<?php
/**
 * VedaVerse — app/repositories/BookmarkRepository.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Saved verses, chapters and topics, plus the private note a reader
 *   can attach to a verse.
 *
 * WHY BOOKMARKS AND NOTES ARE IN ONE FILE
 *   They are the same promise: something the reader made, which must
 *   survive. Both are tagged the same way, both merge into an account
 *   the same way, and both are the reason a guest can use this product
 *   for a year without registering. Splitting them would mean writing
 *   the owner clause twice.
 *
 * A NOTE IS PRIVATE. FULL STOP.
 *   notes.content is never shown to anybody but its author, never
 *   moderated, never AI-reviewed, and never included in an export that
 *   goes anywhere except to the person who wrote it. If a future step
 *   wants to read notes in aggregate, that is a decision for the owner
 *   to make explicitly, not something to arrive at by adding a JOIN.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Repositories;

class BookmarkRepository extends Repository
{
    /** @var string */
    protected $table = 'bookmarks';

    /** @var array<int,string> */
    private $types = array('verse', 'chapter', 'topic', 'forum', 'chat');

    /**
     * @param array  $owner
     * @param string $prefix
     * @return array{0:string,1:array}|null
     */
    private function ownerClause(array $owner, $prefix = '')
    {
        if (isset($owner['user_id']) && $owner['user_id'] !== null) {
            return array($prefix . 'user_id = :owner_uid', array('owner_uid' => (int) $owner['user_id']));
        }

        if (isset($owner['session_id']) && $owner['session_id'] !== null && $owner['session_id'] !== '') {
            return array($prefix . 'session_id = :owner_sid', array('owner_sid' => (string) $owner['session_id']));
        }

        return null;
    }

    /**
     * @param string $type
     * @return string
     */
    private function safeType($type)
    {
        return in_array($type, $this->types, true) ? $type : 'verse';
    }

    // -----------------------------------------------------------------
    // Bookmarks
    // -----------------------------------------------------------------

    /**
     * @param array  $owner
     * @param string $type
     * @param int    $targetId
     * @return bool
     */
    public function has(array $owner, $type, $targetId)
    {
        $clause = $this->ownerClause($owner);
        if ($clause === null) {
            return false;
        }

        $bindings = array_merge($clause[1], array(
            'type' => $this->safeType($type),
            'tid'  => (int) $targetId,
        ));

        return (int) $this->scalar(
            'SELECT COUNT(*) FROM bookmarks
              WHERE ' . $clause[0] . ' AND target_type = :type AND target_id = :tid',
            $bindings
        ) > 0;
    }

    /**
     * Save something, or do nothing if it is already saved.
     *
     * @param array  $owner
     * @param string $type
     * @param int    $targetId
     * @return bool
     */
    public function add(array $owner, $type, $targetId)
    {
        $userId    = isset($owner['user_id']) ? $owner['user_id'] : null;
        $sessionId = isset($owner['session_id']) ? $owner['session_id'] : null;

        if ($userId === null && ($sessionId === null || $sessionId === '')) {
            return false;
        }

        if ($this->has($owner, $type, $targetId)) {
            return true;
        }

        return $this->execute(
            'INSERT INTO bookmarks (user_id, session_id, target_type, target_id)
             VALUES (:uid, :sid, :type, :tid)',
            array(
                'uid'  => $userId === null ? null : (int) $userId,
                'sid'  => $userId === null ? (string) $sessionId : null,
                'type' => $this->safeType($type),
                'tid'  => (int) $targetId,
            )
        ) > 0;
    }

    /**
     * @param array  $owner
     * @param string $type
     * @param int    $targetId
     * @return bool
     */
    public function remove(array $owner, $type, $targetId)
    {
        $clause = $this->ownerClause($owner);
        if ($clause === null) {
            return false;
        }

        $bindings = array_merge($clause[1], array(
            'type' => $this->safeType($type),
            'tid'  => (int) $targetId,
        ));

        return $this->execute(
            'DELETE FROM bookmarks
              WHERE ' . $clause[0] . ' AND target_type = :type AND target_id = :tid',
            $bindings
        ) > 0;
    }

    /**
     * Save if not saved, remove if saved. Returns the state afterwards,
     * so the caller can render the button without asking again.
     *
     * @param array  $owner
     * @param string $type
     * @param int    $targetId
     * @return bool True when it is now saved.
     */
    public function toggle(array $owner, $type, $targetId)
    {
        if ($this->has($owner, $type, $targetId)) {
            $this->remove($owner, $type, $targetId);
            return false;
        }

        $this->add($owner, $type, $targetId);
        return true;
    }

    /**
     * Saved verses, newest first, with enough of each to render a card.
     *
     * @param array $owner
     * @param int   $limit
     * @return array<int,array<string,mixed>>
     */
    public function verses(array $owner, $limit = 50)
    {
        $clause = $this->ownerClause($owner, 'b.');
        if ($clause === null) {
            return array();
        }

        return $this->select(
            'SELECT v.id, v.verse_number, v.slug,
                    v.summary_en, v.summary_hi, v.summary_hinglish,
                    v.sanskrit_devanagari,
                    c.chapter_number,
                    b.created_at
               FROM bookmarks b
               JOIN verses   v ON v.id = b.target_id
               JOIN chapters c ON c.id = v.chapter_id
              WHERE ' . $clause[0] . '
                AND b.target_type = :type
                AND v.published = 1 AND c.published = 1
              ORDER BY b.created_at DESC
              ' . $this->limit($limit, 0, 200),
            array_merge($clause[1], array('type' => 'verse'))
        );
    }

    /**
     * The ids of every verse this owner has saved, for marking a list
     * without one query per row.
     *
     * @param array $owner
     * @return array<int,int>
     */
    public function verseIds(array $owner)
    {
        $clause = $this->ownerClause($owner);
        if ($clause === null) {
            return array();
        }

        $rows = $this->select(
            'SELECT target_id FROM bookmarks
              WHERE ' . $clause[0] . ' AND target_type = :type',
            array_merge($clause[1], array('type' => 'verse'))
        );

        $ids = array();
        foreach ($rows as $row) {
            $ids[] = (int) $row['target_id'];
        }

        return $ids;
    }

    /**
     * @param array $owner
     * @return int
     */
    public function total(array $owner)
    {
        $clause = $this->ownerClause($owner);
        if ($clause === null) {
            return 0;
        }

        return (int) $this->scalar(
            'SELECT COUNT(*) FROM bookmarks WHERE ' . $clause[0],
            $clause[1]
        );
    }

    // -----------------------------------------------------------------
    // Notes
    // -----------------------------------------------------------------

    /**
     * The reader's note on one verse.
     *
     * @param array $owner
     * @param int   $verseId
     * @return array<string,mixed>|null
     */
    public function note(array $owner, $verseId)
    {
        $clause = $this->ownerClause($owner);
        if ($clause === null) {
            return null;
        }

        return $this->selectOne(
            'SELECT * FROM notes WHERE ' . $clause[0] . ' AND verse_id = :vid
              ORDER BY updated_at DESC LIMIT 1',
            array_merge($clause[1], array('vid' => (int) $verseId))
        );
    }

    /**
     * Write or replace a note.
     *
     * An empty note deletes the row rather than storing a blank one, so
     * clearing a note actually clears it — a reader who deletes what
     * they wrote should not find an empty box waiting for them with a
     * timestamp on it.
     *
     * @param array  $owner
     * @param int    $verseId
     * @param string $content
     * @return bool
     */
    public function saveNote(array $owner, $verseId, $content)
    {
        $userId    = isset($owner['user_id']) ? $owner['user_id'] : null;
        $sessionId = isset($owner['session_id']) ? $owner['session_id'] : null;

        if ($userId === null && ($sessionId === null || $sessionId === '')) {
            return false;
        }

        $content  = trim((string) $content);
        $existing = $this->note($owner, $verseId);

        if ($content === '') {
            if ($existing !== null) {
                $this->execute('DELETE FROM notes WHERE id = :id', array('id' => (int) $existing['id']));
            }
            return true;
        }

        if ($existing !== null) {
            return $this->execute(
                'UPDATE notes SET content = :c, updated_at = NOW() WHERE id = :id',
                array('c' => $content, 'id' => (int) $existing['id'])
            ) >= 0;
        }

        return $this->execute(
            'INSERT INTO notes (user_id, session_id, verse_id, content, updated_at)
             VALUES (:uid, :sid, :vid, :c, NOW())',
            array(
                'uid' => $userId === null ? null : (int) $userId,
                'sid' => $userId === null ? (string) $sessionId : null,
                'vid' => (int) $verseId,
                'c'   => $content,
            )
        ) > 0;
    }

    /**
     * Every note this owner has written, newest first.
     *
     * @param array $owner
     * @param int   $limit
     * @return array<int,array<string,mixed>>
     */
    public function notes(array $owner, $limit = 50)
    {
        $clause = $this->ownerClause($owner, 'n.');
        if ($clause === null) {
            return array();
        }

        return $this->select(
            'SELECT n.id, n.content, n.updated_at,
                    v.verse_number, v.slug, c.chapter_number
               FROM notes n
               LEFT JOIN verses   v ON v.id = n.verse_id
               LEFT JOIN chapters c ON c.id = v.chapter_id
              WHERE ' . $clause[0] . '
              ORDER BY n.updated_at DESC
              ' . $this->limit($limit, 0, 200),
            $clause[1]
        );
    }
}
