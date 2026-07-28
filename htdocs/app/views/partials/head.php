<?php
/**
 * VedaVerse — app/views/partials/head.php
 * ---------------------------------------------------------------------
 * Everything inside <head>, in one place, so all three layouts emit the
 * same metadata and none of them can drift.
 *
 * Variables: $title, $description, $robots, $canonical.
 *
 * THE INLINE SCRIPT IS DELIBERATE AND IS THE ONLY ONE
 *   The theme attribute has to be on <html> BEFORE the first paint. Do
 *   it in app.js and the page renders light, then flips to dark — the
 *   flash everybody notices and nobody can name. The only way to avoid
 *   it is a blocking snippet in the head, so there is exactly one, it is
 *   nine lines, and it carries the CSP nonce.
 *
 * STYLESHEET ORDER MATTERS
 *   fonts, tokens, base, components. Tokens define the variables the
 *   other two consume; components override base. Load them out of order
 *   and the cascade quietly does the wrong thing.
 */

use VedaVerse\Core\Config;
use VedaVerse\Core\View;
?>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">

<title><?php echo e($title); ?></title>
<meta name="description" content="<?php echo e(isset($description) ? $description : ''); ?>">
<meta name="robots" content="<?php echo e(isset($robots) ? $robots : Config::get('seo.robots_default')); ?>">
<?php if (!empty($canonical)): ?>
<link rel="canonical" href="<?php echo e($canonical); ?>">
<?php endif; ?>

<meta property="og:site_name" content="<?php echo e(Config::get('seo.open_graph.site_name')); ?>">
<meta property="og:title" content="<?php echo e($title); ?>">
<meta property="og:description" content="<?php echo e(isset($description) ? $description : ''); ?>">
<meta property="og:type" content="website">
<meta name="twitter:card" content="<?php echo e(Config::get('seo.twitter.card')); ?>">

<meta name="theme-color" content="#FF6B2C" media="(prefers-color-scheme: light)">
<meta name="theme-color" content="#14121F" media="(prefers-color-scheme: dark)">

<?php echo csrf_meta(); ?>

<?php /* Applied before first paint. See the note above. */ ?>
<script nonce="<?php echo e(csp_nonce()); ?>">
(function () {
    try {
        var t = localStorage.getItem('vv-theme');
        if (t === 'light' || t === 'dark') {
            document.documentElement.setAttribute('data-theme', t);
        }
        var s = localStorage.getItem('vv-size');
        if (s) { document.documentElement.setAttribute('data-size', s); }
    } catch (e) { /* Storage blocked. The system preference still applies. */ }
}());
</script>

<link rel="stylesheet" href="<?php echo e(asset('css/fonts.css')); ?>">
<link rel="stylesheet" href="<?php echo e(asset('css/tokens.css')); ?>">
<link rel="stylesheet" href="<?php echo e(asset('css/base.css')); ?>">
<link rel="stylesheet" href="<?php echo e(asset('css/components.css')); ?>">
<link rel="stylesheet" href="<?php echo e(asset('css/print.css')); ?>" media="print">

<?php echo View::section('head'); ?>
