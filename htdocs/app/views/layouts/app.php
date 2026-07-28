<?php
/**
 * VedaVerse — app/views/layouts/app.php
 * ---------------------------------------------------------------------
 * The main site shell: header, navigation, content, footer.
 *
 * Variables: $title, $description, $robots, $canonical, $bodyClass, $content.
 *
 * THE ORDER OF THINGS IN THE DOCUMENT
 *   Skip link, header, main, nav, footer. The navigation comes AFTER the
 *   main content in the markup even though it is painted at the bottom
 *   of the screen, so a screen reader and a keyboard reach the content
 *   first. Somebody arriving on a verse page wants the verse, not five
 *   tab stops before it.
 *
 * WHAT THIS LAYOUT DOES NOT DO
 *   It never queries the database. Everything it renders was passed in
 *   by a controller or read from the already-loaded session. If you find
 *   yourself wanting a repository here, the answer is a controller.
 */

use VedaVerse\Core\Config;
use VedaVerse\Core\Session;
use VedaVerse\Core\View;

$user = Session::user();
?><!doctype html>
<html lang="<?php echo e(View::htmlLang()); ?>">
<head>
<?php echo View::partial('partials/head', get_defined_vars()); ?>
</head>
<body class="<?php echo e(isset($bodyClass) ? $bodyClass : ''); ?>">

<a class="skip-link" href="#main"><?php echo et('common.skip_to_content'); ?></a>

<div class="app-shell">

    <header class="app-header">
        <a class="brand" href="/">
            <span class="brand__mark" aria-hidden="true"></span>
            <span><?php echo e(Config::get('app.short_name')); ?></span>
        </a>

        <div class="row">
            <?php if ($user !== null): ?>
                <span class="badge badge-xp" title="<?php echo et('profile.xp'); ?>">
                    <span aria-hidden="true">✦</span>
                    <?php echo e(number_short($user['xp'])); ?>
                </span>
                <?php if ((int) $user['streak_current'] > 0): ?>
                    <span class="badge" title="<?php echo et('profile.streak'); ?>">
                        <span aria-hidden="true">🔥</span>
                        <?php echo e((int) $user['streak_current']); ?>
                    </span>
                <?php endif; ?>
            <?php endif; ?>

            <?php echo View::partial('partials/settings_menu'); ?>
        </div>
    </header>

    <main class="app-main wrap wrap-wide" id="main">
        <?php echo View::partial('partials/flash'); ?>
        <?php echo $content; ?>
    </main>

    <?php echo View::partial('partials/nav'); ?>

</div>

<?php echo View::partial('partials/footer'); ?>

<script src="<?php echo e(asset('js/app.js')); ?>" defer></script>
<?php echo View::section('scripts'); ?>
</body>
</html>
