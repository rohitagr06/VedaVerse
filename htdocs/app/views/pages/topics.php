<?php
/**
 * VedaVerse — app/views/pages/topics.php
 * ---------------------------------------------------------------------
 * Two index pages from one template: /topics and /problems.
 *
 * THE HEADING AND THE LEAD ARE THE WHOLE DIFFERENCE
 *   The cards are identical; the framing is not. /topics opens "ideas
 *   that run through the book" and speaks to somebody studying it.
 *   /problems opens "start from what is bothering you" and speaks to
 *   somebody who has never opened it and is not here for scripture.
 *
 *   One template is right because the LIST is the same object. Two
 *   templates would be right if the framing ever needed different
 *   structure — if that day comes, split it, and do not compromise the
 *   problem page to keep the sharing.
 */

use VedaVerse\Services\I18nService;

/** @var array<int,array> $topics */
/** @var bool $is_problem */

$base = $is_problem ? '/problem/' : '/topic/';
?>

<div class="card">
    <h1><?php echo et($is_problem ? 'problem.index.title' : 'topic.index.title'); ?></h1>

    <?php if ($is_problem): ?>
        <p class="lead"><?php echo et('problem.index.lead'); ?></p>
    <?php endif; ?>
</div>

<?php if ($topics === array()): ?>

    <div class="card">
        <div class="empty">
            <p class="empty__title"><?php echo et('common.nothing_yet'); ?></p>
            <p class="empty__body mb-0"><?php echo et('common.coming_soon'); ?></p>
        </div>
    </div>

<?php else: ?>

    <div class="grid-cards">
        <?php foreach ($topics as $topic): ?>
            <?php
            $name        = I18nService::field($topic, 'name');
            $description = I18nService::field($topic, 'description');
            $count       = (int) $topic['verse_count'];
            ?>
            <article class="card topic-card">
                <a class="topic-card__link" href="<?php echo e($base . rawurlencode((string) $topic['slug'])); ?>">
                    <h2 class="topic-card__title"<?php echo lang_field_attr($topic, 'name'); ?>>
                        <?php echo e($name); ?>
                    </h2>

                    <?php if ($description !== ''): ?>
                        <p class="text-muted"<?php echo lang_field_attr($topic, 'description'); ?>>
                            <?php echo e(str_limit($description, 140)); ?>
                        </p>
                    <?php endif; ?>
                </a>

                <p class="hint mb-0">
                    <?php if ($count > 0): ?>
                        <?php echo etc_('content.verse_count', $count); ?>
                    <?php else: ?>
                        <?php echo et('topic.none'); ?>
                    <?php endif; ?>
                </p>
            </article>
        <?php endforeach; ?>
    </div>

<?php endif; ?>

<?php /*
 * A door to the other door. Somebody who arrived at /problems and found
 * nothing that fits should be able to reach the concepts, and the other
 * way round — without going back to the navigation and guessing.
 */ ?>
<div class="card">
    <p class="mb-0">
        <a href="<?php echo $is_problem ? '/topics' : '/problems'; ?>">
            <?php echo et($is_problem ? 'topic.index.title' : 'problem.index.title'); ?>
        </a>
    </p>
</div>
