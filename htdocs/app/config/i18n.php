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
        // Offline
        // -------------------------------------------------------------
        'offline.badge'      => array('en' => 'Offline', 'hi' => 'ऑफ़लाइन', 'hinglish' => 'Offline'),
        'offline.saved_here' => array('en' => 'Saved on this device. It will sync when you are back online.', 'hi' => 'इस डिवाइस पर सेव है। ऑनलाइन आते ही सिंक हो जाएगा।', 'hinglish' => 'Is device par save hai. Online aate hi sync ho jayega.'),
        'offline.chat'       => array('en' => 'Sarathi needs a connection. Until then, search the verses or read what is already saved here.', 'hi' => 'सारथी को कनेक्शन चाहिए। तब तक श्लोक खोजें या जो सेव है वह पढ़ें।', 'hinglish' => 'Sarathi ko connection chahiye. Tab tak verses search karo ya jo saved hai woh padho.'),
    ),
);
