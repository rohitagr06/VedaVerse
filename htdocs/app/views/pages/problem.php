<?php
/**
 * VedaVerse — app/views/pages/problem.php
 * ---------------------------------------------------------------------
 * One life problem — anger, grief, burnout, comparison — and what the
 * text has to say about it.
 *
 * THIS IS OFTEN THE FRONT DOOR, AND IT IS WRITTEN AS ONE
 *   Somebody landing here searched for their problem. They have very
 *   likely never opened the Gita, may have no interest in scripture, and
 *   did not come looking for chapter 2. Nothing on this page assumes
 *   otherwise.
 *
 * WHY THE EXAMPLES COME FIRST — this is the inversion
 *   The topic page leads with a definition and then shows verses. This
 *   page leads with a SITUATION, because "here is something that
 *   happened to somebody, and it is your situation" earns the right to
 *   then show a two-thousand-year-old line in Sanskrit. Lead with the
 *   verse and a first-time visitor is gone before the scroll.
 *
 * THE DISCLAIMER IS NOT NEGOTIABLE
 *   Somebody reading /problem/grief may be in real distress. The page
 *   says plainly that this is an old book and not therapy, and that
 *   somebody who is struggling should talk to a person who can help.
 *   It appears on EVERY problem page, not on the subset that seems
 *   serious enough — because which ones are serious is not a judgement
 *   a template gets to make.
 */

use VedaVerse\Core\View;
use VedaVerse\Services\I18nService;

/** @var array $topic */
/** @var string $name */

$description = I18nService::field($topic, 'description');
?>

<nav class="breadcrumb" aria-label="<?php echo et('nav.breadcrumb'); ?>">
    <a href="/problems"><?php echo et('nav.problems'); ?></a>
    <span aria-hidden="true">›</span>
    <span aria-current="page"><?php echo e($name); ?></span>
</nav>

<div class="card">
    <h1<?php echo lang_field_attr($topic, 'name'); ?>><?php echo e($name); ?></h1>

    <?php if ($description !== ''): ?>
        <p class="lead"<?php echo lang_field_attr($topic, 'description'); ?>>
            <?php echo e($description); ?>
        </p>
    <?php endif; ?>

    <p class="alert alert-info mb-0"><?php echo et('problem.disclaimer'); ?></p>
</div>

<!-- ================================================================
     FIRST: a situation the reader recognises
     ================================================================ -->
<?php if (!empty($topic['examples'])): ?>
    <section>
        <h2><?php echo et('content.examples'); ?></h2>

        <?php foreach ($topic['examples'] as $example): ?>
            <article class="card example">
                <h3 class="example__title mt-0"<?php echo lang_field_attr($example, 'title'); ?>>
                    <?php echo e(I18nService::field($example, 'title')); ?>
                </h3>

                <p class="example__meta">
                    <span class="badge"><?php echo et('category.' . $example['category']); ?></span>
                    <?php if (trim((string) $example['source_reference']) !== ''): ?>
                        <span class="text-faint"><?php echo e($example['source_reference']); ?></span>
                    <?php endif; ?>
                </p>

                <div<?php echo lang_field_attr($example, 'scenario'); ?>>
                    <?php echo nl2br(e(I18nService::field($example, 'scenario'))); ?>
                </div>

                <?php $lesson = I18nService::field($example, 'lesson'); ?>
                <?php if ($lesson !== ''): ?>
                    <p class="example__lesson"<?php echo lang_field_attr($example, 'lesson'); ?>>
                        <?php echo e($lesson); ?>
                    </p>
                <?php endif; ?>

                <p class="mb-0">
                    <a href="<?php echo e(verse_url(
                        (int) $example['chapter_number'],
                        (int) $example['verse_number']
                    )); ?>">
                        <?php echo et('problem.read'); ?>
                        <span class="text-muted">
                            <?php echo e((int) $example['chapter_number'] . '.' . (int) $example['verse_number']); ?>
                        </span>
                    </a>
                </p>

                <?php if ((int) $example['is_ai_generated'] === 1): ?>
                    <p class="hint mb-0"><?php echo et('content.example.ai_note'); ?></p>
                <?php endif; ?>
            </article>
        <?php endforeach; ?>
    </section>
<?php endif; ?>

<!-- ================================================================
     THEN: the verses, ordered by how squarely they speak to this
     ================================================================ -->
<?php if (!empty($topic['verses'])): ?>
    <section>
        <h2><?php echo et('topic.verses'); ?></h2>
        <div class="grid-cards">
            <?php foreach ($topic['verses'] as $verse): ?>
                <?php echo View::partial('partials/verse_card', array('verse' => $verse)); ?>
            <?php endforeach; ?>
        </div>
    </section>
<?php elseif (empty($topic['examples'])): ?>
    <div class="card">
        <p class="mb-0"><?php echo et('topic.none'); ?></p>
    </div>
<?php endif; ?>

<!-- ================================================================
     THEN: what else this connects to
     ================================================================ -->
<?php if (!empty($topic['related'])): ?>
    <section class="card">
        <h2 class="mt-0"><?php echo et('topic.related'); ?></h2>
        <div class="row">
            <?php foreach ($topic['related'] as $related): ?>
                <a class="chip"
                   href="<?php echo e(((int) $related['is_life_problem'] === 1 ? '/problem/' : '/topic/')
                                     . rawurlencode((string) $related['slug'])); ?>"
                   <?php echo lang_field_attr($related, 'name'); ?>>
                    <?php echo e(I18nService::field($related, 'name')); ?>
                </a>
            <?php endforeach; ?>
        </div>
    </section>
<?php endif; ?>
