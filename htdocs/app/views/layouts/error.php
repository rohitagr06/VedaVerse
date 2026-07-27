<?php
/**
 * VedaVerse — app/views/layouts/error.php
 * ---------------------------------------------------------------------
 * The shell for the 400/401/403/404/429/500/503 pages.
 *
 * SELF-CONTAINED ON PURPOSE
 *   An error page has to render when something is already broken, so it
 *   depends on as little as possible: no navigation, no session-dependent
 *   header, no database read. The stylesheet is inlined rather than
 *   linked, because a 500 caused by a failed deploy may well be a deploy
 *   where the stylesheet is missing too.
 *
 *   If this template itself throws, ErrorHandler falls back to a plain
 *   HTML page built entirely in PHP with no template at all. That is the
 *   floor, and it cannot fail.
 *
 * NEVER INDEXED
 *   An error page that gets crawled is an error page that shows up in
 *   search results.
 *
 * THE TITLE IS DERIVED, NOT PASSED IN
 *   ErrorHandler renders this layout from several places, including the
 *   shutdown handler after a fatal error, where building a full page-data
 *   array is exactly the sort of extra work that fails a second time. So
 *   the layout works out its own title from the status and copes with
 *   every variable being absent. An error page that throws because a
 *   variable was missing is the worst possible failure: the real problem
 *   is replaced by a blank screen.
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
<meta name="theme-color" content="#FF6B2C">
<?php echo View::partial('partials/provisional_css'); ?>
</head>
<body>
<div class="wrap">
    <main id="main">
        <?php echo $content; ?>
    </main>
</div>
</body>
</html>
