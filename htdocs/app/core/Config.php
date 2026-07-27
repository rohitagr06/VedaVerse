<?php
/**
 * VedaVerse — app/core/Config.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Reads the files in app/config/, merges app/config/local.php over the
 *   top, and hands out values by dotted path:
 *
 *       Config::get('database.host')
 *       Config::get('cache.ttl.daily_verse', 3600)
 *
 * WHAT DEPENDS ON IT
 *   Almost everything. Database, Cache, Logger, View, Router and every
 *   service read their settings through it.
 *
 * WHY A CLASS AND NOT JUST require
 *   Three reasons. Each config file is read from disk exactly once per
 *   request no matter how many places ask for it. local.php overrides
 *   work in one place instead of eight. And a missing key returns a
 *   default instead of an undefined-index warning.
 *
 * NOT IN THE ORIGINAL CORE LIST
 *   The build specification names Autoloader, Router, Database, Cache,
 *   Logger, ErrorHandler, Validator and View. Config is an addition. The
 *   alternative was having every one of the eight config files reach for
 *   local.php itself, which is the same code copied eight times. Noted
 *   here so the difference from the specification is visible rather than
 *   silent.
 *
 * CAREFUL CHANGING
 *   set() writes to memory for the current request only. It never writes
 *   to disk. Runtime settings that must persist belong in the settings
 *   table, reached through SettingRepository, not here.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Core;

class Config
{
    /** @var array<string,array> Loaded config files, keyed by name without .php */
    private static $loaded = array();

    /** @var array Contents of local.php, or empty when it does not exist. */
    private static $local = array();

    /** @var bool */
    private static $localLoaded = false;

    /** @var string Absolute path to the config folder. */
    private static $dir = '';

    /** @var array<string,mixed> Memoised results, so a repeated get() costs one array lookup. */
    private static $resolved = array();

    /**
     * Point Config at the config folder. Called once from the bootstrap.
     * Safe to call again; a second call resets the cache, which is what
     * install.php wants after it has written local.php.
     *
     * @param string|null $dir
     * @return void
     */
    public static function init($dir = null)
    {
        if ($dir === null) {
            $dir = dirname(__DIR__) . '/config';
        }
        self::$dir         = rtrim(str_replace('\\', '/', $dir), '/');
        self::$loaded      = array();
        self::$resolved    = array();
        self::$local       = array();
        self::$localLoaded = false;
    }

    /**
     * Fetch a value by dotted path.
     *
     * The first segment is the filename: 'database.host' means the 'host'
     * key of app/config/database.php. Any depth works.
     *
     * @param string $path
     * @param mixed  $default Returned when the path does not exist.
     * @return mixed
     */
    public static function get($path, $default = null)
    {
        if (array_key_exists($path, self::$resolved)) {
            return self::$resolved[$path];
        }

        $parts = explode('.', $path);
        $file  = array_shift($parts);
        $data  = self::file($file);

        foreach ($parts as $part) {
            if (!is_array($data) || !array_key_exists($part, $data)) {
                // Not memoised: a caller may set() it later in the request.
                return $default;
            }
            $data = $data[$part];
        }

        self::$resolved[$path] = $data;
        return $data;
    }

    /**
     * Override a value for the rest of this request only.
     *
     * Used by the bootstrap to fill in values that cannot be written as
     * literals in a config file — the derived base URL, for example, or
     * the Worker URL loaded from the settings table.
     *
     * @param string $path
     * @param mixed  $value
     * @return void
     */
    public static function set($path, $value)
    {
        $parts = explode('.', $path);
        $file  = array_shift($parts);
        self::file($file); // make sure the file is loaded before we edit it

        if (empty($parts)) {
            self::$loaded[$file] = $value;
        } else {
            $ref = &self::$loaded[$file];
            foreach ($parts as $part) {
                if (!isset($ref[$part]) || !is_array($ref[$part])) {
                    $ref[$part] = array();
                }
                $ref = &$ref[$part];
            }
            $ref = $value;
            unset($ref);
        }

        // Any memoised path that starts with the one we just changed is
        // now stale. Cheapest correct answer is to drop the lot.
        self::$resolved = array();
    }

    /**
     * The whole contents of one config file.
     *
     * @param string $file Filename without .php
     * @return array
     */
    public static function all($file)
    {
        return self::file($file);
    }

    /**
     * True when the app is running with debug output on. Checked often
     * enough to deserve its own method.
     *
     * @return bool
     */
    public static function debug()
    {
        return (bool) self::get('app.debug', false);
    }

    /**
     * Load and cache one config file, applying local.php overrides.
     *
     * @param string $file
     * @return array
     */
    private static function file($file)
    {
        if (isset(self::$loaded[$file])) {
            return self::$loaded[$file];
        }

        if (self::$dir === '') {
            self::init();
        }

        // Filenames come from our own code, never from a request, but the
        // check costs nothing and makes that guarantee explicit.
        if (preg_match('/^[a-z0-9_]+$/', $file) !== 1) {
            self::$loaded[$file] = array();
            return array();
        }

        $path = self::$dir . '/' . $file . '.php';
        $data = is_file($path) ? require $path : array();
        if (!is_array($data)) {
            $data = array();
        }

        // Merge local.php over this file's own section.
        $local = self::local();
        if (isset($local[$file]) && is_array($local[$file])) {
            $data = self::merge($data, $local[$file]);
        }

        // Values that cannot be written as literals because they depend on
        // another config file. Doing it here means every reader sees the
        // finished value and nobody has to remember to fill it in.
        if ($file === 'security') {
            if (!isset($data['session']['save_path']) || $data['session']['save_path'] === null) {
                $data['session']['save_path'] = self::get('app.paths.sessions');
            }
        }
        if ($file === 'cache') {
            if (!isset($data['file']['path']) || $data['file']['path'] === null) {
                $data['file']['path'] = self::get('app.paths.cache');
            }
        }

        self::$loaded[$file] = $data;
        return $data;
    }

    /**
     * Read app/config/local.php once. Its absence is normal and silent:
     * before install.php runs, there is no local.php yet.
     *
     * @return array
     */
    private static function local()
    {
        if (self::$localLoaded) {
            return self::$local;
        }
        self::$localLoaded = true;

        $path = self::$dir . '/local.php';
        if (is_file($path)) {
            $data = require $path;
            self::$local = is_array($data) ? $data : array();
        }
        return self::$local;
    }

    /**
     * Recursive merge where the override wins.
     *
     * Deliberately NOT array_merge_recursive, which turns two scalars with
     * the same key into an array of both — so overriding a password would
     * produce a two-element array instead of the new password. This
     * version replaces scalars and merges only arrays, which is what
     * "override" actually means.
     *
     * A numerically-indexed array is replaced wholesale rather than
     * merged, because a list of allowed file extensions in local.php
     * should mean "use these", not "add these to the defaults".
     *
     * @param array $base
     * @param array $override
     * @return array
     */
    private static function merge(array $base, array $override)
    {
        foreach ($override as $key => $value) {
            if (is_array($value) && isset($base[$key]) && is_array($base[$key])
                && !self::isList($value)) {
                $base[$key] = self::merge($base[$key], $value);
            } else {
                $base[$key] = $value;
            }
        }
        return $base;
    }

    /**
     * True when the array is a plain 0,1,2 list rather than a map.
     * array_is_list() would do this in one call, but it is PHP 8.1 only
     * and this code has to run on 7.4.
     *
     * @param array $array
     * @return bool
     */
    private static function isList(array $array)
    {
        if ($array === array()) {
            return true;
        }
        return array_keys($array) === range(0, count($array) - 1);
    }
}
