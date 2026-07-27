<?php
/**
 * VedaVerse — app/repositories/SettingRepository.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Reads and writes the `settings` table — the values an admin can
 *   change at runtime without an FTP upload.
 *
 * SETTINGS VERSUS CONFIG, AND WHY BOTH EXIST
 *   app/config/*.php holds things that change when the CODE changes: the
 *   layer order of the cache, the password policy, which PDO options to
 *   use. Editing them means uploading a file.
 *
 *   The settings table holds things that change when the OWNER decides:
 *   the site name, the Worker URL, chat rate limits, maintenance mode,
 *   feature toggles. Editing them means clicking a button.
 *
 *   Putting the Worker URL in a config file would mean an FTP upload
 *   every time Cloudflare hands out a new subdomain. Putting the PDO
 *   options in the database would mean needing the database to work out
 *   how to connect to the database.
 *
 * ALWAYS READ THROUGH THE CACHE
 *   Settings are read on nearly every request — maintenance mode, the
 *   site name, the CSP's connect-src. Loading all of them once and
 *   caching for five minutes turns that into one query per five minutes
 *   rather than several per request. Five minutes is short enough that an
 *   admin change feels immediate, and any write invalidates the cache
 *   anyway.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Repositories;

use Exception;
use Throwable;
use VedaVerse\Core\Cache;
use VedaVerse\Core\Config;
use VedaVerse\Core\Logger;

class SettingRepository extends Repository
{
    /** @var string */
    protected $table = 'settings';

    /** @var array<string,string>|null In-request copy, so repeated reads are free. */
    private static $loaded = null;

    const CACHE_KEY = 'settings:all';

    /**
     * One setting.
     *
     * @param string $key
     * @param mixed  $default Returned when the key is missing entirely.
     * @return mixed
     */
    public function get($key, $default = null)
    {
        $all = $this->all();
        return array_key_exists($key, $all) ? $all[$key] : $default;
    }

    /**
     * A setting as a boolean. '0', '', 'false' and 'off' are all false.
     *
     * Worth having, because everything in this table is a string and
     * (bool) '0' is true in PHP — which is the sort of thing that turns
     * maintenance mode on and refuses to turn it off.
     *
     * @param string $key
     * @param bool   $default
     * @return bool
     */
    public function bool($key, $default = false)
    {
        $value = $this->get($key, null);
        if ($value === null) {
            return $default;
        }
        return !in_array(strtolower(trim((string) $value)), array('', '0', 'false', 'off', 'no'), true);
    }

    /**
     * @param string $key
     * @param int    $default
     * @return int
     */
    public function int($key, $default = 0)
    {
        $value = $this->get($key, null);
        return $value === null || !is_numeric($value) ? (int) $default : (int) $value;
    }

    /**
     * Every setting, keyed by name.
     *
     * @return array<string,string>
     */
    public function all()
    {
        if (self::$loaded !== null) {
            return self::$loaded;
        }

        $repo = $this;
        $ttl  = (int) Config::get('cache.ttl.settings', 300);

        $values = Cache::remember(self::CACHE_KEY, $ttl, function () use ($repo) {
            return $repo->readAll();
        });

        self::$loaded = is_array($values) ? $values : array();
        return self::$loaded;
    }

    /**
     * Read the table. Public so the cache closure can reach it on PHP 7.4.
     *
     * Returns an empty array rather than throwing when the table is not
     * there yet — which is the state during installation, and during a
     * database outage. A missing settings table must degrade to defaults
     * rather than to a white screen.
     *
     * @return array<string,string>
     */
    public function readAll()
    {
        try {
            $rows = $this->select('SELECT setting_key, setting_value FROM settings');
        } catch (Exception $e) {
            Logger::warning('Settings could not be read, falling back to defaults');
            return array();
        } catch (Throwable $e) {
            return array();
        }

        $out = array();
        foreach ($rows as $row) {
            $out[$row['setting_key']] = $row['setting_value'];
        }
        return $out;
    }

    /**
     * Write one setting and invalidate the cache immediately.
     *
     * @param string $key
     * @param mixed  $value
     * @return bool
     */
    public function set($key, $value)
    {
        try {
            $this->execute(
                'INSERT INTO settings (setting_key, setting_value) VALUES (:k, :v)
                 ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)',
                array('k' => (string) $key, 'v' => $value === null ? null : (string) $value)
            );
        } catch (Exception $e) {
            Logger::error('Could not write a setting', array('setting' => $key));
            return false;
        } catch (Throwable $e) {
            return false;
        }

        $this->forgetCache();
        return true;
    }

    /**
     * Write several settings at once, then invalidate once.
     *
     * @param array<string,mixed> $values
     * @return bool
     */
    public function setMany(array $values)
    {
        $repo = $this;

        try {
            $this->transaction(function () use ($repo, $values) {
                foreach ($values as $key => $value) {
                    $repo->execute(
                        'INSERT INTO settings (setting_key, setting_value) VALUES (:k, :v)
                         ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)',
                        array('k' => (string) $key, 'v' => $value === null ? null : (string) $value)
                    );
                }
                return true;
            });
        } catch (Exception $e) {
            Logger::error('Could not write settings', array('count' => count($values)));
            return false;
        } catch (Throwable $e) {
            return false;
        }

        $this->forgetCache();
        return true;
    }

    /**
     * Drop the cached copy, so the next read hits the table.
     *
     * @return void
     */
    public function forgetCache()
    {
        self::$loaded = null;
        Cache::forget(self::CACHE_KEY);
    }

    /**
     * Expose execute() to the transaction closure in setMany on PHP 7.4,
     * which cannot bind a closure to protected members.
     *
     * @param string $sql
     * @param array  $bindings
     * @return int
     */
    public function execute($sql, array $bindings = array())
    {
        return parent::execute($sql, $bindings);
    }
}
