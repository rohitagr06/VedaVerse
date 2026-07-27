<?php
/**
 * VedaVerse — app/middleware/AdminMiddleware.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Requires a minimum role. Attached per route:
 *
 *       $router->group('/admin', array('auth', 'role:admin'), ...)
 *
 *   Roles are a ladder — user, moderator, admin, superadmin — where a
 *   higher rung can do everything a lower one can. The default is
 *   'admin' when no argument is given.
 *
 * WHY 403 AND NOT 404
 *   A signed-in non-admin who reaches /admin gets a plain refusal. Some
 *   applications answer 404 to hide that the route exists; that is
 *   security through obscurity, it makes real bugs impossible to
 *   diagnose, and anyone who cares already knows the URL of an admin
 *   panel. Acceptance test 8 expects a redirect when signed out and a 403
 *   when signed in as a non-admin, which is exactly this.
 *
 * WHY EVERY REFUSAL IS AUDITED
 *   One person mistyping /admin is noise. The same account trying it
 *   forty times in a minute is the single most useful signal this
 *   application can produce, and it only exists if the refusals are
 *   written down.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Middleware;

use VedaVerse\Core\Logger;
use VedaVerse\Core\Request;
use VedaVerse\Core\Response;
use VedaVerse\Core\Session;
use VedaVerse\Core\View;

class AdminMiddleware extends Middleware
{
    /** @var string */
    private $required = 'admin';

    /**
     * @param string|null $role Supplied by the route as 'role:moderator'.
     */
    public function __construct($role = null)
    {
        $ladder = array('user', 'moderator', 'admin', 'superadmin');

        if (is_string($role) && in_array($role, $ladder, true)) {
            $this->required = $role;
        }
    }

    /**
     * @param Request  $request
     * @param callable $next
     * @return Response
     */
    public function handle(Request $request, $next)
    {
        $user = Session::user();

        // Signed out. AuthMiddleware normally catches this first, but this
        // class must be safe on its own — a route that is given 'role:admin'
        // and not 'auth' would otherwise be wide open to guests.
        if ($user === null) {
            Session::flash('info', View::t('error.401.body'));
            if ($request->isGet()) {
                Session::flash('_intended', safe_redirect_target($request->path(), '/'));
            }
            return Response::redirect('/login', 303);
        }

        if (user_can($this->required)) {
            return $this->next($next, $request);
        }

        Logger::audit(
            'authz_failure',
            'route',
            null,
            array('path' => $request->path(), 'required' => $this->required, 'held' => $user['role']),
            (int) $user['id']
        );

        if ($request->wantsJson()) {
            return Response::json(array(
                'ok'      => false,
                'error'   => 'forbidden',
                'message' => View::t('error.403.body'),
            ), 403);
        }

        return $this->stop(403);
    }
}
