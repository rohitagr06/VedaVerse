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

Autoloader::register(__DIR__);

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

// Language selection proper arrives with I18nService in Step 4. Until
// then, honour an explicit ?lang= and fall back to the configured default,
// which is enough for the error pages to be translated.
$requestedLang = $request->query('lang');
View::setLang(is_string($requestedLang) && $requestedLang !== ''
    ? $requestedLang
    : (string) Config::get('i18n.default', 'en'));

View::share(array(
    'base_url'  => $request->base(),
    'site_name' => Config::get('app.name'),
    'lang'      => View::lang(),
));

// ---------------------------------------------------------------------
// 6. Routes
// ---------------------------------------------------------------------
$router = new Router();

// Short names for middleware, so a route reads as ->middleware('auth').
// The classes themselves land in app/middleware/ in Step 2. Naming them
// here now would make every route fail closed, which is correct behaviour
// but not much use before the classes exist, so the map starts empty and
// Step 2 fills it in.
$router->aliases(array());

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
 * Home.
 *
 * A placeholder until Step 5 builds the Chariot Path. It renders through
 * the real View layer so that the template lookup, escaping and layout
 * handling are all exercised rather than assumed.
 */
$router->get('/', function (Request $req) {
    return Response::html(
        '<!doctype html><html lang="' . View::e(View::htmlLang()) . '">'
        . '<head><meta charset="utf-8">'
        . '<meta name="viewport" content="width=device-width, initial-scale=1">'
        . '<title>' . View::e(Config::get('app.name')) . '</title></head>'
        . '<body style="font-family:system-ui;max-width:36rem;margin:4rem auto;padding:0 1.5rem;line-height:1.6">'
        . '<h1>' . View::e(Config::get('app.name')) . '</h1>'
        . '<p>The foundation is installed and running. Content, the learning path and Sarathi '
        . 'arrive in the next build steps.</p>'
        . '<p><a href="/health">Health check</a></p>'
        . '</body></html>'
    );
})->name('home');

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
    return ErrorHandler::page(400);
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
