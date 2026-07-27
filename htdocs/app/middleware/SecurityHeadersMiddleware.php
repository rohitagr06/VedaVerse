<?php
/**
 * VedaVerse — app/middleware/SecurityHeadersMiddleware.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Attaches the security headers to every response, including error
 *   pages. Runs outermost, so nothing escapes without them.
 *
 * WHY IN PHP AND NOT ONLY IN .htaccess
 *   InfinityFree may not have mod_headers enabled, and an unwrapped
 *   Header directive for a missing module returns HTTP 500 for the whole
 *   site. The .htaccess versions exist too, wrapped in <IfModule>, but
 *   they are the second layer. This one always runs.
 *
 * THE HEADER THAT WILL BITE YOU
 *   Content-Security-Policy's connect-src. If your Cloudflare Worker
 *   origin is not listed, the browser silently blocks every Sarathi
 *   request — the network tab shows the failure, the page shows nothing,
 *   and it looks exactly like the Worker being down. The Worker URL is
 *   stored in settings, so it is read at runtime and spliced in here
 *   rather than being frozen into a config file.
 *
 * WHY 'unsafe-inline' IS IN style-src BUT NOT script-src
 *   Critical CSS is inlined into the head for performance, which needs
 *   it. Scripts do not get it, because inline script is the payload of
 *   almost every XSS. A stylesheet cannot exfiltrate a session.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Middleware;

use VedaVerse\Core\Config;
use VedaVerse\Core\Request;
use VedaVerse\Repositories\SettingRepository;

class SecurityHeadersMiddleware extends Middleware
{
    /**
     * @param Request  $request
     * @param callable $next
     * @return \VedaVerse\Core\Response
     */
    public function handle(Request $request, $next)
    {
        // Mint the nonce BEFORE the page renders, so the tags the views
        // write and the header sent below carry the same value. Doing it
        // afterwards would produce a policy that blocks our own scripts.
        csp_nonce();

        $response = $this->next($next, $request);

        foreach ((array) Config::get('security.headers', array()) as $name => $value) {
            $response->header($name, $value);
        }

        $response->header('Content-Security-Policy', $this->policy());

        // HSTS tells a browser to refuse plain http for this domain for
        // months. Only ever sent when the request genuinely arrived over
        // TLS — sending it from an http response, or from a host that
        // later loses its certificate, locks every visitor out of the
        // site with no way to override it.
        if ($request->isSecure() && Config::get('security.hsts.enabled', true)) {
            $response->header('Strict-Transport-Security', $this->hsts());
        }

        return $response;
    }

    /**
     * Build the CSP, adding the Worker origin to connect-src.
     *
     * @return string
     */
    private function policy()
    {
        $directives = (array) Config::get('security.csp', array());

        // Inline scripts we wrote ourselves are allowed through by nonce.
        // Injected ones cannot carry it, because an attacker cannot know a
        // value that is regenerated every request.
        $nonce = (string) Config::get('security.csp_nonce', '');
        if ($nonce !== '' && isset($directives['script-src'])) {
            $directives['script-src'] .= " 'nonce-" . $nonce . "'";
        }

        $worker = $this->workerOrigin();
        if ($worker !== '') {
            $connect = isset($directives['connect-src']) ? $directives['connect-src'] : "'self'";
            $directives['connect-src'] = $connect . ' ' . $worker;
        }

        $parts = array();
        foreach ($directives as $name => $value) {
            $parts[] = $name . ' ' . $value;
        }

        return implode('; ', $parts);
    }

    /**
     * The scheme and host of the Worker, with no path.
     *
     * A CSP source is an origin, so https://x.workers.dev/chat is not a
     * valid entry — it has to be reduced to https://x.workers.dev. Getting
     * this subtly wrong is a long afternoon, because the browser reports
     * only that the connection was refused by the policy.
     *
     * @return string
     */
    private function workerOrigin()
    {
        $settings = new SettingRepository();
        $url      = (string) $settings->get('worker_url', (string) Config::get('ai.worker_url', ''));

        if (trim($url) === '') {
            return '';
        }

        $parts = parse_url($url);
        if (!is_array($parts) || empty($parts['host'])) {
            return '';
        }

        $scheme = isset($parts['scheme']) ? $parts['scheme'] : 'https';
        $origin = $scheme . '://' . $parts['host'];

        if (!empty($parts['port'])) {
            $origin .= ':' . (int) $parts['port'];
        }

        return $origin;
    }

    /**
     * @return string
     */
    private function hsts()
    {
        $value = 'max-age=' . (int) Config::get('security.hsts.max_age', 15552000);

        if (Config::get('security.hsts.include_subdomains', false)) {
            $value .= '; includeSubDomains';
        }
        if (Config::get('security.hsts.preload', false)) {
            $value .= '; preload';
        }

        return $value;
    }
}
