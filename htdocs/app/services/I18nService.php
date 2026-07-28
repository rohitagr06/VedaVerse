<?php
/**
 * VedaVerse — app/services/I18nService.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Everything to do with the three languages, in one place: which one
 *   this request is in, what a key says in it, which database column to
 *   read for content, and which keys are missing.
 *
 * WHAT DEPENDS ON IT
 *   View::t() delegates here, so the global t() and et() helpers used in
 *   every template end up here too. SessionMiddleware calls detect().
 *   tools/check-strings.php calls audit(). Content services will call
 *   field() and pick().
 *
 * WHY A SERVICE RATHER THAN LEAVING IT IN View
 *   View::t() was enough while the only strings were error pages. It is
 *   not enough now. Language detection was living in SessionMiddleware,
 *   content-column selection was about to be written a fourth time inside
 *   whichever repository needed it first, and nothing could report on the
 *   table as a whole. Those are three different callers wanting the same
 *   knowledge — which is the definition of a service.
 *
 *   View::t() stays as the entry point templates use. It now forwards
 *   here. Nothing in any template changes.
 *
 * THE THREE LANGUAGES ARE PEERS
 *   en, hi and hinglish. Hinglish is not "English with Hindi words" and
 *   not a fallback for either — it is the register most of the intended
 *   audience actually speaks, and it is the one most likely to make
 *   somebody send a link to a friend. Anywhere this file treats a
 *   language specially, it is for a mechanical reason (Devanagari needs a
 *   different lang attribute; no browser advertises Hinglish in
 *   Accept-Language), never an editorial one.
 *
 * MISSING KEYS ARE VISIBLE, NEVER BLANK
 *   A key with no translation in the active language falls back to
 *   English. A key with no English either returns the key itself, so a
 *   gap shows up on the page as "learning.quiz.retry" rather than as an
 *   empty button nobody notices until a user reports it.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Services;

use VedaVerse\Core\Config;
use VedaVerse\Core\Logger;
use VedaVerse\Core\Request;
use VedaVerse\Core\Session;
use VedaVerse\Core\View;

class I18nService
{
    /**
     * The merged string table, loaded once per request.
     *
     * @var array<string,array<string,string>>|null
     */
    private static $strings = null;

    /**
     * Keys that were asked for and could not be answered in the requested
     * language. Collected rather than logged one by one, because a page
     * with a missing section would otherwise write forty log lines.
     *
     * @var array<string,string>
     */
    private static $missing = array();

    // -----------------------------------------------------------------
    // Detection
    // -----------------------------------------------------------------

    /**
     * Decide which language this request is in, and remember an explicit
     * choice.
     *
     * Order, first match wins:
     *   1. ?lang= in the URL — so a shared link opens in the language it
     *      was shared in. This is how Hinglish spreads, and it is the
     *      reason the parameter exists at all.
     *   2. The signed-in user's saved preference.
     *   3. Whatever this session last chose.
     *   4. The browser's Accept-Language header.
     *   5. The site default.
     *
     * @param Request $request
     * @return string
     */
    public static function detect(Request $request)
    {
        $available = self::codes();

        $requested = $request->query('lang');
        if (is_string($requested) && in_array($requested, $available, true)) {
            // Remembered, so the choice survives the next click rather
            // than reverting the moment the reader follows a link.
            Session::setLang($requested);
            return $requested;
        }

        $user = Session::user();
        if ($user !== null
            && isset($user['preferred_lang'])
            && in_array($user['preferred_lang'], $available, true)) {
            return (string) $user['preferred_lang'];
        }

        $stored = Session::lang();
        if (is_string($stored) && in_array($stored, $available, true)) {
            return $stored;
        }

        if (Config::get('i18n.detection.accept_header', true)) {
            $fromHeader = self::fromAcceptHeader((string) $request->header('accept-language', ''), $available);
            if ($fromHeader !== null) {
                return $fromHeader;
            }
        }

        return self::defaultLang();
    }

    /**
     * Read Accept-Language loosely.
     *
     * Deliberately crude: take each entry, drop the quality value, drop
     * the region, and accept the first tag we actually publish. No
     * q-value sorting, because the browser already sends them in
     * preference order and a full RFC 4647 implementation would be fifty
     * lines serving a two-language decision.
     *
     * Hinglish is NEVER chosen this way. No browser advertises it, and
     * inferring that an Indian visitor wants romanised Hindi from their
     * locale would be a guess about a person, not about their software.
     * It is offered in the switcher and chosen deliberately.
     *
     * @param string            $header
     * @param array<int,string> $available
     * @return string|null
     */
    public static function fromAcceptHeader($header, array $available)
    {
        if (trim($header) === '') {
            return null;
        }

        foreach (explode(',', $header) as $entry) {
            $parts = explode(';', $entry);
            $code  = strtolower(trim($parts[0]));
            $code  = explode('-', $code);
            $code  = $code[0];

            if ($code === 'hi' && in_array('hi', $available, true)) {
                return 'hi';
            }
            if ($code === 'en' && in_array('en', $available, true)) {
                return 'en';
            }
        }

        return null;
    }

    // -----------------------------------------------------------------
    // Translation
    // -----------------------------------------------------------------

    /**
     * Look up an interface string.
     *
     * Placeholders are written :like_this and replaced from the array:
     *
     *     I18nService::translate('profile.level', array(':n' => 4))
     *
     * They are replaced longest-first, so :name never eats the front of
     * :name_full. strtr() does that for us; the sort is not needed, but
     * relying on it silently would be the kind of thing that breaks when
     * somebody swaps strtr for str_replace. Noted here instead.
     *
     * @param string      $key
     * @param array       $replacements
     * @param string|null $lang Defaults to the active interface language.
     * @return string
     */
    public static function translate($key, array $replacements = array(), $lang = null)
    {
        $key  = (string) $key;
        $lang = $lang === null ? View::lang() : (string) $lang;

        $text = self::lookup($key, $lang);

        if ($text === null) {
            return $key;
        }

        if ($replacements !== array()) {
            $text = strtr($text, $replacements);
        }

        return $text;
    }

    /**
     * Pick the singular or plural form of a string.
     *
     * The two forms live in one value separated by a pipe:
     *
     *     'review.due' => array(
     *         'en' => ':n verse due today|:n verses due today',
     *         ...
     *     )
     *
     * All three languages use two forms — one for exactly 1, one for
     * everything else — which covers English, Hindi and Hinglish
     * correctly. A language needing more forms (Arabic has six) would
     * need a rule table; there is no point building one for a case that
     * does not exist here.
     *
     * :n is filled in automatically. A value with no pipe is returned
     * as-is, so adding a count to an existing key is not a breaking
     * change.
     *
     * @param string      $key
     * @param int         $count
     * @param array       $replacements
     * @param string|null $lang
     * @return string
     */
    public static function choice($key, $count, array $replacements = array(), $lang = null)
    {
        $count = (int) $count;
        $text  = self::translate($key, array(), $lang);

        if (strpos($text, '|') !== false) {
            $forms = explode('|', $text);
            $text  = ($count === 1) ? $forms[0] : $forms[1];
        }

        // Grouped with commas, so 12,500 XP is readable at a glance.
        // All three languages get Western digits: modern Hindi on a
        // screen uses 0-9, and a learner checking their streak should
        // recognise the number without reading it.
        $replacements[':n'] = number_format((float) $count, 0);

        return strtr($text, $replacements);
    }

    /**
     * True when a key exists at all, in any language.
     *
     * @param string $key
     * @return bool
     */
    public static function has($key)
    {
        $strings = self::strings();
        return isset($strings[$key]);
    }

    /**
     * One key in every language, for the review page and the checker.
     *
     * @param string $key
     * @return array<string,string>
     */
    public static function variants($key)
    {
        $strings = self::strings();
        return isset($strings[$key]) ? $strings[$key] : array();
    }

    /**
     * Find the string for a key in a language, falling back once.
     *
     * Returns null when the key does not exist in any language at all —
     * the caller decides whether that is a blank or a visible key name.
     *
     * @param string $key
     * @param string $lang
     * @return string|null
     */
    private static function lookup($key, $lang)
    {
        $strings  = self::strings();
        $fallback = self::fallbackLang();

        if (isset($strings[$key][$lang]) && $strings[$key][$lang] !== '') {
            return (string) $strings[$key][$lang];
        }

        if (isset($strings[$key][$fallback]) && $strings[$key][$fallback] !== '') {
            self::$missing[$key . '/' . $lang] = $key;
            self::reportMissing($key, $lang, 'no translation');
            return (string) $strings[$key][$fallback];
        }

        self::$missing[$key . '/*'] = $key;
        self::reportMissing($key, $lang, 'key not found');
        return null;
    }

    /**
     * Log a gap, but only in debug mode and only once per key per
     * request.
     *
     * On a live site this is silent on purpose. A missing string is a
     * content bug, not an incident, and writing to the log on every page
     * view would bury the errors that matter under noise nobody can act
     * on from a log file anyway. tools/check-strings.php is where gaps
     * get found, before deployment.
     *
     * @param string $key
     * @param string $lang
     * @param string $why
     * @return void
     */
    private static function reportMissing($key, $lang, $why)
    {
        if (!Config::debug()) {
            return;
        }

        static $seen = array();
        $token = $key . '/' . $lang;
        if (isset($seen[$token])) {
            return;
        }
        $seen[$token] = true;

        Logger::debug('Missing interface string', array(
            'key'    => $key,
            'lang'   => $lang,
            'reason' => $why,
        ));
    }

    /**
     * Every gap seen while rendering this request.
     *
     * The style guide shows this in a panel on a local install, which is
     * the difference between noticing a missing Hindi label and shipping
     * one.
     *
     * @return array<int,string>
     */
    public static function missing()
    {
        return array_values(array_unique(self::$missing));
    }

    // -----------------------------------------------------------------
    // Content — database columns, not interface strings
    // -----------------------------------------------------------------

    /**
     * The column name holding a content field in a language.
     *
     *     I18nService::column('translation', 'hi')   →  'translation_hi'
     *
     * Every translated column in the schema is base_en, base_hi,
     * base_hinglish. That convention is load-bearing: it is why a page
     * can render in a new language without a single query changing.
     *
     * @param string      $base
     * @param string|null $lang
     * @return string
     */
    public static function column($base, $lang = null)
    {
        $lang = $lang === null ? View::lang() : (string) $lang;
        if (!self::isAvailable($lang)) {
            $lang = self::fallbackLang();
        }
        return $base . '_' . $lang;
    }

    /**
     * Read a translated field out of a database row.
     *
     * Content falls back differently from interface strings, and the
     * difference matters. An untranslated BUTTON in English is a small
     * blemish. An untranslated VERSE in English, on a page a Hindi
     * reader opened, is the product failing at the only thing it does.
     *
     * So the fallback chain is explicit rather than straight to English:
     * asked-for language, then Hinglish for a Hindi reader and Hindi for
     * a Hinglish reader — they are the same words in two scripts, so a
     * reader of one can nearly always read the other — then English,
     * then the default.
     *
     * @param array       $row
     * @param string      $base
     * @param string|null $lang
     * @return string
     */
    public static function field(array $row, $base, $lang = null)
    {
        $lang = $lang === null ? View::lang() : (string) $lang;

        foreach (self::contentChain($lang) as $candidate) {
            $col = $base . '_' . $candidate;
            if (isset($row[$col]) && trim((string) $row[$col]) !== '') {
                return (string) $row[$col];
            }
        }

        return '';
    }

    /**
     * Which language a field() call actually landed on.
     *
     * A page showing a Hindi verse to a Hinglish reader must mark that
     * element lang="hi", or a screen reader announces Devanagari with an
     * English engine and produces noise. This is how a template knows.
     *
     * @param array       $row
     * @param string      $base
     * @param string|null $lang
     * @return string
     */
    public static function fieldLang(array $row, $base, $lang = null)
    {
        $lang = $lang === null ? View::lang() : (string) $lang;

        foreach (self::contentChain($lang) as $candidate) {
            $col = $base . '_' . $candidate;
            if (isset($row[$col]) && trim((string) $row[$col]) !== '') {
                return $candidate;
            }
        }

        return $lang;
    }

    /**
     * The order to try content languages in for a given reader.
     *
     * @param string $lang
     * @return array<int,string>
     */
    private static function contentChain($lang)
    {
        $chains = array(
            'en'       => array('en', 'hinglish', 'hi'),
            'hi'       => array('hi', 'hinglish', 'en'),
            'hinglish' => array('hinglish', 'hi', 'en'),
        );

        if (isset($chains[$lang])) {
            return $chains[$lang];
        }

        return array(self::defaultLang(), 'en');
    }

    // -----------------------------------------------------------------
    // Language metadata
    // -----------------------------------------------------------------

    /** @return array<int,string> */
    public static function codes()
    {
        return array_keys((array) Config::get('i18n.languages', array()));
    }

    /** @return array<string,array> */
    public static function languages()
    {
        return (array) Config::get('i18n.languages', array());
    }

    /**
     * @param string $lang
     * @return bool
     */
    public static function isAvailable($lang)
    {
        return in_array((string) $lang, self::codes(), true);
    }

    /** @return string */
    public static function defaultLang()
    {
        return (string) Config::get('i18n.default', 'en');
    }

    /** @return string */
    public static function fallbackLang()
    {
        return (string) Config::get('i18n.fallback', 'en');
    }

    /**
     * The value for a lang="" attribute.
     *
     * Not the same as the language code. Hinglish is en-IN, because a
     * speech engine given lang="hi" would try to read romanised text with
     * Hindi phonetics and produce something worse than either.
     *
     * @param string|null $lang
     * @return string
     */
    public static function htmlLang($lang = null)
    {
        $lang = $lang === null ? View::lang() : (string) $lang;
        return (string) Config::get('i18n.languages.' . $lang . '.html_lang', 'en');
    }

    /**
     * The name of a language, written in that language. "हिन्दी", not
     * "Hindi" — a reader looking for their own language scans for the
     * word they would use for it.
     *
     * @param string $lang
     * @return string
     */
    public static function nativeName($lang)
    {
        return (string) Config::get('i18n.languages.' . $lang . '.native_name', $lang);
    }

    /**
     * True when a language is written in Devanagari, which needs looser
     * line height and a font with the conjunct forms.
     *
     * @param string|null $lang
     * @return bool
     */
    public static function isDevanagari($lang = null)
    {
        $lang = $lang === null ? View::lang() : (string) $lang;
        return Config::get('i18n.languages.' . $lang . '.script') === 'devanagari';
    }

    // -----------------------------------------------------------------
    // The table
    // -----------------------------------------------------------------

    /**
     * The merged string table.
     *
     * app/config/i18n.php returns language metadata plus whatever
     * strings it defines directly; app/config/strings/*.php each return
     * one domain's keys. They are merged here rather than in the config
     * file so that a syntax error in one domain file names that file,
     * and so that adding a domain does not mean editing i18n.php.
     *
     * DEVIATION FROM THE SPECIFICATION, DELIBERATE
     *   The build prompt says "app/config/i18n.php — complete interface
     *   string table". Kept in one file, that table would be roughly
     *   2,500 lines by the end of Step 4 and would keep growing through
     *   Step 13 as the admin panel and the forum arrive. Seven domain
     *   files under app/config/strings/ hold exactly the same data with
     *   exactly the same keys — i18n.php still answers
     *   Config::get('i18n.strings') with the whole table — and a
     *   conflict in a pull request touches one domain instead of one
     *   enormous file.
     *
     * @return array<string,array<string,string>>
     */
    public static function strings()
    {
        if (self::$strings !== null) {
            return self::$strings;
        }

        self::$strings = (array) Config::get('i18n.strings', array());
        return self::$strings;
    }

    /**
     * Drop the cached table. For the checker and the tests, which load
     * the files themselves and want a clean read.
     *
     * @return void
     */
    public static function flush()
    {
        self::$strings = null;
        self::$missing = array();
    }

    /**
     * Every key, grouped by the first segment of its name.
     *
     * Used by the review page and the string checker; both want to show
     * a domain at a time rather than 300 keys in one list.
     *
     * @return array<string,array<int,string>>
     */
    public static function byDomain()
    {
        $grouped = array();

        foreach (array_keys(self::strings()) as $key) {
            $dot    = strpos($key, '.');
            $domain = ($dot === false) ? $key : substr($key, 0, $dot);
            if (!isset($grouped[$domain])) {
                $grouped[$domain] = array();
            }
            $grouped[$domain][] = $key;
        }

        ksort($grouped);
        return $grouped;
    }

    /**
     * Check the whole table and report what is wrong with it.
     *
     * Three kinds of fault, in descending order of how much they hurt:
     *
     *   missing      A key has no text in a language. The reader gets
     *                English where they asked for Hindi.
     *   placeholders A key uses :n in English and :count in Hindi, or
     *                drops the placeholder entirely. The Hindi reader
     *                sees a literal ":n" or a sentence with a hole in
     *                it. This is the failure that survives review,
     *                because the string looks fine on its own.
     *   plurals      One language has two plural forms and another has
     *                one. The count vanishes or the wrong form shows.
     *
     * Returns a structure rather than printing, so both the CLI checker
     * and the browser review page can render the same findings.
     *
     * @return array{missing:array,placeholders:array,plurals:array,counts:array}
     */
    public static function audit()
    {
        $strings   = self::strings();
        $languages = self::codes();
        $fallback  = self::fallbackLang();

        $report = array(
            'missing'      => array(),
            'placeholders' => array(),
            'plurals'      => array(),
            'counts'       => array(),
        );

        foreach ($languages as $lang) {
            $report['counts'][$lang] = 0;
        }

        foreach ($strings as $key => $variants) {
            if (!is_array($variants)) {
                $report['missing'][] = array('key' => $key, 'lang' => '*', 'note' => 'not an array of languages');
                continue;
            }

            $reference = isset($variants[$fallback]) ? (string) $variants[$fallback] : null;

            foreach ($languages as $lang) {
                $text = isset($variants[$lang]) ? (string) $variants[$lang] : '';

                if (trim($text) === '') {
                    $report['missing'][] = array('key' => $key, 'lang' => $lang, 'note' => 'empty or absent');
                    continue;
                }

                $report['counts'][$lang]++;

                if ($reference === null || $lang === $fallback) {
                    continue;
                }

                $want = self::placeholdersIn($reference);
                $got  = self::placeholdersIn($text);

                $lost  = array_diff($want, $got);
                $extra = array_diff($got, $want);

                if ($lost !== array() || $extra !== array()) {
                    $report['placeholders'][] = array(
                        'key'   => $key,
                        'lang'  => $lang,
                        'lost'  => array_values($lost),
                        'extra' => array_values($extra),
                    );
                }

                $wantForms = substr_count($reference, '|');
                $gotForms  = substr_count($text, '|');
                if ($wantForms !== $gotForms) {
                    $report['plurals'][] = array(
                        'key'  => $key,
                        'lang' => $lang,
                        'want' => $wantForms + 1,
                        'got'  => $gotForms + 1,
                    );
                }
            }
        }

        return $report;
    }

    /**
     * Every :placeholder in a string.
     *
     * The pattern stops at a word boundary, so ":n minutes" yields :n and
     * not ":n minutes". A colon followed by a space — which happens in
     * ordinary prose — is not a placeholder and is not matched.
     *
     * @param string $text
     * @return array<int,string>
     */
    public static function placeholdersIn($text)
    {
        $found = array();
        if (preg_match_all('/:[a-z][a-z0-9_]*/i', (string) $text, $matches) && isset($matches[0])) {
            $found = array_values(array_unique($matches[0]));
        }
        sort($found);
        return $found;
    }
}
