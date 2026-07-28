<?php
/**
 * VedaVerse — tools/check-contrast.php
 * =====================================================================
 * Reads the real hex values out of assets/css/tokens.css and checks
 * every text-on-background pairing the product actually uses against
 * WCAG 2.1 AA.
 *
 * USE
 *       php tools/check-contrast.php
 *
 * WHY THIS EXISTS
 *   Accessibility contrast is the requirement most easily broken by a
 *   change that looks harmless. "Make the orange a bit brighter" is one
 *   character in a hex value and it can silently drop the primary button
 *   below the threshold — and nobody notices, because the person making
 *   the change can read it fine.
 *
 *   Because it parses the stylesheet rather than a copy of the values,
 *   it cannot drift out of date. Change a token, run this, know.
 *
 * THRESHOLDS
 *   4.5:1 for normal text, 3:1 for large text (24px, or 19px bold) and
 *   for the non-text things that carry meaning — focus rings, input
 *   borders, icons. Exits non-zero on any failure.
 */

$cssPath = __DIR__ . '/../htdocs/assets/css/tokens.css';

if (!is_file($cssPath)) {
    fwrite(STDERR, "Cannot find tokens.css\n");
    exit(1);
}

$css = file_get_contents($cssPath);

/**
 * Pull every `--vv-name: #HEX;` out of the stylesheet.
 *
 * Only literal hex values — a token defined as var(--other) is resolved
 * afterwards, so the check always uses the value that actually renders.
 */
function vv_tokens($css, $scopePattern = null)
{
    if ($scopePattern !== null) {
        if (preg_match($scopePattern, $css, $m) !== 1) {
            return array();
        }
        $css = $m[0];
    }

    $tokens = array();
    if (preg_match_all('/(--vv-[a-z0-9-]+)\s*:\s*(#[0-9A-Fa-f]{6})\s*;/', $css, $matches, PREG_SET_ORDER)) {
        foreach ($matches as $match) {
            // First definition wins, so :root beats a later theme block
            // unless we asked for that block specifically.
            if (!isset($tokens[$match[1]])) {
                $tokens[$match[1]] = strtoupper($match[2]);
            }
        }
    }
    return $tokens;
}

/**
 * Relative luminance, per the WCAG formula.
 *
 * @param string $hex
 * @return float
 */
function vv_luminance($hex)
{
    $hex = ltrim($hex, '#');
    $channels = array();

    foreach (array(0, 2, 4) as $offset) {
        $value = hexdec(substr($hex, $offset, 2)) / 255;
        $channels[] = $value <= 0.03928
            ? $value / 12.92
            : pow(($value + 0.055) / 1.055, 2.4);
    }

    return 0.2126 * $channels[0] + 0.7152 * $channels[1] + 0.0722 * $channels[2];
}

/**
 * @param string $a
 * @param string $b
 * @return float
 */
function vv_ratio($a, $b)
{
    $la = vv_luminance($a);
    $lb = vv_luminance($b);

    $high = max($la, $lb);
    $low  = min($la, $lb);

    return ($high + 0.05) / ($low + 0.05);
}

// ---------------------------------------------------------------------
// The pairings the product actually renders.
// ---------------------------------------------------------------------

$light = vv_tokens($css);
$dark  = array_merge($light, vv_tokens($css, '/:root\[data-theme="dark"\]\s*\{[^}]*\}/s'));

/**
 * label, foreground token, background token, minimum ratio
 *
 * NAME THE CONCRETE TOKEN IN THE LIGHT LIST, NOT THE ALIAS.
 *   --vv-text is declared as var(--vv-ink) in :root and as a literal
 *   #FFF7EE inside the dark blocks. vv_tokens() only collects LITERAL
 *   hex values, so the light map's --vv-text is the DARK one — the first
 *   literal in the file. Writing '--vv-text' in a light pairing silently
 *   checks cream against cream and reports 1.04:1.
 *
 *   The dark list may use the aliases, because the dark blocks define
 *   them literally. Light uses --vv-ink, --vv-cloud and --vv-surface.
 */
$checks = array(
    'light' => array(
        array('body text on background',      '--vv-ink',           '--vv-cloud',        4.5),
        array('body text on a card',          '--vv-ink',           '--vv-surface',      4.5),
        array('muted text on background',     '--vv-text-muted',    '--vv-cloud',        4.5),
        array('faint text on background',     '--vv-text-faint',    '--vv-cloud',        4.5),
        array('link on background',           '--vv-krishna',       '--vv-cloud',        4.5),
        array('link on a card',               '--vv-krishna',       '--vv-surface',      4.5),
        array('PRIMARY BUTTON label',         '--vv-ink',           '--vv-dawn',         4.5),
        array('marigold button label',        '--vv-ink',           '--vv-marigold',     4.5),
        array('peacock button label',         '--vv-ink',           '--vv-peacock',      4.5),
        array('white on dawn-deep',           '--vv-surface',       '--vv-dawn-deep',    4.5),
        array('white on peacock-deep',        '--vv-surface',       '--vv-peacock-deep', 4.5),
        array('success text',                 '--vv-peacock-text',  '--vv-cloud',        4.5),
        array('warning text',                 '--vv-marigold-text', '--vv-cloud',        4.5),
        array('error text',                   '--vv-danger',        '--vv-cloud',        4.5),
        array('error text on its own tint',   '--vv-danger',        '--vv-error-bg',     4.5),
        array('success text on its own tint', '--vv-peacock-text',  '--vv-success-bg',   4.5),
        array('text on a warning tint',       '--vv-ink',           '--vv-warning-bg',   4.5),
        array('focus ring on background',     '--vv-krishna',       '--vv-cloud',        3.0),
        array('input border on a card',       '--vv-line-strong',   '--vv-surface',      3.0),
        array('sunk surface against card',    '--vv-surface-sunk',  '--vv-surface',      1.0),
    ),
    'dark' => array(
        array('body text on background',      '--vv-text',          '--vv-bg',           4.5),
        array('body text on a card',          '--vv-text',          '--vv-surface',      4.5),
        array('muted text on background',     '--vv-text-muted',    '--vv-bg',           4.5),
        array('faint text on background',     '--vv-text-faint',    '--vv-bg',           4.5),
        array('link on background',           '--vv-krishna-lift',  '--vv-bg',           4.5),
        array('link on a card',               '--vv-krishna-lift',  '--vv-surface',      4.5),
        array('PRIMARY BUTTON label',         '--vv-ink',           '--vv-dawn',         4.5),
        array('marigold on background',       '--vv-marigold',      '--vv-bg',           4.5),
        array('peacock on background',        '--vv-peacock',       '--vv-bg',           4.5),
        array('error text',                   '--vv-danger-lift',   '--vv-bg',           4.5),
        array('error text on its own tint',   '--vv-danger-lift',   '--vv-error-bg',     4.5),
        array('success text on its own tint', '--vv-peacock',       '--vv-success-bg',   4.5),
        array('text on a warning tint',       '--vv-text',          '--vv-warning-bg',   4.5),
        array('focus ring on background',     '--vv-krishna-lift',  '--vv-bg',           3.0),
        array('input border on a card',       '--vv-line-strong',   '--vv-surface',      3.0),
    ),
);

$failures = 0;
$checked  = 0;

echo "VedaVerse contrast check\n";
echo "Reading htdocs/assets/css/tokens.css\n";

foreach ($checks as $theme => $pairs) {
    $tokens = $theme === 'dark' ? $dark : $light;

    echo "\n" . strtoupper($theme) . " THEME\n";
    echo str_repeat('-', 66) . "\n";

    foreach ($pairs as $pair) {
        list($label, $fgToken, $bgToken, $minimum) = $pair;

        if (!isset($tokens[$fgToken]) || !isset($tokens[$bgToken])) {
            printf("  ?  %-34s token missing: %s\n", $label, isset($tokens[$fgToken]) ? $bgToken : $fgToken);
            $failures++;
            continue;
        }

        $ratio = vv_ratio($tokens[$fgToken], $tokens[$bgToken]);
        $ok    = $ratio >= $minimum;
        $checked++;

        if (!$ok) {
            $failures++;
        }

        printf(
            "  %s  %-34s %5.2f:1  (needs %.1f)  %s on %s\n",
            $ok ? "\033[32m✓\033[0m" : "\033[31m✗\033[0m",
            $label,
            $ratio,
            $minimum,
            $tokens[$fgToken],
            $tokens[$bgToken]
        );
    }
}

echo "\n" . str_repeat('-', 66) . "\n";

if ($failures > 0) {
    printf("  %d of %d pairings fail WCAG AA.\n\n", $failures, $checked);
    echo "  Fix the token rather than the component. A component that works\n";
    echo "  around a bad token leaves the bad token there for the next one.\n";
    exit(1);
}

printf("  All %d pairings pass WCAG 2.1 AA.\n", $checked);
exit(0);
