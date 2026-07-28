<?php
/**
 * VedaVerse — app/config/strings/learning.php
 * ---------------------------------------------------------------------
 * The Chariot Path, lessons, quizzes, spaced repetition, streaks, XP,
 * badges and certificates.
 *
 * TONE RULE FOR THIS WHOLE FILE
 *   Encouraging, never competitive, and never sanctimonious. There are
 *   no public leaderboards in this product, and nothing here should read
 *   as though there were one. "Four days" is a fact. "Four days —
 *   you're on fire!" is a slot machine.
 *
 * THE HARDEST STRINGS HERE ARE THE ONES FOR FAILURE
 *   A wrong quiz answer, a broken streak, a review backlog after three
 *   weeks away. Those are the moments somebody closes the tab for good.
 *   Every one of them is written to make coming back easy and to make
 *   the gap a non-event. Read learning.streak.forgiven and
 *   learning.review.welcome_back before changing anything in this file.
 */

return array(

    // -----------------------------------------------------------------
    // The Chariot Path
    // -----------------------------------------------------------------
    'path.title'        => array('en' => 'Your path', 'hi' => 'आपका रास्ता', 'hinglish' => 'Tumhara path'),
    'path.lead'         => array('en' => 'One cluster of verses at a time. The chariot moves when you finish one.', 'hi' => 'एक बार में श्लोकों का एक समूह। एक पूरा करने पर रथ आगे बढ़ता है।', 'hinglish' => 'Ek baar mein shlokon ka ek group. Ek poora karo, rath aage badhta hai.'),
    'path.continue'     => array('en' => 'Carry on', 'hi' => 'आगे बढ़ें', 'hinglish' => 'Aage chalo'),
    'path.start'        => array('en' => 'Begin at Chapter 2', 'hi' => 'अध्याय 2 से शुरू करें', 'hinglish' => 'Chapter 2 se shuru karo'),
    'path.node.current' => array('en' => 'You are here', 'hi' => 'आप यहाँ हैं', 'hinglish' => 'Tum yahan ho'),
    'path.node.done'    => array('en' => 'Finished', 'hi' => 'पूरा हुआ', 'hinglish' => 'Ho gaya'),
    'path.node.ahead'   => array('en' => 'Still ahead', 'hi' => 'अभी आगे', 'hinglish' => 'Abhi aage'),
    'path.node.locked'  => array('en' => 'Opens after the one before it', 'hi' => 'पिछला पूरा होने पर खुलेगा', 'hinglish' => 'Pichhla poora hone par khulega'),
    'path.milestone'    => array('en' => 'Chapter :n', 'hi' => 'अध्याय :n', 'hinglish' => 'Chapter :n'),
    'path.remaining'    => array('en' => ':n verse left in this chapter|:n verses left in this chapter', 'hi' => 'इस अध्याय में :n श्लोक बाकी|इस अध्याय में :n श्लोक बाकी', 'hinglish' => 'Is chapter mein :n shloka baaki|Is chapter mein :n shlok baaki'),

    'path.track'        => array('en' => 'Your track', 'hi' => 'आपका ट्रैक', 'hinglish' => 'Tumhara track'),
    'path.track.change' => array('en' => 'Change track', 'hi' => 'ट्रैक बदलें', 'hinglish' => 'Track badlo'),
    'path.track.kept'   => array('en' => 'Track changed. Everything you had finished stays finished.', 'hi' => 'ट्रैक बदल गया। जो पूरा कर चुके थे वह पूरा ही रहेगा।', 'hinglish' => 'Track badal gaya. Jo poora kar chuke the woh poora hi rahega.'),

    // -----------------------------------------------------------------
    // Reading modes
    // -----------------------------------------------------------------
    'mode.label'    => array('en' => 'How you want to read', 'hi' => 'कैसे पढ़ना है', 'hinglish' => 'Kaise padhna hai'),
    'mode.learn'    => array('en' => 'Learn', 'hi' => 'सीखें', 'hinglish' => 'Learn'),
    'mode.study'    => array('en' => 'Study', 'hi' => 'गहराई से', 'hinglish' => 'Study'),
    'mode.research' => array('en' => 'Research', 'hi' => 'शोध', 'hinglish' => 'Research'),
    'mode.quick'    => array('en' => 'One minute', 'hi' => 'एक मिनट', 'hinglish' => 'Ek minute'),
    'mode.focus'    => array('en' => 'Focus', 'hi' => 'सिर्फ़ पाठ', 'hinglish' => 'Focus'),
    'mode.print'    => array('en' => 'Print', 'hi' => 'प्रिंट', 'hinglish' => 'Print'),
    'mode.learn.hint'    => array('en' => 'The verse, what it means, and where you have seen it.', 'hi' => 'श्लोक, उसका अर्थ, और आपने उसे कहाँ देखा है।', 'hinglish' => 'Shloka, uska matlab, aur tumne use kahan dekha hai.'),
    'mode.study.hint'    => array('en' => 'Adds word meanings, grammar and the full explanation.', 'hi' => 'इसमें शब्दार्थ, व्याकरण और पूरी व्याख्या जुड़ जाती है।', 'hinglish' => 'Isme shabdon ke matlab, grammar aur poori explanation aa jaati hai.'),
    'mode.research.hint' => array('en' => 'Adds the commentary comparison and cross-references.', 'hi' => 'इसमें टीकाओं की तुलना और संदर्भ जुड़ जाते हैं।', 'hinglish' => 'Isme commentary comparison aur cross-references aa jaate hain.'),

    // -----------------------------------------------------------------
    // A lesson
    // -----------------------------------------------------------------
    'lesson.step'        => array('en' => 'Step :n of :total', 'hi' => ':total में से चरण :n', 'hinglish' => 'Step :n of :total'),
    'lesson.curiosity'   => array('en' => 'Before you read', 'hi' => 'पढ़ने से पहले', 'hinglish' => 'Padhne se pehle'),
    'lesson.context'     => array('en' => 'Where we are', 'hi' => 'हम कहाँ हैं', 'hinglish' => 'Hum kahan hain'),
    'lesson.complete'    => array('en' => 'Finish this lesson', 'hi' => 'यह पाठ पूरा करें', 'hinglish' => 'Yeh lesson poora karo'),
    'lesson.completed'   => array('en' => 'Done. That is :n XP.', 'hi' => 'हो गया। :n XP मिले।', 'hinglish' => 'Ho gaya. :n XP mile.'),
    'lesson.next_up'     => array('en' => 'Next up', 'hi' => 'अब आगे', 'hinglish' => 'Ab aage'),
    'lesson.take_break'  => array('en' => 'Stop here for today', 'hi' => 'आज यहीं रुकें', 'hinglish' => 'Aaj yahin ruk jao'),
    'lesson.break_note'  => array('en' => 'Two verses understood properly beat twenty skimmed.', 'hi' => 'ठीक से समझे दो श्लोक, बीस सरसरी से बेहतर हैं।', 'hinglish' => 'Do shlok theek se samjhe hue, bees jaldi-jaldi padhne se behtar hain.'),

    // -----------------------------------------------------------------
    // Quizzes
    // -----------------------------------------------------------------
    'quiz.title'        => array('en' => 'Check yourself', 'hi' => 'खुद को परखें', 'hinglish' => 'Khud ko check karo'),
    'quiz.lead'         => array('en' => 'Not a test. This is how the ideas stick.', 'hi' => 'यह परीक्षा नहीं है। इसी से बात दिमाग़ में बैठती है।', 'hinglish' => 'Yeh exam nahi hai. Isi se baat dimaag mein baithti hai.'),
    'quiz.start'        => array('en' => 'Start', 'hi' => 'शुरू करें', 'hinglish' => 'Shuru karo'),
    'quiz.question_n'   => array('en' => 'Question :n of :total', 'hi' => ':total में से प्रश्न :n', 'hinglish' => 'Question :n of :total'),
    'quiz.submit'       => array('en' => 'Answer', 'hi' => 'जवाब दें', 'hinglish' => 'Answer do'),
    'quiz.next'         => array('en' => 'Next question', 'hi' => 'अगला प्रश्न', 'hinglish' => 'Agla question'),
    'quiz.finish'       => array('en' => 'See how you did', 'hi' => 'नतीजा देखें', 'hinglish' => 'Result dekho'),
    'quiz.correct'      => array('en' => 'That is right', 'hi' => 'सही है', 'hinglish' => 'Sahi hai'),
    // Never just "wrong". The explanation is the point of the question.
    'quiz.incorrect'    => array('en' => 'Not this one — here is why', 'hi' => 'यह नहीं — कारण यह है', 'hinglish' => 'Yeh nahi — reason yeh hai'),
    'quiz.explanation'  => array('en' => 'Why', 'hi' => 'क्यों', 'hinglish' => 'Kyun'),
    'quiz.your_answer'  => array('en' => 'You chose', 'hi' => 'आपने चुना', 'hinglish' => 'Tumne chuna'),
    'quiz.right_answer' => array('en' => 'The answer', 'hi' => 'सही जवाब', 'hinglish' => 'Sahi jawab'),
    'quiz.score'        => array('en' => ':score out of :max', 'hi' => ':max में से :score', 'hinglish' => ':score out of :max'),
    'quiz.passed'       => array('en' => 'That is a pass. The verse is added to your review queue.', 'hi' => 'आप पास हैं। यह श्लोक आपकी दोहराने की सूची में जुड़ गया।', 'hinglish' => 'Pass ho gaye. Yeh shloka tumhari review list mein add ho gaya.'),
    'quiz.failed'       => array('en' => 'Worth another read. Nothing is lost — try again whenever you like.', 'hi' => 'एक बार फिर पढ़ने लायक है। कुछ खोया नहीं — जब चाहें दोबारा कोशिश करें।', 'hinglish' => 'Ek baar aur padhne layak hai. Kuch nahi gaya — jab chaaho phir se try karo.'),
    'quiz.retry'        => array('en' => 'Try these again', 'hi' => 'इन्हें दोबारा करें', 'hinglish' => 'Inhe phir se karo'),
    'quiz.review_wrong' => array('en' => 'Go over what you missed', 'hi' => 'जो छूटा उसे देखें', 'hinglish' => 'Jo chhoot gaya woh dekho'),
    'quiz.time_left'    => array('en' => ':n seconds left', 'hi' => ':n सेकंड बाकी', 'hinglish' => ':n second baaki'),
    'quiz.no_time'      => array('en' => 'Take as long as you want. There is no timer.', 'hi' => 'जितना समय चाहिए लें। कोई घड़ी नहीं चल रही।', 'hinglish' => 'Jitna time chahiye lo. Koi timer nahi hai.'),

    'quiz.kind.mcq'        => array('en' => 'Pick one', 'hi' => 'एक चुनें', 'hinglish' => 'Ek chuno'),
    'quiz.kind.true_false' => array('en' => 'True or false', 'hi' => 'सही या गलत', 'hinglish' => 'Sahi ya galat'),
    'quiz.kind.fill_blank' => array('en' => 'Fill the gap', 'hi' => 'खाली जगह भरें', 'hinglish' => 'Khaali jagah bharo'),
    'quiz.kind.scenario'   => array('en' => 'What applies here', 'hi' => 'यहाँ क्या लागू होता है', 'hinglish' => 'Yahan kya apply hota hai'),
    'quiz.kind.flashcard'  => array('en' => 'Flashcard', 'hi' => 'फ़्लैशकार्ड', 'hinglish' => 'Flashcard'),
    'quiz.true'            => array('en' => 'True', 'hi' => 'सही', 'hinglish' => 'Sahi'),
    'quiz.false'           => array('en' => 'False', 'hi' => 'गलत', 'hinglish' => 'Galat'),

    // -----------------------------------------------------------------
    // Spaced repetition
    // -----------------------------------------------------------------
    'review.title'      => array('en' => 'Review', 'hi' => 'दोहराएँ', 'hinglish' => 'Review'),
    'review.lead'       => array('en' => 'A few verses come back at the point you were about to forget them. That is the whole trick.', 'hi' => 'कुछ श्लोक ठीक उसी समय लौटते हैं जब आप उन्हें भूलने वाले होते हैं। बस यही तरीका है।', 'hinglish' => 'Kuch shlok theek us waqt wapas aate hain jab tum unhe bhoolne wale hote ho. Bas yahi trick hai.'),
    'review.due'        => array('en' => ':n verse ready|:n verses ready', 'hi' => ':n श्लोक तैयार|:n श्लोक तैयार', 'hinglish' => ':n shloka ready|:n shlok ready'),
    'review.none'       => array('en' => 'Nothing due today. Come back tomorrow, or read something new.', 'hi' => 'आज कुछ बाकी नहीं। कल आएँ, या कुछ नया पढ़ें।', 'hinglish' => 'Aaj kuch due nahi hai. Kal aana, ya kuch naya padho.'),
    'review.start'      => array('en' => 'Start reviewing', 'hi' => 'दोहराना शुरू करें', 'hinglish' => 'Review shuru karo'),
    'review.show'       => array('en' => 'Show me', 'hi' => 'दिखाएँ', 'hinglish' => 'Dikhao'),
    'review.how_was_it' => array('en' => 'How did that feel?', 'hi' => 'कैसा लगा?', 'hinglish' => 'Kaisa laga?'),
    'review.again'      => array('en' => 'Gone', 'hi' => 'याद नहीं आया', 'hinglish' => 'Yaad nahi aaya'),
    'review.hard'       => array('en' => 'Slowly', 'hi' => 'मुश्किल से', 'hinglish' => 'Mushkil se'),
    'review.good'       => array('en' => 'Fine', 'hi' => 'ठीक', 'hinglish' => 'Theek'),
    'review.easy'       => array('en' => 'Instantly', 'hi' => 'तुरंत', 'hinglish' => 'Turant'),
    'review.next_in'    => array('en' => 'Back in :n day|Back in :n days', 'hi' => ':n दिन बाद फिर|:n दिन बाद फिर', 'hinglish' => ':n din baad phir|:n din baad phir'),
    'review.done'       => array('en' => 'That is today done.', 'hi' => 'आज का हो गया।', 'hinglish' => 'Aaj ka ho gaya.'),
    'review.capped'     => array('en' => 'Twenty a day is the cap, on purpose. The rest will keep.', 'hi' => 'दिन में बीस की सीमा जानबूझकर है। बाकी रुक सकते हैं।', 'hinglish' => 'Din mein bees ki limit jaan-boojh ke hai. Baaki ruk sakte hain.'),
    // Shown when somebody returns after weeks away. The backlog is
    // silently forgiven; this string is what they see instead of 400
    // overdue cards, which is the moment most people quit for good.
    'review.welcome_back' => array('en' => 'Good to see you. The pile that built up while you were away has been cleared — start from today.', 'hi' => 'आपको देखकर अच्छा लगा। आपकी गैरहाज़िरी में जो ढेर लगा था वह हटा दिया गया है — आज से शुरू करें।', 'hinglish' => 'Achha laga tumhe dekh ke. Jo dher lag gaya tha tumhare na hone par, woh hata diya hai — aaj se shuru karo.'),

    // -----------------------------------------------------------------
    // Progress, XP, streaks
    // -----------------------------------------------------------------
    'profile.xp'          => array('en' => 'Experience points', 'hi' => 'अनुभव अंक', 'hinglish' => 'XP'),
    'profile.streak'      => array('en' => 'Day streak', 'hi' => 'लगातार दिन', 'hinglish' => 'Streak'),
    'profile.level'       => array('en' => 'Level :n', 'hi' => 'स्तर :n', 'hinglish' => 'Level :n'),
    'profile.title'       => array('en' => 'You', 'hi' => 'आप', 'hinglish' => 'Tum'),
    'profile.joined'      => array('en' => 'Reading since :date', 'hi' => ':date से पढ़ रहे हैं', 'hinglish' => ':date se padh rahe ho'),
    'profile.verses_read' => array('en' => 'Verses read', 'hi' => 'पढ़े गए श्लोक', 'hinglish' => 'Padhe hue shlok'),
    'profile.chapters_done' => array('en' => 'Chapters finished', 'hi' => 'पूरे किए अध्याय', 'hinglish' => 'Poore kiye chapters'),
    'profile.mastered'    => array('en' => 'Known cold', 'hi' => 'पक्के याद', 'hinglish' => 'Pakke yaad'),
    'profile.time_spent'  => array('en' => 'Time spent reading', 'hi' => 'पढ़ने में लगा समय', 'hinglish' => 'Padhne mein laga time'),
    'profile.next_level'  => array('en' => ':n XP to the next level', 'hi' => 'अगले स्तर तक :n XP', 'hinglish' => 'Agle level tak :n XP'),

    'streak.days'      => array('en' => ':n day|:n days', 'hi' => ':n दिन|:n दिन', 'hinglish' => ':n din|:n din'),
    'streak.longest'   => array('en' => 'Your longest was :n days', 'hi' => 'आपका सबसे लंबा :n दिन था', 'hinglish' => 'Tumhara sabse lamba :n din tha'),
    'streak.today_done'=> array('en' => 'Today is counted.', 'hi' => 'आज का दिन गिन लिया गया।', 'hinglish' => 'Aaj ka din count ho gaya.'),
    'streak.today_open'=> array('en' => 'One lesson or one review keeps today.', 'hi' => 'एक पाठ या एक दोहराव आज को बचा लेगा।', 'hinglish' => 'Ek lesson ya ek review aaj ko bacha lega.'),
    // The streak freeze exists so one missed day cannot destroy months
    // of momentum. Say it warmly and move on — no guilt, no counter of
    // how close they came to losing it.
    'streak.forgiven'  => array('en' => 'You missed yesterday, so this week’s free pass was used. The streak stands.', 'hi' => 'कल छूट गया था, तो इस हफ़्ते की छूट लग गई। सिलसिला बना हुआ है।', 'hinglish' => 'Kal chhoot gaya tha, to is hafte ki free pass lag gayi. Streak bacha hua hai.'),
    'streak.broken'    => array('en' => 'The streak reset. It was :n days, and the reading still counts.', 'hi' => 'सिलसिला टूट गया। वह :n दिन का था, और पढ़ा हुआ अब भी गिनता है।', 'hinglish' => 'Streak toot gaya. Woh :n din ka tha, aur jo padha woh abhi bhi count hota hai.'),

    // -----------------------------------------------------------------
    // Badges
    // -----------------------------------------------------------------
    'badge.title'      => array('en' => 'What you have picked up', 'hi' => 'आपने क्या-क्या पाया', 'hinglish' => 'Tumne kya kya paaya'),
    'badge.earned'     => array('en' => 'Earned :date', 'hi' => ':date को मिला', 'hinglish' => ':date ko mila'),
    'badge.locked'     => array('en' => 'Not yet', 'hi' => 'अभी नहीं', 'hinglish' => 'Abhi nahi'),
    'badge.new'        => array('en' => 'You earned :name', 'hi' => 'आपको :name मिला', 'hinglish' => 'Tumhe :name mila'),
    'badge.progress'   => array('en' => ':done of :total', 'hi' => ':total में से :done', 'hinglish' => ':done of :total'),
    'badge.none'       => array('en' => 'None yet. They arrive on their own — there is nothing to go looking for.', 'hi' => 'अभी कोई नहीं। ये अपने आप आते हैं — इन्हें ढूँढ़ने की ज़रूरत नहीं।', 'hinglish' => 'Abhi koi nahi. Yeh apne aap aate hain — dhoondhne ki zaroorat nahi.'),

    // -----------------------------------------------------------------
    // Certificates
    // -----------------------------------------------------------------
    'certificate.title'        => array('en' => 'Certificate', 'hi' => 'प्रमाणपत्र', 'hinglish' => 'Certificate'),
    'certificate.earned'       => array('en' => 'You finished all eighteen chapters.', 'hi' => 'आपने सभी अठारह अध्याय पूरे किए।', 'hinglish' => 'Tumne poore atharah chapter khatam kiye.'),
    'certificate.name_on_it'   => array('en' => 'Name to print on it', 'hi' => 'इस पर छपने वाला नाम', 'hinglish' => 'Ispe chhapne wala naam'),
    'certificate.name_hint'    => array('en' => 'Spell it the way you want it to appear. You can change it and generate a new one.', 'hi' => 'जैसा दिखाना है वैसे ही लिखें। बाद में बदलकर नया बना सकते हैं।', 'hinglish' => 'Jaise dikhana hai waise likho. Baad mein badal ke naya bana sakte ho.'),
    'certificate.generate'     => array('en' => 'Make my certificate', 'hi' => 'मेरा प्रमाणपत्र बनाएँ', 'hinglish' => 'Mera certificate banao'),
    'certificate.download'     => array('en' => 'Download the PDF', 'hi' => 'PDF डाउनलोड करें', 'hinglish' => 'PDF download karo'),
    'certificate.id'           => array('en' => 'Certificate ID', 'hi' => 'प्रमाणपत्र आईडी', 'hinglish' => 'Certificate ID'),
    'certificate.verify'       => array('en' => 'Check a certificate', 'hi' => 'प्रमाणपत्र जाँचें', 'hinglish' => 'Certificate check karo'),
    'certificate.verify.lead'  => array('en' => 'Enter the ID printed on it to see whether it is real.', 'hi' => 'उस पर छपी आईडी डालें और देखें कि वह असली है या नहीं।', 'hinglish' => 'Uspe chhapi ID daalo aur dekho asli hai ya nahi.'),
    'certificate.valid'        => array('en' => 'This certificate is genuine. Issued :date, for :scope.', 'hi' => 'यह प्रमाणपत्र असली है। :date को :scope के लिए जारी हुआ।', 'hinglish' => 'Yeh certificate asli hai. :date ko :scope ke liye issue hua.'),
    'certificate.invalid'      => array('en' => 'No certificate with that ID was issued.', 'hi' => 'इस आईडी से कोई प्रमाणपत्र जारी नहीं हुआ।', 'hinglish' => 'Is ID se koi certificate issue nahi hua.'),
    'certificate.revoked'      => array('en' => 'That certificate was withdrawn.', 'hi' => 'वह प्रमाणपत्र वापस ले लिया गया था।', 'hinglish' => 'Woh certificate wapas le liya gaya tha.'),
    'certificate.private'      => array('en' => 'The holder has chosen not to show their name.', 'hi' => 'धारक ने अपना नाम न दिखाने का विकल्प चुना है।', 'hinglish' => 'Jinka certificate hai unhone naam na dikhane ka option chuna hai.'),
    'certificate.scope.all'    => array('en' => 'the complete Bhagavad Gita', 'hi' => 'संपूर्ण भगवद्गीता', 'hinglish' => 'poori Bhagavad Gita'),
    'certificate.scope.chapter'=> array('en' => 'chapter :n', 'hi' => 'अध्याय :n', 'hinglish' => 'chapter :n'),
);
