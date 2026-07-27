<?php
/**
 * VedaVerse — app/helpers/url.php
 * ---------------------------------------------------------------------
 * Building links.
 *
 * THE RULE
 *   Never hardcode a domain, anywhere, ever. The free subdomain can
 *   change, the site may be reached on both www and bare, and a
 *   hardcoded host silently breaks canonical URLs, the sitemap, the
 *   Service Worker scope and every social card at once — while the site
 *   itself keeps working, so nobody notices for weeks.
 *
 *   The base URL is derived from the incoming request in index.php and
 *   stored in config for the rest of that request. Everything here reads
 *   it from there.
 *
 * PHP 7.4 COMPATIBLE.
 */

use VedaVerse\Core\Config;
use VedaVerse\Core\Router;

if (!function_exists('base_url')) {
    /**
     * The site's scheme and host, with no trailing slash.
     *
     * @return string
     */
    function base_url()
    {
        return rtrim((string) Config::get('app.url', ''), '/');
    }
}

if (!function_exists('url')) {
    /**
     * An absolute URL for a site-relative path.
     *
     * Use this for anything that leaves the page: canonical tags, Open
     * Graph, the sitemap, a certificate's verification link. Inside the
     * page, a relative path is fine and shorter.
     *
     * @param string $path
     * @param array  $query
     * @return string
     */
    function url($path = '/', array $query = array())
    {
        $url = base_url() . '/' . ltrim((string) $path, '/');

        if ($query !== array()) {
            $url .= (strpos($url, '?') === false ? '?' : '&') . http_build_query($query);
        }

        return $url;
    }
}

if (!function_exists('route')) {
    /**
     * The path for a named route.
     *
     *   route('verse.show', array('chapter' => 2, 'verse' => 47))
     *   -> /chapter/2/verse/47
     *
     * Always prefer this to writing a path by hand in a template. When a
     * URL structure changes, one route definition changes rather than
     * forty templates, and a typo becomes a logged warning instead of a
     * silent dead link.
     *
     * @param string $name
     * @param array  $params
     * @param array  $query
     * @return string
     */
    function route($name, array $params = array(), array $query = array())
    {
        $path = Router::url($name, $params);

        if ($query !== array()) {
            $path .= (strpos($path, '?') === false ? '?' : '&') . http_build_query($query);
        }

        return $path;
    }
}

if (!function_exists('asset')) {
    /**
     * A URL for a static file, with a cache-busting version string.
     *
     * The version is the app version rather than a file hash, because
     * hashing every asset on every request costs more than it saves on a
     * host this small. Bump app.version on a deploy and every browser
     * refetches.
     *
     * @param string $path Relative to /assets
     * @return string
     */
    function asset($path)
    {
        $path    = '/assets/' . ltrim((string) $path, '/');
        $version = (string) Config::get('app.version', '1');

        return $path . (strpos($path, '?') === false ? '?v=' : '&v=') . rawurlencode($version);
    }
}

if (!function_exists('current_path')) {
    /**
     * The path being requested, with no query string.
     *
     * @return string
     */
    function current_path()
    {
        $uri = isset($_SERVER['REQUEST_URI']) ? (string) $_SERVER['REQUEST_URI'] : '/';
        $q   = strpos($uri, '?');
        return $q === false ? $uri : substr($uri, 0, $q);
    }
}

if (!function_exists('is_current')) {
    /**
     * Is this path the one being viewed? For marking the active nav item.
     *
     * @param string $path
     * @param bool   $exact False also matches anything below the path, so
     *                      /chapter/2 lights up the "Chapters" tab.
     * @return bool
     */
    function is_current($path, $exact = false)
    {
        $current = rtrim(current_path(), '/');
        $path    = rtrim((string) $path, '/');

        if ($path === '') {
            return $current === '';
        }

        return $exact ? ($current === $path) : (strpos($current, $path) === 0);
    }
}

if (!function_exists('safe_redirect_target')) {
    /**
     * Make a redirect target safe to follow.
     *
     * An open redirect is when somebody can send a link to
     * yoursite.com/login?next=//evil.example and have your domain forward
     * the victim there. The domain in the address bar is what people
     * check, so this is a real phishing vector, and it is very easy to
     * introduce by accident with a "return to where you were" feature —
     * which is exactly what the login form has.
     *
     * Anything that is not a plain site-relative path becomes the
     * fallback.
     *
     * @param string|null $target
     * @param string      $fallback
     * @return string
     */
    function safe_redirect_target($target, $fallback = '/')
    {
        $target = (string) $target;

        if ($target === '') {
            return $fallback;
        }

        // Strip anything that could inject a header.
        $target = str_replace(array("\r", "\n", "\0"), '', $target);

        // A protocol-relative URL starts with // and goes off-site.
        if (strncmp($target, '//', 2) === 0) {
            return $fallback;
        }

        // Any scheme at all — http:, javascript:, data: — is refused.
        // We only ever want a path.
        if (preg_match('#^[a-zA-Z][a-zA-Z0-9+.\-]*:#', $target) === 1) {
            return $fallback;
        }

        if (strncmp($target, '/', 1) !== 0) {
            return $fallback;
        }

        return $target;
    }
}

if (!function_exists('verse_url')) {
    /**
     * The canonical path for a verse. Wrapped in its own helper because
     * it appears in search results, cross-references, chat citations,
     * bookmarks and the sitemap, and all of them must agree.
     *
     * @param int $chapter
     * @param int $verse
     * @return string
     */
    function verse_url($chapter, $verse)
    {
        return '/chapter/' . (int) $chapter . '/verse/' . (int) $verse;
    }
}

if (!function_exists('chapter_url')) {
    /**
     * @param int $chapter
     * @return string
     */
    function chapter_url($chapter)
    {
        return '/chapter/' . (int) $chapter;
    }
}
