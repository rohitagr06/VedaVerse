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
| 3 | `tokens.css`, `base.css`, `components.css`, layouts, navigation, component library | Next |
| 4 | Complete three-language interface string table + `I18nService` | |
| 5 | `ContentService`, repositories, chapter/verse/topic/problem pages, the Chariot Path | |
| 6 | **All seed content** — 108 verses in three languages, 8–12 examples each. The largest deliverable. | |
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

**`display:none` honeypots get skipped by some bots.** Ours is positioned
off-screen instead, with `tabindex="-1"` and `aria-hidden`.

**Validation is not sanitisation.** A display name is stored exactly as typed
and escaped on output. `nohtml` was briefly on the name field and had to come
off — it contradicted the stated principle and made acceptance test 7
impossible to run.

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
key in `app/config/i18n.php` with all three languages. A key missing a language
is a bug, not a fallback.

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

---

## 9. Open questions

- **Design token names.** The spec calls them `--rc-dawn`, `--rc-marigold`.
  Rename to `--vv-*`? Free to change until `tokens.css` exists in Step 3.
- **Licence.** The repo is public with no licence, which means all rights
  reserved and nobody can reuse it. Worth settling before Step 6 lands 108
  verses of original prose.
- **Live host.** No InfinityFree account yet. Deploying Step 1–2 there would
  cheaply settle three assumptions: whether `storage/` is really writable,
  whether the `.htaccess` survives, and what PHP version is actually running.
  Acceptance test 9 (direct request for `app/config/database.php` returns 403)
  can only be run there.

---

## 10. Where things are

```
RC1/
├── CLAUDE.md                 this file
├── README.md                 public-facing project overview
├── docs/LOCAL_TESTING.md     how to run and test on the Mac; updated every step
├── spec/                     the master build prompt
├── tools/
│   ├── dev-router.php        router for `php -S` (built-in server ignores .htaccess)
│   ├── dev-reset.php         clears throttle counters, cache, logs, test accounts
│   └── smoke-test.sh         51 HTTP checks, exit 1 on any failure
└── htdocs/                   everything uploaded by FTP
    ├── index.php             front controller — routing only
    ├── install.php           browser installer, self-deleting
    ├── app/
    │   ├── config/           app, database, security, cache, ai, seo, pwa, i18n
    │   │                     (+ local.php — generated, secret, never committed)
    │   ├── core/             Autoloader, Config, Session, Router, Request,
    │   │                     Response, View, Database, Cache, Logger,
    │   │                     ErrorHandler, Validator
    │   ├── middleware/       Middleware (base), SecurityHeaders, Session,
    │   │                     Maintenance, Csrf, RateLimit, Auth, Admin
    │   ├── controllers/      Controller (base), Auth
    │   ├── services/         AuthService
    │   ├── repositories/     Repository (base), User, Session, Setting, Throttle
    │   ├── helpers/          security, string, date, url, format
    │   └── views/            layouts, partials, pages, errors
    ├── database/             schema.sql (54 tables), DROP_ALL.sql, migrations/
    ├── storage/              cache, logs, sessions, backups, temp — web-blocked
    ├── uploads/              certificates, imports, avatars — web-blocked
    └── assets/               css, js, fonts, icons, data
```

**Local test credentials** (sandbox and the owner's Mac, never production):
database `vedaverse_db`, user `vedaverse`, password `localdev`, host `127.0.0.1`.
