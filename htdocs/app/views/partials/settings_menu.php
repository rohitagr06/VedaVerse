<?php
/**
 * VedaVerse — app/views/partials/settings_menu.php
 * ---------------------------------------------------------------------
 * The reader's display controls: theme, text size, language.
 *
 * WHY <details> RATHER THAN A JAVASCRIPT DROPDOWN
 *   It opens and closes with no script at all, it is keyboard accessible
 *   for free, and screen readers announce its expanded state without any
 *   ARIA from us. A hand-built dropdown would need a click handler, an
 *   Escape handler, focus trapping, aria-expanded, and an outside-click
 *   listener — five things to get wrong in exchange for nothing.
 *
 * THE THEME CONTROL HAS THREE OPTIONS, NOT TWO
 *   Light, dark, and follow-the-system. A two-state toggle silently
 *   overrides somebody's operating-system preference the first time they
 *   touch it and offers no way back to it. The third option is what
 *   makes the control honest.
 *
 * WITHOUT JAVASCRIPT
 *   Theme and size do nothing — they are preferences, and the page is
 *   perfectly readable at the system default. Language is a plain link
 *   and works regardless, because it is a real navigation carrying
 *   ?lang= to the server.
 */

use VedaVerse\Core\Config;
use VedaVerse\Core\Session;
use VedaVerse\Core\View;

$languages = (array) Config::get('i18n.languages', array());
$current   = View::lang();
$user      = Session::user();
?>

<details class="settings-menu">
    <summary class="btn btn-secondary btn-sm w-auto">
        <span aria-hidden="true">⚙</span>
        <span class="sr-only"><?php echo et('settings.open'); ?></span>
    </summary>

    <div class="settings-menu__panel card">

        <fieldset class="settings-group">
            <legend class="label"><?php echo et('settings.theme'); ?></legend>
            <div class="row">
                <button type="button" class="chip" data-theme-set="light" aria-pressed="false">
                    <?php echo et('settings.theme.light'); ?>
                </button>
                <button type="button" class="chip" data-theme-set="dark" aria-pressed="false">
                    <?php echo et('settings.theme.dark'); ?>
                </button>
                <button type="button" class="chip" data-theme-set="system" aria-pressed="true">
                    <?php echo et('settings.theme.system'); ?>
                </button>
            </div>
        </fieldset>

        <fieldset class="settings-group">
            <legend class="label"><?php echo et('settings.size'); ?></legend>
            <div class="row">
                <?php foreach (array(1 => 'A', 2 => 'A', 3 => 'A', 4 => 'A') as $step => $glyph): ?>
                    <button type="button"
                            class="chip"
                            data-size-set="<?php echo (int) $step; ?>"
                            aria-pressed="<?php echo $step === 2 ? 'true' : 'false'; ?>">
                        <span aria-hidden="true"
                              style="font-size: <?php echo 12 + ($step * 2); ?>px"><?php echo $glyph; ?></span>
                        <span class="sr-only"><?php echo et('settings.size.step', array(':n' => $step)); ?></span>
                    </button>
                <?php endforeach; ?>
            </div>
        </fieldset>

        <fieldset class="settings-group">
            <legend class="label"><?php echo et('settings.language'); ?></legend>
            <div class="row">
                <?php foreach ($languages as $code => $meta): ?>
                    <?php
                    // A real link carrying ?lang=, so this works with no
                    // JavaScript and a shared URL opens in the language
                    // it was shared in.
                    $query = $_GET;
                    $query['lang'] = $code;
                    $href = current_path() . '?' . http_build_query($query);
                    ?>
                    <a class="chip <?php echo $current === $code ? 'is-active' : ''; ?>"
                       href="<?php echo e($href); ?>"
                       lang="<?php echo e($meta['html_lang']); ?>"
                       <?php echo $current === $code ? 'aria-current="true"' : ''; ?>>
                        <?php echo e($meta['native_name']); ?>
                    </a>
                <?php endforeach; ?>
            </div>
        </fieldset>

        <?php if ($user !== null): ?>
            <fieldset class="settings-group">
                <legend class="label"><?php echo et('settings.account'); ?></legend>
                <p class="hint mb-0"><?php echo e($user['name']); ?></p>

                <?php /*
                 * Sign-out is a POST, not a link. A GET sign-out can be
                 * fired by an <img> tag on somebody else's page, which is
                 * a small but real cross-site annoyance — and it is the
                 * kind of thing that makes a learner think the site is
                 * broken rather than that they were attacked.
                 */ ?>
                <form method="post" action="/logout" class="mt-4">
                    <?php echo csrf_field(); ?>
                    <button type="submit" class="btn btn-secondary btn-sm btn-block">
                        <?php echo et('auth.sign_out'); ?>
                    </button>
                </form>
            </fieldset>
        <?php endif; ?>

    </div>
</details>
