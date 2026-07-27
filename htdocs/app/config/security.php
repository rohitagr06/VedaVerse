<?php
/**
 * VedaVerse — app/config/security.php
 * ---------------------------------------------------------------------
 * Every security knob in one place.
 *
 * THE RULE THIS FILE SERVES
 *   Never trust input, validate it, sanitise it, authorise the action,
 *   process it, escape the output, log anything critical.
 *
 * CAREFUL WITH
 *   * 'pepper' is written by install.php into local.php. Changing it after
 *     launch invalidates every stored IP hash and every session. It does
 *     NOT invalidate passwords (bcrypt does not use it), so a change is
 *     survivable, but do not do it casually.
 *   * Loosening 'password' rules is your call, but shortening the minimum
 *     length is the single biggest downgrade you can make here.
 */

return array(

    // -----------------------------------------------------------------
    // Application pepper
    // -----------------------------------------------------------------
    // A site-wide secret mixed into every hash of an IP address or token,
    // so a stolen database cannot be reversed with a rainbow table of all
    // four billion IPv4 addresses. Overridden by local.php.
    'pepper' => 'CHANGE-ME-INSTALLER-WILL-REPLACE-THIS',

    // -----------------------------------------------------------------
    // Sessions
    // -----------------------------------------------------------------
    'session' => array(
        'name'            => 'vv_session',
        // Where PHP writes session files. Kept inside storage/, which is
        // blocked from the web by .htaccess, rather than the shared system
        // temp directory that other accounts on the host can read.
        'save_path'       => null, // filled in from app.paths.sessions
        'lifetime'        => 0,    // 0 = until the browser closes
        'path'            => '/',
        'domain'          => '',
        // Set automatically when the request arrives over HTTPS. A secure
        // cookie sent over plain http is simply never sent, which would
        // log everyone out on a non-TLS host.
        'secure'          => null,
        'httponly'        => true,
        'samesite'        => 'Lax',
        // Refuse a session id the server never issued.
        'use_strict_mode' => true,
        // Sign out after this long with no activity.
        'idle_timeout'    => 7200,    // 2 hours
        // Sign out after this long regardless of activity.
        'absolute_timeout' => 86400,  // 24 hours
        // Rotate the id on login and on any privilege change.
        'regenerate_on_login' => true,
    ),

    // The guest identity cookie. Long-lived on purpose: a guest's
    // bookmarks and notes should still be there when they come back next
    // month, and should merge into their account if they register.
    'anon_cookie' => array(
        'name'     => 'vv_anon',
        'lifetime' => 31536000, // one year
        'httponly' => true,
        'samesite' => 'Lax',
    ),

    // -----------------------------------------------------------------
    // CSRF
    // -----------------------------------------------------------------
    // One token per session. Every POST form carries it as a hidden field,
    // every fetch() carries it as a header, and CsrfMiddleware checks it
    // BEFORE the controller runs. A request without it never reaches
    // business logic.
    'csrf' => array(
        'field_name'  => '_csrf',
        'header_name' => 'X-CSRF-Token',
        'token_bytes' => 32,
        // Rotate the token this often. Long enough that a slowly filled
        // form does not fail, short enough to be worth having.
        'lifetime'    => 7200,
        // Routes exempt from CSRF because they are GET-only and read
        // nothing user-specific. Keep this list short and boring.
        'exempt'      => array(),
    ),

    // -----------------------------------------------------------------
    // Passwords
    // -----------------------------------------------------------------
    'password' => array(
        'algo'          => PASSWORD_BCRYPT,
        'cost'          => 10,
        'min_length'    => 10,
        'max_length'    => 200, // bcrypt truncates past 72 bytes; reject long input rather than silently ignore it
        'require_upper' => true,
        'require_lower' => true,
        'require_digit' => true,
        'require_symbol'=> true,
        // Reject anything in the bundled common list, case-insensitively.
        'block_common'  => true,
    ),

    // The recovery code shown once at signup. There is no email fallback,
    // so this is the entire account-recovery story. Length and alphabet
    // are chosen to be readable out loud and typo-resistant: no O/0, no
    // I/1/l.
    'recovery_code' => array(
        'length'   => 12,
        'alphabet' => 'ABCDEFGHJKMNPQRSTUVWXYZ23456789',
        'ttl_days' => 3650, // effectively permanent until used
    ),

    // -----------------------------------------------------------------
    // Brute force
    // -----------------------------------------------------------------
    // Counted per hashed identifier, per scope, in the login_attempts
    // table. Progressive delay means the fifth attempt is slow before it
    // is blocked, which costs an attacker far more than it costs a human
    // who mistyped.
    'throttle' => array(
        'max_attempts'    => 5,
        'window_seconds'  => 900,   // 15 minutes
        'lockout_seconds' => 900,
        'progressive_delay_ms' => array(0, 0, 250, 750, 1500),
        'scopes' => array('login', 'recover', 'admin_login', 'forum_post', 'search'),
    ),

    // -----------------------------------------------------------------
    // Uploads
    // -----------------------------------------------------------------
    // Four independent checks, because any one of them alone is bypassable:
    // extension, declared MIME type, actual magic bytes, and size. A file
    // that fails any check is rejected, not sanitised.
    'uploads' => array(
        'max_bytes'          => 2097152, // 2 MB
        'allowed_extensions' => array('csv', 'png', 'jpg', 'jpeg', 'webp'),
        'allowed_mime'       => array('text/csv', 'text/plain', 'application/vnd.ms-excel', 'image/png', 'image/jpeg', 'image/webp'),
        // Rejected outright, whatever they claim to be. SVG is on this
        // list because an SVG is an XML document that can carry script.
        'blocked_extensions' => array('php', 'php3', 'php4', 'php5', 'phtml', 'phar', 'js', 'html', 'htm', 'svg', 'zip', 'exe', 'sh', 'pl', 'py', 'cgi'),
        // First bytes that must match for image types.
        'magic' => array(
            'png'  => "\x89PNG\r\n\x1a\n",
            'jpg'  => "\xFF\xD8\xFF",
            'webp' => 'RIFF',
        ),
    ),

    // -----------------------------------------------------------------
    // Response headers
    // -----------------------------------------------------------------
    // Sent by SecurityHeadersMiddleware in PHP rather than .htaccess,
    // because InfinityFree may not have mod_headers enabled. The .htaccess
    // versions exist too, wrapped in <IfModule>, as a second layer.
    //
    // connect-src is the one to watch: it must list your Cloudflare Worker
    // origin, or the browser will silently block every Sarathi request.
    // The Worker URL is stored in settings and spliced in at runtime.
    'headers' => array(
        'X-Content-Type-Options'  => 'nosniff',
        'X-Frame-Options'         => 'SAMEORIGIN',
        'Referrer-Policy'         => 'strict-origin-when-cross-origin',
        'Permissions-Policy'      => 'geolocation=(), microphone=(), camera=(), interest-cohort=()',
        'Cross-Origin-Opener-Policy' => 'same-origin',
    ),

    'csp' => array(
        'default-src' => "'self'",
        'base-uri'    => "'self'",
        'object-src'  => "'none'",
        'frame-ancestors' => "'self'",
        'img-src'     => "'self' data:",
        'font-src'    => "'self'",
        // 'unsafe-inline' is present for style only, because critical CSS
        // is inlined into the head for performance. Scripts do NOT get it.
        'style-src'   => "'self' 'unsafe-inline'",
        'script-src'  => "'self'",
        // Worker origin appended at runtime from settings.worker_url.
        'connect-src' => "'self'",
        'form-action' => "'self'",
    ),

    // Only sent when the request is genuinely over HTTPS. Sending HSTS on
    // a host that later loses its certificate locks users out of the site.
    'hsts' => array(
        'enabled'            => true,
        'max_age'            => 15552000, // 180 days
        'include_subdomains' => false,
        'preload'            => false,
    ),

    // -----------------------------------------------------------------
    // Audit
    // -----------------------------------------------------------------
    // What gets written to audit_logs. The redact list is enforced in
    // Logger: any array key matching one of these is replaced with
    // [redacted] before anything is written anywhere.
    'audit' => array(
        'actions' => array(
            'login', 'login_failed', 'logout', 'register', 'password_reset',
            'role_change', 'authz_failure', 'admin_action', 'import',
            'delete', 'moderate', 'settings_change', 'certificate_issued',
        ),
        // Two lists, because matching matters more than it looks.
        //
        // redact_exact is compared with ===. A substring match here would
        // be actively harmful: 'pat' would redact 'path', 'code' would
        // redact 'country_code', and the logs would fill with [redacted]
        // where the useful detail should be. That is not a hypothetical —
        // it is exactly what happened the first time this was written as
        // one substring list.
        'redact_exact' => array(
            'code', 'token', 'csrf', '_csrf', 'secret', 'pepper',
            'authorization', 'auth', 'pat', 'github_pat', 'key',
        ),

        // redact_contains IS a substring match, for the compound names
        // that genuinely vary: new_password, password_confirm,
        // recovery_code_hash, gemini_api_key. Every entry here is long and
        // specific enough that a false positive is unlikely.
        'redact_contains' => array(
            'password', 'passwd', 'secret', 'api_key', 'apikey',
            'recovery_code', 'signing_secret', 'private_key', 'bearer',
        ),
    ),

    /**
     * The 200 most common passwords, bundled so the check works with no
     * network. Stored as one comma-separated string rather than a 200-line
     * array purely to keep this file readable. Validator explodes it once
     * and caches the result.
     *
     * To extend it, append to the string. Comparison is case-insensitive
     * and ignores surrounding whitespace.
     */
    'common_passwords' => '123456,password,123456789,12345678,12345,111111,1234567,sunshine,qwerty,iloveyou,princess,admin,welcome,666666,abc123,football,123123,monkey,654321,charlie,aa123456,donald,password1,qwerty123,letmein,zxcvbnm,login,starwars,121212,bailey,freedom,shadow,passw0rd,master,baseball,buster,daniel,hannah,thomas,summer,george,harley,222222,jessica,ginger,abcdef,trustno1,batman,dragon,michael,jordan,hunter,ranger,jennifer,joshua,maggie,biteme,hello,amanda,orange,banana,cookie,chelsea,jasmine,matrix,andrew,silver,richard,samantha,whatever,camaro,secret,andrea,mercedes,peanut,michelle,cheese,purple,nicole,tigger,ashley,robert,jackson,soccer,killer,taylor,martin,william,corvette,hockey,dallas,yankees,guitar,computer,asdfgh,1q2w3e4r,qazwsx,7777777,lovely,888888,chocolate,anthony,friends,butterfly,angel,spider,melissa,booboo,1234567890,flower,hottie,loveme,blessed,family,forever,sparky,snoopy,boomer,whitney,phoenix,junior,internet,service,canada,gateway,mustang,access,please,diamond,nothing,mother,blahblah,cowboy,alexis,samsung,jasper,morgan,brandy,patrick,marina,google,superman,iloveu,qwertyuiop,testing,test123,changeme,default,temp123,welcome1,admin123,root,toor,pass,pass123,letmein1,monkey1,dragon1,football1,baseball1,sunshine1,princess1,shadow1,master1,michael1,jordan23,harley1,ginger1,summer1,freedom1,hunter1,batman1,secret1,chelsea1,matrix1,orange1,banana1,cheese1,silver1,soccer1,hockey1,guitar1,computer1,gateway1,mustang1,phoenix1,diamond1,mother1,cowboy1,patrick1,superman1,krishna,krishna123,gita,bhagavad,radha,shivam,ganesh,india123,bharat,namaste,om123456,hanuman,arjuna,mahadev,jaishriram,ilovegod,gita108',
);
