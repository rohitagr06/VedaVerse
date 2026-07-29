# Testing VedaVerse — Steps 1 to 5

**One session, start to finish.** Follow this top to bottom and you will have
exercised everything built so far. It takes about 25 minutes the first time and
about 5 minutes on every run after that.

`docs/LOCAL_TESTING.md` is the reference manual — every setting explained, every
error message with its cause. **This file is the runbook.** When something here
fails, that file is where the answer is.

---

## Contents

1. [Before you start](#1-before-you-start)
2. [Start the two things that must be running](#2-start-the-two-things-that-must-be-running)
3. [The four automated checks](#3-the-four-automated-checks)
4. [What you check by hand](#4-what-you-check-by-hand)
5. [The full checklist](#5-the-full-checklist)
6. [When something fails](#6-when-something-fails)

---

## 1. Before you start

Open Terminal and run all four of these. They should all answer.

```bash
cd ~/Claude/Projects/Gita/RC1

php -v                     # 8.5.8 — anything 7.4 or newer is fine
git status --short          # shows what has changed since the last commit
ls htdocs/app/config/local.php   # must exist; if not, see step 2.3
ls htdocs/app/config/strings/    # 8 files — this is Step 4
```

`htdocs/app/config/strings/` should list eight files: `admin.php`, `auth.php`,
`common.php`, `community.php`, `content.php`, `errors.php`, `index.php`,
`learning.php`. If that directory is missing, the Step 4 files did not arrive
and nothing below will work.

**Your local database, for reference:** host `127.0.0.1`, database
`vedaverse_db`, user `vedaverse`. It is MariaDB 10.4.28 from XAMPP, not the
Homebrew one — the Homebrew MariaDB stays stopped, permanently, because both
want port 3306 and only one can have it.

**Fonts are not installed** (`htdocs/assets/fonts/` has only `README.md`). The
site falls back to the system stack and looks reasonable. The one thing that
genuinely suffers is the Sanskrit shloka. Fetching them takes about five
minutes and the README explains how — worth doing before you judge the
typography, not needed for any test below.

---

## 2. Start the two things that must be running

### 2.1 The database

XAMPP's MariaDB. If you have XAMPP's control panel open, start MySQL there.
From Terminal:

```bash
sudo /Applications/XAMPP/xamppfiles/bin/mysql.server start
```

Check it answers. **The `--skip-ssl` is required** — your MariaDB *client* is
version 15.2 and demands TLS when a password is given, but the 10.4 *server*
has none. This affects the command line only; PHP connects fine either way.

```bash
mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p -e "SELECT VERSION(); SHOW DATABASES;"
```

You want `10.4.28-MariaDB` and `vedaverse_db` in the list.

### 2.2 The web server

PHP's built-in server, in its own Terminal tab. **Leave it running** for
everything below.

```bash
cd ~/Claude/Projects/Gita/RC1
php -S 127.0.0.1:8080 -t htdocs tools/dev-router.php
```

The router file is not optional. The built-in server ignores `.htaccess`, so
without it every URL except `/` returns 404.

Open <http://127.0.0.1:8080/health> in a browser. You want:

```json
{"ok":true,"checks":{"database":true,"cache":true,"writable_logs":true}}
```

That one URL proves the whole stack boots: autoloading, config, the database
connection, the cache, the router and the response.

### 2.3 Only if `/health` says the site is not configured

The installer has not run, or `local.php` was deleted. Start clean:

```bash
mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db < htdocs/database/DROP_ALL.sql
rm -f htdocs/app/config/local.php
```

Then open <http://127.0.0.1:8080/install.php> and work through the five
screens. Use host `127.0.0.1`, database `vedaverse_db`, user `vedaverse`.

**Write the recovery code down when it appears.** It is shown once and stored
only as a hash. Nobody can look it up afterwards, including you.

Do **not** click "delete the installer" on a local install — you will want it
again.

### 2.4 Load the sample content — Step 5 onwards

Five fully-written verses, so the content pages have something real in them.
Without this every page Step 5 built renders an empty state.

```bash
mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
    < htdocs/database/seed_sample.sql

# Step 6, chapter 2 batch A — run AFTER seed_sample.sql
mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
    < htdocs/database/seed_ch02.sql

# Step 6, chapter 3 — also AFTER seed_sample.sql
mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
    < htdocs/database/seed_ch03.sql

# Step 6, chapter 12 — also AFTER seed_sample.sql
mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
    < htdocs/database/seed_ch12.sql

# Step 6, chapter 16 — also AFTER seed_sample.sql
mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
    < htdocs/database/seed_ch16.sql

# Step 6, chapter 18 — also AFTER seed_sample.sql. Completes the beginner track.
mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
    < htdocs/database/seed_ch18.sql
```

All six are safe to re-run — they update rather than duplicating.
Together they add all 18 chapters, 14 topics and their graph, and
**forty-four fully-written verses** with word meanings, explanations, 139
modern examples, memory hooks, reflections, practices and cross-references,
all in three languages: chapter 2 verses 13, 14, 20, 22, 23, 27, 47, 48, 50,
62, 63 and 70; chapter 3 verses 5, 8, 16, 19, 21, 27, 35 and 37; chapter 12
verses 5, 8, 12, 13, 15, 16, 18 and 19; chapter 16 verses 1, 3, 4, 5, 10, 13,
16 and 21; and chapter 18 verses 11, 14, 16, 32, 37, 48, 59 and 63.

**That is the whole beginner track.** `/` now renders eleven clusters across
five chapters, and a reader who works through it meets the argument of the
book from 2.13 to 18.63 without a gap.

Order matters. The five chapter files all join to the chapters and topics
that `seed_sample.sql` creates, so running any of them first inserts nothing
and reports no error.

Step 6 adds the other 64 verses — the intermediate and advanced tracks, plus
chapter 2 batch B. Nothing in these files gets thrown away.

## The verses the suite guards

Seven sentences across five verses. Six of them refuse a specific misreading
that the verse has a documented history of being put to; the seventh, on
18.63, is there for the opposite reason — it is the sentence the product's
whole stance rests on. `smoke-test.sh` asserts every one of them by literal
string. **If one of those checks ever fails, find out what changed in the
content — do not update the expected string.**

**3.35** — "better your own dharma than another's" — has been used for
centuries to tell people that the circumstances of their birth are their
duty. Its explanation refuses that reading in as many words, and the word
gloss on `svadharma` says the word means *own*, not *inherited*.

**12.13** opens the devotional chapter's portrait of the person its god calls
dear. Its explanation says both halves of an awkward thing once, plainly:
who the chapter is addressed to, and that the reader does not have to share
that frame to use the list. Nearby, **12.16**'s `sarvārambha-parityāgī` is
glossed as giving up the *launching* and not the work — unglossed it reads
as "stop working", which contradicts chapter 3 outright.

**16.4 and 16.5** are the most important two in the file. Chapter 16 names
two sets of qualities, and read as a taxonomy of *persons* it hands anybody a
vocabulary for deciding that some people are a different kind of thing —
which is a use it has been put to, against communities, in living memory.
The 16.4 explanation says the chapter describes two directions a person can
face and not two kinds of person. The 16.5 explanation shows the text doing
that itself: the moment the chapter becomes usable as a weapon, the speaker
turns to the frightened man in front of him and tells him not to grieve,
before any assessment of him at all. The word gloss on `asura` refuses the
"species" reading that makes the whole misuse possible.

Nothing anywhere in `seed_ch16.sql` — not an example, not a reflection, not
a gloss — maps either list onto a group, a profession, a party, a region or
a community. Two of the examples show the same person facing both directions
inside one week. That is the reading the chapter supports and it is the
strongest available answer to the other one.

**18.63** is the last verse of the beginner track and the one the product
leans on hardest. After seven hundred verses of argument the speaker says: I
have told you all of it, think it over completely, then do as you wish. Not
obey, not accept — do as you wish. That permission is why this text can be
taught to somebody with no background and no belief without either side
pretending, and it is in the book rather than being a modern accommodation.
The explanation says so directly and the word gloss keeps *do*, not *obey*.

---

## 3. The four automated checks

Four commands. All four must pass before Step 5 starts.

```bash
cd ~/Claude/Projects/Gita/RC1

# 1. Nothing has a syntax error, on any PHP version we care about
find htdocs tools -name "*.php" -exec php -l {} \; | grep -v "No syntax errors"

# 2. The string table is complete and consistent          [Step 4]
php tools/check-strings.php

# 3. Every colour pairing still meets WCAG AA              [Step 3]
php tools/check-contrast.php

# 4. The whole HTTP surface works                          [Steps 1-2]
php tools/dev-reset.php && bash tools/smoke-test.sh
```

### What each one should say

**1. Lint** — prints nothing at all. Any output is a failure.

**2. `check-strings.php`**

```
Keys     : 628
  en        628
  hi        628
  hinglish  628

All keys present in all three languages.
Placeholders and plural forms agree across languages.
No duplicate keys, no undefined references.

Clean.
```

It catches five faults, and every one of them reads as perfectly good writing
if you only look at it in one language: a missing translation, a `:placeholder`
that exists in English and not in Hindi, a plural form that exists in one
language and not another, a key defined twice, and a key used in code that
does not exist in the table.

Add `--unused` to also list keys the code does not reference yet. It reports
530 of them today, and that is correct — most of the table was written for
pages Steps 5 to 13 will build. It is never a failure.

**3. `check-contrast.php`** — `All 35 pairings pass WCAG 2.1 AA.` It reads the
real hex values out of `tokens.css`, so it cannot drift out of date. Change a
colour, run this, know.

**4. `smoke-test.sh`** — `90 passed, 0 failed`. It registers a real account,
signs in and out, merges anonymous work, checks the role gate, exercises
account recovery, and confirms the brute-force lockout fires.

**The site has to be running in another tab.** The script checks first and
stops with one plain sentence if it is not — `Nothing is listening on
http://127.0.0.1:8080` — rather than reporting 48 failures whose real cause is
that you closed the server. It does the same for a site that is up but not
installed, and for one whose database is not answering.

`dev-reset.php` must run first. It clears the throttle counters that the
previous run's lockout test deliberately tripped — without it the next run
locks itself out and the last four checks fail for no reason.

### After all four, look at the log

```bash
tail -20 htdocs/storage/logs/vedaverse-*.log
```

`NOTICE 404` lines and `WARNING CSRF check failed` lines are expected — the
smoke test deliberately requests missing pages and posts forms without tokens.
**Anything at ERROR level is a real problem.** Nothing should be there.

---

## 4. What you check by hand

The automated checks prove the machinery works. These four prove the product
is any good, and no tool can do them for you.

### 4.1 The three languages, side by side — Step 4

<http://127.0.0.1:8080/styleguide/strings>

Every interface string in English, Hindi and Hinglish, in three columns,
grouped by area. There are 628 of them.

**Read the Hinglish column out loud, one group at a time.** The test is not
"is this correct Hinglish". It is "would I say this to a friend". Anything
that reads as a translation with the Devanagari swapped for Latin letters is
wrong even when every word in it is right — the entire argument for that
column is that it sounds like a person.

Three worth reading hardest, because each one is what somebody sees at the
moment they are most likely to give up and close the tab:

| Key | The moment |
|---|---|
| `auth.code.warning` | being told that losing this code loses the account, permanently |
| `review.welcome_back` | coming back after three weeks to a review backlog |
| `streak.forgiven` | having missed yesterday after a long run of days |

The Hindi column deserves the same pass. The target is spoken Hindi, not the
Hindi of a government form.

Tell me which ones are wrong and I will rewrite them.

### 4.2 The recovery-code screen — Step 2

Still outstanding from earlier, and it matters more than anything else on this
list. Register a throwaway account at <http://127.0.0.1:8080/register> and read
the screen that follows properly, in all three languages:

```
http://127.0.0.1:8080/register?lang=en
http://127.0.0.1:8080/register?lang=hi
http://127.0.0.1:8080/register?lang=hinglish
```

This is the only place in the entire product where a mistake cannot be
undone by anyone. Somebody who loses their password and this code has lost
their account — there is no email reset, because the host blocks outgoing
mail. The wording has to be blunt enough that a person who is skimming still
stops and writes the code down.

Check that the copy button works and that the code is legible enough to copy
onto paper — it is monospaced and widely spaced for exactly that reason.

### 4.3 Language switching — Step 4

Add `?lang=hi` or `?lang=hinglish` to any URL.

- Devanagari renders as Devanagari, never as `????` and never as boxes.
- View source: `<html lang="hi">` for Hindi, `<html lang="en-IN">` for
  Hinglish. This is what makes a screen reader pronounce Hindi as Hindi
  instead of reading it as mangled English.
- The choice sticks as you click around.
- Signing in applies the account's saved language.

Two behaviours worth confirming from the command line:

```bash
# A Hindi browser gets Hindi with no cookie set
curl -s -H "Accept-Language: hi-IN,hi;q=0.9" http://127.0.0.1:8080/login | grep -o '<html lang="[^"]*"'

# An Indian English browser gets English, NOT Hinglish
curl -s -H "Accept-Language: en-IN,en;q=0.9" http://127.0.0.1:8080/login | grep -o '<html lang="[^"]*"'
```

The second one is deliberate. No browser advertises Hinglish, and guessing that
an Indian visitor wants romanised Hindi would be a guess about a person rather
than about their software. It is offered in the switcher and chosen on purpose.

### 4.4 The design system — Step 3

<http://127.0.0.1:8080/styleguide>

Four things that are tedious to check anywhere else and are all on this one
page:

- **Dark theme** — gear menu, top right. It should look like a designed dark
  theme, not an inverted light one.
- **320px** — narrow the window, or use responsive mode. Nothing overflows
  sideways; tap targets stay at 44px.
- **Keyboard** — press Tab from the very top. "Skip to content" is the first
  stop, every field and link shows a visible focus ring, and the order makes
  sense.
- **The shloka** — कर्मण्येवाधिकारस्ते मा फलेषु कदाचन. If the conjuncts render
  as single joined forms, Devanagari is working. Separate letters with visible
  halant marks between them means a font loaded but its OpenType tables were
  stripped, which is not cosmetic — it makes it a different word. Rectangles
  mean no Devanagari font is available at all, which is what you will see until
  you fetch the fonts.

---

## 5. The full checklist

Everything, in order. Tick as you go.

### Automated — must all pass

| # | Check | Command | Pass looks like |
|---|---|---|---|
| 1 | Syntax | `find htdocs tools -name "*.php" -exec php -l {} \;` | no output |
| 2 | Health | open `/health` | `"ok":true`, all three checks true |
| 3 | Strings | `php tools/check-strings.php` | 628 keys × 3, `Clean.` |
| 4 | Contrast | `php tools/check-contrast.php` | all 35 pairings pass |
| 5 | HTTP surface | `php tools/dev-reset.php && bash tools/smoke-test.sh` | 90 passed, 0 failed |
| 6 | Log | `tail -20 htdocs/storage/logs/vedaverse-*.log` | no ERROR lines |

### By hand — Step 1, the foundation

| # | Check | How |
|---|---|---|
| 7 | 54 tables exist | `mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='vedaverse_db';"` |
| 8 | Devanagari survives the round trip | any Hindi page renders correctly — `????` means a charset mismatch at write time, which is unrecoverable |
| 9 | Error pages are human | open `/nope` — a sentence, not a status code, and no file path anywhere |

### By hand — Step 2, accounts

| # | Check | How |
|---|---|---|
| 10 | Register → recovery code → continue | `/register`, and **write the code down** |
| 11 | The recovery-code screen reads right | §4.2 above, all three languages |
| 12 | Sign out, sign back in | your reading position survives |
| 13 | Recover with the code | `/recover` — the old code stops working and a fresh one is issued |
| 14 | Anonymous merge | bookmark something signed out, then register — it follows you into the account |
| 15 | Role gate | `/admin` redirects when signed out, 403 for an ordinary account |

### By hand — Step 3, design

| # | Check | How |
|---|---|---|
| 16 | Every component | `/styleguide` top to bottom |
| 17 | Dark theme | gear menu → Dark |
| 18 | Follow the system | gear menu → Automatic, then change macOS appearance — the page follows live |
| 19 | Text size | gear menu → the four A's; the whole page scales, not just body copy |
| 20 | 320px | nothing overflows sideways |
| 21 | Keyboard | Tab from the top; skip link first |
| 22 | Reduced motion | System Settings → Accessibility → Display → Reduce motion; the skeleton stops shimmering |
| 23 | Print | Cmd-P on `/styleguide` — no nav, no buttons, links show their URLs |

### By hand — Step 4, language

| # | Check | How |
|---|---|---|
| 24 | The string table, read out loud | `/styleguide/strings` — §4.1 above. **The most valuable half hour in this project so far.** |
| 25 | `?lang=` switching and stickiness | §4.3 above |
| 26 | Browser language detection | the two `curl` commands in §4.3 |
| 27 | Hinglish is never auto-selected | second `curl` returns `en`, not `en-IN` |

### By hand — Step 5, content

Needs `seed_sample.sql` loaded (§2.4).

| # | Check | How |
|---|---|---|
| 28 | The path | open `/` — chapter 2 milestone, two nodes, first marked "You are here" |
| 29 | Marking progress | open 2.47, press "Mark as read" — the button becomes a "Read" badge and the path node fills |
| 30 | Resume | back to `/` — the button now says "Carry on" and names a verse |
| 31 | A verse, fully | `/chapter/2/verse/47` — Sanskrit, transliteration on two lines, translation, explanation, four examples, hook, reflections |
| 32 | Reading modes | the four chips — Study adds word-by-word, Research adds cross-references, One minute strips it back |
| 33 | Explanation depth | "Start simple" / "A bit deeper" — the text changes and the active chip fills |
| 34 | Life problems | `/problem/anger` — disclaimer first, then an example, then verses |
| 35 | The other door | `/topic/the-self` — definition first, then verses. The opposite order, on purpose. |
| 36 | Wrong door | `/topic/anger` redirects 301 to `/problem/anger` |
| 37 | Saving and notes | the buttons under a verse work signed out and survive a reload |
| 38 | Chapters | `/chapters` — 18 cards, chapter 2 outlined as the entry point |
| 39 | Devanagari in the gloss | `/chapter/2/verse/47?lang=hi&mode=study` — conjuncts join in the word list |
| 40 | 320px and keyboard | narrow a verse page to 320px, then Tab from the top |
| 41 | Focus mode | a verse → "Focus" at the foot — header, nav and breadcrumb vanish, the skip link does not |
| 42 | Print | a verse → "Print" then Cmd-P — no chrome, links show their URLs |
| 43 | Your own work | `/profile` signed out — saved verses, notes, recently opened |
| 44 | **Acceptance test 5** | bookmark two verses and write a note signed out, then register — all three are still on `/profile` |
| 45 | Data export | `/profile/export` downloads JSON with your notes in it, and no password hash |
| 46 | Account deletion | `/profile` → "Delete this account" — needs the password *and* the word DELETE |

**`/review` and `/sarathi` in the navigation are expected to 404.** They
arrive in Steps 7 and 9.

**Worth doing by hand, and it is the point of the whole step:** read one
modern example out loud in Hinglish. That register is what the product stands
on, and Step 6 writes a hundred more like it.

---

## 6. When something fails

`docs/LOCAL_TESTING.md` Part 6 has every error message this project has
actually produced, with its real cause. The five that come up most:

| Symptom | Cause |
|---|---|
| `Bootstrap failed: 5` starting Homebrew MariaDB | XAMPP already holds port 3306. Use XAMPP's; leave Homebrew's stopped. |
| `ERROR 2026 TLS/SSL error` | client 15.2 wants TLS, server 10.4 has none. Add `--skip-ssl`. Command line only. |
| `Access denied for 'vedaverse'@'localhost'` | MySQL treats `localhost` and `127.0.0.1` as different hosts. The user needs to exist for both. |
| `Refusing to run: app.env is not 'local'` | `local.php` says `production`. Re-run the installer; it detects a local hostname now and writes `local`. |
| Every page redirects to `/install.php` | `local.php` is missing. §2.3. |
| `/login` is 404 but `/` works | you started `php -S` without `tools/dev-router.php`. |
| Smoke test says `Nothing is listening` | the `php -S` tab was closed or Ctrl-C'd. Start it, leave it running, run the test in a *different* tab. |
| Smoke test says `The database is not answering` | XAMPP's MariaDB is stopped. `sudo /Applications/XAMPP/xamppfiles/bin/mysql.server start` |

Anything not on that list: send me the exact output and the last 20 lines of
`htdocs/storage/logs/vedaverse-*.log`.

---

## Committing, once it all passes

```bash
cd ~/Claude/Projects/Gita/RC1
git status --short
git add -A
git commit -m "Step 4: I18nService, three-language string table, string checker"
git push
```

Fifteen changes are expected: eleven modified files, and four new paths —
`htdocs/app/config/strings/`, `htdocs/app/services/I18nService.php`,
`htdocs/app/views/pages/strings.php` and `tools/check-strings.php`.

`htdocs/app/config/local.php` must never appear in that list. It holds your
database password and `.gitignore` already excludes it — but check, every time.
