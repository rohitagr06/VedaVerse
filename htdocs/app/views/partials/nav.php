<?php
/**
 * VedaVerse — app/views/partials/nav.php
 * ---------------------------------------------------------------------
 * The five primary destinations. One piece of markup that renders as a
 * bottom tab bar under 1024px and a sidebar above it — the CSS does the
 * switching, so there is no second copy of the link list to fall out of
 * step with this one.
 *
 * WHY A BOTTOM BAR ON PHONES
 *   A thumb reaches the bottom of a phone and does not comfortably reach
 *   the top. Navigation that lives in a top-left hamburger is
 *   navigation most people never open.
 *
 * ACCESSIBILITY
 *   A real <nav> with a label, so a screen reader can jump to it and
 *   knows which navigation it is. aria-current="page" marks the active
 *   destination — announced by assistive technology, and the CSS hangs
 *   the active styling off the same attribute so the two can never
 *   disagree.
 *
 *   The icons are decorative emoji marked aria-hidden. The text label is
 *   the accessible name, always present, never replaced by a tooltip.
 *
 * THE ICONS ARE A PLACEHOLDER
 *   Emoji render differently on every platform and cannot be styled.
 *   They are here so the shape of the navigation is right; the drawn SVG
 *   set — chariot, cards, feather, compass, profile — arrives with the
 *   illustration work.
 */

use VedaVerse\Core\Session;

$user = Session::user();

/**
 * Path, translation key, icon, and whether it needs an account.
 *
 * Most of these routes do not exist yet — they arrive in Steps 5 and 9.
 * They are listed now so the navigation is complete and the design can
 * be judged whole rather than in pieces.
 */
$items = array(
    array('path' => '/',        'key' => 'nav.path',    'icon' => '🛞', 'auth' => false),
    array('path' => '/review',  'key' => 'nav.review',  'icon' => '🔁', 'auth' => false),
    array('path' => '/sarathi', 'key' => 'nav.sarathi', 'icon' => '🪶', 'auth' => false),
    array('path' => '/explore', 'key' => 'nav.explore', 'icon' => '🧭', 'auth' => false),
    array('path' => $user !== null ? '/profile' : '/login',
          'key'  => $user !== null ? 'nav.profile' : 'auth.login.title',
          'icon' => '👤', 'auth' => false),
);
?>

<nav class="nav" aria-label="<?php echo et('nav.primary'); ?>">
    <?php foreach ($items as $item): ?>
        <?php
        // The home path must match exactly, or every URL on the site
        // would light up the first tab.
        $active = $item['path'] === '/'
            ? is_current('/', true)
            : is_current($item['path']);
        ?>
        <a class="nav__item"
           href="<?php echo e($item['path']); ?>"
           <?php echo $active ? 'aria-current="page"' : ''; ?>>
            <span class="nav__icon" aria-hidden="true"><?php echo $item['icon']; ?></span>
            <span><?php echo et($item['key']); ?></span>
        </a>
    <?php endforeach; ?>
</nav>
