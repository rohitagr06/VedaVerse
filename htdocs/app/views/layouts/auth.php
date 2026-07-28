<?php
/**
 * VedaVerse — app/views/layouts/auth.php
 * ---------------------------------------------------------------------
 * The shell for sign-in, registration, recovery and the one-time code.
 *
 * Narrow, and deliberately bare: no navigation, no footer links, nothing
 * to wander off to. Somebody on one of these pages is trying to do a
 * single thing, and every other link on the page is a chance for them to
 * fail at it.
 *
 * The one link out is back to the home page, at the bottom, small — for
 * the person who arrived here by accident and wants to keep reading
 * without an account, which they are entitled to do.
 *
 * Variables: $title, $description, $robots, $canonical, $content.
 */

use VedaVerse\Core\Config;
use VedaVerse\Core\View;
?><!doctype html>
<html lang="<?php echo e(View::htmlLang()); ?>">
<head>
<?php echo View::partial('partials/head', get_defined_vars()); ?>
</head>
<body class="auth-page">

<a class="skip-link" href="#main"><?php echo et('common.skip_to_content'); ?></a>

<div class="wrap auth-shell">

    <header class="auth-header">
        <a class="brand" href="/">
            <span class="brand__mark" aria-hidden="true"></span>
            <span><?php echo e(Config::get('app.name')); ?></span>
        </a>
    </header>

    <main id="main">
        <?php echo View::partial('partials/flash'); ?>
        <?php echo $content; ?>
    </main>

    <p class="text-center mt-6">
        <a href="/"><?php echo et('common.home'); ?></a>
    </p>

</div>

<script src="<?php echo e(asset('js/app.js')); ?>" defer></script>
<?php echo View::section('scripts'); ?>
</body>
</html>
