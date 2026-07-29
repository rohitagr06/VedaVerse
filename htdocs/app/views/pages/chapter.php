<?php
/**
 * VedaVerse — app/views/pages/chapter.php
 * ---------------------------------------------------------------------
 * One chapter: what it is about, and every verse in it.
 *
 * CURATED AND UNCURATED SIT IN THE SAME LIST
 *   A verse we have written fully and a verse that is only Sanskrit plus
 *   a translation both appear. Hiding the second kind would make the
 *   chapter look shorter than the scripture is, which is a small lie
 *   about the text. They are marked instead, so a reader can see the
 *   difference and choose.
 */

use VedaVerse\Services\I18nService;

/** @var array $chapter */
/** @var \VedaVerse\Services\ContentService $service */

$number = (int) $chapter['chapter_number'];
$verses = $chapter['verses'];
?>

<nav class="breadcrumb" aria-label="<?php echo et('nav.breadcrumb'); ?>">
    <a href="/chapters"><?php echo et('content.chapters'); ?></a>
    <span aria-hidden="true">›</span>
    <span aria-current="page"><?php echo e(t('content.chapter_n', array(':n' => $number))); ?></span>
</nav>

<div class="card">
    <p class="text-muted"><?php echo e(t('content.chapter_n', array(':n' => $number))); ?></p>

    <h1<?php echo lang_field_attr($chapter, 'title'); ?>>
        <?php echo e(I18nService::field($chapter, 'title')); ?>
    </h1>

    <p class="shloka" lang="sa"><?php echo e($chapter['sanskrit_name']); ?></p>
    <p class="transliteration"><?php echo e($chapter['transliteration']); ?></p>

    <?php $subtitle = I18nService::field($chapter, 'subtitle'); ?>
    <?php if ($subtitle !== ''): ?>
        <p class="lead mt-6"<?php echo lang_field_attr($chapter, 'subtitle'); ?>>
            <?php echo e($subtitle); ?>
        </p>
    <?php endif; ?>

    <?php $summary = I18nService::field($chapter, 'summary'); ?>
    <?php if ($summary !== ''): ?>
        <div<?php echo lang_field_attr($chapter, 'summary'); ?>>
            <?php echo nl2br(e($summary)); ?>
        </div>
    <?php endif; ?>

    <p class="row mb-0">
        <span class="badge"><?php echo et('difficulty.' . $chapter['difficulty']); ?></span>
        <span class="text-faint">
            <?php echo etc_('content.verse_count', (int) $chapter['verses_written']); ?>
            &middot;
            <?php echo e(t('chapter.time', array(':n' => $service->readingMinutes($chapter)))); ?>
        </span>
    </p>
</div>

<?php if ($verses === array()): ?>

    <div class="card">
        <div class="empty">
            <p class="empty__title"><?php echo et('common.nothing_yet'); ?></p>
            <p class="empty__body mb-0"><?php echo et('common.coming_soon'); ?></p>
        </div>
    </div>

<?php else: ?>

    <section class="card">
        <h2 class="mt-0"><?php echo et('content.verses'); ?></h2>

        <ul class="verse-list">
            <?php foreach ($verses as $verse): ?>
                <?php
                $isStub  = (int) $verse['is_curated'] !== 1;
                $summary = I18nService::field($verse, 'summary');
                ?>
                <li class="verse-list__item<?php echo $isStub ? ' is-stub' : ''; ?>">
                    <a href="<?php echo e(verse_url($number, (int) $verse['verse_number'])); ?>">
                        <span class="verse-list__ref">
                            <?php echo e($number . '.' . (int) $verse['verse_number']); ?>
                        </span>

                        <span class="verse-list__body">
                            <?php if ($summary !== ''): ?>
                                <span<?php echo lang_field_attr($verse, 'summary'); ?>>
                                    <?php echo e(str_limit($summary, 120)); ?>
                                </span>
                            <?php else: ?>
                                <span class="text-faint" lang="sa">
                                    <?php echo e(str_limit((string) $verse['sanskrit_devanagari'], 60)); ?>
                                </span>
                            <?php endif; ?>
                        </span>

                        <span class="verse-list__flags">
                            <?php if (!empty($verse['is_finished'])): ?>
                                <span class="badge badge-success"><?php echo et('verse.done'); ?></span>
                            <?php endif; ?>
                            <?php if ($isStub): ?>
                                <span class="badge"><?php echo et('admin.content.stub'); ?></span>
                            <?php endif; ?>
                        </span>
                    </a>
                </li>
            <?php endforeach; ?>
        </ul>
    </section>

<?php endif; ?>

<nav class="card row row-between" aria-label="<?php echo et('nav.breadcrumb'); ?>">
    <?php if (!empty($chapter['neighbours']['previous'])): ?>
        <?php $p = $chapter['neighbours']['previous']; ?>
        <a href="<?php echo e(chapter_url((int) $p['chapter_number'])); ?>">
            ← <?php echo e(t('content.chapter_n', array(':n' => (int) $p['chapter_number']))); ?>
        </a>
    <?php else: ?>
        <span></span>
    <?php endif; ?>

    <?php if (!empty($chapter['neighbours']['next'])): ?>
        <?php $n = $chapter['neighbours']['next']; ?>
        <a href="<?php echo e(chapter_url((int) $n['chapter_number'])); ?>">
            <?php echo e(t('content.chapter_n', array(':n' => (int) $n['chapter_number']))); ?> →
        </a>
    <?php endif; ?>
</nav>
