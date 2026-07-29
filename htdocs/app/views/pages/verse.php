<?php
/**
 * VedaVerse — app/views/pages/verse.php
 * ---------------------------------------------------------------------
 * One verse, and everything the product knows about it.
 *
 * THE FOUR THINGS THAT MUST STAY VISIBLY DISTINCT
 *   Scripture · traditional commentary · modern interpretation ·
 *   AI-generated analogy. Never blurred, never run together under one
 *   heading. The section headings are worded as claims about origin —
 *   "What the tradition says", "Written by AI" — precisely so a reader
 *   can tell at a glance which is which. That is a content-integrity
 *   requirement, not a style choice.
 *
 * ORDER IS THE PEDAGOGY
 *   Curiosity → context → Sanskrit → words → translation → explanation →
 *   history → modern examples → practice → reflection → remember. A
 *   beginner's first encounter is never metaphysics. Reordering these
 *   sections changes what the product teaches.
 *
 * LANGUAGE ATTRIBUTES
 *   The shloka is lang="sa". Any field that fell back to a different
 *   language than the reader asked for carries the language it actually
 *   landed in, via lang_field_attr(). Without that a screen reader
 *   announces Devanagari with an English engine and produces noise.
 *
 * NO SCRIPT REQUIRED
 *   Every control is a link or a form. Reading modes and explanation
 *   levels are query strings. Bookmark, note and mark-as-read are POSTs
 *   that redirect back. The page is fully usable with scripting off,
 *   which on a slow connection is the normal case rather than the
 *   exception.
 */

use VedaVerse\Services\I18nService;

/** @var array $verse */
/** @var string $reference   e.g. "2.47" */
/** @var string $mode */
/** @var string $level */
/** @var bool $finished */
/** @var bool $bookmarked */
/** @var array|null $note */

$id      = (int) $verse['id'];
$chapter = (int) $verse['chapter_number'];
$number  = (int) $verse['verse_number'];
$here    = verse_url($chapter, $number);

/** Rebuild this URL with one query parameter changed. */
$withQuery = function (array $changes) use ($here, $mode, $level) {
    $query = array_merge(array('mode' => $mode, 'level' => $level), $changes);
    return $here . '?' . http_build_query($query);
};

/** A hidden field so every POST comes back to exactly this view. */
$returnField = '<input type="hidden" name="return" value="' . e($withQuery(array())) . '">';
?>

<nav class="breadcrumb" aria-label="<?php echo et('nav.breadcrumb'); ?>">
    <a href="/chapters"><?php echo et('content.chapters'); ?></a>
    <span aria-hidden="true">›</span>
    <a href="<?php echo e(chapter_url($chapter)); ?>">
        <?php echo e(t('content.chapter_n', array(':n' => $chapter))); ?>
    </a>
    <span aria-hidden="true">›</span>
    <span aria-current="page"><?php echo e($reference); ?></span>
</nav>

<!-- ================================================================
     SCRIPTURE
     ================================================================ -->
<article class="card verse">

    <header class="verse__header">
        <p class="verse__reference">
            <?php echo e(t('content.verse_ref', array(':chapter' => $chapter, ':verse' => $number))); ?>
        </p>

        <?php /*
         * Reading modes. Real links carrying ?mode=, so a shared URL
         * opens in the mode it was shared in and the control works with
         * no JavaScript.
         */ ?>
        <div class="row" role="group" aria-label="<?php echo et('mode.label'); ?>">
            <?php /*
             * Focus and Print are deliberately NOT in this row. Focus
             * hides the chrome, so a chip row inside the chrome would be
             * the one thing left on screen; Print is a one-way trip to a
             * dialog. Both are offered at the foot of the page instead,
             * where somebody who has finished reading will look for them.
             */ ?>
            <?php foreach (array('learn', 'study', 'research', 'quick') as $option): ?>
                <a class="chip <?php echo $mode === $option ? 'is-active' : ''; ?>"
                   href="<?php echo e($withQuery(array('mode' => $option))); ?>"
                   <?php echo $mode === $option ? 'aria-current="true"' : ''; ?>>
                    <?php echo et('mode.' . $option); ?>
                </a>
            <?php endforeach; ?>
        </div>
    </header>

    <h1 class="sr-only">
        <?php echo e(t('content.gita')); ?> <?php echo e($reference); ?>
    </h1>

    <?php /*
     * lang="sa" is mandatory. It is the difference between a screen
     * reader pronouncing Sanskrit and a screen reader producing noise.
     */ ?>
    <p class="shloka" lang="sa"><?php echo nl2br(e($verse['sanskrit_devanagari'])); ?></p>

    <?php if (trim((string) $verse['transliteration_iast']) !== ''): ?>
        <?php /*
         * nl2br, because a shloka is two lines and the line break is
         * part of the metre. Escaped first, then the <br> added — never
         * the other way round.
         */ ?>
        <p class="transliteration"><?php echo nl2br(e($verse['transliteration_iast'])); ?></p>
    <?php endif; ?>

    <?php if (trim((string) $verse['transliteration_simple']) !== ''): ?>
        <details class="verse__simple">
            <summary><?php echo et('content.transliteration_simple'); ?></summary>
            <p class="mb-0"><?php echo nl2br(e($verse['transliteration_simple'])); ?></p>
        </details>
    <?php endif; ?>
</article>

<!-- ================================================================
     TRANSLATION — original writing, never a published translation
     ================================================================ -->
<section class="card">
    <h2 class="mt-0"><?php echo et('content.translation'); ?></h2>
    <p class="lead" <?php echo lang_field_attr($verse, 'translation'); ?>>
        <?php echo e(I18nService::field($verse, 'translation')); ?>
    </p>

    <?php if (trim((string) $verse['translation_literal']) !== ''): ?>
        <details>
            <summary><?php echo et('content.translation_literal'); ?></summary>
            <p class="mb-0 text-muted"><?php echo e($verse['translation_literal']); ?></p>
        </details>
    <?php endif; ?>
</section>

<?php if (!empty($verse['is_stub'])): ?>

    <div class="card">
        <p class="alert alert-info mb-0"><?php echo et('verse.uncurated'); ?></p>
    </div>

<?php else: ?>

    <!-- ============================================================
         WORD BY WORD — study and research modes only
         ============================================================ -->
    <?php if (!empty($verse['word_meanings'])): ?>
        <section class="card">
            <h2 class="mt-0"><?php echo et('content.word_meanings'); ?></h2>
            <dl class="glossary">
                <?php foreach ($verse['word_meanings'] as $word): ?>
                    <dt>
                        <span lang="sa"><?php echo e($word['devanagari']); ?></span>
                        <?php if (trim((string) $word['transliteration']) !== ''): ?>
                            <em class="text-muted"><?php echo e($word['transliteration']); ?></em>
                        <?php endif; ?>
                    </dt>
                    <dd<?php echo lang_field_attr($word, 'meaning'); ?>>
                        <?php echo e(I18nService::field($word, 'meaning')); ?>
                        <?php if ($mode === 'research' && trim((string) $word['grammar']) !== ''): ?>
                            <span class="hint"><?php echo e($word['grammar']); ?></span>
                        <?php endif; ?>
                    </dd>
                <?php endforeach; ?>
            </dl>
        </section>
    <?php endif; ?>

    <!-- ============================================================
         EXPLANATION — modern interpretation, at the chosen depth
         ============================================================ -->
    <?php if (!empty($verse['explanation'])): ?>
        <?php $x = $verse['explanation']; ?>
        <?php /*
         * The repository falls back when the requested depth has not
         * been written for this verse, so the chip that is highlighted
         * has to be the depth actually on screen — not the one in the
         * query string. Highlighting the requested one would tell the
         * reader they are looking at something they are not.
         */ ?>
        <?php $shownLevel = isset($x['level']) ? (string) $x['level'] : $level; ?>
        <section class="card">
            <h2 class="mt-0"><?php echo et('content.explanation'); ?></h2>

            <?php if (!empty($verse['levels']) && count($verse['levels']) > 1): ?>
                <div class="row" role="group" aria-label="<?php echo et('content.level'); ?>">
                    <?php foreach (array('beginner', 'intermediate', 'advanced') as $option): ?>
                        <?php if (!in_array($option, $verse['levels'], true)) { continue; } ?>
                        <a class="chip <?php echo $shownLevel === $option ? 'is-active' : ''; ?>"
                           href="<?php echo e($withQuery(array('level' => $option))); ?>"
                           <?php echo $shownLevel === $option ? 'aria-current="true"' : ''; ?>>
                            <?php echo et('content.level.' . $option); ?>
                        </a>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>

            <?php foreach (array(
                'historical_context'    => 'content.historical',
                'philosophical_context' => 'content.philosophical',
                'practical_meaning'     => 'content.practical',
                'modern_interpretation' => 'content.modern',
            ) as $field => $key): ?>
                <?php $body = I18nService::field($x, $field); ?>
                <?php if ($body !== ''): ?>
                    <h3><?php echo et($key); ?></h3>
                    <div<?php echo lang_field_attr($x, $field); ?>>
                        <?php echo nl2br(e($body)); ?>
                    </div>
                <?php endif; ?>
            <?php endforeach; ?>
        </section>
    <?php endif; ?>

    <!-- ============================================================
         MODERN EXAMPLES — where you have seen this
         ============================================================ -->
    <?php if (!empty($verse['examples'])): ?>
        <section class="card">
            <h2 class="mt-0"><?php echo et('content.examples'); ?></h2>
            <p class="text-muted"><?php echo et('content.examples.lead'); ?></p>

            <?php foreach ($verse['examples'] as $example): ?>
                <article class="example">
                    <h3 class="example__title"<?php echo lang_field_attr($example, 'title'); ?>>
                        <?php echo e(I18nService::field($example, 'title')); ?>
                    </h3>

                    <p class="example__meta">
                        <span class="badge"><?php echo et('category.' . $example['category']); ?></span>
                        <?php if (trim((string) $example['source_reference']) !== ''): ?>
                            <span class="text-faint"><?php echo e($example['source_reference']); ?></span>
                        <?php endif; ?>
                    </p>

                    <?php if ((int) $example['has_spoiler'] === 1): ?>
                        <p class="hint"><?php echo et('content.example.spoiler'); ?></p>
                    <?php endif; ?>

                    <div<?php echo lang_field_attr($example, 'scenario'); ?>>
                        <?php echo nl2br(e(I18nService::field($example, 'scenario'))); ?>
                    </div>

                    <h4><?php echo et('content.example.connection'); ?></h4>
                    <div<?php echo lang_field_attr($example, 'connection'); ?>>
                        <?php echo nl2br(e(I18nService::field($example, 'connection'))); ?>
                    </div>

                    <?php $lesson = I18nService::field($example, 'lesson'); ?>
                    <?php if ($lesson !== ''): ?>
                        <p class="example__lesson"<?php echo lang_field_attr($example, 'lesson'); ?>>
                            <?php echo e($lesson); ?>
                        </p>
                    <?php endif; ?>

                    <?php /*
                     * The AI label is not a disclaimer in small print. A
                     * reader is entitled to know which of these a person
                     * wrote and which a machine drafted, and it appears
                     * on the example itself rather than once at the top.
                     */ ?>
                    <?php if ((int) $example['is_ai_generated'] === 1): ?>
                        <p class="hint mb-0"><?php echo et('content.example.ai_note'); ?></p>
                    <?php endif; ?>
                </article>
            <?php endforeach; ?>
        </section>
    <?php endif; ?>

    <!-- ============================================================
         TRADITIONAL COMMENTARY — research mode. Never ranked.
         ============================================================ -->
    <?php if (!empty($verse['commentaries'])): ?>
        <section class="card">
            <h2 class="mt-0"><?php echo et('content.commentary'); ?></h2>
            <p class="text-muted"><?php echo et('content.commentary.lead'); ?></p>

            <?php foreach ($verse['commentaries'] as $view): ?>
                <article class="commentary">
                    <h3><?php echo e($view['viewpoint_label']); ?></h3>
                    <div<?php echo lang_field_attr($view, 'position_summary'); ?>>
                        <?php echo nl2br(e(I18nService::field($view, 'position_summary'))); ?>
                    </div>

                    <?php if (trim((string) $view['agreement_notes']) !== ''): ?>
                        <h4><?php echo et('content.commentary.agreement'); ?></h4>
                        <p><?php echo e($view['agreement_notes']); ?></p>
                    <?php endif; ?>

                    <?php if (trim((string) $view['difference_notes']) !== ''): ?>
                        <h4><?php echo et('content.commentary.difference'); ?></h4>
                        <p><?php echo e($view['difference_notes']); ?></p>
                    <?php endif; ?>
                </article>
            <?php endforeach; ?>

            <p class="hint mb-0"><?php echo et('content.commentary.neutral'); ?></p>
        </section>
    <?php endif; ?>

    <!-- ============================================================
         PRACTICE AND REFLECTION
         ============================================================ -->
    <?php if (!empty($verse['practices'])): ?>
        <section class="card">
            <h2 class="mt-0"><?php echo et('content.practice'); ?></h2>
            <?php foreach ($verse['practices'] as $practice): ?>
                <p<?php echo lang_field_attr($practice, 'action'); ?>>
                    <?php echo e(I18nService::field($practice, 'action')); ?>
                    <span class="hint">
                        <?php echo e(t('content.practice_time', array(
                            ':n' => (int) $practice['estimated_minutes'],
                        ))); ?>
                    </span>
                </p>
            <?php endforeach; ?>
        </section>
    <?php endif; ?>

    <?php if (!empty($verse['reflections'])): ?>
        <section class="card">
            <h2 class="mt-0"><?php echo et('content.reflection'); ?></h2>
            <ul>
                <?php foreach ($verse['reflections'] as $reflection): ?>
                    <li<?php echo lang_field_attr($reflection, 'question'); ?>>
                        <?php echo e(I18nService::field($reflection, 'question')); ?>
                    </li>
                <?php endforeach; ?>
            </ul>
        </section>
    <?php endif; ?>

    <!-- ============================================================
         REMEMBER THIS — the line they should still have in a year
         ============================================================ -->
    <?php if (!empty($verse['memory_aid'])): ?>
        <?php
        $aid  = $verse['memory_aid'];
        $hook = I18nService::field($aid, 'hook');
        ?>
        <?php if ($hook !== ''): ?>
            <section class="card remember">
                <h2 class="mt-0"><?php echo et('content.remember'); ?></h2>
                <p class="remember__hook"<?php echo lang_field_attr($aid, 'hook'); ?>>
                    <?php echo e($hook); ?>
                </p>

                <?php $analogy = I18nService::field($aid, 'analogy'); ?>
                <?php if ($analogy !== ''): ?>
                    <p class="text-muted mb-0"<?php echo lang_field_attr($aid, 'analogy'); ?>>
                        <?php echo e($analogy); ?>
                    </p>
                <?php endif; ?>
            </section>
        <?php endif; ?>
    <?php endif; ?>

    <!-- ============================================================
         CROSS REFERENCES — research mode
         ============================================================ -->
    <?php if (!empty($verse['cross_references'])): ?>
        <section class="card">
            <h2 class="mt-0"><?php echo et('content.cross_references'); ?></h2>
            <ul>
                <?php foreach ($verse['cross_references'] as $ref): ?>
                    <li>
                        <?php if ($ref['target_verse_number'] !== null): ?>
                            <a href="<?php echo e(verse_url(
                                (int) $ref['target_chapter_number'],
                                (int) $ref['target_verse_number']
                            )); ?>">
                                <?php echo e((int) $ref['target_chapter_number'] . '.' . (int) $ref['target_verse_number']); ?>
                            </a>
                        <?php else: ?>
                            <strong><?php echo e(trim($ref['book'] . ' ' . $ref['chapter'] . '.' . $ref['verse'], ' .')); ?></strong>
                        <?php endif; ?>
                        <span<?php echo lang_field_attr($ref, 'description'); ?>>
                            <?php echo e(I18nService::field($ref, 'description')); ?>
                        </span>
                    </li>
                <?php endforeach; ?>
            </ul>
        </section>
    <?php endif; ?>

<?php endif; ?>

<!-- ================================================================
     TOPICS
     ================================================================ -->
<?php if (!empty($verse['topics'])): ?>
    <section class="card">
        <h2 class="mt-0"><?php echo et('topic.related'); ?></h2>
        <div class="row">
            <?php foreach ($verse['topics'] as $topic): ?>
                <a class="chip"
                   href="<?php echo e(((int) $topic['is_life_problem'] === 1 ? '/problem/' : '/topic/')
                                     . rawurlencode((string) $topic['slug'])); ?>"
                   <?php echo lang_field_attr($topic, 'name'); ?>>
                    <?php echo e(I18nService::field($topic, 'name')); ?>
                </a>
            <?php endforeach; ?>
        </div>
    </section>
<?php endif; ?>

<!-- ================================================================
     WHAT THE READER CAN DO
     ================================================================ -->
<section class="card">
    <h2 class="mt-0 sr-only"><?php echo et('settings.account'); ?></h2>

    <div class="row">
        <?php /*
         * Once it is done the button becomes a statement rather than an
         * action. Re-marking a finished verse does nothing — markRead()
         * only ever raises completion — so offering the button again
         * would be a control that looks live and is not.
         */ ?>
        <?php if ($finished): ?>
            <p class="mb-0">
                <span class="badge badge-success"><?php echo et('verse.done'); ?></span>
            </p>
        <?php else: ?>
            <form method="post" action="/verse/<?php echo $id; ?>/read">
                <?php echo csrf_field(); ?>
                <?php echo $returnField; ?>
                <button type="submit" class="btn w-auto"><?php echo et('verse.mark_done'); ?></button>
            </form>
        <?php endif; ?>

        <form method="post" action="/verse/<?php echo $id; ?>/bookmark">
            <?php echo csrf_field(); ?>
            <?php echo $returnField; ?>
            <button type="submit" class="btn btn-secondary w-auto"
                    aria-pressed="<?php echo $bookmarked ? 'true' : 'false'; ?>">
                <?php echo et($bookmarked ? 'verse.unbookmark' : 'verse.bookmark'); ?>
            </button>
        </form>
    </div>

    <?php /*
     * A note is private. Never shown to anybody else, never moderated,
     * never read by the AI. The hint says so, because a reader deciding
     * whether to write something honest deserves to know.
     */ ?>
    <form method="post" action="/verse/<?php echo $id; ?>/note" class="mt-6">
        <?php echo csrf_field(); ?>
        <?php echo $returnField; ?>
        <label class="label" for="note"><?php echo et('verse.note'); ?></label>
        <p class="hint"><?php echo et('verse.note_hint'); ?></p>
        <textarea id="note" name="note" rows="4" class="input"
                  maxlength="4000"><?php echo e($note !== null ? $note['content'] : ''); ?></textarea>
        <button type="submit" class="btn btn-secondary w-auto mt-4">
            <?php echo et('verse.note_save'); ?>
        </button>
    </form>
</section>

<!-- ================================================================
     READ IT WITHOUT THE FURNITURE
     ================================================================ -->
<?php if ($mode !== 'focus'): ?>
    <p class="row">
        <a class="chip" href="<?php echo e($withQuery(array('mode' => 'focus'))); ?>">
            <?php echo et('mode.focus'); ?>
        </a>
        <?php /*
         * A real link to ?mode=print rather than a window.print() button:
         * it works with no JavaScript, it can be bookmarked, and print.css
         * is already loaded with media="print" so the browser's own print
         * command produces the same page either way.
         */ ?>
        <a class="chip" href="<?php echo e($withQuery(array('mode' => 'print'))); ?>">
            <?php echo et('mode.print'); ?>
        </a>
    </p>
<?php else: ?>
    <p class="row">
        <a class="chip" href="<?php echo e($withQuery(array('mode' => 'learn'))); ?>">
            <?php echo et('common.back'); ?>
        </a>
    </p>
<?php endif; ?>

<!-- ================================================================
     NEXT AND PREVIOUS
     ================================================================ -->
<nav class="card row row-between" aria-label="<?php echo et('nav.breadcrumb'); ?>">
    <?php if (!empty($verse['neighbours']['previous'])): ?>
        <?php $p = $verse['neighbours']['previous']; ?>
        <a href="<?php echo e(verse_url((int) $p['chapter_number'], (int) $p['verse_number'])); ?>">
            ← <?php echo et('verse.previous'); ?>
        </a>
    <?php else: ?>
        <span></span>
    <?php endif; ?>

    <?php if (!empty($verse['neighbours']['next'])): ?>
        <?php $n = $verse['neighbours']['next']; ?>
        <a href="<?php echo e(verse_url((int) $n['chapter_number'], (int) $n['verse_number'])); ?>">
            <?php echo et('verse.next'); ?> →
        </a>
    <?php endif; ?>
</nav>
