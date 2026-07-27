<?php
/**
 * VedaVerse — app/config/database.php
 * ---------------------------------------------------------------------
 * MySQL connection settings.
 *
 * YOU PROBABLY DO NOT NEED TO EDIT THIS FILE.
 *   install.php asks for your four database credentials in the browser and
 *   writes them into app/config/local.php. Config::get() merges that file
 *   over this one, so whatever you typed into the installer wins.
 *
 *   Edit this file only if you are moving the site to a different host by
 *   hand and cannot re-run the installer.
 *
 * WHERE TO FIND YOUR CREDENTIALS ON INFINITYFREE
 *   Control panel, then "MySQL Databases". You need four things:
 *     host      looks like sqlXXX.infinityfree.com  (NOT localhost)
 *     database  looks like ifX_XXXXXXXX_vedaverse
 *     username  looks like ifX_XXXXXXXX
 *     password  the one you set when creating the database
 *
 * WHY utf8mb4 EVERYWHERE
 *   Plain utf8 in MySQL is a three-byte encoding that cannot store every
 *   character. utf8mb4 is the real thing. If any part of the chain drops
 *   to something else, Devanagari arrives as ???? and the damage happens
 *   at write time, so it cannot be fixed later by changing the display.
 *   Connection charset, table charset and column charset must all match.
 */

return array(

    // The connection VedaVerse uses. There is exactly one.
    'host'      => 'localhost',
    'port'      => 3306,
    'database'  => 'vedaverse_db',
    'username'  => 'root',
    'password'  => '',

    'charset'   => 'utf8mb4',
    'collation' => 'utf8mb4_unicode_ci',

    // Optional table prefix. Leave empty unless you are sharing one
    // database with another application. If you set it after installing,
    // nothing will find its tables.
    'prefix'    => '',

    /**
     * PDO options.
     *
     * ERRMODE_EXCEPTION   — a failed query throws instead of returning
     *                       false, so a mistake is loud rather than silent.
     * FETCH_ASSOC         — rows come back as $row['column'], not both
     *                       named and numeric keys. Half the memory.
     * EMULATE_PREPARES 0  — send real prepared statements to MySQL rather
     *                       than letting PDO fake them by string
     *                       substitution. This is the setting that makes
     *                       prepared statements a genuine defence against
     *                       SQL injection rather than a convention.
     * STRINGIFY_FETCHES 0 — integers come back as integers on PHP 8.
     * PERSISTENT false    — free shared hosting has a low connection
     *                       ceiling. Persistent connections hold slots open
     *                       and will get the account throttled. One
     *                       connection per request, closed at the end.
     */
    'options' => array(
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
        PDO::ATTR_STRINGIFY_FETCHES  => false,
        PDO::ATTR_PERSISTENT         => false,
    ),

    // Seconds to wait for the connection before giving up. Short on
    // purpose: a hung database should show the friendly error page fast,
    // not hold the request open until the host kills it.
    'connect_timeout' => 8,

    // Written into the connection as soon as it opens. Belt and braces on
    // top of the DSN charset, because some MySQL builds ignore one or the
    // other.
    'init_command' => "SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci",
);
