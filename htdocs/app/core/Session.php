<?php
/**
 * VedaVerse — app/core/Session.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Starts the PHP session with safe settings, holds the CSRF token and
 *   flash messages, tracks who is signed in, and issues the durable
 *   anonymous token that lets a guest keep their bookmarks and notes.
 *
 * WHAT DEPENDS ON IT
 *   SessionMiddleware boots it. CsrfMiddleware reads the token.
 *   AuthService writes to it on login and logout. The helpers
 *   current_user() and user_can() read from it.
 *
 * NOT IN THE ORIGINAL CORE LIST
 *   Like Config, this is an addition to the eight classes the build
 *   prompt names. It sits in core rather than in services because CSRF
 *   verification happens in middleware, before any service exists, and
 *   because nothing here is business logic.
 *
 * THE TWO IDENTITIES
 *   Every visitor has a PHP session, which is short-lived and dies when
 *   the browser closes. A guest ALSO gets an anon_token in a year-long
 *   cookie. That token is what their bookmarks, notes, progress and quiz
 *   attempts are tagged with, and it is what makes "come back next month
 *   and your work is still there" true for someone who never registered.
 *   Registration merges those rows into the new account.
 *
 *   Keeping them separate matters. If guest work were tied to the PHP
 *   session, closing the browser would lose it, and the most common
 *   complaint about anonymous-first products would be ours too.
 *
 * COOKIES ARE QUEUED, NOT SENT
 *   Response collects headers and sends them once at the end. So this
 *   class queues its cookie and SessionMiddleware attaches it to the
 *   outgoing Response. Calling setcookie() directly from here would work
 *   until the day something echoes first, and then it would fail with an
 *   error naming the wrong line.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Core;

class Session
{
    /** @var bool */
    private static $started = false;

    /** @var array<string,mixed>|null The signed-in user row, loaded once per request. */
    private static $user = null;

    /** @var bool True once the user has been looked up, so a guest is not re-queried. */
    private static $userLoaded = false;

    /** @var array<int,array> Cookies waiting to be attached to the Response. */
    private static $pendingCookies = array();

    /** @var array<string,mixed> Flash data read at the start of this request. */
    private static $flashIn = array();

    // Session keys, named as constants so a typo is a fatal rather than a
    // silently missing value.
    const KEY_USER_ID   = '_uid';
    const KEY_CSRF      = '_csrf_token';
    const KEY_CSRF_AT   = '_csrf_issued';
    const KEY_LAST_SEEN = '_last_seen';
    const KEY_STARTED   = '_started_at';
    const KEY_FLASH     = '_flash';
    const KEY_ANON      = '_anon';
    const KEY_LANG      = '_lang';

    // -----------------------------------------------------------------
    // Lifecycle
    // -----------------------------------------------------------------

    /**
     * Start the session. Safe to call twice.
     *
     * @return void
     */
    public static function start()
    {
        if (self::$started || PHP_SAPI === 'cli') {
            self::$started = true;
            return;
        }

        if (session_status() === PHP_SESSION_ACTIVE) {
            self::$started = true;
            self::afterStart();
            return;
        }

        $cfg = (array) Config::get('security.session', array());

        // Keep session files inside storage/, which .htaccess blocks from
        // the web. The system temp directory is shared with every other
        // account on the host, and a readable session file is a readable
        // login.
        $savePath = isset($cfg['save_path']) ? $cfg['save_path'] : null;
        if ($savePath && is_dir($savePath) && is_writable($savePath)) {
            session_save_path($savePath);
        }

        // Refuse a session id the server never issued. Without this, an
        // attacker can set a known id in the victim's browser and then
        // reuse it after the victim signs in — session fixation.
        ini_set('session.use_strict_mode', !empty($cfg['use_strict_mode']) ? '1' : '0');
        ini_set('session.use_only_cookies', '1');
        ini_set('session.cookie_httponly', '1');

        session_name(isset($cfg['name']) ? $cfg['name'] : 'vv_session');

        $secure = isset($cfg['secure']) && $cfg['secure'] !== null
            ? (bool) $cfg['secure']
            : self::isHttps();

        session_set_cookie_params(array(
            'lifetime' => isset($cfg['lifetime']) ? (int) $cfg['lifetime'] : 0,
            'path'     => isset($cfg['path']) ? $cfg['path'] : '/',
            'domain'   => isset($cfg['domain']) ? $cfg['domain'] : '',
            'secure'   => $secure,
            'httponly' => true,
            'samesite' => isset($cfg['samesite']) ? $cfg['samesite'] : 'Lax',
        ));

        session_start();
        self::$started = true;

        self::afterStart();
    }

    /**
     * Timeout enforcement and flash rotation, run once after the session
     * is live.
     *
     * @return void
     */
    private static function afterStart()
    {
        $cfg  = (array) Config::get('security.session', array());
        $now  = time();

        $idle     = isset($cfg['idle_timeout']) ? (int) $cfg['idle_timeout'] : 7200;
        $absolute = isset($cfg['absolute_timeout']) ? (int) $cfg['absolute_timeout'] : 86400;

        $lastSeen = isset($_SESSION[self::KEY_LAST_SEEN]) ? (int) $_SESSION[self::KEY_LAST_SEEN] : $now;
        $startedAt = isset($_SESSION[self::KEY_STARTED]) ? (int) $_SESSION[self::KEY_STARTED] : $now;

        $expired = ($idle > 0 && ($now - $lastSeen) > $idle)
                || ($absolute > 0 && ($now - $startedAt) > $absolute);

        if ($expired && isset($_SESSION[self::KEY_USER_ID])) {
            // Only the login is dropped. The anon token stays, so an
            // expired session still shows the reader their own bookmarks
            // rather than looking like a brand new visitor.
            Logger::info('Session expired', array('reason' => ($now - $lastSeen) > $idle ? 'idle' : 'absolute'));
            unset($_SESSION[self::KEY_USER_ID]);
            self::regenerate();
            $startedAt = $now;
        }

        $_SESSION[self::KEY_LAST_SEEN] = $now;
        if (!isset($_SESSION[self::KEY_STARTED])) {
            $_SESSION[self::KEY_STARTED] = $startedAt;
        }

        // Flash messages survive exactly one request: read what the last
        // request left, then clear it so it is not shown twice.
        self::$flashIn = isset($_SESSION[self::KEY_FLASH]) && is_array($_SESSION[self::KEY_FLASH])
            ? $_SESSION[self::KEY_FLASH]
            : array();
        $_SESSION[self::KEY_FLASH] = array();
    }

    /**
     * Issue a fresh session id, keeping the data.
     *
     * Called on login and on any privilege change. This is what defeats
     * session fixation: whatever id the attacker planted stops being the
     * id that is signed in.
     *
     * @return void
     */
    public static function regenerate()
    {
        if (PHP_SAPI === 'cli' || session_status() !== PHP_SESSION_ACTIVE) {
            return;
        }
        session_regenerate_id(true);
    }

    /**
     * Destroy everything: data, cookie, and the user cache.
     *
     * @return void
     */
    public static function destroy()
    {
        if (PHP_SAPI === 'cli') {
            self::$user = null;
            self::$userLoaded = true;
            return;
        }

        $_SESSION = array();

        if (ini_get('session.use_cookies')) {
            $params = session_get_cookie_params();
            setcookie(session_name(), '', array(
                'expires'  => time() - 42000,
                'path'     => $params['path'],
                'domain'   => $params['domain'],
                'secure'   => $params['secure'],
                'httponly' => $params['httponly'],
                'samesite' => isset($params['samesite']) ? $params['samesite'] : 'Lax',
            ));
        }

        if (session_status() === PHP_SESSION_ACTIVE) {
            session_destroy();
        }

        self::$started    = false;
        self::$user       = null;
        self::$userLoaded = true;
    }

    // -----------------------------------------------------------------
    // Reading and writing
    // -----------------------------------------------------------------

    /**
     * @param string $key
     * @param mixed  $default
     * @return mixed
     */
    public static function get($key, $default = null)
    {
        return isset($_SESSION[$key]) ? $_SESSION[$key] : $default;
    }

    /**
     * @param string $key
     * @param mixed  $value
     * @return void
     */
    public static function put($key, $value)
    {
        $_SESSION[$key] = $value;
    }

    /**
     * @param string $key
     * @return void
     */
    public static function forget($key)
    {
        unset($_SESSION[$key]);
    }

    /**
     * @param string $key
     * @return bool
     */
    public static function has($key)
    {
        return isset($_SESSION[$key]);
    }

    // -----------------------------------------------------------------
    // Flash messages
    // -----------------------------------------------------------------

    /**
     * Leave a message for the next request.
     *
     * This is what makes the post-redirect-get pattern usable: a form
     * posts, the controller redirects, and the success message survives
     * the redirect. Without it, a controller would have to render the
     * page itself, which leaves a POST in the browser's history and a
     * "resubmit this form?" dialog on every refresh.
     *
     * @param string $key   'success', 'error', 'info', or a form's old input
     * @param mixed  $value
     * @return void
     */
    public static function flash($key, $value)
    {
        if (!isset($_SESSION[self::KEY_FLASH]) || !is_array($_SESSION[self::KEY_FLASH])) {
            $_SESSION[self::KEY_FLASH] = array();
        }
        $_SESSION[self::KEY_FLASH][$key] = $value;
    }

    /**
     * Read what the previous request flashed.
     *
     * @param string $key
     * @param mixed  $default
     * @return mixed
     */
    public static function flashed($key, $default = null)
    {
        return array_key_exists($key, self::$flashIn) ? self::$flashIn[$key] : $default;
    }

    /**
     * @return array<string,mixed>
     */
    public static function allFlashed()
    {
        return self::$flashIn;
    }

    /**
     * Re-flash the submitted values so a failed form comes back filled in
     * rather than blank.
     *
     * Password fields are stripped. Sending a password back down to be
     * re-rendered into the HTML would put it in the page source, in the
     * browser's back-forward cache and possibly in a proxy log, which is
     * a poor trade for saving one retype.
     *
     * @param array<string,mixed> $input
     * @return void
     */
    public static function flashInput(array $input)
    {
        foreach (array_keys($input) as $key) {
            if (stripos($key, 'password') !== false || stripos($key, 'code') !== false) {
                unset($input[$key]);
            }
        }
        self::flash('_old', $input);
    }

    /**
     * A previously submitted value, for repopulating a form.
     *
     * @param string $key
     * @param string $default
     * @return string
     */
    public static function old($key, $default = '')
    {
        $old = self::flashed('_old', array());
        if (is_array($old) && array_key_exists($key, $old) && is_scalar($old[$key])) {
            return (string) $old[$key];
        }
        return $default;
    }

    // -----------------------------------------------------------------
    // CSRF
    // -----------------------------------------------------------------

    /**
     * The token for this session, minted on first use and rotated when it
     * ages past the configured lifetime.
     *
     * @return string
     */
    public static function csrfToken()
    {
        $lifetime = (int) Config::get('security.csrf.lifetime', 7200);
        $issued   = (int) self::get(self::KEY_CSRF_AT, 0);
        $token    = self::get(self::KEY_CSRF);

        if (!is_string($token) || $token === '' || ($lifetime > 0 && (time() - $issued) > $lifetime)) {
            $bytes = (int) Config::get('security.csrf.token_bytes', 32);
            $token = bin2hex(random_bytes($bytes));
            self::put(self::KEY_CSRF, $token);
            self::put(self::KEY_CSRF_AT, time());
        }

        return $token;
    }

    /**
     * Does the submitted token match?
     *
     * hash_equals rather than ===, so the comparison time does not reveal
     * how many leading characters were right.
     *
     * @param string|null $given
     * @return bool
     */
    public static function verifyCsrf($given)
    {
        $known = self::get(self::KEY_CSRF);

        if (!is_string($known) || $known === '' || !is_string($given) || $given === '') {
            return false;
        }

        return hash_equals($known, $given);
    }

    // -----------------------------------------------------------------
    // Identity
    // -----------------------------------------------------------------

    /**
     * @return int|null
     */
    public static function userId()
    {
        $id = self::get(self::KEY_USER_ID);
        return $id === null ? null : (int) $id;
    }

    /**
     * The signed-in user row, or null.
     *
     * Loaded once per request and cached, so calling current_user() in
     * six templates costs one query rather than six.
     *
     * @return array<string,mixed>|null
     */
    public static function user()
    {
        if (self::$userLoaded) {
            return self::$user;
        }
        self::$userLoaded = true;

        $id = self::userId();
        if ($id === null) {
            self::$user = null;
            return null;
        }

        $repo = new \VedaVerse\Repositories\UserRepository();
        $user = $repo->findActiveById($id);

        // The account was deleted or suspended while the session was
        // still open. Drop the login rather than carrying a stale row
        // around, or a suspended user keeps their access until they
        // happen to sign out.
        if ($user === null) {
            self::forget(self::KEY_USER_ID);
        }

        self::$user = $user;
        return self::$user;
    }

    /**
     * Mark this session as signed in.
     *
     * @param array<string,mixed> $user
     * @return void
     */
    public static function login(array $user)
    {
        self::regenerate();
        self::put(self::KEY_USER_ID, (int) $user['id']);
        self::put(self::KEY_STARTED, time());
        self::$user       = $user;
        self::$userLoaded = true;

        // A new session id deserves a new CSRF token.
        self::forget(self::KEY_CSRF);
        self::forget(self::KEY_CSRF_AT);
    }

    /**
     * Sign out but keep the visitor's guest identity, so their bookmarks
     * are still theirs on the way out.
     *
     * @return void
     */
    public static function logout()
    {
        self::forget(self::KEY_USER_ID);
        self::regenerate();
        self::$user       = null;
        self::$userLoaded = true;
        self::forget(self::KEY_CSRF);
        self::forget(self::KEY_CSRF_AT);
    }

    /**
     * Clear the cached user so the next call re-reads it. Called after a
     * profile or role change within the same request.
     *
     * @return void
     */
    public static function refreshUser()
    {
        self::$user       = null;
        self::$userLoaded = false;
    }

    // -----------------------------------------------------------------
    // The anonymous token
    // -----------------------------------------------------------------

    /**
     * The durable guest identity, created on first sight.
     *
     * Read from the cookie when present, otherwise minted and queued for
     * sending. Also mirrored into the session so it is stable within a
     * request even before the cookie comes back.
     *
     * @return string
     */
    public static function anonToken()
    {
        $cfg  = (array) Config::get('security.anon_cookie', array());
        $name = isset($cfg['name']) ? $cfg['name'] : 'vv_anon';

        // Already resolved this request.
        $existing = self::get(self::KEY_ANON);
        if (is_string($existing) && $existing !== '') {
            return $existing;
        }

        // From the browser. Validated rather than trusted: the value ends
        // up in a WHERE clause as a bound parameter, so it cannot inject,
        // but an oversized or odd token would still pollute the table.
        if (isset($_COOKIE[$name]) && preg_match('/^[a-f0-9]{32,64}$/', (string) $_COOKIE[$name]) === 1) {
            $token = (string) $_COOKIE[$name];
            self::put(self::KEY_ANON, $token);
            return $token;
        }

        $token = bin2hex(random_bytes(16));
        self::put(self::KEY_ANON, $token);

        self::$pendingCookies[] = array(
            'name'     => $name,
            'value'    => $token,
            'lifetime' => isset($cfg['lifetime']) ? (int) $cfg['lifetime'] : 31536000,
            'options'  => array(
                'httponly' => true,
                'samesite' => isset($cfg['samesite']) ? $cfg['samesite'] : 'Lax',
                'secure'   => self::isHttps(),
                'path'     => '/',
            ),
        );

        return $token;
    }

    /**
     * Forget the guest identity. Called after its rows have been merged
     * into a real account, so the same token cannot be adopted twice.
     *
     * @return void
     */
    public static function clearAnonToken()
    {
        $cfg  = (array) Config::get('security.anon_cookie', array());
        $name = isset($cfg['name']) ? $cfg['name'] : 'vv_anon';

        self::forget(self::KEY_ANON);

        self::$pendingCookies[] = array(
            'name'     => $name,
            'value'    => '',
            'lifetime' => -3600, // in the past, which is how a cookie is deleted
            'options'  => array(
                'httponly' => true,
                'samesite' => isset($cfg['samesite']) ? $cfg['samesite'] : 'Lax',
                'secure'   => self::isHttps(),
                'path'     => '/',
            ),
        );
    }

    /**
     * The identity to tag a row with: the user id when signed in, the
     * anonymous token when not.
     *
     * @return array{user_id:int|null,session_id:string|null}
     */
    public static function owner()
    {
        $userId = self::userId();

        if ($userId !== null) {
            return array('user_id' => $userId, 'session_id' => null);
        }

        return array('user_id' => null, 'session_id' => self::anonToken());
    }

    // -----------------------------------------------------------------
    // Language
    // -----------------------------------------------------------------

    /**
     * @param string $lang
     * @return void
     */
    public static function setLang($lang)
    {
        self::put(self::KEY_LANG, $lang);
    }

    /**
     * @return string|null
     */
    public static function lang()
    {
        $lang = self::get(self::KEY_LANG);
        return is_string($lang) ? $lang : null;
    }

    // -----------------------------------------------------------------
    // Cookie handover
    // -----------------------------------------------------------------

    /**
     * Hand queued cookies to the outgoing Response and clear the queue.
     *
     * @param Response $response
     * @return Response
     */
    public static function attachCookies(Response $response)
    {
        foreach (self::$pendingCookies as $cookie) {
            $response->cookie($cookie['name'], $cookie['value'], $cookie['lifetime'], $cookie['options']);
        }
        self::$pendingCookies = array();

        return $response;
    }

    // -----------------------------------------------------------------
    // Helpers
    // -----------------------------------------------------------------

    /**
     * @return bool
     */
    private static function isHttps()
    {
        if (!empty($_SERVER['HTTPS']) && strtolower((string) $_SERVER['HTTPS']) !== 'off') {
            return true;
        }
        if (isset($_SERVER['SERVER_PORT']) && (int) $_SERVER['SERVER_PORT'] === 443) {
            return true;
        }
        return isset($_SERVER['HTTP_X_FORWARDED_PROTO'])
            && strtolower((string) $_SERVER['HTTP_X_FORWARDED_PROTO']) === 'https';
    }

    /**
     * Reset all in-memory state. For tests, which run several requests in
     * one PHP process.
     *
     * @return void
     */
    public static function reset()
    {
        self::$started        = false;
        self::$user           = null;
        self::$userLoaded     = false;
        self::$pendingCookies = array();
        self::$flashIn        = array();
    }
}
