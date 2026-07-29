<?php
/**
 * VedaVerse — app/views/pages/path.php
 * ---------------------------------------------------------------------
 * The Chariot Path. The home screen, the progress indicator and the
 * primary navigation, all the same object.
 *
 * WHAT IT IS
 *   A vertical trail down the page. Chapter milestones divide it; each
 *   node between them is a cluster of three to five verses — one
 *   sitting. Finished nodes are filled, the current one is marked, the
 *   ones ahead are visible but quiet.
 *
 * WHY A PATH AND NOT A LIST
 *   A list of 108 verses is a wall. A path has an end you can see, which
 *   is the only reason anybody believes they will reach it. That is the
 *   entire argument, and it is why the nodes ahead stay visible instead
 *   of being hidden until unlocked.
 *
 * NOTHING HERE IS A GATE
 *   A node styled 'locked' is dimmed, not barred. Every verse on this
 *   site is readable by anybody at any time, including a guest. The
 *   dimming communicates distance, not permission.
 *
 * MARKUP CHOICE
 *   An ordered list. It IS an ordered sequence, screen readers announce
 *   the position and the length — "item 4 of 27" — which is exactly the
 *   information the visual path conveys, and it needs no ARIA at all to
 *   do it.
 */

use VedaVerse\Core\Session;
use VedaVerse\Services\I18nService;

/** @var array $chariot   PathService::build() — NOT named $path, see PathController */
/** @var string $track */
/** @var array|null $resume */

$rows  = $chariot['rows'];
$user  = Session::user();
$empty = ($chariot['total'] === 0);
?>

<div class="card path-header">
    <h1><?php echo et('path.title'); ?></h1>
    <p class="lead"><?php echo et('path.lead'); ?></p>

    <?php if (!$empty): ?>
        <?php /*
         * The progress bar is a real <progress>, not a div with a width.
         * Assistive technology announces it as a progress bar with a
         * value, which a styled div does not, and it degrades to
         * something sensible with no CSS at all.
         */ ?>
        <div class="path-progress">
            <progress class="meter"
                      value="<?php echo (int) $chariot['finished']; ?>"
                      max="<?php echo (int) $chariot['total']; ?>">
                <?php echo (int) $chariot['percent']; ?>%
            </progress>
            <p class="hint mb-0">
                <?php echo e(t('common.of', array(
                    ':n'     => (int) $chariot['finished'],
                    ':total' => (int) $chariot['total'],
                ))); ?>
                &middot;
                <?php echo etc_('content.verse_count', (int) $chariot['total']); ?>
            </p>
        </div>

        <p class="mt-4 mb-0">
            <?php if ($resume !== null): ?>
                <a class="btn w-auto"
                   href="<?php echo e(verse_url((int) $resume['chapter_number'], (int) $resume['verse_number'])); ?>">
                    <?php echo et('path.continue'); ?>
                    <span class="text-muted">
                        <?php echo e((int) $resume['chapter_number'] . '.' . (int) $resume['verse_number']); ?>
                    </span>
                </a>
            <?php elseif ($chariot['current'] !== null): ?>
                <a class="btn w-auto"
                   href="<?php echo e(verse_url(
                       (int) $chariot['current']['chapter']['chapter_number'],
                       (int) $chariot['current']['first']['verse_number']
                   )); ?>">
                    <?php echo et('path.start'); ?>
                </a>
            <?php endif; ?>
        </p>
    <?php endif; ?>
</div>

<?php if ($empty): ?>

    <?php /*
     * No content seeded yet. This is a real state on a fresh install,
     * not a hypothetical — the installer creates the schema and nothing
     * else, so the very first thing an owner sees after installing is
     * this page. It should explain, not apologise.
     */ ?>
    <div class="card">
        <div class="empty">
            <div class="empty__art" aria-hidden="true"></div>
            <p class="empty__title"><?php echo et('common.nothing_yet'); ?></p>
            <p class="empty__body"><?php echo et('chapter.index.lead'); ?></p>
            <a class="btn w-auto" href="/chapters"><?php echo et('nav.chapters'); ?></a>
        </div>
    </div>

<?php else: ?>

    <ol class="path" aria-label="<?php echo et('path.title'); ?>">
        <?php foreach ($rows as $row): ?>

            <?php if ($row['type'] === 'milestone'): ?>
                <?php $chapter = $row['chapter']; ?>
                <li class="path__milestone">
                    <a href="<?php echo e(chapter_url((int) $chapter['chapter_number'])); ?>">
                        <span class="path__milestone-number">
                            <?php echo e(t('content.chapter_n', array(':n' => (int) $chapter['chapter_number']))); ?>
                        </span>
                        <span class="path__milestone-title"<?php echo lang_field_attr($chapter, 'title'); ?>>
                            <?php echo e(I18nService::field($chapter, 'title')); ?>
                        </span>
                    </a>
                </li>

            <?php else: ?>
                <?php
                $chapter = $row['chapter'];
                $first   = $row['first'];
                $state   = $row['state'];

                // The state label is read out as well as shown, because
                // the visual difference between done, current and ahead
                // is colour and fill — and colour alone is never an
                // acceptable signal.
                $stateKey = 'path.node.' . ($state === 'locked' ? 'locked' : $state);
                ?>
                <li class="path__node is-<?php echo e($state); ?>">
                    <a class="path__node-link"
                       href="<?php echo e(verse_url((int) $chapter['chapter_number'], (int) $first['verse_number'])); ?>"
                       <?php echo $state === 'current' ? 'aria-current="step"' : ''; ?>>

                        <span class="path__marker" aria-hidden="true"></span>

                        <span class="path__node-body">
                            <span class="path__node-label"><?php echo e($row['label']); ?></span>
                            <span class="path__node-state"><?php echo et($stateKey); ?></span>
                            <?php
                            $summary = I18nService::field($first, 'summary');
                            if ($summary !== ''):
                                ?>
                                <span class="path__node-summary"<?php echo lang_field_attr($first, 'summary'); ?>>
                                    <?php echo e(str_limit($summary, 90)); ?>
                                </span>
                            <?php endif; ?>
                        </span>
                    </a>
                </li>
            <?php endif; ?>

        <?php endforeach; ?>
    </ol>

<?php endif; ?>

<div class="card">
    <h2 class="mt-0"><?php echo et('path.track'); ?></h2>
    <p class="hint"><?php echo et('auth.hint.track'); ?></p>

    <?php /*
     * A real form with a submit per track, not a select that posts on
     * change. Three buttons are one tap each; a select is a tap, a
     * scroll and a tap, and it does nothing at all without JavaScript.
     */ ?>
    <form method="post" action="/path/track" class="row">
        <?php echo csrf_field(); ?>
        <?php foreach (array('beginner', 'intermediate', 'advanced') as $option): ?>
            <button type="submit"
                    name="track"
                    value="<?php echo e($option); ?>"
                    class="chip <?php echo $track === $option ? 'is-active' : ''; ?>"
                    <?php echo $track === $option ? 'aria-current="true"' : ''; ?>>
                <?php echo et('difficulty.' . $option); ?>
            </button>
        <?php endforeach; ?>
    </form>

    <?php if ($user === null): ?>
        <p class="hint mt-4 mb-0"><?php echo et('auth.guest.explain'); ?></p>
    <?php endif; ?>
</div>
