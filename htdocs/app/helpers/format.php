<?php
/**
 * VedaVerse — app/helpers/format.php
 * ---------------------------------------------------------------------
 * Turning numbers and multi-language records into display strings.
 *
 * PHP 7.4 COMPATIBLE.
 */

use VedaVerse\Core\Config;
use VedaVerse\Core\View;

if (!function_exists('lang_field')) {
    /**
     * Read the right language column out of a content row.
     *
     *   lang_field($verse, 'translation')   -> translation_hi for a Hindi reader
     *
     * Falls back to English when the requested language is empty, which
     * is the normal state for a verse that is not yet curated in all
     * three. Returns '' rather than null so a template can print it
     * without a check.
     *
     * This is the single place that fallback rule lives. If it were
     * inlined at each call site, some pages would fall back and others
     * would show a blank, and nobody would notice which until a Hindi
     * reader complained.
     *
     * @param array<string,mixed> $row
     * @param string              $field Base column name, without the suffix.
     * @param string|null         $lang
     * @return string
     */
    function lang_field($row, $field, $lang = null)
    {
        if (!is_array($row)) {
            return '';
        }

        $lang     = $lang === null ? View::lang() : $lang;
        $fallback = (string) Config::get('i18n.fallback', 'en');

        $key = $field . '_' . $lang;
        if (isset($row[$key]) && trim((string) $row[$key]) !== '') {
            return (string) $row[$key];
        }

        $key = $field . '_' . $fallback;
        if (isset($row[$key]) && trim((string) $row[$key]) !== '') {
            return (string) $row[$key];
        }

        return '';
    }
}

if (!function_exists('lang_attr')) {
    /**
     * The lang attribute for a block of content.
     *
     * This is an accessibility requirement, not decoration. A screen
     * reader given no language attribute reads Devanagari with an English
     * speech engine, which produces noise rather than words. Sanskrit
     * gets 'sa', Hindi 'hi', Hinglish 'en-IN'.
     *
     * @param string $lang
     * @return string
     */
    function lang_attr($lang)
    {
        $html = Config::get('i18n.languages.' . $lang . '.html_lang');
        if ($html === null) {
            $html = Config::get('i18n.content_languages.' . $lang . '.html_lang', $lang);
        }
        return ' lang="' . e($html) . '"';
    }
}

if (!function_exists('number_short')) {
    /**
     * Compact numbers for stat tiles: 1200 -> 1.2k.
     *
     * Uses k and M rather than the Indian lakh and crore. The audience is
     * mixed and k reads unambiguously in all three languages, where
     * "1.2L" would not.
     *
     * @param int|float $value
     * @return string
     */
    function number_short($value)
    {
        $value = (float) $value;

        if (abs($value) >= 1000000) {
            return rtrim(rtrim(number_format($value / 1000000, 1), '0'), '.') . 'M';
        }
        if (abs($value) >= 1000) {
            return rtrim(rtrim(number_format($value / 1000, 1), '0'), '.') . 'k';
        }

        return (string) (int) $value;
    }
}

if (!function_exists('percent')) {
    /**
     * A whole-number percentage, clamped to 0–100.
     *
     * Clamping matters: a progress bar driven by an uncapped value can
     * render past its container and break a layout, and the cause is very
     * hard to spot in a screenshot.
     *
     * @param int|float $part
     * @param int|float $whole
     * @return int
     */
    function percent($part, $whole)
    {
        $whole = (float) $whole;
        if ($whole <= 0) {
            return 0;
        }
        $value = ((float) $part / $whole) * 100;
        return (int) max(0, min(100, round($value)));
    }
}

if (!function_exists('level_from_xp')) {
    /**
     * Level = floor(sqrt(xp / 50)) + 1.
     *
     * A square-root curve rather than a linear one, so early levels come
     * quickly and later ones take real work — which is what makes the
     * first week feel rewarding without making level 40 meaningless.
     *
     * @param int $xp
     * @return int
     */
    function level_from_xp($xp)
    {
        $divisor = (int) Config::get('app.xp.level_divisor', 50);
        if ($divisor < 1) {
            $divisor = 50;
        }
        return (int) floor(sqrt(max(0, (int) $xp) / $divisor)) + 1;
    }
}

if (!function_exists('xp_for_level')) {
    /**
     * The XP needed to reach a level. The inverse of level_from_xp, used
     * to draw the progress bar towards the next level.
     *
     * @param int $level
     * @return int
     */
    function xp_for_level($level)
    {
        $divisor = (int) Config::get('app.xp.level_divisor', 50);
        $level   = max(1, (int) $level);
        return (int) (pow($level - 1, 2) * $divisor);
    }
}

if (!function_exists('level_progress')) {
    /**
     * How far through the current level, as a percentage.
     *
     * @param int $xp
     * @return int
     */
    function level_progress($xp)
    {
        $xp      = max(0, (int) $xp);
        $level   = level_from_xp($xp);
        $floor   = xp_for_level($level);
        $ceiling = xp_for_level($level + 1);

        if ($ceiling <= $floor) {
            return 0;
        }

        return percent($xp - $floor, $ceiling - $floor);
    }
}

if (!function_exists('plural')) {
    /**
     * Pick a singular or plural translation key by count.
     *
     * Deliberately two-form. Hindi and English both work this way for the
     * counts VedaVerse displays. A language with more plural categories
     * would need a real CLDR rule set, and adding one now for a case that
     * does not exist would be complexity without a purpose.
     *
     * @param int    $count
     * @param string $singularKey
     * @param string $pluralKey
     * @return string
     */
    function plural($count, $singularKey, $pluralKey)
    {
        $count = (int) $count;
        return t($count === 1 ? $singularKey : $pluralKey, array(':n' => $count));
    }
}

if (!function_exists('difficulty_label')) {
    /**
     * @param string $difficulty
     * @return string
     */
    function difficulty_label($difficulty)
    {
        $allowed = array('beginner', 'intermediate', 'advanced');
        $key     = in_array($difficulty, $allowed, true) ? $difficulty : 'beginner';
        return t('difficulty.' . $key);
    }
}

if (!function_exists('verse_ref')) {
    /**
     * A verse reference as "2.47".
     *
     * Used everywhere a verse is cited. Never invent or alter numbering —
     * this formats what the database holds and nothing else.
     *
     * @param int $chapter
     * @param int $verse
     * @return string
     */
    function verse_ref($chapter, $verse)
    {
        return (int) $chapter . '.' . (int) $verse;
    }
}

if (!function_exists('bytes_label')) {
    /**
     * Human-readable file size, for the admin's "rebuild offline bundle"
     * report and the storage widget.
     *
     * @param int $bytes
     * @return string
     */
    function bytes_label($bytes)
    {
        $bytes = (float) $bytes;
        $units = array('B', 'KB', 'MB', 'GB');

        $i = 0;
        while ($bytes >= 1024 && $i < count($units) - 1) {
            $bytes /= 1024;
            $i++;
        }

        return round($bytes, $i === 0 ? 0 : 1) . ' ' . $units[$i];
    }
}
