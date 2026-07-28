# Testing VedaVerse on your Mac

**Covers the build through Step 2.** This document is updated at the end of every
step, so what it describes is always exactly what exists.

You do not need Docker, a virtual machine, MAMP, or any hosting account. Two
Homebrew packages and one command.

---

## Contents

- [Part 1 — One-time setup](#part-1--one-time-setup) (about fifteen minutes, once)
- [Part 2 — Starting and stopping](#part-2--starting-and-stopping) (two commands, every time)
- [Part 3 — The automated check](#part-3--the-automated-check) (one command, 51 checks)
- [Part 4 — Testing by hand](#part-4--testing-by-hand) (what to click, and what should happen)
- [Part 5 — What cannot be tested locally](#part-5--what-cannot-be-tested-locally)
- [Part 6 — When something goes wrong](#part-6--when-something-goes-wrong)
- [Part 7 — Step-by-step test log](#part-7--step-by-step-test-log)

---

## Part 1 — One-time setup

### 1.1 Install Homebrew, if you do not have it

Open Terminal and run:

```bash
which brew
```

If that prints a path, skip to 1.2. If it prints nothing, install it from
[brew.sh](https://brew.sh) and follow the two lines it prints at the end about
adding Homebrew to your PATH.

### 1.2 Install PHP and MariaDB

macOS has not shipped with PHP since Monterey, so this is genuinely needed.
MariaDB is MySQL — same protocol, same SQL, and it is what most shared hosts
including InfinityFree actually run underneath.

```bash
brew install php mariadb
brew services start mariadb
```

Check both:

```bash
php -v          # expect 8.1 or newer
mariadb --version
```

Homebrew's PHP already includes everything VedaVerse needs: `pdo_mysql`,
`mbstring`, `json` and `gd`. There is nothing to enable.

> **Why MariaDB and not MySQL?** Either works. MariaDB installs more cleanly on
> Apple Silicon and is a drop-in match for what the live host runs. If you
> already have MySQL installed, keep it — every command below works unchanged
> except that you type `mysql` instead of `mariadb`.

### 1.3 Create the database

```bash
mariadb -u root <<'SQL'
CREATE DATABASE IF NOT EXISTS vedaverse_db
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'vedaverse'@'localhost' IDENTIFIED BY 'localdev';
GRANT ALL PRIVILEGES ON vedaverse_db.* TO 'vedaverse'@'localhost';
FLUSH PRIVILEGES;
SQL
```

The `utf8mb4` on the first line is not decoration. Create the database as plain
`utf8` and every Devanagari character you store becomes `????` at write time,
which cannot be repaired afterwards by changing the display.

The password `localdev` is fine because this database is reachable only from
your own machine. Never reuse it anywhere.

### 1.4 Run the installer

From the repository root (`~/Claude/Projects/Gita/RC1`):

```bash
php -S 127.0.0.1:8080 -t htdocs tools/dev-router.php
```

Leave that running and open **http://127.0.0.1:8080/install.php** in a browser.

Five screens. On the database screen enter:

| Field | Value |
|---|---|
| Database host | `127.0.0.1` |
| Database name | `vedaverse_db` |
| Database username | `vedaverse` |
| Database password | `localdev` |

Then create your administrator account. **Do not press the button that deletes
the installer** — locally you will want to re-run it. On the real host you
absolutely do press it.

The installer writes `htdocs/app/config/local.php`, which holds your database
credentials and two generated secrets. It is in `.gitignore` and must never be
committed.

Finally, tell the application it is running locally, so error pages show you
detail instead of hiding it. Open `htdocs/app/config/local.php` and change the
`app` block to:

```php
'app' => array(
    'env'   => 'local',
    'debug' => true,
),
```

`env => 'local'` is also what `tools/dev-reset.php` checks before it will touch
anything, so this line is required for the development tooling to work.

---

## Part 2 — Starting and stopping

Every session, from the repository root:

```bash
brew services start mariadb                              # if it is not already running
php -S 127.0.0.1:8080 -t htdocs tools/dev-router.php
```

Then open **http://127.0.0.1:8080**. Stop the server with `Ctrl-C`.

### Why the router file

PHP's built-in server does not read `.htaccess`, so it knows nothing about the
rewrite rule that sends every unmatched URL to `index.php`. Without
`tools/dev-router.php`, the home page works and `/login` returns 404 — which
looks exactly like a broken router and is not. The router file does in PHP what
the `.htaccess` rewrite does in Apache.

### Starting from a clean slate

```bash
php tools/dev-reset.php
```

Clears the rate-limit counters, the settings cache, the log files, and any
account left behind by the automated check. It refuses to run unless
`app.env` is `local`, so it cannot be pointed at a live site by accident.

To wipe everything and reinstall from scratch:

```bash
mariadb -u vedaverse -plocaldev vedaverse_db < htdocs/database/DROP_ALL.sql
rm htdocs/app/config/local.php
# then re-run install.php in the browser
```

---

## Part 3 — The automated check

```bash
php tools/dev-reset.php
bash tools/smoke-test.sh
```

Fifty-one checks in about ten seconds, each printed as a pass or a fail. It
exits non-zero if anything failed, so you can run it before every commit.

It covers: the health endpoint, every security header, all seven error pages in
three languages, CSRF rejection on all four forms, the password policy, the
honeypot, registration, the one-time recovery code, output escaping, sign-in and
sign-out, session-id regeneration, the role gate, the full recovery-code reset,
and the brute-force lockout.

**Run `dev-reset.php` first.** The brute-force section deliberately trips the
rate limiter, and running twice inside fifteen minutes will otherwise hit the
per-address ceiling and fail later checks. Every account it creates uses the
reserved domain `@vedaverse.test` with a timestamp, so runs never collide and
nothing you made by hand is ever touched.

When something fails, the log has the detail:

```bash
tail -f htdocs/storage/logs/vedaverse-*.log
```

---

## Part 4 — Testing by hand

The automated check proves the machinery works. These are the things that need
eyes — or that are worth seeing once so you know what the product feels like.

### 4.1 The installer

Delete `htdocs/app/config/local.php`, visit any page, and confirm you are sent to
`/install.php`. Then:

- Type a wrong database host. Expect a plain-language explanation, not a PDO
  error, and specifically the one about InfinityFree not using `localhost`.
- Type a wrong password. Expect the note about the username usually starting
  with `if0_`.
- Complete it and watch the tables screen: about seventy-six lines, each with a
  green tick. Re-run it — every line should still pass, because every table is
  created only if missing.
- On the account screen, try the password `password1`. It should be refused as
  one of the most-guessed passwords.

### 4.2 Registration and the recovery code

- **The recovery-code screen is the one that matters.** Register, and read it.
  It should be impossible to misunderstand that losing both the password and
  that code means losing the account. If it reads as boilerplate, it has failed
  at its only job — tell me and I will rewrite it.
- Press the copy button. It should say "Copied". If nothing happens, the CSP
  nonce has broken — check the browser console for a Content-Security-Policy
  error.
- Navigate away and return to `/recovery-code` directly. It should bounce you
  home. The code cannot be viewed twice, by anybody, including an administrator.

### 4.3 The three languages

Add `?lang=hi` or `?lang=hinglish` to any URL.

- Devanagari must render as Devanagari, never as `????` or as boxes.
- View source and check `<html lang="hi">`. This is what makes a screen reader
  pronounce Hindi as Hindi rather than reading it as mangled English.
- Hinglish should read like a person talking, not like a translation. If any
  string reads as cringe, it is worth fixing — that register is the whole reason
  this product can spread.
- The choice should stick as you click around, and an account's saved preference
  should apply on sign-in.

### 4.4 Keyboard and screen reader

Do this once per step. It is quick and it catches things that never show up in
a screenshot.

- Load `/register` and press Tab from the top. A visible focus ring must appear
  on every field and every link, in a sensible order, and the "Skip to content"
  link must appear as the very first stop.
- Submit the form empty. The error summary at the top should list each problem
  as a link that jumps to the field.
- On macOS press `Cmd-F5` to start VoiceOver and Tab through the form. Every
  field should be announced with its label and its hint.

### 4.5 Small screens

In Safari or Chrome, open the responsive design mode and set the width to
**320px** — an iPhone SE, which is still very much in use in India.

Nothing should overflow horizontally, every tap target should be at least 44px
tall, and the recovery code should stay readable rather than spilling out of its
box.

### 4.6 Dark mode

System Settings → Appearance → Dark, then reload. The site follows
`prefers-color-scheme`. It should be a real dark theme, not an inverted light
one. (The full treatment arrives with the design system in Step 3; what is there
now is the token set.)

---

## Part 5 — What cannot be tested locally

Be honest with yourself about this list. Everything on it needs the real host.

**Anything Apache does.** The built-in PHP server ignores `.htaccess` entirely,
so none of these are exercised locally: the deny rules that block `/app`,
`/storage`, `/database` and `/uploads/imports` from the web; `mod_deflate` and
`mod_expires`; and the `ErrorDocument` directives. The blank `index.php` guard
files in each of those folders are the second layer of that protection and they
*do* work locally, but the first layer does not.

> Acceptance test 9 — "requesting `app/config/database.php` directly returns 403,
> not source" — can only be run on the live host. Run it the day you first
> deploy, before you put anything real in the database.

**InfinityFree's own behaviour.** Its bot-protection JavaScript challenge on
non-browser requests, its entry-process limits, its connection ceiling, and the
45-day inactivity suspension.

**The Cloudflare Worker and Sarathi.** Nothing exists until Step 9.

**Real-device rendering.** Devanagari conjuncts, which fonts actually get
substituted, and how the layout behaves on a mid-range Android phone on a patchy
connection. A desktop browser at 320px is a good proxy and not a substitute.

**Offline behaviour.** The Service Worker arrives in Step 11. Airplane-mode
testing belongs to that step.

---

## Part 6 — When something goes wrong

### Every page redirects to /install.php

`htdocs/app/config/local.php` is missing. Either run the installer, or you
deleted it — recreate it by re-running the installer.

### "The database is not reachable right now"

MariaDB is not running:

```bash
brew services start mariadb
brew services list        # should show mariadb as "started"
```

If it is running, check the four values in `htdocs/app/config/local.php` against
what you created in step 1.3.

### /login returns 404 but the home page works

You started the server without the router file. Stop it and use the full
command, including `tools/dev-router.php` at the end.

### Devanagari shows as ???? or as boxes

`????` means the database was not created as `utf8mb4`. Drop it and recreate it
with the command in 1.3 — the damage happens at write time, so existing rows
cannot be repaired.

Boxes mean your browser has no Devanagari font, which is a display problem on
your machine only, not a bug in the site.

### The copy button on the recovery-code screen does nothing

Open the browser console. A Content-Security-Policy error means the nonce did
not reach the tag. Any other error is a real bug — send me the message.

### Everything is slow

Check whether you left `debug => true` on with a large log file. Also
`tail htdocs/storage/logs/vedaverse-*.log` for "Slow query" warnings, which name
the statement.

### A blank white page

Set `debug => true` in `htdocs/app/config/local.php`, reload, and you will get
the exception with its file and line. If it is still blank, the error is earlier
than the error handler:

```bash
php -l htdocs/index.php
```

---

## Part 7 — Step-by-step test log

What each step added, and what you can check once it exists. Steps are marked
done only when the checks below them pass.

### Step 1 — Schema, installer, config, core ✅

| What to test | How | Expected |
|---|---|---|
| The installer completes on an empty database | `/install.php` | ~76 statements, every one green; 54 tables created |
| Re-running it is safe | run it again | every line still passes |
| Devanagari survives a round trip | register with a Hindi name | stored and displayed unchanged |
| The health check | `/health` | `{"ok":true}` with three green sub-checks |
| Error pages leak nothing | `/no-such-page` | friendly title, reference code, no path, no trace |
| Error pages are translated | `/no-such-page?lang=hi` | Hindi, and `<html lang="hi">` |
| No PHP notices | `debug => true`, click everything | nothing in the log, nothing on the page |

### Step 2 — Helpers, middleware, accounts ✅

| What to test | How | Expected |
|---|---|---|
| All of the above, automated | `bash tools/smoke-test.sh` | 51 passed, 0 failed |
| Registration | `/register` | account created, signed in, code shown once |
| The password policy | try `password1` | refused, with the reason |
| The honeypot | fill the hidden "website" field | signup refused, no account created |
| CSRF | submit any form with a stale tab | refused, with an explanation, nothing written |
| Escaping | register as `<script>alert(1)</script>` | renders as visible text, no alert |
| Sign out and back in | | works; the session id changes on sign-in |
| Brute force | six wrong passwords | locked out; the right password is refused too |
| Recovery | use the code, lower-case, no dashes | accepted; a fresh code is issued; the old one dies |
| The role gate | `/admin` | signed out → redirect; ordinary account → 403 |
| Guest work is adopted | see below | bookmarks, notes and progress move to the new account |
| Maintenance mode | see below | 503 for visitors, admins still get in |

**Testing the guest merge by hand.** Bookmark and note routes arrive in Step 5,
so for now the guest rows have to be created directly:

```bash
# 1. Visit the site signed out, then read your guest token from the browser's
#    cookies (Develop → Storage → Cookies → vv_anon), or:
curl -s -c /tmp/jar http://127.0.0.1:8080/ >/dev/null
TOKEN=$(grep vv_anon /tmp/jar | awk '{print $7}')

# 2. Give that guest some work.
mariadb -u vedaverse -plocaldev vedaverse_db <<SQL
INSERT INTO chapters (chapter_number,sanskrit_name,transliteration,title_en,title_hi,title_hinglish,published)
  VALUES (99,'सांख्ययोग','Sankhya','Test','परीक्षण','Test',1);
SET @c = LAST_INSERT_ID();
INSERT INTO verses (chapter_id,verse_number,global_order,slug,sanskrit_devanagari,published)
  VALUES (@c,47,9999,'test-99-47','कर्मण्येवाधिकारस्ते',1);
SET @v = LAST_INSERT_ID();
INSERT INTO bookmarks (session_id,target_type,target_id,note) VALUES ('$TOKEN','verse',@v,'read again');
INSERT INTO notes (session_id,verse_id,content) VALUES ('$TOKEN',@v,'मेरा नोट');
SQL

# 3. Register in that same browser, then confirm the rows moved.
mariadb -u vedaverse -plocaldev vedaverse_db -e \
  "SELECT 'bookmarks' t, COUNT(*) n FROM bookmarks WHERE user_id IS NOT NULL
   UNION ALL SELECT 'left behind', COUNT(*) FROM bookmarks WHERE session_id='$TOKEN';"
```

Expect the bookmark and the note to belong to the new account, nothing left
behind, and the Devanagari note intact.

**Testing maintenance mode.**

```bash
mariadb -u vedaverse -plocaldev vedaverse_db -e \
  "UPDATE settings SET setting_value='1' WHERE setting_key='maintenance_mode';"
php tools/dev-reset.php     # clears the settings cache so it takes effect now
```

A signed-out visitor gets a 503 with a `Retry-After` header. `/login` and
`/health` stay open. An administrator sees the site normally, with an
`X-VedaVerse-Maintenance: on` header as the reminder that it is still closed.
Set it back to `'0'` and reset again.

### Step 3 — Design system ⏳ not started

Will add: `tokens.css`, `base.css`, `components.css`, the real layouts and
navigation, and the component library. `partials/provisional_css.php` is deleted
at that point.

### Steps 4–15 ⏳ not started

This table grows as each one lands.

---

## Appendix — Command reference

```bash
# Start
brew services start mariadb
php -S 127.0.0.1:8080 -t htdocs tools/dev-router.php

# Check
php tools/dev-reset.php && bash tools/smoke-test.sh

# Watch the log
tail -f htdocs/storage/logs/vedaverse-*.log

# Look in the database
mariadb -u vedaverse -plocaldev vedaverse_db

# Start completely over
mariadb -u vedaverse -plocaldev vedaverse_db < htdocs/database/DROP_ALL.sql
rm htdocs/app/config/local.php
```
