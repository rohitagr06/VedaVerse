<?php
/**
 * VedaVerse — app/repositories/ThrottleRepository.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Counts failed attempts per identifier per scope, so login, recovery,
 *   admin sign-in, forum posting and search can all be rate limited.
 *
 * WHAT DEPENDS ON IT
 *   RateLimitMiddleware and AuthService.
 *
 * WHY IT COUNTS HASHES AND NOT VALUES
 *   The identifier is an email address or an IP, and neither is stored.
 *   Both arrive already hashed with the application pepper. That means a
 *   stolen copy of this table tells an attacker nothing — not which
 *   accounts exist, not who has been trying to sign in. The counting
 *   works exactly as well on a hash as on the original.
 *
 * WHY IT IS A TABLE AND NOT THE CACHE
 *   The cache is allowed to lose things: a full disk, a purge, a
 *   deployment. Losing a rate-limit counter resets an attacker's budget,
 *   which is the one kind of data loss that actively helps them. The
 *   table is the record; the cache is not involved.
 *
 * NO CRON
 *   Old rows are pruned opportunistically. See prune().
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Repositories;

use Exception;
use Throwable;
use VedaVerse\Core\Config;

class ThrottleRepository extends Repository
{
    /** @var string */
    protected $table = 'login_attempts';

    /**
     * Record one attempt.
     *
     * Successes are recorded as well as failures. It costs one row and it
     * means the audit trail can answer "did they eventually get in?",
     * which is the first question anyone asks about a burst of failures.
     *
     * @param string $identifierHash Already hashed by the caller.
     * @param string $scope          'login', 'recover', 'admin_login', …
     * @param bool   $succeeded
     * @return void
     */
    public function record($identifierHash, $scope, $succeeded = false)
    {
        try {
            $this->insertRow(array(
                'identifier_hash' => (string) $identifierHash,
                'scope'           => (string) $scope,
                'attempted_at'    => date('Y-m-d H:i:s'),
                'succeeded'       => $succeeded ? 1 : 0,
            ));
        } catch (Exception $e) {
            // Never let bookkeeping break the request being throttled.
        } catch (Throwable $e) {
        }
    }

    /**
     * How many FAILED attempts inside the window.
     *
     * Only failures count. A person who signs in successfully, signs out
     * and signs in again five times has done nothing wrong, and locking
     * them out for it would be a bug that looks exactly like a security
     * feature.
     *
     * @param string $identifierHash
     * @param string $scope
     * @param int    $windowSeconds
     * @return int
     */
    public function failureCount($identifierHash, $scope, $windowSeconds = 900)
    {
        try {
            return (int) $this->scalar(
                'SELECT COUNT(*) FROM login_attempts
                  WHERE identifier_hash = :id
                    AND scope = :scope
                    AND succeeded = 0
                    AND attempted_at > DATE_SUB(NOW(), INTERVAL :secs SECOND)',
                array('id' => (string) $identifierHash, 'scope' => (string) $scope, 'secs' => (int) $windowSeconds)
            );
        } catch (Exception $e) {
            // If the count cannot be read, fail CLOSED rather than open:
            // report the limit as reached. A database problem should not
            // hand an attacker an unlimited number of guesses.
            return PHP_INT_MAX;
        } catch (Throwable $e) {
            return PHP_INT_MAX;
        }
    }

    /**
     * How many attempts of ANY outcome inside the window.
     *
     * The per-email counter below counts failures only, because a person
     * signing in successfully several times has done nothing wrong. The
     * per-IP counter is different: it exists to catch somebody spraying
     * one password across many accounts, where every individual attempt
     * looks innocent and only the volume gives it away. So this one counts
     * everything, and its ceiling is correspondingly higher.
     *
     * @param string $identifierHash
     * @param string $scope
     * @param int    $windowSeconds
     * @return int
     */
    public function attemptCount($identifierHash, $scope, $windowSeconds = 900)
    {
        try {
            return (int) $this->scalar(
                'SELECT COUNT(*) FROM login_attempts
                  WHERE identifier_hash = :id
                    AND scope = :scope
                    AND attempted_at > DATE_SUB(NOW(), INTERVAL :secs SECOND)',
                array('id' => (string) $identifierHash, 'scope' => (string) $scope, 'secs' => (int) $windowSeconds)
            );
        } catch (Exception $e) {
            // Fail closed, for the same reason as failureCount below.
            return PHP_INT_MAX;
        } catch (Throwable $e) {
            return PHP_INT_MAX;
        }
    }

    /**
     * Has this address made too many attempts in this scope?
     *
     * Separate ceiling from isLocked(), because a shared address — an
     * office, a college, a phone network behind carrier-grade NAT — has
     * many legitimate people behind it, and five attempts between all of
     * them in fifteen minutes would lock out a whole building.
     *
     * @param string $identifierHash
     * @param string $scope
     * @return bool
     */
    public function isAddressLimited($identifierHash, $scope)
    {
        $max    = (int) Config::get('security.throttle.ip_max_attempts', 30);
        $window = (int) Config::get('security.throttle.window_seconds', 900);

        return $this->attemptCount($identifierHash, $scope, $window) >= $max;
    }

    /**
     * Is this identifier currently locked out of this scope?
     *
     * @param string $identifierHash
     * @param string $scope
     * @return bool
     */
    public function isLocked($identifierHash, $scope)
    {
        $max    = (int) Config::get('security.throttle.max_attempts', 5);
        $window = (int) Config::get('security.throttle.window_seconds', 900);

        return $this->failureCount($identifierHash, $scope, $window) >= $max;
    }

    /**
     * Seconds until the oldest counted failure ages out of the window,
     * so the interface can say "try again in 12 minutes" rather than an
     * unhelpful "too many attempts".
     *
     * @param string $identifierHash
     * @param string $scope
     * @return int
     */
    public function secondsUntilUnlocked($identifierHash, $scope)
    {
        $window = (int) Config::get('security.throttle.window_seconds', 900);

        try {
            $oldest = $this->scalar(
                'SELECT MIN(attempted_at) FROM login_attempts
                  WHERE identifier_hash = :id
                    AND scope = :scope
                    AND succeeded = 0
                    AND attempted_at > DATE_SUB(NOW(), INTERVAL :secs SECOND)',
                array('id' => (string) $identifierHash, 'scope' => (string) $scope, 'secs' => $window)
            );
        } catch (Exception $e) {
            return $window;
        } catch (Throwable $e) {
            return $window;
        }

        if ($oldest === null) {
            return 0;
        }

        $remaining = ($window - (time() - strtotime((string) $oldest)));
        return (int) max(0, $remaining);
    }

    /**
     * How long to stall before answering this attempt.
     *
     * A progressive delay is worth more than it looks. It costs an
     * attacker their throughput on every single guess, while a human who
     * mistyped once notices nothing — the first two attempts have no
     * delay at all. It also keeps a lockout from being the only defence,
     * so a distributed attempt spread across many identifiers is still
     * slowed down.
     *
     * @param string $identifierHash
     * @param string $scope
     * @return int Milliseconds
     */
    public function delayFor($identifierHash, $scope)
    {
        $delays = (array) Config::get('security.throttle.progressive_delay_ms', array(0, 0, 250, 750, 1500));
        if ($delays === array()) {
            return 0;
        }

        $window = (int) Config::get('security.throttle.window_seconds', 900);
        $count  = $this->failureCount($identifierHash, $scope, $window);

        if ($count === PHP_INT_MAX) {
            return (int) end($delays);
        }

        $index = min($count, count($delays) - 1);
        return (int) $delays[$index];
    }

    /**
     * Clear the counter for an identifier after a genuine success.
     *
     * Without this, somebody who mistyped four times and then signed in
     * correctly would still be one attempt from a lockout for the next
     * fifteen minutes.
     *
     * @param string $identifierHash
     * @param string $scope
     * @return int
     */
    public function clear($identifierHash, $scope)
    {
        try {
            return $this->deleteRows(
                'identifier_hash = :id AND scope = :scope AND succeeded = 0',
                array('id' => (string) $identifierHash, 'scope' => (string) $scope)
            );
        } catch (Exception $e) {
            return 0;
        } catch (Throwable $e) {
            return 0;
        }
    }

    /**
     * Delete attempts older than a day, occasionally.
     *
     * @param int $probability 1 in N requests do the work.
     * @return int
     */
    public function prune($probability = 100)
    {
        if ($probability < 1 || mt_rand(1, (int) $probability) !== 1) {
            return 0;
        }

        try {
            return $this->execute(
                'DELETE FROM login_attempts WHERE attempted_at < DATE_SUB(NOW(), INTERVAL 1 DAY) LIMIT 500'
            );
        } catch (Exception $e) {
            return 0;
        } catch (Throwable $e) {
            return 0;
        }
    }
}
