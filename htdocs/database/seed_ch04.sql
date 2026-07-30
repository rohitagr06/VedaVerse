-- =====================================================================
-- VedaVerse — database/seed_ch04.sql
-- =====================================================================
-- Chapter 4, Jñāna Karma Sannyāsa Yoga. Eight verses. This completes
-- the INTERMEDIATE track (2, 3, 4, 5, 6, 12, 13, 14, 16, 17, 18).
--
--   4.7   whenever dharma sags, something arrives
--   4.8   and what it arrives to do                       [CARE]
--   4.11  however people come, they are met that way
--   4.13  the varṇa verse                                 [CARE]
--   4.18  action in inaction, inaction in action
--   4.20  doing the work and doing nothing at once
--   4.34  go and ask somebody, and ask properly
--   4.38  nothing here is as clean as understanding
--
-- 4.13 IS THE VERSE THIS PROJECT DEFERRED FOR MONTHS
--   "The four varṇas were brought forth by me, guṇa-karma-vibhāgaśaḥ."
--   It is the single most consequential sentence in the book, because
--   it has been used for most of its history to tell people that the
--   circumstances of their birth were divinely arranged.
--
--   FOUR THINGS ARE TRUE AND THE EXPLANATION SAYS ALL FOUR. Removing
--   any one of them produces a dishonest page.
--
--   1. THE VERSE GIVES ITS OWN CRITERION AND IT IS NOT BIRTH.
--      Guṇa-karma-vibhāgaśaḥ — divided according to quality and to
--      action. The Sanskrit word for birth, janma, does not appear in
--      the line. Whatever else is arguable, the criterion the verse
--      states is not the criterion it was used to justify.
--
--   2. AND IT WAS READ AS BIRTH ANYWAY, FOR CENTURIES, BY PEOPLE WITH
--      AUTHORITY, AND THAT READING DID REAL DAMAGE TO REAL PEOPLE.
--      Pointing at the Sanskrit is true and is not sufficient. A page
--      that stops at point 1 is doing the same thing as a page that
--      stops at point 2 — picking the half that is comfortable.
--
--   3. THE TEXT DOES NOT SETTLE IT. 18.41 to 18.44 lists the four with
--      their duties and is the strongest support the hereditary reading
--      has; 5.18 refuses to rank five beings including a śvapāka; 13.27
--      says whoever sees the same in all of them sees. The book argues
--      with itself and the explanation says so rather than picking a
--      side and calling it the text's.
--
--   4. THE SECOND HALF UNDERCUTS THE FIRST. "Know me to be the maker of
--      that, and also the non-maker." Akartāram. The verse withdraws
--      its own authorship claim in the same breath it makes it, which
--      is a strange foundation for anybody's social order.
--
-- 4.8 NEEDS ITS OWN GUARD AND IT IS EASY TO MISS
--   "For the protection of the good and the destruction of wrongdoers."
--   That has been quoted by people arranging harm to somebody they had
--   designated. The refusal is textual and complete: every verb in the
--   verse is first person. It is a statement about what the speaker
--   does. Nobody in the book is instructed to do it, and Arjuna — who
--   is about to fight, and who has asked for a reason — is never given
--   this one.
--
-- CONTENT RULES — unchanged. Original writing throughout. Sanskrit
--   unaltered, numbering untouched. No praise or criticism of any living
--   politician, party or movement. No communal framing. NOT ONE EXAMPLE
--   IN THIS FILE NAMES A CASTE, A COMMUNITY, A RELIGION OR A REGION.
--
-- RUN AFTER seed_sample.sql. Re-runnable.
--
--     mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
--         < htdocs/database/seed_ch04.sql
--
-- global_order is 162 + verse_number: chapters 1 to 3 have 162 verses.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO verses
  (chapter_id, verse_number, global_order, is_curated, slug,
   sanskrit_devanagari, transliteration_iast, transliteration_simple,
   translation_literal,
   translation_en, translation_hi, translation_hinglish,
   summary_en, summary_hi, summary_hinglish,
   difficulty, seo_title, seo_description, published)
SELECT c.id, v.* FROM (

  SELECT 7 AS verse_number, 169 AS global_order, 1 AS is_curated, 'gita-4-7' AS slug,
    'यदा यदा हि धर्मस्य ग्लानिर्भवति भारत।\nअभ्युत्थानमधर्मस्य तदात्मानं सृजाम्यहम्॥' AS sanskrit_devanagari,
    'yadā yadā hi dharmasya glānir bhavati bhārata\nabhyutthānam adharmasya tadātmānaṁ sṛjāmy aham' AS transliteration_iast,
    'yada yada hi dharmasya glanir bhavati bharata\nabhyutthanam adharmasya tadatmanam srijamy aham' AS transliteration_simple,
    'Whenever there is a decline of dharma and a rising up of adharma, then I bring myself forth.' AS translation_literal,
    'Whenever what holds things together starts sagging, and what pulls them apart starts rising, then I put myself out into it.' AS translation_en,
    'जब भी वह चीज़ ढीली पड़ने लगती है जो सब कुछ थामे रखती है, और वह उठने लगती है जो सब तोड़ती है, तब मैं ख़ुद को उसमें उतार देता हूँ।' AS translation_hi,
    'Jab bhi woh cheez dheeli padne lagti hai jo sab kuch thaame rakhti hai, aur woh uthne lagti hai jo sab todti hai, tab main khud ko usme utaar deta hoon.' AS translation_hinglish,
    'The word is glāni — sagging, going slack. Not defeat. Something losing tension.' AS summary_en,
    'शब्द है ग्लानि — ढीला पड़ना, शिथिल होना। हार नहीं। किसी चीज़ का कसाव खोना।' AS summary_hi,
    'Shabd hai glani — dheela padna, shithil hona. Haar nahi. Kisi cheez ka kasav khona.' AS summary_hinglish,
    'intermediate' AS difficulty,
    'Gita 4.7: whenever what holds things together starts sagging' AS seo_title,
    'The Bhagavad Gita uses glani — a slackening rather than a defeat. The famous verse is about tension being lost, not about a war being won.' AS seo_description,
    1 AS published

  UNION ALL SELECT 8, 170, 1, 'gita-4-8',
    'परित्राणाय साधूनां विनाशाय च दुष्कृताम्।\nधर्मसंस्थापनार्थाय सम्भवामि युगे युगे॥',
    'paritrāṇāya sādhūnāṁ vināśāya ca duṣkṛtām\ndharma-saṁsthāpanārthāya sambhavāmi yuge yuge',
    'paritranaya sadhunam vinashaya cha dushkritam\ndharma-samsthapanarthaya sambhavami yuge yuge',
    'For the protection of the good, for the destruction of wrongdoers, and for the firm establishment of dharma, I come into being age after age.',
    'To get the decent ones out of it, to finish what the harm-doers are doing, and to set the thing that holds back on its feet — I come into being, age after age.',
    'भले लोगों को इससे निकालने के लिए, नुक़सान करने वालों का किया हुआ ख़त्म करने के लिए, और उस चीज़ को फिर पैरों पर खड़ा करने के लिए जो थामती है — मैं युग-युग में आता हूँ।',
    'Bhale logon ko isse nikalne ke liye, nuksaan karne walon ka kiya hua khatam karne ke liye, aur us cheez ko phir pairon par khada karne ke liye jo thaamti hai — main yug-yug mein aata hoon.',
    'Every verb is first person. It is a statement about what the speaker does, and nobody in the book is told to do it.',
    'हर क्रिया उत्तम पुरुष में है। यह इस बारे में बयान है कि वक्ता क्या करता है, और किताब में किसी से यह करने को नहीं कहा गया।',
    'Har kriya uttam purush mein hai. Yeh is baare mein bayan hai ki vakta kya karta hai, aur kitaab mein kisi se yeh karne ko nahi kaha gaya.',
    'intermediate',
    'Gita 4.8: every verb in it is first person',
    'The Bhagavad Gita says who does this and it is not the reader. Arjuna, who is about to fight and has asked for a reason, is never given this one.',
    1

  UNION ALL SELECT 11, 173, 1, 'gita-4-11',
    'ये यथा मां प्रपद्यन्ते तांस्तथैव भजाम्यहम्।\nमम वर्त्मानुवर्तन्ते मनुष्याः पार्थ सर्वशः॥',
    'ye yathā māṁ prapadyante tāṁs tathaiva bhajāmy aham\nmama vartmānuvartante manuṣyāḥ pārtha sarvaśaḥ',
    'ye yatha mam prapadyante tams tathaiva bhajamy aham\nmama vartmanuvartante manushyah partha sarvashah',
    'In whatever way people approach me, in that same way I meet them. In every way, Partha, people follow my path.',
    'However people come towards me, that is how I meet them. Whichever way they are walking, Partha, they are on it.',
    'लोग जिस तरह से मेरी तरफ़ आते हैं, मैं उसी तरह उनसे मिलता हूँ। वे जिस भी रास्ते चल रहे हों, पार्थ, वे उसी पर हैं।',
    'Log jis tarah se meri taraf aate hain, main usi tarah unse milta hoon. Woh jis bhi raaste chal rahe hon, Partha, woh usi par hain.',
    'The one verse in the book most often left out of the quotations, and it is the most generous sentence in it.',
    'किताब का वह एक श्लोक जो उद्धरणों से सबसे ज़्यादा छोड़ा जाता है, और वही उसका सबसे उदार वाक्य है।',
    'Kitaab ka woh ek shloka jo uddharanon se sabse zyada chhoda jaata hai, aur wahi uska sabse udaar vakya hai.',
    'intermediate',
    'Gita 4.11: however people come, that is how they are met',
    'The Bhagavad Gita says people are met in whatever way they approach, and that whichever way they walk, they are on the path. It sets no entry condition.',
    1

  UNION ALL SELECT 13, 175, 1, 'gita-4-13',
    'चातुर्वर्ण्यं मया सृष्टं गुणकर्मविभागशः।\nतस्य कर्तारमपि मां विद्ध्यकर्तारमव्ययम्॥',
    'cātur-varṇyaṁ mayā sṛṣṭaṁ guṇa-karma-vibhāgaśaḥ\ntasya kartāram api māṁ viddhy akartāram avyayam',
    'chatur-varnyam maya srishtam guna-karma-vibhagashah\ntasya kartaram api mam viddhy akartaram avyayam',
    'The fourfold varna was brought forth by me, divided according to guna and karma. Know me to be the maker of that, and also the non-maker, the imperishable.',
    'The four orders came out of me, sorted by quality and by what people do. And know me to be the one who made that — and also the one who did not make it, and does not wear out.',
    'चारों वर्ण मुझसे निकले, गुण और काम के हिसाब से बँटे हुए। और मुझे उसका बनाने वाला जानो — और वह भी जिसने उसे बनाया नहीं, और जो घिसता नहीं।',
    'Chaaron varna mujhse nikle, gun aur kaam ke hisaab se bante hue. Aur mujhe uska banane wala jaano — aur woh bhi jisne use banaya nahi, aur jo ghista nahi.',
    'The criterion the verse states is quality and action. The word for birth does not appear in it. And it was read as birth anyway, for centuries.',
    'श्लोक जो कसौटी बताता है वह गुण और कर्म है। जन्म का शब्द उसमें आता ही नहीं। और फिर भी उसे सदियों तक जन्म ही पढ़ा गया।',
    'Shloka jo kasauti batata hai woh gun aur karm hai. Janm ka shabd usme aata hi nahi. Aur phir bhi use sadiyon tak janm hi padha gaya.',
    'intermediate',
    'Gita 4.13: the criterion it states, and the one it was used for',
    'The Bhagavad Gita divides the four varnas guna-karma-vibhagashah — by quality and action. The word for birth is not in the verse, and the verse was read as birth for centuries anyway.',
    1

  UNION ALL SELECT 18, 180, 1, 'gita-4-18',
    'कर्मण्यकर्म यः पश्येदकर्मणि च कर्म यः।\nस बुद्धिमान्मनुष्येषु स युक्तः कृत्स्नकर्मकृत्॥',
    'karmaṇy akarma yaḥ paśyed akarmaṇi ca karma yaḥ\nsa buddhimān manuṣyeṣu sa yuktaḥ kṛtsna-karma-kṛt',
    'karmany akarma yah pashyed akarmani cha karma yah\nsa buddhiman manushyeshu sa yuktah kritsna-karma-krit',
    'One who sees inaction in action, and action in inaction, is wise among people. That one is joined, and has done the whole of what there is to do.',
    'Whoever can see the not-doing inside doing, and the doing inside not-doing, has understood something. That person is joined up, and has done the whole thing.',
    'जो करने के भीतर न-करना देख ले, और न-करने के भीतर करना, उसने कुछ समझ लिया। वह जुड़ा हुआ है, और उसने पूरा काम कर लिया।',
    'Jo karne ke bheetar na-karna dekh le, aur na-karne ke bheetar karna, usne kuch samajh liya. Woh juda hua hai, aur usne poora kaam kar liya.',
    'The second half is the useful one. Not doing something is also something you are doing.',
    'दूसरा आधा काम का है। कुछ न करना भी वह चीज़ है जो आप कर रहे हैं।',
    'Doosra aadha kaam ka hai. Kuch na karna bhi woh cheez hai jo tum kar rahe ho.',
    'intermediate',
    'Gita 4.18: not doing something is also something you are doing',
    'The Bhagavad Gita asks you to see action in inaction. The half people skip is the second one, and it is the one that removes the exit.',
    1

  UNION ALL SELECT 20, 182, 1, 'gita-4-20',
    'त्यक्त्वा कर्मफलासङ्गं नित्यतृप्तो निराश्रयः।\nकर्मण्यभिप्रवृत्तोऽपि नैव किंचित्करोति सः॥',
    'tyaktvā karma-phalāsaṅgaṁ nitya-tṛpto nirāśrayaḥ\nkarmaṇy abhipravṛtto ''pi naiva kiñcit karoti saḥ',
    'tyaktva karma-phalasangam nitya-tripto nirashrayah\nkarmany abhipravritto pi naiva kinchit karoti sah',
    'Having given up attachment to the fruit of action, always content, depending on nothing, though fully engaged in action, he does not do anything at all.',
    'Having let go of holding on to what the work earns, steadily content, leaning on nothing — even while he is fully into the work, he is not doing a thing.',
    'काम से जो मिलता है उसकी पकड़ छोड़कर, लगातार संतुष्ट, किसी पर टिके बिना — पूरी तरह काम में लगे होते हुए भी, वह कुछ कर नहीं रहा।',
    'Kaam se jo milta hai uski pakad chhodkar, lagataar santusht, kisi par tike bina — poori tarah kaam mein lage hote hue bhi, woh kuch kar nahi raha.',
    'Abhipravṛttaḥ — fully engaged, right in it. The verse insists on that before it says the other thing.',
    'अभिप्रवृत्तः — पूरी तरह लगा हुआ, ठीक उसी में। दूसरी बात कहने से पहले श्लोक इस पर ज़ोर देता है।',
    'Abhipravrittah — poori tarah laga hua, theek usi mein. Doosri baat kehne se pehle shloka is par zor deta hai.',
    'intermediate',
    'Gita 4.20: fully in the work, and not doing a thing',
    'The Bhagavad Gita says abhipravrittah — fully engaged — before it says he does nothing. The engagement is not the part being withdrawn.',
    1

  UNION ALL SELECT 34, 196, 1, 'gita-4-34',
    'तद्विद्धि प्रणिपातेन परिप्रश्नेन सेवया।\nउपदेक्ष्यन्ति ते ज्ञानं ज्ञानिनस्तत्त्वदर्शिनः॥',
    'tad viddhi praṇipātena paripraśnena sevayā\nupadekṣyanti te jñānaṁ jñāninas tattva-darśinaḥ',
    'tad viddhi pranipatena pariprashnena sevaya\nupadekshyanti te jnanam jnaninas tattva-darshinah',
    'Know that by bowing down, by thorough questioning, and by service. Those who know, who see how things are, will teach you that knowledge.',
    'Find it out by going and putting yourself lower, by asking all the way round the thing, and by making yourself useful. People who actually know will tell you.',
    'यह जानिए — जाकर ख़ुद को नीचे रखकर, चीज़ को चारों तरफ़ से पूछकर, और अपने को काम का बनाकर। जो सचमुच जानते हैं वे आपको बता देंगे।',
    'Yeh jaaniye — jaakar khud ko neeche rakhkar, cheez ko chaaron taraf se poochhkar, aur apne ko kaam ka banakar. Jo sach mein jaante hain woh tumhe bata denge.',
    'Pari-praśna — asking all the way round. The middle term is questioning, and it is not the polite kind.',
    'परि-प्रश्न — चारों तरफ़ से पूछना। बीच वाली चीज़ सवाल करना है, और वह शिष्टाचार वाला सवाल नहीं है।',
    'Pari-prashna — chaaron taraf se poochhna. Beech wali cheez sawal karna hai, aur woh shishtachar wala sawal nahi hai.',
    'intermediate',
    'Gita 4.34: go and ask, all the way round the thing',
    'The Bhagavad Gita puts pari-prashna — thorough questioning — between bowing and serving. The instruction is to interrogate, not to accept.',
    1

  UNION ALL SELECT 38, 200, 1, 'gita-4-38',
    'न हि ज्ञानेन सदृशं पवित्रमिह विद्यते।\nतत्स्वयं योगसंसिद्धः कालेनात्मनि विन्दति॥',
    'na hi jñānena sadṛśaṁ pavitram iha vidyate\ntat svayaṁ yoga-saṁsiddhaḥ kālenātmani vindati',
    'na hi jnanena sadrisham pavitram iha vidyate\ntat svayam yoga-samsiddhah kalenatmani vindati',
    'There is nothing here as purifying as knowledge. One perfected in yoga finds that in themselves, in time, of their own accord.',
    'Nothing here cleans a thing the way understanding does. And whoever has settled into the practice finds it in themselves, in time, by themselves.',
    'यहाँ कोई चीज़ वैसे साफ़ नहीं करती जैसे समझ करती है। और जो अभ्यास में बैठ चुका है वह उसे अपने भीतर पा लेता है, समय के साथ, ख़ुद ही।',
    'Yahan koi cheez waise saaf nahi karti jaise samajh karti hai. Aur jo abhyas mein baith chuka hai woh use apne bheetar pa leta hai, samay ke saath, khud hi.',
    'Kālena — in time. Nothing in the verse is available this afternoon and it does not pretend otherwise.',
    'कालेन — समय के साथ। श्लोक में कुछ भी आज दोपहर उपलब्ध नहीं है और वह इसका दिखावा भी नहीं करता।',
    'Kalena — samay ke saath. Shloka mein kuch bhi aaj dopahar uplabdh nahi hai aur woh iska dikhava bhi nahi karta.',
    'intermediate',
    'Gita 4.38: in time, by themselves, of their own accord',
    'The Bhagavad Gita ends its knowledge chapter with kalena — in time. Nothing it offers is available this afternoon and it does not pretend otherwise.',
    1

) AS v
JOIN chapters c ON c.chapter_number = 4;

-- =====================================================================
-- 2. EXPLANATIONS
-- =====================================================================
-- All at beginner depth. The load-bearing sentences, all asserted by
-- smoke-test.sh on the DEFAULT render:
--   4.8   every verb is first person; nobody is instructed
--   4.13  the criterion stated is not birth
--   4.13  AND it was read as birth anyway, for centuries
--   4.13  AND the book argues with itself about it
-- =====================================================================

DELETE ve FROM verse_explanations ve JOIN verses v ON v.id = ve.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 4;

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 7 AS vn, 'beginner' AS level,
   'One of the four or five best-known verses in the book, and the one most often printed on things. It sits in a chapter about knowledge and action, which is not where most people expect to find it.' AS h_en,
   'किताब के चार-पाँच सबसे मशहूर श्लोकों में एक, और वही जो चीज़ों पर सबसे ज़्यादा छपता है। यह ज्ञान और कर्म के अध्याय में है, और ज़्यादातर लोग इसे यहाँ मिलने की उम्मीद नहीं करते।' AS h_hi,
   'Kitaab ke chaar-paanch sabse mashhoor shlokon mein ek, aur wahi jo cheezon par sabse zyada chhapta hai. Yeh gyan aur karm ke adhyay mein hai, aur zyadatar log ise yahan milne ki ummeed nahi karte.' AS h_hing,
   'The word to stop on is glāni. It means sagging, going slack, losing tension — the way a rope does, or a face. Not defeat, not destruction, not being overrun. Something that was holding has stopped holding as well as it did.' AS p_en,
   'रुकने लायक़ शब्द है ग्लानि। इसका मतलब है ढीला पड़ना, शिथिल होना, कसाव खोना — जैसे रस्सी खोती है, या चेहरा। हार नहीं, विनाश नहीं, कुचला जाना नहीं। जो चीज़ थामे हुए थी वह उतना अच्छा थामना बंद कर चुकी है।' AS p_hi,
   'Rukne layak shabd hai glani. Iska matlab hai dheela padna, shithil hona, kasav khona — jaise rassi khoti hai, ya chehra. Haar nahi, vinash nahi, kuchla jaana nahi. Jo cheez thaame hue thi woh utna achha thaamna band kar chuki hai.' AS p_hing,
   'The verse is usually read at the scale of civilisations, and it works there, but the word does not require it. Slackening is the ordinary way things go wrong: not a catastrophe, a loss of tension. A team where nobody is quite covering for anybody any more. A friendship where the messages got shorter. Nothing happened on any particular day, and something is going.' AS m_en,
   'श्लोक आमतौर पर सभ्यताओं के नाप पर पढ़ा जाता है, और वहाँ चलता भी है, पर शब्द इसकी माँग नहीं करता। ढीला पड़ना वह आम तरीक़ा है जिससे चीज़ें बिगड़ती हैं: कोई आपदा नहीं, कसाव का जाना। ऐसी टीम जहाँ अब कोई किसी को ठीक से नहीं संभाल रहा। ऐसी दोस्ती जिसमें संदेश छोटे होते चले गए। किसी एक दिन कुछ नहीं हुआ, और कुछ जा रहा है।' AS m_hi,
   'Shloka aam taur par sabhyataon ke naap par padha jaata hai, aur wahan chalta bhi hai, par shabd iski maang nahi karta. Dheela padna woh aam tareeka hai jisse cheezein bigadti hain: koi aapda nahi, kasav ka jaana. Aisi team jahan ab koi kisi ko theek se nahi sambhal raha. Aisi dosti jisme sandesh chhote hote chale gaye. Kisi ek din kuch nahi hua, aur kuch ja raha hai.' AS m_hing

  UNION ALL SELECT 8, 'beginner',
   'The second half of the sentence begun in 4.7, and the more quoted of the two. It has been printed under photographs of weapons.',
   '4.7 में शुरू हुए वाक्य का दूसरा आधा, और दोनों में ज़्यादा उद्धृत होने वाला। इसे हथियारों की तस्वीरों के नीचे छापा जाता रहा है।',
   '4.7 mein shuru hue vakya ka doosra aadha, aur dono mein zyada uddhrit hone wala. Ise hathiyaron ki tasveeron ke neeche chhapa jaata raha hai.',
   'Three purposes: getting the decent out of it, ending what the harm-doers are doing, and setting the holding thing back upright. Then the verb: sambhavāmi. I come into being. First person, singular, present.',
   'तीन मक़सद: भलों को इससे निकालना, नुक़सान करने वालों का किया हुआ ख़त्म करना, और थामने वाली चीज़ को फिर सीधा खड़ा करना। फिर क्रिया: सम्भवामि। मैं आता हूँ। उत्तम पुरुष, एकवचन, वर्तमान।',
   'Teen maksad: bhalon ko isse nikalna, nuksaan karne walon ka kiya hua khatam karna, aur thaamne wali cheez ko phir seedha khada karna. Phir kriya: sambhavami. Main aata hoon. Uttam purush, ekvachan, vartaman.',
   'This verse has been used to arrange harm to somebody the arranger had already designated, and the refusal is textual and complete: every verb in it is first person. It is a statement about what the speaker does. Nobody in the book is instructed to do it, in any chapter, at any point. And the strongest evidence is who is standing there — Arjuna is about to fight, he has asked directly for a reason to, and across seven hundred verses he is never once given this one. A verse that would have settled his question, offered to somebody who asked, and it is not offered.',
   'इस श्लोक का इस्तेमाल किसी ऐसे को नुक़सान पहुँचाने के इंतज़ाम में होता रहा है जिसे इंतज़ाम करने वाला पहले ही चुन चुका था, और इनकार पाठ से आता है और पूरा है: इसकी हर क्रिया उत्तम पुरुष में है। यह वक्ता क्या करता है, इसका बयान है। किताब में किसी अध्याय में, किसी जगह, किसी से यह करने को नहीं कहा गया। और सबसे बड़ा सबूत यह है कि वहाँ खड़ा कौन है — अर्जुन लड़ने वाला है, उसने सीधे वजह माँगी है, और सात सौ श्लोकों में उसे यह वजह एक बार भी नहीं दी जाती। ऐसा श्लोक जो उसका सवाल तय कर देता, और पूछने वाले को वह पेश ही नहीं किया गया।',
   'Is shloka ka istemaal kisi aise ko nuksaan pahunchane ke intezaam mein hota raha hai jise intezaam karne wala pehle hi chun chuka tha, aur inkaar paath se aata hai aur poora hai: iski har kriya uttam purush mein hai. Yeh vakta kya karta hai, iska bayan hai. Kitaab mein kisi adhyay mein, kisi jagah, kisi se yeh karne ko nahi kaha gaya. Aur sabse bada saboot yeh hai ki wahan khada kaun hai — Arjun ladne wala hai, usne seedhe wajah maangi hai, aur saat sau shlokon mein use yeh wajah ek baar bhi nahi di jaati. Aisa shloka jo uska sawal tay kar deta, aur poochhne wale ko woh pesh hi nahi kiya gaya.'

  UNION ALL SELECT 11, 'beginner',
   'Two verses after the famous one and almost never quoted with it. It is the book''s answer to a question nobody in the book asked.',
   'मशहूर श्लोक के दो श्लोक बाद, और उसके साथ लगभग कभी उद्धृत नहीं होता। यह उस सवाल का किताब का जवाब है जो किताब में किसी ने पूछा ही नहीं।',
   'Mashhoor shloka ke do shloka baad, aur uske saath lagbhag kabhi uddhrit nahi hota. Yeh us sawal ka kitaab ka jawab hai jo kitaab mein kisi ne poochha hi nahi.',
   'However people approach, that is how they are met. Then the second line, which is the larger claim: whichever way they are walking, they are on it. Sarvaśaḥ — in every way, from every direction.',
   'लोग जैसे भी आएँ, उनसे वैसे ही मिला जाता है। फिर दूसरी पंक्ति, जो बड़ा दावा है: वे जिस भी रास्ते चल रहे हों, वे उसी पर हैं। सर्वशः — हर तरह से, हर दिशा से।',
   'Log jaise bhi aayein, unse waise hi mila jaata hai. Phir doosri pankti, jo bada dawa hai: woh jis bhi raaste chal rahe hon, woh usi par hain. Sarvashah — har tarah se, har disha se.',
   'A book that says this cannot also be run as a membership scheme, and it is worth noticing which of the two verses gets printed on things. There is no entry condition here — not belief, not birth, not a name, not having read the book. Whatever a person is walking towards, the verse declines to say they are walking away. It is also the reason this text can be handed to somebody with no background and no belief without either side pretending, and 18.63 says the same thing at the other end.',
   'जो किताब यह कहती है वह सदस्यता योजना की तरह नहीं चलाई जा सकती, और यह देखने लायक़ है कि दोनों में से कौन-सा श्लोक चीज़ों पर छपता है। यहाँ भीतर आने की कोई शर्त नहीं है — न विश्वास, न जन्म, न कोई नाम, न किताब पढ़ा होना। इंसान जिस तरफ़ भी चल रहा हो, श्लोक यह कहने से इनकार करता है कि वह दूर जा रहा है। और यही वजह है कि यह ग्रंथ बिना किसी पृष्ठभूमि और बिना किसी आस्था वाले को दिया जा सकता है और दोनों तरफ़ किसी को दिखावा नहीं करना पड़ता, और दूसरे सिरे पर 18.63 यही कहता है।',
   'Jo kitaab yeh kehti hai woh sadasyata yojna ki tarah nahi chalayi ja sakti, aur yeh dekhne layak hai ki dono mein se kaun sa shloka cheezon par chhapta hai. Yahan bheetar aane ki koi shart nahi hai — na vishwas, na janm, na koi naam, na kitaab padha hona. Insan jis taraf bhi chal raha ho, shloka yeh kehne se inkaar karta hai ki woh door ja raha hai. Aur yahi wajah hai ki yeh granth bina kisi prishthbhumi aur bina kisi aastha wale ko diya ja sakta hai aur dono taraf kisi ko dikhava nahi karna padta, aur doosre sire par 18.63 yahi kehta hai.'

  UNION ALL SELECT 13, 'beginner',
   'Twelve verses into a chapter about knowledge and action, and this is the most consequential sentence in the book — not because of what it says, but because of what it has been used to do.',
   'ज्ञान और कर्म के अध्याय के बारहवें श्लोक पर, और यह किताब का सबसे भारी नतीजों वाला वाक्य है — इसलिए नहीं कि यह क्या कहता है, बल्कि इसलिए कि इससे क्या करवाया गया है।',
   'Gyan aur karm ke adhyay ke barahve shloka par, aur yeh kitaab ka sabse bhaari nateejon wala vakya hai — isliye nahi ki yeh kya kehta hai, balki isliye ki isse kya karvaya gaya hai.',
   'Read the words. Cātur-varṇyaṁ mayā sṛṣṭaṁ — the fourfold order came out of me. Then the criterion, and the criterion is the whole argument: guṇa-karma-vibhāgaśaḥ, divided according to quality and to action. The Sanskrit word for birth, janma, is not in the line.',
   'शब्द पढ़िए। चातुर्वर्ण्यं मया सृष्टं — चारों का क्रम मुझसे निकला। फिर कसौटी, और कसौटी ही पूरी दलील है: गुणकर्मविभागशः, गुण और कर्म के हिसाब से बँटा हुआ। जन्म का संस्कृत शब्द, जन्म, इस पंक्ति में है ही नहीं।',
   'Shabd padho. Chatur-varnyam maya srishtam — chaaron ka kram mujhse nikla. Phir kasauti, aur kasauti hi poori dalil hai: guna-karma-vibhagashah, gun aur karm ke hisaab se banta hua. Janm ka Sanskrit shabd, janma, is pankti mein hai hi nahi.',
   'Four things are true here and leaving any of them out produces a dishonest page. First: the criterion the verse states is quality and action, and it is not birth — the word is simply not there. Second: it was read as birth anyway, for centuries, by people with authority, and that reading was used to tell millions of people that the circumstances of their birth were divinely arranged. Pointing at the Sanskrit is true and it is not sufficient; a page that stops there is doing the same thing as a page that stops at the history, which is picking the half that suits it. Third: the book does not settle this. 18.41 to 18.44 lists the four orders with their duties and is the strongest support the hereditary reading has; 5.18 puts a learned brahmin and a śvapāka in one line and refuses to rank them; 13.27 says whoever sees the same in all beings is the one who sees. The text argues with itself and it is not this project''s place to decide that argument on its behalf. Fourth, and strangest: the second half of this very verse withdraws its own claim. Know me to be the maker of that — and also the non-maker. Whatever a person wants to build on the first line, the second line is already standing underneath it saying not so fast.',
   'यहाँ चार बातें सच हैं और इनमें से कोई भी छोड़ने से पन्ना बेईमान हो जाता है। पहली: श्लोक जो कसौटी बताता है वह गुण और कर्म है, जन्म नहीं — वह शब्द वहाँ है ही नहीं। दूसरी: फिर भी उसे सदियों तक जन्म ही पढ़ा गया, अधिकार वालों के हाथों, और उस पाठ से करोड़ों लोगों को बताया गया कि उनके जन्म के हालात ईश्वर ने तय किए। संस्कृत की तरफ़ इशारा करना सच है और काफ़ी नहीं है; वहीं रुकने वाला पन्ना वही कर रहा है जो इतिहास पर रुकने वाला — अपने काम का आधा चुन लेना। तीसरी: किताब इसे तय नहीं करती। 18.41 से 18.44 चारों को उनके कर्तव्यों के साथ गिनाता है और वंशगत पाठ का सबसे बड़ा सहारा वही है; 5.18 एक विद्वान ब्राह्मण और एक श्वपाक को एक पंक्ति में रखता है और उनमें क्रम लगाने से इनकार करता है; 13.27 कहता है कि जो सब प्राणियों में वही देखता है, वही देखता है। ग्रंथ ख़ुद से बहस करता है और उस बहस को उसकी तरफ़ से तय करना इस परियोजना का काम नहीं है। चौथी, और सबसे अजीब: इसी श्लोक का दूसरा आधा अपना ही दावा वापस ले लेता है। मुझे उसका कर्ता जानो — और अकर्ता भी। पहली पंक्ति पर कोई जो भी खड़ा करना चाहे, दूसरी पंक्ति पहले से नीचे खड़ी होकर कह रही है, इतनी जल्दी नहीं।',
   'Yahan chaar baatein sach hain aur inme se koi bhi chhodne se panna beimaan ho jaata hai. Pehli: shloka jo kasauti batata hai woh gun aur karm hai, janm nahi — woh shabd wahan hai hi nahi. Doosri: phir bhi use sadiyon tak janm hi padha gaya, adhikar walon ke haathon, aur us paath se karodon logon ko bataya gaya ki unke janm ke haalat ishwar ne tay kiye. Sanskrit ki taraf ishara karna sach hai aur kaafi nahi hai; wahin rukne wala panna wahi kar raha hai jo itihaas par rukne wala — apne kaam ka aadha chun lena. Teesri: kitaab ise tay nahi karti. 18.41 se 18.44 chaaron ko unke kartavyon ke saath ginata hai aur vanshagat paath ka sabse bada sahara wahi hai; 5.18 ek vidwan brahmin aur ek shvapak ko ek pankti mein rakhta hai aur unme kram lagane se inkaar karta hai; 13.27 kehta hai ki jo sab praniyon mein wahi dekhta hai, wahi dekhta hai. Granth khud se behes karta hai aur us behes ko uski taraf se tay karna is pariyojna ka kaam nahi hai. Chauthi, aur sabse ajeeb: isi shloka ka doosra aadha apna hi dawa wapas le leta hai. Mujhe uska karta jaano — aur akarta bhi. Pehli pankti par koi jo bhi khada karna chahe, doosri pankti pehle se neeche khadi hokar keh rahi hai, itni jaldi nahi.'

  UNION ALL SELECT 18, 'beginner',
   'The chapter turns from who does what to how to look at doing at all. This verse is the pivot and it is deliberately shaped like a puzzle.',
   'अध्याय इस बात से मुड़ता है कि कौन क्या करता है, और इस तरफ़ आता है कि करने को देखा कैसे जाए। यह श्लोक मोड़ है और जानबूझकर पहेली की शक्ल में बना है।',
   'Adhyay is baat se mudta hai ki kaun kya karta hai, aur is taraf aata hai ki karne ko dekha kaise jaaye. Yeh shloka mod hai aur jaanboojhkar paheli ki shakl mein bana hai.',
   'Two halves. Seeing the not-doing inside doing is the half people expect, and it is chapter 3''s point restated. Seeing the doing inside not-doing is the other half, and it is the one that does work.',
   'दो आधे। करने के भीतर न-करना देखना वह आधा है जिसकी उम्मीद होती है, और वह तीसरे अध्याय की बात दोबारा है। न-करने के भीतर करना देखना दूसरा आधा है, और काम वही करता है।',
   'Do aadhe. Karne ke bheetar na-karna dekhna woh aadha hai jiski ummeed hoti hai, aur woh teesre adhyay ki baat dobara hai. Na-karne ke bheetar karna dekhna doosra aadha hai, aur kaam wahi karta hai.',
   'The second half removes an exit that the first half seems to open. If a person can be fully engaged and doing nothing, somebody will notice that the reverse also follows: they can be doing nothing and be fully engaged in it. Not replying is a reply. Not deciding is a decision, made on a particular day, with consequences somebody will carry. The chapter is not offering a way out of the ledger, and this line is where it says so.',
   'दूसरा आधा उस निकास को बंद कर देता है जो पहला आधा खोलता दिखता है। अगर कोई पूरी तरह लगा हो और कुछ न कर रहा हो, तो कोई यह भी देख लेगा कि उलटा भी बनता है: वह कुछ न कर रहा हो और पूरी तरह उसी में लगा हो। जवाब न देना भी जवाब है। तय न करना भी फ़ैसला है, किसी ख़ास दिन लिया गया, और उसके नतीजे कोई न कोई उठाएगा। अध्याय बहीखाते से निकलने का रास्ता नहीं दे रहा, और यही पंक्ति वह कहती है।',
   'Doosra aadha us nikaas ko band kar deta hai jo pehla aadha kholta dikhta hai. Agar koi poori tarah laga ho aur kuch na kar raha ho, to koi yeh bhi dekh lega ki ulta bhi banta hai: woh kuch na kar raha ho aur poori tarah usi mein laga ho. Jawab na dena bhi jawab hai. Tay na karna bhi faisla hai, kisi khaas din liya gaya, aur uske nateeje koi na koi uthayega. Adhyay bahikhate se nikalne ka raasta nahi de raha, aur yahi pankti woh kehti hai.'

  UNION ALL SELECT 20, 'beginner',
   'The verse that follows through on 4.18, and the one that shows what the first half of that puzzle actually looks like in a person.',
   'वह श्लोक जो 4.18 को आगे ले जाता है, और दिखाता है कि उस पहेली का पहला आधा किसी इंसान में असल में कैसा दिखता है।',
   'Woh shloka jo 4.18 ko aage le jaata hai, aur dikhata hai ki us paheli ka pehla aadha kisi insan mein asal mein kaisa dikhta hai.',
   'Abhipravṛttaḥ api — although fully engaged, right into it. The verse insists on that before it says he does nothing, and the order is the argument. This is not somebody standing back.',
   'अभिप्रवृत्तः अपि — पूरी तरह लगे होते हुए भी, ठीक उसी में। श्लोक यह कहने से पहले कि वह कुछ नहीं कर रहा, इसी पर ज़ोर देता है, और क्रम ही दलील है। यह कोई पीछे हटकर खड़ा इंसान नहीं है।',
   'Abhipravrittah api — poori tarah lage hote hue bhi, theek usi mein. Shloka yeh kehne se pehle ki woh kuch nahi kar raha, isi par zor deta hai, aur kram hi dalil hai. Yeh koi peechhe hatkar khada insan nahi hai.',
   'Nirāśrayaḥ is the word worth having: leaning on nothing, without a support propped under you. Most people doing demanding work have something propped under it — the recognition, the title, the person who will be impressed, the story about what this will have been for. The verse describes somebody doing the same work with none of that underneath, and says the doing carries on unaffected. Not less work. The same work, without the scaffolding.',
   'निराश्रयः वह शब्द है जो रखने लायक़ है: किसी पर टिके बिना, नीचे कोई सहारा लगाए बिना। मेहनत का काम करने वाले ज़्यादातर लोगों ने नीचे कुछ लगा रखा होता है — वह पहचान, वह ओहदा, वह इंसान जो प्रभावित होगा, वह कहानी कि यह सब किसलिए था। श्लोक ऐसे इंसान का वर्णन करता है जो वही काम इनमें से किसी सहारे के बिना कर रहा है, और कहता है कि काम बिना असर के चलता रहता है। कम काम नहीं। वही काम, बिना पाड़ के।',
   'Nirashrayah woh shabd hai jo rakhne layak hai: kisi par tike bina, neeche koi sahara lagaye bina. Mehnat ka kaam karne wale zyadatar logon ne neeche kuch laga rakha hota hai — woh pehchan, woh ohda, woh insan jo prabhavit hoga, woh kahani ki yeh sab kisliye tha. Shloka aise insan ka varnan karta hai jo wahi kaam inme se kisi sahare ke bina kar raha hai, aur kehta hai ki kaam bina asar ke chalta rehta hai. Kam kaam nahi. Wahi kaam, bina paad ke.'

  UNION ALL SELECT 34, 'beginner',
   'Near the end of the chapter, and the only place in the book where somebody is told, in plain words, what to do next.',
   'अध्याय के अंत के पास, और किताब की अकेली जगह जहाँ किसी को साफ़ शब्दों में बताया जाता है कि आगे क्या करना है।',
   'Adhyay ke ant ke paas, aur kitaab ki akeli jagah jahan kisi ko saaf shabdon mein bataya jaata hai ki aage kya karna hai.',
   'Three terms. Praṇipāta is putting yourself lower. Sevā is making yourself useful. And between them, doing the actual work, is pari-praśna — asking all the way round a thing, from every side, until it has been turned over.',
   'तीन शब्द। प्रणिपात यानी ख़ुद को नीचे रखना। सेवा यानी अपने को काम का बनाना। और उनके बीच, असली काम करता हुआ, है परि-प्रश्न — किसी चीज़ को चारों तरफ़ से पूछना, हर तरफ़ से, जब तक वह पलट न जाए।',
   'Teen shabd. Pranipat yani khud ko neeche rakhna. Seva yani apne ko kaam ka banana. Aur unke beech, asli kaam karta hua, hai pari-prashna — kisi cheez ko chaaron taraf se poochhna, har taraf se, jab tak woh palat na jaaye.',
   'The two outer terms are the ones a tradition finds convenient and the middle one is the one it tends to lose. Pari- is the prefix in perimeter: all the way round. The instruction is to interrogate the thing from every side, and it is sandwiched between two forms of deference on purpose — you are not being told to defer instead of asking, you are being told the asking is what you came for. Read next to 18.63, where the same speaker ends seven hundred verses by saying think it over completely and then do as you wish, this is a consistent position and not a lapse.',
   'बाहर के दोनों शब्द वे हैं जो किसी परंपरा को सुविधाजनक लगते हैं और बीच वाला वह है जिसे वह खो देती है। परि- वही उपसर्ग है जो परिधि में है: चारों तरफ़। हिदायत यह है कि चीज़ को हर तरफ़ से खोदकर पूछा जाए, और उसे जानबूझकर विनय के दो रूपों के बीच रखा गया है — आपसे यह नहीं कहा जा रहा कि पूछने के बजाय झुकिए, आपसे यह कहा जा रहा है कि पूछना ही वह है जिसके लिए आप आए हैं। 18.63 के बग़ल में पढ़िए, जहाँ वही वक्ता सात सौ श्लोक इस पर ख़त्म करता है कि पूरी तरह सोच लो और फिर जैसा चाहो करो — तो यह एक टिकी हुई स्थिति है, कोई चूक नहीं।',
   'Bahar ke dono shabd woh hain jo kisi parampara ko suvidhajanak lagte hain aur beech wala woh hai jise woh kho deti hai. Pari- wahi upasarg hai jo paridhi mein hai: chaaron taraf. Hidayat yeh hai ki cheez ko har taraf se khodkar poochha jaaye, aur use jaanboojhkar vinay ke do roopon ke beech rakha gaya hai — tumse yeh nahi kaha ja raha ki poochhne ke bajaye jhuko, tumse yeh kaha ja raha hai ki poochhna hi woh hai jiske liye tum aaye ho. 18.63 ke bagal mein padho, jahan wahi vakta saat sau shloka is par khatam karta hai ki poori tarah soch lo aur phir jaisa chaho karo — to yeh ek tiki hui sthiti hai, koi chook nahi.'

  UNION ALL SELECT 38, 'beginner',
   'The chapter has been about knowledge and action. This is nearly the last thing it says about the first of those.',
   'अध्याय ज्ञान और कर्म पर रहा है। उनमें पहले के बारे में यह उसकी लगभग आख़िरी बात है।',
   'Adhyay gyan aur karm par raha hai. Unme pehle ke baare mein yeh uski lagbhag aakhiri baat hai.',
   'Nothing here is as pavitra as knowledge — the word is about cleanness, about something being made fit rather than about being made holy. Then the ending, and it is the honest part: kālena. In time.',
   'यहाँ कोई चीज़ ज्ञान जितनी पवित्र नहीं — शब्द साफ़ होने के बारे में है, किसी चीज़ के काम लायक़ हो जाने के बारे में, पावन हो जाने के बारे में नहीं। फिर अंत, और वही ईमानदार हिस्सा है: कालेन। समय के साथ।',
   'Yahan koi cheez gyan jitni pavitra nahi — shabd saaf hone ke baare mein hai, kisi cheez ke kaam layak ho jaane ke baare mein, paavan ho jaane ke baare mein nahi. Phir ant, aur wahi imaandaar hissa hai: kalena. Samay ke saath.',
   'Three words at the end do a lot of work and all three are limits. Svayam — of their own accord, so nobody hands it over. Ātmani — in themselves, so it is not somewhere else to be fetched from. Kālena — in time, so it is not available this afternoon. A chapter that has just made the largest claim in the book about knowledge closes by saying you cannot have it yet, nobody can give it to you, and it will not arrive from outside. That is an unusually unsaleable ending and it is why the verse is worth trusting.',
   'अंत के तीन शब्द बहुत काम करते हैं और तीनों सीमाएँ हैं। स्वयं — अपने आप, यानी कोई इसे सौंप नहीं देता। आत्मनि — अपने भीतर, यानी यह कहीं और से लाने की चीज़ नहीं। कालेन — समय के साथ, यानी यह आज दोपहर उपलब्ध नहीं है। जो अध्याय अभी ज्ञान के बारे में किताब का सबसे बड़ा दावा कर चुका है वह यह कहकर ख़त्म होता है कि यह आपको अभी नहीं मिल सकता, कोई आपको दे नहीं सकता, और यह बाहर से नहीं आएगा। यह असामान्य रूप से न बिकने वाला अंत है और इसीलिए इस श्लोक पर भरोसा करने लायक़ है।',
   'Ant ke teen shabd bahut kaam karte hain aur teenon seemayein hain. Svayam — apne aap, yani koi ise saunp nahi deta. Atmani — apne bheetar, yani yeh kahin aur se laane ki cheez nahi. Kalena — samay ke saath, yani yeh aaj dopahar uplabdh nahi hai. Jo adhyay abhi gyan ke baare mein kitaab ka sabse bada dawa kar chuka hai woh yeh kehkar khatam hota hai ki yeh tumhe abhi nahi mil sakta, koi tumhe de nahi sakta, aur yeh bahar se nahi aayega. Yeh asamanya roop se na bikne wala ant hai aur isiliye is shloka par bharosa karne layak hai.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 4;

-- =====================================================================
-- 3. HOOKS, REFLECTIONS, PRACTICES, TOPICS
-- =====================================================================
-- THE 4.13 REFLECTIONS AND PRACTICE ARE STRUCTURAL. They ask the reader
-- about criteria stated versus criteria applied, which is the shape of
-- the verse's problem and is checkable in the reader's own life. Not one
-- of them asks the reader what they think about caste, invites them to
-- take a position on it, or offers them a comfortable conclusion.
--
-- The 4.8 practice is about noticing who a sentence licenses, because
-- that is the whole defence against how that verse gets used.
-- =====================================================================

DELETE m FROM verse_memory_aids m JOIN verses v ON v.id = m.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 4;
DELETE r FROM verse_reflections r JOIN verses v ON v.id = r.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 4;
DELETE p FROM verse_practices p JOIN verses v ON v.id = p.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 4;
DELETE vt FROM verse_topics vt JOIN verses v ON v.id = vt.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 4;

INSERT INTO verse_memory_aids (verse_id, hook_en, hook_hi, hook_hinglish, analogy_en, analogy_hi, analogy_hinglish, visual_cue)
SELECT v.id, m.h_en, m.h_hi, m.h_hing, m.a_en, m.a_hi, m.a_hing, m.cue FROM (
  SELECT 7 AS vn,
  'Glāni is sagging, not defeat. Something losing its tension.' AS h_en,
  'ग्लानि ढीला पड़ना है, हार नहीं। किसी चीज़ का कसाव खोना।' AS h_hi,
  'Glani dheela padna hai, haar nahi. Kisi cheez ka kasav khona.' AS h_hing,
  'Like a rope that is still tied and no longer taut. Nobody cut it.' AS a_en,
  'उस रस्सी जैसा जो बँधी तो है और कसी नहीं रही। किसी ने उसे काटा नहीं।' AS a_hi,
  'Us rassi jaisa jo bandhi to hai aur kasi nahi rahi. Kisi ne use kaata nahi.' AS a_hing,
  'A rope, tied, slack' AS cue

  UNION ALL SELECT 8,
  'Every verb is first person. Nobody in the book is told to do it.',
  'हर क्रिया उत्तम पुरुष में है। किताब में किसी से यह करने को नहीं कहा गया।',
  'Har kriya uttam purush mein hai. Kitaab mein kisi se yeh karne ko nahi kaha gaya.',
  'Like a sign that says "staff only" and is then quoted by customers.',
  'उस सूचना जैसी जिस पर लिखा है "सिर्फ़ कर्मचारी" और जिसे ग्राहक उद्धृत करने लगें।',
  'Us soochna jaisi jis par likha hai "sirf karmchari" aur jise grahak uddhrit karne lagein.',
  'A door marked with one word'

  UNION ALL SELECT 11,
  'However people come, that is how they are met. No entry condition.',
  'लोग जैसे भी आएँ, उनसे वैसे ही मिला जाता है। भीतर आने की कोई शर्त नहीं।',
  'Log jaise bhi aayein, unse waise hi mila jaata hai. Bheetar aane ki koi shart nahi.',
  'Like a door that opens the same for everybody who pushes it.',
  'उस दरवाज़े जैसा जो हर धकेलने वाले के लिए एक-सा खुलता है।',
  'Us darwaze jaisa jo har dhakelne wale ke liye ek-sa khulta hai.',
  'One door, many approaches'

  UNION ALL SELECT 13,
  'The criterion it states is quality and action. Birth is not the word in the line.',
  'यह जो कसौटी बताता है वह गुण और कर्म है। जन्म इस पंक्ति का शब्द नहीं है।',
  'Yeh jo kasauti batata hai woh gun aur karm hai. Janm is pankti ka shabd nahi hai.',
  'Like a rule written one way and applied another for four hundred years.',
  'उस नियम जैसा जो लिखा एक तरह गया और चार सौ साल दूसरी तरह लगाया गया।',
  'Us niyam jaisa jo likha ek tarah gaya aur chaar sau saal doosri tarah lagaya gaya.',
  'One line of text, many margins'

  UNION ALL SELECT 18,
  'Not doing something is also something you are doing.',
  'कुछ न करना भी वह चीज़ है जो आप कर रहे हैं।',
  'Kuch na karna bhi woh cheez hai jo tum kar rahe ho.',
  'Like an unanswered message. Everybody involved knows an answer was given.',
  'बिना जवाब वाले संदेश जैसा। इसमें शामिल हर किसी को पता है कि जवाब दे दिया गया।',
  'Bina jawab wale sandesh jaisa. Isme shamil har kisi ko pata hai ki jawab de diya gaya.',
  'A phone screen, nothing typed'

  UNION ALL SELECT 20,
  'Fully in the work, with nothing propped underneath it.',
  'पूरी तरह काम में, और नीचे कोई सहारा लगाए बिना।',
  'Poori tarah kaam mein, aur neeche koi sahara lagaye bina.',
  'Like a wall standing without the scaffolding it was built with.',
  'उस दीवार जैसी जो उस पाड़ के बिना खड़ी है जिससे वह बनी थी।',
  'Us deewar jaisi jo us paad ke bina khadi hai jisse woh bani thi.',
  'A finished wall, no scaffold'

  UNION ALL SELECT 34,
  'The middle word is asking. All the way round the thing.',
  'बीच वाला शब्द है पूछना। चीज़ के चारों तरफ़ से।',
  'Beech wala shabd hai poochhna. Cheez ke chaaron taraf se.',
  'Like walking round a car before buying it. Nobody calls that rude.',
  'गाड़ी ख़रीदने से पहले उसके चारों तरफ़ घूमने जैसा। इसे कोई बदतमीज़ी नहीं कहता।',
  'Gaadi khareedne se pehle uske chaaron taraf ghoomne jaisa. Ise koi badtameezi nahi kehta.',
  'A circle walked around one object'

  UNION ALL SELECT 38,
  'In time, in yourself, of your own accord. Three limits, at the end.',
  'समय के साथ, अपने भीतर, अपने आप। अंत में तीन सीमाएँ।',
  'Samay ke saath, apne bheetar, apne aap. Ant mein teen seemayein.',
  'Like being told the fruit is good and it ripens in August.',
  'यह बताए जाने जैसा कि फल अच्छा है और वह अगस्त में पकता है।',
  'Yeh bataye jaane jaisa ki phal achha hai aur woh August mein pakta hai.',
  'A calendar, one month circled'
) AS m
JOIN verses v ON v.verse_number = m.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 4;

INSERT INTO verse_reflections (verse_id, question_en, question_hi, question_hinglish, display_order)
SELECT v.id, r.q_en, r.q_hi, r.q_hing, r.ord FROM (
  SELECT 7 AS vn, 'What in your life has gone slack rather than gone wrong?' AS q_en, 'आपकी ज़िंदगी में क्या बिगड़ा नहीं, ढीला पड़ा है?' AS q_hi, 'Tumhari zindagi mein kya bigda nahi, dheela pada hai?' AS q_hing, 1 AS ord
  UNION ALL SELECT 7, 'Sagging has no single day attached to it. Does that make it harder to notice?', 'ढीला पड़ने के साथ कोई एक दिन जुड़ा नहीं होता। क्या इससे उसे पकड़ना मुश्किल हो जाता है?', 'Dheela padne ke saath koi ek din juda nahi hota. Kya isse use pakadna mushkil ho jaata hai?', 2
  UNION ALL SELECT 7, 'Where did somebody put themselves back into something of yours?', 'कहाँ किसी ने आपकी किसी चीज़ में ख़ुद को दोबारा उतारा?', 'Kahan kisi ne tumhari kisi cheez mein khud ko dobara utara?', 3
  UNION ALL SELECT 8, 'Whose sentence is this? Read the verbs and answer.', 'यह वाक्य किसका है? क्रियाएँ पढ़िए और जवाब दीजिए।', 'Yeh vakya kiska hai? Kriyayein padho aur jawab do.', 1
  UNION ALL SELECT 8, 'Arjuna asked for a reason to fight. Why do you think he was never given this one?', 'अर्जुन ने लड़ने की वजह माँगी थी। आपको क्या लगता है उसे यह वजह कभी क्यों नहीं दी गई?', 'Arjun ne ladne ki wajah maangi thi. Tumhe kya lagta hai use yeh wajah kabhi kyun nahi di gayi?', 2
  UNION ALL SELECT 8, 'Where have you seen a first-person sentence quoted as an instruction?', 'आपने कहाँ देखा है कि उत्तम पुरुष का वाक्य हिदायत की तरह उद्धृत हो रहा हो?', 'Tumne kahan dekha hai ki uttam purush ka vakya hidayat ki tarah uddhrit ho raha ho?', 3
  UNION ALL SELECT 11, 'Which of these two verses — 4.8 or 4.11 — have you seen printed on something?', 'इन दो में से कौन-सा श्लोक — 4.8 या 4.11 — आपने किसी चीज़ पर छपा देखा है?', 'In do mein se kaun sa shloka — 4.8 ya 4.11 — tumne kisi cheez par chhapa dekha hai?', 1
  UNION ALL SELECT 11, 'The verse sets no entry condition. Where do you set one without meaning to?', 'श्लोक भीतर आने की कोई शर्त नहीं रखता। आप बिना इरादे के कहाँ शर्त रख देते हैं?', 'Shloka bheetar aane ki koi shart nahi rakhta. Tum bina iraade ke kahan shart rakh dete ho?', 2
  UNION ALL SELECT 11, 'What would a book that said this NOT be able to be run as?', 'जो किताब यह कहती है, उसे किस तरह नहीं चलाया जा सकता?', 'Jo kitaab yeh kehti hai, use kis tarah nahi chalaya ja sakta?', 3
  UNION ALL SELECT 13, 'Where does a rule you live under state one criterion and get applied by another?', 'आप जिस नियम के तहत रहते हैं, वह कहाँ एक कसौटी बताता है और लगाया दूसरी से जाता है?', 'Tum jis niyam ke tahat rehte ho, woh kahan ek kasauti batata hai aur lagaya doosri se jaata hai?', 1
  UNION ALL SELECT 13, 'Pointing at what a text says is true. When is it not enough?', 'किसी ग्रंथ में क्या लिखा है, उसकी तरफ़ इशारा करना सच है। यह कब काफ़ी नहीं होता?', 'Kisi granth mein kya likha hai, uski taraf ishara karna sach hai. Yeh kab kaafi nahi hota?', 2
  UNION ALL SELECT 13, 'The book argues with itself here. Is a book that does that easier or harder to trust?', 'यहाँ किताब ख़ुद से बहस करती है। जो किताब ऐसा करे, उस पर भरोसा करना आसान है या मुश्किल?', 'Yahan kitaab khud se behes karti hai. Jo kitaab aisa kare, us par bharosa karna aasan hai ya mushkil?', 3
  UNION ALL SELECT 18, 'What are you currently not deciding? Name it as a decision.', 'अभी आप क्या तय नहीं कर रहे? उसे फ़ैसले की तरह नाम दीजिए।', 'Abhi tum kya tay nahi kar rahe? Use faisle ki tarah naam do.', 1
  UNION ALL SELECT 18, 'Who is carrying the cost of something you have not done?', 'जो आपने नहीं किया, उसकी क़ीमत कौन उठा रहा है?', 'Jo tumne nahi kiya, uski keemat kaun utha raha hai?', 2
  UNION ALL SELECT 18, 'Which half of this verse did you notice first?', 'इस श्लोक का कौन-सा आधा आपको पहले दिखा?', 'Is shloka ka kaun sa aadha tumhe pehle dikha?', 3
  UNION ALL SELECT 20, 'What is propped under your work? Name one support.', 'आपके काम के नीचे क्या लगा हुआ है? एक सहारा बताइए।', 'Tumhare kaam ke neeche kya laga hua hai? Ek sahara batao.', 1
  UNION ALL SELECT 20, 'If that support went, would the work go with it?', 'अगर वह सहारा हट जाए, तो क्या काम भी उसके साथ चला जाएगा?', 'Agar woh sahara hat jaaye, to kya kaam bhi uske saath chala jayega?', 2
  UNION ALL SELECT 20, 'The verse insists he is fully in it. Why say that first?', 'श्लोक ज़ोर देता है कि वह पूरी तरह उसी में है। यह पहले क्यों कहा गया?', 'Shloka zor deta hai ki woh poori tarah usi mein hai. Yeh pehle kyun kaha gaya?', 3
  UNION ALL SELECT 34, 'Who could you ask? Not read — ask.', 'आप किससे पूछ सकते हैं? पढ़ नहीं — पूछ।', 'Tum kisse poochh sakte ho? Padh nahi — poochh.', 1
  UNION ALL SELECT 34, 'What have you accepted without going all the way round it?', 'आपने क्या मान लिया है बिना उसके चारों तरफ़ घूमे?', 'Tumne kya maan liya hai bina uske chaaron taraf ghoome?', 2
  UNION ALL SELECT 34, 'Asking sits between two forms of deference here. What is that arrangement saying?', 'यहाँ पूछना विनय के दो रूपों के बीच बैठा है। यह इंतज़ाम क्या कह रहा है?', 'Yahan poochhna vinay ke do roopon ke beech baitha hai. Yeh intezaam kya keh raha hai?', 3
  UNION ALL SELECT 38, 'What have you understood that took years and could not have been told to you?', 'आपने क्या समझा है जिसमें साल लगे और जो आपको बताया नहीं जा सकता था?', 'Tumne kya samjha hai jisme saal lage aur jo tumhe bataya nahi ja sakta tha?', 1
  UNION ALL SELECT 38, 'The verse says not this afternoon. Does that make it easier or harder to keep going?', 'श्लोक कहता है आज दोपहर नहीं। इससे चलते रहना आसान होता है या मुश्किल?', 'Shloka kehta hai aaj dopahar nahi. Isse chalte rehna aasan hota hai ya mushkil?', 2
  UNION ALL SELECT 38, 'Nobody can hand it over. What does that rule out as a plan?', 'कोई इसे सौंप नहीं सकता। यह किस योजना को ख़ारिज कर देता है?', 'Koi ise saunp nahi sakta. Yeh kis yojna ko khaarij kar deta hai?', 3
) AS r
JOIN verses v ON v.verse_number = r.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 4;

INSERT INTO verse_practices (verse_id, action_en, action_hi, action_hinglish, estimated_minutes, difficulty, display_order)
SELECT v.id, p.a_en, p.a_hi, p.a_hing, p.mins, p.diff, 1 FROM (
  SELECT 7 AS vn, 'Name one thing that has gone slack. Do the smallest thing that would put some tension back in it.' AS a_en, 'ऐसी एक चीज़ बताइए जो ढीली पड़ गई है। सबसे छोटी वह चीज़ कीजिए जो उसमें थोड़ा कसाव लौटा दे।' AS a_hi, 'Aisi ek cheez batao jo dheeli pad gayi hai. Sabse chhoti woh cheez karo jo usme thoda kasav lauta de.' AS a_hing, 10 AS mins, 'beginner' AS diff
  UNION ALL SELECT 8, 'Take any quotation you have seen used to justify something. Check who the verbs belong to. That is the whole exercise.' AS a_en, 'कोई भी ऐसा उद्धरण लीजिए जो किसी चीज़ को जायज़ ठहराने के लिए इस्तेमाल होते देखा हो। जाँचिए कि क्रियाएँ किसकी हैं। पूरा अभ्यास बस इतना है।' AS a_hi, 'Koi bhi aisa uddharan lo jo kisi cheez ko jayaz thehrane ke liye istemaal hote dekha ho. Jaancho ki kriyayein kiski hain. Poora abhyas bas itna hai.' AS a_hing, 5 AS mins, 'intermediate' AS diff
  UNION ALL SELECT 11, 'Think of somebody who approaches something you care about differently from you. Do not correct them this week.', 'ऐसे किसी के बारे में सोचिए जो आपकी किसी प्रिय चीज़ के पास आपसे अलग तरीक़े से आता है। इस हफ़्ते उसे मत सुधारिए।', 'Aise kisi ke baare mein socho jo tumhari kisi priya cheez ke paas tumse alag tareeke se aata hai. Is hafte use mat sudharo.', 7, 'intermediate'
  UNION ALL SELECT 13, 'Find one rule where you can read the stated criterion and also see how it gets applied. Write both down. Do not resolve them.', 'ऐसा एक नियम ढूँढ़िए जिसकी कही हुई कसौटी आप पढ़ सकें और यह भी देख सकें कि वह लगाया कैसे जाता है। दोनों लिखिए। इन्हें सुलझाइए मत।', 'Aisa ek niyam dhoondho jiski kahi hui kasauti tum padh sako aur yeh bhi dekh sako ki woh lagaya kaise jaata hai. Dono likho. Inhe suljhao mat.', 12, 'advanced'
  UNION ALL SELECT 18, 'Write down one thing you are not doing. Put a date on when you started not doing it.', 'एक चीज़ लिखिए जो आप नहीं कर रहे। लिखिए कि आपने उसे न करना कब से शुरू किया।', 'Ek cheez likho jo tum nahi kar rahe. Likho ki tumne use na karna kab se shuru kiya.', 5, 'beginner'
  UNION ALL SELECT 20, 'Do one piece of work today and tell nobody it is done. Notice what wanted to be told.', 'आज एक काम कीजिए और किसी को मत बताइए कि वह हो गया। ध्यान दीजिए कि बताना क्या चाहता था।', 'Aaj ek kaam karo aur kisi ko mat batao ki woh ho gaya. Dhyan do ki batana kya chahta tha.', 10, 'intermediate'
  UNION ALL SELECT 34, 'Ask one person who knows more than you a question you have been embarrassed to ask.', 'ऐसे एक इंसान से जो आपसे ज़्यादा जानता है, वह सवाल पूछिए जो पूछने में आपको शर्म आती रही है।', 'Aise ek insan se jo tumse zyada jaanta hai, woh sawal poochho jo poochhne mein tumhe sharm aati rahi hai.', 15, 'intermediate'
  UNION ALL SELECT 38, 'Name one thing you understand now that you could not have been told five years ago.', 'एक चीज़ बताइए जो आप अब समझते हैं और जो पाँच साल पहले आपको बताई नहीं जा सकती थी।', 'Ek cheez batao jo tum ab samajhte ho aur jo paanch saal pehle tumhe batai nahi ja sakti thi.', 8, 'beginner'
) AS p
JOIN verses v ON v.verse_number = p.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 4;

INSERT INTO verse_topics (verse_id, topic_id, relevance)
SELECT v.id, t.id, x.rel FROM (
  SELECT 7 AS vn, 'impermanence' AS slug, 9 AS rel
  UNION ALL SELECT 7, 'duty', 7
  UNION ALL SELECT 7, 'steadiness', 6
  UNION ALL SELECT 8, 'duty', 8
  UNION ALL SELECT 8, 'anger', 7
  UNION ALL SELECT 8, 'hard-decisions', 6
  UNION ALL SELECT 11, 'comparison', 9
  UNION ALL SELECT 11, 'the-self', 7
  UNION ALL SELECT 11, 'duty', 6
  UNION ALL SELECT 13, 'comparison', 10
  UNION ALL SELECT 13, 'duty', 9
  UNION ALL SELECT 13, 'the-self', 7
  UNION ALL SELECT 13, 'hard-decisions', 6
  UNION ALL SELECT 18, 'action-without-attachment', 10
  UNION ALL SELECT 18, 'hard-decisions', 9
  UNION ALL SELECT 18, 'duty', 7
  UNION ALL SELECT 20, 'action-without-attachment', 10
  UNION ALL SELECT 20, 'effort-without-result', 9
  UNION ALL SELECT 20, 'comparison', 7
  UNION ALL SELECT 20, 'burnout', 6
  UNION ALL SELECT 34, 'comparison', 8
  UNION ALL SELECT 34, 'hard-decisions', 7
  UNION ALL SELECT 34, 'the-self', 6
  UNION ALL SELECT 38, 'effort-without-result', 9
  UNION ALL SELECT 38, 'steadiness', 8
  UNION ALL SELECT 38, 'the-self', 7
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 4
JOIN topics t ON t.slug = x.slug;

-- =====================================================================
-- 4. MODERN EXAMPLES
-- =====================================================================
-- Four per verse, four distinct categories per verse, THIRTY-TWO total.
--
-- NOT ONE EXAMPLE IN THIS FILE NAMES A CASTE, A COMMUNITY, A RELIGION
-- OR A REGION. The 4.13 set is structural: every one of the four is a
-- situation where a rule states one criterion and is applied by
-- another, which is the shape of the verse's problem and is checkable
-- in any reader's own life. None of them lets the reader finish feeling
-- that they are on the right side of it.
--
-- THE 4.8 SET IS ABOUT WHO A SENTENCE LICENSES. In all four, somebody
-- notices that a first-person statement has been picked up as an
-- instruction, and in none of them is the reader shown a designated
-- wrongdoer.
-- =====================================================================

DELETE e FROM modern_examples e JOIN verses v ON v.id = e.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 4;

INSERT INTO modern_examples
  (verse_id, category, title_en, title_hi, title_hinglish,
   scenario_en, scenario_hi, scenario_hinglish,
   connection_en, connection_hi, connection_hinglish,
   lesson_en, lesson_hi, lesson_hinglish,
   source_reference, has_spoiler, difficulty, tags, is_ai_generated, approved, sort_order)
SELECT v.id, x.cat, x.t_en, x.t_hi, x.t_hing, x.s_en, x.s_hi, x.s_hing,
       x.c_en, x.c_hi, x.c_hing, x.l_en, x.l_hi, x.l_hing,
       x.src, 0, x.diff, x.tags, 0, 1, x.ord
FROM (

  SELECT 7 AS vn, 'corporate' AS cat, 1 AS ord,
  'Nobody could name the day it changed' AS t_en, 'कोई वह दिन नहीं बता सका जब यह बदला' AS t_hi, 'Koi woh din nahi bata saka jab yeh badla' AS t_hing,
  'A team that used to cover for each other stops, over about eight months. No argument, no incident, no departure. Asked when it changed, six people give six different answers and none of them is a date.' AS s_en,
  'एक टीम जो पहले एक-दूसरे को संभाल लेती थी, क़रीब आठ महीनों में यह करना बंद कर देती है। न कोई झगड़ा, न कोई घटना, न कोई गया। यह कब बदला, पूछने पर छह लोग छह अलग जवाब देते हैं और उनमें से कोई तारीख़ नहीं है।' AS s_hi,
  'Ek team jo pehle ek doosre ko sambhal leti thi, kareeb aath mahinon mein yeh karna band kar deti hai. Na koi jhagda, na koi ghatna, na koi gaya. Yeh kab badla, poochhne par chhah log chhah alag jawab dete hain aur unme se koi tareekh nahi hai.' AS s_hing,
  'Glāni is the word and it means exactly this. Not a defeat, not a collapse, not a betrayal — a loss of tension in something that is still standing. The verse is usually read at the scale of ages; the word does not require it, and this is what it looks like at the scale of eight months.' AS c_en,
  'शब्द है ग्लानि और उसका मतलब ठीक यही है। हार नहीं, ढहना नहीं, दग़ा नहीं — किसी ऐसी चीज़ में कसाव का जाना जो अब भी खड़ी है। श्लोक आमतौर पर युगों के नाप पर पढ़ा जाता है; शब्द इसकी माँग नहीं करता, और आठ महीनों के नाप पर वह ऐसा दिखता है।' AS c_hi,
  'Shabd hai glani aur uska matlab theek yahi hai. Haar nahi, dhehna nahi, daga nahi — kisi aisi cheez mein kasav ka jaana jo ab bhi khadi hai. Shloka aam taur par yugon ke naap par padha jaata hai; shabd iski maang nahi karta, aur aath mahinon ke naap par woh aisa dikhta hai.' AS c_hing,
  'No incident, no date, and it is gone. That is what the word means.' AS l_en,
  'न कोई घटना, न कोई तारीख़, और वह जा चुका है। शब्द का मतलब यही है।' AS l_hi,
  'Na koi ghatna, na koi tareekh, aur woh ja chuka hai. Shabd ka matlab yahi hai.' AS l_hing,
  NULL AS src, 'beginner' AS diff, 'work,teams,slackening,gradual' AS tags

  UNION ALL SELECT 7, 'everyday_life', 2,
  'The friendship that got shorter', 'वह दोस्ती जो छोटी होती गई', 'Woh dosti jo chhoti hoti gayi',
  'Two friends of twenty years notice that their messages have got shorter every year for four years. Nothing went wrong. Neither of them is annoyed with the other. One of them books a train.',
  'बीस साल के दो दोस्त देखते हैं कि उनके संदेश चार साल से हर साल छोटे होते गए हैं। कुछ बिगड़ा नहीं। दोनों में से कोई दूसरे से नाराज़ नहीं है। उनमें से एक ट्रेन की टिकट ले लेता है।',
  'Bees saal ke do dost dekhte hain ki unke sandesh chaar saal se har saal chhote hote gaye hain. Kuch bigda nahi. Dono mein se koi doosre se naraaz nahi hai. Unme se ek train ki ticket le leta hai.',
  'The verse pairs a sagging with something putting itself back in. That is the whole structure and it does not require anybody heroic — a train ticket is the ordinary form of putting yourself out into something that has gone slack.',
  'श्लोक ढीले पड़ने के साथ किसी चीज़ के ख़ुद को दोबारा उतारने को जोड़ता है। पूरी बनावट यही है और इसके लिए किसी वीर की ज़रूरत नहीं — किसी ढीली पड़ी चीज़ में ख़ुद को उतारने का आम रूप ट्रेन की टिकट है।',
  'Shloka dheele padne ke saath kisi cheez ke khud ko dobara utaarne ko jodta hai. Poori banawat yahi hai aur iske liye kisi veer ki zaroorat nahi — kisi dheeli padi cheez mein khud ko utaarne ka aam roop train ki ticket hai.',
  'Nothing went wrong. Somebody booked a train.',
  'कुछ बिगड़ा नहीं। किसी ने ट्रेन की टिकट ले ली।',
  'Kuch bigda nahi. Kisi ne train ki ticket le li.',
  NULL, 'beginner', 'friendship,drift,repair,ordinary'

  UNION ALL SELECT 7, 'sports', 3,
  'Standards nobody lowered', 'वे मानक जो किसी ने नहीं गिराए', 'Woh maanak jo kisi ne nahi giraye',
  'A club with a strong training culture finds that after two seasons people are arriving four minutes late and leaving five minutes early. Nobody decided this. The coach does not give a speech; he starts arriving twenty minutes early himself.',
  'मज़बूत अभ्यास संस्कृति वाले एक क्लब में दो सीज़न बाद लोग चार मिनट देर से आने और पाँच मिनट पहले जाने लगते हैं। यह किसी ने तय नहीं किया। कोच कोई भाषण नहीं देता; वह ख़ुद बीस मिनट पहले आने लगता है।',
  'Mazboot abhyas sanskriti wale ek club mein do season baad log chaar minute der se aane aur paanch minute pehle jaane lagte hain. Yeh kisi ne tay nahi kiya. Coach koi bhashan nahi deta; woh khud bees minute pehle aane lagta hai.',
  'Four minutes is what glāni looks like when you measure it. The verse says what happens next is that something puts itself back into the situation, and the grammar is worth noticing: the verse does not say something is sent, it says I put myself out into it.',
  'चार मिनट वह है जो ग्लानि नापने पर दिखती है। श्लोक कहता है कि आगे यह होता है कि कोई चीज़ ख़ुद को उस हालत में दोबारा उतार देती है, और व्याकरण देखने लायक़ है: श्लोक यह नहीं कहता कि कुछ भेजा जाता है, वह कहता है कि मैं ख़ुद को उसमें उतार देता हूँ।',
  'Chaar minute woh hai jo glani naapne par dikhti hai. Shloka kehta hai ki aage yeh hota hai ki koi cheez khud ko us haalat mein dobara utaar deti hai, aur vyakaran dekhne layak hai: shloka yeh nahi kehta ki kuch bheja jaata hai, woh kehta hai ki main khud ko usme utaar deta hoon.',
  'He did not give a speech. He put himself back into it.',
  'उसने भाषण नहीं दिया। उसने ख़ुद को दोबारा उसमें उतार दिया।',
  'Usne bhashan nahi diya. Usne khud ko dobara usme utaar diya.',
  NULL, 'beginner', 'sport,standards,example,drift'

  UNION ALL SELECT 7, 'parenting', 4,
  'The table nobody eats at', 'वह मेज़ जिस पर कोई नहीं खाता', 'Woh mez jis par koi nahi khata',
  'A family that ate together every evening now eats together about once a fortnight. It happened over three years through work, exams and a longer commute. Nobody chose it and everybody misses it, separately, without saying so.',
  'एक परिवार जो हर शाम साथ खाता था अब पखवाड़े में एक बार साथ खाता है। यह तीन साल में काम, परीक्षाओं और लंबे सफ़र से हुआ। किसी ने इसे चुना नहीं और सबको इसकी कमी खलती है, अलग-अलग, बिना कहे।',
  'Ek parivar jo har shaam saath khata tha ab pakhwade mein ek baar saath khata hai. Yeh teen saal mein kaam, parikshaon aur lambe safar se hua. Kisi ne ise chuna nahi aur sabko iski kami khalti hai, alag alag, bina kahe.',
  'A slackening that everybody involved regrets and nobody caused is the exact case the word covers. The useful part is that the verse pairs it with a re-entry rather than with a diagnosis — it does not ask whose fault this was, and neither does the family that fixes it.',
  'ऐसा ढीला पड़ना जिसका सबको अफ़सोस है और जो किसी ने किया नहीं, ठीक वही मामला है जिसे यह शब्द ढकता है। काम की बात यह है कि श्लोक इसे निदान से नहीं, दोबारा उतरने से जोड़ता है — वह यह नहीं पूछता कि दोष किसका था, और जो परिवार इसे ठीक करता है वह भी नहीं पूछता।',
  'Aisa dheela padna jiska sabko afsos hai aur jo kisi ne kiya nahi, theek wahi mamla hai jise yeh shabd dhakta hai. Kaam ki baat yeh hai ki shloka ise nidan se nahi, dobara utarne se jodta hai — woh yeh nahi poochhta ki dosh kiska tha, aur jo parivar ise theek karta hai woh bhi nahi poochhta.',
  'The verse does not ask whose fault it was. Neither does the family that fixes it.',
  'श्लोक नहीं पूछता कि दोष किसका था। जो परिवार इसे ठीक करता है वह भी नहीं पूछता।',
  'Shloka nahi poochhta ki dosh kiska tha. Jo parivar ise theek karta hai woh bhi nahi poochhta.',
  NULL, 'beginner', 'family,routine,drift,repair'

  UNION ALL SELECT 8, 'ethics', 1,
  'Who the sentence belongs to', 'वाक्य किसका है', 'Vakya kiska hai',
  'Somebody is shown a quotation being used to justify treating a group of people badly. Instead of arguing about the sentiment, they read the sentence again and count the verbs. All of them belong to the speaker. None of them is addressed to anybody.',
  'किसी को एक उद्धरण दिखाया जाता है जिसका इस्तेमाल कुछ लोगों के साथ बुरा बरताव जायज़ ठहराने में हो रहा है। भावना पर बहस करने के बजाय वह वाक्य दोबारा पढ़ता है और क्रियाएँ गिनता है। सारी वक्ता की हैं। एक भी किसी को संबोधित नहीं है।',
  'Kisi ko ek uddharan dikhaya jaata hai jiska istemaal kuch logon ke saath bura bartav jayaz thehrane mein ho raha hai. Bhavna par behes karne ke bajaye woh vakya dobara padhta hai aur kriyayein ginta hai. Saari vakta ki hain. Ek bhi kisi ko sambodhit nahi hai.',
  'This is the whole defence and it costs nothing. 4.8 is first person throughout: I come into being, and here is what I do. It licenses nobody, and the strongest evidence is that Arjuna asked directly for a reason to fight and was never given this one in seven hundred verses.',
  'यही पूरा बचाव है और इसमें कुछ ख़र्च नहीं होता। 4.8 पूरा उत्तम पुरुष में है: मैं आता हूँ, और मैं यह करता हूँ। यह किसी को छूट नहीं देता, और सबसे बड़ा सबूत यह है कि अर्जुन ने सीधे लड़ने की वजह माँगी थी और सात सौ श्लोकों में उसे यह वजह कभी नहीं दी गई।',
  'Yahi poora bachav hai aur isme kuch kharch nahi hota. 4.8 poora uttam purush mein hai: main aata hoon, aur main yeh karta hoon. Yeh kisi ko chhoot nahi deta, aur sabse bada saboot yeh hai ki Arjun ne seedhe ladne ki wajah maangi thi aur saat sau shlokon mein use yeh wajah kabhi nahi di gayi.',
  'Count the verbs. All of them belong to the speaker and none is addressed to anybody.',
  'क्रियाएँ गिनिए। सारी वक्ता की हैं और एक भी किसी को संबोधित नहीं है।',
  'Kriyayein gino. Saari vakta ki hain aur ek bhi kisi ko sambodhit nahi hai.',
  NULL, 'advanced', 'quotation,licence,grammar,misuse'

  UNION ALL SELECT 8, 'corporate', 2,
  'The policy that was a description', 'वह नीति जो असल में ब्यौरा थी', 'Woh neeti jo asal mein byora thi',
  'A company handbook says leadership will step in where standards slip. Two years later a team leader is cutting somebody out of meetings and citing that line. It never said anything about what a team leader does.',
  'एक कंपनी की नियमावली में लिखा है कि जहाँ मानक गिरेंगे वहाँ नेतृत्व हस्तक्षेप करेगा। दो साल बाद एक टीम लीडर किसी को मीटिंगों से बाहर कर रहा है और उसी पंक्ति का हवाला दे रहा है। उसमें यह कभी नहीं लिखा था कि टीम लीडर क्या करता है।',
  'Ek company ki niyamavali mein likha hai ki jahan maanak girenge wahan netritva hastakshep karega. Do saal baad ek team leader kisi ko meetingon se bahar kar raha hai aur usi pankti ka hawala de raha hai. Usme yeh kabhi nahi likha tha ki team leader kya karta hai.',
  'The same move at office scale, and it is easier to see there because nobody is emotionally invested in a handbook. A sentence about what one party does gets picked up as authority by another party, and the gap is never argued for — it is just stepped across.',
  'दफ़्तर के नाप पर वही चाल, और वहाँ इसे देखना आसान है क्योंकि नियमावली से किसी का भावनात्मक लगाव नहीं होता। एक पक्ष क्या करता है, इसका वाक्य दूसरा पक्ष अधिकार की तरह उठा लेता है, और उस फ़ासले के लिए कभी दलील नहीं दी जाती — उसे बस लाँघ लिया जाता है।',
  'Daftar ke naap par wahi chaal, aur wahan ise dekhna aasan hai kyunki niyamavali se kisi ka bhavnatmak lagav nahi hota. Ek paksh kya karta hai, iska vakya doosra paksh adhikar ki tarah utha leta hai, aur us faasle ke liye kabhi dalil nahi di jaati — use bas laangh liya jaata hai.',
  'The gap is never argued for. It is just stepped across.',
  'उस फ़ासले के लिए दलील कभी नहीं दी जाती। उसे बस लाँघ लिया जाता है।',
  'Us faasle ke liye dalil kabhi nahi di jaati. Use bas laangh liya jaata hai.',
  NULL, 'intermediate', 'work,authority,quoting,overreach'

  UNION ALL SELECT 8, 'social_media', 3,
  'Two lines under a photograph', 'तस्वीर के नीचे दो पंक्तियाँ', 'Tasveer ke neeche do panktiyan',
  'Somebody sees this verse posted under an image with the first half cut off. The half that is missing is the one where the speaker says who is speaking. It gets shared four thousand times in that form.',
  'कोई इस श्लोक को एक तस्वीर के नीचे लगा देखता है जिसमें पहला आधा काट दिया गया है। जो आधा ग़ायब है वही है जिसमें वक्ता बताता है कि बोल कौन रहा है। उसी रूप में वह चार हज़ार बार साझा होता है।',
  'Koi is shloka ko ek tasveer ke neeche laga dekhta hai jisme pehla aadha kaat diya gaya hai. Jo aadha gayab hai wahi hai jisme vakta batata hai ki bol kaun raha hai. Usi roop mein woh chaar hazaar baar sajha hota hai.',
  'Cutting the attribution is what makes the misuse possible, and it is worth knowing that this is the specific edit to look for. The verse is a sentence with a subject. Removing the subject turns a description into an instruction, and nothing else has to be changed.',
  'श्रेय काट देना ही दुरुपयोग को मुमकिन बनाता है, और यह जानना काम का है कि ढूँढ़ने लायक़ संपादन यही एक है। श्लोक एक वाक्य है जिसका कर्ता है। कर्ता हटा दीजिए और वर्णन हिदायत बन जाता है, और कुछ भी बदलना नहीं पड़ता।',
  'Shrey kaat dena hi durupyog ko mumkin banata hai, aur yeh jaanna kaam ka hai ki dhoondhne layak sampadan yahi ek hai. Shloka ek vakya hai jiska karta hai. Karta hata do aur varnan hidayat ban jaata hai, aur kuch bhi badalna nahi padta.',
  'Remove the subject and a description becomes an instruction. Nothing else has to change.',
  'कर्ता हटा दीजिए और वर्णन हिदायत बन जाता है। और कुछ बदलना नहीं पड़ता।',
  'Karta hata do aur varnan hidayat ban jaata hai. Aur kuch badalna nahi padta.',
  NULL, 'intermediate', 'online,quotation,attribution,editing'

  UNION ALL SELECT 8, 'everyday_life', 4,
  'The rule he made for himself', 'वह नियम जो उसने अपने लिए बनाया', 'Woh niyam jo usne apne liye banaya',
  'Somebody adopts a small habit — before repeating a quotation, find where it came from and read what surrounds it. In the first month he stops repeating three things he had been repeating for years.',
  'कोई एक छोटी आदत अपनाता है — कोई उद्धरण दोहराने से पहले पता करो कि वह आया कहाँ से और उसके आसपास क्या लिखा है। पहले महीने में वह तीन ऐसी बातें दोहराना बंद कर देता है जो वह सालों से दोहरा रहा था।',
  'Koi ek chhoti aadat apnata hai — koi uddharan dohrane se pehle pata karo ki woh aaya kahan se aur uske aas paas kya likha hai. Pehle mahine mein woh teen aisi baatein dohrana band kar deta hai jo woh saalon se dohra raha tha.',
  'The defence against this verse being misused is not an argument, it is a habit, and it is cheap. Reading what surrounds a line takes about a minute and it is the same minute that would have caught 4.8, 5.18 and 4.13 all being quoted at half length.',
  'इस श्लोक के दुरुपयोग का बचाव कोई दलील नहीं, एक आदत है, और वह सस्ती है। किसी पंक्ति के आसपास क्या है यह पढ़ने में क़रीब एक मिनट लगता है और वही एक मिनट 4.8, 5.18 और 4.13 — तीनों को आधी लंबाई में उद्धृत होते पकड़ लेता।',
  'Is shloka ke durupyog ka bachav koi dalil nahi, ek aadat hai, aur woh sasti hai. Kisi pankti ke aas paas kya hai yeh padhne mein kareeb ek minute lagta hai aur wahi ek minute 4.8, 5.18 aur 4.13 — teenon ko aadhi lambai mein uddhrit hote pakad leta.',
  'The defence is not an argument. It is a habit, and it takes a minute.',
  'बचाव कोई दलील नहीं है। वह एक आदत है, और उसमें एक मिनट लगता है।',
  'Bachav koi dalil nahi hai. Woh ek aadat hai, aur usme ek minute lagta hai.',
  NULL, 'beginner', 'quotation,habit,context,reading'

  UNION ALL SELECT 11, 'everyday_life', 1,
  'Four people at the same class', 'एक ही क्लास में चार लोग', 'Ek hi class mein chaar log',
  'Four people turn up to the same weekly class. One is there for the exercise, one for the hour out of the house, one because a doctor suggested it, one because a friend goes. The teacher treats all four the same and does not ask which is which.',
  'चार लोग एक ही साप्ताहिक क्लास में आते हैं। एक कसरत के लिए, एक घर से बाहर के उस एक घंटे के लिए, एक इसलिए कि डॉक्टर ने कहा, एक इसलिए कि दोस्त जाता है। शिक्षक चारों के साथ एक जैसा बरताव करता है और नहीं पूछता कि कौन क्यों है।',
  'Chaar log ek hi saptahik class mein aate hain. Ek kasrat ke liye, ek ghar se bahar ke us ek ghante ke liye, ek isliye ki doctor ne kaha, ek isliye ki dost jaata hai. Shikshak chaaron ke saath ek jaisa bartav karta hai aur nahi poochhta ki kaun kyun hai.',
  'However they approach, that is how they are met. The teacher is doing what the verse describes, and the reason it works is the reason the verse gives: she is not sorting the four into more and less legitimate arrivals, and it does not occur to her to.',
  'वे जैसे भी आएँ, उनसे वैसे ही मिला जाता है। शिक्षक वही कर रही है जो श्लोक बताता है, और यह इसलिए चलता है जो वजह श्लोक देता है: वह चारों को ज़्यादा और कम जायज़ आने वालों में नहीं छाँट रही, और उसे यह सूझता भी नहीं।',
  'Woh jaise bhi aayein, unse waise hi mila jaata hai. Shikshak wahi kar rahi hai jo shloka batata hai, aur yeh isliye chalta hai jo wajah shloka deta hai: woh chaaron ko zyada aur kam jayaz aane walon mein nahi chhaant rahi, aur use yeh soojhta bhi nahi.',
  'She is not sorting them into more and less legitimate arrivals. It does not occur to her to.',
  'वह उन्हें ज़्यादा और कम जायज़ आने वालों में नहीं छाँट रही। उसे यह सूझता भी नहीं।',
  'Woh unhe zyada aur kam jayaz aane walon mein nahi chhaant rahi. Use yeh soojhta bhi nahi.',
  NULL, 'beginner', 'reasons,welcome,teaching,no-conditions'

  UNION ALL SELECT 11, 'friendship', 2,
  'The two who read the same book differently', 'दो जिन्होंने एक ही किताब अलग पढ़ी', 'Do jinhone ek hi kitaab alag padhi',
  'Two friends read the same book. One takes it as literature and one takes it as instruction. They talk about it for nine years and neither converts the other, and neither of them ever suggests the other is doing it wrong.',
  'दो दोस्त एक ही किताब पढ़ते हैं। एक उसे साहित्य की तरह लेता है और एक हिदायत की तरह। वे नौ साल उस पर बात करते हैं और कोई दूसरे को बदल नहीं पाता, और कोई कभी यह नहीं कहता कि दूसरा ग़लत कर रहा है।',
  'Do dost ek hi kitaab padhte hain. Ek use sahitya ki tarah leta hai aur ek hidayat ki tarah. Woh nau saal us par baat karte hain aur koi doosre ko badal nahi pata, aur koi kabhi yeh nahi kehta ki doosra galat kar raha hai.',
  'Sarvaśaḥ — in every way, from every direction. The verse does not say the different approaches converge, and neither does the friendship. What it says is that whichever way somebody is walking, they are on it, which is a claim about the road rather than about who is right.',
  'सर्वशः — हर तरह से, हर दिशा से। श्लोक यह नहीं कहता कि अलग-अलग रास्ते मिल जाते हैं, और यह दोस्ती भी नहीं कहती। वह यह कहता है कि कोई जिस भी रास्ते चल रहा हो, वह उसी पर है, और यह दावा रास्ते के बारे में है, इस बारे में नहीं कि सही कौन है।',
  'Sarvashah — har tarah se, har disha se. Shloka yeh nahi kehta ki alag alag raaste mil jaate hain, aur yeh dosti bhi nahi kehti. Woh yeh kehta hai ki koi jis bhi raste chal raha ho, woh usi par hai, aur yeh dawa raste ke baare mein hai, is baare mein nahi ki sahi kaun hai.',
  'Neither converted the other in nine years. Neither suggested the other was doing it wrong.',
  'नौ साल में कोई दूसरे को नहीं बदल पाया। किसी ने यह नहीं कहा कि दूसरा ग़लत कर रहा है।',
  'Nau saal mein koi doosre ko nahi badal paya. Kisi ne yeh nahi kaha ki doosra galat kar raha hai.',
  NULL, 'intermediate', 'friendship,difference,reading,tolerance'

  UNION ALL SELECT 11, 'healthcare', 3,
  'The same appointment, four reasons', 'वही अपॉइंटमेंट, चार वजहें', 'Wahi appointment, chaar wajahein',
  'A clinic sees four people about the same complaint. One wants it explained, one wants it fixed, one wants to be told it is nothing, one wants somebody to sit with them for ten minutes. The doctor gives each what they came for and treats the same condition four times.',
  'एक क्लिनिक में एक ही शिकायत लेकर चार लोग आते हैं। एक चाहता है कि समझाया जाए, एक चाहता है कि ठीक किया जाए, एक चाहता है कि बता दिया जाए कि कुछ नहीं है, एक चाहता है कि कोई दस मिनट उसके साथ बैठे। डॉक्टर हर एक को वह देता है जिसके लिए वह आया था और वही बीमारी चार बार देखता है।',
  'Ek clinic mein ek hi shikayat lekar chaar log aate hain. Ek chahta hai ki samjhaya jaaye, ek chahta hai ki theek kiya jaaye, ek chahta hai ki bata diya jaaye ki kuch nahi hai, ek chahta hai ki koi das minute uske saath baithe. Doctor har ek ko woh deta hai jiske liye woh aaya tha aur wahi bimari chaar baar dekhta hai.',
  'However they approach, that is how they are met. Note that the medicine does not change — the verse is not saying the thing itself bends to whoever turns up. What changes is the meeting, and that turns out to be most of what the four came for.',
  'वे जैसे भी आएँ, उनसे वैसे ही मिला जाता है। ध्यान दीजिए कि इलाज नहीं बदलता — श्लोक यह नहीं कह रहा कि चीज़ ख़ुद हर आने वाले के हिसाब से मुड़ जाती है। जो बदलता है वह है मिलना, और चारों जिसके लिए आए थे उसका ज़्यादातर हिस्सा वही निकलता है।',
  'Woh jaise bhi aayein, unse waise hi mila jaata hai. Dhyan do ki ilaaj nahi badalta — shloka yeh nahi keh raha ki cheez khud har aane wale ke hisaab se mud jaati hai. Jo badalta hai woh hai milna, aur chaaron jiske liye aaye the uska zyadatar hissa wahi nikalta hai.',
  'The medicine did not change. The meeting did, and that was most of what they came for.',
  'इलाज नहीं बदला। मिलना बदला, और वे जिसके लिए आए थे उसका ज़्यादातर हिस्सा वही था।',
  'Ilaaj nahi badla. Milna badla, aur woh jiske liye aaye the uska zyadatar hissa wahi tha.',
  NULL, 'intermediate', 'medicine,meeting,reasons,care'

  UNION ALL SELECT 11, 'college', 4,
  'The society that stopped vetting', 'वह सोसाइटी जिसने जाँचना बंद कर दिया', 'Woh society jisne jaanchna band kar diya',
  'A student society used to ask people why they wanted to join. They stop asking. Membership doubles, and the people who turn out to do the most work are, in three cases out of five, people whose stated reason would have been thought weak.',
  'एक छात्र सोसाइटी पहले पूछती थी कि लोग शामिल क्यों होना चाहते हैं। वे पूछना बंद कर देते हैं। सदस्यता दोगुनी हो जाती है, और जो लोग सबसे ज़्यादा काम करते निकलते हैं, उनमें पाँच में से तीन मामलों में वे हैं जिनकी बताई वजह कमज़ोर मानी जाती।',
  'Ek student society pehle poochhti thi ki log shamil kyun hona chahte hain. Woh poochhna band kar dete hain. Sadasyata dugni ho jaati hai, aur jo log sabse zyada kaam karte nikalte hain, unme paanch mein se teen mamlon mein woh hain jinki batai wajah kamzor maani jaati.',
  'The verse sets no entry condition and this is what removing one costs and pays. The society was not being unkind before; it was applying a criterion it believed in. Three out of five is the sort of number that makes the verse an empirical claim rather than only a generous one.',
  'श्लोक भीतर आने की कोई शर्त नहीं रखता और शर्त हटाने का ख़र्च और फ़ायदा यह है। सोसाइटी पहले निर्दयी नहीं थी; वह एक ऐसी कसौटी लगा रही थी जिस पर उसे भरोसा था। पाँच में तीन वह आँकड़ा है जो श्लोक को सिर्फ़ उदार नहीं, अनुभव से जाँचने लायक़ दावा बना देता है।',
  'Shloka bheetar aane ki koi shart nahi rakhta aur shart hatane ka kharch aur fayda yeh hai. Society pehle nirdayi nahi thi; woh ek aisi kasauti laga rahi thi jis par use bharosa tha. Paanch mein teen woh aankda hai jo shloka ko sirf udaar nahi, anubhav se jaanchne layak dawa bana deta hai.',
  'They were not being unkind. They were applying a criterion they believed in.',
  'वे निर्दयी नहीं थे। वे एक ऐसी कसौटी लगा रहे थे जिस पर उन्हें भरोसा था।',
  'Woh nirdayi nahi the. Woh ek aisi kasauti laga rahe the jis par unhe bharosa tha.',
  NULL, 'intermediate', 'students,entry,criteria,openness'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 4;

INSERT INTO modern_examples
  (verse_id, category, title_en, title_hi, title_hinglish,
   scenario_en, scenario_hi, scenario_hinglish,
   connection_en, connection_hi, connection_hinglish,
   lesson_en, lesson_hi, lesson_hinglish,
   source_reference, has_spoiler, difficulty, tags, is_ai_generated, approved, sort_order)
SELECT v.id, x.cat, x.t_en, x.t_hi, x.t_hing, x.s_en, x.s_hi, x.s_hing,
       x.c_en, x.c_hi, x.c_hing, x.l_en, x.l_hi, x.l_hing,
       x.src, 0, x.diff, x.tags, 0, 1, x.ord
FROM (

  SELECT 13 AS vn, 'corporate' AS cat, 1 AS ord,
  'The criterion on the page and the criterion in the room' AS t_en, 'काग़ज़ पर की कसौटी और कमरे में की कसौटी' AS t_hi, 'Kagaz par ki kasauti aur kamre mein ki kasauti' AS t_hing,
  'A company''s promotion policy states three criteria, all of them about demonstrated work. An audit of eleven years of promotions finds that one unstated thing predicts the outcome better than any of the three. Nobody wrote it down and nobody had to.' AS s_en,
  'एक कंपनी की तरक़्क़ी नीति तीन कसौटियाँ बताती है, तीनों किए हुए काम के बारे में। ग्यारह साल की तरक़्क़ियों की जाँच में पता चलता है कि एक बिन-कही चीज़ नतीजे को तीनों में से किसी से बेहतर बताती है। किसी ने उसे लिखा नहीं और किसी को लिखना पड़ा भी नहीं।' AS s_hi,
  'Ek company ki tarakki neeti teen kasautiyan batati hai, teenon kiye hue kaam ke baare mein. Gyarah saal ki tarakkiyon ki jaanch mein pata chalta hai ki ek bin-kahi cheez nateeje ko teenon mein se kisi se behtar batati hai. Kisi ne use likha nahi aur kisi ko likhna pada bhi nahi.' AS s_hing,
  'This is the shape of 4.13''s problem at a size a reader can check. The verse states its criterion — guṇa-karma-vibhāgaśaḥ, by quality and by action — and the word for birth is not in the line. And it was applied by birth for centuries anyway. A stated criterion and an applied criterion are two different objects, and pointing at the first one does not dispose of the second.' AS c_en,
  'यह 4.13 की समस्या का आकार है, उस नाप पर जिसे पाठक जाँच सके। श्लोक अपनी कसौटी बताता है — गुणकर्मविभागशः, गुण और कर्म से — और जन्म का शब्द उस पंक्ति में है ही नहीं। और फिर भी उसे सदियों तक जन्म से लगाया गया। कही हुई कसौटी और लगाई गई कसौटी दो अलग चीज़ें हैं, और पहली की तरफ़ इशारा करने से दूसरी निपट नहीं जाती।' AS c_hi,
  'Yeh 4.13 ki samasya ka aakar hai, us naap par jise paathak jaanch sake. Shloka apni kasauti batata hai — guna-karma-vibhagashah, gun aur karm se — aur janm ka shabd us pankti mein hai hi nahi. Aur phir bhi use sadiyon tak janm se lagaya gaya. Kahi hui kasauti aur lagayi gayi kasauti do alag cheezein hain, aur pehli ki taraf ishara karne se doosri nipat nahi jaati.' AS c_hing,
  'A stated criterion and an applied criterion are two different objects.' AS l_en,
  'कही हुई कसौटी और लगाई गई कसौटी दो अलग चीज़ें हैं।' AS l_hi,
  'Kahi hui kasauti aur lagayi gayi kasauti do alag cheezein hain.' AS l_hing,
  NULL AS src, 'advanced' AS diff, 'criteria,stated,applied,audit' AS tags

  UNION ALL SELECT 13, 'school', 2,
  'Sorted at eleven, for life', 'ग्यारह साल पर छाँट दिए गए, ज़िंदगी भर के लिए', 'Gyarah saal par chhaant diye gaye, zindagi bhar ke liye',
  'A school sorts children into three streams at eleven on the basis of an assessment. The assessment measures something real. Ten years later, a follow-up finds that where a child started predicted where they ended better than anything they did in between.',
  'एक स्कूल ग्यारह साल की उम्र में एक परीक्षा के आधार पर बच्चों को तीन धाराओं में बाँटता है। परीक्षा कुछ असली नापती है। दस साल बाद एक अध्ययन पाता है कि बच्चा शुरू कहाँ हुआ, यह उसके अंत को बीच में किए किसी भी काम से बेहतर बताता था।',
  'Ek school gyarah saal ki umr mein ek pariksha ke aadhar par bachchon ko teen dharaon mein baantta hai. Pariksha kuch asli naapti hai. Das saal baad ek adhyayan paata hai ki bachcha shuru kahan hua, yeh uske ant ko beech mein kiye kisi bhi kaam se behtar batata tha.',
  'Nobody in this story intended a hereditary system and one operated anyway. That is the mechanism worth understanding before anybody argues about 4.13: a sort by demonstrated quality, applied once and early and then treated as fixed, becomes a sort by starting position without a single person deciding that it should.',
  'इस कहानी में किसी का इरादा वंशगत व्यवस्था बनाने का नहीं था और फिर भी एक चली। 4.13 पर बहस करने से पहले यही तंत्र समझने लायक़ है: दिखाई गई गुणवत्ता से की गई छँटाई, अगर एक बार और जल्दी लगा दी जाए और फिर पक्की मान ली जाए, तो वह शुरुआती जगह से की गई छँटाई बन जाती है — और यह तय किसी एक इंसान ने नहीं किया होता।',
  'Is kahani mein kisi ka iraada vanshagat vyavastha banane ka nahi tha aur phir bhi ek chali. 4.13 par behes karne se pehle yahi tantra samajhne layak hai: dikhayi gayi gunvatta se ki gayi chhantai, agar ek baar aur jaldi laga di jaaye aur phir pakki maan li jaaye, to woh shuruati jagah se ki gayi chhantai ban jaati hai — aur yeh tay kisi ek insan ne nahi kiya hota.',
  'Nobody intended a hereditary system. One operated anyway.',
  'किसी का इरादा वंशगत व्यवस्था का नहीं था। फिर भी एक चली।',
  'Kisi ka iraada vanshagat vyavastha ka nahi tha. Phir bhi ek chali.',
  NULL, 'advanced', 'school,streaming,sorting,mechanism'

  UNION ALL SELECT 13, 'ethics', 3,
  'Half a line on a poster', 'पोस्टर पर आधी पंक्ति', 'Poster par aadhi pankti',
  'Somebody sees this verse quoted with the second half removed. What is missing is the part where the speaker says: know me to be the maker of that, and also the non-maker. In its full form the verse withdraws its own claim in the same breath.',
  'कोई इस श्लोक को दूसरा आधा हटाकर उद्धृत देखता है। जो हिस्सा ग़ायब है वही है जिसमें वक्ता कहता है: मुझे उसका कर्ता जानो — और अकर्ता भी। पूरे रूप में श्लोक अपना ही दावा उसी साँस में वापस ले लेता है।',
  'Koi is shloka ko doosra aadha hatakar uddhrit dekhta hai. Jo hissa gayab hai wahi hai jisme vakta kehta hai: mujhe uska karta jaano — aur akarta bhi. Poore roop mein shloka apna hi dawa usi saans mein wapas le leta hai.',
  'Akartāram — the non-maker. Whatever anybody wants to build on the first line, the second line is standing underneath it saying not so fast, and it is the half that gets cut. That does not settle the history and this page does not claim it does; it settles what the verse in full actually says.',
  'अकर्तारम् — अकर्ता। पहली पंक्ति पर कोई जो भी खड़ा करना चाहे, दूसरी पंक्ति नीचे खड़ी होकर कह रही है, इतनी जल्दी नहीं — और कटता वही आधा है। इससे इतिहास तय नहीं होता और यह पन्ना ऐसा दावा भी नहीं करता; इससे यह तय होता है कि पूरा श्लोक असल में कहता क्या है।',
  'Akartaram — akarta. Pehli pankti par koi jo bhi khada karna chahe, doosri pankti neeche khadi hokar keh rahi hai, itni jaldi nahi — aur katta wahi aadha hai. Isse itihaas tay nahi hota aur yeh panna aisa dawa bhi nahi karta; isse yeh tay hota hai ki poora shloka asal mein kehta kya hai.',
  'The half that gets cut is the half where the verse takes its own claim back.',
  'जो आधा काटा जाता है वही है जिसमें श्लोक अपना दावा वापस ले लेता है।',
  'Jo aadha kaata jaata hai wahi hai jisme shloka apna dawa wapas le leta hai.',
  NULL, 'advanced', 'quotation,half-lines,akartaram,reading'

  UNION ALL SELECT 13, 'everyday_life', 4,
  'The reader who wanted it settled', 'वह पाठक जो इसे तय करवाना चाहता था', 'Woh paathak jo ise tay karvana chahta tha',
  'Somebody reads this verse hoping the book will resolve the question for them, one way or the other. It does not. 18.41 supports one reading, 5.18 and 13.27 pull hard against it, and the verse itself takes back what it just said. They find this unsatisfying and then, later, useful.',
  'कोई इस श्लोक को इस उम्मीद से पढ़ता है कि किताब उसके लिए सवाल तय कर देगी, इस तरफ़ या उस तरफ़। वह नहीं करती। 18.41 एक पाठ का साथ देता है, 5.18 और 13.27 उसके ख़िलाफ़ ज़ोर से खींचते हैं, और श्लोक ख़ुद अभी कही बात वापस ले लेता है। उसे यह असंतोषजनक लगता है और बाद में, काम का।',
  'Koi is shloka ko is ummeed se padhta hai ki kitaab uske liye sawal tay kar degi, is taraf ya us taraf. Woh nahi karti. 18.41 ek paath ka saath deta hai, 5.18 aur 13.27 uske khilaf zor se kheenchte hain, aur shloka khud abhi kahi baat wapas le leta hai. Use yeh asantoshjanak lagta hai aur baad mein, kaam ka.',
  'The book argues with itself here and this project is not going to decide that argument on its behalf. A reader who wants a text to hand them a settled position on this will be disappointed by the Gita, and being disappointed by it accurately is better than being satisfied by a version of it that has had one of its halves removed.',
  'यहाँ किताब ख़ुद से बहस करती है और यह परियोजना उस बहस को उसकी तरफ़ से तय नहीं करेगी। जो पाठक चाहता है कि कोई ग्रंथ उसे इस पर तय स्थिति सौंप दे, वह गीता से निराश होगा — और उससे सही ढंग से निराश होना उसके ऐसे रूप से संतुष्ट होने से बेहतर है जिसका एक आधा हटा दिया गया हो।',
  'Yahan kitaab khud se behes karti hai aur yeh pariyojna us behes ko uski taraf se tay nahi karegi. Jo paathak chahta hai ki koi granth use is par tay sthiti saunp de, woh Gita se nirash hoga — aur usse sahi dhang se nirash hona uske aise roop se santusht hone se behtar hai jiska ek aadha hata diya gaya ho.',
  'Being accurately disappointed by a text beats being satisfied by half of it.',
  'किसी ग्रंथ से सही ढंग से निराश होना उसके आधे से संतुष्ट होने से बेहतर है।',
  'Kisi granth se sahi dhang se nirash hona uske aadhe se santusht hone se behtar hai.',
  NULL, 'advanced', 'reading,honesty,unsettled,expectations'

  UNION ALL SELECT 18, 'corporate', 1,
  'The decision he did not make', 'वह फ़ैसला जो उसने नहीं किया', 'Woh faisla jo usne nahi kiya',
  'A manager sits on a difficult call for four months, telling himself he is waiting for more information. Two people leave in that time and both cite the uncertainty. He did not decide anything and something was decided.',
  'एक मैनेजर चार महीने एक मुश्किल फ़ैसले पर बैठा रहता है, ख़ुद से कहता हुआ कि वह और जानकारी का इंतज़ार कर रहा है। उस दौरान दो लोग चले जाते हैं और दोनों अनिश्चितता का हवाला देते हैं। उसने कुछ तय नहीं किया और कुछ तय हो गया।',
  'Ek manager chaar mahine ek mushkil faisle par baitha rehta hai, khud se kehta hua ki woh aur jaankari ka intezaar kar raha hai. Us dauran do log chale jaate hain aur dono anishchitta ka hawala dete hain. Usne kuch tay nahi kiya aur kuch tay ho gaya.',
  'Seeing the action inside the inaction. This is the half of the verse that removes an exit rather than offering one. Four months of not deciding is a decision with a start date, and two people carried its consequences while it was being described as patience.',
  'न-करने के भीतर करना देखना। श्लोक का यह वही आधा है जो निकास देता नहीं, बंद करता है। चार महीने तय न करना एक फ़ैसला है जिसकी शुरुआत की तारीख़ है, और जब उसे धैर्य बताया जा रहा था तब दो लोग उसके नतीजे उठा रहे थे।',
  'Na-karne ke bheetar karna dekhna. Shloka ka yeh wahi aadha hai jo nikaas deta nahi, band karta hai. Chaar mahine tay na karna ek faisla hai jiski shuruaat ki tareekh hai, aur jab use dhairya bataya ja raha tha tab do log uske nateeje utha rahe the.',
  'Four months of not deciding is a decision with a start date.',
  'चार महीने तय न करना एक फ़ैसला है जिसकी शुरुआत की तारीख़ है।',
  'Chaar mahine tay na karna ek faisla hai jiski shuruaat ki tareekh hai.',
  NULL, 'intermediate', 'work,decisions,delay,consequences'

  UNION ALL SELECT 18, 'everyday_life', 2,
  'The message left on read', 'पढ़कर छोड़ा गया संदेश', 'Padhkar chhoda gaya sandesh',
  'Somebody leaves a difficult message unanswered for nine days. On the tenth day the sender stops expecting a reply. Both of them understand exactly what was communicated, and nothing was typed.',
  'कोई एक मुश्किल संदेश नौ दिन बिना जवाब छोड़ देता है। दसवें दिन भेजने वाला जवाब की उम्मीद छोड़ देता है। दोनों को ठीक-ठीक पता है कि क्या कहा गया, और टाइप कुछ नहीं हुआ।',
  'Koi ek mushkil sandesh nau din bina jawab chhod deta hai. Dasve din bhejne wala jawab ki ummeed chhod deta hai. Dono ko theek theek pata hai ki kya kaha gaya, aur type kuch nahi hua.',
  'The clearest version of the second half there is. An answer was given, both parties received it, and nobody can be shown a sentence. The verse says a person who can see this is buddhimān — has understood something — and it is not a compliment about cleverness. It is about not being able to hide in the gap.',
  'दूसरे आधे का इससे साफ़ रूप नहीं है। जवाब दिया गया, दोनों पक्षों को मिला, और किसी को कोई वाक्य दिखाया नहीं जा सकता। श्लोक कहता है कि जो यह देख ले वह बुद्धिमान है — उसने कुछ समझ लिया — और यह चतुराई की तारीफ़ नहीं है। यह इस बारे में है कि उस ख़ाली जगह में छिपा नहीं जा सकता।',
  'Doosre aadhe ka isse saaf roop nahi hai. Jawab diya gaya, dono pakshon ko mila, aur kisi ko koi vakya dikhaya nahi ja sakta. Shloka kehta hai ki jo yeh dekh le woh buddhiman hai — usne kuch samajh liya — aur yeh chaturai ki tareef nahi hai. Yeh is baare mein hai ki us khaali jagah mein chhipa nahi ja sakta.',
  'An answer was given and nobody can be shown a sentence.',
  'जवाब दिया गया और किसी को कोई वाक्य दिखाया नहीं जा सकता।',
  'Jawab diya gaya aur kisi ko koi vakya dikhaya nahi ja sakta.',
  NULL, 'beginner', 'messages,silence,answers,accountability'

  UNION ALL SELECT 18, 'ethics', 3,
  'The form he did not sign', 'वह फ़ॉर्म जिस पर उसने दस्तख़त नहीं किए', 'Woh form jis par usne dastkhat nahi kiye',
  'Somebody is asked to sign off on something they have doubts about. They do not refuse and do not sign; they let it sit. It goes through anyway, on a different signature, and they are told afterwards that they had nothing to do with it.',
  'किसी से कहा जाता है कि वह ऐसी चीज़ पर मंज़ूरी दे जिस पर उसे शक है। वह न मना करता है और न दस्तख़त करता है; वह उसे पड़ा रहने देता है। वह फिर भी किसी और दस्तख़त से पास हो जाती है, और बाद में उसे बताया जाता है कि इसमें उसका कोई हाथ नहीं था।',
  'Kisi se kaha jaata hai ki woh aisi cheez par manzoori de jis par use shak hai. Woh na mana karta hai aur na dastkhat karta hai; woh use pada rehne deta hai. Woh phir bhi kisi aur dastkhat se paas ho jaati hai, aur baad mein use bataya jaata hai ki isme uska koi haath nahi tha.',
  'The verse would disagree with the reassurance, gently. Not signing was available as a position and he took a different one, which was letting it pass without his name on it. Both are actions. Only one of them shows up in a file.',
  'श्लोक इस तसल्ली से नरमी से असहमत होगा। दस्तख़त न करना एक स्थिति के तौर पर मौजूद थी और उसने दूसरी ली — उसे अपना नाम लगाए बिना निकल जाने देना। दोनों कर्म हैं। इनमें से सिर्फ़ एक किसी फ़ाइल में दिखता है।',
  'Shloka is tasalli se narmi se asehmat hoga. Dastkhat na karna ek sthiti ke taur par maujood thi aur usne doosri li — use apna naam lagaye bina nikal jaane dena. Dono karm hain. Inme se sirf ek kisi file mein dikhta hai.',
  'Both are actions. Only one of them shows up in a file.',
  'दोनों कर्म हैं। इनमें से सिर्फ़ एक किसी फ़ाइल में दिखता है।',
  'Dono karm hain. Inme se sirf ek kisi file mein dikhta hai.',
  NULL, 'advanced', 'ethics,abstention,responsibility,records'

  UNION ALL SELECT 18, 'sports', 4,
  'The ball he left', 'वह गेंद जो उसने छोड़ी', 'Woh gend jo usne chhodi',
  'A batter leaves a ball outside off stump. It is the most active thing he does in the over — the shoulder, the wrists, the head all move, the bat is deliberately withdrawn. On the scorecard it is a dot.',
  'एक बल्लेबाज़ ऑफ़ स्टंप के बाहर की गेंद छोड़ देता है। पूरे ओवर में यह उसका सबसे सक्रिय काम है — कंधा, कलाइयाँ, सिर, सब हिलते हैं, बल्ला जानबूझकर हटाया जाता है। स्कोरकार्ड पर वह एक डॉट है।',
  'Ek ballebaaz off stump ke bahar ki gend chhod deta hai. Poore over mein yeh uska sabse sakriya kaam hai — kandha, kalaiyan, sir, sab hilte hain, balla jaanboojhkar hataya jaata hai. Scorecard par woh ek dot hai.',
  'Action inside inaction, in a form anybody who has watched cricket already knows. Nobody thinks a leave is nothing; every player knows it is a shot. The verse is asking for that same reading to be applied outside the ground, where the scorecard is less forgiving about what it records.',
  'न-करने के भीतर करना, उस रूप में जिसे क्रिकेट देखने वाला हर कोई पहले से जानता है। कोई नहीं समझता कि गेंद छोड़ना कुछ नहीं है; हर खिलाड़ी जानता है कि वह एक शॉट है। श्लोक यही पाठ मैदान के बाहर लगाने को कह रहा है, जहाँ स्कोरकार्ड यह दर्ज करने में कम उदार है कि हुआ क्या।',
  'Na-karne ke bheetar karna, us roop mein jise cricket dekhne wala har koi pehle se jaanta hai. Koi nahi samajhta ki gend chhodna kuch nahi hai; har khilaadi jaanta hai ki woh ek shot hai. Shloka yahi paath maidan ke bahar lagane ko keh raha hai, jahan scorecard yeh darj karne mein kam udaar hai ki hua kya.',
  'Every player knows a leave is a shot. The scorecard records a dot.',
  'हर खिलाड़ी जानता है कि गेंद छोड़ना एक शॉट है। स्कोरकार्ड एक डॉट दर्ज करता है।',
  'Har khilaadi jaanta hai ki gend chhodna ek shot hai. Scorecard ek dot darj karta hai.',
  NULL, 'beginner', 'cricket,leaving,action,records'

  UNION ALL SELECT 20, 'corporate', 1,
  'The project with nothing riding on it', 'वह प्रोजेक्ट जिस पर कुछ टिका नहीं था', 'Woh project jis par kuch tika nahi tha',
  'Somebody runs a piece of work that will not be announced, will not appear in an appraisal, and is unlikely to be traced back to them. It is the best thing they do that year and they know it while doing it.',
  'कोई एक ऐसा काम चलाता है जिसकी घोषणा नहीं होगी, जो मूल्यांकन में नहीं आएगा, और जिसका उस तक पहुँचना मुश्किल है। उस साल का उसका सबसे अच्छा काम वही है और करते हुए उसे यह पता है।',
  'Koi ek aisa kaam chalata hai jiski ghoshna nahi hogi, jo mulyankan mein nahi aayega, aur jiska us tak pahunchna mushkil hai. Us saal ka uska sabse achha kaam wahi hai aur karte hue use yeh pata hai.',
  'Nirāśrayaḥ — leaning on nothing, no support propped underneath. And note abhipravṛttaḥ: he is fully into it. The verse is not describing reduced effort with the recognition removed; it is describing the same effort with the scaffolding gone, which is a harder thing and a different one.',
  'निराश्रयः — किसी पर टिके बिना, नीचे कोई सहारा लगाए बिना। और अभिप्रवृत्तः देखिए: वह पूरी तरह उसी में है। श्लोक कम मेहनत का वर्णन नहीं कर रहा जिससे पहचान हटा दी गई हो; वह उसी मेहनत का वर्णन कर रहा है जिसकी पाड़ हट चुकी है, और यह कठिन चीज़ है और अलग चीज़।',
  'Nirashrayah — kisi par tike bina, neeche koi sahara lagaye bina. Aur abhipravrittah dekho: woh poori tarah usi mein hai. Shloka kam mehnat ka varnan nahi kar raha jisse pehchan hata di gayi ho; woh usi mehnat ka varnan kar raha hai jiski paad hat chuki hai, aur yeh kathin cheez hai aur alag cheez.',
  'Not less effort with the recognition removed. The same effort with the scaffolding gone.',
  'कम मेहनत नहीं जिससे पहचान हटा दी गई हो। वही मेहनत जिसकी पाड़ हट चुकी है।',
  'Kam mehnat nahi jisse pehchan hata di gayi ho. Wahi mehnat jiski paad hat chuki hai.',
  NULL, 'intermediate', 'work,recognition,quiet,effort'

  UNION ALL SELECT 20, 'parenting', 2,
  'Nobody was going to see it', 'इसे कोई देखने वाला नहीं था', 'Ise koi dekhne wala nahi tha',
  'A parent spends two hours making something for a child''s school thing that thirty people will glance at for four seconds. They enjoy the two hours. Afterwards they cannot work out whether anybody noticed and find they are not looking.',
  'एक अभिभावक बच्चे के स्कूल की किसी चीज़ के लिए दो घंटे कुछ बनाता है जिसे तीस लोग चार सेकंड देखेंगे। उन दो घंटों में उसे मज़ा आता है। बाद में वह तय नहीं कर पाता कि किसी ने ध्यान दिया या नहीं और पाता है कि वह देख भी नहीं रहा।',
  'Ek abhibhavak bachche ke school ki kisi cheez ke liye do ghante kuch banata hai jise tees log chaar second dekhenge. Un do ghanton mein use maza aata hai. Baad mein woh tay nahi kar pata ki kisi ne dhyan diya ya nahi aur paata hai ki woh dekh bhi nahi raha.',
  'Nitya-tṛptaḥ — steadily content — is the middle term and it is doing quiet work. The verse is not describing indifference to the outcome; it describes somebody for whom the two hours were already the whole of it, so there was nothing left over for the four seconds to settle.',
  'नित्यतृप्तः — लगातार संतुष्ट — बीच वाला शब्द है और वह चुपचाप काम कर रहा है। श्लोक नतीजे के प्रति बेरुख़ी का वर्णन नहीं कर रहा; वह ऐसे इंसान का वर्णन करता है जिसके लिए वे दो घंटे ही पूरी बात थे, तो चार सेकंड के तय करने को कुछ बचा ही नहीं।',
  'Nitya-triptah — lagataar santusht — beech wala shabd hai aur woh chupchap kaam kar raha hai. Shloka nateeje ke prati berukhi ka varnan nahi kar raha; woh aise insan ka varnan karta hai jiske liye woh do ghante hi poori baat the, to chaar second ke tay karne ko kuch bacha hi nahi.',
  'The two hours were already the whole of it. Nothing was left for the four seconds to settle.',
  'वे दो घंटे ही पूरी बात थे। चार सेकंड के तय करने को कुछ बचा ही नहीं।',
  'Woh do ghante hi poori baat the. Chaar second ke tay karne ko kuch bacha hi nahi.',
  NULL, 'beginner', 'parenting,making,contentment,unseen'

  UNION ALL SELECT 20, 'startup', 3,
  'The founder who kept building after the exit', 'वह संस्थापक जो बिक्री के बाद भी बनाता रहा', 'Woh sansthapak jo bikri ke baad bhi banata raha',
  'Somebody sells a company and has enough money that nothing further is required. Eighteen months later they are building something again, badly paid, in a smaller room. Asked why, they say they could not find a reason not to.',
  'कोई अपनी कंपनी बेच देता है और उसके पास इतना पैसा है कि आगे कुछ ज़रूरी नहीं। अठारह महीने बाद वह फिर कुछ बना रहा है, कम पैसे में, छोटे कमरे में। पूछने पर वह कहता है कि उसे न करने की कोई वजह नहीं मिली।',
  'Koi apni company bech deta hai aur uske paas itna paisa hai ki aage kuch zaroori nahi. Atharah mahine baad woh phir kuch bana raha hai, kam paise mein, chhote kamre mein. Poochhne par woh kehta hai ki use na karne ki koi wajah nahi mili.',
  'The verse describes somebody fully engaged with nothing propped under the engagement, and this is the version where the props were genuinely removed by circumstance rather than by discipline. What is left is the work, and it turns out to be enough on its own — which is the claim, tested.',
  'श्लोक ऐसे इंसान का वर्णन करता है जो पूरी तरह लगा है और लगाव के नीचे कोई सहारा नहीं। यह वह रूप है जिसमें सहारे अनुशासन से नहीं, हालात से हटे। जो बचता है वह काम है, और वह अकेले ही काफ़ी निकलता है — यही दावा है, जाँचा हुआ।',
  'Shloka aise insan ka varnan karta hai jo poori tarah laga hai aur lagav ke neeche koi sahara nahi. Yeh woh roop hai jisme sahare anushasan se nahi, haalat se hate. Jo bachta hai woh kaam hai, aur woh akele hi kaafi nikalta hai — yahi dawa hai, jaancha hua.',
  'The props were removed by circumstance. What was left turned out to be enough.',
  'सहारे हालात ने हटाए। जो बचा वह काफ़ी निकला।',
  'Sahare haalat ne hataye. Jo bacha woh kaafi nikla.',
  NULL, 'intermediate', 'startups,motivation,after-money,work'

  UNION ALL SELECT 20, 'everyday_life', 4,
  'The garden nobody visits', 'वह बग़ीचा जहाँ कोई नहीं आता', 'Woh bagicha jahan koi nahi aata',
  'Somebody keeps a small garden at the back of a building where almost nobody walks. They have kept it for eleven years. Twice a year somebody notices and says something, and they are pleased for about a minute, and it changes nothing about the following week.',
  'कोई एक इमारत के पीछे छोटा बग़ीचा रखता है जहाँ लगभग कोई नहीं चलता। वह उसे ग्यारह साल से रख रहा है। साल में दो बार कोई देखता है और कुछ कह देता है, और उसे मिनट भर अच्छा लगता है, और अगले हफ़्ते में इससे कुछ नहीं बदलता।',
  'Koi ek imaarat ke peechhe chhota bagicha rakhta hai jahan lagbhag koi nahi chalta. Woh use gyarah saal se rakh raha hai. Saal mein do baar koi dekhta hai aur kuch keh deta hai, aur use minute bhar achha lagta hai, aur agle hafte mein isse kuch nahi badalta.',
  'The minute of being pleased is the honest detail and the verse does not ask for it to be given up. Nitya-tṛptaḥ is steady contentment, not the absence of pleasure at being seen. What the verse describes is the following week being the same either way, and eleven years is enough of a sample to know.',
  'मिनट भर अच्छा लगना ही ईमानदार ब्यौरा है और श्लोक उसे छोड़ने को नहीं कहता। नित्यतृप्तः लगातार संतोष है, देखे जाने की ख़ुशी का न होना नहीं। श्लोक जो बताता है वह यह है कि अगला हफ़्ता दोनों हालतों में एक-सा रहता है, और ग्यारह साल इतना नमूना है कि यह पता चल जाए।',
  'Minute bhar achha lagna hi imaandaar byora hai aur shloka use chhodne ko nahi kehta. Nitya-triptah lagataar santosh hai, dekhe jaane ki khushi ka na hona nahi. Shloka jo batata hai woh yeh hai ki agla hafta dono haalaton mein ek-sa rehta hai, aur gyarah saal itna namoona hai ki yeh pata chal jaaye.',
  'He is pleased for a minute. The following week is the same either way.',
  'उसे मिनट भर अच्छा लगता है। अगला हफ़्ता दोनों हालतों में एक-सा रहता है।',
  'Use minute bhar achha lagta hai. Agla hafta dono haalaton mein ek-sa rehta hai.',
  NULL, 'beginner', 'gardens,unseen,contentment,long-haul'

  UNION ALL SELECT 34, 'college', 1,
  'The question she was embarrassed to ask', 'वह सवाल जो पूछने में उसे शर्म आती थी', 'Woh sawal jo poochhne mein use sharm aati thi',
  'A student two years into a course does not understand something from the first term and has been navigating around it. She asks. The lecturer says three sentences. She loses about ninety seconds of dignity and gets back two years.',
  'कोई छात्रा कोर्स के दो साल बाद भी पहले सत्र की एक चीज़ नहीं समझ पाई है और उसके इर्द-गिर्द से निकलती आ रही है। वह पूछ लेती है। प्रोफ़ेसर तीन वाक्य कहता है। उसकी क़रीब नब्बे सेकंड की इज़्ज़त जाती है और दो साल वापस मिलते हैं।',
  'Koi chhatra course ke do saal baad bhi pehle satra ki ek cheez nahi samajh payi hai aur uske ird-gird se nikalti aa rahi hai. Woh poochh leti hai. Professor teen vakya kehta hai. Uski kareeb nabbe second ki izzat jaati hai aur do saal wapas milte hain.',
  'Praṇipāta — putting yourself lower — is the first term, and ninety seconds of it is the going rate. The verse arranges the three deliberately: the lowering is not the point, it is the price of the middle term, which is the asking.',
  'प्रणिपात — ख़ुद को नीचे रखना — पहला शब्द है, और नब्बे सेकंड उसका चालू भाव है। श्लोक तीनों को जानबूझकर सजाता है: नीचे रखना बात नहीं है, वह बीच वाले शब्द की क़ीमत है, और बीच वाला शब्द है पूछना।',
  'Pranipat — khud ko neeche rakhna — pehla shabd hai, aur nabbe second uska chaalu bhaav hai. Shloka teenon ko jaanboojhkar sajata hai: neeche rakhna baat nahi hai, woh beech wale shabd ki keemat hai, aur beech wala shabd hai poochhna.',
  'Ninety seconds of dignity for two years. The lowering is the price, not the point.',
  'दो साल के बदले नब्बे सेकंड की इज़्ज़त। नीचे रखना क़ीमत है, बात नहीं।',
  'Do saal ke badle nabbe second ki izzat. Neeche rakhna keemat hai, baat nahi.',
  NULL, 'beginner', 'students,asking,embarrassment,cost'

  UNION ALL SELECT 34, 'corporate', 2,
  'He asked it four different ways', 'उसने उसे चार तरह से पूछा', 'Usne use chaar tarah se poochha',
  'Somebody new to a field asks a specialist the same question four times across an hour, each time from a different angle. The specialist is not annoyed. By the fourth version she has changed her own answer, and says so.',
  'किसी क्षेत्र में नया कोई एक विशेषज्ञ से घंटे भर में वही सवाल चार बार पूछता है, हर बार अलग कोण से। विशेषज्ञ को झुँझलाहट नहीं होती। चौथे रूप तक वह अपना ही जवाब बदल चुकी है, और यह कह भी देती है।',
  'Kisi kshetra mein naya koi ek visheshagya se ghante bhar mein wahi sawal chaar baar poochhta hai, har baar alag kon se. Visheshagya ko jhunjhlahat nahi hoti. Chauthe roop tak woh apna hi jawab badal chuki hai, aur yeh keh bhi deti hai.',
  'Pari-praśna is asking all the way round — pari- is the prefix in perimeter. It is not four repetitions of one question, it is one question approached from four sides, and the verse expects it to be done properly enough that the answer might move.',
  'परि-प्रश्न यानी चारों तरफ़ से पूछना — परि- वही उपसर्ग है जो परिधि में है। यह एक सवाल की चार बार दोहराई नहीं है, यह एक सवाल है चार तरफ़ से देखा गया, और श्लोक की उम्मीद है कि यह इतने ठीक से किया जाए कि जवाब हिल सके।',
  'Pari-prashna yani chaaron taraf se poochhna — pari- wahi upasarg hai jo paridhi mein hai. Yeh ek sawal ki chaar baar dohrayi nahi hai, yeh ek sawal hai chaar taraf se dekha gaya, aur shloka ki ummeed hai ki yeh itne theek se kiya jaaye ki jawab hil sake.',
  'Four sides of one question, done well enough that her own answer moved.',
  'एक सवाल के चार पहलू, इतने ठीक से कि उसका अपना जवाब हिल गया।',
  'Ek sawal ke chaar pehlu, itne theek se ki uska apna jawab hil gaya.',
  NULL, 'intermediate', 'learning,questioning,experts,depth'

  UNION ALL SELECT 34, 'ethics', 3,
  'The teacher who wanted to be asked', 'वह शिक्षक जो चाहता था कि उससे पूछा जाए', 'Woh shikshak jo chahta tha ki usse poochha jaaye',
  'Somebody with a following notices that the people around them have stopped asking difficult questions. They start ending sessions by naming the strongest objection to what they have just said, and asking whether anybody has a better one.',
  'जिसके पीछे लोग चलते हैं, वह देखता है कि उसके आसपास के लोगों ने मुश्किल सवाल पूछना बंद कर दिया है। वह सत्र इस तरह ख़त्म करने लगता है कि अभी जो कहा उसकी सबसे मज़बूत आपत्ति ख़ुद बताता है, और पूछता है कि किसी के पास इससे बेहतर है क्या।',
  'Jiske peechhe log chalte hain, woh dekhta hai ki uske aas paas ke logon ne mushkil sawal poochhna band kar diya hai. Woh satra is tarah khatam karne lagta hai ki abhi jo kaha uski sabse mazboot aapatti khud batata hai, aur poochhta hai ki kisi ke paas isse behtar hai kya.',
  'The verse is usually read as advice to the student and it is also a description of what a teacher worth going to looks like. Somebody who cannot be asked all the way round a thing is not offering the arrangement this verse describes, whatever else they are offering.',
  'श्लोक आमतौर पर छात्र के लिए सलाह की तरह पढ़ा जाता है और यह इसका भी वर्णन है कि जिस शिक्षक के पास जाना बनता है वह कैसा दिखता है। जिससे किसी चीज़ के चारों तरफ़ से पूछा न जा सके, वह यह इंतज़ाम नहीं दे रहा जो श्लोक बताता है, वह और जो भी दे रहा हो।',
  'Shloka aam taur par chhatra ke liye salah ki tarah padha jaata hai aur yeh iska bhi varnan hai ki jis shikshak ke paas jaana banta hai woh kaisa dikhta hai. Jisse kisi cheez ke chaaron taraf se poochha na ja sake, woh yeh intezaam nahi de raha jo shloka batata hai, woh aur jo bhi de raha ho.',
  'Somebody who cannot be asked all the way round a thing is not offering this arrangement.',
  'जिससे किसी चीज़ के चारों तरफ़ से पूछा न जा सके, वह यह इंतज़ाम नहीं दे रहा।',
  'Jisse kisi cheez ke chaaron taraf se poochha na ja sake, woh yeh intezaam nahi de raha.',
  NULL, 'advanced', 'teaching,questions,authority,openness'

  UNION ALL SELECT 34, 'everyday_life', 4,
  'The neighbour who had done it before', 'वह पड़ोसी जो पहले यह कर चुका था', 'Woh padosi jo pehle yeh kar chuka tha',
  'Somebody facing a piece of officialdom they do not understand spends nine hours reading about it online. Then they knock on a door two floors down where somebody went through the same thing last year. It takes twenty minutes.',
  'किसी सरकारी प्रक्रिया से जूझता कोई, जिसे वह समझ नहीं पा रहा, नौ घंटे उसके बारे में ऑनलाइन पढ़ता है। फिर वह दो मंज़िल नीचे एक दरवाज़ा खटखटाता है जहाँ किसी ने पिछले साल यही झेला था। इसमें बीस मिनट लगते हैं।',
  'Kisi sarkari prakriya se joojhta koi, jise woh samajh nahi pa raha, nau ghante uske baare mein online padhta hai. Phir woh do manzil neeche ek darwaza khatkhatata hai jahan kisi ne pichhle saal yahi jhela tha. Isme bees minute lagte hain.',
  'The verse says go and ask somebody who knows, and nine hours of reading is what most people do instead. Nothing in the verse is mystical: the instruction is to find a person who has been through the thing and put yourself in front of them.',
  'श्लोक कहता है जाकर किसी जानने वाले से पूछो, और नौ घंटे पढ़ना वह है जो ज़्यादातर लोग इसके बजाय करते हैं। श्लोक में कुछ भी रहस्यमय नहीं है: हिदायत यह है कि ऐसा इंसान ढूँढ़ो जो उस चीज़ से गुज़र चुका है और ख़ुद को उसके सामने रख दो।',
  'Shloka kehta hai jaakar kisi jaanne wale se poocho, aur nau ghante padhna woh hai jo zyadatar log iske bajaye karte hain. Shloka mein kuch bhi rahasyamay nahi hai: hidayat yeh hai ki aisa insan dhoondho jo us cheez se guzar chuka hai aur khud ko uske saamne rakh do.',
  'Nine hours of reading is what most people do instead of knocking on a door.',
  'दरवाज़ा खटखटाने के बजाय ज़्यादातर लोग नौ घंटे पढ़ते हैं।',
  'Darwaza khatkhatane ke bajaye zyadatar log nau ghante padhte hain.',
  NULL, 'beginner', 'asking,neighbours,practical,shortcuts'

  UNION ALL SELECT 38, 'everyday_life', 1,
  'The thing nobody could have told him', 'वह चीज़ जो उसे कोई बता नहीं सकता था', 'Woh cheez jo use koi bata nahi sakta tha',
  'Somebody is told at twenty-two that the job will not love them back. They nod. At thirty-four they understand it, in a car park, for no reason connected to anything, and remember exactly who said it.',
  'किसी को बाईस की उम्र में बताया जाता है कि नौकरी बदले में प्यार नहीं करेगी। वह सिर हिला देता है। चौंतीस पर उसे यह समझ आता है, एक पार्किंग में, किसी से जुड़ी हुई वजह के बिना, और उसे ठीक-ठीक याद है कि यह किसने कहा था।',
  'Kisi ko baaees ki umr mein bataya jaata hai ki naukri badle mein pyar nahi karegi. Woh sir hila deta hai. Chauntees par use yeh samajh aata hai, ek parking mein, kisi se judi hui wajah ke bina, aur use theek theek yaad hai ki yeh kisne kaha tha.',
  'Kālena — in time. Svayam — of their own accord. Ātmani — in themselves. All three limits are in the verse and all three are in this story, including the detail that the sentence was available for twelve years and could not be used.',
  'कालेन — समय के साथ। स्वयं — अपने आप। आत्मनि — अपने भीतर। तीनों सीमाएँ श्लोक में हैं और तीनों इस कहानी में, इस ब्यौरे समेत कि वह वाक्य बारह साल तक मौजूद था और इस्तेमाल नहीं हो सका।',
  'Kalena — samay ke saath. Svayam — apne aap. Atmani — apne bheetar. Teenon seemayein shloka mein hain aur teenon is kahani mein, is byore samet ki woh vakya barah saal tak maujood tha aur istemaal nahi ho saka.',
  'The sentence was available for twelve years and could not be used.',
  'वह वाक्य बारह साल मौजूद रहा और इस्तेमाल नहीं हो सका।',
  'Woh vakya barah saal maujood raha aur istemaal nahi ho saka.',
  NULL, 'beginner', 'understanding,time,advice,delay'

  UNION ALL SELECT 38, 'healthcare', 2,
  'What the training could not teach', 'जो प्रशिक्षण नहीं सिखा सका', 'Jo prashikshan nahi sikha saka',
  'A doctor is taught how to give bad news in a two-day course. She is competent at it in year one and good at it in year seven. Nothing was added in between; the same words started arriving at the right speed.',
  'एक डॉक्टर को दो दिन के कोर्स में बुरी ख़बर देना सिखाया जाता है। पहले साल वह इसमें ठीक है और सातवें साल अच्छी। बीच में कुछ जोड़ा नहीं गया; वही शब्द सही रफ़्तार से आने लगे।',
  'Ek doctor ko do din ke course mein buri khabar dena sikhaya jaata hai. Pehle saal woh isme theek hai aur saatve saal achhi. Beech mein kuch joda nahi gaya; wahi shabd sahi raftaar se aane lage.',
  'The verse says nothing here cleans like understanding and then immediately says you cannot be given it. Both halves are in this story: the course was real and worth doing, and what happened between year one and year seven was not more course.',
  'श्लोक कहता है कि यहाँ कोई चीज़ समझ जितना साफ़ नहीं करती और फिर तुरंत कहता है कि यह आपको दी नहीं जा सकती। दोनों आधे इस कहानी में हैं: कोर्स असली था और करने लायक़, और पहले साल से सातवें साल के बीच जो हुआ वह और कोर्स नहीं था।',
  'Shloka kehta hai ki yahan koi cheez samajh jitna saaf nahi karti aur phir turant kehta hai ki yeh tumhe di nahi ja sakti. Dono aadhe is kahani mein hain: course asli tha aur karne layak, aur pehle saal se saatve saal ke beech jo hua woh aur course nahi tha.',
  'The course was real. What happened between year one and year seven was not more course.',
  'कोर्स असली था। पहले और सातवें साल के बीच जो हुआ वह और कोर्स नहीं था।',
  'Course asli tha. Pehle aur saatve saal ke beech jo hua woh aur course nahi tha.',
  NULL, 'intermediate', 'medicine,training,experience,time'

  UNION ALL SELECT 38, 'sports', 3,
  'The player who could not coach it', 'वह खिलाड़ी जो इसे सिखा नहीं सका', 'Woh khilaadi jo ise sikha nahi saka',
  'A former player who read the game brilliantly becomes a coach and cannot transmit the thing he was best at. He can name it, describe it and demonstrate it. Three of his players eventually have it and none of them can say when.',
  'खेल को बेहतरीन पढ़ने वाला एक पूर्व खिलाड़ी कोच बनता है और वह चीज़ आगे नहीं पहुँचा पाता जिसमें वह सबसे अच्छा था। वह उसका नाम ले सकता है, वर्णन कर सकता है, करके दिखा सकता है। उसके तीन खिलाड़ियों में वह आख़िरकार आ जाती है और कोई नहीं बता सकता कब।',
  'Khel ko behtareen padhne wala ek poorv khilaadi coach banta hai aur woh cheez aage nahi pahuncha pata jisme woh sabse achha tha. Woh uska naam le sakta hai, varnan kar sakta hai, karke dikha sakta hai. Uske teen khilaadiyon mein woh aakhirkar aa jaati hai aur koi nahi bata sakta kab.',
  'Svayam and ātmani — of their own accord, in themselves. The coach is not failing; the verse says this particular thing is not transmissible on demand and arrives from inside. What he could do was arrange the conditions and wait, which is what he did.',
  'स्वयं और आत्मनि — अपने आप, अपने भीतर। कोच नाकाम नहीं है; श्लोक कहता है कि यह ख़ास चीज़ माँगने पर सौंपी नहीं जा सकती और भीतर से आती है। वह जो कर सकता था वह था हालात जुटाना और इंतज़ार करना, और उसने वही किया।',
  'Svayam aur atmani — apne aap, apne bheetar. Coach nakaam nahi hai; shloka kehta hai ki yeh khaas cheez maangne par saunpi nahi ja sakti aur bheetar se aati hai. Woh jo kar sakta tha woh tha haalat jutana aur intezaar karna, aur usne wahi kiya.',
  'He was not failing. He was arranging the conditions and waiting.',
  'वह नाकाम नहीं हो रहा था। वह हालात जुटा रहा था और इंतज़ार कर रहा था।',
  'Woh nakaam nahi ho raha tha. Woh haalat juta raha tha aur intezaar kar raha tha.',
  NULL, 'intermediate', 'coaching,transmission,patience,time'

  UNION ALL SELECT 38, 'college', 4,
  'The essay she could not have written in year one', 'वह निबंध जो वह पहले साल नहीं लिख सकती थी', 'Woh nibandh jo woh pehle saal nahi likh sakti thi',
  'A student rereads an essay she wrote three years ago on the same question she has just answered again. The old one is not wrong. It is thinner, and she cannot point to any particular thing she has learned since that accounts for it.',
  'एक छात्रा तीन साल पहले लिखा अपना निबंध दोबारा पढ़ती है, उसी सवाल पर जिसका उसने अभी फिर जवाब दिया है। पुराना ग़लत नहीं है। वह पतला है, और वह ऐसी कोई ख़ास चीज़ नहीं बता सकती जो उसने तब से सीखी हो और जिससे यह फ़र्क़ समझ आता हो।',
  'Ek chhatra teen saal pehle likha apna nibandh dobara padhti hai, usi sawal par jiska usne abhi phir jawab diya hai. Purana galat nahi hai. Woh patla hai, aur woh aisi koi khaas cheez nahi bata sakti jo usne tab se seekhi ho aur jisse yeh farq samajh aata ho.',
  'Kālena is the honest word and this is the ordinary experience of it. Nothing identifiable was added. Something has become available that was not, and the only evidence is two documents and three years between them.',
  'कालेन ईमानदार शब्द है और यह उसका आम अनुभव है। कुछ भी पहचानने लायक़ जोड़ा नहीं गया। कुछ ऐसा उपलब्ध हो गया है जो नहीं था, और सबूत बस दो दस्तावेज़ हैं और उनके बीच के तीन साल।',
  'Kalena imaandaar shabd hai aur yeh uska aam anubhav hai. Kuch bhi pehchanne layak joda nahi gaya. Kuch aisa uplabdh ho gaya hai jo nahi tha, aur saboot bas do dastavez hain aur unke beech ke teen saal.',
  'Nothing identifiable was added. The evidence is two documents and three years.',
  'कुछ भी पहचानने लायक़ जोड़ा नहीं गया। सबूत दो दस्तावेज़ हैं और तीन साल।',
  'Kuch bhi pehchanne layak joda nahi gaya. Saboot do dastavez hain aur teen saal.',
  NULL, 'beginner', 'students,time,depth,evidence'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 4;

-- =====================================================================
-- 5. CROSS REFERENCES
-- =====================================================================
-- THIRTEEN DECLARED. Every target checked against the seeded verse list
-- first. Count the loaded rows against thirteen before shipping.
--
-- 4.13 gets THREE, on purpose, and they do not agree with each other:
-- 5.18 and 13.27 pull against the hereditary reading and 3.35 shows the
-- adjacent misuse. 18.41, which is the strongest support that reading
-- has, is not yet seeded and so cannot be linked — the explanation
-- names it in prose instead, because leaving it out would be picking a
-- side.
-- =====================================================================

DELETE x FROM verse_cross_references x JOIN verses v ON v.id = x.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 4;

INSERT INTO verse_cross_references
  (verse_id, reference_type, book, chapter, verse, target_verse_id,
   description_en, description_hi, description_hinglish, relationship, sort_order)
SELECT v.id, 'gita', 'Bhagavad Gita', CAST(x.tch AS CHAR), CAST(x.tvn AS CHAR), tv.id,
       x.d_en, x.d_hi, x.d_hing, x.rel, x.ord
FROM (
  SELECT 7 AS vn, 1 AS tch, 30 AS tvn, 1 AS ord,
    'A mind going round while everything looked like it was pointing the wrong way. Both verses are about a slackening rather than a break, and 1.30 is what it feels like from inside one.' AS d_en,
    'घूमता हुआ मन और सब कुछ उलटी दिशा में इशारा करता दिखता हुआ। दोनों श्लोक टूटने के नहीं, ढीले पड़ने के बारे में हैं, और 1.30 वह है जो उसके भीतर से महसूस होता है।' AS d_hi,
    'Ghoomta hua man aur sab kuch ulti disha mein ishara karta dikhta hua. Dono shloka tootne ke nahi, dheele padne ke baare mein hain, aur 1.30 woh hai jo uske bheetar se mehsoos hota hai.' AS d_hing,
    'supports' AS rel
  UNION ALL SELECT 8, 16, 4, 1,
    'Chapter 16 is the one most often read as sorting people into two kinds, and 16.4''s explanation refuses that. 4.8 is the verse most often used to license acting on such a sorting. Read them together and neither survives the use.',
    'सोलहवाँ अध्याय वही है जिसे सबसे ज़्यादा लोगों को दो क़िस्मों में छाँटने के तौर पर पढ़ा जाता है, और 16.4 की व्याख्या इससे इनकार करती है। 4.8 वह श्लोक है जिसका इस्तेमाल ऐसी छँटाई पर कार्रवाई की छूट के लिए सबसे ज़्यादा होता है। दोनों साथ पढ़िए और उस इस्तेमाल में कोई नहीं बचता।',
    'Solahvan adhyay wahi hai jise sabse zyada logon ko do kismon mein chhaantne ke taur par padha jaata hai, aur 16.4 ki vyakhya isse inkaar karti hai. 4.8 woh shloka hai jiska istemaal aisi chhantai par karvai ki chhoot ke liye sabse zyada hota hai. Dono saath padho aur us istemaal mein koi nahi bachta.',
    'opposite'
  UNION ALL SELECT 8, 18, 63, 1,
    'The book''s last instruction is think it over completely and then do as you wish. A text that ends there has not, four hundred verses earlier, issued anybody a licence.',
    'किताब की आख़िरी हिदायत है — पूरी तरह सोच लो और फिर जैसा चाहो करो। जो ग्रंथ वहाँ ख़त्म होता है उसने चार सौ श्लोक पहले किसी को कोई छूट जारी नहीं की।',
    'Kitaab ki aakhiri hidayat hai — poori tarah soch lo aur phir jaisa chaho karo. Jo granth wahan khatam hota hai usne chaar sau shloka pehle kisi ko koi chhoot jaari nahi ki.',
    'supports'
  UNION ALL SELECT 11, 18, 63, 1,
    'Two verses that make this text teachable to somebody with no background and no belief. One sets no entry condition; the other sets no exit condition either.',
    'दो श्लोक जो इस ग्रंथ को बिना पृष्ठभूमि और बिना आस्था वाले को पढ़ाने लायक़ बनाते हैं। एक भीतर आने की कोई शर्त नहीं रखता; दूसरा बाहर जाने की भी नहीं।',
    'Do shloka jo is granth ko bina prishthbhumi aur bina aastha wale ko padhane layak banate hain. Ek bheetar aane ki koi shart nahi rakhta; doosra bahar jaane ki bhi nahi.',
    'same'
  UNION ALL SELECT 11, 12, 13, 1,
    'No hatred towards any being. 4.11 is the same disposition stated from the other side — not how a person should meet others, but how they are met however they come.',
    'किसी प्राणी से द्वेष नहीं। 4.11 वही रुख़ है, दूसरी तरफ़ से कहा गया — यह नहीं कि इंसान दूसरों से कैसे मिले, बल्कि यह कि वे जैसे भी आएँ, उनसे कैसे मिला जाता है।',
    'Kisi prani se dwesh nahi. 4.11 wahi rukh hai, doosri taraf se kaha gaya — yeh nahi ki insan doosron se kaise mile, balki yeh ki woh jaise bhi aayein, unse kaise mila jaata hai.',
    'same'
  UNION ALL SELECT 13, 5, 18, 1,
    'The verse that pulls hardest against the hereditary reading, and it is in the same book. 5.18 puts a learned brahmin and a śvapāka in one line and declines to rank them.',
    'वह श्लोक जो वंशगत पाठ के ख़िलाफ़ सबसे ज़ोर से खींचता है, और वह इसी किताब में है। 5.18 एक विद्वान ब्राह्मण और एक श्वपाक को एक पंक्ति में रखता है और उनमें क्रम लगाने से इनकार करता है।',
    'Woh shloka jo vanshagat paath ke khilaf sabse zor se kheenchta hai, aur woh isi kitaab mein hai. 5.18 ek vidwan brahmin aur ek shvapak ko ek pankti mein rakhta hai aur unme kram lagane se inkaar karta hai.',
    'opposite'
  UNION ALL SELECT 13, 13, 27, 1,
    'Whoever sees the same thing standing in all beings is the one who sees. Read next to 4.13 it is the same disagreement the book is having with itself, stated without a list to argue about.',
    'जो सब प्राणियों में वही चीज़ खड़ी देखता है, वही देखता है। 4.13 के बग़ल में पढ़िए तो यह वही असहमति है जो किताब ख़ुद से कर रही है, और यहाँ बहस करने को कोई सूची भी नहीं है।',
    'Jo sab praniyon mein wahi cheez khadi dekhta hai, wahi dekhta hai. 4.13 ke bagal mein padho to yeh wahi asehmati hai jo kitaab khud se kar rahi hai, aur yahan behes karne ko koi soochi bhi nahi hai.',
    'opposite'
  UNION ALL SELECT 13, 3, 35, 1,
    'The adjacent misuse. 3.35 says better your own dharma than another''s and has been used for centuries to tell people their birth was their duty; its gloss says svadharma means OWN, not inherited. Same move, different verse.',
    'बग़ल वाला दुरुपयोग। 3.35 कहता है कि दूसरे के धर्म से अपना धर्म बेहतर है और सदियों तक इससे लोगों को बताया गया कि उनका जन्म ही उनका कर्तव्य है; उसका अर्थ कहता है कि स्वधर्म यानी अपना, विरासत में मिला नहीं। वही चाल, दूसरा श्लोक।',
    'Bagal wala durupyog. 3.35 kehta hai ki doosre ke dharm se apna dharm behtar hai aur sadiyon tak isse logon ko bataya gaya ki unka janm hi unka kartavya hai; uska arth kehta hai ki svadharm yani apna, virasat mein mila nahi. Wahi chaal, doosra shloka.',
    'same'
  UNION ALL SELECT 18, 3, 5, 1,
    'Nobody stays actionless even for a moment. 4.18 is why: the not-doing turns out to have doing inside it, so there was never an actionless option to take.',
    'कोई एक क्षण भी बिना कर्म के नहीं रहता। 4.18 वजह है: न-करने के भीतर करना निकल आता है, तो बिना कर्म वाला विकल्प कभी था ही नहीं।',
    'Koi ek pal bhi bina karm ke nahi rehta. 4.18 wajah hai: na-karne ke bheetar karna nikal aata hai, to bina karm wala vikalp kabhi tha hi nahi.',
    'same'
  UNION ALL SELECT 18, 5, 8, 1,
    '"I am not doing anything" while seeing, hearing and walking. 4.18 is the same puzzle stated as an instruction to look, and it adds the half 5.8 leaves out.',
    '"मैं कुछ नहीं करता" — और साथ ही देखते, सुनते, चलते हुए। 4.18 वही पहेली है, देखने की हिदायत की तरह कही गई, और वह वह आधा जोड़ता है जो 5.8 छोड़ देता है।',
    '"Main kuch nahi karta" — aur saath hi dekhte, sunte, chalte hue. 4.18 wahi paheli hai, dekhne ki hidayat ki tarah kahi gayi, aur woh woh aadha jodta hai jo 5.8 chhod deta hai.',
    'same'
  UNION ALL SELECT 20, 5, 10, 1,
    'The lotus leaf. 4.20 says the same thing without the picture and adds the word that matters: abhipravṛttaḥ, fully engaged. The leaf is in the water; he is in the work.',
    'कमल का पत्ता। 4.20 वही बात बिना तस्वीर के कहता है और वह शब्द जोड़ता है जो मायने रखता है: अभिप्रवृत्तः, पूरी तरह लगा हुआ। पत्ता पानी में है; वह काम में है।',
    'Kamal ka patta. 4.20 wahi baat bina tasveer ke kehta hai aur woh shabd jodta hai jo maayne rakhta hai: abhipravrittah, poori tarah laga hua. Patta paani mein hai; woh kaam mein hai.',
    'same'
  UNION ALL SELECT 34, 18, 63, 1,
    'Ask all the way round the thing; and at the end, think it over completely and then do as you wish. The same speaker, four hundred verses apart, refusing to be simply obeyed twice.',
    'चीज़ के चारों तरफ़ से पूछो; और अंत में, पूरी तरह सोच लो और फिर जैसा चाहो करो। वही वक्ता, चार सौ श्लोक के फ़ासले पर, दो बार सिर्फ़ माने जाने से इनकार करता हुआ।',
    'Cheez ke chaaron taraf se poocho; aur ant mein, poori tarah soch lo aur phir jaisa chaho karo. Wahi vakta, chaar sau shloka ke faasle par, do baar sirf maane jaane se inkaar karta hua.',
    'same'
  UNION ALL SELECT 38, 6, 35, 1,
    'By practice and by loosening the grip. 4.38 says the same thing about time — nobody hands it over, it arrives in you, and it arrives late.',
    'अभ्यास से और पकड़ ढीली करने से। 4.38 वही बात समय के बारे में कहता है — कोई इसे सौंपता नहीं, यह आपके भीतर आती है, और देर से आती है।',
    'Abhyas se aur pakad dheeli karne se. 4.38 wahi baat samay ke baare mein kehta hai — koi ise saunpta nahi, yeh tumhare bheetar aati hai, aur der se aati hai.',
    'same'
) AS x
JOIN verses v  ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 4
JOIN chapters tc ON tc.chapter_number = x.tch
JOIN verses tv ON tv.verse_number = x.tvn AND tv.chapter_id = tc.id;

-- =====================================================================
-- 6. WORD BY WORD
-- =====================================================================
-- Three glosses carry the chapter's weight:
--   guṇa-karma-vibhāgaśaḥ (4.13) says what the criterion IS and that
--                                the word for birth is not in the line
--   akartāram (4.13)             says the verse withdraws its own claim
--   sambhavāmi (4.8)             says the verb is first person
-- All glosses stay under 400 characters — the column is varchar(400).
-- =====================================================================

DELETE w FROM verse_word_meanings w JOIN verses v ON v.id = w.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 4;

INSERT INTO verse_word_meanings
  (verse_id, word_order, devanagari, transliteration,
   meaning_en, meaning_hi, meaning_hinglish, grammar, root_word)
SELECT v.id, w.ord, w.dev, w.tr, w.m_en, w.m_hi, w.m_hing, w.gram, w.root FROM (

  SELECT 7 AS vn, 1 AS ord, 'ग्लानिः' AS dev, 'glāniḥ' AS tr, 'sagging, going slack, losing tension — the way a rope does or a face does. NOT defeat and not destruction. Something that was holding has stopped holding as well' AS m_en, 'ग्लानि — ढीला पड़ना, शिथिल होना, कसाव खोना; जैसे रस्सी खोती है या चेहरा। हार नहीं और विनाश नहीं। जो थामे हुए थी वह उतना अच्छा थामना बंद कर चुकी है' AS m_hi, 'glani — dheela padna, shithil hona, kasav khona; jaise rassi khoti hai ya chehra. Haar nahi aur vinash nahi. Jo thaame hue thi woh utna achha thaamna band kar chuki hai' AS m_hing, 'nominative singular' AS gram, 'ग्लै' AS root
  UNION ALL SELECT 7, 2, 'यदा यदा', 'yadā yadā', 'whenever, repeatedly — the doubling makes it a pattern rather than a single event', 'जब-जब — दोहराव इसे एक घटना नहीं, एक ढर्रा बना देता है', 'jab-jab — dohrav ise ek ghatna nahi, ek dharra bana deta hai', 'indeclinable', NULL
  UNION ALL SELECT 7, 3, 'अभ्युत्थानम्', 'abhyutthānam', 'a rising up, a standing forth — said of adharma, and it is the counterpart to the sagging', 'अभ्युत्थान — उठ खड़ा होना; अधर्म के लिए कहा गया, और यह उस ढीले पड़ने का जोड़ीदार है', 'abhyutthan — uth khada hona; adharm ke liye kaha gaya, aur yeh us dheele padne ka jodidar hai', 'nominative singular', 'अभि + उद् + स्था'
  UNION ALL SELECT 7, 4, 'सृजामि अहम्', 'sṛjāmy aham', 'I bring forth, I send out — first person, and the object is ātmānam, myself. Not something dispatched; the speaker put out into it', 'मैं रचता हूँ, मैं भेजता हूँ — उत्तम पुरुष, और कर्म है आत्मानम्, ख़ुद को। कुछ भेजा नहीं गया; वक्ता ख़ुद उसमें उतरा', 'main rachta hoon, main bhejta hoon — uttam purush, aur karm hai atmanam, khud ko. Kuch bheja nahi gaya; vakta khud usme utra', 'present, first singular', 'सृज्'

  UNION ALL SELECT 8, 1, 'परित्राणाय', 'paritrāṇāya', 'for the getting-out-of, for rescue — pari- is all round, so it is deliverance from something surrounding', 'परित्राण के लिए — बचा लेने के लिए; परि- यानी चारों तरफ़, यानी किसी घेरे से निकाल लेना', 'paritran ke liye — bacha lene ke liye; pari- yani chaaron taraf, yani kisi ghere se nikaal lena', 'dative singular', 'परि + त्रै'
  UNION ALL SELECT 8, 2, 'विनाशाय दुष्कृताम्', 'vināśāya duṣkṛtām', 'for the undoing of those who do harm — duṣ-kṛt is literally bad-doer, defined by the doing and not by who somebody is', 'दुष्कृतों के विनाश के लिए — दुष्-कृत् शब्दशः बुरा-करने-वाला है, जो करने से तय होता है, इससे नहीं कि कोई है कौन', 'dushkriton ke vinash ke liye — dush-krit shabdashah bura-karne-wala hai, jo karne se tay hota hai, isse nahi ki koi hai kaun', 'dative plural', 'दुष् + कृ'
  UNION ALL SELECT 8, 3, 'सम्भवामि', 'sambhavāmi', 'I come into being. FIRST PERSON, singular, present — and so is every other verb in the verse. It is a statement about what the speaker does. Nobody in the book is instructed to do it, and Arjuna, who asked directly for a reason to fight, is never given this one', 'मैं होता हूँ, मैं आता हूँ। उत्तम पुरुष, एकवचन, वर्तमान — और श्लोक की हर दूसरी क्रिया भी। यह वक्ता क्या करता है इसका बयान है। किताब में किसी से यह करने को नहीं कहा गया, और अर्जुन, जिसने सीधे लड़ने की वजह माँगी, उसे यह वजह कभी नहीं दी जाती', 'main hota hoon, main aata hoon. Uttam purush, ekvachan, vartaman — aur shloka ki har doosri kriya bhi. Yeh vakta kya karta hai iska bayan hai. Kitaab mein kisi se yeh karne ko nahi kaha gaya, aur Arjun, jisne seedhe ladne ki wajah maangi, use yeh wajah kabhi nahi di jaati', 'present, first singular', 'सम् + भू'
  UNION ALL SELECT 8, 4, 'युगे युगे', 'yuge yuge', 'age after age — the doubling again, and it puts the whole sentence outside anybody''s particular afternoon', 'युग-युग में — फिर वही दोहराव, और वह पूरे वाक्य को किसी की किसी ख़ास दोपहर से बाहर रख देता है', 'yug-yug mein — phir wahi dohrav, aur woh poore vakya ko kisi ki kisi khaas dopahar se bahar rakh deta hai', 'locative singular', NULL

  UNION ALL SELECT 11, 1, 'ये यथा', 'ye yathā', 'those who, in whatever way — the construction leaves the manner completely open', 'जो, जिस तरह से भी — रचना तरीक़े को पूरी तरह खुला छोड़ देती है', 'jo, jis tarah se bhi — rachna tareeke ko poori tarah khula chhod deti hai', 'nominative plural', NULL
  UNION ALL SELECT 11, 2, 'प्रपद्यन्ते', 'prapadyante', 'they approach, they come towards — and no condition is attached to the approaching', 'वे आते हैं, वे पास आते हैं — और आने के साथ कोई शर्त नहीं लगाई गई', 'woh aate hain, woh paas aate hain — aur aane ke saath koi shart nahi lagayi gayi', 'present middle, third plural', 'प्र + पद्'
  UNION ALL SELECT 11, 3, 'भजामि अहम्', 'bhajāmy aham', 'I meet them, I take part with them — bhaj is sharing and belonging, not rewarding', 'मैं उनसे मिलता हूँ, उनमें भाग लेता हूँ — भज् बाँटने और अपना होने का शब्द है, इनाम देने का नहीं', 'main unse milta hoon, unme bhaag leta hoon — bhaj baantne aur apna hone ka shabd hai, inaam dene ka nahi', 'present, first singular', 'भज्'
  UNION ALL SELECT 11, 4, 'सर्वशः', 'sarvaśaḥ', 'in every way, from every direction — the word that makes this a claim about everybody rather than about the well-disposed', 'सर्वशः — हर तरह से, हर दिशा से; वही शब्द जो इसे भले-मनवालों के बारे में नहीं, सबके बारे में दावा बनाता है', 'sarvashah — har tarah se, har disha se; wahi shabd jo ise bhale-manwalon ke baare mein nahi, sabke baare mein dawa banata hai', 'indeclinable', 'सर्व'

  UNION ALL SELECT 13, 1, 'चातुर्वर्ण्यम्', 'cātur-varṇyam', 'the fourfold varṇa — an abstract noun, the fourfoldness rather than four groups of people. Varṇa itself is a wide word; its root sense is colour or covering, and it was applied to social order later', 'चातुर्वर्ण्य — चार वर्णों वाला होना; यह भाववाचक संज्ञा है, चार समूह नहीं। वर्ण ख़ुद चौड़ा शब्द है; उसकी मूल भावना रंग या आवरण की है, और सामाजिक क्रम पर वह बाद में लगाया गया', 'chatur-varnya — chaar varnon wala hona; yeh bhaavvachak sangya hai, chaar samooh nahi. Varna khud chauda shabd hai; uski mool bhavna rang ya aavaran ki hai, aur samajik kram par woh baad mein lagaya gaya', 'nominative singular', 'वर्ण'
  UNION ALL SELECT 13, 2, 'गुणकर्मविभागशः', 'guṇa-karma-vibhāgaśaḥ', 'DIVIDED ACCORDING TO QUALITY AND ACTION. This is the criterion the verse states, and it is the whole of it. The Sanskrit word for birth, janma, does not appear anywhere in the line. That does not undo the history — the verse was read as birth for centuries anyway — but it settles what the words say', 'गुण और कर्म के विभाग से। यही कसौटी श्लोक बताता है, और यही पूरी है। जन्म का संस्कृत शब्द, जन्म, इस पंक्ति में कहीं नहीं आता। इससे इतिहास मिटता नहीं — श्लोक को सदियों तक जन्म ही पढ़ा गया — पर इससे यह तय होता है कि शब्द कहते क्या हैं', 'gun aur karm ke vibhag se. Yahi kasauti shloka batata hai, aur yahi poori hai. Janm ka Sanskrit shabd, janma, is pankti mein kahin nahi aata. Isse itihaas mitta nahi — shloka ko sadiyon tak janm hi padha gaya — par isse yeh tay hota hai ki shabd kehte kya hain', 'adverbial', 'वि + भज्'
  UNION ALL SELECT 13, 3, 'मया सृष्टम्', 'mayā sṛṣṭam', 'brought forth by me — instrumental, so the claim is about origin. The next line immediately qualifies it', 'मुझसे रचा गया — करण कारक, यानी दावा उत्पत्ति के बारे में है। अगली पंक्ति फ़ौरन उस पर शर्त लगा देती है', 'mujhse racha gaya — karan karak, yani dawa utpatti ke baare mein hai. Agli pankti fauran us par shart laga deti hai', 'past participle', 'सृज्'
  UNION ALL SELECT 13, 4, 'कर्तारम् अपि', 'kartāram api', 'the maker, indeed — the first half of a pair, and api signals that something is about to be conceded', 'कर्ता भी — जोड़ी का पहला आधा, और अपि इशारा करता है कि अभी कुछ मान लिया जाने वाला है', 'karta bhi — jodi ka pehla aadha, aur api ishara karta hai ki abhi kuch maan liya jaane wala hai', 'accusative singular', 'कृ'
  UNION ALL SELECT 13, 5, 'अकर्तारम्', 'akartāram', 'AND THE NON-MAKER. The verse withdraws its own authorship claim in the same breath it makes it, and this is the half that gets cut when the line is quoted. Whatever anybody wants to build on the first half, the second half is standing underneath it', 'और अकर्ता। श्लोक अपना कर्तापन का दावा उसी साँस में वापस ले लेता है जिसमें करता है, और पंक्ति उद्धृत होते वक़्त यही आधा कट जाता है। पहले आधे पर कोई जो भी खड़ा करना चाहे, दूसरा आधा उसके नीचे खड़ा है', 'aur akarta. Shloka apna kartapan ka dawa usi saans mein wapas le leta hai jisme karta hai, aur pankti uddhrit hote waqt yahi aadha kat jaata hai. Pehle aadhe par koi jo bhi khada karna chahe, doosra aadha uske neeche khada hai', 'accusative singular', 'कृ'

  UNION ALL SELECT 18, 1, 'कर्मणि अकर्म', 'karmaṇy akarma', 'inaction in action — the half people expect, and chapter 3''s point restated', 'कर्म में अकर्म — वह आधा जिसकी उम्मीद होती है, और तीसरे अध्याय की बात दोबारा', 'karm mein akarm — woh aadha jiski ummeed hoti hai, aur teesre adhyay ki baat dobara', 'locative + nominative', 'कृ'
  UNION ALL SELECT 18, 2, 'अकर्मणि कर्म', 'akarmaṇi ca karma', 'AND ACTION IN INACTION — the half that removes an exit rather than opening one. Not replying is a reply; not deciding is a decision with a start date', 'और अकर्म में कर्म — वह आधा जो निकास खोलता नहीं, बंद करता है। जवाब न देना भी जवाब है; तय न करना भी एक फ़ैसला है जिसकी शुरुआत की तारीख़ है', 'aur akarm mein karm — woh aadha jo nikaas kholta nahi, band karta hai. Jawab na dena bhi jawab hai; tay na karna bhi ek faisla hai jiski shuruaat ki tareekh hai', 'locative + nominative', 'कृ'
  UNION ALL SELECT 18, 3, 'बुद्धिमान्', 'buddhimān', 'one who has understanding — not clever. The verse is not complimenting anybody''s quickness', 'बुद्धिमान — जिसके पास समझ है; चतुर नहीं। श्लोक किसी की तेज़ी की तारीफ़ नहीं कर रहा', 'buddhiman — jiske paas samajh hai; chatur nahi. Shloka kisi ki tezi ki tareef nahi kar raha', 'nominative singular', 'बुध्'
  UNION ALL SELECT 18, 4, 'कृत्स्नकर्मकृत्', 'kṛtsna-karma-kṛt', 'one who has done the whole of what there is to do — kṛtsna is the same word as in 13.34, the whole of it', 'जिसने पूरा करने लायक़ काम कर लिया — कृत्स्न वही शब्द है जो 13.34 में है, पूरा का पूरा', 'jisne poora karne layak kaam kar liya — kritsna wahi shabd hai jo 13.34 mein hai, poora ka poora', 'nominative singular', 'कृ'

  UNION ALL SELECT 20, 1, 'नित्यतृप्तः', 'nitya-tṛptaḥ', 'steadily content — tṛpta is the satisfaction after enough, and nitya makes it a standing condition rather than a mood', 'नित्यतृप्त — लगातार संतुष्ट; तृप्त वह संतोष है जो पर्याप्त के बाद आता है, और नित्य उसे मनोदशा नहीं, टिकी हुई हालत बना देता है', 'nitya-tript — lagataar santusht; tript woh santosh hai jo paryapt ke baad aata hai, aur nitya use manodasha nahi, tiki hui haalat bana deta hai', 'nominative singular', 'तृप्'
  UNION ALL SELECT 20, 2, 'निराश्रयः', 'nirāśrayaḥ', 'leaning on nothing — āśraya is a support, a prop, the thing something rests against. Most demanding work has one propped under it: the recognition, the title, the person who will be impressed', 'निराश्रय — किसी पर टिका नहीं; आश्रय यानी सहारा, टेक, वह चीज़ जिस पर कुछ टिकता है। मेहनत के ज़्यादातर काम के नीचे कोई सहारा लगा होता है: पहचान, ओहदा, वह इंसान जो प्रभावित होगा', 'nirashray — kisi par tika nahi; aashray yani sahara, tek, woh cheez jis par kuch tikta hai. Mehnat ke zyadatar kaam ke neeche koi sahara laga hota hai: pehchan, ohda, woh insan jo prabhavit hoga', 'nominative singular', 'आ + श्रि'
  UNION ALL SELECT 20, 3, 'अभिप्रवृत्तः अपि', 'abhipravṛtto ''pi', 'ALTHOUGH fully engaged, right into it. The verse insists on this before it says he does nothing, and the order is the argument — this is not somebody standing back', 'पूरी तरह लगे होते हुए भी, ठीक उसी में। श्लोक यह कहने से पहले कि वह कुछ नहीं करता, इसी पर ज़ोर देता है, और क्रम ही दलील है — यह कोई पीछे हटकर खड़ा इंसान नहीं है', 'poori tarah lage hote hue bhi, theek usi mein. Shloka yeh kehne se pehle ki woh kuch nahi karta, isi par zor deta hai, aur kram hi dalil hai — yeh koi peechhe hatkar khada insan nahi hai', 'nominative singular', 'अभि + प्र + वृत्'

  UNION ALL SELECT 34, 1, 'प्रणिपातेन', 'praṇipātena', 'by putting yourself lower — literally falling forward. It is the price of the middle term rather than the point', 'प्रणिपात से — शब्दशः आगे झुक जाना। यह बीच वाले शब्द की क़ीमत है, बात नहीं', 'pranipat se — shabdashah aage jhuk jaana. Yeh beech wale shabd ki keemat hai, baat nahi', 'instrumental singular', 'प्र + नि + पत्'
  UNION ALL SELECT 34, 2, 'परिप्रश्नेन', 'paripraśnena', 'BY ASKING ALL THE WAY ROUND — pari- is the prefix in perimeter. Not polite enquiry; interrogation from every side until the thing has been turned over. It sits between two forms of deference on purpose', 'परिप्रश्न से — चारों तरफ़ से पूछकर; परि- वही उपसर्ग है जो परिधि में है। शिष्टाचार वाला सवाल नहीं; हर तरफ़ से खोदकर पूछना जब तक चीज़ पलट न जाए। यह जानबूझकर विनय के दो रूपों के बीच बैठा है', 'pariprashna se — chaaron taraf se poochhkar; pari- wahi upasarg hai jo paridhi mein hai. Shishtachar wala sawal nahi; har taraf se khodkar poochhna jab tak cheez palat na jaaye. Yeh jaanboojhkar vinay ke do roopon ke beech baitha hai', 'instrumental singular', 'परि + प्रछ्'
  UNION ALL SELECT 34, 3, 'सेवया', 'sevayā', 'by making yourself useful — service, and the third of the three', 'सेवा से — अपने को काम का बनाकर; तीनों में तीसरा', 'seva se — apne ko kaam ka banakar; teenon mein teesra', 'instrumental singular', 'सेव्'
  UNION ALL SELECT 34, 4, 'तत्त्वदर्शिनः', 'tattva-darśinaḥ', 'those who see how things actually are — the qualification is on the seeing, not on any office they hold', 'तत्त्वदर्शी — जो देखते हैं कि चीज़ें असल में हैं कैसी; योग्यता देखने पर है, किसी पद पर नहीं', 'tattvadarshi — jo dekhte hain ki cheezein asal mein hain kaisi; yogyata dekhne par hai, kisi pad par nahi', 'nominative plural', 'दृश्'

  UNION ALL SELECT 38, 1, 'पवित्रम्', 'pavitram', 'cleansing, making fit — the sense is a filter or a strainer, something that removes what should not be there. Not holiness', 'पवित्र — साफ़ करने वाला, काम लायक़ बनाने वाला; भावना छन्ने की है, जो हटा दे वह जो नहीं होना चाहिए। पावनता नहीं', 'pavitra — saaf karne wala, kaam layak banane wala; bhavna chhanne ki hai, jo hata de woh jo nahi hona chahiye. Paavanta nahi', 'nominative singular', 'पू'
  UNION ALL SELECT 38, 2, 'स्वयम्', 'svayam', 'of their own accord — so nobody hands it over. The first of three limits at the end of the verse', 'स्वयम् — अपने आप; यानी कोई इसे सौंप नहीं देता। श्लोक के अंत की तीन सीमाओं में पहली', 'svayam — apne aap; yani koi ise saunp nahi deta. Shloka ke ant ki teen seemaon mein pehli', 'indeclinable', NULL
  UNION ALL SELECT 38, 3, 'आत्मनि', 'ātmani', 'in themselves — so it is not somewhere else to be fetched from. The second limit', 'आत्मनि — अपने भीतर; यानी यह कहीं और से लाने की चीज़ नहीं। दूसरी सीमा', 'atmani — apne bheetar; yani yeh kahin aur se laane ki cheez nahi. Doosri seema', 'locative singular', 'आत्मन्'
  UNION ALL SELECT 38, 4, 'कालेन', 'kālena', 'IN TIME — so it is not available this afternoon. The third limit, and the honest one. A chapter that has just made the largest claim in the book about knowledge closes by saying you cannot have it yet', 'कालेन — समय के साथ; यानी यह आज दोपहर उपलब्ध नहीं है। तीसरी सीमा, और ईमानदार वाली। जो अध्याय अभी ज्ञान के बारे में किताब का सबसे बड़ा दावा कर चुका है वह यह कहकर बंद होता है कि यह तुम्हें अभी नहीं मिल सकता', 'kalena — samay ke saath; yani yeh aaj dopahar uplabdh nahi hai. Teesri seema, aur imaandaar wali. Jo adhyay abhi gyan ke baare mein kitaab ka sabse bada dawa kar chuka hai woh yeh kehkar band hota hai ki yeh tumhe abhi nahi mil sakta', 'instrumental singular', 'काल'
) AS w
JOIN verses v ON v.verse_number = w.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 4;
