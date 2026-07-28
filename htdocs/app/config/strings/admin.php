<?php
/**
 * VedaVerse — app/config/strings/admin.php
 * ---------------------------------------------------------------------
 * The admin panel: the moderation queue, the content editor, imports,
 * backups, users and settings.
 *
 * WHY THE ADMIN PANEL IS TRANSLATED AT ALL
 *   Because the person running it may well prefer Hindi, and because
 *   "no hardcoded English in any view" has no exceptions — the moment
 *   one screen is allowed to skip the string table, the next one does
 *   too, and the rule stops meaning anything.
 *
 * REGISTER IS DIFFERENT HERE
 *   Slightly more direct, and it uses the words an operator actually
 *   needs: row, table, rollback, hash. A moderator working through a
 *   queue at speed is served by precision, not by warmth. Even so the
 *   destructive confirmations spell out exactly what will be lost —
 *   that is where warmth turns into not ruining somebody's evening.
 */

return array(

    // -----------------------------------------------------------------
    // Shell
    // -----------------------------------------------------------------
    'admin.title'        => array('en' => 'Admin', 'hi' => 'एडमिन', 'hinglish' => 'Admin'),
    'admin.dashboard'    => array('en' => 'Overview', 'hi' => 'सारांश', 'hinglish' => 'Overview'),
    'admin.back_to_site' => array('en' => 'Back to the site', 'hi' => 'साइट पर वापस', 'hinglish' => 'Site par wapas'),
    'admin.signed_in_as' => array('en' => 'Signed in as :name (:role)', 'hi' => ':name (:role) के रूप में साइन इन', 'hinglish' => ':name (:role) ke roop mein signed in'),

    'admin.nav.moderation'  => array('en' => 'Moderation queue', 'hi' => 'मॉडरेशन कतार', 'hinglish' => 'Moderation queue'),
    'admin.nav.content'     => array('en' => 'Content', 'hi' => 'सामग्री', 'hinglish' => 'Content'),
    'admin.nav.users'       => array('en' => 'People', 'hi' => 'लोग', 'hinglish' => 'Log'),
    'admin.nav.imports'     => array('en' => 'Import', 'hi' => 'आयात', 'hinglish' => 'Import'),
    'admin.nav.backups'     => array('en' => 'Backups', 'hi' => 'बैकअप', 'hinglish' => 'Backup'),
    'admin.nav.settings'    => array('en' => 'Settings', 'hi' => 'सेटिंग', 'hinglish' => 'Settings'),
    'admin.nav.logs'        => array('en' => 'Logs', 'hi' => 'लॉग', 'hinglish' => 'Logs'),

    // -----------------------------------------------------------------
    // Overview
    // -----------------------------------------------------------------
    'admin.stat.pending'    => array('en' => 'Waiting for review', 'hi' => 'समीक्षा के इंतज़ार में', 'hinglish' => 'Review ke wait mein'),
    'admin.stat.users'      => array('en' => 'Accounts', 'hi' => 'खाते', 'hinglish' => 'Accounts'),
    'admin.stat.verses'     => array('en' => 'Curated verses', 'hi' => 'तैयार श्लोक', 'hinglish' => 'Ready shlok'),
    'admin.stat.searches'   => array('en' => 'Searches this week', 'hi' => 'इस हफ़्ते की खोजें', 'hinglish' => 'Is hafte ki searches'),
    'admin.stat.ai_fallback'=> array('en' => 'Answers from the fallback provider', 'hi' => 'वैकल्पिक प्रदाता से आए जवाब', 'hinglish' => 'Fallback provider se aaye jawab'),
    'admin.stat.errors'     => array('en' => 'Errors in the last day', 'hi' => 'पिछले दिन की त्रुटियाँ', 'hinglish' => 'Pichhle din ke errors'),

    // -----------------------------------------------------------------
    // Moderation
    // -----------------------------------------------------------------
    // The screen the owner will spend the most time in. Short labels,
    // because they sit on buttons pressed hundreds of times.
    'admin.mod.queue'       => array('en' => 'Queue', 'hi' => 'कतार', 'hinglish' => 'Queue'),
    'admin.mod.empty'       => array('en' => 'Queue is clear.', 'hi' => 'कतार खाली है।', 'hinglish' => 'Queue khaali hai.'),
    'admin.mod.approve'     => array('en' => 'Approve', 'hi' => 'मंज़ूर', 'hinglish' => 'Approve'),
    'admin.mod.reject'      => array('en' => 'Reject', 'hi' => 'अस्वीकार', 'hinglish' => 'Reject'),
    'admin.mod.ban'         => array('en' => 'Ban the author', 'hi' => 'लेखक पर रोक', 'hinglish' => 'Author ko ban karo'),
    'admin.mod.bulk'        => array('en' => 'Approve all selected', 'hi' => 'चुने हुए सब मंज़ूर करें', 'hinglish' => 'Selected sab approve karo'),
    'admin.mod.reason'      => array('en' => 'Reason shown to the author', 'hi' => 'लेखक को दिखाया जाने वाला कारण', 'hinglish' => 'Author ko dikhaya jaane wala reason'),
    'admin.mod.reason_hint' => array('en' => 'They will read this. One clear sentence.', 'hi' => 'वे इसे पढ़ेंगे। एक साफ़ वाक्य।', 'hinglish' => 'Woh ise padhenge. Ek clear line.'),
    'admin.mod.approved'    => array('en' => 'Approved and live.', 'hi' => 'मंज़ूर, अब लाइव है।', 'hinglish' => 'Approve ho gaya, live hai.'),
    'admin.mod.rejected'    => array('en' => 'Rejected. The author can see the reason.', 'hi' => 'अस्वीकार। लेखक कारण देख सकता है।', 'hinglish' => 'Reject kar diya. Author reason dekh sakta hai.'),
    'admin.mod.shortcuts'   => array('en' => 'A approve · R reject · J next · K previous', 'hi' => 'A मंज़ूर · R अस्वीकार · J अगला · K पिछला', 'hinglish' => 'A approve · R reject · J agla · K pichhla'),

    // The AI score sorts the queue. It never decides anything, and the
    // label has to keep saying so — the day it reads as a verdict is the
    // day somebody starts approving by score.
    'admin.mod.ai_score'    => array('en' => 'AI risk score', 'hi' => 'AI जोखिम अंक', 'hinglish' => 'AI risk score'),
    'admin.mod.ai_reason'   => array('en' => 'What the AI flagged', 'hi' => 'AI ने क्या चिह्नित किया', 'hinglish' => 'AI ne kya flag kiya'),
    'admin.mod.ai_note'     => array('en' => 'This only sorts the queue. Nothing is approved or rejected without you.', 'hi' => 'यह सिर्फ़ कतार को क्रम में लगाता है। आपके बिना कुछ भी मंज़ूर या अस्वीकार नहीं होता।', 'hinglish' => 'Yeh sirf queue ko sort karta hai. Tumhare bina kuch approve ya reject nahi hota.'),
    'admin.mod.unscored'    => array('en' => 'Not scored — the scoring service was unreachable.', 'hi' => 'अंक नहीं मिला — स्कोरिंग सेवा तक पहुँच नहीं हो सकी।', 'hinglish' => 'Score nahi mila — scoring service tak pahunch nahi hui.'),

    // -----------------------------------------------------------------
    // Content editing
    // -----------------------------------------------------------------
    'admin.content.title'    => array('en' => 'Content', 'hi' => 'सामग्री', 'hinglish' => 'Content'),
    'admin.content.new'      => array('en' => 'Add', 'hi' => 'जोड़ें', 'hinglish' => 'Add karo'),
    'admin.content.edit'     => array('en' => 'Edit', 'hi' => 'संपादित करें', 'hinglish' => 'Edit karo'),
    'admin.content.publish'  => array('en' => 'Publish', 'hi' => 'प्रकाशित करें', 'hinglish' => 'Publish karo'),
    'admin.content.unpublish'=> array('en' => 'Take down', 'hi' => 'हटाएँ', 'hinglish' => 'Hatao'),
    'admin.content.draft'    => array('en' => 'Draft', 'hi' => 'मसौदा', 'hinglish' => 'Draft'),
    'admin.content.published'=> array('en' => 'Published', 'hi' => 'प्रकाशित', 'hinglish' => 'Published'),
    'admin.content.missing_lang' => array('en' => 'Missing in :language', 'hi' => ':language में नहीं है', 'hinglish' => ':language mein nahi hai'),
    'admin.content.all_langs'=> array('en' => 'All three languages are filled in.', 'hi' => 'तीनों भाषाएँ भरी हुई हैं।', 'hinglish' => 'Teeno bhasha bhari hui hain.'),
    'admin.content.curated'  => array('en' => 'Fully written', 'hi' => 'पूरी तरह लिखा हुआ', 'hinglish' => 'Poora likha hua'),
    'admin.content.stub'     => array('en' => 'Sanskrit and translation only', 'hi' => 'सिर्फ़ संस्कृत और अनुवाद', 'hinglish' => 'Sirf Sanskrit aur translation'),

    // The rule that keeps this project out of a copyright dispute. It is
    // in the editor, next to the field, not in a policy document.
    'admin.content.original_only' => array('en' => 'Write every translation yourself. Do not paste from a published translation — the Sanskrit is public domain, modern renderings are not.', 'hi' => 'हर अनुवाद खुद लिखें। किसी प्रकाशित अनुवाद से कॉपी न करें — संस्कृत सार्वजनिक है, आधुनिक अनुवाद नहीं।', 'hinglish' => 'Har translation khud likho. Kisi published translation se paste mat karo — Sanskrit public domain hai, modern translations nahi.'),
    'admin.content.no_quotes'     => array('en' => 'Describe films and events in your own words. No dialogue, no lyrics.', 'hi' => 'फ़िल्मों और घटनाओं को अपने शब्दों में लिखें। कोई संवाद नहीं, कोई गीत नहीं।', 'hinglish' => 'Filmon aur events ko apne shabdon mein likho. Koi dialogue nahi, koi lyrics nahi.'),
    'admin.content.no_politics'   => array('en' => 'Political examples describe the shape of a dilemma only. No praise or criticism of any living figure, party or movement.', 'hi' => 'राजनीतिक उदाहरण सिर्फ़ दुविधा का ढाँचा बताएँ। किसी जीवित व्यक्ति, दल या आंदोलन की प्रशंसा या आलोचना नहीं।', 'hinglish' => 'Political examples sirf dilemma ka shape batayein. Kisi zinda vyakti, party ya movement ki taareef ya criticism nahi.'),

    // -----------------------------------------------------------------
    // Import
    // -----------------------------------------------------------------
    'admin.import.title'     => array('en' => 'Import a CSV', 'hi' => 'CSV आयात करें', 'hinglish' => 'CSV import karo'),
    'admin.import.file'      => array('en' => 'The file', 'hi' => 'फ़ाइल', 'hinglish' => 'File'),
    'admin.import.type'      => array('en' => 'What is in it', 'hi' => 'इसमें क्या है', 'hinglish' => 'Isme kya hai'),
    'admin.import.run'       => array('en' => 'Import', 'hi' => 'आयात करें', 'hinglish' => 'Import karo'),
    'admin.import.dry_run'   => array('en' => 'Check it without importing', 'hi' => 'बिना आयात किए जाँचें', 'hinglish' => 'Bina import kiye check karo'),
    // All-or-nothing, and the message says so before the button is
    // pressed. A half-imported chapter is worse than no import.
    'admin.import.atomic'    => array('en' => 'One bad row rolls the whole file back. Nothing is imported unless everything is.', 'hi' => 'एक खराब पंक्ति पूरी फ़ाइल को वापस कर देती है। सब सही होने पर ही कुछ आयात होता है।', 'hinglish' => 'Ek kharab row poori file ko rollback kar deti hai. Sab sahi hoga tabhi kuch import hoga.'),
    'admin.import.result'    => array('en' => ':ok of :total rows were fine.', 'hi' => ':total में से :ok पंक्तियाँ ठीक थीं।', 'hinglish' => ':total mein se :ok rows theek thi.'),
    'admin.import.rolled_back' => array('en' => 'Rolled back. Nothing was written.', 'hi' => 'वापस कर दिया गया। कुछ नहीं लिखा गया।', 'hinglish' => 'Rollback ho gaya. Kuch nahi likha gaya.'),
    'admin.import.errors'    => array('en' => 'What went wrong, by row', 'hi' => 'पंक्ति के हिसाब से क्या गलत था', 'hinglish' => 'Row ke hisaab se kya galat tha'),
    'admin.import.row'       => array('en' => 'Row :n', 'hi' => 'पंक्ति :n', 'hinglish' => 'Row :n'),
    'admin.import.done'      => array('en' => 'Imported :n row.|Imported :n rows.', 'hi' => ':n पंक्ति आयात हुई।|:n पंक्तियाँ आयात हुईं।', 'hinglish' => ':n row import hui.|:n rows import hui.'),

    // -----------------------------------------------------------------
    // People
    // -----------------------------------------------------------------
    'admin.users.title'   => array('en' => 'People', 'hi' => 'लोग', 'hinglish' => 'Log'),
    'admin.users.search'  => array('en' => 'Find by name or email', 'hi' => 'नाम या ईमेल से खोजें', 'hinglish' => 'Naam ya email se dhoondho'),
    'admin.users.role'    => array('en' => 'Role', 'hi' => 'भूमिका', 'hinglish' => 'Role'),
    'admin.users.status'  => array('en' => 'Status', 'hi' => 'स्थिति', 'hinglish' => 'Status'),
    'admin.users.joined'  => array('en' => 'Joined', 'hi' => 'जुड़े', 'hinglish' => 'Joined'),
    'admin.users.suspend' => array('en' => 'Suspend', 'hi' => 'निलंबित करें', 'hinglish' => 'Suspend karo'),
    'admin.users.restore' => array('en' => 'Restore', 'hi' => 'बहाल करें', 'hinglish' => 'Wapas laao'),
    'admin.role.user'       => array('en' => 'Reader', 'hi' => 'पाठक', 'hinglish' => 'Reader'),
    'admin.role.moderator'  => array('en' => 'Moderator', 'hi' => 'मॉडरेटर', 'hinglish' => 'Moderator'),
    'admin.role.admin'      => array('en' => 'Admin', 'hi' => 'एडमिन', 'hinglish' => 'Admin'),
    'admin.role.superadmin' => array('en' => 'Owner', 'hi' => 'मालिक', 'hinglish' => 'Owner'),

    // -----------------------------------------------------------------
    // Settings
    // -----------------------------------------------------------------
    'admin.settings.site'        => array('en' => 'Site', 'hi' => 'साइट', 'hinglish' => 'Site'),
    'admin.settings.ai'          => array('en' => 'Sarathi', 'hi' => 'सारथी', 'hinglish' => 'Sarathi'),
    'admin.settings.features'    => array('en' => 'Features', 'hi' => 'सुविधाएँ', 'hinglish' => 'Features'),
    'admin.settings.seo'         => array('en' => 'Search engines', 'hi' => 'सर्च इंजन', 'hinglish' => 'Search engines'),
    'admin.settings.maintenance' => array('en' => 'Maintenance mode', 'hi' => 'रखरखाव मोड', 'hinglish' => 'Maintenance mode'),
    'admin.settings.maintenance_note' => array('en' => 'Everybody sees a “back shortly” page. You keep full access.', 'hi' => 'सबको “जल्द वापस आते हैं” वाला पेज दिखेगा। आपकी पहुँच बनी रहेगी।', 'hinglish' => 'Sabko “thodi der mein wapas” wala page dikhega. Tumhara access chalta rahega.'),
    'admin.settings.worker_url'  => array('en' => 'Worker URL', 'hi' => 'वर्कर URL', 'hinglish' => 'Worker URL'),
    'admin.settings.chat_cap'    => array('en' => 'Questions per person per day', 'hi' => 'प्रति व्यक्ति प्रतिदिन सवाल', 'hinglish' => 'Per person per day sawaal'),
    'admin.settings.saved'       => array('en' => 'Settings saved.', 'hi' => 'सेटिंग सेव हो गईं।', 'hinglish' => 'Settings save ho gayi.'),

    // -----------------------------------------------------------------
    // Offline bundle
    // -----------------------------------------------------------------
    'admin.bundle.title'    => array('en' => 'Offline bundle', 'hi' => 'ऑफ़लाइन बंडल', 'hinglish' => 'Offline bundle'),
    'admin.bundle.rebuild'  => array('en' => 'Rebuild it', 'hi' => 'फिर से बनाएँ', 'hinglish' => 'Phir se banao'),
    'admin.bundle.size'     => array('en' => 'Current size: :size', 'hi' => 'अभी का आकार: :size', 'hinglish' => 'Abhi ka size: :size'),
    'admin.bundle.too_big'  => array('en' => 'Over 5 MB. Split it by chapter, or readers on slow connections will never finish downloading it.', 'hi' => '5 MB से ऊपर। इसे अध्याय के हिसाब से बाँटें, वरना धीमे कनेक्शन वाले पाठक इसे कभी डाउनलोड नहीं कर पाएँगे।', 'hinglish' => '5 MB se upar. Chapter ke hisaab se todo, warna slow connection wale readers kabhi download nahi kar payenge.'),
    'admin.bundle.built'    => array('en' => 'Rebuilt. :size, :n verses.', 'hi' => 'फिर से बना। :size, :n श्लोक।', 'hinglish' => 'Phir se ban gaya. :size, :n shlok.'),

    // -----------------------------------------------------------------
    // Backups
    // -----------------------------------------------------------------
    'admin.backup.title'    => array('en' => 'Backups', 'hi' => 'बैकअप', 'hinglish' => 'Backup'),
    'admin.backup.make'     => array('en' => 'Make one now', 'hi' => 'अभी बनाएँ', 'hinglish' => 'Abhi banao'),
    'admin.backup.download' => array('en' => 'Download', 'hi' => 'डाउनलोड करें', 'hinglish' => 'Download karo'),
    'admin.backup.note'     => array('en' => 'Download it somewhere else. A backup living on the same host as the site it backs up is not a backup.', 'hi' => 'इसे कहीं और डाउनलोड करके रखें। जिस होस्ट का बैकअप है उसी पर रखा बैकअप, बैकअप नहीं है।', 'hinglish' => 'Ise kahin aur download karke rakho. Jis host ka backup hai usi par pada backup, backup nahi hai.'),
    'admin.backup.none'     => array('en' => 'No backups yet.', 'hi' => 'अभी कोई बैकअप नहीं।', 'hinglish' => 'Abhi koi backup nahi.'),

    // -----------------------------------------------------------------
    // Destructive confirmations
    // -----------------------------------------------------------------
    'admin.danger.title'   => array('en' => 'This cannot be undone', 'hi' => 'यह वापस नहीं हो सकता', 'hinglish' => 'Yeh wapas nahi ho sakta'),
    'admin.danger.confirm' => array('en' => 'Type :word to confirm', 'hi' => 'पक्का करने के लिए :word लिखें', 'hinglish' => 'Confirm karne ke liye :word likho'),
    'admin.danger.cancel'  => array('en' => 'Leave it alone', 'hi' => 'रहने दें', 'hinglish' => 'Rehne do'),

    // -----------------------------------------------------------------
    // Logs
    // -----------------------------------------------------------------
    'admin.logs.title'    => array('en' => 'Logs', 'hi' => 'लॉग', 'hinglish' => 'Logs'),
    'admin.logs.level'    => array('en' => 'Level', 'hi' => 'स्तर', 'hinglish' => 'Level'),
    'admin.logs.when'     => array('en' => 'When', 'hi' => 'कब', 'hinglish' => 'Kab'),
    'admin.logs.empty'    => array('en' => 'Nothing logged.', 'hi' => 'कुछ दर्ज नहीं हुआ।', 'hinglish' => 'Kuch log nahi hua.'),
    'admin.logs.privacy'  => array('en' => 'IP addresses are stored as hashes and chat content is never logged. There is nothing here to identify a reader by.', 'hi' => 'आईपी पते हैश के रूप में सुरक्षित हैं और चैट की सामग्री कभी दर्ज नहीं होती। यहाँ किसी पाठक को पहचानने लायक कुछ नहीं है।', 'hinglish' => 'IP address hash ban ke store hote hain aur chat content kabhi log nahi hota. Yahan kisi reader ko pehchanne layak kuch nahi hai.'),

    // -----------------------------------------------------------------
    // The string review page
    // -----------------------------------------------------------------
    'admin.strings.title'   => array('en' => 'Interface strings', 'hi' => 'इंटरफ़ेस स्ट्रिंग', 'hinglish' => 'Interface strings'),
    'admin.strings.lead'    => array('en' => 'Every interface string in all three languages, side by side. Read the Hinglish column out loud — if it sounds like a translation rather than a person talking, it needs rewriting.', 'hi' => 'हर इंटरफ़ेस स्ट्रिंग, तीनों भाषाओं में, साथ-साथ। Hinglish वाला कॉलम ज़ोर से पढ़ें — अगर वह किसी की बात नहीं, अनुवाद जैसा लगे, तो उसे दोबारा लिखना चाहिए।', 'hinglish' => 'Har interface string, teeno bhasha mein, saath saath. Hinglish column zor se padho — agar woh kisi ki baat nahi, translation jaisa lage, to use dobara likhna chahiye.'),
    'admin.strings.domain'  => array('en' => 'Group', 'hi' => 'समूह', 'hinglish' => 'Group'),
    'admin.strings.key'     => array('en' => 'Key', 'hi' => 'कुंजी', 'hinglish' => 'Key'),
    'admin.strings.total'   => array('en' => ':n key|:n keys', 'hi' => ':n कुंजी|:n कुंजियाँ', 'hinglish' => ':n key|:n keys'),
    'admin.strings.ok'      => array('en' => 'No gaps, no placeholder mismatches.', 'hi' => 'कोई कमी नहीं, कोई प्लेसहोल्डर गड़बड़ी नहीं।', 'hinglish' => 'Koi gap nahi, koi placeholder mismatch nahi.'),
    'admin.strings.legend'  => array(
        'en'       => 'A :placeholder must appear in all three languages. A | separates the singular form from the plural.',
        'hi'       => 'एक :placeholder तीनों भाषाओं में होना चाहिए। एक | एकवचन को बहुवचन से अलग करता है।',
        'hinglish' => 'Ek :placeholder teeno bhasha mein hona chahiye. Ek | singular ko plural se alag karta hai.',
    ),
    'admin.strings.cli'     => array(
        'en'       => 'Run php tools/check-strings.php to check both from the command line.',
        'hi'       => 'दोनों को कमांड लाइन से जाँचने के लिए php tools/check-strings.php चलाएँ।',
        'hinglish' => 'Dono ko command line se check karne ke liye php tools/check-strings.php chalao.',
    ),
    'admin.strings.problems'=> array('en' => 'Problems found', 'hi' => 'मिली समस्याएँ', 'hinglish' => 'Mili problems'),
);
