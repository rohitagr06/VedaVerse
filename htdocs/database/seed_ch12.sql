-- =====================================================================
-- VedaVerse — database/seed_ch12.sql
-- =====================================================================
-- Chapter 12, Bhakti Yoga. Eight verses.
--
--   12.5   the abstract path is harder, and the text says so itself
--   12.8   put your attention here, and keep putting it here
--   12.12  the ladder, ending in: peace follows giving up the fruit
--   12.13  no ill-will, friendly, compassionate, without "mine"
--   12.15  does not disturb the world, is not disturbed by it
--   12.16  impartial, capable, unworried, not always starting over
--   12.18  the same to friend and enemy, praise and insult
--   12.19  content with what comes, not needing a fixed place
--
-- THIS CHAPTER NEEDS A DECISION MADE OUT LOUD
--   Chapter 12 is the devotional chapter. It is addressed to somebody
--   who has, or wants, a personal relationship with a god, and its
--   famous second half is not a neutral list of good qualities — it is a
--   list of who is DEAR TO that god. The refrain "sa me priyaḥ" is in
--   the Sanskrit eight times and cannot be quietly dropped.
--
--   A product that teaches this text to people with no background in
--   Hinduism has two dishonest options and one honest one. It can
--   pretend the frame is not there and present 12.13–12.19 as secular
--   self-improvement, which misrepresents the chapter. It can present
--   the frame as a requirement, which excludes most of the audience for
--   no reason the text itself gives. Or it can do what this file does:
--   state plainly who the chapter is addressed to, translate the
--   refrain rather than erasing it, and say — once, in the explanation
--   for 12.13, and not repeated at every verse — that the qualities
--   described are practicable by somebody who does not share the frame,
--   and that the text does not claim otherwise.
--
--   The 12.5 explanation carries the other half of this. That verse is
--   the text conceding that the abstract, impersonal path is harder for
--   people with bodies. Read as doctrine it settles nothing; read as
--   observation it is unusually generous, and it is the reason the rest
--   of the chapter exists at all.
--
-- 12.16 HAS A SMALLER TRAP
--   "sarvārambha-parityāgī" — giving up all undertakings — reads in
--   English like an argument for doing nothing, which would contradict
--   chapter 3 outright. The gloss and the explanation both say what the
--   compound actually describes: not the abandonment of work, but the
--   end of the restless starting-over that never finishes anything.
--
-- CONTENT RULES — unchanged
--   Original writing throughout. Sanskrit unaltered, numbering
--   untouched. Films named as facts, no dialogue or lyrics. No praise or
--   criticism of any living politician, party or movement. No communal
--   framing anywhere, and a devotional chapter is where that rule earns
--   its keep: nothing in this file says or implies that one way of
--   believing, or of not believing, is better than another.
--
-- RUN AFTER seed_sample.sql. Re-runnable.
--
--     mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
--         < htdocs/database/seed_ch12.sql
--
-- global_order is 469 + verse_number: chapters 1 to 11 have 469 verses
-- between them.
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

  SELECT 5 AS verse_number, 474 AS global_order, 1 AS is_curated, 'gita-12-5' AS slug,
    'क्लेशोऽधिकतरस्तेषामव्यक्तासक्तचेतसाम्।\nअव्यक्ता हि गतिर्दुःखं देहवद्भिरवाप्यते॥' AS sanskrit_devanagari,
    'kleśo ''dhikataras teṣām avyaktāsakta-cetasām\navyaktā hi gatir duḥkhaṁ dehavadbhir avāpyate' AS transliteration_iast,
    'klesho dhikataras tesham avyaktasakta-chetasam\navyakta hi gatir duhkham dehavadbhir avapyate' AS transliteration_simple,
    'Greater is the difficulty for those whose minds are attached to the unmanifest. For the goal that has no form is reached with hardship by those who have bodies.' AS translation_literal,
    'It is harder for the ones who fix on what has no shape. A goal with nothing to hold is reached painfully by people who have bodies.' AS translation_en,
    'जो निराकार पर टिकते हैं, उनके लिए यह ज़्यादा कठिन है। जिस लक्ष्य में पकड़ने को कुछ नहीं, उस तक शरीर वाले लोग तकलीफ़ से पहुँचते हैं।' AS translation_hi,
    'Jo nirakar par tikte hain, unke liye yeh zyada mushkil hai. Jis lakshya mein pakadne ko kuch nahi, wahan tak sharir wale log takleef se pahunchte hain.' AS translation_hinglish,
    'The text admits its own hard path is hard. That admission is why the rest of this chapter exists.' AS summary_en,
    'ग्रंथ ख़ुद मानता है कि उसका कठिन रास्ता कठिन है। यही स्वीकार बाक़ी अध्याय की वजह है।' AS summary_hi,
    'Text khud maanta hai ki uska mushkil rasta mushkil hai. Yahi sweekar baaki chapter ki wajah hai.' AS summary_hinglish,
    'intermediate' AS difficulty,
    'Gita 12.5: why the abstract path is harder' AS seo_title,
    'The Bhagavad Gita concedes that a formless goal is harder for embodied people to hold on to. An unusually honest admission, and the reason chapter 12 exists.' AS seo_description,
    1 AS published

  UNION ALL SELECT 8, 477, 1, 'gita-12-8',
    'मय्येव मन आधत्स्व मयि बुद्धिं निवेशय।\nनिवसिष्यसि मय्येव अत ऊर्ध्वं न संशयः॥',
    'mayy eva mana ādhatsva mayi buddhiṁ niveśaya\nnivasiṣyasi mayy eva ata ūrdhvaṁ na saṁśayaḥ',
    'mayy eva mana adhatsva mayi buddhim niveshaya\nnivasishyasi mayy eva ata urdhvam na samshayah',
    'Fix your mind on me alone; place your understanding in me. You will dwell in me from then onwards — of this there is no doubt.',
    'Put your attention here. Put your judgement here too. After that you live here — there is no doubt about it.',
    'अपना ध्यान यहाँ रखिए। अपनी समझ भी यहीं रखिए। उसके बाद आप यहीं रहते हैं — इसमें कोई संदेह नहीं।',
    'Apna dhyan yahan rakho. Apni samajh bhi yahin rakho. Uske baad tum yahin rehte ho — isme koi shak nahi.',
    'The instruction is attention, given twice. Where the attention goes, the person ends up living.',
    'हिदायत ध्यान की है, दो बार दी गई। ध्यान जहाँ जाता है, आदमी वहीं रहने लगता है।',
    'Hidayat dhyan ki hai, do baar di gayi. Dhyan jahan jaata hai, aadmi wahin rehne lagta hai.',
    'beginner',
    'Gita 12.8: where your attention goes, you live',
    'The Bhagavad Gita gives one instruction twice — put your attention here, put your judgement here. What you attend to is where you end up living.',
    1

  UNION ALL SELECT 12, 481, 1, 'gita-12-12',
    'श्रेयो हि ज्ञानमभ्यासाज्ज्ञानाद्ध्यानं विशिष्यते।\nध्यानात्कर्मफलत्यागस्त्यागाच्छान्तिरनन्तरम्॥',
    'śreyo hi jñānam abhyāsāj jñānād dhyānaṁ viśiṣyate\ndhyānāt karma-phala-tyāgas tyāgāc chāntir anantaram',
    'shreyo hi jnanam abhyasaj jnanad dhyanam vishishyate\ndhyanat karma-phala-tyagas tyagach chhantir anantaram',
    'Better than practice is knowledge; than knowledge, meditation is held higher; than meditation, giving up the fruit of action; from that giving up, peace immediately follows.',
    'Understanding beats drilling. Sustained attention beats understanding. Letting go of what the work earns you beats all of it — and peace follows that at once, not eventually.',
    'समझना रटने से बेहतर है। टिका हुआ ध्यान समझने से बेहतर है। काम से जो मिलना है उसे छोड़ देना इन सबसे बेहतर है — और शांति उसके तुरंत बाद आती है, कभी बाद में नहीं।',
    'Samajhna ratne se behtar hai. Tika hua dhyan samajhne se behtar hai. Kaam se jo milna hai use chhod dena in sabse behtar hai — aur shanti uske turant baad aati hai, kabhi baad mein nahi.',
    'A ranked list that ends somewhere unexpected, and the last step is the one from chapter 2.',
    'क्रम में रखी सूची जो अनपेक्षित जगह ख़त्म होती है, और आख़िरी सीढ़ी दूसरे अध्याय वाली है।',
    'Kram mein rakhi list jo unexpected jagah khatam hoti hai, aur aakhiri seedhi doosre chapter wali hai.',
    'intermediate',
    'Gita 12.12: the ladder that ends in letting go',
    'The Bhagavad Gita ranks practice, knowledge and meditation, then puts something above all three: giving up the fruit of the work. Peace follows that immediately.',
    1

  UNION ALL SELECT 13, 482, 1, 'gita-12-13',
    'अद्वेष्टा सर्वभूतानां मैत्रः करुण एव च।\nनिर्ममो निरहङ्कारः समदुःखसुखः क्षमी॥',
    'adveṣṭā sarva-bhūtānāṁ maitraḥ karuṇa eva ca\nnirmamo nirahaṅkāraḥ sama-duḥkha-sukhaḥ kṣamī',
    'adveshta sarva-bhutanam maitrah karuna eva cha\nnirmamo nirahankarah sama-duhkha-sukhah kshami',
    'Bearing ill-will towards no being, friendly and compassionate, without "mine", without "I", the same in pain and pleasure, forgiving.',
    'Holding nothing against anybody. Warm, and moved by what happens to people. Without a grip on "mine" and without a case to make for himself. The same in a bad week and a good one. Slow to keep score.',
    'किसी के ख़िलाफ़ कुछ मन में नहीं रखता। गर्मजोश, और लोगों के साथ जो होता है उससे हिलता है। "मेरा" पर पकड़ नहीं, और अपने बारे में कोई दलील नहीं। बुरे हफ़्ते और अच्छे हफ़्ते में एक जैसा। हिसाब रखने में धीमा।',
    'Kisi ke khilaf kuch man mein nahi rakhta. Garmjosh, aur logon ke saath jo hota hai usse hilta hai. "Mera" par pakad nahi, aur apne baare mein koi dalil nahi. Bure hafte aur achhe hafte mein ek jaisa. Hisaab rakhne mein dheema.',
    'The list starts here. Six things, and not one of them is a belief.',
    'सूची यहाँ से शुरू होती है। छह बातें, और उनमें एक भी मान्यता नहीं है।',
    'List yahan se shuru hoti hai. Chhah baatein, aur unme ek bhi maanyata nahi hai.',
    'beginner',
    'Gita 12.13: six qualities, none of them a belief',
    'The Bhagavad Gita begins its portrait of the person it calls dear: no ill-will, warmth, compassion, no grip on "mine", the same in pain and pleasure, forgiving.',
    1

  UNION ALL SELECT 15, 484, 1, 'gita-12-15',
    'यस्मान्नोद्विजते लोको लोकान्नोद्विजते च यः।\nहर्षामर्षभयोद्वेगैर्मुक्तो यः स च मे प्रियः॥',
    'yasmān nodvijate loko lokān nodvijate ca yaḥ\nharṣāmarṣa-bhayodvegair mukto yaḥ sa ca me priyaḥ',
    'yasman nodvijate loko lokan nodvijate cha yah\nharshamarsha-bhayodvegair mukto yah sa cha me priyah',
    'He from whom the world is not agitated, and who is not agitated by the world, freed from elation, resentment, fear and anxiety — he too is dear to me.',
    'Nobody tenses when he walks in, and he does not tense when the world walks in. Not carried off by a high, not eaten by resentment, not run by fear, not permanently braced. That one, too, is dear to me.',
    'वह आए तो कोई सिकुड़ता नहीं, और दुनिया आए तो वह सिकुड़ता नहीं। न किसी उछाल में बहता है, न मलाल में घुलता है, न डर के चलाए चलता है, न हमेशा तना रहता है। वह भी मुझे प्रिय है।',
    'Woh aaye to koi sikudta nahi, aur duniya aaye to woh sikudta nahi. Na kisi ubhaar mein behta hai, na malaal mein ghulta hai, na dar ke chalaye chalta hai, na hamesha tana rehta hai. Woh bhi mujhe priya hai.',
    'Two directions, stated as one test. Easy to be calm alone; the verse asks about the room.',
    'दो दिशाएँ, एक ही कसौटी की तरह। अकेले में शांत रहना आसान है; श्लोक कमरे के बारे में पूछता है।',
    'Do dishayein, ek hi kasauti ki tarah. Akele mein shaant rehna asaan hai; shloka kamre ke baare mein poochta hai.',
    'beginner',
    'Gita 12.15: not disturbing, and not disturbed',
    'The Bhagavad Gita sets a two-way test: the world is not agitated by him and he is not agitated by the world. Being calm alone is the easy half.',
    1

  UNION ALL SELECT 16, 485, 1, 'gita-12-16',
    'अनपेक्षः शुचिर्दक्ष उदासीनो गतव्यथः।\nसर्वारम्भपरित्यागी यो मद्भक्तः स मे प्रियः॥',
    'anapekṣaḥ śucir dakṣa udāsīno gata-vyathaḥ\nsarvārambha-parityāgī yo mad-bhaktaḥ sa me priyaḥ',
    'anapekshah shuchir daksha udasino gata-vyathah\nsarvarambha-parityagi yo mad-bhaktah sa me priyah',
    'Free from expectation, clean, capable, impartial, whose distress has gone, who has given up all undertakings — that one, devoted to me, is dear to me.',
    'Not waiting on anything. Straight in his dealings. Good at what he does. Not taking a side to be on a side. The old ache gone. And done with starting over — not done with working. That one is dear to me.',
    'किसी चीज़ के इंतज़ार में नहीं। लेन-देन में सीधा। अपने काम में कुशल। पक्ष लेने के लिए पक्ष नहीं लेता। पुरानी टीस जा चुकी। और बार-बार नए सिरे से शुरू करना छूट गया — काम करना नहीं छूटा। वह मुझे प्रिय है।',
    'Kisi cheez ke intezaar mein nahi. Len-den mein seedha. Apne kaam mein kushal. Paksh lene ke liye paksh nahi leta. Purani tees ja chuki. Aur baar-baar naye sire se shuru karna chhoot gaya — kaam karna nahi chhoota. Woh mujhe priya hai.',
    'Six more, and one of them is the most misread compound in the chapter.',
    'छह और, और उनमें एक अध्याय का सबसे ग़लत पढ़ा जाने वाला समास है।',
    'Chhah aur, aur unme ek chapter ka sabse galat padha jaane wala samas hai.',
    'intermediate',
    'Gita 12.16: giving up starting over, not giving up work',
    'The Bhagavad Gita describes someone free of expectation, capable and impartial, who has given up all undertakings — which means the restless starting-over, not the work.',
    1

  UNION ALL SELECT 18, 487, 1, 'gita-12-18',
    'समः शत्रौ च मित्रे च तथा मानापमानयोः।\nशीतोष्णसुखदुःखेषु समः सङ्गविवर्जितः॥',
    'samaḥ śatrau ca mitre ca tathā mānāpamānayoḥ\nśītoṣṇa-sukha-duḥkheṣu samaḥ saṅga-vivarjitaḥ',
    'samah shatrau cha mitre cha tatha manapamanayoh\nshitoshna-sukha-duhkheshu samah sanga-vivarjitah',
    'The same towards enemy and friend, and in honour and dishonour; the same in cold and heat, pleasure and pain; free from attachment.',
    'The same with the person who is against him and the person who is for him. The same when he is praised and when he is insulted. The same in cold and heat, in a good stretch and a bad one. Not stuck to any of it.',
    'जो उसके ख़िलाफ़ है और जो उसके साथ है — दोनों के साथ एक जैसा। तारीफ़ में और अपमान में एक जैसा। सर्दी-गर्मी में, अच्छे दौर और बुरे दौर में एक जैसा। किसी से चिपका हुआ नहीं।',
    'Jo uske khilaf hai aur jo uske saath hai — dono ke saath ek jaisa. tareef mein aur apmaan mein ek jaisa. Sardi-garmi mein, achhe daur aur bure daur mein ek jaisa. Kisi se chipka hua nahi.',
    'The same to friend and enemy is the hard one, and the verse does not soften it.',
    'दोस्त और दुश्मन के साथ एक जैसा — यही कठिन है, और श्लोक इसे नरम नहीं करता।',
    'Dost aur dushman ke saath ek jaisa — yahi mushkil hai, aur shloka ise naram nahi karta.',
    'intermediate',
    'Gita 12.18: the same to friend and enemy',
    'The Bhagavad Gita asks for evenness towards the person against you and the person for you, in praise and insult alike. It does not soften the hard half.',
    1

  UNION ALL SELECT 19, 488, 1, 'gita-12-19',
    'तुल्यनिन्दास्तुतिर्मौनी सन्तुष्टो येन केनचित्।\nअनिकेतः स्थिरमतिर्भक्तिमान्मे प्रियो नरः॥',
    'tulya-nindā-stutir maunī santuṣṭo yena kenacit\naniketaḥ sthira-matir bhaktimān me priyo naraḥ',
    'tulya-ninda-stutir mauni santushto yena kenachit\naniketah sthira-matir bhaktiman me priyo narah',
    'To whom blame and praise are equal, silent, content with whatever comes, without a fixed dwelling, steady in mind, full of devotion — that person is dear to me.',
    'Blame and praise weigh the same to him. He does not need to answer. Content with whatever turns up. Not needing one particular place to be all right. Settled in what he thinks. That person is dear to me.',
    'निंदा और तारीफ़ उसके लिए बराबर वज़न की हैं। उसे जवाब देने की ज़रूरत नहीं पड़ती। जो मिल जाए उसी में संतुष्ट। ठीक रहने के लिए किसी एक जगह की ज़रूरत नहीं। अपनी सोच में जमा हुआ। वह व्यक्ति मुझे प्रिय है।',
    'Ninda aur tareef uske liye barabar wazan ki hain. Use jawab dene ki zaroorat nahi padti. Jo mil jaaye usi mein santusht. Theek rehne ke liye kisi ek jagah ki zaroorat nahi. Apni soch mein jama hua. Woh insaan mujhe priya hai.',
    'The last of the list, and the one that has been misread as homelessness.',
    'सूची की आख़िरी, और वही जिसे बेघरी समझ लिया जाता रहा है।',
    'List ki aakhiri, aur wahi jise begharee samajh liya jaata raha hai.',
    'intermediate',
    'Gita 12.19: content with whatever comes',
    'The Bhagavad Gita closes its portrait: blame and praise weigh the same, content with whatever turns up, not needing one particular place in order to be all right.',
    1

) AS v
JOIN chapters c ON c.chapter_number = 12;

-- =====================================================================
-- EXPLANATIONS
-- =====================================================================
-- The framing sentence — who this chapter is addressed to, and what a
-- reader outside that frame can still take from it — lives in 12.13 and
-- appears exactly once. Repeating it at every verse would turn a piece
-- of honesty into a disclaimer, and readers skip disclaimers.
-- =====================================================================

DELETE ve FROM verse_explanations ve JOIN verses v ON v.id = ve.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 12;

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 5 AS vn, 'beginner' AS level,
   'Arjuna has just asked a comparison question: who is further along, the one who worships you with form, or the one who fixes on the formless absolute? Krishna answers the second half first, and does not give the answer a teacher usually gives.' AS h_en,
   'अर्जुन ने अभी तुलना का सवाल पूछा है: कौन आगे है — वह जो आपको रूप के साथ पूजता है, या वह जो निराकार पर टिकता है? कृष्ण दूसरे हिस्से का जवाब पहले देते हैं, और वह जवाब नहीं देते जो गुरु आमतौर पर देते हैं।' AS h_hi,
   'Arjun ne abhi tulna ka sawaal poocha hai: kaun aage hai — woh jo aapko roop ke saath poojta hai, ya woh jo nirakar par tikta hai? Krishna doosre hisse ka jawab pehle dete hain, aur woh jawab nahi dete jo guru aam taur par dete hain.' AS h_hing,
   'He does not say the abstract path is wrong. He says it is harder, and he gives the reason: people have bodies, and a body wants something to face. Notice what this is not — it is not a claim that abstract thinkers are shallow, and it is not a claim that they will fail. It is an observation about cost.' AS p_en,
   'वे यह नहीं कहते कि निराकार का रास्ता ग़लत है। वे कहते हैं कि वह कठिन है, और वजह भी देते हैं: लोगों के पास शरीर है, और शरीर को सामने कुछ चाहिए। ध्यान दीजिए यह क्या नहीं है — यह दावा नहीं कि निराकार पर सोचने वाले उथले हैं, और यह दावा भी नहीं कि वे असफल होंगे। यह क़ीमत के बारे में एक observation है।' AS p_hi,
   'Woh yeh nahi kehte ki nirakar ka rasta galat hai. Woh kehte hain ki woh mushkil hai, aur wajah bhi dete hain: logon ke paas sharir hai, aur sharir ko saamne kuch chahiye. Dhyan do yeh kya nahi hai — yeh dawa nahi ki nirakar par sochne wale uthle hain, aur yeh dawa bhi nahi ki woh asafal honge. Yeh keemat ke baare mein ek observation hai.' AS p_hing,
   'Any practice that gives you nothing to face is harder to keep than one that does, and this is observable without settling anything about what is true. It is why a running club outlasts a resolution to run, and why people who meditate alone stop more often than people who sit in a room with others. The verse is not flattering anybody. It is describing what bodies are like.' AS m_en,
   'ऐसा कोई भी अभ्यास जिसमें सामने कुछ न हो, उसे टिकाना उससे कठिन है जिसमें कुछ हो — और यह देखा जा सकता है, बिना यह तय किए कि सच क्या है। इसीलिए दौड़ने का क्लब दौड़ने के संकल्प से ज़्यादा चलता है, और अकेले ध्यान करने वाले उन लोगों से ज़्यादा छोड़ते हैं जो किसी कमरे में औरों के साथ बैठते हैं। श्लोक किसी की तारीफ़ नहीं कर रहा। वह बता रहा है कि शरीर कैसे होते हैं।' AS m_hi,
   'Aisa koi bhi abhyas jisme saamne kuch na ho, use tikana usse mushkil hai jisme kuch ho — aur yeh dekha ja sakta hai, bina yeh tay kiye ki sach kya hai. Isiliye daudne ka club daudne ke sankalp se zyada chalta hai, aur akele meditate karne wale un logon se zyada chhodte hain jo kisi kamre mein auron ke saath baithte hain. Shloka kisi ki tareef nahi kar raha. Woh bata raha hai ki sharir kaise hote hain.' AS m_hing

  UNION ALL SELECT 8, 'beginner',
   'This is the chapter''s instruction in its shortest form, given before the long descending ladder that follows it. Krishna says the simple thing first and then, for six verses, keeps offering smaller versions to somebody who cannot manage the simple thing.',
   'यह अध्याय की हिदायत अपने सबसे छोटे रूप में है, उस लंबी उतरती सीढ़ी से पहले जो आगे आती है। कृष्ण पहले सीधी बात कहते हैं और फिर छह श्लोक तक उस व्यक्ति के लिए छोटे-छोटे रूप देते जाते हैं जो सीधी बात नहीं कर पाता।',
   'Yeh chapter ki hidayat apne sabse chhote roop mein hai, us lambi utarti seedhi se pehle jo aage aati hai. Krishna pehle seedhi baat kehte hain aur phir chhah shloka tak us insaan ke liye chhote-chhote roop dete jaate hain jo seedhi baat nahi kar paata.',
   'Two words are doing the work: mind and buddhi. The first is where your attention goes; the second is what you use to decide. The verse asks for both, which is more than it looks like — plenty of people give something their attention while their judgement quietly reports to somewhere else entirely.',
   'दो शब्द काम कर रहे हैं: मन और बुद्धि। पहला वह है जहाँ आपका ध्यान जाता है; दूसरा वह जिससे आप तय करते हैं। श्लोक दोनों माँगता है, जो दिखने से ज़्यादा है — बहुत लोग किसी चीज़ को ध्यान देते हैं जबकि उनकी बुद्धि चुपचाप कहीं और को जवाब देती रहती है।',
   'Do shabd kaam kar rahe hain: man aur buddhi. Pehla woh hai jahan tumhara dhyan jaata hai; doosra woh jisse tum tay karte ho. Shloka dono maangta hai, jo dikhne se zyada hai — bahut log kisi cheez ko dhyan dete hain jabki unki buddhi chupchap kahin aur ko jawab deti rehti hai.',
   'Strip the theology and a testable claim remains: you become what you keep attending to. Everybody has watched this happen to somebody — a person six months into a new job, or a new grievance, or a feed they check forty times a day, who now sounds like the thing they have been looking at. The verse is not describing a reward. It is describing a mechanism, and the only decision it leaves you is what to point it at.',
   'धर्मशास्त्र हटा दीजिए तो एक जाँचने लायक दावा बचता है: आप वही बन जाते हैं जिसे आप लगातार देखते हैं। यह सबने किसी न किसी के साथ होते देखा है — कोई नई नौकरी में छह महीने का, या किसी नई शिकायत में, या ऐसी फ़ीड में जिसे वह दिन में चालीस बार देखता है, और अब वह उसी चीज़ जैसा बोलता है जिसे वह देखता रहा है। श्लोक कोई इनाम नहीं बता रहा। वह एक तंत्र बता रहा है, और आपके लिए बस यह फ़ैसला छोड़ता है कि उसे किस तरफ़ मोड़ना है।',
   'Dharmashastra hata do to ek jaanchne layak claim bachta hai: tum wahi ban jaate ho jise tum lagatar dekhte ho. Yeh sabne kisi na kisi ke saath hote dekha hai — koi nayi naukri mein chhah mahine ka, ya kisi nayi shikayat mein, ya aisi feed mein jise woh din mein chalis baar dekhta hai, aur ab woh usi cheez jaisa bolta hai jise woh dekhta raha hai. Shloka koi inaam nahi bata raha. Woh ek mechanism bata raha hai, aur tumhare liye bas yeh faisla chhodta hai ki use kis taraf modna hai.'

  UNION ALL SELECT 12, 'intermediate',
   'Six verses of descending options end here, in a ranked list. It is worth reading the two together: Krishna has just told somebody who cannot do the first thing to do the second, and somebody who cannot do the second to do the third. Then he ranks them, and the ranking does not go the way the offering did.',
   'उतरते हुए विकल्पों के छह श्लोक यहाँ ख़त्म होते हैं, एक क्रमबद्ध सूची में। दोनों को साथ पढ़ना ठीक रहेगा: कृष्ण अभी उस व्यक्ति से जो पहला काम नहीं कर सकता दूसरा करने को कह चुके हैं, और जो दूसरा नहीं कर सकता उससे तीसरा। फिर वे उन्हें क्रम में रखते हैं, और क्रम उस तरफ़ नहीं जाता जिस तरफ़ पेशकश गई थी।',
   'Utarte hue options ke chhah shloka yahan khatam hote hain, ek kramabaddh list mein. Dono ko saath padhna theek rahega: Krishna abhi us insaan se jo pehla kaam nahi kar sakta doosra karne ko keh chuke hain, aur jo doosra nahi kar sakta usse teesra. Phir woh unhe kram mein rakhte hain, aur kram us taraf nahi jaata jis taraf peshkash gayi thi.',
   'Practice, then understanding, then sustained attention, then letting go of what the work earns — each better than the one before. The last is the instruction from 2.47, arriving here as the top of a ladder rather than as an opening demand. And the peace is said to be immediate, "anantaram", which is a specific claim: not that it accumulates, but that it is what is left the moment the grip opens.',
   'अभ्यास, फिर समझ, फिर टिका हुआ ध्यान, फिर काम से जो मिलना है उसे छोड़ना — हर एक पिछले से बेहतर। आख़िरी वही हिदायत है जो 2.47 में थी, यहाँ शुरुआती माँग की तरह नहीं बल्कि सीढ़ी के सिरे की तरह आती है। और शांति को तुरंत कहा गया है, "अनन्तरम्", जो एक ख़ास दावा है: यह जमा नहीं होती, बल्कि जिस क्षण पकड़ खुलती है उसी क्षण जो बचता है वही है।',
   'Abhyas, phir samajh, phir tika hua dhyan, phir kaam se jo milna hai use chhodna — har ek pichhle se behtar. Aakhiri wahi hidayat hai jo 2.47 mein thi, yahan shuruaati maang ki tarah nahi balki seedhi ke sire ki tarah aati hai. Aur shanti ko turant kaha gaya hai, "anantaram", jo ek khaas claim hai: yeh jama nahi hoti, balki jis pal pakad khulti hai usi pal jo bachta hai wahi hai.',
   'The order is the useful part and it is the opposite of how most people arrange their own effort. Almost everybody tries hardest at the bottom rung — more discipline, more information, more technique — because those are the ones that respond to trying. The thing the verse puts at the top is not something you can try harder at. It is something you stop doing.',
   'क्रम ही काम की बात है और वह ठीक उल्टा है जिस तरह ज़्यादातर लोग अपनी मेहनत जमाते हैं। लगभग सब सबसे नीचे वाली सीढ़ी पर सबसे ज़्यादा ज़ोर लगाते हैं — और अनुशासन, और जानकारी, और तरीक़ा — क्योंकि वही ज़ोर लगाने पर जवाब देती हैं। जिसे श्लोक सबसे ऊपर रखता है उस पर ज़्यादा ज़ोर लगाया ही नहीं जा सकता। वह वह चीज़ है जिसे करना बंद किया जाता है।',
   'Kram hi kaam ki baat hai aur woh theek ulta hai jis tarah zyadatar log apni mehnat jamate hain. Lagbhag sab sabse neeche wali seedhi par sabse zyada zor lagate hain — aur discipline, aur jaankari, aur tareeka — kyunki wahi zor lagane par jawab deti hain. Jise shloka sabse upar rakhta hai us par zyada zor lagaya hi nahi ja sakta. Woh woh cheez hai jise karna band kiya jaata hai.'

  UNION ALL SELECT 13, 'beginner',
   'The famous portrait starts here and runs to the end of the chapter. Every few lines it returns to the same refrain — "sa me priyaḥ", that one is dear to me — which is worth noticing rather than skipping, because it tells you what kind of list this is. It is not a description of a good person in general. It is a description of who is dear to a god, given by that god.',
   'प्रसिद्ध चित्र यहाँ से शुरू होकर अध्याय के अंत तक चलता है। हर कुछ पंक्तियों बाद वही टेक लौटती है — "स मे प्रियः", वह मुझे प्रिय है — जिसे छोड़ने के बजाय ध्यान देना चाहिए, क्योंकि वही बताती है कि यह किस तरह की सूची है। यह आम तौर पर अच्छे इंसान का वर्णन नहीं है। यह इस बात का वर्णन है कि किसी ईश्वर को कौन प्रिय है, और यह उसी ईश्वर के कहे में है।',
   'Prasiddh chitra yahan se shuru hokar chapter ke ant tak chalta hai. Har kuch lines baad wahi tek lautti hai — "sa me priyah", woh mujhe priya hai — jise chhodne ke bajaye dhyan dena chahiye, kyunki wahi batati hai ki yeh kis tarah ki list hai. Yeh aam taur par achhe insaan ka varnan nahi hai. Yeh is baat ka varnan hai ki kisi ishwar ko kaun priya hai, aur yeh usi ishwar ke kahe mein hai.',
   'Six qualities: no ill-will towards anything alive, warmth, being moved by what happens to people, no grip on "mine", no case being made for "I", the same in pain and pleasure, and slow to keep score. Not one of them is a belief, an opinion, or a thing you have to accept. Every one is a way of behaving that somebody around you could confirm or deny by watching for a fortnight.',
   'छह गुण: किसी भी जीव के प्रति कोई द्वेष नहीं, गर्मजोशी, लोगों के साथ जो होता है उससे हिलना, "मेरा" पर पकड़ नहीं, "मैं" के लिए कोई दलील नहीं, दुख और सुख में एक जैसा, और हिसाब रखने में धीमा। इनमें एक भी मान्यता नहीं है, न कोई राय, न कोई ऐसी बात जिसे मानना पड़े। हर एक बरताव का तरीक़ा है, जिसे आपके आस-पास कोई दो हफ़्ते देखकर हाँ या ना कह सकता है।',
   'Chhah gun: kisi bhi jeev ke prati koi dwesh nahi, garmjoshi, logon ke saath jo hota hai usse hilna, "mera" par pakad nahi, "main" ke liye koi dalil nahi, dukh aur sukh mein ek jaisa, aur hisaab rakhne mein dheema. Inme ek bhi maanyata nahi hai, na koi raay, na koi aisi baat jise maanna pade. Har ek bartav ka tareeka hai, jise tumhare aas-paas koi do hafte dekh kar haan ya na keh sakta hai.',
   'So here is the thing this chapter needs said once, plainly. It is addressed to somebody who has or wants a personal relationship with a god, and this product does not pretend otherwise or quietly translate the frame away. It also does not require you to share it. The qualities from here to the end of the chapter are describable and practicable by somebody who holds no religious view at all, and the text nowhere claims they are unavailable to such a person — it simply is not addressing them. Read the list as a portrait, ask which of the six you would fail on this month, and the devotional frame neither helps nor obstructs you.',
   'तो यह अध्याय एक बात एक बार, साफ़-साफ़ कहलवाता है। यह उस व्यक्ति को संबोधित है जिसका किसी ईश्वर से निजी रिश्ता है या जो वह चाहता है, और यह उत्पाद न इससे मुँह मोड़ता है और न चुपचाप उस ढाँचे का अनुवाद करके उसे मिटाता है। यह आपसे वही मानने को भी नहीं कहता। यहाँ से अध्याय के अंत तक गिनाए गुण उस व्यक्ति के लिए भी बताए और किए जा सकते हैं जिसकी कोई धार्मिक मान्यता नहीं है, और ग्रंथ कहीं यह दावा नहीं करता कि वे उसके लिए उपलब्ध नहीं हैं — वह बस उसे संबोधित नहीं कर रहा। सूची को एक चित्र की तरह पढ़िए, पूछिए कि इस महीने आप छह में से किस पर खरे नहीं उतरेंगे, और भक्ति का ढाँचा न आपकी मदद करता है न रुकावट बनता है।',
   'To yeh chapter ek baat ek baar, saaf-saaf kehlwata hai. Yeh us insaan ko sambodhit hai jiska kisi ishwar se niji rishta hai ya jo woh chahta hai, aur yeh product na isse muh modta hai aur na chupchap us dhaanche ka anuvaad kar ke use mitata hai. Yeh tumse wahi maanne ko bhi nahi kehta. Yahan se chapter ke ant tak ginaye gun us insaan ke liye bhi bataye aur kiye ja sakte hain jiski koi dharmik maanyata nahi hai, aur granth kahin yeh dawa nahi karta ki woh uske liye uplabdh nahi hain — woh bas use sambodhit nahi kar raha. List ko ek chitra ki tarah padho, poocho ki is mahine tum chhah mein se kis par khare nahi utroge, aur bhakti ka dhaancha na tumhari madad karta hai na rukavat banta hai.'

  UNION ALL SELECT 15, 'beginner',
   'The portrait has been running for two verses and this is where it turns outward. Everything before it described an inner state. This one describes what it is like to be in a room with the person, which is a different and harder test.',
   'चित्र दो श्लोकों से चल रहा है और यहाँ वह बाहर की तरफ़ मुड़ता है। इससे पहले सब कुछ भीतर की अवस्था बताता था। यह बताता है कि उस व्यक्ति के साथ एक कमरे में होना कैसा है, जो अलग और ज़्यादा कठिन कसौटी है।',
   'Chitra do shlokon se chal raha hai aur yahan woh bahar ki taraf mudta hai. Isse pehle sab kuch bheetar ki avastha batata tha. Yeh batata hai ki us insaan ke saath ek kamre mein hona kaisa hai, jo alag aur zyada mushkil kasauti hai.',
   'Two directions, and both have to hold. The world is not agitated by him — nobody adjusts their face when he arrives, nobody checks the room before speaking. And he is not agitated by the world. Then four specific things he is free of: elation, resentment, fear, and the low continuous bracing that is none of those three and drains more than all of them.',
   'दो दिशाएँ, और दोनों टिकनी चाहिए। दुनिया उससे विचलित नहीं होती — उसके आने पर कोई अपना चेहरा नहीं बदलता, कोई बोलने से पहले कमरा नहीं देखता। और वह दुनिया से विचलित नहीं होता। फिर चार ख़ास चीज़ें जिनसे वह मुक्त है: उछाल, मलाल, डर, और वह धीमा लगातार तनाव जो इन तीनों में से कोई नहीं है और इन सबसे ज़्यादा निचोड़ता है।',
   'Do dishayein, aur dono tikni chahiye. Duniya usse vichalit nahi hoti — uske aane par koi apna chehra nahi badalta, koi bolne se pehle kamra nahi dekhta. Aur woh duniya se vichalit nahi hota. Phir chaar khaas cheezein jinse woh mukt hai: ubhaar, malaal, dar, aur woh dheema lagatar tanav jo in teenon mein se koi nahi hai aur in sabse zyada nichodta hai.',
   'The first half is the one people skip, and it is the one other people can actually answer for you. Ask anybody who has worked under somebody whose mood set the temperature of a room: they can tell you the exact sound of that person''s footsteps. A great deal of composure is available at the cost of everybody nearby, and this verse quietly refuses to count that as composure.',
   'पहला आधा वही है जिसे लोग छोड़ देते हैं, और वही है जिसका जवाब दूसरे लोग सचमुच दे सकते हैं। किसी से पूछिए जिसने ऐसे व्यक्ति के नीचे काम किया है जिसका मिज़ाज कमरे का तापमान तय करता था: वह आपको उसके क़दमों की ठीक-ठीक आवाज़ बता देगा। बहुत सारा संयम आस-पास वालों की क़ीमत पर मिल जाता है, और यह श्लोक चुपचाप उसे संयम मानने से इनकार कर देता है।',
   'Pehla aadha wahi hai jise log chhod dete hain, aur wahi hai jiska jawab doosre log sach mein de sakte hain. Kisi se poocho jisne aise insaan ke neeche kaam kiya hai jiska mizaaj kamre ka taapman tay karta tha: woh tumhe uske kadmon ki theek-theek aawaz bata dega. Bahut saara sanyam aas-paas walon ki keemat par mil jaata hai, aur yeh shloka chupchap use sanyam maanne se inkaar kar deta hai.'

  UNION ALL SELECT 16, 'intermediate',
   'Six more qualities, and the last compound in the list is the one that has caused the most trouble in translation. "Sarvārambha-parityāgī" comes out in English as "one who has given up all undertakings", which sounds like an instruction to stop working — in a book that spent chapter 3 arguing the opposite.',
   'छह और गुण, और सूची का आख़िरी समास वही है जिसने अनुवाद में सबसे ज़्यादा गड़बड़ की है। "सर्वारम्भपरित्यागी" अंग्रेज़ी में "जिसने सब उद्यम छोड़ दिए" बनता है, जो काम बंद करने की हिदायत जैसा लगता है — उस किताब में जिसने तीसरा अध्याय इसके उलट कहने में लगाया।',
   'Chhah aur gun, aur list ka aakhiri samas wahi hai jisne anuvaad mein sabse zyada gadbad ki hai. "Sarvarambha-parityagi" English mein "jisne sab udyam chhod diye" banta hai, jo kaam band karne ki hidayat jaisa lagta hai — us kitaab mein jisne teesra chapter iske ulat kehne mein lagaya.',
   'Ārambha is a beginning, a launching, a taking-up — not the work itself. What is being given up is the compulsive starting: the new plan on Monday, the fresh notebook, the enthusiasm that is really an escape from the boring middle of the last thing. Read that way it agrees with chapter 3 exactly, and it names a failure mode that most productive-looking people recognise immediately.',
   'आरम्भ यानी शुरुआत, छेड़ना, उठाना — काम ख़ुद नहीं। जो छोड़ा जा रहा है वह है बार-बार शुरू करने की लत: सोमवार को नई योजना, नई कॉपी, वह जोश जो असल में पिछली चीज़ के उबाऊ बीच से भागना है। ऐसे पढ़िए तो यह तीसरे अध्याय से ठीक-ठीक मिल जाता है, और यह उस ख़राबी का नाम रखता है जिसे काम में लगे दिखने वाले ज़्यादातर लोग तुरंत पहचान लेते हैं।',
   'Aarambh yaani shuruaat, chhedna, uthana — kaam khud nahi. Jo chhoda ja raha hai woh hai baar-baar shuru karne ki lat: Monday ko nayi yojna, nayi copy, woh josh jo asal mein pichhli cheez ke ubaau beech se bhaagna hai. Aise padho to yeh teesre chapter se theek-theek mil jaata hai, aur yeh us kharabi ka naam rakhta hai jise kaam mein lage dikhne wale zyadatar log turant pehchan lete hain.',
   'The other quality worth slowing down for is "udāsīna", impartial, which is not indifference. It is the state of not having a side in a dispute you are not part of — and the internet is largely built out of the opposite. Somebody who is udāsīna about a quarrel between two people they do not know is not being cold. They are declining a job nobody gave them.',
   'दूसरा गुण जिस पर धीमा होना चाहिए वह है "उदासीन", यानी तटस्थ, जो उदासीनता या बेरुख़ी नहीं है। यह उस झगड़े में पक्ष न होने की अवस्था है जिसमें आप शामिल ही नहीं हैं — और इंटरनेट काफ़ी हद तक इसके उलट से बना है। जो दो अनजान लोगों के झगड़े को लेकर उदासीन है, वह ठंडा नहीं है। वह ऐसा काम लेने से मना कर रहा है जो उसे किसी ने दिया ही नहीं।',
   'Doosra gun jis par dheema hona chahiye woh hai "udasin", yaani tatasth, jo berukhi nahi hai. Yeh us jhagde mein paksh na hone ki avastha hai jisme tum shamil hi nahi ho — aur internet kaafi had tak iske ulat se bana hai. Jo do anjaan logon ke jhagde ko lekar udasin hai, woh thanda nahi hai. Woh aisa kaam lene se mana kar raha hai jo use kisi ne diya hi nahi.'

  UNION ALL SELECT 18, 'intermediate',
   'The list reaches its hardest line. Everything before it could be read as a description of somebody with a calm temperament. This one cannot, because it names an enemy and asks for the same conduct towards him as towards a friend.',
   'सूची अपनी सबसे कठिन पंक्ति पर पहुँचती है। इससे पहले सब कुछ शांत स्वभाव वाले व्यक्ति का वर्णन पढ़ा जा सकता था। यह नहीं पढ़ा जा सकता, क्योंकि यह शत्रु का नाम लेता है और उसके साथ वही बरताव माँगता है जो मित्र के साथ।',
   'List apni sabse mushkil line par pahunchti hai. Isse pehle sab kuch shaant swabhav wale insaan ka varnan padha ja sakta tha. Yeh nahi padha ja sakta, kyunki yeh shatru ka naam leta hai aur uske saath wahi bartav maangta hai jo mitra ke saath.',
   'It is worth being exact about what "sama" asks for, because the loose reading is both wrong and unpleasant. It is not liking them equally, and it is not pretending there is no difference. It is that your conduct does not change shape depending on which of the two is in front of you — the same honesty, the same courtesy, the same refusal to take a cheap opportunity. What you feel is not what is being legislated.',
   '"सम" क्या माँगता है, इस पर सटीक होना ज़रूरी है, क्योंकि ढीला पाठ ग़लत भी है और अप्रिय भी। यह दोनों को बराबर पसंद करना नहीं है, और यह दिखावा भी नहीं कि कोई फ़र्क़ ही नहीं। यह यह है कि सामने दोनों में से कौन है, इससे आपके बरताव का आकार नहीं बदलता — वही ईमानदारी, वही शिष्टता, सस्ता मौक़ा न उठाने की वही आदत। जो आप महसूस करते हैं उस पर क़ानून नहीं बनाया जा रहा।',
   '"Sama" kya maangta hai, is par sateek hona zaroori hai, kyunki dheela padhna galat bhi hai aur apriya bhi. Yeh dono ko barabar pasand karna nahi hai, aur yeh dikhava bhi nahi ki koi farq hi nahi. Yeh yeh hai ki saamne dono mein se kaun hai, isse tumhare bartav ka aakar nahi badalta — wahi imaandari, wahi shishtata, sasta mauka na uthane ki wahi aadat. Jo tum mehsoos karte ho us par kanoon nahi banaya ja raha.',
   'The test almost everybody fails is not about grand enemies. It is about the colleague who once made you look bad in front of somebody. Watch what happens to your standards of fairness when their work comes to you for review. The verse is not asking you to like them. It is asking whether your judgement is a judgement or a settling of accounts wearing one.',
   'जिस कसौटी पर लगभग सब गिरते हैं वह किसी बड़े दुश्मन की नहीं है। वह उस सहकर्मी की है जिसने कभी किसी के सामने आपको नीचा दिखाया था। देखिए कि जब उसका काम आपके पास समीक्षा के लिए आता है तब आपके निष्पक्षता के मानक का क्या होता है। श्लोक आपसे उसे पसंद करने को नहीं कह रहा। वह पूछ रहा है कि आपका फ़ैसला फ़ैसला है, या हिसाब बराबर करना जो फ़ैसले का चोला पहने है।',
   'Jis kasauti par lagbhag sab girte hain woh kisi bade dushman ki nahi hai. Woh us colleague ki hai jisne kabhi kisi ke saamne tumhe neecha dikhaya tha. Dekho ki jab uska kaam tumhare paas review ke liye aata hai tab tumhare nishpakshta ke standard ka kya hota hai. Shloka tumse use pasand karne ko nahi keh raha. Woh pooch raha hai ki tumhara faisla faisla hai, ya hisaab barabar karna jo faisle ka chola pehne hai.'

  UNION ALL SELECT 19, 'intermediate',
   'The portrait closes. "Aniketaḥ" — without a fixed dwelling — is the word that has carried the most weight historically, and it has been read both as a literal instruction to wander and as something considerably less dramatic.',
   'चित्र यहाँ पूरा होता है। "अनिकेतः" — बिना तय ठिकाने वाला — वही शब्द है जिसने इतिहास में सबसे ज़्यादा बोझ उठाया है, और इसे घूमते रहने की सीधी हिदायत की तरह भी पढ़ा गया है और उससे काफ़ी कम नाटकीय किसी बात की तरह भी।',
   'Chitra yahan poora hota hai. "Aniketah" — bina tay thikane wala — wahi shabd hai jisne itihaas mein sabse zyada bojh uthaya hai, aur ise ghoomte rehne ki seedhi hidayat ki tarah bhi padha gaya hai aur usse kaafi kam natakiya kisi baat ki tarah bhi.',
   'The less dramatic reading is the one that fits the rest of the list, all of which is about what a person is like rather than where they sleep. Not needing one particular arrangement in order to be all right. The room, the routine, the chair, the city, the exact configuration of things without which the day cannot start — that is a niketa, and most people have several.',
   'कम नाटकीय पाठ वही है जो बाक़ी सूची से मेल खाता है, जो पूरी की पूरी इस बारे में है कि आदमी कैसा है, न कि वह कहाँ सोता है। ठीक रहने के लिए किसी एक ख़ास इंतज़ाम की ज़रूरत न होना। वह कमरा, वह दिनचर्या, वह कुर्सी, वह शहर, चीज़ों की वह ठीक-ठीक जमावट जिसके बिना दिन शुरू ही नहीं होता — वही निकेत है, और ज़्यादातर लोगों के पास कई हैं।',
   'Kam natakiya padhna wahi hai jo baaki list se mel khata hai, jo poori ki poori is baare mein hai ki aadmi kaisa hai, na ki woh kahan sota hai. Theek rehne ke liye kisi ek khaas intezaam ki zaroorat na hona. Woh kamra, woh dinacharya, woh kursi, woh shehar, cheezon ki woh theek-theek jamavat jiske bina din shuru hi nahi hota — wahi niketa hai, aur zyadatar logon ke paas kai hain.',
   'The one to test yourself against is "maunī" — silent — sitting next to "blame and praise weigh the same". Together they describe somebody who does not need to answer. Not somebody with nothing to say; somebody for whom being described wrongly is not an emergency. Almost nobody manages this, and the tell is how fast the reply gets written, not whether it was justified.',
   'ख़ुद को जिस पर परखना चाहिए वह है "मौनी" — चुप — जो "निंदा और तारीफ़ बराबर" के ठीक बगल में बैठा है। दोनों मिलकर उस व्यक्ति को बताते हैं जिसे जवाब देने की ज़रूरत नहीं पड़ती। ऐसा नहीं कि उसके पास कहने को कुछ नहीं; ऐसा कि ग़लत बताया जाना उसके लिए आपात स्थिति नहीं है। यह लगभग कोई नहीं कर पाता, और निशानी यह है कि जवाब कितनी जल्दी लिखा गया, यह नहीं कि वह जायज़ था या नहीं।',
   'Khud ko jis par parakhna chahiye woh hai "mauni" — chup — jo "ninda aur tareef barabar" ke theek bagal mein baitha hai. Dono milkar us insaan ko batate hain jise jawab dene ki zaroorat nahi padti. Aisa nahi ki uske paas kehne ko kuch nahi; aisa ki galat bataya jaana uske liye emergency nahi hai. Yeh lagbhag koi nahi kar paata, aur nishani yeh hai ki jawab kitni jaldi likha gaya, yeh nahi ki woh jaayaz tha ya nahi.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 12;

-- =====================================================================
-- 3. HOOKS, REFLECTIONS, PRACTICES, TOPICS
-- =====================================================================

DELETE m FROM verse_memory_aids m JOIN verses v ON v.id = m.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 12;
DELETE r FROM verse_reflections r JOIN verses v ON v.id = r.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 12;
DELETE p FROM verse_practices p JOIN verses v ON v.id = p.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 12;
DELETE vt FROM verse_topics vt JOIN verses v ON v.id = vt.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 12;

INSERT INTO verse_memory_aids (verse_id, hook_en, hook_hi, hook_hinglish, analogy_en, analogy_hi, analogy_hinglish, visual_cue)
SELECT v.id, m.h_en, m.h_hi, m.h_hing, m.a_en, m.a_hi, m.a_hing, m.cue FROM (
  SELECT 5 AS vn,
  'A practice with nothing to face is harder to keep. That is about bodies, not about depth.' AS h_en,
  'जिस अभ्यास में सामने कुछ न हो, उसे टिकाना कठिन है। यह शरीर की बात है, गहराई की नहीं।' AS h_hi,
  'Jis abhyas mein saamne kuch na ho, use tikana mushkil hai. Yeh sharir ki baat hai, gehrai ki nahi.' AS h_hing,
  'Like running alone versus running with a club. Same distance, different survival rate.' AS a_en,
  'अकेले दौड़ने और क्लब के साथ दौड़ने जैसा। दूरी वही, टिकने की दर अलग।' AS a_hi,
  'Akele daudne aur club ke saath daudne jaisa. Doori wahi, tikne ki rate alag.' AS a_hing,
  'One runner on an empty road, a group on the same road' AS cue

  UNION ALL SELECT 8,
  'You become what you keep looking at. That is the whole instruction.',
  'आप वही बन जाते हैं जिसे आप देखते रहते हैं। पूरी हिदायत यही है।',
  'Tum wahi ban jaate ho jise tum dekhte rehte ho. Poori hidayat yahi hai.',
  'Like an accent. Nobody chose it; everybody caught it from what they were listening to.',
  'लहजे जैसा। किसी ने चुना नहीं; सबने वहीं से पकड़ा जो वे सुन रहे थे।',
  'Lehje jaisa. Kisi ne chuna nahi; sabne wahin se pakda jo woh sun rahe the.',
  'An eye, and the thing it is fixed on, sharing a shape'

  UNION ALL SELECT 12,
  'Trying harder works on the bottom rungs. The top one is something you stop doing.',
  'ज़्यादा ज़ोर नीचे की सीढ़ियों पर चलता है। सबसे ऊपर वाली वह है जिसे करना बंद किया जाता है।',
  'Zyada zor neeche ki seedhiyon par chalta hai. Sabse upar wali woh hai jise karna band kiya jaata hai.',
  'Like unclenching a fist. There is no technique for it and no way to do it harder.',
  'मुट्ठी खोलने जैसा। इसका कोई तरीक़ा नहीं है और इसे ज़्यादा ज़ोर से किया भी नहीं जा सकता।',
  'Mutthi kholne jaisa. Iska koi tareeka nahi hai aur ise zyada zor se kiya bhi nahi ja sakta.',
  'A ladder whose top rung is an open hand'

  UNION ALL SELECT 13,
  'Six qualities, and not one of them is a belief.',
  'छह गुण, और उनमें एक भी मान्यता नहीं है।',
  'Chhah gun, aur unme ek bhi maanyata nahi hai.',
  'Like a reference from a colleague rather than a CV. It only mentions things somebody watched you do.',
  'सीवी नहीं, सहकर्मी की सिफ़ारिश जैसा। उसमें वही आता है जो किसी ने आपको करते देखा।',
  'CV nahi, colleague ki sifarish jaisa. Usme wahi aata hai jo kisi ne tumhe karte dekha.',
  'A short list in somebody else''s handwriting'

  UNION ALL SELECT 15,
  'Being calm alone is the easy half. The verse asks about the room.',
  'अकेले शांत रहना आसान आधा है। श्लोक कमरे के बारे में पूछता है।',
  'Akele shaant rehna asaan aadha hai. Shloka kamre ke baare mein poochta hai.',
  'Like a thermostat you cannot see. Everybody in the room is dressed for it anyway.',
  'ऐसे थर्मोस्टैट जैसा जो दिखता नहीं। फिर भी कमरे में सब उसी के हिसाब से कपड़े पहने हैं।',
  'Aise thermostat jaisa jo dikhta nahi. Phir bhi kamre mein sab usi ke hisaab se kapde pehne hain.',
  'A room where everyone is angled the same way'

  UNION ALL SELECT 16,
  'Giving up starting over. Not giving up the work.',
  'बार-बार नए सिरे से शुरू करना छोड़ना। काम छोड़ना नहीं।',
  'Baar-baar naye sire se shuru karna chhodna. Kaam chhodna nahi.',
  'Like a shelf of notebooks with four pages used each. The enthusiasm was never the problem.',
  'उस शेल्फ़ जैसा जिसमें कॉपियाँ हैं और हर एक में चार पन्ने भरे हैं। जोश कभी समस्या था ही नहीं।',
  'Us shelf jaisa jisme copies hain aur har ek mein chaar panne bhare hain. Josh kabhi problem tha hi nahi.',
  'A row of notebooks, each open at page four'

  UNION ALL SELECT 18,
  'Not liking them equally. Behaving the same way whichever one is in front of you.',
  'दोनों को बराबर पसंद करना नहीं। सामने जो भी हो, बरताव वही रहना।',
  'Dono ko barabar pasand karna nahi. Saamne jo bhi ho, bartav wahi rehna.',
  'Like a set of scales that does not know whose hand put the weight on.',
  'ऐसे तराज़ू जैसा जिसे पता ही नहीं कि बाट किसके हाथ ने रखा।',
  'Aise taraazu jaisa jise pata hi nahi ki baat kiske haath ne rakha.',
  'A balance, both pans hidden from the reader'

  UNION ALL SELECT 19,
  'Not needing to answer is different from having nothing to say.',
  'जवाब देने की ज़रूरत न पड़ना और कहने को कुछ न होना — दो अलग बातें हैं।',
  'Jawab dene ki zaroorat na padna aur kehne ko kuch na hona — do alag baatein hain.',
  'Like a door that is unlocked. It is not being defended, and it turns out not to need defending.',
  'खुले दरवाज़े जैसा। उसकी रक्षा नहीं की जा रही, और पता चलता है कि ज़रूरत भी नहीं थी।',
  'Khule darwaze jaisa. Uski raksha nahi ki ja rahi, aur pata chalta hai ki zaroorat bhi nahi thi.',
  'An unlocked door, no bolt fitted'
) AS m
JOIN verses v ON v.verse_number = m.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 12;

INSERT INTO verse_reflections (verse_id, question_en, question_hi, question_hinglish, display_order)
SELECT v.id, r.q_en, r.q_hi, r.q_hing, r.ord FROM (
  SELECT 5 AS vn, 'Which of your practices survived, and what did they give you to face?' AS q_en, 'आपके कौन-से अभ्यास टिके, और उनमें सामने क्या था?' AS q_hi, 'Tumhare kaun se abhyas tike, aur unme saamne kya tha?' AS q_hing, 1 AS ord
  UNION ALL SELECT 5, 'Have you ever mistaken "harder" for "better"? What did it cost you?', 'क्या आपने कभी "कठिन" को "बेहतर" समझ लिया है? उसकी क्या क़ीमत लगी?', 'Kya tumne kabhi "mushkil" ko "behtar" samajh liya hai? Uski kya keemat lagi?', 2
  UNION ALL SELECT 5, 'What would it take for you to accept an easier route to the same place?', 'उसी जगह पहुँचने का आसान रास्ता मानने के लिए आपको क्या चाहिए?', 'Usi jagah pahunchne ka asaan rasta maanne ke liye tumhe kya chahiye?', 3
  UNION ALL SELECT 8, 'What have you given the most attention to in the last six months? Do you sound like it now?', 'पिछले छह महीनों में आपने सबसे ज़्यादा ध्यान किसे दिया? क्या अब आप वैसे ही बोलते हैं?', 'Pichhle chhah mahinon mein tumne sabse zyada dhyan kise diya? Kya ab tum waise hi bolte ho?', 1
  UNION ALL SELECT 8, 'Where does your attention go and your judgement quietly disagree?', 'ऐसी कौन-सी जगह है जहाँ आपका ध्यान जाता है और आपकी बुद्धि चुपचाप असहमत रहती है?', 'Aisi kaun si jagah hai jahan tumhara dhyan jaata hai aur tumhari buddhi chupchap asahmat rehti hai?', 2
  UNION ALL SELECT 8, 'If somebody watched only what you look at, what would they say you are becoming?', 'अगर कोई सिर्फ़ यह देखे कि आप क्या देखते हैं, तो वह कहेगा कि आप क्या बन रहे हैं?', 'Agar koi sirf yeh dekhe ki tum kya dekhte ho, to woh kahega ki tum kya ban rahe ho?', 3
  UNION ALL SELECT 12, 'Which rung do you spend your effort on, and which one would actually change things?', 'आप अपनी मेहनत किस सीढ़ी पर लगाते हैं, और असल में कौन-सी चीज़ें बदलती?', 'Tum apni mehnat kis seedhi par lagate ho, aur asal mein kaun si cheezein badalti?', 1
  UNION ALL SELECT 12, 'What are you trying harder at that cannot be solved by trying harder?', 'ऐसा क्या है जिस पर आप ज़्यादा ज़ोर लगा रहे हैं जो ज़ोर लगाने से हल ही नहीं होता?', 'Aisa kya hai jis par tum zyada zor laga rahe ho jo zor lagane se hal hi nahi hota?', 2
  UNION ALL SELECT 12, 'The verse says peace is immediate, not accumulated. Does that match anything you have felt?', 'श्लोक कहता है शांति तुरंत मिलती है, जमा नहीं होती। क्या यह आपके किसी अनुभव से मिलता है?', 'Shloka kehta hai shanti turant milti hai, jama nahi hoti. Kya yeh tumhare kisi anubhav se milta hai?', 3
  UNION ALL SELECT 13, 'Of the six, which would somebody who works with you say you fail on?', 'इन छह में से किस पर आपके साथ काम करने वाला कहेगा कि आप खरे नहीं उतरते?', 'In chhah mein se kis par tumhare saath kaam karne wala kahega ki tum khare nahi utarte?', 1
  UNION ALL SELECT 13, 'Who are you currently holding something against, and how long has it been?', 'अभी आप किसके ख़िलाफ़ कुछ मन में रखे हैं, और कब से?', 'Abhi tum kiske khilaf kuch man mein rakhe ho, aur kab se?', 2
  UNION ALL SELECT 13, 'Where does your grip on "mine" show up most — things, people, or credit?', '"मेरा" की आपकी पकड़ सबसे ज़्यादा कहाँ दिखती है — चीज़ों पर, लोगों पर, या श्रेय पर?', '"Mera" ki tumhari pakad sabse zyada kahan dikhti hai — cheezon par, logon par, ya credit par?', 3
  UNION ALL SELECT 15, 'Does anybody adjust themselves when you walk in? How would you find out?', 'क्या आपके आने पर कोई ख़ुद को संभालता है? आपको यह पता कैसे चलेगा?', 'Kya tumhare aane par koi khud ko sambhalta hai? Tumhe yeh pata kaise chalega?', 1
  UNION ALL SELECT 15, 'Whose mood set the temperature of a room you were in? What did it teach you?', 'आप जिस कमरे में थे उसका तापमान किसके मिज़ाज से तय होता था? उससे आपने क्या सीखा?', 'Tum jis kamre mein the uska taapman kiske mizaaj se tay hota tha? Usse tumne kya seekha?', 2
  UNION ALL SELECT 15, 'Which of the four — elation, resentment, fear, bracing — runs you most often?', 'चार में से कौन-सी आपको सबसे ज़्यादा चलाती है — उछाल, मलाल, डर, या तनाव?', 'Chaar mein se kaun si tumhe sabse zyada chalati hai — ubhaar, malaal, dar, ya tanav?', 3
  UNION ALL SELECT 16, 'How many things have you begun this year, and how many have you finished?', 'इस साल आपने कितनी चीज़ें शुरू कीं, और कितनी पूरी कीं?', 'Is saal tumne kitni cheezein shuru kin, aur kitni poori kin?', 1
  UNION ALL SELECT 16, 'What are you about to start that is really an escape from the middle of something else?', 'आप क्या शुरू करने वाले हैं जो असल में किसी और चीज़ के बीच से भागना है?', 'Tum kya shuru karne wale ho jo asal mein kisi aur cheez ke beech se bhaagna hai?', 2
  UNION ALL SELECT 16, 'Whose quarrel have you taken a side in this week that was never yours?', 'इस हफ़्ते आपने किसके झगड़े में पक्ष लिया जो कभी आपका था ही नहीं?', 'Is hafte tumne kiske jhagde mein paksh liya jo kabhi tumhara tha hi nahi?', 3
  UNION ALL SELECT 18, 'Whose work would you review differently because of something they did to you?', 'किसके काम की समीक्षा आप इसलिए अलग तरह से करेंगे क्योंकि उसने आपके साथ कुछ किया था?', 'Kiske kaam ka review tum isliye alag tarah se karoge kyunki usne tumhare saath kuch kiya tha?', 1
  UNION ALL SELECT 18, 'When you were last praised and last insulted, how long did each stay with you?', 'पिछली बार तारीफ़ और पिछली बार अपमान — दोनों आपके साथ कितनी देर रहे?', 'Pichhli baar tareef aur pichhli baar apmaan — dono tumhare saath kitni der rahe?', 2
  UNION ALL SELECT 18, 'Is there somebody you are fair to only because being unfair would be noticed?', 'क्या कोई ऐसा है जिसके साथ आप सिर्फ़ इसलिए न्याय करते हैं क्योंकि अन्याय पकड़ा जाता?', 'Kya koi aisa hai jiske saath tum sirf isliye nyay karte ho kyunki anyay pakda jaata?', 3
  UNION ALL SELECT 19, 'When were you last described wrongly and did not reply? What did that cost?', 'पिछली बार कब आपको ग़लत बताया गया और आपने जवाब नहीं दिया? उसकी क्या क़ीमत लगी?', 'Pichhli baar kab tumhe galat bataya gaya aur tumne jawab nahi diya? Uski kya keemat lagi?', 1
  UNION ALL SELECT 19, 'What arrangement do you need in place before your day can start?', 'आपका दिन शुरू होने से पहले कौन-सा इंतज़ाम होना ज़रूरी है?', 'Tumhara din shuru hone se pehle kaun sa intezaam hona zaroori hai?', 2
  UNION ALL SELECT 19, 'If that arrangement vanished for a month, what would you find out about yourself?', 'अगर वह इंतज़ाम एक महीने के लिए ग़ायब हो जाए, तो आपको अपने बारे में क्या पता चलेगा?', 'Agar woh intezaam ek mahine ke liye gayab ho jaaye, to tumhe apne baare mein kya pata chalega?', 3
) AS r
JOIN verses v ON v.verse_number = r.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 12;

INSERT INTO verse_practices (verse_id, action_en, action_hi, action_hinglish, estimated_minutes, difficulty, display_order)
SELECT v.id, p.a_en, p.a_hi, p.a_hing, p.mins, p.diff, 1 FROM (
  SELECT 5 AS vn, 'Take one habit you keep failing to hold. Give it something to face — a person, a time, a place — and try it for a week.' AS a_en, 'ऐसी एक आदत लीजिए जो टिकती नहीं। उसे सामने कुछ दीजिए — कोई व्यक्ति, कोई समय, कोई जगह — और एक हफ़्ता चलाइए।' AS a_hi, 'Aisi ek aadat lo jo tikti nahi. Use saamne kuch do — koi insaan, koi time, koi jagah — aur ek hafta chalao.' AS a_hing, 5 AS mins, 'beginner' AS diff
  UNION ALL SELECT 8, 'Write down the three things you gave the most attention to this week. Not the most important — the most attention.', 'इस हफ़्ते जिन तीन चीज़ों को आपने सबसे ज़्यादा ध्यान दिया, उन्हें लिखिए। सबसे ज़रूरी नहीं — सबसे ज़्यादा ध्यान।', 'Is hafte jin teen cheezon ko tumne sabse zyada dhyan diya, unhe likho. Sabse zaroori nahi — sabse zyada dhyan.', 6, 'beginner'
  UNION ALL SELECT 12, 'Name one thing you have been trying harder at for months. Ask what it would mean to stop gripping it instead.', 'एक चीज़ बताइए जिस पर आप महीनों से ज़्यादा ज़ोर लगा रहे हैं। पूछिए कि उसे पकड़ना छोड़ देने का क्या मतलब होगा।', 'Ek cheez batao jis par tum mahinon se zyada zor laga rahe ho. Poocho ki use pakadna chhod dene ka kya matlab hoga.', 8, 'intermediate'
  UNION ALL SELECT 13, 'Read the six qualities out loud. Mark the one you would fail on this month, and leave it marked.', 'छह गुण ज़ोर से पढ़िए। जिस पर इस महीने आप खरे नहीं उतरेंगे उसे निशान लगाइए, और निशान लगा रहने दीजिए।', 'Chhah gun zor se padho. Jis par is mahine tum khare nahi utroge use nishan lagao, aur nishan laga rehne do.', 5, 'beginner'
  UNION ALL SELECT 15, 'Ask one person who has to deal with you regularly whether your mood changes the room. Do not defend the answer.', 'किसी एक व्यक्ति से पूछिए जिसे आपसे नियमित रूप से निपटना पड़ता है कि क्या आपका मिज़ाज कमरा बदल देता है। जवाब का बचाव मत कीजिए।', 'Kisi ek insaan se poocho jise tumse regular nipatna padta hai ki kya tumhara mizaaj kamra badal deta hai. Jawab ka bachav mat karo.', 10, 'advanced'
  UNION ALL SELECT 16, 'List everything you started this year. Finish the smallest unfinished one today instead of starting anything.', 'इस साल शुरू की गई हर चीज़ लिखिए। आज कुछ नया शुरू करने के बजाय सबसे छोटी अधूरी चीज़ पूरी कीजिए।', 'Is saal shuru ki gayi har cheez likho. Aaj kuch naya shuru karne ke bajaye sabse chhoti adhoori cheez poori karo.', 20, 'intermediate'
  UNION ALL SELECT 18, 'Think of somebody you hold something against. Next time their work reaches you, apply the standard you would apply to a friend''s.', 'किसी ऐसे व्यक्ति को सोचिए जिसके ख़िलाफ़ आप कुछ रखे हैं। अगली बार उसका काम आपके पास आए, तो वही मानक लगाइए जो दोस्त के काम पर लगाते।', 'Kisi aise insaan ko socho jiske khilaf tum kuch rakhe ho. Agli baar uska kaam tumhare paas aaye, to wahi standard lagao jo dost ke kaam par lagate.', 10, 'intermediate'
  UNION ALL SELECT 19, 'The next time you want to correct somebody''s version of you, wait a day. Then decide whether it still needs doing.', 'अगली बार जब आपके बारे में किसी की बात सुधारने का मन हो, एक दिन रुकिए। फिर तय कीजिए कि अब भी करना ज़रूरी है या नहीं।', 'Agli baar jab tumhare baare mein kisi ki baat sudharne ka man ho, ek din ruko. Phir tay karo ki ab bhi karna zaroori hai ya nahi.', 3, 'intermediate'
) AS p
JOIN verses v ON v.verse_number = p.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 12;

INSERT INTO verse_topics (verse_id, topic_id, relevance)
SELECT v.id, t.id, x.rel FROM (
  SELECT 5 AS vn, 'steadiness' AS slug, 8 AS rel
  UNION ALL SELECT 5, 'hard-decisions', 6
  UNION ALL SELECT 5, 'comparison', 6
  UNION ALL SELECT 8, 'restlessness', 9
  UNION ALL SELECT 8, 'steadiness', 8
  UNION ALL SELECT 8, 'desire', 7
  UNION ALL SELECT 8, 'the-self', 6
  UNION ALL SELECT 12, 'effort-without-result', 10
  UNION ALL SELECT 12, 'action-without-attachment', 9
  UNION ALL SELECT 12, 'burnout', 8
  UNION ALL SELECT 12, 'steadiness', 7
  UNION ALL SELECT 13, 'anger', 8
  UNION ALL SELECT 13, 'steadiness', 8
  UNION ALL SELECT 13, 'the-self', 7
  UNION ALL SELECT 13, 'grief', 6
  UNION ALL SELECT 15, 'steadiness', 10
  UNION ALL SELECT 15, 'anger', 8
  UNION ALL SELECT 15, 'fear', 7
  UNION ALL SELECT 15, 'restlessness', 7
  UNION ALL SELECT 16, 'restlessness', 10
  UNION ALL SELECT 16, 'burnout', 9
  UNION ALL SELECT 16, 'action-without-attachment', 7
  UNION ALL SELECT 16, 'duty', 6
  UNION ALL SELECT 18, 'steadiness', 9
  UNION ALL SELECT 18, 'anger', 8
  UNION ALL SELECT 18, 'comparison', 8
  UNION ALL SELECT 18, 'hard-decisions', 6
  UNION ALL SELECT 19, 'comparison', 9
  UNION ALL SELECT 19, 'steadiness', 9
  UNION ALL SELECT 19, 'desire', 7
  UNION ALL SELECT 19, 'impermanence', 6
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 12
JOIN topics t ON t.slug = x.slug;

-- =====================================================================
-- 4. MODERN EXAMPLES
-- =====================================================================
-- Three per verse. Nothing here presumes the reader believes anything.
-- The devotional frame is named in the 12.13 explanation and does not
-- need re-litigating in twenty-four scenarios; these describe conduct,
-- which is what the second half of the chapter describes too.
-- =====================================================================

DELETE e FROM modern_examples e JOIN verses v ON v.id = e.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 12;

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

  SELECT 5 AS vn, 'healthcare' AS cat, 1 AS ord,
  'The exercises that needed a Tuesday' AS t_en, 'वे व्यायाम जिन्हें एक मंगलवार चाहिए था' AS t_hi, 'Woh exercise jinhe ek Tuesday chahiye tha' AS t_hing,
  'Two people are given the same rehabilitation programme. One is told to do it at home whenever suits. The other is booked into a room at four o''clock on Tuesdays with six other people and a physiotherapist who notices absences. At three months the second person has done roughly four times as many sessions. Neither was more committed at the start; they were asked in different ways.' AS s_en,
  'दो लोगों को एक ही पुनर्वास कार्यक्रम मिलता है। एक से कहा जाता है कि घर पर जब सुविधा हो कर लीजिए। दूसरे का मंगलवार चार बजे एक कमरे में समय तय है, छह और लोगों और एक फ़िज़ियोथेरेपिस्ट के साथ जो ग़ैरहाज़िरी पकड़ती है। तीन महीने में दूसरे ने लगभग चार गुना सत्र किए हैं। शुरू में कोई ज़्यादा प्रतिबद्ध नहीं था; दोनों से अलग तरीक़े से कहा गया था।' AS s_hi,
  'Do logon ko ek hi rehabilitation programme milta hai. Ek se kaha jaata hai ki ghar par jab suvidha ho kar lo. Doosre ka Tuesday chaar baje ek kamre mein time tay hai, chhah aur logon aur ek physiotherapist ke saath jo gairhaziri pakadti hai. Teen mahine mein doosre ne lagbhag chaar guna session kiye hain. Shuru mein koi zyada pratibaddh nahi tha; dono se alag tareeke se kaha gaya tha.' AS s_hing,
  'The verse says a goal with nothing to hold is reached painfully by people who have bodies, and this is that claim with a number attached. Neither programme was better designed as medicine. One of them gave a body something to turn up to, and bodies turn up to things.' AS c_en,
  'श्लोक कहता है कि जिस लक्ष्य में पकड़ने को कुछ नहीं, वहाँ शरीर वाले लोग तकलीफ़ से पहुँचते हैं — और यह वही दावा है, आँकड़े के साथ। दवा के तौर पर कोई कार्यक्रम बेहतर नहीं बना था। उनमें से एक ने शरीर को कहीं पहुँचने को दिया, और शरीर कहीं पहुँचते हैं।' AS c_hi,
  'Shloka kehta hai ki jis lakshya mein pakadne ko kuch nahi, wahan sharir wale log takleef se pahunchte hain — aur yeh wahi claim hai, aankde ke saath. Dawa ke taur par koi programme behtar nahi bana tha. Unme se ek ne sharir ko kahin pahunchne ko diya, aur sharir kahin pahunchte hain.' AS c_hing,
  'The abstract version is not the serious version. It is just the one with nothing to turn up to.' AS l_en,
  'निराकार वाला रूप ज़्यादा गंभीर नहीं होता। बस उसमें पहुँचने को कुछ नहीं होता।' AS l_hi,
  'Nirakar wala roop zyada gambhir nahi hota. Bas usme pahunchne ko kuch nahi hota.' AS l_hing,
  NULL AS src, 'beginner' AS diff, 'health,habits,recovery,structure,discipline' AS tags

  UNION ALL SELECT 5, 'everyday_life', 2,
  'Reading more, in principle', 'सिद्धांत रूप में ज़्यादा पढ़ना', 'Siddhant roop mein zyada padhna',
  'Somebody resolves to read more and does not, for two years, in the ordinary way that resolutions do not happen. Then a friend starts a book club that meets on the first Sunday of the month in a specific café. In the following year they read eleven books, most of which they would not have chosen, and several of which they liked.',
  'कोई ज़्यादा पढ़ने का संकल्प करता है और नहीं पढ़ता, दो साल तक, उसी साधारण तरीक़े से जिससे संकल्प पूरे नहीं होते। फिर एक दोस्त बुक क्लब शुरू करता है जो हर महीने के पहले रविवार को एक ख़ास कैफ़े में मिलता है। अगले साल में वे ग्यारह किताबें पढ़ते हैं, जिनमें से ज़्यादातर वे ख़ुद न चुनते, और कई उन्हें पसंद आती हैं।',
  'Koi zyada padhne ka sankalp karta hai aur nahi padhta, do saal tak, usi sadharan tareeke se jisse sankalp poore nahi hote. Phir ek dost book club shuru karta hai jo har mahine ke pehle Sunday ko ek khaas cafe mein milta hai. Agle saal mein woh gyarah kitabein padhte hain, jinme se zyadatar woh khud na chunte, aur kai unhe pasand aati hain.',
  'A resolution is a formless goal. A café, a Sunday and six people who will ask is a goal with something to face. The verse makes no claim about which is nobler and neither does this example — only that the second one has a far better survival rate, for reasons that are about bodies rather than character.',
  'संकल्प एक निराकार लक्ष्य है। एक कैफ़े, एक रविवार और छह लोग जो पूछेंगे — यह ऐसा लक्ष्य है जिसमें सामने कुछ है। श्लोक यह दावा नहीं करता कि कौन-सा ज़्यादा नेक है और यह उदाहरण भी नहीं — बस इतना कि दूसरे के टिकने की दर कहीं बेहतर है, और वजह चरित्र नहीं, शरीर है।',
  'Sankalp ek nirakar lakshya hai. Ek cafe, ek Sunday aur chhah log jo poochenge — yeh aisa lakshya hai jisme saamne kuch hai. Shloka yeh claim nahi karta ki kaun sa zyada nek hai aur yeh example bhi nahi — bas itna ki doosre ke tikne ki rate kahin behtar hai, aur wajah charitra nahi, sharir hai.',
  'A resolution has nothing to face. That is not a character flaw in you; it is a design flaw in the resolution.',
  'संकल्प में सामने कुछ नहीं होता। यह आपके चरित्र की ख़ामी नहीं है; यह संकल्प के ढाँचे की ख़ामी है।',
  'Sankalp mein saamne kuch nahi hota. Yeh tumhare charitra ki khami nahi hai; yeh sankalp ke dhaanche ki khami hai.',
  NULL, 'beginner', 'habits,reading,structure,community,intention'

  UNION ALL SELECT 5, 'college', 3,
  'The subject nobody could picture', 'वह विषय जिसकी कोई तस्वीर नहीं बनती थी', 'Woh vishay jiski koi tasveer nahi banti thi',
  'A first-year course covers two topics in the same term. One is taught through worked cases with names and dates; the other is taught as pure structure, correctly and clearly, with no example in it at all. The examination results are not the interesting part. The interesting part is that four years later, graduates can still describe the first one and know only that they once passed the second.',
  'पहले साल का एक पाठ्यक्रम उसी सत्र में दो विषय पढ़ाता है। एक नाम और तारीख़ों वाले उदाहरणों से पढ़ाया जाता है; दूसरा शुद्ध ढाँचे की तरह, सही और साफ़, बिना किसी उदाहरण के। परीक्षा के नतीजे दिलचस्प हिस्सा नहीं हैं। दिलचस्प यह है कि चार साल बाद स्नातक पहले को अब भी बता सकते हैं और दूसरे के बारे में सिर्फ़ इतना जानते हैं कि कभी पास किया था।',
  'Pehle saal ka ek course usi term mein do vishay padhata hai. Ek naam aur tareekhon wale examples se padhaya jaata hai; doosra shuddh dhaanche ki tarah, sahi aur saaf, bina kisi example ke. Exam ke results dilchasp hissa nahi hain. Dilchasp yeh hai ki chaar saal baad graduates pehle ko ab bhi bata sakte hain aur doosre ke baare mein sirf itna jaante hain ki kabhi pass kiya tha.',
  'The abstract teaching was not worse teaching. It asked the mind to hold something with no handles on it, over a long period, which is exactly the difficulty the verse describes. Note that the verse does not say the formless is unreachable — only that it costs more, and that the cost is paid in a currency people run out of.',
  'निराकार पढ़ाई ख़राब पढ़ाई नहीं थी। उसने मन से ऐसी चीज़ थामने को कहा जिस पर पकड़ने को कुछ नहीं था, लंबे समय तक — ठीक वही कठिनाई जो श्लोक बताता है। ध्यान दीजिए, श्लोक यह नहीं कहता कि निराकार तक पहुँचा नहीं जा सकता — सिर्फ़ यह कि क़ीमत ज़्यादा है, और वह क़ीमत ऐसी मुद्रा में चुकानी पड़ती है जो लोगों के पास ख़त्म हो जाती है।',
  'Nirakar padhai kharab padhai nahi thi. Usne man se aisi cheez thaamne ko kaha jis par pakadne ko kuch nahi tha, lambe samay tak — theek wahi mushkil jo shloka batata hai. Dhyan do, shloka yeh nahi kehta ki nirakar tak pahuncha nahi ja sakta — sirf yeh ki keemat zyada hai, aur woh keemat aisi currency mein chukani padti hai jo logon ke paas khatam ho jaati hai.',
  'The formless is not unreachable. It is expensive, and people run out before they arrive.',
  'निराकार तक पहुँचा नहीं जा सकता, ऐसा नहीं। वह महँगा है, और लोग पहुँचने से पहले चुक जाते हैं।',
  'Nirakar tak pahuncha nahi ja sakta, aisa nahi. Woh mehnga hai, aur log pahunchne se pehle chuk jaate hain.',
  NULL, 'intermediate', 'study,learning,abstraction,memory,teaching'

  UNION ALL SELECT 8, 'social_media', 1,
  'Six months of one argument', 'एक ही बहस के छह महीने', 'Ek hi behes ke chhah mahine',
  'Somebody follows a running dispute closely for half a year — not participating, just reading. Their friends notice, before they do, that their sentences have changed shape: shorter, more braced, arranged for an opponent who is not in the room. Told this, they are surprised, and their first response is a rebuttal.',
  'कोई आधे साल तक एक चल रही बहस को ध्यान से देखता है — भाग नहीं लेता, बस पढ़ता है। उसके दोस्त उससे पहले नोटिस करते हैं कि उसके वाक्यों का आकार बदल गया है: छोटे, ज़्यादा तने हुए, ऐसे किसी विरोधी के लिए सजे जो कमरे में है ही नहीं। यह बताए जाने पर वह हैरान होता है, और उसकी पहली प्रतिक्रिया एक जवाब होती है।',
  'Koi aadhe saal tak ek chal rahi behes ko dhyan se dekhta hai — bhaag nahi leta, bas padhta hai. Uske dost usse pehle notice karte hain ki uske vakyon ka aakar badal gaya hai: chhote, zyada tane hue, aise kisi virodhi ke liye saje jo kamre mein hai hi nahi. Yeh bataye jaane par woh hairan hota hai, aur uski pehli pratikriya ek jawab hoti hai.',
  'The verse says put your attention here and you will live here. Read as a description rather than an instruction it is unnervingly accurate, and it does not require the attention to be devotional or even deliberate. Half a year of watching an argument installs the argument.',
  'श्लोक कहता है कि ध्यान यहाँ रखिए और आप यहीं रहने लगेंगे। हिदायत की जगह वर्णन की तरह पढ़िए तो यह डरा देने वाला सटीक है, और इसके लिए ध्यान का भक्तिपूर्ण या सोचा-समझा होना भी ज़रूरी नहीं। आधे साल किसी बहस को देखना उस बहस को भीतर बिठा देता है।',
  'Shloka kehta hai ki dhyan yahan rakho aur tum yahin rehne lagoge. Hidayat ki jagah varnan ki tarah padho to yeh dara dene wala sateek hai, aur iske liye dhyan ka bhaktipurn ya socha-samjha hona bhi zaroori nahi. Aadhe saal kisi behes ko dekhna us behes ko bheetar bitha deta hai.',
  'You do not have to participate to be shaped by it. Watching is enough, and watching is what most of us do.',
  'ढलने के लिए भाग लेना ज़रूरी नहीं। देखना काफ़ी है, और हममें से ज़्यादातर यही करते हैं।',
  'Dhalne ke liye bhaag lena zaroori nahi. Dekhna kaafi hai, aur humme se zyadatar yahi karte hain.',
  NULL, 'beginner', 'attention,internet,argument,identity,habits'

  UNION ALL SELECT 8, 'corporate', 2,
  'The place the judgement actually reported to', 'वह जगह जिसे बुद्धि असल में जवाब देती थी', 'Woh jagah jise buddhi asal mein jawab deti thi',
  'A manager gives a project her full attention for a quarter — hours, care, real thought. When a decision comes up that would help the project and slightly embarrass her, she takes the other option, quickly, and gives a reason that is not untrue. The attention was all there. The judgement had been reporting somewhere else the whole time.',
  'एक मैनेजर एक तिमाही तक किसी प्रोजेक्ट को अपना पूरा ध्यान देती है — घंटे, परवाह, सचमुच की सोच। जब ऐसा फ़ैसला आता है जो प्रोजेक्ट के लिए अच्छा है और उसके लिए थोड़ा असहज, तो वह दूसरा विकल्प चुनती है, जल्दी से, और ऐसी वजह देती है जो झूठ नहीं है। ध्यान पूरा वहीं था। बुद्धि पूरे समय कहीं और को जवाब दे रही थी।',
  'Ek manager ek quarter tak kisi project ko apna poora dhyan deti hai — ghante, parwah, sach mein ki soch. Jab aisa faisla aata hai jo project ke liye achha hai aur uske liye thoda asahaj, to woh doosra option chunti hai, jaldi se, aur aisi wajah deti hai jo jhooth nahi hai. Dhyan poora wahin tha. Buddhi poore samay kahin aur ko jawab de rahi thi.',
  'This is why the verse asks for two things and not one. Attention is the easy half and it is visible; buddhi, the deciding part, is the half nobody can audit from outside. A person can give something years of attention while every hard call quietly goes to protecting themselves.',
  'इसीलिए श्लोक दो चीज़ें माँगता है, एक नहीं। ध्यान आसान आधा है और वह दिखता है; बुद्धि, यानी तय करने वाला हिस्सा, वह आधा है जिसकी जाँच बाहर से कोई नहीं कर सकता। आदमी किसी चीज़ को सालों ध्यान दे सकता है जबकि हर मुश्किल फ़ैसला चुपचाप ख़ुद को बचाने की तरफ़ जाता रहे।',
  'Isiliye shloka do cheezein maangta hai, ek nahi. Dhyan asaan aadha hai aur woh dikhta hai; buddhi, yaani tay karne wala hissa, woh aadha hai jiski jaanch bahar se koi nahi kar sakta. Aadmi kisi cheez ko saalon dhyan de sakta hai jabki har mushkil faisla chupchap khud ko bachane ki taraf jaata rahe.',
  'Attention is visible and judgement is not. The verse asks for both because only one of them can be faked.',
  'ध्यान दिखता है, बुद्धि नहीं। श्लोक दोनों माँगता है क्योंकि इनमें से एक का ही दिखावा हो सकता है।',
  'Dhyan dikhta hai, buddhi nahi. Shloka dono maangta hai kyunki inme se ek ka hi dikhava ho sakta hai.',
  NULL, 'advanced', 'work,integrity,attention,decisions,self-interest'

  UNION ALL SELECT 8, 'parenting', 3,
  'What the house was actually about', 'घर असल में किस बारे में था', 'Ghar asal mein kis baare mein tha',
  'A family says, accurately, that what matters to them is kindness. A visitor spending a week there notices that the conversations at the table are almost entirely about results — marks, positions, who did well. Nobody is lying about the value. The attention simply went somewhere else, daily, for years.',
  'एक परिवार सही कहता है कि उनके लिए दयालुता मायने रखती है। एक हफ़्ता वहाँ बिताने वाला मेहमान देखता है कि मेज़ पर बातचीत लगभग पूरी तरह नतीजों के बारे में है — अंक, स्थान, किसने अच्छा किया। मूल्य के बारे में कोई झूठ नहीं बोल रहा। ध्यान बस कहीं और गया, रोज़, सालों तक।',
  'Ek parivar sahi kehta hai ki unke liye dayalta maayne rakhti hai. Ek hafta wahan bitane wala mehmaan dekhta hai ki mez par baat lagbhag poori tarah results ke baare mein hai — ank, sthan, kisne achha kiya. Value ke baare mein koi jhooth nahi bol raha. Dhyan bas kahin aur gaya, roz, saalon tak.',
  'The verse locates the mechanism precisely: not what you value, not what you say, but where the attention goes. A household''s actual curriculum is whatever gets talked about at dinner, and it teaches for about six thousand evenings whether anybody intended it or not.',
  'श्लोक तंत्र की जगह ठीक-ठीक बताता है: आप क्या मानते हैं यह नहीं, आप क्या कहते हैं यह नहीं, बल्कि ध्यान कहाँ जाता है। घर का असली पाठ्यक्रम वही है जिसकी बात खाने की मेज़ पर होती है, और वह लगभग छह हज़ार शामों तक पढ़ाता है, चाहे किसी ने चाहा हो या नहीं।',
  'Shloka mechanism ki jagah theek-theek batata hai: tum kya maante ho yeh nahi, tum kya kehte ho yeh nahi, balki dhyan kahan jaata hai. Ghar ka asli syllabus wahi hai jiski baat khaane ki mez par hoti hai, aur woh lagbhag chhah hazaar shaamon tak padhata hai, chahe kisi ne chaha ho ya nahi.',
  'A household teaches whatever it talks about, not whatever it believes.',
  'घर वही सिखाता है जिसकी बात करता है, वह नहीं जिसे मानता है।',
  'Ghar wahi sikhata hai jiski baat karta hai, woh nahi jise maanta hai.',
  NULL, 'intermediate', 'family,values,attention,children,dinner'

  UNION ALL SELECT 12, 'startup', 1,
  'Everything except the one thing', 'एक चीज़ को छोड़कर सब कुछ', 'Ek cheez ko chhodkar sab kuch',
  'A founder responds to a bad quarter by working more hours, hiring a coach, reading four books on the problem and rebuilding the process twice. All of it is real effort and some of it helps. What she cannot do, and describes to a friend as the only thing she cannot do, is stop refreshing the dashboard.',
  'एक संस्थापक बुरी तिमाही का जवाब ज़्यादा घंटे काम करके, कोच रखकर, समस्या पर चार किताबें पढ़कर और प्रक्रिया दो बार दोबारा बनाकर देती है। यह सब असली मेहनत है और कुछ काम भी आती है। जो वह नहीं कर पाती, और दोस्त को बताती है कि यही एक चीज़ है जो वह नहीं कर पाती, वह है डैशबोर्ड बार-बार खोलना बंद करना।',
  'Ek founder buri quarter ka jawab zyada ghante kaam karke, coach rakhkar, samasya par chaar kitabein padhkar aur process do baar dobara banakar deti hai. Yeh sab asli mehnat hai aur kuch kaam bhi aati hai. Jo woh nahi kar paati, aur dost ko batati hai ki yahi ek cheez hai jo woh nahi kar paati, woh hai dashboard baar-baar kholna band karna.',
  'The verse ranks four things and puts letting go of the fruit above practice, knowledge and sustained attention. She has done the bottom three thoroughly, because those respond to effort. The top one does not, which is exactly why it is the one still undone after a quarter of hard work.',
  'श्लोक चार चीज़ों को क्रम में रखता है और फल छोड़ने को अभ्यास, ज्ञान और टिके ध्यान से ऊपर रखता है। उसने नीचे की तीनों ठीक से कीं, क्योंकि वे मेहनत पर जवाब देती हैं। सबसे ऊपर वाली नहीं देती, और इसीलिए तिमाही भर की कड़ी मेहनत के बाद भी वही अधूरी है।',
  'Shloka chaar cheezon ko kram mein rakhta hai aur phal chhodne ko abhyas, gyan aur tike dhyan se upar rakhta hai. Usne neeche ki teenon theek se kin, kyunki woh mehnat par jawab deti hain. Sabse upar wali nahi deti, aur isiliye quarter bhar ki kadi mehnat ke baad bhi wahi adhoori hai.',
  'The rungs that respond to effort are the ones you will do. That is not the same as the ones that would help.',
  'जो सीढ़ियाँ मेहनत पर जवाब देती हैं, वही आप करेंगे। वे वही नहीं हैं जो काम आतीं।',
  'Jo seedhiyan mehnat par jawab deti hain, wahi tum karoge. Woh wahi nahi hain jo kaam aatin.',
  NULL, 'intermediate', 'work,effort,letting-go,anxiety,business'

  UNION ALL SELECT 12, 'sports', 2,
  'The tenth of a second that came back', 'वह दसवाँ हिस्सा जो लौट आया', 'Woh daswan hissa jo laut aaya',
  'A swimmer plateaus for eighteen months. Technique work, more volume, video analysis, a sports psychologist — all of it applied properly, none of it moving the time. In a meet that does not matter, entered casually because a friend was going, she swims a personal best. Her coach''s note afterwards is three words about what she was not doing.',
  'एक तैराक अठारह महीने एक ही जगह अटकी रहती है। तकनीक का काम, ज़्यादा अभ्यास, वीडियो विश्लेषण, खेल मनोवैज्ञानिक — सब ठीक से लगाया गया, किसी से समय नहीं हिला। एक ऐसी प्रतियोगिता में, जिसका कोई महत्व नहीं और जिसमें वह बस इसलिए उतरी कि एक दोस्त जा रही थी, वह अपना सर्वश्रेष्ठ समय निकालती है। कोच का बाद का नोट तीन शब्दों का है, इस बारे में कि वह क्या नहीं कर रही थी।',
  'Ek tairak atharah mahine ek hi jagah atki rehti hai. Technique ka kaam, zyada abhyas, video analysis, sports psychologist — sab theek se lagaya gaya, kisi se time nahi hila. Ek aisi competition mein, jiska koi mahatva nahi aur jisme woh bas isliye utri ki ek dost ja rahi thi, woh apna best time nikalti hai. Coach ka baad ka note teen shabdon ka hai, is baare mein ki woh kya nahi kar rahi thi.',
  'The verse claims the top rung is not more effort but the release of the grip on what the effort earns. Sport is where this is easiest to observe and hardest to arrange deliberately, because deciding to stop caring about the time is itself a way of caring about the time.',
  'श्लोक कहता है कि सबसे ऊपर वाली सीढ़ी और मेहनत नहीं, बल्कि मेहनत से जो मिलना है उस पर पकड़ का ढीला पड़ना है। खेल वह जगह है जहाँ यह देखना सबसे आसान है और जानबूझकर करना सबसे मुश्किल, क्योंकि समय की परवाह छोड़ने का फ़ैसला ख़ुद समय की परवाह करने का ही एक तरीक़ा है।',
  'Shloka kehta hai ki sabse upar wali seedhi aur mehnat nahi, balki mehnat se jo milna hai us par pakad ka dheela padna hai. Khel woh jagah hai jahan yeh dekhna sabse asaan hai aur jaanboojhkar karna sabse mushkil, kyunki time ki parwah chhodne ka faisla khud time ki parwah karne ka hi ek tareeka hai.',
  'Deciding to stop caring about the result is another way of caring about the result. That is the whole difficulty.',
  'नतीजे की परवाह छोड़ने का फ़ैसला भी नतीजे की परवाह करने का ही तरीक़ा है। पूरी मुश्किल यही है।',
  'Result ki parwah chhodne ka faisla bhi result ki parwah karne ka hi tareeka hai. Poori mushkil yahi hai.',
  NULL, 'advanced', 'sport,performance,letting-go,pressure,plateau'

  UNION ALL SELECT 12, 'finance', 3,
  'The month of not looking', 'न देखने का महीना', 'Na dekhne ka mahina',
  'An investor who checks the portfolio several times a day is persuaded to stop for a month — no changes to what is held, only to how often it is looked at. Nothing improves in the account. Something improves in the person, immediately and noticeably, and they describe it as getting a room back that they had not known was occupied.',
  'एक निवेशक जो दिन में कई बार पोर्टफ़ोलियो देखता है, उसे एक महीने के लिए रुकने को मनाया जाता है — जो रखा है उसमें कोई बदलाव नहीं, सिर्फ़ इसमें कि कितनी बार देखा जाए। खाते में कुछ बेहतर नहीं होता। उस व्यक्ति में कुछ बेहतर होता है, तुरंत और साफ़ दिखने लायक, और वह इसे यूँ बताता है जैसे कोई कमरा वापस मिल गया हो जिसके बारे में पता ही नहीं था कि वह भरा हुआ था।',
  'Ek investor jo din mein kai baar portfolio dekhta hai, use ek mahine ke liye rukne ko manaya jaata hai — jo rakha hai usme koi badlav nahi, sirf isme ki kitni baar dekha jaaye. Khaate mein kuch behtar nahi hota. Us insaan mein kuch behtar hota hai, turant aur saaf dikhne layak, aur woh ise yun batata hai jaise koi kamra wapas mil gaya ho jiske baare mein pata hi nahi tha ki woh bhara hua tha.',
  'The verse says peace follows immediately — anantaram — and this is what immediate looks like when it is tested. The portfolio was never the thing being carried. The checking was, and it stopped costing the moment it stopped.',
  'श्लोक कहता है कि शांति तुरंत आती है — अनन्तरम् — और जाँचने पर तुरंत का यही रूप दिखता है। पोर्टफ़ोलियो कभी वह चीज़ थी ही नहीं जो ढोई जा रही थी। ढोया जा रहा था बार-बार देखना, और वह जिस क्षण रुका उसी क्षण उसकी क़ीमत भी रुक गई।',
  'Shloka kehta hai ki shanti turant aati hai — anantaram — aur jaanchne par turant ka yahi roop dikhta hai. Portfolio kabhi woh cheez thi hi nahi jo dhoyi ja rahi thi. Dhoya ja raha tha baar-baar dekhna, aur woh jis pal ruka usi pal uski keemat bhi ruk gayi.',
  'The holding was never the weight. The checking was, and it stops costing the moment it stops.',
  'रखना कभी बोझ था ही नहीं। बोझ था बार-बार देखना, और वह जिस क्षण रुकता है उसी क्षण क़ीमत भी रुक जाती है।',
  'Rakhna kabhi bojh tha hi nahi. Bojh tha baar-baar dekhna, aur woh jis pal rukta hai usi pal keemat bhi ruk jaati hai.',
  NULL, 'beginner', 'money,anxiety,checking,letting-go,peace'

  UNION ALL SELECT 13, 'corporate', 1,
  'The reference that nobody could write', 'वह सिफ़ारिश जो कोई लिख नहीं सका', 'Woh sifarish jo koi likh nahi saka',
  'A capable person leaves a company after six years. Asked for references, three former colleagues each write something warm about the work and nothing at all about the person, and each notices this while writing and cannot fix it. Everything they can recall is an outcome. Nothing they can recall is a moment.',
  'एक सक्षम व्यक्ति छह साल बाद कंपनी छोड़ता है। सिफ़ारिश माँगे जाने पर तीन पूर्व सहकर्मी काम के बारे में गर्मजोश कुछ लिखते हैं और व्यक्ति के बारे में कुछ भी नहीं, और तीनों लिखते हुए यह महसूस करते हैं और ठीक नहीं कर पाते। जो कुछ उन्हें याद है वह नतीजे हैं। जो याद नहीं है वह कोई एक पल है।',
  'Ek saksham insaan chhah saal baad company chhodta hai. Sifarish maange jaane par teen poorv colleague kaam ke baare mein garmjosh kuch likhte hain aur insaan ke baare mein kuch bhi nahi, aur teenon likhte hue yeh mehsoos karte hain aur theek nahi kar paate. Jo kuch unhe yaad hai woh results hain. Jo yaad nahi hai woh koi ek pal hai.',
  'Every one of the six qualities in this verse is a thing somebody else could witness. That is what makes the list unusual — it cannot be self-assessed honestly, and this scenario is what the assessment looks like when it comes back. Nobody said anything bad. Nobody had anything to say.',
  'इस श्लोक के छहों गुण ऐसे हैं जिन्हें कोई और देख सकता है। यही इस सूची को असामान्य बनाता है — इसका ईमानदार आत्म-मूल्यांकन हो ही नहीं सकता, और यह दृश्य वही है जो मूल्यांकन लौटकर आने पर दिखता है। किसी ने कुछ बुरा नहीं कहा। किसी के पास कहने को कुछ था ही नहीं।',
  'Is shloka ke chhahon gun aise hain jinhe koi aur dekh sakta hai. Yahi is list ko asamanya banata hai — iska imaandar self-assessment ho hi nahi sakta, aur yeh drishya wahi hai jo assessment lautkar aane par dikhta hai. Kisi ne kuch bura nahi kaha. Kisi ke paas kehne ko kuch tha hi nahi.',
  'None of the six can be self-assessed. Somebody who watched you for a fortnight is the only instrument.',
  'इन छह में से किसी को आप ख़ुद नहीं नाप सकते। जिसने आपको दो हफ़्ते देखा है, वही इकलौता उपकरण है।',
  'In chhah mein se kisi ko tum khud nahi naap sakte. Jisne tumhe do hafte dekha hai, wahi iklauta upkaran hai.',
  NULL, 'intermediate', 'work,character,reputation,witness,colleagues'

  UNION ALL SELECT 13, 'relationships', 2,
  'The ledger nobody admitted to keeping', 'वह बही जिसे रखने की बात कोई नहीं मानता था', 'Woh bahi jise rakhne ki baat koi nahi maanta tha',
  'Two people who have been together eleven years discover, in an ordinary argument about something small, that both have been keeping count. Neither would have said so. The evidence is that each can produce, instantly and in order, four things from years ago with dates attached.',
  'ग्यारह साल से साथ रहे दो लोग किसी छोटी बात की साधारण बहस में पाते हैं कि दोनों हिसाब रख रहे थे। दोनों में से कोई यह कहता नहीं। सबूत यह है कि हर एक तुरंत और क्रम से सालों पुरानी चार बातें तारीख़ों के साथ गिना देता है।',
  'Gyarah saal se saath rahe do log kisi chhoti baat ki sadharan behes mein paate hain ki dono hisaab rakh rahe the. Dono mein se koi yeh kehta nahi. Saboot yeh hai ki har ek turant aur kram se saalon purani chaar baatein tareekhon ke saath gina deta hai.',
  'The verse ends its list with "kṣamī" — forgiving, and closer to slow to keep score than to grandly pardoning. That reading is the useful one here, because neither of these two would describe themselves as unforgiving, and both have an archive with an index.',
  'श्लोक अपनी सूची "क्षमी" पर ख़त्म करता है — क्षमाशील, और अर्थ भव्य माफ़ी से ज़्यादा "हिसाब रखने में धीमा" के पास है। यहाँ यही पाठ काम का है, क्योंकि इन दोनों में से कोई ख़ुद को अक्षमाशील नहीं बताएगा, और दोनों के पास अनुक्रमणिका सहित संग्रह है।',
  'Shloka apni list "kshami" par khatam karta hai — kshamashil, aur arth bhavya maafi se zyada "hisaab rakhne mein dheema" ke paas hai. Yahan yahi padhna kaam ka hai, kyunki in dono mein se koi khud ko akshamashil nahi bataega, aur dono ke paas index sahit sangrah hai.',
  'Forgiveness is not mainly an event. It is whether the archive is being maintained.',
  'क्षमा मुख्य रूप से कोई घटना नहीं है। सवाल यह है कि संग्रह संभाला जा रहा है या नहीं।',
  'Kshama mukhya roop se koi ghatna nahi hai. Sawaal yeh hai ki sangrah sambhala ja raha hai ya nahi.',
  NULL, 'intermediate', 'relationships,forgiveness,memory,scorekeeping,marriage'

  UNION ALL SELECT 13, 'everyday_life', 3,
  'The neighbour who was owed nothing', 'वह पड़ोसी जिस पर कुछ बकाया नहीं था', 'Woh padosi jis par kuch bakaya nahi tha',
  'An older woman in a building takes in parcels, waters plants during holidays, and once sat with somebody''s child for four hours during an emergency. She is not close to any of these households. Asked why, she gives an answer that is not about virtue and not about religion — she says she cannot see a thing that needs doing and walk past it.',
  'इमारत में एक बुज़ुर्ग महिला पार्सल रख लेती हैं, छुट्टियों में पौधों को पानी देती हैं, और एक बार किसी आपात स्थिति में किसी के बच्चे के साथ चार घंटे बैठी रहीं। इनमें से किसी घर से उनकी नज़दीकी नहीं है। पूछने पर वे ऐसा जवाब देती हैं जो न सद्गुण के बारे में है न धर्म के — वे कहती हैं कि उन्हें कोई काम पड़ा दिखे तो वे उसे छोड़कर आगे नहीं जा पातीं।',
  'Imaarat mein ek buzurg mahila parcel rakh leti hain, chhuttiyon mein paudhon ko paani deti hain, aur ek baar kisi emergency mein kisi ke bachche ke saath chaar ghante baithi rahin. Inme se kisi ghar se unki nazdeeki nahi hai. Poochne par woh aisa jawab deti hain jo na sadgun ke baare mein hai na dharm ke — woh kehti hain ki unhe koi kaam pada dikhe to woh use chhodkar aage nahi ja paatin.',
  'Two of the six are visible here without any of the vocabulary: maitraḥ, friendly, and karuṇa, moved by what happens to people. What makes it worth including is her answer. She is not performing a quality; she is describing what she notices, and the quality is downstream of the noticing.',
  'छह में से दो यहाँ बिना किसी शब्दावली के दिख रहे हैं: मैत्रः, यानी मित्रवत, और करुण, यानी लोगों के साथ जो होता है उससे हिलने वाला। इसे रखने लायक उनका जवाब बनाता है। वे कोई गुण निभा नहीं रहीं; वे बता रही हैं कि उन्हें क्या दिखता है, और गुण उस दिखने के बाद आता है।',
  'Chhah mein se do yahan bina kisi shabdavali ke dikh rahe hain: maitrah, yaani mitravat, aur karuna, yaani logon ke saath jo hota hai usse hilne wala. Ise rakhne layak unka jawab banata hai. Woh koi gun nibha nahi rahin; woh bata rahi hain ki unhe kya dikhta hai, aur gun us dikhne ke baad aata hai.',
  'The quality is downstream of the noticing. Nobody arrives at kindness by deciding to have some.',
  'गुण देखने के बाद आता है। दयालु होने का फ़ैसला करके कोई दयालु नहीं बनता।',
  'Gun dekhne ke baad aata hai. Dayalu hone ka faisla karke koi dayalu nahi banta.',
  NULL, 'beginner', 'neighbours,kindness,attention,community,ordinary'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 12;

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

  SELECT 15 AS vn, 'leadership' AS cat, 1 AS ord,
  'The footsteps everybody could identify' AS t_en, 'वे क़दम जिन्हें सब पहचानते थे' AS t_hi, 'Woh kadam jinhe sab pehchante the' AS t_hing,
  'A department head is regarded as unflappable. He does not raise his voice and does not panic in a crisis. He also has a particular walk when something has annoyed him, and everybody on the floor can identify it from about twelve metres. Conversations rearrange themselves before he reaches the door. Nobody has ever mentioned this to him and he would be astonished.' AS s_en,
  'एक विभाग प्रमुख को अडिग माना जाता है। वे आवाज़ ऊँची नहीं करते और संकट में घबराते नहीं। और उनकी एक ख़ास चाल भी है जब कुछ खटक जाए, और फ़्लोर पर हर कोई उसे बारह मीटर दूर से पहचान लेता है। वे दरवाज़े तक पहुँचें उससे पहले बातचीत अपनी जगह बदल लेती है। यह किसी ने उनसे कभी नहीं कहा और वे हैरान रह जाते।' AS s_hi,
  'Ek department head ko adig maana jaata hai. Woh aawaz oonchi nahi karte aur sankat mein ghabrate nahi. Aur unki ek khaas chaal bhi hai jab kuch khatak jaaye, aur floor par har koi use barah meter door se pehchan leta hai. Woh darwaze tak pahunchein usse pehle baatchit apni jagah badal leti hai. Yeh kisi ne unse kabhi nahi kaha aur woh hairan reh jaate.' AS s_hing,
  'He passes the second half of the verse comfortably — the world does not agitate him. He fails the first half, which is the half he cannot check for himself and the half that is other people''s actual experience of him. The verse joins the two with an "and", which is not decorative.' AS c_en,
  'वे श्लोक का दूसरा आधा आसानी से पार करते हैं — दुनिया उन्हें विचलित नहीं करती। वे पहले आधे पर गिरते हैं, जो वही आधा है जिसे वे ख़ुद जाँच नहीं सकते और जो दूसरों का उनके साथ असली अनुभव है। श्लोक दोनों को "और" से जोड़ता है, जो सजावट नहीं है।' AS c_hi,
  'Woh shloka ka doosra aadha asaani se paar karte hain — duniya unhe vichalit nahi karti. Woh pehle aadhe par girte hain, jo wahi aadha hai jise woh khud jaanch nahi sakte aur jo doosron ka unke saath asli anubhav hai. Shloka dono ko "aur" se jodta hai, jo sajawat nahi hai.' AS c_hing,
  'You can only audit the half of this verse that is about you. The other half is held by everybody who works near you.' AS l_en,
  'इस श्लोक का सिर्फ़ वही आधा आप जाँच सकते हैं जो आपके बारे में है। दूसरा आधा उन सबके पास है जो आपके पास काम करते हैं।' AS l_hi,
  'Is shloka ka sirf wahi aadha tum jaanch sakte ho jo tumhare baare mein hai. Doosra aadha un sabke paas hai jo tumhare paas kaam karte hain.' AS l_hing,
  NULL AS src, 'intermediate' AS diff, 'leadership,work,mood,composure,culture' AS tags

  UNION ALL SELECT 15, 'parenting', 2,
  'The evening that depended on a door', 'वह शाम जो एक दरवाज़े पर टिकी थी', 'Woh shaam jo ek darwaze par tiki thi',
  'Two children in a house have developed a shared skill: from the sound of the front door closing, they can tell what kind of evening it is going to be, and they act on the information within seconds. Neither has ever been shouted at. The forecast is built entirely from small signals, and it is accurate.',
  'एक घर के दो बच्चों ने एक साझा हुनर विकसित कर लिया है: सामने के दरवाज़े के बंद होने की आवाज़ से वे बता सकते हैं कि शाम किस तरह की होगी, और वे कुछ ही पलों में उस जानकारी पर अमल करते हैं। दोनों में से किसी पर कभी चिल्लाया नहीं गया। यह अनुमान पूरी तरह छोटे-छोटे संकेतों से बना है, और सही निकलता है।',
  'Ek ghar ke do bachchon ne ek saajha hunar vikasit kar liya hai: saamne ke darwaze ke band hone ki aawaz se woh bata sakte hain ki shaam kis tarah ki hogi, aur woh kuch hi palon mein us jaankari par amal karte hain. Dono mein se kisi par kabhi chillaya nahi gaya. Yeh anuman poori tarah chhote-chhote sanketon se bana hai, aur sahi nikalta hai.',
  'This is the first half of the verse measured by the most sensitive instrument available. Children in a house are not judging anybody; they are forecasting, because forecasting is useful. If the forecast is possible, the answer to the verse''s first question is already known.',
  'यह श्लोक का पहला आधा है, और नापने वाला उपकरण सबसे संवेदनशील है। घर के बच्चे किसी को आंक नहीं रहे; वे अनुमान लगा रहे हैं, क्योंकि अनुमान काम आता है। अगर अनुमान लगाया जा सकता है, तो श्लोक के पहले सवाल का जवाब पहले से मालूम है।',
  'Yeh shloka ka pehla aadha hai, aur naapne wala upkaran sabse samvedansheel hai. Ghar ke bachche kisi ko aank nahi rahe; woh anuman laga rahe hain, kyunki anuman kaam aata hai. Agar anuman lagaya ja sakta hai, to shloka ke pehle sawaal ka jawab pehle se maloom hai.',
  'If the people around you can forecast your mood, they have been paying a cost you have not been counting.',
  'अगर आपके आस-पास के लोग आपका मिज़ाज पहले से भाँप लेते हैं, तो वे ऐसी क़ीमत चुका रहे हैं जो आपने गिनी नहीं।',
  'Agar tumhare aas-paas ke log tumhara mizaaj pehle se bhaanp lete hain, to woh aisi keemat chuka rahe hain jo tumne gini nahi.',
  NULL, 'advanced', 'family,children,mood,home,atmosphere'

  UNION ALL SELECT 15, 'everyday_life', 3,
  'The queue that did not tighten', 'वह क़तार जो तनी नहीं', 'Woh line jo tani nahi',
  'A flight is delayed five hours and the desk has one member of staff. Most of the queue is polite and taut. One man near the front takes his news, says something ordinary to the woman behind the desk, and sits down. The queue behind him visibly loosens for about two minutes, and several people afterwards would not be able to say why.',
  'एक उड़ान पाँच घंटे देर है और काउंटर पर एक ही कर्मचारी है। क़तार में ज़्यादातर लोग शालीन हैं और तने हुए। आगे की तरफ़ एक आदमी अपनी ख़बर लेता है, काउंटर के पीछे खड़ी महिला से कुछ साधारण-सा कहता है, और जाकर बैठ जाता है। उसके पीछे की क़तार लगभग दो मिनट के लिए साफ़ तौर पर ढीली पड़ जाती है, और कई लोग बाद में बता नहीं पाएँगे कि क्यों।',
  'Ek flight paanch ghante der hai aur counter par ek hi karmchari hai. Line mein zyadatar log shalin hain aur tane hue. Aage ki taraf ek aadmi apni khabar leta hai, counter ke peechhe khadi mahila se kuch sadharan sa kehta hai, aur jaakar baith jaata hai. Uske peechhe ki line lagbhag do minute ke liye saaf taur par dheeli pad jaati hai, aur kai log baad mein bata nahi payenge ki kyun.',
  'Both halves in one small moment, and neither of them announced. He is not agitated by the world; the world around him is not agitated by him. Note what he did not do — he did not tell anybody to calm down, which is the intervention that works in the opposite direction.',
  'एक छोटे पल में दोनों आधे, और दोनों बिना घोषणा के। वह दुनिया से विचलित नहीं है; उसके आस-पास की दुनिया उससे विचलित नहीं है। ध्यान दीजिए उसने क्या नहीं किया — उसने किसी से शांत होने को नहीं कहा, जो वह हस्तक्षेप है जो उल्टी दिशा में काम करता है।',
  'Ek chhote pal mein dono aadhe, aur dono bina ghoshna ke. Woh duniya se vichalit nahi hai; uske aas-paas ki duniya usse vichalit nahi hai. Dhyan do usne kya nahi kiya — usne kisi se shaant hone ko nahi kaha, jo woh intervention hai jo ulti disha mein kaam karta hai.',
  'Telling a room to calm down is the intervention that works in the opposite direction. Sitting down is not.',
  'कमरे से शांत होने को कहना वह हस्तक्षेप है जो उल्टी दिशा में काम करता है। बैठ जाना नहीं है।',
  'Kamre se shaant hone ko kehna woh intervention hai jo ulti disha mein kaam karta hai. Baith jaana nahi hai.',
  NULL, 'beginner', 'travel,patience,strangers,atmosphere,ordinary'

  UNION ALL SELECT 16, 'everyday_life', 1,
  'Eleven notebooks, four pages each', 'ग्यारह कॉपियाँ, हर एक में चार पन्ने', 'Gyarah copies, har ek mein chaar panne',
  'Clearing a drawer, somebody finds eleven notebooks bought over six years. Each has between two and five pages used. The handwriting on the first page of every one of them is noticeably neater than anything that follows, and in four of them the first page is a plan for using the notebook.',
  'दराज़ साफ़ करते हुए किसी को छह साल में ख़रीदी ग्यारह कॉपियाँ मिलती हैं। हर एक में दो से पाँच पन्ने भरे हैं। हर एक के पहले पन्ने की लिखावट उसके बाद की हर चीज़ से साफ़ तौर पर सुंदर है, और उनमें से चार में पहला पन्ना उसी कॉपी को इस्तेमाल करने की योजना है।',
  'Daraz saaf karte hue kisi ko chhah saal mein kharidi gyarah copies milti hain. Har ek mein do se paanch panne bhare hain. Har ek ke pehle panne ki likhavat uske baad ki har cheez se saaf taur par sundar hai, aur unme se chaar mein pehla panna usi copy ko istemaal karne ki yojna hai.',
  'This is "sarvārambha-parityāgī" seen from the wrong end. What the compound asks you to give up is exactly this — the launching, the fresh start, the plan for the plan. The person in this drawer is not lazy; they have worked hard eleven times, always at the beginning.',
  'यह "सर्वारम्भपरित्यागी" को उल्टे सिरे से देखना है। समास जिसे छोड़ने को कहता है वह ठीक यही है — शुरू करना, नया आरंभ, योजना की योजना। इस दराज़ वाला व्यक्ति आलसी नहीं है; उसने ग्यारह बार कड़ी मेहनत की है, हर बार शुरुआत में।',
  'Yeh "sarvarambha-parityagi" ko ulte sire se dekhna hai. Samas jise chhodne ko kehta hai woh theek yahi hai — shuru karna, naya aarambh, yojna ki yojna. Is daraz wala insaan aalsi nahi hai; usne gyarah baar kadi mehnat ki hai, har baar shuruaat mein.',
  'Eleven beginnings is not laziness. It is effort spent entirely on the part that feels best.',
  'ग्यारह शुरुआतें आलस नहीं हैं। यह वह मेहनत है जो पूरी की पूरी उसी हिस्से पर लगी जो सबसे अच्छा लगता है।',
  'Gyarah shuruaatein aalas nahi hain. Yeh woh mehnat hai jo poori ki poori usi hisse par lagi jo sabse achha lagta hai.',
  NULL, 'beginner', 'habits,starting,finishing,procrastination,work'

  UNION ALL SELECT 16, 'social_media', 2,
  'The quarrel between two strangers', 'दो अनजान लोगों का झगड़ा', 'Do anjaan logon ka jhagda',
  'A dispute between two people neither of whom anybody in the office has met occupies about forty minutes of a working morning across four conversations. By lunchtime three people have positions, one has a strongly held position, and nobody involved will remember any of it within a fortnight.',
  'दो ऐसे लोगों का झगड़ा जिनसे दफ़्तर में कोई कभी मिला नहीं, काम की सुबह के लगभग चालीस मिनट, चार बातचीतों में ले लेता है। दोपहर तक तीन लोगों की राय बन चुकी है, एक की राय मज़बूत है, और इसमें शामिल किसी को दो हफ़्ते में इसमें से कुछ याद नहीं रहेगा।',
  'Do aise logon ka jhagda jinse office mein koi kabhi mila nahi, kaam ki subah ke lagbhag chalis minute, chaar baatchiton mein le leta hai. Dopahar tak teen logon ki raay ban chuki hai, ek ki raay mazboot hai, aur isme shamil kisi ko do hafte mein isme se kuch yaad nahi rahega.',
  '"Udāsīna" is the quality this verse asks for and it is routinely mistranslated as indifference, which sounds cold and is not what is meant. It is declining to take a side in something that is not yours. Nobody in this office is a bad person; they have simply accepted a job that was never assigned to them.',
  '"उदासीन" वही गुण है जो यह श्लोक माँगता है और इसका अनुवाद आम तौर पर बेरुख़ी की तरह होता है, जो ठंडा लगता है और अर्थ वह नहीं है। यह उस चीज़ में पक्ष लेने से मना करना है जो आपकी है ही नहीं। इस दफ़्तर में कोई बुरा इंसान नहीं है; उन्होंने बस ऐसा काम ले लिया है जो उन्हें कभी सौंपा नहीं गया।',
  '"Udasin" wahi gun hai jo yeh shloka maangta hai aur iska anuvaad aam taur par berukhi ki tarah hota hai, jo thanda lagta hai aur arth woh nahi hai. Yeh us cheez mein paksh lene se mana karna hai jo tumhari hai hi nahi. Is office mein koi bura insaan nahi hai; unhone bas aisa kaam le liya hai jo unhe kabhi saunpa nahi gaya.',
  'Impartiality is not coldness. It is declining a job nobody gave you.',
  'तटस्थता बेरुख़ी नहीं है। यह ऐसा काम लेने से मना करना है जो आपको किसी ने दिया ही नहीं।',
  'Tatasthata berukhi nahi hai. Yeh aisa kaam lene se mana karna hai jo tumhe kisi ne diya hi nahi.',
  NULL, 'beginner', 'internet,attention,opinion,impartiality,work'

  UNION ALL SELECT 16, 'startup', 3,
  'The pivot that was a rest', 'वह मोड़ जो असल में आराम था', 'Woh pivot jo asal mein aaram tha',
  'A company changes direction for the third time in two years. Each change is defensible on its own terms and each arrives at roughly the same point in the cycle — about four months in, when the interesting problems have been solved and what remains is the unglamorous middle. An investor eventually says this out loud, in one sentence, and the room does not argue.',
  'एक कंपनी दो साल में तीसरी बार दिशा बदलती है। हर बदलाव अपने आप में सही ठहराया जा सकता है और हर बार चक्र के लगभग एक ही बिंदु पर आता है — क़रीब चार महीने बाद, जब दिलचस्प समस्याएँ हल हो चुकी होती हैं और बचता है बेरौनक़ बीच का हिस्सा। एक निवेशक आख़िरकार यह ज़ोर से कह देता है, एक वाक्य में, और कमरा बहस नहीं करता।',
  'Ek company do saal mein teesri baar disha badalti hai. Har badlav apne aap mein sahi thehraya ja sakta hai aur har baar cycle ke lagbhag ek hi bindu par aata hai — karib chaar mahine baad, jab dilchasp samasyayein hal ho chuki hoti hain aur bachta hai berounak beech ka hissa. Ek investor aakhirkar yeh zor se keh deta hai, ek vakya mein, aur kamra behes nahi karta.',
  'The verse is not against changing direction, and nothing here says a pivot is a failure. It names a pattern: when the starting is the part that gets done well and the middle is the part that keeps arriving just before a change, the change is doing a job that has nothing to do with strategy.',
  'श्लोक दिशा बदलने के ख़िलाफ़ नहीं है, और यहाँ कुछ भी यह नहीं कहता कि मोड़ लेना नाकामी है। वह एक ढर्रा बताता है: जब शुरुआत ही वह हिस्सा हो जो अच्छा किया जाता है और बीच का हिस्सा हर बार किसी बदलाव से ठीक पहले आता हो, तो वह बदलाव कोई ऐसा काम कर रहा है जिसका रणनीति से कोई लेना-देना नहीं।',
  'Shloka disha badalne ke khilaf nahi hai, aur yahan kuch bhi yeh nahi kehta ki pivot nakami hai. Woh ek dharra batata hai: jab shuruaat hi woh hissa ho jo achha kiya jaata hai aur beech ka hissa har baar kisi badlav se theek pehle aata ho, to woh badlav koi aisa kaam kar raha hai jiska strategy se koi lena-dena nahi.',
  'A change that always arrives at the same point in the cycle is not a strategy. It is an exit from the boring part.',
  'जो बदलाव हर बार चक्र के एक ही बिंदु पर आता है वह रणनीति नहीं है। वह उबाऊ हिस्से से निकलने का रास्ता है।',
  'Jo badlav har baar cycle ke ek hi bindu par aata hai woh strategy nahi hai. Woh ubaau hisse se nikalne ka rasta hai.',
  NULL, 'intermediate', 'business,starting,finishing,strategy,avoidance'

  UNION ALL SELECT 18, 'corporate', 1,
  'The review that was a settling of accounts', 'वह समीक्षा जो हिसाब बराबर करना थी', 'Woh review jo hisaab barabar karna tha',
  'A design goes to two reviewers. One of them was made to look careless by the designer in a meeting eight months ago. Both reviews raise valid points. Only one of them raises seven, ordered from most to least damaging, and closes by noting that the deadline is the designer''s own estimate.',
  'एक डिज़ाइन दो समीक्षकों के पास जाता है। उनमें से एक को आठ महीने पहले एक बैठक में उसी डिज़ाइनर ने लापरवाह दिखा दिया था। दोनों समीक्षाओं में सही बातें हैं। उनमें से एक ही में सात बातें हैं, सबसे ज़्यादा नुक़सानदेह से सबसे कम के क्रम में, और अंत में यह भी कि समयसीमा ख़ुद डिज़ाइनर की बताई हुई है।',
  'Ek design do reviewers ke paas jaata hai. Unme se ek ko aath mahine pehle ek meeting mein usi designer ne laparwah dikha diya tha. Dono reviews mein sahi baatein hain. Unme se ek hi mein saat baatein hain, sabse zyada nuksaandeh se sabse kam ke kram mein, aur ant mein yeh bhi ki samay-seema khud designer ki batayi hui hai.',
  'Nothing in the second review is false, which is what makes it the right example. The verse does not ask you to feel the same about the two people. It asks whether your conduct changes shape depending on which one is in front of you — and seven ordered points is a shape.',
  'दूसरी समीक्षा में कुछ भी झूठ नहीं है, और इसीलिए यह सही उदाहरण है। श्लोक आपसे यह नहीं कहता कि दोनों लोगों के बारे में एक जैसा महसूस कीजिए। वह पूछता है कि सामने कौन है, इससे आपके बरताव का आकार बदलता है या नहीं — और क्रम में लगी सात बातें एक आकार हैं।',
  'Doosri review mein kuch bhi jhooth nahi hai, aur isiliye yeh sahi example hai. Shloka tumse yeh nahi kehta ki dono logon ke baare mein ek jaisa mehsoos karo. Woh poochta hai ki saamne kaun hai, isse tumhare bartav ka aakar badalta hai ya nahi — aur kram mein lagi saat baatein ek aakar hain.',
  'Everything in it can be true and it can still be a settling of accounts. The tell is the shape, not the facts.',
  'उसमें सब कुछ सच हो सकता है और वह फिर भी हिसाब बराबर करना हो सकता है। निशानी आकार है, तथ्य नहीं।',
  'Usme sab kuch sach ho sakta hai aur woh phir bhi hisaab barabar karna ho sakta hai. Nishani aakar hai, tathya nahi.',
  NULL, 'advanced', 'work,fairness,grudges,review,judgement'

  UNION ALL SELECT 18, 'sports', 2,
  'The handshake at the end', 'अंत में मिलाया हाथ', 'Ant mein milaya haath',
  'Two clubs have a genuine rivalry with twenty years of history in it. In one fixture a player from one side goes down badly and it is a player from the other who stays with him until the stretcher arrives, then plays the remaining half hour hard enough to be booked. Both things are reported, and only one of them surprises anybody.',
  'दो क्लबों के बीच बीस साल के इतिहास वाली सच्ची प्रतिद्वंद्विता है। एक मैच में एक तरफ़ का खिलाड़ी बुरी तरह गिरता है और दूसरी तरफ़ का ही खिलाड़ी स्ट्रेचर आने तक उसके साथ रहता है, फिर बाक़ी आधा घंटा इतना कड़ा खेलता है कि उसे कार्ड मिल जाता है। दोनों बातें छपती हैं, और उनमें से एक ही किसी को हैरान करती है।',
  'Do clubon ke beech bees saal ke itihaas wali sachchi pratidwandita hai. Ek match mein ek taraf ka player buri tarah girta hai aur doosri taraf ka hi player stretcher aane tak uske saath rehta hai, phir baaki aadha ghanta itna kada khelta hai ki use card mil jaata hai. Dono baatein chhapti hain, aur unme se ek hi kisi ko hairan karti hai.',
  'This is what "sama" looks like when it is not confused with softness. He did not stop competing, did not pretend the rivalry was not real, and did not like the other man more than he had an hour earlier. His conduct simply did not consult the shirt.',
  '"सम" ऐसा दिखता है जब उसे नरमी से नहीं मिलाया जाता। उसने खेलना बंद नहीं किया, यह दिखावा नहीं किया कि प्रतिद्वंद्विता झूठी है, और उस आदमी को एक घंटे पहले से ज़्यादा पसंद भी नहीं करने लगा। उसके बरताव ने बस जर्सी से सलाह नहीं ली।',
  '"Sama" aisa dikhta hai jab use narmi se nahi milaya jaata. Usne khelna band nahi kiya, yeh dikhava nahi kiya ki pratidwandita jhooti hai, aur us aadmi ko ek ghante pehle se zyada pasand bhi nahi karne laga. Uske bartav ne bas jersey se salah nahi li.',
  'Evenness is not softness. He kept competing; his conduct just did not consult the shirt.',
  'समता नरमी नहीं है। उसने खेलना जारी रखा; उसके बरताव ने बस जर्सी से सलाह नहीं ली।',
  'Samta narmi nahi hai. Usne khelna jaari rakha; uske bartav ne bas jersey se salah nahi li.',
  NULL, 'beginner', 'sport,rivalry,fairness,conduct,respect'

  UNION ALL SELECT 18, 'ethics', 3,
  'Praise on Tuesday, insult on Thursday', 'मंगलवार को तारीफ़, गुरुवार को अपमान', 'Tuesday ko tareef, Thursday ko apmaan',
  'A person is publicly praised for a piece of work on a Tuesday and publicly criticised for the same piece on a Thursday by somebody else. They can describe, later and with some embarrassment, that the Tuesday cost them about an hour of usable attention and the Thursday cost them two days.',
  'किसी की एक काम के लिए मंगलवार को सार्वजनिक तारीफ़ होती है और उसी काम के लिए गुरुवार को किसी और की तरफ़ से सार्वजनिक आलोचना। वे बाद में, कुछ झेंप के साथ, बता सकते हैं कि मंगलवार ने उनके क़रीब एक घंटे का काम लायक ध्यान लिया और गुरुवार ने दो दिन।',
  'Kisi ki ek kaam ke liye Tuesday ko public tareef hoti hai aur usi kaam ke liye Thursday ko kisi aur ki taraf se public alochna. Woh baad mein, kuch jhenp ke saath, bata sakte hain ki Tuesday ne unke karib ek ghante ka kaam layak dhyan liya aur Thursday ne do din.',
  'The verse puts honour and dishonour in the same breath, and the asymmetry here is the honest finding: for almost everybody the two do not weigh the same, and the heavier one is the insult by a factor most people would rather not measure. That ratio is the thing to know about yourself.',
  'श्लोक मान और अपमान को एक ही साँस में रखता है, और यहाँ की असमानता ईमानदार निष्कर्ष है: लगभग सबके लिए दोनों का वज़न बराबर नहीं है, और भारी वाला अपमान है — इतने गुना भारी कि ज़्यादातर लोग नापना नहीं चाहेंगे। अपने बारे में जानने लायक बात वही अनुपात है।',
  'Shloka maan aur apmaan ko ek hi saans mein rakhta hai, aur yahan ki asamanta imaandar nishkarsh hai: lagbhag sabke liye dono ka wazan barabar nahi hai, aur bhaari wala apmaan hai — itne guna bhaari ki zyadatar log naapna nahi chahenge. Apne baare mein jaanne layak baat wahi anupat hai.',
  'Measure how long praise stays and how long an insult stays. The ratio is more useful than any resolution about either.',
  'नापिए कि तारीफ़ कितनी देर रहती है और अपमान कितनी देर। यह अनुपात दोनों के बारे में किसी भी संकल्प से ज़्यादा काम का है।',
  'Naapo ki tareef kitni der rehti hai aur apmaan kitni der. Yeh anupat dono ke baare mein kisi bhi sankalp se zyada kaam ka hai.',
  NULL, 'intermediate', 'praise,criticism,attention,work,self-knowledge'

  UNION ALL SELECT 19, 'social_media', 1,
  'The reply that took four hours to not send', 'वह जवाब जिसे न भेजने में चार घंटे लगे', 'Woh jawab jise na bhejne mein chaar ghante lage',
  'Somebody is described inaccurately in a public thread. They draft a correction, do not send it, redraft it, walk around, redraft it again, and eventually do not send it. The not-sending takes four hours, which is longer than sending it would have taken and, they observe afterwards, longer than anybody spent reading the original.',
  'किसी के बारे में एक सार्वजनिक धागे में ग़लत बात लिखी जाती है। वह एक सुधार लिखता है, भेजता नहीं, फिर से लिखता है, टहलता है, फिर से लिखता है, और आख़िर में नहीं भेजता। न भेजने में चार घंटे लगते हैं, जो भेजने में लगने वाले समय से ज़्यादा है और, जैसा वह बाद में देखता है, उस मूल बात को पढ़ने में किसी के लगे समय से भी ज़्यादा।',
  'Kisi ke baare mein ek public thread mein galat baat likhi jaati hai. Woh ek sudhar likhta hai, bhejta nahi, phir se likhta hai, tehalta hai, phir se likhta hai, aur aakhir mein nahi bhejta. Na bhejne mein chaar ghante lagte hain, jo bhejne mein lagne wale samay se zyada hai aur, jaisa woh baad mein dekhta hai, us mool baat ko padhne mein kisi ke lage samay se bhi zyada.',
  'The verse pairs "maunī" with blame and praise weighing the same, and this is why the pairing matters. Silence on the outside is not the quality. Not needing to answer is the quality, and four hours of drafting is a need that happened to end in silence.',
  'श्लोक "मौनी" को इस बात के साथ जोड़ता है कि निंदा और तारीफ़ बराबर वज़न की हैं, और यही जोड़ मायने रखता है। बाहर की चुप्पी वह गुण नहीं है। गुण यह है कि जवाब देने की ज़रूरत न पड़े, और चार घंटे का मसौदा एक ज़रूरत है जो संयोग से चुप्पी पर ख़त्म हुई।',
  'Shloka "mauni" ko is baat ke saath jodta hai ki ninda aur tareef barabar wazan ki hain, aur yahi jod maayne rakhta hai. Bahar ki chuppi woh gun nahi hai. Gun yeh hai ki jawab dene ki zaroorat na pade, aur chaar ghante ka masauda ek zaroorat hai jo sanyog se chuppi par khatam hui.',
  'Silence on the outside is not the quality. Not needing to answer is, and the drafting is the tell.',
  'बाहर की चुप्पी वह गुण नहीं है। गुण यह है कि जवाब देने की ज़रूरत न पड़े, और निशानी मसौदा है।',
  'Bahar ki chuppi woh gun nahi hai. Gun yeh hai ki jawab dene ki zaroorat na pade, aur nishani masauda hai.',
  NULL, 'intermediate', 'internet,reputation,silence,restraint,attention'

  UNION ALL SELECT 19, 'everyday_life', 2,
  'The desk that had to be that desk', 'वह मेज़ जिसे वही मेज़ होना था', 'Woh mez jise wahi mez hona tha',
  'A writer produces good work for six years at one particular desk, in one particular room, starting at one particular time with one particular kind of coffee. A renovation removes the room for eleven weeks. The first three weeks produce nothing. The remaining eight produce roughly what the room used to, from a kitchen table, and afterwards the desk is never quite reinstated.',
  'एक लेखक छह साल तक एक ख़ास मेज़ पर, एक ख़ास कमरे में, एक ख़ास समय पर, एक ख़ास तरह की कॉफ़ी के साथ अच्छा काम करता है। मरम्मत के कारण वह कमरा ग्यारह हफ़्ते के लिए चला जाता है। पहले तीन हफ़्ते कुछ नहीं निकलता। बाक़ी आठ में रसोई की मेज़ से लगभग उतना ही निकलता है जितना उस कमरे से निकलता था, और उसके बाद वह मेज़ पूरी तरह कभी वापस नहीं आती।',
  'Ek lekhak chhah saal tak ek khaas mez par, ek khaas kamre mein, ek khaas time par, ek khaas tarah ki coffee ke saath achha kaam karta hai. Marammat ke kaaran woh kamra gyarah hafte ke liye chala jaata hai. Pehle teen hafte kuch nahi nikalta. Baaki aath mein rasoi ki mez se lagbhag utna hi nikalta hai jitna us kamre se nikalta tha, aur uske baad woh mez poori tarah kabhi wapas nahi aati.',
  '"Aniketaḥ" read sensibly is this: not needing one particular arrangement in order to be all right. The three empty weeks were real and the verse does not pretend otherwise. What the eleven weeks established is that the room had been carrying credit for something the person was doing.',
  '"अनिकेतः" को समझदारी से पढ़ें तो अर्थ यही है: ठीक रहने के लिए किसी एक ख़ास इंतज़ाम की ज़रूरत न होना। वे तीन ख़ाली हफ़्ते सच्चे थे और श्लोक इससे मुँह नहीं मोड़ता। ग्यारह हफ़्तों ने जो साबित किया वह यह है कि उस कमरे को उस काम का श्रेय मिल रहा था जो वह व्यक्ति कर रहा था।',
  '"Aniketah" ko samajhdari se padho to arth yahi hai: theek rehne ke liye kisi ek khaas intezaam ki zaroorat na hona. Woh teen khaali hafte sachche the aur shloka isse muh nahi modta. Gyarah hafton ne jo sabit kiya woh yeh hai ki us kamre ko us kaam ka credit mil raha tha jo woh insaan kar raha tha.',
  'The room had been taking credit for something you were doing. Most people have three or four rooms like that.',
  'उस कमरे को उस चीज़ का श्रेय मिल रहा था जो आप कर रहे थे। ज़्यादातर लोगों के पास ऐसे तीन-चार कमरे होते हैं।',
  'Us kamre ko us cheez ka credit mil raha tha jo tum kar rahe the. Zyadatar logon ke paas aise teen-chaar kamre hote hain.',
  NULL, 'beginner', 'work,routine,place,dependence,habits'

  UNION ALL SELECT 19, 'healthcare', 3,
  'Whatever the day brought', 'दिन जो भी लाया', 'Din jo bhi laya',
  'A long hospital stay removes almost every choice a person normally makes: when to eat, what to eat, when the lights go off, who comes in. Some patients on the ward are visibly destroyed by this in the first fortnight. One woman is not, and when asked, says something that is not resignation — she says she stopped negotiating with the timetable on about day four and got a great deal of herself back.',
  'अस्पताल में लंबा रुकना किसी व्यक्ति के लगभग सारे रोज़मर्रा के चुनाव छीन लेता है: कब खाना है, क्या खाना है, बत्तियाँ कब बुझेंगी, कौन अंदर आएगा। वार्ड के कुछ मरीज़ पहले दो हफ़्तों में इससे साफ़ तौर पर टूट जाते हैं। एक महिला नहीं टूटती, और पूछने पर वे जो कहती हैं वह हार मानना नहीं है — वे कहती हैं कि उन्होंने चौथे दिन के आसपास समय-सारणी से मोलभाव करना छोड़ दिया और अपना बहुत कुछ वापस पा लिया।',
  'Hospital mein lamba rukna kisi insaan ke lagbhag saare rozmarra ke chunav chheen leta hai: kab khana hai, kya khana hai, battiyan kab bujhengi, kaun andar aayega. Ward ke kuch mareez pehle do hafton mein isse saaf taur par toot jaate hain. Ek mahila nahi tootti, aur poochne par woh jo kehti hain woh haar maanna nahi hai — woh kehti hain ki unhone chauthe din ke aas-paas timetable se mol-bhaav karna chhod diya aur apna bahut kuch wapas paa liya.',
  '"Santuṣṭo yena kenacit" — content with whatever comes — is a phrase that reads badly in comfortable circumstances and reads very differently here. It is not approval of what came. It is the end of a negotiation that was never going to be won and was consuming everything she had.',
  '"सन्तुष्टो येन केनचित्" — जो मिल जाए उसी में संतुष्ट — यह वाक्यांश आरामदेह हालात में बुरा लगता है और यहाँ बिलकुल अलग पढ़ा जाता है। यह इस बात की मंज़ूरी नहीं है कि जो आया वह ठीक था। यह उस मोलभाव का अंत है जो जीता ही नहीं जा सकता था और उनका सब कुछ खा रहा था।',
  '"Santushto yena kenachit" — jo mil jaaye usi mein santusht — yeh vakyansh aaramdeh haalat mein bura lagta hai aur yahan bilkul alag padha jaata hai. Yeh is baat ki manzoori nahi hai ki jo aaya woh theek tha. Yeh us mol-bhaav ka ant hai jo jeeta hi nahi ja sakta tha aur unka sab kuch kha raha tha.',
  'Contentment is not approval of what came. Sometimes it is the end of a negotiation that was never winnable.',
  'संतोष इस बात की मंज़ूरी नहीं है कि जो आया वह ठीक था। कभी-कभी यह उस मोलभाव का अंत है जो जीता ही नहीं जा सकता था।',
  'Santosh is baat ki manzoori nahi hai ki jo aaya woh theek tha. Kabhi-kabhi yeh us mol-bhaav ka ant hai jo jeeta hi nahi ja sakta tha.',
  NULL, 'advanced', 'illness,control,acceptance,hospital,contentment'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 12;

-- =====================================================================
-- 5. CROSS REFERENCES
-- =====================================================================
-- Chapter 12 earns a lot of these, because its second half restates in
-- portrait form what chapters 2 and 3 argued in instruction form. Only
-- the ones where the parallel genuinely illuminates are here.
-- =====================================================================

DELETE x FROM verse_cross_references x JOIN verses v ON v.id = x.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 12;

INSERT INTO verse_cross_references
  (verse_id, reference_type, book, chapter, verse, target_verse_id,
   description_en, description_hi, description_hinglish, relationship, sort_order)
SELECT v.id, 'gita', 'Bhagavad Gita', CAST(x.tch AS CHAR), CAST(x.tvn AS CHAR), tv.id,
       x.d_en, x.d_hi, x.d_hing, x.rel, x.ord
FROM (
  SELECT 12 AS vn, 2 AS tch, 47 AS tvn, 1 AS ord,
    'The instruction from 2.47 arrives here as the top of a ladder rather than as an opening demand. Same act, and a reader who could not accept it there sometimes can accept it here.' AS d_en,
    '2.47 वाली हिदायत यहाँ शुरुआती माँग की तरह नहीं, सीढ़ी के सिरे की तरह आती है। काम वही है, और जो पाठक उसे वहाँ नहीं मान पाया वह कभी-कभी यहाँ मान लेता है।' AS d_hi,
    '2.47 wali hidayat yahan shuruaati maang ki tarah nahi, seedhi ke sire ki tarah aati hai. Kaam wahi hai, aur jo padhne wala use wahan nahi maan paya woh kabhi-kabhi yahan maan leta hai.' AS d_hing,
    'same' AS rel
  UNION ALL SELECT 12, 2, 48, 2,
    'Peace is said here to follow immediately. 2.48 describes what that steadiness looks like from inside while the result is still pending.',
    'यहाँ कहा गया है कि शांति तुरंत आती है। 2.48 बताता है कि नतीजा अभी बाक़ी हो, तब भीतर से वह समता कैसी लगती है।',
    'Yahan kaha gaya hai ki shanti turant aati hai. 2.48 batata hai ki result abhi baaki ho, tab bheetar se woh samta kaisi lagti hai.',
    'supports'
  UNION ALL SELECT 16, 3, 8, 1,
    'Read carelessly this verse sounds like an argument for doing nothing. 3.8 is the same book saying the opposite in as many words, which settles what the compound can mean.',
    'लापरवाही से पढ़ें तो यह श्लोक कुछ न करने की दलील जैसा लगता है। 3.8 उसी किताब में साफ़ शब्दों में उल्टा कह रहा है, जिससे तय हो जाता है कि समास का अर्थ क्या हो सकता है।',
    'Laparwahi se padho to yeh shloka kuch na karne ki dalil jaisa lagta hai. 3.8 usi kitaab mein saaf shabdon mein ulta keh raha hai, jisse tay ho jaata hai ki samas ka arth kya ho sakta hai.',
    'opposite'
  UNION ALL SELECT 16, 3, 19, 2,
    'Working without clinging to the result is the instruction; this is the portrait of somebody in whom it has become ordinary.',
    'नतीजे से चिपके बिना काम करना हिदायत है; यह उस व्यक्ति का चित्र है जिसमें वह आदत बन चुकी है।',
    'Result se chipke bina kaam karna hidayat hai; yeh us insaan ka chitra hai jisme woh aadat ban chuki hai.',
    'supports'
  UNION ALL SELECT 18, 2, 48, 1,
    'The same evenness, stated twice: 2.48 sets it out as a definition of yoga, and 12.18 shows it in a room with two people in it.',
    'वही समता, दो बार कही गई: 2.48 उसे योग की परिभाषा की तरह रखता है, और 12.18 उसे दो लोगों वाले कमरे में दिखाता है।',
    'Wahi samta, do baar kahi gayi: 2.48 use yoga ki paribhasha ki tarah rakhta hai, aur 12.18 use do logon wale kamre mein dikhata hai.',
    'same'
  UNION ALL SELECT 18, 2, 14, 2,
    'Cold and heat, pleasure and pain, in the same order. 2.14 asks you to endure them; this one describes somebody for whom enduring is no longer the word.',
    'सर्दी-गर्मी, सुख-दुख, उसी क्रम में। 2.14 उन्हें सहने को कहता है; यह उस व्यक्ति को बताता है जिसके लिए सहना अब सही शब्द नहीं रहा।',
    'Sardi-garmi, sukh-dukh, usi kram mein. 2.14 unhe sehne ko kehta hai; yeh us insaan ko batata hai jiske liye sehna ab sahi shabd nahi raha.',
    'supports'
  UNION ALL SELECT 15, 2, 70, 1,
    'The ocean that takes every river without rising is the same picture as somebody the world cannot agitate — one in an image, one in a room.',
    'जो समुद्र हर नदी लेकर भी नहीं बढ़ता, वह उसी तस्वीर का दूसरा रूप है जिसे दुनिया विचलित नहीं कर पाती — एक उपमा में, एक कमरे में।',
    'Jo samudra har nadi lekar bhi nahi badhta, woh usi tasveer ka doosra roop hai jise duniya vichalit nahi kar paati — ek upma mein, ek kamre mein.',
    'same'
  UNION ALL SELECT 13, 2, 62, 1,
    'The chain from dwelling to wanting to anger is what "no ill-will towards anything alive" is the absence of. One describes the mechanism, the other the person it does not run in.',
    'सोचते रहने से चाह और फिर गुस्से तक की कड़ी वही है जिसकी अनुपस्थिति "किसी जीव के प्रति द्वेष नहीं" है। एक तंत्र बताता है, दूसरा वह व्यक्ति जिसमें वह चलता नहीं।',
    'Sochte rehne se chaah aur phir gusse tak ki chain wahi hai jiski gairhaziri "kisi jeev ke prati dwesh nahi" hai. Ek mechanism batata hai, doosra woh insaan jisme woh chalta nahi.',
    'opposite'
  UNION ALL SELECT 19, 2, 70, 1,
    'Content with whatever comes, and the ocean that does not rise when the rivers arrive. The second is what the first looks like when it is drawn rather than described.',
    'जो मिल जाए उसी में संतुष्ट, और वह समुद्र जो नदियों के आने पर भी नहीं बढ़ता। दूसरा वही है जो पहला बताया नहीं, खींचा जाए तो दिखता है।',
    'Jo mil jaaye usi mein santusht, aur woh samudra jo nadiyon ke aane par bhi nahi badhta. Doosra wahi hai jo pehla bataya nahi, kheencha jaaye to dikhta hai.',
    'same'
  UNION ALL SELECT 5, 12, 8, 1,
    'The verse says the formless is harder for people with bodies. This is the alternative it is clearing the ground for.',
    'श्लोक कहता है कि शरीर वालों के लिए निराकार कठिन है। यह वही विकल्प है जिसके लिए वह ज़मीन साफ़ कर रहा है।',
    'Shloka kehta hai ki sharir walon ke liye nirakar mushkil hai. Yeh wahi option hai jiske liye woh zameen saaf kar raha hai.',
    'supports'
) AS x
JOIN verses v  ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 12
JOIN chapters tc ON tc.chapter_number = x.tch
JOIN verses tv ON tv.verse_number = x.tvn AND tv.chapter_id = tc.id;

-- =====================================================================
-- 6. WORD BY WORD
-- =====================================================================
-- Where a word has been fought over — sarvārambha and aniketaḥ above
-- all — the gloss says what the word means and leaves the argument to
-- the explanation. It does not smuggle a reading in as a definition.
-- =====================================================================

DELETE w FROM verse_word_meanings w JOIN verses v ON v.id = w.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 12;

INSERT INTO verse_word_meanings
  (verse_id, word_order, devanagari, transliteration,
   meaning_en, meaning_hi, meaning_hinglish, grammar, root_word)
SELECT v.id, w.ord, w.dev, w.tr, w.m_en, w.m_hi, w.m_hing, w.gram, w.root FROM (

  -- 12.5
  SELECT 5 AS vn, 1 AS ord, 'क्लेशः' AS dev, 'kleśaḥ' AS tr, 'difficulty, strain' AS m_en, 'क्लेश, कठिनाई' AS m_hi, 'klesh, mushkil' AS m_hing, 'nominative singular' AS gram, 'क्लिश्' AS root
  UNION ALL SELECT 5, 2, 'अधिकतरः', 'adhikataraḥ', 'greater — a comparative, not a verdict', 'ज़्यादा — तुलना है, फ़ैसला नहीं', 'zyada — tulna hai, faisla nahi', 'comparative, nominative', 'अधिक'
  UNION ALL SELECT 5, 3, 'तेषाम्', 'teṣām', 'for those', 'उनके लिए', 'unke liye', 'genitive plural', 'तद्'
  UNION ALL SELECT 5, 4, 'अव्यक्तासक्तचेतसाम्', 'avyaktāsakta-cetasām', 'whose minds are fixed on the unmanifest', 'जिनका चित्त अव्यक्त पर टिका है', 'jinka chitt avyakt par tika hai', 'compound, genitive plural', 'चित्'
  UNION ALL SELECT 5, 5, 'अव्यक्ता', 'avyaktā', 'unmanifest — what has no form to face', 'अव्यक्त — जिसका कोई रूप सामने नहीं', 'avyakt — jiska koi roop saamne nahi', 'nominative singular', 'वि + अञ्ज्'
  UNION ALL SELECT 5, 6, 'गतिः', 'gatiḥ', 'goal, the place one is going', 'गति, लक्ष्य', 'gati, lakshya', 'nominative singular', 'गम्'
  UNION ALL SELECT 5, 7, 'दुःखम्', 'duḥkham', 'with difficulty', 'कठिनाई से', 'mushkil se', 'adverbial accusative', 'दुःख'
  UNION ALL SELECT 5, 8, 'देहवद्भिः', 'dehavadbhiḥ', 'by those who have bodies', 'शरीर वालों के द्वारा', 'sharir walon ke dwara', 'instrumental plural', 'देह'
  UNION ALL SELECT 5, 9, 'अवाप्यते', 'avāpyate', 'is reached', 'पाया जाता है', 'paaya jaata hai', 'passive, third person', 'अव + आप्'

  -- 12.8
  UNION ALL SELECT 8, 1, 'मयि', 'mayi', 'in me', 'मुझमें', 'mujhme', 'locative singular', 'अस्मद्'
  UNION ALL SELECT 8, 2, 'एव', 'eva', 'only, alone', 'ही', 'hi', 'emphatic particle', NULL
  UNION ALL SELECT 8, 3, 'मनः', 'manaḥ', 'the mind — where attention goes', 'मन — जहाँ ध्यान जाता है', 'man — jahan dhyan jaata hai', 'accusative singular', 'मन्'
  UNION ALL SELECT 8, 4, 'आधत्स्व', 'ādhatsva', 'place, set down', 'रखिए', 'rakho', 'imperative middle, second person', 'आ + धा'
  UNION ALL SELECT 8, 5, 'बुद्धिम्', 'buddhim', 'the deciding faculty — judgement, not intellect in the exam sense', 'बुद्धि — तय करने वाली शक्ति, परीक्षा वाली अक़्ल नहीं', 'buddhi — tay karne wali shakti, exam wali akal nahi', 'accusative singular', 'बुध्'
  UNION ALL SELECT 8, 6, 'निवेशय', 'niveśaya', 'settle, install', 'बिठा दीजिए', 'bitha do', 'causative imperative, second person', 'नि + विश्'
  UNION ALL SELECT 8, 7, 'निवसिष्यसि', 'nivasiṣyasi', 'you will dwell, you will live', 'आप रहेंगे', 'tum rahoge', 'future, second person', 'नि + वस्'
  UNION ALL SELECT 8, 8, 'न संशयः', 'na saṁśayaḥ', 'no doubt about it', 'इसमें संदेह नहीं', 'isme shak nahi', 'nominative singular', 'सम् + शी'

  -- 12.12
  UNION ALL SELECT 12, 1, 'श्रेयः', 'śreyaḥ', 'better', 'बेहतर', 'behtar', 'comparative, nominative', 'श्री'
  UNION ALL SELECT 12, 2, 'ज्ञानम्', 'jñānam', 'knowledge, understanding', 'ज्ञान, समझ', 'gyan, samajh', 'nominative singular', 'ज्ञा'
  UNION ALL SELECT 12, 3, 'अभ्यासात्', 'abhyāsāt', 'than repeated practice, than drilling', 'अभ्यास से, रटने से', 'abhyas se, ratne se', 'ablative singular', 'अभि + अस्'
  UNION ALL SELECT 12, 4, 'ध्यानम्', 'dhyānam', 'sustained attention, meditation', 'ध्यान, टिका हुआ मन', 'dhyan, tika hua man', 'nominative singular', 'ध्यै'
  UNION ALL SELECT 12, 5, 'विशिष्यते', 'viśiṣyate', 'is held higher', 'ऊपर रखा जाता है', 'upar rakha jaata hai', 'passive, third person', 'वि + शिष्'
  UNION ALL SELECT 12, 6, 'कर्मफलत्यागः', 'karma-phala-tyāgaḥ', 'giving up the fruit of action', 'कर्म के फल का त्याग', 'karm ke phal ka tyag', 'compound, nominative', 'त्यज्'
  UNION ALL SELECT 12, 7, 'शान्तिः', 'śāntiḥ', 'peace, quiet', 'शांति', 'shanti', 'nominative singular', 'शम्'
  UNION ALL SELECT 12, 8, 'अनन्तरम्', 'anantaram', 'immediately, with nothing in between', 'तुरंत, बीच में कुछ नहीं', 'turant, beech mein kuch nahi', 'indeclinable', 'अन्तर'

  -- 12.13
  UNION ALL SELECT 13, 1, 'अद्वेष्टा', 'adveṣṭā', 'not hating, bearing no ill-will', 'द्वेष न रखने वाला', 'dwesh na rakhne wala', 'nominative singular', 'अ + द्विष्'
  UNION ALL SELECT 13, 2, 'सर्वभूतानाम्', 'sarva-bhūtānām', 'towards all beings — everything alive, not only people', 'सब प्राणियों के प्रति — हर जीव, सिर्फ़ लोग नहीं', 'sab praniyon ke prati — har jeev, sirf log nahi', 'compound, genitive plural', 'भू'
  UNION ALL SELECT 13, 3, 'मैत्रः', 'maitraḥ', 'friendly, warm', 'मित्रवत, गर्मजोश', 'mitravat, garmjosh', 'nominative singular', 'मित्र'
  UNION ALL SELECT 13, 4, 'करुणः', 'karuṇaḥ', 'compassionate — moved by what happens to others', 'करुण — दूसरों के साथ जो होता है उससे हिलने वाला', 'karun — doosron ke saath jo hota hai usse hilne wala', 'nominative singular', 'कृ'
  UNION ALL SELECT 13, 5, 'निर्ममः', 'nirmamaḥ', 'without "mine"', 'बिना "मेरा" के', 'bina "mera" ke', 'nominative singular', 'मम'
  UNION ALL SELECT 13, 6, 'निरहङ्कारः', 'nirahaṅkāraḥ', 'without the I-maker — no case being made for oneself', 'अहंकार रहित — अपने लिए कोई दलील नहीं', 'ahankaar rahit — apne liye koi dalil nahi', 'compound, nominative', 'अहम् + कृ'
  UNION ALL SELECT 13, 7, 'समदुःखसुखः', 'sama-duḥkha-sukhaḥ', 'the same in pain and pleasure', 'दुख और सुख में एक जैसा', 'dukh aur sukh mein ek jaisa', 'compound, nominative', 'सम'
  UNION ALL SELECT 13, 8, 'क्षमी', 'kṣamī', 'forgiving — closer to slow to keep score than to grandly pardoning', 'क्षमाशील — भव्य माफ़ी से ज़्यादा "हिसाब रखने में धीमा"', 'kshamashil — bhavya maafi se zyada "hisaab rakhne mein dheema"', 'nominative singular', 'क्षम्'

  -- 12.15
  UNION ALL SELECT 15, 1, 'यस्मात्', 'yasmāt', 'from whom', 'जिससे', 'jisse', 'ablative singular', 'यद्'
  UNION ALL SELECT 15, 2, 'न उद्विजते', 'na udvijate', 'is not agitated, does not flinch', 'विचलित नहीं होता', 'vichalit nahi hota', 'present middle, third person', 'उद् + विज्'
  UNION ALL SELECT 15, 3, 'लोकः', 'lokaḥ', 'the world — here, the people around him', 'लोक — यहाँ, आस-पास के लोग', 'lok — yahan, aas-paas ke log', 'nominative singular', 'लोक'
  UNION ALL SELECT 15, 4, 'हर्ष', 'harṣa', 'elation, being carried off by a high', 'हर्ष, उछाल', 'harsh, ubhaar', 'in compound', 'हृष्'
  UNION ALL SELECT 15, 5, 'अमर्ष', 'amarṣa', 'resentment, the grievance that will not settle', 'अमर्ष, न बैठने वाला मलाल', 'amarsh, na baithne wala malaal', 'in compound', 'मृष्'
  UNION ALL SELECT 15, 6, 'भय', 'bhaya', 'fear', 'भय, डर', 'bhay, dar', 'in compound', 'भी'
  UNION ALL SELECT 15, 7, 'उद्वेगैः', 'udvegaiḥ', 'by anxieties — the low continuous bracing', 'उद्वेगों से — वह धीमा लगातार तनाव', 'udvegon se — woh dheema lagatar tanav', 'instrumental plural', 'उद् + विज्'
  UNION ALL SELECT 15, 8, 'मुक्तः', 'muktaḥ', 'freed, released', 'मुक्त', 'mukt', 'past participle, nominative', 'मुच्'
  UNION ALL SELECT 15, 9, 'स च मे प्रियः', 'sa ca me priyaḥ', 'he too is dear to me', 'वह भी मुझे प्रिय है', 'woh bhi mujhe priya hai', 'nominative singular', 'प्री'

  -- 12.16
  UNION ALL SELECT 16, 1, 'अनपेक्षः', 'anapekṣaḥ', 'without expectation, not waiting on anything', 'बिना अपेक्षा के, किसी के इंतज़ार में नहीं', 'bina apeksha ke, kisi ke intezaar mein nahi', 'nominative singular', 'अप + ईक्ष्'
  UNION ALL SELECT 16, 2, 'शुचिः', 'śuciḥ', 'clean — of conduct as much as of body', 'शुचि — शरीर जितना ही बरताव का', 'shuchi — sharir jitna hi bartav ka', 'nominative singular', 'शुच्'
  UNION ALL SELECT 16, 3, 'दक्षः', 'dakṣaḥ', 'capable, good at what he does', 'दक्ष, अपने काम में कुशल', 'daksh, apne kaam mein kushal', 'nominative singular', 'दक्ष्'
  UNION ALL SELECT 16, 4, 'उदासीनः', 'udāsīnaḥ', 'impartial — not taking a side in what is not his; NOT indifferent', 'उदासीन — जो उसका नहीं उसमें पक्ष नहीं; बेरुख़ी नहीं', 'udasin — jo uska nahi usme paksh nahi; berukhi nahi', 'nominative singular', 'उद् + आस्'
  UNION ALL SELECT 16, 5, 'गतव्यथः', 'gata-vyathaḥ', 'whose distress has gone', 'जिसकी टीस चली गई', 'jiski tees chali gayi', 'compound, nominative', 'व्यथ्'
  UNION ALL SELECT 16, 6, 'सर्वारम्भपरित्यागी', 'sarvārambha-parityāgī', 'who has given up all UNDERTAKINGS — ārambha is the launching, the taking-up, not the work', 'जिसने सब आरम्भ छोड़ दिए — आरम्भ यानी शुरू करना, उठाना; काम नहीं', 'jisne sab aarambh chhod diye — aarambh yaani shuru karna, uthana; kaam nahi', 'compound, nominative', 'आ + रभ्'
  UNION ALL SELECT 16, 7, 'मद्भक्तः', 'mad-bhaktaḥ', 'devoted to me', 'मेरा भक्त', 'mera bhakt', 'compound, nominative', 'भज्'

  -- 12.18
  UNION ALL SELECT 18, 1, 'समः', 'samaḥ', 'the same — of conduct; the verse does not legislate feeling', 'सम — बरताव में; श्लोक भावना पर क़ानून नहीं बनाता', 'sam — bartav mein; shloka bhavna par kanoon nahi banata', 'nominative singular', 'सम'
  UNION ALL SELECT 18, 2, 'शत्रौ', 'śatrau', 'towards an enemy', 'शत्रु के प्रति', 'shatru ke prati', 'locative singular', 'शत्रु'
  UNION ALL SELECT 18, 3, 'मित्रे', 'mitre', 'towards a friend', 'मित्र के प्रति', 'mitra ke prati', 'locative singular', 'मित्र'
  UNION ALL SELECT 18, 4, 'मानापमानयोः', 'mānāpamānayoḥ', 'in honour and dishonour', 'मान और अपमान में', 'maan aur apmaan mein', 'compound, locative dual', 'मन्'
  UNION ALL SELECT 18, 5, 'शीतोष्णसुखदुःखेषु', 'śītoṣṇa-sukha-duḥkheṣu', 'in cold and heat, pleasure and pain', 'सर्दी-गर्मी, सुख-दुख में', 'sardi-garmi, sukh-dukh mein', 'compound, locative plural', 'शीत'
  UNION ALL SELECT 18, 6, 'सङ्गविवर्जितः', 'saṅga-vivarjitaḥ', 'free of clinging', 'आसक्ति से रहित', 'lagaav se rahit', 'compound, nominative', 'सञ्ज्'

  -- 12.19
  UNION ALL SELECT 19, 1, 'तुल्यनिन्दास्तुतिः', 'tulya-nindā-stutiḥ', 'to whom blame and praise weigh the same', 'जिसके लिए निंदा और स्तुति बराबर वज़न की हैं', 'jiske liye ninda aur stuti barabar wazan ki hain', 'compound, nominative', 'तुल्'
  UNION ALL SELECT 19, 2, 'मौनी', 'maunī', 'silent — not having nothing to say, not needing to answer', 'मौनी — कहने को कुछ न होना नहीं, जवाब देने की ज़रूरत न पड़ना', 'mauni — kehne ko kuch na hona nahi, jawab dene ki zaroorat na padna', 'nominative singular', 'मुनि'
  UNION ALL SELECT 19, 3, 'सन्तुष्टः', 'santuṣṭaḥ', 'content', 'संतुष्ट', 'santusht', 'past participle, nominative', 'सम् + तुष्'
  UNION ALL SELECT 19, 4, 'येन केनचित्', 'yena kenacit', 'with whatever comes, by whatever means', 'जो भी मिल जाए उसी से', 'jo bhi mil jaaye usi se', 'instrumental singular', 'किम्'
  UNION ALL SELECT 19, 5, 'अनिकेतः', 'aniketaḥ', 'without a fixed dwelling — read across the list, not needing one particular arrangement in order to be all right', 'अनिकेत — बिना तय ठिकाने के; पूरी सूची के साथ पढ़ें तो: ठीक रहने के लिए किसी एक ख़ास इंतज़ाम की ज़रूरत न होना', 'aniket — bina tay thikane ke; poori list ke saath padho to: theek rehne ke liye kisi ek khaas intezaam ki zaroorat na hona', 'nominative singular', 'निकेत'
  UNION ALL SELECT 19, 6, 'स्थिरमतिः', 'sthira-matiḥ', 'steady in what he thinks', 'अपनी सोच में जमा हुआ', 'apni soch mein jama hua', 'compound, nominative', 'स्था'
  UNION ALL SELECT 19, 7, 'भक्तिमान्', 'bhaktimān', 'having devotion', 'भक्ति वाला', 'bhakti wala', 'nominative singular', 'भज्'
  UNION ALL SELECT 19, 8, 'मे प्रियो नरः', 'me priyo naraḥ', 'that person is dear to me', 'वह व्यक्ति मुझे प्रिय है', 'woh insaan mujhe priya hai', 'nominative singular', 'प्री'
) AS w
JOIN verses v ON v.verse_number = w.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 12;

-- =====================================================================
-- 7. BEGINNER-DEPTH EXPLANATIONS ADDED LATER
-- =====================================================================
-- Four of this chapter's eight verses were seeded at intermediate only,
-- so a beginner-track reader met half of chapter 12 through the
-- repository's fallback. This adds the beginner depth for all four.
--
-- They live at the bottom of this file rather than in one of their own
-- because the DELETE in the explanations section clears the whole
-- chapter; a row added from elsewhere would vanish on the next re-run.
-- =====================================================================

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 12 AS vn, 'beginner' AS level,
   'Krishna has just spent six verses offering smaller and smaller versions of the same thing — if you cannot do this, do that; if you cannot do that, do this instead. Then he stops offering and ranks them.' AS h_en,
   'कृष्ण ने अभी छह श्लोक एक ही चीज़ के छोटे से छोटे रूप देने में लगाए हैं — यह नहीं कर सकते तो वह कीजिए; वह नहीं कर सकते तो यह कीजिए। फिर वे देना बंद करके उन्हें क्रम में रख देते हैं।' AS h_hi,
   'Krishna ne abhi chhah shloka ek hi cheez ke chhote se chhote roop dene mein lagaye hain — yeh nahi kar sakte to woh karo; woh nahi kar sakte to yeh karo. Phir woh dena band karke unhe kram mein rakh dete hain.' AS h_hing,
   'Four things, each better than the one before it. Drilling something until it sticks. Then understanding it. Then being able to hold your attention on it. And above all three: letting go of what the work gets you. Peace comes right after that one — not eventually, right after.' AS p_en,
   'चार चीज़ें, हर एक पिछली से बेहतर। किसी चीज़ को रटकर बिठाना। फिर उसे समझना। फिर उस पर ध्यान टिका पाना। और इन तीनों से ऊपर: काम से जो मिलता है उसे छोड़ देना। शांति उसके ठीक बाद आती है — कभी बाद में नहीं, ठीक बाद।' AS p_hi,
   'Chaar cheezein, har ek pichhli se behtar. Kisi cheez ko ratkar bithana. Phir use samajhna. Phir us par dhyan tika paana. Aur in teenon se upar: kaam se jo milta hai use chhod dena. Shanti uske theek baad aati hai — kabhi baad mein nahi, theek baad.' AS p_hing,
   'The order is the useful part, because it is the opposite of how most people arrange their effort. Almost everybody pushes hardest on the bottom rungs — more discipline, more reading, better technique — since those are the ones that answer when you push. The thing at the top does not answer to pushing. It is something you stop doing.' AS m_en,
   'क्रम ही काम की बात है, क्योंकि यह ठीक उल्टा है जिस तरह ज़्यादातर लोग अपनी मेहनत जमाते हैं। लगभग सब सबसे नीचे वाली सीढ़ियों पर ज़ोर लगाते हैं — और अनुशासन, और पढ़ाई, बेहतर तरीक़ा — क्योंकि ज़ोर लगाने पर वही जवाब देती हैं। जो सबसे ऊपर है वह ज़ोर का जवाब नहीं देता। वह वह चीज़ है जिसे करना बंद किया जाता है।' AS m_hi,
   'Kram hi kaam ki baat hai, kyunki yeh theek ulta hai jis tarah zyadatar log apni mehnat jamate hain. Lagbhag sab sabse neeche wali seedhiyon par zor lagate hain — aur discipline, aur padhai, behtar tareeka — kyunki zor lagane par wahi jawab deti hain. Jo sabse upar hai woh zor ka jawab nahi deta. Woh woh cheez hai jise karna band kiya jaata hai.' AS m_hing

  UNION ALL SELECT 16, 'beginner',
   'The portrait of the person this chapter calls dear has been running for three verses. Six more qualities arrive here, and the last one in the list has caused more trouble in translation than anything else in the chapter.',
   'इस अध्याय जिसे प्रिय कहता है, उसका चित्र तीन श्लोकों से चल रहा है। छह और गुण यहाँ आते हैं, और सूची का आख़िरी अनुवाद में अध्याय की किसी भी और बात से ज़्यादा गड़बड़ कर चुका है।',
   'Is chapter jise priya kehta hai, uska chitra teen shlokon se chal raha hai. Chhah aur gun yahan aate hain, aur list ka aakhiri anuvaad mein chapter ki kisi bhi aur baat se zyada gadbad kar chuka hai.',
   'Not waiting on anything. Straight in how he deals with people. Good at what he does. Not picking a side in a quarrel that is not his. The old ache gone. And then the last one, which in English comes out as "has given up all undertakings" and sounds like an instruction to stop working. It is not. The word means the starting, the launching — not the work.',
   'किसी चीज़ के इंतज़ार में नहीं। लोगों से लेन-देन में सीधा। अपने काम में कुशल। ऐसे झगड़े में पक्ष नहीं लेता जो उसका है ही नहीं। पुरानी टीस जा चुकी। और फिर आख़िरी वाला, जो अंग्रेज़ी में "सब उद्यम छोड़ दिए" बनता है और काम बंद करने की हिदायत जैसा लगता है। वह है नहीं। शब्द का अर्थ है शुरू करना, उठाना — काम नहीं।',
   'Kisi cheez ke intezaar mein nahi. Logon se len-den mein seedha. Apne kaam mein kushal. Aise jhagde mein paksh nahi leta jo uska hai hi nahi. Purani tees ja chuki. Aur phir aakhiri wala, jo English mein "sab udyam chhod diye" banta hai aur kaam band karne ki hidayat jaisa lagta hai. Woh hai nahi. Shabd ka arth hai shuru karna, uthana — kaam nahi.',
   'What is being given up is the compulsive starting — the new plan on Monday, the fresh notebook, the enthusiasm that is really an escape from the boring middle of the last thing. Read that way it agrees with chapter 3 exactly instead of contradicting it, and it names a failure mode that most busy-looking people recognise immediately.',
   'जो छोड़ा जा रहा है वह है बार-बार शुरू करने की लत — सोमवार को नई योजना, नई कॉपी, वह जोश जो असल में पिछली चीज़ के उबाऊ बीच से भागना है। ऐसे पढ़िए तो यह तीसरे अध्याय से टकराने के बजाय ठीक-ठीक मिल जाता है, और उस ख़राबी का नाम रखता है जिसे व्यस्त दिखने वाले ज़्यादातर लोग तुरंत पहचान लेते हैं।',
   'Jo chhoda ja raha hai woh hai baar-baar shuru karne ki lat — Monday ko nayi yojna, nayi copy, woh josh jo asal mein pichhli cheez ke ubaau beech se bhaagna hai. Aise padho to yeh teesre chapter se takrane ke bajaye theek-theek mil jaata hai, aur us kharabi ka naam rakhta hai jise vyast dikhne wale zyadatar log turant pehchan lete hain.'

  UNION ALL SELECT 18, 'beginner',
   'The list of qualities reaches its hardest line. Everything before it could be read as a description of somebody with a naturally calm temperament. This one cannot, because it names an enemy.',
   'गुणों की सूची अपनी सबसे कठिन पंक्ति पर पहुँचती है। इससे पहले सब कुछ स्वभाव से शांत व्यक्ति का वर्णन पढ़ा जा सकता था। यह नहीं, क्योंकि यह शत्रु का नाम लेता है।',
   'Gunon ki list apni sabse mushkil line par pahunchti hai. Isse pehle sab kuch swabhav se shaant insaan ka varnan padha ja sakta tha. Yeh nahi, kyunki yeh shatru ka naam leta hai.',
   'The same with the person who is against him and the person who is for him. The same when praised and when insulted. Be careful about what "the same" is asking for here — not liking them equally, and not pretending there is no difference. Your conduct does not change shape depending on which of the two is standing in front of you.',
   'जो उसके ख़िलाफ़ है और जो उसके साथ है — दोनों के साथ एक जैसा। तारीफ़ में और अपमान में एक जैसा। "एक जैसा" यहाँ क्या माँग रहा है, इस पर सावधान रहिए — दोनों को बराबर पसंद करना नहीं, और यह दिखावा भी नहीं कि कोई फ़र्क़ ही नहीं। सामने दोनों में से कौन खड़ा है, इससे आपके बरताव का आकार नहीं बदलता।',
   'Jo uske khilaf hai aur jo uske saath hai — dono ke saath ek jaisa. Tareef mein aur apmaan mein ek jaisa. "Ek jaisa" yahan kya maang raha hai, is par savdhan raho — dono ko barabar pasand karna nahi, aur yeh dikhava bhi nahi ki koi farq hi nahi. Saamne dono mein se kaun khada hai, isse tumhare bartav ka aakar nahi badalta.',
   'The test almost everybody fails is not about grand enemies. It is the colleague who once made you look bad in front of somebody. Watch what happens to your standards of fairness when their work comes to you for review. The verse is not asking you to like them; it is asking whether your judgement is a judgement.',
   'जिस कसौटी पर लगभग सब गिरते हैं वह किसी बड़े दुश्मन की नहीं है। वह उस सहकर्मी की है जिसने कभी किसी के सामने आपको नीचा दिखाया। देखिए कि जब उसका काम आपके पास समीक्षा के लिए आता है तब आपके निष्पक्षता के मानक का क्या होता है। श्लोक आपसे उसे पसंद करने को नहीं कह रहा; वह पूछ रहा है कि आपका फ़ैसला फ़ैसला है या नहीं।',
   'Jis kasauti par lagbhag sab girte hain woh kisi bade dushman ki nahi hai. Woh us colleague ki hai jisne kabhi kisi ke saamne tumhe neecha dikhaya. Dekho ki jab uska kaam tumhare paas review ke liye aata hai tab tumhare nishpakshta ke standard ka kya hota hai. Shloka tumse use pasand karne ko nahi keh raha; woh pooch raha hai ki tumhara faisla faisla hai ya nahi.'

  UNION ALL SELECT 19, 'beginner',
   'The portrait ends here. One word in it — aniketaḥ, without a fixed dwelling — has carried a lot of weight historically and has been read both as an instruction to wander and as something much less dramatic.',
   'चित्र यहाँ पूरा होता है। इसमें एक शब्द — अनिकेतः, बिना तय ठिकाने वाला — इतिहास में बहुत बोझ उठा चुका है और इसे घूमते रहने की हिदायत की तरह भी पढ़ा गया है और उससे कहीं कम नाटकीय किसी बात की तरह भी।',
   'Chitra yahan poora hota hai. Isme ek shabd — aniketah, bina tay thikane wala — itihaas mein bahut bojh utha chuka hai aur ise ghoomte rehne ki hidayat ki tarah bhi padha gaya hai aur usse kahin kam natakiya kisi baat ki tarah bhi.',
   'The quieter reading fits the rest of the list, which is entirely about what a person is like and not about where they sleep: not needing one particular arrangement in order to be all right. The room, the routine, the chair, the exact set-up without which the day cannot start. Most people have several.',
   'शांत वाला पाठ बाक़ी सूची से मेल खाता है, जो पूरी की पूरी इस बारे में है कि आदमी कैसा है, न कि वह कहाँ सोता है: ठीक रहने के लिए किसी एक ख़ास इंतज़ाम की ज़रूरत न होना। वह कमरा, वह दिनचर्या, वह कुर्सी, चीज़ों की वह ठीक जमावट जिसके बिना दिन शुरू ही नहीं होता। ज़्यादातर लोगों के पास कई हैं।',
   'Shaant wala padhna baaki list se mel khata hai, jo poori ki poori is baare mein hai ki aadmi kaisa hai, na ki woh kahan sota hai: theek rehne ke liye kisi ek khaas intezaam ki zaroorat na hona. Woh kamra, woh dinacharya, woh kursi, cheezon ki woh theek jamavat jiske bina din shuru hi nahi hota. Zyadatar logon ke paas kai hain.',
   'The one to test yourself against is the word next to it: silent. Together they describe somebody who does not need to answer — not somebody with nothing to say, somebody for whom being described wrongly is not an emergency. Almost nobody manages it, and the tell is how fast the reply gets written rather than whether it was fair.',
   'ख़ुद को जिस पर परखना चाहिए वह उसके बगल वाला शब्द है: मौनी। दोनों मिलकर उस व्यक्ति को बताते हैं जिसे जवाब देने की ज़रूरत नहीं पड़ती — ऐसा नहीं कि कहने को कुछ नहीं, बल्कि ऐसा कि ग़लत बताया जाना उसके लिए आपात स्थिति नहीं है। यह लगभग कोई नहीं कर पाता, और निशानी यह है कि जवाब कितनी जल्दी लिखा गया, यह नहीं कि वह जायज़ था।',
   'Khud ko jis par parakhna chahiye woh uske bagal wala shabd hai: mauni. Dono milkar us insaan ko batate hain jise jawab dene ki zaroorat nahi padti — aisa nahi ki kehne ko kuch nahi, balki aisa ki galat bataya jaana uske liye emergency nahi hai. Yeh lagbhag koi nahi kar paata, aur nishani yeh hai ki jawab kitni jaldi likha gaya, yeh nahi ki woh jaayaz tha.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 12;
