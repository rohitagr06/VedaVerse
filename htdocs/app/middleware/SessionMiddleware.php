<?php
/**
 * VedaVerse — app/middleware/SessionMiddleware.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Starts the session, makes sure the visitor has a durable guest
 *   identity, chooses the interface language, records the session row,
 *   and runs the small amount of housekeeping that would otherwise need
 *   a cron job.
 *
 * WHERE IT SITS
 *   After security headers and maintenance mode, before CSRF — because
 *   CSRF needs a session to compare the submitted token against.
 *
 * NOT IN THE SPECIFICATION'S MIDDLEWARE LIST
 *   The build prompt names Auth, Admin, Csrf, RateLimit, Maintenance and
 *   SecurityHeaders. This is an addition. Session bootstrapping has to
 *   happen somewhere before CSRF, and doing it inside index.php would put
 *   logic in a file that is supposed to be routing only.
 *
 * THE HOUSEKEEPING
 *   There is no cron on this host. Expired sessions and stale throttle
 *   rows are pruned here, on roughly one request in a hundred, with a
 *   capped row count so the unlucky request still finishes fast.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Middleware;

use VedaVerse\Core\Config;
use VedaVerse\Core\Request;
use VedaVerse\Core\Session;
use VedaVerse\Core\View;
use VedaVerse\Repositories\SessionRepository;
use VedaVerse\Repositories\ThrottleRepository;
use VedaVerse\Services\I18nService;

class SessionMiddleware extends Middleware
{
    /**
     * @param Request  $request
     * @param callable $next
     * @return \VedaVerse\Core\Response
     */
    public function handle(Request $request, $next)
    {
        Session::start();

        // A guest gets their durable token on first sight, rather than on
        // their first bookmark, so a reader who saves something never has
        // a moment where the action lands against no identity at all.
        //
        // Signed-in visitors do NOT get one. Their work is tagged with
        // their user id, so a guest cookie would be dead weight — and,
        // more to the point, one issued immediately after registration
        // would be a brand new empty identity handed to somebody whose
        // guest work had just been merged, which reads like the merge
        // failed when you look at the cookie jar.
        if (Session::userId() === null) {
            Session::anonToken();
        }

        $this->chooseLanguage($request);

        $this->recordSession($request);

        $response = $this->next($next, $request);

        // Cookies are queued by Session and attached here, so they go out
        // with the response rather than through a bare setcookie() that
        // would fail the moment something echoed first.
        Session::attachCookies($response);

        $this->housekeeping();

        return $response;
    }

    /**
     * Decide which language this request is in.
     *
     * The decision itself moved to I18nService in Step 4, where the rest
     * of the language knowledge lives. What stays here is the wiring:
     * middleware is the right place to ASK, and the wrong place to hold
     * the answer, because the checker and the review page need the same
     * rules without going through a request.
     *
     * @param Request $request
     * @return void
     */
    private function chooseLanguage(Request $request)
    {
        $lang = I18nService::detect($request);

        View::setLang($lang);
        View::share('lang', $lang);
        View::share('html_lang', I18nService::htmlLang($lang));
    }

    /**
     * Keep the sessions table roughly in step with reality.
     *
     * Best effort by design: the repository swallows its own failures,
     * because a write to a bookkeeping table must never cost a learner
     * their page.
     *
     * @param Request $request
     * @return void
     */
    private function recordSession(Request $request)
    {
        if (PHP_SAPI === 'cli' || session_status() !== PHP_SESSION_ACTIVE) {
            return;
        }

        $lifetime = (int) Config::get('security.session.absolute_timeout', 86400);

        $repo = new SessionRepository();
        $repo->touch(
            session_id(),
            Session::userId(),
            Session::get(Session::KEY_ANON),
            $request->ipHash(),
            $request->userAgentHash(),
            $lifetime
        );
    }

    /**
     * The work a cron job would do, spread across ordinary requests.
     *
     * @return void
     */
    private function housekeeping()
    {
        $sessions = new SessionRepository();
        $sessions->prune(100);

        $throttle = new ThrottleRepository();
        $throttle->prune(100);
    }
}
