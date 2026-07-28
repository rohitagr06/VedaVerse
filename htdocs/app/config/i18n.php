<?php
/**
 * VedaVerse — app/config/i18n.php
 * ---------------------------------------------------------------------
 * Language definitions, detection order, and the merged interface string
 * table.
 *
 * WHERE THE STRINGS ACTUALLY LIVE
 *   In app/config/strings/*.php, one file per domain. This file loads
 *   them and hands back one flat array, so Config::get('i18n.strings')
 *   still answers with the complete table exactly as it always did. No
 *   caller needs to know the table is assembled from seven files.
 *
 *   DELIBERATE DEVIATION FROM THE BUILD SPECIFICATION, which says
 *   "app/config/i18n.php — complete interface string table". Kept in one
 *   file that table is about 2,500 lines at the end of Step 4 and keeps
 *   growing through Step 13 as the admin panel, the forum and the
 *   certificate flow arrive. Splitting it costs the twelve lines below
 *   and buys: a syntax error that names the domain it is in, an edit to
 *   the quiz wording that does not collide with an edit to the forum
 *   wording, and a file a translator can be handed without being handed
 *   all of them.
 *
 * THE RULE
 *   No hardcoded English in any view, ever. If a view needs a word, the
 *   word gets a key in all three languages first. This is annoying for
 *   exactly as long as it takes to add the second language, and then it
 *   is the only reason the third one is possible at all.
 *
 * THE THREE LANGUAGES
 *   en        Plain, warm, direct English. Short sentences. No "thou",
 *             no "verily", no academic hedging.
 *   hi        Natural spoken Hindi in Devanagari. Not stiff literary
 *             Hindi. Written for somebody who speaks Hindi at home and
 *             reads it slowly.
 *   hinglish  How urban India actually talks. Code-switched, casual,
 *             never cringe. This is the register that makes the product
 *             spread, and it is not a joke or an afterthought.
 *
 * ADDING A KEY
 *   Put it in the domain file it belongs to, in all three languages, and
 *   run `php tools/check-strings.php`. That catches a missing language,
 *   a placeholder that appears in one language and not another, and a
 *   plural form that exists in English and not in Hindi.
 *
 * MISSING KEYS AT RUNTIME
 *   I18nService falls back to 'en', and to the key itself if there is no
 *   English either, so a gap shows on the page as "quiz.retry" rather
 *   than as a blank button nobody notices.
 */

/**
 * Load and merge the domain files.
 *
 * Order matters only in that a later file wins a duplicate key — which
 * should never happen, and tools/check-strings.php reports it if it
 * does.
 */
$vv_strings = array();

foreach (array('common', 'errors', 'auth', 'content', 'learning', 'community', 'admin') as $vv_domain) {
    $vv_path = __DIR__ . '/strings/' . $vv_domain . '.php';

    if (!is_file($vv_path)) {
        // A missing domain file must not take the site down — the pages
        // that use it will show their key names, which is ugly and
        // obvious, and every other page keeps working.
        continue;
    }

    $vv_part = require $vv_path;
    if (is_array($vv_part)) {
        $vv_strings = array_merge($vv_strings, $vv_part);
    }
}

unset($vv_domain, $vv_path, $vv_part);

return array(

    'default'  => 'en',
    'fallback' => 'en',

    // The only three. Adding a fourth is a data change plus a font check,
    // not a code change.
    'languages' => array(
        'en' => array(
            'code'        => 'en',
            'name'        => 'English',
            'native_name' => 'English',
            'html_lang'   => 'en',
            'dir'         => 'ltr',
            // The lang attribute matters for accessibility: a screen
            // reader pronounces Devanagari correctly only when the element
            // is marked as Hindi.
            'script'      => 'latin',
            'date_format' => 'j M Y',
        ),
        'hi' => array(
            'code'        => 'hi',
            'name'        => 'Hindi',
            'native_name' => 'हिन्दी',
            'html_lang'   => 'hi',
            'dir'         => 'ltr',
            'script'      => 'devanagari',
            'date_format' => 'j M Y',
        ),
        'hinglish' => array(
            'code'        => 'hinglish',
            'name'        => 'Hinglish',
            'native_name' => 'Hinglish',
            // Romanised Hindi is still Hindi for a screen reader's
            // purposes, but marking it hi would make an English speech
            // engine mangle it. en-IN is the honest compromise.
            'html_lang'   => 'en-IN',
            'dir'         => 'ltr',
            'script'      => 'latin',
            'date_format' => 'j M Y',
        ),
    ),

    // Sanskrit is not an interface language, but the shloka needs its own
    // lang attribute so it is announced and rendered correctly.
    'content_languages' => array(
        'sa' => array('html_lang' => 'sa', 'script' => 'devanagari'),
    ),

    // How a language is chosen, first match wins. I18nService::detect()
    // implements this order.
    'detection' => array(
        'query_param'  => 'lang',   // ?lang=hinglish, for sharing a link
        'user_setting' => true,     // users.preferred_lang
        'cookie'       => 'vv_lang',
        'accept_header'=> true,     // browser Accept-Language, mapped loosely
        'default'      => 'en',
    ),

    // The domain files, in the order they are merged. Named here as well
    // as in the loop above so the checker can report on them by name.
    'string_domains' => array('common', 'errors', 'auth', 'content', 'learning', 'community', 'admin'),

    /**
     * Interface strings, keyed by dotted namespace. Every key carries all
     * three languages. A key with a missing language is a bug, not a
     * fallback.
     */
    'strings' => $vv_strings,
);
