<?php
/**
 * VedaVerse — app/views/pages/auth/recover.php
 * ---------------------------------------------------------------------
 * Account recovery: email plus the one-time code, and a new password.
 *
 * ONE SCREEN, NOT TWO
 *   There is no "check your inbox" step, because there is no inbox — the
 *   host blocks outgoing mail. Everything the person needs is on this
 *   page, and the page says plainly what happens if they have lost the
 *   code as well, rather than leaving them clicking hopefully.
 *
 *   The code field accepts it with or without the grouping dashes and in
 *   any case. People write these on paper and type them back weeks later,
 *   usually while stressed, and failing them on punctuation would be
 *   cruel for no security gain.
 */

use VedaVerse\Core\Session;

$errors = Session::flashed('_errors', array());
$err = function ($field) use ($errors) {
    return isset($errors[$field][0]) ? $errors[$field][0] : '';
};
?>

<div class="card">
    <h1><?php echo et('auth.recover.title'); ?></h1>
    <p class="lead"><?php echo et('auth.recover.lead'); ?></p>

    <form method="post" action="/recover" novalidate>
        <?php echo csrf_field(); ?>

        <label for="field-email"><?php echo et('auth.field.email'); ?></label>
        <input type="email"
               id="field-email"
               name="email"
               value="<?php echo e(Session::old('email')); ?>"
               autocomplete="username"
               inputmode="email"
               required
               <?php echo $err('email') !== '' ? 'aria-invalid="true" aria-describedby="error-email"' : ''; ?>>
        <?php if ($err('email') !== ''): ?>
            <span class="field-error" id="error-email"><?php echo e($err('email')); ?></span>
        <?php endif; ?>

        <label for="field-code">
            <?php echo et('auth.field.code'); ?>
            <span class="hint">XXXX-XXXX-XXXX</span>
        </label>
        <input type="text"
               id="field-code"
               name="code"
               autocomplete="off"
               autocapitalize="characters"
               spellcheck="false"
               maxlength="20"
               required
               <?php echo $err('code') !== '' ? 'aria-invalid="true" aria-describedby="error-code"' : ''; ?>>
        <?php if ($err('code') !== ''): ?>
            <span class="field-error" id="error-code"><?php echo e($err('code')); ?></span>
        <?php endif; ?>

        <label for="field-password">
            <?php echo et('auth.field.new_password'); ?>
            <span class="hint" id="password-hint"><?php echo et('auth.hint.password'); ?></span>
        </label>
        <input type="password"
               id="field-password"
               name="password"
               autocomplete="new-password"
               required
               aria-describedby="password-hint<?php echo $err('password') !== '' ? ' error-password' : ''; ?>"
               <?php echo $err('password') !== '' ? 'aria-invalid="true"' : ''; ?>>
        <?php if ($err('password') !== ''): ?>
            <span class="field-error" id="error-password"><?php echo e($err('password')); ?></span>
        <?php endif; ?>

        <label for="field-password_confirm"><?php echo et('auth.field.password_confirm'); ?></label>
        <input type="password"
               id="field-password_confirm"
               name="password_confirm"
               autocomplete="new-password"
               required
               <?php echo $err('password_confirm') !== '' ? 'aria-invalid="true" aria-describedby="error-password_confirm"' : ''; ?>>
        <?php if ($err('password_confirm') !== ''): ?>
            <span class="field-error" id="error-password_confirm"><?php echo e($err('password_confirm')); ?></span>
        <?php endif; ?>

        <button type="submit" class="btn"><?php echo et('auth.recover.submit'); ?></button>
    </form>
</div>

<div class="card">
    <p class="small"><?php echo et('auth.recover.no_code'); ?></p>
    <p><a href="/login"><?php echo et('auth.login.title'); ?></a></p>
</div>
