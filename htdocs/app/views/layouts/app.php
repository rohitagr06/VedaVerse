<?php
/**
 * VedaVerse — app/views/layouts/app.php
 * ---------------------------------------------------------------------
 * The main site shell.
 *
 * PROVISIONAL. Step 3 brings the real navigation — the bottom tab bar on
 * mobile, the sidebar above 1024px, the Chariot Path — and the design
 * system that goes with it. What is here now is the minimum that lets
 * Step 2's pages render, be navigated by keyboard, and be tested.
 *
 * WHAT IS ALREADY FINAL
 *   The document head. Every page emits its own title, description,
 *   canonical and robots directive, and the lang attribute is set from
 *   the interface language so a screen reader pronounces Devanagari
 *   correctly rather than reading it as English. Those are requirements
 *   from sections 13 and 16 of the specification, not placeholders.
 *
 * Variables: $title, $description, $robots, $canonical, $bodyClass, $content.
 */

use VedaVerse\Core\Config;
use VedaVerse\Core\Session;
use VedaVerse\Core\View;

$user = Session::user();
?><!doctype html>
<html lang="<?php echo e(View::htmlLang()); ?>">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?php echo e($title); ?></title>
<meta name="description" content="<?php echo e(isset($description) ? $description : ''); ?>">
<meta name="robots" content="<?php echo e(isset($robots) ? $robots : Config::get('seo.robots_default')); ?>">
<?php if (!empty($canonical)): ?>
<link rel="canonical" href="<?php echo e($canonical); ?>">
<?php endif; ?>
<meta property="og:site_name" content="<?php echo e(Config::get('seo.open_graph.site_name')); ?>">
<meta property="og:title" content="<?php echo e($title); ?>">
<meta property="og:type" content="website">
<meta name="theme-color" content="#FF6B2C">
<?php echo csrf_meta(); ?>
<?php echo View::partial('partials/provisional_css'); ?>
<?php echo View::section('head'); ?>
</head>
<body class="<?php echo e(isset($bodyClass) ? $bodyClass : ''); ?>">

<a class="skip" href="#main"><?php echo et('common.skip_to_content'); ?></a>

<div class="wrap wrap-wide">

    <header class="row">
        <a class="brand" href="/">
            <span class="brand-mark" aria-hidden="true"></span>
            <span class="brand-name"><?php echo e(Config::get('app.name')); ?></span>
        </a>

        <nav aria-label="Account">
            <?php if ($user !== null): ?>
                <span class="small"><?php echo e($user['name']); ?></span>
                <form method="post" action="/logout" style="display:inline">
                    <?php echo csrf_field(); ?>
                    <button type="submit" class="btn btn-secondary" style="width:auto;margin:0;min-height:44px">
                        <?php echo et('auth.sign_out'); ?>
                    </button>
                </form>
            <?php else: ?>
                <a class="small" href="/login"><?php echo et('auth.login.title'); ?></a>
            <?php endif; ?>
        </nav>
    </header>

    <main id="main">
        <?php echo View::partial('partials/flash'); ?>
        <?php echo $content; ?>
    </main>

</div>

<?php echo View::section('scripts'); ?>
</body>
</html>
