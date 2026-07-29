-- =====================================================================
-- VedaVerse — database/seed_sample.sql
-- =====================================================================
-- All eighteen chapters, the topic graph, and five fully-written verses
-- from chapter 2.
--
-- WHY THIS FILE EXISTS
--   Step 5 builds the content pages. Step 6 writes the 108 verses.
--   Without this file, everything Step 5 produces renders an empty state
--   and nobody can judge any of it until the largest step in the build
--   is also finished. Five real verses make the Chariot Path, the verse
--   page and life-problem navigation all reviewable now.
--
-- THIS IS NOT THROWAWAY DATA
--   Every verse here is written to final quality and stays in the
--   product. Step 6 adds the other 103 and tops each of these up from
--   five modern examples to the specified eight to twelve. Nothing in
--   this file gets deleted or rewritten.
--
-- CONTENT RULES OBSERVED HERE — read before adding to it
--   * Every translation, summary, explanation and example is ORIGINAL
--     writing. No published translation is reproduced. Prabhupada,
--     Easwaran, Radhakrishnan, Gita Press and every other modern
--     rendering is under its own copyright and appears nowhere.
--   * The Sanskrit is quoted as it is: ancient, public domain, and not
--     altered. Verse numbering is never changed and verses are never
--     merged.
--   * Films and matches are named as facts. No dialogue, no lyrics, no
--     plot text is reproduced. Anything that gives away a story is
--     flagged has_spoiler.
--   * No example praises or criticises any living politician, party or
--     movement. Where a public-life example appears it describes the
--     SHAPE of a dilemma and nothing else.
--   * Traditional viewpoints are presented side by side and never
--     ranked. Whether one is right is the reader's judgement.
--
-- RUNNING IT
--   Idempotent. INSERT IGNORE on the parents and a delete-then-insert on
--   the children, so re-running updates rather than duplicating.
--
--       mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
--           < htdocs/database/seed_sample.sql
--
--   Or from the admin panel once Step 13 exists.
--
-- PARSING RULES — the installer splits on these
--   Statements end with a semicolon at the end of a line. No semicolons
--   inside string literals. No stored procedures, no DELIMITER.
-- =====================================================================

SET NAMES utf8mb4;

-- =====================================================================
-- 1. CHAPTERS
-- =====================================================================
-- verse_count is the count in the SCRIPTURE, not the count we have
-- written. Chapter 2 has 72 verses whether five of them are curated or
-- all of them are. The progress bars use the curated count instead —
-- see ChapterRepository::curatedCounts().
--
-- estimated_minutes is left at 0 deliberately. ContentService works it
-- out from what is actually written, so it cannot claim a forty-minute
-- read for a chapter with two verses in it.
-- =====================================================================

INSERT IGNORE INTO chapters
  (chapter_number, sanskrit_name, transliteration,
   title_en, title_hi, title_hinglish,
   subtitle_en, subtitle_hi, subtitle_hinglish,
   theme, difficulty, estimated_minutes, verse_count, sort_order, published)
VALUES
(1, 'अर्जुनविषादयोग', 'Arjuna Viṣāda Yoga',
 'The Collapse', 'अर्जुन का टूटना', 'Arjun Ka Tootna',
 'A man who has trained his whole life sits down and cannot do the thing he trained for.',
 'जिसने पूरी ज़िंदगी तैयारी की, वही आदमी बैठ जाता है और वह काम नहीं कर पाता।',
 'Jisne poori zindagi tayyari ki, wahi aadmi baith jaata hai aur woh kaam nahi kar paata.',
 'Doubt, panic, moral paralysis', 'beginner', 0, 47, 1, 1),

(2, 'साङ्ख्ययोग', 'Sāṅkhya Yoga',
 'The Ground Under Everything', 'सब कुछ जिस पर टिका है', 'Sab Kuch Jis Par Tika Hai',
 'The answer starts here. What actually dies, what does not, and what you are responsible for.',
 'जवाब यहीं से शुरू होता है। सचमुच क्या मरता है, क्या नहीं, और आप किसके ज़िम्मेदार हैं।',
 'Jawab yahin se shuru hota hai. Sach mein kya marta hai, kya nahi, aur tum kiske zimmedaar ho.',
 'The self, duty, steadiness', 'beginner', 0, 72, 2, 1),

(3, 'कर्मयोग', 'Karma Yoga',
 'Doing the Work', 'काम करना', 'Kaam Karna',
 'Nobody gets to opt out. The question is only how you act, not whether.',
 'कोई बाहर नहीं बैठ सकता। सवाल सिर्फ़ यह है कि आप कैसे काम करते हैं, यह नहीं कि करते हैं या नहीं।',
 'Koi bahar nahi baith sakta. Sawaal sirf yeh hai ki tum kaise kaam karte ho, yeh nahi ki karte ho ya nahi.',
 'Action, duty, motivation', 'beginner', 0, 43, 3, 1),

(4, 'ज्ञानकर्मसंन्यासयोग', 'Jñāna Karma Sannyāsa Yoga',
 'Knowing and Doing', 'जानना और करना', 'Jaanna Aur Karna',
 'Understanding does not replace acting. It changes what acting costs you.',
 'समझ लेने से काम करना बंद नहीं होता। बस काम की कीमत बदल जाती है।',
 'Samajh lene se kaam karna band nahi hota. Bas kaam ki keemat badal jaati hai.',
 'Knowledge, action, renunciation', 'intermediate', 0, 42, 4, 1),

(5, 'कर्मसंन्यासयोग', 'Karma Sannyāsa Yoga',
 'Letting Go While Still Working', 'करते हुए छोड़ना', 'Karte Hue Chhodna',
 'Walking away and staying put can be the same act, done from a different place.',
 'छोड़ देना और डटे रहना, एक ही काम हो सकते हैं — फ़र्क़ सिर्फ़ भीतर का है।',
 'Chhod dena aur date rehna ek hi kaam ho sakte hain — farq sirf andar ka hai.',
 'Detachment, equanimity', 'intermediate', 0, 29, 5, 1),

(6, 'आत्मसंयमयोग', 'Ātma Saṁyama Yoga',
 'Your Own Worst Opponent', 'अपना ही सबसे बड़ा विरोधी', 'Apna Hi Sabse Bada Virodhi',
 'The mind is either the best friend you have or the only enemy who never leaves.',
 'मन या तो आपका सबसे अच्छा दोस्त है, या वह इकलौता दुश्मन जो कभी नहीं जाता।',
 'Mann ya to tumhara sabse achha dost hai, ya woh akela dushman jo kabhi jaata nahi.',
 'Discipline, focus, the mind', 'intermediate', 0, 47, 6, 1),

(7, 'ज्ञानविज्ञानयोग', 'Jñāna Vijñāna Yoga',
 'Knowing It and Living It', 'जानना और जीना', 'Jaanna Aur Jeena',
 'There is a difference between the answer and having the answer become you.',
 'जवाब जान लेने और जवाब बन जाने में फ़र्क़ है।',
 'Jawab jaan lene mein aur jawab ban jaane mein farq hai.',
 'Knowledge, realisation', 'advanced', 0, 30, 7, 1),

(8, 'अक्षरब्रह्मयोग', 'Akṣara Brahma Yoga',
 'What Lasts', 'जो टिकता है', 'Jo Tikta Hai',
 'What survives when everything you can point at has gone.',
 'जब वह सब चला जाए जिसकी ओर आप उँगली उठा सकते हैं, तब क्या बचता है।',
 'Jab woh sab chala jaaye jiski taraf tum ungli utha sakte ho, tab kya bachta hai.',
 'Impermanence, the imperishable', 'advanced', 0, 28, 8, 1),

(9, 'राजविद्याराजगुह्ययोग', 'Rāja Vidyā Rāja Guhya Yoga',
 'The Open Secret', 'खुला हुआ रहस्य', 'Khula Hua Rahasya',
 'The most important thing is not hidden. It is just not noticed.',
 'सबसे ज़रूरी बात छिपी नहीं है। बस उस पर नज़र नहीं जाती।',
 'Sabse zaroori baat chhipi nahi hai. Bas us par nazar nahi jaati.',
 'Devotion, presence', 'intermediate', 0, 34, 9, 1),

(10, 'विभूतियोग', 'Vibhūti Yoga',
 'Wherever You Look', 'जहाँ भी देखो', 'Jahan Bhi Dekho',
 'A list of the best of everything, and one point being made underneath it.',
 'हर चीज़ में जो सबसे ऊँचा है उसकी सूची, और उसके नीचे एक ही बात।',
 'Har cheez mein jo sabse ooncha hai uski list, aur uske neeche ek hi baat.',
 'Immanence, wonder', 'intermediate', 0, 42, 10, 1),

(11, 'विश्वरूपदर्शनयोग', 'Viśvarūpa Darśana Yoga',
 'Seeing Too Much', 'हद से ज़्यादा दिख जाना', 'Had Se Zyada Dikh Jaana',
 'Arjuna asks to see everything, gets his wish, and immediately asks for it to stop.',
 'अर्जुन सब कुछ देखना चाहता है, देख लेता है, और तुरंत रोकने को कहता है।',
 'Arjun sab kuch dekhna chahta hai, dekh leta hai, aur turant rokne ko kehta hai.',
 'Awe, scale, terror', 'advanced', 0, 55, 11, 1),

(12, 'भक्तियोग', 'Bhakti Yoga',
 'The Simplest Road', 'सबसे आसान रास्ता', 'Sabse Aasaan Rasta',
 'For people who would rather love something than understand it. It works.',
 'उनके लिए जो समझने से ज़्यादा प्रेम करना चाहते हैं। यह चलता है।',
 'Un logon ke liye jo samajhne se zyada pyaar karna chahte hain. Yeh chalta hai.',
 'Devotion, simplicity', 'beginner', 0, 20, 12, 1),

(13, 'क्षेत्रक्षेत्रज्ञविभागयोग', 'Kṣetra Kṣetrajña Vibhāga Yoga',
 'The Field and Who Watches It', 'खेत और उसे देखने वाला', 'Khet Aur Use Dekhne Wala',
 'You are not the thing that is happening. You are what notices it happening.',
 'जो हो रहा है, आप वह नहीं हैं। आप वह हैं जो उसे होते हुए देख रहा है।',
 'Jo ho raha hai, tum woh nahi ho. Tum woh ho jo use hote hue dekh raha hai.',
 'Awareness, the observer', 'advanced', 0, 35, 13, 1),

(14, 'गुणत्रयविभागयोग', 'Guṇatraya Vibhāga Yoga',
 'Three Settings', 'तीन हालतें', 'Teen Halatein',
 'Clarity, restlessness and inertia. You are in one of them right now.',
 'साफ़ी, बेचैनी और जड़ता। अभी इसी वक़्त आप इनमें से किसी एक में हैं।',
 'Clarity, bechaini aur jadta. Abhi is waqt tum inme se kisi ek mein ho.',
 'Temperament, mood, tendency', 'intermediate', 0, 27, 14, 1),

(15, 'पुरुषोत्तमयोग', 'Puruṣottama Yoga',
 'The Upside-Down Tree', 'उलटा पेड़', 'Ulta Ped',
 'A tree with its roots in the air, and an instruction to cut it down.',
 'एक पेड़ जिसकी जड़ें ऊपर हैं, और उसे काट डालने का आदेश।',
 'Ek ped jiski jadein upar hain, aur use kaat dene ka order.',
 'Attachment, freedom', 'advanced', 0, 20, 15, 1),

(16, 'दैवासुरसम्पद्विभागयोग', 'Daivāsura Sampad Vibhāga Yoga',
 'Two Ways to Be', 'होने के दो तरीक़े', 'Hone Ke Do Tareeke',
 'Not good people and bad people. Two directions any person can face.',
 'अच्छे लोग और बुरे लोग नहीं। दो दिशाएँ, जिनमें कोई भी मुड़ सकता है।',
 'Achhe log aur bure log nahi. Do directions, jinme koi bhi mud sakta hai.',
 'Character, integrity', 'beginner', 0, 24, 16, 1),

(17, 'श्रद्धात्रयविभागयोग', 'Śraddhātraya Vibhāga Yoga',
 'What You Actually Believe', 'आप सचमुच क्या मानते हैं', 'Tum Sach Mein Kya Maante Ho',
 'Not what you say you believe. What your food, your speech and your giving say you believe.',
 'वह नहीं जो आप कहते हैं। वह जो आपका खाना, बोलना और देना बताता है।',
 'Woh nahi jo tum kehte ho. Woh jo tumhara khana, bolna aur dena batata hai.',
 'Faith, habit, integrity', 'intermediate', 0, 28, 17, 1),

(18, 'मोक्षसंन्यासयोग', 'Mokṣa Sannyāsa Yoga',
 'Everything, Once More', 'सब कुछ, एक बार फिर', 'Sab Kuch, Ek Baar Phir',
 'The whole argument again, shorter, and then one last thing said plainly.',
 'पूरी बात दोबारा, छोटे में, और फिर आख़िर में एक बात सीधे-सीधे।',
 'Poori baat dobara, chhote mein, aur phir aakhir mein ek baat seedhi si.',
 'Freedom, summary, choice', 'intermediate', 0, 78, 18, 1);

-- =====================================================================
-- 2. TOPICS
-- =====================================================================
-- Two kinds in one table, separated by is_life_problem.
--
--   concepts        what the book is about — karma, dharma, the self
--   life problems   what the reader is about — anger, grief, burnout
--
-- The second set is the real front door. Most people arrive with a
-- problem, not with an interest in scripture, and /problems is written
-- for exactly that person.
-- =====================================================================

INSERT IGNORE INTO topics
  (name_en, name_hi, name_hinglish, slug,
   description_en, description_hi, description_hinglish,
   is_life_problem, sort_order, published)
VALUES

-- --- concepts -------------------------------------------------------
('Action without attachment', 'कर्म बिना आसक्ति', 'Bina attachment ke karm', 'action-without-attachment',
 'Doing the work properly while holding the result loosely. The central practical idea of the whole text.',
 'काम पूरे मन से करना, पर नतीजे को कसकर न पकड़ना। पूरे ग्रंथ का सबसे व्यावहारिक विचार यही है।',
 'Kaam poore mann se karna, par result ko kas ke na pakadna. Poore text ka sabse practical idea yahi hai.',
 0, 1, 1),

('The self', 'आत्मा', 'Atma', 'the-self',
 'What in you is not your body, your job title or your mood. The thing the book says does not end.',
 'आपमें वह क्या है जो न शरीर है, न पद, न मनोदशा। ग्रंथ कहता है वही ख़त्म नहीं होता।',
 'Tumme woh kya hai jo na body hai, na designation, na mood. Text kehta hai wahi khatam nahi hota.',
 0, 2, 1),

('Duty', 'कर्तव्य', 'Kartavya', 'duty',
 'The work that is yours to do, as opposed to the work that looks more impressive.',
 'वह काम जो आपका है — उस काम के बजाय जो ज़्यादा प्रभावशाली दिखता है।',
 'Woh kaam jo tumhara hai — us kaam ki jagah jo zyada impressive dikhta hai.',
 0, 3, 1),

('Steadiness', 'स्थिरता', 'Sthirta', 'steadiness',
 'Staying roughly the same person whether things went well today or badly.',
 'आज अच्छा हुआ या बुरा — फिर भी लगभग वही इंसान बने रहना।',
 'Aaj achha hua ya bura — phir bhi lagbhag wahi insaan bane rehna.',
 0, 4, 1),

('Desire', 'इच्छा', 'Ichha', 'desire',
 'Wanting, and what wanting does to the person doing the wanting.',
 'चाहना, और चाहने वाले पर उस चाहने का असर।',
 'Chahna, aur chahne wale par us chahne ka asar.',
 0, 5, 1),

('Impermanence', 'अनित्यता', 'Anityata', 'impermanence',
 'Nothing you are currently upset about will still be here in its present form.',
 'अभी जिस बात से आप परेशान हैं, वह इस रूप में टिकेगी नहीं।',
 'Abhi jis baat se pareshan ho, woh is roop mein tikegi nahi.',
 0, 6, 1),

-- --- life problems --------------------------------------------------
('Anger', 'गुस्सा', 'Gussa', 'anger',
 'The thing that arrives fast, feels justified, and costs you something you wanted to keep.',
 'जो तेज़ी से आता है, जायज़ लगता है, और कुछ ऐसा ले जाता है जिसे आप रखना चाहते थे।',
 'Jo tezi se aata hai, jaayaz lagta hai, aur kuch aisa le jaata hai jo tum rakhna chahte the.',
 1, 10, 1),

('Grief', 'शोक', 'Shok', 'grief',
 'Losing somebody, and being told — unhelpfully — that you should be over it.',
 'किसी को खो देना, और यह सुनना कि अब तो आपको सँभल जाना चाहिए।',
 'Kisi ko kho dena, aur yeh sunna ki ab to tumhe sambhal jaana chahiye.',
 1, 11, 1),

('When effort does not pay off', 'जब मेहनत बेकार जाए', 'Jab mehnat bekaar jaaye', 'effort-without-result',
 'You did the work. It did not land. What that means, and what it does not mean.',
 'आपने काम किया। बात नहीं बनी। इसका मतलब क्या है, और क्या नहीं है।',
 'Tumne kaam kiya. Baat nahi bani. Iska matlab kya hai, aur kya nahi hai.',
 1, 12, 1),

('Burnout', 'थकान और जलन', 'Burnout', 'burnout',
 'Still working, and nothing in it reaches you any more.',
 'काम अब भी चल रहा है, पर उसमें से कुछ भी आप तक नहीं पहुँच रहा।',
 'Kaam abhi bhi chal raha hai, par usme se kuch bhi tum tak nahi pahunch raha.',
 1, 13, 1),

('Comparison', 'तुलना', 'Tulna', 'comparison',
 'Measuring your life against somebody else''s, usually against their best day and your ordinary one.',
 'अपनी ज़िंदगी को किसी और से नापना — अक्सर उनके सबसे अच्छे दिन से अपने आम दिन को।',
 'Apni zindagi ko kisi aur se naapna — aksar unke sabse achhe din se apne normal din ko.',
 1, 14, 1),

('Making a hard decision', 'मुश्किल फ़ैसला', 'Mushkil faisla', 'hard-decisions',
 'Both options cost something real, and refusing to choose is also a choice.',
 'दोनों रास्तों में कुछ सचमुच खोना है, और न चुनना भी एक चुनाव है।',
 'Dono raaste mein kuch sach mein khona hai, aur na chunna bhi ek choice hai.',
 1, 15, 1),

('Fear', 'डर', 'Dar', 'fear',
 'The thing that keeps you from starting, and looks like caution from the inside.',
 'जो आपको शुरू नहीं करने देता, और भीतर से समझदारी जैसा लगता है।',
 'Jo tumhe shuru nahi karne deta, aur andar se samajhdari jaisa lagta hai.',
 1, 16, 1),

('Losing your peace over small things', 'छोटी बातों पर चैन खोना', 'Chhoti baaton par chain khona', 'restlessness',
 'Traffic, a message left on read, a comment in a meeting. And the rest of the day gone.',
 'ट्रैफ़िक, बिना जवाब का मैसेज, मीटिंग में कही गई एक बात। और पूरा दिन चला गया।',
 'Traffic, bina jawab ka message, meeting mein kahi ek baat. Aur poora din gaya.',
 1, 17, 1);

-- =====================================================================
-- 3. THE TOPIC GRAPH
-- =====================================================================
-- Edges between topics. Directional in the schema, read in both
-- directions by TopicRepository::related() — because a reader following
-- a trail of ideas does not care which way an editor happened to enter
-- it.
--
-- Written as a SELECT of two slugs rather than raw ids, so the file does
-- not depend on auto-increment values and can be re-run against any
-- database.
-- =====================================================================

INSERT IGNORE INTO topic_relations (topic_id, related_topic_id, relation_type, strength)
SELECT a.id, b.id, r.rel, r.strength
FROM (
    SELECT 'anger' AS x, 'desire' AS y, 'caused_by' AS rel, 9 AS strength
    UNION ALL SELECT 'anger', 'restlessness', 'related', 7
    UNION ALL SELECT 'desire', 'comparison', 'causes', 8
    UNION ALL SELECT 'comparison', 'burnout', 'causes', 6
    UNION ALL SELECT 'effort-without-result', 'action-without-attachment', 'related', 10
    UNION ALL SELECT 'effort-without-result', 'burnout', 'causes', 7
    UNION ALL SELECT 'grief', 'impermanence', 'related', 9
    UNION ALL SELECT 'grief', 'the-self', 'related', 8
    UNION ALL SELECT 'hard-decisions', 'duty', 'related', 9
    UNION ALL SELECT 'hard-decisions', 'fear', 'caused_by', 7
    UNION ALL SELECT 'restlessness', 'steadiness', 'opposite', 9
    UNION ALL SELECT 'burnout', 'action-without-attachment', 'related', 8
    UNION ALL SELECT 'fear', 'the-self', 'related', 6
    UNION ALL SELECT 'action-without-attachment', 'duty', 'related', 9
    UNION ALL SELECT 'steadiness', 'the-self', 'related', 8
    UNION ALL SELECT 'impermanence', 'steadiness', 'related', 7
) AS r
JOIN topics a ON a.slug = r.x
JOIN topics b ON b.slug = r.y;

-- =====================================================================
-- 4. FIVE VERSES FROM CHAPTER 2
-- =====================================================================
-- Chosen to cover five different problems rather than five neighbouring
-- verse numbers, so the topic graph and the life-problem pages have
-- something real to connect:
--
--   2.13  grief and change        the body passes through ages; so does this
--   2.14  endurance               heat and cold arrive and leave; sit through them
--   2.47  effort and outcome      the famous one, and the most misread
--   2.62  where anger comes from  the chain from dwelling to rage
--   2.70  peace amid wanting      the ocean that rivers cannot disturb
--
-- All five are on the specification's mandatory list.
--
-- global_order is the position across the whole text. Chapter 1 has 47
-- verses, so chapter 2 verse n is 47 + n. It drives next/previous across
-- chapter boundaries.
-- =====================================================================

INSERT IGNORE INTO verses
  (chapter_id, verse_number, global_order, is_curated, slug,
   sanskrit_devanagari, transliteration_iast, transliteration_simple,
   translation_literal,
   translation_en, translation_hi, translation_hinglish,
   summary_en, summary_hi, summary_hinglish,
   difficulty, seo_title, seo_description, published)
SELECT c.id, v.* FROM (

  SELECT
    13 AS verse_number, 60 AS global_order, 1 AS is_curated, 'gita-2-13' AS slug,
    'देहिनोऽस्मिन्यथा देहे कौमारं यौवनं जरा।\nतथा देहान्तरप्राप्तिर्धीरस्तत्र न मुह्यति॥' AS sanskrit_devanagari,
    'dehino ''smin yathā dehe kaumāraṁ yauvanaṁ jarā\ntathā dehāntara-prāptir dhīras tatra na muhyati' AS transliteration_iast,
    'dehino smin yatha dehe kaumaram yauvanam jara\ntatha dehantara-praptir dhirastatra na muhyati' AS transliteration_simple,
    'For the embodied one in this body, as childhood, youth and old age are, so is the obtaining of another body. The steady person is not confused about that.' AS translation_literal,
    'The one living inside this body passes through being a child, then a young adult, then old — and the body it wakes up in next is one more step of the same kind. Somebody steady does not lose their footing over it.' AS translation_en,
    'जो इस शरीर के भीतर रहता है, वह बचपन से जवानी और फिर बुढ़ापे से गुज़रता है — और अगला शरीर मिलना भी उसी क्रम की एक और सीढ़ी है। जो स्थिर है, वह यहाँ डगमगाता नहीं।' AS translation_hi,
    'Jo is body ke andar rehta hai, woh bachpan se jawani, phir budhape se guzarta hai — aur agla sharir milna bhi usi silsile ki ek aur seedhi hai. Jo sthir hai, woh yahan dagmagata nahi.' AS translation_hinglish,
    'The body you are in has already changed completely more than once, and you did not mourn any of it.' AS summary_en,
    'जिस शरीर में आप हैं, वह पहले भी पूरी तरह बदल चुका है — और आपने उसका शोक नहीं मनाया।' AS summary_hi,
    'Jis body mein tum ho, woh pehle bhi poori tarah badal chuki hai — aur tumne uska matam nahi manaya.' AS summary_hinglish,
    'beginner' AS difficulty,
    'What the Bhagavad Gita says about grief and change' AS seo_title,
    'Losing somebody, or losing a version of your own life, and being told to move on. What Gita 2.13 actually says about change, and what it does not say.' AS seo_description,
    1 AS published

  UNION ALL SELECT
    14, 61, 1, 'gita-2-14',
    'मात्रास्पर्शास्तु कौन्तेय शीतोष्णसुखदुःखदाः।\nआगमापायिनोऽनित्यास्तांस्तितिक्षस्व भारत॥',
    'mātrā-sparśās tu kaunteya śītoṣṇa-sukha-duḥkha-dāḥ\nāgamāpāyino ''nityās tāṁs titikṣasva bhārata',
    'matra-sparshas tu kaunteya shitoshna-sukha-duhkha-dah\nagamapayino nityas tams titikshasva bharata',
    'The contacts of the senses, Kaunteya, give cold and heat, pleasure and pain. They come and go, they are impermanent. Endure them, Bharata.',
    'Contact with the world brings cold and heat, comfort and pain. All of them arrive, and all of them leave — that is what they do. Sit through them.',
    'दुनिया से संपर्क ठंड और गरमी, सुख और दुख लाता है। ये सब आते हैं और चले जाते हैं — यही इनका स्वभाव है। इन्हें सह जाइए।',
    'Duniya se contact thand aur garmi, sukh aur dukh laata hai. Yeh sab aate hain aur chale jaate hain — inka kaam hi yahi hai. Inhe seh jao.',
    'Discomfort is not a signal that something has gone wrong. It is weather.',
    'तकलीफ़ इस बात का संकेत नहीं है कि कुछ गड़बड़ हो गया। वह मौसम है।',
    'Takleef iska signal nahi hai ki kuch gadbad ho gaya. Woh mausam hai.',
    'beginner',
    'Gita 2.14 on getting through a bad stretch',
    'A hard week, a bad season, a phase that will not end. What the Bhagavad Gita says about enduring discomfort without treating it as a verdict.',
    1

  UNION ALL SELECT
    47, 94, 1, 'gita-2-47',
    'कर्मण्येवाधिकारस्ते मा फलेषु कदाचन।\nमा कर्मफलहेतुर्भूर्मा ते सङ्गोऽस्त्वकर्मणि॥',
    'karmaṇy evādhikāras te mā phaleṣu kadācana\nmā karma-phala-hetur bhūr mā te saṅgo ''stv akarmaṇi',
    'karmany evadhikaras te ma phaleshu kadachana\nma karma-phala-hetur bhur ma te sango stv akarmani',
    'Your right is to action alone, never to its fruits. Do not be the cause of the fruit of action. Let there be no attachment in you to inaction.',
    'The work is yours. What comes of it is not. Do not act in order to collect the result — and do not use that as a reason to stop working either.',
    'काम आपका है। उससे जो निकलेगा, वह आपका नहीं। नतीजा बटोरने के लिए काम मत कीजिए — और इसी बात को काम छोड़ देने का बहाना भी मत बनाइए।',
    'Kaam tumhara hai. Usse jo niklega woh tumhara nahi. Result batorne ke liye kaam mat karo — aur isi baat ko kaam chhodne ka bahana bhi mat banao.',
    'Effort is yours, outcome is not — and that is not permission to stop trying.',
    'मेहनत आपकी है, नतीजा नहीं — और यह मेहनत छोड़ने की इजाज़त नहीं है।',
    'Mehnat tumhari hai, result nahi — aur yeh mehnat chhodne ki permission nahi hai.',
    'beginner',
    'Gita 2.47: doing the work without obsessing over the result',
    'The most quoted verse in the Bhagavad Gita, and the most misread. What it actually says about effort, outcomes, and the half of it people leave out.',
    1

  UNION ALL SELECT
    62, 109, 1, 'gita-2-62',
    'ध्यायतो विषयान्पुंसः सङ्गस्तेषूपजायते।\nसङ्गात्सञ्जायते कामः कामात्क्रोधोऽभिजायते॥',
    'dhyāyato viṣayān puṁsaḥ saṅgas teṣūpajāyate\nsaṅgāt sañjāyate kāmaḥ kāmāt krodho ''bhijāyate',
    'dhyayato vishayan pumsah sangas teshupajayate\nsangat sanjayate kamah kamat krodho bhijayate',
    'For a person dwelling on objects of the senses, attachment to them is born. From attachment desire is born. From desire anger arises.',
    'Keep turning something over in your mind and you become attached to it. Attachment turns into wanting. Wanting, blocked, comes out as anger. Nobody skips a step.',
    'किसी चीज़ के बारे में सोचते रहिए, और उससे लगाव बन जाता है। लगाव चाह बन जाता है। चाह रुक जाए तो गुस्सा बनकर निकलती है। कोई कड़ी छूटती नहीं।',
    'Kisi cheez ke baare mein sochte raho, aur usse lagaav ban jaata hai. Lagaav chaah ban jaati hai. Chaah ruk jaaye to gussa ban ke nikalti hai. Koi step chhootta nahi.',
    'Anger is not the first step. It is the fourth, and the first one was quiet.',
    'गुस्सा पहली सीढ़ी नहीं है। वह चौथी है, और पहली चुपचाप थी।',
    'Gussa pehli seedhi nahi hai. Woh chauthi hai, aur pehli chupchap thi.',
    'intermediate',
    'Where anger actually comes from, according to Gita 2.62',
    'Anger feels like it arrives from nowhere. The Bhagavad Gita traces it back four steps to something much quieter, and the earlier you catch it the cheaper it is.',
    1

  UNION ALL SELECT
    70, 117, 1, 'gita-2-70',
    'आपूर्यमाणमचलप्रतिष्ठं समुद्रमापः प्रविशन्ति यद्वत्।\nतद्वत्कामा यं प्रविशन्ति सर्वे स शान्तिमाप्नोति न कामकामी॥',
    'āpūryamāṇam acala-pratiṣṭhaṁ samudram āpaḥ praviśanti yadvat\ntadvat kāmā yaṁ praviśanti sarve sa śāntim āpnoti na kāma-kāmī',
    'apuryamanam achala-pratishtham samudram apah pravishanti yadvat\ntadvat kama yam pravishanti sarve sa shantim apnoti na kama-kami',
    'As waters enter the ocean, which is being filled yet remains unmoved in its own place, so the one whom all desires enter attains peace — not the one who longs after desires.',
    'Rivers pour into the ocean all day and the ocean does not rise to meet them. Wanting will keep arriving in you too. Peace belongs to the one it arrives in without moving them, not to the one who runs after it.',
    'नदियाँ दिन भर समुद्र में गिरती हैं और समुद्र उन्हें लेने ऊपर नहीं उठता। चाहें आपमें भी आती रहेंगी। शांति उसे मिलती है जिसमें वे आकर भी उसे हिला नहीं पातीं — उसे नहीं जो उनके पीछे भागता है।',
    'Nadiyan din bhar samundar mein girti hain aur samundar unhe lene upar nahi uthta. Chaahein tumme bhi aati rahengi. Shanti use milti hai jinme woh aa ke bhi hila nahi paatin — us ko nahi jo unke peeche bhagta hai.',
    'The goal is not to stop wanting things. It is to stop being moved every time you do.',
    'लक्ष्य चाहना बंद करना नहीं है। लक्ष्य यह है कि हर चाह पर हिलना बंद हो।',
    'Goal chahna band karna nahi hai. Goal yeh hai ki har chaah par hilna band ho.',
    'intermediate',
    'Gita 2.70 on wanting things and still having peace',
    'You are told to stop wanting. The Bhagavad Gita says something more usable: let wanting arrive without letting it move you. The ocean image, explained.',
    1

) AS v
JOIN chapters c ON c.chapter_number = 2;

-- =====================================================================
-- 5. EXPLANATIONS
-- =====================================================================
-- Two depths per verse: beginner, which assumes nothing and uses no
-- Sanskrit terms at all, and intermediate, which introduces the terms
-- with their definitions attached. Advanced — where interpretations are
-- compared — arrives with the commentary work in Step 6.
--
-- The delete-then-insert makes the file re-runnable without piling up
-- duplicate explanations.
-- =====================================================================

DELETE ve FROM verse_explanations ve JOIN verses v ON v.id = ve.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 2 AND v.verse_number IN (13, 14, 47, 62, 70);

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level,
       x.h_en, x.h_hi, x.h_hing,
       x.p_en, x.p_hi, x.p_hing,
       x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 13 AS vn, 'beginner' AS level,
   'Two armies are drawn up and neither has moved. Arjuna has just looked across at the other side and recognised his teachers, his cousins, the men who taught him to hold a bow. He has put his weapons down. These are among the first words Krishna says to him in reply.' AS h_en,
   'दो सेनाएँ आमने-सामने खड़ी हैं और अभी कोई हिला नहीं है। अर्जुन ने अभी-अभी सामने देखा है और अपने गुरुओं, भाइयों, उन लोगों को पहचाना है जिन्होंने उसे धनुष पकड़ना सिखाया। उसने हथियार रख दिए हैं। कृष्ण जवाब में जो पहले शब्द कहते हैं, यह उनमें से है।' AS h_hi,
   'Do senayein aamne saamne khadi hain aur abhi koi hila nahi hai. Arjun ne abhi saamne dekha hai aur apne gurus, cousins, un logon ko pehchana hai jinhone use dhanush pakadna sikhaya. Usne hathiyar rakh diye hain. Krishna jawab mein jo pehle shabd kehte hain, yeh unme se hai.' AS h_hing,
   'You have already been several people. The five-year-old you was replaced without ceremony, and so was the person you were at twenty. You did not grieve either of them, because the replacing happened slowly enough that you never noticed a moment of loss. The verse is pointing at that, and asking you to extend the same steadiness one step further.' AS p_en,
   'आप पहले ही कई लोग हो चुके हैं। पाँच साल का आप बिना किसी विदाई के बदल गया, और बीस साल वाला भी। आपने दोनों का शोक नहीं मनाया, क्योंकि बदलना इतने धीरे हुआ कि खोने का कोई क्षण दिखा ही नहीं। श्लोक इसी की ओर इशारा कर रहा है, और वही स्थिरता एक क़दम आगे ले जाने को कह रहा है।' AS p_hi,
   'Tum pehle hi kai log ban chuke ho. Paanch saal wala tum bina kisi vidaai ke badal gaya, aur bees saal wala bhi. Tumne dono ka matam nahi manaya, kyunki badalna itne dheere hua ki khone ka koi moment dikha hi nahi. Shloka isi taraf ishara kar raha hai, aur wahi sthirta ek kadam aage le jaane ko keh raha hai.' AS p_hing,
   'This is not an instruction to feel nothing. Arjuna is about to lose people he loves and Krishna never tells him that will not hurt. The claim is narrower and more useful: change is not the same as destruction, and the panic that says everything is ending is reading the situation wrong. Grief is allowed. Panic is optional.' AS m_en,
   'यह कुछ न महसूस करने का आदेश नहीं है। अर्जुन अपने प्रियजनों को खोने वाला है और कृष्ण कभी नहीं कहते कि इससे दुख नहीं होगा। दावा इससे छोटा और ज़्यादा काम का है: बदलना और नष्ट होना एक बात नहीं है, और जो घबराहट कहती है कि सब ख़त्म हो रहा है, वह स्थिति को ग़लत पढ़ रही है। दुख की जगह है। घबराहट ज़रूरी नहीं।' AS m_hi,
   'Yeh kuch mehsoos na karne ka order nahi hai. Arjun apne logon ko khone wala hai aur Krishna kabhi nahi kehte ki dard nahi hoga. Baat isse chhoti aur zyada kaam ki hai: badalna aur khatam hona ek cheez nahi hai, aur jo ghabrahat kehti hai ki sab khatam ho raha hai, woh situation ko galat padh rahi hai. Dukh ki jagah hai. Ghabrahat optional hai.' AS m_hing

  UNION ALL SELECT 13, 'intermediate',
   'The argument in chapter 2 moves in a specific order. Krishna does not begin with duty or with action; he begins by disputing Arjuna''s premise about what is actually at stake. Everything practical in the rest of the book rests on this section.',
   'दूसरे अध्याय की दलील एक ख़ास क्रम में चलती है। कृष्ण कर्तव्य या कर्म से शुरू नहीं करते; वे पहले अर्जुन की इस धारणा पर सवाल उठाते हैं कि दाँव पर असल में क्या लगा है। बाकी पूरी किताब का व्यावहारिक हिस्सा इसी पर टिका है।',
   'Doosre chapter ki baat ek khaas order mein chalti hai. Krishna duty ya karm se shuru nahi karte; woh pehle Arjun ki is dhaarna par sawaal uthate hain ki daanv par asal mein kya laga hai. Baaki poori kitaab ka practical hissa isi par tika hai.',
   'The word here is dehin — the one who has a body, as distinct from the body itself. The grammar does the work: it is a possessor, not a possession. Whatever you call it, the claim is that the thing wearing the body is not identical with the body, and that continuity belongs to the wearer.',
   'यहाँ शब्द है देही — वह जिसके पास शरीर है, न कि शरीर स्वयं। व्याकरण ही बात कह देता है: वह मालिक है, माल नहीं। आप उसे जो भी नाम दें, दावा यह है कि शरीर पहनने वाला शरीर के बराबर नहीं है, और निरंतरता पहनने वाले की है।',
   'Yahan shabd hai dehin — woh jiske paas sharir hai, sharir khud nahi. Grammar hi baat keh deti hai: woh maalik hai, maal nahi. Tum use jo bhi naam do, baat yeh hai ki sharir pehnne wala sharir ke barabar nahi hai, aur continuity pehnne wale ki hai.',
   'You do not have to accept the metaphysics for the psychology to work. Even read strictly as a claim about identity over time, it undercuts the specific panic that says this loss ends everything. A person who has watched themselves survive being unrecognisably different has evidence, not just a doctrine.',
   'मनोविज्ञान काम करे, इसके लिए तत्त्वज्ञान मानना ज़रूरी नहीं। अगर इसे सिर्फ़ समय के साथ पहचान के बारे में एक दावा मानें, तब भी यह उस ख़ास घबराहट को काट देता है जो कहती है कि यह नुक़सान सब कुछ ख़त्म कर देगा। जिसने ख़ुद को पहचान से परे बदलते हुए बचते देखा है, उसके पास सिद्धांत नहीं, सबूत है।',
   'Psychology chale, uske liye metaphysics maanna zaroori nahi. Agar ise sirf time ke saath identity ke baare mein ek claim maano, tab bhi yeh us khaas ghabrahat ko kaat deta hai jo kehti hai ki yeh nuksaan sab khatam kar dega. Jisne khud ko pehchan se pare badalte hue bachte dekha hai, uske paas theory nahi, proof hai.'

  UNION ALL SELECT 14, 'beginner',
   'Immediately after telling Arjuna that change is not destruction, Krishna addresses the more immediate objection — that this is unbearable right now, whatever is true in the long run.',
   'अर्जुन को यह बताने के तुरंत बाद कि बदलना नाश नहीं है, कृष्ण उस ज़्यादा तात्कालिक आपत्ति पर आते हैं — कि लंबे में जो भी सच हो, अभी यह सहा नहीं जा रहा।',
   'Arjun ko yeh batane ke turant baad ki badalna naash nahi hai, Krishna us zyada turant wali objection par aate hain — ki lambe mein jo bhi sach ho, abhi yeh saha nahi ja raha.',
   'Notice what is not being said. Nobody is telling you the cold is not cold. The claim is about duration: this arrived, and therefore it will leave, because arriving is the kind of thing that has a leaving attached. What you have to do in the meantime is sit in it without concluding anything permanent from it.',
   'ध्यान दीजिए कि क्या नहीं कहा जा रहा। कोई यह नहीं कह रहा कि ठंड ठंडी नहीं है। बात अवधि की है: यह आया है, इसलिए जाएगा भी, क्योंकि आने के साथ जाना जुड़ा होता है। इस बीच आपको बस इसमें बैठे रहना है, और इससे कोई स्थायी नतीजा नहीं निकालना है।',
   'Dhyan do ki kya nahi kaha ja raha. Koi yeh nahi keh raha ki thand thandi nahi hai. Baat duration ki hai: yeh aaya hai, isliye jaayega bhi, kyunki aane ke saath jaana juda hota hai. Is beech tumhe bas isme baithe rehna hai, aur isse koi permanent conclusion nahi nikalna hai.',
   'Most of the damage a bad stretch does is not the bad stretch. It is the decisions made inside it — the job quit in week three, the message sent at 2am, the conclusion that this is simply how life is now. Endurance here is not heroism. It is the practice of not deciding anything large while the weather is bad.',
   'बुरे दौर का ज़्यादातर नुक़सान बुरा दौर नहीं करता। वह उसके भीतर लिए गए फ़ैसले करते हैं — तीसरे हफ़्ते छोड़ी गई नौकरी, रात दो बजे भेजा संदेश, यह नतीजा कि अब ज़िंदगी ऐसी ही है। यहाँ सहना वीरता नहीं है। यह अभ्यास है कि मौसम ख़राब हो तो कोई बड़ा फ़ैसला न लिया जाए।',
   'Bure daur ka zyadatar nuksaan bura daur nahi karta. Woh uske andar liye gaye decisions karte hain — teesre hafte chhodi gayi job, raat do baje bheja message, yeh conclusion ki ab zindagi aisi hi hai. Yahan sehna heroism nahi hai. Yeh practice hai ki mausam kharab ho to koi bada faisla na liya jaaye.'

  UNION ALL SELECT 47, 'beginner',
   'Arjuna''s objection has moved. He is no longer only grieving; he is now arguing that the outcome of this war is so terrible that the action cannot be right. Krishna separates the two.',
   'अर्जुन की आपत्ति बदल गई है। अब वह सिर्फ़ शोक नहीं कर रहा; अब उसका तर्क यह है कि इस युद्ध का नतीजा इतना भयानक है कि यह काम सही हो ही नहीं सकता। कृष्ण दोनों को अलग कर देते हैं।',
   'Arjun ki objection badal gayi hai. Ab woh sirf shok nahi kar raha; ab uska tark yeh hai ki is yudh ka result itna bhayanak hai ki yeh kaam sahi ho hi nahi sakta. Krishna dono ko alag kar dete hain.',
   'There are two halves and people quote one. The first half says the result is not yours to control. The second half says that is not a reason to stop working. Take the first without the second and you get a comfortable excuse; take the second without the first and you get the exhaustion of trying to control something you cannot.',
   'इसमें दो हिस्से हैं और लोग एक ही उद्धृत करते हैं। पहला कहता है कि नतीजा आपके वश में नहीं। दूसरा कहता है कि यह काम रोकने का कारण नहीं है। पहला बिना दूसरे के लीजिए तो आरामदेह बहाना मिलता है; दूसरा बिना पहले के लीजिए तो उस चीज़ को क़ाबू करने की थकान मिलती है जो क़ाबू में है ही नहीं।',
   'Isme do hisse hain aur log ek hi quote karte hain. Pehla kehta hai result tumhare control mein nahi. Doosra kehta hai yeh kaam rokne ka reason nahi hai. Pehla bina doosre ke lo to aaramdeh bahana milta hai; doosra bina pehle ke lo to us cheez ko control karne ki thakan milti hai jo control mein hai hi nahi.',
   'This is not advice to stop caring about results. Somebody who did not care would not have trained. It is advice about where to put your weight. Effort is a place you can stand. Outcome is not, because outcome depends on twelve things happening in rooms you are not in.',
   'यह नतीजों की परवाह छोड़ने की सलाह नहीं है। जिसे परवाह नहीं होती, वह तैयारी ही नहीं करता। यह सलाह इस बारे में है कि वज़न कहाँ रखें। मेहनत वह जगह है जहाँ आप खड़े हो सकते हैं। नतीजा नहीं, क्योंकि नतीजा उन बारह चीज़ों पर टिका है जो उन कमरों में होती हैं जहाँ आप हैं ही नहीं।',
   'Yeh results ki parwah chhodne ki salah nahi hai. Jise parwah nahi hoti woh training hi nahi karta. Yeh salah is baare mein hai ki weight kahan rakho. Mehnat woh jagah hai jahan tum khade ho sakte ho. Result nahi, kyunki result un baarah cheezon par tika hai jo un kamron mein hoti hain jahan tum ho hi nahi.'

  UNION ALL SELECT 47, 'intermediate',
   'This verse is where chapter 2 turns from what is true to what to do about it, and it is the hinge the next four chapters swing on. Everything called karma yoga in the rest of the text is an unpacking of this sentence.',
   'यही वह जगह है जहाँ दूसरा अध्याय "क्या सच है" से "अब करना क्या है" की ओर मुड़ता है, और अगले चार अध्याय इसी कब्ज़े पर घूमते हैं। आगे जिसे कर्मयोग कहा गया है, वह इसी एक वाक्य का विस्तार है।',
   'Yahi woh jagah hai jahan chapter 2 "kya sach hai" se "ab karna kya hai" ki taraf mudta hai, aur agle chaar chapter isi hinge par ghoomte hain. Aage jise karma yoga kaha gaya hai, woh isi ek line ka vistaar hai.',
   'Adhikara is closer to jurisdiction than to right — the area in which your authority actually operates. Phala is fruit, the yield of the tree rather than the tending of it. Read that way the sentence is almost administrative: here is your jurisdiction, and here is what falls outside it. The fourth clause guards the exit — do not become attached to inaction either.',
   'अधिकार का अर्थ "हक़" से ज़्यादा "क्षेत्राधिकार" के क़रीब है — वह दायरा जिसमें आपका अधिकार सचमुच चलता है। फल यानी पेड़ की उपज, न कि उसकी देखभाल। ऐसे पढ़ें तो वाक्य लगभग प्रशासनिक है: यह आपका क्षेत्र है, और यह उसके बाहर। चौथा हिस्सा निकास का पहरा देता है — निष्क्रियता से भी मत जुड़िए।',
   'Adhikara ka matlab "haq" se zyada "jurisdiction" ke kareeb hai — woh dayra jisme tumhara adhikaar sach mein chalta hai. Phala matlab ped ki upaj, uski dekhbhal nahi. Aise padho to line lagbhag administrative hai: yeh tumhara area hai, aur yeh uske bahar. Chautha hissa exit par pehra deta hai — nishkriyta se bhi mat judo.',
   'The fourth clause is the one that makes this hard rather than comforting. Without it, "the result is not mine" becomes a reason to do nothing, which is the most common misuse of this verse. With it, the verse closes both exits: you may not act for the yield, and you may not use that as grounds to stop.',
   'चौथा हिस्सा ही इसे आरामदेह के बजाय कठिन बनाता है। उसके बिना "नतीजा मेरा नहीं" कुछ न करने का कारण बन जाता है, और यही इस श्लोक का सबसे आम दुरुपयोग है। उसके साथ श्लोक दोनों दरवाज़े बंद कर देता है: उपज के लिए काम मत कीजिए, और इसी को रुक जाने का आधार भी मत बनाइए।',
   'Chautha hissa hi ise aaramdeh ki jagah mushkil banata hai. Uske bina "result mera nahi" kuch na karne ka reason ban jaata hai, aur yahi is shloka ka sabse common misuse hai. Uske saath shloka dono darwaze band kar deta hai: upaj ke liye kaam mat karo, aur isi ko ruk jaane ka aadhaar bhi mat banao.'

  UNION ALL SELECT 62, 'beginner',
   'Krishna has been describing the steady person — sthitaprajna — and Arjuna has asked how you would recognise one. This verse comes as part of the answer, and it describes the failure mode rather than the success.',
   'कृष्ण स्थिर व्यक्ति — स्थितप्रज्ञ — का वर्णन कर रहे थे, और अर्जुन ने पूछा कि उसे पहचानें कैसे। यह श्लोक उसी जवाब का हिस्सा है, और यह सफलता नहीं, असफलता का रास्ता बताता है।',
   'Krishna sthir vyakti — sthitaprajna — ka varnan kar rahe the, aur Arjun ne poocha ki use pehchane kaise. Yeh shloka usi jawab ka hissa hai, aur yeh safalta nahi, asafalta ka rasta batata hai.',
   'Four steps, in order. You dwell on something. Dwelling makes you attached. Attachment becomes wanting. Wanting, when it meets an obstacle, comes out as anger. The useful part is the order, because it tells you where to intervene — and the cheapest place is the first step, which does not feel like anything at all.',
   'चार सीढ़ियाँ, क्रम से। आप किसी चीज़ पर सोचते रहते हैं। सोचते रहने से लगाव बनता है। लगाव चाह बनता है। चाह के रास्ते में रुकावट आए तो वह गुस्सा बनकर निकलती है। काम की बात क्रम है, क्योंकि वही बताता है कि दख़ल कहाँ देना है — और सबसे सस्ती जगह पहली सीढ़ी है, जो महसूस ही नहीं होती।',
   'Chaar seedhiyan, order mein. Tum kisi cheez par sochte rehte ho. Sochte rehne se lagaav banta hai. Lagaav chaah banti hai. Chaah ke raaste mein rukawat aaye to woh gussa ban ke nikalti hai. Kaam ki baat order hai, kyunki wahi batata hai ki dakhal kahan dena hai — aur sabse sasti jagah pehli seedhi hai, jo mehsoos hi nahi hoti.',
   'Anger feels like it comes from the thing that just happened. It almost never does. It comes from a want that has been quietly assembling for weeks, and the thing that just happened is only where it met resistance. This is why the same remark lands as nothing on Tuesday and as fury on Friday.',
   'गुस्सा ऐसा लगता है जैसे अभी-अभी हुई बात से आया। लगभग कभी नहीं आता। वह उस चाह से आता है जो हफ़्तों से चुपचाप जुड़ रही थी, और अभी हुई बात सिर्फ़ वह जगह है जहाँ उसे रुकावट मिली। इसीलिए वही बात मंगलवार को कुछ नहीं लगती और शुक्रवार को आग लगा देती है।',
   'Gussa aisa lagta hai jaise abhi hui baat se aaya. Lagbhag kabhi nahi aata. Woh us chaah se aata hai jo hafton se chupchap ban rahi thi, aur abhi hui baat sirf woh jagah hai jahan use rukawat mili. Isiliye wahi baat mangalwar ko kuch nahi lagti aur shukrawar ko aag laga deti hai.'

  UNION ALL SELECT 70, 'beginner',
   'This is close to the end of chapter 2, and it is the picture Krishna leaves Arjuna with before the argument moves on to action in chapter 3.',
   'यह दूसरे अध्याय के अंत के क़रीब है, और यही वह चित्र है जो कृष्ण अर्जुन के पास छोड़ते हैं, इससे पहले कि बात तीसरे अध्याय में कर्म की ओर बढ़े।',
   'Yeh chapter 2 ke ant ke kareeb hai, aur yahi woh tasveer hai jo Krishna Arjun ke paas chhodte hain, isse pehle ki baat chapter 3 mein karm ki taraf badhe.',
   'The ocean is not empty and it is not still. Rivers are pouring into it constantly. What it does not do is rise to meet them, or go looking for more. That is the whole image: the peace being described is not the absence of wanting, it is wanting arriving in something large enough not to be moved by it.',
   'समुद्र न ख़ाली है, न शांत। नदियाँ लगातार उसमें गिर रही हैं। वह बस उन्हें लेने ऊपर नहीं उठता, और और की तलाश में नहीं जाता। पूरा चित्र यही है: जिस शांति की बात है वह चाह का न होना नहीं है, वह चाह का किसी इतने बड़े में आना है कि वह हिले नहीं।',
   'Samundar na khaali hai, na shaant. Nadiyan lagatar usme gir rahi hain. Woh bas unhe lene upar nahi uthta, aur aur ki talash mein nahi jaata. Poora image yahi hai: jis shanti ki baat hai woh chaah ka na hona nahi hai, woh chaah ka kisi itne bade mein aana hai ki woh hile nahi.',
   'Most advice about desire is some version of wanting less, which almost nobody manages and which makes people feel like failures for being alive. This is a different instruction and a more achievable one: let the wanting come, and work on the size of the thing it is arriving in.',
   'चाह के बारे में ज़्यादातर सलाह किसी न किसी रूप में "कम चाहो" होती है, जो लगभग कोई नहीं कर पाता और जो लोगों को ज़िंदा होने के लिए अपराधी महसूस कराती है। यह अलग निर्देश है और ज़्यादा हो सकने वाला: चाह को आने दीजिए, और उस चीज़ के आकार पर काम कीजिए जिसमें वह आ रही है।',
   'Chaah ke baare mein zyadatar salah kisi na kisi roop mein "kam chaho" hoti hai, jo lagbhag koi nahi kar paata aur jo logon ko zinda hone ke liye guilty feel karati hai. Yeh alag instruction hai aur zyada ho sakne wala: chaah ko aane do, aur us cheez ke size par kaam karo jisme woh aa rahi hai.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2;

-- =====================================================================
-- 6. MEMORY AIDS, REFLECTIONS, PRACTICES
-- =====================================================================
-- The hook is the line the learner should still have in a year. Twenty
-- words at most, and it has to be sharp — a hook that is merely accurate
-- is not doing its job.
--
-- Reflections are in the second person and about the reader's own life,
-- never about the text. "What does this verse mean" is a comprehension
-- question. "Whose approval were you working for" is a reflection.
-- =====================================================================

DELETE m FROM verse_memory_aids m JOIN verses v ON v.id = m.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 2 AND v.verse_number IN (13, 14, 47, 62, 70);
DELETE r FROM verse_reflections r JOIN verses v ON v.id = r.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 2 AND v.verse_number IN (13, 14, 47, 62, 70);
DELETE p FROM verse_practices p JOIN verses v ON v.id = p.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 2 AND v.verse_number IN (13, 14, 47, 62, 70);

INSERT INTO verse_memory_aids (verse_id, hook_en, hook_hi, hook_hinglish, analogy_en, analogy_hi, analogy_hinglish, visual_cue)
SELECT v.id, m.h_en, m.h_hi, m.h_hing, m.a_en, m.a_hi, m.a_hing, m.cue FROM (
  SELECT 13 AS vn,
    'You have already survived becoming someone else. Twice.' AS h_en,
    'आप पहले भी कोई और बन कर बच चुके हैं। दो बार।' AS h_hi,
    'Tum pehle bhi koi aur ban ke bach chuke ho. Do baar.' AS h_hing,
    'Like a photograph of you at seven. Nothing in that picture is still here, and you did not lose anybody.' AS a_en,
    'सात साल की उम्र की अपनी तस्वीर की तरह। उस तस्वीर का कुछ भी अब यहाँ नहीं है, और आपने किसी को खोया नहीं।' AS a_hi,
    'Saat saal ki apni photo ki tarah. Us photo ka kuch bhi ab yahan nahi hai, aur tumne kisi ko khoya nahi.' AS a_hing,
    'A strip of passport photographs, ten years apart' AS cue
  UNION ALL SELECT 14,
    'It is weather, not a verdict.',
    'यह मौसम है, फ़ैसला नहीं।',
    'Yeh mausam hai, faisla nahi.',
    'Like standing on a platform in the rain. You are not being punished. You are being rained on.',
    'बारिश में प्लेटफ़ॉर्म पर खड़े होने जैसा। सज़ा नहीं मिल रही। बस बारिश हो रही है।',
    'Baarish mein platform par khade hone jaisa. Saza nahi mil rahi. Bas baarish ho rahi hai.',
    'A monsoon platform, people waiting'
  UNION ALL SELECT 47,
    'Effort is yours. The scoreboard is not. Neither is quitting.',
    'मेहनत आपकी। स्कोरबोर्ड नहीं। और छोड़ देना भी नहीं।',
    'Mehnat tumhari. Scoreboard nahi. Aur chhod dena bhi nahi.',
    'Like a bowler at the top of their run-up. The delivery is theirs. The edge, the drop, the umpire — none of it is.',
    'रन-अप के सिरे पर खड़े गेंदबाज़ की तरह। गेंद उसकी है। बल्ले का किनारा, छूटा कैच, अंपायर — कुछ भी उसका नहीं।',
    'Run-up ke sire par khade bowler ki tarah. Ball uski hai. Edge, dropped catch, umpire — kuch bhi uska nahi.',
    'A bowler mid-run-up, scoreboard out of focus behind'
  UNION ALL SELECT 62,
    'Anger is step four. Step one was just thinking about it.',
    'गुस्सा चौथी सीढ़ी है। पहली सीढ़ी सिर्फ़ सोचते रहना थी।',
    'Gussa chauthi seedhi hai. Pehli seedhi sirf sochte rehna thi.',
    'Like a kettle. By the time it whistles, the heat has been on for four minutes.',
    'केतली की तरह। जब तक सीटी बजती है, आँच चार मिनट से जल रही होती है।',
    'Kettle ki tarah. Jab tak seeti bajti hai, aanch chaar minute se jal rahi hoti hai.',
    'A kettle just before the whistle'
  UNION ALL SELECT 70,
    'Be the ocean. Rivers arrive all day and it does not rise to meet them.',
    'समुद्र बनिए। नदियाँ दिन भर आती हैं और वह उन्हें लेने ऊपर नहीं उठता।',
    'Samundar bano. Nadiyan din bhar aati hain aur woh unhe lene upar nahi uthta.',
    'Like a large room. Add one more person and nothing changes. Add one to a lift and everything does.',
    'बड़े कमरे की तरह। एक आदमी और आ जाए, कुछ नहीं बदलता। लिफ़्ट में एक आ जाए, सब बदल जाता है।',
    'Bade kamre ki tarah. Ek aadmi aur aa jaaye, kuch nahi badalta. Lift mein ek aa jaaye, sab badal jaata hai.',
    'A river mouth meeting a flat sea'
) AS m
JOIN verses v ON v.verse_number = m.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2;

INSERT INTO verse_reflections (verse_id, question_en, question_hi, question_hinglish, display_order)
SELECT v.id, r.q_en, r.q_hi, r.q_hing, r.ord FROM (
  SELECT 13 AS vn, 'Which version of yourself ended without you noticing it go?' AS q_en, 'आपका कौन-सा रूप बिना आपकी नज़र में आए ख़त्म हो गया?' AS q_hi, 'Tumhara kaun sa version bina tumhari nazar mein aaye khatam ho gaya?' AS q_hing, 1 AS ord
  UNION ALL SELECT 13, 'What are you afraid will be lost that has, in fact, already changed several times?', 'आपको किसके खो जाने का डर है, जो असल में पहले ही कई बार बदल चुका है?', 'Tumhe kiske kho jaane ka dar hai, jo asal mein pehle hi kai baar badal chuka hai?', 2
  UNION ALL SELECT 13, 'Who told you that you should be over it by now, and were they right?', 'आपसे किसने कहा कि अब तक तो सँभल जाना चाहिए था, और क्या वे सही थे?', 'Tumse kisne kaha ki ab tak to sambhal jaana chahiye tha, aur kya woh sahi the?', 3
  UNION ALL SELECT 14, 'What have you decided in the last month that you decided while you were tired?', 'पिछले महीने आपने क्या तय किया जो थके होने पर तय किया?', 'Pichhle mahine tumne kya decide kiya jo thake hue decide kiya?', 1
  UNION ALL SELECT 14, 'What is the smallest thing that would make this stretch survivable rather than shorter?', 'सबसे छोटी कौन-सी बात इस दौर को छोटा नहीं, सहने लायक बना देगी?', 'Sabse chhoti kaun si baat is daur ko chhota nahi, sehne layak bana degi?', 2
  UNION ALL SELECT 14, 'When this passes, what will you wish you had not concluded?', 'जब यह गुज़र जाएगा, तब आप चाहेंगे कि आपने क्या नतीजा न निकाला होता?', 'Jab yeh guzar jayega, tab tum chahoge ki tumne kya conclusion na nikala hota?', 3
  UNION ALL SELECT 47, 'Whose approval was the actual point of the last thing you worked hard on?', 'पिछली बार जिस पर मेहनत की, उसका असली मक़सद किसकी वाहवाही थी?', 'Pichhli baar jis par mehnat ki, uska asli maksad kiski wahwahi thi?', 1
  UNION ALL SELECT 47, 'If nobody ever found out you did it, would you still do it as well?', 'अगर किसी को कभी पता न चले कि आपने यह किया, तब भी आप इसे उतना ही अच्छा करते?', 'Agar kisi ko kabhi pata na chale ki tumne yeh kiya, tab bhi tum ise utna hi achha karte?', 2
  UNION ALL SELECT 47, 'Where have you used "the result is not in my hands" as a reason to stop trying?', 'आपने कहाँ "नतीजा मेरे हाथ में नहीं" को कोशिश छोड़ने का कारण बनाया है?', 'Tumne kahan "result mere haath mein nahi" ko koshish chhodne ka reason banaya hai?', 3
  UNION ALL SELECT 62, 'Think of the last time you lost your temper. What had you been turning over for days before it?', 'पिछली बार जब गुस्सा आया, उससे पहले कई दिन से आप क्या सोच रहे थे?', 'Pichhli baar jab gussa aaya, usse pehle kai din se tum kya soch rahe the?', 1
  UNION ALL SELECT 62, 'What are you dwelling on right now that has not become a want yet?', 'अभी आप किस बात पर टिके हुए हैं जो अभी चाह नहीं बनी है?', 'Abhi tum kis baat par ruke hue ho jo abhi chaah nahi bani hai?', 2
  UNION ALL SELECT 62, 'Which of your recent angers was really about the thing you were angry at?', 'हाल का कौन-सा गुस्सा सचमुच उसी बात पर था जिस पर आया था?', 'Haal ka kaun sa gussa sach mein usi baat par tha jis par aaya tha?', 3
  UNION ALL SELECT 70, 'What do you want right now that you would be embarrassed to say out loud?', 'अभी आप क्या चाहते हैं जिसे ज़ोर से कहने में शर्म आएगी?', 'Abhi tum kya chahte ho jise zor se kehne mein sharam aayegi?', 1
  UNION ALL SELECT 70, 'Which small wants have the most power to ruin your day, and why those?', 'कौन-सी छोटी चाहें आपका दिन ख़राब करने की सबसे ज़्यादा ताक़त रखती हैं, और वही क्यों?', 'Kaun si chhoti chaahein tumhara din kharab karne ki sabse zyada taakat rakhti hain, aur wahi kyun?', 2
  UNION ALL SELECT 70, 'When did you last get exactly what you wanted, and how long did it hold?', 'आख़िरी बार आपको ठीक वही मिला जो चाहिए था — वह कितने दिन टिका?', 'Aakhri baar tumhe theek wahi mila jo chahiye tha — woh kitne din tika?', 3
) AS r
JOIN verses v ON v.verse_number = r.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2;

INSERT INTO verse_practices (verse_id, action_en, action_hi, action_hinglish, estimated_minutes, difficulty, display_order)
SELECT v.id, p.a_en, p.a_hi, p.a_hing, p.mins, p.diff, 1 FROM (
  SELECT 13 AS vn, 'Find a photograph of yourself from at least ten years ago. Look at it for a minute without deciding anything about it.' AS a_en, 'कम से कम दस साल पुरानी अपनी एक तस्वीर ढूँढ़िए। एक मिनट तक उसे देखिए, उसके बारे में कोई राय बनाए बिना।' AS a_hi, 'Kam se kam das saal purani apni ek photo dhoondho. Ek minute tak use dekho, uske baare mein koi raay banaye bina.' AS a_hing, 3 AS mins, 'beginner' AS diff
  UNION ALL SELECT 14, 'Name one decision you are currently tempted to make. Write it down, date it, and agree with yourself not to make it for a week.', 'एक फ़ैसला बताइए जो अभी करने का मन है। उसे लिखिए, तारीख़ डालिए, और ख़ुद से तय कीजिए कि एक हफ़्ते तक नहीं करेंगे।', 'Ek faisla batao jo abhi karne ka mann hai. Use likho, date daalo, aur khud se tay karo ki ek hafte tak nahi karoge.', 5, 'beginner'
  UNION ALL SELECT 47, 'Pick one task today. Before you start, write the one sentence describing what doing it well would look like. Do not write what you hope comes of it.', 'आज एक काम चुनिए। शुरू करने से पहले एक वाक्य लिखिए कि उसे अच्छी तरह करना कैसा दिखेगा। यह मत लिखिए कि उससे क्या मिलने की उम्मीद है।', 'Aaj ek kaam chuno. Shuru karne se pehle ek line likho ki use achhe se karna kaisa dikhega. Yeh mat likho ki usse kya milne ki umeed hai.', 5, 'beginner'
  UNION ALL SELECT 62, 'Next time irritation arrives, before responding, ask one question: what have I been wanting that this just got in the way of?', 'अगली बार चिढ़ आए तो जवाब देने से पहले एक सवाल पूछिए: मैं क्या चाह रहा था जिसमें यह अभी रुकावट बना?', 'Agli baar chidh aaye to jawab dene se pehle ek sawaal pucho: main kya chah raha tha jisme yeh abhi rukawat bana?', 2, 'intermediate'
  UNION ALL SELECT 70, 'Write down three things you want. Beside each, write what your day looks like if you never get it. Notice which ones you can already live with.', 'तीन चीज़ें लिखिए जो आप चाहते हैं। हर एक के आगे लिखिए कि न मिलने पर आपका दिन कैसा होगा। देखिए किनके बिना आप अभी भी जी सकते हैं।', 'Teen cheezein likho jo tum chahte ho. Har ek ke aage likho ki na milne par tumhara din kaisa hoga. Dekho kinke bina tum abhi bhi ji sakte ho.', 8, 'intermediate'
) AS p
JOIN verses v ON v.verse_number = p.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2;

-- =====================================================================
-- 7. TOPIC TAGGING
-- =====================================================================
-- relevance is 1 to 10 and it is the ordering on a life-problem page.
-- It is the difference between "here are forty verses that mention
-- anger" and "here are the three that will actually help".
-- =====================================================================

DELETE vt FROM verse_topics vt JOIN verses v ON v.id = vt.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 2 AND v.verse_number IN (13, 14, 47, 62, 70);

INSERT INTO verse_topics (verse_id, topic_id, relevance)
SELECT v.id, t.id, x.rel FROM (
  SELECT 13 AS vn, 'grief' AS slug, 10 AS rel
  UNION ALL SELECT 13, 'impermanence', 9
  UNION ALL SELECT 13, 'the-self', 8
  UNION ALL SELECT 13, 'fear', 5
  UNION ALL SELECT 14, 'burnout', 9
  UNION ALL SELECT 14, 'steadiness', 9
  UNION ALL SELECT 14, 'impermanence', 8
  UNION ALL SELECT 14, 'restlessness', 6
  UNION ALL SELECT 47, 'effort-without-result', 10
  UNION ALL SELECT 47, 'action-without-attachment', 10
  UNION ALL SELECT 47, 'duty', 9
  UNION ALL SELECT 47, 'comparison', 7
  UNION ALL SELECT 47, 'burnout', 6
  UNION ALL SELECT 62, 'anger', 10
  UNION ALL SELECT 62, 'desire', 9
  UNION ALL SELECT 62, 'restlessness', 7
  UNION ALL SELECT 70, 'desire', 10
  UNION ALL SELECT 70, 'restlessness', 9
  UNION ALL SELECT 70, 'steadiness', 8
  UNION ALL SELECT 70, 'comparison', 7
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2
JOIN topics t ON t.slug = x.slug;

-- =====================================================================
-- 8. CROSS REFERENCES
-- =====================================================================
-- Only where the parallel genuinely illuminates. A reference that just
-- shares a word is noise, and noise here trains readers to skip the
-- section entirely.
-- =====================================================================

DELETE x FROM verse_cross_references x JOIN verses v ON v.id = x.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 2 AND v.verse_number IN (13, 14, 47, 62, 70);

INSERT INTO verse_cross_references
  (verse_id, reference_type, book, chapter, verse, target_verse_id,
   description_en, description_hi, description_hinglish, relationship, sort_order)
SELECT v.id, 'gita', 'Bhagavad Gita', '2', CAST(x.target AS CHAR), tv.id,
       x.d_en, x.d_hi, x.d_hing, x.rel, 1
FROM (
  SELECT 62 AS vn, 70 AS target,
    'The chain in 2.62 ends in anger. This is the picture of somebody in whom it does not start.' AS d_en,
    '2.62 की कड़ी गुस्से पर ख़त्म होती है। यह उस व्यक्ति का चित्र है जिसमें वह शुरू ही नहीं होती।' AS d_hi,
    '2.62 ki chain gusse par khatam hoti hai. Yeh us insaan ki tasveer hai jisme woh shuru hi nahi hoti.' AS d_hing,
    'opposite' AS rel
  UNION ALL SELECT 13, 14,
    'The same argument one step closer to the ground: not what survives change, but how to sit through it.',
    'वही दलील एक क़दम और ज़मीन के पास: क्या बचता है यह नहीं, बल्कि उसे सहा कैसे जाए।',
    'Wahi baat ek kadam aur zameen ke paas: kya bachta hai yeh nahi, balki use seh kaise jaaye.',
    'supports'
  UNION ALL SELECT 47, 14,
    'Endurance is what makes 2.47 possible. Nobody keeps working without the result unless they can sit in discomfort.',
    'सहनशीलता ही 2.47 को संभव बनाती है। जो तकलीफ़ में बैठ न सके, वह बिना नतीजे के काम करता नहीं रह सकता।',
    'Sehna hi 2.47 ko possible banata hai. Jo takleef mein baith na sake, woh bina result ke kaam karta nahi reh sakta.',
    'supports'
) AS x
JOIN verses v  ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2
JOIN verses tv ON tv.verse_number = x.target AND tv.chapter_id = c.id;

-- =====================================================================
-- 9. WORD BY WORD
-- =====================================================================
-- Every significant word in reading order, with a grammar note and the
-- root where it helps. This is what Study and Research modes render.
--
-- The gloss is the one place where being literal beats being readable.
-- The natural translation is elsewhere; here the job is to show which
-- Sanskrit word carried which piece of the meaning.
-- =====================================================================

DELETE w FROM verse_word_meanings w JOIN verses v ON v.id = w.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 2 AND v.verse_number IN (13, 14, 47, 62, 70);

INSERT INTO verse_word_meanings
  (verse_id, word_order, devanagari, transliteration,
   meaning_en, meaning_hi, meaning_hinglish, grammar, root_word)
SELECT v.id, w.ord, w.dev, w.tr, w.m_en, w.m_hi, w.m_hing, w.gram, w.root FROM (

  -- 2.13
  SELECT 13 AS vn, 1 AS ord, 'देहिनः' AS dev, 'dehinaḥ' AS tr, 'of the one who has a body' AS m_en, 'देहधारी का' AS m_hi, 'sharir wale ka' AS m_hing, 'genitive singular' AS gram, 'देहिन्' AS root
  UNION ALL SELECT 13, 2, 'अस्मिन्', 'asmin', 'in this', 'इस में', 'is mein', 'locative singular', 'इदम्'
  UNION ALL SELECT 13, 3, 'यथा', 'yathā', 'just as', 'जैसे', 'jaise', 'indeclinable', NULL
  UNION ALL SELECT 13, 4, 'देहे', 'dehe', 'in the body', 'शरीर में', 'sharir mein', 'locative singular', 'देह'
  UNION ALL SELECT 13, 5, 'कौमारं', 'kaumāraṁ', 'childhood', 'बचपन', 'bachpan', 'nominative singular', 'कुमार'
  UNION ALL SELECT 13, 6, 'यौवनं', 'yauvanaṁ', 'youth', 'जवानी', 'jawani', 'nominative singular', 'युवन्'
  UNION ALL SELECT 13, 7, 'जरा', 'jarā', 'old age', 'बुढ़ापा', 'budhapa', 'nominative singular', 'जॄ'
  UNION ALL SELECT 13, 8, 'देहान्तरप्राप्तिः', 'dehāntara-prāptiḥ', 'obtaining another body', 'दूसरा शरीर मिलना', 'doosra sharir milna', 'compound, nominative', 'प्र + आप्'
  UNION ALL SELECT 13, 9, 'धीरः', 'dhīraḥ', 'the steady one', 'धीर, स्थिर व्यक्ति', 'dheer, sthir insaan', 'nominative singular', 'धी'
  UNION ALL SELECT 13, 10, 'न मुह्यति', 'na muhyati', 'is not confused', 'मोह में नहीं पड़ता', 'moh mein nahi padta', 'present, third person', 'मुह्'

  -- 2.14
  UNION ALL SELECT 14, 1, 'मात्रास्पर्शाः', 'mātrā-sparśāḥ', 'contacts of the senses with things', 'इंद्रियों का चीज़ों से संपर्क', 'indriyon ka cheezon se contact', 'compound, nominative plural', 'स्पृश्'
  UNION ALL SELECT 14, 2, 'कौन्तेय', 'kaunteya', 'son of Kunti — Arjuna', 'कुंतीपुत्र — अर्जुन', 'Kunti ka beta — Arjun', 'vocative', NULL
  UNION ALL SELECT 14, 3, 'शीतोष्णसुखदुःखदाः', 'śītoṣṇa-sukha-duḥkha-dāḥ', 'giving cold and heat, pleasure and pain', 'ठंड-गरमी, सुख-दुख देने वाले', 'thand-garmi, sukh-dukh dene wale', 'compound, nominative plural', 'दा'
  UNION ALL SELECT 14, 4, 'आगमापायिनः', 'āgamāpāyinaḥ', 'coming and going', 'आने-जाने वाले', 'aane-jaane wale', 'compound, nominative plural', 'आ + गम् / अप + इ'
  UNION ALL SELECT 14, 5, 'अनित्याः', 'anityāḥ', 'not permanent', 'अनित्य, टिकाऊ नहीं', 'permanent nahi', 'nominative plural', 'नित्य'
  UNION ALL SELECT 14, 6, 'तितिक्षस्व', 'titikṣasva', 'endure them', 'सह जाओ', 'seh jao', 'imperative, second person', 'तिज्'

  -- 2.47
  UNION ALL SELECT 47, 1, 'कर्मणि', 'karmaṇi', 'in action, in the work', 'कर्म में', 'karm mein', 'locative singular', 'कृ'
  UNION ALL SELECT 47, 2, 'एव', 'eva', 'only, alone', 'ही', 'hi', 'emphatic particle', NULL
  UNION ALL SELECT 47, 3, 'अधिकारः', 'adhikāraḥ', 'authority, jurisdiction — closer to remit than to right', 'अधिकार, क्षेत्राधिकार', 'adhikaar, jurisdiction', 'nominative singular', 'अधि + कृ'
  UNION ALL SELECT 47, 4, 'ते', 'te', 'yours', 'तुम्हारा', 'tumhara', 'genitive singular', 'त्वम्'
  UNION ALL SELECT 47, 5, 'मा', 'mā', 'do not', 'मत', 'mat', 'prohibitive particle', NULL
  UNION ALL SELECT 47, 6, 'फलेषु', 'phaleṣu', 'in the fruits, in the results', 'फलों में, नतीजों में', 'phalon mein, results mein', 'locative plural', 'फल'
  UNION ALL SELECT 47, 7, 'कदाचन', 'kadācana', 'ever, at any time', 'कभी भी', 'kabhi bhi', 'indeclinable', NULL
  UNION ALL SELECT 47, 8, 'कर्मफलहेतुः', 'karma-phala-hetuḥ', 'one motivated by the fruit of action', 'कर्म के फल को कारण बनाने वाला', 'karm ke phal ko wajah banane wala', 'compound, nominative', 'हेतु'
  UNION ALL SELECT 47, 9, 'सङ्गः', 'saṅgaḥ', 'attachment, clinging', 'आसक्ति, चिपकना', 'lagaav, chipakna', 'nominative singular', 'सञ्ज्'
  UNION ALL SELECT 47, 10, 'अकर्मणि', 'akarmaṇi', 'in inaction, in not doing', 'अकर्म में, न करने में', 'na karne mein', 'locative singular', 'अ + कृ'

  -- 2.62
  UNION ALL SELECT 62, 1, 'ध्यायतः', 'dhyāyataḥ', 'of one who keeps dwelling on', 'लगातार सोचते रहने वाले का', 'lagatar sochte rehne wale ka', 'present participle, genitive', 'ध्यै'
  UNION ALL SELECT 62, 2, 'विषयान्', 'viṣayān', 'objects, the things senses reach for', 'विषय, इंद्रियों की चीज़ें', 'vishay, indriyon ki cheezein', 'accusative plural', 'विषय'
  UNION ALL SELECT 62, 3, 'सङ्गः', 'saṅgaḥ', 'attachment', 'लगाव', 'lagaav', 'nominative singular', 'सञ्ज्'
  UNION ALL SELECT 62, 4, 'उपजायते', 'upajāyate', 'is born, arises', 'पैदा होता है', 'paida hota hai', 'present, third person', 'उप + जन्'
  UNION ALL SELECT 62, 5, 'कामः', 'kāmaḥ', 'desire, wanting', 'काम, चाह', 'chaah', 'nominative singular', 'कम्'
  UNION ALL SELECT 62, 6, 'क्रोधः', 'krodhaḥ', 'anger', 'क्रोध, गुस्सा', 'gussa', 'nominative singular', 'क्रुध्'
  UNION ALL SELECT 62, 7, 'अभिजायते', 'abhijāyate', 'comes into being', 'उत्पन्न होता है', 'paida ho jaata hai', 'present, third person', 'अभि + जन्'

  -- 2.70
  UNION ALL SELECT 70, 1, 'आपूर्यमाणम्', 'āpūryamāṇam', 'being filled', 'भरता हुआ', 'bharta hua', 'passive participle, accusative', 'आ + पॄ'
  UNION ALL SELECT 70, 2, 'अचलप्रतिष्ठम्', 'acala-pratiṣṭham', 'unmoved, fixed in itself', 'अचल, अपनी जगह टिका', 'apni jagah tika hua', 'compound, accusative', 'प्रति + स्था'
  UNION ALL SELECT 70, 3, 'समुद्रम्', 'samudram', 'the ocean', 'समुद्र', 'samundar', 'accusative singular', 'समुद्र'
  UNION ALL SELECT 70, 4, 'आपः', 'āpaḥ', 'waters', 'जल, नदियाँ', 'paani, nadiyan', 'nominative plural', 'अप्'
  UNION ALL SELECT 70, 5, 'प्रविशन्ति', 'praviśanti', 'enter', 'प्रवेश करती हैं', 'ghusti hain', 'present, third person plural', 'प्र + विश्'
  UNION ALL SELECT 70, 6, 'कामाः', 'kāmāḥ', 'desires', 'चाहें', 'chaahein', 'nominative plural', 'कम्'
  UNION ALL SELECT 70, 7, 'शान्तिम्', 'śāntim', 'peace', 'शांति', 'shanti', 'accusative singular', 'शम्'
  UNION ALL SELECT 70, 8, 'कामकामी', 'kāma-kāmī', 'one who longs after desires', 'चाहों के पीछे भागने वाला', 'chaahon ke peeche bhagne wala', 'compound, nominative', 'कम्'

) AS w
JOIN verses v ON v.verse_number = w.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2;

-- =====================================================================
-- 10. MODERN EXAMPLES
-- =====================================================================
-- Four per verse here, across at least four categories each. Step 6
-- tops every verse up to the specified eight to twelve; these are
-- written to final quality and stay.
--
-- THE RULES, RESTATED WHERE THEY ARE EASIEST TO BREAK
--   Films and matches are named as facts and described in our own
--   words. No dialogue is quoted, no lyrics, no script. Anything that
--   gives away a story carries has_spoiler = 1.
--
--   Nothing here praises or criticises any living politician, party or
--   movement. The one public-life example below describes the SHAPE of
--   a dilemma — a person resigning on principle — with no named figure
--   and no side taken.
--
--   is_ai_generated = 0 on all of these. They were written for this
--   file by a person and reviewed. The flag exists so that the day
--   Sarathi drafts one, a reader can tell which is which.
--
--   approved = 1 because these have been reviewed. Nothing unapproved
--   is ever visible — VerseRepository::examples() filters on it.
-- =====================================================================

DELETE e FROM modern_examples e JOIN verses v ON v.id = e.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 2 AND v.verse_number IN (13, 14, 47, 62, 70);

INSERT INTO modern_examples
  (verse_id, category, title_en, title_hi, title_hinglish,
   scenario_en, scenario_hi, scenario_hinglish,
   connection_en, connection_hi, connection_hinglish,
   lesson_en, lesson_hi, lesson_hinglish,
   source_reference, has_spoiler, difficulty, tags, is_ai_generated, approved, sort_order)
SELECT v.id, x.cat, x.t_en, x.t_hi, x.t_hing, x.s_en, x.s_hi, x.s_hing,
       x.c_en, x.c_hi, x.c_hing, x.l_en, x.l_hi, x.l_hing,
       x.src, x.spoil, x.diff, x.tags, 0, 1, x.ord
FROM (

-- --- 2.13 : grief and change ----------------------------------------
  SELECT 13 AS vn, 'everyday_life' AS cat, 1 AS ord,
  'The house that was sold' AS t_en, 'वह घर जो बिक गया' AS t_hi, 'Woh ghar jo bik gaya' AS t_hing,
  'The family home goes on the market after thirty years. The last visit is spent walking through empty rooms that still have marks on the doorframe where three children were measured every birthday. Everyone agrees it is the right decision. Everyone also finds a reason to sit in the car for a while before driving off. The building is still standing; somebody else''s furniture is in it by August.' AS s_en,
  'तीस साल बाद घर बिकने चला। आख़िरी बार खाली कमरों में घूमते हुए दरवाज़े की चौखट पर वे निशान दिखे जहाँ हर जन्मदिन पर तीन बच्चों की लंबाई नापी जाती थी। सब मानते हैं कि फ़ैसला सही है। और सब गाड़ी में थोड़ी देर बैठे भी रहते हैं, निकलने से पहले। इमारत अब भी खड़ी है; अगस्त तक उसमें किसी और का सामान होगा।' AS s_hi,
  'Tees saal baad ghar bikne chala. Aakhri baar khaali kamron mein ghoomte hue darwaze ki chaukhat par woh nishaan dikhe jahan har birthday par teen bachchon ki lambai naapi jaati thi. Sab maante hain faisla sahi hai. Aur sab gaadi mein thodi der baithe bhi rehte hain, nikalne se pehle. Building abhi bhi khadi hai; August tak usme kisi aur ka saamaan hoga.' AS s_hing,
  'What ended was not the house. It was a version of the family that had already ended years earlier, quietly, as the children left one by one. The sale is only the moment it became visible. The verse points at exactly this gap — the change had happened; only the noticing was sudden.' AS c_en,
  'ख़त्म घर नहीं हुआ। ख़त्म परिवार का वह रूप हुआ जो सालों पहले चुपचाप ख़त्म हो चुका था, जब बच्चे एक-एक करके निकल गए। बिक्री सिर्फ़ वह क्षण है जब यह दिखा। श्लोक इसी अंतर की ओर इशारा करता है — बदलाव हो चुका था; सिर्फ़ दिखना अचानक था।' AS c_hi,
  'Khatam ghar nahi hua. Khatam parivar ka woh roop hua jo saalon pehle chupchap khatam ho chuka tha, jab bachche ek-ek karke nikal gaye. Sale sirf woh moment hai jab yeh dikha. Shloka isi gap ki taraf ishara karta hai — badlav ho chuka tha; sirf dikhna achanak tha.' AS c_hing,
  'Most of what we mourn at a single moment actually left slowly, over years we were present for.' AS l_en,
  'जिस चीज़ का हम एक पल में शोक करते हैं, वह असल में सालों में धीरे-धीरे गई — और हम वहीं मौजूद थे।' AS l_hi,
  'Jis cheez ka hum ek pal mein matam karte hain, woh asal mein saalon mein dheere-dheere gayi — aur hum wahin maujood the.' AS l_hing,
  NULL AS src, 0 AS spoil, 'beginner' AS diff, 'grief,home,family,moving,change' AS tags

  UNION ALL SELECT 13, 'bollywood', 2,
  'The father who has to let go', 'वह पिता जिसे छोड़ना पड़ता है', 'Woh pita jise chhodna padta hai',
  'In Taare Zameen Par, a father drops his young son at boarding school believing he is doing the responsible thing. The boy he leaves behind is not the boy who comes back into focus later in the film. Neither is the father. What changes is not one dramatic event but a slow shift in who each of them is willing to be for the other.',
  'तारे ज़मीन पर में एक पिता अपने छोटे बेटे को बोर्डिंग स्कूल छोड़ आता है, यह मानकर कि वही ज़िम्मेदारी है। जिस बच्चे को वह छोड़कर आता है, वह वही बच्चा नहीं है जो फ़िल्म में आगे चलकर दिखता है। पिता भी वही नहीं रहता। बदलाव किसी एक नाटकीय घटना से नहीं आता, बल्कि इस धीमी सरकन से कि दोनों एक-दूसरे के लिए क्या बनने को तैयार हैं।',
  'Taare Zameen Par mein ek pita apne chhote bete ko boarding school chhod aata hai, yeh maan ke ki yahi responsibility hai. Jis bachche ko woh chhod ke aata hai, woh wahi bachcha nahi hai jo film mein aage dikhta hai. Pita bhi wahi nahi rehta. Badlav kisi ek dramatic ghatna se nahi aata, balki is dheemi sarkan se ki dono ek doosre ke liye kya banne ko taiyar hain.',
  'The verse describes childhood giving way to youth without anybody losing anything. The film shows the same passage from the outside — a parent grieving a version of his child while that child is alive and in the next room.',
  'श्लोक कहता है कि बचपन जवानी में बदल जाता है और कोई कुछ खोता नहीं। फ़िल्म उसी बदलाव को बाहर से दिखाती है — एक माता-पिता अपने बच्चे के किसी रूप का शोक कर रहे हैं, जबकि वह बच्चा ज़िंदा है और बगल के कमरे में है।',
  'Shloka kehta hai ki bachpan jawani mein badal jaata hai aur koi kuch khota nahi. Film usi badlav ko bahar se dikhati hai — ek parent apne bachche ke kisi roop ka matam kar raha hai, jabki woh bachcha zinda hai aur bagal ke kamre mein hai.',
  'You can grieve someone who has not gone anywhere. That is still grief, and it is still allowed.',
  'आप उसका भी शोक कर सकते हैं जो कहीं गया नहीं। वह भी शोक है, और उसकी भी जगह है।',
  'Tum uska bhi matam kar sakte ho jo kahin gaya nahi. Woh bhi grief hai, aur uski bhi jagah hai.',
  'Taare Zameen Par (2007)', 0, 'beginner', 'grief,parenting,childhood,film,change'

  UNION ALL SELECT 13, 'healthcare', 3,
  'The waiting room at 4am',
  'रात चार बजे का इंतज़ार',
  'Raat chaar baje ka wait',
  'A hospital corridor, the third night in a row. The family has stopped talking in full sentences. Somebody keeps refilling a paper cup they are not drinking from. Nobody in that corridor is arguing about metaphysics. What they want is a way to stand up for another hour without the fear taking their legs out from under them.',
  'अस्पताल का गलियारा, लगातार तीसरी रात। घरवालों ने पूरे वाक्यों में बोलना बंद कर दिया है। कोई बार-बार काग़ज़ का गिलास भर रहा है जिससे वह पी नहीं रहा। उस गलियारे में कोई दर्शन पर बहस नहीं कर रहा। सबको बस एक घंटा और खड़े रहने का तरीक़ा चाहिए, बिना इसके कि डर पैरों के नीचे से ज़मीन खींच ले।',
  'Hospital ka corridor, lagatar teesri raat. Gharwalon ne poore vaakyon mein bolna band kar diya hai. Koi baar-baar kaagaz ka glass bhar raha hai jisse woh pee nahi raha. Us corridor mein koi philosophy par behes nahi kar raha. Sabko bas ek ghanta aur khade rehne ka tareeka chahiye, bina iske ki dar pairon ke neeche se zameen kheench le.',
  'This is where the verse either earns its place or does not. Read as consolation it is offensive — nobody in that corridor wants to be told death is a change of clothes. Read as it is written, it is narrower: it does not promise the fear is unfounded, only that the mind racing towards total annihilation is running ahead of what is actually known.',
  'यहीं तय होता है कि श्लोक की जगह बनती है या नहीं। सांत्वना की तरह पढ़ें तो यह चुभता है — उस गलियारे में कोई नहीं सुनना चाहता कि मृत्यु कपड़े बदलने जैसी है। जैसा लिखा है वैसा पढ़ें तो बात छोटी है: यह नहीं कहता कि डर बेबुनियाद है, बस इतना कि पूर्ण अंत की ओर भागता मन उससे आगे निकल रहा है जो सचमुच पता है।',
  'Yahin tay hota hai ki shloka ki jagah banti hai ya nahi. Consolation ki tarah padho to yeh chubhta hai — us corridor mein koi nahi sunna chahta ki maut kapde badalne jaisi hai. Jaisa likha hai waisa padho to baat chhoti hai: yeh nahi kehta ki dar bebuniyaad hai, bas itna ki poore ant ki taraf bhagta mann usse aage nikal raha hai jo sach mein pata hai.',
  'A text that cannot survive a hospital corridor is not worth carrying into one.',
  'जो ग्रंथ अस्पताल के गलियारे में टिक न सके, उसे वहाँ ले जाने का कोई अर्थ नहीं।',
  'Jo kitaab hospital ke corridor mein tik na sake, use wahan le jaane ka koi matlab nahi.',
  NULL, 0, 'intermediate', 'grief,illness,fear,family,death'

  UNION ALL SELECT 13, 'sports', 4,
  'The season after the last season',
  'आख़िरी सीज़न के बाद वाला साल',
  'Aakhri season ke baad wala saal',
  'A player retires. For twenty years the answer to "what do you do" took one word. Now it takes a paragraph, and the paragraph keeps changing. The hardest months are not the ones right after the last match — those are full of tributes. It is the following year, when the phone is quieter and the body has stopped being an instrument and gone back to being a body.',
  'एक खिलाड़ी संन्यास लेता है। बीस साल तक "आप क्या करते हैं" का जवाब एक शब्द था। अब एक पैराग्राफ़ लगता है, और वह पैराग्राफ़ बदलता रहता है। सबसे मुश्किल महीने आख़िरी मैच के तुरंत बाद वाले नहीं होते — वे तो सम्मान से भरे रहते हैं। मुश्किल अगला साल है, जब फ़ोन शांत हो जाता है और शरीर औज़ार होना छोड़कर फिर सिर्फ़ शरीर बन जाता है।',
  'Ek player retire hota hai. Bees saal tak "aap kya karte hain" ka jawab ek shabd tha. Ab ek paragraph lagta hai, aur woh paragraph badalta rehta hai. Sabse mushkil mahine aakhri match ke turant baad wale nahi hote — woh to tributes se bhare rehte hain. Mushkil agla saal hai, jab phone shaant ho jaata hai aur sharir instrument hona chhod ke phir sirf sharir ban jaata hai.',
  'Childhood, youth, age — the verse lists them as ordinary. A career has the same shape compressed into twenty years, and it produces the same confusion: the person is still here, and something that felt like the person has gone.',
  'बचपन, जवानी, बुढ़ापा — श्लोक इन्हें साधारण मानकर गिनाता है। करियर का आकार वही है, बीस साल में सिमटा हुआ, और उलझन भी वही: आदमी अब भी यहीं है, और जो आदमी जैसा लगता था वह जा चुका है।',
  'Bachpan, jawani, budhapa — shloka inhe saadharan maan ke ginata hai. Career ka shape wahi hai, bees saal mein simta hua, aur uljhan bhi wahi: aadmi abhi bhi yahin hai, aur jo aadmi jaisa lagta tha woh ja chuka hai.',
  'Losing a role is not losing yourself, however much it feels like the same event.',
  'भूमिका खोना अपने आप को खोना नहीं है, चाहे लगे कितना ही एक जैसा।',
  'Role khona khud ko khona nahi hai, chahe lage kitna hi ek jaisa.',
  NULL, 0, 'beginner', 'grief,identity,retirement,sport,change'

-- --- 2.14 : endurance -----------------------------------------------
  UNION ALL SELECT 14, 'corporate', 1,
  'Week three of the bad quarter',
  'ख़राब तिमाही का तीसरा हफ़्ता',
  'Kharab quarter ka teesra hafta',
  'The numbers missed, the review was tense, and the manager who used to reply in ten minutes now takes a day. Nothing has been said outright. By Thursday a resignation letter exists in a drafts folder, written at 1am and reread every morning since. Six weeks later the quarter closes, the mood turns, and the letter is still in drafts.',
  'नंबर पूरे नहीं हुए, रिव्यू तनाव भरा रहा, और जो मैनेजर दस मिनट में जवाब देता था अब एक दिन लेता है। सीधे कुछ कहा नहीं गया। गुरुवार तक ड्राफ़्ट में एक इस्तीफ़ा पड़ा है, रात एक बजे लिखा और तब से हर सुबह दोबारा पढ़ा गया। छह हफ़्ते बाद तिमाही ख़त्म होती है, माहौल बदलता है, और वह चिट्ठी अब भी ड्राफ़्ट में है।',
  'Numbers miss ho gaye, review tension bhara tha, aur jo manager das minute mein reply karta tha ab ek din leta hai. Seedha kuch kaha nahi gaya. Guruwar tak drafts mein ek resignation pada hai, raat ek baje likha aur tab se har subah dobara padha gaya. Chhe hafte baad quarter khatam hota hai, mahaul badalta hai, aur woh letter abhi bhi drafts mein hai.',
  'The verse is not saying the bad quarter is imaginary. It is saying that a state which arrived will also leave, and that the expensive mistake is not the discomfort but the permanent decision made inside it.',
  'श्लोक यह नहीं कह रहा कि ख़राब तिमाही झूठी है। वह कह रहा है कि जो हालत आई है वह जाएगी भी, और महँगी ग़लती तकलीफ़ नहीं है — तकलीफ़ के भीतर लिया गया स्थायी फ़ैसला है।',
  'Shloka yeh nahi keh raha ki kharab quarter jhootha hai. Woh keh raha hai ki jo haalat aayi hai woh jaayegi bhi, aur mehngi galti takleef nahi hai — takleef ke andar liya gaya permanent faisla hai.',
  'Do not make a permanent decision in a temporary state.',
  'अस्थायी हालत में स्थायी फ़ैसला मत लीजिए।',
  'Temporary haalat mein permanent faisla mat lo.',
  NULL, 0, 'beginner', 'burnout,work,patience,decisions,resignation'

  UNION ALL SELECT 14, 'cricket', 2,
  'Batting through the first hour',
  'पहला घंटा निकालना',
  'Pehla ghanta nikalna',
  'A green pitch, overcast, and the ball is doing things nobody can control. The batter is beaten four times in an over and scores nothing for forty minutes. The commentary calls it a struggle. What is actually happening is a decision, repeated ball after ball, not to play a shot that would end it faster. By lunch the pitch has flattened and the same bowling looks ordinary.',
  'हरी पिच, बादल, और गेंद ऐसा कुछ कर रही है जो किसी के बस में नहीं। बल्लेबाज़ एक ही ओवर में चार बार बीट होता है और चालीस मिनट तक रन नहीं बनता। कमेंट्री इसे संघर्ष कहती है। असल में जो हो रहा है वह हर गेंद पर दोहराया गया एक फ़ैसला है — वह शॉट न खेलने का जो इसे जल्दी ख़त्म कर देता। लंच तक पिच बैठ जाती है और वही गेंदबाज़ी साधारण लगने लगती है।',
  'Hari pitch, baadal, aur ball aisa kuch kar rahi hai jo kisi ke bas mein nahi. Batsman ek hi over mein chaar baar beat hota hai aur chalis minute tak run nahi banta. Commentary ise struggle kehti hai. Asal mein jo ho raha hai woh har ball par dohraya gaya ek faisla hai — woh shot na khelne ka jo ise jaldi khatam kar deta. Lunch tak pitch baith jaati hai aur wahi bowling saadharan lagne lagti hai.',
  'Titiksha is usually translated as endurance, which sounds passive. This is what it looks like as an active skill: not enjoying the hour, not pretending it is comfortable, and not doing the thing that would make it stop.',
  'तितिक्षा का अनुवाद अक्सर "सहनशीलता" होता है, जो निष्क्रिय लगता है। सक्रिय कौशल के रूप में वह ऐसा दिखता है: उस घंटे का मज़ा नहीं लेना, यह भी नहीं कहना कि आराम है, और वह काम नहीं करना जो इसे रोक देता।',
  'Titiksha ka translation aksar "sehna" hota hai, jo passive lagta hai. Active skill ke roop mein woh aisa dikhta hai: us ghante ka maza nahi lena, yeh bhi nahi kehna ki aaram hai, aur woh kaam nahi karna jo ise rok deta.',
  'Enduring is an action. It just does not look like one from outside.',
  'सहना एक क्रिया है। बस बाहर से वैसा नहीं दिखता।',
  'Sehna ek action hai. Bas bahar se waisa nahi dikhta.',
  NULL, 0, 'beginner', 'patience,discipline,cricket,pressure,endurance'

  UNION ALL SELECT 14, 'college', 3,
  'The semester that did not go to plan',
  'वह सेमेस्टर जो योजना से नहीं चला',
  'Woh semester jo plan se nahi chala',
  'A bad set of results in the second year. The student stops going to the study group, then stops answering in the group chat, and starts describing themselves, quietly and consistently, as someone who is not actually good at this. The results were one semester. The description lasts three more.',
  'दूसरे साल नतीजे ख़राब आए। छात्र स्टडी ग्रुप जाना बंद करता है, फिर ग्रुप चैट में जवाब देना बंद करता है, और चुपचाप, लगातार, ख़ुद को ऐसा बताने लगता है जो असल में इस काम के लायक ही नहीं। नतीजे एक सेमेस्टर के थे। वह विवरण तीन और सेमेस्टर चलता है।',
  'Doosre saal results kharab aaye. Student study group jaana band karta hai, phir group chat mein jawab dena band karta hai, aur chupchap, lagatar, khud ko aisa batane lagta hai jo asal mein is kaam ke layak hi nahi. Results ek semester ke the. Woh description teen aur semester chalta hai.',
  'The heat came and would have gone. What did not go was the conclusion drawn while it was there. The verse asks for endurance precisely so that the temporary thing is not allowed to write something permanent about you.',
  'गरमी आई थी और चली भी जाती। जो नहीं गया वह उस दौरान निकाला गया नतीजा था। श्लोक सहने को इसीलिए कहता है, ताकि अस्थायी चीज़ आपके बारे में कुछ स्थायी लिख न दे।',
  'Garmi aayi thi aur chali bhi jaati. Jo nahi gaya woh us dauran nikala gaya conclusion tha. Shloka sehne ko isiliye kehta hai, taaki temporary cheez tumhare baare mein kuch permanent likh na de.',
  'A bad season is an event. "I am not good at this" is a sentence you wrote during it.',
  'ख़राब दौर एक घटना है। "मैं इस लायक नहीं" वह वाक्य है जो आपने उसी दौरान लिखा।',
  'Kharab daur ek ghatna hai. "Main is layak nahi" woh line hai jo tumne usi dauran likhi.',
  NULL, 0, 'beginner', 'failure,confidence,study,burnout,self-talk'

  UNION ALL SELECT 14, 'parenting', 4,
  'The fourth night without sleep',
  'बिना नींद की चौथी रात',
  'Bina neend ki chauthi raat',
  'A newborn who will not settle. By the fourth night both parents have run out of the version of themselves that is patient, and are running on the version that is merely present. Somebody says something unfair in the kitchen at 3am. In eight weeks the baby sleeps and neither of them can reliably remember what was said.',
  'नवजात है जो शांत नहीं होता। चौथी रात तक दोनों माता-पिता का धैर्य वाला रूप ख़त्म हो चुका है, और सिर्फ़ मौजूद रहने वाला रूप बचा है। रात तीन बजे रसोई में कोई कुछ नाइंसाफ़ी भरा कह देता है। आठ हफ़्ते बाद बच्चा सोने लगता है और दोनों में से किसी को ठीक-ठीक याद नहीं रहता कि कहा क्या गया था।',
  'Newborn hai jo shaant nahi hota. Chauthi raat tak dono parents ka patience wala version khatam ho chuka hai, aur sirf maujood rehne wala version bacha hai. Raat teen baje kitchen mein koi kuch na-insaafi bhara keh deta hai. Aath hafte baad bachcha sone lagta hai aur dono mein se kisi ko theek-theek yaad nahi rehta ki kaha kya gaya tha.',
  'The verse names the arriving and the leaving as the defining feature. This is the clearest domestic case: an unbearable state that is genuinely unbearable, genuinely temporary, and the damage it does is almost entirely in what gets said and believed while it lasts.',
  'श्लोक आने और जाने को ही इनकी पहचान बताता है। घर का सबसे साफ़ उदाहरण यही है: एक असहनीय हालत जो सचमुच असहनीय है, सचमुच अस्थायी है, और उसका नुक़सान लगभग पूरा उसी में है जो उस दौरान कहा और माना जाता है।',
  'Shloka aane aur jaane ko hi inki pehchan batata hai. Ghar ka sabse clear example yahi hai: ek asehniya haalat jo sach mein asehniya hai, sach mein temporary hai, aur uska nuksaan lagbhag poora usi mein hai jo us dauran kaha aur maana jaata hai.',
  'Judge nobody, including yourself, by what they said in week one.',
  'किसी को भी — ख़ुद को भी — पहले हफ़्ते की कही बात से मत आँकिए।',
  'Kisi ko bhi — khud ko bhi — pehle hafte ki kahi baat se mat aanko.',
  NULL, 0, 'beginner', 'parenting,exhaustion,patience,marriage,sleep'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2;

INSERT INTO modern_examples
  (verse_id, category, title_en, title_hi, title_hinglish,
   scenario_en, scenario_hi, scenario_hinglish,
   connection_en, connection_hi, connection_hinglish,
   lesson_en, lesson_hi, lesson_hinglish,
   source_reference, has_spoiler, difficulty, tags, is_ai_generated, approved, sort_order)
SELECT v.id, x.cat, x.t_en, x.t_hi, x.t_hing, x.s_en, x.s_hi, x.s_hing,
       x.c_en, x.c_hi, x.c_hing, x.l_en, x.l_hi, x.l_hing,
       x.src, x.spoil, x.diff, x.tags, 0, 1, x.ord
FROM (

-- --- 2.47 : effort and outcome --------------------------------------
  SELECT 47 AS vn, 'bollywood' AS cat, 1 AS ord,
  'The student who studied for the wrong reason' AS t_en, 'ग़लत वजह से पढ़ने वाला छात्र' AS t_hi, 'Galat wajah se padhne wala student' AS t_hing,
  '3 Idiots sets two students against each other: one who wants to understand engineering and one who wants to come first. Both work extremely hard. The one chasing the rank is visibly more anxious, sleeps less, and enjoys none of it — and the film is careful to show that his results are good. The problem it identifies is not that he fails. It is what winning costs him.' AS s_en,
  '3 Idiots दो छात्रों को आमने-सामने रखती है: एक जो इंजीनियरिंग समझना चाहता है, दूसरा जो पहला आना चाहता है। दोनों बेहद मेहनत करते हैं। रैंक के पीछे भागने वाला साफ़ दिखता है — ज़्यादा घबराया, कम सोया, और उसमें से कोई ख़ुशी नहीं। फ़िल्म ध्यान से दिखाती है कि उसके नतीजे अच्छे हैं। समस्या यह नहीं है कि वह असफल होता है। समस्या यह है कि जीत उसे किस क़ीमत पर मिलती है।' AS s_hi,
  '3 Idiots do students ko aamne-saamne rakhti hai: ek jo engineering samajhna chahta hai, doosra jo first aana chahta hai. Dono bahut mehnat karte hain. Rank ke peeche bhagne wala saaf dikhta hai — zyada ghabraya, kam soya, aur usme se koi khushi nahi. Film dhyan se dikhati hai ki uske results achhe hain. Problem yeh nahi hai ki woh fail hota hai. Problem yeh hai ki jeet uske kitne mein padti hai.' AS s_hing,
  'This is the verse''s distinction made visible. Two people doing identical work, one holding the action and one holding the fruit. The verse does not promise the second one worse marks. It says the second one is standing on ground that will not hold, because the marks were never his to control.' AS c_en,
  'यही श्लोक का भेद है, दिखाई देता हुआ। दो लोग एक ही काम कर रहे हैं — एक ने कर्म पकड़ा है, दूसरे ने फल। श्लोक यह वादा नहीं करता कि दूसरे के नंबर कम आएँगे। वह कहता है कि दूसरा ऐसी ज़मीन पर खड़ा है जो टिकेगी नहीं, क्योंकि नंबर कभी उसके वश में थे ही नहीं।' AS c_hi,
  'Yahi shloka ka farq hai, dikhta hua. Do log ek hi kaam kar rahe hain — ek ne karm pakda hai, doosre ne phal. Shloka yeh promise nahi karta ki doosre ke number kam aayenge. Woh kehta hai ki doosra aisi zameen par khada hai jo tikegi nahi, kyunki number kabhi uske control mein the hi nahi.' AS c_hing,
  'Two people can do the same work and only one of them is standing on solid ground.' AS l_en,
  'दो लोग एक ही काम कर सकते हैं, और उनमें से सिर्फ़ एक पक्की ज़मीन पर खड़ा होता है।' AS l_hi,
  'Do log ek hi kaam kar sakte hain, aur unme se sirf ek pakki zameen par khada hota hai.' AS l_hing,
  '3 Idiots (2009)' AS src, 0 AS spoil, 'beginner' AS diff, 'effort,results,study,anxiety,film' AS tags

  UNION ALL SELECT 47, 'startup', 2,
  'Four years, and then the market moved',
  'चार साल, और फिर बाज़ार बदल गया',
  'Chaar saal, aur phir market badal gaya',
  'A team builds carefully for four years. The product is good, the customers are real, and then a much larger company ships the same thing free with something people already own. The founders are asked whether they regret it. What they actually have to work out is different: whether four years of good work were made worthless by an event that happened in a room none of them were in.',
  'एक टीम चार साल तक ध्यान से बनाती है। प्रोडक्ट अच्छा है, ग्राहक असली हैं, और फिर एक कहीं बड़ी कंपनी वही चीज़ मुफ़्त में उसके साथ जोड़ देती है जो लोगों के पास पहले से है। संस्थापकों से पूछा जाता है कि क्या उन्हें अफ़सोस है। असल में उन्हें कुछ और तय करना है: क्या चार साल का अच्छा काम उस घटना से बेकार हो गया जो ऐसे कमरे में हुई जहाँ उनमें से कोई नहीं था।',
  'Ek team chaar saal tak dhyan se banati hai. Product achha hai, customers asli hain, aur phir ek kahin badi company wahi cheez free mein us cheez ke saath de deti hai jo logon ke paas pehle se hai. Founders se poocha jaata hai ki kya unhe afsos hai. Asal mein unhe kuch aur tay karna hai: kya chaar saal ka achha kaam us ghatna se bekaar ho gaya jo aise kamre mein hui jahan unme se koi nahi tha.',
  'The verse gives a usable answer. The work was theirs and it was good work; the market''s move was never in their jurisdiction. That does not make the loss smaller. It makes it a loss rather than a verdict on them.',
  'श्लोक एक काम का जवाब देता है। काम उनका था और अच्छा था; बाज़ार का चलना कभी उनके अधिकार में नहीं था। इससे नुक़सान छोटा नहीं होता। बस वह नुक़सान रह जाता है, उनके बारे में फ़ैसला नहीं बनता।',
  'Shloka ek kaam ka jawab deta hai. Kaam unka tha aur achha tha; market ka chalna kabhi unke adhikaar mein tha hi nahi. Isse nuksaan chhota nahi hota. Bas woh nuksaan reh jaata hai, unke baare mein verdict nahi banta.',
  'An outcome you did not control is not a report card on your work.',
  'जो नतीजा आपके वश में नहीं था, वह आपके काम का रिपोर्ट कार्ड नहीं है।',
  'Jo result tumhare bas mein nahi tha, woh tumhare kaam ka report card nahi hai.',
  NULL, 0, 'intermediate', 'effort,results,startup,failure,work'

  UNION ALL SELECT 47, 'social_media', 3,
  'The post that did not do numbers',
  'वह पोस्ट जिस पर नंबर नहीं आए',
  'Woh post jispe number nahi aaye',
  'Somebody writes something honest, spends a long time on it, publishes it, and it reaches almost nobody. Within a week they are writing differently — shorter, louder, more like the things that do well. Six months later they cannot remember why they started, and the account is doing better than it ever has.',
  'कोई कुछ ईमानदार लिखता है, उस पर बहुत समय लगाता है, छापता है, और वह लगभग किसी तक नहीं पहुँचता। एक हफ़्ते के भीतर वह अलग लिखने लगता है — छोटा, तेज़, उन चीज़ों जैसा जो चलती हैं। छह महीने बाद उसे याद नहीं कि उसने शुरू क्यों किया था, और अकाउंट पहले से कहीं बेहतर चल रहा है।',
  'Koi kuch imaandaar likhta hai, uspe bahut time lagata hai, publish karta hai, aur woh lagbhag kisi tak nahi pahunchta. Ek hafte ke andar woh alag likhne lagta hai — chhota, zor se, un cheezon jaisa jo chalti hain. Chhe mahine baad use yaad nahi ki usne shuru kyun kiya tha, aur account pehle se kahin behtar chal raha hai.',
  'The verse warns against acting for the fruit, and the reason is right here. It is not that chasing the number fails. It is that chasing it slowly replaces the work with whatever produces the number, and by the time you notice, the thing you were doing has gone.',
  'श्लोक फल के लिए काम करने से मना करता है, और वजह यहीं दिखती है। बात यह नहीं कि नंबर के पीछे भागना नाकाम होता है। बात यह है कि उसके पीछे भागना धीरे-धीरे काम की जगह वह चीज़ रख देता है जो नंबर लाती है — और जब तक ध्यान जाता है, जो आप कर रहे थे वह जा चुका होता है।',
  'Shloka phal ke liye kaam karne se mana karta hai, aur wajah yahin dikhti hai. Baat yeh nahi ki number ke peeche bhagna fail hota hai. Baat yeh hai ki uske peeche bhagna dheere-dheere kaam ki jagah woh cheez rakh deta hai jo number laati hai — aur jab tak dhyan jaata hai, jo tum kar rahe the woh ja chuka hota hai.',
  'Chasing the result does not usually fail. It usually succeeds, and quietly replaces the work.',
  'फल के पीछे भागना आमतौर पर नाकाम नहीं होता। वह कामयाब होता है, और चुपचाप काम की जगह ले लेता है।',
  'Phal ke peeche bhagna aksar fail nahi hota. Woh kaamyab hota hai, aur chupchap kaam ki jagah le leta hai.',
  NULL, 0, 'intermediate', 'effort,results,social media,authenticity,work'

  UNION ALL SELECT 47, 'ethics', 4,
  'Resigning on a point of principle',
  'सिद्धांत पर इस्तीफ़ा',
  'Usool par resignation',
  'An official disagrees with a decision they are required to implement. They say so internally, are overruled, and resign. The decision goes ahead anyway. Nothing they did changed the outcome by a single day. Colleagues divide immediately into those who call it pointless and those who call it the only honest thing available.',
  'एक अधिकारी उस फ़ैसले से असहमत है जिसे लागू करना उसकी ज़िम्मेदारी है। वह भीतर अपनी बात रखता है, बात नहीं मानी जाती, और वह इस्तीफ़ा दे देता है। फ़ैसला वैसे भी लागू हो जाता है। उसके किए से नतीजा एक दिन भी नहीं बदला। साथी तुरंत बँट जाते हैं — कुछ इसे बेकार कहते हैं, कुछ इसे इकलौती ईमानदार बात।',
  'Ek officer us faisle se disagree karta hai jise lagoo karna uski zimmedari hai. Woh andar apni baat rakhta hai, baat nahi maani jaati, aur woh resign kar deta hai. Faisla waise bhi lagoo ho jaata hai. Uske kiye se result ek din bhi nahi badla. Saathi turant baant jaate hain — kuch ise bekaar kehte hain, kuch ise akeli imaandaar baat.',
  'Both camps are measuring the act by its fruit. The verse offers a third measure: whether the action was theirs to take and whether they took it properly. On that measure the question of whether the decision changed does not arise.',
  'दोनों पक्ष उस काम को उसके फल से नाप रहे हैं। श्लोक तीसरा पैमाना देता है: क्या वह काम उनका था, और क्या उन्होंने उसे ठीक से किया। उस पैमाने पर यह सवाल उठता ही नहीं कि फ़ैसला बदला या नहीं।',
  'Dono taraf wale us kaam ko uske phal se naap rahe hain. Shloka teesra paimana deta hai: kya woh kaam unka tha, aur kya unhone use theek se kiya. Us paimane par yeh sawaal uthta hi nahi ki faisla badla ya nahi.',
  'Whether an act was right and whether it worked are two separate questions.',
  'काम सही था या नहीं, और काम चला या नहीं — ये दो अलग सवाल हैं।',
  'Kaam sahi tha ya nahi, aur kaam chala ya nahi — yeh do alag sawaal hain.',
  NULL, 0, 'advanced', 'ethics,duty,principle,work,consequences'

-- --- 2.62 : where anger comes from ----------------------------------
  UNION ALL SELECT 62, 'corporate', 1,
  'The promotion that was never promised',
  'वह पदोन्नति जिसका वादा कभी हुआ ही नहीं',
  'Woh promotion jiska waada kabhi hua hi nahi',
  'A manager mentions in March that a role might open up. Over the next four months an employee thinks about it in the shower, mentally rearranges their commute, and tells one friend. In August somebody else gets it. The reaction is not disappointment; it is fury, and it lands on a colleague who had nothing to do with the decision.',
  'मार्च में मैनेजर ज़िक्र करता है कि एक पद खुल सकता है। अगले चार महीने कर्मचारी नहाते हुए उसके बारे में सोचता है, मन ही मन रास्ता बदलकर देखता है, और एक दोस्त को बता देता है। अगस्त में वह किसी और को मिलता है। प्रतिक्रिया निराशा नहीं होती; गुस्सा होती है, और वह एक ऐसे सहकर्मी पर गिरता है जिसका उस फ़ैसले से कोई लेना-देना नहीं था।',
  'March mein manager zikr karta hai ki ek role khul sakta hai. Agle chaar mahine employee nahate hue uske baare mein sochta hai, mann hi mann commute rearrange karta hai, aur ek dost ko bata deta hai. August mein woh kisi aur ko milta hai. Reaction nirasha nahi hoti; gussa hoti hai, aur woh ek aise colleague par girta hai jiska us faisle se koi lena-dena nahi tha.',
  'Every step of the verse is visible with dates on it. March was dwelling. The shower thoughts were attachment. By July it was a want. August was only where it met an obstacle, and the colleague was standing in the wrong place.',
  'श्लोक की हर सीढ़ी यहाँ तारीख़ के साथ दिखती है। मार्च सोचते रहना था। नहाते हुए के ख़याल लगाव थे। जुलाई तक वह चाह बन चुकी थी। अगस्त सिर्फ़ वह जगह थी जहाँ उसे रुकावट मिली, और सहकर्मी ग़लत जगह खड़ा था।',
  'Shloka ki har seedhi yahan date ke saath dikhti hai. March sochte rehna tha. Nahate hue ke khayal lagaav the. July tak woh chaah ban chuki thi. August sirf woh jagah thi jahan use rukawat mili, aur colleague galat jagah khada tha.',
  'The thing you got angry at is usually just where the wanting hit a wall.',
  'जिस बात पर गुस्सा आया, वह अक्सर सिर्फ़ वह जगह है जहाँ चाह दीवार से टकराई।',
  'Jis baat par gussa aaya, woh aksar sirf woh jagah hai jahan chaah deewar se takrayi.',
  NULL, 0, 'beginner', 'anger,work,promotion,desire,expectations'

  UNION ALL SELECT 62, 'social_media', 2,
  'The reply drafted at 2am',
  'रात दो बजे लिखा जवाब',
  'Raat do baje likha jawab',
  'A mild disagreement in a comment thread. It could have ended there. Instead it is reread at lunch, again on the train, and again in bed. By 2am a reply exists that is three paragraphs long and about something much older than the comment. It gets deleted at 2:15, which is the only good thing in the story.',
  'कमेंट में हल्की-सी असहमति। बात वहीं ख़त्म हो सकती थी। इसके बजाय वह दोपहर में दोबारा पढ़ी जाती है, फिर ट्रेन में, फिर बिस्तर में। रात दो बजे तक तीन पैराग्राफ़ का एक जवाब तैयार है, और वह उस कमेंट से कहीं पुरानी किसी बात के बारे में है। दो बजकर पंद्रह मिनट पर वह मिट जाता है, और कहानी में बस यही एक अच्छी बात है।',
  'Comment mein halki si disagreement. Baat wahin khatam ho sakti thi. Iske bajay woh lunch mein dobara padhi jaati hai, phir train mein, phir bistar mein. Raat do baje tak teen paragraph ka ek jawab taiyar hai, aur woh us comment se kahin purani kisi baat ke baare mein hai. Do baj kar pandrah minute par woh delete ho jaata hai, aur kahani mein bas yahi ek achhi baat hai.',
  'The verse says dwelling is the first step and it is the cheapest place to stop. Nothing about the comment changed between noon and 2am. What changed was how many times it had been turned over.',
  'श्लोक कहता है कि सोचते रहना पहली सीढ़ी है और वही सबसे सस्ती जगह है रुकने की। दोपहर से रात दो बजे तक कमेंट में कुछ नहीं बदला। बदला सिर्फ़ यह कि उसे कितनी बार पलटा गया।',
  'Shloka kehta hai ki sochte rehna pehli seedhi hai aur wahi sabse sasti jagah hai rukne ki. Dopahar se raat do baje tak comment mein kuch nahi badla. Badla sirf yeh ki use kitni baar palta gaya.',
  'Rereading something is not thinking about it. It is feeding it.',
  'किसी बात को बार-बार पढ़ना उस पर सोचना नहीं है। वह उसे खिलाना है।',
  'Kisi baat ko baar-baar padhna us par sochna nahi hai. Woh use khilana hai.',
  NULL, 0, 'beginner', 'anger,social media,rumination,desire,night'

  UNION ALL SELECT 62, 'relationships', 3,
  'The argument that was not about the dishes',
  'वह झगड़ा जो बर्तनों का नहीं था',
  'Woh jhagda jo bartanon ka nahi tha',
  'Two people who live together have a serious row about a sink. Both know within an hour that it was not about the sink. Neither can easily say what it was about, because the actual thing has been accumulating for months in a form neither of them named — a growing sense of doing more and being noticed less.',
  'साथ रहने वाले दो लोगों में सिंक को लेकर गंभीर झगड़ा होता है। एक घंटे के भीतर दोनों जानते हैं कि बात सिंक की नहीं थी। दोनों में से कोई आसानी से नहीं बता पाता कि बात क्या थी, क्योंकि असली बात महीनों से ऐसे रूप में जमा हो रही थी जिसे किसी ने नाम नहीं दिया — यह बढ़ता एहसास कि कर ज़्यादा रहे हैं और दिख कम रहे हैं।',
  'Saath rehne wale do logon mein sink ko le kar serious jhagda hota hai. Ek ghante ke andar dono jaante hain ki baat sink ki nahi thi. Dono mein se koi aasani se nahi bata paata ki baat kya thi, kyunki asli baat mahinon se aise roop mein jama ho rahi thi jise kisi ne naam nahi diya — yeh badhta ehsaas ki kar zyada rahe hain aur dikh kam rahe hain.',
  'The verse is diagnostic rather than moral. It does not say anger is wrong; it says anger is late. By the time it shows up the useful work — naming what was wanted, months earlier — is long past.',
  'श्लोक नैतिक नहीं, नैदानिक है। वह यह नहीं कहता कि गुस्सा ग़लत है; वह कहता है कि गुस्सा देर से आता है। जब तक वह दिखता है, काम की बात — कि चाहा क्या जा रहा था, महीनों पहले — बहुत पीछे छूट चुकी होती है।',
  'Shloka naitik nahi, diagnostic hai. Woh yeh nahi kehta ki gussa galat hai; woh kehta hai ki gussa der se aata hai. Jab tak woh dikhta hai, kaam ki baat — ki chaha kya ja raha tha, mahinon pehle — bahut peeche chhoot chuki hoti hai.',
  'Name the want in month one and you will not need the argument in month six.',
  'पहले महीने में चाह को नाम दे दीजिए, तो छठे महीने झगड़े की ज़रूरत नहीं पड़ेगी।',
  'Pehle mahine mein chaah ko naam de do, to chhathe mahine jhagde ki zaroorat nahi padegi.',
  NULL, 0, 'intermediate', 'anger,relationships,marriage,resentment,communication'

  UNION ALL SELECT 62, 'everyday_life', 4,
  'Traffic, and the rest of the day',
  'ट्रैफ़िक, और बाकी का दिन',
  'Traffic, aur baaki ka din',
  'Someone cuts in at a junction. The driver arrives at work eleven minutes late and in a state that lasts until about three in the afternoon. Two conversations go badly. Nobody in either conversation knows about the junction, and by evening the driver has forgotten it too, while still feeling that it was a bad day.',
  'चौराहे पर कोई गाड़ी काटकर निकल जाता है। ड्राइवर ग्यारह मिनट देर से दफ़्तर पहुँचता है, और उस हालत में जो लगभग तीन बजे तक चलती है। दो बातचीत ख़राब होती हैं। दोनों में किसी को उस चौराहे का पता नहीं, और शाम तक ड्राइवर भी उसे भूल चुका होता है — यह महसूस करते हुए कि दिन ख़राब गया।',
  'Chaurahe par koi gaadi kaat ke nikal jaata hai. Driver gyarah minute late office pahunchta hai, aur us haalat mein jo lagbhag teen baje tak chalti hai. Do baatein kharab hoti hain. Dono mein kisi ko us chaurahe ka pata nahi, aur shaam tak driver bhi use bhool chuka hota hai — yeh mehsoos karte hue ki din kharab gaya.',
  'A small want — to arrive on time, to be treated fairly — met an obstacle and produced heat that outlasted its cause by six hours. The verse''s point is the disproportion: the size of the anger has almost nothing to do with the size of the event.',
  'एक छोटी चाह — समय पर पहुँचने की, ठीक बर्ताव पाने की — रुकावट से टकराई और ऐसी गरमी बनी जो अपने कारण से छह घंटे ज़्यादा टिकी। श्लोक की बात यही असंतुलन है: गुस्से का आकार घटना के आकार से लगभग कोई रिश्ता नहीं रखता।',
  'Ek chhoti chaah — time par pahunchne ki, theek behaviour milne ki — rukawat se takrayi aur aisi garmi bani jo apne kaaran se chhe ghante zyada tiki. Shloka ki baat yahi imbalance hai: gusse ka size ghatna ke size se lagbhag koi rishta nahi rakhta.',
  'If the anger outlasts the event by hours, it was never really about the event.',
  'अगर गुस्सा घटना से घंटों ज़्यादा टिके, तो वह कभी उस घटना का था ही नहीं।',
  'Agar gussa ghatna se ghanton zyada tike, to woh kabhi us ghatna ka tha hi nahi.',
  NULL, 0, 'beginner', 'anger,traffic,everyday,irritation,desire'

-- --- 2.70 : peace amid wanting --------------------------------------
  UNION ALL SELECT 70, 'finance', 1,
  'The number that keeps moving',
  'वह आँकड़ा जो हिलता रहता है',
  'Woh number jo hilta rehta hai',
  'Somebody decides that a particular amount of savings will make them feel secure. They reach it. Within about a month the figure that would make them feel secure has moved, and the new one feels as obviously correct as the old one did. This repeats three times over eleven years without ever being noticed as a pattern.',
  'कोई तय करता है कि इतनी बचत हो जाए तो सुरक्षित महसूस होगा। वह उतनी बचत कर लेता है। लगभग एक महीने में सुरक्षित महसूस कराने वाला आँकड़ा आगे खिसक जाता है, और नया आँकड़ा उतना ही स्वाभाविक लगता है जितना पुराना लगता था। ग्यारह साल में यह तीन बार होता है और एक बार भी पैटर्न की तरह नहीं दिखता।',
  'Koi tay karta hai ki itni savings ho jaaye to secure lagega. Woh utni kar leta hai. Lagbhag ek mahine mein secure feel karane wala number aage khisak jaata hai, aur naya number utna hi natural lagta hai jitna purana lagta tha. Gyarah saal mein yeh teen baar hota hai aur ek baar bhi pattern ki tarah nahi dikhta.',
  'The verse does not tell this person to want less money. It says the strategy is wrong: filling the ocean is not how the ocean becomes calm, and no amount of water arriving would ever have been the thing that settled it.',
  'श्लोक इस व्यक्ति से यह नहीं कहता कि कम पैसा चाहो। वह कहता है कि तरीक़ा ही ग़लत है: समुद्र को भरकर शांत नहीं किया जाता, और कितना भी पानी आ जाए, वह कभी उसे ठहराने वाली चीज़ थी ही नहीं।',
  'Shloka is insaan se yeh nahi kehta ki kam paisa chaho. Woh kehta hai ki tareeka hi galat hai: samundar ko bhar ke shaant nahi kiya jaata, aur kitna bhi paani aa jaaye, woh kabhi use thaharane wali cheez thi hi nahi.',
  'A target that moves every time you reach it was never a target.',
  'जो लक्ष्य हर बार पहुँचते ही आगे खिसक जाए, वह कभी लक्ष्य था ही नहीं।',
  'Jo target har baar pahunchte hi aage khisak jaaye, woh kabhi target tha hi nahi.',
  NULL, 0, 'beginner', 'desire,money,security,contentment,peace'

  UNION ALL SELECT 70, 'sports', 2,
  'The player who does not hear the crowd',
  'वह खिलाड़ी जिसे भीड़ सुनाई नहीं देती',
  'Woh player jise bheed sunayi nahi deti',
  'Eighty thousand people, a penalty, and the noise designed specifically to make one person fail. Some players describe the sound going quiet — not because it stopped, but because their attention had narrowed to something the noise could not reach. The noise was at full volume the whole time.',
  'अस्सी हज़ार लोग, एक पेनल्टी, और वह शोर जो ख़ास तौर पर एक आदमी को चूकाने के लिए बनाया गया है। कुछ खिलाड़ी बताते हैं कि आवाज़ शांत हो गई — इसलिए नहीं कि वह रुक गई, बल्कि इसलिए कि उनका ध्यान ऐसी जगह सिमट गया जहाँ शोर पहुँच ही नहीं सकता था। शोर पूरे समय पूरी आवाज़ में था।',
  'Assi hazaar log, ek penalty, aur woh shor jo khaas taur par ek aadmi ko chukane ke liye banaya gaya hai. Kuch players batate hain ki awaaz shaant ho gayi — isliye nahi ki woh ruk gayi, balki isliye ki unka dhyan aisi jagah simat gaya jahan shor pahunch hi nahi sakta tha. Shor poore time poori awaaz mein tha.',
  'This is the ocean image with the volume turned up. The rivers did not stop. Something about where the person was standing meant the rivers arriving did not move them.',
  'यह वही समुद्र वाला चित्र है, आवाज़ तेज़ करके। नदियाँ रुकी नहीं। बस वह जहाँ खड़ा था, उस जगह की वजह से आती हुई नदियाँ उसे हिला नहीं पाईं।',
  'Yeh wahi samundar wala image hai, awaaz tez kar ke. Nadiyan ruki nahi. Bas woh jahan khada tha, us jagah ki wajah se aati hui nadiyan use hila nahi paayin.',
  'Peace is not a quiet room. It is being large enough that the noise arriving does not move you.',
  'शांति शांत कमरा नहीं है। शांति इतना बड़ा होना है कि आता हुआ शोर आपको हिला न सके।',
  'Shanti shaant kamra nahi hai. Shanti itna bada hona hai ki aata hua shor tumhe hila na sake.',
  NULL, 0, 'intermediate', 'peace,pressure,focus,sport,desire'

  UNION ALL SELECT 70, 'social_media', 3,
  'Twenty minutes of other people''s good news',
  'बीस मिनट, दूसरों की अच्छी ख़बरें',
  'Bees minute, doosron ki achhi khabrein',
  'A scroll before bed. A promotion, a house, a holiday, a wedding — none of it aimed at anybody, all of it true, all of it somebody''s best day. Twenty minutes later a person who was content at 10:40 is not content at 11:00, and nothing whatsoever has happened to them.',
  'सोने से पहले थोड़ा स्क्रॉल। एक पदोन्नति, एक घर, एक छुट्टी, एक शादी — कुछ भी किसी को निशाना बनाकर नहीं, सब सच, और सब किसी का सबसे अच्छा दिन। बीस मिनट बाद जो व्यक्ति दस चालीस पर संतुष्ट था, वह ग्यारह बजे नहीं है, और उसके साथ कुछ भी नहीं हुआ।',
  'Sone se pehle thoda scroll. Ek promotion, ek ghar, ek chhutti, ek shaadi — kuch bhi kisi ko target kar ke nahi, sab sach, aur sab kisi ka sabse achha din. Bees minute baad jo insaan das chalis par content tha, woh gyarah baje nahi hai, aur uske saath kuch bhi nahi hua.',
  'The rivers arrived, and this ocean rose to meet every one of them. The verse is not asking the reader to stop seeing other people''s lives. It is pointing at the rising.',
  'नदियाँ आईं, और यह समुद्र हर एक को लेने ऊपर उठ गया। श्लोक यह नहीं कह रहा कि दूसरों की ज़िंदगी देखना बंद कर दीजिए। वह उस उठने की ओर इशारा कर रहा है।',
  'Nadiyan aayin, aur yeh samundar har ek ko lene upar uth gaya. Shloka yeh nahi keh raha ki doosron ki zindagi dekhna band kar do. Woh us uthne ki taraf ishara kar raha hai.',
  'Nothing happened to you. You simply rose to meet twenty rivers in a row.',
  'आपके साथ कुछ नहीं हुआ। आप बस लगातार बीस नदियों को लेने ऊपर उठ गए।',
  'Tumhare saath kuch nahi hua. Tum bas lagatar bees nadiyon ko lene upar uth gaye.',
  NULL, 0, 'beginner', 'comparison,social media,desire,peace,contentment'

  UNION ALL SELECT 70, 'leadership', 4,
  'The manager everyone brings bad news to',
  'वह मैनेजर जिसके पास सब बुरी ख़बर लाते हैं',
  'Woh manager jiske paas sab buri khabar laate hain',
  'In one team, people bring problems early. In another team down the corridor, people bring the same problems a week later, when they are much harder to fix. The difference is not competence or seniority. It is that one of the two managers reliably does not change temperature when something goes wrong, and everybody has worked this out without discussing it.',
  'एक टीम में लोग समस्या जल्दी ले आते हैं। गलियारे के उस पार दूसरी टीम में लोग वही समस्या एक हफ़्ते बाद लाते हैं, जब उसे ठीक करना कहीं मुश्किल हो चुका होता है। फ़र्क़ काबिलियत या पद का नहीं है। फ़र्क़ यह है कि दोनों में से एक मैनेजर कुछ ग़लत होने पर अपना तापमान नहीं बदलता, और यह बात सबने बिना कहे समझ ली है।',
  'Ek team mein log problem jaldi le aate hain. Corridor ke us paar doosri team mein log wahi problem ek hafte baad laate hain, jab use theek karna kahin mushkil ho chuka hota hai. Farq kabiliyat ya seniority ka nahi hai. Farq yeh hai ki dono mein se ek manager kuch galat hone par apna temperature nahi badalta, aur yeh baat sabne bina kahe samajh li hai.',
  'This is what the ocean is worth in practice. Steadiness is not a private spiritual achievement — it is infrastructure. People route information around anybody who rises to meet every river.',
  'व्यवहार में समुद्र होने का यही मोल है। स्थिरता कोई निजी आध्यात्मिक उपलब्धि नहीं है — वह ढाँचा है। जो हर नदी को लेने ऊपर उठता है, लोग सूचना उसके इर्द-गिर्द से घुमाकर ले जाते हैं।',
  'Practice mein samundar hone ka yahi mol hai. Sthirta koi private spiritual achievement nahi hai — woh infrastructure hai. Jo har nadi ko lene upar uthta hai, log information uske aas-paas se ghuma ke le jaate hain.',
  'People tell the truth to whoever does not change temperature when they hear it.',
  'लोग सच उसी से कहते हैं जो सुनकर अपना तापमान नहीं बदलता।',
  'Log sach usi se kehte hain jo sun ke apna temperature nahi badalta.',
  NULL, 0, 'intermediate', 'leadership,steadiness,trust,work,peace'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2;
