<?php
/**
 * VedaVerse — app/config/i18n.php
 * ---------------------------------------------------------------------
 * Language definitions and the interface string table.
 *
 * SCOPE OF THIS FILE AS SHIPPED IN STEP 1
 *   The language metadata below is final. The 'strings' table currently
 *   holds only what the framework itself can emit before any page exists:
 *   error pages, validation messages, and the handful of words the core
 *   uses. Step 4 of the build order fills in the complete interface table
 *   and adds I18nService on top of it. The shape does not change — later
 *   steps only add keys.
 *
 * THE RULE
 *   No hardcoded English in any view, ever. If a view needs a word, the
 *   word gets a key here in all three languages first. This is annoying
 *   for exactly as long as it takes to add the second language, and then
 *   it is the only reason the third one is possible at all.
 *
 * THE THREE LANGUAGES
 *   en        Plain, warm, direct English. Short sentences. No "thou",
 *             no "verily", no academic hedging.
 *   hi        Natural spoken Hindi in Devanagari. Not stiff literary
 *             Hindi. Written for somebody who speaks Hindi at home and
 *             reads it slowly.
 *   hinglish  How urban India actually talks. Code-switched, casual,
 *             never cringe. This is the register that makes the product
 *             spread, and it is not a joke or an afterthought.
 *
 * MISSING KEYS
 *   I18nService falls back to 'en' and, in debug mode only, logs the
 *   missing key so gaps surface during development instead of shipping as
 *   blank labels.
 */

return array(

    'default'  => 'en',
    'fallback' => 'en',

    // The only three. Adding a fourth is a data change plus a font check,
    // not a code change.
    'languages' => array(
        'en' => array(
            'code'        => 'en',
            'name'        => 'English',
            'native_name' => 'English',
            'html_lang'   => 'en',
            'dir'         => 'ltr',
            // The lang attribute matters for accessibility: a screen
            // reader pronounces Devanagari correctly only when the element
            // is marked as Hindi.
            'script'      => 'latin',
            'date_format' => 'j M Y',
        ),
        'hi' => array(
            'code'        => 'hi',
            'name'        => 'Hindi',
            'native_name' => 'हिन्दी',
            'html_lang'   => 'hi',
            'dir'         => 'ltr',
            'script'      => 'devanagari',
            'date_format' => 'j M Y',
        ),
        'hinglish' => array(
            'code'        => 'hinglish',
            'name'        => 'Hinglish',
            'native_name' => 'Hinglish',
            // Romanised Hindi is still Hindi for a screen reader's
            // purposes, but marking it hi would make an English speech
            // engine mangle it. en-IN is the honest compromise.
            'html_lang'   => 'en-IN',
            'dir'         => 'ltr',
            'script'      => 'latin',
            'date_format' => 'j M Y',
        ),
    ),

    // Sanskrit is not an interface language, but the shloka needs its own
    // lang attribute so it is announced and rendered correctly.
    'content_languages' => array(
        'sa' => array('html_lang' => 'sa', 'script' => 'devanagari'),
    ),

    // How a language is chosen, first match wins.
    'detection' => array(
        'query_param'  => 'lang',   // ?lang=hinglish, for sharing a link
        'user_setting' => true,     // users.preferred_lang
        'cookie'       => 'vv_lang',
        'accept_header'=> true,     // browser Accept-Language, mapped loosely
        'default'      => 'en',
    ),

    /**
     * Interface strings.
     *
     * Keyed by dotted namespace. Every key carries all three languages. A
     * key with a missing language is a bug, not a fallback.
     */
    'strings' => array(

        // -------------------------------------------------------------
        // Core words the framework itself uses
        // -------------------------------------------------------------
        'common.app_name'   => array('en' => 'VedaVerse', 'hi' => 'VedaVerse', 'hinglish' => 'VedaVerse'),
        'common.yes'        => array('en' => 'Yes', 'hi' => 'हाँ', 'hinglish' => 'Haan'),
        'common.no'         => array('en' => 'No', 'hi' => 'नहीं', 'hinglish' => 'Nahi'),
        'common.save'       => array('en' => 'Save', 'hi' => 'सेव करें', 'hinglish' => 'Save karo'),
        'common.cancel'     => array('en' => 'Cancel', 'hi' => 'रद्द करें', 'hinglish' => 'Cancel'),
        'common.back'       => array('en' => 'Back', 'hi' => 'वापस', 'hinglish' => 'Wapas'),
        'common.next'       => array('en' => 'Next', 'hi' => 'आगे', 'hinglish' => 'Aage'),
        'common.retry'      => array('en' => 'Try again', 'hi' => 'फिर कोशिश करें', 'hinglish' => 'Phir se try karo'),
        'common.loading'    => array('en' => 'Loading', 'hi' => 'लोड हो रहा है', 'hinglish' => 'Load ho raha hai'),
        'common.home'       => array('en' => 'Home', 'hi' => 'होम', 'hinglish' => 'Home'),
        'common.search'     => array('en' => 'Search', 'hi' => 'खोजें', 'hinglish' => 'Search'),
        'common.skip_to_content' => array('en' => 'Skip to content', 'hi' => 'सामग्री पर जाएँ', 'hinglish' => 'Content par jao'),

        // -------------------------------------------------------------
        // Error pages
        // -------------------------------------------------------------
        // These have to make sense to somebody who has no idea what an
        // HTTP status code is, and they must never leak a file path.
        'error.400.title'   => array('en' => 'That request did not make sense', 'hi' => 'यह अनुरोध समझ नहीं आया', 'hinglish' => 'Yeh request samajh nahi aayi'),
        'error.400.body'    => array('en' => 'Something in that request was malformed. Going back and trying again usually fixes it.', 'hi' => 'अनुरोध में कुछ गड़बड़ थी। वापस जाकर दोबारा कोशिश करें।', 'hinglish' => 'Request mein kuch gadbad thi. Wapas jaake dobara try karo.'),

        'error.401.title'   => array('en' => 'You need to sign in', 'hi' => 'आपको साइन इन करना होगा', 'hinglish' => 'Sign in karna padega'),
        'error.401.body'    => array('en' => 'This page is for signed-in learners. Reading everything else stays free and anonymous.', 'hi' => 'यह पेज साइन इन किए हुए शिक्षार्थियों के लिए है। बाकी सब पढ़ना मुफ़्त और गुमनाम है।', 'hinglish' => 'Yeh page sign in kiye users ke liye hai. Baaki sab padhna free aur anonymous hai.'),

        'error.403.title'   => array('en' => 'Not your door', 'hi' => 'यह आपके लिए नहीं है', 'hinglish' => 'Yeh tumhare liye nahi hai'),
        'error.403.body'    => array('en' => 'Your account does not have access to this. If you think that is wrong, ask the site owner.', 'hi' => 'आपके खाते के पास इसकी अनुमति नहीं है। अगर यह गलत लगे तो साइट के मालिक से पूछें।', 'hinglish' => 'Tumhare account ke paas iska access nahi hai. Galat lage to owner se pooch lo.'),

        'error.404.title'   => array('en' => 'This page is not here', 'hi' => 'यह पेज यहाँ नहीं है', 'hinglish' => 'Yeh page yahan nahi hai'),
        'error.404.body'    => array('en' => 'The link may be old, or the address may have a typo. Try the search, or start from Chapter 2.', 'hi' => 'लिंक पुराना हो सकता है, या पते में गलती। खोज आज़माएँ, या अध्याय 2 से शुरू करें।', 'hinglish' => 'Link purana ho sakta hai ya address mein typo. Search try karo, ya Chapter 2 se shuru karo.'),

        'error.429.title'   => array('en' => 'Slow down for a moment', 'hi' => 'थोड़ा रुकिए', 'hinglish' => 'Thoda ruko'),
        'error.429.body'    => array('en' => 'That was a lot of requests in a short time. Wait a minute and carry on.', 'hi' => 'कम समय में बहुत सारे अनुरोध हो गए। एक मिनट रुककर जारी रखें।', 'hinglish' => 'Kam time mein bahut requests ho gayi. Ek minute ruk ke continue karo.'),

        'error.500.title'   => array('en' => 'Something broke on our side', 'hi' => 'हमारी तरफ़ कुछ गड़बड़ हुई', 'hinglish' => 'Humari taraf kuch gadbad ho gayi'),
        'error.500.body'    => array('en' => 'This is our fault, not yours. It has been logged. Try again in a moment.', 'hi' => 'यह गलती हमारी है, आपकी नहीं। इसे दर्ज कर लिया गया है। थोड़ी देर में फिर कोशिश करें।', 'hinglish' => 'Yeh galti humari hai, tumhari nahi. Log ho gaya hai. Thodi der mein try karo.'),

        'error.503.title'   => array('en' => 'Back shortly', 'hi' => 'जल्द वापस आते हैं', 'hinglish' => 'Thodi der mein wapas'),
        'error.503.body'    => array('en' => 'VedaVerse is being updated. This usually takes a few minutes.', 'hi' => 'VedaVerse अपडेट हो रहा है। आमतौर पर कुछ मिनट लगते हैं।', 'hinglish' => 'VedaVerse update ho raha hai. Kuch minute lagenge.'),

        'error.reference'   => array('en' => 'Reference', 'hi' => 'संदर्भ', 'hinglish' => 'Reference'),

        // -------------------------------------------------------------
        // Validation
        // -------------------------------------------------------------
        // :field and :n are replaced by Validator. Keep the placeholders
        // when translating.
        'validation.required'     => array('en' => ':field is required.', 'hi' => ':field ज़रूरी है।', 'hinglish' => ':field zaroori hai.'),
        'validation.email'        => array('en' => 'That does not look like an email address.', 'hi' => 'यह ईमेल पते जैसा नहीं लग रहा।', 'hinglish' => 'Yeh email address jaisa nahi lag raha.'),
        'validation.min'          => array('en' => ':field must be at least :n characters.', 'hi' => ':field में कम से कम :n अक्षर होने चाहिए।', 'hinglish' => ':field mein kam se kam :n characters chahiye.'),
        'validation.max'          => array('en' => ':field must be :n characters or fewer.', 'hi' => ':field :n अक्षरों से ज़्यादा नहीं हो सकता।', 'hinglish' => ':field :n characters se zyada nahi ho sakta.'),
        'validation.integer'      => array('en' => ':field must be a whole number.', 'hi' => ':field पूर्ण संख्या होनी चाहिए।', 'hinglish' => ':field poora number hona chahiye.'),
        'validation.in'           => array('en' => 'That is not one of the allowed choices.', 'hi' => 'यह अनुमत विकल्पों में नहीं है।', 'hinglish' => 'Yeh allowed options mein nahi hai.'),
        'validation.between'      => array('en' => ':field must be between :min and :max.', 'hi' => ':field :min और :max के बीच होना चाहिए।', 'hinglish' => ':field :min se :max ke beech hona chahiye.'),
        'validation.words'        => array('en' => ':field needs at least :n words.', 'hi' => ':field में कम से कम :n शब्द चाहिए।', 'hinglish' => ':field mein kam se kam :n words chahiye.'),
        'validation.links'        => array('en' => 'Please include no more than :n link.', 'hi' => 'कृपया :n से ज़्यादा लिंक न डालें।', 'hinglish' => 'Please :n se zyada link mat daalo.'),
        'validation.format'       => array('en' => ':field is not in the right format.', 'hi' => ':field सही प्रारूप में नहीं है।', 'hinglish' => ':field sahi format mein nahi hai.'),
        'validation.matches'      => array('en' => ':field does not match.', 'hi' => ':field मेल नहीं खाता।', 'hinglish' => ':field match nahi kar raha.'),
        'validation.password_weak'=> array('en' => 'Use at least 10 characters with upper and lower case, a number and a symbol.', 'hi' => 'कम से कम 10 अक्षर, बड़े और छोटे अक्षर, एक अंक और एक चिह्न इस्तेमाल करें।', 'hinglish' => 'Kam se kam 10 characters, upper aur lower case, ek number aur ek symbol daalo.'),
        'validation.password_common' => array('en' => 'That password is on the list of most-guessed passwords. Pick something else.', 'hi' => 'यह पासवर्ड सबसे ज़्यादा अनुमान लगाए जाने वालों में है। कुछ और चुनें।', 'hinglish' => 'Yeh password sabse common list mein hai. Kuch aur chuno.'),
        'validation.csrf'         => array('en' => 'Your session expired while this form was open. Please try again.', 'hi' => 'फ़ॉर्म खुला रहते सत्र समाप्त हो गया। कृपया दोबारा कोशिश करें।', 'hinglish' => 'Form khula tha tab session expire ho gaya. Dobara try karo.'),
        'validation.throttled'    => array('en' => 'Too many attempts. Wait :n minutes and try again.', 'hi' => 'बहुत सारी कोशिशें। :n मिनट रुककर दोबारा कोशिश करें।', 'hinglish' => 'Bahut attempts ho gaye. :n minute ruk ke try karo.'),
        'validation.upload_type'  => array('en' => 'That file type is not allowed.', 'hi' => 'यह फ़ाइल प्रकार अनुमत नहीं है।', 'hinglish' => 'Yeh file type allowed nahi hai.'),
        'validation.upload_size'  => array('en' => 'That file is too large.', 'hi' => 'यह फ़ाइल बहुत बड़ी है।', 'hinglish' => 'Yeh file bahut badi hai.'),

        // -------------------------------------------------------------
        // Relative time and units
        // -------------------------------------------------------------
        'time.just_now'       => array('en' => 'just now', 'hi' => 'अभी', 'hinglish' => 'abhi'),
        'time.minutes'        => array('en' => ':n minutes ago', 'hi' => ':n मिनट पहले', 'hinglish' => ':n minute pehle'),
        'time.hours'          => array('en' => ':n hours ago', 'hi' => ':n घंटे पहले', 'hinglish' => ':n ghante pehle'),
        'time.days'           => array('en' => ':n days ago', 'hi' => ':n दिन पहले', 'hinglish' => ':n din pehle'),
        'time.minutes_short'  => array('en' => ':n min', 'hi' => ':n मिनट', 'hinglish' => ':n min'),
        'time.under_a_minute' => array('en' => 'under a minute', 'hi' => 'एक मिनट से कम', 'hinglish' => 'ek minute se kam'),

        'difficulty.beginner'     => array('en' => 'Beginner', 'hi' => 'शुरुआती', 'hinglish' => 'Shuruaati'),
        'difficulty.intermediate' => array('en' => 'Intermediate', 'hi' => 'मध्यम', 'hinglish' => 'Medium'),
        'difficulty.advanced'     => array('en' => 'Advanced', 'hi' => 'उन्नत', 'hinglish' => 'Advanced'),

        // -------------------------------------------------------------
        // Accounts
        // -------------------------------------------------------------
        // Written for somebody who is slightly anxious, because that is
        // the state most people are in on a sign-in screen. Plain, short,
        // no jargon — and honest about the recovery code, which is the one
        // place this product genuinely cannot rescue anyone.
        'auth.login.title'      => array('en' => 'Sign in', 'hi' => 'साइन इन करें', 'hinglish' => 'Sign in karo'),
        'auth.login.lead'       => array('en' => 'Welcome back. Your reading is where you left it.', 'hi' => 'वापसी पर स्वागत है। आपका पढ़ा हुआ वहीं है जहाँ छोड़ा था।', 'hinglish' => 'Wapas aa gaye. Jahan chhoda tha wahin se shuru karo.'),
        'auth.login.submit'     => array('en' => 'Sign in', 'hi' => 'साइन इन', 'hinglish' => 'Sign in'),
        'auth.login.no_account' => array('en' => 'No account yet?', 'hi' => 'अभी खाता नहीं है?', 'hinglish' => 'Account nahi hai?'),
        'auth.login.forgot'     => array('en' => 'Lost your password?', 'hi' => 'पासवर्ड भूल गए?', 'hinglish' => 'Password bhool gaye?'),

        'auth.register.title'        => array('en' => 'Create an account', 'hi' => 'खाता बनाएँ', 'hinglish' => 'Account banao'),
        'auth.register.lead'         => array('en' => 'You can read everything without one. An account adds syncing across devices, the forum, and certificates.', 'hi' => 'बिना खाते के भी सब पढ़ सकते हैं। खाते से डिवाइस के बीच सिंक, फ़ोरम और प्रमाणपत्र मिलते हैं।', 'hinglish' => 'Bina account ke bhi sab padh sakte ho. Account se sync, forum aur certificate milte hain.'),
        'auth.register.submit'       => array('en' => 'Create my account', 'hi' => 'मेरा खाता बनाएँ', 'hinglish' => 'Account banao'),
        'auth.register.have_account' => array('en' => 'Already have one?', 'hi' => 'पहले से खाता है?', 'hinglish' => 'Pehle se account hai?'),
        'auth.register.no_email'     => array('en' => 'Your email is only used to sign in. Nothing is ever sent to it — this site sends no email at all.', 'hi' => 'ईमेल सिर्फ़ साइन इन के लिए है। कुछ भी नहीं भेजा जाता — यह साइट कोई ईमेल नहीं भेजती।', 'hinglish' => 'Email sirf sign in ke liye hai. Kuch bheja nahi jaata — yeh site koi email send hi nahi karti.'),

        'auth.recover.title'   => array('en' => 'Recover your account', 'hi' => 'खाता वापस पाएँ', 'hinglish' => 'Account wapas lo'),
        'auth.recover.lead'    => array('en' => 'Enter your email, the recovery code you wrote down at signup, and a new password.', 'hi' => 'अपना ईमेल, साइनअप के समय लिखा गया रिकवरी कोड, और नया पासवर्ड डालें।', 'hinglish' => 'Email, signup ke time likha recovery code, aur naya password daalo.'),
        'auth.recover.submit'  => array('en' => 'Set a new password', 'hi' => 'नया पासवर्ड सेट करें', 'hinglish' => 'Naya password set karo'),
        'auth.recover.done'    => array('en' => 'Password changed. You have been signed out everywhere else.', 'hi' => 'पासवर्ड बदल गया। बाकी सब जगह से साइन आउट कर दिया गया है।', 'hinglish' => 'Password change ho gaya. Baaki sab jagah se sign out kar diya hai.'),
        'auth.recover.no_code' => array('en' => 'Lost the code as well? Then this account cannot be recovered — there is no email reset. You would need to create a new one.', 'hi' => 'कोड भी खो गया? तब यह खाता वापस नहीं मिल सकता — ईमेल रीसेट नहीं है। नया खाता बनाना होगा।', 'hinglish' => 'Code bhi kho gaya? Phir yeh account wapas nahi mil sakta — email reset hai hi nahi. Naya banana padega.'),

        'auth.code.title'    => array('en' => 'Write this down now', 'hi' => 'इसे अभी लिख लें', 'hinglish' => 'Yeh abhi likh lo'),
        'auth.code.lead'     => array('en' => 'This is your recovery code. It is shown once, right now, and stored only as a hash — nobody can look it up later, including us.', 'hi' => 'यह आपका रिकवरी कोड है। यह सिर्फ़ अभी एक बार दिख रहा है और केवल हैश के रूप में सुरक्षित है — बाद में कोई इसे नहीं देख सकता, हम भी नहीं।', 'hinglish' => 'Yeh tumhara recovery code hai. Sirf abhi ek baar dikh raha hai, aur sirf hash ban ke store hota hai — baad mein koi dekh nahi sakta, hum bhi nahi.'),
        'auth.code.warning'  => array('en' => 'If you lose both your password and this code, the account cannot be recovered. There is no email reset, because this host blocks outgoing mail.', 'hi' => 'अगर पासवर्ड और यह कोड दोनों खो गए, तो खाता वापस नहीं मिलेगा। ईमेल रीसेट नहीं है, क्योंकि यह होस्ट ईमेल भेजने नहीं देता।', 'hinglish' => 'Password aur yeh code dono kho gaye to account wapas nahi milega. Email reset nahi hai, kyunki host email bhejne hi nahi deta.'),
        'auth.code.copy'     => array('en' => 'Copy the code', 'hi' => 'कोड कॉपी करें', 'hinglish' => 'Code copy karo'),
        'auth.code.copied'   => array('en' => 'Copied', 'hi' => 'कॉपी हो गया', 'hinglish' => 'Copy ho gaya'),
        'auth.code.continue' => array('en' => 'I have written it down — continue', 'hi' => 'मैंने लिख लिया — आगे बढ़ें', 'hinglish' => 'Likh liya — aage chalo'),

        'auth.field.name'             => array('en' => 'Your name', 'hi' => 'आपका नाम', 'hinglish' => 'Tumhara naam'),
        'auth.field.email'            => array('en' => 'Email', 'hi' => 'ईमेल', 'hinglish' => 'Email'),
        'auth.field.password'         => array('en' => 'Password', 'hi' => 'पासवर्ड', 'hinglish' => 'Password'),
        'auth.field.new_password'     => array('en' => 'New password', 'hi' => 'नया पासवर्ड', 'hinglish' => 'Naya password'),
        'auth.field.password_confirm' => array('en' => 'Password again', 'hi' => 'पासवर्ड दोबारा', 'hinglish' => 'Password phir se'),
        'auth.field.code'             => array('en' => 'Recovery code', 'hi' => 'रिकवरी कोड', 'hinglish' => 'Recovery code'),
        'auth.field.lang'             => array('en' => 'Reading language', 'hi' => 'पढ़ने की भाषा', 'hinglish' => 'Padhne ki bhasha'),
        'auth.field.track'            => array('en' => 'Where to start', 'hi' => 'कहाँ से शुरू करें', 'hinglish' => 'Kahan se shuru karein'),

        'auth.hint.password' => array('en' => 'At least 10 characters, with upper and lower case, a number and a symbol.', 'hi' => 'कम से कम 10 अक्षर, बड़े और छोटे अक्षर, एक अंक और एक चिह्न।', 'hinglish' => 'Kam se kam 10 characters, upper aur lower case, ek number aur ek symbol.'),
        'auth.hint.track'    => array('en' => 'You can change this later without losing progress.', 'hi' => 'इसे बाद में बदल सकते हैं, प्रगति खोए बिना।', 'hinglish' => 'Baad mein change kar sakte ho, progress khoye bina.'),

        'auth.track.beginner'     => array('en' => 'Beginner — chapters 2, 3, 12, 16, 18', 'hi' => 'शुरुआती — अध्याय 2, 3, 12, 16, 18', 'hinglish' => 'Beginner — chapter 2, 3, 12, 16, 18'),
        'auth.track.intermediate' => array('en' => 'Intermediate — adds 4, 5, 6, 13, 14, 17', 'hi' => 'मध्यम — साथ में 4, 5, 6, 13, 14, 17', 'hinglish' => 'Intermediate — inke saath 4, 5, 6, 13, 14, 17'),
        'auth.track.advanced'     => array('en' => 'Advanced — all eighteen chapters', 'hi' => 'उन्नत — सभी अठारह अध्याय', 'hinglish' => 'Advanced — poore atharah chapter'),

        'auth.error.invalid'             => array('en' => 'That email and password do not match an account.', 'hi' => 'यह ईमेल और पासवर्ड किसी खाते से मेल नहीं खाते।', 'hinglish' => 'Yeh email aur password kisi account se match nahi karte.'),
        'auth.error.email_taken'         => array('en' => 'There is already an account with that email. Try signing in, or recover it.', 'hi' => 'इस ईमेल से खाता पहले से है। साइन इन करें या रिकवर करें।', 'hinglish' => 'Is email se account pehle se hai. Sign in karo ya recover karo.'),
        'auth.error.recover_invalid'     => array('en' => 'That email and recovery code do not match.', 'hi' => 'यह ईमेल और रिकवरी कोड मेल नहीं खाते।', 'hinglish' => 'Yeh email aur recovery code match nahi karte.'),
        'auth.error.registration_closed' => array('en' => 'New accounts are closed at the moment. Reading is still open to everyone.', 'hi' => 'अभी नए खाते बंद हैं। पढ़ना सबके लिए खुला है।', 'hinglish' => 'Abhi naye account band hain. Padhna sabke liye khula hai.'),

        'auth.logged_out' => array('en' => 'Signed out. Your bookmarks on this device are still here.', 'hi' => 'साइन आउट हो गया। इस डिवाइस पर आपके बुकमार्क अब भी यहीं हैं।', 'hinglish' => 'Sign out ho gaya. Is device par tumhare bookmark abhi bhi yahin hain.'),
        'auth.merged'     => array('en' => 'Everything you saved before signing in has been added to your account.', 'hi' => 'साइन इन से पहले जो सेव किया था, वह आपके खाते में जुड़ गया है।', 'hinglish' => 'Sign in se pehle jo save kiya tha, woh account mein add ho gaya hai.'),
        'auth.sign_out'   => array('en' => 'Sign out', 'hi' => 'साइन आउट', 'hinglish' => 'Sign out'),

        'form.errors_heading' => array('en' => 'Please fix these first', 'hi' => 'पहले इन्हें ठीक करें', 'hinglish' => 'Pehle yeh theek karo'),
        'form.required_note'  => array('en' => 'All fields are required.', 'hi' => 'सभी फ़ील्ड ज़रूरी हैं।', 'hinglish' => 'Saare fields zaroori hain.'),

        // -------------------------------------------------------------
        // Navigation
        // -------------------------------------------------------------
        // Short, because a tab-bar label has about eight characters
        // before it wraps on a 320px screen. "Path" not "Learning Path",
        // "Sarathi" not "Ask Sarathi".
        'nav.primary' => array('en' => 'Main navigation', 'hi' => 'मुख्य नेविगेशन', 'hinglish' => 'Main navigation'),
        'nav.path'    => array('en' => 'Path', 'hi' => 'रास्ता', 'hinglish' => 'Path'),
        'nav.review'  => array('en' => 'Review', 'hi' => 'दोहराएँ', 'hinglish' => 'Review'),
        'nav.sarathi' => array('en' => 'Sarathi', 'hi' => 'सारथी', 'hinglish' => 'Sarathi'),
        'nav.explore' => array('en' => 'Explore', 'hi' => 'खोजें', 'hinglish' => 'Explore'),
        'nav.profile' => array('en' => 'You', 'hi' => 'आप', 'hinglish' => 'Tum'),

        // -------------------------------------------------------------
        // Display settings
        // -------------------------------------------------------------
        'settings.open'          => array('en' => 'Display settings', 'hi' => 'प्रदर्शन सेटिंग', 'hinglish' => 'Display settings'),
        'settings.theme'         => array('en' => 'Appearance', 'hi' => 'रंग-रूप', 'hinglish' => 'Look'),
        'settings.theme.light'   => array('en' => 'Light', 'hi' => 'उजला', 'hinglish' => 'Light'),
        'settings.theme.dark'    => array('en' => 'Dark', 'hi' => 'गहरा', 'hinglish' => 'Dark'),
        'settings.theme.system'  => array('en' => 'Automatic', 'hi' => 'अपने आप', 'hinglish' => 'Apne aap'),
        'settings.size'          => array('en' => 'Text size', 'hi' => 'अक्षरों का आकार', 'hinglish' => 'Text ka size'),
        'settings.size.step'     => array('en' => 'Text size :n of 4', 'hi' => '4 में से :n आकार', 'hinglish' => 'Size :n of 4'),
        'settings.language'      => array('en' => 'Language', 'hi' => 'भाषा', 'hinglish' => 'Bhasha'),
        'settings.account'       => array('en' => 'Account', 'hi' => 'खाता', 'hinglish' => 'Account'),

        // -------------------------------------------------------------
        // Profile and progress
        // -------------------------------------------------------------
        'profile.xp'     => array('en' => 'Experience points', 'hi' => 'अनुभव अंक', 'hinglish' => 'XP'),
        'profile.streak' => array('en' => 'Day streak', 'hi' => 'लगातार दिन', 'hinglish' => 'Streak'),
        'profile.level'  => array('en' => 'Level :n', 'hi' => 'स्तर :n', 'hinglish' => 'Level :n'),

        // -------------------------------------------------------------
        // Footer
        // -------------------------------------------------------------
        // The claim that matters legally and editorially: every word of
        // translation, explanation and example here is original writing.
        'footer.original_work' => array(
            'en'       => 'Every translation and example here is original writing.',
            'hi'       => 'यहाँ का हर अनुवाद और उदाहरण मौलिक लेखन है।',
            'hinglish' => 'Yahan ka har translation aur example original likha gaya hai.',
        ),

        // -------------------------------------------------------------
        // Offline
        // -------------------------------------------------------------
        'offline.badge'      => array('en' => 'Offline', 'hi' => 'ऑफ़लाइन', 'hinglish' => 'Offline'),
        'offline.saved_here' => array('en' => 'Saved on this device. It will sync when you are back online.', 'hi' => 'इस डिवाइस पर सेव है। ऑनलाइन आते ही सिंक हो जाएगा।', 'hinglish' => 'Is device par save hai. Online aate hi sync ho jayega.'),
        'offline.chat'       => array('en' => 'Sarathi needs a connection. Until then, search the verses or read what is already saved here.', 'hi' => 'सारथी को कनेक्शन चाहिए। तब तक श्लोक खोजें या जो सेव है वह पढ़ें।', 'hinglish' => 'Sarathi ko connection chahiye. Tab tak verses search karo ya jo saved hai woh padho.'),
    ),
);
