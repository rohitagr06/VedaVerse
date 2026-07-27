<?php
/**
 * VedaVerse — app/core/Logger.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Writes application events to a daily file in storage/logs/, and the
 *   serious ones to the error_logs table so the admin dashboard can show
 *   them without FTP access.
 *
 * WHAT DEPENDS ON IT
 *   ErrorHandler (every uncaught error), Database (failed queries), and
 *   any service that wants to record something. Logger::audit() is the
 *   separate, deliberate trail of who did what.
 *
 * THE RULE THAT MATTERS MOST HERE
 *   Never log a password, an API key, a signing secret, a raw IP address,
 *   or the contents of a chat message. A log file is a text file on a
 *   shared host: assume somebody will eventually read it who should not
 *   have. redact() enforces this on the context array automatically, using
 *   the key list in config/security.php. It cannot catch a secret that
 *   somebody interpolated into the message string by hand, so do not do
 *   that.
 *
 * WHY IT NEVER THROWS
 *   Logging runs at the worst moments — the database is down, the disk is
 *   full, a fatal error is already in progress. If Logger threw an
 *   exception it would replace a diagnosable failure with a blank page. So
 *   every write is wrapped, and a failed write is given up on rather than
 *   escalated. Losing a log line is annoying. Losing the site is worse.
 *
 * CAREFUL CHANGING
 *   The recursion guard. Database calls Logger on a failed query, and
 *   Logger writes to the database. Without the guard, one failed INSERT
 *   would loop until the request died. Leave $writingToDb in place.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Core;

use Exception;
use PDO;
use Throwable;

class Logger
{
    // Severity, low to high. Anything at or above the database threshold
    // also gets a row in error_logs.
    const DEBUG    = 'debug';
    const INFO     = 'info';
    const NOTICE   = 'notice';
    const WARNING  = 'warning';
    const ERROR    = 'error';
    const CRITICAL = 'critical';

    /** @var array<string,int> */
    private static $severity = array(
        self::DEBUG => 10, self::INFO => 20, self::NOTICE => 30,
        self::WARNING => 40, self::ERROR => 50, self::CRITICAL => 60,
    );

    /** @var bool Guards against Database -> Logger -> Database recursion. */
    private static $writingToDb = false;

    /** @var bool Set false once the database is known to be unavailable. */
    private static $dbAvailable = true;

    /** @var string|null Short id shared by every line of one request. */
    private static $requestRef = null;

    /** @var array<string,bool> Directories already confirmed to exist. */
    private static $dirsReady = array();

    // -----------------------------------------------------------------
    // Level shortcuts
    // -----------------------------------------------------------------

    public static function debug($message, array $context = array())    { self::log(self::DEBUG, $message, $context); }
    public static function info($message, array $context = array())     { self::log(self::INFO, $message, $context); }
    public static function notice($message, array $context = array())   { self::log(self::NOTICE, $message, $context); }
    public static function warning($message, array $context = array())  { self::log(self::WARNING, $message, $context); }
    public static function error($message, array $context = array())    { self::log(self::ERROR, $message, $context); }
    public static function critical($message, array $context = array()) { self::log(self::CRITICAL, $message, $context); }

    /**
     * Write one line.
     *
     * @param string $level   One of the constants above.
     * @param string $message Human-readable. No secrets, no user content.
     * @param array  $context Extra detail. Redacted before writing.
     * @return void
     */
    public static function log($level, $message, array $context = array())
    {
        if (!isset(self::$severity[$level])) {
            $level = self::ERROR;
        }

        // In production, debug lines are dropped entirely rather than
        // written and ignored. On a 400 MB disk quota that matters.
        if ($level === self::DEBUG && !Config::debug()) {
            return;
        }

        $context = self::redact($context);

        self::toFile($level, $message, $context);

        if (self::$severity[$level] >= self::$severity[self::WARNING]) {
            self::toDatabase($level, $message, $context);
        }
    }

    /**
     * Record an exception with its type, message, file and line.
     *
     * The stack trace goes to the file log only, never to the database and
     * never to the browser: a trace names every file on the server.
     *
     * @param Throwable $e
     * @param string    $level
     * @return void
     */
    public static function exception($e, $level = self::ERROR)
    {
        $context = array(
            'type' => get_class($e),
            'file' => self::shortPath($e->getFile()),
            'line' => $e->getLine(),
        );

        if (Config::debug()) {
            $context['trace'] = $e->getTraceAsString();
        }

        self::log($level, $e->getMessage(), $context);
    }

    /**
     * The deliberate trail: who did what, to what, when.
     *
     * Separate from the error log because it answers a different question
     * and has a different retention need. Logins, authorisation failures,
     * admin actions, imports, deletions, moderation, settings changes and
     * certificate issuance all belong here.
     *
     * @param string      $action     e.g. 'role_change'
     * @param string|null $targetType e.g. 'user'
     * @param int|null    $targetId
     * @param array       $meta       Redacted before writing.
     * @param int|null    $userId     Who did it. Null for the system.
     * @return void
     */
    public static function audit($action, $targetType = null, $targetId = null, array $meta = array(), $userId = null)
    {
        if (self::$writingToDb || !self::$dbAvailable) {
            return;
        }

        $meta = self::redact($meta);

        try {
            self::$writingToDb = true;
            $pdo = Database::pdo();
            $stmt = $pdo->prepare(
                'INSERT INTO audit_logs (user_id, action, target_type, target_id, meta_json, ip_hash, created_at)
                 VALUES (:user_id, :action, :target_type, :target_id, :meta_json, :ip_hash, NOW())'
            );
            $stmt->execute(array(
                ':user_id'     => $userId,
                ':action'      => substr((string) $action, 0, 80),
                ':target_type' => $targetType === null ? null : substr((string) $targetType, 0, 60),
                ':target_id'   => $targetId,
                ':meta_json'   => $meta === array() ? null : json_encode($meta, JSON_UNESCAPED_UNICODE),
                ':ip_hash'     => self::ipHash(),
            ));
        } catch (Exception $e) {
            self::toFile(self::WARNING, 'Audit write failed: ' . $e->getMessage(), array());
        } catch (Throwable $e) {
            self::toFile(self::WARNING, 'Audit write failed: ' . $e->getMessage(), array());
        }

        self::$writingToDb = false;
    }

    /**
     * A short reference shared by every log line in this request and shown
     * on the error page. Lets a user say "I saw error a3f91c" and lets the
     * owner find the exact request, without exposing anything internal.
     *
     * @return string
     */
    public static function requestRef()
    {
        if (self::$requestRef === null) {
            try {
                self::$requestRef = substr(bin2hex(random_bytes(4)), 0, 8);
            } catch (Exception $e) {
                // random_bytes can only fail if the platform has no source
                // of randomness at all. A reference is a convenience, not a
                // security control, so a weak fallback is acceptable here
                // and only here.
                self::$requestRef = substr(md5(uniqid('', true)), 0, 8);
            }
        }
        return self::$requestRef;
    }

    // -----------------------------------------------------------------
    // Writers
    // -----------------------------------------------------------------

    /**
     * Append one line to storage/logs/vedaverse-YYYY-MM-DD.log
     *
     * FILE_APPEND with LOCK_EX means two simultaneous requests cannot
     * interleave halfway through a line.
     *
     * @return void
     */
    private static function toFile($level, $message, array $context)
    {
        $dir = Config::get('app.paths.logs');
        if (!$dir || !self::ensureDir($dir)) {
            return;
        }

        $line = sprintf(
            "[%s] %s.%s ref=%s %s%s\n",
            date('Y-m-d H:i:s'),
            'vedaverse',
            strtoupper($level),
            self::requestRef(),
            self::oneLine($message),
            $context === array() ? '' : ' ' . json_encode($context, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)
        );

        // The @ is here on purpose. If the disk is full or the directory
        // has gone read-only, a failed log write must not emit a warning
        // into the middle of a page.
        @file_put_contents($dir . '/vedaverse-' . date('Y-m-d') . '.log', $line, FILE_APPEND | LOCK_EX);
    }

    /**
     * Insert a row into error_logs. Best effort: if the database is the
     * thing that is broken, this quietly gives up and the file log is
     * still there.
     *
     * @return void
     */
    private static function toDatabase($level, $message, array $context)
    {
        if (self::$writingToDb || !self::$dbAvailable || !Database::isConnected()) {
            return;
        }

        try {
            self::$writingToDb = true;
            $pdo = Database::pdo();
            $stmt = $pdo->prepare(
                'INSERT INTO error_logs (level, message, file, line, url, session_ref, created_at)
                 VALUES (:level, :message, :file, :line, :url, :session_ref, NOW())'
            );
            $stmt->execute(array(
                ':level'       => $level,
                ':message'     => self::oneLine($message),
                ':file'        => isset($context['file']) ? substr((string) $context['file'], 0, 255) : null,
                ':line'        => isset($context['line']) ? (int) $context['line'] : null,
                ':url'         => substr(self::currentUrl(), 0, 500),
                ':session_ref' => self::requestRef(),
            ));
        } catch (Exception $e) {
            // One failure is enough. Stop trying for the rest of the
            // request rather than adding a failed INSERT to every line.
            self::$dbAvailable = false;
        } catch (Throwable $e) {
            self::$dbAvailable = false;
        }

        self::$writingToDb = false;
    }

    // -----------------------------------------------------------------
    // Helpers
    // -----------------------------------------------------------------

    /**
     * Replace the value of any sensitive key with [redacted], at any depth.
     * The key list lives in config/security.php so it can be extended
     * without touching this file.
     *
     * @param array $context
     * @param int   $depth Recursion guard against a self-referencing array.
     * @return array
     */
    private static function redact(array $context, $depth = 0)
    {
        if ($depth > 6) {
            return array('_' => '[too deep]');
        }

        $exact    = (array) Config::get('security.audit.redact_exact', array());
        $contains = (array) Config::get('security.audit.redact_contains', array());
        $out      = array();

        foreach ($context as $key => $value) {
            $lower = strtolower((string) $key);

            // Exact first — see the note in config/security.php about why
            // these two lists are separate.
            $hit = in_array($lower, $exact, true);

            if (!$hit) {
                foreach ($contains as $needle) {
                    if (strpos($lower, (string) $needle) !== false) {
                        $hit = true;
                        break;
                    }
                }
            }

            if ($hit) {
                $out[$key] = '[redacted]';
            } elseif (is_array($value)) {
                $out[$key] = self::redact($value, $depth + 1);
            } elseif (is_object($value)) {
                $out[$key] = '[object ' . get_class($value) . ']';
            } elseif (is_string($value) && strlen($value) > 500) {
                // Long strings are almost always user content. Truncate so
                // a full chat message or forum post never lands in a log.
                $out[$key] = substr($value, 0, 500) . '…[truncated]';
            } else {
                $out[$key] = $value;
            }
        }

        return $out;
    }

    /**
     * SHA-256 of the caller's IP plus the application pepper.
     *
     * Raw IP addresses are never stored anywhere in VedaVerse. The hash is still
     * enough to count five failed logins from one place, which is all the
     * throttle needs, while being useless to anybody who steals the table.
     *
     * @return string|null
     */
    public static function ipHash()
    {
        $ip = isset($_SERVER['REMOTE_ADDR']) ? $_SERVER['REMOTE_ADDR'] : '';
        if ($ip === '') {
            return null;
        }
        return hash('sha256', $ip . '|' . Config::get('security.pepper', ''));
    }

    /**
     * Newlines out of log lines, so one event is always one line and the
     * file can be read with tail or grep.
     *
     * @param string $text
     * @return string
     */
    private static function oneLine($text)
    {
        return trim(preg_replace('/\s+/u', ' ', (string) $text));
    }

    /**
     * Strip the server's absolute path down to something relative, so a
     * log line does not disclose the account's home directory.
     *
     * @param string $path
     * @return string
     */
    private static function shortPath($path)
    {
        $root = Config::get('app.paths.root', '');
        if ($root !== '' && strpos($path, $root) === 0) {
            return ltrim(substr($path, strlen($root)), '/');
        }
        return basename($path);
    }

    /**
     * The URL being requested, for the log row. Query string included,
     * because "which page" is usually the first question.
     *
     * @return string
     */
    private static function currentUrl()
    {
        if (PHP_SAPI === 'cli') {
            return 'cli';
        }
        $uri = isset($_SERVER['REQUEST_URI']) ? $_SERVER['REQUEST_URI'] : '';
        return (string) $uri;
    }

    /**
     * Create a directory if it is missing, once per request per path.
     *
     * @param string $dir
     * @return bool
     */
    private static function ensureDir($dir)
    {
        if (isset(self::$dirsReady[$dir])) {
            return self::$dirsReady[$dir];
        }
        $ok = is_dir($dir) ? true : @mkdir($dir, 0755, true);
        self::$dirsReady[$dir] = (bool) $ok && is_writable($dir);
        return self::$dirsReady[$dir];
    }

    /**
     * Delete log files older than the given number of days.
     *
     * There is no cron on this host, so TaskService calls this
     * occasionally from a normal request. The disk quota is small enough
     * that unbounded logs would eventually fill it.
     *
     * @param int $days
     * @return int Files removed.
     */
    public static function purgeOlderThan($days = 30)
    {
        $dir = Config::get('app.paths.logs');
        if (!$dir || !is_dir($dir)) {
            return 0;
        }

        $cutoff  = time() - ($days * 86400);
        $removed = 0;

        $files = glob($dir . '/vedaverse-*.log');
        if (!is_array($files)) {
            return 0;
        }

        foreach ($files as $file) {
            if (@filemtime($file) < $cutoff && @unlink($file)) {
                $removed++;
            }
        }

        return $removed;
    }
}
