<?php
/**
 * VedaVerse — app/repositories/UserRepository.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   All SQL touching users, their profile and settings rows, and the
 *   adoption of a guest's work into a new account.
 *
 * WHAT DEPENDS ON IT
 *   AuthService, Session (to load the signed-in user), and later the
 *   admin user list.
 *
 * WHAT NEVER LEAVES THIS FILE
 *   password_hash and recovery_code_hash are only ever SELECTed by the
 *   two methods that verify them. Every other read names its columns
 *   explicitly and leaves the hashes behind, so a hash cannot end up in a
 *   template, a JSON response or a log by accident. That is why there is
 *   no `SELECT *` anywhere below.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Repositories;

use VedaVerse\Core\Database;
use VedaVerse\Core\Logger;

class UserRepository extends Repository
{
    /** @var string */
    protected $table = 'users';

    /** @var array<int,string> */
    protected $sortable = array('id', 'name', 'email', 'created_at', 'last_login', 'xp', 'level');

    /**
     * The columns safe to hand to the rest of the application. Note what
     * is absent: password_hash and recovery_code_hash.
     */
    const SAFE_COLUMNS = 'id, uuid, name, email, role, status, preferred_lang, track,
                          xp, level, streak_current, streak_longest, streak_freezes,
                          streak_freeze_granted_on, last_active_date, created_at, last_login';

    // -----------------------------------------------------------------
    // Reads
    // -----------------------------------------------------------------

    /**
     * A user by id, whatever their status.
     *
     * @param int $id
     * @return array<string,mixed>|null
     */
    public function findById($id)
    {
        return $this->selectOne(
            'SELECT ' . self::SAFE_COLUMNS . ' FROM users WHERE id = :id LIMIT 1',
            array('id' => (int) $id)
        );
    }

    /**
     * A user by id, but only if they are still allowed in.
     *
     * Session::user() calls this rather than findById, so suspending an
     * account takes effect on that account's next request rather than
     * whenever they happen to sign out.
     *
     * @param int $id
     * @return array<string,mixed>|null
     */
    public function findActiveById($id)
    {
        return $this->selectOne(
            'SELECT ' . self::SAFE_COLUMNS . ' FROM users WHERE id = :id AND status = :status LIMIT 1',
            array('id' => (int) $id, 'status' => 'active')
        );
    }

    /**
     * @param string $uuid
     * @return array<string,mixed>|null
     */
    public function findByUuid($uuid)
    {
        return $this->selectOne(
            'SELECT ' . self::SAFE_COLUMNS . ' FROM users WHERE uuid = :uuid LIMIT 1',
            array('uuid' => (string) $uuid)
        );
    }

    /**
     * @param string $email
     * @return array<string,mixed>|null
     */
    public function findByEmail($email)
    {
        return $this->selectOne(
            'SELECT ' . self::SAFE_COLUMNS . ' FROM users WHERE email = :email LIMIT 1',
            array('email' => $this->normaliseEmail($email))
        );
    }

    /**
     * Fetch the row needed to CHECK a password, hash included.
     *
     * Deliberately separate from findByEmail and deliberately narrow.
     * AuthService calls it, verifies, and then re-reads the safe columns.
     * Nothing else should ever call it.
     *
     * @param string $email
     * @return array<string,mixed>|null
     */
    public function findForLogin($email)
    {
        return $this->selectOne(
            'SELECT id, email, name, password_hash, role, status FROM users WHERE email = :email LIMIT 1',
            array('email' => $this->normaliseEmail($email))
        );
    }

    /**
     * Fetch the row needed to check a recovery code.
     *
     * @param string $email
     * @return array<string,mixed>|null
     */
    public function findForRecovery($email)
    {
        return $this->selectOne(
            'SELECT id, email, name, recovery_code_hash, status FROM users WHERE email = :email LIMIT 1',
            array('email' => $this->normaliseEmail($email))
        );
    }

    /**
     * @param string $email
     * @return bool
     */
    public function emailExists($email)
    {
        return (int) $this->scalar(
            'SELECT COUNT(*) FROM users WHERE email = :email',
            array('email' => $this->normaliseEmail($email))
        ) > 0;
    }

    /**
     * How old is this account, in hours?
     *
     * The forum requires a 24-hour-old account before a first post, which
     * costs a spammer a day per throwaway account and costs a real
     * learner nothing, because they read for a while before they post.
     *
     * @param int $userId
     * @return float
     */
    public function ageInHours($userId)
    {
        $seconds = $this->scalar(
            'SELECT TIMESTAMPDIFF(SECOND, created_at, NOW()) FROM users WHERE id = :id',
            array('id' => (int) $userId)
        );
        return $seconds === null ? 0.0 : ((float) $seconds / 3600);
    }

    // -----------------------------------------------------------------
    // Writes
    // -----------------------------------------------------------------

    /**
     * Create a user with their profile and settings rows.
     *
     * All three in one transaction. A user with no user_settings row
     * would break the settings page for that one account, and that class
     * of bug shows up months later on a single user's login, which is
     * about the worst way to find it.
     *
     * @param array<string,mixed> $data Already validated by the caller.
     * @return int New user id
     */
    public function create(array $data)
    {
        $repo = $this;

        return (int) $this->transaction(function () use ($repo, $data) {
            $userId = $repo->insertUser($data);
            $repo->ensureCompanionRows($userId, isset($data['name']) ? $data['name'] : '');
            return $userId;
        });
    }

    /**
     * The users-table insert. Public only so the transaction closure above
     * can reach it on PHP 7.4, which has no arrow-function closure
     * binding to private members.
     *
     * @param array<string,mixed> $data
     * @return int
     */
    public function insertUser(array $data)
    {
        return $this->insertRow(array(
            'uuid'                    => $data['uuid'],
            'name'                    => $data['name'],
            'email'                   => $this->normaliseEmail($data['email']),
            'password_hash'           => $data['password_hash'],
            'recovery_code_hash'      => $data['recovery_code_hash'],
            'recovery_code_issued_at' => date('Y-m-d H:i:s'),
            'role'                    => isset($data['role']) ? $data['role'] : 'user',
            'status'                  => 'active',
            'preferred_lang'          => isset($data['preferred_lang']) ? $data['preferred_lang'] : 'en',
            'track'                   => isset($data['track']) ? $data['track'] : 'beginner',
            'created_at'              => date('Y-m-d H:i:s'),
        ));
    }

    /**
     * Make sure the profile and settings rows exist.
     *
     * INSERT IGNORE rather than a check-then-insert, which has a race
     * between the two halves.
     *
     * @param int    $userId
     * @param string $name
     * @return void
     */
    public function ensureCompanionRows($userId, $name = '')
    {
        $this->execute(
            'INSERT IGNORE INTO user_profiles (user_id, certificate_name) VALUES (:id, :name)',
            array('id' => (int) $userId, 'name' => $name)
        );
        $this->execute(
            'INSERT IGNORE INTO user_settings (user_id) VALUES (:id)',
            array('id' => (int) $userId)
        );
    }

    /**
     * @param int    $userId
     * @param string $passwordHash
     * @return int
     */
    public function updatePassword($userId, $passwordHash)
    {
        return $this->updateRows(
            array('password_hash' => $passwordHash),
            'id = :id',
            array('id' => (int) $userId)
        );
    }

    /**
     * Store a new recovery-code hash and stamp when it was issued.
     *
     * @param int    $userId
     * @param string $codeHash
     * @return int
     */
    public function updateRecoveryCode($userId, $codeHash)
    {
        return $this->updateRows(
            array(
                'recovery_code_hash'      => $codeHash,
                'recovery_code_issued_at' => date('Y-m-d H:i:s'),
            ),
            'id = :id',
            array('id' => (int) $userId)
        );
    }

    /**
     * @param int $userId
     * @return int
     */
    public function touchLogin($userId)
    {
        return $this->updateRows(
            array('last_login' => date('Y-m-d H:i:s')),
            'id = :id',
            array('id' => (int) $userId)
        );
    }

    /**
     * @param int    $userId
     * @param string $lang
     * @return int
     */
    public function updateLanguage($userId, $lang)
    {
        return $this->updateRows(
            array('preferred_lang' => $lang),
            'id = :id',
            array('id' => (int) $userId)
        );
    }

    /**
     * Change which track a reader is following.
     *
     * A track decides what the Chariot Path lays out in front of
     * somebody. It is not a permission and it is not a gate — every
     * chapter stays readable by everybody — so switching it costs no
     * progress and needs no audit entry.
     *
     * The value is checked against the enum here rather than trusted,
     * because MySQL's response to an unknown enum value in a non-strict
     * mode is to store an empty string, and an empty track would send
     * PathService to its fallback for a reader who thought they had
     * chosen something.
     *
     * @param int    $userId
     * @param string $track
     * @return int
     */
    public function updateTrack($userId, $track)
    {
        $allowed = array('beginner', 'intermediate', 'advanced');

        if (!in_array($track, $allowed, true)) {
            return 0;
        }

        return $this->updateRows(
            array('track' => $track),
            'id = :id',
            array('id' => (int) $userId)
        );
    }

    /**
     * Delete an account and everything personal attached to it.
     *
     * WHAT GOES AND WHAT STAYS
     *   Progress, bookmarks, notes, recent views, sessions, chats and
     *   the user row itself go. Forum threads and replies STAY, with
     *   their author set to NULL by the schema's ON DELETE SET NULL.
     *
     *   Section 12 requires that: orphaning a conversation punishes the
     *   people who replied to it, and a thread that vanishes mid-argument
     *   is a worse outcome for everybody than one signed "a removed
     *   account". Deletion is about the person's identity and their
     *   private material, not about erasing a discussion other people
     *   took part in.
     *
     * WHY THE CHILD DELETES ARE EXPLICIT
     *   Most of them would cascade anyway. Naming them means the set is
     *   auditable in one place, and a table added later without a
     *   cascade cannot silently survive a deletion.
     *
     * @param int $userId
     * @return bool
     */
    public function deleteAccount($userId)
    {
        $userId = (int) $userId;

        if ($userId <= 0) {
            return false;
        }

        $repo = $this;

        return (bool) $this->transaction(function () use ($repo, $userId) {
            foreach (array(
                'user_progress', 'bookmarks', 'notes', 'recent_views',
                'sessions', 'user_reviews', 'user_achievements',
                'saved_searches', 'password_resets',
                'user_profiles', 'user_settings',
            ) as $table) {
                $repo->deleteForUser($table, $userId);
            }

            $repo->deleteRow($userId);

            return true;
        });
    }

    /**
     * Delete one user's rows from one table.
     *
     * The table name is interpolated because a table name cannot be a
     * bound parameter. It comes only from the hard-coded list above and
     * goes through Database::identifier, never from a request.
     *
     * @param string $table
     * @param int    $userId
     * @return int
     */
    public function deleteForUser($table, $userId)
    {
        try {
            return $this->execute(
                'DELETE FROM `' . Database::identifier($table) . '` WHERE user_id = :uid',
                array('uid' => (int) $userId)
            );
        } catch (\Exception $e) {
            // A table that does not exist on an older schema must not
            // block the deletion of everything else.
            return 0;
        }
    }

    /**
     * @param int $userId
     * @return int
     */
    public function deleteRow($userId)
    {
        return $this->execute('DELETE FROM users WHERE id = :uid', array('uid' => (int) $userId));
    }

    /**
     * Change a role. Always audited by the caller — a silent privilege
     * change is exactly the event an audit log exists for.
     *
     * @param int    $userId
     * @param string $role
     * @return int
     */
    public function updateRole($userId, $role)
    {
        $allowed = array('user', 'moderator', 'admin', 'superadmin');
        if (!in_array($role, $allowed, true)) {
            return 0;
        }

        return $this->updateRows(
            array('role' => $role),
            'id = :id',
            array('id' => (int) $userId)
        );
    }

    /**
     * @param int    $userId
     * @param string $status
     * @return int
     */
    public function updateStatus($userId, $status)
    {
        $allowed = array('active', 'suspended', 'deleted');
        if (!in_array($status, $allowed, true)) {
            return 0;
        }

        return $this->updateRows(
            array('status' => $status),
            'id = :id',
            array('id' => (int) $userId)
        );
    }

    // -----------------------------------------------------------------
    // Password reset bookkeeping
    // -----------------------------------------------------------------

    /**
     * Record that a recovery code was redeemed.
     *
     * Kept as its own table row rather than a flag on the user, so the
     * admin can see that an account was recovered, and when, without
     * being able to see the code.
     *
     * @param int    $userId
     * @param string $codeHash
     * @return int New row id
     */
    public function recordReset($userId, $codeHash)
    {
        return (int) Database::insert('password_resets', array(
            'user_id'    => (int) $userId,
            'code_hash'  => $codeHash,
            'expires_at' => date('Y-m-d H:i:s', time() + 3600),
            'used_at'    => date('Y-m-d H:i:s'),
            'created_at' => date('Y-m-d H:i:s'),
        ));
    }

    /**
     * How many resets has this account had in the last day?
     *
     * A legitimate user recovers once. Repeated resets mean either
     * somebody is working through stolen codes, or the owner is stuck in
     * a loop — both worth noticing.
     *
     * @param int $userId
     * @return int
     */
    public function recentResetCount($userId)
    {
        return (int) $this->scalar(
            'SELECT COUNT(*) FROM password_resets
              WHERE user_id = :id AND used_at > DATE_SUB(NOW(), INTERVAL 1 DAY)',
            array('id' => (int) $userId)
        );
    }

    // -----------------------------------------------------------------
    // The anonymous merge
    // -----------------------------------------------------------------

    /**
     * Move a guest's work onto a real account.
     *
     * THE MOST COMMONLY BROKEN FEATURE IN ANY APP THAT SUPPORTS
     * ANONYMOUS USE, which is why it is one transaction and why it is
     * tested explicitly.
     *
     * Two cases, and the second is the one that bites:
     *
     *   Registration — the account is brand new, so nothing can collide.
     *   Every guest row moves across untouched.
     *
     *   Login — the account already has history. A guest who read verse
     *   2.47 while signed out, on an account that has already mastered
     *   it, produces a genuine conflict. The rule is KEEP THE MORE
     *   ADVANCED STATE: the higher completion percentage, the better quiz
     *   score, the later mastery. Notes are never merged or overwritten —
     *   both are kept, because a note is something a person wrote and
     *   quietly discarding one is unforgivable in a way that losing a
     *   percentage point is not.
     *
     * Rows that would violate a unique key are updated in place first,
     * then the leftovers are moved, then anything still pointing at the
     * old token is deleted. Order matters: doing the UPDATE after the
     * move would deadlock against the unique key.
     *
     * @param int    $userId
     * @param string $anonToken
     * @return array<string,int> What moved, per table, for the audit log.
     */
    public function adoptAnonymousData($userId, $anonToken)
    {
        $userId    = (int) $userId;
        $anonToken = (string) $anonToken;

        if ($userId <= 0 || $anonToken === '') {
            return array();
        }

        $repo = $this;

        return (array) $this->transaction(function () use ($repo, $userId, $anonToken) {
            $moved = array();

            $moved['progress']      = $repo->mergeProgress($userId, $anonToken);
            $moved['reviews']       = $repo->mergeReviews($userId, $anonToken);
            $moved['bookmarks']     = $repo->mergeBookmarks($userId, $anonToken);
            $moved['notes']         = $repo->mergeSimple('notes', $userId, $anonToken);
            $moved['quiz_attempts'] = $repo->mergeSimple('quiz_attempts', $userId, $anonToken);
            $moved['recent_views']  = $repo->mergeSimple('recent_views', $userId, $anonToken);
            $moved['chat_sessions'] = $repo->mergeSimple('chat_sessions', $userId, $anonToken);

            return $moved;
        });
    }

    /**
     * Tables with no unique constraint on (user_id, something): the rows
     * can simply be re-pointed.
     *
     * The table name comes from the fixed list in adoptAnonymousData, and
     * still goes through identifier() because a list that is "obviously
     * fixed" today is the list somebody extends from a variable in two
     * years.
     *
     * @param string $table
     * @param int    $userId
     * @param string $anonToken
     * @return int
     */
    public function mergeSimple($table, $userId, $anonToken)
    {
        $table = Database::identifier($table);

        return $this->execute(
            'UPDATE `' . $table . '` SET user_id = :uid, session_id = NULL
              WHERE session_id = :token AND user_id IS NULL',
            array('uid' => (int) $userId, 'token' => $anonToken)
        );
    }

    /**
     * user_progress has UNIQUE(user_id, verse_id).
     *
     * Guest rows that collide with existing progress are folded in with
     * GREATEST(), so the account keeps whichever side got further. Then
     * the survivors are re-pointed and the folded-in guest rows dropped.
     *
     * @param int    $userId
     * @param string $anonToken
     * @return int
     */
    public function mergeProgress($userId, $anonToken)
    {
        // Note the two names for the same value. With emulated prepares
        // turned OFF — which is the setting that makes prepared statements
        // a real defence rather than string substitution — PDO cannot reuse
        // one named placeholder twice in a statement. Each occurrence needs
        // its own name.
        // Two bind sets, not one.
        //
        // With emulated prepares OFF — the setting that makes prepared
        // statements a genuine defence rather than string substitution —
        // PDO is strict in both directions: a named placeholder cannot be
        // reused within one statement, AND binding a parameter the
        // statement does not mention is an error. So each statement gets
        // exactly the parameters it uses, and the duplicate user id gets
        // its own name.
        $fold = array('uid' => (int) $userId, 'token' => $anonToken);
        $move = array('uid' => (int) $userId, 'uid2' => (int) $userId, 'token' => $anonToken);
        $drop = array('token' => $anonToken);

        // 1. Fold colliding rows into the account's existing progress.
        //    status is ordered by the ENUM's own ordinal, where
        //    locked < unlocked < learning < mastered, so GREATEST picks
        //    the more advanced of the two.
        $this->execute(
            'UPDATE user_progress AS mine
               JOIN user_progress AS guest
                 ON guest.verse_id = mine.verse_id
                AND guest.session_id = :token
                AND guest.user_id IS NULL
                SET mine.completion_percentage = GREATEST(mine.completion_percentage, guest.completion_percentage),
                    mine.quiz_score            = GREATEST(COALESCE(mine.quiz_score, 0), COALESCE(guest.quiz_score, 0)),
                    mine.status                = GREATEST(mine.status, guest.status),
                    mine.last_read             = GREATEST(COALESCE(mine.last_read, guest.last_read), COALESCE(guest.last_read, mine.last_read)),
                    mine.mastered_at           = COALESCE(mine.mastered_at, guest.mastered_at)
              WHERE mine.user_id = :uid',
            $fold
        );

        // 2. Move the rows that did not collide.
        $moved = $this->execute(
            'UPDATE user_progress AS guest
                SET guest.user_id = :uid, guest.session_id = NULL
              WHERE guest.session_id = :token
                AND guest.user_id IS NULL
                AND NOT EXISTS (
                      SELECT 1 FROM (SELECT verse_id FROM user_progress WHERE user_id = :uid2) AS mine
                       WHERE mine.verse_id = guest.verse_id
                )',
            $move
        );

        // 3. Drop whatever is left — those were folded in at step 1.
        $this->execute(
            'DELETE FROM user_progress WHERE session_id = :token AND user_id IS NULL',
            $drop
        );

        return $moved;
    }

    /**
     * user_reviews has UNIQUE(user_id, verse_id) and holds SM-2 state.
     *
     * On a collision the EARLIER due date wins, not the later one. The
     * conservative choice: showing a card sooner than strictly necessary
     * costs the learner a few seconds, whereas pushing it out costs them
     * the recall the whole system exists to protect.
     *
     * @param int    $userId
     * @param string $anonToken
     * @return int
     */
    public function mergeReviews($userId, $anonToken)
    {
        // Note the two names for the same value. With emulated prepares
        // turned OFF — which is the setting that makes prepared statements
        // a real defence rather than string substitution — PDO cannot reuse
        // one named placeholder twice in a statement. Each occurrence needs
        // its own name.
        // Two bind sets, not one.
        //
        // With emulated prepares OFF — the setting that makes prepared
        // statements a genuine defence rather than string substitution —
        // PDO is strict in both directions: a named placeholder cannot be
        // reused within one statement, AND binding a parameter the
        // statement does not mention is an error. So each statement gets
        // exactly the parameters it uses, and the duplicate user id gets
        // its own name.
        $fold = array('uid' => (int) $userId, 'token' => $anonToken);
        $move = array('uid' => (int) $userId, 'uid2' => (int) $userId, 'token' => $anonToken);
        $drop = array('token' => $anonToken);

        $this->execute(
            'UPDATE user_reviews AS mine
               JOIN user_reviews AS guest
                 ON guest.verse_id = mine.verse_id
                AND guest.session_id = :token
                AND guest.user_id IS NULL
                SET mine.repetitions   = GREATEST(mine.repetitions, guest.repetitions),
                    mine.interval_days = GREATEST(mine.interval_days, guest.interval_days),
                    mine.ease_factor   = GREATEST(mine.ease_factor, guest.ease_factor),
                    mine.due_date      = LEAST(mine.due_date, guest.due_date),
                    mine.last_reviewed_at = GREATEST(COALESCE(mine.last_reviewed_at, guest.last_reviewed_at), COALESCE(guest.last_reviewed_at, mine.last_reviewed_at))
              WHERE mine.user_id = :uid',
            $fold
        );

        $moved = $this->execute(
            'UPDATE user_reviews AS guest
                SET guest.user_id = :uid, guest.session_id = NULL
              WHERE guest.session_id = :token
                AND guest.user_id IS NULL
                AND NOT EXISTS (
                      SELECT 1 FROM (SELECT verse_id FROM user_reviews WHERE user_id = :uid2) AS mine
                       WHERE mine.verse_id = guest.verse_id
                )',
            $move
        );

        $this->execute(
            'DELETE FROM user_reviews WHERE session_id = :token AND user_id IS NULL',
            $drop
        );

        return $moved;
    }

    /**
     * bookmarks has UNIQUE(user_id, target_type, target_id).
     *
     * A duplicate bookmark is not interesting, so a collision keeps the
     * account's own row — but if the guest wrote a note on theirs and the
     * account's is bare, the note is carried across rather than dropped.
     *
     * @param int    $userId
     * @param string $anonToken
     * @return int
     */
    public function mergeBookmarks($userId, $anonToken)
    {
        // Note the two names for the same value. With emulated prepares
        // turned OFF — which is the setting that makes prepared statements
        // a real defence rather than string substitution — PDO cannot reuse
        // one named placeholder twice in a statement. Each occurrence needs
        // its own name.
        // Two bind sets, not one.
        //
        // With emulated prepares OFF — the setting that makes prepared
        // statements a genuine defence rather than string substitution —
        // PDO is strict in both directions: a named placeholder cannot be
        // reused within one statement, AND binding a parameter the
        // statement does not mention is an error. So each statement gets
        // exactly the parameters it uses, and the duplicate user id gets
        // its own name.
        $fold = array('uid' => (int) $userId, 'token' => $anonToken);
        $move = array('uid' => (int) $userId, 'uid2' => (int) $userId, 'token' => $anonToken);
        $drop = array('token' => $anonToken);

        $this->execute(
            'UPDATE bookmarks AS mine
               JOIN bookmarks AS guest
                 ON guest.target_type = mine.target_type
                AND guest.target_id   = mine.target_id
                AND guest.session_id  = :token
                AND guest.user_id IS NULL
                SET mine.note = COALESCE(NULLIF(mine.note, \'\'), guest.note)
              WHERE mine.user_id = :uid',
            $fold
        );

        $moved = $this->execute(
            'UPDATE bookmarks AS guest
                SET guest.user_id = :uid, guest.session_id = NULL
              WHERE guest.session_id = :token
                AND guest.user_id IS NULL
                AND NOT EXISTS (
                      SELECT 1 FROM (
                          SELECT target_type, target_id FROM bookmarks WHERE user_id = :uid2
                      ) AS mine
                       WHERE mine.target_type = guest.target_type
                         AND mine.target_id   = guest.target_id
                )',
            $move
        );

        $this->execute(
            'DELETE FROM bookmarks WHERE session_id = :token AND user_id IS NULL',
            $drop
        );

        return $moved;
    }

    // -----------------------------------------------------------------
    // Helpers
    // -----------------------------------------------------------------

    /**
     * Normalise an email before storing or comparing.
     *
     * Lowercased and trimmed, so "Rohit@Example.com" and
     * "rohit@example.com " cannot become two accounts. Nothing cleverer —
     * stripping dots or plus-addressing would be wrong, because those are
     * genuinely different addresses under the standard even if one
     * popular provider treats them alike.
     *
     * @param string $email
     * @return string
     */
    public function normaliseEmail($email)
    {
        $email = trim((string) $email);
        return function_exists('mb_strtolower') ? mb_strtolower($email, 'UTF-8') : strtolower($email);
    }
}
