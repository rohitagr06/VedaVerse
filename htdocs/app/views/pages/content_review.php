<?php
/**
 * VedaVerse — app/views/pages/content_review.php
 * ---------------------------------------------------------------------
 * Every written word of the CONTENT, in three languages, side by side.
 *
 * WHY THIS EXISTS SEPARATELY FROM /styleguide/strings
 *   That page reviews the interface — 628 short labels. This one
 *   reviews the writing: translations, explanations, modern examples,
 *   memory hooks, reflections. They are different jobs. A label is
 *   judged for accuracy in about a second; a hundred-word scenario is
 *   judged by reading it aloud and asking whether a person would say it.
 *
 * WHY IT IS WORTH BUILDING BEFORE STEP 6 RATHER THAN AFTER
 *   Step 6 writes 103 more verses. Reviewing them by clicking through
 *   103 pages, each with a mode switcher and a level switcher and four
 *   examples behind them, is a review nobody completes. Here every batch
 *   is one page, one scroll, three columns.
 *
 * HOW TO USE IT
 *   Read the Hinglish column out loud, one verse at a time. The test is
 *   not "is this correct" — it is "would I say this to a friend". A
 *   sentence that is accurate and reads like a translation with the
 *   Devanagari swapped for Latin letters is wrong, because sounding like
 *   a person is the entire argument for that column existing.
 *
 * NO DATABASE ACCESS HERE
 *   The controller fetched all of it. A view never queries.
 */

use VedaVerse\Services\I18nService;

/** @var array<int,array> $verses  each already assembled by ContentService */
/** @var array<string,array> $languages */
/** @var int|null $chapterFilter */

$codes = array_keys($languages);

/**
 * One labelled row of the same field in all three languages.
 *
 * Closure rather than a partial because it is called about forty times
 * per verse and a partial would mean forty View::capture() calls and
 * forty array merges to render one page.
 */
$row = function ($label, array $source, $field) use ($codes, $languages) {
    $any = false;
    foreach ($codes as $code) {
        if (trim((string) (isset($source[$field . '_' . $code]) ? $source[$field . '_' . $code] : '')) !== '') {
            $any = true;
            break;
        }
    }
    if (!$any) {
        return;
    }

    echo '<tr><th scope="row">' . e($label) . '</th>';

    foreach ($codes as $code) {
        $value = isset($source[$field . '_' . $code]) ? (string) $source[$field . '_' . $code] : '';
        // The lang attribute is not decoration. Without it a screen
        // reader announces the Devanagari column with an English engine.
        echo '<td lang="' . e($languages[$code]['html_lang']) . '">';
        echo trim($value) === ''
            ? '<span class="text-faint">—</span>'
            : nl2br(e($value));
        echo '</td>';
    }

    echo '</tr>';
};
?>

<div class="card">
    <h1>Content review</h1>
    <p class="lead">
        Every written word, in English, Hindi and Hinglish, side by side.
        <?php echo count($verses); ?> verse<?php echo count($verses) === 1 ? '' : 's'; ?>.
    </p>

    <p><strong>Read the Hinglish column out loud, one verse at a time.</strong>
       The test is not whether it is correct. It is whether you would say it to a
       friend. A sentence that is accurate and still reads like a translation with
       the Devanagari swapped for Latin letters is wrong — sounding like a person
       is the whole reason that column exists.</p>

    <p class="hint mb-0">
        The interface strings are reviewed separately, on
        <a href="/styleguide/strings">/styleguide/strings</a>.
        Add <code>?chapter=2</code> to limit this page to one chapter.
    </p>
</div>

<?php if ($verses === array()): ?>

    <div class="card">
        <p class="mb-0">Nothing curated yet. Load
           <code>htdocs/database/seed_sample.sql</code>.</p>
    </div>

<?php endif; ?>

<?php foreach ($verses as $verse): ?>
    <?php $ref = (int) $verse['chapter_number'] . '.' . (int) $verse['verse_number']; ?>

    <h2 id="v-<?php echo e($ref); ?>"><?php echo e($ref); ?></h2>

    <div class="card sg-strings">
        <p class="shloka" lang="sa"><?php echo nl2br(e($verse['sanskrit_devanagari'])); ?></p>

        <table>
            <caption class="sr-only">Verse <?php echo e($ref); ?> in three languages</caption>
            <thead>
                <tr>
                    <th scope="col">Field</th>
                    <?php foreach ($codes as $code): ?>
                        <th scope="col" lang="<?php echo e($languages[$code]['html_lang']); ?>">
                            <?php echo e($languages[$code]['native_name']); ?>
                        </th>
                    <?php endforeach; ?>
                </tr>
            </thead>
            <tbody>
                <?php
                $row('Translation', $verse, 'translation');
                $row('Summary', $verse, 'summary');

                if (!empty($verse['explanation'])) {
                    $x = $verse['explanation'];
                    $row('What was happening', $x, 'historical_context');
                    $row('The idea behind it', $x, 'philosophical_context');
                    $row('What to do with it', $x, 'practical_meaning');
                    $row('Read today', $x, 'modern_interpretation');
                }

                if (!empty($verse['memory_aid'])) {
                    $row('Hook', $verse['memory_aid'], 'hook');
                    $row('Analogy', $verse['memory_aid'], 'analogy');
                }

                foreach ((array) (isset($verse['reflections']) ? $verse['reflections'] : array()) as $i => $r) {
                    $row('Reflection ' . ($i + 1), $r, 'question');
                }

                foreach ((array) (isset($verse['practices']) ? $verse['practices'] : array()) as $p) {
                    $row('Practice', $p, 'action');
                }
                ?>
            </tbody>
        </table>
    </div>

    <?php /*
     * Examples get their own table per example rather than more rows on
     * the one above. A scenario is a hundred words; interleaving four of
     * them with the short fields makes both unreadable.
     */ ?>
    <?php foreach ((array) (isset($verse['examples']) ? $verse['examples'] : array()) as $n => $example): ?>
        <div class="card sg-strings">
            <h3 class="mt-0">
                <?php echo e($ref); ?> · example <?php echo (int) $n + 1; ?>
                <span class="badge"><?php echo et('category.' . $example['category']); ?></span>
                <?php if (trim((string) $example['source_reference']) !== ''): ?>
                    <span class="text-faint"><?php echo e($example['source_reference']); ?></span>
                <?php endif; ?>
            </h3>

            <table>
                <caption class="sr-only">Example <?php echo (int) $n + 1; ?> for verse <?php echo e($ref); ?></caption>
                <thead>
                    <tr>
                        <th scope="col">Field</th>
                        <?php foreach ($codes as $code): ?>
                            <th scope="col" lang="<?php echo e($languages[$code]['html_lang']); ?>">
                                <?php echo e($languages[$code]['native_name']); ?>
                            </th>
                        <?php endforeach; ?>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $row('Title', $example, 'title');
                    $row('What happened', $example, 'scenario');
                    $row('How the verse fits', $example, 'connection');
                    $row('The takeaway', $example, 'lesson');
                    $row('Reflection', $example, 'reflection');
                    ?>
                </tbody>
            </table>
        </div>
    <?php endforeach; ?>

<?php endforeach; ?>
