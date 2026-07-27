<?php
/**
 * VedaVerse — app/middleware/CsrfMiddleware.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Refuses any state-changing request that does not carry this session's
 *   CSRF token.
 *
 * WHAT CSRF ACTUALLY IS, IN ONE PARAGRAPH
 *   A cookie is sent by the browser on every request to your domain,
 *   including requests started by somebody else's page. So a form on
 *   evil.example that posts to vedaverse/profile/delete arrives fully
 *   authenticated, because the browser attaches the session cookie
 *   without being asked. The defence is a secret the attacker's page
 *   cannot read: a token stored in the session and echoed into the form.
 *   Their page can make the browser send the request, but it cannot know
 *   the token to include.
 *
 * WHY IT RUNS IN MIDDLEWARE AND NOT IN CONTROLLERS
 *   Because a check written in a controller is a check somebody forgets
 *   in the fortieth controller. Here it is impossible to forget: the
 *   controller does not run at all unless the token is right.
 *
 * SAFE METHODS ARE SKIPPED
 *   GET and HEAD are not checked, on the assumption they change nothing.
 *   That assumption is on you: a GET route that deletes something is a
 *   CSRF hole this middleware cannot see. If it changes state, it is a
 *   POST.
 *
 * SameSite IS NOT ENOUGH ON ITS OWN
 *   The session cookie is SameSite=Lax, which already blocks most of
 *   this. It is not a substitute — Lax still permits top-level GET
 *   navigation, older browsers ignore it, and a single misconfiguration
 *   removes the whole protection. Two independent defences.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Middleware;

use VedaVerse\Core\Config;
use VedaVerse\Core\Logger;
use VedaVerse\Core\Request;
use VedaVerse\Core\Response;
use VedaVerse\Core\Session;
use VedaVerse\Core\View;

class CsrfMiddleware extends Middleware
{
    /**
     * @param Request  $request
     * @param callable $next
     * @return Response
     */
    public function handle(Request $request, $next)
    {
        if (in_array($request->method(), array('GET', 'HEAD', 'OPTIONS'), true)) {
            return $this->next($next, $request);
        }

        if ($this->isExempt($request)) {
            return $this->next($next, $request);
        }

        $token = $this->tokenFrom($request);

        if (!Session::verifyCsrf($token)) {
            // Logged at warning, not error. The overwhelmingly common
            // cause is a form left open past the token lifetime, or a
            // browser tab restored after a restart — a real attack looks
            // identical from here, which is why the log records the path
            // and nothing about the token itself.
            Logger::warning('CSRF check failed', array(
                'path'   => $request->path(),
                'method' => $request->method(),
                'had_token' => $token !== null && $token !== '',
            ));

            return $this->refuse($request);
        }

        return $this->next($next, $request);
    }

    /**
     * Find the token in the form body or the header.
     *
     * A normal form posts a hidden field. A fetch() sends a header,
     * because putting the token in a JSON body would mean every endpoint
     * had to parse the body before it could authorise the request.
     *
     * @param Request $request
     * @return string|null
     */
    private function tokenFrom(Request $request)
    {
        $field = (string) Config::get('security.csrf.field_name', '_csrf');
        $value = $request->post($field);

        if (is_string($value) && $value !== '') {
            return $value;
        }

        $header = (string) Config::get('security.csrf.header_name', 'X-CSRF-Token');
        $value  = $request->header(strtolower($header));

        return is_string($value) && $value !== '' ? $value : null;
    }

    /**
     * Routes excused from the check.
     *
     * The list lives in config and should stay empty or near it. Every
     * entry is a hole, and "just this one endpoint" is how the first one
     * always gets added.
     *
     * @param Request $request
     * @return bool
     */
    private function isExempt(Request $request)
    {
        $exempt = (array) Config::get('security.csrf.exempt', array());
        $path   = $request->path();

        foreach ($exempt as $pattern) {
            if ($pattern !== '' && strpos($path, (string) $pattern) === 0) {
                return true;
            }
        }

        return false;
    }

    /**
     * Turn the failure into something the person can act on.
     *
     * A bare 403 leaves someone staring at a form they just spent five
     * minutes filling in with no idea what happened. Since the usual
     * cause really is an expired token, the HTML path sends them back
     * where they came from with an explanation and a fresh token, rather
     * than to an error page that loses their work.
     *
     * @param Request $request
     * @return Response
     */
    private function refuse(Request $request)
    {
        if ($request->wantsJson()) {
            return Response::json(array(
                'ok'    => false,
                'error' => 'csrf',
                'message' => View::t('validation.csrf'),
            ), 403);
        }

        Session::flash('error', View::t('validation.csrf'));

        // Back to the referring page when it is on this site, otherwise
        // home. safe_redirect_target refuses anything off-site, so a
        // forged Referer cannot turn this into an open redirect.
        $referer = (string) $request->header('referer', '');
        $target  = '/';

        if ($referer !== '') {
            $host = parse_url($referer, PHP_URL_HOST);
            $self = parse_url($request->base(), PHP_URL_HOST);
            if ($host !== null && $self !== null && strcasecmp((string) $host, (string) $self) === 0) {
                $path   = parse_url($referer, PHP_URL_PATH);
                $target = safe_redirect_target($path, '/');
            }
        }

        return Response::redirect($target, 303);
    }
}
