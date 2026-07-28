<?php
/**
 * VedaVerse — app/helpers/security.php
 * ---------------------------------------------------------------------
 * The short global functions that every template and controller reaches
 * for. Loaded once by index.php, before anything else runs.
 *
 * WHY THESE ARE GLOBAL FUNCTIONS AND NOT STATIC METHODS
 *   Escaping only works if it is done every single time. A template that
 *   has to write \VedaVerse\Core\View::e() around every value is a
 *   template where somebody eventually does not bother. e() is three
 *   characters, so there is no excuse.
 *
 * EVERY FUNCTION IS GUARDED WITH function_exists
 *   app/core/View.php carries fallback copies of e(), t() and et() so the
 *   view layer still works in contexts that do not load the helpers —
 *   install.php being the one that matters. The guards mean whichever
 *   loads first wins and neither causes a fatal redeclare.
 *
 * PHP 7.4 COMPATIBLE.
 */

use VedaVerse\Core\Config;
use VedaVerse\Core\Session;
use VedaVerse\Core\View;

// ---------------------------------------------------------------------
// Output escaping
// ---------------------------------------------------------------------

if (!function_exists('e')) {
    /**
     * Escape a value for HTML. Use this on EVERYTHING that gets printed:
     * database content, configuration, a name the user chose, a URL.
     *
     * ENT_QUOTES escapes single quotes as well as double, which matters
     * because an attribute written with single quotes is just as valid
     * as one written with double.
     *
     * ENT_SUBSTITUTE is the flag people leave out and regret. Without it,
     * one malformed UTF-8 byte makes htmlspecialchars return an empty
     * string — so a single corrupt character would blank an entire verse
     * rather than showing one replacement glyph.
     *
     * @param mixed $value
     * @return string
     */
    function e($value)
    {
        return htmlspecialchars((string) $value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
    }
}

if (!function_exists('eu')) {
    /**
     * Escape a value for use inside a URL.
     *
     * @param mixed $value
     * @return string
     */
    function eu($value)
    {
        return rawurlencode((string) $value);
    }
}

if (!function_exists('ejs')) {
    /**
     * Encode a value for embedding in a <script> block.
     *
     * The HEX flags stop a string containing "</script>" from closing the
     * block early, which is the classic way a JSON blob inside a page
     * becomes script injection.
     *
     * @param mixed $value
     * @return string
     */
    function ejs($value)
    {
        $json = json_encode(
            $value,
            JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT
        );
        return $json === false ? 'null' : $json;
    }
}

if (!function_exists('eattr')) {
    /**
     * Build an HTML attribute list from an array, escaping both sides.
     *
     *   <input <?php echo eattr(array('name' => $n, 'value' => $v)); ?>>
     *
     * A null or false value drops the attribute entirely. True renders it
     * bare, which is what boolean attributes like `required` want.
     *
     * @param array<string,mixed> $attributes
     * @return string
     */
    function eattr(array $attributes)
    {
        $out = array();
        foreach ($attributes as $name => $value) {
            if ($value === null || $value === false) {
                continue;
            }
            $name = preg_replace('/[^A-Za-z0-9\-_:]/', '', (string) $name);
            if ($name === '') {
                continue;
            }
            if ($value === true) {
                $out[] = $name;
            } else {
                $out[] = $name . '="' . e($value) . '"';
            }
        }
        return implode(' ', $out);
    }
}

// ---------------------------------------------------------------------
// Translation
// ---------------------------------------------------------------------

if (!function_exists('t')) {
    /**
     * Look up an interface string in the current language.
     *
     * @param string $key          e.g. 'auth.login.title'
     * @param array  $replacements e.g. array(':n' => 5)
     * @return string
     */
    function t($key, array $replacements = array())
    {
        return View::t($key, $replacements);
    }
}

if (!function_exists('et')) {
    /**
     * Translate and escape. What a template almost always wants.
     *
     * @param string $key
     * @param array  $replacements
     * @return string
     */
    function et($key, array $replacements = array())
    {
        return e(View::t($key, $replacements));
    }
}

if (!function_exists('tc')) {
    /**
     * Translate with a count, picking the singular or plural form.
     *
     *   tc('review.due', $n)   ->  "1 verse ready" / "4 verses ready"
     *
     * :n is filled in from the count. See I18nService::choice() for how
     * the two forms are written.
     *
     * @param string $key
     * @param int    $count
     * @param array  $replacements
     * @return string
     */
    function tc($key, $count, array $replacements = array())
    {
        return View::choice($key, $count, $replacements);
    }
}

if (!function_exists('etc_')) {
    /**
     * Translate with a count, then escape.
     *
     * The trailing underscore is not a typo: etc() reads as "et cetera"
     * to every person who will ever open this file, and a helper whose
     * name means something else entirely is a small trap. This is the
     * escaping partner to tc().
     *
     * @param string $key
     * @param int    $count
     * @param array  $replacements
     * @return string
     */
    function etc_($key, $count, array $replacements = array())
    {
        return e(View::choice($key, $count, $replacements));
    }
}

// ---------------------------------------------------------------------
// CSRF
// ---------------------------------------------------------------------

if (!function_exists('csrf_token')) {
    /**
     * The current session's CSRF token.
     *
     * @return string
     */
    function csrf_token()
    {
        return Session::csrfToken();
    }
}

if (!function_exists('csrf_field')) {
    /**
     * The hidden input every POST form must carry.
     *
     * A form without this is refused by CsrfMiddleware before the
     * controller runs, which is deliberate: forgetting it should be a
     * loud failure in development rather than a silent hole in
     * production.
     *
     * @return string
     */
    function csrf_field()
    {
        $name = (string) Config::get('security.csrf.field_name', '_csrf');
        return '<input type="hidden" name="' . e($name) . '" value="' . e(csrf_token()) . '">';
    }
}

if (!function_exists('csp_nonce')) {
    /**
     * The Content-Security-Policy nonce for this request.
     *
     * Every inline <script> must carry it:
     *
     *     <script nonce="<?php echo csp_nonce(); ?>"> … </script>
     *
     * WHY THIS EXISTS RATHER THAN 'unsafe-inline'
     *   The policy is script-src 'self', which blocks inline script — and
     *   inline script is the payload of nearly every cross-site scripting
     *   attack, so that block is the single most valuable line in the
     *   policy. Adding 'unsafe-inline' to make one copy button work would
     *   switch it off for the whole site.
     *
     *   A nonce is the way to have both: a fresh random value per
     *   request, echoed into the header and into the tags we wrote
     *   ourselves. Injected script cannot carry it, because the attacker
     *   cannot know it.
     *
     *   Which means: NEVER put a nonce on a script whose contents came
     *   from user input, and never cache a page containing one.
     *
     * @return string
     */
    function csp_nonce()
    {
        $nonce = Config::get('security.csp_nonce');

        if (!is_string($nonce) || $nonce === '') {
            $nonce = base64_encode(random_bytes(16));
            Config::set('security.csp_nonce', $nonce);
        }

        return $nonce;
    }
}

if (!function_exists('csrf_meta')) {
    /**
     * The meta tag JavaScript reads to set the X-CSRF-Token header on a
     * fetch() call. Goes in the layout head.
     *
     * @return string
     */
    function csrf_meta()
    {
        return '<meta name="csrf-token" content="' . e(csrf_token()) . '">';
    }
}

// ---------------------------------------------------------------------
// Hashing and randomness
// ---------------------------------------------------------------------

if (!function_exists('hash_ip')) {
    /**
     * SHA-256 of an IP address plus the application pepper.
     *
     * Raw IP addresses are never stored anywhere in VedaVerse. The hash
     * is still enough to count five failed logins from one place, which
     * is all the throttle needs, while being useless to anybody who ends
     * up with a copy of the table — the pepper is what makes it useless,
     * since without it all four billion IPv4 addresses could be hashed
     * and looked up in an afternoon.
     *
     * @param string|null $ip Defaults to the current request.
     * @return string
     */
    function hash_ip($ip = null)
    {
        if ($ip === null) {
            $ip = isset($_SERVER['REMOTE_ADDR']) ? (string) $_SERVER['REMOTE_ADDR'] : '';
        }
        return hash('sha256', $ip . '|' . Config::get('security.pepper', ''));
    }
}

if (!function_exists('hash_value')) {
    /**
     * Peppered hash of any identifier — an email for the throttle key, a
     * user agent string, a token.
     *
     * NOT for passwords. Passwords use password_hash(), which is slow on
     * purpose. This is fast on purpose, because it runs on every request.
     *
     * @param string $value
     * @param string $scope Keeps hashes of the same value in different
     *                      contexts from matching each other.
     * @return string
     */
    function hash_value($value, $scope = '')
    {
        return hash('sha256', $scope . '|' . $value . '|' . Config::get('security.pepper', ''));
    }
}

if (!function_exists('random_token')) {
    /**
     * A cryptographically secure random hex string.
     *
     * random_bytes, never rand() or uniqid(). uniqid() is derived from
     * the clock and is guessable; rand() is not seeded for security. Both
     * look random enough to pass a glance and neither is.
     *
     * @param int $bytes
     * @return string Twice $bytes characters of hex.
     */
    function random_token($bytes = 32)
    {
        return bin2hex(random_bytes((int) $bytes));
    }
}

if (!function_exists('secure_equals')) {
    /**
     * Compare two strings without leaking their difference through timing.
     *
     * A normal === returns as soon as it finds a mismatched byte, so the
     * time it takes reveals how many leading characters were correct. For
     * a token an attacker can submit repeatedly, that is enough to
     * reconstruct it one character at a time. hash_equals always takes
     * the same time.
     *
     * @param string $known
     * @param string $given
     * @return bool
     */
    function secure_equals($known, $given)
    {
        return hash_equals((string) $known, (string) $given);
    }
}

if (!function_exists('uuid4')) {
    /**
     * A version 4 UUID, used as the public identifier for a user so the
     * sequential database id never appears in a URL.
     *
     * @return string
     */
    function uuid4()
    {
        $bytes    = random_bytes(16);
        $bytes[6] = chr((ord($bytes[6]) & 0x0f) | 0x40); // version 4
        $bytes[8] = chr((ord($bytes[8]) & 0x3f) | 0x80); // variant 1
        return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($bytes), 4));
    }
}

// ---------------------------------------------------------------------
// Current user
// ---------------------------------------------------------------------

if (!function_exists('current_user')) {
    /**
     * The signed-in user as an array, or null for a guest.
     *
     * Convenient in templates. It does NOT hit the database — the user is
     * loaded once per request by SessionMiddleware and cached.
     *
     * @return array<string,mixed>|null
     */
    function current_user()
    {
        return Session::user();
    }
}

if (!function_exists('is_logged_in')) {
    /**
     * @return bool
     */
    function is_logged_in()
    {
        return Session::user() !== null;
    }
}

if (!function_exists('user_can')) {
    /**
     * Role check.
     *
     * Roles are a simple ladder: user, moderator, admin, superadmin. A
     * higher rung can do everything a lower one can.
     *
     * IMPORTANT: this exists so a template can hide a button the user
     * cannot use. Hiding a button is tidiness, not security. The route
     * behind it must refuse the request on its own, in middleware or in
     * the service. Never let this function be the only thing standing
     * between a user and an action.
     *
     * @param string $role The minimum role required.
     * @return bool
     */
    function user_can($role)
    {
        $ladder = array('user' => 1, 'moderator' => 2, 'admin' => 3, 'superadmin' => 4);

        $user = Session::user();
        if ($user === null) {
            return false;
        }

        $have = isset($ladder[$user['role']]) ? $ladder[$user['role']] : 0;
        $need = isset($ladder[$role]) ? $ladder[$role] : 99;

        return $have >= $need;
    }
}
