<?php
/**
 * VedaVerse — app/helpers/date.php
 * ---------------------------------------------------------------------
 * Dates, and the day boundary that streaks depend on.
 *
 * THE THING THAT MATTERS HERE
 *   A streak increments once per CALENDAR DAY, and spaced repetition is
 *   due on a calendar day. Both need one consistent answer to "what day
 *   is it", and that answer must not change depending on which server
 *   the code lands on.
 *
 *   Everything below uses the application timezone from config (Asia/
 *   Kolkata by default), set once in index.php. The database stores UTC
 *   in DATETIME columns. Mixing the two silently is how a learner in
 *   Delhi loses a streak at 5:30 in the morning.
 *
 * PHP 7.4 COMPATIBLE.
 */

use VedaVerse\Core\Config;
use VedaVerse\Core\View;

if (!function_exists('app_today')) {
    /**
     * Today's date in the application timezone, as YYYY-MM-DD.
     *
     * This is the single source of truth for "what day is it" across
     * streaks, SM-2 due dates and the daily verse.
     *
     * @return string
     */
    function app_today()
    {
        return date('Y-m-d');
    }
}

if (!function_exists('app_now')) {
    /**
     * The current moment as a MySQL DATETIME string.
     *
     * @return string
     */
    function app_now()
    {
        return date('Y-m-d H:i:s');
    }
}

if (!function_exists('days_between')) {
    /**
     * Whole days from $from to $to. Negative when $to is earlier.
     *
     * Compares dates rather than timestamps, so 23:55 yesterday to 00:05
     * today is one day, not zero. That is the behaviour a streak needs.
     *
     * @param string $from YYYY-MM-DD or any parseable date
     * @param string|null $to Defaults to today.
     * @return int
     */
    function days_between($from, $to = null)
    {
        $to = $to === null ? app_today() : $to;

        $a = strtotime(date('Y-m-d', strtotime((string) $from)));
        $b = strtotime(date('Y-m-d', strtotime((string) $to)));

        if ($a === false || $b === false) {
            return 0;
        }

        return (int) round(($b - $a) / 86400);
    }
}

if (!function_exists('is_today')) {
    /**
     * @param string|null $date
     * @return bool
     */
    function is_today($date)
    {
        if ($date === null || $date === '') {
            return false;
        }
        return date('Y-m-d', strtotime((string) $date)) === app_today();
    }
}

if (!function_exists('is_yesterday')) {
    /**
     * The check that decides whether a streak continues or breaks.
     *
     * @param string|null $date
     * @return bool
     */
    function is_yesterday($date)
    {
        if ($date === null || $date === '') {
            return false;
        }
        return days_between($date, app_today()) === 1;
    }
}

if (!function_exists('format_date')) {
    /**
     * A date formatted for the current interface language.
     *
     * Deliberately plain: "27 Jul 2026". Localised month names would need
     * either the intl extension, which is not guaranteed on this host, or
     * a hand-written month table in three languages. Neither is worth it
     * for a date that appears on a certificate and in an admin list.
     *
     * @param string|null $date
     * @param string|null $lang
     * @return string
     */
    function format_date($date, $lang = null)
    {
        if ($date === null || $date === '') {
            return '';
        }

        $timestamp = strtotime((string) $date);
        if ($timestamp === false) {
            return '';
        }

        $lang   = $lang === null ? View::lang() : $lang;
        $format = (string) Config::get('i18n.languages.' . $lang . '.date_format', 'j M Y');

        return date($format, $timestamp);
    }
}

if (!function_exists('format_datetime')) {
    /**
     * @param string|null $datetime
     * @return string
     */
    function format_datetime($datetime)
    {
        if ($datetime === null || $datetime === '') {
            return '';
        }
        $timestamp = strtotime((string) $datetime);
        return $timestamp === false ? '' : date('j M Y, H:i', $timestamp);
    }
}

if (!function_exists('time_ago')) {
    /**
     * A relative time — "3 days ago", "just now".
     *
     * Every string is a translation key, so this works in all three
     * languages. Falls back to an absolute date past a month, because
     * "437 days ago" is harder to read than the date itself.
     *
     * @param string|null $datetime
     * @return string
     */
    function time_ago($datetime)
    {
        if ($datetime === null || $datetime === '') {
            return '';
        }

        $timestamp = strtotime((string) $datetime);
        if ($timestamp === false) {
            return '';
        }

        $seconds = time() - $timestamp;

        // A clock skew or a future date reads as "just now" rather than
        // as a negative duration.
        if ($seconds < 60) {
            return t('time.just_now');
        }
        if ($seconds < 3600) {
            return t('time.minutes', array(':n' => (int) floor($seconds / 60)));
        }
        if ($seconds < 86400) {
            return t('time.hours', array(':n' => (int) floor($seconds / 3600)));
        }
        if ($seconds < 2592000) {
            return t('time.days', array(':n' => (int) floor($seconds / 86400)));
        }

        return format_date($datetime);
    }
}

if (!function_exists('minutes_label')) {
    /**
     * "5 min" for an estimated reading or practice time.
     *
     * @param int $minutes
     * @return string
     */
    function minutes_label($minutes)
    {
        $minutes = (int) $minutes;
        if ($minutes < 1) {
            return t('time.under_a_minute');
        }
        return t('time.minutes_short', array(':n' => $minutes));
    }
}
