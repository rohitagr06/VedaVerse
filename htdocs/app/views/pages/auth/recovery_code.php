<?php
/**
 * VedaVerse — app/views/pages/auth/recovery_code.php
 * ---------------------------------------------------------------------
 * The one screen in the whole product that cannot be shown twice.
 *
 * This is the entire account-recovery story. There is no email reset,
 * because the host blocks outgoing mail, so a learner who loses both
 * their password and this code loses the account. That is a hard
 * consequence and the page says so in plain words rather than burying it
 * in small print — the alternative is somebody clicking past it and
 * finding out months later.
 *
 * WHAT THE PAGE DELIBERATELY DOES NOT DO
 *   No automatic redirect, no timer, no "continue" that fires on its own.
 *   The person leaves when they say they have written it down.
 *
 * THE COPY BUTTON
 *   Progressive enhancement: it is created by script and only when the
 *   Clipboard API exists, so a browser without it shows no broken button.
 *   The code itself is selectable text regardless.
 *
 * Variables: $code.
 */

use VedaVerse\Core\View;
?>

<div class="card">
    <h1><?php echo et('auth.code.title'); ?></h1>
    <p class="lead"><?php echo et('auth.code.lead'); ?></p>

    <p class="code-block" id="recovery-code"><?php echo e($code); ?></p>

    <p id="copy-slot"></p>

    <div class="alert alert-error" role="alert">
        <?php echo et('auth.code.warning'); ?>
    </div>

    <a class="btn btn-secondary" href="/"><?php echo et('auth.code.continue'); ?></a>
</div>

<?php View::start('scripts'); ?>
<script nonce="<?php echo e(csp_nonce()); ?>">
(function () {
    'use strict';

    if (!navigator.clipboard) { return; }

    var slot = document.getElementById('copy-slot');
    var code = document.getElementById('recovery-code');
    if (!slot || !code) { return; }

    var button = document.createElement('button');
    button.type = 'button';
    button.className = 'btn btn-secondary';
    button.textContent = <?php echo ejs(t('auth.code.copy')); ?>;

    button.addEventListener('click', function () {
        navigator.clipboard.writeText(code.textContent.trim()).then(function () {
            button.textContent = <?php echo ejs(t('auth.code.copied')); ?>;
            // Announced to a screen reader, not only shown.
            button.setAttribute('aria-live', 'polite');
        });
    });

    slot.appendChild(button);
}());
</script>
<?php View::end(); ?>
