<?php
/**
 * VedaVerse — app/controllers/PathController.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   The Chariot Path — the product's primary navigation — and the
 *   explore page that offers the other ways in.
 *
 * WHOSE TRACK
 *   A signed-in reader's saved preference, a guest's session choice, or
 *   the site default. A guest can switch track and it sticks for their
 *   session; it is not worth a database row until they have an account,
 *   and pretending otherwise would mean writing to user_progress on
 *   somebody who has read nothing.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Controllers;

use VedaVerse\Core\Config;
use VedaVerse\Core\Request;
use VedaVerse\Core\Session;
use VedaVerse\Core\View;
use VedaVerse\Repositories\BookmarkRepository;
use VedaVerse\Repositories\ProgressRepository;
use VedaVerse\Repositories\UserRepository;
use VedaVerse\Services\ContentService;
use VedaVerse\Services\PathService;

class PathController extends Controller
{
    /** Where a guest's chosen track is remembered. */
    const TRACK_KEY = 'vv_track';

    /**
     * GET /path
     */
    public function path(Request $request)
    {
        $service = new PathService();
        $owner   = $this->owner();
        $track   = $this->track();

        // NOT 'path'. View::capture() has a local $path holding the
        // resolved template filename and extracts with EXTR_SKIP, so a
        // data key called 'path' is silently dropped and the template
        // sees the file path instead. Same trap for 'vars'.
        return $this->view('pages/path', array(
            'title'       => View::t('path.title'),
            'description' => View::t('path.lead'),
            'robots'      => 'noindex, follow',
            'canonical'   => $request->url('/path'),
            'chariot'     => $service->build($track, $owner),
            'track'       => $track,
            'resume'      => $service->resumePoint($owner),
        ));
    }

    /**
     * POST /path/track
     *
     * Switching track never costs progress — everything finished stays
     * finished, because progress is recorded per verse and a track is
     * only a view over which verses are laid out. Saying so in the flash
     * matters: the fear that it will reset is why people do not switch.
     */
    public function setTrack(Request $request)
    {
        $requested = (string) $request->input('track', '');
        $allowed   = array('beginner', 'intermediate', 'advanced');

        if (!in_array($requested, $allowed, true)) {
            return $this->fail('/path', View::t('validation.in'));
        }

        $user = $this->user();

        if ($user !== null) {
            $users = new UserRepository();
            $users->updateTrack((int) $user['id'], $requested);
            Session::refreshUser();
        } else {
            Session::put(self::TRACK_KEY, $requested);
        }

        return $this->ok('/path', View::t('path.track.kept'));
    }

    /**
     * GET /explore
     *
     * The other doors: the verse of the day, chapters, concepts, life
     * problems, and whatever this reader was last looking at.
     */
    public function explore(Request $request)
    {
        $content   = new ContentService();
        $owner     = $this->owner();
        $progress  = new ProgressRepository();
        $bookmarks = new BookmarkRepository();

        return $this->view('pages/explore', array(
            'title'       => View::t('explore.title'),
            'description' => View::t('explore.lead'),
            'canonical'   => $request->url('/explore'),
            'daily'       => $content->verseOfTheDay(),
            'chapters'    => $content->chapterIndex($owner),
            'problems'    => $content->topicIndex(true),
            'recent'      => $progress->recentlyViewed($owner, 4),
            'bookmarks'   => $bookmarks->verses($owner, 4),
        ));
    }

    /**
     * Which track this reader is on.
     *
     * @return string
     */
    private function track()
    {
        $user = $this->user();

        if ($user !== null && isset($user['track']) && $user['track'] !== '') {
            return (string) $user['track'];
        }

        $chosen = Session::get(self::TRACK_KEY);

        if (is_string($chosen) && $chosen !== '') {
            return $chosen;
        }

        return (string) Config::get('app.defaults.track', 'beginner');
    }
}
