<?php
/**
 * VedaVerse — app/middleware/MaintenanceMiddleware.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Turns the site off for everyone except administrators, so the owner
 *   can import content or restore a backup without a learner catching the
 *   site mid-write.
 *
 * THE ADMIN BYPASS IS THE WHOLE POINT
 *   Maintenance mode with no bypass is a mode you cannot switch off from
 *   inside the application, because the settings page is behind the mode
 *   you just enabled. The admin path and the auth path stay open, always.
 *
 * WHY 503 AND Retry-After
 *   503 tells a search engine "temporarily unavailable, keep the ranking
 *   and come back". A 404 or a 200 with an apology page during a
 *   maintenance window is how a site quietly loses its search positions,
 *   and the damage is not visible for weeks.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Middleware;

use VedaVerse\Core\Request;
use VedaVerse\Core\Response;
use VedaVerse\Core\Session;
use VedaVerse\Repositories\SettingRepository;

class MaintenanceMiddleware extends Middleware
{
    /**
     * Paths that stay reachable while the site is closed.
     *
     * Auth is on the list so an admin who is not signed in can sign in —
     * otherwise enabling maintenance mode while logged out locks the
     * owner out of their own site until they edit the database by hand.
     *
     * @var array<int,string>
     */
    private $alwaysOpen = array('/admin', '/login', '/logout', '/health');

    /**
     * @param Request  $request
     * @param callable $next
     * @return Response
     */
    public function handle(Request $request, $next)
    {
        $settings = new SettingRepository();

        if (!$settings->bool('maintenance_mode', false)) {
            return $this->next($next, $request);
        }

        if ($this->isOpen($request->path())) {
            return $this->next($next, $request);
        }

        if (user_can('admin')) {
            // Let an admin browse the closed site, but make it obvious
            // that it is closed — otherwise it is genuinely easy to leave
            // maintenance mode on for a day without noticing, because
            // everything looks normal to the only person who can see it.
            $response = $this->next($next, $request);
            return $response->header('X-VedaVerse-Maintenance', 'on');
        }

        $response = $this->stop(503);

        // Ten minutes: long enough that a crawler backs off, short enough
        // that it comes back the same day.
        return $response->header('Retry-After', '600');
    }

    /**
     * @param string $path
     * @return bool
     */
    private function isOpen($path)
    {
        foreach ($this->alwaysOpen as $open) {
            if (strpos($path, $open) === 0) {
                return true;
            }
        }
        return false;
    }
}
