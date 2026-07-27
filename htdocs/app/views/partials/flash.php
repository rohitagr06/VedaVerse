<?php
/**
 * VedaVerse — app/views/partials/flash.php
 * ---------------------------------------------------------------------
 * Renders the one-shot messages left by the previous request, and the
 * validation errors from a rejected form.
 *
 * ACCESSIBILITY, NOT DECORATION
 *   role="alert" makes a screen reader announce the message when the page
 *   loads, rather than leaving a blind user to discover it by chance
 *   somewhere above the form they just submitted. The error list is a
 *   real <ul> of real links to the fields, because "there were 3 errors"
 *   with no way to reach them is worse than useless.
 *
 * COLOUR IS NEVER THE ONLY SIGNAL
 *   Each alert carries a word as well as a colour, so it still reads
 *   correctly in monochrome and to somebody who cannot distinguish red
 *   from green.
 */

use VedaVerse\Core\Session;

$success = Session::flashed('success');
$error   = Session::flashed('error');
$info    = Session::flashed('info');
$errors  = Session::flashed('_errors', array());
?>

<?php if (is_string($success) && $success !== ''): ?>
    <div class="alert alert-success" role="status">
        <?php echo e($success); ?>
    </div>
<?php endif; ?>

<?php if (is_string($info) && $info !== ''): ?>
    <div class="alert alert-info" role="status">
        <?php echo e($info); ?>
    </div>
<?php endif; ?>

<?php if (is_string($error) && $error !== ''): ?>
    <div class="alert alert-error" role="alert">
        <?php echo e($error); ?>
    </div>
<?php endif; ?>

<?php if (is_array($errors) && $errors !== array()): ?>
    <div class="alert alert-error" role="alert">
        <strong><?php echo et('form.errors_heading'); ?></strong>
        <ul>
            <?php foreach ($errors as $field => $messages): ?>
                <?php foreach ((array) $messages as $message): ?>
                    <li>
                        <a href="#field-<?php echo e($field); ?>"><?php echo e($message); ?></a>
                    </li>
                <?php endforeach; ?>
            <?php endforeach; ?>
        </ul>
    </div>
<?php endif; ?>
