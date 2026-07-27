<?php
/**
 * VedaVerse — app/config/pwa.php
 * ---------------------------------------------------------------------
 * Progressive Web App and offline behaviour.
 *
 * WHY OFFLINE IS A REQUIREMENT AND NOT A NICE-TO-HAVE
 *   A large share of the people this is built for read on a phone, on a
 *   patchy connection, on a metro or in a town where data drops out for
 *   ten minutes at a time. If the app is useless without a signal, it is
 *   useless when they actually have time to read. All 108 curated verses,
 *   in three languages, with their examples and quizzes, must work with
 *   the network switched off.
 *
 * THE ONE THING THAT BREAKS PWAs
 *   A stale Service Worker. When you deploy, bump 'cache_version'. The
 *   Service Worker keys its cache on that string, so a new value makes it
 *   discard the old cache and refetch. Forget to bump it and your users
 *   keep seeing last week's site with no way to escape it. This is the
 *   single most common cause of "I uploaded the fix but nothing changed".
 */

return array(

    'enabled' => true,

    // -----------------------------------------------------------------
    // manifest.webmanifest
    // -----------------------------------------------------------------
    'manifest' => array(
        'name'        => 'VedaVerse — The Gita, Decoded',
        'short_name'  => 'VedaVerse',
        'description' => 'Learn the Bhagavad Gita as practical psychology, in English, Hindi and Hinglish.',
        'display'     => 'standalone',
        'orientation' => 'portrait',
        // The query parameter lets analytics-free code still tell an
        // installed launch from a browser visit.
        'start_url'   => '/?src=pwa',
        'scope'       => '/',
        'theme_color'      => '#FF6B2C', // --rc-dawn
        'background_color' => '#FFF7EE', // --rc-cloud
        'lang'        => 'en',
        'categories'  => array('education', 'books', 'lifestyle'),

        // Maskable icons matter: without a maskable variant, Android crops
        // the icon into a circle and slices the artwork.
        'icons' => array(
            array('src' => '/assets/icons/icon-192.png', 'sizes' => '192x192', 'type' => 'image/png', 'purpose' => 'any'),
            array('src' => '/assets/icons/icon-384.png', 'sizes' => '384x384', 'type' => 'image/png', 'purpose' => 'any'),
            array('src' => '/assets/icons/icon-512.png', 'sizes' => '512x512', 'type' => 'image/png', 'purpose' => 'any'),
            array('src' => '/assets/icons/maskable-192.png', 'sizes' => '192x192', 'type' => 'image/png', 'purpose' => 'maskable'),
            array('src' => '/assets/icons/maskable-512.png', 'sizes' => '512x512', 'type' => 'image/png', 'purpose' => 'maskable'),
        ),

        // At least two screenshots, or Android shows the plain mini
        // install bar instead of the rich install prompt.
        'screenshots' => array(
            array('src' => '/assets/img/screenshot-path.png',  'sizes' => '1080x1920', 'type' => 'image/png', 'form_factor' => 'narrow'),
            array('src' => '/assets/img/screenshot-verse.png', 'sizes' => '1080x1920', 'type' => 'image/png', 'form_factor' => 'narrow'),
        ),
    ),

    // -----------------------------------------------------------------
    // Service Worker
    // -----------------------------------------------------------------
    // BUMP THIS ON EVERY DEPLOY.
    'cache_version' => 'vedaverse-v1',

    // Strategy per kind of request. The Service Worker reads these
    // patterns in order and uses the first match.
    'strategies' => array(
        // The shell and everything that rarely changes.
        'precache' => array(
            '/', '/offline.html',
            '/assets/css/tokens.css', '/assets/css/base.css', '/assets/css/components.css',
            '/assets/js/app.js', '/assets/js/offline.js',
            '/manifest.webmanifest',
        ),
        // Big, versioned, expensive to fetch.
        'cache_first' => array(
            '/assets/data/content-bundle.json',
            '/assets/fonts/', '/assets/img/', '/assets/icons/', '/assets/illustrations/',
        ),
        // Show the cached copy instantly, refresh it in the background.
        'stale_while_revalidate' => array(
            '/chapter/', '/verse/', '/topic/', '/problem/', '/chapters',
        ),
        // Try the network, fall back to cache.
        'network_first' => array(
            '/search', '/forum',
        ),
        // Never cached under any circumstances. A cached auth response or
        // a cached chat token is a security bug, not a performance win.
        'network_only' => array(
            '/api/chat_token.php', '/admin', '/login', '/register', '/logout', '/recover',
        ),
    ),

    'offline_page' => '/offline.html',

    // -----------------------------------------------------------------
    // Offline content bundle
    // -----------------------------------------------------------------
    // Built by the admin with one button. Contains all curated verses in
    // three languages with examples, memory aids, reflections and quizzes.
    'bundle' => array(
        'path'       => '/assets/data/content-bundle.json',
        // Past this, split by chapter and lazy-cache instead. A 12 MB
        // first-load download on a 3G connection is not offline support,
        // it is a bounce.
        'max_bytes'  => 5242880, // 5 MB
        'split_by_chapter_over' => 5242880,
        // Versioned by a hash of its contents, so the Service Worker knows
        // when to refetch without being told.
        'version_by' => 'content_hash',
    ),

    // -----------------------------------------------------------------
    // Offline writes
    // -----------------------------------------------------------------
    // Quiz attempts, SRS grades, progress, bookmarks and notes queue in
    // IndexedDB and flush on reconnect. Every queued item carries a
    // browser-generated UUID, and api/progress_sync.php ignores a UUID it
    // has already seen. That is what makes a flaky reconnection safe.
    //
    // Never lose a learner's work silently. If a flush fails, the item
    // stays queued and the sync indicator stays visible.
    'sync' => array(
        'store_name'     => 'vedaverse-outbox',
        'endpoint'       => '/api/progress_sync.php',
        'batch_size'     => 50,
        'retry_delays'   => array(1000, 5000, 15000, 60000),
        'max_queue_days' => 30,
    ),

    // -----------------------------------------------------------------
    // Install prompt
    // -----------------------------------------------------------------
    // Do not ask on first load. A prompt before the learner knows what
    // this is gets dismissed, and a dismissed prompt does not come back.
    // Ask after the second completed lesson, when the answer might be yes.
    'install_prompt' => array(
        'after_lessons'      => 2,
        'dismiss_cooldown_days' => 30,
        // Safari never fires beforeinstallprompt, so iOS gets a manual
        // "Add to Home Screen" sheet with instructions instead.
        'ios_manual_sheet'   => true,
    ),

    // When a new Service Worker is detected, offer a one-tap refresh
    // rather than reloading under the user mid-sentence.
    'update_prompt' => true,
);
