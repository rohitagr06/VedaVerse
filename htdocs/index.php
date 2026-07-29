<?php
/**
 * VedaVerse — index.php
 * =====================================================================
 * The front controller. Every request to the site arrives here, because
 * .htaccess rewrites anything that is not a real file onto this one file.
 *
 * WHAT BELONGS IN THIS FILE
 *   Bootstrapping and routing. Nothing else. No queries, no business
 *   logic, no HTML. If you are tempted to add an if statement about
 *   verses here, it belongs in a controller.
 *
 * SCOPE AS SHIPPED IN STEP 1
 *   The core is complete and the router works, but the controllers,
 *   middleware and views arrive in later steps of the build order. So the
 *   route table below is deliberately short: a health check that proves
 *   the whole stack boots, and the error handling that every later route
 *   will rely on. Step 2 adds the middleware and the auth routes, Step 5
 *   adds the content routes, and this file grows a route table rather
 *   than growing logic.
 *
 * READING ORDER FOR A BEGINNER
 *   Top to bottom is the actual order of events. Autoloader, then config,
 *   then error handling, then the request, then routes, then dispatch,
 *   then send. Each stage can only use what came before it.
 * =====================================================================
 */

// ---------------------------------------------------------------------
// 1. Find our own classes
// ---------------------------------------------------------------------
// This is the only require in the application. Everything after it is
// loaded on demand by the autoloader.
// Recorded first so the timing at the bottom measures the whole request.
define('VEDAVERSE_START', microtime(true));

require_once __DIR__ . '/app/core/Autoloader.php';

use VedaVerse\Core\Autoloader;
use VedaVerse\Core\Cache;
use VedaVerse\Core\Config;
use VedaVerse\Core\Database;
use VedaVerse\Core\ErrorHandler;
use VedaVerse\Core\Logger;
use VedaVerse\Core\Request;
use VedaVerse\Core\Response;
use VedaVerse\Core\Router;
use VedaVerse\Core\View;
use VedaVerse\Services\I18nService;

Autoloader::register(__DIR__);

// Helpers define global functions — e(), t(), csrf_field(), url() — so
// they are required rather than autoloaded. Loaded before anything else
// so every later layer, including the error handler, can use them.
foreach (array('security', 'string', 'date', 'url', 'format') as $helper) {
    require_once __DIR__ . '/app/helpers/' . $helper . '.php';
}

// ---------------------------------------------------------------------
// 2. Configuration
// ---------------------------------------------------------------------
Config::init(__DIR__ . '/app/config');

// If the installer has not run, there is no database to talk to. Say so
// plainly instead of showing a stack trace about a missing connection.
if (!is_file(__DIR__ . '/app/config/local.php')) {
    if (is_file(__DIR__ . '/install.php')) {
        header('Location: /install.php');
        exit;
    }
    header('HTTP/1.1 503 Service Unavailable');
    header('Content-Type: text/html; charset=utf-8');
    echo '<!doctype html><meta charset="utf-8"><title>Not configured</title>'
       . '<p style="font-family:system-ui;padding:2rem">This site has not been set up yet, '
       . 'and the installer is missing. Upload install.php and open it in a browser.</p>';
    exit;
}

date_default_timezone_set((string) Config::get('app.timezone', 'UTC'));

// ---------------------------------------------------------------------
// 3. Error handling — registered before anything else can fail
// ---------------------------------------------------------------------
ErrorHandler::register();

// ---------------------------------------------------------------------
// 4. The request
// ---------------------------------------------------------------------
$request = Request::capture();

// The base URL is derived from this request rather than hardcoded, so the
// site keeps working when the free subdomain changes. Every later layer
// reads it from config rather than working it out again.
Config::set('app.url', $request->base());

// ---------------------------------------------------------------------
// 5. The view layer
// ---------------------------------------------------------------------
View::init();

// The default is set here so that anything failing BEFORE the middleware
// runs — a configuration error, a dead database — still renders its error
// page in a real language. SessionMiddleware then picks the visitor's
// actual language from the URL, their account, their session or their
// browser. Step 4 moves that logic into I18nService.
View::setLang((string) Config::get('i18n.default', 'en'));

View::share(array(
    'base_url'  => $request->base(),
    'site_name' => Config::get('app.name'),
));

// ---------------------------------------------------------------------
// 6. Routes
// ---------------------------------------------------------------------
$router = new Router();

// Short names, so a route reads as ->middleware('auth') rather than
// naming a fully-qualified class. A middleware may take one argument
// after a colon: 'throttle:login', 'role:moderator'.
$router->aliases(array(
    'auth'     => 'VedaVerse\\Middleware\\AuthMiddleware',
    'role'     => 'VedaVerse\\Middleware\\AdminMiddleware',
    'throttle' => 'VedaVerse\\Middleware\\RateLimitMiddleware',
));

/**
 * The global stack, outermost first. The order is deliberate and is
 * explained at the top of app/middleware/Middleware.php:
 *
 *   SecurityHeaders  attaches headers to EVERY response, including the
 *                    503 from maintenance mode and the 403 from CSRF.
 *   Session          starts the session and picks the language.
 *   Maintenance      needs the session to exist, because its whole point
 *                    is that an ADMIN can still get in. Put it before
 *                    Session and the bypass silently never fires, which
 *                    locks the owner out of the site they just closed.
 *   Csrf             needs the session too, to compare the token, and
 *                    refuses forged writes before any controller runs.
 */
$router->globalMiddleware(array(
    'VedaVerse\\Middleware\\SecurityHeadersMiddleware',
    'VedaVerse\\Middleware\\SessionMiddleware',
    'VedaVerse\\Middleware\\MaintenanceMiddleware',
    'VedaVerse\\Middleware\\CsrfMiddleware',
));

/**
 * Health check.
 *
 * The one route that exists in Step 1. It proves the whole chain works:
 * autoloading, configuration, the database connection, the cache, the
 * router and the response. Open /health after uploading and you know
 * within a second whether the deployment is sound.
 *
 * It reports status only — no versions, no paths, no credentials — because
 * it is a public URL.
 */
$router->get('/health', function (Request $req) {
    $checks = array();

    try {
        $value = Database::scalar('SELECT 1');
        $checks['database'] = ((int) $value === 1);
    } catch (Exception $e) {
        $checks['database'] = false;
    }

    try {
        Cache::set('health:probe', 'ok', 60);
        $checks['cache'] = (Cache::get('health:probe') === 'ok');
        Cache::forget('health:probe');
    } catch (Exception $e) {
        $checks['cache'] = false;
    }

    $checks['writable_logs'] = is_writable((string) Config::get('app.paths.logs'));

    $ok = true;
    foreach ($checks as $result) {
        if (!$result) { $ok = false; }
    }

    return Response::json(array(
        'ok'     => $ok,
        'checks' => $checks,
    ), $ok ? 200 : 503);
})->name('health');

/**
 * Home IS the Chariot Path.
 *
 * Not a landing page that links to it — the path itself. A returning
 * reader should land on the road they are walking, and a first-time
 * visitor should see what the road is before being asked for anything.
 * The nav's first tab points at / for the same reason.
 *
 * /path is kept as a second address for it, because the flash redirects
 * after switching track have somewhere honest to go and because a link
 * to "the path" reads better than a link to "/".
 */
$router->get('/', array('VedaVerse\\Controllers\\PathController', 'path'))->name('home');

/**
 * Accounts.
 *
 * There is ONE sign-in screen, for everybody including administrators —
 * see the note at the top of AuthController for why a second admin login
 * form would be a liability rather than a defence.
 *
 * The throttle scopes are separate on purpose. Somebody who has locked
 * themselves out of /login by mistyping must still be able to reach
 * /recover, which is the only way back in when there is no email reset.
 */
$router->get('/login',  array('VedaVerse\\Controllers\\AuthController', 'showLogin'))->name('login');
$router->post('/login', array('VedaVerse\\Controllers\\AuthController', 'login'))
       ->middleware('throttle:login');

$router->post('/logout', array('VedaVerse\\Controllers\\AuthController', 'logout'))->name('logout');

$router->get('/register',  array('VedaVerse\\Controllers\\AuthController', 'showRegister'))->name('register');
$router->post('/register', array('VedaVerse\\Controllers\\AuthController', 'register'))
       ->middleware('throttle:login');

$router->get('/recover',  array('VedaVerse\\Controllers\\AuthController', 'showRecover'))->name('recover');
$router->post('/recover', array('VedaVerse\\Controllers\\AuthController', 'recover'))
       ->middleware('throttle:recover');

// Reached only by redirect, straight after registration or a reset. A
// direct visit has nothing to show and bounces home — the code cannot be
// looked up again by anybody, including an administrator.
$router->get('/recovery-code', array('VedaVerse\\Controllers\\AuthController', 'showRecoveryCode'))
       ->name('recovery-code');

/**
 * The scripture.
 *
 * Every one of these is open to a guest, deliberately and permanently.
 * Reading is free and anonymous; so are saving, noting and marking
 * progress, because a guest's work is tagged with their year-long token
 * and merges into an account if they ever make one. Adding 'auth' to any
 * route in this block would quietly break the product's central promise.
 *
 * ORDER MATTERS BELOW. /chapter/{chapter}/verse/{verse} is registered
 * before /chapter/{number}, because the router takes the first pattern
 * that matches and a single-segment pattern would otherwise swallow the
 * longer address.
 */
$router->get('/chapters', array('VedaVerse\\Controllers\\ContentController', 'chapters'))->name('chapters');

$router->get('/chapter/{chapter}/verse/{verse}', array('VedaVerse\\Controllers\\ContentController', 'verse'))
       ->name('verse');

$router->get('/chapter/{number}', array('VedaVerse\\Controllers\\ContentController', 'chapter'))->name('chapter');

/**
 * What a reader can do TO a verse.
 *
 * All POST, all CSRF-checked by the global middleware, all redirecting
 * back to where the reader was. None of them answer JSON: these have to
 * keep working when a script has not loaded, which on an Indian mobile
 * connection is a normal Tuesday rather than an edge case.
 */
$router->post('/verse/{id}/read',     array('VedaVerse\\Controllers\\ContentController', 'markRead'));
$router->post('/verse/{id}/bookmark', array('VedaVerse\\Controllers\\ContentController', 'toggleBookmark'));
$router->post('/verse/{id}/note',     array('VedaVerse\\Controllers\\ContentController', 'saveNote'));

/**
 * The two doors.
 *
 * /topics is for somebody studying the book. /problems is for somebody
 * who has a problem and has very likely never opened it — and the
 * specification is explicit that the second is often the real front
 * door. Separate routes, separate templates, separate copy.
 */
$router->get('/topics',          array('VedaVerse\\Controllers\\TopicController', 'topics'))->name('topics');
$router->get('/topic/{slug}',    array('VedaVerse\\Controllers\\TopicController', 'topic'))->name('topic');
$router->get('/problems',        array('VedaVerse\\Controllers\\TopicController', 'problems'))->name('problems');
$router->get('/problem/{slug}',  array('VedaVerse\\Controllers\\TopicController', 'problem'))->name('problem');

/**
 * The Chariot Path — the primary navigation — and the other ways in.
 */
$router->get('/path',        array('VedaVerse\\Controllers\\PathController', 'path'))->name('path');
$router->post('/path/track', array('VedaVerse\\Controllers\\PathController', 'setTrack'));
$router->get('/explore',     array('VedaVerse\\Controllers\\PathController', 'explore'))->name('explore');

/**
 * The reader's own work, and the controls over their own data.
 *
 * Open to guests on purpose. A guest has bookmarks, notes and progress —
 * all tagged with their year-long token — and this is the page on which
 * the merge at registration becomes visible, which is acceptance test 5.
 *
 * Deletion is the exception: it needs an account, because there is
 * nothing else to delete.
 */
$router->get('/profile',         array('VedaVerse\\Controllers\\ProfileController', 'show'))->name('profile');
$router->get('/profile/export',  array('VedaVerse\\Controllers\\ProfileController', 'export'))->name('profile.export');
$router->post('/profile/delete', array('VedaVerse\\Controllers\\ProfileController', 'destroy'))
       ->middleware('auth');

/**
 * A placeholder for the admin panel, so the role check has something to
 * guard and acceptance test 8 — redirect when signed out, 403 when signed
 * in as a non-admin — can be run now rather than in Step 13.
 */
$router->get('/admin', function (Request $req) {
    return Response::html('<!doctype html><html lang="en"><head><meta charset="utf-8">'
        . '<title>Admin</title></head><body style="font-family:system-ui;padding:2rem">'
        . '<h1>Admin</h1><p>The panel is built in Step 13. This route exists now so the '
        . 'role check has something to protect.</p></body></html>');
})->middleware(array('auth', 'role:admin'))->name('admin');

/**
 * The design system, on one page.
 *
 * Visible on a local install, and to administrators on a live site. Not
 * secret — but it is not part of the product either, and a stray link to
 * it from a search result would be odd. noindex on the page, and the
 * check below on the route.
 */
$router->get('/styleguide', function (Request $req) {
    $isLocal = Config::get('app.env') === 'local';

    if (!$isLocal && !user_can('admin')) {
        return ErrorHandler::page(404);
    }

    return Response::html(View::render('pages/styleguide', array(
        'title'  => 'Design system',
        'robots' => 'noindex, nofollow',
    ), 'layouts/app'));
})->name('styleguide');

/**
 * The CONTENT, three languages side by side.
 *
 * The companion to /styleguide/strings, and the more important of the
 * two from Step 6 on. That page reviews 628 interface labels; this one
 * reviews the writing — translations, explanations, modern examples,
 * hooks, reflections.
 *
 * It exists because reviewing a chapter batch by clicking through
 * eighteen verse pages, each behind a mode switcher and a level
 * switcher, is a review nobody finishes. One page, one scroll.
 *
 * ?chapter=2 limits it to one chapter, which is how a Step 6 batch gets
 * reviewed.
 */
$router->get('/styleguide/content', function (Request $req) {
    $isLocal = Config::get('app.env') === 'local';

    if (!$isLocal && !user_can('admin')) {
        return ErrorHandler::page(404);
    }

    $chapter = $req->query('chapter');
    $chapter = ($chapter === null || $chapter === '') ? null : (int) $chapter;

    $repo    = new VedaVerse\Repositories\VerseRepository();
    $service = new VedaVerse\Services\ContentService();

    // Assembled through the same service the real page uses, in research
    // mode so every section is present. A review that read the tables
    // directly could pass while the page a reader sees is broken.
    $verses = array();
    foreach ($repo->allCurated($chapter) as $row) {
        $full = $service->verse(
            (int) $row['chapter_number'],
            (int) $row['verse_number'],
            'research'
        );
        if ($full !== null) {
            $verses[] = $full;
        }
    }

    return Response::html(View::render('pages/content_review', array(
        'title'         => 'Content review',
        'robots'        => 'noindex, nofollow',
        'verses'        => $verses,
        'languages'     => I18nService::languages(),
        'chapterFilter' => $chapter,
    ), 'layouts/app'));
})->name('styleguide.content');

/**
 * The interface string table, three languages side by side.
 *
 * Same audience and same guard as the style guide, and for the same
 * reason: it is a review tool, not a page in the product.
 *
 * It earns its place because tools/check-strings.php can prove the table
 * is complete and cannot prove it is any good. Whether the Hinglish
 * sounds like a person talking is a judgement, and a judgement needs the
 * three languages next to each other on a screen.
 */
$router->get('/styleguide/strings', function (Request $req) {
    $isLocal = Config::get('app.env') === 'local';

    if (!$isLocal && !user_can('admin')) {
        return ErrorHandler::page(404);
    }

    return Response::html(View::render('pages/strings', array(
        'title'     => 'Interface strings',
        'robots'    => 'noindex, nofollow',
        'groups'    => I18nService::byDomain(),
        'strings'   => I18nService::strings(),
        'report'    => I18nService::audit(),
        'languages' => I18nService::languages(),
    ), 'layouts/app'));
})->name('styleguide.strings');

// ---------------------------------------------------------------------
// 7. What to do when nothing matches
// ---------------------------------------------------------------------
$router->onNotFound(function (Request $req) {
    // Logged at notice level, not error: a 404 is usually a stale link or
    // a bot, and logging it as an error would bury the real problems.
    Logger::notice('404', array('path' => $req->path()));
    return ErrorHandler::page(404);
});

$router->onMethodNotAllowed(function (Request $req) {
    // The 400 wording — "that request did not make sense" — is right for
    // a wrong method, so it is reused rather than adding a seventh error
    // page nobody will ever read. The STATUS is corrected to 405, because
    // that is what tells a developer the route exists and the form is
    // posting to the wrong verb. Answering 400 there costs an hour.
    return ErrorHandler::page(400)->status(405);
});

// ---------------------------------------------------------------------
// 8. Run it
// ---------------------------------------------------------------------
$response = $router->dispatch($request);
$response->send();

// ---------------------------------------------------------------------
// 9. Tidy up
// ---------------------------------------------------------------------
// The connection is released explicitly rather than left to PHP's
// shutdown, because this host counts simultaneous connections and a
// slow-finishing request holding one open is a real cost.
Database::disconnect();

// A slow page is worth knowing about on shared hosting, where the entry
// process limit means a slow page is also a page that blocks others.
if (defined('VEDAVERSE_START')) {
    $elapsed = (microtime(true) - VEDAVERSE_START) * 1000;
    $budget  = (float) Config::get('app.performance.slow_request_ms', 2000);
    if ($elapsed > $budget) {
        Logger::warning('Slow request', array(
            'ms'      => round($elapsed, 1),
            'path'    => $request->path(),
            'queries' => Database::stats(),
        ));
    }
}
