<?php
/**
 * VedaVerse — app/middleware/AuthMiddleware.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Requires a signed-in account. Guests are sent to the login screen
 *   with a note of where they were heading, so they land back there
 *   afterwards instead of on the home page.
 *
 * WHAT IT IS NOT FOR
 *   Reading. Anonymous learning is a resolved decision: a guest can read
 *   every verse, take every quiz, search, bookmark and take notes without
 *   an account. This middleware belongs only on the three things that
 *   genuinely need an identity — posting to the forum, syncing across
 *   devices, and earning a certificate.
 *
 *   If you find yourself adding it to a content route, that is a
 *   requirements bug, not a security improvement.
 *
 * THE RETURN PATH IS A REDIRECT VECTOR
 *   "Send them back where they came from" is exactly how open redirects
 *   get introduced. The intended path goes through
 *   safe_redirect_target(), which refuses anything with a scheme, a host
 *   or a leading double slash.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Middleware;

use VedaVerse\Core\Logger;
use VedaVerse\Core\Request;
use VedaVerse\Core\Response;
use VedaVerse\Core\Session;
use VedaVerse\Core\View;

class AuthMiddleware extends Middleware
{
    /**
     * @param Request  $request
     * @param callable $next
     * @return Response
     */
    public function handle(Request $request, $next)
    {
        if (Session::user() !== null) {
            return $this->next($next, $request);
        }

        Logger::info('Sign-in required', array('path' => $request->path()));

        if ($request->wantsJson()) {
            return Response::json(array(
                'ok'      => false,
                'error'   => 'unauthenticated',
                'message' => View::t('error.401.body'),
            ), 401);
        }

        // Remember where they were going, but only for a GET. Replaying a
        // POST after login would resubmit a form the person may no longer
        // want to send, and they would have no idea it happened.
        if ($request->isGet()) {
            Session::flash('_intended', safe_redirect_target($request->path(), '/'));
        }

        Session::flash('info', View::t('error.401.body'));

        return Response::redirect('/login', 303);
    }
}
