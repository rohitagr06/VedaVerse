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
 * TWO COUNTERS, AND THEY MEASURE DIFFERENT THINGS
 *   This middleware counts REQUESTS from a hashed address, with a high
 *   ceiling. AuthService counts FAILURES against a hashed email, with a
 *   low one.
 *
 *   The reason they differ: an attacker spraying one common password
 *   across five hundred accounts produces no repeated failures on any
 *   single account, so the email counter never fires — only the volume
 *   from one address gives it away. An attacker working through a
 *   password list against one account from a rotating pool of addresses
 *   produces no volume from any single address — only the failures on
 *   that account give it away. Either counter alone leaves an obvious
 *   gap, and the ceilings have to differ because a shared address (an
 *   office, a college, carrier-grade NAT) has many legitimate people
 *   behind it.
 *
 *   Raw addresses are never stored. Both counters hold peppered hashes.
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

        // The address counter lives in its own scope, prefixed 'ip:', so it
        // cannot be confused with the per-email counter AuthService keeps
        // under the same scope name. Two counters, two ceilings, one table.
        $scope = 'ip:' . $this->scope;
        $key   = hash_value($request->ip(), 'throttle');

        if ($throttle->isAddressLimited($key, $scope)) {
            $seconds = $throttle->secondsUntilUnlocked($key, $scope);

            Logger::warning('Rate limit reached', array(
                'scope' => $scope,
                'path'  => $request->path(),
            ));

            return $this->tooMany($request, $seconds > 0 ? $seconds : 900);
        }

        // Record BEFORE handing on, not after.
        //
        // This middleware cannot tell success from failure — that is the
        // service's business, and asking it to inspect the response would
        // couple it to how every controller happens to redirect. So it
        // counts requests rather than failures, which is the right measure
        // for an address anyway. Recording first also means an attempt
        // that crashes the controller still counts, rather than giving an
        // attacker a free guess by finding an input that throws.
        $throttle->record($key, $scope, false);

        // Stall before doing the work, not after. Delaying the response
        // once the attempt has already been processed costs the attacker
        // nothing, because they can abandon the connection and fire the
        // next guess immediately.
        $delay = $throttle->delayFor($key, $scope);
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
