<?php
/**
 * VedaVerse — app/views/pages/home.php
 * ---------------------------------------------------------------------
 * PROVISIONAL. Step 5 replaces this with the Chariot Path — the vertical
 * scrolling trail across Kurukshetra that is the home screen, the
 * progress indicator and the navigation all at once.
 *
 * What is here now exists so the layout, the account header, the flash
 * messages and the sign-in state can all be exercised end to end before
 * any content exists.
 */

use VedaVerse\Core\Config;
use VedaVerse\Core\Session;

$user = Session::user();
?>

<div class="card">
    <h1><?php echo e(Config::get('app.name')); ?></h1>
    <p class="lead"><?php echo e(Config::get('app.tagline')); ?></p>

    <?php if ($user !== null): ?>
        <p>Signed in as <strong><?php echo e($user['name']); ?></strong>.</p>
    <?php else: ?>
        <p>You can read everything without an account. An account adds syncing
           across devices, the forum, and certificates.</p>
        <p>
            <a href="/register"><?php echo et('auth.register.title'); ?></a>
            &middot;
            <a href="/login"><?php echo et('auth.login.title'); ?></a>
        </p>
    <?php endif; ?>
</div>

<div class="card">
    <h2>Build progress</h2>
    <p class="small">
        Steps 1 and 2 of the build order are done: the schema and installer,
        the core, the helpers, the middleware, and accounts. Content, the
        learning path and Sarathi arrive in later steps.
    </p>
    <p class="small"><a href="/health">Health check</a></p>
</div>
