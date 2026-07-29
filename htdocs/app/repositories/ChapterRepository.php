<?php
/**
 * VedaVerse — app/repositories/ChapterRepository.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Every query about chapters. Nothing else in the application writes
 *   SQL against the chapters table.
 *
 * WHAT DEPENDS ON IT
 *   ContentService, PathService, and the sitemap in Step 14.
 *
 * WHY REPOSITORIES AT ALL
 *   So that "how do we fetch a chapter" has exactly one answer. When the
 *   published filter changes, or a column is renamed, or an index turns
 *   out to be missing, there is one file to open. A controller that
 *   writes its own SELECT is a controller that will still be selecting
 *   unpublished rows a year after somebody fixed it everywhere else.
 *
 * THE published FILTER IS NOT OPTIONAL
 *   Every public read goes through a method that filters on published.
 *   An unpublished chapter is a draft — half-written, possibly wrong
 *   about the scripture, and the whole point of the approval workflow is
 *   that it never reaches a reader. Admin screens in Step 13 get their
 *   own explicitly-named methods rather than a boolean flag on these,
 *   because a flag defaults to the wrong value eventually.
 *
 * LANGUAGE
 *   These return every language column. Choosing between them is
 *   I18nService's job, and a repository that picked one would have to
 *   know the reader — which is exactly the knowledge a repository must
 *   not have.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Repositories;

class ChapterRepository extends Repository
{
    /** @var string */
    protected $table = 'chapters';

    /** @var array<int,string> */
    protected $sortable = array('chapter_number', 'sort_order', 'difficulty');

    /**
     * The columns a listing needs. Deliberately not `*`: the summary
     * columns are TEXT, and pulling eighteen of them to render a grid of
     * titles is wasted bytes on a host that counts them.
     *
     * @var string
     */
    private $listColumns = 'id, chapter_number, sanskrit_name, transliteration,
                            title_en, title_hi, title_hinglish,
                            subtitle_en, subtitle_hi, subtitle_hinglish,
                            theme, difficulty, estimated_minutes, verse_count,
                            cover_slug, sort_order';

    /**
     * Every published chapter, in reading order.
     *
     * @return array<int,array<string,mixed>>
     */
    public function all()
    {
        return $this->select(
            'SELECT ' . $this->listColumns . '
               FROM chapters
              WHERE published = 1
              ORDER BY sort_order ASC, chapter_number ASC'
        );
    }

    /**
     * One chapter by its number — 1 to 18 — which is what appears in the
     * URL, because /chapter/2 is a readable address and /chapter/17 is
     * not the same thing as chapter id 17.
     *
     * @param int $number
     * @return array<string,mixed>|null
     */
    public function byNumber($number)
    {
        return $this->selectOne(
            'SELECT * FROM chapters WHERE chapter_number = :n AND published = 1 LIMIT 1',
            array('n' => (int) $number)
        );
    }

    /**
     * One chapter by primary key, published only.
     *
     * @param int $id
     * @return array<string,mixed>|null
     */
    public function published($id)
    {
        return $this->selectOne(
            'SELECT * FROM chapters WHERE id = :id AND published = 1 LIMIT 1',
            array('id' => (int) $id)
        );
    }

    /**
     * The chapters in one track, in reading order.
     *
     * The track lists live in config rather than in the database because
     * they are an editorial decision about pedagogy, not data a reader
     * or an administrator edits. Passing the numbers in keeps this
     * method from having to know what a "track" is.
     *
     * @param array<int,int> $numbers
     * @return array<int,array<string,mixed>>
     */
    public function inTrack(array $numbers)
    {
        $numbers = array_values(array_unique(array_map('intval', $numbers)));

        if ($numbers === array()) {
            return array();
        }

        // IN () cannot take one bound array, so a placeholder is
        // generated per value — :t0, :t1, … — and each is bound
        // separately. The values are cast to int above, so nothing
        // reaches the SQL that did not come through intval().
        $placeholders = array();
        $bindings     = array();

        foreach ($numbers as $i => $number) {
            $placeholders[]   = ':t' . $i;
            $bindings['t' . $i] = $number;
        }

        return $this->select(
            'SELECT ' . $this->listColumns . '
               FROM chapters
              WHERE published = 1
                AND chapter_number IN (' . implode(', ', $placeholders) . ')
              ORDER BY sort_order ASC, chapter_number ASC',
            $bindings
        );
    }

    /**
     * The chapter before and after this one, for the footer links.
     *
     * @param int $number
     * @return array{previous:array|null,next:array|null}
     */
    public function neighbours($number)
    {
        $number = (int) $number;

        $previous = $this->selectOne(
            'SELECT chapter_number, title_en, title_hi, title_hinglish
               FROM chapters
              WHERE published = 1 AND chapter_number < :n
              ORDER BY chapter_number DESC
              LIMIT 1',
            array('n' => $number)
        );

        $next = $this->selectOne(
            'SELECT chapter_number, title_en, title_hi, title_hinglish
               FROM chapters
              WHERE published = 1 AND chapter_number > :n
              ORDER BY chapter_number ASC
              LIMIT 1',
            array('n' => $number)
        );

        return array('previous' => $previous, 'next' => $next);
    }

    /**
     * How many verses in this chapter are actually written.
     *
     * The chapters.verse_count column is the count in the SCRIPTURE —
     * chapter 2 has 72 verses whether we have written them or not. This
     * is the count we can show, which is a different number and the one
     * a progress bar must use. Conflating them puts every learner at
     * 7% forever.
     *
     * @param int $chapterId
     * @return int
     */
    public function curatedCount($chapterId)
    {
        return (int) $this->scalar(
            'SELECT COUNT(*) FROM verses
              WHERE chapter_id = :id AND published = 1 AND is_curated = 1',
            array('id' => (int) $chapterId)
        );
    }

    /**
     * Curated counts for every chapter at once, keyed by chapter id.
     *
     * The chapters index would otherwise run eighteen COUNT queries to
     * draw eighteen progress bars. On shared hosting that is the
     * difference between a fast page and a page that trips the entry
     * process limit under any real traffic.
     *
     * @return array<int,int>
     */
    public function curatedCounts()
    {
        $rows = $this->select(
            'SELECT chapter_id, COUNT(*) AS n
               FROM verses
              WHERE published = 1 AND is_curated = 1
              GROUP BY chapter_id'
        );

        $counts = array();
        foreach ($rows as $row) {
            $counts[(int) $row['chapter_id']] = (int) $row['n'];
        }

        return $counts;
    }
}
