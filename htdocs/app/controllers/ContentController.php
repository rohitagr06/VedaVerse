<?php
/**
 * VedaVerse — app/controllers/ContentController.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   The scripture pages: the chapter index, one chapter, one verse, and
 *   the small write actions a reader can take on a verse — mark it read,
 *   save it, write a private note.
 *
 * HOW THIN IS THIN
 *   Read the request, ask a service, render or redirect. Every method
 *   here is short enough to read in one go, and none of them contains a
 *   query or a decision about content. When one of them starts to grow,
 *   the thing that grew belongs in ContentService.
 *
 * EVERYTHING HERE IS READABLE BY A GUEST
 *   No auth middleware on any of these routes. Reading is free and
 *   anonymous, and so is saving, noting and marking progress — a guest's
 *   work is tagged with their year-long anonymous token and merges into
 *   an account if they ever make one. That is the product's central
 *   promise and it is enforced by the absence of a middleware, so do not
 *   add one here without meaning to.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Controllers;

use VedaVerse\Core\Config;
use VedaVerse\Core\ErrorHandler;
use VedaVerse\Core\Request;
use VedaVerse\Core\View;
use VedaVerse\Repositories\BookmarkRepository;
use VedaVerse\Repositories\ProgressRepository;
use VedaVerse\Repositories\VerseRepository;
use VedaVerse\Services\ContentService;
use VedaVerse\Services\I18nService;

class ContentController extends Controller
{
    /**
     * GET /chapters
     */
    public function chapters(Request $request)
    {
        $service  = new ContentService();
        $chapters = $service->chapterIndex($this->owner());

        return $this->view('pages/chapters', array(
            'title'       => View::t('chapter.index.title'),
            'description' => View::t('chapter.index.lead'),
            'canonical'   => $request->url('/chapters'),
            'chapters'    => $chapters,
            'service'     => $service,
        ));
    }

    /**
     * GET /chapter/{number}
     */
    public function chapter(Request $request)
    {
        // Route placeholders arrive on the Request, not as method
        // arguments — see Router::dispatch(), which calls setParams()
        // and then invokes the action with the Request alone.
        $number  = (int) $request->param('number');

        $service = new ContentService();
        $chapter = $service->chapter($number, $this->owner());

        if ($chapter === null) {
            return ErrorHandler::page(404);
        }

        $title = I18nService::field($chapter, 'title');

        return $this->view('pages/chapter', array(
            'title'       => View::t('content.chapter_n', array(':n' => (int) $chapter['chapter_number'])) . ' — ' . $title,
            'description' => I18nService::field($chapter, 'subtitle'),
            'canonical'   => $request->url(chapter_url((int) $chapter['chapter_number'])),
            'chapter'     => $chapter,
            'service'     => $service,
        ));
    }

    /**
     * GET /chapter/{chapter}/verse/{verse}
     */
    public function verse(Request $request)
    {
        $chapterNumber = (int) $request->param('chapter');
        $verseNumber   = (int) $request->param('verse');

        $service = new ContentService();

        // Both come from the query string, so both go through the
        // service's allow-lists before they reach a query. safeMode and
        // safeLevel return the default for anything unrecognised rather
        // than erroring — a shared link with a stale ?mode= should open,
        // not 404.
        $mode  = $service->safeMode((string) $request->query('mode', 'learn'));
        $level = $service->safeLevel((string) $request->query('level', 'beginner'));

        $verse = $service->verse($chapterNumber, $verseNumber, $mode, $level);

        if ($verse === null) {
            return ErrorHandler::page(404);
        }

        $owner = $this->owner();

        // "You were reading" and the resume point both need this, and
        // this is the only place that knows a verse was opened.
        $progress = new ProgressRepository();
        $progress->recordView($owner, (int) $verse['id']);

        // Whether this reader has already finished it. Without this the
        // page looks identical before and after marking it read, which
        // makes the button feel broken and makes people press it twice.
        $state    = $progress->forVerse($owner, (int) $verse['id']);
        $finished = $state !== null && (int) $state['completion_percentage'] >= 100;

        $bookmarks = new BookmarkRepository();

        $reference = (int) $verse['chapter_number'] . '.' . (int) $verse['verse_number'];

        // The SEO title an editor wrote wins. It is written for somebody
        // searching for a problem — "what the Gita says about doing your
        // job without obsessing over the result" — rather than for a
        // verse number, which is what almost nobody searches for.
        $title = trim((string) $verse['seo_title']) !== ''
            ? (string) $verse['seo_title']
            : View::t('content.gita') . ' ' . $reference;

        return $this->view('pages/verse', array(
            'title'       => $title,
            'description' => trim((string) $verse['seo_description']) !== ''
                ? (string) $verse['seo_description']
                : I18nService::field($verse, 'summary'),
            'canonical'   => $request->url(verse_url((int) $verse['chapter_number'], (int) $verse['verse_number'])),
            'verse'       => $verse,
            'reference'   => $reference,
            'mode'        => $mode,
            'level'       => $level,
            // Focus mode hides the chrome. Done with a body class rather
            // than a second layout, so there is one shell to keep
            // accessible instead of two that drift.
            'bodyClass'   => $mode === 'focus' ? 'is-focus' : '',
            'finished'    => $finished,
            'bookmarked'  => $bookmarks->has($owner, 'verse', (int) $verse['id']),
            'note'        => $bookmarks->note($owner, (int) $verse['id']),
            'service'     => $service,
        ));
    }

    /**
     * POST /verse/{id}/read
     *
     * Marks a verse finished. Redirects back rather than answering with
     * JSON, so the button works with JavaScript switched off — the whole
     * progress system would otherwise be unusable for anybody on a slow
     * connection whose scripts have not loaded yet.
     */
    public function markRead(Request $request)
    {
        $verse = $this->publishedVerse($request);

        if ($verse === null) {
            return ErrorHandler::page(404);
        }

        $progress = new ProgressRepository();
        $progress->markRead($this->owner(), (int) $verse['id'], (int) $verse['chapter_id']);

        // Back to where they were, with the flash. Not to the next verse
        // — deciding for somebody that they want to continue is how a
        // reader loses the sentence they were in the middle of.
        return $this->ok($this->backTo($request), View::t('lesson.completed', array(
            ':n' => (int) Config::get('app.xp.lesson', 10),
        )));
    }

    /**
     * POST /verse/{id}/bookmark
     */
    public function toggleBookmark(Request $request)
    {
        $verse = $this->publishedVerse($request);

        if ($verse === null) {
            return ErrorHandler::page(404);
        }

        $bookmarks = new BookmarkRepository();
        $saved     = $bookmarks->toggle($this->owner(), 'verse', (int) $verse['id']);

        return $this->ok(
            $this->backTo($request),
            View::t($saved ? 'verse.bookmarked' : 'verse.unbookmark')
        );
    }

    /**
     * POST /verse/{id}/note
     */
    public function saveNote(Request $request)
    {
        $verse = $this->publishedVerse($request);

        if ($verse === null) {
            return ErrorHandler::page(404);
        }

        $content = (string) $request->input('note', '');

        // Long enough for a real thought, short enough that the column
        // cannot be used as free file storage.
        $v = $this->validate(
            array('note' => $content),
            array('note' => 'max:4000'),
            array('note' => View::t('verse.note'))
        );

        if ($v->fails()) {
            return $this->back($this->backTo($request), $v, array('note' => $content));
        }

        $bookmarks = new BookmarkRepository();
        $bookmarks->saveNote($this->owner(), (int) $verse['id'], $content);

        return $this->ok($this->backTo($request), View::t('flash.saved'));
    }

    /**
     * The published verse this write action names, or null.
     *
     * WHY ALL THREE WRITE ACTIONS GO THROUGH THIS
     *   The id comes from the URL and anybody can type one. notes has a
     *   foreign key to verses, so posting a note to an id that does not
     *   exist raised an integrity-constraint violation and a 500 page on
     *   a URL a bored person can guess. bookmarks has no such key —
     *   target_id is polymorphic — so the same request there wrote a
     *   bookmark pointing at nothing, silently, and it would have sat in
     *   the table until some later page tried to render it.
     *
     *   One guard, used by all three, is the only version of this that
     *   stays true when a fourth write action is added.
     *
     * @param Request $request
     * @return array<string,mixed>|null
     */
    private function publishedVerse(Request $request)
    {
        $verses = new VerseRepository();
        $verse  = $verses->find((int) $request->param('id'), 'id, chapter_id, verse_number, published');

        if ($verse === null || (int) $verse['published'] !== 1) {
            return null;
        }

        return $verse;
    }

    /**
     * Where a write action should return to.
     *
     * The submitted `return` field, put through safe_redirect_target —
     * the same helper AuthMiddleware and the sign-in flow already use.
     * An unvalidated redirect target is an open redirect, which is a
     * real phishing primitive: somebody posts a link on our domain and
     * the victim lands on theirs. One implementation, used everywhere,
     * is the only way that stays true.
     *
     * @param Request $request
     * @return string
     */
    private function backTo(Request $request)
    {
        return safe_redirect_target((string) $request->input('return', ''), '/');
    }
}
