<?php
/**
 * VedaVerse — app/views/pages/auth/login.php
 * ---------------------------------------------------------------------
 * The sign-in form.
 *
 * ACCESSIBILITY DECISIONS THAT LOOK LIKE STYLE BUT ARE NOT
 *   Every input has a real <label for>, not a placeholder standing in for
 *   one — a placeholder disappears the moment somebody types, which
 *   leaves anybody who was relying on it with an unlabelled box.
 *   aria-invalid and aria-describedby tie a field to its error message so
 *   a screen reader reads them together. autocomplete attributes let a
 *   password manager work, which is the single biggest thing this form
 *   can do for the security of the people using it.
 *
 * There is one sign-in screen for everyone, administrators included. See
 * the note at the top of AuthController for why.
 */

use VedaVerse\Core\Session;
use VedaVerse\Core\View;

$errors = Session::flashed('_errors', array());
$err = function ($field) use ($errors) {
    return isset($errors[$field][0]) ? $errors[$field][0] : '';
};
?>

<div class="card">
    <h1><?php echo et('auth.login.title'); ?></h1>
    <p class="lead"><?php echo et('auth.login.lead'); ?></p>

    <form method="post" action="/login" novalidate>
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

        <label for="field-password"><?php echo et('auth.field.password'); ?></label>
        <input type="password"
               id="field-password"
               name="password"
               autocomplete="current-password"
               required
               <?php echo $err('password') !== '' ? 'aria-invalid="true" aria-describedby="error-password"' : ''; ?>>
        <?php if ($err('password') !== ''): ?>
            <span class="field-error" id="error-password"><?php echo e($err('password')); ?></span>
        <?php endif; ?>

        <button type="submit" class="btn"><?php echo et('auth.login.submit'); ?></button>
    </form>
</div>

<div class="card">
    <p><?php echo et('auth.login.no_account'); ?>
       <a href="/register"><?php echo et('auth.register.title'); ?></a></p>
    <p><?php echo et('auth.login.forgot'); ?>
       <a href="/recover"><?php echo et('auth.recover.title'); ?></a></p>
</div>
