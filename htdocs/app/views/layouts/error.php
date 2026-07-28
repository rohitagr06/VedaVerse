<?php
/**
 * VedaVerse — app/views/layouts/error.php
 * ---------------------------------------------------------------------
 * The shell for the 400/401/403/404/429/500/503 pages.
 *
 * DEPENDS ON AS LITTLE AS POSSIBLE, ON PURPOSE
 *   An error page has to render when something is already broken. No
 *   navigation, no session-dependent header, no database read, no
 *   JavaScript. The stylesheets are linked rather than assumed, and if
 *   they fail to load the page is still readable — it is a heading, a
 *   paragraph and two links.
 *
 *   If this template itself throws, ErrorHandler falls back to a plain
 *   page built entirely in PHP with no template at all. That is the
 *   floor, and it cannot fail.
 *
 * THE TITLE IS DERIVED, NOT PASSED IN
 *   ErrorHandler renders this from several places, including the
 *   shutdown handler after a fatal error, where assembling a full data
 *   array is exactly the thing that fails a second time. So the layout
 *   works out its own title and copes with every variable being absent.
 *
 * Variables: $status, $content. Both optional.
 */

use VedaVerse\Core\View;

$status = isset($status) ? (int) $status : 500;
$title  = isset($title) && $title !== '' ? $title : View::t('error.' . $status . '.title');
?><!doctype html>
<html lang="<?php echo e(View::htmlLang()); ?>">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex, nofollow">
<title><?php echo e($title); ?></title>
<meta name="theme-color" content="#FF6B2C" media="(prefers-color-scheme: light)">
<meta name="theme-color" content="#14121F" media="(prefers-color-scheme: dark)">
<link rel="stylesheet" href="<?php echo e(asset('css/tokens.css')); ?>">
<link rel="stylesheet" href="<?php echo e(asset('css/base.css')); ?>">
<link rel="stylesheet" href="<?php echo e(asset('css/components.css')); ?>">
</head>
<body class="error-page">
<div class="wrap error-shell">
    <main id="main">
        <?php echo $content; ?>
    </main>
</div>
</body>
</html>
