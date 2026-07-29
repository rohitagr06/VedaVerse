<?php
/**
 * VedaVerse — app/views/pages/topic.php
 * ---------------------------------------------------------------------
 * One concept — karma, dharma, detachment — and the verses that build
 * it.
 *
 * ORDER: DEFINITION, THEN VERSES, THEN NEIGHBOURS
 *   Somebody here is studying. They want to know what the word means
 *   before they read verses using it, and once they have read them they
 *   want the next idea along. That is the order.
 *
 *   The problem page inverts this deliberately. See pages/problem.php.
 */

use VedaVerse\Core\View;
use VedaVerse\Services\I18nService;

/** @var array $topic */
/** @var string $name */

$description = I18nService::field($topic, 'description');
?>

<nav class="breadcrumb" aria-label="<?php echo et('nav.breadcrumb'); ?>">
    <a href="/topics"><?php echo et('nav.topics'); ?></a>
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
</div>

<?php if (!empty($topic['verses'])): ?>
    <section>
        <h2><?php echo et('topic.verses'); ?></h2>
        <div class="grid-cards">
            <?php foreach ($topic['verses'] as $verse): ?>
                <?php echo View::partial('partials/verse_card', array('verse' => $verse)); ?>
            <?php endforeach; ?>
        </div>
    </section>
<?php else: ?>
    <div class="card">
        <p class="mb-0"><?php echo et('topic.none'); ?></p>
    </div>
<?php endif; ?>

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
