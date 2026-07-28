<?php
/**
 * VedaVerse — app/config/strings/common.php
 * ---------------------------------------------------------------------
 * Words and phrases used all over the interface: buttons, navigation,
 * the settings panel, relative time, the footer, offline notices.
 *
 * If a string is specific to one feature it belongs in that feature's
 * file. This one is for things that would otherwise be written five
 * times with five slightly different wordings.
 *
 * REGISTER
 *   en        Plain, warm, direct. Short sentences.
 *   hi        Natural spoken Hindi in Devanagari, not literary Hindi.
 *   hinglish  How urban India actually talks. Casual, code-switched,
 *             never cringe.
 *
 * PLACEHOLDERS
 *   :name style. Every language must carry the same set — a Hindi string
 *   that drops :n prints a sentence with a hole in it, and the string
 *   looks perfectly fine on its own in review. tools/check-strings.php
 *   catches exactly this.
 *
 * PLURALS
 *   Two forms separated by a pipe: singular|plural. Use tc() to print
 *   them. A value with no pipe is used as-is for every count.
 */

return array(

    // -----------------------------------------------------------------
    // The product
    // -----------------------------------------------------------------
    'common.app_name'    => array('en' => 'VedaVerse', 'hi' => 'VedaVerse', 'hinglish' => 'VedaVerse'),
    'common.tagline'     => array(
        'en'       => 'The Bhagavad Gita, as practical psychology.',
        'hi'       => 'भगवद्गीता, रोज़मर्रा के मनोविज्ञान की तरह।',
        'hinglish' => 'Bhagavad Gita, practical psychology ki tarah.',
    ),

    // -----------------------------------------------------------------
    // Answers and actions
    // -----------------------------------------------------------------
    'common.yes'         => array('en' => 'Yes', 'hi' => 'हाँ', 'hinglish' => 'Haan'),
    'common.no'          => array('en' => 'No', 'hi' => 'नहीं', 'hinglish' => 'Nahi'),
    'common.ok'          => array('en' => 'OK', 'hi' => 'ठीक है', 'hinglish' => 'Theek hai'),
    'common.save'        => array('en' => 'Save', 'hi' => 'सेव करें', 'hinglish' => 'Save karo'),
    'common.saved'       => array('en' => 'Saved', 'hi' => 'सेव हो गया', 'hinglish' => 'Save ho gaya'),
    'common.cancel'      => array('en' => 'Cancel', 'hi' => 'रद्द करें', 'hinglish' => 'Cancel'),
    'common.close'       => array('en' => 'Close', 'hi' => 'बंद करें', 'hinglish' => 'Band karo'),
    'common.edit'        => array('en' => 'Edit', 'hi' => 'बदलें', 'hinglish' => 'Edit karo'),
    'common.delete'      => array('en' => 'Delete', 'hi' => 'हटाएँ', 'hinglish' => 'Delete karo'),
    'common.confirm'     => array('en' => 'Confirm', 'hi' => 'पक्का करें', 'hinglish' => 'Confirm karo'),
    'common.back'        => array('en' => 'Back', 'hi' => 'वापस', 'hinglish' => 'Wapas'),
    'common.next'        => array('en' => 'Next', 'hi' => 'आगे', 'hinglish' => 'Aage'),
    'common.previous'    => array('en' => 'Previous', 'hi' => 'पिछला', 'hinglish' => 'Pichhla'),
    'common.continue'    => array('en' => 'Continue', 'hi' => 'जारी रखें', 'hinglish' => 'Continue karo'),
    'common.start'       => array('en' => 'Start', 'hi' => 'शुरू करें', 'hinglish' => 'Shuru karo'),
    'common.finish'      => array('en' => 'Finish', 'hi' => 'पूरा करें', 'hinglish' => 'Khatam karo'),
    'common.retry'       => array('en' => 'Try again', 'hi' => 'फिर कोशिश करें', 'hinglish' => 'Phir se try karo'),
    'common.skip'        => array('en' => 'Skip', 'hi' => 'छोड़ें', 'hinglish' => 'Chhod do'),
    'common.copy'        => array('en' => 'Copy', 'hi' => 'कॉपी करें', 'hinglish' => 'Copy karo'),
    'common.copied'      => array('en' => 'Copied', 'hi' => 'कॉपी हो गया', 'hinglish' => 'Copy ho gaya'),
    'common.share'       => array('en' => 'Share', 'hi' => 'साझा करें', 'hinglish' => 'Share karo'),
    'common.download'    => array('en' => 'Download', 'hi' => 'डाउनलोड करें', 'hinglish' => 'Download karo'),
    'common.print'       => array('en' => 'Print', 'hi' => 'प्रिंट करें', 'hinglish' => 'Print karo'),
    'common.search'      => array('en' => 'Search', 'hi' => 'खोजें', 'hinglish' => 'Search'),
    'common.filter'      => array('en' => 'Filter', 'hi' => 'छाँटें', 'hinglish' => 'Filter'),
    'common.clear'       => array('en' => 'Clear', 'hi' => 'हटाएँ', 'hinglish' => 'Clear karo'),
    'common.show_more'   => array('en' => 'Show more', 'hi' => 'और दिखाएँ', 'hinglish' => 'Aur dikhao'),
    'common.show_less'   => array('en' => 'Show less', 'hi' => 'कम दिखाएँ', 'hinglish' => 'Kam dikhao'),
    'common.read_more'   => array('en' => 'Read more', 'hi' => 'और पढ़ें', 'hinglish' => 'Aur padho'),
    'common.expand'      => array('en' => 'Expand', 'hi' => 'खोलें', 'hinglish' => 'Kholo'),
    'common.collapse'    => array('en' => 'Collapse', 'hi' => 'समेटें', 'hinglish' => 'Band karo'),
    'common.select'      => array('en' => 'Select', 'hi' => 'चुनें', 'hinglish' => 'Chuno'),
    'common.optional'    => array('en' => 'Optional', 'hi' => 'ज़रूरी नहीं', 'hinglish' => 'Optional'),
    'common.required'    => array('en' => 'Required', 'hi' => 'ज़रूरी', 'hinglish' => 'Zaroori'),
    'common.new'         => array('en' => 'New', 'hi' => 'नया', 'hinglish' => 'Naya'),

    // -----------------------------------------------------------------
    // States
    // -----------------------------------------------------------------
    'common.loading'     => array('en' => 'Loading', 'hi' => 'लोड हो रहा है', 'hinglish' => 'Load ho raha hai'),
    'common.saving'      => array('en' => 'Saving', 'hi' => 'सेव हो रहा है', 'hinglish' => 'Save ho raha hai'),
    'common.nothing_yet' => array('en' => 'Nothing here yet.', 'hi' => 'अभी यहाँ कुछ नहीं है।', 'hinglish' => 'Abhi yahan kuch nahi hai.'),
    'common.no_results'  => array('en' => 'Nothing matched that.', 'hi' => 'इससे कुछ मेल नहीं खाया।', 'hinglish' => 'Isse kuch match nahi hua.'),
    'common.coming_soon' => array('en' => 'Coming soon', 'hi' => 'जल्द आ रहा है', 'hinglish' => 'Jaldi aa raha hai'),

    // -----------------------------------------------------------------
    // Structure
    // -----------------------------------------------------------------
    'common.home'            => array('en' => 'Home', 'hi' => 'होम', 'hinglish' => 'Home'),
    'common.skip_to_content' => array('en' => 'Skip to content', 'hi' => 'सामग्री पर जाएँ', 'hinglish' => 'Content par jao'),
    'common.menu'            => array('en' => 'Menu', 'hi' => 'मेन्यू', 'hinglish' => 'Menu'),
    'common.page_of'         => array('en' => 'Page :n of :total', 'hi' => ':total में से पेज :n', 'hinglish' => 'Page :n of :total'),
    'common.of'              => array('en' => ':n of :total', 'hi' => ':total में से :n', 'hinglish' => ':n of :total'),
    'common.and'             => array('en' => 'and', 'hi' => 'और', 'hinglish' => 'aur'),
    'common.or'              => array('en' => 'or', 'hi' => 'या', 'hinglish' => 'ya'),

    // -----------------------------------------------------------------
    // Primary navigation
    // -----------------------------------------------------------------
    // Short, because a tab-bar label has about eight characters before it
    // wraps on a 320px screen. "Path" not "Learning Path", "Sarathi" not
    // "Ask Sarathi".
    'nav.primary'      => array('en' => 'Main navigation', 'hi' => 'मुख्य नेविगेशन', 'hinglish' => 'Main navigation'),
    'nav.path'         => array('en' => 'Path', 'hi' => 'रास्ता', 'hinglish' => 'Path'),
    'nav.review'       => array('en' => 'Review', 'hi' => 'दोहराएँ', 'hinglish' => 'Review'),
    'nav.sarathi'      => array('en' => 'Sarathi', 'hi' => 'सारथी', 'hinglish' => 'Sarathi'),
    'nav.explore'      => array('en' => 'Explore', 'hi' => 'खोजें', 'hinglish' => 'Explore'),
    'nav.profile'      => array('en' => 'You', 'hi' => 'आप', 'hinglish' => 'Tum'),
    'nav.chapters'     => array('en' => 'Chapters', 'hi' => 'अध्याय', 'hinglish' => 'Chapters'),
    'nav.topics'       => array('en' => 'Topics', 'hi' => 'विषय', 'hinglish' => 'Topics'),
    'nav.problems'     => array('en' => 'Life problems', 'hi' => 'जीवन की समस्याएँ', 'hinglish' => 'Life ke problems'),
    'nav.forum'        => array('en' => 'Community', 'hi' => 'समुदाय', 'hinglish' => 'Community'),
    'nav.admin'        => array('en' => 'Admin', 'hi' => 'एडमिन', 'hinglish' => 'Admin'),
    'nav.breadcrumb'   => array('en' => 'You are here', 'hi' => 'आप यहाँ हैं', 'hinglish' => 'Tum yahan ho'),

    // -----------------------------------------------------------------
    // Display settings
    // -----------------------------------------------------------------
    'settings.open'         => array('en' => 'Display settings', 'hi' => 'प्रदर्शन सेटिंग', 'hinglish' => 'Display settings'),
    'settings.theme'        => array('en' => 'Appearance', 'hi' => 'रंग-रूप', 'hinglish' => 'Look'),
    'settings.theme.light'  => array('en' => 'Light', 'hi' => 'उजला', 'hinglish' => 'Light'),
    'settings.theme.dark'   => array('en' => 'Dark', 'hi' => 'गहरा', 'hinglish' => 'Dark'),
    'settings.theme.system' => array('en' => 'Automatic', 'hi' => 'अपने आप', 'hinglish' => 'Apne aap'),
    'settings.size'         => array('en' => 'Text size', 'hi' => 'अक्षरों का आकार', 'hinglish' => 'Text ka size'),
    'settings.size.step'    => array('en' => 'Text size :n of 4', 'hi' => '4 में से :n आकार', 'hinglish' => 'Size :n of 4'),
    'settings.language'     => array('en' => 'Language', 'hi' => 'भाषा', 'hinglish' => 'Bhasha'),
    'settings.account'      => array('en' => 'Account', 'hi' => 'खाता', 'hinglish' => 'Account'),
    'settings.saved'        => array('en' => 'Preferences saved on this device.', 'hi' => 'पसंद इस डिवाइस पर सेव हो गई।', 'hinglish' => 'Preferences is device par save ho gayi.'),

    // -----------------------------------------------------------------
    // Language names, for the switcher and the review page
    // -----------------------------------------------------------------
    // Each written in its own language, because a reader looking for
    // their language scans for the word they would use for it.
    'lang.en'       => array('en' => 'English', 'hi' => 'English', 'hinglish' => 'English'),
    'lang.hi'       => array('en' => 'हिन्दी', 'hi' => 'हिन्दी', 'hinglish' => 'हिन्दी'),
    'lang.hinglish' => array('en' => 'Hinglish', 'hi' => 'Hinglish', 'hinglish' => 'Hinglish'),
    'lang.sa'       => array('en' => 'Sanskrit', 'hi' => 'संस्कृत', 'hinglish' => 'Sanskrit'),
    'lang.switch'   => array('en' => 'Read this in :language', 'hi' => 'इसे :language में पढ़ें', 'hinglish' => 'Ise :language mein padho'),

    // -----------------------------------------------------------------
    // Forms
    // -----------------------------------------------------------------
    'form.errors_heading' => array('en' => 'Please fix these first', 'hi' => 'पहले इन्हें ठीक करें', 'hinglish' => 'Pehle yeh theek karo'),
    'form.required_note'  => array('en' => 'All fields are required.', 'hi' => 'सभी फ़ील्ड ज़रूरी हैं।', 'hinglish' => 'Saare fields zaroori hain.'),
    'form.optional_note'  => array('en' => 'Anything marked optional can be left blank.', 'hi' => 'जिन पर “ज़रूरी नहीं” लिखा है, उन्हें खाली छोड़ सकते हैं।', 'hinglish' => 'Jin par optional likha hai, unhe khaali chhod sakte ho.'),
    'form.characters_left'=> array('en' => ':n character left|:n characters left', 'hi' => ':n अक्षर बचा|:n अक्षर बचे', 'hinglish' => ':n character bacha|:n character bache'),
    'form.unsaved'        => array('en' => 'You have changes that are not saved yet.', 'hi' => 'कुछ बदलाव अभी सेव नहीं हुए हैं।', 'hinglish' => 'Kuch changes abhi save nahi hue hain.'),

    // -----------------------------------------------------------------
    // Relative time
    // -----------------------------------------------------------------
    'time.just_now'       => array('en' => 'just now', 'hi' => 'अभी', 'hinglish' => 'abhi'),
    'time.minutes'        => array('en' => ':n minutes ago', 'hi' => ':n मिनट पहले', 'hinglish' => ':n minute pehle'),
    'time.hours'          => array('en' => ':n hours ago', 'hi' => ':n घंटे पहले', 'hinglish' => ':n ghante pehle'),
    'time.days'           => array('en' => ':n days ago', 'hi' => ':n दिन पहले', 'hinglish' => ':n din pehle'),
    'time.minutes_short'  => array('en' => ':n min', 'hi' => ':n मिनट', 'hinglish' => ':n min'),
    'time.under_a_minute' => array('en' => 'under a minute', 'hi' => 'एक मिनट से कम', 'hinglish' => 'ek minute se kam'),
    'time.today'          => array('en' => 'today', 'hi' => 'आज', 'hinglish' => 'aaj'),
    'time.yesterday'      => array('en' => 'yesterday', 'hi' => 'कल', 'hinglish' => 'kal'),
    'time.day_count'      => array('en' => ':n day|:n days', 'hi' => ':n दिन|:n दिन', 'hinglish' => ':n din|:n din'),
    'time.minute_count'   => array('en' => ':n minute|:n minutes', 'hi' => ':n मिनट|:n मिनट', 'hinglish' => ':n minute|:n minute'),

    // -----------------------------------------------------------------
    // Difficulty
    // -----------------------------------------------------------------
    'difficulty.beginner'     => array('en' => 'Beginner', 'hi' => 'शुरुआती', 'hinglish' => 'Shuruaati'),
    'difficulty.intermediate' => array('en' => 'Intermediate', 'hi' => 'मध्यम', 'hinglish' => 'Medium'),
    'difficulty.advanced'     => array('en' => 'Advanced', 'hi' => 'उन्नत', 'hinglish' => 'Advanced'),

    // -----------------------------------------------------------------
    // Footer
    // -----------------------------------------------------------------
    // The claim that matters legally and editorially: every word of
    // translation, explanation and example here is original writing.
    'footer.original_work' => array(
        'en'       => 'Every translation and example here is original writing.',
        'hi'       => 'यहाँ का हर अनुवाद और उदाहरण मौलिक लेखन है।',
        'hinglish' => 'Yahan ka har translation aur example original likha gaya hai.',
    ),
    'footer.about'     => array('en' => 'About', 'hi' => 'परिचय', 'hinglish' => 'About'),
    'footer.privacy'   => array('en' => 'Privacy', 'hi' => 'निजता', 'hinglish' => 'Privacy'),
    'footer.terms'     => array('en' => 'Terms', 'hi' => 'शर्तें', 'hinglish' => 'Terms'),
    'footer.contact'   => array('en' => 'Contact', 'hi' => 'संपर्क', 'hinglish' => 'Contact'),
    'footer.licence'   => array('en' => 'Licence', 'hi' => 'लाइसेंस', 'hinglish' => 'Licence'),
    'footer.sources'   => array('en' => 'Sources', 'hi' => 'स्रोत', 'hinglish' => 'Sources'),

    // -----------------------------------------------------------------
    // Offline and installing
    // -----------------------------------------------------------------
    'offline.badge'      => array('en' => 'Offline', 'hi' => 'ऑफ़लाइन', 'hinglish' => 'Offline'),
    'offline.saved_here' => array('en' => 'Saved on this device. It will sync when you are back online.', 'hi' => 'इस डिवाइस पर सेव है। ऑनलाइन आते ही सिंक हो जाएगा।', 'hinglish' => 'Is device par save hai. Online aate hi sync ho jayega.'),
    'offline.chat'       => array('en' => 'Sarathi needs a connection. Until then, search the verses or read what is already saved here.', 'hi' => 'सारथी को कनेक्शन चाहिए। तब तक श्लोक खोजें या जो सेव है वह पढ़ें।', 'hinglish' => 'Sarathi ko connection chahiye. Tab tak verses search karo ya jo saved hai woh padho.'),
    'offline.title'      => array('en' => 'You are offline', 'hi' => 'आप ऑफ़लाइन हैं', 'hinglish' => 'Tum offline ho'),
    'offline.body'       => array('en' => 'The verses you have already opened are still here. New ones need a connection.', 'hi' => 'जो श्लोक आप पहले खोल चुके हैं वे यहीं हैं। नए के लिए कनेक्शन चाहिए।', 'hinglish' => 'Jo verses tum pehle khol chuke ho woh yahin hain. Naye ke liye connection chahiye.'),
    'offline.back_online'=> array('en' => 'Back online. Syncing your progress.', 'hi' => 'फिर ऑनलाइन। आपकी प्रगति सिंक हो रही है।', 'hinglish' => 'Wapas online. Progress sync ho rahi hai.'),
    'offline.available'  => array('en' => 'Available offline', 'hi' => 'ऑफ़लाइन उपलब्ध', 'hinglish' => 'Offline available'),

    'pwa.install.title'  => array('en' => 'Keep VedaVerse on your home screen', 'hi' => 'VedaVerse को होम स्क्रीन पर रखें', 'hinglish' => 'VedaVerse ko home screen par rakho'),
    'pwa.install.body'   => array('en' => 'It opens like an app and works without a connection.', 'hi' => 'यह ऐप की तरह खुलता है और बिना कनेक्शन के भी चलता है।', 'hinglish' => 'App ki tarah khulta hai aur bina internet ke bhi chalta hai.'),
    'pwa.install.action' => array('en' => 'Add to home screen', 'hi' => 'होम स्क्रीन पर जोड़ें', 'hinglish' => 'Home screen par add karo'),
    'pwa.install.later'  => array('en' => 'Not now', 'hi' => 'अभी नहीं', 'hinglish' => 'Abhi nahi'),

    // -----------------------------------------------------------------
    // Sharing
    // -----------------------------------------------------------------
    'share.copy_link'    => array('en' => 'Copy link', 'hi' => 'लिंक कॉपी करें', 'hinglish' => 'Link copy karo'),
    'share.link_copied'  => array('en' => 'Link copied. It opens in the language you are reading in.', 'hi' => 'लिंक कॉपी हो गया। यह उसी भाषा में खुलेगा जिसमें आप पढ़ रहे हैं।', 'hinglish' => 'Link copy ho gaya. Usi bhasha mein khulega jisme tum padh rahe ho.'),
    'share.whatsapp'     => array('en' => 'Send on WhatsApp', 'hi' => 'व्हाट्सऐप पर भेजें', 'hinglish' => 'WhatsApp par bhejo'),
);
