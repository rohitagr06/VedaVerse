<?php
/**
 * VedaVerse — app/views/partials/verse_card.php
 * ---------------------------------------------------------------------
 * One verse, as a card in a list. Used by the topic page, the problem
 * page, the explore page and the bookmarks list.
 *
 * WHY A PARTIAL
 *   Four pages show a verse as a card. Copied four times, they drift —
 *   one gains a difficulty badge, one loses the language attribute, one
 *   forgets the Sanskrit. The lang attribute in particular is the kind
 *   of thing that silently disappears from three of four copies, and
 *   nobody notices because it is invisible to a sighted reader.
 *
 * EXPECTS
 *   $verse  a row carrying at least chapter_number, verse_number, and
 *           either summary_* or translation_*.
 *
 * SHOWS THE TRANSLATION, NOT THE SANSKRIT
 *   A card is a decision about whether to open something. Devanagari
 *   the reader may not read is not that decision — the sentence in
 *   their own language is. The Sanskrit is on the verse page, where it
 *   belongs.
 */

use VedaVerse\Services\I18nService;

/** @var array $verse */

$chapterNumber = (int) $verse['chapter_number'];
$verseNumber   = (int) $verse['verse_number'];

// Prefer the one-line summary; fall back to the full translation
// trimmed. A card with a blank body is worse than a long one.
$body  = I18nService::field($verse, 'summary');
$field = 'summary';

if (trim($body) === '') {
    $body  = I18nService::field($verse, 'translation');
    $field = 'translation';
}
?>

<article class="card verse-card">
    <a class="verse-card__link" href="<?php echo e(verse_url($chapterNumber, $verseNumber)); ?>">
        <p class="verse-card__ref">
            <?php echo e($chapterNumber . '.' . $verseNumber); ?>
        </p>

        <?php if (trim($body) !== ''): ?>
            <p class="verse-card__body"<?php echo lang_field_attr($verse, $field); ?>>
                <?php echo e(str_limit($body, 160)); ?>
            </p>
        <?php endif; ?>
    </a>

    <?php if (isset($verse['difficulty'])): ?>
        <p class="hint mb-0">
            <span class="badge"><?php echo et('difficulty.' . $verse['difficulty']); ?></span>
        </p>
    <?php endif; ?>
</article>
