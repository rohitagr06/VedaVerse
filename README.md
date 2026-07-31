# VedaVerse — The Gita, Decoded

An AI-assisted learning platform that teaches the Bhagavad Gita to people with no
background in Sanskrit, Hinduism or philosophy. Every teaching is anchored to
something the learner has already lived through — a film, a cricket collapse, an
appraisal meeting, a family argument — and the text is presented as practical
psychology rather than as scripture to be believed.

Three languages: English, Hindi (Devanagari), and Hinglish. All three are
first-class. Hinglish is not a novelty; it is the register that makes this
spread.

---

## Build status

The build follows the fifteen-step order in `spec/RC1_Master_Build_Prompt_v2.md`.

| Step | Scope | State |
|---|---|---|
| 1 | Schema, installer, config, core classes | **Done** |
| 2 | Helpers, middleware, auth, anonymous merge | **Done** |
| 3 | Design system, layouts, component library | **Done** |
| 4 | Full three-language interface string table | **Done** |
| 5 | Content service, chapter/verse/topic pages, Chariot Path | **Done** |
| 6 | 108 curated verses, all seed content | **In progress — 117 written, 4 chapters to go** |
| 7 | Quizzes, SM-2 spaced repetition, progress, badges | Not started |
| 8 | Search | Not started |
| 9 | Cloudflare Worker, Sarathi chat, offline responder | Not started |
| 10 | Forum and moderation queue | Not started |
| 11 | PWA, service worker, offline sync | Not started |
| 12 | Certificates | Not started |
| 13 | Admin panel | Not started |
| 14 | SEO, sitemap, structured data | Not started |
| 15 | Final `.htaccess`, documentation, acceptance pass | Not started |

Nothing is deployed yet.

### Where step 6 has got to

A hundred and seventeen verses are written to final quality across fourteen chapters, each with
Sanskrit, IAST and simple transliteration, a literal rendering, three original
translations, three summaries, an explanation at beginner depth, memory hooks,
three reflection questions, a practice, topic tags, modern examples,
cross-references and word-by-word glosses — all of it in English, Hindi and
Hinglish.

| Chapter | Verses | Examples | Track |
|---|---|---|---|
| 1 — The Collapse | 9 | 36 | all three, second to last |
| 2 — The Ground Under Everything | 12 | 43 | all three |
| 3 — Doing the Thing | 8 | 64 | all three |
| 4 — Knowing and Doing | 8 | 32 | intermediate, advanced |
| 5 — Doing It Without Carrying It | 8 | 32 | intermediate, advanced |
| 6 — Sitting With Yourself | 8 | 32 | intermediate, advanced |
| 7 — Where To Look, And Who Comes | 8 | 32 | advanced |
| 12 — The Easier Road | 8 | 24 | all three |
| 13 — The Field and Who Watches It | 8 | 32 | intermediate, advanced |
| 14 — Three Settings | 8 | 32 | intermediate, advanced |
| 15 — The Upside-Down Tree | 8 | 32 | advanced |
| 16 — Two Directions | 8 | 24 | all three |
| 17 — What You Actually Believe | 8 | 32 | intermediate, advanced |
| 18 — Putting It Down | 8 | 24 | all three |

**The beginner track is complete** — chapters 2, 3, 12, 16, 1 and 18, thirteen
path clusters, and a reader who works through it meets the argument of the book
from 2.13 to 18.63 without a gap. Chapter 1 sits second to last in all three
tracks rather than first: the collapse reads far better once you know what the
argument is going to be. It used to be on the advanced track only, which was the
same judgement taken one step too far — the chapter list shows chapter 1 first,
badged Beginner, so a reader could open it and then never meet it again on their
own path. **The beginner and intermediate tracks are both complete.** Chapter 2
has a second batch of six discretionary verses outstanding, and the advanced-only
chapters 8 to 11 are the remaining body of work.

**The advanced track now differs from the intermediate one.** Until chapter 15
was seeded it did not. `app.tracks` lists 7, 8, 9, 10, 11 and 15 for advanced,
`PathService` silently skips chapters with no seeded verses, and so a reader who
switched to advanced gained nothing but chapter 1 — nothing errored, no check
failed, and the product quietly did not do what it said. That is the same family
of bug as a published chapter with no verses in it. Chapter 15 is the shortest
of the six at twenty verses, so it went first, and the smoke suite now switches
track the way a reader does and asserts that the path actually changes. Chapter 7
followed it, and the advanced path now runs 2, 3, 4, 5, 6, 7, 12, 13, 14, 15, 16,
17, 1, 18.

**The two deferred passages are now written.** 4.13, the varṇa verse, and 1.41,
Arjuna's claim that ruined women produce varṇa-saṅkara, are the book's hardest
passages on caste and gender. They were held back for months and then done
together, because they are the same problem approached from two sides.

Neither is softened and neither is left out. **4.13** carries four sentences and
removing any one produces a dishonest page: the criterion the verse states is
quality and action and the Sanskrit word for birth is not in the line; it was
read as birth anyway, for centuries, by people with authority, and that reading
did real damage; the book does not settle it, because 18.41–44 supports the
hereditary reading while 5.18 and 13.27 pull hard against it; and the second half
of the verse withdraws its own authorship claim. **1.41** is recorded rather than
endorsed — it is Arjuna's, thirteen verses into a speech that began after his
legs gave way, and the explanation says out loud that this describes the sentence
and does *not* excuse it, because a bad argument made in distress is still a bad
argument and this one did centuries of damage in the mouths of people who were
perfectly calm. Nothing in the seventeen chapters that follow takes it up. Not
one modern example in either chapter names a caste, a community, a religion or a
region.

---

## The constraints that shape everything

VedaVerse targets **InfinityFree free shared hosting**, uploaded by FTP. That is
not an incidental detail — it is why the code looks the way it does.

**PHP 7.4 compatible**, and clean on 8.2. No union types, no `match`, no enums,
no constructor promotion. **No Composer, no Node, no build step** — every
dependency is hand-written or a single vendored file. **Zero outbound HTTP from
PHP**: the host cannot resolve external DNS from PHP, so all AI traffic goes
browser → Cloudflare Worker → provider, and any `curl_exec()` in `app/` pointed
at a third-party domain is a bug. **No cron** — streak decay, due-card
computation and cache purging all run lazily on ordinary requests. **No email
at all**: `mail()` and SMTP are blocked, so account recovery is a one-time code
shown once at signup, and notifications are in-app only.

Two more that are choices rather than constraints. Every `.htaccess` directive
is wrapped in `<IfModule>`, because an unwrapped directive for a module the host
has not enabled returns HTTP 500 for the whole site with no visible error.
And **`utf8mb4` end to end** — connection, table and column — because a
mismatch anywhere stores Devanagari as `????` at write time, which cannot be
repaired afterwards by changing the display.

---

## Repository layout

```
htdocs/                  Everything that gets uploaded by FTP
├── index.php            Front controller — routing only, no logic
├── install.php          Browser installer, deletes itself when done
├── .htaccess            Provisional; Step 15 replaces it
├── app/
│   ├── config/          app, database, security, cache, ai, seo, pwa, i18n
│   │                    (+ local.php, generated by the installer, never committed)
│   ├── core/            Autoloader, Config, Router, Request, Response, View,
│   │                    Database, Cache, Logger, ErrorHandler, Validator
│   ├── middleware/      SecurityHeaders, Session, Maintenance, Csrf,
│   │                    RateLimit, Auth, Admin — in that order
│   ├── controllers/     Thin: validate, authorise, delegate, respond
│   ├── services/        Business logic. Never emits HTML, never reads $_POST.
│   ├── repositories/    The only place SQL exists.
│   ├── models/
│   ├── helpers/         security, string, date, url, format — global
│   │                    functions: e(), t(), csrf_field(), url(), route()
│   └── views/           Never queries the database.
├── database/            schema.sql, DROP_ALL.sql, seed files, migrations
├── storage/             Blocked from the web. Cache, logs, sessions, backups.
├── uploads/             Certificates, CSV imports, avatars
└── assets/              CSS, JS, fonts, icons, offline content bundle

spec/                    The master build prompt this is built against
tools/                   dev-router.php, dev-reset.php, smoke-test.sh
docs/                    LOCAL_TESTING.md (Step 15 adds the other eight)
CLAUDE.md                Project context — read first when picking this up
```

The Cloudflare Worker lives in `htdocs/worker/` when it arrives at Step 9, and
is deliberately **not** uploaded to the web host.

---

## Architecture

A modular monolith, layered in strict order:

```
Browser → Apache → index.php → Router → Middleware
   → Controller  (thin: validate, CSRF, authorise, delegate)
   → Service     (all business logic, never emits HTML)
   → Repository  (all SQL, prepared statements only)
   → MySQL
```

Four rules that do not bend. Views never query the database. Controllers never
write SQL and never build HTML strings. Services never touch `$_POST` directly —
a controller reads the request and passes plain values down, which is what keeps
business logic testable and portable. Repositories are the only place SQL
exists.

Autoloading is a hand-written PSR-4-style map in `app/core/Autoloader.php`:
`\VedaVerse\Core\Router` resolves to `app/core/Router.php`. Namespace segments
map to lowercase folder names; class names must match their filename exactly,
because Linux filesystems are case-sensitive and a mismatch works locally and
fails on upload.

---

## Deploying

Full instructions land in `docs/DEPLOY_CHECKLIST.md` at Step 15. The short
version:

1. Create the MySQL database in your host's control panel and note four values:
   host (**not** `localhost` on InfinityFree — it looks like
   `sql123.infinityfree.com`), database name, username, password.
2. Set PHP to 8.1 or 8.2 in the control panel.
3. Upload the contents of `htdocs/` by FTP.
4. Open `install.php` in a browser. It checks the server, tests your
   credentials before writing anything, runs the schema one statement at a time
   with a pass/fail line for each, and creates your administrator account.
5. **Write down the recovery code it shows you.** It is displayed once and
   stored only as a hash. There is no email reset, so losing both the password
   and the code means losing the account.
6. Press the button that deletes `install.php`.
7. Deploy the Worker (Step 9) and paste its URL into admin settings. Sarathi
   stays switched off until you do — a chat box that cannot possibly answer is
   worse than no chat box.

One thing to diarise: InfinityFree suspends accounts after roughly 45 days of
inactivity. Sign in to the control panel occasionally.

### Running it locally

```bash
brew install php mariadb && brew services start mariadb
php -S 127.0.0.1:8080 -t htdocs tools/dev-router.php
```

Then open `http://127.0.0.1:8080/install.php`. The router file is needed because
PHP's built-in server ignores `.htaccess`, so without it every route except the
home page returns 404.

`docs/LOCAL_TESTING.md` has the full walkthrough — setup, what to test by hand,
what cannot be tested without the real host, and a per-step log of what exists.

```bash
find htdocs tools -name "*.php" -exec php -l {} \;    # syntax, PHP 7.4 upward
php tools/check-strings.php                           # string table complete
php tools/check-contrast.php                          # 35 WCAG AA pairings
php tools/dev-reset.php && bash tools/smoke-test.sh   # 161 HTTP checks
```

A hundred and thirty-six checks over HTTP in about twenty seconds: headers, error
pages in three languages, CSRF, the password policy, registration, escaping,
sign-in, the role gate, recovery, the brute-force lockout — and the content
guards described below. Exits non-zero on any failure, so it can gate a commit.

`docs/TEST_RUN.md` lists the seed files to load and, in a section called *The
verses the suite guards*, explains every content assertion and why it is there.

---

## Security posture

Prepared statements in repositories only, never string concatenation, including
in admin. One escaping helper, `e()`, applied to every output including database
content. Per-session CSRF token verified in middleware before the controller
runs. IP addresses are hashed with a site-wide pepper and never stored raw.
Passwords are bcrypt at cost 10, minimum ten characters with mixed case, a digit
and a symbol, checked against a bundled list of the most-guessed passwords.
Logs redact anything that looks like a secret. Error pages never show a file
path, a stack trace, a SQL fragment or a key — they show a reference code the
owner can search the log for.

Nothing user-written becomes public without a human approving it. AI moderation
scores the admin's queue to sort it by risk; it never gates. The human is
always the gate.

---

## Content rules

Every translation, explanation, summary and example is original writing. Film
titles, match results and public events are named freely — titles and facts are
not protected — but no dialogue, no lyrics, no copyrighted commentary, no
copyrighted images. The Sanskrit source is ancient and free; published modern
translations are not.

Political examples illustrate the *structure* of a dilemma — loyalty against
conscience, the cost of an unpopular decision — with no praise or criticism of
any living politician, party or movement, and no communal framing. When in
doubt, use a corporate or sporting example instead.

Every record keeps four things visibly distinct: what the scripture says, what
traditional commentators have said, what a modern reading suggests, and what is
an AI-generated analogy. They are never blurred.

### The verses the suite guards

Some verses in this book have a documented history of being put to uses their
words do not support, and some can hurt the reader who lands on them. Where that
is true, the explanation refuses the misreading in as many words, and
`smoke-test.sh` asserts the refusal by literal string on the **default** render —
not at a named depth, because the default is what a reader actually gets. **If
one of those checks fails, find out what changed in the content. Never update
the expected string.**

Against misuse: **3.35** (svadharma is *own*, not *inherited*), **16.4 and 16.5**
(the chapter describes two directions a person can face, not two kinds of
person), **14.5** (the guṇas are settings that take turns, not kinds of person —
and 14.10 says so itself), **17.2** (svabhāva-ja is not about birth), **4.8**
(every verb in it is first person, so it instructs nobody — and Arjuna, who asked
directly for a reason to fight, is never given this one), **4.13** and **1.41**
(above), and **5.18**, which needs
guarding from both sides at once — the word śvapāka is not sanded down, and the
verse is not turned into a boast about the tradition, because the same book
contains 4.13.

For the reader's own wellbeing: **6.5** (leverage is not blame, and this is not a
reason to stop asking for help), **6.17 and 17.7** (both sort by fit and by
effect, never by amount; no number appears in either), **17.19** (practice done
by hurting yourself is put in the bottom category by the text itself — the
problem is the category, not the dose), **13.6, 13.29 and 13.32** — chapter 13
carries the most misusable idea in the book, *you are not this, you are the one
watching it*, and it defends against that itself: 13.6 puts awareness on the list
of things observed, so the witness is not a place to climb into; 13.29 says the
seeing produces *less* self-harm; and 13.32's "not stained" means not coloured
by, not not-felt — **14.8** (being tired is not what that
verse describes — tamas is defined as born of *not-seeing*, and rest is not on
trial anywhere in the chapter), **14.23** (udāsīna-*vat*, LIKE one uninvolved —
the suffix is not a licence to stop caring about people), **5.22** (not an
argument for joylessness), and the three sentences on **1.46**, which is the most
carefully written page in the corpus.

**15.7** is the warmest sentence in the book and has been used as a permission
slip — *I am already a fragment of the divine, so what I do is beside the point*.
The refusal is in the same verse: its second line says the fragment *draws* the
senses, and karṣati is the word for hauling something heavy, so the fragment is
not sitting above the situation, it is down in the body doing the pulling.
**15.3** hands over an axe, and two things are asserted because both are in the
line — the axe is pointed at a *tree*, and asaṅga is not-sticking, not
not-feeling. **15.15** names apohana, the taking away of memory and knowledge, as
coming from the same place they do; nothing in that chapter file treats
forgetting or going blank as a fault, and the four modern examples on the verse
all run the other way.

**7.16** is the verse with the best claim to being this project's licence. It
names four kinds of person who come — the one in distress, the one who wants to
know, the one who wants something out of it, and the one who knows — and the
word it puts on all four, *before* it separates them, is sukṛtinaḥ: people who
have done well. A reader who arrived here in a bad month, or because they wanted
something, is named as legitimate by the text itself. And then **7.17** ranks
them, and the ranking is asserted too, because printing 7.16 without 7.17 would
have been the most comfortable omission in the chapter and a lie by arrangement.
What the 7.17 page adds is what the ranking is *not*: all four are already
inside when it is drawn. **7.3** — one in thousands even tries — counts an
activity and not a worth, and is cross-referenced to 7.16 as an *opposite* so a
reader who lands on it alone is handed the other one. **7.11** is the book
endorsing desire, and the narrow qualifier is kept rather than widened into
"only spiritual desire counts". **7.14** says *hard to get across* before it says
anything about getting across, and nothing in that chapter file promises a
timescale.

And one guarded for the opposite reason: **18.63** — *think it over completely,
then do as you wish*. That permission is why this text can be taught to somebody
with no background and no belief without either side pretending, and it is in the
book rather than being a modern accommodation.

---

## Licence

Two licences, because this repository holds two different kinds of work.

**The software is MIT.** The PHP application, the stylesheets, the JavaScript,
the schema, the tooling. Take it, learn from it, build on it.

**The content is CC BY-SA 4.0.** Everything written for a reader rather than for
a computer: the translations, explanations, modern examples, reflection
questions, and the interface text in all three languages. Share it and adapt it
freely, including commercially — but credit it, and keep your version open under
the same terms. This is months of original writing and it is the actual product;
ShareAlike is what stops somebody closing it.

The Sanskrit source is ancient and in the public domain. No published translation
by anyone else appears here — every rendering in this project was written for it.

Full detail, including the bundled OFL fonts and how to tell software from
content in a file that contains both, is in [LICENSE](LICENSE).
