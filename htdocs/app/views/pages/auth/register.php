<?php
/**
 * VedaVerse — app/views/pages/auth/register.php
 * ---------------------------------------------------------------------
 * The registration form.
 *
 * THE HONEYPOT
 *   The "website" field is hidden from people and left visible to bots,
 *   which fill in everything they find. It is hidden with an off-screen
 *   position rather than display:none, because some bots specifically
 *   skip display:none fields — and it carries tabindex="-1" and
 *   aria-hidden so a keyboard or screen-reader user never lands in it.
 *   Free hosting attracts a lot of automated signups, and this costs
 *   nothing.
 *
 * WHY THE PAGE SAYS YOU DO NOT NEED AN ACCOUNT
 *   Registration must never feel like a toll gate. Anonymous learning is
 *   a resolved decision, so the form leads by saying so and then explains
 *   what an account actually adds. A signup form that pretends to be
 *   compulsory loses the readers who would have come back.
 */

use VedaVerse\Core\Config;
use VedaVerse\Core\Session;

$errors = Session::flashed('_errors', array());
$err = function ($field) use ($errors) {
    return isset($errors[$field][0]) ? $errors[$field][0] : '';
};

$languages = (array) Config::get('i18n.languages', array());
$oldLang   = Session::old('lang', (string) Config::get('i18n.default', 'en'));
$oldTrack  = Session::old('track', 'beginner');
?>

<div class="card">
    <h1><?php echo et('auth.register.title'); ?></h1>
    <p class="lead"><?php echo et('auth.register.lead'); ?></p>

    <form method="post" action="/register" novalidate>
        <?php echo csrf_field(); ?>

        <label for="field-name"><?php echo et('auth.field.name'); ?></label>
        <input type="text"
               id="field-name"
               name="name"
               value="<?php echo e(Session::old('name')); ?>"
               autocomplete="name"
               maxlength="120"
               required
               <?php echo $err('name') !== '' ? 'aria-invalid="true" aria-describedby="error-name"' : ''; ?>>
        <?php if ($err('name') !== ''): ?>
            <span class="field-error" id="error-name"><?php echo e($err('name')); ?></span>
        <?php endif; ?>

        <label for="field-email">
            <?php echo et('auth.field.email'); ?>
            <span class="hint"><?php echo et('auth.register.no_email'); ?></span>
        </label>
        <input type="email"
               id="field-email"
               name="email"
               value="<?php echo e(Session::old('email')); ?>"
               autocomplete="username"
               inputmode="email"
               maxlength="191"
               required
               <?php echo $err('email') !== '' ? 'aria-invalid="true" aria-describedby="error-email"' : ''; ?>>
        <?php if ($err('email') !== ''): ?>
            <span class="field-error" id="error-email"><?php echo e($err('email')); ?></span>
        <?php endif; ?>

        <label for="field-password">
            <?php echo et('auth.field.password'); ?>
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

        <label for="field-lang"><?php echo et('auth.field.lang'); ?></label>
        <select id="field-lang" name="lang">
            <?php foreach ($languages as $code => $meta): ?>
                <option value="<?php echo e($code); ?>" <?php echo $oldLang === $code ? 'selected' : ''; ?>>
                    <?php echo e($meta['native_name']); ?>
                </option>
            <?php endforeach; ?>
        </select>

        <label for="field-track">
            <?php echo et('auth.field.track'); ?>
            <span class="hint"><?php echo et('auth.hint.track'); ?></span>
        </label>
        <select id="field-track" name="track">
            <?php foreach (array('beginner', 'intermediate', 'advanced') as $track): ?>
                <option value="<?php echo e($track); ?>" <?php echo $oldTrack === $track ? 'selected' : ''; ?>>
                    <?php echo et('auth.track.' . $track); ?>
                </option>
            <?php endforeach; ?>
        </select>

        <?php /* Honeypot. Off-screen rather than display:none — see the file header. */ ?>
        <div style="position:absolute;left:-9999px;top:-9999px" aria-hidden="true">
            <label for="field-website">Website</label>
            <input type="text" id="field-website" name="website" value="" tabindex="-1" autocomplete="off">
        </div>

        <button type="submit" class="btn"><?php echo et('auth.register.submit'); ?></button>
    </form>
</div>

<div class="card">
    <p><?php echo et('auth.register.have_account'); ?>
       <a href="/login"><?php echo et('auth.login.title'); ?></a></p>
</div>
