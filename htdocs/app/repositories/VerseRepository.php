<?php
/**
 * VedaVerse — app/repositories/VerseRepository.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Every query about verses and the eight tables that hang off them —
 *   word meanings, explanations, commentaries, modern examples, memory
 *   aids, reflections, practices, cross-references.
 *
 * WHAT DEPENDS ON IT
 *   ContentService assembles a verse page from these. SearchService will
 *   use the FULLTEXT methods in Step 8. Nothing else touches these
 *   tables.
 *
 * WHY THE PARTS ARE SEPARATE METHODS RATHER THAN ONE BIG JOIN
 *   A verse has up to twelve word meanings, three explanation levels,
 *   three commentaries, twelve examples, five reflections. Joining them
 *   in one query produces the Cartesian product of all of those — well
 *   over a thousand rows to render one page, every one of them carrying
 *   a full copy of the verse's TEXT columns. Nine small indexed queries
 *   are faster, and each one is legible.
 *
 *   ContentService::verse() is what calls them together. A caller that
 *   only needs the verse itself pays for only that.
 *
 * THE approved FILTER ON EXAMPLES
 *   modern_examples.approved gates AI-generated material. Nothing
 *   written by a machine reaches a reader until a person has said yes.
 *   The filter is here, in the query, and not in the template — a
 *   template that forgets it is a template that publishes unreviewed
 *   text, and templates get copied.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Repositories;

class VerseRepository extends Repository
{
    /** @var string */
    protected $table = 'verses';

    /** @var array<int,string> */
    protected $sortable = array('verse_number', 'global_order', 'difficulty');

    /**
     * Columns for a listing — everything except the long-form TEXT.
     * A chapter page renders up to seventy of these.
     *
     * @var string
     */
    private $listColumns = 'v.id, v.chapter_id, v.verse_number, v.global_order,
                            v.is_curated, v.slug, v.difficulty,
                            v.sanskrit_devanagari, v.transliteration_simple,
                            v.summary_en, v.summary_hi, v.summary_hinglish';

    // -----------------------------------------------------------------
    // The verse itself
    // -----------------------------------------------------------------

    /**
     * One verse by chapter and verse number — the pair a reader
     * actually knows. /chapter/2/verse/47, not a database id.
     *
     * @param int $chapterNumber
     * @param int $verseNumber
     * @return array<string,mixed>|null
     */
    public function byReference($chapterNumber, $verseNumber)
    {
        return $this->selectOne(
            'SELECT v.*, c.chapter_number, c.sanskrit_name AS chapter_sanskrit,
                    c.title_en AS chapter_title_en,
                    c.title_hi AS chapter_title_hi,
                    c.title_hinglish AS chapter_title_hinglish
               FROM verses v
               JOIN chapters c ON c.id = v.chapter_id
              WHERE c.chapter_number = :c
                AND v.verse_number = :v
                AND v.published = 1
                AND c.published = 1
              LIMIT 1',
            array('c' => (int) $chapterNumber, 'v' => (int) $verseNumber)
        );
    }

    /**
     * One verse by slug, for the SEO-friendly address.
     *
     * @param string $slug
     * @return array<string,mixed>|null
     */
    public function bySlug($slug)
    {
        return $this->selectOne(
            'SELECT v.*, c.chapter_number
               FROM verses v
               JOIN chapters c ON c.id = v.chapter_id
              WHERE v.slug = :slug AND v.published = 1 AND c.published = 1
              LIMIT 1',
            array('slug' => (string) $slug)
        );
    }

    /**
     * Every published verse in a chapter, in order.
     *
     * @param int  $chapterId
     * @param bool $curatedOnly When true, only verses that are fully written.
     * @return array<int,array<string,mixed>>
     */
    public function inChapter($chapterId, $curatedOnly = false)
    {
        $sql = 'SELECT ' . $this->listColumns . '
                  FROM verses v
                 WHERE v.chapter_id = :id AND v.published = 1';

        if ($curatedOnly) {
            $sql .= ' AND v.is_curated = 1';
        }

        $sql .= ' ORDER BY v.verse_number ASC';

        return $this->select($sql, array('id' => (int) $chapterId));
    }

    /**
     * The verse before and after this one, across chapter boundaries.
     *
     * global_order rather than verse_number, so the last verse of
     * chapter 2 leads to the first of chapter 3 instead of dead-ending.
     * Only curated verses are offered — walking a reader into a bare
     * Sanskrit stub with no explanation is worse than stopping.
     *
     * @param int $globalOrder
     * @return array{previous:array|null,next:array|null}
     */
    public function neighbours($globalOrder)
    {
        $order = (int) $globalOrder;

        $columns = 'v.verse_number, v.slug, c.chapter_number';

        $previous = $this->selectOne(
            'SELECT ' . $columns . '
               FROM verses v JOIN chapters c ON c.id = v.chapter_id
              WHERE v.global_order < :o AND v.published = 1 AND v.is_curated = 1 AND c.published = 1
              ORDER BY v.global_order DESC LIMIT 1',
            array('o' => $order)
        );

        $next = $this->selectOne(
            'SELECT ' . $columns . '
               FROM verses v JOIN chapters c ON c.id = v.chapter_id
              WHERE v.global_order > :o AND v.published = 1 AND v.is_curated = 1 AND c.published = 1
              ORDER BY v.global_order ASC LIMIT 1',
            array('o' => $order)
        );

        return array('previous' => $previous, 'next' => $next);
    }

    /**
     * A deterministic verse of the day.
     *
     * Deterministic, not random: everybody who opens the site on the
     * same day sees the same verse, which is what makes it worth
     * talking about. Driven by the day number so it needs no stored
     * state and no cron.
     *
     * @param int $daySeed Days since the epoch, or any stable integer.
     * @return array<string,mixed>|null
     */
    public function daily($daySeed)
    {
        $total = (int) $this->scalar(
            'SELECT COUNT(*) FROM verses WHERE published = 1 AND is_curated = 1'
        );

        if ($total === 0) {
            return null;
        }

        $offset = ((int) $daySeed) % $total;

        // LIMIT/OFFSET cannot be bound as parameters in MySQL, so the
        // value is cast to int and the modulo above bounds it to the row
        // count. Nothing here comes from a request.
        return $this->selectOne(
            'SELECT v.*, c.chapter_number
               FROM verses v JOIN chapters c ON c.id = v.chapter_id
              WHERE v.published = 1 AND v.is_curated = 1 AND c.published = 1
              ORDER BY v.global_order ASC
              LIMIT 1 OFFSET ' . (int) $offset
        );
    }

    /**
     * @return int
     */
    public function curatedTotal()
    {
        return (int) $this->scalar(
            'SELECT COUNT(*) FROM verses WHERE published = 1 AND is_curated = 1'
        );
    }

    // -----------------------------------------------------------------
    // The parts of a verse
    // -----------------------------------------------------------------

    /**
     * @param int $verseId
     * @return array<int,array<string,mixed>>
     */
    public function wordMeanings($verseId)
    {
        return $this->select(
            'SELECT * FROM verse_word_meanings WHERE verse_id = :id ORDER BY word_order ASC',
            array('id' => (int) $verseId)
        );
    }

    /**
     * The explanation at one depth.
     *
     * @param int    $verseId
     * @param string $level beginner | intermediate | advanced
     * @return array<string,mixed>|null
     */
    public function explanation($verseId, $level)
    {
        $allowed = array('beginner', 'intermediate', 'advanced');
        if (!in_array($level, $allowed, true)) {
            $level = 'beginner';
        }

        return $this->selectOne(
            'SELECT * FROM verse_explanations WHERE verse_id = :id AND level = :lvl LIMIT 1',
            array('id' => (int) $verseId, 'lvl' => $level)
        );
    }

    /**
     * Which depths exist for this verse, so the level switcher offers
     * only the ones that will actually show something.
     *
     * @param int $verseId
     * @return array<int,string>
     */
    public function explanationLevels($verseId)
    {
        $rows = $this->select(
            'SELECT level FROM verse_explanations WHERE verse_id = :id',
            array('id' => (int) $verseId)
        );

        $levels = array();
        foreach ($rows as $row) {
            $levels[] = (string) $row['level'];
        }

        return $levels;
    }

    /**
     * Traditional viewpoints, in the order an editor set.
     *
     * Never re-ordered by any measure of importance — the schema's
     * sort_order is editorial sequencing, not ranking, and presenting
     * one school above another is exactly what this product does not do.
     *
     * @param int $verseId
     * @return array<int,array<string,mixed>>
     */
    public function commentaries($verseId)
    {
        return $this->select(
            'SELECT * FROM verse_commentaries WHERE verse_id = :id ORDER BY sort_order ASC, id ASC',
            array('id' => (int) $verseId)
        );
    }

    /**
     * Modern examples, approved ones only.
     *
     * @param int         $verseId
     * @param string|null $category Optional filter.
     * @return array<int,array<string,mixed>>
     */
    public function examples($verseId, $category = null)
    {
        $bindings = array('id' => (int) $verseId);
        $sql      = 'SELECT * FROM modern_examples WHERE verse_id = :id AND approved = 1';

        if ($category !== null && $category !== '') {
            $sql .= ' AND category = :cat';
            $bindings['cat'] = (string) $category;
        }

        $sql .= ' ORDER BY sort_order ASC, id ASC';

        return $this->select($sql, $bindings);
    }

    /**
     * Which categories this verse has approved examples in, so the
     * filter chips offer only categories that will return something.
     *
     * @param int $verseId
     * @return array<int,string>
     */
    public function exampleCategories($verseId)
    {
        $rows = $this->select(
            'SELECT category, COUNT(*) AS n
               FROM modern_examples
              WHERE verse_id = :id AND approved = 1
              GROUP BY category
              ORDER BY n DESC, category ASC',
            array('id' => (int) $verseId)
        );

        $categories = array();
        foreach ($rows as $row) {
            $categories[] = (string) $row['category'];
        }

        return $categories;
    }

    /**
     * @param int $verseId
     * @return array<string,mixed>|null
     */
    public function memoryAid($verseId)
    {
        return $this->selectOne(
            'SELECT * FROM verse_memory_aids WHERE verse_id = :id LIMIT 1',
            array('id' => (int) $verseId)
        );
    }

    /**
     * @param int $verseId
     * @return array<int,array<string,mixed>>
     */
    public function reflections($verseId)
    {
        return $this->select(
            'SELECT * FROM verse_reflections WHERE verse_id = :id ORDER BY display_order ASC, id ASC',
            array('id' => (int) $verseId)
        );
    }

    /**
     * @param int $verseId
     * @return array<int,array<string,mixed>>
     */
    public function practices($verseId)
    {
        return $this->select(
            'SELECT * FROM verse_practices WHERE verse_id = :id ORDER BY display_order ASC, id ASC',
            array('id' => (int) $verseId)
        );
    }

    /**
     * Cross-references, with the target verse's address resolved when
     * the reference points inside the Gita — so the template can link it
     * without running a query of its own.
     *
     * @param int $verseId
     * @return array<int,array<string,mixed>>
     */
    public function crossReferences($verseId)
    {
        return $this->select(
            'SELECT x.*,
                    t.verse_number AS target_verse_number,
                    t.slug         AS target_slug,
                    tc.chapter_number AS target_chapter_number
               FROM verse_cross_references x
               LEFT JOIN verses   t  ON t.id  = x.target_verse_id AND t.published = 1
               LEFT JOIN chapters tc ON tc.id = t.chapter_id
              WHERE x.verse_id = :id
              ORDER BY x.sort_order ASC, x.id ASC',
            array('id' => (int) $verseId)
        );
    }

    /**
     * The topics this verse is tagged with, strongest first.
     *
     * @param int $verseId
     * @return array<int,array<string,mixed>>
     */
    public function topics($verseId)
    {
        return $this->select(
            'SELECT t.*, vt.relevance
               FROM verse_topics vt
               JOIN topics t ON t.id = vt.topic_id
              WHERE vt.verse_id = :id AND t.published = 1
              ORDER BY vt.relevance DESC, t.sort_order ASC',
            array('id' => (int) $verseId)
        );
    }
}
