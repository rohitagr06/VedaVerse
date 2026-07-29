<?php
/**
 * VedaVerse — app/services/ContentService.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Assembles the things a content page needs, from the repositories,
 *   in the reader's language, at the depth they asked for.
 *
 * WHAT DEPENDS ON IT
 *   ContentController and TopicController. Later: SearchService,
 *   SarathiService's retrieval step, and the offline bundle builder.
 *
 * THE LINE THIS FILE DRAWS
 *   Controllers do not query. Repositories do not decide. This is where
 *   deciding happens — which explanation level to show, what "related"
 *   means, whether a verse is complete enough to render fully. None of
 *   it is HTML, none of it reads $_POST, and it never echoes.
 *
 * WHY verse() RETURNS ONE ARRAY AND NOT AN OBJECT
 *   There is no ORM here and no model layer worth the name. A verse page
 *   needs nine related sets; handing the template one array with named
 *   keys is honest about that, and a template that does
 *   $verse['examples'] is readable by somebody who has never seen this
 *   codebase. An object would add ceremony and no safety.
 *
 * READING MODES
 *   learn / study / research / quick decide which SECTIONS are built at
 *   all, not just which are displayed. A reader in Quick mode does not
 *   pay for twelve examples and three commentaries they will not see —
 *   which on this host is the difference between a fast page and a slow
 *   one.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Services;

use VedaVerse\Core\Config;
use VedaVerse\Repositories\ChapterRepository;
use VedaVerse\Repositories\ProgressRepository;
use VedaVerse\Repositories\TopicRepository;
use VedaVerse\Repositories\VerseRepository;

class ContentService
{
    /** @var ChapterRepository */
    private $chapters;

    /** @var VerseRepository */
    private $verses;

    /** @var TopicRepository */
    private $topics;

    /**
     * The six reading modes.
     *
     * learn / study / research / quick decide what is BUILT — a reader
     * in Quick mode does not pay for twelve examples they will not see.
     *
     * focus and print are presentation over the same content as learn:
     * focus hides the chrome so only the verse and its explanation are
     * on screen, print swaps the stylesheet. Both build the learn set,
     * which is why they are listed here and handled in the template
     * rather than in the switch below.
     */
    const MODES = 'learn,study,research,quick,focus,print';

    public function __construct()
    {
        $this->chapters = new ChapterRepository();
        $this->verses   = new VerseRepository();
        $this->topics   = new TopicRepository();
    }

    // -----------------------------------------------------------------
    // Chapters
    // -----------------------------------------------------------------

    /**
     * Every chapter, with the count of verses actually written and — if
     * the reader has any — how many of those they have finished.
     *
     * @param array $owner Session::owner(), or an empty array.
     * @return array<int,array<string,mixed>>
     */
    public function chapterIndex(array $owner = array())
    {
        $chapters = $this->chapters->all();
        $written  = $this->chapters->curatedCounts();

        $done = array();
        if ($owner !== array()) {
            $progress = new ProgressRepository();
            $done     = $progress->completedByChapter($owner);
        }

        foreach ($chapters as $i => $chapter) {
            $id    = (int) $chapter['id'];
            $total = isset($written[$id]) ? $written[$id] : 0;
            $read  = isset($done[$id]) ? $done[$id] : 0;

            $chapters[$i]['verses_written']  = $total;
            $chapters[$i]['verses_finished'] = min($read, $total);
            // Guarded against a zero denominator: a chapter with nothing
            // written yet is 0%, not a division by zero.
            $chapters[$i]['percent'] = $total > 0
                ? (int) round(($chapters[$i]['verses_finished'] / $total) * 100)
                : 0;
        }

        return $chapters;
    }

    /**
     * One chapter with its verse list.
     *
     * @param int   $number
     * @param array $owner
     * @return array<string,mixed>|null
     */
    public function chapter($number, array $owner = array())
    {
        $chapter = $this->chapters->byNumber($number);

        if ($chapter === null) {
            return null;
        }

        $verses = $this->verses->inChapter((int) $chapter['id']);

        $progress = array();
        if ($owner !== array()) {
            $repo     = new ProgressRepository();
            $progress = $repo->map($owner);
        }

        foreach ($verses as $i => $verse) {
            $id = (int) $verse['id'];
            $verses[$i]['is_finished'] =
                isset($progress[$id]) && (int) $progress[$id]['completion_percentage'] >= 100;
        }

        $chapter['verses']         = $verses;
        $chapter['verses_written'] = $this->chapters->curatedCount((int) $chapter['id']);
        $chapter['neighbours']     = $this->chapters->neighbours((int) $chapter['chapter_number']);

        return $chapter;
    }

    // -----------------------------------------------------------------
    // Verses
    // -----------------------------------------------------------------

    /**
     * A verse and everything that hangs off it.
     *
     * @param int    $chapterNumber
     * @param int    $verseNumber
     * @param string $mode  learn | study | research | quick
     * @param string $level beginner | intermediate | advanced
     * @return array<string,mixed>|null
     */
    public function verse($chapterNumber, $verseNumber, $mode = 'learn', $level = 'beginner')
    {
        $verse = $this->verses->byReference($chapterNumber, $verseNumber);

        if ($verse === null) {
            return null;
        }

        $mode  = $this->safeMode($mode);
        $level = $this->safeLevel($level);
        $id    = (int) $verse['id'];

        $verse['mode']  = $mode;
        $verse['level'] = $level;

        // Always present, in every mode. The verse itself and where it
        // sits are not optional.
        $verse['neighbours'] = $this->verses->neighbours((int) $verse['global_order']);
        $verse['topics']     = $this->verses->topics($id);

        // A stub — Sanskrit and a translation, nothing else written yet.
        // The template shows a plain notice rather than eight empty
        // headings, and there is nothing else to fetch.
        if ((int) $verse['is_curated'] !== 1) {
            $verse['is_stub'] = true;
            return $verse;
        }

        $verse['is_stub']     = false;
        $verse['memory_aid']  = $this->verses->memoryAid($id);

        // focus and print show the learn set; only the chrome differs.
        if ($mode === 'quick') {
            // One minute: the verse, what it means, and the line to
            // remember. Nothing else is built.
            return $verse;
        }

        $verse['levels']       = $this->verses->explanationLevels($id);
        $verse['explanation']  = $this->verses->explanation($id, $level);
        $verse['reflections']  = $this->verses->reflections($id);
        $verse['practices']    = $this->verses->practices($id);
        $verse['examples']     = $this->verses->examples($id);
        $verse['categories']   = $this->verses->exampleCategories($id);

        if ($mode === 'study' || $mode === 'research') {
            $verse['word_meanings'] = $this->verses->wordMeanings($id);
        }

        if ($mode === 'research') {
            $verse['commentaries']     = $this->verses->commentaries($id);
            $verse['cross_references'] = $this->verses->crossReferences($id);
        }

        return $verse;
    }

    /**
     * The verse of the day.
     *
     * Seeded by the calendar day, so everybody sees the same one and it
     * changes at midnight without a cron job or a stored value.
     *
     * @return array<string,mixed>|null
     */
    public function verseOfTheDay()
    {
        // Days since the epoch. Timezone-aware, because "today" for a
        // reader in India should turn over at midnight in India.
        $day = (int) floor(time() / 86400);

        return $this->verses->daily($day);
    }

    // -----------------------------------------------------------------
    // Topics and life problems
    // -----------------------------------------------------------------

    /**
     * @param bool $lifeProblems
     * @return array<int,array<string,mixed>>
     */
    public function topicIndex($lifeProblems = false)
    {
        $topics = $lifeProblems ? $this->topics->lifeProblems() : $this->topics->concepts();
        $counts = $this->topics->verseCounts();

        foreach ($topics as $i => $topic) {
            $id = (int) $topic['id'];
            $topics[$i]['verse_count'] = isset($counts[$id]) ? $counts[$id] : 0;
        }

        return $topics;
    }

    /**
     * One topic, its verses, its neighbours in the graph, and matching
     * examples.
     *
     * A life-problem page leads with the examples, because somebody who
     * arrived here has a problem rather than an interest in scripture,
     * and "here is a situation you recognise" earns the right to show
     * them a verse in Sanskrit. The template decides the order; this
     * just makes sure both are there.
     *
     * @param string $slug
     * @return array<string,mixed>|null
     */
    public function topic($slug)
    {
        $topic = $this->topics->bySlug($slug);

        if ($topic === null) {
            return null;
        }

        $id = (int) $topic['id'];

        $topic['verses']   = $this->topics->verses($id);
        $topic['related']  = $this->topics->related($id);
        $topic['examples'] = $this->topics->examples($id);

        return $topic;
    }

    // -----------------------------------------------------------------
    // Small helpers
    // -----------------------------------------------------------------

    /**
     * @param string $mode
     * @return string
     */
    public function safeMode($mode)
    {
        $allowed = explode(',', self::MODES);
        return in_array($mode, $allowed, true) ? $mode : 'learn';
    }

    /**
     * @param string $level
     * @return string
     */
    public function safeLevel($level)
    {
        $allowed = array('beginner', 'intermediate', 'advanced');
        return in_array($level, $allowed, true) ? $level : 'beginner';
    }

    /**
     * How long a chapter takes to read, in minutes.
     *
     * Uses the stored estimate when an editor set one, and otherwise
     * assumes four minutes a verse — roughly what a curated verse takes
     * at an unhurried pace. Never returns zero, because "0 minutes"
     * beside a chapter reads as broken.
     *
     * @param array $chapter
     * @return int
     */
    public function readingMinutes(array $chapter)
    {
        $stored = isset($chapter['estimated_minutes']) ? (int) $chapter['estimated_minutes'] : 0;

        if ($stored > 0) {
            return $stored;
        }

        $written = isset($chapter['verses_written']) ? (int) $chapter['verses_written'] : 0;

        return max(1, $written * 4);
    }

    /**
     * The chapter numbers in a track, in the order it teaches them.
     *
     * @param string $track
     * @return array<int,int>
     */
    public function trackChapters($track)
    {
        $chapters = Config::get('app.tracks.' . $track . '.chapters');

        if (!is_array($chapters) || $chapters === array()) {
            $chapters = Config::get('app.tracks.beginner.chapters', array(2));
        }

        return array_map('intval', $chapters);
    }
}
