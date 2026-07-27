<?php
/**
 * VedaVerse — app/views/partials/error_body.php
 * ---------------------------------------------------------------------
 * The shared body of every error page. Each errors/NNN.php passes its own
 * status in, and the title and text come from the translation table, so
 * all seven pages stay consistent in all three languages by construction
 * rather than by seven people remembering to.
 *
 * WHAT IS DELIBERATELY ABSENT
 *   The exception message, the file, the line, the stack trace, any SQL.
 *   A visitor gets a short apology and a reference code; the detail goes
 *   to the log where the owner can find it by that code. In debug mode
 *   ErrorHandler adds the detail itself — this template never does, so
 *   there is no branch here that could leak in production.
 *
 * Variables: $status, $reference.
 */

use VedaVerse\Core\View;

$status    = isset($status) ? (int) $status : 500;
$reference = isset($reference) ? $reference : '';
?>

<div class="card">
    <h1><?php echo e(View::t('error.' . $status . '.title')); ?></h1>
    <p class="lead"><?php echo e(View::t('error.' . $status . '.body')); ?></p>

    <p>
        <a href="/"><?php echo et('common.home'); ?></a>
        <?php if ($status === 401): ?>
            &middot; <a href="/login"><?php echo et('auth.login.title'); ?></a>
        <?php endif; ?>
    </p>

    <?php if ($reference !== ''): ?>
        <p class="small">
            <?php echo et('error.reference'); ?>: <code><?php echo e($reference); ?></code>
        </p>
    <?php endif; ?>
</div>
