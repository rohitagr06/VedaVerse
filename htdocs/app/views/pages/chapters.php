<?php
/**
 * VedaVerse — app/views/pages/chapters.php
 * ---------------------------------------------------------------------
 * All eighteen chapters.
 *
 * WHY THIS PAGE SAYS CHAPTER 2 IS THE START
 *   Because a list of eighteen numbered chapters invites somebody to
 *   begin at 1, and chapter 1 is Arjuna's collapse — scene-setting with
 *   no teaching in it. Starting there is the single most common way a
 *   first-time reader of the Gita gives up. The lead sentence exists to
 *   redirect that instinct, and the entry chapter is marked.
 *
 * PROGRESS ON EACH CARD
 *   "verses written" is not the same number as chapters.verse_count.
 *   Chapter 2 has 72 verses in the scripture and we have curated a
 *   handful — a progress bar against 72 would show every learner at 3%
 *   forever. The denominator is what exists to be read.
 */

use VedaVerse\Services\I18nService;

/** @var array<int,array> $chapters */
/** @var \VedaVerse\Services\ContentService $service */

$entry = (int) \VedaVerse\Core\Config::get('app.defaults.entry_chapter', 2);
?>

<div class="card">
    <h1><?php echo et('chapter.index.title'); ?></h1>
    <p class="lead"><?php echo et('chapter.index.lead'); ?></p>
</div>

<?php if ($chapters === array()): ?>

    <div class="card">
        <div class="empty">
            <p class="empty__title"><?php echo et('common.nothing_yet'); ?></p>
            <p class="empty__body mb-0"><?php echo et('common.coming_soon'); ?></p>
        </div>
    </div>

<?php else: ?>

    <div class="grid-cards">
        <?php foreach ($chapters as $chapter): ?>
            <?php
            $number  = (int) $chapter['chapter_number'];
            $written = (int) $chapter['verses_written'];
            $done    = (int) $chapter['verses_finished'];
            ?>
            <article class="card chapter-card<?php echo $number === $entry ? ' is-entry' : ''; ?>">
                <a class="chapter-card__link" href="<?php echo e(chapter_url($number)); ?>">
                    <p class="chapter-card__number">
                        <?php echo e(t('content.chapter_n', array(':n' => $number))); ?>
                    </p>

                    <h2 class="chapter-card__title"<?php echo lang_field_attr($chapter, 'title'); ?>>
                        <?php echo e(I18nService::field($chapter, 'title')); ?>
                    </h2>

                    <p class="chapter-card__sanskrit" lang="sa">
                        <?php echo e($chapter['sanskrit_name']); ?>
                    </p>

                    <?php $subtitle = I18nService::field($chapter, 'subtitle'); ?>
                    <?php if ($subtitle !== ''): ?>
                        <p class="text-muted"<?php echo lang_field_attr($chapter, 'subtitle'); ?>>
                            <?php echo e($subtitle); ?>
                        </p>
                    <?php endif; ?>
                </a>

                <p class="chapter-card__meta">
                    <span class="badge"><?php echo et('difficulty.' . $chapter['difficulty']); ?></span>
                    <?php if ($written > 0): ?>
                        <span class="text-faint">
                            <?php echo etc_('content.verse_count', $written); ?>
                            &middot;
                            <?php echo e(t('chapter.time', array(
                                ':n' => $service->readingMinutes($chapter),
                            ))); ?>
                        </span>
                    <?php endif; ?>
                </p>

                <?php if ($written > 0 && $done > 0): ?>
                    <progress class="meter" value="<?php echo $done; ?>" max="<?php echo $written; ?>">
                        <?php echo (int) $chapter['percent']; ?>%
                    </progress>
                    <p class="hint mb-0">
                        <?php echo e(t('common.of', array(':n' => $done, ':total' => $written))); ?>
                    </p>
                <?php elseif ($written === 0): ?>
                    <p class="hint mb-0"><?php echo et('common.coming_soon'); ?></p>
                <?php endif; ?>

                <?php if ($number === $entry): ?>
                    <p class="hint mb-0"><strong><?php echo et('path.start'); ?></strong></p>
                <?php endif; ?>
            </article>
        <?php endforeach; ?>
    </div>

<?php endif; ?>
