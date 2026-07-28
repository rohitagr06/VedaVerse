<?php
/**
 * VedaVerse — app/views/pages/styleguide.php
 * ---------------------------------------------------------------------
 * Every component in the design system, on one page.
 *
 * WHY THIS EXISTS
 *   A design system you cannot see all at once is a design system that
 *   drifts. Two buttons end up slightly different, a card gains a
 *   shadow nobody else has, an empty state is invented from scratch
 *   because nobody knew one existed. This page is the answer: open it
 *   after any change to components.css and the drift is visible.
 *
 *   It is also the fastest way to check the four things that matter and
 *   are tedious to verify page by page — the dark theme, 320px, keyboard
 *   focus, and Devanagari rendering. All of them are on this one page.
 *
 * WHO CAN SEE IT
 *   Local installs, and administrators on a live site. It is not secret,
 *   but it is not part of the product either, and a stray link to it
 *   from a search result would be odd. The route enforces that; this
 *   template only renders.
 *
 * NOT A COMPONENT LIBRARY IN THE FRAMEWORK SENSE
 *   There is no build step and no component abstraction — these are
 *   plain classes on plain HTML. The page shows the markup alongside
 *   each example so it can be copied directly.
 */

use VedaVerse\Core\Config;
use VedaVerse\Core\View;

/** Render an example with its markup underneath, so it can be copied. */
$demo = function ($html) {
    echo '<div class="sg-demo">' . $html . '</div>';
    echo '<pre class="sg-code"><code>' . e(trim($html)) . '</code></pre>';
};
?>

<div class="card">
    <h1>Design system</h1>
    <p class="lead">Every component, in one place. Open this after any change to
       <code>components.css</code>.</p>
    <p class="text-muted">Four things to check here that are tedious to check anywhere else:
       switch the theme with the gear menu, narrow the window to 320px, press Tab from the
       top of the page, and look at the shloka to confirm the Devanagari conjuncts join.</p>
</div>

<!-- ================================================================ -->
<h2 id="colour">Colour</h2>
<div class="card">
    <p class="text-muted">Every pairing below is checked by
       <code>tools/check-contrast.php</code>, which reads the real values out of
       <code>tokens.css</code> and fails the build if any drops below WCAG AA.</p>

    <div class="sg-swatches">
        <?php
        $swatches = array(
            'dawn'     => 'Primary. Buttons, active states.',
            'marigold' => 'XP, streaks, rewards.',
            'krishna'  => 'Secondary. Links, chat, information.',
            'peacock'  => 'Success, mastery, correct answers.',
            'ink'      => 'Text on light. Base of the dark theme.',
            'cloud'    => 'Light background.',
        );
        foreach ($swatches as $name => $use): ?>
            <div class="sg-swatch">
                <div class="sg-swatch__chip" style="background: var(--vv-<?php echo e($name); ?>)"></div>
                <div>
                    <strong>--vv-<?php echo e($name); ?></strong>
                    <span class="hint"><?php echo e($use); ?></span>
                </div>
            </div>
        <?php endforeach; ?>
    </div>

    <h3>Gradients</h3>
    <div class="sg-swatches">
        <div class="sg-swatch">
            <div class="sg-swatch__chip" style="background: var(--vv-grad-dawn)"></div>
            <div><strong>--vv-grad-dawn</strong><span class="hint">Primary actions, progress.</span></div>
        </div>
        <div class="sg-swatch">
            <div class="sg-swatch__chip" style="background: var(--vv-grad-peacock)"></div>
            <div><strong>--vv-grad-peacock</strong><span class="hint">Mastery, chat.</span></div>
        </div>
    </div>
</div>

<!-- ================================================================ -->
<h2 id="type">Typography</h2>
<div class="card">
    <h1>Heading one — 34px</h1>
    <h2 class="mt-0">Heading two — 26px</h2>
    <h3>Heading three — 20px</h3>
    <p>Body text at 17px. Seventeen rather than the usual sixteen because Devanagari
       carries more detail per character and needs the extra pixel to stay legible at
       the same reading distance.</p>
    <p class="lead">A lead paragraph at 20px, used for the first line of a page.</p>
    <p class="text-muted">Muted text for secondary information.</p>
    <p class="text-faint">Faint text — still meets AA, unlike most "faint" greys.</p>
    <p><small>Small text at 15px.</small> And <code>inline code</code>, and
       <a href="#type">a link</a> which keeps its underline.</p>
</div>

<h3>The shloka</h3>
<div class="card">
    <p class="text-muted">Everything in this product is rounded and playful except the
       verse. The verse is a serif, larger, on a quiet card, with double line height
       because Devanagari stacks conjuncts above and below the baseline. That contrast
       is the design's whole argument.</p>

    <p class="shloka" lang="sa">कर्मण्येवाधिकारस्ते मा फलेषु कदाचन</p>
    <p class="transliteration">karmaṇy-evādhikāras te mā phaleṣu kadācana</p>
    <p class="text-center text-muted">Bhagavad Gita 2.47</p>

    <p class="hint mt-4">If the conjuncts render as separate letters with visible halant
       marks between them, the font loaded but its OpenType layout features were stripped
       during subsetting. See <code>assets/fonts/README.md</code>.</p>
</div>

<!-- ================================================================ -->
<h2 id="buttons">Buttons</h2>
<div class="card">
    <p class="text-muted">Press and hold one. The 4px bottom edge compresses to 1px —
       that is the tactile press, and it is most of why this family of interface feels
       good to use.</p>
    <p class="text-muted">The primary label is ink, not white. White on
       <code>--vv-dawn</code> measures 2.84:1 and fails AA; ink measures 6.51:1. This is
       the most-clicked element in the product.</p>

    <div class="row mt-4">
        <button class="btn w-auto">Primary</button>
        <button class="btn btn-secondary w-auto">Secondary</button>
        <button class="btn btn-success w-auto">Correct</button>
        <button class="btn btn-reward w-auto">Claim XP</button>
        <button class="btn btn-danger w-auto">Delete</button>
        <button class="btn btn-quiet w-auto">Quiet</button>
    </div>

    <div class="row mt-4">
        <button class="btn btn-sm w-auto">Small</button>
        <button class="btn w-auto">Default</button>
        <button class="btn btn-lg w-auto">Large</button>
        <button class="btn w-auto" disabled>Disabled</button>
    </div>

    <p class="hint mt-4">"Small" is less padding, never a smaller tap target — every
       button stays at least 44px tall.</p>

    <button class="btn btn-block mt-4">Full width, for the primary action on a form</button>
</div>

<!-- ================================================================ -->
<h2 id="forms">Forms</h2>
<div class="card">
    <div class="field">
        <label for="sg-name">A normal field</label>
        <input type="text" id="sg-name" value="Rohit Agrawal">
    </div>

    <div class="field">
        <label for="sg-email">
            With a hint
            <span class="hint" id="sg-email-hint">Tied to the input with aria-describedby,
                  so a screen reader reads them together.</span>
        </label>
        <input type="email" id="sg-email" aria-describedby="sg-email-hint" placeholder="you@example.com">
    </div>

    <div class="field">
        <label for="sg-bad">In an error state</label>
        <input type="text" id="sg-bad" value="not-an-email"
               aria-invalid="true" aria-describedby="sg-bad-error">
        <span class="field-error" id="sg-bad-error">That does not look like an email address.</span>
    </div>

    <div class="field">
        <label for="sg-select">A select</label>
        <select id="sg-select">
            <option>English</option>
            <option>हिन्दी</option>
            <option>Hinglish</option>
        </select>
    </div>

    <div class="field">
        <label for="sg-textarea">A note</label>
        <textarea id="sg-textarea" rows="3">फल की चिंता छोड़ो — काम पर ध्यान दो।</textarea>
    </div>

    <p class="hint">Inputs are 16px minimum. Anything smaller and iOS Safari zooms the
       page on focus, stranding the reader at the wrong scale with no obvious way back.</p>
</div>

<!-- ================================================================ -->
<h2 id="alerts">Alerts</h2>
<div class="card">
    <div class="alert alert-success" role="status">Saved. Your progress is up to date.</div>
    <div class="alert alert-info" role="status">You can read everything without an account.</div>
    <div class="alert alert-warning" role="status">This chapter is not finished yet.</div>
    <div class="alert alert-error" role="alert">
        <strong>Please fix these first</strong>
        <ul>
            <li><a href="#forms">That does not look like an email address.</a></li>
            <li><a href="#forms">Use at least 10 characters.</a></li>
        </ul>
    </div>
    <p class="hint">Each carries a word as well as a colour, so the meaning survives in
       monochrome and for a reader who cannot distinguish red from green.</p>
</div>

<!-- ================================================================ -->
<h2 id="badges">Badges, chips and progress</h2>
<div class="card">
    <div class="row">
        <span class="badge">Beginner</span>
        <span class="badge badge-xp">✦ 1.2k</span>
        <span class="badge badge-mastery">Mastered</span>
        <span class="badge badge-new">New</span>
    </div>

    <div class="row mt-4">
        <button class="chip" aria-pressed="true">All</button>
        <button class="chip" aria-pressed="false">Bollywood</button>
        <button class="chip" aria-pressed="false">Cricket</button>
        <button class="chip" aria-pressed="false">Corporate</button>
    </div>

    <h3>Progress</h3>
    <div class="progress" role="progressbar" aria-valuenow="62" aria-valuemin="0" aria-valuemax="100"
         aria-label="Chapter 2 progress">
        <div class="progress__fill" style="width: 62%"></div>
    </div>
    <p class="hint mt-4">The bar is decorative; the real value is on the element as ARIA,
       so a screen reader reads "62 percent" rather than nothing.</p>

    <div class="progress progress-mastery mt-4" role="progressbar" aria-valuenow="30"
         aria-valuemin="0" aria-valuemax="100" aria-label="Mastery">
        <div class="progress__fill" style="width: 30%"></div>
    </div>
</div>

<!-- ================================================================ -->
<h2 id="cards">Cards</h2>
<a class="card card-link" href="#cards">
    <div class="card__title">2.47 — Why chasing results makes you miserable</div>
    <p class="mb-0">You have a right to your effort, never to its fruits.</p>
    <p class="card__meta mt-4">Chapter 2 &middot; Beginner &middot; 4 min</p>
</a>

<!-- ================================================================ -->
<h2 id="loading">Loading and empty states</h2>
<div class="card">
    <h3 class="mt-0">Skeleton</h3>
    <p class="text-muted">Skeletons, not spinners. A spinner says "wait"; a skeleton says
       what is arriving and where, so the page does not jump when it lands.</p>
    <div aria-hidden="true">
        <div class="skeleton skeleton-title"></div>
        <div class="skeleton skeleton-line"></div>
        <div class="skeleton skeleton-line"></div>
        <div class="skeleton skeleton-line"></div>
    </div>
</div>

<div class="card">
    <div class="empty">
        <div class="empty__art" aria-hidden="true"></div>
        <p class="empty__title">Nothing saved yet</p>
        <p class="empty__body">Bookmark a verse and it will wait for you here — no account
           needed.</p>
        <a class="btn w-auto" href="/">Start with Chapter 2</a>
    </div>
    <p class="hint">An empty state invites an action. It never apologises — "no results
       found" tells the reader they failed.</p>
</div>

<!-- ================================================================ -->
<h2 id="code">The recovery code</h2>
<div class="card">
    <p class="text-muted">Shown once, never again. Monospaced and generously spaced
       because it gets copied onto paper by somebody who is already anxious, and a
       misread character costs them the account. Marigold on ink is 11.45:1 —
       deliberately the loudest pairing in the palette.</p>
    <p class="code-block">3EFT-YS6J-TP28</p>
</div>

<!-- ================================================================ -->
<h2 id="languages">The three languages</h2>
<div class="card">
    <p><strong>English.</strong> Plain, warm, direct. Short sentences. No "thou", no
       "verily", no academic hedging.</p>
    <p lang="hi"><strong>हिन्दी।</strong> स्वाभाविक बोलचाल की हिन्दी, किताबी नहीं। उसके लिए
       लिखी गई जो घर पर हिन्दी बोलता है और धीरे-धीरे पढ़ता है।</p>
    <p><strong>Hinglish.</strong> Result aa gaya, ab kya? Krishna bol rahe hain: effort
       tera, outcome tera nahi.</p>
    <p class="hint">Each block carries its own <code>lang</code> attribute. Without it a
       screen reader reads Devanagari with an English speech engine and produces noise.</p>
    <p class="mt-4"><a class="btn btn-secondary w-auto" href="/styleguide/strings">Read every
       interface string in all three languages</a></p>
    <p class="hint mb-0">That page is where the register actually gets judged. A checker can
       prove the table is complete; only a person reading the Hinglish column out loud can
       tell whether it sounds like a friend talking or like a translation.</p>
</div>
