<?php
/**
 * VedaVerse — app/config/local.example.php
 * ---------------------------------------------------------------------
 * A worked example of the file install.php generates.
 *
 * WHAT local.php IS
 *   The one config file that contains real secrets, and the only one that
 *   differs between your machine and the live host. Config::get() loads it
 *   last and merges it over everything else, so any value in here beats
 *   the same value in app.php, database.php or ai.php.
 *
 * YOU DO NOT NORMALLY CREATE THIS FILE BY HAND
 *   install.php writes it for you from what you type into the browser.
 *   This example exists so that (a) you can see what the installer made,
 *   and (b) you can recreate it manually if you ever move hosts without
 *   re-running the installer.
 *
 * TO USE IT MANUALLY
 *   Copy this file to local.php in the same folder, fill in the four
 *   database values, and generate two long random strings for the pepper
 *   and the signing secret. Do not invent them by typing on the keyboard.
 *
 * NEVER
 *   * commit local.php to git (it is in .gitignore)
 *   * paste its contents into a support forum
 *   * reuse the signing secret anywhere else
 *
 * The whole app/ folder is blocked from the web by .htaccess, and this
 * folder additionally carries a guard index.php. Even so, treat the
 * contents as if they could leak, and rotate them if you ever suspect
 * they have.
 */

return array(

    'app' => array(
        // 'production' on the live host, 'local' on your machine.
        'env'   => 'production',
        // Must be false on the live host. See app.php.
        'debug' => false,
    ),

    // The four values from your host's MySQL panel.
    'database' => array(
        'host'     => 'sql000.infinityfree.com',
        'database' => 'if0_00000000_vedaverse',
        'username' => 'if0_00000000',
        'password' => 'your-database-password',
    ),

    'security' => array(
        // Site-wide secret mixed into IP and token hashes.
        // Generate with: bin2hex(random_bytes(32))
        'pepper' => 'replace-with-64-random-hex-characters',
    ),

    'ai' => array(
        // Filled in from the admin panel after you deploy the Worker.
        // No trailing slash.
        'worker_url' => '',

        // Must match the Worker secret exactly:
        //   wrangler secret put SIGNING_SECRET
        // If these two strings differ by even one character, every chat
        // request returns 401 and the site falls back to the offline
        // responder, which looks like "the AI is broken" but is not.
        'signing_secret' => 'replace-with-64-random-hex-characters',
    ),
);
