<?php
/**
 * VedaVerse — app/config/cache.php
 * ---------------------------------------------------------------------
 * The four cache layers and how long each thing lives.
 *
 * THE FOUR LAYERS, FASTEST FIRST
 *   1. memory  — a PHP array, alive for one request only. Free. Stops the
 *                same value being fetched twice on one page.
 *   2. file    — storage/cache/*.cache. Fast, no database round trip.
 *   3. table   — the cache table. Survives when the disk is full or the
 *                cache directory is not writable, which does happen on
 *                free hosting.
 *   4. browser — Cache-Control headers and the Service Worker. Not
 *                configured here, see pwa.php and .htaccess.
 *
 *   Cache::get() reads down the list and stops at the first hit, then
 *   back-fills the faster layers. Cache::set() writes to memory and file,
 *   and to the table only when 'use_table' is on.
 *
 * NEVER CACHED, AND THIS IS NOT NEGOTIABLE
 *   Anything belonging to a signed-in person, and CSRF tokens. Caching a
 *   personalised page is how one user ends up seeing another user's
 *   progress. Cache::set() refuses keys prefixed 'user:' unless the caller
 *   passes the private flag, which only ProgressService does.
 */

return array(

    // Master switch. Turn off while debugging a stale-content problem.
    'enabled' => true,

    // Layer order. Remove 'table' if your host's database is the slow part
    // rather than the disk.
    'layers'    => array('memory', 'file', 'table'),
    'use_table' => true,

    'file' => array(
        // Filled in from app.paths.cache.
        'path'      => null,
        'extension' => '.cache',
        // Spread files across sub-directories named after the first two
        // characters of the key hash. Some shared hosts get slow past a
        // few thousand files in one directory.
        'shard'     => true,
    ),

    /**
     * Time to live, in seconds, per kind of thing.
     * Content is invalidated explicitly on every admin write as well, so
     * these are a safety net and not the primary freshness mechanism.
     */
    'ttl' => array(
        'default'            => 3600,   // 1 hour
        'content'            => 3600,   // chapters, verses, topic pages
        'chapter_list'       => 3600,
        'verse_payload'      => 3600,
        'topic_page'         => 3600,
        'search_suggestions' => 900,    // 15 minutes
        'seo_meta'           => 3600,
        'daily_verse'        => 86400,  // 24 hours
        'settings'           => 300,    // short: an admin change should show up quickly
        'content_bundle'     => 86400,
    ),

    /**
     * Opportunistic purge of expired rows and files.
     *
     * There is no cron on this host, so cleanup has to ride along on a
     * normal page request. Doing it on every request would add a DELETE to
     * every page load. 'probability' => 50 means roughly one request in
     * fifty does the cleanup, which keeps the table tidy at a cost nobody
     * notices. 'limit' caps how many rows one pass deletes so the unlucky
     * request that draws the short straw still finishes fast.
     */
    'purge' => array(
        'probability' => 50,
        'limit'       => 200,
    ),

    // Prefix on every key. Bump the version part to invalidate the entire
    // cache at once after a deploy that changes data shapes.
    'prefix' => 'vv:v1:',
);
