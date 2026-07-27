<?php
/**
 * VedaVerse — app/config/ai.php
 * ---------------------------------------------------------------------
 * Settings for Sarathi, the AI guide.
 *
 * READ THIS BEFORE YOU CHANGE ANYTHING HERE
 *
 *   PHP in VedaVerse never makes an outbound HTTP call. Not to OpenAI, not to
 *   GitHub, not to Google. The host cannot resolve external DNS from PHP,
 *   so such a call would fail on the live site even though it works on
 *   your laptop. If you ever find curl_exec() pointed at a third-party
 *   domain anywhere in app/, that is a bug, not a feature.
 *
 *   What actually happens:
 *     1. The browser asks api/chat_token.php for a short-lived signed
 *        token. Same origin, CSRF checked. PHP mints it and attaches the
 *        retrieved verse context.
 *     2. The browser calls the Cloudflare Worker directly with that token.
 *     3. The Worker verifies the signature, checks the rate limit, and
 *        talks to the AI providers. It holds the API keys.
 *     4. The browser posts the result back to api/chat_save.php.
 *
 *   The signing secret therefore exists in exactly two places: local.php
 *   on this host, and a Cloudflare Worker secret. It is never sent to the
 *   browser and never appears in a page source.
 *
 * WHAT YOU EDIT IN THE ADMIN PANEL INSTEAD OF HERE
 *   The Worker URL and the rate limits are stored in the settings table so
 *   they can change without an FTP upload. The values below are fallbacks
 *   used when a setting is missing.
 */

return array(

    // Master switch. install.php leaves this off until a Worker URL is
    // saved in admin, so a fresh install never shows a chat box that
    // cannot possibly work.
    'enabled' => false,

    // -----------------------------------------------------------------
    // Worker
    // -----------------------------------------------------------------
    // Example: https://vedaverse-sarathi.yourname.workers.dev
    // No trailing slash. Overridden by settings.worker_url.
    'worker_url' => '',

    // Written by install.php into local.php. Must be byte-identical to the
    // Worker secret set with: wrangler secret put SIGNING_SECRET
    // If the two differ, every chat request comes back 401 from the Worker.
    'signing_secret' => 'CHANGE-ME-INSTALLER-WILL-REPLACE-THIS',

    'token' => array(
        // Seconds a minted token stays valid. Deliberately short. A leaked
        // token is worth two minutes of somebody else's rate limit and
        // nothing more.
        'ttl'         => 120,
        // The Worker burns the token's id in KV on first use, so a
        // captured token cannot be replayed even inside its window.
        'single_use'  => true,
        'algo'        => 'sha256',
    ),

    // -----------------------------------------------------------------
    // Provider chain
    // -----------------------------------------------------------------
    // Configured here for documentation and for the admin dashboard. The
    // Worker holds its own copies in environment variables so the endpoint
    // or model can change without redeploying code.
    //
    // VERIFY BEFORE LAUNCH: GitHub's Models endpoint, the exact model
    // string, and the free-tier limits move. Check GitHub's Models
    // documentation and update the Worker's environment variables rather
    // than editing this file.
    'providers' => array(

        // Tier 1.
        'github' => array(
            'label'    => 'GitHub Models',
            'endpoint' => 'https://models.github.ai/inference/chat/completions',
            'model'    => 'openai/gpt-4o-mini',
            // The PAT needs the models: read scope and nothing else.
            // It lives ONLY as a Worker secret named GITHUB_PAT.
            'auth'     => 'worker-secret:GITHUB_PAT',
        ),

        // Tier 2. A different vendor on a different network with a
        // different rate-limit bucket, which is the entire point. Two
        // models behind the same endpoint and the same token are not a
        // fallback, they are one point of failure with two names.
        'gemini' => array(
            'label'    => 'Google Gemini',
            'endpoint' => 'https://generativelanguage.googleapis.com/v1beta/models',
            'model'    => 'gemini-2.0-flash',
            'auth'     => 'worker-secret:GEMINI_API_KEY',
        ),

        // Tier 3. Runs in the browser against the cached content bundle.
        // No network at all, which is why it is the last resort and why it
        // cannot fail. It composes an acknowledgement, one relevant verse,
        // one modern example, one reflection question, and an honest line
        // saying Sarathi is offline. The learner never sees a dead spinner.
        'static' => array(
            'label'  => 'Offline responder',
            'source' => 'assets/data/content-bundle.json',
        ),
    ),

    // Per provider. One retry, then move down the chain. Never loop.
    'timeout_seconds' => 15,
    'max_retries'     => 1,

    // Turns falling back into a measurable thing rather than a rumour.
    // Every assistant message records which provider answered.
    'log_provider' => true,

    // -----------------------------------------------------------------
    // Rate limits
    // -----------------------------------------------------------------
    // Enforced in the Worker with KV, which is the only enforcement that
    // counts. Mirrored into the ai_usage table so the interface can show
    // "6 of 25 left today" BEFORE the learner types, rather than throwing
    // a wall in their face after.
    'limits' => array(
        'anon' => array('hour' => 10,  'day' => 25),
        'user' => array('hour' => 50,  'day' => 100),
        // Admins are unlimited. This is a convenience for testing the
        // fallback chain, not a business decision.
        'admin' => array('hour' => 0,  'day' => 0),
    ),

    // -----------------------------------------------------------------
    // Retrieval
    // -----------------------------------------------------------------
    // Structured RAG against MySQL. No vector database, no embeddings.
    // Retrieval runs in PHP when the token is minted, and the result rides
    // along in the request as context[].
    //
    // Never dump the whole database into a prompt. Three to five verses
    // with their examples is both cheaper and more accurate than fifty.
    'retrieval' => array(
        'max_verses'            => 5,
        'max_examples_per_verse'=> 2,
        'max_context_chars'     => 6000,
        'history_turns'         => 8,
    ),

    // -----------------------------------------------------------------
    // Prompt safety
    // -----------------------------------------------------------------
    // Two layers. Sarathi's system prompt tells it to ignore override
    // attempts, and separately the Worker strips instruction-shaped
    // patterns out of retrieved context before injection. Both, because
    // one is a request and the other is a guarantee.
    //
    // Treat all user text as data, never as instruction.
    'injection_patterns' => array(
        'ignore (all )?(previous|prior|above) instructions',
        'disregard (your|the) (instructions|prompt|rules)',
        'system prompt',
        'you are now',
        'reveal your (instructions|prompt|rules)',
        'act as (if|though) you',
        'developer mode',
    ),

    // The full system prompt is embedded verbatim in worker/worker.js, not
    // here, because that is where it is used and shipping it to PHP would
    // mean two copies drifting apart. This is a pointer, not the text.
    'system_prompt_location' => 'worker/worker.js',

    // Phrases that trigger the crisis response path. When any of these
    // match, the Worker prepends a crisis instruction and the teaching
    // voice is dropped entirely. Kept in PHP too so the offline responder
    // behaves the same way with no network.
    'crisis_signals' => array(
        'kill myself', 'end my life', 'suicide', 'self harm', 'self-harm',
        'want to die', 'no reason to live', 'hurt myself', 'hurt someone',
        'better off dead', 'cant go on', "can't go on",
    ),
);
