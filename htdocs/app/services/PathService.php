<?php
/**
 * VedaVerse — app/services/PathService.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Builds the Chariot Path: the vertical run of nodes a learner moves
 *   along, with chapter milestones between them and a state on each.
 *
 * WHAT DEPENDS ON IT
 *   PathController, and the home page's "carry on" button.
 *
 * WHY THIS IS A SERVICE AND NOT A QUERY
 *   The path is not a list of verses. It is a list of verses, grouped
 *   into clusters, interleaved with chapter markers, filtered by the
 *   reader's track, with each node's state derived from progress — and
 *   with the current node found by rule rather than stored. None of that
 *   is SQL, and all of it is a decision. Two queries feed it; everything
 *   else here is arithmetic.
 *
 * THE FOUR NODE STATES, AND WHY THE FOURTH IS RARE
 *   done      every verse in the cluster is finished
 *   current   the first cluster that is not done — exactly one per path
 *   ahead     not started, and visible
 *   locked    not started, and beyond the lookahead
 *
 *   'locked' is presentational, not a gate. Every verse on this site is
 *   readable by anybody at any time, including a guest, including one
 *   that appears locked on the path. The dimming exists so a learner
 *   sees that the road is finite, which is the entire argument for a
 *   path over a list. It is not a paywall and it is not a prerequisite.
 *   If a future step makes it one, that is a product decision to take
 *   deliberately, not a side effect of a CSS class name.
 *
 * WHAT IT DOES NOT DO
 *   No XP, no streaks, no badges. Those are Step 7. This reads progress
 *   and draws a road.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Services;

use VedaVerse\Core\Config;
use VedaVerse\Repositories\ChapterRepository;
use VedaVerse\Repositories\ProgressRepository;
use VedaVerse\Repositories\VerseRepository;

class PathService
{
    /** @var ChapterRepository */
    private $chapters;

    /** @var VerseRepository */
    private $verses;

    /** @var ProgressRepository */
    private $progress;

    public function __construct()
    {
        $this->chapters = new ChapterRepository();
        $this->verses   = new VerseRepository();
        $this->progress = new ProgressRepository();
    }

    /**
     * Build the whole path for one reader.
     *
     * Returns a flat list of rows, each either a milestone or a node, in
     * the order they are drawn. Flat rather than nested because the
     * template renders one continuous line down the page — nesting would
     * mean two loops producing one visual sequence, and the connector
     * between a milestone and the node under it would have to be
     * special-cased.
     *
     * @param string $track beginner | intermediate | advanced
     * @param array  $owner Session::owner(), or empty for a fresh visitor.
     * @return array{rows:array,current:array|null,finished:int,total:int}
     */
    public function build($track, array $owner = array())
    {
        $numbers = $this->trackChapters($track);
        $size    = max(1, (int) Config::get('app.path.cluster_size', 4));
        $ahead   = max(1, (int) Config::get('app.path.lookahead', 6));

        $chapters = $this->chapters->inTrack($numbers);

        // inTrack() returns them in chapter order; the track's own order
        // is the teaching order and is what the path must follow.
        $byNumber = array();
        foreach ($chapters as $chapter) {
            $byNumber[(int) $chapter['chapter_number']] = $chapter;
        }

        $done = $owner === array() ? array() : $this->progress->map($owner);

        $rows       = array();
        $total      = 0;
        $finished   = 0;
        $current    = null;
        $nodeIndex  = 0;

        foreach ($numbers as $number) {
            if (!isset($byNumber[$number])) {
                // In the track but not published yet. Skipped silently:
                // a gap in the road is better than a marker leading to a
                // 404.
                continue;
            }

            $chapter = $byNumber[$number];
            $verses  = $this->verses->inChapter((int) $chapter['id'], true);

            if ($verses === array()) {
                continue;
            }

            $rows[] = array(
                'type'    => 'milestone',
                'chapter' => $chapter,
            );

            foreach (array_chunk($verses, $size) as $cluster) {
                $clusterDone = true;

                foreach ($cluster as $verse) {
                    $id = (int) $verse['id'];
                    $total++;

                    $verseDone = isset($done[$id])
                        && (int) $done[$id]['completion_percentage'] >= 100;

                    if ($verseDone) {
                        $finished++;
                    } else {
                        $clusterDone = false;
                    }
                }

                $node = array(
                    'type'    => 'node',
                    'index'   => $nodeIndex,
                    'chapter' => $chapter,
                    'verses'  => $cluster,
                    'state'   => $clusterDone ? 'done' : 'ahead',
                    'first'   => $cluster[0],
                    'label'   => $this->clusterLabel($chapter, $cluster),
                );

                // The first cluster that is not finished is where the
                // reader is. Marked once — everything after it stays
                // 'ahead' even if they have skipped forward and read
                // something further on, because "you are here" has to
                // mean one place.
                if ($current === null && !$clusterDone) {
                    $node['state'] = 'current';
                    $current       = $node;
                }

                $rows[] = $node;
                $nodeIndex++;
            }
        }

        // Anything more than `lookahead` nodes past the current one is
        // dimmed. Done in a second pass because the current node's index
        // is not known until the first pass has finished.
        if ($current !== null) {
            $limit = (int) $current['index'] + $ahead;

            foreach ($rows as $i => $row) {
                if ($row['type'] === 'node'
                    && $row['state'] === 'ahead'
                    && (int) $row['index'] > $limit) {
                    $rows[$i]['state'] = 'locked';
                }
            }
        }

        return array(
            'rows'     => $rows,
            'current'  => $current,
            'finished' => $finished,
            'total'    => $total,
            'percent'  => $total > 0 ? (int) round(($finished / $total) * 100) : 0,
        );
    }

    /**
     * Where a reader should carry on from.
     *
     * The verse after the furthest one they have finished. Null for
     * somebody who has read nothing — the caller then offers chapter 2,
     * which is the entry point.
     *
     * @param array $owner
     * @return array<string,mixed>|null
     */
    public function resumePoint(array $owner)
    {
        if ($owner === array()) {
            return null;
        }

        return $this->progress->resumePoint($owner);
    }

    /**
     * A label for a cluster: "2.11 – 2.14", or "2.47" when it is one
     * verse.
     *
     * Built from the real verse numbers rather than a range, because a
     * chapter's curated verses are not contiguous — chapter 2 has 72
     * verses and eighteen of them are written, so a cluster might be
     * 2.13, 2.14, 2.20, 2.22. Printing "2.13 – 2.22" would claim ten
     * verses that are not there.
     *
     * @param array $chapter
     * @param array $cluster
     * @return string
     */
    private function clusterLabel(array $chapter, array $cluster)
    {
        $number = (int) $chapter['chapter_number'];
        $count  = count($cluster);

        if ($count === 1) {
            return $number . '.' . (int) $cluster[0]['verse_number'];
        }

        $first = (int) $cluster[0]['verse_number'];
        $last  = (int) $cluster[$count - 1]['verse_number'];

        // Contiguous — a range says it more compactly than a list.
        if (($last - $first) === ($count - 1)) {
            return $number . '.' . $first . '–' . $last;
        }

        // Not contiguous. Every reference carries its chapter number:
        // "2.13, 14, 47, 62" reads as one verse and three stray integers,
        // which is exactly how it looked in the first screenshot.
        $parts = array();
        foreach ($cluster as $verse) {
            $parts[] = $number . '.' . (int) $verse['verse_number'];
        }

        return implode(' · ', $parts);
    }

    /**
     * The chapter numbers in a track, falling back to beginner.
     *
     * @param string $track
     * @return array<int,int>
     */
    public function trackChapters($track)
    {
        $allowed = array('beginner', 'intermediate', 'advanced');

        if (!in_array($track, $allowed, true)) {
            $track = (string) Config::get('app.defaults.track', 'beginner');
        }

        $chapters = Config::get('app.tracks.' . $track . '.chapters');

        if (!is_array($chapters) || $chapters === array()) {
            return array((int) Config::get('app.defaults.entry_chapter', 2));
        }

        return array_map('intval', $chapters);
    }
}
