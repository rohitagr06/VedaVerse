<?php
/**
 * VedaVerse — app/views/pages/profile.php
 * ---------------------------------------------------------------------
 * The "You" tab. What this reader has saved, written and finished.
 *
 * IT LOOKS THE SAME FOR A GUEST
 *   Deliberately. A guest has all of this — their work is tagged with a
 *   year-long token — and the only honest difference is a line saying it
 *   lives on this device until they make an account. Showing a guest a
 *   sign-in wall here would contradict everything else the product says
 *   about anonymous reading.
 *
 * THIS PAGE IS WHERE THE MERGE BECOMES VISIBLE
 *   Bookmark two verses signed out, write a note, register, come back
 *   here. That is acceptance test 5, and until this page existed it
 *   could only be checked in SQL.
 *
 * NO XP, NO STREAK, NO LEVEL
 *   Those arrive in Step 7 with ProgressService. Rendering a zero for
 *   them now would look like a bug rather than an unbuilt feature.
 */

use VedaVerse\Core\Session;
use VedaVerse\Core\View;
use VedaVerse\Services\I18nService;

/** @var array<int,array> $saved */
/** @var array<int,array> $notes */
/** @var int $finished */
/** @var array<int,array> $recent */

$user = Session::user();
?>

<div class="card">
    <h1><?php echo et('profile.title'); ?></h1>

    <?php if ($user !== null): ?>
        <p class="lead"><?php echo e($user['name']); ?></p>
        <p class="text-muted mb-0"><?php echo e($user['email']); ?></p>
    <?php else: ?>
        <p class="lead"><?php echo et('auth.guest.badge'); ?></p>
        <p class="text-muted"><?php echo et('auth.guest.explain'); ?></p>
        <p class="mb-0">
            <a class="btn w-auto" href="/register"><?php echo et('auth.register.title'); ?></a>
            <a href="/login"><?php echo et('auth.login.title'); ?></a>
        </p>
    <?php endif; ?>
</div>

<div class="card">
    <h2 class="mt-0"><?php echo et('profile.verses_read'); ?></h2>
    <p class="lead mb-0"><?php echo e((string) (int) $finished); ?></p>
</div>

<!-- ================================================================
     SAVED
     ================================================================ -->
<section>
    <h2><?php echo et('explore.bookmarks'); ?></h2>

    <?php if ($saved === array()): ?>
        <div class="card">
            <div class="empty">
                <p class="empty__title"><?php echo et('common.nothing_yet'); ?></p>
                <p class="empty__body"><?php echo et('verse.bookmark'); ?></p>
                <a class="btn w-auto" href="/chapters"><?php echo et('nav.chapters'); ?></a>
            </div>
        </div>
    <?php else: ?>
        <div class="grid-cards">
            <?php foreach ($saved as $verse): ?>
                <?php echo View::partial('partials/verse_card', array('verse' => $verse)); ?>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>
</section>

<!-- ================================================================
     NOTES — private, and said so
     ================================================================ -->
<section class="card">
    <h2 class="mt-0"><?php echo et('verse.note'); ?></h2>
    <p class="hint"><?php echo et('verse.note_hint'); ?></p>

    <?php if ($notes === array()): ?>
        <p class="mb-0"><?php echo et('common.nothing_yet'); ?></p>
    <?php else: ?>
        <?php foreach ($notes as $note): ?>
            <article class="commentary">
                <?php if ($note['verse_number'] !== null): ?>
                    <h3 class="mt-0">
                        <a href="<?php echo e(verse_url(
                            (int) $note['chapter_number'],
                            (int) $note['verse_number']
                        )); ?>">
                            <?php echo e((int) $note['chapter_number'] . '.' . (int) $note['verse_number']); ?>
                        </a>
                    </h3>
                <?php endif; ?>

                <?php /* A note is the reader's own words. Escaped like everything else. */ ?>
                <p><?php echo nl2br(e($note['content'])); ?></p>
                <p class="hint mb-0"><?php echo e(time_ago($note['updated_at'])); ?></p>
            </article>
        <?php endforeach; ?>
    <?php endif; ?>
</section>

<!-- ================================================================
     RECENTLY OPENED
     ================================================================ -->
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

<!-- ================================================================
     YOUR DATA
     ================================================================ -->
<section class="card">
    <h2 class="mt-0"><?php echo et('account.data'); ?></h2>

    <p>
        <a class="btn btn-secondary w-auto" href="/profile/export">
            <?php echo et('account.export'); ?>
        </a>
    </p>

    <?php if ($user !== null): ?>
        <?php /*
         * Deletion asks for the password AND the word DELETE. Two
         * confirmations is not paranoia here: there is no backup anybody
         * can restore from, and the recovery code cannot bring an account
         * back that no longer exists.
         */ ?>
        <details class="mt-6">
            <summary><?php echo et('account.delete'); ?></summary>

            <div class="alert alert-error mt-4">
                <?php echo et('account.delete_warning'); ?>
            </div>

            <form method="post" action="/profile/delete">
                <?php echo csrf_field(); ?>

                <label class="label" for="password"><?php echo et('account.current_password'); ?></label>
                <input class="input" type="password" id="password" name="password"
                       autocomplete="current-password" required>

                <label class="label mt-4" for="confirm"><?php echo et('account.delete_confirm'); ?></label>
                <input class="input" type="text" id="confirm" name="confirm"
                       autocomplete="off" required>

                <button type="submit" class="btn btn-danger w-auto mt-4">
                    <?php echo et('account.delete'); ?>
                </button>
            </form>
        </details>
    <?php endif; ?>
</section>
