<?php
/**
 * VedaVerse — app/core/View.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Renders a PHP template from app/views/, optionally wrapped in a
 *   layout, and returns the HTML as a string.
 *
 * WHAT DEPENDS ON IT
 *   Controllers, and only controllers. A view is the last stop.
 *
 * THE RULE VIEWS MUST NOT BREAK
 *   A view never queries the database. Not through a repository, not
 *   through a service, not "just this once for the sidebar". If a template
 *   needs data, the controller fetches it and passes it in. The moment a
 *   view can query, you can no longer tell what a page costs by reading
 *   the controller, and the N+1 query that appears six months later is
 *   invisible until the site is slow.
 *
 *   Views also never check permissions. Middleware and services do that.
 *   A view may hide a button for tidiness, but hiding a button is not
 *   security — the route behind it must refuse the request on its own.
 *
 * ESCAPING
 *   Everything printed goes through e(). Everything: database content,
 *   configuration, a name the user chose, a URL. The one exception is
 *   HTML we generated ourselves and know to be safe, printed with raw(),
 *   which is deliberately ugly to type so it stands out in review.
 *
 *   e() uses ENT_QUOTES so single quotes are escaped too, and
 *   ENT_SUBSTITUTE so an invalid UTF-8 byte becomes a replacement
 *   character instead of an empty string. That second flag matters here:
 *   without it, one malformed byte in a Devanagari string would blank the
 *   whole verse rather than showing one wrong character.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Core;

use Exception;
use Throwable;
use VedaVerse\Services\I18nService;

class View
{
    /** @var string Absolute path to app/views */
    private static $dir = '';

    /** @var array<string,mixed> Values available to every template. */
    private static $shared = array();

    /** @var array<string,string> Captured named sections. */
    private static $sections = array();

    /** @var array<int,string> Stack of section names currently being captured. */
    private static $stack = array();

    /** @var string The active interface language. */
    private static $lang = 'en';

    /**
     * @param string|null $dir
     * @return void
     */
    public static function init($dir = null)
    {
        self::$dir = $dir === null ? (string) Config::get('app.paths.views') : rtrim($dir, '/');
        self::$lang = (string) Config::get('i18n.default', 'en');
    }

    /**
     * Make a value available to every template — the current user, the
     * language, the base URL. Set once in the bootstrap.
     *
     * @param string|array $key
     * @param mixed        $value
     * @return void
     */
    public static function share($key, $value = null)
    {
        if (is_array($key)) {
            self::$shared = array_merge(self::$shared, $key);
            return;
        }
        self::$shared[$key] = $value;
    }

    /**
     * Set the language used by t().
     *
     * @param string $lang
     * @return void
     */
    public static function setLang($lang)
    {
        $languages = Config::get('i18n.languages', array());
        self::$lang = isset($languages[$lang]) ? $lang : (string) Config::get('i18n.fallback', 'en');
    }

    /** @return string */
    public static function lang()
    {
        return self::$lang;
    }

    /**
     * Render a template and return the HTML.
     *
     *   View::render('pages/verse', array('verse' => $verse), 'layouts/app')
     *
     * The template is plain PHP. $data keys arrive as local variables, so
     * array('verse' => $v) means $verse inside the file.
     *
     * @param string      $template Path under app/views, no .php
     * @param array       $data
     * @param string|null $layout   Path under app/views, no .php
     * @return string
     * @throws Exception when the template does not exist.
     */
    public static function render($template, array $data = array(), $layout = null)
    {
        if (self::$dir === '') {
            self::init();
        }

        $content = self::capture($template, $data);

        if ($layout === null) {
            return $content;
        }

        // The layout gets the same data plus the rendered page, so a
        // layout can read the page title the page set.
        $data['content'] = $content;
        return self::capture($layout, $data);
    }

    /**
     * Render a partial from inside another template. The one call a
     * template is allowed to make.
     *
     * @param string $template
     * @param array  $data
     * @return string
     */
    public static function partial($template, array $data = array())
    {
        return self::capture($template, $data);
    }

    /**
     * Does this template exist?
     *
     * Lets a caller offer a fallback without triggering the error log.
     * ErrorHandler uses it: in the early build steps the error templates do
     * not exist yet, and a missing-template error on every 404 would fill
     * the log with noise about a situation that is expected.
     *
     * @param string $template
     * @return bool
     */
    public static function exists($template)
    {
        if (self::$dir === '') {
            self::init();
        }
        return self::path($template) !== null;
    }

    /**
     * Include and buffer one template file.
     *
     * @param string $template
     * @param array  $data
     * @return string
     * @throws Exception
     */
    private static function capture($template, array $data)
    {
        // WHY EVERY LOCAL IN THIS METHOD IS PREFIXED __vv_
        //
        //   extract() below turns the data array into local variables.
        //   Any key matching a local this method still needs would clobber
        //   it, so EXTR_SKIP silently drops that key instead — the
        //   template then sees THIS method's variable rather than the one
        //   the controller passed, with no error anywhere.
        //
        //   That cost two debugging rounds in Step 5. A controller passing
        //   'path' got the template's filename; one passing 'level' got an
        //   output-buffer nesting depth. Both rendered a page, neither
        //   raised a warning, and 'level' is an entirely reasonable name
        //   for a controller to choose.
        //
        //   The prefix makes the collision impossible rather than merely
        //   documented. EXTR_SKIP stays as a backstop. Do NOT introduce an
        //   unprefixed local below this line.
        $__vv_path = self::path($template);

        if ($__vv_path === null) {
            // In production this becomes a 500 page. In development the
            // template name is the only useful part of the message, so it
            // is included either way — a template name is our own string,
            // never user input.
            Logger::error('Missing view template', array('template' => $template));
            throw new Exception('A page template is missing: ' . $template);
        }

        // Shared values first so a page can override one deliberately.
        $__vv_vars = array_merge(self::$shared, $data);

        extract($__vv_vars, EXTR_SKIP);

        $__vv_level = ob_get_level();
        ob_start();

        try {
            include $__vv_path;
        } catch (Exception $e) {
            // Unwind any buffers the template opened before it failed, or
            // its half-rendered output would leak into the error page.
            while (ob_get_level() > $__vv_level) {
                ob_end_clean();
            }
            throw $e;
        } catch (Throwable $e) {
            while (ob_get_level() > $__vv_level) {
                ob_end_clean();
            }
            throw $e;
        }

        return (string) ob_get_clean();
    }

    /**
     * Resolve a template name to a file, refusing anything that tries to
     * climb out of app/views.
     *
     * Template names come from our own controllers, not from requests. The
     * check is here anyway, because a route that renders "pages/" . $slug
     * is a very natural thing to write and is a file-disclosure bug the
     * moment somebody passes ../../config/local.
     *
     * @param string $template
     * @return string|null
     */
    private static function path($template)
    {
        $template = (string) $template;

        if (strpos($template, "\0") !== false || strpos($template, '..') !== false) {
            Logger::warning('Blocked a suspicious template path', array('template' => $template));
            return null;
        }
        if (preg_match('#^[A-Za-z0-9_/\-]+$#', $template) !== 1) {
            return null;
        }

        $path = self::$dir . '/' . $template . '.php';
        return is_file($path) ? $path : null;
    }

    // -----------------------------------------------------------------
    // Sections
    // -----------------------------------------------------------------

    /**
     * Start capturing a named section. Used by a page to hand something to
     * its layout — extra CSS in the head, a custom breadcrumb.
     *
     *   <?php View::start('head'); ?> <link ...> <?php View::end(); ?>
     *
     * @param string $name
     * @return void
     */
    public static function start($name)
    {
        self::$stack[] = $name;
        ob_start();
    }

    /**
     * Finish the section opened by the last start().
     *
     * @return void
     */
    public static function end()
    {
        if (self::$stack === array()) {
            Logger::warning('View::end() called without a matching start()');
            return;
        }
        $name = array_pop(self::$stack);
        self::$sections[$name] = (string) ob_get_clean();
    }

    /**
     * Print a captured section, or a default when the page set nothing.
     *
     * The content is NOT escaped: sections hold HTML the page composed
     * deliberately. Never capture raw user input into a section.
     *
     * @param string $name
     * @param string $default
     * @return string
     */
    public static function section($name, $default = '')
    {
        return isset(self::$sections[$name]) ? self::$sections[$name] : $default;
    }

    /**
     * Clear captured sections. Called between renders so one page's
     * leftovers never appear on the next.
     *
     * @return void
     */
    public static function reset()
    {
        self::$sections = array();
        self::$stack    = array();
    }

    // -----------------------------------------------------------------
    // Escaping and translation
    // -----------------------------------------------------------------

    /**
     * Escape for HTML. The single most-called function in the codebase.
     *
     * @param mixed $value
     * @return string
     */
    public static function e($value)
    {
        return htmlspecialchars((string) $value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
    }

    /**
     * Escape for use inside a URL query string.
     *
     * @param mixed $value
     * @return string
     */
    public static function eu($value)
    {
        return rawurlencode((string) $value);
    }

    /**
     * Escape for embedding a value in a <script> block.
     *
     * HEX_TAG and friends stop a string containing "</script>" from
     * closing the block early, which is the classic way a JSON blob in a
     * page turns into script injection.
     *
     * @param mixed $value
     * @return string
     */
    public static function ejs($value)
    {
        $json = json_encode(
            $value,
            JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT
        );
        return $json === false ? 'null' : $json;
    }

    /**
     * Look up an interface string in the current language.
     *
     * The lookup itself lives in I18nService — this is the entry point
     * templates use, kept because t() and et() call it from several
     * hundred places and because a template should not be reaching into
     * a service by name.
     *
     * Falls back to the configured fallback language, then to the key
     * itself so a missing string is visible rather than blank.
     *
     * @param string $key          e.g. 'error.404.title'
     * @param array  $replacements e.g. array(':n' => 5)
     * @param string|null $lang    Override the current language.
     * @return string
     */
    public static function t($key, array $replacements = array(), $lang = null)
    {
        return I18nService::translate($key, $replacements, $lang === null ? self::$lang : $lang);
    }

    /**
     * Singular or plural by count. See I18nService::choice().
     *
     * @param string      $key
     * @param int         $count
     * @param array       $replacements
     * @param string|null $lang
     * @return string
     */
    public static function choice($key, $count, array $replacements = array(), $lang = null)
    {
        return I18nService::choice($key, $count, $replacements, $lang === null ? self::$lang : $lang);
    }

    /**
     * The html lang attribute for a language code, so a screen reader
     * pronounces Devanagari correctly rather than reading it as English.
     *
     * @param string|null $lang
     * @return string
     */
    public static function htmlLang($lang = null)
    {
        $lang = $lang === null ? self::$lang : $lang;
        return (string) Config::get('i18n.languages.' . $lang . '.html_lang', 'en');
    }
}


/**
 * ---------------------------------------------------------------------
 * Global shorthands.
 *
 * A template that has to write View::e() around every value is a template
 * nobody escapes consistently, so the two most-used helpers get short
 * global names. Step 2 of the build order moves these into
 * app/helpers/security.php along with the rest of the helper set; the
 * function_exists guards mean both files can coexist during that change
 * without a fatal redeclare.
 * ---------------------------------------------------------------------
 */

if (!function_exists('e')) {
    /**
     * Escape a value for HTML output. Use this on everything.
     *
     * @param mixed $value
     * @return string
     */
    function e($value)
    {
        return htmlspecialchars((string) $value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
    }
}

if (!function_exists('t')) {
    /**
     * Translate an interface string.
     *
     * @param string $key
     * @param array  $replacements
     * @return string
     */
    function t($key, array $replacements = array())
    {
        return \VedaVerse\Core\View::t($key, $replacements);
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
        return e(\VedaVerse\Core\View::t($key, $replacements));
    }
}
