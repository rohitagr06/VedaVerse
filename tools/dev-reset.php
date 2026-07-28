<?php
/**
 * VedaVerse — tools/dev-reset.php
 * =====================================================================
 * Clears development state so a test run starts clean: rate-limit
 * counters, the settings cache, log files, and any account created by
 * the smoke test.
 *
 * USE
 *       php tools/dev-reset.php
 *
 * IT REFUSES TO RUN AGAINST A PRODUCTION CONFIGURATION.
 *   app/config/local.php must say env => 'local'. On a live site this
 *   script exits without touching anything. It also lives outside
 *   htdocs/, so it is never uploaded in the first place — the check is
 *   there for the case where somebody copies the whole repository up.
 *
 * WHAT IT DOES NOT TOUCH
 *   Real accounts, content, or anything else in the database. It deletes
 *   only rows it can identify as test data: accounts whose email ends in
 *   @vedaverse.test, and the throttle counters.
 */

$root = realpath(__DIR__ . '/../htdocs');

require $root . '/app/core/Autoloader.php';
VedaVerse\Core\Autoloader::register($root);
VedaVerse\Core\Config::init($root . '/app/config');

foreach (array('security', 'string', 'date', 'url', 'format') as $helper) {
    require_once $root . '/app/helpers/' . $helper . '.php';
}

use VedaVerse\Core\Cache;
use VedaVerse\Core\Config;
use VedaVerse\Core\Database;

if (Config::get('app.env') !== 'local') {
    fwrite(STDERR, "Refusing to run: app.env is not 'local'.\n");
    fwrite(STDERR, "This script only ever runs against a development configuration.\n");
    exit(1);
}

echo "Resetting development state\n";
echo "---------------------------\n";

// Rate-limit counters, so repeated smoke-test runs are not blocked by the
// per-address ceiling the previous run deliberately tripped.
try {
    $n = Database::execute('DELETE FROM login_attempts');
    echo "  rate-limit counters cleared ($n rows)\n";
} catch (Exception $e) {
    echo "  rate-limit counters: could not clear (" . $e->getMessage() . ")\n";
}

// Accounts created by the smoke test. The domain is reserved for exactly
// this, so nothing a human made can match.
try {
    $n = Database::execute("DELETE FROM users WHERE email LIKE '%@vedaverse.test'");
    echo "  test accounts removed ($n)\n";
} catch (Exception $e) {
    echo "  test accounts: could not remove\n";
}

// Guest rows left behind by an interrupted merge test.
foreach (array('bookmarks', 'notes', 'user_progress', 'user_reviews', 'quiz_attempts', 'recent_views') as $table) {
    try {
        Database::execute(
            'DELETE FROM `' . Database::identifier($table) . "` WHERE session_id LIKE 'smoketest%'"
        );
    } catch (Exception $e) {
        // The table may not exist yet in an early build. Not worth stopping for.
    }
}
echo "  orphaned guest rows removed\n";

// The settings cache, so a value changed directly in the database shows up
// immediately instead of after five minutes.
Cache::flush();
echo "  cache flushed\n";

// Log files.
$logs = glob(Config::get('app.paths.logs') . '/*.log');
if (is_array($logs)) {
    foreach ($logs as $log) {
        @unlink($log);
    }
    echo "  logs cleared (" . count($logs) . " file(s))\n";
}

echo "\nReady.\n";
