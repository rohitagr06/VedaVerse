<?php
/**
 * VedaVerse — app/middleware/Middleware.php
 * ---------------------------------------------------------------------
 * WHAT MIDDLEWARE IS
 *   A layer that wraps the controller. Each one may inspect the request,
 *   pass it along, and adjust the response on the way back out — like an
 *   onion, with the controller at the centre.
 *
 *       SecurityHeaders  →  Session  →  Maintenance  →  Csrf  →  Controller
 *       ← headers added  ←  cookies  ←  503 or pass  ←  403   ←
 *
 *   A middleware may also stop the request dead by returning a Response
 *   instead of calling $next. That is how CsrfMiddleware refuses a forged
 *   form before any business logic sees it, and it is the whole point:
 *   the check cannot be forgotten in a controller, because the controller
 *   never runs.
 *
 * ORDER MATTERS, AND THE ORDER IS DELIBERATE
 *   Security headers go outermost so they are attached to EVERY response,
 *   including the 503 from maintenance mode and the 403 from CSRF.
 *
 *   Session comes next, because the two after it both depend on it:
 *   Maintenance has to know whether the visitor is an administrator in
 *   order to let them through, and CSRF has to have a session token to
 *   compare against. Putting Maintenance first looks tidier — a closed
 *   site would do less work — but the admin bypass would then never fire,
 *   and the owner would be locked out of the site they had just closed
 *   with no way back in short of editing the database by hand.
 *
 *   Route middleware — auth, role, throttle — runs last, inside all of it.
 *
 * WHAT A MIDDLEWARE MUST NOT DO
 *   Echo anything. Query content tables. Hold business logic. If it is
 *   deciding what a learner is allowed to do rather than whether this
 *   request is well-formed and permitted, it belongs in a service.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Middleware;

use VedaVerse\Core\ErrorHandler;
use VedaVerse\Core\Request;
use VedaVerse\Core\Response;

abstract class Middleware
{
    /**
     * Handle the request.
     *
     * @param Request  $request
     * @param callable $next Call it to continue, or do not call it to stop.
     * @return Response
     */
    abstract public function handle(Request $request, $next);

    /**
     * Continue down the chain and guarantee a Response comes back.
     *
     * A controller that returns a plain string is wrapped rather than
     * blowing up two layers later with an unhelpful message about calling
     * a method on a string.
     *
     * @param callable $next
     * @param Request  $request
     * @return Response
     */
    protected function next($next, Request $request)
    {
        $response = call_user_func($next, $request);

        if ($response instanceof Response) {
            return $response;
        }

        return Response::html((string) $response);
    }

    /**
     * Stop the request with an error page, in whichever format the caller
     * asked for.
     *
     * Routed through ErrorHandler so a refusal from middleware looks
     * exactly like a refusal from anywhere else — same page, same
     * translation, same reference code, and JSON for a fetch() rather
     * than an HTML page it would render as literal markup.
     *
     * @param int $status
     * @return Response
     */
    protected function stop($status)
    {
        return ErrorHandler::page($status);
    }
}
