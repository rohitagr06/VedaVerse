<?php
/**
 * VedaVerse — app/views/layouts/auth.php
 * ---------------------------------------------------------------------
 * The shell for the sign-in, registration and recovery screens.
 *
 * Narrow and deliberately bare: no navigation, no footer links, nothing
 * to wander off to. Somebody on this page is trying to do one thing, and
 * every other link is a chance to fail at it.
 *
 * PROVISIONAL STYLING. Step 3 replaces partials/provisional_css.php with
 * the real design system. The markup and the accessibility behaviour are
 * not provisional and should survive that change.
 *
 * Variables: $title, $description, $robots, $canonical, $content.
 */

use VedaVerse\Core\View;
?><!doctype html>
<html lang="<?php echo e(View::htmlLang()); ?>">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?php echo e($title); ?></title>
<meta name="description" content="<?php echo e(isset($description) ? $description : ''); ?>">
<meta name="robots" content="<?php echo e(isset($robots) ? $robots : 'noindex, nofollow'); ?>">
<?php if (!empty($canonical)): ?>
<link rel="canonical" href="<?php echo e($canonical); ?>">
<?php endif; ?>
<meta name="theme-color" content="#FF6B2C">
<?php echo csrf_meta(); ?>
<?php echo View::partial('partials/provisional_css'); ?>
<?php echo View::section('head'); ?>
</head>
<body>

<a class="skip" href="#main"><?php echo et('common.skip_to_content'); ?></a>

<div class="wrap">

    <a class="brand" href="/">
        <span class="brand-mark" aria-hidden="true"></span>
        <span class="brand-name"><?php echo e(\VedaVerse\Core\Config::get('app.name')); ?></span>
    </a>

    <main id="main">
        <?php echo View::partial('partials/flash'); ?>
        <?php echo $content; ?>
    </main>

    <p class="foot">
        <a href="/"><?php echo et('common.home'); ?></a>
    </p>

</div>

<?php echo View::section('scripts'); ?>
</body>
</html>
