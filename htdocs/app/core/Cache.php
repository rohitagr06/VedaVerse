<?php
/**
 * VedaVerse — app/core/Cache.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Stores computed values so the same work is not done twice. Three
 *   layers, checked in order: an in-request array, files in
 *   storage/cache/, and the cache table.
 *
 * WHAT DEPENDS ON IT
 *   ContentService, SearchService, SeoService and SettingRepository lean on
 *   it hardest. The pattern you will use most is remember():
 *
 *       $chapters = Cache::remember('chapters:all', 3600, function () {
 *           return (new ChapterRepository())->allPublished();
 *       });
 *
 *   The closure runs only on a miss.
 *
 * WHY THREE LAYERS
 *   The memory layer stops one page fetching the same thing five times.
 *   The file layer avoids a database round trip. The table layer is the
 *   fallback for when the cache directory is not writable, which happens
 *   on free hosting more often than you would expect. A hit at a slower
 *   layer back-fills the faster ones on the way out.
 *
 * WHAT IS NEVER CACHED
 *   Anything belonging to a signed-in person, and CSRF tokens. Caching a
 *   personalised value is how one learner ends up seeing another
 *   learner's progress, and it is very hard to notice in testing because
 *   it only shows up with two simultaneous users. set() refuses keys that
 *   start with "user:" unless the caller passes $private = true, which is
 *   a deliberate, greppable act.
 *
 * VALUES MUST BE JSON-SAFE
 *   Arrays, strings, numbers, booleans and null. Not objects, not
 *   closures, not resources. JSON is used rather than serialize() because
 *   unserialize() on stored data is an object-injection risk, and because
 *   a cache file you can read in a text editor is far easier to debug.
 *
 * NO CRON
 *   Expired entries are cleared opportunistically, on roughly one request
 *   in fifty. See purge().
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Core;

use Exception;
use Throwable;

class Cache
{
    /** @var array<string,mixed> Layer one. Alive for this request only. */
    private static $memory = array();

    /** @var bool|null Cached answer to "is the cache directory usable". */
    private static $fileUsable = null;

    /** @var array{hits:int,misses:int,writes:int} */
    private static $stats = array('hits' => 0, 'misses' => 0, 'writes' => 0);

    /**
     * Read a value. Returns $default on a miss or an expired entry.
     *
     * @param string $key
     * @param mixed  $default
     * @return mixed
     */
    public static function get($key, $default = null)
    {
        if (!self::enabled()) {
            return $default;
        }

        $key = self::normalise($key);

        // Layer 1: memory.
        if (array_key_exists($key, self::$memory)) {
            self::$stats['hits']++;
            return self::$memory[$key];
        }

        // Layer 2: file.
        if (self::layerOn('file')) {
            $value = self::fileGet($key);
            if ($value !== self::MISS) {
                self::$memory[$key] = $value;
                self::$stats['hits']++;
                return $value;
            }
        }

        // Layer 3: table.
        if (self::layerOn('table') && Config::get('cache.use_table', true)) {
            $value = self::tableGet($key);
            if ($value !== self::MISS) {
                // Back-fill the faster layers so the next reader is cheap.
                self::$memory[$key] = $value;
                if (self::layerOn('file')) {
                    self::filePut($key, $value, (int) Config::get('cache.ttl.default', 3600));
                }
                self::$stats['hits']++;
                return $value;
            }
        }

        self::$stats['misses']++;
        return $default;
    }

    /**
     * Store a value for $ttl seconds.
     *
     * @param string $key
     * @param mixed  $value   Must be JSON-encodable.
     * @param int    $ttl     Seconds. Falls back to cache.ttl.default.
     * @param bool   $private Set true only for deliberately per-user data.
     * @return bool
     */
    public static function set($key, $value, $ttl = null, $private = false)
    {
        if (!self::enabled()) {
            return false;
        }

        $key = self::normalise($key);
        $ttl = $ttl === null ? (int) Config::get('cache.ttl.default', 3600) : (int) $ttl;

        if ($ttl <= 0) {
            return false;
        }

        // The guard described in the header comment. A per-user key
        // reaching the shared cache by accident is a data leak, so it is
        // refused loudly in debug and quietly in production.
        if (!$private && strncmp($key, self::prefix() . 'user:', strlen(self::prefix()) + 5) === 0) {
            Logger::warning('Refused to cache a per-user key without the private flag', array('key' => $key));
            return false;
        }

        self::$memory[$key] = $value;
        self::$stats['writes']++;

        $ok = true;
        if (self::layerOn('file')) {
            $ok = self::filePut($key, $value, $ttl) && $ok;
        }
        if (self::layerOn('table') && Config::get('cache.use_table', true)) {
            $ok = self::tablePut($key, $value, $ttl) && $ok;
        }

        self::maybePurge();
        return $ok;
    }

    /**
     * Return a cached value, computing and storing it on a miss.
     *
     * The pattern to reach for by default: it makes the cached and
     * uncached paths one piece of code, so they cannot drift apart.
     *
     * @param string   $key
     * @param int      $ttl
     * @param callable $producer Runs only on a miss.
     * @param bool     $private
     * @return mixed
     */
    public static function remember($key, $ttl, $producer, $private = false)
    {
        $sentinel = self::get($key, self::MISS);
        if ($sentinel !== self::MISS) {
            return $sentinel;
        }

        $value = call_user_func($producer);

        // Null is cacheable, but "no rows found" is usually a transient
        // state during content editing, so it is not stored. The cost is
        // one repeated query on an empty page.
        if ($value !== null) {
            self::set($key, $value, $ttl, $private);
        }

        return $value;
    }

    /**
     * Drop one key from every layer.
     *
     * @param string $key
     * @return void
     */
    public static function forget($key)
    {
        $key = self::normalise($key);
        unset(self::$memory[$key]);

        $path = self::filePath($key);
        if ($path !== null && is_file($path)) {
            @unlink($path);
        }

        try {
            if (Database::isConnected() || Config::get('cache.use_table', true)) {
                Database::delete('cache', 'cache_key = :k', array('k' => $key));
            }
        } catch (Exception $e) {
            // A cache delete failing is not worth breaking a page over.
        } catch (Throwable $e) {
        }
    }

    /**
     * Drop every key that begins with a prefix.
     *
     * This is what an admin content save calls: after editing verse 47,
     * flush('verse:47') and flush('chapter:2') rather than clearing the
     * whole cache and making every other page slow for the next hour.
     *
     * @param string $prefix
     * @return void
     */
    public static function flush($prefix = '')
    {
        $full = self::normalise($prefix);

        foreach (array_keys(self::$memory) as $key) {
            if ($prefix === '' || strncmp($key, $full, strlen($full)) === 0) {
                unset(self::$memory[$key]);
            }
        }

        $dir = Config::get('cache.file.path');
        if ($dir && is_dir($dir)) {
            // File names are hashes, so a prefix cannot be matched by
            // filename. A prefix flush therefore clears the file layer
            // wholesale and lets it refill. Correctness over cleverness.
            self::rmFiles($dir);
        }

        try {
            if ($prefix === '') {
                Database::execute('DELETE FROM cache WHERE 1 = 1');
            } else {
                // LIKE with a bound parameter. The escape characters in the
                // prefix are neutralised so a key containing % cannot widen
                // the match.
                $like = str_replace(array('\\', '%', '_'), array('\\\\', '\\%', '\\_'), $full) . '%';
                Database::execute('DELETE FROM cache WHERE cache_key LIKE :like', array('like' => $like));
            }
        } catch (Exception $e) {
        } catch (Throwable $e) {
        }
    }

    // -----------------------------------------------------------------
    // File layer
    // -----------------------------------------------------------------

    /**
     * @return mixed self::MISS when absent or expired.
     */
    private static function fileGet($key)
    {
        $path = self::filePath($key);
        if ($path === null || !is_file($path)) {
            return self::MISS;
        }

        $raw = @file_get_contents($path);
        if ($raw === false || $raw === '') {
            return self::MISS;
        }

        $payload = json_decode($raw, true);
        if (!is_array($payload) || !array_key_exists('e', $payload) || !array_key_exists('v', $payload)) {
            // Corrupt or half-written. Remove it and treat as a miss.
            @unlink($path);
            return self::MISS;
        }

        if ((int) $payload['e'] < time()) {
            @unlink($path);
            return self::MISS;
        }

        return $payload['v'];
    }

    private static function filePut($key, $value, $ttl)
    {
        $path = self::filePath($key);
        if ($path === null) {
            return false;
        }

        $dir = dirname($path);
        if (!is_dir($dir) && !@mkdir($dir, 0755, true)) {
            return false;
        }

        $json = json_encode(array('e' => time() + (int) $ttl, 'v' => $value), JSON_UNESCAPED_UNICODE);
        if ($json === false) {
            Logger::warning('Cache value is not JSON-encodable', array('key' => $key));
            return false;
        }

        // Write to a temporary name and rename into place. Rename is
        // atomic on the same filesystem, so a reader never sees a
        // half-written file even if two requests write at once.
        $tmp = $path . '.' . getmypid() . '.tmp';
        if (@file_put_contents($tmp, $json, LOCK_EX) === false) {
            return false;
        }
        if (!@rename($tmp, $path)) {
            @unlink($tmp);
            return false;
        }

        return true;
    }

    /**
     * Hash the key into a path. Sharding by the first two hex characters
     * keeps any one directory to a few hundred files, because some shared
     * hosts get noticeably slow past a few thousand.
     *
     * @return string|null
     */
    private static function filePath($key)
    {
        if (self::$fileUsable === false) {
            return null;
        }

        $dir = Config::get('cache.file.path');
        if (!$dir) {
            self::$fileUsable = false;
            return null;
        }

        if (self::$fileUsable === null) {
            if (!is_dir($dir)) {
                @mkdir($dir, 0755, true);
            }
            self::$fileUsable = is_dir($dir) && is_writable($dir);
            if (!self::$fileUsable) {
                Logger::warning('Cache directory is not writable, falling back to the database layer', array('dir' => $dir));
                return null;
            }
        }

        $hash = hash('sha256', $key);
        $ext  = Config::get('cache.file.extension', '.cache');

        if (Config::get('cache.file.shard', true)) {
            return rtrim($dir, '/') . '/' . substr($hash, 0, 2) . '/' . $hash . $ext;
        }
        return rtrim($dir, '/') . '/' . $hash . $ext;
    }

    private static function rmFiles($dir)
    {
        $ext   = Config::get('cache.file.extension', '.cache');
        $items = @scandir($dir);
        if (!is_array($items)) {
            return;
        }
        foreach ($items as $item) {
            if ($item === '.' || $item === '..') {
                continue;
            }
            $path = rtrim($dir, '/') . '/' . $item;
            if (is_dir($path)) {
                self::rmFiles($path);
            } elseif (substr($item, -strlen($ext)) === $ext) {
                @unlink($path);
            }
        }
    }

    // -----------------------------------------------------------------
    // Table layer
    // -----------------------------------------------------------------

    private static function tableGet($key)
    {
        try {
            $row = Database::selectOne(
                'SELECT cache_value, expires_at FROM cache WHERE cache_key = :k LIMIT 1',
                array('k' => $key)
            );
        } catch (Exception $e) {
            return self::MISS;
        } catch (Throwable $e) {
            return self::MISS;
        }

        if ($row === null) {
            return self::MISS;
        }
        if (strtotime($row['expires_at']) < time()) {
            return self::MISS;
        }

        $payload = json_decode($row['cache_value'], true);
        if (!is_array($payload) || !array_key_exists('v', $payload)) {
            return self::MISS;
        }
        return $payload['v'];
    }

    private static function tablePut($key, $value, $ttl)
    {
        $json = json_encode(array('v' => $value), JSON_UNESCAPED_UNICODE);
        if ($json === false) {
            return false;
        }

        try {
            // One statement rather than SELECT-then-INSERT-or-UPDATE, which
            // has a race between the two halves.
            Database::execute(
                'INSERT INTO cache (cache_key, cache_value, expires_at)
                 VALUES (:k, :v, DATE_ADD(NOW(), INTERVAL :ttl SECOND))
                 ON DUPLICATE KEY UPDATE cache_value = VALUES(cache_value), expires_at = VALUES(expires_at)',
                array('k' => $key, 'v' => $json, 'ttl' => (int) $ttl)
            );
            return true;
        } catch (Exception $e) {
            return false;
        } catch (Throwable $e) {
            return false;
        }
    }

    // -----------------------------------------------------------------
    // Housekeeping
    // -----------------------------------------------------------------

    /**
     * Occasionally delete expired rows and files.
     *
     * There is no cron, so this rides along on a normal request. Running it
     * every time would add a DELETE to every page load, so it runs on
     * roughly one request in fifty and deletes a capped number of rows, and
     * the unlucky request that draws it still finishes fast.
     *
     * @return void
     */
    private static function maybePurge()
    {
        $probability = (int) Config::get('cache.purge.probability', 50);
        if ($probability < 1) {
            return;
        }

        // mt_rand rather than random_int: this is a scheduling coin flip,
        // not a security decision, and mt_rand is considerably cheaper.
        if (mt_rand(1, $probability) !== 1) {
            return;
        }

        self::purge();
    }

    /**
     * Delete expired entries now. Also callable from the admin panel.
     *
     * @return int Rows removed from the table.
     */
    public static function purge()
    {
        $limit   = (int) Config::get('cache.purge.limit', 200);
        $removed = 0;

        try {
            $removed = Database::execute(
                'DELETE FROM cache WHERE expires_at < NOW() LIMIT ' . (int) $limit
            );
        } catch (Exception $e) {
        } catch (Throwable $e) {
        }

        // The file layer stores its expiry inside each file, so an expired
        // file is removed when something next reads it. A periodic sweep
        // is not worth the directory walk on a small quota.
        return $removed;
    }

    // -----------------------------------------------------------------
    // Small helpers
    // -----------------------------------------------------------------

    /** Sentinel meaning "genuinely absent", so a stored null is not a miss. */
    const MISS = "\0__vv_cache_miss__\0";

    private static function enabled()
    {
        return (bool) Config::get('cache.enabled', true);
    }

    private static function layerOn($layer)
    {
        $layers = Config::get('cache.layers', array('memory', 'file', 'table'));
        return in_array($layer, (array) $layers, true);
    }

    private static function prefix()
    {
        return (string) Config::get('cache.prefix', 'vv:v1:');
    }

    /**
     * Add the configured prefix and strip anything that would be awkward
     * in a key. Bumping the version inside cache.prefix invalidates every
     * entry at once, which is the cheapest way to handle a deploy that
     * changes the shape of cached data.
     *
     * @param string $key
     * @return string
     */
    private static function normalise($key)
    {
        $key = preg_replace('/\s+/', '_', trim((string) $key));
        return self::prefix() . $key;
    }

    /**
     * Hit and miss counts for the debug bar.
     *
     * @return array{hits:int,misses:int,writes:int}
     */
    public static function stats()
    {
        return self::$stats;
    }
}
