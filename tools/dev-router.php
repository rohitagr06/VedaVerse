<?php
/**
 * VedaVerse — tools/dev-router.php
 * =====================================================================
 * A router for PHP's built-in web server, so local development behaves
 * like Apache.
 *
 * WHY THIS IS NEEDED
 *   PHP's built-in server does not read .htaccess, so it knows nothing
 *   about the rewrite rule that sends every unmatched URL to index.php.
 *   Without this file, `php -S` serves the home page and then answers 404
 *   for /login, /register and every other route — which looks exactly
 *   like a broken router and is not.
 *
 *   This script does what the .htaccess rewrite does: serve a real file
 *   if one exists at that path, otherwise hand the request to the front
 *   controller.
 *
 * USE
 *   From the repository root:
 *
 *       php -S 127.0.0.1:8080 -t htdocs tools/dev-router.php
 *
 *   Then open http://127.0.0.1:8080
 *
 * NOT FOR PRODUCTION
 *   This file lives outside htdocs/ and is never uploaded. The built-in
 *   server is single-threaded and has no security hardening; it is a
 *   development convenience and nothing more.
 *
 * WHAT IT CANNOT TEST
 *   Anything that depends on Apache: the .htaccess deny rules on /app,
 *   /storage and /database, mod_deflate, mod_expires, and the ErrorDocument
 *   directives. Those need a real Apache, or the live host. See
 *   docs/LOCAL_TESTING.md for what that means in practice.
 */

$docroot = realpath(__DIR__ . '//../htdocs');
$path    = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

// Serve an existing file directly — CSS, images, the service worker,
// install.php. realpath() resolves the path before the check, so a
// request for /../../etc/passwd cannot escape the document root.
if ($path !== '/' && $path !== null) {
    $candidate = realpath($docroot . $path);

    if ($candidate !== false
        && strpos($candidate, $docroot) === 0
        && is_file($candidate)) {
        return false; // let the built-in server serve it
    }
}

require $docroot . '/index.php';
