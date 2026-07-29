<?php
/**
 * VedaVerse — app/controllers/ProfileController.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   The "You" tab: what this reader has saved, written and finished, and
 *   the controls over their own data.
 *
 * WHY IT EXISTS IN STEP 5 RATHER THAN LATER
 *   Three reasons, and none of them is that the page is exciting.
 *
 *   1. app/views/partials/nav.php has linked a signed-in reader to
 *      /profile since Step 3. It answered 404. A dead link in the
 *      primary navigation is worse than a plain page.
 *
 *   2. Acceptance test 5 — bookmark and note things as a guest, then
 *      register, and confirm the work followed you — could not actually
 *      be performed. The merge worked; there was simply no screen on
 *      which to see that it had. A test you can only run in SQL is a
 *      test nobody runs.
 *
 *   3. Section 12 requires that a person can export their data and
 *      delete their account. That is not a feature to schedule; it is
 *      the promise the anonymous-first design is built on.
 *
 * GUESTS SEE THIS TOO
 *   No auth middleware on the read routes. A guest has bookmarks, notes
 *   and progress — all of it tagged with their year-long token — and
 *   telling them to sign in to look at their own work would be a lie
 *   about how this product stores things. Export works for them as well.
 *   Only account deletion needs an account, because there is nothing
 *   else to delete.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Controllers;

use VedaVerse\Core\Config;
use VedaVerse\Core\Request;
use VedaVerse\Core\Response;
use VedaVerse\Core\Session;
use VedaVerse\Core\View;
use VedaVerse\Repositories\BookmarkRepository;
use VedaVerse\Repositories\ProgressRepository;
use VedaVerse\Repositories\UserRepository;

class ProfileController extends Controller
{
    /**
     * GET /profile
     */
    public function show(Request $request)
    {
        $owner     = $this->owner();
        $bookmarks = new BookmarkRepository();
        $progress  = new ProgressRepository();

        return $this->view('pages/profile', array(
            'title'     => View::t('profile.title'),
            'robots'    => 'noindex, nofollow',
            'canonical' => $request->url('/profile'),
            'saved'     => $bookmarks->verses($owner, 50),
            'notes'     => $bookmarks->notes($owner, 50),
            'finished'  => $progress->completedTotal($owner),
            'recent'    => $progress->recentlyViewed($owner, 5),
        ));
    }

    /**
     * GET /profile/export
     *
     * Everything this person has written or done, as JSON, in one file.
     *
     * WHY A DOWNLOAD AND NOT A PAGE
     *   Section 12 says a user can export their data. A page they would
     *   have to select and copy is not an export. This sets
     *   Content-Disposition so the browser saves it, and the filename
     *   carries the date so two exports do not overwrite each other.
     *
     * WHAT IS NOT IN IT
     *   The password hash and the recovery-code hash. Neither is
     *   "their data" in any useful sense, both are secrets, and an
     *   export file is the least protected place a hash could end up —
     *   it lands in a downloads folder, gets emailed to a friend for
     *   help, and is never deleted.
     */
    public function export(Request $request)
    {
        $owner     = $this->owner();
        $bookmarks = new BookmarkRepository();
        $progress  = new ProgressRepository();
        $user      = $this->user();

        $payload = array(
            'exported_at' => gmdate('c'),
            'source'      => (string) Config::get('app.name'),
            'account'     => $user === null ? null : array(
                'name'           => $user['name'],
                'email'          => $user['email'],
                'preferred_lang' => $user['preferred_lang'],
                'track'          => isset($user['track']) ? $user['track'] : null,
                'created_at'     => $user['created_at'],
            ),
            'bookmarks' => $bookmarks->verses($owner, 200),
            'notes'     => $bookmarks->notes($owner, 200),
            'progress'  => array_values($progress->map($owner)),
        );

        $json = json_encode($payload, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

        // JSON_UNESCAPED_UNICODE matters here: without it every
        // Devanagari character in a saved verse becomes a \uXXXX escape
        // and the file is unreadable to the person it belongs to.
        if ($json === false) {
            $json = '{"error":"export failed"}';
        }

        return Response::html($json)->headers(array(
            'Content-Type'        => 'application/json; charset=utf-8',
            'Content-Disposition' => 'attachment; filename="vedaverse-export-' . gmdate('Y-m-d') . '.json"',
            // An export is personal and must never be cached by a proxy
            // or left in a shared browser cache.
            'Cache-Control'       => 'no-store, private',
        ));
    }

    /**
     * POST /profile/delete
     *
     * Deletes the account. Requires the current password AND the word
     * DELETE typed out, because this is irreversible and there is no
     * backup anybody can restore from.
     *
     * FORUM AUTHORSHIP IS ANONYMISED, NOT ORPHANED
     *   Section 12 is explicit. Deleting the user row would cascade
     *   threads and replies away and leave conversations with holes in
     *   them, which punishes the people who replied. The rows stay; the
     *   name goes.
     */
    public function destroy(Request $request)
    {
        $user = $this->user();

        if ($user === null) {
            return $this->redirect('/login');
        }

        $confirm  = trim((string) $request->input('confirm', ''));
        $password = (string) $request->input('password', '');

        if (strtoupper($confirm) !== 'DELETE') {
            return $this->fail('/profile', View::t('account.delete_confirm'));
        }

        $users   = new UserRepository();
        $account = $users->findForLogin((string) $user['email']);

        if ($account === null || !password_verify($password, (string) $account['password_hash'])) {
            return $this->fail('/profile', View::t('auth.error.invalid'));
        }

        $users->deleteAccount((int) $user['id']);
        Session::logout();

        return $this->ok('/', View::t('account.deleted'));
    }
}
