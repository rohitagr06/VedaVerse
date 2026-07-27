<?php
/**
 * VedaVerse — app/views/partials/provisional_css.php
 * ---------------------------------------------------------------------
 * PROVISIONAL. Step 3 of the build order replaces all of this with
 * assets/css/tokens.css, base.css and components.css, and this file is
 * deleted.
 *
 * WHY IT EXISTS AT ALL
 *   Step 2 has to produce working, testable auth screens, and Step 3 is
 *   where the design system arrives. Rather than ship forms that are
 *   unreadable in the meantime, this carries the token values from the
 *   specification — the real palette, the real type scale, the real
 *   spacing steps — so the eventual restyle is a swap rather than a
 *   rewrite.
 *
 * WHAT IS ALREADY REAL AND MUST SURVIVE THE REPLACEMENT
 *   The accessibility floor is not provisional. Visible focus rings,
 *   44px minimum tap targets, AA contrast, 320px support, and
 *   prefers-reduced-motion are requirements, not styling. Whatever
 *   replaces this file has to keep all five.
 */
?>
<style>
:root {
    /* Palette, from section 15 of the specification. */
    --rc-dawn:     #FF6B2C;
    --rc-marigold: #FFC22E;
    --rc-krishna:  #2D5BFF;
    --rc-peacock:  #00B5A5;
    --rc-ink:      #14121F;
    --rc-cloud:    #FFF7EE;

    --rc-muted:   #6b6577;
    --rc-line:    #eae2d8;
    --rc-surface: #ffffff;
    --rc-danger:  #b3261e;

    --grad-dawn: linear-gradient(135deg, var(--rc-dawn), var(--rc-marigold));

    /* Type scale: 13 / 15 / 17 / 20 / 26 / 34 / 44 */
    --t-sm: 15px;
    --t-base: 17px;
    --t-lg: 20px;
    --t-xl: 26px;
    --t-2xl: 34px;

    /* Spacing scale: 4 / 8 / 12 / 16 / 24 / 32 / 48 / 64 */
    --s-1: 4px;  --s-2: 8px;  --s-3: 12px; --s-4: 16px;
    --s-5: 24px; --s-6: 32px; --s-7: 48px; --s-8: 64px;

    --radius: 20px;
}

@media (prefers-color-scheme: dark) {
    :root {
        --rc-cloud:   #14121F;
        --rc-ink:     #FFF7EE;
        --rc-surface: #1e1b2b;
        --rc-line:    #2f2a3d;
        --rc-muted:   #a49db4;
        --rc-danger:  #ff8a80;
    }
}

*, *::before, *::after { box-sizing: border-box; }

body {
    margin: 0;
    background: var(--rc-cloud);
    color: var(--rc-ink);
    font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
    font-size: var(--t-base);
    line-height: 1.6;
    /* Devanagari needs a little more room between lines than Latin. */
    text-rendering: optimizeLegibility;
}

/* Keyboard users must always be able to see where they are. This is a
   requirement, not a preference — never replace it with outline: none. */
:focus-visible {
    outline: 3px solid var(--rc-krishna);
    outline-offset: 2px;
    border-radius: 6px;
}

.skip {
    position: absolute;
    left: -9999px;
    top: 0;
    background: var(--rc-ink);
    color: var(--rc-cloud);
    padding: var(--s-3) var(--s-4);
    z-index: 100;
}
.skip:focus { left: var(--s-3); top: var(--s-3); }

.wrap { max-width: 32rem; margin: 0 auto; padding: var(--s-6) var(--s-4) var(--s-8); }
.wrap-wide { max-width: 60rem; }

.brand {
    display: flex; align-items: center; gap: var(--s-3);
    margin-bottom: var(--s-5); text-decoration: none; color: inherit;
}
.brand-mark { width: 36px; height: 36px; border-radius: 12px; background: var(--grad-dawn); flex: none; }
.brand-name { font-weight: 700; font-size: var(--t-lg); }

.card {
    background: var(--rc-surface);
    border: 1px solid var(--rc-line);
    border-radius: var(--radius);
    padding: var(--s-5);
    /* Warm-tinted shadow, never grey. */
    box-shadow: 0 6px 24px rgba(255, 107, 44, .08);
    margin-bottom: var(--s-4);
}

h1 { font-size: var(--t-xl); line-height: 1.3; margin: 0 0 var(--s-2); }
h2 { font-size: var(--t-lg); margin: var(--s-5) 0 var(--s-2); }
p  { margin: 0 0 var(--s-3); }
.lead  { color: var(--rc-muted); }
.small { font-size: var(--t-sm); color: var(--rc-muted); }

a { color: var(--rc-krishna); }

label { display: block; font-weight: 600; margin: var(--s-4) 0 var(--s-1); }
.hint { display: block; font-weight: 400; font-size: var(--t-sm); color: var(--rc-muted); margin-top: 2px; }

input[type="text"], input[type="email"], input[type="password"], select {
    width: 100%;
    /* 44px minimum tap target. */
    min-height: 44px;
    padding: var(--s-3);
    font-size: 16px; /* 16px or larger, or iOS Safari zooms on focus */
    font-family: inherit;
    color: var(--rc-ink);
    background: var(--rc-surface);
    border: 2px solid var(--rc-line);
    border-radius: 12px;
}
input:focus, select:focus { border-color: var(--rc-krishna); }
input[aria-invalid="true"] { border-color: var(--rc-danger); }

.btn {
    display: inline-block;
    width: 100%;
    min-height: 48px;
    margin-top: var(--s-5);
    padding: var(--s-3) var(--s-5);
    font: inherit;
    font-weight: 700;
    text-align: center;
    text-decoration: none;
    color: #fff;
    background: var(--rc-dawn);
    border: 0;
    border-radius: 14px;
    cursor: pointer;
    /* The 4px bottom edge that compresses on press. */
    box-shadow: 0 4px 0 #d4531c;
    transition: transform .06s ease, box-shadow .06s ease;
}
.btn:active { transform: translateY(3px); box-shadow: 0 1px 0 #d4531c; }
.btn-secondary {
    color: var(--rc-ink);
    background: var(--rc-surface);
    border: 2px solid var(--rc-line);
    box-shadow: 0 4px 0 var(--rc-line);
}

.alert { border-radius: 14px; padding: var(--s-3) var(--s-4); margin-bottom: var(--s-4); border: 2px solid; }
.alert-success { background: rgba(0,181,165,.10); border-color: rgba(0,181,165,.45); }
.alert-error   { background: rgba(179,38,30,.08); border-color: rgba(179,38,30,.35); }
.alert-info    { background: rgba(45,91,255,.08); border-color: rgba(45,91,255,.35); }
.alert ul { margin: var(--s-1) 0 0 var(--s-4); padding: 0; }

.field-error { display: block; color: var(--rc-danger); font-size: var(--t-sm); margin-top: var(--s-1); }

.code-block {
    font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
    font-size: var(--t-xl);
    letter-spacing: .12em;
    text-align: center;
    word-break: break-all;
    padding: var(--s-5);
    border-radius: 14px;
    background: #14121F;
    color: var(--rc-marigold);
}

.row { display: flex; gap: var(--s-3); flex-wrap: wrap; align-items: center; justify-content: space-between; }
.foot { margin-top: var(--s-5); font-size: var(--t-sm); color: var(--rc-muted); }

/* Everything above 320px must work. */
@media (max-width: 340px) {
    .wrap { padding-left: var(--s-3); padding-right: var(--s-3); }
    .card { padding: var(--s-4); }
    .code-block { font-size: var(--t-lg); }
}

@media (prefers-reduced-motion: reduce) {
    *, *::before, *::after { transition: none !important; animation: none !important; }
    .btn:active { transform: none; }
}
</style>
