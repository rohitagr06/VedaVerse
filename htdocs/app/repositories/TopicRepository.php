<?php
/**
 * VedaVerse — app/repositories/TopicRepository.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Queries about topics, life problems, and the graph that connects
 *   them.
 *
 * THE DISTINCTION THAT MATTERS
 *   A topic and a life problem are the same table with a flag. But they
 *   are two different doors into the product and they are not
 *   interchangeable:
 *
 *     topics          Concepts that run through the text — karma,
 *                     dharma, detachment. Somebody browsing them has
 *                     already decided to study the book.
 *
 *     life problems   Anger, grief, burnout, comparison. Somebody
 *                     arriving here has a problem, not an interest, and
 *                     has very likely never opened the Gita.
 *
 *   The specification is explicit that life-problem navigation is
 *   often the real front door and must be a first-class surface rather
 *   than a tag page. That is why is_life_problem gets its own methods
 *   here instead of a boolean argument — a caller can see, at the call
 *   site, which door it is serving.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Repositories;

class TopicRepository extends Repository
{
    /** @var string */
    protected $table = 'topics';

    /** @var array<int,string> */
    protected $sortable = array('sort_order', 'name_en');

    /**
     * Concepts — everything that is not flagged a life problem.
     *
     * @return array<int,array<string,mixed>>
     */
    public function concepts()
    {
        return $this->select(
            'SELECT * FROM topics
              WHERE published = 1 AND is_life_problem = 0
              ORDER BY sort_order ASC, name_en ASC'
        );
    }

    /**
     * Life problems — the other front door.
     *
     * @return array<int,array<string,mixed>>
     */
    public function lifeProblems()
    {
        return $this->select(
            'SELECT * FROM topics
              WHERE published = 1 AND is_life_problem = 1
              ORDER BY sort_order ASC, name_en ASC'
        );
    }

    /**
     * @param string $slug
     * @return array<string,mixed>|null
     */
    public function bySlug($slug)
    {
        return $this->selectOne(
            'SELECT * FROM topics WHERE slug = :slug AND published = 1 LIMIT 1',
            array('slug' => (string) $slug)
        );
    }

    /**
     * The verses that address a topic, most relevant first.
     *
     * relevance is an editor's 1-to-10 judgement of how squarely this
     * verse speaks to this topic. It is the ordering on a problem page,
     * and it is the difference between "here are 40 verses mentioning
     * anger" and "here are the three that will actually help".
     *
     * @param int $topicId
     * @param int $limit
     * @return array<int,array<string,mixed>>
     */
    public function verses($topicId, $limit = 20)
    {
        return $this->select(
            'SELECT v.id, v.verse_number, v.slug, v.difficulty,
                    v.sanskrit_devanagari,
                    v.summary_en, v.summary_hi, v.summary_hinglish,
                    v.translation_en, v.translation_hi, v.translation_hinglish,
                    c.chapter_number,
                    vt.relevance
               FROM verse_topics vt
               JOIN verses   v ON v.id = vt.verse_id
               JOIN chapters c ON c.id = v.chapter_id
              WHERE vt.topic_id = :id
                AND v.published = 1 AND v.is_curated = 1 AND c.published = 1
              ORDER BY vt.relevance DESC, v.global_order ASC
              ' . $this->limit($limit),
            array('id' => (int) $topicId)
        );
    }

    /**
     * Related topics from the concept graph.
     *
     * The graph is directional in the schema — "burnout causes
     * exhaustion" is not the same edge as the reverse. For a reader
     * following a trail of ideas, both directions are equally useful,
     * so the two are unioned and the relation type comes back with each
     * row for the template to label.
     *
     * @param int $topicId
     * @param int $limit
     * @return array<int,array<string,mixed>>
     */
    public function related($topicId, $limit = 8)
    {
        return $this->select(
            'SELECT t.*, r.relation_type, r.strength
               FROM topic_relations r
               JOIN topics t ON t.id = r.related_topic_id
              WHERE r.topic_id = :id AND t.published = 1

              UNION

             SELECT t.*, r.relation_type, r.strength
               FROM topic_relations r
               JOIN topics t ON t.id = r.topic_id
              WHERE r.related_topic_id = :id2 AND t.published = 1

              ORDER BY strength DESC, sort_order ASC
              ' . $this->limit($limit),
            // Two names for one value: with EMULATE_PREPARES off, a
            // named placeholder cannot be reused within one statement.
            array('id' => (int) $topicId, 'id2' => (int) $topicId)
        );
    }

    /**
     * Modern examples tagged to the same verses as this topic.
     *
     * A life-problem page is far more persuasive opening with "here is
     * a situation you recognise" than with a verse in Sanskrit. This is
     * what makes that possible.
     *
     * @param int $topicId
     * @param int $limit
     * @return array<int,array<string,mixed>>
     */
    public function examples($topicId, $limit = 6)
    {
        return $this->select(
            'SELECT e.*, v.verse_number, v.slug, c.chapter_number
               FROM verse_topics vt
               JOIN modern_examples e ON e.verse_id = vt.verse_id
               JOIN verses   v ON v.id = e.verse_id
               JOIN chapters c ON c.id = v.chapter_id
              WHERE vt.topic_id = :id
                AND e.approved = 1
                AND v.published = 1 AND c.published = 1
              ORDER BY vt.relevance DESC, e.sort_order ASC
              ' . $this->limit($limit),
            array('id' => (int) $topicId)
        );
    }

    /**
     * How many curated verses each topic has, keyed by topic id.
     *
     * The index pages show a count beside every topic. Without this
     * they would run one query per topic — thirty topics, thirty
     * queries, on a host that counts them.
     *
     * @return array<int,int>
     */
    public function verseCounts()
    {
        $rows = $this->select(
            'SELECT vt.topic_id, COUNT(*) AS n
               FROM verse_topics vt
               JOIN verses v ON v.id = vt.verse_id
              WHERE v.published = 1 AND v.is_curated = 1
              GROUP BY vt.topic_id'
        );

        $counts = array();
        foreach ($rows as $row) {
            $counts[(int) $row['topic_id']] = (int) $row['n'];
        }

        return $counts;
    }
}
