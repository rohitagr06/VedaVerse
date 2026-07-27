-- =====================================================================
-- VedaVerse — database/DROP_ALL.sql
-- ---------------------------------------------------------------------
-- Deletes EVERY VedaVerse table so schema.sql can be run again on a clean slate.
--
-- THIS DESTROYS ALL DATA. Users, progress, notes, forum posts, everything.
-- Take a backup from the admin panel before you run it.
--
-- Foreign key checks are switched off for the duration, which is why the
-- drop order below does not have to be perfect. They are switched back on
-- at the end. If you ever run this by hand and interrupt it halfway, run
-- SET FOREIGN_KEY_CHECKS = 1 yourself before using the database again.
--
-- Same parsing rules as schema.sql: one statement per line ending, no
-- semicolons inside strings.
-- =====================================================================

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS sync_events;
DROP TABLE IF EXISTS announcements;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS error_logs;
DROP TABLE IF EXISTS audit_logs;
DROP TABLE IF EXISTS import_errors;
DROP TABLE IF EXISTS imports;
DROP TABLE IF EXISTS popular_searches;
DROP TABLE IF EXISTS search_logs;
DROP TABLE IF EXISTS cache;
DROP TABLE IF EXISTS settings;

DROP TABLE IF EXISTS moderation_log;
DROP TABLE IF EXISTS reports;
DROP TABLE IF EXISTS forum_posts;
DROP TABLE IF EXISTS forum_threads;
DROP TABLE IF EXISTS forum_categories;

DROP TABLE IF EXISTS static_responses;
DROP TABLE IF EXISTS prompt_templates;
DROP TABLE IF EXISTS ai_usage;
DROP TABLE IF EXISTS chat_messages;
DROP TABLE IF EXISTS chat_sessions;

DROP TABLE IF EXISTS saved_searches;
DROP TABLE IF EXISTS recent_views;
DROP TABLE IF EXISTS notes;
DROP TABLE IF EXISTS bookmarks;

DROP TABLE IF EXISTS certificates;
DROP TABLE IF EXISTS user_achievements;
DROP TABLE IF EXISTS achievements;
DROP TABLE IF EXISTS user_reviews;
DROP TABLE IF EXISTS user_progress;
DROP TABLE IF EXISTS quiz_attempts;
DROP TABLE IF EXISTS quiz_options;
DROP TABLE IF EXISTS quiz_questions;
DROP TABLE IF EXISTS quizzes;

DROP TABLE IF EXISTS topic_relations;
DROP TABLE IF EXISTS verse_topics;
DROP TABLE IF EXISTS topics;
DROP TABLE IF EXISTS verse_cross_references;
DROP TABLE IF EXISTS verse_practices;
DROP TABLE IF EXISTS verse_reflections;
DROP TABLE IF EXISTS verse_memory_aids;
DROP TABLE IF EXISTS modern_examples;
DROP TABLE IF EXISTS verse_commentaries;
DROP TABLE IF EXISTS verse_explanations;
DROP TABLE IF EXISTS verse_word_meanings;
DROP TABLE IF EXISTS verses;
DROP TABLE IF EXISTS chapters;

DROP TABLE IF EXISTS login_attempts;
DROP TABLE IF EXISTS password_resets;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS user_settings;
DROP TABLE IF EXISTS user_profiles;
DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS migrations;

SET FOREIGN_KEY_CHECKS = 1;
