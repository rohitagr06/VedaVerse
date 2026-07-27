<?php
/**
 * VedaVerse — app/repositories/Repository.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   The base class every repository extends. Wraps Database so a
 *   subclass writes $this->select(...) instead of naming the Database
 *   class in fifty places.
 *
 * WHAT A REPOSITORY IS FOR
 *   SQL lives here and nowhere else. Not in controllers, not in
 *   services, not in views. That one rule is what makes a later move to
 *   a different database, or to Laravel, or to a VPS with Redis in front,
 *   a job that touches the outer layers only.
 *
 * WHAT A REPOSITORY IS NOT FOR
 *   Business rules. A repository answers "give me this row" and "write
 *   this row". Whether a learner is ALLOWED to see that row, or what
 *   should happen when they master it, belongs in a service. When those
 *   two get mixed, the rules become impossible to test without a
 *   database and impossible to find when they are wrong.
 *
 * THE NON-NEGOTIABLE
 *   Every value that came from a request goes in as a bound parameter.
 *   Never build SQL by joining strings, not even for an integer, not even
 *   in admin. Column and table names — which cannot be bound, because SQL
 *   does not allow it — go through Database::identifier(), which refuses
 *   anything but letters, digits and underscores.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Repositories;

use VedaVerse\Core\Database;

abstract class Repository
{
    /**
     * The table this repository owns. Subclasses set it.
     *
     * @var string
     */
    protected $table = '';

    /**
     * Columns that are safe to accept from a caller when building a
     * filtered query. An allow-list, because the alternative is deciding
     * at each call site and getting it wrong once.
     *
     * @var array<int,string>
     */
    protected $sortable = array('id');

    // -----------------------------------------------------------------
    // Thin wrappers around Database
    // -----------------------------------------------------------------

    /**
     * @param string $sql
     * @param array  $bindings
     * @return array<int,array<string,mixed>>
     */
    protected function select($sql, array $bindings = array())
    {
        return Database::select($sql, $bindings);
    }

    /**
     * @param string $sql
     * @param array  $bindings
     * @return array<string,mixed>|null
     */
    protected function selectOne($sql, array $bindings = array())
    {
        return Database::selectOne($sql, $bindings);
    }

    /**
     * @param string $sql
     * @param array  $bindings
     * @return mixed
     */
    protected function scalar($sql, array $bindings = array())
    {
        return Database::scalar($sql, $bindings);
    }

    /**
     * @param string $sql
     * @param array  $bindings
     * @return int Rows affected
     */
    protected function execute($sql, array $bindings = array())
    {
        return Database::execute($sql, $bindings);
    }

    /**
     * @param array $data
     * @return int New id
     */
    protected function insertRow(array $data)
    {
        return Database::insert($this->table, $data);
    }

    /**
     * @param array  $data
     * @param string $where
     * @param array  $bindings
     * @return int Rows affected
     */
    protected function updateRows(array $data, $where, array $bindings = array())
    {
        return Database::update($this->table, $data, $where, $bindings);
    }

    /**
     * @param string $where
     * @param array  $bindings
     * @return int Rows affected
     */
    protected function deleteRows($where, array $bindings = array())
    {
        return Database::delete($this->table, $where, $bindings);
    }

    /**
     * Run a closure inside a transaction.
     *
     * @param callable $work
     * @return mixed
     */
    protected function transaction($work)
    {
        return Database::transaction($work);
    }

    // -----------------------------------------------------------------
    // Common shapes
    // -----------------------------------------------------------------

    /**
     * One row by primary key.
     *
     * @param int   $id
     * @param string $columns Never '*'. Naming columns keeps a later
     *                        schema addition from silently bloating every
     *                        query that already existed.
     * @return array<string,mixed>|null
     */
    public function find($id, $columns = 'id')
    {
        return $this->selectOne(
            'SELECT ' . $this->columns($columns) . ' FROM `' . Database::identifier($this->table) . '` WHERE id = :id LIMIT 1',
            array('id' => (int) $id)
        );
    }

    /**
     * @return int
     */
    public function count()
    {
        return (int) $this->scalar('SELECT COUNT(*) FROM `' . Database::identifier($this->table) . '`');
    }

    /**
     * Check a caller-supplied sort column against the allow-list.
     *
     * ORDER BY cannot take a bound parameter, so a column name arriving
     * from a query string is the one place a repository is tempted to
     * concatenate. This is the answer: if it is not on the list, it is
     * not used.
     *
     * @param string|null $column
     * @param string      $default
     * @return string
     */
    protected function safeSort($column, $default = 'id')
    {
        return in_array((string) $column, $this->sortable, true) ? (string) $column : $default;
    }

    /**
     * ASC or DESC, and nothing else.
     *
     * @param string|null $direction
     * @return string
     */
    protected function safeDirection($direction)
    {
        return strtoupper((string) $direction) === 'ASC' ? 'ASC' : 'DESC';
    }

    /**
     * Validate a comma-separated column list.
     *
     * @param string $columns
     * @return string
     */
    protected function columns($columns)
    {
        $out = array();
        foreach (explode(',', (string) $columns) as $column) {
            $column = trim($column);
            if ($column === '') {
                continue;
            }
            $out[] = '`' . Database::identifier($column) . '`';
        }
        return $out === array() ? '`id`' : implode(', ', $out);
    }

    /**
     * A LIMIT clause built from integers.
     *
     * MySQL will not accept a bound parameter in LIMIT when prepared
     * statements are real rather than emulated, so the values are cast to
     * int here — which is safe precisely because a cast to int cannot
     * carry SQL — and clamped so a caller cannot ask for a million rows.
     *
     * @param int $limit
     * @param int $offset
     * @param int $max
     * @return string
     */
    protected function limit($limit, $offset = 0, $max = 200)
    {
        $limit  = max(1, min((int) $limit, (int) $max));
        $offset = max(0, (int) $offset);

        return ' LIMIT ' . $limit . ' OFFSET ' . $offset;
    }
}
