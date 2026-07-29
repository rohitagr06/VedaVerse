#!/usr/bin/env bash
#
# VedaVerse — tools/smoke-test.sh
# =====================================================================
# Walks the whole application over HTTP and reports pass or fail for each
# check. Everything that can be verified without a browser is verified
# here, so "does this still work" is one command rather than an afternoon
# of clicking.
#
# USE
#       php -S 127.0.0.1:8080 -t htdocs tools/dev-router.php &
#       php tools/dev-reset.php
#       bash tools/smoke-test.sh
#
#   Optionally against another address:
#       bash tools/smoke-test.sh http://127.0.0.1:9000
#
# WHAT IT NEEDS
#   curl, and a running site. No database client, no PHP extensions, no
#   test framework. Every account it creates uses the reserved domain
#   @vedaverse.test with a per-run timestamp, so runs never collide and
#   nothing a human made can be touched.
#
# EXIT CODE
#   0 when everything passed, 1 otherwise — so it can gate a commit.
#
# ONE THING TO KNOW
#   The brute-force section deliberately trips the rate limiter. Running
#   the script twice inside fifteen minutes can therefore hit the
#   per-address ceiling and fail later checks. Run `php tools/dev-reset.php`
#   first, which is what clears those counters.
# =====================================================================

set -u

BASE="${1:-http://127.0.0.1:8080}"
JAR_DIR="$(mktemp -d)"
STAMP="$(date +%s)"
PASS=0
FAIL=0

cleanup() { rm -rf "$JAR_DIR"; }
trap cleanup EXIT

# ---------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------

ok()   { printf '  \033[32m✓\033[0m %s\n' "$1"; PASS=$((PASS+1)); }
bad()  { printf '  \033[31m✗\033[0m %s\n' "$1"; printf '      expected: %s\n      got:      %s\n' "$2" "$3"; FAIL=$((FAIL+1)); }
head_() { printf '\n\033[1m%s\033[0m\n' "$1"; }

# check <label> <expected> <actual>
check() { if [ "$2" = "$3" ]; then ok "$1"; else bad "$1" "$2" "$3"; fi; }

# contains <label> <needle> <haystack>
contains() {
  case "$3" in
    *"$2"*) ok "$1" ;;
    *)      bad "$1" "text containing: $2" "not found" ;;
  esac
}

# absent <label> <needle> <haystack>
absent() {
  case "$3" in
    *"$2"*) bad "$1" "no occurrence of: $2" "found it" ;;
    *)      ok "$1" ;;
  esac
}

# req <jar> <curl args…>  — a request that keeps cookies
req() { local jar="$1"; shift; curl -s -b "$JAR_DIR/$jar" -c "$JAR_DIR/$jar" "$@"; }

# status <jar> <path>
status() { req "$1" -o /dev/null -w '%{http_code}' "$BASE$2"; }

# token <jar> <path>  — pull the CSRF token out of a form
token() {
  req "$1" "$BASE$2" | grep -o 'name="_csrf" value="[a-f0-9]*"' | head -1 | sed 's/.*value="//;s/"//'
}

echo "VedaVerse smoke test"
echo "Target: $BASE"
echo "Run id: $STAMP"

# ---------------------------------------------------------------------
# PREFLIGHT — is anything listening at all?
# ---------------------------------------------------------------------
# Without this, forgetting to start `php -S` produces 48 red lines that
# all say "got: 000", and the real cause — nothing is listening on that
# port — is nowhere in the output. Diagnosing that from the failure list
# takes longer than the whole test run.
#
# 000 is curl's code for "the connection never happened". It is not an
# HTTP status; no server ever answered.

# No `|| echo 000` fallback here: curl already PRINTS 000 on a refused
# connection and then exits 7, so the fallback would append a second 000
# and the comparison below would never match. Caught by testing this
# against a dead port, which is the only way it would ever have been.
PREFLIGHT="$(curl -s -o /dev/null -w '%{http_code}' --max-time 5 "$BASE/health" 2>/dev/null)"
PREFLIGHT="${PREFLIGHT:-000}"

if [ "$PREFLIGHT" = "000" ]; then
  printf '\n\033[31mNothing is listening on %s\033[0m\n\n' "$BASE"
  echo "The site has to be running before this script can test it. In another"
  echo "terminal tab, from the repository root:"
  echo
  echo "    php -S 127.0.0.1:8080 -t htdocs tools/dev-router.php"
  echo
  echo "Leave that running, then run this script again. The dev-router.php"
  echo "argument is not optional — the built-in server ignores .htaccess, so"
  echo "without it every URL except / returns 404."
  echo
  echo "If the site is running on a different port, pass its address:"
  echo
  echo "    bash tools/smoke-test.sh http://127.0.0.1:9000"
  echo
  exit 1
fi

# The site is up but the installer has not run. index.php answers that
# case with a redirect to install.php, or a 503 when install.php is gone
# too. Both are worth naming plainly rather than letting every check
# downstream fail against a site that has no database.
#
# The Location HEADER is what gets inspected, not the body — a redirect
# has an empty body, so matching on body text finds nothing and this
# whole branch silently never fires.
if [ "$PREFLIGHT" = "503" ] || [ "$PREFLIGHT" = "302" ] || [ "$PREFLIGHT" = "301" ]; then
  PRE_HDRS="$(curl -s -D- -o /dev/null --max-time 5 "$BASE/health")"
  PRE_BODY="$(curl -s --max-time 5 "$BASE/health")"
  case "$PRE_HDRS$PRE_BODY" in
    *install.php*|*"has not been set up"*)
      printf '\n\033[31mThe site is running but not installed\033[0m\n\n'
      echo "app/config/local.php is missing, so there is no database to test"
      echo "against — every request is redirecting to the installer."
      echo
      echo "Open $BASE/install.php and work through the five screens, then run"
      echo "this script again."
      echo
      exit 1
      ;;
  esac
fi

# The site is up and installed, but the database is not answering —
# almost always because the database server is not running. Fifteen
# checks fail downstream from this one cause, and none of them says
# "the database is down".
PRE_HEALTH="$(curl -s --max-time 5 "$BASE/health")"
case "$PRE_HEALTH" in
  *'"database":false'*)
    printf '\n\033[31mThe database is not answering\033[0m\n\n'
    echo "The site is running and configured, but it cannot reach MySQL."
    echo "Start the database server and run this again:"
    echo
    echo "    sudo /Applications/XAMPP/xamppfiles/bin/mysql.server start"
    echo
    echo "Then confirm it answers — the --skip-ssl is required, because the"
    echo "MariaDB client demands TLS and the 10.4 server has none:"
    echo
    echo "    mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p -e 'SELECT 1'"
    echo
    echo "The exact driver error is in htdocs/storage/logs/."
    echo
    exit 1
    ;;
esac

# ---------------------------------------------------------------------
head_ "1. The site is up"
# ---------------------------------------------------------------------

HEALTH="$(curl -s "$BASE/health")"
contains "health endpoint reports ok"          '"ok":true'          "$HEALTH"
contains "  database reachable"                '"database":true'    "$HEALTH"
contains "  cache working"                     '"cache":true'       "$HEALTH"
contains "  log directory writable"            '"writable_logs":true' "$HEALTH"

check "home page renders"      200 "$(curl -s -o /dev/null -w '%{http_code}' "$BASE/")"
check "login page renders"     200 "$(curl -s -o /dev/null -w '%{http_code}' "$BASE/login")"
check "register page renders"  200 "$(curl -s -o /dev/null -w '%{http_code}' "$BASE/register")"
check "recover page renders"   200 "$(curl -s -o /dev/null -w '%{http_code}' "$BASE/recover")"

# ---------------------------------------------------------------------
head_ "2. Security headers on every response"
# ---------------------------------------------------------------------

HDRS="$(curl -s -D- -o /dev/null "$BASE/login")"
contains "Content-Security-Policy sent"   "Content-Security-Policy"       "$HDRS"
contains "  inline script blocked by default" "script-src 'self'"         "$HDRS"
contains "X-Content-Type-Options: nosniff" "nosniff"                      "$HDRS"
contains "X-Frame-Options: SAMEORIGIN"     "SAMEORIGIN"                   "$HDRS"
contains "Referrer-Policy set"             "strict-origin-when-cross-origin" "$HDRS"
contains "Permissions-Policy set"          "Permissions-Policy"           "$HDRS"
contains "session cookie is HttpOnly"      "HttpOnly"                     "$HDRS"
contains "session cookie is SameSite=Lax"  "SameSite=Lax"                 "$HDRS"

ERRHDRS="$(curl -s -D- -o /dev/null "$BASE/no-such-page")"
contains "headers are on error pages too"  "Content-Security-Policy"      "$ERRHDRS"

# ---------------------------------------------------------------------
head_ "3. Error pages"
# ---------------------------------------------------------------------

check "unknown path is 404"     404 "$(curl -s -o /dev/null -w '%{http_code}' "$BASE/no-such-page")"
check "wrong method is 405"     405 "$(curl -s -o /dev/null -w '%{http_code}' "$BASE/logout")"

NOTFOUND="$(curl -s "$BASE/no-such-page")"
contains "404 has a friendly title"   "This page is not here" "$NOTFOUND"
contains "404 shows a reference code" "<code>"                "$NOTFOUND"
absent   "404 leaks no file path"     "/htdocs/"              "$NOTFOUND"
absent   "404 leaks no stack trace"   "#0 "                   "$NOTFOUND"

contains "404 in Hindi"    "यह पेज यहाँ नहीं है"  "$(curl -s "$BASE/no-such-page?lang=hi")"
contains "404 in Hinglish" "Yeh page yahan nahi hai" "$(curl -s "$BASE/no-such-page?lang=hinglish")"
contains "404 as JSON for a fetch" '"ok":false' "$(curl -s -H 'Accept: application/json' "$BASE/no-such-page")"

# ---------------------------------------------------------------------
head_ "4. CSRF protection"
# ---------------------------------------------------------------------

for route in login register recover logout; do
  OUT="$(curl -s -c "$JAR_DIR/csrf" -b "$JAR_DIR/csrf" -o /dev/null -w '%{http_code}' \
        -X POST -d "email=a@vedaverse.test&password=Whatever" "$BASE/$route")"
  case "$OUT" in
    30*) ok "POST /$route without a token is refused" ;;
    *)   bad "POST /$route without a token is refused" "a 3xx redirect" "$OUT" ;;
  esac
done

BADTOKEN="$(curl -s -c "$JAR_DIR/csrf2" -b "$JAR_DIR/csrf2" -o /dev/null -w '%{http_code}' \
           -X POST -d "_csrf=deadbeef&email=a@vedaverse.test&password=Whatever" "$BASE/login")"
case "$BADTOKEN" in
  30*) ok "POST with a forged token is refused" ;;
  *)   bad "POST with a forged token is refused" "a 3xx redirect" "$BADTOKEN" ;;
esac

# ---------------------------------------------------------------------
head_ "5. Registration"
# ---------------------------------------------------------------------

EMAIL="smoke-$STAMP@vedaverse.test"
PASSWORD='Kurukshetra#2026x'

# 5a. A weak password is refused.
T="$(token main /register)"
req main -o /dev/null -X POST \
  --data-urlencode "_csrf=$T" --data-urlencode "name=Weak Password" \
  --data-urlencode "email=weak-$STAMP@vedaverse.test" \
  --data-urlencode "password=password1" --data-urlencode "password_confirm=password1" \
  --data-urlencode "lang=en" --data-urlencode "track=beginner" --data-urlencode "website=" \
  "$BASE/register"
contains "weak password refused, with a reason" "At least 10 characters" "$(req main "$BASE/register?lang=en")"

# 5b. The honeypot catches a bot.
T="$(token main /register)"
req main -o /dev/null -X POST \
  --data-urlencode "_csrf=$T" --data-urlencode "name=Bot" \
  --data-urlencode "email=bot-$STAMP@vedaverse.test" \
  --data-urlencode "password=$PASSWORD" --data-urlencode "password_confirm=$PASSWORD" \
  --data-urlencode "lang=en" --data-urlencode "track=beginner" \
  --data-urlencode "website=http://spam.example" \
  "$BASE/register"
BOTPAGE="$(req main "$BASE/register")"
contains "honeypot rejects a bot signup" "alert-error" "$BOTPAGE"

# 5c. A real signup succeeds.
T="$(token main /register)"
req main -o /dev/null -X POST \
  --data-urlencode "_csrf=$T" --data-urlencode "name=Smoke Tester" \
  --data-urlencode "email=$EMAIL" \
  --data-urlencode "password=$PASSWORD" --data-urlencode "password_confirm=$PASSWORD" \
  --data-urlencode "lang=hinglish" --data-urlencode "track=advanced" --data-urlencode "website=" \
  "$BASE/register"

CODEPAGE="$(req main "$BASE/recovery-code")"
CODE="$(printf '%s' "$CODEPAGE" | grep -oE 'id="recovery-code">[A-Z0-9-]+' | sed 's/.*>//')"

if [ -n "$CODE" ]; then ok "registration succeeds and shows a recovery code ($CODE)"
else bad "registration succeeds and shows a recovery code" "a code" "nothing"; fi

contains "the code screen carries the loud warning" 'class="alert alert-error"' "$CODEPAGE"
check "the code cannot be viewed twice" 303 "$(status main /recovery-code)"

HOME="$(req main "$BASE/")"
# The account NAME, not an English label. This account registers in
# Hinglish, so the old assertion only passed while the home page carried
# hardcoded English — which was itself a bug. A name is
# language-independent, and it is the stronger claim anyway: it proves
# the right person is signed in, not that some string exists.
contains "signed in after registering" "Smoke Tester" "$HOME"
contains "chosen language is applied"  'lang="en-IN"' "$HOME"

# ---------------------------------------------------------------------
head_ "6. Output escaping"
# ---------------------------------------------------------------------

XSSMAIL="xss-$STAMP@vedaverse.test"
T="$(token xss /register)"
req xss -o /dev/null -X POST \
  --data-urlencode "_csrf=$T" --data-urlencode 'name=<script>alert(1)</script>' \
  --data-urlencode "email=$XSSMAIL" \
  --data-urlencode "password=$PASSWORD" --data-urlencode "password_confirm=$PASSWORD" \
  --data-urlencode "lang=en" --data-urlencode "track=beginner" --data-urlencode "website=" \
  "$BASE/register"
req xss -o /dev/null "$BASE/recovery-code"
XSSHOME="$(req xss "$BASE/")"
absent   "a script tag in a display name does not execute" "<script>alert(1)</script>" "$XSSHOME"
contains "  it renders as escaped text instead" "&lt;script&gt;alert(1)&lt;/script&gt;" "$XSSHOME"

# ---------------------------------------------------------------------
head_ "7. Sign out and back in"
# ---------------------------------------------------------------------

T="$(token main /)"
req main -o /dev/null -X POST --data-urlencode "_csrf=$T" "$BASE/logout"
contains "sign out works" "Sign in" "$(req main "$BASE/")"

SESSION_BEFORE="$(grep vv_session "$JAR_DIR/main" 2>/dev/null | awk '{print $7}')"
T="$(token main /login)"
req main -o /dev/null -X POST \
  --data-urlencode "_csrf=$T" --data-urlencode "email=$EMAIL" --data-urlencode "password=$PASSWORD" \
  "$BASE/login"
SESSION_AFTER="$(grep vv_session "$JAR_DIR/main" 2>/dev/null | awk '{print $7}')"

contains "sign in works" "Smoke Tester" "$(req main "$BASE/")"
if [ "$SESSION_BEFORE" != "$SESSION_AFTER" ]; then
  ok "session id changes on sign-in (defeats fixation)"
else
  bad "session id changes on sign-in (defeats fixation)" "a new id" "the same id"
fi

# ---------------------------------------------------------------------
head_ "8. Role gate"
# ---------------------------------------------------------------------

check "/admin redirects a signed-out visitor" 303 "$(curl -s -o /dev/null -w '%{http_code}' "$BASE/admin")"
check "/admin is 403 for an ordinary account" 403 "$(status main /admin)"

# ---------------------------------------------------------------------
head_ "9. Account recovery"
# ---------------------------------------------------------------------

NEWPASSWORD='Panchajanya#2026'
# Typed back in lower case with the dashes left out, as people actually do.
BARE="$(printf '%s' "$CODE" | tr -d '-' | tr 'A-Z' 'a-z')"

T="$(token main /recover)"
req main -o /dev/null -X POST \
  --data-urlencode "_csrf=$T" --data-urlencode "email=$EMAIL" \
  --data-urlencode "code=AAAA-BBBB-CCCC" \
  --data-urlencode "password=$NEWPASSWORD" --data-urlencode "password_confirm=$NEWPASSWORD" \
  "$BASE/recover?lang=en"
# ?lang=en on the POST, not just the GET. The test account registered in
# Hinglish, and a flash message is composed during the request that sets
# it — so asking for English on the page that DISPLAYS it is too late. An
# explicit language in the URL beats the account preference, which is what
# makes a shared link open in the language it was shared in.
contains "a wrong recovery code is refused" "do not match" "$(req main "$BASE/recover?lang=en")"

T="$(token main /recover)"
req main -o /dev/null -X POST \
  --data-urlencode "_csrf=$T" --data-urlencode "email=$EMAIL" \
  --data-urlencode "code=$BARE" \
  --data-urlencode "password=$NEWPASSWORD" --data-urlencode "password_confirm=$NEWPASSWORD" \
  "$BASE/recover"
NEWCODE="$(req main "$BASE/recovery-code" | grep -oE 'id="recovery-code">[A-Z0-9-]+' | sed 's/.*>//')"

if [ -n "$NEWCODE" ] && [ "$NEWCODE" != "$CODE" ]; then
  ok "the code works lower-case and undashed, and a fresh one is issued"
else
  bad "the code works lower-case and undashed, and a fresh one is issued" "a new code" "${NEWCODE:-nothing}"
fi

T="$(token main /recover)"
req main -o /dev/null -X POST \
  --data-urlencode "_csrf=$T" --data-urlencode "email=$EMAIL" --data-urlencode "code=$CODE" \
  --data-urlencode "password=$PASSWORD" --data-urlencode "password_confirm=$PASSWORD" \
  "$BASE/recover?lang=en"
contains "the old code no longer works" "do not match" "$(req main "$BASE/recover?lang=en")"

T="$(token main /login)"
req main -o /dev/null -X POST \
  --data-urlencode "_csrf=$T" --data-urlencode "email=$EMAIL" --data-urlencode "password=$NEWPASSWORD" \
  "$BASE/login"
contains "the new password signs in" "Smoke Tester" "$(req main "$BASE/")"

# ---------------------------------------------------------------------
head_ "10. Content"
# ---------------------------------------------------------------------
# Needs database/seed_sample.sql loaded. Without it these are all empty
# states rather than failures, so the first check says which it is
# instead of reporting eight mysterious misses.

CHAPTERS="$(req anon "$BASE/chapters")"

case "$CHAPTERS" in
  *"Chapter 2"*)
    ok "chapter index lists chapters"

    check "chapter page renders"      200 "$(status anon /chapter/2)"
    check "verse page renders"        200 "$(status anon /chapter/2/verse/47)"
    check "an absent chapter is 404"  404 "$(status anon /chapter/99)"
    check "an absent verse is 404"    404 "$(status anon /chapter/2/verse/999)"

    VERSE="$(req anon "$BASE/chapter/2/verse/47")"
    contains "  the Sanskrit is marked lang=sa" 'lang="sa"' "$VERSE"
    contains "  the translation is present"     'The work is yours' "$VERSE"
    contains "  modern examples are shown"      'example__lesson' "$VERSE"

    # Study mode adds the word-by-word gloss; Learn mode must not.
    contains "study mode adds the word gloss" 'class="glossary"' "$(req anon "$BASE/chapter/2/verse/47?mode=study")"
    absent   "learn mode leaves it out"       'class="glossary"' "$VERSE"

    # A stale or invented mode must open the page, not break it.
    check "an unknown reading mode still renders" 200 "$(status anon '/chapter/2/verse/47?mode=nonsense')"

    contains "the path shows a current node" 'is-current' "$(req anon "$BASE/")"
    contains "life problems are listed"      'problem/anger' "$(req anon "$BASE/problems")"

    PROBLEM="$(req anon "$BASE/problem/anger")"
    contains "a problem page carries the disclaimer" 'not therapy' "$PROBLEM"
    contains "  and leads with an example"           'class="card example"' "$PROBLEM"

    # A topic reached through the wrong door redirects rather than
    # rendering two URLs with the same content.
    check "a concept under /problem redirects" 301 "$(status anon /problem/desire)"
    check "a life problem under /topic redirects" 301 "$(status anon /topic/anger)"

    # Reading and saving are open to guests. This is the product's
    # central promise and the easiest thing to break by adding one
    # middleware.
    VID="$(printf '%s' "$VERSE" | grep -oE 'action="/verse/[0-9]+/read"' | head -1 | grep -oE '[0-9]+')"
    if [ -n "$VID" ]; then
      T="$(token anon '/chapter/2/verse/47')"
      req anon -o /dev/null -X POST --data-urlencode "_csrf=$T" \
        --data-urlencode "return=/chapter/2/verse/47" "$BASE/verse/$VID/read"
      contains "a guest can mark a verse read" 'badge-success' "$(req anon "$BASE/chapter/2/verse/47")"

      T="$(token anon '/chapter/2/verse/47')"
      req anon -o /dev/null -X POST --data-urlencode "_csrf=$T" \
        --data-urlencode "return=/chapter/2/verse/47" "$BASE/verse/$VID/bookmark"
      contains "a guest can save a verse" 'Remove from saved' "$(req anon "$BASE/chapter/2/verse/47")"

      # An unvalidated redirect target is an open redirect, which is a
      # real phishing primitive.
      T="$(token anon '/chapter/2/verse/47')"
      LOC="$(req anon -o /dev/null -D- -X POST --data-urlencode "_csrf=$T" \
             --data-urlencode "return=//evil.example/x" "$BASE/verse/$VID/bookmark" | grep -i '^location:')"
      case "$LOC" in
        *evil.example*) bad "an off-site return is refused" "a local path" "$LOC" ;;
        *)              ok  "an off-site return is refused" ;;
      esac
    else
      bad "a guest can mark a verse read" "a verse id in the form" "none found"
    fi
    ;;
  *)
    printf '  \033[33m—\033[0m %s\n' "no content seeded — load database/seed_sample.sql to test this section"
    ;;
esac

# ---------------------------------------------------------------------
head_ "11. Your own data"
# ---------------------------------------------------------------------

check "the profile page is open to guests" 200 "$(status anon /profile)"

EXPORT_H="$(req anon -o /tmp/vv-export.$$ -D- "$BASE/profile/export")"
contains "the export downloads as JSON" 'application/json'  "$EXPORT_H"
contains "  as an attachment"           'attachment;'       "$EXPORT_H"
contains "  and is never cached"        'no-store'          "$EXPORT_H"

EXPORT_BODY="$(cat /tmp/vv-export.$$ 2>/dev/null)"
rm -f /tmp/vv-export.$$
contains "  it is real JSON"            '"bookmarks"'       "$EXPORT_BODY"
absent   "  it leaks no password hash"  'password_hash'     "$EXPORT_BODY"
absent   "  it leaks no recovery hash"  'recovery_code_hash' "$EXPORT_BODY"

# Deletion is POST-only and behind the auth middleware. A GET must not
# reach it at all — an account deletion that can be triggered by a URL
# is one <img> tag away from being triggered by somebody else's page.
check "account deletion refuses GET" 405 "$(status anon /profile/delete)"

# ---------------------------------------------------------------------
head_ "12. Brute force"
# ---------------------------------------------------------------------

T="$(token main /)"
req main -o /dev/null -X POST --data-urlencode "_csrf=$T" "$BASE/logout"

LOCKED=""
for i in 1 2 3 4 5 6; do
  T="$(token main /login)"
  req main -o /dev/null -X POST \
    --data-urlencode "_csrf=$T" --data-urlencode "email=$EMAIL" --data-urlencode "password=wrong$i" \
    "$BASE/login"
  PAGE="$(req main "$BASE/login")"
  case "$PAGE" in *"Too many attempts"*) LOCKED="$i"; break ;; esac
done

if [ -n "$LOCKED" ]; then ok "locked out after $LOCKED wrong passwords"
else bad "lockout after repeated wrong passwords" "a lockout by attempt 6" "never locked"; fi

T="$(token main /login)"
req main -o /dev/null -X POST \
  --data-urlencode "_csrf=$T" --data-urlencode "email=$EMAIL" --data-urlencode "password=$NEWPASSWORD" \
  "$BASE/login"
contains "the correct password is still refused while locked" "Sign in" "$(req main "$BASE/")"

# ---------------------------------------------------------------------
head_ "Result"
# ---------------------------------------------------------------------

printf '\n  %d passed, %d failed\n\n' "$PASS" "$FAIL"

if [ "$FAIL" -gt 0 ]; then
  echo "  Something is broken. Check htdocs/storage/logs/ for detail."
  exit 1
fi

echo "  Everything that can be checked without a browser is working."
echo "  Run php tools/dev-reset.php before the next run to clear the counters."
exit 0
