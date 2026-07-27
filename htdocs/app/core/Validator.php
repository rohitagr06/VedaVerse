<?php
/**
 * VedaVerse — app/core/Validator.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Checks incoming data against a set of rules and collects the failures
 *   as translated, human-readable messages.
 *
 * WHAT DEPENDS ON IT
 *   Controllers, before they hand anything to a service. Also the CSV
 *   importer, which validates every row before the transaction opens.
 *
 * HOW IT READS
 *
 *   $v = Validator::make($request->post(), array(
 *       'name'     => 'required|max:120',
 *       'email'    => 'required|email|max:191',
 *       'password' => 'required|password',
 *       'lang'     => 'required|in:en,hi,hinglish',
 *       'chapter'  => 'required|integer|between:1,18',
 *   ));
 *
 *   if ($v->fails()) {
 *       return $this->back($v->errors());
 *   }
 *   $clean = $v->validated();
 *
 * WHAT VALIDATION IS AND IS NOT
 *   Validation decides whether to accept the request. It is not escaping,
 *   and passing validation does not make a value safe to print — a name
 *   can validate perfectly and still contain a script tag, which is fine,
 *   because the view escapes it on the way out. The two jobs are separate
 *   on purpose: a validator that also "cleans" HTML tends to mangle real
 *   input (an apostrophe in a name, a less-than in a note) while giving
 *   the false impression that output escaping can be skipped.
 *
 *   validated() returns only the keys you declared rules for. Anything
 *   else the browser sent is dropped, so an extra field posted by hand
 *   cannot ride along into a database write.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Core;

class Validator
{
    /** @var array<string,mixed> The data being checked. */
    private $data = array();

    /** @var array<string,string|array> Field => rule string or list. */
    private $rules = array();

    /** @var array<string,array<int,string>> Field => messages. */
    private $errors = array();

    /** @var array<string,string> Field => human label, for the message text. */
    private $labels = array();

    /** @var array<string,bool>|null The common password list, exploded once. */
    private static $commonPasswords = null;

    /**
     * @param array $data
     * @param array $rules
     * @param array $labels Field => the name to use in messages.
     */
    public function __construct(array $data, array $rules, array $labels = array())
    {
        $this->data   = $data;
        $this->rules  = $rules;
        $this->labels = $labels;
    }

    /**
     * @param array $data
     * @param array $rules
     * @param array $labels
     * @return self
     */
    public static function make(array $data, array $rules, array $labels = array())
    {
        $v = new self($data, $rules, $labels);
        $v->run();
        return $v;
    }

    /**
     * Apply every rule.
     *
     * @return void
     */
    public function run()
    {
        $this->errors = array();

        foreach ($this->rules as $field => $ruleset) {
            $rules = is_array($ruleset) ? $ruleset : explode('|', (string) $ruleset);
            $value = $this->value($field);

            // "required" is checked first and short-circuits the rest. A
            // missing field should produce one message, not five.
            $isRequired = in_array('required', $rules, true);
            $isEmpty    = $this->isEmpty($value);

            if ($isRequired && $isEmpty) {
                $this->fail($field, 'validation.required');
                continue;
            }
            if (!$isRequired && $isEmpty) {
                // Optional and absent. Nothing to check.
                continue;
            }

            foreach ($rules as $rule) {
                if ($rule === 'required' || $rule === '') {
                    continue;
                }
                $this->apply($field, $value, $rule);
            }
        }
    }

    /**
     * Run one rule.
     *
     * @param string $field
     * @param mixed  $value
     * @param string $rule e.g. 'max:120' or 'in:en,hi'
     * @return void
     */
    private function apply($field, $value, $rule)
    {
        $name = $rule;
        $arg  = '';
        $pos  = strpos($rule, ':');
        if ($pos !== false) {
            $name = substr($rule, 0, $pos);
            $arg  = substr($rule, $pos + 1);
        }

        switch ($name) {

            case 'string':
                if (!is_string($value)) {
                    $this->fail($field, 'validation.required');
                }
                break;

            case 'email':
                // filter_var is the right tool here. A hand-written email
                // regex is a well-known way to reject valid addresses,
                // particularly ones with apostrophes or newer top-level
                // domains, and VedaVerse never sends mail so there is nothing to
                // gain from being stricter than this.
                if (filter_var((string) $value, FILTER_VALIDATE_EMAIL) === false) {
                    $this->fail($field, 'validation.email');
                }
                break;

            case 'min':
                if ($this->length($value) < (int) $arg) {
                    $this->fail($field, 'validation.min', array(':n' => (int) $arg));
                }
                break;

            case 'max':
                if ($this->length($value) > (int) $arg) {
                    $this->fail($field, 'validation.max', array(':n' => (int) $arg));
                }
                break;

            case 'integer':
                if (!is_numeric($value) || (string) (int) $value !== (string) $value) {
                    $this->fail($field, 'validation.integer');
                }
                break;

            case 'numeric':
                if (!is_numeric($value)) {
                    $this->fail($field, 'validation.integer');
                }
                break;

            case 'between':
                $parts = explode(',', $arg);
                $low   = isset($parts[0]) ? (float) $parts[0] : 0;
                $high  = isset($parts[1]) ? (float) $parts[1] : 0;
                if (!is_numeric($value) || (float) $value < $low || (float) $value > $high) {
                    $this->fail($field, 'validation.between', array(
                        ':min' => $parts[0], ':max' => isset($parts[1]) ? $parts[1] : '',
                    ));
                }
                break;

            case 'in':
                $allowed = explode(',', $arg);
                // Strict comparison against strings, so "0" cannot match
                // an unrelated entry through PHP's looser rules.
                if (!in_array((string) $value, $allowed, true)) {
                    $this->fail($field, 'validation.in');
                }
                break;

            case 'boolean':
                if (!in_array((string) $value, array('0', '1', 'true', 'false', 'on', 'off'), true)) {
                    $this->fail($field, 'validation.in');
                }
                break;

            case 'date':
                if (strtotime((string) $value) === false) {
                    $this->fail($field, 'validation.format');
                }
                break;

            case 'slug':
                if (preg_match('/^[a-z0-9]+(?:-[a-z0-9]+)*$/', (string) $value) !== 1) {
                    $this->fail($field, 'validation.format');
                }
                break;

            case 'url':
                if (filter_var((string) $value, FILTER_VALIDATE_URL) === false) {
                    $this->fail($field, 'validation.format');
                }
                break;

            case 'regex':
                // The pattern comes from our own code, complete with
                // delimiters. Never build one from user input.
                if (@preg_match($arg, (string) $value) !== 1) {
                    $this->fail($field, 'validation.format');
                }
                break;

            case 'matches':
                // Confirm-password and similar. hash_equals rather than ===
                // so the comparison takes the same time whatever the input,
                // which matters when the value being compared is a secret.
                $other = (string) $this->value($arg);
                if (!hash_equals($other, (string) $value)) {
                    $this->fail($field, 'validation.matches');
                }
                break;

            case 'lang':
                $languages = array_keys((array) Config::get('i18n.languages', array()));
                if (!in_array((string) $value, $languages, true)) {
                    $this->fail($field, 'validation.in');
                }
                break;

            case 'password':
                $this->checkPassword($field, (string) $value);
                break;

            case 'nohtml':
                // For fields that must never contain markup at all, such as
                // a slug or a certificate name. Not a substitute for
                // escaping on output anywhere else.
                if ((string) $value !== strip_tags((string) $value)) {
                    $this->fail($field, 'validation.format');
                }
                break;

            case 'honeypot':
                // An anti-spam field hidden with CSS. A human never fills
                // it in, so anything at all in it means a bot. The message
                // is deliberately generic: telling a spammer which check
                // caught them just helps them fix it.
                if (trim((string) $value) !== '') {
                    $this->fail($field, 'validation.in');
                }
                break;

            case 'words':
                // Minimum word count, used for the 20-word floor on forum
                // threads.
                $count = preg_match_all('/\S+/u', (string) $value);
                if ($count < (int) $arg) {
                    $this->fail($field, 'validation.words', array(':n' => (int) $arg));
                }
                break;

            case 'maxlinks':
                // At most N links in a body. Free hosting attracts link
                // spam, and one link is plenty for a genuine post.
                $links = preg_match_all('#https?://#i', (string) $value);
                if ($links > (int) $arg) {
                    $this->fail($field, 'validation.links', array(':n' => (int) $arg));
                }
                break;

            default:
                // An unknown rule is a typo in our own code. Log it rather
                // than silently passing, because a rule that does nothing
                // looks exactly like a rule that works.
                Logger::warning('Unknown validation rule', array('rule' => $name, 'field' => $field));
                break;
        }
    }

    /**
     * The password policy from config/security.php.
     *
     * @param string $field
     * @param string $value
     * @return void
     */
    private function checkPassword($field, $value)
    {
        $policy = Config::get('security.password', array());

        $min = isset($policy['min_length']) ? (int) $policy['min_length'] : 10;
        $max = isset($policy['max_length']) ? (int) $policy['max_length'] : 200;

        $length = $this->length($value);
        $weak   = false;

        if ($length < $min || $length > $max) {
            $weak = true;
        }
        if (!empty($policy['require_upper']) && preg_match('/[A-Z]/', $value) !== 1) {
            $weak = true;
        }
        if (!empty($policy['require_lower']) && preg_match('/[a-z]/', $value) !== 1) {
            $weak = true;
        }
        if (!empty($policy['require_digit']) && preg_match('/[0-9]/', $value) !== 1) {
            $weak = true;
        }
        if (!empty($policy['require_symbol']) && preg_match('/[^A-Za-z0-9]/', $value) !== 1) {
            $weak = true;
        }

        if ($weak) {
            $this->fail($field, 'validation.password_weak');
            return;
        }

        if (!empty($policy['block_common']) && self::isCommonPassword($value)) {
            $this->fail($field, 'validation.password_common');
        }
    }

    /**
     * Is this one of the most-guessed passwords?
     *
     * The list is exploded into a lookup map once per request, so this is
     * an array key check rather than a scan of two hundred strings.
     *
     * @param string $password
     * @return bool
     */
    public static function isCommonPassword($password)
    {
        if (self::$commonPasswords === null) {
            self::$commonPasswords = array();
            $raw = (string) Config::get('security.common_passwords', '');
            foreach (explode(',', $raw) as $entry) {
                $entry = strtolower(trim($entry));
                if ($entry !== '') {
                    self::$commonPasswords[$entry] = true;
                }
            }
        }

        return isset(self::$commonPasswords[strtolower(trim($password))]);
    }

    // -----------------------------------------------------------------
    // Results
    // -----------------------------------------------------------------

    /** @return bool */
    public function passes()
    {
        return $this->errors === array();
    }

    /** @return bool */
    public function fails()
    {
        return $this->errors !== array();
    }

    /**
     * Every message, keyed by field.
     *
     * @return array<string,array<int,string>>
     */
    public function errors()
    {
        return $this->errors;
    }

    /**
     * The first message for one field, or '' when it passed. What a form
     * template wants next to an input.
     *
     * @param string $field
     * @return string
     */
    public function error($field)
    {
        return isset($this->errors[$field][0]) ? $this->errors[$field][0] : '';
    }

    /**
     * Every message as a flat list, for a summary at the top of a form.
     *
     * @return array<int,string>
     */
    public function all()
    {
        $flat = array();
        foreach ($this->errors as $messages) {
            foreach ($messages as $message) {
                $flat[] = $message;
            }
        }
        return $flat;
    }

    /**
     * The validated data, containing only the fields that had rules.
     *
     * This is what gets passed to a service. Never hand a service the raw
     * request array: an extra field posted by hand would otherwise be
     * carried straight into an insert, which is how a normal user gives
     * themselves the admin role.
     *
     * @return array<string,mixed>
     */
    public function validated()
    {
        $out = array();
        foreach (array_keys($this->rules) as $field) {
            if (array_key_exists($field, $this->data)) {
                $out[$field] = $this->data[$field];
            }
        }
        return $out;
    }

    /**
     * Record a failure against a field.
     *
     * @param string $field
     * @param string $key          A translation key.
     * @param array  $replacements
     * @return void
     */
    public function fail($field, $key, array $replacements = array())
    {
        $replacements[':field'] = $this->label($field);

        if (!isset($this->errors[$field])) {
            $this->errors[$field] = array();
        }
        $this->errors[$field][] = View::t($key, $replacements);
    }

    // -----------------------------------------------------------------
    // Helpers
    // -----------------------------------------------------------------

    /**
     * Read a field, supporting dotted paths for nested arrays.
     *
     * @param string $field
     * @return mixed
     */
    private function value($field)
    {
        if (array_key_exists($field, $this->data)) {
            return $this->data[$field];
        }

        if (strpos($field, '.') !== false) {
            $ref = $this->data;
            foreach (explode('.', $field) as $part) {
                if (!is_array($ref) || !array_key_exists($part, $ref)) {
                    return null;
                }
                $ref = $ref[$part];
            }
            return $ref;
        }

        return null;
    }

    /**
     * @param mixed $value
     * @return bool
     */
    private function isEmpty($value)
    {
        if ($value === null) {
            return true;
        }
        if (is_string($value)) {
            return trim($value) === '';
        }
        if (is_array($value)) {
            return $value === array();
        }
        return false;
    }

    /**
     * Length in characters, not bytes.
     *
     * This distinction is the whole ball game for this product. "कृष्ण" is
     * five characters and fifteen bytes. strlen() would report fifteen, so
     * a 120-character name limit would reject a perfectly normal Hindi
     * name at about forty characters. mb_strlen is correct.
     *
     * @param mixed $value
     * @return int
     */
    private function length($value)
    {
        if (is_array($value)) {
            return count($value);
        }
        $string = (string) $value;
        return function_exists('mb_strlen') ? mb_strlen($string, 'UTF-8') : strlen($string);
    }

    /**
     * The human name for a field in a message.
     *
     * @param string $field
     * @return string
     */
    private function label($field)
    {
        if (isset($this->labels[$field])) {
            return $this->labels[$field];
        }
        // 'certificate_name' becomes 'Certificate name'.
        return ucfirst(str_replace('_', ' ', $field));
    }
}
