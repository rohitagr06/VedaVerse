/* =====================================================================
 * VedaVerse — assets/js/app.js
 * ---------------------------------------------------------------------
 * The only JavaScript the interface needs to function: theme choice,
 * text size, and the CSRF header on fetch calls.
 *
 * PROGRESSIVE ENHANCEMENT IS NOT OPTIONAL HERE
 *   Every page works with this file blocked, failed or still loading.
 *   Reading, navigating, signing in, taking a quiz — all of it is server
 *   rendered and works without a line of script. What this adds is
 *   preference and polish.
 *
 *   That is not purism. A large share of the audience is on a mid-range
 *   Android phone on a connection that drops, and a site that shows
 *   nothing until its JavaScript arrives shows nothing rather often.
 *
 * NO FRAMEWORK, NO BUILD STEP
 *   Plain ES5-compatible JavaScript in an IIFE. It runs as written, from
 *   the file as committed, with no transpiler between the two.
 *
 * STORAGE
 *   Preferences go in localStorage, which is a per-device choice and
 *   deliberately not synced — somebody using dark mode on their phone at
 *   night does not necessarily want it on a laptop at noon.
 * ===================================================================== */

(function () {
    'use strict';

    var STORAGE_THEME = 'vv-theme';
    var STORAGE_SIZE  = 'vv-size';

    var root = document.documentElement;

    /**
     * localStorage throws rather than returning null in Safari private
     * browsing and when a browser has storage disabled entirely. Every
     * access is wrapped, because a preference that cannot be saved must
     * degrade to "no preference", never to a broken page.
     */
    function readStored(key) {
        try {
            return window.localStorage.getItem(key);
        } catch (e) {
            return null;
        }
    }

    function writeStored(key, value) {
        try {
            window.localStorage.setItem(key, value);
        } catch (e) {
            /* Preference not saved. The page still works. */
        }
    }

    /* -----------------------------------------------------------------
     * Theme
     * ---------------------------------------------------------------
     * Three states, and the third one matters: light, dark, and "follow
     * the system". A toggle with only two states silently overrides
     * somebody's operating-system setting the first time they touch it,
     * with no way back.
     *
     * The attribute is applied to <html> before first paint by an inline
     * snippet in the layout head — see partials/head.php. If it were
     * done here, the page would render light and then flip, which is the
     * flash of wrong theme everybody notices and nobody can name.
     * ----------------------------------------------------------------- */

    function applyTheme(theme) {
        if (theme === 'light' || theme === 'dark') {
            root.setAttribute('data-theme', theme);
        } else {
            root.removeAttribute('data-theme');
        }
    }

    function currentTheme() {
        return root.getAttribute('data-theme') || 'system';
    }

    function setTheme(theme) {
        applyTheme(theme);

        if (theme === 'system') {
            try { window.localStorage.removeItem(STORAGE_THEME); } catch (e) {}
        } else {
            writeStored(STORAGE_THEME, theme);
        }

        updateThemeButtons();
    }

    function updateThemeButtons() {
        var buttons = document.querySelectorAll('[data-theme-set]');
        var active  = currentTheme();

        for (var i = 0; i < buttons.length; i++) {
            var isActive = buttons[i].getAttribute('data-theme-set') === active;
            /* aria-pressed rather than a class alone, so a screen reader
             * announces which option is selected. */
            buttons[i].setAttribute('aria-pressed', isActive ? 'true' : 'false');
        }
    }

    /* -----------------------------------------------------------------
     * Text size
     * ---------------------------------------------------------------
     * Four steps, driven by data-size on <html>, which tokens.css turns
     * into a multiplier on every font size.
     *
     * This is in addition to browser zoom, not instead of it. Zoom
     * scales everything including layout; this scales only text, which
     * is what somebody with low vision on a small screen usually wants.
     * ----------------------------------------------------------------- */

    function applySize(step) {
        var value = parseInt(step, 10);
        if (isNaN(value) || value < 1 || value > 4) {
            value = 2;
        }
        root.setAttribute('data-size', String(value));
        return value;
    }

    function setSize(step) {
        writeStored(STORAGE_SIZE, String(applySize(step)));
        updateSizeButtons();
    }

    function updateSizeButtons() {
        var buttons = document.querySelectorAll('[data-size-set]');
        var active  = root.getAttribute('data-size') || '2';

        for (var i = 0; i < buttons.length; i++) {
            buttons[i].setAttribute(
                'aria-pressed',
                buttons[i].getAttribute('data-size-set') === active ? 'true' : 'false'
            );
        }
    }

    /* -----------------------------------------------------------------
     * CSRF on fetch
     * ---------------------------------------------------------------
     * Every state-changing fetch has to carry the token or
     * CsrfMiddleware refuses it. Rather than remembering that at forty
     * call sites, window.fetch is wrapped once so the header is added to
     * same-origin, non-GET requests automatically.
     *
     * Same-origin only. Attaching the token to a cross-origin request —
     * to the Cloudflare Worker, say — would hand it to a third party,
     * which is precisely what it exists to prevent.
     * ----------------------------------------------------------------- */

    function csrfToken() {
        var meta = document.querySelector('meta[name="csrf-token"]');
        return meta ? meta.getAttribute('content') : null;
    }

    function isSameOrigin(url) {
        if (typeof url !== 'string') {
            return false;
        }
        /* A relative path is same-origin by definition. A protocol-
         * relative URL (//host) is not, and is deliberately excluded. */
        if (url.indexOf('//') === 0) {
            return false;
        }
        if (url.charAt(0) === '/' || url.charAt(0) === '?' || url.charAt(0) === '#') {
            return true;
        }
        return url.indexOf(window.location.origin) === 0;
    }

    function wrapFetch() {
        if (!window.fetch) {
            return;
        }

        var original = window.fetch;

        window.fetch = function (input, init) {
            init = init || {};

            var url    = typeof input === 'string' ? input : (input && input.url);
            var method = (init.method || 'GET').toUpperCase();
            var token  = csrfToken();

            var needsToken = token
                && isSameOrigin(url)
                && method !== 'GET'
                && method !== 'HEAD';

            if (needsToken) {
                var headers = new Headers(init.headers || {});
                if (!headers.has('X-CSRF-Token')) {
                    headers.set('X-CSRF-Token', token);
                }
                init.headers = headers;

                /* Cookies are not sent on a same-origin fetch unless
                 * asked for, and without the session cookie the token
                 * has nothing to be compared against. */
                if (!init.credentials) {
                    init.credentials = 'same-origin';
                }
            }

            return original.call(this, input, init);
        };
    }

    /* -----------------------------------------------------------------
     * Wiring
     * ----------------------------------------------------------------- */

    function bind() {
        document.addEventListener('click', function (event) {
            var themeButton = event.target.closest
                ? event.target.closest('[data-theme-set]')
                : null;

            if (themeButton) {
                event.preventDefault();
                setTheme(themeButton.getAttribute('data-theme-set'));
                return;
            }

            var sizeButton = event.target.closest
                ? event.target.closest('[data-size-set]')
                : null;

            if (sizeButton) {
                event.preventDefault();
                setSize(sizeButton.getAttribute('data-size-set'));
            }
        });

        updateThemeButtons();
        updateSizeButtons();
    }

    /* -----------------------------------------------------------------
     * Start
     * ----------------------------------------------------------------- */

    applySize(readStored(STORAGE_SIZE) || '2');
    wrapFetch();

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', bind);
    } else {
        bind();
    }

    /* A small, deliberate public surface. Later steps — the quiz, the
     * spaced-repetition queue, the chat — attach to this rather than
     * scattering globals. */
    window.VedaVerse = {
        setTheme: setTheme,
        setSize:  setSize,
        csrfToken: csrfToken
    };
}());
