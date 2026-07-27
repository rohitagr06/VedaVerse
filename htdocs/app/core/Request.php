<?php
/**
 * VedaVerse — app/core/Request.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Wraps the incoming HTTP request. One object holding the method, the
 *   path, the query string, the posted fields, the headers and the client
 *   fingerprint.
 *
 * WHAT DEPENDS ON IT
 *   Router (to match a route), every middleware, and every controller.
 *
 * WHY NOT JUST USE $_POST
 *   Three reasons, and the third is the important one.
 *   1. $_POST does not hold a JSON body, so an API endpoint would need
 *      different code from a form endpoint.
 *   2. Defaults. $request->post('page', 1) beats an isset() every time.
 *   3. Services must never touch superglobals. A service that reads $_POST
 *      cannot be unit tested, cannot be called from a CLI import, and
 *      cannot be reused. Controllers read the Request and hand plain
 *      values down. This is the boundary that keeps business logic
 *      portable, which is the whole point of the layering.
 *
 * WHAT THIS CLASS DOES NOT DO
 *   It does not validate, sanitise or escape. It reports what arrived,
 *   faithfully and untrusted. Validation is Validator's job, escaping is
 *   the view's. Somewhere between those two the value becomes safe, and
 *   keeping the stages separate is what makes it possible to tell where.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Core;

class Request
{
    /** @var string GET, POST, PUT, DELETE… */
    private $method = 'GET';

    /** @var string Path with no query string and no leading script name, e.g. /chapter/2/verse/47 */
    private $path = '/';

    /** @var array<string,mixed> */
    private $query = array();

    /** @var array<string,mixed> */
    private $body = array();

    /** @var array<string,string> Header name lowercased => value */
    private $headers = array();

    /** @var array<string,mixed> $_FILES as it arrived */
    private $files = array();

    /** @var array<string,mixed> Values the router extracted from the path, e.g. chapter => 2 */
    private $params = array();

    /** @var bool */
    private $secure = false;

    /** @var string Scheme and host, e.g. https://vedaverse.rf.gd */
    private $base = '';

    /**
     * Build a Request from PHP's superglobals.
     *
     * This is the only place in the codebase that reads $_SERVER, $_GET,
     * $_POST or php://input. Everything downstream goes through the
     * methods below.
     *
     * @return self
     */
    public static function capture()
    {
        $r = new self();

        $r->method = isset($_SERVER['REQUEST_METHOD']) ? strtoupper($_SERVER['REQUEST_METHOD']) : 'GET';
        $r->query  = $_GET;
        $r->files  = $_FILES;

        $r->headers = self::readHeaders();
        $r->secure  = self::detectHttps();
        $r->path    = self::detectPath();
        $r->base    = self::detectBase($r->secure);

        // A browser form posts application/x-www-form-urlencoded and lands
        // in $_POST. A fetch() with a JSON body does not, so read the raw
        // stream in that case. Both end up in the same place, so a
        // controller does not care which arrived.
        $type = $r->header('content-type', '');
        if ($r->method !== 'GET' && stripos($type, 'application/json') !== false) {
            $raw     = file_get_contents('php://input');
            $decoded = json_decode((string) $raw, true);
            $r->body = is_array($decoded) ? $decoded : array();
        } else {
            $r->body = $_POST;
        }

        // Browsers can only send GET and POST from a form. A hidden
        // _method field lets a form express PUT or DELETE. Only honoured
        // on a POST, so a GET can never be turned into a delete by editing
        // a URL — which is exactly the trick this would otherwise enable.
        if ($r->method === 'POST' && isset($r->body['_method'])) {
            $override = strtoupper((string) $r->body['_method']);
            if (in_array($override, array('PUT', 'PATCH', 'DELETE'), true)) {
                $r->method = $override;
            }
        }

        return $r;
    }

    // -----------------------------------------------------------------
    // Reading the request
    // -----------------------------------------------------------------

    /** @return string */
    public function method()
    {
        return $this->method;
    }

    /** @return bool */
    public function isPost()
    {
        return $this->method === 'POST';
    }

    /** @return bool */
    public function isGet()
    {
        return $this->method === 'GET';
    }

    /**
     * The path, always starting with a slash and never ending with one
     * (except for the root itself).
     *
     * @return string
     */
    public function path()
    {
        return $this->path;
    }

    /**
     * A query-string value.
     *
     * @param string|null $key  Null returns the whole array.
     * @param mixed       $default
     * @return mixed
     */
    public function query($key = null, $default = null)
    {
        if ($key === null) {
            return $this->query;
        }
        return array_key_exists($key, $this->query) ? $this->query[$key] : $default;
    }

    /**
     * A posted value, from a form or a JSON body.
     *
     * @param string|null $key
     * @param mixed       $default
     * @return mixed
     */
    public function post($key = null, $default = null)
    {
        if ($key === null) {
            return $this->body;
        }
        return array_key_exists($key, $this->body) ? $this->body[$key] : $default;
    }

    /**
     * A value from anywhere: route parameters first, then the body, then
     * the query string. Route parameters win because they are the most
     * specific and cannot be forged past the router's own pattern.
     *
     * @param string $key
     * @param mixed  $default
     * @return mixed
     */
    public function input($key, $default = null)
    {
        if (array_key_exists($key, $this->params)) {
            return $this->params[$key];
        }
        if (array_key_exists($key, $this->body)) {
            return $this->body[$key];
        }
        if (array_key_exists($key, $this->query)) {
            return $this->query[$key];
        }
        return $default;
    }

    /**
     * A value cast to an integer. For ids and page numbers, where a
     * non-numeric value should become the default rather than zero.
     *
     * @param string $key
     * @param int    $default
     * @return int
     */
    public function int($key, $default = 0)
    {
        $value = $this->input($key, null);
        if ($value === null || $value === '' || !is_numeric($value)) {
            return $default;
        }
        return (int) $value;
    }

    /**
     * A trimmed string. Never trust it, never echo it unescaped.
     *
     * @param string $key
     * @param string $default
     * @return string
     */
    public function str($key, $default = '')
    {
        $value = $this->input($key, null);
        if (!is_string($value)) {
            return $default;
        }
        return trim($value);
    }

    /**
     * A header, by case-insensitive name.
     *
     * @param string $name
     * @param mixed  $default
     * @return mixed
     */
    public function header($name, $default = null)
    {
        $name = strtolower($name);
        return isset($this->headers[$name]) ? $this->headers[$name] : $default;
    }

    /** @return array<string,mixed> */
    public function files()
    {
        return $this->files;
    }

    /**
     * Route parameters, set by the Router after a pattern match.
     *
     * @param array<string,mixed> $params
     * @return void
     */
    public function setParams(array $params)
    {
        $this->params = $params;
    }

    /**
     * @param string|null $key
     * @param mixed       $default
     * @return mixed
     */
    public function param($key = null, $default = null)
    {
        if ($key === null) {
            return $this->params;
        }
        return array_key_exists($key, $this->params) ? $this->params[$key] : $default;
    }

    // -----------------------------------------------------------------
    // Client fingerprint
    // -----------------------------------------------------------------

    /**
     * The caller's IP address.
     *
     * Proxy headers are NOT trusted. X-Forwarded-For is trivially forged
     * by the client, so trusting it would let anybody defeat the login
     * throttle by sending a different value each attempt. On this host
     * there is no reverse proxy in front of us anyway. If you later move
     * behind Cloudflare, read CF-Connecting-IP here and only here — and
     * only after locking the origin down so it cannot be reached directly.
     *
     * @return string
     */
    public function ip()
    {
        return isset($_SERVER['REMOTE_ADDR']) ? (string) $_SERVER['REMOTE_ADDR'] : '';
    }

    /**
     * SHA-256 of the IP plus the application pepper. This is what gets
     * stored. The raw address never does.
     *
     * @return string
     */
    public function ipHash()
    {
        return hash('sha256', $this->ip() . '|' . Config::get('security.pepper', ''));
    }

    /**
     * Hash of the user agent string, for spotting a session that has
     * jumped to a completely different browser.
     *
     * @return string
     */
    public function userAgentHash()
    {
        $ua = isset($_SERVER['HTTP_USER_AGENT']) ? (string) $_SERVER['HTTP_USER_AGENT'] : '';
        return hash('sha256', $ua . '|' . Config::get('security.pepper', ''));
    }

    /** @return bool */
    public function isSecure()
    {
        return $this->secure;
    }

    /**
     * True for a fetch() or XMLHttpRequest, so a controller can answer
     * with JSON instead of a redirect.
     *
     * @return bool
     */
    public function wantsJson()
    {
        $accept = (string) $this->header('accept', '');
        if (stripos($accept, 'application/json') !== false) {
            return true;
        }
        return strtolower((string) $this->header('x-requested-with', '')) === 'xmlhttprequest';
    }

    /**
     * The site's own scheme and host, worked out from this request.
     *
     * Never hardcode a domain anywhere in VedaVerse. The free subdomain can
     * change, the site may be reached on both www and bare, and a
     * hardcoded value silently breaks canonical URLs, the sitemap and the
     * Service Worker scope all at once.
     *
     * @return string e.g. https://vedaverse.rf.gd
     */
    public function base()
    {
        return $this->base;
    }

    /**
     * A full absolute URL for a site-relative path.
     *
     * @param string $path
     * @return string
     */
    public function url($path = '/')
    {
        return $this->base . '/' . ltrim((string) $path, '/');
    }

    /**
     * The full current URL, used for the canonical tag and error logs.
     *
     * @param bool $withQuery
     * @return string
     */
    public function fullUrl($withQuery = true)
    {
        $url = $this->base . $this->path;
        if ($withQuery && $this->query !== array()) {
            $url .= '?' . http_build_query($this->query);
        }
        return $url;
    }

    // -----------------------------------------------------------------
    // Detection
    // -----------------------------------------------------------------

    /**
     * @return array<string,string>
     */
    private static function readHeaders()
    {
        $headers = array();

        // getallheaders() exists under Apache mod_php but not everywhere,
        // so fall back to walking $_SERVER, which always works.
        if (function_exists('getallheaders')) {
            $raw = getallheaders();
            if (is_array($raw)) {
                foreach ($raw as $name => $value) {
                    $headers[strtolower($name)] = $value;
                }
                return $headers;
            }
        }

        foreach ($_SERVER as $key => $value) {
            if (strncmp($key, 'HTTP_', 5) === 0) {
                $name = strtolower(str_replace('_', '-', substr($key, 5)));
                $headers[$name] = $value;
            }
        }
        // These two arrive without the HTTP_ prefix.
        if (isset($_SERVER['CONTENT_TYPE'])) {
            $headers['content-type'] = $_SERVER['CONTENT_TYPE'];
        }
        if (isset($_SERVER['CONTENT_LENGTH'])) {
            $headers['content-length'] = $_SERVER['CONTENT_LENGTH'];
        }

        return $headers;
    }

    /**
     * @return bool
     */
    private static function detectHttps()
    {
        if (!empty($_SERVER['HTTPS']) && strtolower($_SERVER['HTTPS']) !== 'off') {
            return true;
        }
        if (isset($_SERVER['SERVER_PORT']) && (int) $_SERVER['SERVER_PORT'] === 443) {
            return true;
        }
        // Shared hosts commonly terminate TLS at a load balancer and pass
        // this along. It is a client-forgeable header in theory, but the
        // only thing it changes is whether generated links say https, so
        // the downside of trusting it here is a broken link rather than a
        // security hole.
        if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && strtolower($_SERVER['HTTP_X_FORWARDED_PROTO']) === 'https') {
            return true;
        }
        return false;
    }

    /**
     * Work out the application path from REQUEST_URI.
     *
     * Handles the case where VedaVerse is installed in a subfolder rather than
     * at the domain root, by subtracting the directory that index.php
     * lives in.
     *
     * @return string
     */
    private static function detectPath()
    {
        $uri = isset($_SERVER['REQUEST_URI']) ? (string) $_SERVER['REQUEST_URI'] : '/';

        // Drop the query string.
        $qpos = strpos($uri, '?');
        if ($qpos !== false) {
            $uri = substr($uri, 0, $qpos);
        }

        // Subtract the subdirectory, if any.
        $script = isset($_SERVER['SCRIPT_NAME']) ? (string) $_SERVER['SCRIPT_NAME'] : '';
        $dir    = rtrim(str_replace('\\', '/', dirname($script)), '/');
        if ($dir !== '' && $dir !== '.' && strpos($uri, $dir) === 0) {
            $uri = substr($uri, strlen($dir));
        }

        $uri = '/' . ltrim(rawurldecode($uri), '/');

        // Collapse doubled slashes and drop a trailing one, so /chapter/2/
        // and /chapter/2 are the same route and the same canonical URL.
        $uri = preg_replace('#/+#', '/', $uri);
        if ($uri !== '/' ) {
            $uri = rtrim($uri, '/');
        }

        return $uri === '' ? '/' : $uri;
    }

    /**
     * @param bool $secure
     * @return string
     */
    private static function detectBase($secure)
    {
        $configured = Config::get('app.url');
        if (is_string($configured) && $configured !== '') {
            return rtrim($configured, '/');
        }

        $scheme = ($secure || Config::get('app.force_https', false)) ? 'https' : 'http';

        $host = '';
        if (isset($_SERVER['HTTP_HOST'])) {
            $host = (string) $_SERVER['HTTP_HOST'];
        } elseif (isset($_SERVER['SERVER_NAME'])) {
            $host = (string) $_SERVER['SERVER_NAME'];
        }

        // The Host header comes from the client. Anything outside the legal
        // character set for a hostname is dropped rather than reflected,
        // because this value ends up inside generated links and a redirect.
        $host = preg_replace('/[^A-Za-z0-9\.\-:]/', '', $host);

        $script = isset($_SERVER['SCRIPT_NAME']) ? (string) $_SERVER['SCRIPT_NAME'] : '';
        $dir    = rtrim(str_replace('\\', '/', dirname($script)), '/');
        if ($dir === '.' ) {
            $dir = '';
        }

        return $scheme . '://' . $host . $dir;
    }
}
