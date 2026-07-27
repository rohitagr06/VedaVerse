<?php
/**
 * VedaVerse — app/config/app.php
 * ---------------------------------------------------------------------
 * Global application settings.
 *
 * WHAT THIS FILE IS
 *   A plain PHP array. Nothing here runs any logic, connects to anything,
 *   or has side effects. Config files are read once by Config::get() and
 *   cached in memory for the rest of the request.
 *
 * WHAT A BEGINNER SHOULD BE CAREFUL CHANGING
 *   * 'debug' must stay false on the live site. Turning it on shows file
 *     paths and SQL to anyone who visits, which is how sites get broken
 *     into. Turn it on locally, never in production.
 *   * 'url' is deliberately null. Do NOT hardcode your domain here. The
 *     free subdomain you deploy to can change, and VedaVerse works out its own
 *     address at runtime from the request. See url_base() in Request.
 *
 * SECRETS DO NOT LIVE IN THIS FILE
 *   Database passwords and signing secrets are written by install.php into
 *   app/config/local.php, which is blocked from the web and never committed
 *   to version control. Values below marked "overridden by local.php" are
 *   safe placeholders only.
 */

return array(

    // ---------------------------------------------------------------
    // Identity
    // ---------------------------------------------------------------
    'name'           => 'VedaVerse — The Gita, Decoded',
    'short_name'     => 'VedaVerse',
    'tagline'        => 'Ancient wisdom, decoded for the life you are actually living.',
    'version'        => '1.0.0',

    // Bumped whenever database/schema.sql changes. Also stored in the
    // settings table as schema_version, so the admin panel can warn when
    // the uploaded code is newer than the installed database.
    'schema_version' => '1.0.0',

    // ---------------------------------------------------------------
    // Environment
    // ---------------------------------------------------------------
    // 'production' or 'local'. install.php writes 'production' into
    // local.php on a real host.
    'env'            => 'production',

    // NEVER true on a live site.
    'debug'          => false,

    // Leave null. VedaVerse derives the base URL from the incoming request so it
    // keeps working when the free subdomain changes.
    'url'            => null,

    // Force https:// in generated links when the request arrives over TLS
    // or behind a proxy that says so. Harmless on plain http.
    'force_https'    => false,

    'timezone'       => 'Asia/Kolkata',

    // ---------------------------------------------------------------
    // Filesystem paths
    // ---------------------------------------------------------------
    // All paths are absolute and derived from this file's location, so
    // moving the whole folder never breaks anything.
    'paths' => array(
        'root'         => dirname(dirname(__DIR__)),
        'app'          => dirname(__DIR__),
        'views'        => dirname(__DIR__) . '/views',
        'storage'      => dirname(dirname(__DIR__)) . '/storage',
        'cache'        => dirname(dirname(__DIR__)) . '/storage/cache',
        'logs'         => dirname(dirname(__DIR__)) . '/storage/logs',
        'sessions'     => dirname(dirname(__DIR__)) . '/storage/sessions',
        'backups'      => dirname(dirname(__DIR__)) . '/storage/backups',
        'temp'         => dirname(dirname(__DIR__)) . '/storage/temp',
        'uploads'      => dirname(dirname(__DIR__)) . '/uploads',
        'certificates' => dirname(dirname(__DIR__)) . '/uploads/certificates',
        'imports'      => dirname(dirname(__DIR__)) . '/uploads/imports',
        'database'     => dirname(dirname(__DIR__)) . '/database',
        'assets'       => dirname(dirname(__DIR__)) . '/assets',
    ),

    // ---------------------------------------------------------------
    // Learning defaults
    // ---------------------------------------------------------------
    // These are the values the code falls back to. The admin panel can
    // override most of them through the settings table at runtime.
    'defaults' => array(
        'lang'  => 'en',
        'track' => 'beginner',
        // Chapter 2 is the entry point, not Chapter 1. Chapter 1 is scene
        // setting. Chapter 2 is where the teaching actually starts, and a
        // first-time learner should land there.
        'entry_chapter' => 2,
    ),

    // XP and levelling. Level = floor(sqrt(xp / 50)) + 1.
    'xp' => array(
        'lesson'         => 10,
        'review'         => 5,
        'correct_answer' => 2,
        'chapter'        => 25,
        'level_divisor'  => 50,
    ),

    // ---------------------------------------------------------------
    // Feature switches
    // ---------------------------------------------------------------
    // Anything that can fail on free hosting has an off switch, so the
    // owner can disable one feature instead of the whole site.
    'features' => array(
        'forum'        => true,
        'chat'         => true,
        'certificates' => true,
        'pwa'          => true,
        'registration' => true,
    ),

    // ---------------------------------------------------------------
    // Performance budgets
    // ---------------------------------------------------------------
    // Not enforcement, just the numbers the build is aiming at. Logger
    // records a warning when a request exceeds slow_request_ms.
    'performance' => array(
        'slow_request_ms' => 2000,
        'slow_query_ms'   => 300,
    ),

    // Shown on error pages and in the footer so a user can quote a build
    // when they report a problem.
    'build' => '1.0.0-step2',
);
