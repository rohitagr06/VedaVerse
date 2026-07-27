<?php
/**
 * VedaVerse — app/core/Database.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Opens the single PDO connection, and gives repositories a small set of
 *   helpers for running prepared statements.
 *
 * WHAT DEPENDS ON IT
 *   Every repository. Nothing else should touch it — not controllers, not
 *   services, and absolutely not views. If you find yourself typing
 *   Database:: outside app/repositories/, stop and put the query in a
 *   repository instead. That one rule is what makes the eventual move to
 *   another database or another framework a small job instead of a rewrite.
 *
 * THE NON-NEGOTIABLE
 *   Every value that came from a request goes in through a bound
 *   parameter. Never build SQL by joining strings, not even in admin, not
 *   even when "it is only an integer". The helpers here bind everything,
 *   and the only strings that reach SQL directly are table and column
 *   names supplied by our own code, which are checked against a strict
 *   pattern before use.
 *
 * ONE CONNECTION PER REQUEST
 *   Free shared hosting has a low ceiling on simultaneous MySQL
 *   connections, and persistent connections hold slots open between
 *   requests until the account gets throttled. So: one connection, opened
 *   the first time it is needed, closed when the request ends.
 *
 * CAREFUL CHANGING
 *   ATTR_EMULATE_PREPARES is false in config/database.php. Setting it true
 *   makes PDO fake prepared statements by substituting strings itself,
 *   which quietly turns your injection defence into a string-escaping
 *   function. Leave it false.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Core;

use Exception;
use PDO;
use PDOException;
use PDOStatement;

class Database
{
    /** @var PDO|null */
    private static $pdo = null;

    /** @var int Queries run this request. Shown on the debug bar. */
    private static $queryCount = 0;

    /** @var float Total query time this request, in milliseconds. */
    private static $queryMs = 0.0;

    /** @var string Table prefix from config, usually empty. */
    private static $prefix = '';

    /**
     * The live PDO handle, connecting on first use.
     *
     * @return PDO
     * @throws Exception when the connection cannot be made.
     */
    public static function pdo()
    {
        if (self::$pdo === null) {
            self::connect();
        }
        return self::$pdo;
    }

    /**
     * True when a connection is already open. Used by Logger so that
     * writing a log line never itself triggers a connection attempt during
     * a database outage.
     *
     * @return bool
     */
    public static function isConnected()
    {
        return self::$pdo !== null;
    }

    /**
     * Open the connection.
     *
     * The credentials come from config/database.php, which install.php
     * overrides through local.php.
     *
     * @return void
     * @throws Exception
     */
    private static function connect()
    {
        $cfg = Config::all('database');

        self::$prefix = isset($cfg['prefix']) ? (string) $cfg['prefix'] : '';

        $dsn = sprintf(
            'mysql:host=%s;port=%d;dbname=%s;charset=%s',
            isset($cfg['host']) ? $cfg['host'] : 'localhost',
            isset($cfg['port']) ? (int) $cfg['port'] : 3306,
            isset($cfg['database']) ? $cfg['database'] : '',
            isset($cfg['charset']) ? $cfg['charset'] : 'utf8mb4'
        );

        $options = isset($cfg['options']) && is_array($cfg['options']) ? $cfg['options'] : array();
        $options[PDO::ATTR_TIMEOUT] = isset($cfg['connect_timeout']) ? (int) $cfg['connect_timeout'] : 8;

        // Belt and braces on the charset. Some MySQL builds honour the DSN
        // charset, some honour the init command, and a mismatch is exactly
        // how Devanagari turns into ????. Set both.
        if (!empty($cfg['init_command'])) {
            $options[PDO::MYSQL_ATTR_INIT_COMMAND] = $cfg['init_command'];
        }

        try {
            self::$pdo = new PDO(
                $dsn,
                isset($cfg['username']) ? $cfg['username'] : '',
                isset($cfg['password']) ? $cfg['password'] : '',
                $options
            );
        } catch (PDOException $e) {
            // The PDO message contains the username and sometimes the host.
            // Log a version the owner can act on, and rethrow something
            // that is safe to show if it ever escapes to a page.
            Logger::critical('Database connection failed', array(
                'host'     => isset($cfg['host']) ? $cfg['host'] : '',
                'database' => isset($cfg['database']) ? $cfg['database'] : '',
                'driver'   => $e->getMessage(),
            ));
            throw new Exception('The database is not reachable right now.');
        }
    }

    /**
     * Close the connection. Called at the end of a request and by
     * install.php between steps.
     *
     * @return void
     */
    public static function disconnect()
    {
        self::$pdo = null;
    }

    // -----------------------------------------------------------------
    // Running statements
    // -----------------------------------------------------------------

    /**
     * Prepare, bind and execute. The engine under every other helper.
     *
     * @param string $sql      With named placeholders, e.g. :verse_id
     * @param array  $bindings Placeholder name (with or without the colon)
     *                         to value.
     * @return PDOStatement
     * @throws Exception
     */
    public static function run($sql, array $bindings = array())
    {
        $pdo   = self::pdo();
        $start = microtime(true);

        try {
            $stmt = $pdo->prepare($sql);
            foreach ($bindings as $key => $value) {
                $param = is_int($key) ? $key + 1 : ':' . ltrim((string) $key, ':');
                $stmt->bindValue($param, $value, self::typeOf($value));
            }
            $stmt->execute();
        } catch (PDOException $e) {
            // The SQL is logged because it comes from our own code and is
            // useful. The BINDINGS ARE NOT, because they are user input and
            // may hold a password or a note somebody wrote.
            Logger::error('Query failed', array(
                'sql'    => $sql,
                'driver' => $e->getMessage(),
            ));
            throw new Exception('That database operation could not be completed.');
        }

        $elapsed = (microtime(true) - $start) * 1000;
        self::$queryCount++;
        self::$queryMs += $elapsed;

        $slow = (float) Config::get('app.performance.slow_query_ms', 300);
        if ($elapsed > $slow) {
            Logger::warning('Slow query', array('ms' => round($elapsed, 1), 'sql' => $sql));
        }

        return $stmt;
    }

    /**
     * All matching rows.
     *
     * @return array<int,array<string,mixed>>
     */
    public static function select($sql, array $bindings = array())
    {
        return self::run($sql, $bindings)->fetchAll(PDO::FETCH_ASSOC);
    }

    /**
     * The first matching row, or null.
     *
     * @return array<string,mixed>|null
     */
    public static function selectOne($sql, array $bindings = array())
    {
        $row = self::run($sql, $bindings)->fetch(PDO::FETCH_ASSOC);
        return $row === false ? null : $row;
    }

    /**
     * The first column of the first row, or null. For COUNT(*) and friends.
     *
     * @return mixed
     */
    public static function scalar($sql, array $bindings = array())
    {
        $value = self::run($sql, $bindings)->fetchColumn(0);
        return $value === false ? null : $value;
    }

    /**
     * Run a statement and report how many rows it touched.
     *
     * @return int
     */
    public static function execute($sql, array $bindings = array())
    {
        return self::run($sql, $bindings)->rowCount();
    }

    /**
     * Insert one row from an associative array and return its new id.
     *
     * Column names come from our own code, never from a request. They are
     * still checked against a strict pattern, because "never" has a way of
     * becoming "almost never" three years into a project.
     *
     * @param string $table
     * @param array  $data Column => value
     * @return int
     * @throws Exception
     */
    public static function insert($table, array $data)
    {
        $table   = self::identifier($table);
        $columns = array();
        $holders = array();
        $binds   = array();

        foreach ($data as $column => $value) {
            $safe            = self::identifier($column);
            $columns[]       = '`' . $safe . '`';
            $holders[]       = ':' . $safe;
            $binds[':' . $safe] = $value;
        }

        if ($columns === array()) {
            throw new Exception('Nothing to insert.');
        }

        $sql = 'INSERT INTO `' . self::$prefix . $table . '` ('
             . implode(', ', $columns) . ') VALUES (' . implode(', ', $holders) . ')';

        self::run($sql, $binds);
        return (int) self::pdo()->lastInsertId();
    }

    /**
     * Update rows matching a WHERE clause.
     *
     * $where is a fragment written by us, with its own placeholders, e.g.
     * 'id = :id AND user_id = :user_id'. It is never assembled from
     * request data.
     *
     * @param string $table
     * @param array  $data        Column => new value
     * @param string $where       SQL fragment with placeholders
     * @param array  $whereBinds  Values for those placeholders
     * @return int Rows affected
     * @throws Exception
     */
    public static function update($table, array $data, $where, array $whereBinds = array())
    {
        $table = self::identifier($table);
        $sets  = array();
        $binds = array();

        foreach ($data as $column => $value) {
            $safe = self::identifier($column);
            // The bound name is prefixed so a column called "id" cannot
            // collide with an :id in the WHERE clause.
            $sets[]                 = '`' . $safe . '` = :set_' . $safe;
            $binds[':set_' . $safe] = $value;
        }

        if ($sets === array()) {
            return 0;
        }
        if (trim((string) $where) === '') {
            // An UPDATE with no WHERE rewrites the whole table. Never allow
            // it by accident. Pass '1 = 1' deliberately if you really mean
            // every row.
            throw new Exception('Refusing to update every row: no WHERE clause given.');
        }

        foreach ($whereBinds as $key => $value) {
            $binds[':' . ltrim((string) $key, ':')] = $value;
        }

        $sql = 'UPDATE `' . self::$prefix . $table . '` SET ' . implode(', ', $sets) . ' WHERE ' . $where;
        return self::execute($sql, $binds);
    }

    /**
     * Delete rows matching a WHERE clause. Same protection as update().
     *
     * @return int Rows affected
     * @throws Exception
     */
    public static function delete($table, $where, array $whereBinds = array())
    {
        $table = self::identifier($table);
        if (trim((string) $where) === '') {
            throw new Exception('Refusing to delete every row: no WHERE clause given.');
        }
        $binds = array();
        foreach ($whereBinds as $key => $value) {
            $binds[':' . ltrim((string) $key, ':')] = $value;
        }
        return self::execute('DELETE FROM `' . self::$prefix . $table . '` WHERE ' . $where, $binds);
    }

    // -----------------------------------------------------------------
    // Transactions
    // -----------------------------------------------------------------

    /**
     * Run a closure inside a transaction. Commits on a clean return, rolls
     * back on any exception, then rethrows so the caller still knows.
     *
     * This is how the anonymous-to-registered merge and the CSV import
     * stay all-or-nothing. A half-merged guest account is worse than a
     * failed merge, because the learner sees some of their notes and
     * assumes the rest are gone.
     *
     * @param callable $work Receives no arguments.
     * @return mixed Whatever $work returned.
     * @throws Exception
     */
    public static function transaction($work)
    {
        $pdo = self::pdo();

        // MySQL does not nest transactions. If one is already open, just
        // run the work inside it rather than silently committing the outer
        // one early.
        if ($pdo->inTransaction()) {
            return call_user_func($work);
        }

        $pdo->beginTransaction();
        try {
            $result = call_user_func($work);
            $pdo->commit();
            return $result;
        } catch (Exception $e) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            Logger::error('Transaction rolled back', array('reason' => $e->getMessage()));
            throw $e;
        }
    }

    // -----------------------------------------------------------------
    // Small helpers
    // -----------------------------------------------------------------

    /**
     * Check a table or column name and hand it back.
     *
     * Identifiers cannot be bound as parameters — SQL does not allow it —
     * so the only safe approach is to accept nothing but letters, digits
     * and underscores. Anything else is refused rather than escaped.
     *
     * @param string $name
     * @return string
     * @throws Exception
     */
    public static function identifier($name)
    {
        $name = (string) $name;
        if (preg_match('/^[A-Za-z_][A-Za-z0-9_]*$/', $name) !== 1) {
            throw new Exception('Refusing an unsafe table or column name.');
        }
        return $name;
    }

    /**
     * Map a PHP value to the right PDO type, so integers bind as integers
     * and nulls bind as NULL rather than as the string "".
     *
     * @param mixed $value
     * @return int
     */
    private static function typeOf($value)
    {
        if ($value === null)  { return PDO::PARAM_NULL; }
        if (is_int($value))   { return PDO::PARAM_INT; }
        if (is_bool($value))  { return PDO::PARAM_BOOL; }
        return PDO::PARAM_STR;
    }

    /**
     * Build "(:in_0, :in_1, :in_2)" plus its bindings for an IN clause,
     * since PDO cannot bind a list to a single placeholder.
     *
     * Usage:
     *   list($sql, $binds) = Database::inClause($ids, 'verse');
     *   Database::select('SELECT * FROM verses WHERE id IN ' . $sql, $binds);
     *
     * @param array  $values
     * @param string $prefix Unique per clause when a query has two of them.
     * @return array{0:string,1:array}
     */
    public static function inClause(array $values, $prefix = 'in')
    {
        if ($values === array()) {
            // An empty IN () is a syntax error in MySQL. "IN (NULL)"
            // matches nothing, which is the sane meaning of an empty list.
            return array('(NULL)', array());
        }

        $holders = array();
        $binds   = array();
        $i       = 0;
        foreach ($values as $value) {
            $name           = ':' . $prefix . '_' . $i;
            $holders[]      = $name;
            $binds[$name]   = $value;
            $i++;
        }
        return array('(' . implode(', ', $holders) . ')', $binds);
    }

    /**
     * Diagnostics for the debug bar and the admin dashboard.
     *
     * @return array{queries:int,ms:float}
     */
    public static function stats()
    {
        return array('queries' => self::$queryCount, 'ms' => round(self::$queryMs, 2));
    }
}
