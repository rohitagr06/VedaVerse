<?php
/**
 * VedaVerse — app/views/pages/explore.php
 * ---------------------------------------------------------------------
 * Every way in that is not the Chariot Path.
 *
 * WHY THIS PAGE EXISTS
 *   The path is one route through the book and it is the right one for
 *   somebody working through it. It is the wrong one for somebody who
 *   opened the app with four minutes and a specific feeling, and for
 *   somebody coming back to a verse they half-remember. Those readers
 *   get this page.
 *
 * ORDER
 *   Today's verse, then what you were reading, then what you saved,
 *   then the two doors. The first three are personal and change every
 *   visit; the last two are the same every time and belong underneath.
 */

use VedaVerse\Core\View;
use VedaVerse\Services\I18nService;

/** @var array|null $daily */
/** @var array<int,array> $chapters */
/** @var array<int,array> $problems */
/** @var array<int,array> $recent */
/** @var array<int,array> $bookmarks */
?>

<div class="card">
    <h1><?php echo et('explore.title'); ?></h1>
    <p class="lead mb-0"><?php echo et('explore.lead'); ?></p>
</div>

<?php if ($daily !== null): ?>
    <section class="card">
        <h2 class="mt-0"><?php echo et('explore.daily'); ?></h2>

        <p class="shloka" lang="sa">
            <?php echo nl2br(e(str_limit((string) $daily['sanskrit_devanagari'], 200))); ?>
        </p>

        <p class="lead"<?php echo lang_field_attr($daily, 'translation'); ?>>
            <?php echo e(I18nService::field($daily, 'translation')); ?>
        </p>

        <p class="mb-0">
            <a class="btn w-auto"
               href="<?php echo e(verse_url((int) $daily['chapter_number'], (int) $daily['verse_number'])); ?>">
                <?php echo et('common.read_more'); ?>
                <span class="text-muted">
                    <?php echo e((int) $daily['chapter_number'] . '.' . (int) $daily['verse_number']); ?>
                </span>
            </a>
        </p>
    </section>
<?php endif; ?>

<?php if ($recent !== array()): ?>
    <section>
        <h2><?php echo et('explore.recent'); ?></h2>
        <div class="grid-cards">
            <?php foreach ($recent as $verse): ?>
                <?php echo View::partial('partials/verse_card', array('verse' => $verse)); ?>
            <?php endforeach; ?>
        </div>
    </section>
<?php endif; ?>

<?php if ($bookmarks !== array()): ?>
    <section>
        <h2><?php echo et('explore.bookmarks'); ?></h2>
        <div class="grid-cards">
            <?php foreach ($bookmarks as $verse): ?>
                <?php echo View::partial('partials/verse_card', array('verse' => $verse)); ?>
            <?php endforeach; ?>
        </div>
    </section>
<?php endif; ?>

<?php /*
 * The life problems come before the chapters on purpose. Somebody on
 * this page is browsing rather than working through the book, and
 * "start from what is bothering you" is the more likely reason they
 * opened it.
 */ ?>
<?php if ($problems !== array()): ?>
    <section class="card">
        <h2 class="mt-0"><?php echo et('problem.index.title'); ?></h2>
        <div class="row">
            <?php foreach ($problems as $problem): ?>
                <a class="chip"
                   href="/problem/<?php echo e(rawurlencode((string) $problem['slug'])); ?>"
                   <?php echo lang_field_attr($problem, 'name'); ?>>
                    <?php echo e(I18nService::field($problem, 'name')); ?>
                </a>
            <?php endforeach; ?>
        </div>
        <p class="hint mt-4 mb-0">
            <a href="/problems"><?php echo et('common.show_more'); ?></a>
        </p>
    </section>
<?php endif; ?>

<section class="card">
    <h2 class="mt-0"><?php echo et('nav.chapters'); ?></h2>
    <div class="row">
        <?php foreach ($chapters as $chapter): ?>
            <a class="chip" href="<?php echo e(chapter_url((int) $chapter['chapter_number'])); ?>">
                <?php echo e((int) $chapter['chapter_number']); ?>
                <span class="text-faint"<?php echo lang_field_attr($chapter, 'title'); ?>>
                    <?php echo e(str_limit(I18nService::field($chapter, 'title'), 22)); ?>
                </span>
            </a>
        <?php endforeach; ?>
    </div>
    <p class="hint mt-4 mb-0">
        <a href="/chapters"><?php echo et('chapter.index.title'); ?></a>
        &middot;
        <a href="/topics"><?php echo et('topic.index.title'); ?></a>
    </p>
</section>
