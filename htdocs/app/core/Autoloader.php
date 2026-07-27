<?php
/**
 * VedaVerse — app/core/Autoloader.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Finds and loads class files on demand, so nothing in this codebase
 *   ever needs a require statement for a class. Write
 *   new \VedaVerse\Services\ContentService() and the file loads itself.
 *
 * WHY IT IS HAND-WRITTEN
 *   Composer is not available on this host and there is no build step, so
 *   the standard autoloader is not an option. This is about forty lines of
 *   the same idea.
 *
 * WHAT DEPENDS ON IT
 *   Everything. index.php and install.php require this one file directly,
 *   call register(), and from that point on every other class is found
 *   automatically.
 *
 * THE NAMING RULE
 *   \VedaVerse\Core\Router         -> app/core/Router.php
 *   \VedaVerse\Services\SeoService -> app/services/SeoService.php
 *   \VedaVerse\Repositories\VerseRepository -> app/repositories/VerseRepository.php
 *
 *   Namespace segments map to lowercase folder names (the folder is
 *   "core", the namespace is "Core"). The class name keeps its exact
 *   capitalisation and must match the filename exactly, because Linux
 *   filesystems are case-sensitive. A file named "router.php" holding
 *   class Router will work on Windows and fail the moment you upload it.
 *   Match the case.
 *
 * CAREFUL CHANGING
 *   The character check in load() is a security control, not tidiness. A
 *   class name is normally under your control, but if any code ever
 *   resolves a class name from user input, that check is what stops
 *   "..\..\..\etc\passwd" turning into a file read. Leave it in.
 *
 * PHP 7.4 COMPATIBLE. No Composer. No build step.
 */

namespace VedaVerse\Core;

class Autoloader
{
    /** @var string Absolute path to htdocs, with no trailing slash. */
    private static $root = '';

    /** @var array<string,string> Namespace prefix => folder, relative to root. */
    private static $map = array(
        'VedaVerse\\Core\\'         => 'app/core/',
        'VedaVerse\\Middleware\\'   => 'app/middleware/',
        'VedaVerse\\Controllers\\'  => 'app/controllers/',
        'VedaVerse\\Services\\'     => 'app/services/',
        'VedaVerse\\Repositories\\' => 'app/repositories/',
        'VedaVerse\\Models\\'       => 'app/models/',
    );

    /** @var bool Guards against register() being called twice. */
    private static $registered = false;

    /** @var array<string,bool> Class names we already failed to find, so we do not stat the disk twice for the same miss. */
    private static $misses = array();

    /**
     * Turn the autoloader on.
     *
     * @param string|null $root Absolute path to htdocs. Worked out from
     *                          this file's own location when omitted, so
     *                          the whole folder can be moved anywhere.
     * @return void
     */
    public static function register($root = null)
    {
        if (self::$registered) {
            return;
        }

        if ($root === null) {
            // __DIR__ is .../htdocs/app/core, so two levels up is htdocs.
            $root = dirname(dirname(__DIR__));
        }
        self::$root = rtrim(str_replace('\\', '/', $root), '/');

        // 'true' prepends nothing and appends this loader to the queue.
        // The third argument matters: without it a failure here would be
        // swallowed instead of surfacing as a clear error.
        spl_autoload_register(array(__CLASS__, 'load'), true, false);
        self::$registered = true;
    }

    /**
     * Register an extra namespace prefix at runtime.
     *
     * Used by install.php, which lives at the web root rather than inside
     * app/, and by anything vendored into vendor-lite/ later (FPDF for
     * certificates, for example).
     *
     * @param string $prefix    e.g. 'VedaVerse\\Vendor\\'
     * @param string $directory Path relative to htdocs, with trailing slash.
     * @return void
     */
    public static function addNamespace($prefix, $directory)
    {
        self::$map[$prefix] = ltrim(rtrim($directory, '/'), '/') . '/';
    }

    /**
     * Resolve one class name to one file and include it.
     *
     * Returning quietly on no-match is deliberate: other autoloaders may
     * be registered after this one and should get their turn. Throwing
     * here would break them.
     *
     * @param string $class Fully-qualified class name, no leading slash.
     * @return bool True when a file was included.
     */
    public static function load($class)
    {
        if (isset(self::$misses[$class])) {
            return false;
        }

        // Only letters, digits, underscores and backslashes are legal in a
        // PHP class name. Anything else — a dot, a slash, a null byte — is
        // either a bug or an attack. Refuse it before it touches the disk.
        if (preg_match('/[^A-Za-z0-9_\\\\]/', $class) === 1) {
            self::$misses[$class] = true;
            return false;
        }

        foreach (self::$map as $prefix => $folder) {
            // strncmp rather than strpos, because we care about a prefix
            // specifically and strncmp does not scan the whole string.
            if (strncmp($class, $prefix, strlen($prefix)) !== 0) {
                continue;
            }

            $relative = substr($class, strlen($prefix));
            $path = self::$root . '/' . $folder . str_replace('\\', '/', $relative) . '.php';

            if (is_file($path)) {
                require $path;
                return true;
            }

            // Matched the prefix but the file is not there. Remember the
            // miss so a later call does not stat the disk again.
            self::$misses[$class] = true;
            return false;
        }

        return false;
    }

    /**
     * The absolute path to htdocs. Handy anywhere a path has to be built
     * without dragging Config in.
     *
     * @return string
     */
    public static function root()
    {
        return self::$root;
    }
}
