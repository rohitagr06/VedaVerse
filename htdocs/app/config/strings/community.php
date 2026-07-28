<?php
/**
 * VedaVerse — app/config/strings/community.php
 * ---------------------------------------------------------------------
 * Sarathi, the AI companion, and the pre-moderated forum.
 *
 * SARATHI MUST NEVER PRETEND
 *   Not to be a person, not to be a guru, and not to know something it
 *   is guessing at. The strings here say which provider answered, say
 *   plainly when it is offline and running on the cached text instead,
 *   and label AI-written material as AI-written. A companion that hides
 *   what it is would be a better demo and a worse teacher.
 *
 * THE FORUM IS PRE-MODERATED, AND THE WAIT MUST BE HONEST
 *   Nothing appears publicly until a human approves it. The confirmation
 *   after posting has to say so clearly, or a person will assume their
 *   post was swallowed and write it again. It also must not promise a
 *   turnaround time nobody can keep.
 *
 * ANTI-SPAM MESSAGES SPEAK TO THE PERSON, NOT THE SPAMMER
 *   The someone who trips the 24-hour rule or the five-minute rule is
 *   almost always a real person in a hurry. These read as house rules,
 *   not accusations.
 */

return array(

    // -----------------------------------------------------------------
    // Sarathi
    // -----------------------------------------------------------------
    'chat.title'       => array('en' => 'Sarathi', 'hi' => 'सारथी', 'hinglish' => 'Sarathi'),
    'chat.lead'        => array('en' => 'Ask about anything in the text, or about something happening in your life. Sarathi answers from the verses.', 'hi' => 'ग्रंथ के बारे में कुछ भी पूछें, या अपनी ज़िंदगी की किसी बात के बारे में। सारथी श्लोकों से जवाब देता है।', 'hinglish' => 'Text ke baare mein kuch bhi poocho, ya apni life ki kisi baat ke baare mein. Sarathi shlokon se jawab deta hai.'),
    'chat.what_is'     => array('en' => 'Sarathi means charioteer. In the text, that is Krishna’s role — the one who drives while Arjuna decides.', 'hi' => 'सारथी यानी रथ हाँकने वाला। ग्रंथ में यही कृष्ण की भूमिका है — जो रथ चलाते हैं, निर्णय अर्जुन करता है।', 'hinglish' => 'Sarathi matlab rath chalane wala. Text mein yahi Krishna ka role hai — chalate woh hain, decide Arjun karta hai.'),
    'chat.placeholder' => array('en' => 'What is on your mind?', 'hi' => 'मन में क्या है?', 'hinglish' => 'Mann mein kya hai?'),
    'chat.send'        => array('en' => 'Ask', 'hi' => 'पूछें', 'hinglish' => 'Poocho'),
    'chat.thinking'    => array('en' => 'Reading the verses', 'hi' => 'श्लोक देख रहे हैं', 'hinglish' => 'Shlok dekh raha hai'),
    'chat.new'         => array('en' => 'Start again', 'hi' => 'नई शुरुआत', 'hinglish' => 'Nayi shuruaat'),
    'chat.history'     => array('en' => 'Earlier conversations', 'hi' => 'पिछली बातचीत', 'hinglish' => 'Pichhli baatein'),
    'chat.save'        => array('en' => 'Keep this answer', 'hi' => 'यह जवाब सहेजें', 'hinglish' => 'Yeh jawab save karo'),
    'chat.saved'       => array('en' => 'Kept', 'hi' => 'सहेज लिया', 'hinglish' => 'Save ho gaya'),
    'chat.you'         => array('en' => 'You', 'hi' => 'आप', 'hinglish' => 'Tum'),
    'chat.clear'       => array('en' => 'Clear this conversation', 'hi' => 'यह बातचीत हटाएँ', 'hinglish' => 'Yeh conversation hatao'),
    'chat.cleared'     => array('en' => 'Cleared from this device and from your account.', 'hi' => 'इस डिवाइस से और आपके खाते से हटा दिया गया।', 'hinglish' => 'Is device se aur tumhare account se hata diya.'),

    // The disclaimer sits under the input where it is unavoidable, not
    // buried in a terms page. A learner should know what they are
    // talking to before they type a hard question into it.
    'chat.disclaimer'  => array('en' => 'Sarathi is software. It can be wrong, and it is not a counsellor, a doctor or a priest.', 'hi' => 'सारथी एक सॉफ़्टवेयर है। यह गलत भी हो सकता है, और यह न सलाहकार है, न डॉक्टर, न पुरोहित।', 'hinglish' => 'Sarathi ek software hai. Galat bhi ho sakta hai, aur yeh na counsellor hai, na doctor, na pandit.'),
    'chat.grounded'    => array('en' => 'Based on', 'hi' => 'इस पर आधारित', 'hinglish' => 'Iske aadhar par'),
    'chat.ai_label'    => array('en' => 'Written by AI', 'hi' => 'AI द्वारा लिखा गया', 'hinglish' => 'AI ne likha hai'),

    'chat.starter.stuck'    => array('en' => 'I am stuck on a decision', 'hi' => 'मैं एक फ़ैसले पर अटका हूँ', 'hinglish' => 'Ek decision par atka hua hoon'),
    'chat.starter.anger'    => array('en' => 'I lost my temper today', 'hi' => 'आज मुझे गुस्सा आ गया', 'hinglish' => 'Aaj gussa aa gaya'),
    'chat.starter.result'   => array('en' => 'I worked hard and it did not work out', 'hi' => 'मेहनत की, फिर भी बात नहीं बनी', 'hinglish' => 'Mehnat ki, phir bhi baat nahi bani'),
    'chat.starter.explain'  => array('en' => 'Explain this verse to me simply', 'hi' => 'यह श्लोक आसान भाषा में समझाइए', 'hinglish' => 'Yeh shloka simple mein samjhao'),

    // Failure states. The learner never sees a dead spinner or a raw
    // error — there is always something honest to read.
    'chat.offline.title'  => array('en' => 'Sarathi is offline', 'hi' => 'सारथी अभी ऑफ़लाइन है', 'hinglish' => 'Sarathi abhi offline hai'),
    'chat.offline.body'   => array('en' => 'No connection to the AI right now. Here is what the text itself says about what you asked.', 'hi' => 'अभी AI से संपर्क नहीं है। आपने जो पूछा, ग्रंथ खुद उस पर यह कहता है।', 'hinglish' => 'Abhi AI se connection nahi hai. Tumne jo poocha, text khud uspe yeh kehta hai.'),
    'chat.static_note'    => array('en' => 'This answer came from the verses saved on your device, not from the AI.', 'hi' => 'यह जवाब आपके डिवाइस पर सेव श्लोकों से आया है, AI से नहीं।', 'hinglish' => 'Yeh jawab tumhare device par save shlokon se aaya hai, AI se nahi.'),
    'chat.error'          => array('en' => 'That did not go through. Nothing was lost — ask again.', 'hi' => 'यह नहीं जा सका। कुछ खोया नहीं — फिर पूछें।', 'hinglish' => 'Yeh nahi gaya. Kuch nahi gaya — phir se poocho.'),
    'chat.limit_guest'    => array('en' => 'That is the limit for reading as a guest today. An account raises it.', 'hi' => 'मेहमान के तौर पर आज की सीमा यही थी। खाते से यह बढ़ जाती है।', 'hinglish' => 'Guest ke taur par aaj ki limit yahi thi. Account banane se badh jaati hai.'),
    'chat.limit_user'     => array('en' => 'You have used today’s questions. The count resets at midnight.', 'hi' => 'आज के सवाल पूरे हो गए। गिनती आधी रात को फिर शुरू होगी।', 'hinglish' => 'Aaj ke sawaal khatam. Count aadhi raat ko reset ho jaayega.'),
    'chat.remaining'      => array('en' => ':n question left today|:n questions left today', 'hi' => 'आज :n सवाल बाकी|आज :n सवाल बाकी', 'hinglish' => 'Aaj :n sawaal baaki|Aaj :n sawaal baaki'),

    // -----------------------------------------------------------------
    // Forum
    // -----------------------------------------------------------------
    'forum.title'        => array('en' => 'Community', 'hi' => 'समुदाय', 'hinglish' => 'Community'),
    'forum.lead'         => array('en' => 'People reading the same book, thinking out loud. Read freely; posting needs an account.', 'hi' => 'वही किताब पढ़ रहे लोग, खुलकर सोचते हुए। पढ़ना सबके लिए; लिखने के लिए खाता चाहिए।', 'hinglish' => 'Wahi kitaab padh rahe log, khul ke soch rahe hain. Padhna free hai; likhne ke liye account chahiye.'),
    'forum.categories'   => array('en' => 'Areas', 'hi' => 'विभाग', 'hinglish' => 'Areas'),
    'forum.threads'      => array('en' => 'Discussions', 'hi' => 'चर्चाएँ', 'hinglish' => 'Discussions'),
    'forum.replies'      => array('en' => ':n reply|:n replies', 'hi' => ':n जवाब|:n जवाब', 'hinglish' => ':n reply|:n replies'),
    'forum.new_thread'   => array('en' => 'Start a discussion', 'hi' => 'चर्चा शुरू करें', 'hinglish' => 'Discussion shuru karo'),
    'forum.reply'        => array('en' => 'Reply', 'hi' => 'जवाब दें', 'hinglish' => 'Reply karo'),
    'forum.title_label'  => array('en' => 'What is this about?', 'hi' => 'यह किस बारे में है?', 'hinglish' => 'Yeh kis baare mein hai?'),
    'forum.body_label'   => array('en' => 'What do you want to say?', 'hi' => 'आप क्या कहना चाहते हैं?', 'hinglish' => 'Kya kehna chahte ho?'),
    'forum.about_verse'  => array('en' => 'About a verse (optional)', 'hi' => 'किसी श्लोक के बारे में (ज़रूरी नहीं)', 'hinglish' => 'Kisi shloka ke baare mein (optional)'),
    'forum.post'         => array('en' => 'Send it in', 'hi' => 'भेजें', 'hinglish' => 'Bhej do'),
    'forum.by'           => array('en' => 'by :name', 'hi' => ':name ने', 'hinglish' => ':name ne'),
    'forum.locked'       => array('en' => 'This area is closed to new posts.', 'hi' => 'इस विभाग में नई पोस्ट बंद हैं।', 'hinglish' => 'Is area mein nayi post band hain.'),
    'forum.empty'        => array('en' => 'Nothing here yet. Yours could be the first.', 'hi' => 'अभी यहाँ कुछ नहीं। पहली आपकी हो सकती है।', 'hinglish' => 'Abhi yahan kuch nahi. Pehli tumhari ho sakti hai.'),
    'forum.sign_in_note' => array('en' => 'You need an account to post. Reading needs nothing.', 'hi' => 'लिखने के लिए खाता चाहिए। पढ़ने के लिए कुछ नहीं।', 'hinglish' => 'Likhne ke liye account chahiye. Padhne ke liye kuch nahi.'),

    // -----------------------------------------------------------------
    // Pre-moderation
    // -----------------------------------------------------------------
    // Say the wait exists, do not promise how long it is, and make it
    // obvious the post was received — otherwise people submit it twice.
    'forum.pending.notice'  => array('en' => 'Sent. A person reads every post before it goes up, so it will not appear straight away.', 'hi' => 'भेज दिया गया। हर पोस्ट को छपने से पहले एक व्यक्ति पढ़ता है, इसलिए यह तुरंत नहीं दिखेगी।', 'hinglish' => 'Bhej diya. Har post ko lagne se pehle ek insaan padhta hai, isliye turant nahi dikhegi.'),
    'forum.pending.badge'   => array('en' => 'Waiting for review', 'hi' => 'समीक्षा का इंतज़ार', 'hinglish' => 'Review ka wait'),
    'forum.pending.only_you'=> array('en' => 'Only you can see this until it is approved.', 'hi' => 'मंज़ूरी मिलने तक इसे सिर्फ़ आप देख सकते हैं।', 'hinglish' => 'Approve hone tak ise sirf tum dekh sakte ho.'),
    'forum.approved'        => array('en' => 'Your post is up.', 'hi' => 'आपकी पोस्ट लग गई।', 'hinglish' => 'Tumhari post lag gayi.'),
    'forum.rejected'        => array('en' => 'This was not published.', 'hi' => 'यह प्रकाशित नहीं हुई।', 'hinglish' => 'Yeh publish nahi hui.'),
    'forum.rejected.reason' => array('en' => 'Reason given: :reason', 'hi' => 'दिया गया कारण: :reason', 'hinglish' => 'Reason: :reason'),
    'forum.rejected.note'   => array('en' => 'Only you can see this. Rewriting and sending it again is fine.', 'hi' => 'इसे सिर्फ़ आप देख सकते हैं। दोबारा लिखकर भेजना ठीक है।', 'hinglish' => 'Ise sirf tum dekh sakte ho. Dobara likh ke bhejna bilkul theek hai.'),

    // House rules, worded for the real person who trips them.
    'forum.rules.title'   => array('en' => 'How this place works', 'hi' => 'यह जगह कैसे चलती है', 'hinglish' => 'Yeh jagah kaise chalti hai'),
    'forum.rules.body'    => array('en' => 'Disagree with ideas as hard as you like. Not with people. No campaigning for any party or movement. One link per post.', 'hi' => 'विचारों से जितना चाहें असहमत हों। लोगों से नहीं। किसी दल या आंदोलन का प्रचार नहीं। एक पोस्ट में एक ही लिंक।', 'hinglish' => 'Ideas se jitna chaaho disagree karo. Logon se nahi. Kisi party ya movement ka prachar nahi. Ek post mein ek hi link.'),
    'forum.limit.new_account' => array('en' => 'New accounts can post after a day. It keeps the spam out and it is the only thing that does.', 'hi' => 'नए खाते एक दिन बाद पोस्ट कर सकते हैं। स्पैम रोकने का यही एक तरीका काम करता है।', 'hinglish' => 'Naye account ek din baad post kar sakte hain. Spam rokne ka bas yahi tarika chalta hai.'),
    'forum.limit.pending'     => array('en' => 'You have three posts waiting already. Once one is reviewed you can send another.', 'hi' => 'आपकी तीन पोस्ट पहले से इंतज़ार में हैं। एक की समीक्षा होते ही अगली भेज सकते हैं।', 'hinglish' => 'Tumhari teen post pehle se wait kar rahi hain. Ek review ho jaye to agli bhej sakte ho.'),
    'forum.limit.too_fast'    => array('en' => 'One post every five minutes. Give it a moment.', 'hi' => 'हर पाँच मिनट में एक पोस्ट। थोड़ा रुकें।', 'hinglish' => 'Har paanch minute mein ek post. Thoda ruk jao.'),
    'forum.limit.links'       => array('en' => 'One link per post, at most.', 'hi' => 'एक पोस्ट में ज़्यादा से ज़्यादा एक लिंक।', 'hinglish' => 'Ek post mein zyada se zyada ek link.'),
    'forum.limit.too_short'   => array('en' => 'Twenty words at least, so there is something to reply to.', 'hi' => 'कम से कम बीस शब्द, ताकि जवाब देने लायक कुछ हो।', 'hinglish' => 'Kam se kam bees shabd, taaki reply karne layak kuch ho.'),

    // -----------------------------------------------------------------
    // Reporting
    // -----------------------------------------------------------------
    'report.action'   => array('en' => 'Report this', 'hi' => 'इसकी शिकायत करें', 'hinglish' => 'Iski report karo'),
    'report.title'    => array('en' => 'Tell us what is wrong with it', 'hi' => 'बताइए इसमें क्या गलत है', 'hinglish' => 'Batao isme kya galat hai'),
    'report.reason'   => array('en' => 'What is the problem?', 'hi' => 'समस्या क्या है?', 'hinglish' => 'Problem kya hai?'),
    'report.submit'   => array('en' => 'Send the report', 'hi' => 'शिकायत भेजें', 'hinglish' => 'Report bhejo'),
    'report.thanks'   => array('en' => 'Thank you. A moderator will look at it.', 'hi' => 'धन्यवाद। कोई मॉडरेटर इसे देखेगा।', 'hinglish' => 'Thanks. Koi moderator ise dekhega.'),
    'report.reason.spam'    => array('en' => 'Spam or advertising', 'hi' => 'स्पैम या विज्ञापन', 'hinglish' => 'Spam ya advertising'),
    'report.reason.abuse'   => array('en' => 'Abusive or personal', 'hi' => 'अपमानजनक या व्यक्तिगत हमला', 'hinglish' => 'Abusive ya personal attack'),
    'report.reason.off'     => array('en' => 'Nothing to do with the topic', 'hi' => 'विषय से कोई संबंध नहीं', 'hinglish' => 'Topic se koi lena dena nahi'),
    'report.reason.wrong'   => array('en' => 'Factually wrong about the text', 'hi' => 'ग्रंथ के बारे में तथ्यात्मक रूप से गलत', 'hinglish' => 'Text ke baare mein factually galat'),
    'report.reason.other'   => array('en' => 'Something else', 'hi' => 'कुछ और', 'hinglish' => 'Kuch aur'),

    // -----------------------------------------------------------------
    // Notifications
    // -----------------------------------------------------------------
    'notify.title'     => array('en' => 'For you', 'hi' => 'आपके लिए', 'hinglish' => 'Tumhare liye'),
    'notify.none'      => array('en' => 'Nothing new.', 'hi' => 'कुछ नया नहीं।', 'hinglish' => 'Kuch naya nahi.'),
    'notify.mark_read' => array('en' => 'Mark everything read', 'hi' => 'सब पढ़ा हुआ चिह्नित करें', 'hinglish' => 'Sab read mark karo'),
    'notify.unread'    => array('en' => ':n unread', 'hi' => ':n अपठित', 'hinglish' => ':n unread'),
);
