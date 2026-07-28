<?php
/**
 * VedaVerse — install.php
 * =====================================================================
 * The browser installer. There is no command line on this host, so this
 * file is the setup script: you upload it with the rest of the site, open
 * it in a browser, answer four questions, and delete it.
 *
 * WHAT IT DOES, IN ORDER
 *   1. Checks that the server can actually run VedaVerse and that the folders
 *      it needs to write to are writable.
 *   2. Asks for your four MySQL credentials and proves they work before
 *      going any further.
 *   3. Writes app/config/local.php with those credentials and two freshly
 *      generated secrets.
 *   4. Runs database/schema.sql ONE STATEMENT AT A TIME, and shows you a
 *      pass or fail line for every single one. If something fails, you
 *      see exactly which table and why, instead of a blank page.
 *   5. Creates your administrator account and shows the recovery code
 *      once.
 *   6. Deletes itself.
 *
 * WHY IT DELETES ITSELF
 *   An installer left on a live server is a way to overwrite the database
 *   configuration of a running site. VedaVerse refuses to reinstall over a
 *   finished install, but the only real fix is for the file to be gone.
 *   The last screen has a button. Press it.
 *
 * IF SOMETHING GOES WRONG
 *   Nothing here is destructive. Every table is CREATE TABLE IF NOT
 *   EXISTS, so re-running a half-finished install continues rather than
 *   wiping anything. To start completely fresh, run database/DROP_ALL.sql
 *   from your host's phpMyAdmin first — that one IS destructive.
 *
 * PHP 7.4 COMPATIBLE. No Composer, no shell, no outbound network calls.
 * =====================================================================
 */

// -----------------------------------------------------------------
// Bootstrap
// -----------------------------------------------------------------

// Errors are shown here on purpose. This is a setup tool being run by the
// site owner, and a silent failure during installation is far worse than a
// visible one. The live site does the opposite: see ErrorHandler.
error_reporting(E_ALL);
ini_set('display_errors', '1');

date_default_timezone_set('UTC');

define('VEDAVERSE_ROOT', __DIR__);
define('VEDAVERSE_MIN_PHP', '7.4.0');

require_once VEDAVERSE_ROOT . '/app/core/Autoloader.php';
\VedaVerse\Core\Autoloader::register(VEDAVERSE_ROOT);
\VedaVerse\Core\Config::init(VEDAVERSE_ROOT . '/app/config');

use VedaVerse\Core\Config;
use VedaVerse\Core\Validator;

session_name('vv_install');
session_start();

// -----------------------------------------------------------------
// Guard: refuse to run over a finished installation
// -----------------------------------------------------------------

$alreadyInstalled = vv_is_installed();
$unlocked         = isset($_SESSION['vv_install_unlocked']) && $_SESSION['vv_install_unlocked'] === true;

// -----------------------------------------------------------------
// CSRF for the installer's own forms
// -----------------------------------------------------------------

if (empty($_SESSION['vv_install_token'])) {
    $_SESSION['vv_install_token'] = bin2hex(random_bytes(32));
}
$token = $_SESSION['vv_install_token'];

$step     = isset($_POST['step']) ? (string) $_POST['step'] : 'welcome';
$isPost   = ($_SERVER['REQUEST_METHOD'] === 'POST');
$errors   = array();
$notices  = array();
$results  = array();   // per-statement schema results
$recovery = null;      // the code shown once at the end

if ($isPost) {
    // hash_equals rather than === so the comparison cannot be timed.
    $sent = isset($_POST['_token']) ? (string) $_POST['_token'] : '';
    if (!hash_equals($token, $sent)) {
        $errors[] = 'This form expired. The page has been reloaded — please try again.';
        $step     = 'welcome';
        $isPost   = false;
    }
}

if ($alreadyInstalled && !$unlocked && $step !== 'unlock' && $step !== 'selfdestruct') {
    $step   = 'locked';
    $isPost = false;
}

// =====================================================================
// STEP HANDLERS
// =====================================================================

if ($isPost) {
    switch ($step) {

        // -------------------------------------------------------------
        case 'unlock':
            // Deliberately awkward: to reinstall over a working site you
            // have to type the words out. There is no accidental path to
            // this screen.
            if (strtoupper(trim((string) vv_post('confirm'))) === 'REINSTALL') {
                $_SESSION['vv_install_unlocked'] = true;
                $step = 'requirements';
            } else {
                $errors[] = 'Type REINSTALL exactly, in capitals, to continue.';
                $step     = 'locked';
            }
            break;

        // -------------------------------------------------------------
        // The welcome screen's button leads to the server check, and the
        // server check's button leads to the database form. Two separate
        // cases, so neither screen can be skipped by accident.
        case 'welcome':
            $step = 'requirements';
            break;

        // -------------------------------------------------------------
        case 'requirements':
            $step = 'database';
            break;

        // -------------------------------------------------------------
        case 'database':
            $db = array(
                'host'     => vv_post('db_host', 'localhost'),
                'database' => vv_post('db_name'),
                'username' => vv_post('db_user'),
                'password' => vv_post('db_pass'),
            );

            if ($db['host'] === '')     { $errors[] = 'The database host is required. On InfinityFree it looks like sql123.infinityfree.com, not localhost.'; }
            if ($db['database'] === '') { $errors[] = 'The database name is required.'; }
            if ($db['username'] === '') { $errors[] = 'The database username is required.'; }

            if ($errors === array()) {
                $test = vv_test_connection($db);
                if ($test !== true) {
                    $errors[] = $test;
                } else {
                    $_SESSION['vv_install_db'] = $db;

                    $written = vv_write_local_config($db);
                    if ($written !== true) {
                        $errors[] = $written;
                    } else {
                        $notices[] = 'Connected successfully, and app/config/local.php has been written.';
                        $step      = 'schema';
                    }
                }
            }

            if ($errors !== array()) {
                $step = 'database';
            }
            break;

        // -------------------------------------------------------------
        case 'schema':
            $db = isset($_SESSION['vv_install_db']) ? $_SESSION['vv_install_db'] : null;
            if (!is_array($db)) {
                $errors[] = 'The database details were lost. Please enter them again.';
                $step     = 'database';
                break;
            }

            $results = vv_run_sql_file($db, VEDAVERSE_ROOT . '/database/schema.sql');

            $failed = 0;
            foreach ($results as $r) {
                if (!$r['ok']) { $failed++; }
            }

            if ($failed === 0) {
                vv_prepare_directories();
                $notices[] = 'Every statement ran cleanly.';
                $step      = 'schema_done';
            } else {
                $errors[] = $failed . ' statement(s) failed. Read the red lines below, fix the cause, and run this step again. Nothing was lost — re-running is safe.';
                $step     = 'schema_result';
            }
            break;

        // -------------------------------------------------------------
        case 'admin':
            $db = isset($_SESSION['vv_install_db']) ? $_SESSION['vv_install_db'] : null;
            if (!is_array($db)) {
                $errors[] = 'The database details were lost. Please enter them again.';
                $step     = 'database';
                break;
            }

            $input = array(
                'name'             => vv_post('admin_name'),
                'email'            => vv_post('admin_email'),
                'password'         => vv_post('admin_password'),
                'password_confirm' => vv_post('admin_password_confirm'),
                'site_name'        => vv_post('site_name', 'VedaVerse — The Gita, Decoded'),
                'lang'             => vv_post('admin_lang', 'en'),
            );

            // The same Validator the live site uses, so the password policy
            // is enforced in exactly one place.
            $v = Validator::make($input, array(
                'name'             => 'required|max:120',
                'email'            => 'required|email|max:191',
                'password'         => 'required|password',
                'password_confirm' => 'required|matches:password',
                'site_name'        => 'required|max:120',
                'lang'             => 'required|lang',
            ), array(
                'name'             => 'Your name',
                'email'            => 'Email',
                'password'         => 'Password',
                'password_confirm' => 'Password confirmation',
                'site_name'        => 'Site name',
            ));

            if ($v->fails()) {
                $errors = array_merge($errors, $v->all());
                $step   = 'admin';
                break;
            }

            $created = vv_create_admin($db, $input);
            if (is_string($created)) {
                $errors[] = $created;
                $step     = 'admin';
            } else {
                $recovery = $created['recovery_code'];
                $_SESSION['vv_install_recovery'] = $recovery;
                $step = 'finished';
            }
            break;

        // -------------------------------------------------------------
        case 'selfdestruct':
            $removed = @unlink(__FILE__);
            // Session data held database credentials. Clear it either way.
            $_SESSION = array();
            session_destroy();

            vv_render_goodbye($removed);
            exit;
    }
}

// Screens reached by a plain link rather than a form post.
if (!$isPost && isset($_GET['step'])) {
    $requested = (string) $_GET['step'];
    if (in_array($requested, array('requirements', 'database', 'schema_done', 'admin'), true)) {
        if (!$alreadyInstalled || $unlocked) {
            $step = $requested;
        }
    }
}

// =====================================================================
// FUNCTIONS
// =====================================================================

/**
 * A trimmed POST value.
 *
 * @param string $key
 * @param string $default
 * @return string
 */
function vv_post($key, $default = '')
{
    if (!isset($_POST[$key]) || !is_string($_POST[$key])) {
        return $default;
    }
    return trim($_POST[$key]);
}

/**
 * Escape for HTML. The installer runs before the rest of the app is
 * usable, so it carries its own copy rather than depending on anything.
 *
 * @param mixed $value
 * @return string
 */
function vv_e($value)
{
    return htmlspecialchars((string) $value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}

/**
 * Has VedaVerse already been installed here?
 *
 * Two conditions, both required: the config file exists AND the database
 * says an install finished. Either one alone is a half-finished state that
 * the installer should be allowed to continue from.
 *
 * @return bool
 */
function vv_is_installed()
{
    if (!is_file(VEDAVERSE_ROOT . '/app/config/local.php')) {
        return false;
    }

    try {
        $cfg = Config::all('database');
        $pdo = vv_connect(array(
            'host'     => isset($cfg['host']) ? $cfg['host'] : '',
            'database' => isset($cfg['database']) ? $cfg['database'] : '',
            'username' => isset($cfg['username']) ? $cfg['username'] : '',
            'password' => isset($cfg['password']) ? $cfg['password'] : '',
        ));

        $stmt = $pdo->prepare("SELECT setting_value FROM settings WHERE setting_key = 'installed_at' LIMIT 1");
        $stmt->execute();
        $value = $stmt->fetchColumn(0);

        return is_string($value) && trim($value) !== '';
    } catch (Exception $e) {
        return false;
    } catch (Throwable $e) {
        return false;
    }
}

/**
 * Open a PDO connection from a credentials array.
 *
 * @param array $db
 * @return PDO
 * @throws PDOException
 */
function vv_connect(array $db)
{
    $dsn = 'mysql:host=' . $db['host'] . ';dbname=' . $db['database'] . ';charset=utf8mb4';

    $options = array(
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
        PDO::ATTR_TIMEOUT            => 8,
    );

    // PHP 8.5 moved the MySQL-specific PDO constants into a Pdo\Mysql class
    // and deprecated the PDO::MYSQL_* names. Database::initCommandAttribute()
    // picks whichever this PHP version has — see the comment there for why it
    // is written with defined() rather than naming the class directly.
    $options[VedaVerse\Core\Database::initCommandAttribute()] =
        'SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci';

    return new PDO($dsn, $db['username'], $db['password'], $options);
}

/**
 * Try the credentials and translate the failure into something a beginner
 * can act on.
 *
 * @param array $db
 * @return true|string True, or an error message.
 */
function vv_test_connection(array $db)
{
    try {
        $pdo = vv_connect($db);

        // Confirm the connection really is utf8mb4. A connection that
        // negotiates latin1 will accept Devanagari and store it as ????,
        // and the damage happens at write time so it cannot be repaired
        // afterwards by changing the display.
        $row = $pdo->query("SHOW VARIABLES LIKE 'character_set_client'")->fetch();
        if (is_array($row) && isset($row['Value']) && stripos($row['Value'], 'utf8') === false) {
            return 'Connected, but the connection character set is ' . vv_e($row['Value'])
                 . ' rather than utf8mb4. Hindi text would be stored as question marks. Ask your host to enable utf8mb4.';
        }

        return true;

    } catch (PDOException $e) {
        $message = $e->getMessage();

        // The three failures that account for almost every support
        // question, named in plain language.
        if (stripos($message, 'Access denied') !== false) {
            return 'The database refused those details.<br><br>'
                 . '<strong>On InfinityFree:</strong> check the username and password. The username '
                 . 'usually starts with "if0_" and is NOT your control-panel login.<br><br>'
                 . '<strong>Testing locally against XAMPP, MAMP or a system MySQL:</strong> the user '
                 . 'probably exists for the wrong host. MySQL treats 127.0.0.1 and localhost as '
                 . 'different hosts, so a user created as <code>\'name\'@\'%\'</code> is still '
                 . 'refused when you connect to 127.0.0.1. Create it for localhost as well:<br>'
                 . '<code>CREATE USER \'name\'@\'localhost\' IDENTIFIED BY \'password\';<br>'
                 . 'GRANT ALL ON dbname.* TO \'name\'@\'localhost\';</code>';
        }
        if (stripos($message, 'Unknown database') !== false) {
            return 'That database name does not exist on the server. Create the database in your host control panel first, then copy its exact name here.';
        }
        if (stripos($message, 'getaddrinfo') !== false || stripos($message, 'Unknown MySQL server host') !== false || stripos($message, 'php_network_getaddresses') !== false) {
            return 'That host name could not be found. On InfinityFree it is not "localhost" — it looks like sql123.infinityfree.com and is shown on the MySQL Databases page.';
        }

        return 'Could not connect: ' . vv_e($message);
    }
}

/**
 * Write app/config/local.php with the credentials and two new secrets.
 *
 * @param array $db
 * @return true|string
 */
function vv_write_local_config(array $db)
{
    $path = VEDAVERSE_ROOT . '/app/config/local.php';

    if (file_exists($path) && !is_writable($path)) {
        return 'app/config/local.php exists but is not writable. Set its permissions to 644 over FTP and try again.';
    }
    if (!file_exists($path) && !is_writable(dirname($path))) {
        return 'The folder app/config is not writable, so the settings file cannot be created. Set the folder to 755 over FTP and try again.';
    }

    // Two independent secrets. random_bytes is the cryptographically
    // secure source — never use rand() or uniqid() for these.
    $pepper  = bin2hex(random_bytes(32));
    $signing = bin2hex(random_bytes(32));

    // A local install is configured AS a local install.
    //
    // Defaulting to production and asking the developer to edit the file
    // afterwards means they forget, and then error pages hide the very
    // detail they need and the development tooling refuses to run. Both
    // failures look like something else, and neither points at the cause.
    $isLocal = vv_is_local_request();

    $php  = "<?php\n";
    $php .= "/**\n";
    $php .= " * VedaVerse — app/config/local.php\n";
    $php .= " * ------------------------------------------------------------------\n";
    $php .= " * GENERATED BY install.php ON " . gmdate('Y-m-d H:i:s') . " UTC. DO NOT COMMIT THIS FILE.\n";
    $php .= " *\n";
    $php .= " * It holds the only real secrets in the application. Everything else\n";
    $php .= " * in app/config/ is safe to share. If you ever paste a config file\n";
    $php .= " * into a forum for help, make sure it is not this one.\n";
    $php .= " *\n";
    $php .= " * signing_secret must match the Cloudflare Worker secret exactly:\n";
    $php .= " *     wrangler secret put SIGNING_SECRET\n";
    $php .= " * Copy the value below when you set it up. If the two differ by one\n";
    $php .= " * character, every chat request comes back 401 and the site silently\n";
    $php .= " * falls back to the offline responder.\n";
    $php .= " */\n\n";
    $php .= "return array(\n";
    $php .= "    'app' => array(\n";
    $php .= "        'env'   => '" . ($isLocal ? 'local' : 'production') . "',\n";
    $php .= "        'debug' => " . ($isLocal ? 'true' : 'false') . ",\n";
    $php .= "    ),\n";
    $php .= "    'database' => array(\n";
    $php .= "        'host'     => " . var_export($db['host'], true) . ",\n";
    $php .= "        'database' => " . var_export($db['database'], true) . ",\n";
    $php .= "        'username' => " . var_export($db['username'], true) . ",\n";
    $php .= "        'password' => " . var_export($db['password'], true) . ",\n";
    $php .= "    ),\n";
    $php .= "    'security' => array(\n";
    $php .= "        'pepper' => " . var_export($pepper, true) . ",\n";
    $php .= "    ),\n";
    $php .= "    'ai' => array(\n";
    $php .= "        'worker_url'     => '',\n";
    $php .= "        'signing_secret' => " . var_export($signing, true) . ",\n";
    $php .= "    ),\n";
    $php .= ");\n";

    if (@file_put_contents($path, $php, LOCK_EX) === false) {
        return 'Could not write app/config/local.php. Check the folder permissions over FTP.';
    }

    @chmod($path, 0644);

    // Reload configuration so the rest of this request sees the new values.
    Config::init(VEDAVERSE_ROOT . '/app/config');

    return true;
}

/**
 * Is this installer running on a development machine?
 *
 * Judged by the address the BROWSER used, not by the database host — a
 * local site can legitimately point at a remote database, and a live site
 * never answers on localhost.
 *
 * Getting this wrong in the cautious direction is harmless: a production
 * install misread as local would show error detail, which is why the
 * patterns below are exact rather than fuzzy. Nothing here matches a real
 * domain. .test and .local are reserved for exactly this and can never be
 * registered.
 *
 * @return bool
 */
function vv_is_local_request()
{
    $host = isset($_SERVER['HTTP_HOST']) ? strtolower((string) $_SERVER['HTTP_HOST']) : '';

    // Drop the port.
    $colon = strpos($host, ':');
    if ($colon !== false) {
        $host = substr($host, 0, $colon);
    }

    if (in_array($host, array('localhost', '127.0.0.1', '::1', '[::1]'), true)) {
        return true;
    }

    foreach (array('.local', '.test', '.localhost') as $suffix) {
        if (substr($host, -strlen($suffix)) === $suffix) {
            return true;
        }
    }

    return false;
}

/**
 * Split a .sql file into statements and run them one at a time.
 *
 * Running the file as one big query would give a single pass or fail for
 * fifty tables, which tells you nothing when it breaks. One statement at a
 * time costs a few more round trips and produces a report you can act on.
 *
 * @param array  $db
 * @param string $file
 * @return array<int,array{label:string,ok:bool,error:string}>
 */
function vv_run_sql_file(array $db, $file)
{
    $out = array();

    if (!is_file($file)) {
        return array(array(
            'label' => basename($file),
            'ok'    => false,
            'error' => 'The file is missing. Upload the whole database/ folder over FTP.',
        ));
    }

    $sql = file_get_contents($file);
    if ($sql === false) {
        return array(array('label' => basename($file), 'ok' => false, 'error' => 'The file could not be read.'));
    }

    try {
        $pdo = vv_connect($db);
    } catch (PDOException $e) {
        return array(array('label' => 'Connection', 'ok' => false, 'error' => vv_e($e->getMessage())));
    }

    foreach (vv_split_sql($sql) as $statement) {
        $label = vv_describe_statement($statement);

        try {
            $pdo->exec($statement);
            $out[] = array('label' => $label, 'ok' => true, 'error' => '');

        } catch (PDOException $e) {
            $code    = $e->getCode();
            $message = $e->getMessage();

            // 42000 with "Duplicate key name" means the index is already
            // there from an earlier run. That is success, not failure, and
            // treating it as an error would make a resumed install look
            // broken. The FULLTEXT index is the usual case.
            if (stripos($message, 'Duplicate key name') !== false) {
                $out[] = array('label' => $label . ' (already present)', 'ok' => true, 'error' => '');
                continue;
            }

            $out[] = array(
                'label' => $label,
                'ok'    => false,
                'error' => '[' . vv_e($code) . '] ' . vv_e($message),
            );
        }
    }

    return $out;
}

/**
 * Break a .sql file into statements.
 *
 * Simple on purpose. It relies on the two rules stated at the top of
 * schema.sql: every statement ends with a semicolon at the end of a line,
 * and no string literal in the file contains a semicolon. A general SQL
 * parser is not worth writing for a file we control.
 *
 * @param string $sql
 * @return array<int,string>
 */
function vv_split_sql($sql)
{
    $statements = array();
    $buffer     = '';

    foreach (preg_split('/\R/', $sql) as $line) {
        $trimmed = trim($line);

        if ($trimmed === '' || strpos($trimmed, '--') === 0) {
            continue;
        }

        $buffer .= $line . "\n";

        if (substr($trimmed, -1) === ';') {
            $statements[] = trim($buffer);
            $buffer       = '';
        }
    }

    if (trim($buffer) !== '') {
        $statements[] = trim($buffer);
    }

    return $statements;
}

/**
 * A short human label for a statement, for the progress report.
 *
 * @param string $statement
 * @return string
 */
function vv_describe_statement($statement)
{
    $flat = preg_replace('/\s+/', ' ', $statement);

    if (preg_match('/^CREATE TABLE (?:IF NOT EXISTS )?`?([a-zA-Z0-9_]+)`?/i', $flat, $m) === 1) {
        return 'Create table ' . $m[1];
    }
    if (preg_match('/^ALTER TABLE `?([a-zA-Z0-9_]+)`?/i', $flat, $m) === 1) {
        return 'Index on ' . $m[1];
    }
    if (preg_match('/^INSERT(?: IGNORE)? INTO `?([a-zA-Z0-9_]+)`?/i', $flat, $m) === 1) {
        return 'Seed row in ' . $m[1];
    }
    if (preg_match('/^DROP TABLE (?:IF EXISTS )?`?([a-zA-Z0-9_]+)`?/i', $flat, $m) === 1) {
        return 'Drop table ' . $m[1];
    }
    if (stripos($flat, 'SET FOREIGN_KEY_CHECKS') === 0) {
        return 'Foreign key checks';
    }

    return substr($flat, 0, 60) . (strlen($flat) > 60 ? '…' : '');
}

/**
 * Create the folders VedaVerse writes to, and drop a deny rule into each one.
 *
 * The .htaccess files matter more than they look. storage/ holds session
 * files and logs, and uploads/imports holds whatever CSV somebody uploaded.
 * Without these rules those are all public URLs.
 *
 * @return array<int,string> Anything that could not be created.
 */
function vv_prepare_directories()
{
    $problems = array();

    $writable = array(
        'storage', 'storage/cache', 'storage/logs', 'storage/sessions',
        'storage/backups', 'storage/temp',
        'uploads', 'uploads/certificates', 'uploads/imports', 'uploads/avatars',
        'assets/data',
    );

    foreach ($writable as $relative) {
        $path = VEDAVERSE_ROOT . '/' . $relative;
        if (!is_dir($path) && !@mkdir($path, 0755, true)) {
            $problems[] = $relative . ' could not be created.';
            continue;
        }
        if (!is_writable($path)) {
            $problems[] = $relative . ' exists but is not writable (set it to 755).';
        }
    }

    // Deny-everything rule for folders no browser should ever reach. Each
    // block is wrapped so that a server missing the newer or the older
    // Apache syntax still applies one of them.
    $deny = "# Generated by install.php. Do not remove.\n"
          . "# This folder must never be readable over the web.\n"
          . "<IfModule mod_authz_core.c>\n"
          . "    Require all denied\n"
          . "</IfModule>\n"
          . "<IfModule !mod_authz_core.c>\n"
          . "    Order allow,deny\n"
          . "    Deny from all\n"
          . "</IfModule>\n";

    $denyDirs = array('storage', 'app', 'database', 'vendor-lite', 'uploads/imports');
    foreach ($denyDirs as $relative) {
        $path = VEDAVERSE_ROOT . '/' . $relative;
        if (is_dir($path)) {
            @file_put_contents($path . '/.htaccess', $deny);
        }
    }

    // Belt and braces: a blank index.php in every sensitive folder, so a
    // server with .htaccess disabled shows an empty page rather than a
    // directory listing of your configuration files.
    $guard    = "<?php\n// Intentionally blank. Stops a directory listing if .htaccess is ignored.\n";
    $guardDirs = array(
        'app', 'app/config', 'app/core', 'app/middleware', 'app/controllers',
        'app/services', 'app/repositories', 'app/models', 'app/helpers', 'app/views',
        'storage', 'storage/cache', 'storage/logs', 'storage/sessions',
        'storage/backups', 'storage/temp',
        'database', 'uploads', 'uploads/certificates', 'uploads/imports', 'uploads/avatars',
        'vendor-lite',
    );
    foreach ($guardDirs as $relative) {
        $path = VEDAVERSE_ROOT . '/' . $relative;
        if (is_dir($path) && !is_file($path . '/index.php')) {
            @file_put_contents($path . '/index.php', $guard);
        }
    }

    return $problems;
}

/**
 * Create the first administrator and mark the install finished.
 *
 * @param array $db
 * @param array $input
 * @return array|string The created user data, or an error message.
 */
function vv_create_admin(array $db, array $input)
{
    try {
        $pdo = vv_connect($db);
    } catch (PDOException $e) {
        return 'Could not connect to the database: ' . vv_e($e->getMessage());
    }

    $policy   = Config::get('security.recovery_code', array());
    $length   = isset($policy['length']) ? (int) $policy['length'] : 12;
    $alphabet = isset($policy['alphabet']) ? (string) $policy['alphabet'] : 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';

    $recovery = vv_random_code($length, $alphabet);
    $uuid     = vv_uuid4();

    $cost = (int) Config::get('security.password.cost', 10);

    try {
        $pdo->beginTransaction();

        // An existing account with this email means the installer is being
        // re-run. Promote and re-key it rather than failing, because the
        // owner's most likely reason for coming back here is a lost
        // password.
        $stmt = $pdo->prepare('SELECT id FROM users WHERE email = :email LIMIT 1');
        $stmt->execute(array(':email' => $input['email']));
        $existing = $stmt->fetchColumn(0);

        $hash         = password_hash($input['password'], PASSWORD_BCRYPT, array('cost' => $cost));
        $recoveryHash = password_hash($recovery, PASSWORD_BCRYPT, array('cost' => $cost));

        if ($existing) {
            $userId = (int) $existing;
            $stmt = $pdo->prepare(
                'UPDATE users
                    SET name = :name, password_hash = :hash, recovery_code_hash = :rhash,
                        recovery_code_issued_at = NOW(), role = :role, status = :status,
                        preferred_lang = :lang
                  WHERE id = :id'
            );
            $stmt->execute(array(
                ':name'   => $input['name'],
                ':hash'   => $hash,
                ':rhash'  => $recoveryHash,
                ':role'   => 'superadmin',
                ':status' => 'active',
                ':lang'   => $input['lang'],
                ':id'     => $userId,
            ));
        } else {
            $stmt = $pdo->prepare(
                'INSERT INTO users
                    (uuid, name, email, password_hash, recovery_code_hash, recovery_code_issued_at,
                     role, status, preferred_lang, track, created_at)
                 VALUES
                    (:uuid, :name, :email, :hash, :rhash, NOW(),
                     :role, :status, :lang, :track, NOW())'
            );
            $stmt->execute(array(
                ':uuid'   => $uuid,
                ':name'   => $input['name'],
                ':email'  => $input['email'],
                ':hash'   => $hash,
                ':rhash'  => $recoveryHash,
                ':role'   => 'superadmin',
                ':status' => 'active',
                ':lang'   => $input['lang'],
                ':track'  => 'advanced',
            ));
            $userId = (int) $pdo->lastInsertId();
        }

        // The two companion rows, so the profile and settings pages never
        // have to cope with a missing record.
        $pdo->prepare('INSERT IGNORE INTO user_profiles (user_id, certificate_name) VALUES (:id, :name)')
            ->execute(array(':id' => $userId, ':name' => $input['name']));

        $pdo->prepare('INSERT IGNORE INTO user_settings (user_id) VALUES (:id)')
            ->execute(array(':id' => $userId));

        // Settings that came from this screen.
        $settings = array(
            'site_name'    => $input['site_name'],
            'default_lang' => $input['lang'],
            'installed_at' => gmdate('Y-m-d H:i:s'),
            'app_version'  => (string) Config::get('app.version', '1.0.0'),
            'schema_version' => (string) Config::get('app.schema_version', '1.0.0'),
        );
        $stmt = $pdo->prepare(
            'INSERT INTO settings (setting_key, setting_value) VALUES (:k, :v)
             ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)'
        );
        foreach ($settings as $key => $value) {
            $stmt->execute(array(':k' => $key, ':v' => $value));
        }

        // First entry in the audit trail.
        $pdo->prepare(
            'INSERT INTO audit_logs (user_id, action, target_type, target_id, meta_json, created_at)
             VALUES (:uid, :action, :ttype, :tid, :meta, NOW())'
        )->execute(array(
            ':uid'    => $userId,
            ':action' => 'install',
            ':ttype'  => 'user',
            ':tid'    => $userId,
            ':meta'   => json_encode(array('via' => 'install.php')),
        ));

        $pdo->commit();

        return array('user_id' => $userId, 'recovery_code' => $recovery);

    } catch (PDOException $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }

        if (stripos($e->getMessage(), "doesn't exist") !== false || stripos($e->getMessage(), 'Base table') !== false) {
            return 'The tables are missing. Go back and run the database step first.';
        }
        return 'Could not create the administrator: ' . vv_e($e->getMessage());
    }
}

/**
 * A random code from a restricted alphabet.
 *
 * random_int, not rand: this is the entire account-recovery mechanism, and
 * a predictable code is the same as no code. The alphabet has no O, 0, I,
 * 1 or l, because this gets written on paper and read back later.
 *
 * @param int    $length
 * @param string $alphabet
 * @return string
 */
function vv_random_code($length, $alphabet)
{
    $max  = strlen($alphabet) - 1;
    $code = '';
    for ($i = 0; $i < $length; $i++) {
        $code .= $alphabet[random_int(0, $max)];
    }
    // Grouped in fours so it can be read aloud without losing your place.
    return implode('-', str_split($code, 4));
}

/**
 * A version 4 UUID.
 *
 * @return string
 */
function vv_uuid4()
{
    $bytes = random_bytes(16);
    $bytes[6] = chr((ord($bytes[6]) & 0x0f) | 0x40); // version 4
    $bytes[8] = chr((ord($bytes[8]) & 0x3f) | 0x80); // variant 1
    return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($bytes), 4));
}

/**
 * Everything the server needs to provide.
 *
 * @return array<int,array{label:string,ok:bool,detail:string,fatal:bool}>
 */
function vv_requirements()
{
    $checks = array();

    $checks[] = array(
        'label'  => 'PHP ' . VEDAVERSE_MIN_PHP . ' or newer',
        'ok'     => version_compare(PHP_VERSION, VEDAVERSE_MIN_PHP, '>='),
        'detail' => 'You are running PHP ' . PHP_VERSION . '. On InfinityFree, set this in the control panel under PHP Settings — 8.1 or 8.2 is ideal.',
        'fatal'  => true,
    );

    foreach (array(
        'pdo_mysql' => 'Talks to MySQL.',
        'mbstring'  => 'Counts Devanagari characters correctly. Without it, Hindi text gets truncated mid-character.',
        'json'      => 'Used by the cache, the API and the offline bundle.',
    ) as $ext => $why) {
        $checks[] = array(
            'label'  => 'PHP extension: ' . $ext,
            'ok'     => extension_loaded($ext),
            'detail' => $why,
            'fatal'  => true,
        );
    }

    $checks[] = array(
        'label'  => 'Secure random numbers',
        'ok'     => function_exists('random_bytes'),
        'detail' => 'Needed for session tokens, CSRF tokens and recovery codes.',
        'fatal'  => true,
    );

    $checks[] = array(
        'label'  => 'database/schema.sql is present',
        'ok'     => is_file(VEDAVERSE_ROOT . '/database/schema.sql'),
        'detail' => 'Upload the whole database/ folder over FTP.',
        'fatal'  => true,
    );

    $checks[] = array(
        'label'  => 'app/config is writable',
        'ok'     => is_writable(VEDAVERSE_ROOT . '/app/config'),
        'detail' => 'The installer writes local.php here. Set the folder to 755 over FTP.',
        'fatal'  => true,
    );

    // Not fatal: the installer creates these, and the app falls back to the
    // database cache layer if the folder never becomes writable.
    $storage = VEDAVERSE_ROOT . '/storage';
    $checks[] = array(
        'label'  => 'storage/ is writable',
        'ok'     => (is_dir($storage) && is_writable($storage)) || is_writable(VEDAVERSE_ROOT),
        'detail' => 'Holds logs, sessions and the file cache. The installer will create it.',
        'fatal'  => false,
    );

    $checks[] = array(
        'label'  => 'GD image library',
        'ok'     => extension_loaded('gd'),
        'detail' => 'Only needed for the QR code on certificates. Everything else works without it.',
        'fatal'  => false,
    );

    return $checks;
}

// =====================================================================
// PRESENTATION
// =====================================================================

/**
 * The final screen, shown after the installer deletes itself. Rendered
 * separately because at that point the file is gone and there is nothing
 * left to link back to.
 *
 * @param bool $removed
 * @return void
 */
function vv_render_goodbye($removed)
{
    ?><!doctype html>
<html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex, nofollow">
<title>VedaVerse — installed</title>
<?php vv_styles(); ?>
</head><body><main class="wrap">
<div class="card">
<h1><?php echo $removed ? 'Done. The installer has deleted itself.' : 'Almost done — one manual step'; ?></h1>
<?php if ($removed): ?>
    <p class="lead">VedaVerse is installed and install.php is gone from the server.</p>
    <p>Next: sign in at <code>/admin</code> with the account you just created, then follow
       <code>docs/WORKER_SETUP.md</code> to deploy the Cloudflare Worker and paste its URL
       into the settings screen. Sarathi stays switched off until you do.</p>
<?php else: ?>
    <p class="lead">VedaVerse is installed, but the installer could not delete itself — the file
       permissions did not allow it.</p>
    <p class="bad"><strong>Delete <code>install.php</code> from your server over FTP now.</strong>
       Leaving it there lets anybody who finds it reconfigure your site.</p>
<?php endif; ?>
<p><a class="btn" href="/">Open the site</a></p>
</div></main></body></html><?php
}

/**
 * The installer's stylesheet. Inline and self-contained: the design system
 * does not exist yet at install time, and a setup page that depends on a
 * stylesheet is one more thing that can fail.
 *
 * @return void
 */
function vv_styles()
{
    ?><style>
:root{--dawn:#FF6B2C;--marigold:#FFC22E;--krishna:#2D5BFF;--peacock:#00B5A5;--ink:#14121F;--cloud:#FFF7EE;--muted:#6b6577;--bad:#c0392b;}
*{box-sizing:border-box}
body{margin:0;background:var(--cloud);color:var(--ink);font-family:system-ui,-apple-system,"Segoe UI",Roboto,sans-serif;line-height:1.6;font-size:17px}
.wrap{max-width:44rem;margin:0 auto;padding:32px 20px 80px}
.brand{display:flex;align-items:center;gap:12px;margin-bottom:24px}
.brand .dot{width:36px;height:36px;border-radius:12px;background:linear-gradient(135deg,var(--dawn),var(--marigold))}
.brand strong{font-size:20px}
.brand span{color:var(--muted);font-size:15px}
.card{background:#fff;border-radius:20px;padding:28px;box-shadow:0 6px 24px rgba(255,107,44,.10);margin-bottom:20px}
h1{font-size:26px;margin:0 0 8px;line-height:1.3}
h2{font-size:20px;margin:24px 0 8px}
p{margin:0 0 14px}
.lead{color:var(--muted)}
code{background:#f3efe9;padding:2px 6px;border-radius:6px;font-size:15px}
label{display:block;font-weight:600;margin:16px 0 4px}
.hint{font-weight:400;color:var(--muted);font-size:14px;display:block;margin-top:2px}
input[type=text],input[type=email],input[type=password]{width:100%;padding:12px 14px;font-size:16px;border:2px solid #e5ded4;border-radius:12px;background:#fff;color:var(--ink)}
input:focus{outline:3px solid rgba(45,91,255,.35);outline-offset:1px;border-color:var(--krishna)}
.btn{display:inline-block;border:0;background:var(--dawn);color:#fff;font-weight:700;font-size:17px;padding:13px 22px;border-radius:14px;cursor:pointer;box-shadow:0 4px 0 #d4531c;text-decoration:none;margin-top:20px}
.btn:active{transform:translateY(3px);box-shadow:0 1px 0 #d4531c}
.btn.secondary{background:#fff;color:var(--ink);border:2px solid #e5ded4;box-shadow:0 4px 0 #e5ded4}
.btn.danger{background:var(--bad);box-shadow:0 4px 0 #8e2a1e}
ul.checks{list-style:none;padding:0;margin:8px 0}
ul.checks li{padding:10px 0;border-bottom:1px solid #f0eae2;display:flex;gap:10px;align-items:flex-start}
ul.checks li:last-child{border-bottom:0}
.mark{font-weight:700;flex:0 0 1.6em}
.ok .mark{color:var(--peacock)}
.no .mark{color:var(--bad)}
.warn .mark{color:var(--marigold)}
.detail{color:var(--muted);font-size:14px;display:block}
.alert{border-radius:14px;padding:14px 16px;margin-bottom:16px}
.alert.bad{background:#fdeceb;border:2px solid #f5c6c2;color:#7d241b}
.alert.good{background:#e6f7f5;border:2px solid #a9e3dc;color:#075e56}
.alert ul{margin:6px 0 0 18px;padding:0}
.results{max-height:26rem;overflow:auto;border:2px solid #f0eae2;border-radius:14px;padding:6px 12px;font-size:14px;background:#fdfbf8}
.results div{padding:4px 0;border-bottom:1px solid #f5f1eb;display:flex;gap:8px}
.results div:last-child{border-bottom:0}
.results .err{color:var(--bad);display:block;font-size:13px;margin-top:2px}
.code{font-family:ui-monospace,SFMono-Regular,Menlo,monospace;font-size:24px;letter-spacing:2px;background:var(--ink);color:var(--marigold);padding:18px;border-radius:14px;text-align:center;word-break:break-all}
.steps{display:flex;gap:6px;margin-bottom:20px;flex-wrap:wrap}
.steps span{font-size:13px;color:var(--muted);background:#fff;border:2px solid #eee5da;border-radius:999px;padding:4px 12px}
.steps span.on{background:var(--ink);color:#fff;border-color:var(--ink)}
.bad{color:var(--bad)}
@media (prefers-reduced-motion: reduce){*{transition:none!important}.btn:active{transform:none}}
</style><?php
}

/**
 * The step indicator across the top.
 *
 * @param string $current
 * @return void
 */
function vv_steps($current)
{
    $steps = array(
        'requirements' => 'Server check',
        'database'     => 'Database',
        'schema'       => 'Tables',
        'admin'        => 'Your account',
        'finished'     => 'Done',
    );

    $map = array(
        'welcome' => 'requirements', 'locked' => 'requirements',
        'schema_result' => 'schema', 'schema_done' => 'schema',
    );
    $current = isset($map[$current]) ? $map[$current] : $current;

    echo '<div class="steps">';
    foreach ($steps as $key => $label) {
        echo '<span class="' . ($key === $current ? 'on' : '') . '">' . vv_e($label) . '</span>';
    }
    echo '</div>';
}

?><!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex, nofollow">
<title>Install VedaVerse</title>
<?php vv_styles(); ?>
</head>
<body>
<main class="wrap">

<div class="brand">
    <div class="dot" aria-hidden="true"></div>
    <div>
        <strong>VedaVerse</strong><br>
        <span>The Gita, Decoded — installer</span>
    </div>
</div>

<?php vv_steps($step); ?>

<?php if ($errors !== array()): ?>
    <div class="alert bad">
        <strong>That did not work.</strong>
        <ul>
            <?php foreach ($errors as $message): ?>
                <li><?php echo $message; /* messages are pre-escaped where they include server output */ ?></li>
            <?php endforeach; ?>
        </ul>
    </div>
<?php endif; ?>

<?php if ($notices !== array()): ?>
    <div class="alert good">
        <?php foreach ($notices as $message): ?>
            <div><?php echo vv_e($message); ?></div>
        <?php endforeach; ?>
    </div>
<?php endif; ?>


<?php // ============================================================ ?>
<?php if ($step === 'locked'): ?>

    <div class="card">
        <h1>VedaVerse is already installed here</h1>
        <p class="lead">A finished installation was found in this database, so the installer
           has stopped rather than risk overwriting it.</p>
        <p><strong>If you were looking for the site,</strong> it is at
           <a href="/">the home page</a>. To sign in as an administrator, go to <code>/admin</code>.</p>
        <p><strong>If you meant to delete this file,</strong> use the button below — that is the
           right thing to do on a live site.</p>

        <form method="post">
            <input type="hidden" name="_token" value="<?php echo vv_e($token); ?>">
            <input type="hidden" name="step" value="selfdestruct">
            <button class="btn danger" type="submit">Delete install.php now</button>
        </form>

        <h2>Reinstalling anyway</h2>
        <p>This does not delete your data — every table is created only if missing — but it does
           overwrite <code>app/config/local.php</code> and issue a new recovery code.
           Type <code>REINSTALL</code> to continue.</p>

        <form method="post">
            <input type="hidden" name="_token" value="<?php echo vv_e($token); ?>">
            <input type="hidden" name="step" value="unlock">
            <label for="confirm">Confirmation</label>
            <input type="text" id="confirm" name="confirm" autocomplete="off" placeholder="REINSTALL">
            <button class="btn secondary" type="submit">Unlock the installer</button>
        </form>
    </div>


<?php // ============================================================ ?>
<?php elseif ($step === 'welcome'): ?>

    <div class="card">
        <h1>Let us get VedaVerse running</h1>
        <p class="lead">Five screens. You will need four things from your hosting control panel:
           the database host, the database name, the database username, and its password.</p>
        <p>Nothing here is destructive. If a step fails you can fix the cause and run it again —
           tables are only created when they are missing.</p>
        <p><strong>Have those four values open in another tab before you start.</strong>
           On InfinityFree they are on the "MySQL Databases" page.</p>

        <form method="post">
            <input type="hidden" name="_token" value="<?php echo vv_e($token); ?>">
            <input type="hidden" name="step" value="welcome">
            <button class="btn" type="submit">Check the server</button>
        </form>
    </div>


<?php // ============================================================ ?>
<?php elseif ($step === 'requirements'): ?>

    <?php
    $checks     = vv_requirements();
    $blocked    = false;
    foreach ($checks as $check) {
        if (!$check['ok'] && $check['fatal']) { $blocked = true; }
    }
    ?>

    <div class="card">
        <h1>Server check</h1>
        <p class="lead">Everything marked in red has to be fixed before VedaVerse can run.
           Amber items are optional.</p>

        <ul class="checks">
            <?php foreach ($checks as $check): ?>
                <?php $class = $check['ok'] ? 'ok' : ($check['fatal'] ? 'no' : 'warn'); ?>
                <li class="<?php echo $class; ?>">
                    <span class="mark" aria-hidden="true"><?php echo $check['ok'] ? '✓' : ($check['fatal'] ? '✗' : '!'); ?></span>
                    <span>
                        <?php echo vv_e($check['label']); ?>
                        <?php if (!$check['ok']): ?>
                            <span class="detail"><?php echo vv_e($check['detail']); ?></span>
                        <?php endif; ?>
                    </span>
                </li>
            <?php endforeach; ?>
        </ul>

        <?php if ($blocked): ?>
            <div class="alert bad">Fix the items marked ✗, then reload this page.</div>
            <a class="btn secondary" href="?step=requirements">Check again</a>
        <?php else: ?>
            <form method="post">
                <input type="hidden" name="_token" value="<?php echo vv_e($token); ?>">
                <input type="hidden" name="step" value="requirements">
                <button class="btn" type="submit">Continue to the database</button>
            </form>
        <?php endif; ?>
    </div>


<?php // ============================================================ ?>
<?php elseif ($step === 'database'): ?>

    <div class="card">
        <h1>Database details</h1>
        <p class="lead">These come from your hosting control panel, not from anything you
           choose here. Create the database there first if you have not already.</p>

        <form method="post">
            <input type="hidden" name="_token" value="<?php echo vv_e($token); ?>">
            <input type="hidden" name="step" value="database">

            <label for="db_host">Database host
                <span class="hint">On InfinityFree this is NOT localhost. It looks like sql123.infinityfree.com.</span>
            </label>
            <input type="text" id="db_host" name="db_host" autocomplete="off"
                   value="<?php echo vv_e(vv_post('db_host', 'localhost')); ?>">

            <label for="db_name">Database name
                <span class="hint">Often prefixed by your account id, for example if0_12345678_vedaverse.</span>
            </label>
            <input type="text" id="db_name" name="db_name" autocomplete="off"
                   value="<?php echo vv_e(vv_post('db_name')); ?>">

            <label for="db_user">Database username
                <span class="hint">Not your control-panel login. Usually starts with if0_.</span>
            </label>
            <input type="text" id="db_user" name="db_user" autocomplete="off"
                   value="<?php echo vv_e(vv_post('db_user')); ?>">

            <label for="db_pass">Database password
                <span class="hint">The password you set when creating the database.</span>
            </label>
            <input type="password" id="db_pass" name="db_pass" autocomplete="off">

            <button class="btn" type="submit">Test the connection and continue</button>
        </form>
    </div>


<?php // ============================================================ ?>
<?php elseif ($step === 'schema'): ?>

    <div class="card">
        <h1>Create the tables</h1>
        <p class="lead">This runs <code>database/schema.sql</code> one statement at a time and
           reports each one. About fifty tables. It takes a few seconds.</p>
        <p>Safe to run more than once: every table is created only if it is missing.</p>

        <form method="post">
            <input type="hidden" name="_token" value="<?php echo vv_e($token); ?>">
            <input type="hidden" name="step" value="schema">
            <button class="btn" type="submit">Create the tables</button>
        </form>
    </div>


<?php // ============================================================ ?>
<?php elseif ($step === 'schema_result' || $step === 'schema_done'): ?>

    <div class="card">
        <h1>Table results</h1>

        <?php if ($results !== array()): ?>
            <div class="results">
                <?php foreach ($results as $r): ?>
                    <div class="<?php echo $r['ok'] ? 'ok' : 'no'; ?>">
                        <span class="mark" aria-hidden="true"><?php echo $r['ok'] ? '✓' : '✗'; ?></span>
                        <span>
                            <?php echo vv_e($r['label']); ?>
                            <?php if (!$r['ok']): ?>
                                <span class="err"><?php echo $r['error']; /* pre-escaped */ ?></span>
                            <?php endif; ?>
                        </span>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>

        <?php if ($step === 'schema_done'): ?>
            <p style="margin-top:16px">Storage folders were created and protected as well.</p>
            <p><a class="btn" href="?step=admin">Create your account</a></p>
        <?php else: ?>
            <h2>What the common failures mean</h2>
            <p><strong>"Specified key was too long"</strong> — a very old MySQL. Ask your host to
               enable <code>innodb_large_prefix</code>, or upgrade to MySQL 5.7 or newer.</p>
            <p><strong>"Access denied for user"</strong> — the database user cannot create tables.
               Grant it full privileges on this database in the control panel.</p>
            <p><strong>"The used table type doesn't support FULLTEXT"</strong> — only the search
               index failed. The site works; search falls back to topic and tag matching.</p>
            <form method="post">
                <input type="hidden" name="_token" value="<?php echo vv_e($token); ?>">
                <input type="hidden" name="step" value="schema">
                <button class="btn" type="submit">Try again</button>
            </form>
        <?php endif; ?>
    </div>


<?php // ============================================================ ?>
<?php elseif ($step === 'admin'): ?>

    <div class="card">
        <h1>Your administrator account</h1>
        <p class="lead">This is the account you will manage the site with. It gets the
           superadmin role, which is the only role that can change system settings.</p>
        <p><strong>VedaVerse sends no email, ever</strong> — the host blocks it. Your email address is
           stored so you can sign in with it, and nothing is ever sent to it. Account recovery
           uses a code shown on the next screen.</p>

        <form method="post">
            <input type="hidden" name="_token" value="<?php echo vv_e($token); ?>">
            <input type="hidden" name="step" value="admin">

            <label for="site_name">Site name
                <span class="hint">Shown in the header, in page titles and on certificates.</span>
            </label>
            <input type="text" id="site_name" name="site_name"
                   value="<?php echo vv_e(vv_post('site_name', 'VedaVerse — The Gita, Decoded')); ?>">

            <label for="admin_name">Your name</label>
            <input type="text" id="admin_name" name="admin_name" autocomplete="name"
                   value="<?php echo vv_e(vv_post('admin_name')); ?>">

            <label for="admin_email">Email
                <span class="hint">Used as your sign-in name. Never mailed to.</span>
            </label>
            <input type="email" id="admin_email" name="admin_email" autocomplete="username"
                   value="<?php echo vv_e(vv_post('admin_email')); ?>">

            <label for="admin_password">Password
                <span class="hint">At least 10 characters, with upper and lower case, a number and a symbol.</span>
            </label>
            <input type="password" id="admin_password" name="admin_password" autocomplete="new-password">

            <label for="admin_password_confirm">Password again</label>
            <input type="password" id="admin_password_confirm" name="admin_password_confirm" autocomplete="new-password">

            <label for="admin_lang">Default language for the site</label>
            <select id="admin_lang" name="admin_lang" style="width:100%;padding:12px 14px;font-size:16px;border:2px solid #e5ded4;border-radius:12px;background:#fff">
                <option value="en">English</option>
                <option value="hi">हिन्दी (Hindi)</option>
                <option value="hinglish">Hinglish</option>
            </select>

            <button class="btn" type="submit">Create my account</button>
        </form>
    </div>


<?php // ============================================================ ?>
<?php elseif ($step === 'finished'): ?>

    <div class="card">
        <h1>Write this down before you close the page</h1>
        <p class="lead">This is your recovery code. It is shown once, right now, and it is
           stored only as a hash — nobody, including you, can look it up later.</p>

        <p class="code"><?php echo vv_e($recovery); ?></p>

        <p class="bad"><strong>If you lose both your password and this code, the account cannot
           be recovered.</strong> There is no email reset, because this host blocks outgoing mail.
           Write it on paper, or put it in a password manager, now.</p>
    </div>

    <div class="card">
        <h1>Last step: delete the installer</h1>
        <p>Leaving <code>install.php</code> on the server lets anybody who finds it point your
           site at a different database. Press the button.</p>

        <form method="post">
            <input type="hidden" name="_token" value="<?php echo vv_e($token); ?>">
            <input type="hidden" name="step" value="selfdestruct">
            <button class="btn danger" type="submit">I have written the code down — delete install.php</button>
        </form>
    </div>

    <?php if (vv_is_local_request()): ?>
        <div class="card">
            <h1>Configured for local development</h1>
            <p>You opened this installer on <code><?php echo vv_e($_SERVER['HTTP_HOST']); ?></code>,
               so <code>app/config/local.php</code> was written with
               <code>env =&gt; 'local'</code> and <code>debug =&gt; true</code>. Error pages will
               show you the exception, file and line instead of hiding them, and the scripts in
               <code>tools/</code> will run.</p>
            <p class="bad"><strong>If this is actually a live site, change both values now.</strong>
               Debug output on a public site shows visitors your file paths and your SQL.</p>
        </div>
    <?php endif; ?>

    <div class="card">
        <h1>What comes next</h1>
        <p>The site runs now, but it has no content and no AI yet. In order:</p>
        <p><strong>1.</strong> Sign in at <code>/admin</code>.<br>
           <strong>2.</strong> Import the seed content, or run the seed SQL files from your host's
           phpMyAdmin.<br>
           <strong>3.</strong> Follow <code>docs/WORKER_SETUP.md</code> to deploy the Cloudflare
           Worker, then paste its URL into Settings. Sarathi stays switched off until you do,
           which is deliberate — a chat box that cannot possibly answer is worse than no chat box.</p>
        <p>One thing to diarise: this host suspends accounts that go unused for about 45 days.
           Sign in to the control panel occasionally.</p>
    </div>

<?php endif; ?>

</main>
</body>
</html>
