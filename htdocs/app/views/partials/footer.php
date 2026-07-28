<?php
/**
 * VedaVerse — app/views/partials/footer.php
 * ---------------------------------------------------------------------
 * Deliberately small.
 *
 * A footer stuffed with links is a footer nobody reads, and on a phone
 * it is a long scroll past nothing to reach the bottom of the page. What
 * belongs here is what somebody genuinely goes looking for: what this is,
 * who made it, and the honest note about the content.
 *
 * The link list grows in Step 15 when the pages it would point at
 * actually exist. Adding them now would mean a footer full of 404s.
 */

use VedaVerse\Core\Config;
?>

<footer class="app-footer wrap wrap-wide">
    <p class="mb-0">
        <?php echo e(Config::get('app.name')); ?>
        &middot;
        <?php echo et('footer.original_work'); ?>
    </p>
</footer>
