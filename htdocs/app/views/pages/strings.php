<?php
/**
 * VedaVerse — app/views/pages/strings.php
 * ---------------------------------------------------------------------
 * Every interface string, in all three languages, side by side.
 *
 * WHY THIS EXISTS
 *   tools/check-strings.php proves the table is COMPLETE. It cannot
 *   prove it is GOOD. Whether the Hindi reads like something a person
 *   would say, and whether the Hinglish sounds like a friend talking
 *   rather than Google Translate with the diacritics knocked off, are
 *   judgements only a human reading the columns can make.
 *
 *   Reading them out of a PHP file does not work. The rows are long, the
 *   quoting is noisy, and the three languages of one key are separated
 *   by punctuation rather than by space. Three columns in a browser is
 *   the difference between reviewing 600 strings and intending to.
 *
 * HOW TO USE IT
 *   Read the Hinglish column out loud, one group at a time. Anything you
 *   would not say to a friend is wrong, however accurate it is. That is
 *   the single most valuable half hour anybody can spend on this
 *   product's tone.
 *
 * WHO CAN SEE IT
 *   Local installs and administrators, same as the style guide. The
 *   route enforces it; this template only renders. noindex either way.
 *
 * NO DATABASE
 *   Everything here comes from the config table the controller passed
 *   in. A view never queries.
 */

/** @var array<string,array<int,string>> $groups   domain => keys */
/** @var array<string,array<string,string>> $strings */
/** @var array $report   I18nService::audit() output */
/** @var array<string,array> $languages */

$codes = array_keys($languages);

/**
 * Highlight the placeholders so a missing one is visible at a glance.
 * The text is escaped FIRST and the markup added after, so a string
 * containing a < is never rendered as a tag.
 */
$mark = function ($text) {
    $safe = e($text);
    $safe = preg_replace('/(:[a-z][a-z0-9_]*)/i', '<b class="sg-ph">$1</b>', $safe);
    // The pipe separating plural forms, made visible rather than being
    // mistaken for a typo.
    return str_replace('|', '<span class="sg-pipe">|</span>', $safe);
};

$problemKeys = array();
foreach (array('missing', 'placeholders', 'plurals') as $kind) {
    foreach ($report[$kind] as $row) {
        $problemKeys[$row['key']] = true;
    }
}
?>

<div class="card">
    <h1><?php echo et('admin.strings.title'); ?></h1>
    <p class="lead"><?php echo et('admin.strings.lead'); ?></p>

    <p class="text-muted">
        <?php echo etc_('admin.strings.total', count($strings)); ?> ·
        <?php echo e(implode(' · ', array_map(function ($c) use ($languages) {
            return $languages[$c]['native_name'];
        }, $codes))); ?>
    </p>

    <?php if ($problemKeys === array()): ?>
        <p class="alert alert-success mb-0"><?php echo et('admin.strings.ok'); ?></p>
    <?php else: ?>
        <div class="alert alert-warning">
            <strong><?php echo et('admin.strings.problems'); ?></strong>
            <ul class="mb-0">
                <?php foreach ($report['missing'] as $row): ?>
                    <li><code><?php echo e($row['key']); ?></code> — no <?php echo e($row['lang']); ?></li>
                <?php endforeach; ?>
                <?php foreach ($report['placeholders'] as $row): ?>
                    <li><code><?php echo e($row['key']); ?></code> —
                        <?php echo e($row['lang']); ?>
                        <?php if ($row['lost'] !== array()): ?>
                            is missing <?php echo e(implode(', ', $row['lost'])); ?>
                        <?php endif; ?>
                        <?php if ($row['extra'] !== array()): ?>
                            has extra <?php echo e(implode(', ', $row['extra'])); ?>
                        <?php endif; ?>
                    </li>
                <?php endforeach; ?>
                <?php foreach ($report['plurals'] as $row): ?>
                    <li><code><?php echo e($row['key']); ?></code> —
                        English has <?php echo (int) $row['want']; ?> form(s),
                        <?php echo e($row['lang']); ?> has <?php echo (int) $row['got']; ?></li>
                <?php endforeach; ?>
            </ul>
        </div>
    <?php endif; ?>

    <?php /*
     * The legend is run through the same highlighter as the table, so it
     * demonstrates the notation it is describing rather than describing
     * it in words that look nothing like the thing.
     */ ?>
    <p class="hint mb-0">
        <?php echo $mark(t('admin.strings.legend')); ?>
        <?php echo et('admin.strings.cli'); ?>
    </p>
</div>

<div class="card">
    <h2 class="mt-0"><?php echo et('admin.strings.domain'); ?></h2>
    <div class="row">
        <?php foreach ($groups as $domain => $keys): ?>
            <a class="chip" href="#g-<?php echo e($domain); ?>">
                <?php echo e($domain); ?> <span class="text-faint"><?php echo count($keys); ?></span>
            </a>
        <?php endforeach; ?>
    </div>
</div>

<?php foreach ($groups as $domain => $keys): ?>

    <h2 id="g-<?php echo e($domain); ?>"><?php echo e($domain); ?></h2>

    <div class="card sg-strings">
        <table>
            <caption class="sr-only">
                Interface strings in the <?php echo e($domain); ?> group,
                in <?php echo e(implode(', ', $codes)); ?>
            </caption>
            <thead>
                <tr>
                    <th scope="col"><?php echo et('admin.strings.key'); ?></th>
                    <?php foreach ($codes as $code): ?>
                        <th scope="col" lang="<?php echo e($languages[$code]['html_lang']); ?>">
                            <?php echo e($languages[$code]['native_name']); ?>
                        </th>
                    <?php endforeach; ?>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($keys as $key): ?>
                    <tr<?php echo isset($problemKeys[$key]) ? ' class="is-flagged"' : ''; ?>>
                        <th scope="row"><code><?php echo e($key); ?></code></th>
                        <?php foreach ($codes as $code): ?>
                            <?php
                            // The lang attribute is not decoration here. Without
                            // it a screen reader reads the Devanagari column with
                            // an English engine, and this page becomes unusable
                            // for the person most likely to be reviewing Hindi.
                            $value = isset($strings[$key][$code]) ? $strings[$key][$code] : '';
                            ?>
                            <td lang="<?php echo e($languages[$code]['html_lang']); ?>">
                                <?php if (trim($value) === ''): ?>
                                    <span class="text-faint">—</span>
                                <?php else: ?>
                                    <?php echo $mark($value); ?>
                                <?php endif; ?>
                            </td>
                        <?php endforeach; ?>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>

<?php endforeach; ?>
