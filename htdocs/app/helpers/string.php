<?php
/**
 * VedaVerse — app/helpers/string.php
 * ---------------------------------------------------------------------
 * Text handling, written for a product that is one third Devanagari.
 *
 * THE RULE RUNNING THROUGH THIS FILE
 *   Never use strlen(), substr(), strtolower() or str_split() on user or
 *   content text. They count BYTES. "कृष्ण" is five characters and
 *   fifteen bytes, so substr($name, 0, 10) would cut a Hindi name in the
 *   middle of a character and produce a broken glyph — or, in a database
 *   column, a value that will not round-trip.
 *
 *   Every function here uses the mb_* family. There is a fallback for the
 *   unlikely case that mbstring is missing, but install.php marks it a
 *   fatal requirement precisely so that fallback never runs.
 *
 * PHP 7.4 COMPATIBLE.
 */

if (!function_exists('str_length')) {
    /**
     * Length in characters, not bytes.
     *
     * @param string $value
     * @return int
     */
    function str_length($value)
    {
        $value = (string) $value;
        return function_exists('mb_strlen') ? mb_strlen($value, 'UTF-8') : strlen($value);
    }
}

if (!function_exists('str_cut')) {
    /**
     * Take the first N characters, safely.
     *
     * @param string $value
     * @param int    $length
     * @param int    $start
     * @return string
     */
    function str_cut($value, $length, $start = 0)
    {
        $value = (string) $value;
        return function_exists('mb_substr')
            ? mb_substr($value, (int) $start, (int) $length, 'UTF-8')
            : substr($value, (int) $start, (int) $length);
    }
}

if (!function_exists('str_limit')) {
    /**
     * Truncate to a length, breaking at a word boundary and appending an
     * ellipsis. For card previews and meta descriptions.
     *
     * Cutting mid-word reads as broken; cutting at a space reads as
     * deliberate. Costs one extra strrpos.
     *
     * @param string $value
     * @param int    $length
     * @param string $suffix
     * @return string
     */
    function str_limit($value, $length = 120, $suffix = '…')
    {
        $value = trim(preg_replace('/\s+/u', ' ', (string) $value));

        if (str_length($value) <= $length) {
            return $value;
        }

        $cut   = str_cut($value, $length);
        $space = function_exists('mb_strrpos') ? mb_strrpos($cut, ' ', 0, 'UTF-8') : strrpos($cut, ' ');

        // Only break at the space if it is reasonably near the end.
        // Otherwise a long unbroken string would be cut to almost nothing.
        if ($space !== false && $space > (int) ($length * 0.6)) {
            $cut = str_cut($cut, $space);
        }

        return rtrim($cut) . $suffix;
    }
}

if (!function_exists('str_words')) {
    /**
     * Count words. Used for the twenty-word floor on forum threads and
     * the twenty-word ceiling on a "Remember This" hook.
     *
     * @param string $value
     * @return int
     */
    function str_words($value)
    {
        return (int) preg_match_all('/\S+/u', (string) $value);
    }
}

if (!function_exists('slugify')) {
    /**
     * Turn a title into a URL slug.
     *
     * Devanagari has no ASCII equivalent, so a Hindi title would slugify
     * to an empty string. When that happens the caller gets '' back and
     * must supply its own fallback — for a verse that is the chapter and
     * verse number, which is a better URL than transliterated Sanskrit
     * would be anyway.
     *
     * Never trust this to be unique. The database has the unique key.
     *
     * @param string $value
     * @return string
     */
    function slugify($value)
    {
        $value = (string) $value;

        // Strip accents where an ASCII equivalent exists (é -> e). Left
        // alone for scripts with no equivalent.
        if (function_exists('iconv')) {
            $ascii = @iconv('UTF-8', 'ASCII//TRANSLIT//IGNORE', $value);
            if ($ascii !== false) {
                $value = $ascii;
            }
        }

        $value = strtolower($value);
        $value = preg_replace('/[^a-z0-9]+/', '-', $value);

        return trim((string) $value, '-');
    }
}

if (!function_exists('str_clean')) {
    /**
     * Strip control characters and normalise whitespace on the way in.
     *
     * This is NOT sanitising for output — a name may legitimately contain
     * a less-than sign, and the view escapes it. What this removes is
     * invisible junk: null bytes, zero-width characters used to fake
     * duplicate usernames, and the bidirectional override characters that
     * can make a filename display backwards.
     *
     * @param string $value
     * @return string
     */
    function str_clean($value)
    {
        $value = (string) $value;

        // C0 and C1 control characters, except tab, newline and return.
        $value = preg_replace('/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]/u', '', $value);

        // Zero-width space, joiner, non-joiner, BOM, and the bidi
        // overrides. Note that the zero-width joiner (U+200D) IS needed by
        // Devanagari conjuncts, so it is deliberately not in this list.
        $value = preg_replace('/[\x{200B}\x{200E}\x{200F}\x{202A}-\x{202E}\x{FEFF}]/u', '', $value);

        return trim($value);
    }
}

if (!function_exists('str_squish')) {
    /**
     * Collapse runs of whitespace into single spaces.
     *
     * @param string $value
     * @return string
     */
    function str_squish($value)
    {
        return trim(preg_replace('/\s+/u', ' ', (string) $value));
    }
}

if (!function_exists('str_mask')) {
    /**
     * Partially hide a value for display — an email in an admin list, a
     * recovery code in a log line.
     *
     *   str_mask('rohit@example.com') -> 'ro***@example.com'
     *
     * @param string $value
     * @param int    $keep How many leading characters to show.
     * @return string
     */
    function str_mask($value, $keep = 2)
    {
        $value = (string) $value;

        $at = strpos($value, '@');
        if ($at !== false) {
            $local  = str_cut($value, $at);
            $domain = substr($value, $at);
            return str_cut($local, $keep) . '***' . $domain;
        }

        if (str_length($value) <= $keep) {
            return str_repeat('*', str_length($value));
        }

        return str_cut($value, $keep) . str_repeat('*', max(3, str_length($value) - $keep));
    }
}

if (!function_exists('str_initials')) {
    /**
     * Initials for an avatar placeholder. Works with Devanagari, where it
     * returns the first character of each word rather than a Latin letter.
     *
     * @param string $name
     * @param int    $max
     * @return string
     */
    function str_initials($name, $max = 2)
    {
        $parts = preg_split('/\s+/u', str_squish($name));
        if (!is_array($parts)) {
            return '';
        }

        $out = '';
        foreach ($parts as $part) {
            if ($part === '') {
                continue;
            }
            $out .= str_cut($part, 1);
            if (str_length($out) >= $max) {
                break;
            }
        }

        return function_exists('mb_strtoupper') ? mb_strtoupper($out, 'UTF-8') : strtoupper($out);
    }
}

if (!function_exists('str_contains_any')) {
    /**
     * Does the haystack contain any of these needles, case-insensitively?
     *
     * Used for the crisis-signal check in the offline responder and for
     * the prompt-injection pattern scan.
     *
     * @param string            $haystack
     * @param array<int,string> $needles
     * @return bool
     */
    function str_contains_any($haystack, array $needles)
    {
        $haystack = function_exists('mb_strtolower')
            ? mb_strtolower((string) $haystack, 'UTF-8')
            : strtolower((string) $haystack);

        foreach ($needles as $needle) {
            $needle = function_exists('mb_strtolower')
                ? mb_strtolower((string) $needle, 'UTF-8')
                : strtolower((string) $needle);

            if ($needle !== '' && strpos($haystack, $needle) !== false) {
                return true;
            }
        }

        return false;
    }
}
