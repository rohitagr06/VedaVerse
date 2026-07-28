<?php
/**
 * VedaVerse — tools/check-strings.php
 * =====================================================================
 * Checks the interface string table for the four faults that survive a
 * human read-through.
 *
 * USE
 *       php tools/check-strings.php
 *       php tools/check-strings.php --unused     also list unused keys
 *
 * WHY THIS EXISTS
 *   Every fault it looks for reads perfectly well in isolation. That is
 *   the whole problem. A Hindi string with the :n dropped is a fluent
 *   Hindi sentence. A key that exists in two domain files is valid PHP.
 *   Nobody catches these by eye, and each of them ships as a page that
 *   looks fine to the person who wrote it and broken to somebody reading
 *   in the other language.
 *
 * WHAT IT CHECKS
 *   1. MISSING     A key with no text in one of the three languages.
 *                  The reader gets English where they asked for Hindi.
 *   2. PLACEHOLDER A key using :n in English and :count — or nothing —
 *                  in Hindi. The reader sees a literal ":n", or a
 *                  sentence with a hole in it.
 *   3. PLURAL      Two forms in one language and one in another. The
 *                  count vanishes, or the singular is used for four.
 *   4. DUPLICATE   The same key defined in two domain files. array_merge
 *                  keeps the last one silently, so an edit to the first
 *                  has no effect and there is nothing to see.
 *   5. UNDEFINED   A key referenced by t(), et(), tc() or View::t() in
 *                  the codebase that does not exist in the table. This
 *                  is a blank label on a page nobody opened yet.
 *
 * WHAT IT DOES NOT CHECK
 *   Whether the Hindi is good Hindi or the Hinglish sounds like a person
 *   rather than a translation. No tool can. Open /styleguide/strings on
 *   a local install and read the columns side by side — that is the
 *   review this cannot replace, and it is the one that matters most.
 *
 * EXIT CODE
 *   0 when clean, 1 on any fault. Safe to put in a pre-push hook.
 */

$root      = dirname(__DIR__);
$configDir = $root . '/htdocs/app/config';

if (!is_file($configDir . '/i18n.php')) {
    fwrite(STDERR, "Cannot find app/config/i18n.php\n");
    exit(1);
}

// ---------------------------------------------------------------------
// Load the table, and each domain file separately so duplicates across
// files can be reported by name. The merged table alone cannot tell you
// a key was defined twice — that is exactly what array_merge hides.
// ---------------------------------------------------------------------

$config    = require $configDir . '/i18n.php';
$strings   = isset($config['strings']) ? $config['strings'] : array();
$languages = array_keys(isset($config['languages']) ? $config['languages'] : array());
$fallback  = isset($config['fallback']) ? $config['fallback'] : 'en';
$domains   = isset($config['string_domains']) ? $config['string_domains'] : array();

$problems = array();
$counts   = array();
foreach ($languages as $lang) {
    $counts[$lang] = 0;
}

/**
 * Every :placeholder in a string, sorted so two strings can be compared.
 *
 * @param string $text
 * @return array<int,string>
 */
function vv_placeholders($text)
{
    $found = array();
    if (preg_match_all('/:[a-z][a-z0-9_]*/i', (string) $text, $m) && isset($m[0])) {
        $found = array_values(array_unique($m[0]));
    }
    sort($found);
    return $found;
}

/**
 * @param array  $problems
 * @param string $kind
 * @param string $key
 * @param string $detail
 * @return void
 */
function vv_problem(array &$problems, $kind, $key, $detail)
{
    $problems[] = array('kind' => $kind, 'key' => $key, 'detail' => $detail);
}

// ---------------------------------------------------------------------
// 4. Duplicates across domain files
// ---------------------------------------------------------------------

$seenIn = array();

foreach ($domains as $domain) {
    $path = $configDir . '/strings/' . $domain . '.php';
    if (!is_file($path)) {
        vv_problem($problems, 'DOMAIN', $domain, 'file listed in string_domains but missing from disk');
        continue;
    }

    $part = require $path;
    if (!is_array($part)) {
        vv_problem($problems, 'DOMAIN', $domain, 'file does not return an array');
        continue;
    }

    // A key repeated INSIDE one file is invisible to everything above:
    // PHP collapses it while parsing the array literal, so both
    // array_keys() and the merged table show one entry and the first
    // definition is simply gone. The only way to see it is to read the
    // source as text. This is the likelier of the two duplicate cases —
    // a long file, two people, the same obvious key name.
    $source = (string) file_get_contents($path);
    // The key must contain a dot. That is what separates a table key
    // from the 'en' / 'hi' / 'hinglish' lines inside a multi-line entry,
    // which sit at the start of their own line and would otherwise be
    // counted as duplicated keys in every file.
    if (preg_match_all('/^\s*\'([a-z0-9_]+(?:\.[a-z0-9_]+)+)\'\s*=>/mi', $source, $m)) {
        $tally = array_count_values($m[1]);
        foreach ($tally as $key => $n) {
            if ($n > 1) {
                vv_problem(
                    $problems,
                    'DUPLICATE',
                    $key,
                    'defined ' . $n . ' times in ' . $domain . '.php — PHP keeps only the last one'
                );
            }
        }
    }

    foreach (array_keys($part) as $key) {
        if (isset($seenIn[$key])) {
            vv_problem(
                $problems,
                'DUPLICATE',
                $key,
                'defined in ' . $seenIn[$key] . '.php and again in ' . $domain . '.php — the second one wins silently'
            );
            continue;
        }
        $seenIn[$key] = $domain;
    }
}

// ---------------------------------------------------------------------
// 1, 2, 3. Missing text, placeholder drift, plural mismatch
// ---------------------------------------------------------------------

foreach ($strings as $key => $variants) {

    if (!is_array($variants)) {
        vv_problem($problems, 'SHAPE', $key, 'is not an array of languages');
        continue;
    }

    $reference = isset($variants[$fallback]) ? (string) $variants[$fallback] : null;

    foreach ($languages as $lang) {
        $text = isset($variants[$lang]) ? (string) $variants[$lang] : '';

        if (trim($text) === '') {
            vv_problem($problems, 'MISSING', $key, 'no ' . $lang);
            continue;
        }

        $counts[$lang]++;

        if ($reference === null || $lang === $fallback) {
            continue;
        }

        $want = vv_placeholders($reference);
        $got  = vv_placeholders($text);

        $lost  = array_diff($want, $got);
        $extra = array_diff($got, $want);

        if ($lost !== array()) {
            vv_problem($problems, 'PLACEHOLDER', $key, $lang . ' is missing ' . implode(', ', $lost));
        }
        if ($extra !== array()) {
            vv_problem($problems, 'PLACEHOLDER', $key, $lang . ' has ' . implode(', ', $extra) . ' which ' . $fallback . ' does not');
        }

        $wantForms = substr_count($reference, '|') + 1;
        $gotForms  = substr_count($text, '|') + 1;

        if ($wantForms !== $gotForms) {
            vv_problem(
                $problems,
                'PLURAL',
                $key,
                $fallback . ' has ' . $wantForms . ' form(s), ' . $lang . ' has ' . $gotForms
            );
        }
    }
}

// ---------------------------------------------------------------------
// 5. Keys referenced in code but not defined
// ---------------------------------------------------------------------
// Only literal single-quoted keys are found. A key built at runtime —
// t('difficulty.' . $level) — cannot be checked this way, so those are
// collected as prefixes and any key starting with one is treated as
// used. That is deliberately generous: a false "undefined" would train
// people to ignore this tool.

$referenced = array();
$prefixes   = array();

$files = new RecursiveIteratorIterator(
    new RecursiveDirectoryIterator($root . '/htdocs', FilesystemIterator::SKIP_DOTS)
);

foreach ($files as $file) {
    if (substr($file->getFilename(), -4) !== '.php') {
        continue;
    }
    // The table itself, obviously, defines every key it mentions.
    if (strpos(str_replace('\\', '/', $file->getPathname()), '/app/config/strings/') !== false) {
        continue;
    }

    $code = (string) file_get_contents($file->getPathname());

    // t('key'), et('key'), tc('key', ...), etc_('key', ...), View::t('key')
    //
    // The trailing [),] matters: without it, t('difficulty.' . $level)
    // matches as a literal key called "difficulty." and is reported as
    // undefined on every run. A tool that cries wolf on correct code is
    // a tool people stop reading.
    if (preg_match_all('/\b(?:etc_|et|tc|t)\(\s*\'([a-z0-9_.]+)\'\s*[),]/i', $code, $m)) {
        foreach ($m[1] as $key) {
            $referenced[$key] = $file->getFilename();
        }
    }
    // t('prefix.' . $var)
    if (preg_match_all('/\b(?:etc_|et|tc|t)\(\s*\'([a-z0-9_.]+\.)\'\s*\./i', $code, $m)) {
        foreach ($m[1] as $prefix) {
            $prefixes[] = $prefix;
        }
    }
}

foreach ($referenced as $key => $where) {
    if (!isset($strings[$key])) {
        vv_problem($problems, 'UNDEFINED', $key, 'used in ' . $where . ' but not in the table');
    }
}

// ---------------------------------------------------------------------
// Report
// ---------------------------------------------------------------------

$byKind = array();
foreach ($problems as $problem) {
    $byKind[$problem['kind']][] = $problem;
}

echo "VedaVerse — interface strings\n";
echo str_repeat('=', 60) . "\n\n";

echo 'Domains  : ' . implode(', ', $domains) . "\n";
echo 'Keys     : ' . count($strings) . "\n";
foreach ($counts as $lang => $n) {
    printf("  %-9s %d\n", $lang, $n);
}
echo "\n";

if ($problems === array()) {
    echo "All keys present in all three languages.\n";
    echo "Placeholders and plural forms agree across languages.\n";
    echo "No duplicate keys, no undefined references.\n\n";
} else {
    foreach ($byKind as $kind => $list) {
        echo $kind . ' (' . count($list) . ")\n";
        echo str_repeat('-', 60) . "\n";
        foreach ($list as $problem) {
            printf("  %-40s %s\n", $problem['key'], $problem['detail']);
        }
        echo "\n";
    }
}

// ---------------------------------------------------------------------
// Unused keys — reported only when asked, and never a failure
// ---------------------------------------------------------------------
// Most of the table is written before the pages that use it. An unused
// key in Step 4 usually means Step 7 has not been built yet, not that
// anything is wrong. Failing on it would make the tool useless for
// exactly as long as the project is unfinished.

if (in_array('--unused', $argv, true)) {
    $unused = array();

    foreach (array_keys($strings) as $key) {
        if (isset($referenced[$key])) {
            continue;
        }
        foreach ($prefixes as $prefix) {
            if (strpos($key, $prefix) === 0) {
                continue 2;
            }
        }
        $unused[] = $key;
    }

    echo 'NOT YET USED (' . count($unused) . ")\n";
    echo str_repeat('-', 60) . "\n";
    echo "Expected while the later build steps are unwritten.\n\n";
    foreach ($unused as $key) {
        echo '  ' . $key . "\n";
    }
    echo "\n";
}

if ($problems !== array()) {
    echo count($problems) . " problem(s). Nothing here is cosmetic.\n";
    exit(1);
}

echo "Clean.\n";
exit(0);
