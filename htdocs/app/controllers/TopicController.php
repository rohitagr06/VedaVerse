<?php
/**
 * VedaVerse — app/controllers/TopicController.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Two doors into the same content, kept deliberately separate.
 *
 *     /topics, /topic/{slug}        concepts — karma, dharma, detachment
 *     /problems, /problem/{slug}    life problems — anger, grief, burnout
 *
 * WHY TWO SETS OF ROUTES FOR ONE TABLE
 *   They are not the same audience and they must not read the same.
 *   Somebody browsing /topics has already decided to study the book.
 *   Somebody who typed their problem into a search engine and landed on
 *   /problem/burnout has not, and may never have opened the Gita.
 *
 *   The specification calls life-problem navigation the real front door
 *   and says to treat it as a first-class surface rather than a tag
 *   page. Separate routes, separate templates and separate copy is what
 *   that means in practice. Merging them into one page with a flag would
 *   save fifty lines and lose the thing that makes the product work.
 *
 * THE DISCLAIMER ON A PROBLEM PAGE IS NOT OPTIONAL
 *   Somebody reading /problem/grief may be in real distress. The page
 *   says plainly that this is a two-thousand-year-old text and not
 *   therapy, and that if things are bad they should talk to somebody who
 *   can help. That string is content.problem.disclaimer and it is
 *   rendered on every problem page, not on a subset judged serious.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Controllers;

use VedaVerse\Core\ErrorHandler;
use VedaVerse\Core\Request;
use VedaVerse\Core\View;
use VedaVerse\Services\ContentService;
use VedaVerse\Services\I18nService;

class TopicController extends Controller
{
    /**
     * GET /topics
     */
    public function topics(Request $request)
    {
        $service = new ContentService();

        return $this->view('pages/topics', array(
            'title'       => View::t('topic.index.title'),
            'description' => View::t('topic.index.title'),
            'canonical'   => $request->url('/topics'),
            'topics'      => $service->topicIndex(false),
            'is_problem'  => false,
        ));
    }

    /**
     * GET /problems
     */
    public function problems(Request $request)
    {
        $service = new ContentService();

        return $this->view('pages/topics', array(
            'title'       => View::t('problem.index.title'),
            'description' => View::t('problem.index.lead'),
            'canonical'   => $request->url('/problems'),
            'topics'      => $service->topicIndex(true),
            'is_problem'  => true,
        ));
    }

    /**
     * GET /topic/{slug}
     */
    public function topic(Request $request)
    {
        // Route placeholders arrive on the Request, not as method
        // arguments — see Router::dispatch().
        return $this->show($request, (string) $request->param('slug'), false);
    }

    /**
     * GET /problem/{slug}
     */
    public function problem(Request $request)
    {
        return $this->show($request, (string) $request->param('slug'), true);
    }

    /**
     * The shared body of both detail pages.
     *
     * The two differ in template and in copy, not in what they fetch —
     * so the fetch is here once and the difference is a template name.
     *
     * @param Request $request
     * @param string  $slug
     * @param bool    $asProblem
     * @return \VedaVerse\Core\Response
     */
    private function show(Request $request, $slug, $asProblem)
    {
        $service = new ContentService();
        $topic   = $service->topic((string) $slug);

        if ($topic === null) {
            return ErrorHandler::page(404);
        }

        // A topic reached through the wrong door redirects to the right
        // one rather than rendering there. Two URLs showing the same
        // content is a duplicate-content problem for search engines, and
        // more to the point /problem/karma would open with "start from
        // what is bothering you" above an abstract concept.
        $isProblem = (int) $topic['is_life_problem'] === 1;

        if ($isProblem !== $asProblem) {
            return $this->redirect(
                ($isProblem ? '/problem/' : '/topic/') . rawurlencode((string) $topic['slug']),
                301
            );
        }

        $name = I18nService::field($topic, 'name');

        return $this->view($asProblem ? 'pages/problem' : 'pages/topic', array(
            'title'       => $name,
            'description' => I18nService::field($topic, 'description'),
            'canonical'   => $request->url(
                ($asProblem ? '/problem/' : '/topic/') . rawurlencode((string) $topic['slug'])
            ),
            'topic'       => $topic,
            'name'        => $name,
            'is_problem'  => $asProblem,
        ));
    }
}
