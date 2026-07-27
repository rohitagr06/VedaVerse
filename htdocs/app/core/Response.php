<?php
/**
 * VedaVerse — app/core/Response.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Collects the status code, the headers and the body, and sends them
 *   once, at the end, in the right order.
 *
 * WHAT DEPENDS ON IT
 *   Every controller returns one. Middleware may add headers to it or
 *   replace it entirely.
 *
 * WHY BUFFER INSTEAD OF ECHOING
 *   PHP will not let you send a header after any output has been written,
 *   and the error message when you try ("headers already sent") points at
 *   the wrong line — it names the place output started, not the place the
 *   header was attempted. Building the whole response first and sending it
 *   in one go makes that class of bug impossible, and it also means an
 *   error thrown halfway through rendering can still be turned into a
 *   clean 500 page instead of half a page followed by an error.
 *
 * SECURITY NOTE
 *   Header values are stripped of newlines before being sent. Injecting a
 *   newline into a header lets an attacker add headers of their own or
 *   start the body early. Any value that came from a request must go
 *   through here rather than through header() directly.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Core;

class Response
{
    /** @var int */
    private $status = 200;

    /** @var array<string,string> Header name => value */
    private $headers = array();

    /** @var string */
    private $body = '';

    /** @var array<int,array> Cookies queued for sending. */
    private $cookies = array();

    /** @var bool Guards against sending twice. */
    private $sent = false;

    /** @var array<int,string> The status texts VedaVerse actually uses. */
    private static $texts = array(
        200 => 'OK',
        201 => 'Created',
        204 => 'No Content',
        301 => 'Moved Permanently',
        302 => 'Found',
        303 => 'See Other',
        304 => 'Not Modified',
        400 => 'Bad Request',
        401 => 'Unauthorized',
        403 => 'Forbidden',
        404 => 'Not Found',
        405 => 'Method Not Allowed',
        409 => 'Conflict',
        410 => 'Gone',
        413 => 'Payload Too Large',
        422 => 'Unprocessable Entity',
        429 => 'Too Many Requests',
        500 => 'Internal Server Error',
        503 => 'Service Unavailable',
    );

    /**
     * @param string $body
     * @param int    $status
     * @param array<string,string> $headers
     */
    public function __construct($body = '', $status = 200, array $headers = array())
    {
        $this->body   = (string) $body;
        $this->status = (int) $status;
        foreach ($headers as $name => $value) {
            $this->header($name, $value);
        }
    }

    // -----------------------------------------------------------------
    // Named constructors
    // -----------------------------------------------------------------

    /**
     * An HTML page.
     *
     * @param string $html
     * @param int    $status
     * @return self
     */
    public static function html($html, $status = 200)
    {
        return new self($html, $status, array('Content-Type' => 'text/html; charset=utf-8'));
    }

    /**
     * A JSON reply, for the api/ endpoints and for fetch() calls.
     *
     * JSON_UNESCAPED_UNICODE keeps Devanagari as Devanagari rather than
     * turning it into कृ escapes: same meaning, roughly a third
     * of the bytes, and readable when you are debugging.
     *
     * @param mixed $data
     * @param int   $status
     * @return self
     */
    public static function json($data, $status = 200)
    {
        $json = json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        if ($json === false) {
            Logger::error('Failed to encode a JSON response', array('error' => json_last_error_msg()));
            $json   = '{"ok":false,"error":"encoding_failed"}';
            $status = 500;
        }

        return new self($json, $status, array(
            'Content-Type' => 'application/json; charset=utf-8',
            // An API reply is per-request and often per-user. Never let a
            // proxy or the Service Worker keep a copy.
            'Cache-Control' => 'no-store',
        ));
    }

    /**
     * A redirect.
     *
     * 302 by default, because that is what a form submission wants: it
     * says "look over there this time" rather than "never come back here".
     * A 301 is cached by the browser permanently and is very hard to undo
     * once it is out, so use it only for a genuine permanent move.
     *
     * @param string $to     Site-relative path or absolute URL.
     * @param int    $status
     * @return self
     */
    public static function redirect($to, $status = 302)
    {
        $r = new self('', $status);
        $r->header('Location', self::safeLocation($to));
        return $r;
    }

    /**
     * An empty 204, for a fetch() that has nothing to say back.
     *
     * @return self
     */
    public static function noContent()
    {
        return new self('', 204);
    }

    /**
     * Serve a file for download. Used for certificates and admin exports.
     *
     * @param string $path     Absolute path on disk.
     * @param string $filename What the browser should call it.
     * @param string $mime
     * @return self
     */
    public static function download($path, $filename, $mime = 'application/octet-stream')
    {
        if (!is_file($path) || !is_readable($path)) {
            return new self('', 404);
        }

        $body = (string) file_get_contents($path);

        // The filename is quoted and stripped of anything that could break
        // out of the header or the quotes.
        $safe = preg_replace('/[^A-Za-z0-9\.\-_ ]/', '', (string) $filename);

        return new self($body, 200, array(
            'Content-Type'        => $mime,
            'Content-Disposition' => 'attachment; filename="' . $safe . '"',
            'Content-Length'      => (string) strlen($body),
            'Cache-Control'       => 'private, no-store',
        ));
    }

    // -----------------------------------------------------------------
    // Building
    // -----------------------------------------------------------------

    /**
     * Set a header. Newlines are stripped: see the security note above.
     *
     * @param string $name
     * @param string $value
     * @return self Chainable.
     */
    public function header($name, $value)
    {
        $name  = preg_replace('/[^A-Za-z0-9\-]/', '', (string) $name);
        $value = str_replace(array("\r", "\n", "\0"), '', (string) $value);
        if ($name !== '') {
            $this->headers[$name] = $value;
        }
        return $this;
    }

    /**
     * @param array<string,string> $headers
     * @return self
     */
    public function headers(array $headers)
    {
        foreach ($headers as $name => $value) {
            $this->header($name, $value);
        }
        return $this;
    }

    /**
     * @param int $status
     * @return self
     */
    public function status($status = null)
    {
        if ($status === null) {
            return $this->status;
        }
        $this->status = (int) $status;
        return $this;
    }

    /**
     * @param string|null $body
     * @return self|string
     */
    public function body($body = null)
    {
        if ($body === null) {
            return $this->body;
        }
        $this->body = (string) $body;
        return $this;
    }

    /**
     * Queue a cookie.
     *
     * Defaults come from config/security.php and are the safe ones:
     * HttpOnly so JavaScript cannot read it, SameSite=Lax so it is not
     * sent on a cross-site POST, and Secure whenever the request is over
     * HTTPS.
     *
     * @param string $name
     * @param string $value
     * @param int    $lifetime Seconds from now. 0 means a session cookie.
     * @param array  $options  Overrides.
     * @return self
     */
    public function cookie($name, $value, $lifetime = 0, array $options = array())
    {
        $defaults = array(
            'path'     => '/',
            'domain'   => '',
            'secure'   => !empty($_SERVER['HTTPS']) && strtolower($_SERVER['HTTPS']) !== 'off',
            'httponly' => true,
            'samesite' => 'Lax',
        );

        $this->cookies[] = array(
            'name'    => $name,
            'value'   => $value,
            'expires' => $lifetime > 0 ? time() + $lifetime : 0,
            'options' => array_merge($defaults, $options),
        );

        return $this;
    }

    // -----------------------------------------------------------------
    // Sending
    // -----------------------------------------------------------------

    /**
     * Write the whole thing to the client. Called once, by index.php.
     *
     * @return void
     */
    public function send()
    {
        if ($this->sent) {
            return;
        }
        $this->sent = true;

        if (headers_sent($file, $line)) {
            // Something wrote output before we got here — usually a stray
            // space after a closing PHP tag in an included file. Log where,
            // because the browser will show a mangled page and this is the
            // only clue.
            Logger::error('Output started before the response was sent', array(
                'file' => $file,
                'line' => $line,
            ));
        } else {
            $text = isset(self::$texts[$this->status]) ? self::$texts[$this->status] : '';
            header('HTTP/1.1 ' . $this->status . ($text === '' ? '' : ' ' . $text), true, $this->status);

            foreach ($this->headers as $name => $value) {
                header($name . ': ' . $value, true);
            }

            foreach ($this->cookies as $cookie) {
                self::sendCookie($cookie);
            }
        }

        // 204 means "no body", and a 304 must not have one either. Sending
        // bytes anyway makes some clients hang waiting for a length that
        // will never match.
        if ($this->status !== 204 && $this->status !== 304) {
            echo $this->body;
        }
    }

    /**
     * setcookie() takes an options array from PHP 7.3 onward, which is the
     * only form that supports SameSite. VedaVerse's floor is 7.4, so the array
     * form is always available.
     *
     * @param array $cookie
     * @return void
     */
    private static function sendCookie(array $cookie)
    {
        $o = $cookie['options'];
        setcookie($cookie['name'], (string) $cookie['value'], array(
            'expires'  => $cookie['expires'],
            'path'     => $o['path'],
            'domain'   => $o['domain'],
            'secure'   => (bool) $o['secure'],
            'httponly' => (bool) $o['httponly'],
            'samesite' => $o['samesite'],
        ));
    }

    /**
     * Make a redirect target safe.
     *
     * An open redirect is when somebody can send a link to
     * yoursite.com/go?to=evil.example and have your domain forward the
     * victim there. It is a real phishing vector and it is easy to
     * introduce by accident, so anything that is not a plain site-relative
     * path is replaced with the site root.
     *
     * @param string $to
     * @return string
     */
    private static function safeLocation($to)
    {
        $to = str_replace(array("\r", "\n", "\0"), '', (string) $to);

        // A protocol-relative URL starts with // and goes off-site.
        if (strncmp($to, '//', 2) === 0) {
            return '/';
        }

        // An absolute URL is allowed only when it points at this site.
        if (preg_match('#^https?://#i', $to) === 1) {
            $host = parse_url($to, PHP_URL_HOST);
            $self = isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : '';
            if ($host === null || strcasecmp((string) $host, (string) $self) !== 0) {
                Logger::warning('Blocked an off-site redirect', array('target' => $to));
                return '/';
            }
            return $to;
        }

        return '/' . ltrim($to, '/');
    }
}
