<?php
/**
 * VedaVerse — app/views/errors/400.php
 *
 * All seven error pages share one body (partials/error_body.php) so that
 * the wording, the reference code and the accessibility behaviour cannot
 * drift apart between them. Give a status its own markup here only when
 * it genuinely needs something the others do not.
 */
echo \VedaVerse\Core\View::partial('partials/error_body', array(
    'status'    => 400,
    'reference' => isset($reference) ? $reference : '',
));
