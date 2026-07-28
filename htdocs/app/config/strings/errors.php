<?php
/**
 * VedaVerse — app/config/strings/errors.php
 * ---------------------------------------------------------------------
 * Error pages, validation messages, and the generic flash notices.
 *
 * TWO RULES FOR EVERY STRING IN THIS FILE
 *
 *   1. It has to make sense to somebody who has never heard of an HTTP
 *      status code. "This page is not here" is a sentence. "404 Not
 *      Found" is a diagnostic aimed at the wrong person.
 *
 *   2. It must never leak a file path, a database name, a table name, a
 *      query, or a stack frame. Those go in the log, where the person
 *      who can act on them will look. A reference code is offered
 *      instead, so a user can quote it and an administrator can find the
 *      matching log line.
 *
 * TONE
 *   When it is our fault, say so. "This is our fault, not yours" costs
 *   nothing and stops somebody re-typing a form four times believing
 *   they got it wrong.
 */

return array(

    // -----------------------------------------------------------------
    // Error pages
    // -----------------------------------------------------------------
    'error.400.title' => array('en' => 'That request did not make sense', 'hi' => 'यह अनुरोध समझ नहीं आया', 'hinglish' => 'Yeh request samajh nahi aayi'),
    'error.400.body'  => array('en' => 'Something in that request was malformed. Going back and trying again usually fixes it.', 'hi' => 'अनुरोध में कुछ गड़बड़ थी। वापस जाकर दोबारा कोशिश करें।', 'hinglish' => 'Request mein kuch gadbad thi. Wapas jaake dobara try karo.'),

    'error.401.title' => array('en' => 'You need to sign in', 'hi' => 'आपको साइन इन करना होगा', 'hinglish' => 'Sign in karna padega'),
    'error.401.body'  => array('en' => 'This page is for signed-in learners. Reading everything else stays free and anonymous.', 'hi' => 'यह पेज साइन इन किए हुए शिक्षार्थियों के लिए है। बाकी सब पढ़ना मुफ़्त और गुमनाम है।', 'hinglish' => 'Yeh page sign in kiye users ke liye hai. Baaki sab padhna free aur anonymous hai.'),

    'error.403.title' => array('en' => 'Not your door', 'hi' => 'यह आपके लिए नहीं है', 'hinglish' => 'Yeh tumhare liye nahi hai'),
    'error.403.body'  => array('en' => 'Your account does not have access to this. If you think that is wrong, ask the site owner.', 'hi' => 'आपके खाते के पास इसकी अनुमति नहीं है। अगर यह गलत लगे तो साइट के मालिक से पूछें।', 'hinglish' => 'Tumhare account ke paas iska access nahi hai. Galat lage to owner se pooch lo.'),

    'error.404.title' => array('en' => 'This page is not here', 'hi' => 'यह पेज यहाँ नहीं है', 'hinglish' => 'Yeh page yahan nahi hai'),
    'error.404.body'  => array('en' => 'The link may be old, or the address may have a typo. Try the search, or start from Chapter 2.', 'hi' => 'लिंक पुराना हो सकता है, या पते में गलती। खोज आज़माएँ, या अध्याय 2 से शुरू करें।', 'hinglish' => 'Link purana ho sakta hai ya address mein typo. Search try karo, ya Chapter 2 se shuru karo.'),

    'error.410.title' => array('en' => 'This was taken down', 'hi' => 'इसे हटा दिया गया है', 'hinglish' => 'Isko hata diya gaya hai'),
    'error.410.body'  => array('en' => 'The page existed once and was removed on purpose. Nothing you did caused this.', 'hi' => 'यह पेज पहले था और जानबूझकर हटाया गया। इसमें आपकी कोई गलती नहीं।', 'hinglish' => 'Yeh page pehle tha, jaan-boojh ke hataya gaya. Tumhari koi galti nahi.'),

    'error.429.title' => array('en' => 'Slow down for a moment', 'hi' => 'थोड़ा रुकिए', 'hinglish' => 'Thoda ruko'),
    'error.429.body'  => array('en' => 'That was a lot of requests in a short time. Wait a minute and carry on.', 'hi' => 'कम समय में बहुत सारे अनुरोध हो गए। एक मिनट रुककर जारी रखें।', 'hinglish' => 'Kam time mein bahut requests ho gayi. Ek minute ruk ke continue karo.'),

    'error.500.title' => array('en' => 'Something broke on our side', 'hi' => 'हमारी तरफ़ कुछ गड़बड़ हुई', 'hinglish' => 'Humari taraf kuch gadbad ho gayi'),
    'error.500.body'  => array('en' => 'This is our fault, not yours. It has been logged. Try again in a moment.', 'hi' => 'यह गलती हमारी है, आपकी नहीं। इसे दर्ज कर लिया गया है। थोड़ी देर में फिर कोशिश करें।', 'hinglish' => 'Yeh galti humari hai, tumhari nahi. Log ho gaya hai. Thodi der mein try karo.'),

    'error.503.title' => array('en' => 'Back shortly', 'hi' => 'जल्द वापस आते हैं', 'hinglish' => 'Thodi der mein wapas'),
    'error.503.body'  => array('en' => 'VedaVerse is being updated. This usually takes a few minutes.', 'hi' => 'VedaVerse अपडेट हो रहा है। आमतौर पर कुछ मिनट लगते हैं।', 'hinglish' => 'VedaVerse update ho raha hai. Kuch minute lagenge.'),

    'error.reference'   => array('en' => 'Reference', 'hi' => 'संदर्भ', 'hinglish' => 'Reference'),
    'error.reference_note' => array('en' => 'Quote this code if you report the problem. It matches one line in our log and contains nothing about you.', 'hi' => 'समस्या बताते समय यह कोड लिखें। यह हमारे लॉग की एक लाइन से मेल खाता है और इसमें आपकी कोई जानकारी नहीं है।', 'hinglish' => 'Problem report karo to yeh code likh dena. Yeh humare log ki ek line se match karta hai, isme tumhari koi info nahi hai.'),
    'error.go_home'     => array('en' => 'Go to the start', 'hi' => 'शुरुआत पर जाएँ', 'hinglish' => 'Shuruaat par jao'),
    'error.search_instead' => array('en' => 'Search instead', 'hi' => 'इसके बजाय खोजें', 'hinglish' => 'Search kar lo'),

    // -----------------------------------------------------------------
    // Validation
    // -----------------------------------------------------------------
    // :field, :n, :min and :max are filled in by Validator. Every
    // language must keep the same placeholders — a Hindi message that
    // drops :n leaves a sentence with a hole in it, and it reads
    // perfectly well in isolation, which is why nobody catches it by
    // eye. tools/check-strings.php catches it.
    'validation.required'        => array('en' => ':field is required.', 'hi' => ':field ज़रूरी है।', 'hinglish' => ':field zaroori hai.'),
    'validation.email'           => array('en' => 'That does not look like an email address.', 'hi' => 'यह ईमेल पते जैसा नहीं लग रहा।', 'hinglish' => 'Yeh email address jaisa nahi lag raha.'),
    'validation.min'             => array('en' => ':field must be at least :n characters.', 'hi' => ':field में कम से कम :n अक्षर होने चाहिए।', 'hinglish' => ':field mein kam se kam :n characters chahiye.'),
    'validation.max'             => array('en' => ':field must be :n characters or fewer.', 'hi' => ':field :n अक्षरों से ज़्यादा नहीं हो सकता।', 'hinglish' => ':field :n characters se zyada nahi ho sakta.'),
    'validation.integer'         => array('en' => ':field must be a whole number.', 'hi' => ':field पूर्ण संख्या होनी चाहिए।', 'hinglish' => ':field poora number hona chahiye.'),
    'validation.in'              => array('en' => 'That is not one of the allowed choices.', 'hi' => 'यह अनुमत विकल्पों में नहीं है।', 'hinglish' => 'Yeh allowed options mein nahi hai.'),
    'validation.between'         => array('en' => ':field must be between :min and :max.', 'hi' => ':field :min और :max के बीच होना चाहिए।', 'hinglish' => ':field :min se :max ke beech hona chahiye.'),
    'validation.words'           => array('en' => ':field needs at least :n words.', 'hi' => ':field में कम से कम :n शब्द चाहिए।', 'hinglish' => ':field mein kam se kam :n words chahiye.'),
    'validation.links'           => array('en' => 'Please include no more than :n link.', 'hi' => 'कृपया :n से ज़्यादा लिंक न डालें।', 'hinglish' => 'Please :n se zyada link mat daalo.'),
    'validation.format'          => array('en' => ':field is not in the right format.', 'hi' => ':field सही प्रारूप में नहीं है।', 'hinglish' => ':field sahi format mein nahi hai.'),
    'validation.matches'         => array('en' => ':field does not match.', 'hi' => ':field मेल नहीं खाता।', 'hinglish' => ':field match nahi kar raha.'),
    'validation.password_weak'   => array('en' => 'Use at least 10 characters with upper and lower case, a number and a symbol.', 'hi' => 'कम से कम 10 अक्षर, बड़े और छोटे अक्षर, एक अंक और एक चिह्न इस्तेमाल करें।', 'hinglish' => 'Kam se kam 10 characters, upper aur lower case, ek number aur ek symbol daalo.'),
    'validation.password_common' => array('en' => 'That password is on the list of most-guessed passwords. Pick something else.', 'hi' => 'यह पासवर्ड सबसे ज़्यादा अनुमान लगाए जाने वालों में है। कुछ और चुनें।', 'hinglish' => 'Yeh password sabse common list mein hai. Kuch aur chuno.'),
    'validation.csrf'            => array('en' => 'Your session expired while this form was open. Please try again.', 'hi' => 'फ़ॉर्म खुला रहते सत्र समाप्त हो गया। कृपया दोबारा कोशिश करें।', 'hinglish' => 'Form khula tha tab session expire ho gaya. Dobara try karo.'),
    'validation.throttled'       => array('en' => 'Too many attempts. Wait :n minutes and try again.', 'hi' => 'बहुत सारी कोशिशें। :n मिनट रुककर दोबारा कोशिश करें।', 'hinglish' => 'Bahut attempts ho gaye. :n minute ruk ke try karo.'),
    'validation.upload_type'     => array('en' => 'That file type is not allowed.', 'hi' => 'यह फ़ाइल प्रकार अनुमत नहीं है।', 'hinglish' => 'Yeh file type allowed nahi hai.'),
    'validation.upload_size'     => array('en' => 'That file is too large.', 'hi' => 'यह फ़ाइल बहुत बड़ी है।', 'hinglish' => 'Yeh file bahut badi hai.'),
    'validation.url'             => array('en' => 'That does not look like a web address.', 'hi' => 'यह वेब पते जैसा नहीं लग रहा।', 'hinglish' => 'Yeh web address jaisa nahi lag raha.'),
    'validation.date'            => array('en' => 'That is not a date we can read.', 'hi' => 'यह तारीख़ हम पढ़ नहीं पा रहे।', 'hinglish' => 'Yeh date hum padh nahi paa rahe.'),
    'validation.unique'          => array('en' => 'That :field is already taken.', 'hi' => 'यह :field पहले से लिया जा चुका है।', 'hinglish' => 'Yeh :field pehle se liya ja chuka hai.'),

    // -----------------------------------------------------------------
    // Generic flash notices
    // -----------------------------------------------------------------
    'flash.saved'      => array('en' => 'Saved.', 'hi' => 'सेव हो गया।', 'hinglish' => 'Save ho gaya.'),
    'flash.deleted'    => array('en' => 'Deleted.', 'hi' => 'हटा दिया गया।', 'hinglish' => 'Delete ho gaya.'),
    'flash.updated'    => array('en' => 'Updated.', 'hi' => 'अपडेट हो गया।', 'hinglish' => 'Update ho gaya.'),
    'flash.no_changes' => array('en' => 'Nothing changed.', 'hi' => 'कुछ नहीं बदला।', 'hinglish' => 'Kuch nahi badla.'),
    'flash.failed'     => array('en' => 'That did not work. Nothing was changed.', 'hi' => 'यह नहीं हो पाया। कुछ भी नहीं बदला।', 'hinglish' => 'Yeh nahi hua. Kuch bhi change nahi hua.'),
    'flash.dismiss'    => array('en' => 'Dismiss this message', 'hi' => 'यह संदेश हटाएँ', 'hinglish' => 'Yeh message hatao'),
);
