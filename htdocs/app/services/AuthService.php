<?php
/**
 * VedaVerse — app/services/AuthService.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Registration, sign-in, sign-out, and account recovery. All of the
 *   business rules; none of the SQL and none of the HTML.
 *
 * WHAT DEPENDS ON IT
 *   AuthController. Nothing else should touch it directly.
 *
 * THE SHAPE OF EVERY PUBLIC METHOD
 *   It takes plain values — never $_POST, never a Request — and returns
 *   an array with an 'ok' key plus either data or an 'error' code. The
 *   controller turns that into a page or a redirect. Keeping it this way
 *   means the whole of authentication can be exercised from a script with
 *   no browser, which is how the tests for it run.
 *
 * THE THREE THINGS THAT MAKE THIS FILE WORTH READING CAREFULLY
 *
 *   1. NO EMAIL EXISTS. The host blocks outgoing mail, so there is no
 *      "reset link". Recovery is a twelve-character code shown once at
 *      signup. If a learner loses both their password and that code, the
 *      account is gone. That is a hard consequence, so the code is
 *      generated properly, stored only as a hash, and reissued on every
 *      successful use.
 *
 *   2. THE ANONYMOUS MERGE. A guest accumulates bookmarks, notes,
 *      progress and quiz attempts against a durable token. Registering —
 *      or signing in — has to carry that work across. It is the most
 *      commonly broken feature in applications that support anonymous
 *      use, and it runs on both paths here, not just registration.
 *
 *   3. NOT LEAKING WHICH EMAILS EXIST. Every failure on the login and
 *      recovery paths returns the same message and takes roughly the same
 *      time, so the form cannot be used to enumerate accounts.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Services;

use Exception;
use Throwable;
use VedaVerse\Core\Config;
use VedaVerse\Core\Logger;
use VedaVerse\Core\Session;
use VedaVerse\Repositories\SessionRepository;
use VedaVerse\Repositories\ThrottleRepository;
use VedaVerse\Repositories\UserRepository;

class AuthService
{
    /** @var UserRepository */
    private $users;

    /** @var ThrottleRepository */
    private $throttle;

    /** @var SessionRepository */
    private $sessions;

    public function __construct()
    {
        $this->users    = new UserRepository();
        $this->throttle = new ThrottleRepository();
        $this->sessions = new SessionRepository();
    }

    // -----------------------------------------------------------------
    // Registration
    // -----------------------------------------------------------------

    /**
     * Create an account, adopt the visitor's guest work, and sign them in.
     *
     * @param array{name:string,email:string,password:string,lang:string,track:string} $input
     *        Already validated by the controller.
     * @return array{ok:bool,error?:string,user?:array,recovery_code?:string,merged?:array}
     */
    public function register(array $input)
    {
        $email = $this->users->normaliseEmail($input['email']);

        if ($this->users->emailExists($email)) {
            // This one DOES disclose that an address is taken, and it has
            // to: a registration form that accepts a duplicate silently
            // and then fails to sign the person in is worse than useless.
            // The disclosure is unavoidable on any signup form, which is
            // exactly why it is not repeated on the login form.
            return array('ok' => false, 'error' => 'email_taken');
        }

        $code = $this->generateRecoveryCode();
        $cost = (int) Config::get('security.password.cost', 10);

        try {
            $userId = $this->users->create(array(
                'uuid'               => uuid4(),
                'name'               => str_clean($input['name']),
                'email'              => $email,
                'password_hash'      => password_hash($input['password'], PASSWORD_BCRYPT, array('cost' => $cost)),
                'recovery_code_hash' => password_hash($code, PASSWORD_BCRYPT, array('cost' => $cost)),
                'preferred_lang'     => $input['lang'],
                'track'              => isset($input['track']) ? $input['track'] : 'beginner',
                'role'               => 'user',
            ));
        } catch (Exception $e) {
            Logger::error('Registration failed', array('reason' => $e->getMessage()));
            return array('ok' => false, 'error' => 'create_failed');
        } catch (Throwable $e) {
            Logger::error('Registration failed', array('reason' => $e->getMessage()));
            return array('ok' => false, 'error' => 'create_failed');
        }

        $merged = $this->adoptGuestWork($userId);

        $user = $this->users->findActiveById($userId);
        if ($user === null) {
            return array('ok' => false, 'error' => 'create_failed');
        }

        Session::login($user);
        $this->users->touchLogin($userId);

        Logger::audit('register', 'user', $userId, array('merged' => $merged), $userId);

        return array(
            'ok'            => true,
            'user'          => $user,
            'recovery_code' => $code,
            'merged'        => $merged,
        );
    }

    // -----------------------------------------------------------------
    // Sign in
    // -----------------------------------------------------------------

    /**
     * Verify a password and start a session.
     *
     * Throttled twice over: RateLimitMiddleware counts by hashed IP, and
     * this counts by hashed email. One catches many accounts tried from
     * one place; the other catches one account tried from many places.
     * Either on its own leaves an obvious gap.
     *
     * @param string $email
     * @param string $password
     * @return array{ok:bool,error?:string,user?:array,minutes?:int,merged?:array}
     */
    public function attempt($email, $password)
    {
        $email = $this->users->normaliseEmail($email);
        $key   = hash_value($email, 'login');

        if ($this->throttle->isLocked($key, 'login')) {
            $seconds = $this->throttle->secondsUntilUnlocked($key, 'login');
            Logger::audit('login_failed', 'user', null, array('reason' => 'locked'), null);
            return array(
                'ok'      => false,
                'error'   => 'locked',
                'minutes' => (int) max(1, ceil($seconds / 60)),
            );
        }

        $row = $this->users->findForLogin($email);

        // No such account. A dummy verify runs anyway so that a missing
        // address and a wrong password take about the same time — without
        // it, the response time alone tells an attacker which addresses
        // are registered.
        if ($row === null) {
            password_verify($password, '$2y$10$usesomesillystringfeedsomesillystringxxxxxxxxxxxxxxxxxxxxxx');
            $this->throttle->record($key, 'login', false);
            Logger::audit('login_failed', 'user', null, array('reason' => 'no_account'), null);
            return array('ok' => false, 'error' => 'invalid');
        }

        if (!password_verify($password, $row['password_hash'])) {
            $this->throttle->record($key, 'login', false);
            Logger::audit('login_failed', 'user', (int) $row['id'], array('reason' => 'bad_password'), null);
            return array('ok' => false, 'error' => 'invalid');
        }

        if ($row['status'] !== 'active') {
            $this->throttle->record($key, 'login', false);
            Logger::audit('login_failed', 'user', (int) $row['id'], array('reason' => 'status_' . $row['status']), null);
            // Deliberately the same message as a wrong password. Telling
            // somebody "this account is suspended" confirms it exists.
            return array('ok' => false, 'error' => 'invalid');
        }

        // The password was right. If the cost factor has been raised since
        // this hash was made, quietly upgrade it — this is the only moment
        // the plain password is available to rehash with.
        $this->rehashIfNeeded((int) $row['id'], $password, $row['password_hash']);

        $this->throttle->record($key, 'login', true);
        $this->throttle->clear($key, 'login');

        $user = $this->users->findActiveById((int) $row['id']);
        if ($user === null) {
            return array('ok' => false, 'error' => 'invalid');
        }

        Session::login($user);
        $this->users->touchLogin((int) $user['id']);

        // The merge runs on login too, not only on registration. Signing
        // in on a device where you had been reading as a guest is the case
        // that actually happens, and it is the case with real conflicts.
        $merged = $this->adoptGuestWork((int) $user['id']);

        Logger::audit('login', 'user', (int) $user['id'], array('merged' => $merged), (int) $user['id']);

        return array('ok' => true, 'user' => $user, 'merged' => $merged);
    }

    /**
     * End the session.
     *
     * The guest token is NOT cleared. Somebody who signs out is still the
     * same person at the same browser, and their reading should carry on
     * where it was rather than starting from nothing.
     *
     * @return void
     */
    public function logout()
    {
        $userId = Session::userId();

        if (PHP_SAPI !== 'cli' && session_status() === PHP_SESSION_ACTIVE) {
            $this->sessions->forget(session_id());
        }

        Session::logout();

        if ($userId !== null) {
            Logger::audit('logout', 'user', $userId, array(), $userId);
        }
    }

    // -----------------------------------------------------------------
    // Recovery
    // -----------------------------------------------------------------

    /**
     * Redeem a recovery code and set a new password.
     *
     * One code, one use. On success the old code is invalidated, a fresh
     * one is issued and returned for display exactly once, and every other
     * session belonging to the account is destroyed.
     *
     * That last part matters more than it looks: a password reset that
     * leaves the attacker's session alive has not locked anybody out. It
     * is an easy step to miss because everything appears to work.
     *
     * @param string $email
     * @param string $code
     * @param string $newPassword
     * @return array{ok:bool,error?:string,recovery_code?:string,minutes?:int}
     */
    public function recover($email, $code, $newPassword)
    {
        $email = $this->users->normaliseEmail($email);
        $key   = hash_value($email, 'recover');

        if ($this->throttle->isLocked($key, 'recover')) {
            $seconds = $this->throttle->secondsUntilUnlocked($key, 'recover');
            return array('ok' => false, 'error' => 'locked', 'minutes' => (int) max(1, ceil($seconds / 60)));
        }

        $row = $this->users->findForRecovery($email);

        // Normalise the submitted code: people write it down on paper and
        // type it back in lower case, or with the grouping dashes left
        // out. Neither should fail.
        $code = strtoupper(preg_replace('/[^A-Za-z0-9]/', '', (string) $code));

        if ($row === null || empty($row['recovery_code_hash'])) {
            password_verify($code, '$2y$10$usesomesillystringfeedsomesillystringxxxxxxxxxxxxxxxxxxxxxx');
            $this->throttle->record($key, 'recover', false);
            return array('ok' => false, 'error' => 'invalid');
        }

        // The hash was made from the grouped form ("97DV-N8X2-XMJQ"), so
        // the stripped input has to be regrouped before it is compared.
        $grouped = $this->storedCodeFormat($code);

        if (!password_verify($grouped, $row['recovery_code_hash'])) {
            $this->throttle->record($key, 'recover', false);
            Logger::audit('password_reset', 'user', (int) $row['id'], array('result' => 'bad_code'), null);
            return array('ok' => false, 'error' => 'invalid');
        }

        if ($row['status'] !== 'active') {
            $this->throttle->record($key, 'recover', false);
            return array('ok' => false, 'error' => 'invalid');
        }

        $userId  = (int) $row['id'];
        $cost    = (int) Config::get('security.password.cost', 10);
        $newCode = $this->generateRecoveryCode();

        try {
            $this->users->updatePassword($userId, password_hash($newPassword, PASSWORD_BCRYPT, array('cost' => $cost)));
            $this->users->updateRecoveryCode($userId, password_hash($newCode, PASSWORD_BCRYPT, array('cost' => $cost)));
            // Only a hash of the redeemed code is recorded, so the audit
            // trail can show that a reset happened without storing
            // anything that could be replayed.
            $this->users->recordReset($userId, hash('sha256', $grouped));
        } catch (Exception $e) {
            Logger::error('Recovery failed to write', array('reason' => $e->getMessage()));
            return array('ok' => false, 'error' => 'create_failed');
        } catch (Throwable $e) {
            return array('ok' => false, 'error' => 'create_failed');
        }

        // Every existing session for this account is destroyed.
        $this->sessions->forgetAllForUser($userId);

        $this->throttle->clear($key, 'recover');
        Logger::audit('password_reset', 'user', $userId, array('result' => 'ok'), $userId);

        return array('ok' => true, 'recovery_code' => $newCode);
    }

    /**
     * Change a password for somebody who already knows the old one.
     *
     * @param int    $userId
     * @param string $currentPassword
     * @param string $newPassword
     * @return array{ok:bool,error?:string}
     */
    public function changePassword($userId, $currentPassword, $newPassword)
    {
        $user = $this->users->findById((int) $userId);
        if ($user === null) {
            return array('ok' => false, 'error' => 'invalid');
        }

        $row = $this->users->findForLogin($user['email']);
        if ($row === null || !password_verify($currentPassword, $row['password_hash'])) {
            Logger::audit('password_reset', 'user', (int) $userId, array('result' => 'bad_current'), (int) $userId);
            return array('ok' => false, 'error' => 'invalid');
        }

        $cost = (int) Config::get('security.password.cost', 10);
        $this->users->updatePassword((int) $userId, password_hash($newPassword, PASSWORD_BCRYPT, array('cost' => $cost)));

        Logger::audit('password_reset', 'user', (int) $userId, array('result' => 'self_service'), (int) $userId);

        return array('ok' => true);
    }

    // -----------------------------------------------------------------
    // Internals
    // -----------------------------------------------------------------

    /**
     * Carry a guest's work onto the account, then retire the token.
     *
     * The token is cleared only after the transaction commits, so a
     * failure halfway leaves the guest still owning their own rows rather
     * than orphaning them against a token nobody holds any more.
     *
     * @param int $userId
     * @return array<string,int>
     */
    private function adoptGuestWork($userId)
    {
        $token = Session::get(Session::KEY_ANON);

        if (!is_string($token) || $token === '') {
            return array();
        }

        try {
            $merged = $this->users->adoptAnonymousData((int) $userId, $token);
        } catch (Exception $e) {
            // A failed merge must not fail the registration. The person
            // has an account; the worst case is that they have to
            // re-bookmark a few verses, which is recoverable. Losing the
            // signup is not.
            Logger::error('Anonymous merge failed', array('user_id' => (int) $userId, 'reason' => $e->getMessage()));
            return array();
        } catch (Throwable $e) {
            Logger::error('Anonymous merge failed', array('user_id' => (int) $userId));
            return array();
        }

        Session::clearAnonToken();

        return $merged;
    }

    /**
     * Upgrade a password hash whose cost is now below the configured one.
     *
     * @param int    $userId
     * @param string $password
     * @param string $hash
     * @return void
     */
    private function rehashIfNeeded($userId, $password, $hash)
    {
        $cost = (int) Config::get('security.password.cost', 10);

        if (!password_needs_rehash($hash, PASSWORD_BCRYPT, array('cost' => $cost))) {
            return;
        }

        try {
            $this->users->updatePassword($userId, password_hash($password, PASSWORD_BCRYPT, array('cost' => $cost)));
            Logger::info('Password hash upgraded', array('user_id' => $userId));
        } catch (Exception $e) {
            // Not worth failing a valid login over.
        } catch (Throwable $e) {
        }
    }

    /**
     * A recovery code, grouped in fours for reading aloud.
     *
     * random_int, not rand: this is the entire account-recovery story, and
     * a predictable code is the same as no code at all. The alphabet has
     * no O, 0, I, 1 or l, because this gets written on paper and typed
     * back weeks later by somebody who is already anxious.
     *
     * @return string
     */
    public function generateRecoveryCode()
    {
        $cfg      = (array) Config::get('security.recovery_code', array());
        $length   = isset($cfg['length']) ? (int) $cfg['length'] : 12;
        $alphabet = isset($cfg['alphabet']) ? (string) $cfg['alphabet'] : 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';

        $max  = strlen($alphabet) - 1;
        $code = '';
        for ($i = 0; $i < $length; $i++) {
            $code .= $alphabet[random_int(0, $max)];
        }

        return implode('-', str_split($code, 4));
    }

    /**
     * Put a submitted code back into the exact form that was hashed.
     *
     * The stored hash is of the grouped string ("97DV-N8X2-XMJQ"), so a
     * code typed without dashes has to be regrouped before comparison.
     * Doing it here rather than at the call site means the storage format
     * is decided in one place.
     *
     * @param string $bare Letters and digits only, upper case.
     * @return string
     */
    private function storedCodeFormat($bare)
    {
        return implode('-', str_split($bare, 4));
    }
}
