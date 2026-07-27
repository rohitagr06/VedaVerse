<?php
/**
 * VedaVerse — app/core/ErrorHandler.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Catches everything PHP can go wrong with — notices, warnings, thrown
 *   exceptions, and fatal errors — and turns each one into a logged entry
 *   plus a friendly page.
 *
 * WHAT DEPENDS ON IT
 *   index.php and install.php call register() as their first real act,
 *   before anything else can fail.
 *
 * THE PRODUCTION RULE
 *   A visitor never sees a file path, a line number, a SQL fragment, a
 *   stack trace or a key. Not once, not on a rare error, not on the admin
 *   pages. Everything specific goes to the log; the page gets a short
 *   apology and a reference code the owner can search for. In debug mode,
 *   on your own machine, you get the details instead.
 *
 * WHY NOTICES ARE PROMOTED TO EXCEPTIONS
 *   PHP's default is to print a notice into the middle of the page and
 *   carry on with a value it has guessed. That is how a page ends up
 *   half-rendered with a warning in the header, and how a bug survives to
 *   production because nobody noticed the small red text. Here, any error
 *   PHP reports becomes an ErrorException, which means it either gets
 *   handled deliberately or it stops the request loudly.
 *
 *   Acceptance test 28 is "no PHP notices, warnings or deprecations on any
 *   page with error_reporting(E_ALL)". This class is how that stays true
 *   rather than being checked once and forgotten.
 *
 * PHP 7.4 AND 8.2 COMPATIBLE.
 *   PHP 8 turned several former warnings into thrown Errors and changed
 *   some notices into warnings. Because everything funnels through the
 *   same two handlers here, the behaviour is the same on both versions.
 *
 * CAREFUL CHANGING
 *   The shutdown handler is the only thing that can report a fatal error
 *   such as running out of memory, because at that point PHP will not call
 *   anything else. Keep it small and keep it allocating almost nothing.
 */

namespace VedaVerse\Core;

use ErrorException;
use Exception;
use Throwable;

class ErrorHandler
{
    /** @var bool */
    private static $registered = false;

    /** @var bool True once a fatal has been reported, to avoid doubling up. */
    private static $reported = false;

    /** @var int Reserved memory, freed on shutdown so the fatal handler can run after an out-of-memory error. */
    private static $reserve = null;

    /**
     * Turn on error handling.
     *
     * @return void
     */
    public static function register()
    {
        if (self::$registered) {
            return;
        }
        self::$registered = true;

        // Report everything. What differs between production and
        // development is whether it is DISPLAYED, not whether it is seen.
        error_reporting(E_ALL);
        ini_set('display_errors', Config::debug() ? '1' : '0');
        ini_set('display_startup_errors', Config::debug() ? '1' : '0');
        ini_set('log_errors', '1');

        // Hold a small block of memory. If the request later dies from
        // memory exhaustion, freeing this in the shutdown handler leaves
        // just enough room to log the fact and render a page.
        self::$reserve = str_repeat(' ', 32768);

        set_error_handler(array(__CLASS__, 'handleError'));
        set_exception_handler(array(__CLASS__, 'handleException'));
        register_shutdown_function(array(__CLASS__, 'handleShutdown'));
    }

    /**
     * Convert a PHP error into an exception.
     *
     * @param int    $severity
     * @param string $message
     * @param string $file
     * @param int    $line
     * @return bool
     * @throws ErrorException
     */
    public static function handleError($severity, $message, $file = '', $line = 0)
    {
        // Respect an @ suppression. VedaVerse uses @ deliberately and sparingly —
        // on log writes and cache writes, where a failure must not become a
        // visible error — and honouring it here is what makes that work.
        // error_reporting() returns 0 on PHP 7 and a small constant mask on
        // PHP 8 when the operator is in play, so check both shapes.
        $mask = error_reporting();
        if ($mask === 0 || ($mask & $severity) === 0) {
            return true;
        }

        throw new ErrorException($message, 0, $severity, $file, $line);
    }

    /**
     * Handle anything that reached the top uncaught.
     *
     * @param Throwable $e
     * @return void
     */
    public static function handleException($e)
    {
        self::$reported = true;

        try {
            Logger::exception($e, Logger::ERROR);
        } catch (Exception $inner) {
            // Logging itself failed. Nothing useful left to do but carry on
            // and still show the user a page.
        } catch (Throwable $inner) {
        }

        // An exception thrown while a view was rendering leaves partial
        // HTML in the output buffer. Discard it, or the error page appears
        // inside half a broken page.
        while (ob_get_level() > 0) {
            ob_end_clean();
        }

        $response = self::page(500, $e);
        $response->send();
    }

    /**
     * Catch a fatal error, which never reaches the exception handler.
     *
     * @return void
     */
    public static function handleShutdown()
    {
        // Give the reserve back so there is room to work after an
        // out-of-memory death.
        self::$reserve = null;

        $error = error_get_last();
        if ($error === null || self::$reported) {
            return;
        }

        $fatal = array(E_ERROR, E_PARSE, E_CORE_ERROR, E_COMPILE_ERROR, E_USER_ERROR);
        if (!in_array($error['type'], $fatal, true)) {
            return;
        }

        self::$reported = true;

        try {
            Logger::critical($error['message'], array(
                'file' => $error['file'],
                'line' => $error['line'],
                'type' => 'fatal',
            ));
        } catch (Exception $e) {
        } catch (Throwable $e) {
        }

        while (ob_get_level() > 0) {
            ob_end_clean();
        }

        self::page(500, null)->send();
    }

    /**
     * Build an error page for a status code.
     *
     * Used by the router's 404 handler and by the middleware for 401, 403
     * and 429 as well as by the handlers above, so every error page in the
     * product looks and behaves the same.
     *
     * @param int            $status
     * @param Throwable|null $e Included in the page only in debug mode.
     * @return Response
     */
    public static function page($status, $e = null)
    {
        $status = (int) $status;
        $ref    = Logger::requestRef();

        // A failed fetch() wants JSON, not an HTML page it will render into
        // a div as literal markup.
        if (self::wantsJson()) {
            $payload = array(
                'ok'        => false,
                'status'    => $status,
                'error'     => View::t('error.' . $status . '.title'),
                'reference' => $ref,
            );
            if ($e !== null && Config::debug()) {
                $payload['debug'] = array(
                    'message' => $e->getMessage(),
                    'file'    => $e->getFile(),
                    'line'    => $e->getLine(),
                );
            }
            return Response::json($payload, $status);
        }

        // Prefer a real template once the view layer exists. In Step 1 the
        // templates are not built yet, so the fallback below is what
        // renders — deliberately self-contained, with no dependency on the
        // design system, so that it still works when everything else is
        // broken.
        //
        // exists() is checked rather than catching a failure, so a missing
        // template is a quiet fallback while a template that exists and
        // throws is still logged as the real problem it is.
        if (View::exists('errors/' . $status) && View::exists('layouts/error')) {
            try {
                $html = View::render('errors/' . $status, array(
                    'status'    => $status,
                    'reference' => $ref,
                    'exception' => Config::debug() ? $e : null,
                ), 'layouts/error');
                return Response::html($html, $status);
            } catch (Exception $viewFailure) {
                Logger::error('The error template itself failed', array('status' => $status));
            } catch (Throwable $viewFailure) {
                Logger::error('The error template itself failed', array('status' => $status));
            }
        }

        return Response::html(self::fallbackHtml($status, $ref, $e), $status);
    }

    /**
     * A complete, self-contained error page.
     *
     * No external CSS, no fonts, no JavaScript, no database. This has to
     * render when the site is on fire, which means it cannot depend on any
     * part of the site.
     *
     * @param int            $status
     * @param string         $ref
     * @param Throwable|null $e
     * @return string
     */
    private static function fallbackHtml($status, $ref, $e = null)
    {
        $known = array(400, 401, 403, 404, 429, 500, 503);
        if (!in_array($status, $known, true)) {
            $status = 500;
        }

        $title = View::t('error.' . $status . '.title');
        $body  = View::t('error.' . $status . '.body');
        $lang  = View::htmlLang();

        // Debug details, and only in debug mode. This is the branch that
        // must never be reachable in production.
        $details = '';
        if ($e !== null && Config::debug()) {
            $details =
                '<pre style="margin-top:2rem;padding:1rem;background:#14121F;color:#FFF7EE;'
                . 'border-radius:12px;overflow:auto;font-size:13px;line-height:1.6;">'
                . View::e(get_class($e) . ': ' . $e->getMessage()) . "\n\n"
                . View::e($e->getFile() . ':' . $e->getLine()) . "\n\n"
                . View::e($e->getTraceAsString())
                . '</pre>';
        }

        return '<!doctype html>'
            . '<html lang="' . View::e($lang) . '">'
            . '<head>'
            . '<meta charset="utf-8">'
            . '<meta name="viewport" content="width=device-width, initial-scale=1">'
            . '<meta name="robots" content="noindex, nofollow">'
            . '<title>' . View::e($title) . '</title>'
            . '<style>'
            . 'body{margin:0;min-height:100vh;display:flex;align-items:center;justify-content:center;'
            . 'background:#FFF7EE;color:#14121F;font-family:system-ui,-apple-system,"Segoe UI",Roboto,sans-serif;'
            . 'line-height:1.6;padding:24px;}'
            . 'main{max-width:34rem;}'
            . 'h1{font-size:26px;margin:0 0 12px;}'
            . 'p{margin:0 0 16px;font-size:17px;}'
            . 'a{color:#2D5BFF;font-weight:600;}'
            . '.ref{font-size:13px;color:#6b6577;}'
            . '@media (prefers-color-scheme: dark){body{background:#14121F;color:#FFF7EE;}a{color:#7f9bff;}.ref{color:#9a94a8;}}'
            . '</style>'
            . '</head>'
            . '<body>'
            . '<main>'
            . '<h1>' . View::e($title) . '</h1>'
            . '<p>' . View::e($body) . '</p>'
            . '<p><a href="/">' . View::e(View::t('common.home')) . '</a></p>'
            . '<p class="ref">' . View::e(View::t('error.reference')) . ': ' . View::e($ref) . '</p>'
            . $details
            . '</main>'
            . '</body></html>';
    }

    /**
     * @return bool
     */
    private static function wantsJson()
    {
        $accept = isset($_SERVER['HTTP_ACCEPT']) ? (string) $_SERVER['HTTP_ACCEPT'] : '';
        if (stripos($accept, 'application/json') !== false) {
            return true;
        }
        $xhr = isset($_SERVER['HTTP_X_REQUESTED_WITH']) ? (string) $_SERVER['HTTP_X_REQUESTED_WITH'] : '';
        return strtolower($xhr) === 'xmlhttprequest';
    }
}
