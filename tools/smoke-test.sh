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

    # THE EXPLANATION FALLBACK
    #   Not every verse has all three depths written. Without the
    #   fallback in VerseRepository::explanation(), a verse missing the
    #   requested depth renders an EMPTY explanation section — a page
    #   that looks broken rather than unfinished, and no way for the
    #   reader to discover that the writing exists at another depth.
    #
    #   THIS ASSERTION USED TO POINT AT 2.50 AT BEGINNER DEPTH, AND WENT
    #   VACUOUS WHEN 2.50 GOT A BEGINNER EXPLANATION. Every curated
    #   verse now has one, so asking for beginner can no longer exercise
    #   the fallback anywhere. It asks for ADVANCED on 2.14 instead —
    #   2.14 has beginner only, and beginner is where advanced falls
    #   back to. Keep this pointed at a depth that genuinely does not
    #   exist; if 2.14 ever gains an advanced explanation, move it.
    contains "a missing depth falls back instead of rendering empty" \
      '<h3>What was happening</h3>' \
      "$(req anon "$BASE/chapter/2/verse/14?level=advanced")"

    # CHAPTER 3, AND THE ONE SENTENCE IN IT THAT IS NOT OPTIONAL
    #   3.35 has been used for centuries to argue that the circumstances
    #   of somebody's birth are their duty. The explanation refuses that
    #   reading in as many words. If a future edit softens or drops that
    #   sentence, the verse quietly becomes a defence of something the
    #   rest of the chapter argues against — so it is asserted here
    #   rather than left to a reviewer to notice.
    if [ "$(status anon /chapter/3/verse/35)" = "200" ]; then
      contains "3.35 refuses the birth reading in as many words" \
        'ties svadharma to birth' \
        "$(req anon "$BASE/chapter/3/verse/35")"
      contains "  and the word gloss says so too" \
        'not &quot;inherited&quot;' \
        "$(req anon "$BASE/chapter/3/verse/35?mode=study")"
    else
      printf '  \033[33m—\033[0m %s\n' "chapter 3 not seeded — load database/seed_ch03.sql to test 3.35"
    fi

    # CHAPTER 12, AND THE TWO THINGS IT IS NOT ALLOWED TO LOSE
    #   Chapter 12 is the devotional chapter, and the honest handling of
    #   that has one load-bearing sentence: the 12.13 explanation says
    #   who the chapter is addressed to AND says the reader does not
    #   have to share it. Drop either half and the chapter either
    #   misrepresents itself or excludes most of its audience.
    #
    #   12.16's "sarvārambha-parityāgī" is the second. Left unglossed it
    #   reads as "give up all work", which contradicts chapter 3
    #   outright. The gloss has to keep saying that ārambha is the
    #   launching and not the work.
    if [ "$(status anon /chapter/12/verse/13)" = "200" ]; then
      V1213="$(req anon "$BASE/chapter/12/verse/13")"
      contains "12.13 names who the chapter is addressed to" \
        'addressed to somebody who has or wants' "$V1213"
      contains "  and says the reader need not share it" \
        'does not require you to share it' "$V1213"
      contains "12.16 glosses sarvarambha as the launching, not the work" \
        'not the work' \
        "$(req anon "$BASE/chapter/12/verse/16?mode=study")"
    else
      printf '  \033[33m—\033[0m %s\n' "chapter 12 not seeded — load database/seed_ch12.sql to test 12.13 and 12.16"
    fi

    # CHAPTER 16 — THE ONE THAT CAN BE TURNED INTO A WEAPON
    #   16.1 to 16.4 name two sets of qualities. Read as a taxonomy of
    #   PERSONS the chapter hands anybody a vocabulary for deciding that
    #   some people are a different kind of thing, and that vocabulary
    #   has been used against communities in living memory.
    #
    #   Three sentences hold the line and all three are asserted here:
    #   16.4 says the chapter describes directions and not kinds of
    #   person; 16.5 says the text itself takes the chapter out of the
    #   reader's hand by reassuring the listener before assessing him;
    #   and the word gloss on asura refuses the "species" reading that
    #   makes the whole misuse possible.
    #
    #   If any of these three fails, do not "fix the test". The content
    #   has drifted and the chapter is no longer safe to ship.
    if [ "$(status anon /chapter/16/verse/5)" = "200" ]; then
      contains "16.4 says directions, not kinds of person" \
        'not two kinds of person' \
        "$(req anon "$BASE/chapter/16/verse/4")"
      contains "16.5 keeps the line that disarms the chapter" \
        'takes it out of the reader' \
        "$(req anon "$BASE/chapter/16/verse/5")"
      contains "  and the asura gloss refuses the species reading" \
        'Not a species, not a kind of person' \
        "$(req anon "$BASE/chapter/16/verse/4?mode=study")"
    else
      printf '  \033[33m—\033[0m %s\n' "chapter 16 not seeded — load database/seed_ch16.sql to test 16.4 and 16.5"
    fi

    # CHAPTER 18, AND THE SENTENCE THE PRODUCT RESTS ON
    #   18.63 is the last thing said before the closing exchange: I have
    #   told you all of it, think it over completely, then do as you
    #   wish. Not obey. Not accept. Do as you wish.
    #
    #   That line is why this product can teach the text to somebody
    #   with no background and no belief without either side pretending.
    #   It is asserted here not because anybody is likely to attack it,
    #   but because it is the sentence everything else leans on and it
    #   should not be able to drift out quietly.
    if [ "$(status anon /chapter/18/verse/63)" = "200" ]; then
      contains "18.63 hands the decision back to the reader" \
        'hands the decision back' \
        "$(req anon "$BASE/chapter/18/verse/63")"
      contains "  and the gloss keeps 'do', not 'obey'" \
        'Not obey, not follow, not surrender' \
        "$(req anon "$BASE/chapter/18/verse/63?mode=study")"
    else
      printf '  \033[33m—\033[0m %s\n' "chapter 18 not seeded — load database/seed_ch18.sql to test 18.63"
    fi

    # CHAPTER 6 — TWO WELLBEING SAFEGUARDS RATHER THAN TWO MISUSES
    #   6.5 says a person can lift themselves and can let themselves
    #   sink. Handed to somebody who is depressed that reads as "your
    #   suffering is your own fault", which is not in the line. The
    #   explanation separates leverage from blame and says out loud that
    #   this is not a reason to stop asking anybody else for help.
    #
    #   6.17 asks for measure in eating and sleeping, which somebody
    #   already restricting can read as permission. The defence is the
    #   verse before it, which rules out BOTH extremes by name, and the
    #   gloss on yukta, which says fitted rather than minimal.
    #
    #   Both are asserted on the DEFAULT render, because the default is
    #   what a reader in either situation actually lands on.
    if [ "$(status anon /chapter/6/verse/5)" = "200" ]; then
      contains "6.5 separates leverage from blame" \
        'not a claim about blame' \
        "$(req anon "$BASE/chapter/6/verse/5")"
      contains "  and does not tell anybody to do it alone" \
        'asking anybody else for a rope' \
        "$(req anon "$BASE/chapter/6/verse/5")"
      contains "6.17 keeps both extremes, not just the one" \
        'not for the one who does not eat' \
        "$(req anon "$BASE/chapter/6/verse/17")"
      contains "  and the yukta gloss says fitted, not minimal" \
        'not &quot;restrained&quot; and not &quot;minimal&quot;' \
        "$(req anon "$BASE/chapter/6/verse/17?mode=study")"
    else
      printf '  \033[33m—\033[0m %s\n' "chapter 6 not seeded — load database/seed_ch06.sql to test 6.5 and 6.17"
    fi

    # CHAPTER 5 — THE LEVELLING VERSE, GUARDED FROM BOTH SIDES
    #   5.18 puts the most respected figure in that society and the
    #   most despised one in a single line and refuses to rank them.
    #   There are two ways to spoil it and the explanation refuses
    #   both, so both are asserted here.
    #
    #   The first: sanding the word down. Śvapāka was a term of
    #   contempt aimed at people that society pushed to its bottom.
    #   Translating it into something neutral hides what the verse is
    #   doing, so the explanation says the word is not softened, and
    #   the gloss says what it meant and that it must not be used as a
    #   name now.
    #
    #   The second: turning it into a boast. The same book contains
    #   4.13, and quoting 5.18 as proof the tradition was always
    #   egalitarian is the same move as quoting 4.13 for the opposite,
    #   run backwards. The explanation says so in as many words.
    #
    #   5.22 has a smaller trap: "the wise one does not dwell in them"
    #   read as an argument for joylessness. The defence is the gloss
    #   on ramate, which rules out "does not touch" and "does not
    #   enjoy" by name.
    #
    #   Asserted on the DEFAULT render, not at a named level, because
    #   the safeguards have to survive somebody adding a deeper
    #   explanation row later.
    if [ "$(status anon /chapter/5/verse/18)" = "200" ]; then
      contains "5.18 does not sand the word down" \
        'not softened here' \
        "$(req anon "$BASE/chapter/5/verse/18")"
      contains "  and does not turn the verse into a boast" \
        'run backwards' \
        "$(req anon "$BASE/chapter/5/verse/18")"
      contains "  and the gloss refuses the word as a name" \
        'must not be used as one now' \
        "$(req anon "$BASE/chapter/5/verse/18?mode=study")"
      contains "5.22 is not an argument for joylessness" \
        'does not take up residence' \
        "$(req anon "$BASE/chapter/5/verse/22")"
      contains "  and the ramate gloss rules out both misreadings" \
        'Not &quot;does not touch&quot; and not &quot;does not enjoy&quot;' \
        "$(req anon "$BASE/chapter/5/verse/22?mode=study")"
      contains "5.23 glosses vega as a surge with an end" \
        'Not a state and not a temperament' \
        "$(req anon "$BASE/chapter/5/verse/23?mode=study")"
    else
      printf '  \033[33m—\033[0m %s\n' "chapter 5 not seeded — load database/seed_ch05.sql to test 5.18 and 5.22"
    fi

    # CHAPTER 1 — THE ONE PLACE A READER IN TROUBLE MAY LAND FIRST
    #   Chapter 1 is Arjuna's collapse, and it is published and marked
    #   beginner, so it sits at the top of the chapter list where a
    #   browsing reader meets it before anything else. Three sets of
    #   sentences do the work and all three are asserted on the DEFAULT
    #   render, because the default is what that reader gets.
    #
    #   1.28 to 1.30 describe an acute stress response with unusual
    #   precision, and the temptation is to say so and stop. The
    #   explanation says this is one man on one afternoon, that it is
    #   not a claim about anybody's body now, and that the book is not
    #   treatment.
    #
    #   1.46 is "it would be better if they killed me, unarmed and not
    #   resisting", and it is the most carefully written page in the
    #   corpus. Three things have to survive on it: the line is not
    #   softened, the text does not agree with it (nothing in seventeen
    #   chapters returns to it — what happens next is that somebody
    #   stays), and if the sentence is live for the reader then what
    #   helps is a person and not a chapter. All three are asserted, and
    #   none of them may be edited out to make the page shorter.
    #
    #   1.47 is the evidence that the book does not despise the
    #   collapse: Sanjaya reports the sitting, the bow and the grief and
    #   uses no word for weakness anywhere.
    if [ "$(status anon /chapter/1/verse/46)" = "200" ]; then
      contains "1.28 describes rather than diagnoses" \
        'this book is not treatment' \
        "$(req anon "$BASE/chapter/1/verse/28")"
      contains "1.46 records the sentence without agreeing with it" \
        'the text does not agree with it' \
        "$(req anon "$BASE/chapter/1/verse/46")"
      contains "  and what happens next is that somebody stays" \
        'somebody stays and keeps talking to him' \
        "$(req anon "$BASE/chapter/1/verse/46")"
      contains "  and it points at a person, not at a chapter" \
        'what helps is a person and not a chapter' \
        "$(req anon "$BASE/chapter/1/verse/46")"
      contains "  and the ksemataram gloss keeps it a comparison" \
        'It is not a request and not a threat' \
        "$(req anon "$BASE/chapter/1/verse/46?mode=study")"
      contains "1.47 records the collapse without contempt" \
        'nobody in the text calls him weak' \
        "$(req anon "$BASE/chapter/1/verse/47")"
      contains "  and the gloss says the word is absent from the verse" \
        'no word for weak, cowardly, unmanly or unbecoming' \
        "$(req anon "$BASE/chapter/1/verse/47?mode=study")"
      # The exact count is deliberate rather than brittle-by-accident.
      # It catches the original bug (a published chapter with nothing in
      # it) AND a partial load. Update the number when chapter 1 grows;
      # it went 8 -> 9 when 1.41 was written.
      contains "chapter 1 is no longer an empty published chapter" \
        '9 verses' \
        "$(req anon "$BASE/chapter/1")"
    else
      printf '  \033[33m—\033[0m %s\n' "chapter 1 not seeded — load database/seed_ch01.sql to test 1.46 and 1.47"
    fi

    # CHAPTER 17 — THREE CARE-VERSES, ALL POINTING AT THE READER
    #   17.2 says shraddha is svabhava-ja, born of one's own nature.
    #   Read as "determined by birth" that is 4.13 again, and the rest
    #   of the chapter makes the reading impossible because every test
    #   it gives is behavioural. The explanation says so outright.
    #
    #   17.7 is 6.17 with sharper teeth: a verse that sorts food, in a
    #   product somebody with a disordered relationship to eating will
    #   read. The defence is that the chapter sorts by WHAT FOOD DOES
    #   and never by how much — no amount appears in the Sanskrit or
    #   anywhere in seed_ch17.sql — and that the chapter closes the door
    #   itself twelve verses later.
    #
    #   17.19 is that door and it is the strongest wellbeing sentence in
    #   the corpus: practice undertaken by hurting yourself is named and
    #   put in the bottom category by the text. The explanation says the
    #   problem is the category and not the severity, and the gloss on
    #   pidaya says the wrongness is in the hurting and not the amount.
    #   A gentler regimen is NOT what this verse asks for.
    if [ "$(status anon /chapter/17/verse/19)" = "200" ]; then
      contains "17.2 keeps svabhava-ja away from birth" \
        'does NOT mean determined by birth' \
        "$(req anon "$BASE/chapter/17/verse/2")"
      contains "17.7 is not a diet and not a rule" \
        'Nothing here is a diet and nothing here is a rule' \
        "$(req anon "$BASE/chapter/17/verse/7")"
      contains "17.19 says the category is wrong, not the dose" \
        'it is that this is the wrong category of thing' \
        "$(req anon "$BASE/chapter/17/verse/19")"
      contains "  and the pidaya gloss puts it in the hurting" \
        'and NOT in the amount' \
        "$(req anon "$BASE/chapter/17/verse/19?mode=study")"
      contains "17.16 puts gentleness on the list and severity nowhere" \
        'Severity is not on the list anywhere' \
        "$(req anon "$BASE/chapter/17/verse/16")"
    else
      printf '  \033[33m—\033[0m %s\n' "chapter 17 not seeded — load database/seed_ch17.sql to test 17.7 and 17.19"
    fi

    # CHAPTER 14 — A SORTING CHAPTER, WHICH MEANS 16.4 ALL OVER AGAIN
    #   Any chapter that sorts into three can be read as sorting PEOPLE
    #   into three, and somebody has always been willing to call another
    #   person tamasic and mean it about who they are. The refusal here
    #   is stronger than chapter 16's because the chapter argues against
    #   the misreading itself: 14.10 says the three take turns in the
    #   same person, so a quality that alternates inside an afternoon
    #   cannot be an identity.
    #
    #   14.8 is the verse that can hurt somebody. Tamas is listed with
    #   heedlessness, indolence and sleep, and handed to an exhausted
    #   reader that is the book calling their state the lowest quality
    #   of being. The defence is the definition, which comes FIRST:
    #   ajnana-ja, born of not-seeing. Somebody exhausted can see
    #   perfectly well what is happening to them. Rest is not on trial
    #   anywhere in this chapter and 6.17 is cross-referenced to prove
    #   it.
    #
    #   14.23 turns on a suffix. udasina-VAT, LIKE one uninvolved — the
    #   same construction as shatru-vat in 6.6. Drop the suffix and the
    #   verse becomes a licence to stop caring about people, which it is
    #   not, and chapter 12 describes the same person as friendly to
    #   every being.
    if [ "$(status anon /chapter/14/verse/8)" = "200" ]; then
      contains "14.5 keeps the gunas as states, not as people" \
        'settings that take turns, not kinds of person' \
        "$(req anon "$BASE/chapter/14/verse/5")"
      contains "14.8 separates not-seeing from being tired" \
        'being tired is not what this verse is describing' \
        "$(req anon "$BASE/chapter/14/verse/8")"
      contains "  and the ajnana-ja gloss says so too" \
        'which is not the same as being tired' \
        "$(req anon "$BASE/chapter/14/verse/8?mode=study")"
      contains "14.23 is not a licence to stop caring" \
        'licence to stop caring about anybody' \
        "$(req anon "$BASE/chapter/14/verse/23")"
      contains "  and the udasina-vat gloss keeps the suffix" \
        'Drop the suffix and the verse becomes a licence' \
        "$(req anon "$BASE/chapter/14/verse/23?mode=study")"
      contains "14.6 says the clear setting binds too" \
        'said of the good one' \
        "$(req anon "$BASE/chapter/14/verse/6?mode=study")"
    else
      printf '  \033[33m—\033[0m %s\n' "chapter 14 not seeded — load database/seed_ch14.sql to test 14.8 and 14.23"
    fi

    # CHAPTER 13 — THE MOST MISUSABLE IDEA IN THE BOOK
    #   "You are not this, you are the one watching it." Handed to
    #   somebody in pain, grieving, or already feeling unreal, that is
    #   not wisdom — it is an exit, and unlike caste or gender nobody
    #   has to be arguing in bad faith for the harm to happen. The
    #   reader does it to themselves and it feels like progress.
    #
    #   The chapter defends against this itself in three places, and the
    #   explanations quote the text rather than arguing alongside it:
    #
    #   13.6 puts cetana — AWARENESS — on the list of what the field
    #   contains. If awareness is among the things observed then the
    #   watcher is not a place a person can climb into, and any practice
    #   that consists of climbing into it has misread the verse that
    #   defines it.
    #
    #   13.29 is the chapter's own wellbeing line: na hinasty atmana
    #   atmanam, he does not injure the self by the self. Same
    #   construction as 6.5. The claim is that this seeing produces LESS
    #   self-harm, so any reading of 13.2 or 13.32 that leaves somebody
    #   further from themselves is contradicted by the same chapter.
    #
    #   13.32 can go wrong in two directions at once and both are
    #   asserted. Not stained means not coloured by — the 5.10 leaf sits
    #   in the water all day — so it is not an instruction to stop
    #   feeling things. And it is not moral licence either.
    if [ "$(status anon /chapter/13/verse/29)" = "200" ]; then
      contains "13.6 keeps the witness out of reach as a hiding place" \
        'the watcher is not a place a person can go and sit' \
        "$(req anon "$BASE/chapter/13/verse/6")"
      contains "  and the cetana gloss says why" \
        'awareness is among the things being watched' \
        "$(req anon "$BASE/chapter/13/verse/6?mode=study")"
      contains "13.29 says the seeing produces less self-harm" \
        'it produces LESS self-harm' \
        "$(req anon "$BASE/chapter/13/verse/29")"
      contains "13.32 is not an instruction to stop feeling things" \
        'is not a technique. It will not work' \
        "$(req anon "$BASE/chapter/13/verse/32")"
      contains "  and it is not moral licence either" \
        'nothing attaches to me, so nothing I do matters' \
        "$(req anon "$BASE/chapter/13/verse/32")"
      contains "  and the lipyate gloss keeps touched and soaked apart" \
        'It does not mean not touched and it does not mean not felt' \
        "$(req anon "$BASE/chapter/13/verse/32?mode=study")"
    else
      printf '  \033[33m—\033[0m %s\n' "chapter 13 not seeded — load database/seed_ch13.sql to test 13.6 and 13.29"
    fi

    # CHAPTER 4 AND 1.41 — THE PASSAGES THIS PROJECT DEFERRED
    #   4.13 is the most consequential sentence in the book, not for
    #   what it says but for what it was used to do. FOUR things are
    #   true and leaving any one out produces a dishonest page, so all
    #   four are asserted:
    #     1. the criterion the verse states is quality and action, and
    #        the Sanskrit word for birth is not in the line
    #     2. it was read as birth anyway, for centuries, by people with
    #        authority, and that reading did real damage
    #     3. the book does not settle it — 18.41 supports the hereditary
    #        reading, 5.18 and 13.27 pull hard against it
    #     4. the second half withdraws the verse's own authorship claim
    #   A page that keeps only 1 is doing the same thing as a page that
    #   keeps only 2: picking the comfortable half.
    #
    #   4.8 is the licence verse. Every verb in it is first person, so
    #   it instructs nobody, and the strongest evidence is that Arjuna
    #   asked directly for a reason to fight and was never given it.
    #
    #   1.41 is the worst sentence in the book on gender and caste at
    #   once. It is recorded, not softened, framed by 1.31 where the
    #   chapter already said his reasons arrived after his legs gave
    #   way — and the explanation says out loud that this describes the
    #   sentence and does NOT excuse it. Nothing in the seventeen
    #   chapters that follow takes it up.
    if [ "$(status anon /chapter/4/verse/13)" = "200" ]; then
      contains "4.13 states a criterion that is not birth" \
        'it is not birth' \
        "$(req anon "$BASE/chapter/4/verse/13")"
      contains "  and admits it was read as birth anyway" \
        'read as birth anyway, for centuries' \
        "$(req anon "$BASE/chapter/4/verse/13")"
      contains "  and does not pretend the book settles it" \
        'the book does not settle this' \
        "$(req anon "$BASE/chapter/4/verse/13")"
      contains "  and keeps the half that withdraws the claim" \
        'withdraws its own claim' \
        "$(req anon "$BASE/chapter/4/verse/13")"
      contains "  and the guna-karma gloss says the word is absent" \
        'does not appear anywhere in the line' \
        "$(req anon "$BASE/chapter/4/verse/13?mode=study")"
      contains "4.8 licenses nobody" \
        'every verb in it is first person' \
        "$(req anon "$BASE/chapter/4/verse/8")"
    else
      printf '  \033[33m—\033[0m %s\n' "chapter 4 not seeded — load database/seed_ch04.sql to test 4.13 and 4.8"
    fi

    if [ "$(status anon /chapter/1/verse/41)" = "200" ]; then
      contains "1.41 is named for what it is" \
        'worst sentence in the book' \
        "$(req anon "$BASE/chapter/1/verse/41")"
      contains "  and the frame is not offered as an excuse" \
        'is NOT a defence of it' \
        "$(req anon "$BASE/chapter/1/verse/41")"
      contains "  and the book never takes the claim up" \
        'never granted, never returned to' \
        "$(req anon "$BASE/chapter/1/verse/41")"
      contains "  and the varna-sankara gloss says what it was for" \
        'the stated reason for controlling women' \
        "$(req anon "$BASE/chapter/1/verse/41?mode=study")"
    else
      printf '  \033[33m—\033[0m %s\n' "1.41 not seeded — reload database/seed_ch01.sql"
    fi

    contains "the path shows a current node" 'is-current' "$(req anon "$BASE/")"

    # CHAPTER 1 IS ON EVERY TRACK, NOT ONLY ON ADVANCED
    #   It used to sit in the advanced track alone, on the editorial
    #   judgement that the collapse reads better once you know what the
    #   argument is. That judgement stands and chapter 1 is still second
    #   to last. What was wrong was it being ABSENT from beginner and
    #   intermediate: the chapter list shows chapter 1 first, badged
    #   Beginner, so a reader could open it and then never meet it again
    #   on their own path. Asserted on the guest home page, which is the
    #   beginner track.
    contains "chapter 1 is on the beginner path" \
      'href="/chapter/1/verse/28"' \
      "$(req anon "$BASE/")"
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
