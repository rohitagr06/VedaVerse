<?php
/**
 * VedaVerse — app/middleware/RateLimitMiddleware.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Slows down and eventually blocks repeated attempts against a scope.
 *   Attached per route:
 *
 *       $router->post('/login', ...)->middleware('throttle:login');
 *
 * WHY BOTH A DELAY AND A LOCKOUT
 *   A lockout alone is blunt: it does nothing for the first four guesses
 *   and then stops everything, which an attacker works around by
 *   spreading attempts thinly. The progressive delay costs them
 *   throughput on every single request while a human who mistyped once
 *   notices nothing, because the first two attempts are not delayed at
 *   all.
 *
 * WHAT IT COUNTS
 *   The hashed IP, per scope. Raw addresses are never stored. AuthService
 *   ALSO throttles by hashed email, so an attacker rotating IPs against
 *   one account is caught by the second counter and an attacker trying
 *   many accounts from one address is caught by this one. Either alone
 *   leaves an obvious gap.
 *
 * FAILING CLOSED
 *   If the counter cannot be read — a database problem — the repository
 *   reports the limit as reached rather than as zero. A broken database
 *   must not hand out unlimited guesses.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Middleware;

use VedaVerse\Core\Config;
use VedaVerse\Core\Logger;
use VedaVerse\Core\Request;
use VedaVerse\Core\Response;
use VedaVerse\Core\View;
use VedaVerse\Repositories\ThrottleRepository;

class RateLimitMiddleware extends Middleware
{
    /** @var string */
    private $scope = 'default';

    /**
     * @param string|null $scope Supplied by the route as 'throttle:login'.
     */
    public function __construct($scope = null)
    {
        if (is_string($scope) && $scope !== '') {
            // Only scopes named in config are honoured. A typo in a route
            // then falls back to the default bucket rather than silently
            // creating an unlimited one of its own.
            $known = (array) Config::get('security.throttle.scopes', array());
            $this->scope = in_array($scope, $known, true) ? $scope : 'default';
        }
    }

    /**
     * @param Request  $request
     * @param callable $next
     * @return Response
     */
    public function handle(Request $request, $next)
    {
        // Only state-changing requests are counted. Throttling GET would
        // mean a learner reading quickly gets locked out of the site.
        if (in_array($request->method(), array('GET', 'HEAD', 'OPTIONS'), true)) {
            return $this->next($next, $request);
        }

        $throttle = new ThrottleRepository();
        $key      = hash_value($request->ip(), 'throttle:' . $this->scope);

        if ($throttle->isLocked($key, $this->scope)) {
            $seconds = $throttle->secondsUntilUnlocked($key, $this->scope);

            Logger::warning('Rate limit reached', array(
                'scope' => $this->scope,
                'path'  => $request->path(),
            ));

            return $this->tooMany($request, $seconds);
        }

        // Stall before doing the work, not after. Delaying the response
        // once the attempt has already been processed costs the attacker
        // nothing, because they can abandon the connection and fire the
        // next guess immediately.
        $delay = $throttle->delayFor($key, $this->scope);
        if ($delay > 0) {
            usleep($delay * 1000);
        }

        return $this->next($next, $request);
    }

    /**
     * A 429 that tells the person when to come back.
     *
     * @param Request $request
     * @param int     $seconds
     * @return Response
     */
    private function tooMany(Request $request, $seconds)
    {
        $minutes = (int) max(1, ceil($seconds / 60));

        if ($request->wantsJson()) {
            $response = Response::json(array(
                'ok'          => false,
                'error'       => 'rate_limited',
                'message'     => View::t('validation.throttled', array(':n' => $minutes)),
                'retry_after' => (int) $seconds,
            ), 429);
        } else {
            $response = $this->stop(429);
        }

        return $response->header('Retry-After', (string) max(1, (int) $seconds));
    }
}
