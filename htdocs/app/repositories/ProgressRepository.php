<?php
/**
 * VedaVerse — app/repositories/ProgressRepository.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Reads and writes user_progress: which verses somebody has read, and
 *   how far through a chapter they are.
 *
 * SCOPE IN STEP 5 — READ THIS BEFORE ADDING TO IT
 *   The Chariot Path cannot be drawn without knowing which nodes are
 *   done, so a minimal progress read-and-mark path ships with Step 5.
 *   That is all this is.
 *
 *   XP, levels, streaks, mastery, the SM-2 review schedule and the badge
 *   evaluation are Step 7's ProgressService and SrsService. This
 *   repository deliberately does not touch users.xp, users.streak_current
 *   or user_reviews — if it did, Step 7 would arrive to find half its
 *   job already done inconsistently in a file that was meant to be
 *   temporary.
 *
 *   status here only ever moves to 'learning'. 'mastered' is earned
 *   through a quiz, and quizzes do not exist yet.
 *
 * THE GUEST / MEMBER DUALITY
 *   Every row is tagged with EITHER user_id (signed in) or session_id
 *   (the year-long anonymous token). Never both. Session::owner()
 *   returns the right pair, and every method here takes it whole rather
 *   than guessing — because a query that filters on the wrong one either
 *   shows a reader somebody else's progress or silently shows them none
 *   of their own.
 *
 *   UserRepository::adoptAnonymousData() merges guest rows into an
 *   account at registration and at login. If you add a column here, add
 *   it there too.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Repositories;

use VedaVerse\Core\Database;

class ProgressRepository extends Repository
{
    /** @var string */
    protected $table = 'user_progress';

    /**
     * Build the WHERE fragment and bindings for one owner.
     *
     * Returned as a pair rather than interpolated at each call site, so
     * the guest and member cases cannot drift apart between methods.
     *
     * @param array{user_id:int|null,session_id:string|null} $owner
     * @return array{0:string,1:array}|null Null when there is no identity at all.
     */
    private function ownerClause(array $owner, $prefix = '')
    {
        if (isset($owner['user_id']) && $owner['user_id'] !== null) {
            return array(
                $prefix . 'user_id = :owner_uid',
                array('owner_uid' => (int) $owner['user_id']),
            );
        }

        if (isset($owner['session_id']) && $owner['session_id'] !== null && $owner['session_id'] !== '') {
            return array(
                $prefix . 'session_id = :owner_sid',
                array('owner_sid' => (string) $owner['session_id']),
            );
        }

        // No identity — a request before the session cookie exists.
        // Returning null lets the caller show an empty state rather than
        // running a query that would match every anonymous row ever
        // written.
        return null;
    }

    /**
     * Every verse this owner has any progress on, keyed by verse id.
     *
     * One query for the whole path. The alternative — asking per node —
     * is 108 queries to draw one screen.
     *
     * @param array $owner
     * @return array<int,array<string,mixed>>
     */
    public function map(array $owner)
    {
        $clause = $this->ownerClause($owner);
        if ($clause === null) {
            return array();
        }

        $rows = $this->select(
            'SELECT verse_id, chapter_id, status, completion_percentage, quiz_score, last_read
               FROM user_progress
              WHERE ' . $clause[0],
            $clause[1]
        );

        $map = array();
        foreach ($rows as $row) {
            $map[(int) $row['verse_id']] = $row;
        }

        return $map;
    }

    /**
     * Progress on one verse.
     *
     * @param array $owner
     * @param int   $verseId
     * @return array<string,mixed>|null
     */
    public function forVerse(array $owner, $verseId)
    {
        $clause = $this->ownerClause($owner);
        if ($clause === null) {
            return null;
        }

        $bindings = array_merge($clause[1], array('vid' => (int) $verseId));

        return $this->selectOne(
            'SELECT * FROM user_progress WHERE ' . $clause[0] . ' AND verse_id = :vid LIMIT 1',
            $bindings
        );
    }

    /**
     * Record that somebody has read a verse.
     *
     * Idempotent: reading the same verse twice does not create a second
     * row and does not reset anything. completion_percentage only ever
     * moves up, so re-opening a verse already marked complete cannot
     * quietly undo it.
     *
     * @param array $owner
     * @param int   $verseId
     * @param int   $chapterId
     * @param int   $percentage
     * @return bool
     */
    public function markRead(array $owner, $verseId, $chapterId, $percentage = 100)
    {
        $userId    = isset($owner['user_id']) ? $owner['user_id'] : null;
        $sessionId = isset($owner['session_id']) ? $owner['session_id'] : null;

        if ($userId === null && ($sessionId === null || $sessionId === '')) {
            return false;
        }

        $percentage = max(0, min(100, (int) $percentage));

        // The unique key is (user_id, verse_id), which MySQL treats as
        // non-matching whenever user_id is NULL — so ON DUPLICATE KEY
        // does not deduplicate for guests. Hence the explicit
        // read-then-write. Two guests racing on the same verse would at
        // worst leave two rows, and the read path takes the first, so
        // nothing a learner sees is wrong.
        $existing = $this->forVerse($owner, $verseId);

        if ($existing !== null) {
            return $this->execute(
                'UPDATE user_progress
                    SET completion_percentage = GREATEST(completion_percentage, :pct),
                        status = CASE WHEN status = :mastered THEN status ELSE :learning END,
                        last_read = NOW()
                  WHERE id = :id',
                array(
                    'pct'      => $percentage,
                    'mastered' => 'mastered',
                    'learning' => 'learning',
                    'id'       => (int) $existing['id'],
                )
            ) >= 0;
        }

        return $this->execute(
            'INSERT INTO user_progress
                (user_id, session_id, verse_id, chapter_id, status, completion_percentage, last_read)
             VALUES
                (:uid, :sid, :vid, :cid, :status, :pct, NOW())',
            array(
                'uid'    => $userId === null ? null : (int) $userId,
                'sid'    => $userId === null ? (string) $sessionId : null,
                'vid'    => (int) $verseId,
                'cid'    => (int) $chapterId,
                'status' => 'learning',
                'pct'    => $percentage,
            )
        ) > 0;
    }

    /**
     * How many verses in each chapter this owner has finished, keyed by
     * chapter id.
     *
     * @param array $owner
     * @return array<int,int>
     */
    public function completedByChapter(array $owner)
    {
        $clause = $this->ownerClause($owner);
        if ($clause === null) {
            return array();
        }

        $rows = $this->select(
            'SELECT chapter_id, COUNT(*) AS n
               FROM user_progress
              WHERE ' . $clause[0] . '
                AND completion_percentage >= 100
              GROUP BY chapter_id',
            $clause[1]
        );

        $counts = array();
        foreach ($rows as $row) {
            $counts[(int) $row['chapter_id']] = (int) $row['n'];
        }

        return $counts;
    }

    /**
     * The verse this owner should carry on from: the one after the
     * furthest they have finished.
     *
     * Returns null for somebody who has read nothing, and the caller
     * shows "begin at chapter 2" instead — which is the right first
     * screen, and the reason chapter 2 is the entry point rather than
     * chapter 1.
     *
     * @param array $owner
     * @return array<string,mixed>|null
     */
    public function resumePoint(array $owner)
    {
        $clause = $this->ownerClause($owner, 'p.');
        if ($clause === null) {
            return null;
        }

        $furthest = $this->scalar(
            'SELECT MAX(v.global_order)
               FROM user_progress p
               JOIN verses v ON v.id = p.verse_id
              WHERE ' . $clause[0] . '
                AND p.completion_percentage >= 100',
            $clause[1]
        );

        if ($furthest === null || $furthest === false) {
            return null;
        }

        return $this->selectOne(
            'SELECT v.verse_number, v.slug, c.chapter_number
               FROM verses v JOIN chapters c ON c.id = v.chapter_id
              WHERE v.global_order > :o
                AND v.published = 1 AND v.is_curated = 1 AND c.published = 1
              ORDER BY v.global_order ASC
              LIMIT 1',
            array('o' => (int) $furthest)
        );
    }

    /**
     * Total verses finished. Used on the profile tile.
     *
     * @param array $owner
     * @return int
     */
    public function completedTotal(array $owner)
    {
        $clause = $this->ownerClause($owner);
        if ($clause === null) {
            return 0;
        }

        return (int) $this->scalar(
            'SELECT COUNT(*) FROM user_progress
              WHERE ' . $clause[0] . ' AND completion_percentage >= 100',
            $clause[1]
        );
    }

    /**
     * Note that a verse was opened, for "you were reading".
     *
     * Best effort. A failure here must never cost somebody their page —
     * this is a convenience list, not their work.
     *
     * @param array $owner
     * @param int   $verseId
     * @return void
     */
    public function recordView(array $owner, $verseId)
    {
        $userId    = isset($owner['user_id']) ? $owner['user_id'] : null;
        $sessionId = isset($owner['session_id']) ? $owner['session_id'] : null;

        if ($userId === null && ($sessionId === null || $sessionId === '')) {
            return;
        }

        try {
            $this->execute(
                'INSERT INTO recent_views (user_id, session_id, verse_id, viewed_at)
                 VALUES (:uid, :sid, :vid, NOW())',
                array(
                    'uid' => $userId === null ? null : (int) $userId,
                    'sid' => $userId === null ? (string) $sessionId : null,
                    'vid' => (int) $verseId,
                )
            );
        } catch (\Exception $e) {
            // Swallowed on purpose. See the note above.
        }
    }

    /**
     * The last few verses this owner opened, most recent first and
     * without repeats.
     *
     * @param array $owner
     * @param int   $limit
     * @return array<int,array<string,mixed>>
     */
    public function recentlyViewed(array $owner, $limit = 5)
    {
        $clause = $this->ownerClause($owner, 'r.');
        if ($clause === null) {
            return array();
        }

        return $this->select(
            'SELECT v.verse_number, v.slug, c.chapter_number,
                    v.summary_en, v.summary_hi, v.summary_hinglish,
                    MAX(r.viewed_at) AS viewed_at
               FROM recent_views r
               JOIN verses   v ON v.id = r.verse_id
               JOIN chapters c ON c.id = v.chapter_id
              WHERE ' . $clause[0] . '
                AND v.published = 1 AND c.published = 1
              GROUP BY v.id, v.verse_number, v.slug, c.chapter_number,
                       v.summary_en, v.summary_hi, v.summary_hinglish
              ORDER BY viewed_at DESC
              ' . $this->limit($limit, 0, 20),
            $clause[1]
        );
    }

    /**
     * Trim the recent-views table.
     *
     * There is no cron on this host, so housekeeping happens on
     * ordinary requests. Called from SessionMiddleware at a low
     * probability with a capped row count.
     *
     * @param int $keepDays
     * @param int $max
     * @return void
     */
    public function prune($keepDays = 60, $max = 200)
    {
        try {
            Database::execute(
                'DELETE FROM recent_views
                  WHERE viewed_at < DATE_SUB(NOW(), INTERVAL :d DAY)
                  LIMIT ' . max(1, (int) $max),
                array('d' => max(1, (int) $keepDays))
            );
        } catch (\Exception $e) {
            // Bookkeeping. Never worth an error page.
        }
    }
}
