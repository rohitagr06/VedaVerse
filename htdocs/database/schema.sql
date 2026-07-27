-- =====================================================================
-- VedaVerse — database/schema.sql
-- ---------------------------------------------------------------------
-- The complete database structure for VedaVerse.
--
-- HOW THIS FILE IS USED
--   install.php reads this file, splits it into individual statements at
--   each semicolon that ends a line, and runs them ONE AT A TIME so it can
--   report pass/fail for every single statement in the browser. That means:
--
--     * every statement must end with a semicolon on its own line-end
--     * there must be NO semicolons inside string literals in this file
--     * no stored procedures, no triggers, no DELIMITER blocks
--
--   Keep those three rules if you ever edit this file by hand.
--
-- CONVENTIONS USED THROUGHOUT
--   * Engine InnoDB everywhere (we need foreign keys and transactions).
--   * utf8mb4 / utf8mb4_unicode_ci everywhere. This is what makes
--     Devanagari (देवनागरी) store and read back correctly instead of ????.
--   * VARCHAR columns that carry a UNIQUE key or a plain INDEX are capped
--     at 191 characters. Reason: on older MySQL (5.6/5.7 with the default
--     row format) one index entry may not exceed 767 bytes, and utf8mb4
--     uses up to 4 bytes per character. 191 x 4 = 764 bytes. Staying at or
--     below 191 means the schema installs on old and new MySQL alike.
--   * Every three-language field appears as three columns with the same
--     name plus _en, _hi and _hinglish. There is no separate translation
--     table: three fixed languages is a resolved decision, and three
--     columns read far more simply for a beginner than an EAV join.
--   * "session_id" columns hold the durable anonymous token (see the
--     sessions table note) and are deliberately NOT foreign keys, so that a
--     guest's bookmarks and notes survive their session row expiring.
--   * ON DELETE CASCADE is used only where the child row is meaningless
--     without its parent (a verse's word meanings, for example). Anything
--     that represents a human action (a forum post, an audit log) uses
--     SET NULL or RESTRICT so history is never silently destroyed.
--
-- SCHEMA VERSION
--   Tracked as the "schema_version" row in the settings table, seeded at
--   the bottom of this file. Bump it in the same commit as any migration.
-- =====================================================================


-- =====================================================================
-- SECTION 1 — IDENTITY AND ACCESS
-- =====================================================================

-- Every human account. Note: email is stored but NEVER mailed to.
-- VedaVerse sends no email at all (the host blocks it), so account recovery
-- runs on the one-time recovery code stored as recovery_code_hash.
CREATE TABLE IF NOT EXISTS users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  uuid CHAR(36) NOT NULL COMMENT 'Public-facing id. Never expose the numeric id in a URL.',
  name VARCHAR(120) NOT NULL,
  email VARCHAR(191) NOT NULL COMMENT 'Stored for identification only. Nothing is ever sent to it.',
  password_hash VARCHAR(255) NOT NULL COMMENT 'bcrypt, cost 10. Never readable, never logged.',
  recovery_code_hash VARCHAR(255) DEFAULT NULL COMMENT 'Hash of the 12-character code shown once at signup.',
  recovery_code_issued_at DATETIME DEFAULT NULL,
  role ENUM('user','moderator','admin','superadmin') NOT NULL DEFAULT 'user',
  status ENUM('active','suspended','deleted') NOT NULL DEFAULT 'active',
  preferred_lang ENUM('en','hi','hinglish') NOT NULL DEFAULT 'en',
  track ENUM('beginner','intermediate','advanced') NOT NULL DEFAULT 'beginner',
  xp INT UNSIGNED NOT NULL DEFAULT 0,
  level SMALLINT UNSIGNED NOT NULL DEFAULT 1,
  streak_current SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  streak_longest SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  streak_freezes SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'One is granted per week so a single missed day does not wipe a long streak.',
  streak_freeze_granted_on DATE DEFAULT NULL,
  last_active_date DATE DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  last_login DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_users_email (email),
  UNIQUE KEY uq_users_uuid (uuid),
  KEY ix_users_role_status (role, status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Display-side profile. Split from users so the hot login query stays small.
CREATE TABLE IF NOT EXISTS user_profiles (
  user_id INT UNSIGNED NOT NULL,
  avatar VARCHAR(191) DEFAULT NULL,
  bio VARCHAR(500) DEFAULT NULL,
  country VARCHAR(80) DEFAULT NULL,
  theme ENUM('system','light','dark') NOT NULL DEFAULT 'system',
  font_size TINYINT UNSIGNED NOT NULL DEFAULT 2 COMMENT 'One of four steps: 1 small, 2 default, 3 large, 4 largest.',
  reading_mode ENUM('learn','study','research','quick','focus') NOT NULL DEFAULT 'learn',
  certificate_name VARCHAR(160) DEFAULT NULL COMMENT 'The name printed on a certificate, which may differ from the display name.',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id),
  CONSTRAINT fk_user_profiles_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Behaviour toggles. Defaults are deliberately privacy-favouring.
CREATE TABLE IF NOT EXISTS user_settings (
  user_id INT UNSIGNED NOT NULL,
  dark_mode TINYINT(1) NOT NULL DEFAULT 0,
  ai_response_length ENUM('short','medium','long') NOT NULL DEFAULT 'medium',
  accessibility_mode TINYINT(1) NOT NULL DEFAULT 0,
  reduced_motion TINYINT(1) NOT NULL DEFAULT 0,
  offline_sync TINYINT(1) NOT NULL DEFAULT 1,
  public_profile TINYINT(1) NOT NULL DEFAULT 0,
  show_certificates TINYINT(1) NOT NULL DEFAULT 0,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id),
  CONSTRAINT fk_user_settings_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- One row per browser session, logged in or not.
--
-- IMPORTANT, and easy to get wrong: anon_token is the DURABLE guest
-- identity. It lives in a long-lived cookie and it is what every guest
-- bookmark, note, quiz attempt and progress row is tagged with. The
-- session row itself may expire and be cleaned up long before the guest
-- comes back. That is why other tables store the token in a plain
-- "session_id" column with no foreign key: expiring a session must never
-- delete a guest's work. On registration AuthService rewrites those rows
-- to the new user_id inside a transaction.
CREATE TABLE IF NOT EXISTS sessions (
  id VARCHAR(64) NOT NULL COMMENT 'Hash of the PHP session id. The raw id is never stored.',
  user_id INT UNSIGNED DEFAULT NULL,
  anon_token VARCHAR(64) DEFAULT NULL COMMENT 'Durable guest identity. Survives this row.',
  ip_hash CHAR(64) DEFAULT NULL COMMENT 'SHA-256 of IP plus app pepper. Raw IPs are never stored.',
  user_agent_hash CHAR(64) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_seen_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  expires_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  KEY ix_sessions_user (user_id),
  KEY ix_sessions_anon (anon_token),
  KEY ix_sessions_expires (expires_at),
  CONSTRAINT fk_sessions_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Recovery-code redemptions. No email is involved anywhere in this flow.
CREATE TABLE IF NOT EXISTS password_resets (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL,
  code_hash VARCHAR(255) NOT NULL,
  expires_at DATETIME NOT NULL,
  used_at DATETIME DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_password_resets_user (user_id, used_at),
  CONSTRAINT fk_password_resets_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Failed-attempt counter for login, recovery, admin login, posting, search.
-- Keyed by a hashed identifier so no raw IP or email is ever stored here.
CREATE TABLE IF NOT EXISTS login_attempts (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  identifier_hash CHAR(64) NOT NULL COMMENT 'Hash of scope plus email or IP.',
  scope VARCHAR(40) NOT NULL DEFAULT 'login',
  attempted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  succeeded TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY ix_login_attempts_lookup (identifier_hash, attempted_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- =====================================================================
-- SECTION 2 — CONTENT
-- =====================================================================

CREATE TABLE IF NOT EXISTS chapters (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  chapter_number TINYINT UNSIGNED NOT NULL,
  sanskrit_name VARCHAR(150) NOT NULL COMMENT 'Devanagari.',
  transliteration VARCHAR(150) NOT NULL,
  title_en VARCHAR(191) NOT NULL,
  title_hi VARCHAR(191) NOT NULL,
  title_hinglish VARCHAR(191) NOT NULL,
  subtitle_en VARCHAR(255) DEFAULT NULL,
  subtitle_hi VARCHAR(255) DEFAULT NULL,
  subtitle_hinglish VARCHAR(255) DEFAULT NULL,
  summary_en TEXT,
  summary_hi TEXT,
  summary_hinglish TEXT,
  theme VARCHAR(120) DEFAULT NULL,
  difficulty ENUM('beginner','intermediate','advanced') NOT NULL DEFAULT 'beginner',
  estimated_minutes SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  verse_count SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  cover_slug VARCHAR(120) DEFAULT NULL,
  sort_order SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 0,
  created_by INT UNSIGNED DEFAULT NULL,
  edited_by INT UNSIGNED DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_chapters_number (chapter_number),
  KEY ix_chapters_published (published, sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- is_curated = 1 means the verse is fully written in all three languages.
-- is_curated = 0 means it exists as Sanskrit plus transliteration plus one
-- translation, so the admin can promote it later without a migration.
CREATE TABLE IF NOT EXISTS verses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  chapter_id INT UNSIGNED NOT NULL,
  verse_number SMALLINT UNSIGNED NOT NULL,
  global_order SMALLINT UNSIGNED NOT NULL COMMENT 'Position across the whole text, 1 upward. Used for next/previous.',
  is_curated TINYINT(1) NOT NULL DEFAULT 0,
  slug VARCHAR(191) NOT NULL,
  sanskrit_devanagari TEXT NOT NULL,
  transliteration_iast TEXT,
  transliteration_simple TEXT COMMENT 'Diacritic-free version for readers who cannot parse IAST.',
  translation_literal TEXT,
  translation_en TEXT,
  translation_hi TEXT,
  translation_hinglish TEXT,
  summary_en TEXT,
  summary_hi TEXT,
  summary_hinglish TEXT,
  difficulty ENUM('beginner','intermediate','advanced') NOT NULL DEFAULT 'beginner',
  seo_title VARCHAR(191) DEFAULT NULL,
  seo_description VARCHAR(320) DEFAULT NULL,
  published TINYINT(1) NOT NULL DEFAULT 0,
  created_by INT UNSIGNED DEFAULT NULL,
  edited_by INT UNSIGNED DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_verses_chapter_verse (chapter_id, verse_number),
  UNIQUE KEY uq_verses_slug (slug),
  KEY ix_verses_global_order (global_order),
  KEY ix_verses_curated (is_curated, published),
  CONSTRAINT fk_verses_chapter FOREIGN KEY (chapter_id) REFERENCES chapters (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- FULLTEXT lives in its own statement so that if a very old MySQL rejects
-- it, install.php reports one failed line instead of failing table creation.
-- Search degrades to topic and tag matching without it.
ALTER TABLE verses ADD FULLTEXT KEY ft_verses_text (translation_en, summary_en);

CREATE TABLE IF NOT EXISTS verse_word_meanings (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  verse_id INT UNSIGNED NOT NULL,
  word_order SMALLINT UNSIGNED NOT NULL,
  devanagari VARCHAR(150) NOT NULL,
  transliteration VARCHAR(150) DEFAULT NULL,
  meaning_en VARCHAR(400) DEFAULT NULL,
  meaning_hi VARCHAR(400) DEFAULT NULL,
  meaning_hinglish VARCHAR(400) DEFAULT NULL,
  grammar VARCHAR(200) DEFAULT NULL,
  root_word VARCHAR(150) DEFAULT NULL,
  notes VARCHAR(500) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_word_meanings_order (verse_id, word_order),
  CONSTRAINT fk_word_meanings_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- One row per level per verse: beginner, intermediate, advanced.
CREATE TABLE IF NOT EXISTS verse_explanations (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  verse_id INT UNSIGNED NOT NULL,
  level ENUM('beginner','intermediate','advanced') NOT NULL,
  historical_context_en TEXT,
  historical_context_hi TEXT,
  historical_context_hinglish TEXT,
  philosophical_context_en TEXT,
  philosophical_context_hi TEXT,
  philosophical_context_hinglish TEXT,
  practical_meaning_en TEXT,
  practical_meaning_hi TEXT,
  practical_meaning_hinglish TEXT,
  modern_interpretation_en TEXT,
  modern_interpretation_hi TEXT,
  modern_interpretation_hinglish TEXT,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_explanations_verse_level (verse_id, level),
  CONSTRAINT fk_explanations_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Traditional viewpoints, presented side by side and never ranked.
-- There is deliberately no "is_correct" or "weight" column here. Adding one
-- would be a content-policy violation, not just a schema change.
CREATE TABLE IF NOT EXISTS verse_commentaries (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  verse_id INT UNSIGNED NOT NULL,
  viewpoint_label VARCHAR(150) NOT NULL,
  position_summary_en TEXT,
  position_summary_hi TEXT,
  position_summary_hinglish TEXT,
  agreement_notes TEXT COMMENT 'What this viewpoint shares with the others.',
  difference_notes TEXT COMMENT 'Where it genuinely differs. State it plainly, do not adjudicate.',
  sort_order SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY ix_commentaries_verse (verse_id, sort_order),
  CONSTRAINT fk_commentaries_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- The Modern Context blocks. 8 to 12 per curated verse, five-plus categories.
-- source_reference is plain text ("Lagaan, 2001"). Never store dialogue.
CREATE TABLE IF NOT EXISTS modern_examples (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  verse_id INT UNSIGNED NOT NULL,
  category ENUM(
    'bollywood','cricket','sports','politics','corporate','startup',
    'leadership','relationships','marriage','parenting','school',
    'college','social_media','technology','ai','healthcare',
    'military','finance','friendship','ethics','everyday_life'
  ) NOT NULL,
  title_en VARCHAR(191) NOT NULL,
  title_hi VARCHAR(191) DEFAULT NULL,
  title_hinglish VARCHAR(191) DEFAULT NULL,
  scenario_en TEXT,
  scenario_hi TEXT,
  scenario_hinglish TEXT,
  connection_en TEXT,
  connection_hi TEXT,
  connection_hinglish TEXT,
  lesson_en VARCHAR(500) DEFAULT NULL,
  lesson_hi VARCHAR(500) DEFAULT NULL,
  lesson_hinglish VARCHAR(500) DEFAULT NULL,
  reflection_en VARCHAR(500) DEFAULT NULL,
  reflection_hi VARCHAR(500) DEFAULT NULL,
  reflection_hinglish VARCHAR(500) DEFAULT NULL,
  source_reference VARCHAR(191) DEFAULT NULL COMMENT 'Film, match or event NAME only. Never dialogue or lyrics.',
  has_spoiler TINYINT(1) NOT NULL DEFAULT 0,
  difficulty ENUM('beginner','intermediate','advanced') NOT NULL DEFAULT 'beginner',
  tags VARCHAR(500) DEFAULT NULL COMMENT 'Comma-separated searchable keywords.',
  is_ai_generated TINYINT(1) NOT NULL DEFAULT 0,
  approved TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Nothing AI-generated is visible until an admin sets this to 1.',
  created_by INT UNSIGNED DEFAULT NULL,
  edited_by INT UNSIGNED DEFAULT NULL,
  sort_order SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_examples_verse_approved (verse_id, approved),
  KEY ix_examples_category (category, approved),
  CONSTRAINT fk_examples_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- "Remember This": the one line the learner should still have a year later.
CREATE TABLE IF NOT EXISTS verse_memory_aids (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  verse_id INT UNSIGNED NOT NULL,
  hook_en VARCHAR(200) DEFAULT NULL COMMENT 'Twenty words maximum. Enforced in the service layer, not here.',
  hook_hi VARCHAR(200) DEFAULT NULL,
  hook_hinglish VARCHAR(200) DEFAULT NULL,
  analogy_en TEXT,
  analogy_hi TEXT,
  analogy_hinglish TEXT,
  visual_cue VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_memory_aids_verse (verse_id),
  CONSTRAINT fk_memory_aids_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS verse_reflections (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  verse_id INT UNSIGNED NOT NULL,
  question_en VARCHAR(500) DEFAULT NULL,
  question_hi VARCHAR(500) DEFAULT NULL,
  question_hinglish VARCHAR(500) DEFAULT NULL,
  display_order SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY ix_reflections_verse (verse_id, display_order),
  CONSTRAINT fk_reflections_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS verse_practices (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  verse_id INT UNSIGNED NOT NULL,
  action_en VARCHAR(500) DEFAULT NULL,
  action_hi VARCHAR(500) DEFAULT NULL,
  action_hinglish VARCHAR(500) DEFAULT NULL,
  estimated_minutes SMALLINT UNSIGNED NOT NULL DEFAULT 5,
  difficulty ENUM('beginner','intermediate','advanced') NOT NULL DEFAULT 'beginner',
  display_order SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY ix_practices_verse (verse_id, display_order),
  CONSTRAINT fk_practices_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- This table is how future texts get absorbed as DATA rather than as a
-- schema change. Ramayana, Upanishads, Chanakya and modern writers all fit
-- here already: add a reference_type value, add rows, ship nothing new.
CREATE TABLE IF NOT EXISTS verse_cross_references (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  verse_id INT UNSIGNED NOT NULL,
  reference_type ENUM('gita','mahabharata','ramayana','upanishad','yoga_sutra','chanakya','gandhi','modern') NOT NULL,
  book VARCHAR(150) DEFAULT NULL,
  chapter VARCHAR(40) DEFAULT NULL,
  verse VARCHAR(40) DEFAULT NULL,
  target_verse_id INT UNSIGNED DEFAULT NULL COMMENT 'Set only when reference_type is gita, so internal links resolve.',
  description_en TEXT,
  description_hi TEXT,
  description_hinglish TEXT,
  relationship ENUM('same','opposite','supports','story','term') NOT NULL DEFAULT 'supports',
  sort_order SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY ix_xref_verse (verse_id, reference_type),
  KEY ix_xref_target (target_verse_id),
  CONSTRAINT fk_xref_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE CASCADE,
  CONSTRAINT fk_xref_target FOREIGN KEY (target_verse_id) REFERENCES verses (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- is_life_problem = 1 turns a topic into a front-door /problem/<slug> page.
CREATE TABLE IF NOT EXISTS topics (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name_en VARCHAR(150) NOT NULL,
  name_hi VARCHAR(150) DEFAULT NULL,
  name_hinglish VARCHAR(150) DEFAULT NULL,
  slug VARCHAR(191) NOT NULL,
  description_en TEXT,
  description_hi TEXT,
  description_hinglish TEXT,
  is_life_problem TINYINT(1) NOT NULL DEFAULT 0,
  icon VARCHAR(80) DEFAULT NULL,
  sort_order SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  published TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_topics_slug (slug),
  KEY ix_topics_problem (is_life_problem, sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS verse_topics (
  verse_id INT UNSIGNED NOT NULL,
  topic_id INT UNSIGNED NOT NULL,
  relevance TINYINT UNSIGNED NOT NULL DEFAULT 5 COMMENT '1 to 10. Drives ordering on a problem page.',
  PRIMARY KEY (verse_id, topic_id),
  KEY ix_verse_topics_topic (topic_id, relevance),
  CONSTRAINT fk_verse_topics_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE CASCADE,
  CONSTRAINT fk_verse_topics_topic FOREIGN KEY (topic_id) REFERENCES topics (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- The concept graph. "Comparison" relates to "jealousy" relates to "self-worth".
CREATE TABLE IF NOT EXISTS topic_relations (
  topic_id INT UNSIGNED NOT NULL,
  related_topic_id INT UNSIGNED NOT NULL,
  relation_type ENUM('related','causes','caused_by','opposite','narrower','broader') NOT NULL DEFAULT 'related',
  strength TINYINT UNSIGNED NOT NULL DEFAULT 5,
  PRIMARY KEY (topic_id, related_topic_id),
  KEY ix_topic_relations_related (related_topic_id),
  CONSTRAINT fk_topic_relations_topic FOREIGN KEY (topic_id) REFERENCES topics (id) ON DELETE CASCADE,
  CONSTRAINT fk_topic_relations_related FOREIGN KEY (related_topic_id) REFERENCES topics (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- =====================================================================
-- SECTION 3 — LEARNING
-- =====================================================================

CREATE TABLE IF NOT EXISTS quizzes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  chapter_id INT UNSIGNED DEFAULT NULL,
  verse_id INT UNSIGNED DEFAULT NULL,
  title_en VARCHAR(191) NOT NULL,
  title_hi VARCHAR(191) DEFAULT NULL,
  title_hinglish VARCHAR(191) DEFAULT NULL,
  type ENUM('verse','chapter','topic','review','placement') NOT NULL DEFAULT 'verse',
  passing_score TINYINT UNSIGNED NOT NULL DEFAULT 70 COMMENT 'Percentage.',
  time_limit SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Seconds. 0 means untimed.',
  published TINYINT(1) NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_quizzes_chapter (chapter_id, published),
  KEY ix_quizzes_verse (verse_id, published),
  CONSTRAINT fk_quizzes_chapter FOREIGN KEY (chapter_id) REFERENCES chapters (id) ON DELETE CASCADE,
  CONSTRAINT fk_quizzes_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Every question carries an explanation, shown whether the learner was
-- right or wrong. "Incorrect." on its own is never acceptable output.
CREATE TABLE IF NOT EXISTS quiz_questions (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  quiz_id INT UNSIGNED NOT NULL,
  kind ENUM('mcq','true_false','fill_blank','scenario','flashcard') NOT NULL DEFAULT 'mcq',
  prompt_en TEXT NOT NULL,
  prompt_hi TEXT,
  prompt_hinglish TEXT,
  explanation_en TEXT,
  explanation_hi TEXT,
  explanation_hinglish TEXT,
  answer_text VARCHAR(255) DEFAULT NULL COMMENT 'Expected answer for fill_blank. Compared case-insensitively, server side only.',
  difficulty ENUM('beginner','intermediate','advanced') NOT NULL DEFAULT 'beginner',
  points TINYINT UNSIGNED NOT NULL DEFAULT 1,
  sort_order SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY ix_questions_quiz (quiz_id, sort_order),
  CONSTRAINT fk_questions_quiz FOREIGN KEY (quiz_id) REFERENCES quizzes (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS quiz_options (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  question_id INT UNSIGNED NOT NULL,
  label_en VARCHAR(500) NOT NULL,
  label_hi VARCHAR(500) DEFAULT NULL,
  label_hinglish VARCHAR(500) DEFAULT NULL,
  is_correct TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Never sent to the browser before submission.',
  sort_order SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY ix_options_question (question_id, sort_order),
  CONSTRAINT fk_options_question FOREIGN KEY (question_id) REFERENCES quiz_questions (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS quiz_attempts (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED DEFAULT NULL,
  session_id VARCHAR(64) DEFAULT NULL COMMENT 'Guest anon_token. See the sessions table note.',
  quiz_id INT UNSIGNED NOT NULL,
  score SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  max_score SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  duration_seconds SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  answers_json MEDIUMTEXT COMMENT 'What the learner chose. Server-graded result only.',
  taken_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_attempts_user (user_id, taken_at),
  KEY ix_attempts_session (session_id, taken_at),
  KEY ix_attempts_quiz (quiz_id),
  CONSTRAINT fk_attempts_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_attempts_quiz FOREIGN KEY (quiz_id) REFERENCES quizzes (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS user_progress (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED DEFAULT NULL,
  session_id VARCHAR(64) DEFAULT NULL,
  verse_id INT UNSIGNED NOT NULL,
  chapter_id INT UNSIGNED NOT NULL,
  status ENUM('locked','unlocked','learning','mastered') NOT NULL DEFAULT 'unlocked',
  completion_percentage TINYINT UNSIGNED NOT NULL DEFAULT 0,
  quiz_score TINYINT UNSIGNED DEFAULT NULL,
  last_read DATETIME DEFAULT NULL,
  mastered_at DATETIME DEFAULT NULL,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_progress_user_verse (user_id, verse_id),
  KEY ix_progress_user_chapter (user_id, chapter_id),
  KEY ix_progress_session (session_id, verse_id),
  CONSTRAINT fk_progress_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_progress_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE CASCADE,
  CONSTRAINT fk_progress_chapter FOREIGN KEY (chapter_id) REFERENCES chapters (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- SM-2 spaced repetition state. Due cards are computed on page load, never
-- by cron, because the host has no cron.
CREATE TABLE IF NOT EXISTS user_reviews (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED DEFAULT NULL,
  session_id VARCHAR(64) DEFAULT NULL,
  verse_id INT UNSIGNED NOT NULL,
  ease_factor DECIMAL(4,2) NOT NULL DEFAULT 2.50 COMMENT 'Standard SM-2 ease. Floored at 1.30.',
  interval_days SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  repetitions SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  due_date DATE NOT NULL,
  last_grade TINYINT UNSIGNED DEFAULT NULL COMMENT '0 to 5.',
  last_reviewed_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_reviews_user_verse (user_id, verse_id),
  KEY ix_reviews_user_due (user_id, due_date),
  KEY ix_reviews_session_due (session_id, due_date),
  CONSTRAINT fk_reviews_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_reviews_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- criteria_json drives evaluation, so a new badge is a database row and
-- not a code change. BadgeService reads it on every progress write.
CREATE TABLE IF NOT EXISTS achievements (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  code VARCHAR(80) NOT NULL,
  name_en VARCHAR(150) NOT NULL,
  name_hi VARCHAR(150) DEFAULT NULL,
  name_hinglish VARCHAR(150) DEFAULT NULL,
  description_en VARCHAR(500) DEFAULT NULL,
  description_hi VARCHAR(500) DEFAULT NULL,
  description_hinglish VARCHAR(500) DEFAULT NULL,
  icon VARCHAR(80) DEFAULT NULL,
  category ENUM('consistency','coverage','depth','curiosity','community') NOT NULL DEFAULT 'consistency',
  criteria_json TEXT COMMENT 'Machine-readable rule, for example {"type":"streak","value":7}.',
  sort_order SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  active TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  UNIQUE KEY uq_achievements_code (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS user_achievements (
  user_id INT UNSIGNED NOT NULL,
  achievement_id INT UNSIGNED NOT NULL,
  earned_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, achievement_id),
  KEY ix_user_achievements_time (user_id, earned_at),
  CONSTRAINT fk_user_achievements_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_user_achievements_achievement FOREIGN KEY (achievement_id) REFERENCES achievements (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- certificate_id is the public identifier printed on the PDF and typed into
-- the verification page. The numeric id never appears anywhere public.
CREATE TABLE IF NOT EXISTS certificates (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL,
  certificate_id VARCHAR(40) NOT NULL,
  scope VARCHAR(191) NOT NULL DEFAULT 'Complete Course',
  issued_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  name_on_certificate VARCHAR(160) NOT NULL,
  revoked TINYINT(1) NOT NULL DEFAULT 0,
  revoked_reason VARCHAR(255) DEFAULT NULL,
  pdf_path VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_certificates_public_id (certificate_id),
  KEY ix_certificates_user (user_id),
  CONSTRAINT fk_certificates_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- =====================================================================
-- SECTION 4 — PERSONAL
-- =====================================================================

CREATE TABLE IF NOT EXISTS bookmarks (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED DEFAULT NULL,
  session_id VARCHAR(64) DEFAULT NULL,
  target_type ENUM('verse','chapter','topic','forum','chat') NOT NULL DEFAULT 'verse',
  target_id INT UNSIGNED NOT NULL,
  note VARCHAR(500) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_bookmarks_user_target (user_id, target_type, target_id),
  KEY ix_bookmarks_session (session_id, target_type),
  CONSTRAINT fk_bookmarks_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS notes (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED DEFAULT NULL,
  session_id VARCHAR(64) DEFAULT NULL,
  verse_id INT UNSIGNED DEFAULT NULL,
  content TEXT,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_notes_user (user_id, updated_at),
  KEY ix_notes_session (session_id, updated_at),
  KEY ix_notes_verse (verse_id),
  CONSTRAINT fk_notes_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_notes_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS recent_views (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED DEFAULT NULL,
  session_id VARCHAR(64) DEFAULT NULL,
  verse_id INT UNSIGNED NOT NULL,
  viewed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_recent_user (user_id, viewed_at),
  KEY ix_recent_session (session_id, viewed_at),
  CONSTRAINT fk_recent_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_recent_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS saved_searches (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL,
  query VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_saved_searches_user (user_id, created_at),
  CONSTRAINT fk_saved_searches_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- =====================================================================
-- SECTION 5 — CHAT (SARATHI)
-- =====================================================================

CREATE TABLE IF NOT EXISTS chat_sessions (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED DEFAULT NULL,
  session_id VARCHAR(64) DEFAULT NULL,
  title VARCHAR(191) DEFAULT NULL COMMENT 'Auto-titled from the first user message. Renameable.',
  provider ENUM('github','gemini','static') DEFAULT NULL COMMENT 'Provider of the most recent reply.',
  started_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_message_at DATETIME DEFAULT NULL,
  message_count SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY ix_chat_sessions_user (user_id, last_message_at),
  KEY ix_chat_sessions_session (session_id, last_message_at),
  CONSTRAINT fk_chat_sessions_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- provider is written on every assistant message so the admin dashboard can
-- show the real fallback rate rather than a guess.
CREATE TABLE IF NOT EXISTS chat_messages (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  chat_session_id INT UNSIGNED NOT NULL,
  role ENUM('user','assistant','system') NOT NULL,
  content MEDIUMTEXT NOT NULL,
  model_used VARCHAR(120) DEFAULT NULL,
  provider ENUM('github','gemini','static') DEFAULT NULL,
  tokens_estimated INT UNSIGNED DEFAULT NULL,
  latency_ms INT UNSIGNED DEFAULT NULL,
  is_saved TINYINT(1) NOT NULL DEFAULT 0,
  flagged TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Admin marked this answer as bad during AI review.',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_chat_messages_session (chat_session_id, created_at),
  CONSTRAINT fk_chat_messages_session FOREIGN KEY (chat_session_id) REFERENCES chat_sessions (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Mirrors the Worker's KV counters so the interface can show remaining
-- quota BEFORE the learner hits a wall, rather than after.
CREATE TABLE IF NOT EXISTS ai_usage (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_key VARCHAR(64) NOT NULL COMMENT 'User uuid, or a hash of the anonymous token.',
  day DATE NOT NULL,
  hour_bucket TINYINT UNSIGNED NOT NULL DEFAULT 0,
  count SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY uq_ai_usage_key_day_hour (user_key, day, hour_bucket),
  KEY ix_ai_usage_day (day)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS prompt_templates (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  code VARCHAR(80) NOT NULL,
  name VARCHAR(150) NOT NULL,
  template_text MEDIUMTEXT NOT NULL,
  version SMALLINT UNSIGNED NOT NULL DEFAULT 1,
  active TINYINT(1) NOT NULL DEFAULT 1,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_prompt_templates_code_version (code, version)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Answers an admin promoted out of chat review into the offline responder.
CREATE TABLE IF NOT EXISTS static_responses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  intent VARCHAR(80) NOT NULL,
  pattern VARCHAR(255) NOT NULL COMMENT 'Keyword list the browser matches against when offline.',
  verse_id INT UNSIGNED DEFAULT NULL,
  response_en TEXT,
  response_hi TEXT,
  response_hinglish TEXT,
  active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_static_responses_intent (intent, active),
  CONSTRAINT fk_static_responses_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- =====================================================================
-- SECTION 6 — COMMUNITY (PRE-MODERATED)
-- =====================================================================

CREATE TABLE IF NOT EXISTS forum_categories (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name_en VARCHAR(150) NOT NULL,
  name_hi VARCHAR(150) DEFAULT NULL,
  name_hinglish VARCHAR(150) DEFAULT NULL,
  slug VARCHAR(191) NOT NULL,
  description_en VARCHAR(500) DEFAULT NULL,
  description_hi VARCHAR(500) DEFAULT NULL,
  description_hinglish VARCHAR(500) DEFAULT NULL,
  sort_order SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  is_locked TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY uq_forum_categories_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- status defaults to pending. Nothing is public until a human sets it to
-- approved. ai_flag_score only SORTS the admin queue, it never gates.
CREATE TABLE IF NOT EXISTS forum_threads (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  category_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED DEFAULT NULL COMMENT 'NULL after account deletion. Authorship is anonymised, threads are not orphaned.',
  verse_id INT UNSIGNED DEFAULT NULL,
  slug VARCHAR(191) NOT NULL,
  title VARCHAR(191) NOT NULL,
  body MEDIUMTEXT NOT NULL,
  status ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  ai_flag_score TINYINT UNSIGNED DEFAULT NULL COMMENT '0 to 100, or NULL when the Worker was unreachable.',
  ai_flag_reason VARCHAR(255) DEFAULT NULL,
  reviewed_by INT UNSIGNED DEFAULT NULL,
  reviewed_at DATETIME DEFAULT NULL,
  reject_reason VARCHAR(500) DEFAULT NULL,
  reply_count SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_forum_threads_slug (slug),
  KEY ix_forum_threads_status (status, created_at),
  KEY ix_forum_threads_category (category_id, status, created_at),
  KEY ix_forum_threads_user (user_id),
  KEY ix_forum_threads_queue (status, ai_flag_score),
  CONSTRAINT fk_forum_threads_category FOREIGN KEY (category_id) REFERENCES forum_categories (id) ON DELETE CASCADE,
  CONSTRAINT fk_forum_threads_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL,
  CONSTRAINT fk_forum_threads_verse FOREIGN KEY (verse_id) REFERENCES verses (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS forum_posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  thread_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED DEFAULT NULL,
  body MEDIUMTEXT NOT NULL,
  status ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  ai_flag_score TINYINT UNSIGNED DEFAULT NULL,
  ai_flag_reason VARCHAR(255) DEFAULT NULL,
  reviewed_by INT UNSIGNED DEFAULT NULL,
  reviewed_at DATETIME DEFAULT NULL,
  reject_reason VARCHAR(500) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_forum_posts_thread (thread_id, status, created_at),
  KEY ix_forum_posts_queue (status, ai_flag_score),
  KEY ix_forum_posts_user (user_id),
  CONSTRAINT fk_forum_posts_thread FOREIGN KEY (thread_id) REFERENCES forum_threads (id) ON DELETE CASCADE,
  CONSTRAINT fk_forum_posts_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS reports (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  reporter_id INT UNSIGNED DEFAULT NULL,
  target_type ENUM('thread','post','chat','example','user') NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  reason VARCHAR(500) NOT NULL,
  status ENUM('open','actioned','dismissed') NOT NULL DEFAULT 'open',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_reports_status (status, created_at),
  KEY ix_reports_target (target_type, target_id),
  CONSTRAINT fk_reports_reporter FOREIGN KEY (reporter_id) REFERENCES users (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS moderation_log (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  moderator_id INT UNSIGNED DEFAULT NULL,
  target_type ENUM('thread','post','chat','example','user') NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  action VARCHAR(60) NOT NULL,
  reason VARCHAR(500) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_moderation_log_target (target_type, target_id),
  KEY ix_moderation_log_time (created_at),
  CONSTRAINT fk_moderation_log_moderator FOREIGN KEY (moderator_id) REFERENCES users (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- =====================================================================
-- SECTION 7 — SYSTEM
-- =====================================================================

CREATE TABLE IF NOT EXISTS settings (
  setting_key VARCHAR(120) NOT NULL COMMENT 'Named setting_key, not key, because KEY is reserved in MySQL.',
  setting_value TEXT,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (setting_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Third of the four cache layers: browser, then file, then this table, then
-- in-process memory. Expired rows are purged opportunistically, on roughly
-- one request in fifty, never on every hit.
CREATE TABLE IF NOT EXISTS cache (
  cache_key VARCHAR(191) NOT NULL,
  cache_value LONGTEXT,
  expires_at DATETIME NOT NULL,
  PRIMARY KEY (cache_key),
  KEY ix_cache_expires (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS search_logs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  query VARCHAR(255) NOT NULL,
  results_count SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  user_type ENUM('guest','user','admin') NOT NULL DEFAULT 'guest',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_search_logs_time (created_at),
  KEY ix_search_logs_query (query)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS popular_searches (
  query VARCHAR(191) NOT NULL,
  count INT UNSIGNED NOT NULL DEFAULT 1,
  last_searched DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (query),
  KEY ix_popular_searches_count (count)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS imports (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  file_name VARCHAR(255) NOT NULL,
  type ENUM('chapters','verses','word_meanings','examples','topics','quizzes') NOT NULL,
  rows_total INT UNSIGNED NOT NULL DEFAULT 0,
  rows_ok INT UNSIGNED NOT NULL DEFAULT 0,
  rows_failed INT UNSIGNED NOT NULL DEFAULT 0,
  status ENUM('pending','preview','committed','rolled_back') NOT NULL DEFAULT 'pending',
  imported_by INT UNSIGNED DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_imports_time (created_at),
  CONSTRAINT fk_imports_user FOREIGN KEY (imported_by) REFERENCES users (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS import_errors (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  import_id INT UNSIGNED NOT NULL,
  row_number_ref INT UNSIGNED NOT NULL COMMENT 'Named row_number_ref because ROW_NUMBER is reserved in MySQL 8.',
  message VARCHAR(500) NOT NULL,
  PRIMARY KEY (id),
  KEY ix_import_errors_import (import_id),
  CONSTRAINT fk_import_errors_import FOREIGN KEY (import_id) REFERENCES imports (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Never write a password, an API key, a raw IP or full chat content here.
CREATE TABLE IF NOT EXISTS audit_logs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED DEFAULT NULL,
  action VARCHAR(80) NOT NULL,
  target_type VARCHAR(60) DEFAULT NULL,
  target_id INT UNSIGNED DEFAULT NULL,
  meta_json TEXT,
  ip_hash CHAR(64) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_audit_logs_user (user_id, created_at),
  KEY ix_audit_logs_action (action, created_at),
  CONSTRAINT fk_audit_logs_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS error_logs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  level ENUM('debug','info','notice','warning','error','critical') NOT NULL DEFAULT 'error',
  message TEXT NOT NULL,
  file VARCHAR(255) DEFAULT NULL,
  line INT UNSIGNED DEFAULT NULL,
  url VARCHAR(500) DEFAULT NULL,
  session_ref VARCHAR(64) DEFAULT NULL COMMENT 'Short reference shown on the error page so a user can quote it.',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_error_logs_level_time (level, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- In-app only. There is no email channel in this product.
CREATE TABLE IF NOT EXISTS notifications (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL,
  type VARCHAR(60) NOT NULL,
  title VARCHAR(191) NOT NULL,
  body VARCHAR(500) DEFAULT NULL,
  link VARCHAR(255) DEFAULT NULL,
  read_at DATETIME DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_notifications_user (user_id, read_at, created_at),
  CONSTRAINT fk_notifications_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS announcements (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  title_en VARCHAR(191) NOT NULL,
  title_hi VARCHAR(191) DEFAULT NULL,
  title_hinglish VARCHAR(191) DEFAULT NULL,
  body_en TEXT,
  body_hi TEXT,
  body_hinglish TEXT,
  starts_at DATETIME DEFAULT NULL,
  ends_at DATETIME DEFAULT NULL,
  active TINYINT(1) NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ix_announcements_active (active, starts_at, ends_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Makes api/progress_sync.php idempotent. The browser generates a UUID per
-- queued offline event. A duplicate insert fails on the unique key and is
-- ignored, so a flaky reconnection can never double-count a learner's work.
CREATE TABLE IF NOT EXISTS sync_events (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  event_uuid CHAR(36) NOT NULL,
  user_id INT UNSIGNED DEFAULT NULL,
  session_id VARCHAR(64) DEFAULT NULL,
  event_type VARCHAR(60) NOT NULL,
  processed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_sync_events_uuid (event_uuid),
  KEY ix_sync_events_user (user_id, processed_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Records which migration files have already run, so a later upgrade never
-- re-applies one. install.php writes the baseline row.
CREATE TABLE IF NOT EXISTS migrations (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  migration VARCHAR(191) NOT NULL,
  applied_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_migrations_name (migration)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- =====================================================================
-- SECTION 8 — BASELINE SETTINGS
-- ---------------------------------------------------------------------
-- Only the rows the application needs in order to boot. Real content lives
-- in the seed files. INSERT IGNORE means re-running this file is harmless.
-- =====================================================================

INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('schema_version', '1.0.0');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('app_version', '1.0.0');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('site_name', 'VedaVerse — The Gita, Decoded');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('default_lang', 'en');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('maintenance_mode', '0');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('worker_url', '');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('ai_enabled', '0');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('ai_limit_anon_hour', '10');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('ai_limit_anon_day', '25');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('ai_limit_user_hour', '50');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('ai_limit_user_day', '100');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('forum_enabled', '1');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('forum_min_account_age_hours', '24');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('forum_max_pending_per_user', '3');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('review_daily_cap', '20');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('certificates_enabled', '1');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('content_bundle_version', '0');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('seo_default_title', 'VedaVerse — The Gita, Decoded');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('seo_default_description', 'Learn the Bhagavad Gita as practical psychology, in English, Hindi and Hinglish. No background needed.');
INSERT IGNORE INTO settings (setting_key, setting_value) VALUES ('installed_at', '');

INSERT IGNORE INTO migrations (migration) VALUES ('0000_baseline_schema');

-- =====================================================================
-- End of schema.
-- =====================================================================
