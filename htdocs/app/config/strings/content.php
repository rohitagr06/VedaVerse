<?php
/**
 * VedaVerse — app/config/strings/content.php
 * ---------------------------------------------------------------------
 * The labels on the scripture itself: chapters, verses, the sections of
 * a verse page, topics, life problems, modern examples, search.
 *
 * THE FOUR THINGS THAT MUST STAY VISIBLY DISTINCT
 *   Scripture, traditional commentary, modern interpretation, and
 *   AI-generated analogy. The section headings in this file are the
 *   main way a reader can tell them apart at a glance — which is why
 *   they are worded as claims about origin ("What the tradition says",
 *   "Written by AI") rather than as neutral furniture ("Commentary",
 *   "Examples"). Do not flatten them into shorter labels.
 *
 * NAMING
 *   "Shloka" is used in Hindi and Hinglish, "verse" in English. Both are
 *   right for their reader; neither is a translation of the other.
 */

return array(

    // -----------------------------------------------------------------
    // Units of scripture
    // -----------------------------------------------------------------
    'content.chapter'       => array('en' => 'Chapter', 'hi' => 'अध्याय', 'hinglish' => 'Chapter'),
    'content.chapters'      => array('en' => 'Chapters', 'hi' => 'अध्याय', 'hinglish' => 'Chapters'),
    'content.verse'         => array('en' => 'Verse', 'hi' => 'श्लोक', 'hinglish' => 'Shloka'),
    'content.verses'        => array('en' => 'Verses', 'hi' => 'श्लोक', 'hinglish' => 'Shlok'),
    'content.verse_count'   => array('en' => ':n verse|:n verses', 'hi' => ':n श्लोक|:n श्लोक', 'hinglish' => ':n shloka|:n shlok'),
    'content.chapter_n'     => array('en' => 'Chapter :n', 'hi' => 'अध्याय :n', 'hinglish' => 'Chapter :n'),
    'content.verse_ref'     => array('en' => 'Chapter :chapter, verse :verse', 'hi' => 'अध्याय :chapter, श्लोक :verse', 'hinglish' => 'Chapter :chapter, shloka :verse'),
    'content.gita'          => array('en' => 'Bhagavad Gita', 'hi' => 'भगवद्गीता', 'hinglish' => 'Bhagavad Gita'),

    // -----------------------------------------------------------------
    // The verse page, section by section
    // -----------------------------------------------------------------
    'content.sanskrit'          => array('en' => 'The Sanskrit', 'hi' => 'संस्कृत', 'hinglish' => 'Sanskrit'),
    'content.transliteration'   => array('en' => 'How it sounds', 'hi' => 'उच्चारण', 'hinglish' => 'Kaise bolte hain'),
    'content.transliteration_simple' => array('en' => 'Simple spelling', 'hi' => 'आसान वर्तनी', 'hinglish' => 'Aasaan spelling'),
    'content.word_meanings'     => array('en' => 'Word by word', 'hi' => 'शब्द-दर-शब्द', 'hinglish' => 'Shabd by shabd'),
    'content.word'              => array('en' => 'Word', 'hi' => 'शब्द', 'hinglish' => 'Shabd'),
    'content.meaning'           => array('en' => 'Meaning', 'hi' => 'अर्थ', 'hinglish' => 'Matlab'),
    'content.grammar'           => array('en' => 'Grammar', 'hi' => 'व्याकरण', 'hinglish' => 'Grammar'),
    'content.root'              => array('en' => 'Root', 'hi' => 'मूल शब्द', 'hinglish' => 'Root'),
    'content.translation'       => array('en' => 'What it says', 'hi' => 'इसका अर्थ', 'hinglish' => 'Iska matlab'),
    'content.translation_literal' => array('en' => 'Word-for-word translation', 'hi' => 'शब्दशः अनुवाद', 'hinglish' => 'Literal translation'),
    'content.explanation'       => array('en' => 'What it means', 'hi' => 'इसका मतलब क्या है', 'hinglish' => 'Iska matlab kya hai'),
    'content.historical'        => array('en' => 'What was happening', 'hi' => 'तब क्या हो रहा था', 'hinglish' => 'Tab kya ho raha tha'),
    'content.philosophical'     => array('en' => 'The idea behind it', 'hi' => 'इसके पीछे का विचार', 'hinglish' => 'Iske peeche ka idea'),
    'content.practical'         => array('en' => 'What to do with it', 'hi' => 'इसे कैसे बरतें', 'hinglish' => 'Isko use kaise karein'),
    'content.modern'            => array('en' => 'Read today', 'hi' => 'आज के संदर्भ में', 'hinglish' => 'Aaj ke hisaab se'),
    'content.reflection'        => array('en' => 'Sit with this', 'hi' => 'इस पर सोचें', 'hinglish' => 'Is par socho'),
    'content.practice'          => array('en' => 'Try this today', 'hi' => 'आज यह करके देखें', 'hinglish' => 'Aaj yeh karke dekho'),
    'content.practice_time'     => array('en' => 'Takes about :n minutes', 'hi' => 'लगभग :n मिनट', 'hinglish' => 'Lagbhag :n minute'),
    'content.remember'          => array('en' => 'Remember this', 'hi' => 'यह याद रखें', 'hinglish' => 'Yeh yaad rakho'),
    'content.memory_hook'       => array('en' => 'The one line', 'hi' => 'एक पंक्ति में', 'hinglish' => 'Ek line mein'),
    'content.analogy'           => array('en' => 'Think of it like', 'hi' => 'ऐसे समझें', 'hinglish' => 'Aise samjho'),
    'content.cross_references'  => array('en' => 'Related passages', 'hi' => 'संबंधित अंश', 'hinglish' => 'Related passages'),
    'content.also_see'          => array('en' => 'Also worth reading', 'hi' => 'यह भी पढ़ें', 'hinglish' => 'Yeh bhi padho'),

    // -----------------------------------------------------------------
    // Explanation levels
    // -----------------------------------------------------------------
    // The learner chooses the depth. Beginner is not a lesser version —
    // it is the same idea with nothing assumed.
    'content.level'              => array('en' => 'How deep to go', 'hi' => 'कितनी गहराई में', 'hinglish' => 'Kitna deep jaana hai'),
    'content.level.beginner'     => array('en' => 'Start simple', 'hi' => 'आसान से शुरू', 'hinglish' => 'Simple se shuru'),
    'content.level.intermediate' => array('en' => 'A bit deeper', 'hi' => 'थोड़ा गहरा', 'hinglish' => 'Thoda deep'),
    'content.level.advanced'     => array('en' => 'The full argument', 'hi' => 'पूरी विवेचना', 'hinglish' => 'Poori baat'),

    // -----------------------------------------------------------------
    // Commentary — presented neutrally, never ranked
    // -----------------------------------------------------------------
    'content.commentary'          => array('en' => 'What the tradition says', 'hi' => 'परंपरा क्या कहती है', 'hinglish' => 'Tradition kya kehti hai'),
    'content.commentary.lead'     => array('en' => 'Serious readers have disagreed about this verse for centuries. Here is where they agree and where they genuinely differ.', 'hi' => 'सदियों से गंभीर पाठक इस श्लोक पर असहमत रहे हैं। कहाँ सहमति है और कहाँ सच में मतभेद — दोनों यहाँ हैं।', 'hinglish' => 'Sadiyon se serious readers is shloka par disagree karte aaye hain. Kahan agree karte hain aur kahan sach mein alag hain — dono yahan hai.'),
    'content.commentary.agreement'=> array('en' => 'Where they agree', 'hi' => 'जहाँ सहमति है', 'hinglish' => 'Jahan sab agree karte hain'),
    'content.commentary.difference' => array('en' => 'Where they differ', 'hi' => 'जहाँ मतभेद है', 'hinglish' => 'Jahan alag hain'),
    'content.commentary.neutral'  => array('en' => 'None of these is presented as the correct one. That judgement is yours.', 'hi' => 'इनमें से किसी को सही नहीं बताया गया है। वह निर्णय आपका है।', 'hinglish' => 'Inme se kisi ko sahi nahi bataya gaya. Woh decide tumhe karna hai.'),

    // -----------------------------------------------------------------
    // Modern examples
    // -----------------------------------------------------------------
    'content.examples'          => array('en' => 'Where you have seen this', 'hi' => 'यह आपने कहाँ देखा है', 'hinglish' => 'Yeh tumne kahan dekha hai'),
    'content.examples.lead'     => array('en' => 'The same situation, in places you already know.', 'hi' => 'वही स्थिति, उन जगहों में जिन्हें आप पहले से जानते हैं।', 'hinglish' => 'Wahi situation, un jagahon mein jo tum pehle se jaante ho.'),
    'content.example.scenario'  => array('en' => 'What happened', 'hi' => 'क्या हुआ', 'hinglish' => 'Kya hua'),
    'content.example.connection'=> array('en' => 'How the verse fits', 'hi' => 'श्लोक कैसे लागू होता है', 'hinglish' => 'Shloka kaise fit hota hai'),
    'content.example.lesson'    => array('en' => 'The takeaway', 'hi' => 'सार', 'hinglish' => 'Takeaway'),
    'content.example.source'    => array('en' => 'Reference', 'hi' => 'संदर्भ', 'hinglish' => 'Reference'),
    'content.example.spoiler'   => array('en' => 'This gives away part of the plot.', 'hi' => 'इसमें कहानी का एक हिस्सा खुल जाता है।', 'hinglish' => 'Isme kahani ka ek hissa khul jaata hai.'),
    'content.example.show'      => array('en' => 'Show it anyway', 'hi' => 'फिर भी दिखाएँ', 'hinglish' => 'Phir bhi dikhao'),
    'content.example.ai_note'   => array('en' => 'Written by AI, checked by a person before it was published.', 'hi' => 'AI ने लिखा, प्रकाशित होने से पहले एक व्यक्ति ने जाँचा।', 'hinglish' => 'AI ne likha, publish hone se pehle ek insaan ne check kiya.'),
    'content.example.filter'    => array('en' => 'Show examples from', 'hi' => 'इनमें से उदाहरण दिखाएँ', 'hinglish' => 'Inme se examples dikhao'),
    'content.example.all'       => array('en' => 'Everything', 'hi' => 'सब कुछ', 'hinglish' => 'Sab kuch'),

    // -----------------------------------------------------------------
    // Example categories
    // -----------------------------------------------------------------
    // These are the twenty-one categories in the schema. The Hindi is
    // deliberately not a transliteration of the English — "corporate"
    // reads as "office" to a Hindi speaker, which is the point.
    'category.bollywood'     => array('en' => 'Films', 'hi' => 'फ़िल्में', 'hinglish' => 'Filmein'),
    'category.cricket'       => array('en' => 'Cricket', 'hi' => 'क्रिकेट', 'hinglish' => 'Cricket'),
    'category.sports'        => array('en' => 'Sport', 'hi' => 'खेल', 'hinglish' => 'Sports'),
    'category.politics'      => array('en' => 'Public life', 'hi' => 'सार्वजनिक जीवन', 'hinglish' => 'Public life'),
    'category.corporate'     => array('en' => 'Office life', 'hi' => 'दफ़्तर', 'hinglish' => 'Office'),
    'category.startup'       => array('en' => 'Startups', 'hi' => 'स्टार्टअप', 'hinglish' => 'Startup'),
    'category.leadership'    => array('en' => 'Leading people', 'hi' => 'नेतृत्व', 'hinglish' => 'Leadership'),
    'category.relationships' => array('en' => 'Relationships', 'hi' => 'रिश्ते', 'hinglish' => 'Rishte'),
    'category.marriage'      => array('en' => 'Marriage', 'hi' => 'शादी', 'hinglish' => 'Shaadi'),
    'category.parenting'     => array('en' => 'Being a parent', 'hi' => 'माता-पिता होना', 'hinglish' => 'Parenting'),
    'category.school'        => array('en' => 'School', 'hi' => 'स्कूल', 'hinglish' => 'School'),
    'category.college'       => array('en' => 'College', 'hi' => 'कॉलेज', 'hinglish' => 'College'),
    'category.social_media'  => array('en' => 'Social media', 'hi' => 'सोशल मीडिया', 'hinglish' => 'Social media'),
    'category.technology'    => array('en' => 'Technology', 'hi' => 'तकनीक', 'hinglish' => 'Tech'),
    'category.ai'            => array('en' => 'AI', 'hi' => 'एआई', 'hinglish' => 'AI'),
    'category.healthcare'    => array('en' => 'Illness and care', 'hi' => 'बीमारी और देखभाल', 'hinglish' => 'Bimari aur care'),
    'category.military'      => array('en' => 'Service and duty', 'hi' => 'सेवा और कर्तव्य', 'hinglish' => 'Service aur duty'),
    'category.finance'       => array('en' => 'Money', 'hi' => 'पैसा', 'hinglish' => 'Paisa'),
    'category.friendship'    => array('en' => 'Friendship', 'hi' => 'दोस्ती', 'hinglish' => 'Dosti'),
    'category.ethics'        => array('en' => 'Right and wrong', 'hi' => 'सही और गलत', 'hinglish' => 'Sahi aur galat'),
    'category.everyday_life' => array('en' => 'Everyday life', 'hi' => 'रोज़ की ज़िंदगी', 'hinglish' => 'Roz ki zindagi'),

    // -----------------------------------------------------------------
    // Chapters
    // -----------------------------------------------------------------
    'chapter.index.title'  => array('en' => 'All eighteen chapters', 'hi' => 'सभी अठारह अध्याय', 'hinglish' => 'Poore atharah chapter'),
    'chapter.index.lead'   => array('en' => 'Chapter 2 is where the teaching starts. Chapter 1 sets the scene.', 'hi' => 'शिक्षा अध्याय 2 से शुरू होती है। अध्याय 1 दृश्य तैयार करता है।', 'hinglish' => 'Teaching chapter 2 se shuru hoti hai. Chapter 1 sirf scene set karta hai.'),
    'chapter.sanskrit_name'=> array('en' => 'Sanskrit name', 'hi' => 'संस्कृत नाम', 'hinglish' => 'Sanskrit naam'),
    'chapter.theme'        => array('en' => 'What it is about', 'hi' => 'यह किस बारे में है', 'hinglish' => 'Yeh kis baare mein hai'),
    'chapter.time'         => array('en' => 'About :n minutes to read', 'hi' => 'पढ़ने में लगभग :n मिनट', 'hinglish' => 'Padhne mein lagbhag :n minute'),
    'chapter.start'        => array('en' => 'Start this chapter', 'hi' => 'यह अध्याय शुरू करें', 'hinglish' => 'Yeh chapter shuru karo'),
    'chapter.resume'       => array('en' => 'Carry on from verse :n', 'hi' => 'श्लोक :n से जारी रखें', 'hinglish' => 'Shloka :n se continue karo'),
    'chapter.complete'     => array('en' => 'Chapter finished', 'hi' => 'अध्याय पूरा', 'hinglish' => 'Chapter poora'),
    'chapter.not_in_track' => array('en' => 'Not in your track — you can still read it.', 'hi' => 'आपके ट्रैक में नहीं है — फिर भी पढ़ सकते हैं।', 'hinglish' => 'Tumhare track mein nahi hai — phir bhi padh sakte ho.'),

    // -----------------------------------------------------------------
    // Verse navigation
    // -----------------------------------------------------------------
    'verse.next'       => array('en' => 'Next verse', 'hi' => 'अगला श्लोक', 'hinglish' => 'Agla shloka'),
    'verse.previous'   => array('en' => 'Previous verse', 'hi' => 'पिछला श्लोक', 'hinglish' => 'Pichhla shloka'),
    'verse.bookmark'   => array('en' => 'Save this verse', 'hi' => 'यह श्लोक सहेजें', 'hinglish' => 'Yeh shloka save karo'),
    'verse.bookmarked' => array('en' => 'Saved', 'hi' => 'सहेजा गया', 'hinglish' => 'Save ho gaya'),
    'verse.unbookmark' => array('en' => 'Remove from saved', 'hi' => 'सहेजे हुए से हटाएँ', 'hinglish' => 'Saved se hatao'),
    'verse.note'       => array('en' => 'Your note', 'hi' => 'आपका नोट', 'hinglish' => 'Tumhara note'),
    'verse.note_hint'  => array('en' => 'Private to you. Nobody else can read it.', 'hi' => 'सिर्फ़ आपके लिए। कोई और नहीं पढ़ सकता।', 'hinglish' => 'Sirf tumhare liye. Koi aur nahi padh sakta.'),
    'verse.note_save'  => array('en' => 'Save note', 'hi' => 'नोट सेव करें', 'hinglish' => 'Note save karo'),
    'verse.mark_done'  => array('en' => 'Mark as read', 'hi' => 'पढ़ा हुआ चिह्नित करें', 'hinglish' => 'Padh liya mark karo'),
    'verse.done'       => array('en' => 'Read', 'hi' => 'पढ़ लिया', 'hinglish' => 'Padh liya'),
    'verse.uncurated'  => array('en' => 'This verse has the Sanskrit and a translation. The full treatment is still being written.', 'hi' => 'इस श्लोक का संस्कृत और अनुवाद मौजूद है। बाकी हिस्सा अभी लिखा जा रहा है।', 'hinglish' => 'Is shloka ka Sanskrit aur translation hai. Baaki abhi likha ja raha hai.'),
    'verse.listen'     => array('en' => 'Hear the Sanskrit', 'hi' => 'संस्कृत सुनें', 'hinglish' => 'Sanskrit suno'),

    // -----------------------------------------------------------------
    // Topics and life problems
    // -----------------------------------------------------------------
    // The life-problem entry point is how most people will actually
    // arrive: they have a problem, not a chapter number.
    'topic.index.title'   => array('en' => 'Ideas that run through the book', 'hi' => 'पूरी किताब में चलने वाले विचार', 'hinglish' => 'Poori kitaab mein chalne wale ideas'),
    'topic.related'       => array('en' => 'Connected ideas', 'hi' => 'जुड़े हुए विचार', 'hinglish' => 'Jude hue ideas'),
    'topic.verses'        => array('en' => 'Verses on this', 'hi' => 'इस पर श्लोक', 'hinglish' => 'Is par shlok'),
    'topic.none'          => array('en' => 'Nothing is tagged with this yet.', 'hi' => 'अभी इससे कुछ जुड़ा नहीं है।', 'hinglish' => 'Abhi isse kuch juda nahi hai.'),

    'problem.index.title' => array('en' => 'Start from what is bothering you', 'hi' => 'जो परेशान कर रहा है, वहीं से शुरू करें', 'hinglish' => 'Jo pareshan kar raha hai, wahin se shuru karo'),
    'problem.index.lead'  => array('en' => 'You do not have to start at the beginning. Pick the thing on your mind and read what the book says about it.', 'hi' => 'शुरुआत से ही शुरू करना ज़रूरी नहीं। जो मन में है वह चुनें और पढ़ें कि किताब उस पर क्या कहती है।', 'hinglish' => 'Shuruaat se hi shuru karna zaroori nahi. Jo mann mein hai woh chuno aur padho ki kitaab uspe kya kehti hai.'),
    'problem.read'        => array('en' => 'What the Gita says about this', 'hi' => 'गीता इस पर क्या कहती है', 'hinglish' => 'Gita is par kya kehti hai'),
    'problem.disclaimer'  => array('en' => 'This is a two-thousand-year-old text, not therapy. If you are in real distress, talk to somebody who can help.', 'hi' => 'यह दो हज़ार साल पुराना ग्रंथ है, इलाज नहीं। अगर आप सचमुच परेशानी में हैं, तो किसी ऐसे से बात करें जो मदद कर सके।', 'hinglish' => 'Yeh do hazaar saal purani kitaab hai, therapy nahi. Agar sach mein bahut mushkil mein ho, to kisi se baat karo jo help kar sake.'),

    // -----------------------------------------------------------------
    // Explore and search
    // -----------------------------------------------------------------
    'explore.title'       => array('en' => 'Explore', 'hi' => 'खोजें', 'hinglish' => 'Explore'),
    'explore.lead'        => array('en' => 'By chapter, by idea, or by what is on your mind.', 'hi' => 'अध्याय से, विचार से, या जो मन में है उससे।', 'hinglish' => 'Chapter se, idea se, ya jo mann mein hai usse.'),
    'explore.daily'       => array('en' => 'Verse of the day', 'hi' => 'आज का श्लोक', 'hinglish' => 'Aaj ka shloka'),
    'explore.random'      => array('en' => 'Show me any verse', 'hi' => 'कोई भी श्लोक दिखाएँ', 'hinglish' => 'Koi bhi shloka dikhao'),
    'explore.recent'      => array('en' => 'You were reading', 'hi' => 'आप पढ़ रहे थे', 'hinglish' => 'Tum padh rahe the'),
    'explore.bookmarks'   => array('en' => 'Saved by you', 'hi' => 'आपके सहेजे हुए', 'hinglish' => 'Tumhare saved'),

    'search.title'        => array('en' => 'Search', 'hi' => 'खोजें', 'hinglish' => 'Search'),
    'search.placeholder'  => array('en' => 'A word, a verse number, or a problem', 'hi' => 'शब्द, श्लोक संख्या, या कोई समस्या', 'hinglish' => 'Shabd, shloka number, ya koi problem'),
    'search.submit'       => array('en' => 'Search', 'hi' => 'खोजें', 'hinglish' => 'Search karo'),
    'search.results_for'  => array('en' => 'Results for “:query”', 'hi' => '“:query” के नतीजे', 'hinglish' => '“:query” ke results'),
    'search.count'        => array('en' => ':n result|:n results', 'hi' => ':n नतीजा|:n नतीजे', 'hinglish' => ':n result|:n results'),
    'search.none'         => array('en' => 'Nothing matched “:query”.', 'hi' => '“:query” से कुछ मेल नहीं खाया।', 'hinglish' => '“:query” se kuch match nahi hua.'),
    'search.suggestions'  => array('en' => 'Try one of these instead', 'hi' => 'इनमें से कोई आज़माएँ', 'hinglish' => 'Inme se koi try karo'),
    'search.popular'      => array('en' => 'What people look for', 'hi' => 'लोग क्या खोजते हैं', 'hinglish' => 'Log kya search karte hain'),
    'search.in_chapter'   => array('en' => 'in chapter :n', 'hi' => 'अध्याय :n में', 'hinglish' => 'chapter :n mein'),
    'search.tip'          => array('en' => 'Typing 2.47 goes straight to that verse.', 'hi' => '2.47 लिखने पर सीधे उसी श्लोक पर पहुँचेंगे।', 'hinglish' => '2.47 likhoge to seedha usi shloka par pahunch jaoge.'),
);
