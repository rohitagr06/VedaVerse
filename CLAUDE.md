# VedaVerse — project context

**Read this first in any new session.** It is the working memory for this
project: what is built, what the rules are, what has already been decided, and
which mistakes have already been made once. Update it at the end of every build
step.

---

## 1. What this is

An AI-assisted learning platform teaching the Bhagavad Gita to people with no
background in Sanskrit, Hinduism or philosophy. The premise: ancient wisdom
sticks when it is attached to something the learner already knows, so every
teaching is anchored to a Bollywood scene, a cricket collapse, an appraisal
meeting, a family argument. Presented as practical psychology, useful to anyone
regardless of belief.

Three languages, all first-class: English, Hindi (Devanagari), Hinglish.
Hinglish is not a novelty — it is the register that makes this spread.

Not goals for v1: advertising, payments, leaderboards, aggressive gamification,
supernatural claims, medical/legal/financial advice.

- **Owner:** Rohit (rohitagr06@gmail.com), on a MacBook Air.
- **Repo:** https://github.com/rohitagr06/VedaVerse — public, `main`.
- **Local path:** `~/Claude/Projects/Gita/RC1`
- **Governing document:** `spec/RC1_Master_Build_Prompt_v2.md` — 24 sections,
  a 15-step build order. Read Section 20 for the order and Section 21 for the
  acceptance tests. **Section 1 overrides everything else in it.**

> The codename in the spec is RC1; the product is VedaVerse. The rename was done
> before the first commit. The spec file keeps its original name because it is
> the owner's authored input, not generated output.

---

## 2. Build status

| Step | Scope | State |
|---|---|---|
| 1 | `schema.sql`, `install.php`, `app/config/*`, `app/core/*` | **Done** |
| 2 | `app/helpers/*`, middleware, `AuthService`, auth screens, anonymous merge | **Done** |
| 3 | `tokens.css`, `base.css`, `components.css`, layouts, navigation, component library | **Done** |
| 4 | Complete three-language interface string table + `I18nService` | **Done** |
| 5 | `ContentService`, repositories, chapter/verse/topic/problem pages, the Chariot Path | **Done** |
| 6 | **All seed content** — 108 verses in three languages, 8–12 examples each. The largest deliverable. | **In progress** — ch2 batch A done (12 of 18) |
| 7 | `QuizService`, `SrsService`, `ProgressService`, `BadgeService` | |
| 8 | `SearchService` | |
| 9 | Cloudflare Worker, Sarathi chat, offline responder | |
| 10 | Forum + moderation queue | |
| 11 | PWA, service worker, offline sync | |
| 12 | Certificates (vendored FPDF) | |
| 13 | Admin panel | |
| 14 | SEO, sitemap, JSON-LD | |
| 15 | Final `.htaccess`, all nine `docs/` files, acceptance pass | |

Nothing is deployed. No InfinityFree account exists yet.

---

## 3. The constraints that shape every decision

These come from the target host (InfinityFree free shared hosting, FTP upload)
and they are not negotiable.

- **PHP 7.4 compatible**, clean on 8.2. No union types, no `match`, no enums, no
  constructor promotion, no `str_contains`/`str_starts_with`/`array_is_list`, no
  nullsafe `?->`. Verified by grep before every delivery.
- **No Composer, no Node, no build step.** Every dependency hand-written or a
  single vendored file.
- **Zero outbound HTTP from PHP.** The host cannot resolve external DNS from
  PHP. All AI traffic goes browser → Cloudflare Worker → provider. Any
  `curl_exec()` in `app/` pointed at a third-party domain is a bug.
- **No cron.** Streak decay, SRS due dates, cache purging and session pruning
  all run lazily on ordinary requests, on a 1-in-N probability with a capped
  row count.
- **No email at all.** `mail()` and SMTP are blocked. Account recovery is a
  12-character code shown once at signup. Notifications are in-app only.
- **`utf8mb4` end to end** — connection, table, column. A mismatch anywhere
  stores Devanagari as `????` at write time and cannot be repaired afterwards.
- **Every `.htaccess` directive wrapped in `<IfModule>`.** An unwrapped
  directive for a module the host has not enabled returns HTTP 500 for the whole
  site, with no visible error anywhere.
- **Nothing user-written goes public without a human approving it.** AI
  moderation only sorts the admin queue by risk. It never gates.

---

## 4. Architecture

```
Browser → Apache → index.php → Router → Middleware
   → Controller  (thin: validate, CSRF, authorise, delegate)
   → Service     (all business logic; never emits HTML, never reads $_POST)
   → Repository  (all SQL; prepared statements only)
   → MySQL
```

Four rules that do not bend:

1. **Views never query the database.** Not through a repository, not "just for
   the sidebar". The controller fetches and passes in.
2. **Controllers never write SQL and never build HTML strings.**
3. **Services never touch superglobals.** A controller reads the Request and
   hands plain values down. This is what keeps business logic testable from a
   script and portable to another framework.
4. **Repositories are the only place SQL exists.**

Autoloading: hand-written PSR-4-style map in `app/core/Autoloader.php`.
`\VedaVerse\Core\Router` → `app/core/Router.php`. Namespace segments map to
lowercase folder names. **Class name must match filename exactly** — Linux is
case-sensitive and a mismatch works on macOS and fails on upload.

### Middleware order — this bit is load-bearing

```
SecurityHeaders → Session → Maintenance → Csrf → [route middleware] → Controller
```

Getting this wrong has already cost one bug: Maintenance was originally before
Session, which meant the admin bypass could never fire, because `user_can()`
returns false with no session. Enabling maintenance mode would have locked the
owner out of the site they had just closed.

Route middleware aliases: `auth`, `role:admin`, `throttle:login`. One argument
after a colon, passed to the constructor.

### Additions to the spec's class list, and why

- **`app/core/Config.php`** — the alternative was each of eight config files
  reaching for `local.php` itself, the same code copied eight times.
- **`app/core/Session.php`** — CSRF verification happens in middleware, before
  any service exists, so session handling has to live in core.
- **`app/middleware/SessionMiddleware.php`** — something has to start the
  session before CSRF, and doing it in `index.php` would put logic in a file
  that is meant to be routing only.
- **`app/config/strings/*.php`** — the spec says the table lives in
  `i18n.php`. Kept there it is ~2,500 lines at the end of Step 4 and keeps
  growing to Step 13. Seven domain files hold exactly the same keys;
  `i18n.php` merges them, so no caller sees the difference.
- **Four tables beyond Section 7's list** — `login_attempts` (throttle),
  `sync_events` (makes `progress_sync.php` idempotent), `static_responses`
  (answers promoted out of AI review), `migrations`.
- **Renamed columns** — `settings.key` → `setting_key` and
  `import_errors.row_number` → `row_number_ref`, because both originals are
  reserved words in MySQL.

---

## 5. Things already learned the hard way

Do not rediscover these.

**PDO with `ATTR_EMULATE_PREPARES => false` is strict in both directions.** A
named placeholder cannot be reused within one statement, *and* binding a
parameter the statement does not mention is an error. So each statement gets
exactly the parameters it uses, and a repeated value gets a second name
(`:uid`, `:uid2`). This cost two debugging rounds on the merge SQL.

**`GREATEST()` on an ENUM compares by ordinal**, which is why
`GREATEST(mine.status, guest.status)` correctly picks `mastered` over
`learning`. Verified against MariaDB 10.11.

**Updating a table from a subquery on itself** needs the subquery wrapped in a
derived table (`SELECT … FROM (SELECT … FROM t) AS alias`). MySQL rejects it
otherwise.

**The router's 404 and 405 handlers must run through the global middleware.**
They originally bypassed it, which meant the most-hit page on any site — the one
catching every stale link and every bot — was the only page going out with no
security headers, no session and no language.

**A substring match on redaction key names eats real data.** `'pat'` matched
`path`, `'code'` matched `country_code`, and the logs filled with `[redacted]`
where the useful detail should be. There are now two lists:
`redact_exact` (compared with `===`) and `redact_contains` (substring, for
`password`, `api_key` and friends).

**A counter nothing writes to is not a rate limiter.** `RateLimitMiddleware`
originally *read* a per-IP counter that only `AuthService` wrote to, under a
different key — so the per-address limit was dead code that looked like it
worked. There are now two deliberate counters with different ceilings: per-email
failures (5 / 15 min, in `AuthService`) and per-address requests (30 / 15 min,
in the middleware, scope prefixed `ip:`).

**Error templates must cope with every variable being absent.** `layouts/error.php`
derives its own title from the status, because `ErrorHandler` renders it from the
shutdown handler too, where building a full data array is exactly the thing that
fails a second time.

**PHP 8.5 moved the MySQL-specific PDO constants** into a `Pdo\Mysql` class and
deprecated `PDO::MYSQL_*`. Because the code must also run on 7.4, where that
class does not exist, the resolution goes through
`Database::initCommandAttribute()` using `defined()` and `constant()` rather
than naming either directly. Any future `PDO::MYSQL_*` needs the same treatment.
Note the knock-on: `ErrorHandler` promotes deprecations to exceptions, so on
8.5 an unhandled one is a 500 page, not a quiet notice.

**White on the brand orange fails WCAG AA at 2.84:1.** The primary button
therefore uses ink text on `--vv-dawn` (6.51:1). Derived `-deep`, `-text` and
`-lift` variants exist for the cases that genuinely need white text or a text
colour on a light or dark surface. `tools/check-contrast.php` parses
`tokens.css` and fails on any regression — run it after touching a colour.

**A CSS grid places children in source order.** `<main>` comes before `<nav>` in
the markup so assistive technology reaches content first, which meant the
sidebar layout put the content in the 260px column. Fixed with explicit
`grid-column` / `grid-row` on both. The DOM order serves the screen reader, the
grid order serves the eye.

**`[aria-invalid="true"]` (0,1,0) loses to `input[type="text"]` (0,1,1),** so the
error border silently never rendered. Found by screenshotting the style guide,
which is the only way that class of bug ever gets found — take screenshots.

**`display:none` honeypots get skipped by some bots.** Ours is positioned
off-screen instead, with `tabindex="-1"` and `aria-hidden`.

**Validation is not sanitisation.** A display name is stored exactly as typed
and escaped on output. `nohtml` was briefly on the name field and had to come
off — it contradicted the stated principle and made acceptance test 7
impossible to run.

**`check-contrast.php` collects only literal hex values, so an alias resolves to
the wrong theme.** `--vv-text` is `var(--vv-ink)` in `:root` and a literal
`#FFF7EE` inside the dark blocks, which makes the light map's `--vv-text` the
dark one. Name the concrete token — `--vv-ink`, `--vv-cloud`, `--vv-surface` —
in every light pairing. A wrong pairing does not error; it quietly reports
cream on cream at 1.04:1.

**`inline-flex` eats the whitespace between children.** A chip holding a label
and a count rendered as `admin104`. The fix is `gap` on the chip, not a
`&nbsp;` at the call site.

**A duplicated key inside one string file is invisible to every check that
loads the file.** PHP collapses it while parsing the array literal, so
`array_keys()` and the merged table both show one entry and the first
definition is simply gone. `check-strings.php` reads the source as text to
catch it — that is why it does something as crude as a regex over a file it
has already required.

**`View::capture()` extracts template data with EXTR_SKIP, so a data key
matching one of its own locals is SILENTLY DROPPED.** A controller passing
`'path'` got the template's filename; one passing `'level'` got an
output-buffer depth. Both rendered a page, neither warned, and `level` is an
entirely reasonable key name. Fixed at the source in Step 5 — every local in
that method is now `__vv_`-prefixed, so the collision is impossible rather
than merely documented. Do not add an unprefixed local to it.

**Route placeholders arrive on the Request, not as controller arguments.**
`Router::dispatch()` calls `$request->setParams()` and then invokes the
action with the Request alone. A controller signed
`chapter(Request $r, $number)` throws ArgumentCountError. Read
`$request->param('number')`.

**`Repository::limit()` returns `' LIMIT n OFFSET m'`, with the keyword
already in it.** Writing `'... LIMIT ' . $this->limit($n)` produces
`LIMIT LIMIT 20 OFFSET 0`.

**A CSS connector line cannot have a fixed height.** The Chariot Path's
segments broke because node height depends on whether a summary line wraps
and on the reader's text-size setting. Stretch between two offsets instead.
Found by screenshot; invisible in the markup.

**A trailing comma before `UNION ALL` in a seed file is a syntax error that
names the wrong line.** MariaDB reports it at the UNION, not at the comma, so
the eye goes to the line that is fine. It has bitten twice now, in
`seed_sample.sql` and `seed_ch02.sql`. The fix is mechanical — scan forward
past blank and comment lines, and if the next real line starts `UNION ALL
SELECT`, strip the comma. Run that over any seed file before loading it.

**A write action must check that its target exists BEFORE writing.**
`POST /verse/{id}/note` did not. `notes` has a foreign key to `verses`, so a
guessable URL produced an integrity-constraint violation and a 500 page.
`bookmarks` has no such key — `target_id` is polymorphic — so the same request
there wrote a bookmark pointing at nothing, silently. One shared guard,
`ContentController::publishedVerse()`, now covers all three.

**A placeholder present in English and missing in Hindi reads as a perfectly
fluent Hindi sentence.** This is the whole reason `check-strings.php` exists.
Nobody finds these by proofreading, because there is nothing visibly wrong.

**A test tool that reports 48 failures for one missing precondition is worse
than no tool.** `smoke-test.sh` ran with the web server stopped and printed
48 red lines, every one of them `got: 000`, with nothing anywhere saying
"nothing is listening". It now checks four preconditions first — is anything
on the port, is the site installed, is the database answering — and stops with
one sentence naming the actual cause.

**`curl -w '%{http_code}'` already prints `000` on a refused connection, then
exits non-zero.** So `$(curl … || echo 000)` yields `000000` and any
comparison against `000` silently never matches. Found only by pointing the
preflight at a dead port — which is the only way it would ever have been.

---

## 6. Conventions

**Every file opens with a comment block** stating what it does, what depends on
it, and what a beginner should be careful changing. The audience is explicitly
a PHP beginner who will copy, paste and upload by FTP and will not debug the
architecture. Non-obvious lines carry a plain-language reason — *why*, not
*what*.

**Escaping:** one helper, `e()`, on everything printed including database
content. `ejs()` for values inside `<script>`. `eattr()` for attribute lists.

**Interface strings:** no hardcoded English in any view, ever. Every string is a
key in `app/config/strings/<domain>.php` with all three languages; `i18n.php`
merges the seven domain files and still answers `Config::get('i18n.strings')`
with the whole table. A key missing a language is a bug, not a fallback.
Read them with `t()` / `et()`, or `tc()` / `etc_()` when a count decides between
a singular and a plural form written as `one|many`. Run
`php tools/check-strings.php` before committing.

**Naming:** `vv_` prefix on cookies and installer functions, `vedaverse-` on log
files and cache versions, `vv:v1:` cache key prefix, `VEDAVERSE_` constants.

**Security defaults:** bcrypt cost 10; IPs hashed with a site pepper, never
stored raw; CSRF per session, verified in middleware; sessions regenerated on
login; CSP `script-src 'self'` plus a per-request nonce — never `'unsafe-inline'`
for scripts.

**Content rules** (matter from Step 6 on): every translation and example is
original writing. Name films, matches and events freely; never reproduce
dialogue, lyrics or copyrighted commentary. Political examples illustrate the
*structure* of a dilemma only — no praise or criticism of any living politician,
party or movement, no communal framing. Keep four things visibly distinct:
scripture, traditional commentary, modern interpretation, AI-generated analogy.
Never fabricate a verse, a chapter number, a Sanskrit word or a commentary
attribution.

---

## 7. Working method

**Every step is verified before delivery, not asserted.** The sandbox has PHP
8.4 and MariaDB 10.11. The routine:

1. Build in `/root/vv/htdocs` in the container.
2. `php -l` every file; grep for PHP 8-only syntax.
3. Run the real installer end to end over HTTP with cookies and CSRF tokens.
4. Run `tools/smoke-test.sh` — 51 checks.
5. Check `storage/logs/` is clean of notices and deprecations.
6. Zip, `SendUserFile`, `device_commit_files` to `RC1/`, then unpack.

**Getting files onto the Mac.** `device_bash` has no network, so git push cannot
run there — the owner pushes from his own Terminal. The mount also forbids
`unlink`, so `unzip -o` fails on existing files; overwrite in place with
`cat src > dest`, which truncates rather than deleting. Verify with `md5sum`
against the container copy. Files that need deleting get moved to
`RC1/_to_delete/` instead.

**Reporting.** State what was verified and how, name deviations from the spec
explicitly rather than letting them pass silently, and end with the specific
decisions needed before the next step. Prose, not bullet soup.

---

## 8. Decisions taken, with reasons

| Decision | Reason |
|---|---|
| Product renamed RC1 → VedaVerse before the first commit | Cheapest possible moment; only 60 files existed |
| Repo rooted at `RC1/`, containing `htdocs/` and `spec/` | Keeps the spec versioned beside the code it describes |
| Provisional auth views now, restyled in Step 3 | Otherwise the whole auth flow is untestable until Step 3 lands |
| One sign-in screen, `/login`, for everybody | A second admin form is a second place for an auth bug to hide; the role check on the routes is what actually protects them |
| Merge conflict rule: keep the more advanced state | Higher completion, better quiz score, *earlier* SRS due date, both notes kept |
| The merge runs on login as well as registration | Registration has no conflicts by definition; login is the case that actually happens and the only one with real conflicts |
| CSP nonce rather than `'unsafe-inline'` | One copy button should not switch off the most valuable line in the policy |
| `index.php` and root `.htaccess` shipped in Step 1 | Nothing boots or is testable without them; both marked provisional, Step 15 replaces the `.htaccess` |
| Design tokens named `--vv-*` | Matches the namespace used everywhere else; decided before `tokens.css` existed, so it cost nothing |
| Primary button uses ink text, not white | White on `--vv-dawn` is 2.84:1 and fails AA. Measured, not assumed. |
| MIT for the software, CC BY-SA 4.0 for the content | The engineering is a gift; the writing is the product and ShareAlike stops it being closed |
| String table split into `app/config/strings/*.php` | One file would be ~2,500 lines by Step 4 and still growing at Step 13; seven files mean a syntax error names its domain and two edits stop colliding |
| Content fields fall back hi ↔ hinglish before English | Same words, different script — a Hindi reader is better served by the Hinglish text than by English. Interface strings still fall straight back to English. |
| Hinglish is never chosen from `Accept-Language` | No browser advertises it, and inferring it from an Indian locale is a guess about a person rather than about their software |
| Step 5 ships `seed_sample.sql` — 5 real verses, not fixtures | The path, the verse page and life-problem navigation are unjudgeable empty. These are final-quality and become part of Step 6's 108. |
| Content fields fall back hi ↔ hinglish before English | Same words, different script. Interface strings still fall straight to English. |
| A 'locked' path node is dimmed, never barred | Every verse is readable by anybody at any time, including a guest. The dimming shows distance, not permission. |
| Track lists live in `app/config/app.php`, not the database | An editorial judgement about pedagogy, not data an admin edits at 2am. |
| `/topics` and `/problems` are separate routes and templates | Different audiences. The problem page leads with an example because its reader has a problem, not an interest in scripture. |
| Progress in Step 5 is read-and-mark only | XP, streaks, mastery and SM-2 are Step 7. Half-implementing them now would leave Step 7 fixing a temporary file. |
| `/profile` built in Step 5, not later | The nav had linked to it since Step 3 and it 404'd, and acceptance test 5 could only be verified in SQL without it |
| Data export and account deletion ship with the profile | §12 requires both. They are the promise the anonymous-first design rests on, not a feature to schedule. |
| Account deletion anonymises forum authorship | §12. The FKs are already `ON DELETE SET NULL`; orphaning a thread punishes the people who replied to it. |
| Focus mode is a body class, not a second layout | Two shells means two places to keep the skip link and focus order right, and the second one rots. |
| Two plural forms, no CLDR rule table | English, Hindi and Hinglish all take one form for 1 and one for everything else. A six-form language would need real rules; none exists here. |

---

## 9. Known gaps, deliberately deferred

Found in the Step 5 audit. None is a defect; each is scheduled or argued.

- **Fonts are not vendored.** `assets/fonts/` has only the README, so the
  shloka falls back to a system stack. §15 requires self-hosted woff2 subsets
  and acceptance test 2 leans on it. Five minutes of work, needs doing before
  anyone judges the typography.
- **No illustrations or icons.** Nav icons are emoji placeholders; chapter
  milestones have no distinct art. §15 and §9.2 both want them; §20 assigns
  them to no step. Needs a home — probably alongside Step 6.
- **`user_profiles` / `user_settings` are written once and never read.**
  Theme and text size are localStorage only. Syncing them across devices is
  the point of those tables and nothing does it yet.
- **`verse_commentaries` has no rows**, so Research mode's commentary
  comparison has never rendered with data. The query and the template exist.
  Step 6.
- **8 of the ~18 life problems in §9.3 are seeded.** Step 6.
- **4 modern examples per verse against the specified 8–12.** Step 6 tops
  them up; nothing written so far is thrown away.
- **`install.php` does not offer to load `seed_sample.sql`.** A fresh install
  lands on an empty path. The empty state is handled properly, so this is
  cosmetic until Step 6 — but it is a poor first five minutes.
- **Swipeable example cards** (§15) render as a plain stacked list.
- **`migrations` table and `database/migrations/`** exist and nothing uses
  them; schema versioning goes through `settings.schema_version` instead.
  Pick one and delete the other.

---

## 10. Open questions

- **Live host.** No InfinityFree account yet. Deploying Step 1–2 there would
  cheaply settle three assumptions: whether `storage/` is really writable,
  whether the `.htaccess` survives, and what PHP version is actually running.
  Acceptance test 9 (direct request for `app/config/database.php` returns 403)
  can only be run there.

---

## 11. Where things are

```
RC1/
├── CLAUDE.md                 this file
├── README.md                 public-facing project overview
├── docs/
│   ├── LOCAL_TESTING.md      the manual: every setting, every error message
│   └── TEST_RUN.md           the runbook: one linear pass, Steps 1–4, checklist
├── spec/                     the master build prompt
├── tools/
│   ├── dev-router.php        router for `php -S` (built-in server ignores .htaccess)
│   ├── dev-reset.php         clears throttle counters, cache, logs, test accounts
│   ├── smoke-test.sh         79 HTTP checks, exit 1 on any failure
│   ├── check-contrast.php    35 WCAG AA pairings read from tokens.css
│   └── check-strings.php     missing languages, placeholder drift, plural
│                             drift, duplicate keys, undefined references
└── htdocs/                   everything uploaded by FTP
    ├── index.php             front controller — routing only
    ├── install.php           browser installer, self-deleting
    ├── app/
    │   ├── config/           app, database, security, cache, ai, seo, pwa, i18n
    │   │                     strings/ — common, errors, auth, content,
    │   │                     learning, community, admin (626 keys × 3)
    │   │                     (+ local.php — generated, secret, never committed)
    │   ├── core/             Autoloader, Config, Session, Router, Request,
    │   │                     Response, View, Database, Cache, Logger,
    │   │                     ErrorHandler, Validator
    │   ├── middleware/       Middleware (base), SecurityHeaders, Session,
    │   │                     Maintenance, Csrf, RateLimit, Auth, Admin
    │   ├── controllers/      Controller (base), Auth, Content, Topic, Path,
    │   │                     Profile
    │   ├── services/         AuthService, I18nService, ContentService,
    │   │                     PathService
    │   ├── repositories/     Repository (base), User, Session, Setting,
    │   │                     Throttle, Chapter, Verse, Topic, Progress,
    │   │                     Bookmark
    │   ├── helpers/          security, string, date, url, format
    │   └── views/            layouts, partials, pages, errors
    ├── database/             schema.sql (54 tables), DROP_ALL.sql,
    │                         seed_sample.sql (18 chapters, 14 topics,
    │                         5 curated verses), migrations/
    ├── storage/              cache, logs, sessions, backups, temp — web-blocked
    ├── uploads/              certificates, imports, avatars — web-blocked
    └── assets/
        ├── css/              tokens, base, components, print, fonts
        ├── js/               app.js — theme, text size, CSRF on fetch
        └── fonts/            README only; the binaries are fetched, not committed
```

**Local test credentials** (sandbox and the owner's Mac, never production):
database `vedaverse_db`, user `vedaverse`, password `localdev`, host `127.0.0.1`.

## 12. The owner's actual local environment

Worth knowing, because it differs from the sandbox and has already produced
four separate failures.

- **PHP 8.5.8** (Homebrew). Newer than the 8.4 the sandbox runs. Surfaced the
  `PDO::MYSQL_ATTR_INIT_COMMAND` deprecation.
- **MariaDB 10.4.28 from XAMPP** at `/Applications/XAMPP/xamppfiles`, running
  as `_mysql` on port 3306, started at boot. Older than the sandbox's 10.11 —
  which is *good*, since it is closer to what InfinityFree runs. The schema
  installs clean on it: 76 statements, 0 failures.
- A Homebrew MariaDB 12.3 is also installed but **must stay stopped** — it
  cannot bind to 3306 while XAMPP holds it.
- The `mariadb` CLI is version 15.2 (from 12.3) and therefore **requires
  `--skip-ssl`** against the 10.4 server. PDO is unaffected.
- Grafana runs on this machine too. Do not assume port availability.

When something fails on his machine but works in the sandbox, check this list
first.
