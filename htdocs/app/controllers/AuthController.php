<?php
/**
 * VedaVerse — app/controllers/AuthController.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   The screens for signing up, signing in, signing out and recovering an
 *   account. Thin by design: every one of these methods validates, calls
 *   AuthService, and turns the answer into a redirect.
 *
 * ONE SIGN-IN SCREEN, NOT TWO
 *   Administrators sign in at /login like everybody else, and are sent to
 *   /admin afterwards because of their role. A separate admin login form
 *   would be a second place for an authentication bug to hide, and it
 *   would need its own throttle, its own CSRF handling and its own tests
 *   for no benefit — the role check on the admin routes is what actually
 *   protects them.
 *
 * THE RECOVERY CODE IS SHOWN EXACTLY ONCE
 *   After registration and after a reset, the code goes into a one-shot
 *   flash and the person is redirected to a page that displays it. It is
 *   never stored anywhere it could be read again, never emailed (there is
 *   no email), and never logged. If they close that page without writing
 *   it down, it is gone — which the page says, in large letters.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Controllers;

use VedaVerse\Core\Config;
use VedaVerse\Core\Request;
use VedaVerse\Core\Response;
use VedaVerse\Core\Session;
use VedaVerse\Core\View;
use VedaVerse\Services\AuthService;

class AuthController extends Controller
{
    /** @var AuthService */
    private $auth;

    public function __construct()
    {
        $this->auth = new AuthService();
    }

    // -----------------------------------------------------------------
    // Sign in
    // -----------------------------------------------------------------

    /**
     * GET /login
     *
     * @param Request $request
     * @return Response
     */
    public function showLogin(Request $request)
    {
        if ($this->user() !== null) {
            return $this->redirect('/');
        }

        // Carry the intended destination through the GET so it is still
        // there when the form is submitted.
        $intended = $this->intended('');
        if ($intended !== '') {
            Session::flash('_intended', $intended);
        }

        return $this->view('pages/auth/login', array(
            'title'  => View::t('auth.login.title'),
            'robots' => 'noindex, nofollow',
        ), 'layouts/auth');
    }

    /**
     * POST /login
     *
     * @param Request $request
     * @return Response
     */
    public function login(Request $request)
    {
        $input = array(
            'email'    => $request->str('email'),
            'password' => (string) $request->post('password', ''),
        );

        // Deliberately loose rules. The login form checks that something
        // was typed and nothing more — applying the password policy here
        // would tell an attacker which of their guesses could not
        // possibly be somebody's password, and would lock out any account
        // whose password predates a policy change.
        $v = $this->validate($input, array(
            'email'    => 'required|email|max:191',
            'password' => 'required|max:200',
        ), array(
            'email'    => View::t('auth.field.email'),
            'password' => View::t('auth.field.password'),
        ));

        if ($v->fails()) {
            return $this->back('/login', $v, $input);
        }

        $intended = $this->intended('/');
        $result   = $this->auth->attempt($input['email'], $input['password']);

        if (!$result['ok']) {
            if ($result['error'] === 'locked') {
                return $this->fail('/login', View::t('validation.throttled', array(':n' => $result['minutes'])));
            }
            // One message for every failure — wrong password, no such
            // account, suspended account. Anything more specific turns
            // this form into a way to find out which addresses exist.
            Session::flashInput($input);
            return $this->fail('/login', View::t('auth.error.invalid'));
        }

        $user = $result['user'];

        if ($this->mergedSomething($result)) {
            Session::flash('success', View::t('auth.merged'));
        }

        return $this->redirect($this->destinationFor($user, $intended));
    }

    /**
     * POST /logout
     *
     * A POST, not a GET. A sign-out link that works on GET can be
     * triggered by an image tag on another site, which is a small but
     * genuinely annoying cross-site attack.
     *
     * @param Request $request
     * @return Response
     */
    public function logout(Request $request)
    {
        $this->auth->logout();

        return $this->ok('/', View::t('auth.logged_out'));
    }

    // -----------------------------------------------------------------
    // Register
    // -----------------------------------------------------------------

    /**
     * GET /register
     *
     * @param Request $request
     * @return Response
     */
    public function showRegister(Request $request)
    {
        if ($this->user() !== null) {
            return $this->redirect('/');
        }

        if (!Config::get('app.features.registration', true)) {
            return $this->fail('/', View::t('auth.error.registration_closed'));
        }

        return $this->view('pages/auth/register', array(
            'title'  => View::t('auth.register.title'),
            'robots' => 'noindex, nofollow',
        ), 'layouts/auth');
    }

    /**
     * POST /register
     *
     * @param Request $request
     * @return Response
     */
    public function register(Request $request)
    {
        if (!Config::get('app.features.registration', true)) {
            return $this->fail('/', View::t('auth.error.registration_closed'));
        }

        $input = array(
            'name'             => $request->str('name'),
            'email'            => $request->str('email'),
            'password'         => (string) $request->post('password', ''),
            'password_confirm' => (string) $request->post('password_confirm', ''),
            'lang'             => $request->str('lang', (string) Config::get('i18n.default', 'en')),
            'track'            => $request->str('track', 'beginner'),
            'website'          => $request->str('website'), // honeypot
        );

        $v = $this->validate($input, array(
            // Deliberately NOT 'nohtml'. A display name is stored exactly
            // as typed and escaped on the way out, which is the rule
            // stated at the top of Validator: validation decides whether
            // to accept, escaping decides what is safe to print. Rejecting
            // a name containing a less-than sign would be sanitising in
            // the wrong layer, and it would give the false comfort that
            // output escaping could be skipped somewhere.
            'name'             => 'required|min:2|max:120',
            'email'            => 'required|email|max:191',
            'password'         => 'required|password',
            'password_confirm' => 'required|matches:password',
            'lang'             => 'required|lang',
            'track'            => 'required|in:beginner,intermediate,advanced',
            'website'          => 'honeypot',
        ), array(
            'name'             => View::t('auth.field.name'),
            'email'            => View::t('auth.field.email'),
            'password'         => View::t('auth.field.password'),
            'password_confirm' => View::t('auth.field.password_confirm'),
        ));

        if ($v->fails()) {
            return $this->back('/register', $v, $input);
        }

        $result = $this->auth->register($v->validated());

        if (!$result['ok']) {
            $message = $result['error'] === 'email_taken'
                ? View::t('auth.error.email_taken')
                : View::t('error.500.body');

            return $this->back('/register', array('email' => array($message)), $input);
        }

        // The code goes into a one-shot flash and is displayed by the next
        // request. It is never written anywhere else.
        Session::flash('_recovery_code', $result['recovery_code']);

        if ($this->mergedSomething($result)) {
            Session::flash('success', View::t('auth.merged'));
        }

        return $this->redirect('/recovery-code');
    }

    // -----------------------------------------------------------------
    // The one-time recovery code screen
    // -----------------------------------------------------------------

    /**
     * GET /recovery-code
     *
     * Reached only by redirect, straight after registration or a reset.
     * A direct visit has no flash to show and goes to the profile
     * instead — the code cannot be looked up again, by anybody, including
     * an administrator.
     *
     * @param Request $request
     * @return Response
     */
    public function showRecoveryCode(Request $request)
    {
        $code = Session::flashed('_recovery_code');

        if (!is_string($code) || $code === '') {
            return $this->redirect('/');
        }

        return $this->view('pages/auth/recovery_code', array(
            'title'  => View::t('auth.code.title'),
            'robots' => 'noindex, nofollow',
            'code'   => $code,
        ), 'layouts/auth');
    }

    // -----------------------------------------------------------------
    // Recovery
    // -----------------------------------------------------------------

    /**
     * GET /recover
     *
     * @param Request $request
     * @return Response
     */
    public function showRecover(Request $request)
    {
        return $this->view('pages/auth/recover', array(
            'title'  => View::t('auth.recover.title'),
            'robots' => 'noindex, nofollow',
        ), 'layouts/auth');
    }

    /**
     * POST /recover
     *
     * @param Request $request
     * @return Response
     */
    public function recover(Request $request)
    {
        $input = array(
            'email'            => $request->str('email'),
            'code'             => $request->str('code'),
            'password'         => (string) $request->post('password', ''),
            'password_confirm' => (string) $request->post('password_confirm', ''),
        );

        $v = $this->validate($input, array(
            'email'            => 'required|email|max:191',
            'code'             => 'required|min:12|max:20',
            'password'         => 'required|password',
            'password_confirm' => 'required|matches:password',
        ), array(
            'email'            => View::t('auth.field.email'),
            'code'             => View::t('auth.field.code'),
            'password'         => View::t('auth.field.new_password'),
            'password_confirm' => View::t('auth.field.password_confirm'),
        ));

        if ($v->fails()) {
            return $this->back('/recover', $v, $input);
        }

        $result = $this->auth->recover($input['email'], $input['code'], $input['password']);

        if (!$result['ok']) {
            if ($result['error'] === 'locked') {
                return $this->fail('/recover', View::t('validation.throttled', array(':n' => $result['minutes'])));
            }
            Session::flashInput($input);
            return $this->fail('/recover', View::t('auth.error.recover_invalid'));
        }

        // A fresh code, shown once, exactly as at signup.
        Session::flash('_recovery_code', $result['recovery_code']);
        Session::flash('success', View::t('auth.recover.done'));

        return $this->redirect('/recovery-code');
    }

    // -----------------------------------------------------------------
    // Helpers
    // -----------------------------------------------------------------

    /**
     * Did the guest merge actually move anything?
     *
     * Only worth telling somebody their bookmarks came across if some
     * did. A cheerful "your work has been transferred" after moving zero
     * rows reads as a lie.
     *
     * @param array $result
     * @return bool
     */
    private function mergedSomething(array $result)
    {
        if (!isset($result['merged']) || !is_array($result['merged'])) {
            return false;
        }

        foreach ($result['merged'] as $count) {
            if ((int) $count > 0) {
                return true;
            }
        }

        return false;
    }

    /**
     * Where a person lands after signing in.
     *
     * The page they were trying to reach, if there was one. Otherwise
     * /admin for an administrator, since that is almost always why they
     * signed in, and the home page for everybody else.
     *
     * @param array  $user
     * @param string $intended
     * @return string
     */
    private function destinationFor(array $user, $intended)
    {
        if ($intended !== '' && $intended !== '/') {
            return $intended;
        }

        $elevated = array('admin', 'superadmin', 'moderator');

        return in_array($user['role'], $elevated, true) ? '/admin' : '/';
    }
}
