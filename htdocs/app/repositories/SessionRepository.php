<?php
/**
 * VedaVerse — app/repositories/SessionRepository.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Keeps the `sessions` table in step with live browser sessions, and
 *   prunes expired rows.
 *
 * WHAT THIS TABLE IS FOR, AND WHAT IT IS NOT FOR
 *   PHP owns the actual session data — it lives in a file under
 *   storage/sessions and this table never holds it. What the table gives
 *   us is a queryable record: how many people are on the site, which
 *   accounts have live sessions so an admin can sign one out, and a
 *   hashed fingerprint to notice a session that has jumped to a
 *   completely different browser.
 *
 *   Losing a row here logs nobody out. That is deliberate — a write
 *   failure on a housekeeping table must never cost a learner their
 *   session.
 *
 * NO CRON
 *   Expired rows are pruned opportunistically from a normal request, on
 *   roughly one request in a hundred. See prune().
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Repositories;

use Exception;
use Throwable;
use VedaVerse\Core\Logger;

class SessionRepository extends Repository
{
    /** @var string */
    protected $table = 'sessions';

    /**
     * Record or refresh the row for this browser session.
     *
     * The primary key is a HASH of the PHP session id, never the id
     * itself. If the raw id were stored, a leaked copy of this table
     * would be a leaked set of live logins — somebody could paste an id
     * straight into a cookie and be signed in as that user. A hash cannot
     * be used that way.
     *
     * @param string      $phpSessionId
     * @param int|null    $userId
     * @param string|null $anonToken
     * @param string|null $ipHash
     * @param string|null $userAgentHash
     * @param int         $lifetimeSeconds
     * @return void
     */
    public function touch($phpSessionId, $userId, $anonToken, $ipHash, $userAgentHash, $lifetimeSeconds = 86400)
    {
        $id = hash('sha256', (string) $phpSessionId);

        try {
            $this->execute(
                'INSERT INTO sessions (id, user_id, anon_token, ip_hash, user_agent_hash, created_at, last_seen_at, expires_at)
                 VALUES (:id, :user_id, :anon, :ip, :ua, NOW(), NOW(), DATE_ADD(NOW(), INTERVAL :ttl SECOND))
                 ON DUPLICATE KEY UPDATE
                     user_id      = VALUES(user_id),
                     anon_token   = VALUES(anon_token),
                     last_seen_at = NOW(),
                     expires_at   = VALUES(expires_at)',
                array(
                    'id'      => $id,
                    'user_id' => $userId === null ? null : (int) $userId,
                    'anon'    => $anonToken,
                    'ip'      => $ipHash,
                    'ua'      => $userAgentHash,
                    'ttl'     => (int) $lifetimeSeconds,
                )
            );
        } catch (Exception $e) {
            // Housekeeping. A failure here must not break the request.
            Logger::warning('Could not record the session row', array('reason' => $e->getMessage()));
        } catch (Throwable $e) {
            Logger::warning('Could not record the session row', array('reason' => $e->getMessage()));
        }
    }

    /**
     * Remove the row for one browser session, on sign-out.
     *
     * @param string $phpSessionId
     * @return int
     */
    public function forget($phpSessionId)
    {
        try {
            return $this->deleteRows('id = :id', array('id' => hash('sha256', (string) $phpSessionId)));
        } catch (Exception $e) {
            return 0;
        } catch (Throwable $e) {
            return 0;
        }
    }

    /**
     * Drop every session belonging to one account.
     *
     * Used when an admin suspends a user and when somebody resets their
     * own password — a password reset that leaves the attacker's session
     * alive has not actually locked them out, which is a mistake that is
     * very easy to make and very hard to notice.
     *
     * @param int $userId
     * @return int
     */
    public function forgetAllForUser($userId)
    {
        try {
            return $this->deleteRows('user_id = :uid', array('uid' => (int) $userId));
        } catch (Exception $e) {
            return 0;
        } catch (Throwable $e) {
            return 0;
        }
    }

    /**
     * How many distinct sessions have been seen recently. Feeds the
     * admin dashboard's "active learners" number.
     *
     * @param int $minutes
     * @return int
     */
    public function activeCount($minutes = 30)
    {
        return (int) $this->scalar(
            'SELECT COUNT(*) FROM sessions WHERE last_seen_at > DATE_SUB(NOW(), INTERVAL :m MINUTE)',
            array('m' => (int) $minutes)
        );
    }

    /**
     * Delete expired rows, occasionally.
     *
     * There is no cron on this host, so cleanup rides along on ordinary
     * requests. Running it every time would add a DELETE to every page
     * load; one request in a hundred keeps the table tidy at a cost
     * nobody perceives. The LIMIT caps the unlucky request's extra work.
     *
     * @param int $probability 1 in N requests do the work. 0 disables.
     * @return int
     */
    public function prune($probability = 100)
    {
        if ($probability < 1 || mt_rand(1, (int) $probability) !== 1) {
            return 0;
        }

        try {
            return $this->execute('DELETE FROM sessions WHERE expires_at < NOW() LIMIT 500');
        } catch (Exception $e) {
            return 0;
        } catch (Throwable $e) {
            return 0;
        }
    }
}
