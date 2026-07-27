<?php
/**
 * VedaVerse — app/config/seo.php
 * ---------------------------------------------------------------------
 * Defaults for titles, descriptions, social cards and structured data.
 *
 * THE PRINCIPLE
 *   Every verse is an independently rankable page, and the title is
 *   written for the problem, not the citation. Somebody types "how to stop
 *   caring about results" into a search engine. They do not type
 *   "Bhagavad Gita chapter 2 verse 47". A page titled
 *   "Bhagavad Gita 2.47 — Why Chasing Results Makes You Miserable"
 *   answers both.
 *
 * WHAT USES THIS
 *   SeoService merges these defaults with per-page values and hands the
 *   result to the layout. A page that sets nothing still emits a valid,
 *   unique title, description, canonical and robots directive.
 */

return array(

    // -----------------------------------------------------------------
    // Titles
    // -----------------------------------------------------------------
    // %s is the page title. Keep the suffix short: search engines truncate
    // around 60 characters and the brand should not eat the useful half.
    'title_template' => '%s | VedaVerse',
    'title_default'  => 'VedaVerse — The Gita, Decoded',
    'title_max'      => 60,

    'description_default' => 'Learn the Bhagavad Gita as practical psychology, in English, Hindi and Hinglish. Every teaching anchored to something you have already lived through. No background needed.',
    'description_max'     => 160,

    // -----------------------------------------------------------------
    // Robots
    // -----------------------------------------------------------------
    'robots_default' => 'index, follow, max-image-preview:large',
    // Never indexed, in addition to the robots.txt rules. Belt and braces,
    // because robots.txt is a request and a meta directive is a stronger
    // signal.
    'noindex_paths' => array(
        '/admin', '/api', '/auth', '/login', '/register', '/recover',
        '/profile', '/sarathi/history', '/search',
    ),

    // -----------------------------------------------------------------
    // Social cards
    // -----------------------------------------------------------------
    'open_graph' => array(
        'site_name' => 'VedaVerse',
        'type'      => 'website',
        'locale'    => 'en_IN',
        'locale_alternate' => array('hi_IN'),
        // Relative to the site root. 1200x630 is the size every platform
        // crops least badly.
        'default_image' => '/assets/img/og-default.png',
        'image_width'   => 1200,
        'image_height'  => 630,
    ),

    'twitter' => array(
        'card' => 'summary_large_image',
        'site' => '', // fill in the @handle if one ever exists
    ),

    // -----------------------------------------------------------------
    // Structured data
    // -----------------------------------------------------------------
    // Which JSON-LD type each kind of page emits. Validate changes with
    // Google's Rich Results Test before shipping them: invalid structured
    // data is worse than none.
    'jsonld' => array(
        'organization' => array(
            'name' => 'VedaVerse',
            'url'  => null, // derived at runtime
            'logo' => '/assets/icons/icon-512.png',
        ),
        'website' => array(
            // Powers the sitelinks search box.
            'search_url_template' => '/search?q={search_term_string}',
        ),
        'types' => array(
            'home'    => array('WebSite', 'Organization'),
            'chapter' => array('Course', 'BreadcrumbList'),
            'verse'   => array('Article', 'BreadcrumbList'),
            'topic'   => array('CollectionPage', 'BreadcrumbList'),
            'problem' => array('FAQPage', 'BreadcrumbList'),
            'forum'   => array('DiscussionForumPosting', 'BreadcrumbList'),
        ),
        'publisher' => 'VedaVerse',
    ),

    // -----------------------------------------------------------------
    // Sitemap
    // -----------------------------------------------------------------
    // sitemap.php builds this dynamically from published content. Pending
    // forum threads, admin, auth and chat pages are excluded — a pending
    // post must not be discoverable through a sitemap while it is
    // invisible on the site itself.
    'sitemap' => array(
        'changefreq' => array(
            'home'    => 'daily',
            'chapter' => 'weekly',
            'verse'   => 'monthly',
            'topic'   => 'weekly',
            'problem' => 'weekly',
            'forum'   => 'daily',
        ),
        'priority' => array(
            'home'    => '1.0',
            'problem' => '0.9',
            'chapter' => '0.8',
            'verse'   => '0.8',
            'topic'   => '0.7',
            'forum'   => '0.5',
        ),
        // Split into multiple files past this many URLs.
        'max_urls_per_file' => 5000,
    ),

    // Hreflang. Three languages, one URL each, with the language carried
    // as a query parameter rather than a separate path, so a verse keeps
    // one canonical page and all its ranking signal.
    'hreflang' => array(
        'en'       => 'en',
        'hi'       => 'hi',
        'hinglish' => 'en-IN',
    ),
);
