<?php
/**
 * VedaVerse — app/controllers/Controller.php
 * ---------------------------------------------------------------------
 * WHAT A CONTROLLER IS
 *   Four steps and nothing else: validate the input, check the request is
 *   allowed, hand plain values to a service, turn what comes back into a
 *   response.
 *
 * WHAT A CONTROLLER IS NOT
 *   It never writes SQL. It never builds an HTML string. It never holds a
 *   business rule — if you are writing "if the learner has completed
 *   eight verses then" in a controller, that belongs in a service, where
 *   it can be tested without a browser and reused by the CSV importer and
 *   the API.
 *
 *   The test: could this controller be deleted and rewritten for a JSON
 *   API in twenty minutes, with no logic lost? If not, something is in
 *   the wrong layer.
 *
 * WHY POST-REDIRECT-GET
 *   A form post never renders a page directly. It redirects, and the
 *   message survives in a flash. Otherwise the POST stays in the
 *   browser's history and every refresh offers to resubmit it — which on
 *   a registration form means a duplicate account and a very confused
 *   person.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Controllers;

use VedaVerse\Core\Config;
use VedaVerse\Core\Request;
use VedaVerse\Core\Response;
use VedaVerse\Core\Session;
use VedaVerse\Core\Validator;
use VedaVerse\Core\View;

abstract class Controller
{
    /**
     * Render a page inside a layout.
     *
     * @param string      $template Path under app/views, no .php
     * @param array       $data
     * @param string      $layout
     * @param int         $status
     * @return Response
     */
    protected function view($template, array $data = array(), $layout = 'layouts/app', $status = 200)
    {
        // Values every layout expects. A page can override any of them by
        // passing the same key.
        $data = array_merge(array(
            'title'       => Config::get('app.name'),
            'description' => Config::get('seo.description_default'),
            'robots'      => Config::get('seo.robots_default'),
            'canonical'   => null,
            'bodyClass'   => '',
        ), $data);

        View::reset();

        return Response::html(View::render($template, $data, $layout), $status);
    }

    /**
     * @param mixed $data
     * @param int   $status
     * @return Response
     */
    protected function json($data, $status = 200)
    {
        return Response::json($data, $status);
    }

    /**
     * Redirect, defaulting to 303.
     *
     * 303 rather than 302 after a form post, because it tells the browser
     * unambiguously to follow up with a GET. A 302 leaves that to the
     * browser's discretion, and some clients repeat the POST.
     *
     * @param string $to
     * @param int    $status
     * @return Response
     */
    protected function redirect($to, $status = 303)
    {
        return Response::redirect($to, $status);
    }

    /**
     * Bounce back to a form with the errors and the values already typed.
     *
     * Coming back to a blank form after one mistake in a six-field
     * registration is the fastest way to lose somebody. flashInput strips
     * passwords on the way through, so nothing sensitive is re-rendered.
     *
     * @param string     $to
     * @param Validator|array $errors
     * @param array      $input
     * @return Response
     */
    protected function back($to, $errors, array $input = array())
    {
        $messages = $errors instanceof Validator ? $errors->errors() : (array) $errors;

        Session::flash('_errors', $messages);
        Session::flashInput($input);

        return $this->redirect($to);
    }

    /**
     * Redirect with a success message.
     *
     * @param string $to
     * @param string $message
     * @return Response
     */
    protected function ok($to, $message = '')
    {
        if ($message !== '') {
            Session::flash('success', $message);
        }
        return $this->redirect($to);
    }

    /**
     * Redirect with an error message.
     *
     * @param string $to
     * @param string $message
     * @return Response
     */
    protected function fail($to, $message)
    {
        Session::flash('error', $message);
        return $this->redirect($to);
    }

    /**
     * Validate request data.
     *
     * @param array $data
     * @param array $rules
     * @param array $labels
     * @return Validator
     */
    protected function validate(array $data, array $rules, array $labels = array())
    {
        return Validator::make($data, $rules, $labels);
    }

    /**
     * Where to send somebody after signing in.
     *
     * Uses the path they were originally heading for when AuthMiddleware
     * intercepted them, and falls back to the given default. The value
     * has already been through safe_redirect_target on the way in, and
     * goes through it again here — cheap, and it means a stored value
     * that somehow became unsafe cannot be followed.
     *
     * @param string $default
     * @return string
     */
    protected function intended($default = '/')
    {
        $intended = Session::flashed('_intended');

        return is_string($intended) && $intended !== ''
            ? safe_redirect_target($intended, $default)
            : $default;
    }

    /**
     * The signed-in user, or null.
     *
     * @return array<string,mixed>|null
     */
    protected function user()
    {
        return Session::user();
    }

    /**
     * The current request's owner, for tagging a row: a user id when
     * signed in, the guest token when not.
     *
     * @return array{user_id:int|null,session_id:string|null}
     */
    protected function owner()
    {
        return Session::owner();
    }
}
