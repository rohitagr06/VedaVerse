-- =====================================================================
-- VedaVerse — database/seed_ch05.sql
-- =====================================================================
-- Chapter 5, Karma Sannyāsa Yoga. Eight verses. Second chapter of the
-- INTERMEDIATE track (2, 3, 4, 5, 6, 12, 13, 14, 16, 17, 18 in app.php).
--
--   5.2   both roads arrive; one of them is easier to walk
--   5.8   "I am not doing anything" — while seeing, hearing, walking
--   5.10  the lotus leaf, which water does not wet
--   5.12  peace from letting the fruit go, and what happens otherwise
--   5.18  the levelling verse                            [CARE]
--   5.21  the happiness that is not in the contact
--   5.22  pleasures from contact have a beginning and an end
--   5.23  able to hold the surge, here, before the end
--
-- 5.18 NEEDS CARE, AND A DIFFERENT KIND FROM 3.35 AND 16.4
--   Those two are verses that get turned into weapons. This one is the
--   opposite: it is the text's own flattest statement that hierarchy is
--   not what a wise person sees. It puts a learned brahmin, a cow, an
--   elephant, a dog and a śvapāka in one list and says the wise see the
--   same in all five.
--
--   Two things have to be true of the treatment.
--
--   1. THE WORD IS NOT SANITISED. Śvapāka is a real term, historically
--      used with contempt, for people placed outside the caste order.
--      Translating it as something neutral hides what the verse is
--      doing. The gloss says what the word meant and who it was used
--      against, and does not reproduce it as a slur in the running
--      translation.
--
--   2. IT IS NOT TURNED INTO A BOAST. The honest sentence is that this
--      text contains this verse AND contains 4.13, and that readers
--      have quoted whichever one suited them for a very long time.
--      Presenting 5.18 as proof that the tradition was always egalitarian
--      would be the same move as presenting 4.13 as proof of the
--      opposite, run in reverse. The explanation says so.
--
-- 5.22 HAS A SMALLER TRAP
--   "Pleasures born of contact are wombs of sorrow" reads as an
--   argument against enjoying anything. The verse's actual claim is
--   narrower — they start and they stop — and the explanation keeps it
--   there rather than letting it become a case for joylessness.
--
-- CONTENT RULES — unchanged
--   Original writing throughout. Sanskrit unaltered, numbering
--   untouched. No praise or criticism of any living politician, party
--   or movement. No communal framing, and 5.18 is a verse where that
--   rule and the honest treatment point the same way.
--
-- RUN AFTER seed_sample.sql. Re-runnable.
--
--     mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
--         < htdocs/database/seed_ch05.sql
--
-- global_order is 204 + verse_number: chapters 1 to 4 have 204 verses
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

  SELECT 2 AS verse_number, 206 AS global_order, 1 AS is_curated, 'gita-5-2' AS slug,
    'संन्यासः कर्मयोगश्च निःश्रेयसकरावुभौ।\nतयोस्तु कर्मसंन्यासात्कर्मयोगो विशिष्यते॥' AS sanskrit_devanagari,
    'sannyāsaḥ karma-yogaś ca niḥśreyasa-karāv ubhau\ntayos tu karma-sannyāsāt karma-yogo viśiṣyate' AS transliteration_iast,
    'sannyasah karma-yogash cha nihshreyasa-karav ubhau\ntayos tu karma-sannyasat karma-yogo vishishyate' AS transliteration_simple,
    'Both renunciation and the yoga of action lead to the highest good. But of the two, the yoga of action is superior to the renunciation of action.' AS translation_literal,
    'Both get you there. Walking away from the work, and staying in it while letting go of what it earns — either road arrives. Of the two, the second one is better.' AS translation_en,
    'दोनों पहुँचा देते हैं। काम छोड़कर चले जाना, और काम में रहते हुए उससे मिलने वाली चीज़ को छोड़ देना — दोनों रास्ते पहुँचते हैं। दोनों में दूसरा बेहतर है।' AS translation_hi,
    'Dono pahuncha dete hain. Kaam chhodkar chale jaana, aur kaam mein rehte hue usse milne wali cheez ko chhod dena — dono raste pahunchte hain. Dono mein doosra behtar hai.' AS translation_hinglish,
    'Arjuna asked which. The answer is both, and then a preference, which is a more honest shape than picking one.' AS summary_en,
    'अर्जुन ने पूछा कौन-सा। जवाब है दोनों, और फिर एक पसंद — और यह किसी एक को चुन लेने से ज़्यादा ईमानदार आकार है।' AS summary_hi,
    'Arjun ne poocha kaun sa. Jawab hai dono, aur phir ek pasand — aur yeh kisi ek ko chun lene se zyada imaandar aakar hai.' AS summary_hinglish,
    'beginner' AS difficulty,
    'Gita 5.2: both roads arrive, one is easier to walk' AS seo_title,
    'Arjuna asks whether to renounce work or do it. The Bhagavad Gita says both reach the same place, and then says which of the two it prefers.' AS seo_description,
    1 AS published

  UNION ALL SELECT 8, 212, 1, 'gita-5-8',
    'नैव किंचित्करोमीति युक्तो मन्येत तत्त्ववित्।\nपश्यञ्शृण्वन्स्पृशञ्जिघ्रन्नश्नन्गच्छन्स्वपञ्श्वसन्॥',
    'naiva kiñcit karomīti yukto manyeta tattva-vit\npaśyañ śṛṇvan spṛśañ jighrann aśnan gacchan svapañ śvasan',
    'naiva kinchit karomiti yukto manyeta tattva-vit\npashyan shrinvan sprishan jighrann ashnan gacchan svapan shvasan',
    'One who is joined and knows the truth of things would think "I do nothing at all" — while seeing, hearing, touching, smelling, eating, moving, sleeping, breathing.',
    'Somebody who has understood how this works thinks: I am not the one doing any of this. And meanwhile they are seeing, hearing, touching, smelling, eating, walking, sleeping, breathing. The list is long on purpose.',
    'जिसने समझ लिया कि यह चलता कैसे है, वह सोचता है: यह सब मैं नहीं कर रहा। और इस बीच वह देख रहा है, सुन रहा है, छू रहा है, सूँघ रहा है, खा रहा है, चल रहा है, सो रहा है, साँस ले रहा है। सूची जानबूझकर लंबी है।',
    'Jisne samajh liya ki yeh chalta kaise hai, woh sochta hai: yeh sab main nahi kar raha. Aur is beech woh dekh raha hai, sun raha hai, chhoo raha hai, soongh raha hai, kha raha hai, chal raha hai, so raha hai, saans le raha hai. List jaanboojhkar lambi hai.',
    'Eight ordinary verbs in a row, and the claim is being made across all of them at once.',
    'लगातार आठ साधारण क्रियाएँ, और दावा उन सब पर एक साथ किया जा रहा है।',
    'Lagatar aath sadharan kriyayein, aur dawa un sab par ek saath kiya ja raha hai.',
    'intermediate',
    'Gita 5.8: I am not doing any of this, while doing all of it',
    'The Bhagavad Gita lists eight ordinary actions — seeing, hearing, eating, breathing — and says the one who understands thinks they are doing none of them.',
    1

  UNION ALL SELECT 10, 214, 1, 'gita-5-10',
    'ब्रह्मण्याधाय कर्माणि सङ्गं त्यक्त्वा करोति यः।\nलिप्यते न स पापेन पद्मपत्रमिवाम्भसा॥',
    'brahmaṇy ādhāya karmāṇi saṅgaṁ tyaktvā karoti yaḥ\nlipyate na sa pāpena padma-patram ivāmbhasā',
    'brahmany adhaya karmani sangam tyaktva karoti yah\nlipyate na sa papena padma-patram ivambhasa',
    'One who acts having placed actions in Brahman, having abandoned attachment, is not stained by wrong, as a lotus leaf is not by water.',
    'Somebody who does the work with the holding-on let go of is not stained by it — the way a lotus leaf sits in water all day and comes out dry.',
    'जो काम पकड़ छोड़कर करता है, उस पर दाग़ नहीं लगता — जैसे कमल का पत्ता दिन भर पानी में रहकर सूखा निकलता है।',
    'Jo kaam pakad chhodkar karta hai, us par daag nahi lagta — jaise kamal ka patta din bhar paani mein rehkar sookha nikalta hai.',
    'The leaf is not avoiding the water. It is in it the whole time.',
    'पत्ता पानी से बच नहीं रहा। वह पूरे समय उसी में है।',
    'Patta paani se bach nahi raha. Woh poore samay usi mein hai.',
    'beginner',
    'Gita 5.10: the lotus leaf sits in the water all day',
    'The Bhagavad Gita compares acting without clinging to a lotus leaf in water. The point of the image is that the leaf is not avoiding the water.',
    1

  UNION ALL SELECT 12, 216, 1, 'gita-5-12',
    'युक्तः कर्मफलं त्यक्त्वा शान्तिमाप्नोति नैष्ठिकीम्।\nअयुक्तः कामकारेण फले सक्तो निबध्यते॥',
    'yuktaḥ karma-phalaṁ tyaktvā śāntim āpnoti naiṣṭhikīm\nayuktaḥ kāma-kāreṇa phale sakto nibadhyate',
    'yuktah karma-phalam tyaktva shantim apnoti naishthikim\nayuktah kama-karena phale sakto nibadhyate',
    'The one who is joined, having given up the fruit of action, attains settled peace. The one not joined, driven by desire, attached to the fruit, is bound.',
    'The one who lets the result go gets a peace that stays. The one who does not is pulled along by wanting, sticks to the result, and is tied to it.',
    'जो नतीजा छोड़ देता है उसे ऐसी शांति मिलती है जो टिकती है। जो नहीं छोड़ता, वह चाह के खींचे चलता है, नतीजे से चिपकता है, और उससे बँध जाता है।',
    'Jo nateeja chhod deta hai use aisi shanti milti hai jo tikti hai. Jo nahi chhodta, woh chaah ke kheenche chalta hai, nateeje se chipakta hai, aur usse bandh jaata hai.',
    'Two people doing the same work. The difference is not in the work.',
    'दो लोग वही काम कर रहे हैं। फ़र्क़ काम में नहीं है।',
    'Do log wahi kaam kar rahe hain. Farq kaam mein nahi hai.',
    'beginner',
    'Gita 5.12: the difference is not in the work',
    'The Bhagavad Gita describes two people doing the same work: one lets the result go and is at peace, one holds on and is tied to it.',
    1

  UNION ALL SELECT 18, 222, 1, 'gita-5-18',
    'विद्याविनयसम्पन्ने ब्राह्मणे गवि हस्तिनि।\nशुनि चैव श्वपाके च पण्डिताः समदर्शिनः॥',
    'vidyā-vinaya-sampanne brāhmaṇe gavi hastini\nśuni caiva śva-pāke ca paṇḍitāḥ sama-darśinaḥ',
    'vidya-vinaya-sampanne brahmane gavi hastini\nshuni chaiva shva-pake cha panditah sama-darshinah',
    'In a brahmin endowed with learning and humility, in a cow, in an elephant, and in a dog and in one who cooks dog — the wise are seers of the same.',
    'A scholar with learning and good manners. A cow. An elephant. A dog. And a person from the group this society placed lowest of all. Five in one list, and the verse says those who actually see, see the same thing in every one of them.',
    'विद्या और विनय वाला एक विद्वान। एक गाय। एक हाथी। एक कुत्ता। और उस समूह का एक व्यक्ति जिसे उस समाज ने सबसे नीचे रखा था। एक ही सूची में पाँच, और श्लोक कहता है कि जो सचमुच देखते हैं वे इन सबमें एक ही चीज़ देखते हैं।',
    'Vidya aur vinay wala ek vidwan. Ek gaay. Ek haathi. Ek kutta. Aur us samuh ka ek insaan jise us samaaj ne sabse neeche rakha tha. Ek hi list mein paanch, aur shloka kehta hai ki jo sach mein dekhte hain woh in sabme ek hi cheez dekhte hain.',
    'The most respected person and the most despised one, put in the same sentence on purpose.',
    'सबसे सम्मानित व्यक्ति और सबसे तिरस्कृत, जानबूझकर एक ही वाक्य में रखे गए।',
    'Sabse sammanit insaan aur sabse tiraskrit, jaanboojhkar ek hi vakya mein rakhe gaye.',
    'intermediate',
    'Gita 5.18: the most respected and the most despised, in one sentence',
    'The Bhagavad Gita lists a learned brahmin, a cow, an elephant, a dog and an outcaste, and says those who see clearly see the same in all of them.',
    1

  UNION ALL SELECT 21, 225, 1, 'gita-5-21',
    'बाह्यस्पर्शेष्वसक्तात्मा विन्दत्यात्मनि यत्सुखम्।\nस ब्रह्मयोगयुक्तात्मा सुखमक्षयमश्नुते॥',
    'bāhya-sparśeṣv asaktātmā vindaty ātmani yat sukham\nsa brahma-yoga-yuktātmā sukham akṣayam aśnute',
    'bahya-sparsheshv asaktatma vindaty atmani yat sukham\nsa brahma-yoga-yuktatma sukham akshayam ashnute',
    'One whose self is unattached to external contacts finds the happiness that is in the self. That one, joined in union, enjoys imperishable happiness.',
    'Somebody not stuck to what is coming in from outside finds the kind of happiness that was already in there. That one gets a happiness that does not run out.',
    'जो बाहर से आ रही चीज़ों से चिपका नहीं है, उसे वह सुख मिलता है जो पहले से भीतर था। उसे ऐसा सुख मिलता है जो चुकता नहीं।',
    'Jo bahar se aa rahi cheezon se chipka nahi hai, use woh sukh milta hai jo pehle se bheetar tha. Use aisa sukh milta hai jo chukta nahi.',
    'Not a different happiness. The one that was there before anything arrived.',
    'कोई अलग सुख नहीं। वही जो कुछ आने से पहले भी था।',
    'Koi alag sukh nahi. Wahi jo kuch aane se pehle bhi tha.',
    'intermediate',
    'Gita 5.21: the happiness that was already there',
    'The Bhagavad Gita says somebody unattached to what arrives from outside finds a happiness inside that does not run out.',
    1

  UNION ALL SELECT 22, 226, 1, 'gita-5-22',
    'ये हि संस्पर्शजा भोगा दुःखयोनय एव ते।\nआद्यन्तवन्तः कौन्तेय न तेषु रमते बुधः॥',
    'ye hi saṁsparśa-jā bhogā duḥkha-yonaya eva te\nādy-antavantaḥ kaunteya na teṣu ramate budhaḥ',
    'ye hi samsparsha-ja bhoga duhkha-yonaya eva te\nady-antavantah kaunteya na teshu ramate budhah',
    'The enjoyments born of contact are indeed wombs of sorrow. They have a beginning and an end, Kaunteya; the wise one does not take delight in them.',
    'The good things that come from contact with something are also where the sorrow comes from. They start and they stop. Somebody who has understood does not set up house in them.',
    'किसी चीज़ से संपर्क से जो अच्छा मिलता है, दुख भी वहीं से आता है। वे शुरू होते हैं और ख़त्म होते हैं। जिसने समझ लिया है वह उनमें घर नहीं बसाता।',
    'Kisi cheez se sampark se jo achha milta hai, dukh bhi wahin se aata hai. Woh shuru hote hain aur khatam hote hain. Jisne samajh liya hai woh unme ghar nahi basata.',
    'Not "do not enjoy things". Do not build the house there, because it has an end date.',
    '"चीज़ों का आनंद मत लीजिए" नहीं। वहाँ घर मत बनाइए, क्योंकि उसकी तारीख़ तय है।',
    '"Cheezon ka anand mat lo" nahi. Wahan ghar mat banao, kyunki uski tareekh tay hai.',
    'intermediate',
    'Gita 5.22: they start and they stop',
    'The Bhagavad Gita says pleasures from contact are also where sorrow comes from, because they have a beginning and an end. Not an argument against enjoying them.',
    1

  UNION ALL SELECT 23, 227, 1, 'gita-5-23',
    'शक्नोतीहैव यः सोढुं प्राक्शरीरविमोक्षणात्।\nकामक्रोधोद्भवं वेगं स युक्तः स सुखी नरः॥',
    'śaknotīhaiva yaḥ soḍhuṁ prāk śarīra-vimokṣaṇāt\nkāma-krodhodbhavaṁ vegaṁ sa yuktaḥ sa sukhī naraḥ',
    'shaknotihaiva yah sodhum prak sharira-vimokshanat\nkama-krodhodbhavam vegam sa yuktah sa sukhi narah',
    'One who is able, here itself, before release from the body, to withstand the surge arising from desire and anger — that one is joined, that one is a happy person.',
    'Somebody who can hold the surge that comes up out of wanting and anger — here, in this life, not later — that person is joined up, and that person is happy.',
    'जो चाह और गुस्से से उठने वाले उस उछाल को थाम सकता है — यहीं, इसी जीवन में, बाद में नहीं — वह जुड़ा हुआ है, और वही सुखी है।',
    'Jo chaah aur gusse se uthne wale us ubhaar ko thaam sakta hai — yahin, isi jeevan mein, baad mein nahi — woh juda hua hai, aur wahi sukhi hai.',
    'Vega is a surge, not a state. The verse asks you to outlast a wave, not to become a different person.',
    'वेग उछाल है, कोई अवस्था नहीं। श्लोक एक लहर को झेल जाने को कहता है, कोई और इंसान बन जाने को नहीं।',
    'Veg ubhaar hai, koi avastha nahi. Shloka ek lehar ko jhel jaane ko kehta hai, koi aur insaan ban jaane ko nahi.',
    'beginner',
    'Gita 5.23: outlast the surge, here, not later',
    'The Bhagavad Gita asks whether you can withstand the surge that comes from wanting and anger — in this life. A surge is a wave, not a permanent state.',
    1

) AS v
JOIN chapters c ON c.chapter_number = 5;

-- =====================================================================
-- EXPLANATIONS
-- =====================================================================
-- Every verse gets a beginner depth, because the default reader is who
-- lands on the page. 5.18 carries the two sentences the header
-- describes — the word is not sanitised, and the verse is not turned
-- into a boast — and smoke-test.sh asserts both on the default render.
-- =====================================================================

DELETE ve FROM verse_explanations ve JOIN verses v ON v.id = ve.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 5;

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 2 AS vn, 'beginner' AS level,
   'Arjuna opens the chapter by pointing out that he has now been told two different things — give up action, and do action without attachment — and asking, reasonably, which one it is. This is the answer.' AS h_en,
   'अर्जुन अध्याय की शुरुआत यह कहकर करते हैं कि उन्हें अब तक दो अलग बातें बताई गई हैं — कर्म छोड़ दो, और बिना आसक्ति के कर्म करो — और वाजिब तौर पर पूछते हैं कि इनमें से कौन-सी। यही जवाब है।' AS h_hi,
   'Arjun chapter ki shuruaat yeh kehkar karte hain ki unhe ab tak do alag baatein batayi gayi hain — karm chhod do, aur bina aasakti ke karm karo — aur waajib taur par poochte hain ki inme se kaun si. Yahi jawab hai.' AS h_hing,
   'Both reach the highest good, and then one is preferred. That is a specific shape: not "you have misunderstood, there is only one road", and not "they are identical, choose freely". Two roads, both real, one easier for most people to actually walk.' AS p_en,
   'दोनों परम कल्याण तक पहुँचाते हैं, और फिर एक को बेहतर बताया जाता है। यह एक ख़ास आकार है: न "तुमने ग़लत समझा, रास्ता एक ही है", और न "दोनों एक जैसे हैं, जो चाहो चुनो"। दो रास्ते, दोनों असली, और उनमें एक ज़्यादातर लोगों के लिए चलने में आसान।' AS p_hi,
   'Dono param kalyan tak pahunchate hain, aur phir ek ko behtar bataya jaata hai. Yeh ek khaas aakar hai: na "tumne galat samjha, rasta ek hi hai", aur na "dono ek jaise hain, jo chaho chuno". Do raste, dono asli, aur unme ek zyadatar logon ke liye chalne mein aasan.' AS p_hing,
   'The reason for the preference arrives in the verses just after, and it is practical rather than moral: walking away is harder to do properly than it looks, and most people who try it take the thing they were walking away from with them. Chapter 6 will say the same about a mind that changes location. The preference is about what actually works, and the verse is honest enough to concede that the other road is a road.' AS m_en,
   'इस पसंद की वजह इसके ठीक बाद के श्लोकों में आती है, और वह नैतिक नहीं, व्यावहारिक है: छोड़कर चले जाना ठीक से करना जितना दिखता है उससे कठिन है, और जो लोग यह करते हैं उनमें से ज़्यादातर उसी चीज़ को साथ ले जाते हैं जिससे वे दूर जा रहे थे। छठा अध्याय जगह बदल लेने वाले मन के बारे में यही कहेगा। पसंद इस बारे में है कि असल में चलता क्या है, और श्लोक इतना ईमानदार है कि दूसरे रास्ते को भी रास्ता मान लेता है।' AS m_hi,
   'Is pasand ki wajah iske theek baad ke shlokon mein aati hai, aur woh naitik nahi, vyavharik hai: chhodkar chale jaana theek se karna jitna dikhta hai usse mushkil hai, aur jo log yeh karte hain unme se zyadatar usi cheez ko saath le jaate hain jisse woh door ja rahe the. Chhatha chapter jagah badal lene wale man ke baare mein yahi kahega. Pasand is baare mein hai ki asal mein chalta kya hai, aur shloka itna imaandar hai ki doosre raste ko bhi rasta maan leta hai.' AS m_hing

  UNION ALL SELECT 8, 'beginner',
   'The chapter is explaining what "not acting" actually means for somebody who is still very much alive and moving about. This verse and the one after it are the explanation, and they work by listing.' AS h_en,
   'अध्याय समझा रहा है कि "कर्म न करना" उस व्यक्ति के लिए असल में क्या है जो पूरी तरह ज़िंदा है और चल-फिर रहा है। यह श्लोक और इसके बाद वाला वही समझाइश हैं, और वे सूची बनाकर काम करते हैं।' AS h_hi,
   'Chapter samjha raha hai ki "karm na karna" us insaan ke liye asal mein kya hai jo poori tarah zinda hai aur chal-phir raha hai. Yeh shloka aur iske baad wala wahi samjhaish hain, aur woh list banakar kaam karte hain.' AS h_hing,
   'Eight verbs in a row: seeing, hearing, touching, smelling, eating, moving, sleeping, breathing. Read the list slowly, because the length is the argument. None of these is a special spiritual activity. They are what a body does all day, and the claim is being made across all of them at once.' AS p_en,
   'लगातार आठ क्रियाएँ: देखना, सुनना, छूना, सूँघना, खाना, चलना, सोना, साँस लेना। सूची धीरे पढ़िए, क्योंकि लंबाई ही दलील है। इनमें से कोई ख़ास आध्यात्मिक काम नहीं है। यह वही है जो शरीर दिन भर करता है, और दावा इन सब पर एक साथ किया जा रहा है।' AS p_hi,
   'Lagatar aath kriyayein: dekhna, sunna, chhoona, soonghna, khana, chalna, sona, saans lena. List dheere padho, kyunki lambai hi dalil hai. Inme se koi khaas adhyatmik kaam nahi hai. Yeh wahi hai jo sharir din bhar karta hai, aur dawa in sab par ek saath kiya ja raha hai.' AS p_hing,
   'Take breathing, which is on the list and is the easiest to check. You are doing it now and you did not start it and will not decide when to stop. Whatever you think you are, breathing is happening in the same place. The verse extends that observation across the other seven, and it is worth noticing that it does not ask you to stop doing any of them.' AS m_en,
   'साँस लीजिए — यह सूची में है और जाँचने में सबसे आसान। आप अभी ले रहे हैं और आपने शुरू नहीं की और आप तय नहीं करेंगे कि कब रुके। आप ख़ुद को जो भी मानते हों, साँस उसी जगह चल रही है। श्लोक इसी observation को बाक़ी सातों पर बढ़ा देता है, और ध्यान देने लायक है कि वह इनमें से किसी को बंद करने को नहीं कहता।' AS m_hi,
   'Saans lo — yeh list mein hai aur jaanchne mein sabse asaan. Tum abhi le rahe ho aur tumne shuru nahi ki aur tum tay nahi karoge ki kab ruke. Tum khud ko jo bhi maante ho, saans usi jagah chal rahi hai. Shloka isi observation ko baaki saaton par badha deta hai, aur dhyan dene layak hai ki woh inme se kisi ko band karne ko nahi kehta.' AS m_hing

  UNION ALL SELECT 10, 'beginner',
   'The chapter''s central image, and one of about four in the whole book that people remember without being able to say which chapter it came from.' AS h_en,
   'अध्याय की केंद्रीय तस्वीर, और पूरी किताब की उन चार-एक तस्वीरों में से एक जो लोगों को याद रहती हैं बिना यह बता पाए कि किस अध्याय से आईं।' AS h_hi,
   'Chapter ki kendriya tasveer, aur poori kitaab ki un chaar-ek tasveeron mein se ek jo logon ko yaad rehti hain bina yeh bata paaye ki kis chapter se aayin.' AS h_hing,
   'A lotus leaf sits on water. Water runs off it and the leaf comes out dry. The comparison is to somebody who does the work with the clinging let go of, and the thing worth holding on to is what the leaf is not doing: it is not on the bank, it is not covered, it is not avoiding anything.' AS p_en,
   'कमल का पत्ता पानी पर बैठा है। पानी उस पर से बह जाता है और पत्ता सूखा निकलता है। तुलना उस व्यक्ति से है जो पकड़ छोड़कर काम करता है, और थामने लायक बात यह है कि पत्ता क्या नहीं कर रहा: वह किनारे पर नहीं है, वह ढका हुआ नहीं है, वह किसी चीज़ से बच नहीं रहा।' AS p_hi,
   'Kamal ka patta paani par baitha hai. Paani us par se beh jaata hai aur patta sookha nikalta hai. Tulna us insaan se hai jo pakad chhodkar kaam karta hai, aur thaamne layak baat yeh hai ki patta kya nahi kar raha: woh kinare par nahi hai, woh dhaka hua nahi hai, woh kisi cheez se bach nahi raha.' AS p_hing,
   'Most images for staying unaffected are images of distance — a wall, a shell, standing back. This one is not. The leaf is in the water for the whole of its life and the water is genuinely wet. What the image describes is a surface property rather than a location, which is why it fits a person who has a demanding job and a family rather than one who has left.' AS m_en,
   'अप्रभावित रहने की ज़्यादातर तस्वीरें दूरी की तस्वीरें होती हैं — दीवार, खोल, पीछे हट जाना। यह वैसी नहीं है। पत्ता जीवन भर पानी में ही है और पानी सचमुच गीला है। तस्वीर किसी जगह का नहीं, एक सतह का गुण बताती है — और इसीलिए यह उस व्यक्ति पर बैठती है जिसके पास कठिन नौकरी और परिवार है, उस पर नहीं जो छोड़कर चला गया।' AS m_hi,
   'Aprabhavit rehne ki zyadatar tasveerein doori ki tasveerein hoti hain — deewar, khol, peechhe hat jaana. Yeh waisi nahi hai. Patta jeevan bhar paani mein hi hai aur paani sach mein geela hai. Tasveer kisi jagah ka nahi, ek satah ka gun batati hai — aur isiliye yeh us insaan par baithti hai jiske paas mushkil naukri aur parivar hai, us par nahi jo chhodkar chala gaya.' AS m_hing

  UNION ALL SELECT 12, 'beginner',
   'The chapter states the practical difference plainly, and does it by describing two people rather than one rule.',
   'अध्याय व्यावहारिक फ़र्क़ सीधे बताता है, और एक नियम की जगह दो लोगों का वर्णन करके बताता है।',
   'Chapter vyavharik farq seedhe batata hai, aur ek niyam ki jagah do logon ka varnan karke batata hai.',
   'One lets the fruit go and gets a peace described as naiṣṭhikī — settled, of the kind that stays. The other is driven along by wanting, sticks to the result and is tied to it. Both are working. The verse locates the whole difference outside the work.',
   'एक फल छोड़ देता है और उसे ऐसी शांति मिलती है जिसे नैष्ठिकी कहा गया है — जमी हुई, टिकने वाली। दूसरा चाह के खींचे चलता है, नतीजे से चिपकता है और उससे बँध जाता है। दोनों काम कर रहे हैं। श्लोक पूरा फ़र्क़ काम के बाहर रखता है।',
   'Ek phal chhod deta hai aur use aisi shanti milti hai jise naishthiki kaha gaya hai — jami hui, tikne wali. Doosra chaah ke kheenche chalta hai, nateeje se chipakta hai aur usse bandh jaata hai. Dono kaam kar rahe hain. Shloka poora farq kaam ke bahar rakhta hai.',
   'The word for what happens to the second person is nibadhyate — is bound, tied. Not punished, not failing, not doing worse work. Anybody who has watched somebody talented become unable to leave a job they no longer want, because of what leaving would mean about the last nine years, has seen the specific thing this word describes.',
   'दूसरे व्यक्ति के साथ जो होता है उसका शब्द है निबध्यते — बँध जाता है, बाँध दिया जाता है। सज़ा नहीं मिलती, वह नाकाम नहीं होता, वह ख़राब काम भी नहीं करता। जिसने किसी प्रतिभाशाली व्यक्ति को ऐसी नौकरी छोड़ने में असमर्थ होते देखा है जो अब उसे चाहिए ही नहीं — इसलिए कि छोड़ने का मतलब पिछले नौ साल के बारे में क्या होगा — उसने ठीक वही चीज़ देखी है जो यह शब्द बताता है।',
   'Doosre insaan ke saath jo hota hai uska shabd hai nibadhyate — bandh jaata hai, baandh diya jaata hai. Saza nahi milti, woh nakaam nahi hota, woh kharab kaam bhi nahi karta. Jisne kisi pratibhashali insaan ko aisi naukri chhodne mein asamarth hote dekha hai jo ab use chahiye hi nahi — isliye ki chhodne ka matlab pichhle nau saal ke baare mein kya hoga — usne theek wahi cheez dekhi hai jo yeh shabd batata hai.'

  UNION ALL SELECT 18, 'beginner',
   'The chapter has been describing what somebody who has understood actually sees. This verse gives the test, and it gives it as a list of five.',
   'अध्याय बता रहा है कि जिसने समझ लिया है वह असल में देखता क्या है। यह श्लोक कसौटी देता है, और पाँच की सूची के रूप में देता है।',
   'Chapter bata raha hai ki jisne samajh liya hai woh asal mein dekhta kya hai. Yeh shloka kasauti deta hai, aur paanch ki list ke roop mein deta hai.',
   'A scholar with learning and humility. A cow. An elephant. A dog. And śvapāka — a word for people that society placed outside its order entirely, used with contempt. The wise, it says, see the same in all five. Notice the order: the list starts at the top of the hierarchy and walks all the way down it without a break.',
   'विद्या और विनय वाला एक विद्वान। एक गाय। एक हाथी। एक कुत्ता। और श्वपाक — उन लोगों के लिए एक शब्द जिन्हें समाज ने अपनी व्यवस्था से पूरी तरह बाहर रखा था, और जो तिरस्कार के साथ इस्तेमाल होता था। श्लोक कहता है कि ज्ञानी पाँचों में एक ही देखते हैं। क्रम पर ध्यान दीजिए: सूची पदानुक्रम के सबसे ऊपर से शुरू होकर बिना रुके पूरे नीचे तक उतरती है।',
   'Vidya aur vinay wala ek vidwan. Ek gaay. Ek haathi. Ek kutta. Aur shvapaka — un logon ke liye ek shabd jinhe samaaj ne apni vyavastha se poori tarah bahar rakha tha, aur jo tiraskar ke saath istemaal hota tha. Shloka kehta hai ki gyani paanchon mein ek hi dekhte hain. Kram par dhyan do: list padanukram ke sabse upar se shuru hokar bina ruke poore neeche tak utarti hai.',
   'Two things have to be said about this verse and they pull in different directions. The first: the word is not softened here, because softening it hides what the verse is doing. It was a term of contempt for real people, and the verse puts the person it names in the same sentence as the most respected figure in that society and declines to rank them. That is not a small thing to have written down.

The second: this is also the book that contains 4.13, and readers have quoted whichever of the two suited them for a very long time. Presenting 5.18 as proof that the tradition was always egalitarian is the same move as presenting 4.13 as proof of the opposite, run backwards. Both verses are in the text. This one is the one that levels, and what it is worth is not that it settles the argument but that it exists and says what it says.',
   'इस श्लोक के बारे में दो बातें कहनी होंगी और वे अलग दिशाओं में खींचती हैं। पहली: यहाँ शब्द नरम नहीं किया गया, क्योंकि नरम करने से छिप जाता है कि श्लोक कर क्या रहा है। वह असली लोगों के लिए तिरस्कार का शब्द था, और श्लोक जिस व्यक्ति का वह नाम लेता है उसे उस समाज की सबसे सम्मानित हस्ती के साथ एक ही वाक्य में रखता है और दोनों में क्रम लगाने से इनकार कर देता है। यह लिख दिया जाना छोटी बात नहीं है।

दूसरी: यह वही किताब है जिसमें 4.13 भी है, और पाठक बहुत लंबे समय से इनमें से वही उद्धृत करते आए हैं जो उन्हें सुविधाजनक लगा। 5.18 को इस बात का सबूत बनाकर पेश करना कि परंपरा हमेशा समतावादी थी, वही चाल है जो 4.13 को उल्टे का सबूत बनाकर पेश करना है — बस उल्टी दिशा में। दोनों श्लोक ग्रंथ में हैं। यह वह है जो बराबर करता है, और इसकी क़ीमत यह नहीं कि यह बहस ख़त्म कर देता है, बल्कि यह कि यह मौजूद है और जो कहता है वह कहता है।',
   'Is shloka ke baare mein do baatein kehni hongi aur woh alag dishaon mein kheenchti hain. Pehli: yahan shabd naram nahi kiya gaya, kyunki naram karne se chhip jaata hai ki shloka kar kya raha hai. Woh asli logon ke liye tiraskar ka shabd tha, aur shloka jis insaan ka woh naam leta hai use us samaaj ki sabse sammanit hasti ke saath ek hi vakya mein rakhta hai aur dono mein kram lagane se inkaar kar deta hai. Yeh likh diya jaana chhoti baat nahi hai.

Doosri: yeh wahi kitaab hai jisme 4.13 bhi hai, aur padhne wale bahut lambe samay se inme se wahi quote karte aaye hain jo unhe suvidhajanak laga. 5.18 ko is baat ka saboot banakar pesh karna ki parampara hamesha samtavadi thi, wahi chaal hai jo 4.13 ko ulte ka saboot banakar pesh karna hai — bas ulti disha mein. Dono shloka granth mein hain. Yeh woh hai jo barabar karta hai, aur iski keemat yeh nahi ki yeh behes khatam kar deta hai, balki yeh ki yeh maujood hai aur jo kehta hai woh kehta hai.'

  UNION ALL SELECT 21, 'beginner',
   'The chapter turns to where satisfaction actually comes from, and the answer is given as a location rather than as an amount.',
   'अध्याय इस तरफ़ मुड़ता है कि संतोष असल में आता कहाँ से है, और जवाब मात्रा में नहीं, जगह में दिया जाता है।',
   'Chapter is taraf mudta hai ki santosh asal mein aata kahan se hai, aur jawab maatra mein nahi, jagah mein diya jaata hai.',
   'Somebody not stuck to bāhya-sparśa — outside contacts, the things that arrive — finds a happiness that is described as being in the self. And then a second claim: that one does not run out. The two halves are separate. The first is about where it is; the second is about how it behaves.',
   'जो बाह्य-स्पर्श से चिपका नहीं है — बाहर के संपर्क, वे चीज़ें जो आती हैं — उसे ऐसा सुख मिलता है जिसे आत्मा में बताया गया है। और फिर दूसरा दावा: वह चुकता नहीं। दोनों आधे अलग हैं। पहला बताता है कि वह कहाँ है; दूसरा बताता है कि वह बरतता कैसे है।',
   'Jo bahya-sparsha se chipka nahi hai — bahar ke sampark, woh cheezein jo aati hain — use aisa sukh milta hai jise atma mein bataya gaya hai. Aur phir doosra dawa: woh chukta nahi. Dono aadhe alag hain. Pehla batata hai ki woh kahan hai; doosra batata hai ki woh bartta kaise hai.',
   'The everyday version of this is available to anybody who has had a good day that nothing in particular caused. Most people have had a few and cannot reproduce them, because they go looking in the arrivals — the meal, the message, the news — and the day was not made of those. The verse is not saying the arrivals are worthless. It is saying they are not where that particular thing lives.',
   'इसका रोज़मर्रा वाला रूप उस किसी के लिए भी उपलब्ध है जिसका कोई दिन अच्छा गया हो बिना किसी ख़ास वजह के। ज़्यादातर लोगों के ऐसे कुछ दिन रहे हैं और वे उन्हें दोहरा नहीं पाते, क्योंकि वे आने वाली चीज़ों में ढूँढ़ते हैं — वह खाना, वह संदेश, वह ख़बर — और वह दिन उनसे बना ही नहीं था। श्लोक यह नहीं कह रहा कि आने वाली चीज़ें बेकार हैं। वह कह रहा है कि वह ख़ास चीज़ वहाँ रहती नहीं।',
   'Iska rozmarra wala roop us kisi ke liye bhi uplabdh hai jiska koi din achha gaya ho bina kisi khaas wajah ke. Zyadatar logon ke aise kuch din rahe hain aur woh unhe dohra nahi paate, kyunki woh aane wali cheezon mein dhoondhte hain — woh khana, woh message, woh khabar — aur woh din unse bana hi nahi tha. Shloka yeh nahi keh raha ki aane wali cheezein bekaar hain. Woh keh raha hai ki woh khaas cheez wahan rehti nahi.'

  UNION ALL SELECT 22, 'beginner',
   'This follows the previous verse and gives the reason. It is the harshest-sounding line in the chapter and the one most easily misread as an argument for joylessness.',
   'यह पिछले श्लोक के बाद आता है और वजह देता है। यह अध्याय की सबसे कठोर लगने वाली पंक्ति है और वही जिसे सबसे आसानी से आनंदहीनता की दलील समझ लिया जाता है।',
   'Yeh pichhle shloka ke baad aata hai aur wajah deta hai. Yeh chapter ki sabse kathor lagne wali line hai aur wahi jise sabse aasani se anandheenta ki dalil samajh liya jaata hai.',
   'The pleasures that come from contact are duḥkha-yoni — the source that sorrow also comes out of. Then the reason, and the reason is the whole verse: ādi-antavantaḥ, they have a beginning and an end. Nothing here says they are bad. It says they are temporary, and that the sorrow comes from the same place because it is the ending of the same thing.',
   'संपर्क से आने वाले सुख दुःख-योनि हैं — वही स्रोत जहाँ से दुख भी निकलता है। फिर वजह, और वजह ही पूरा श्लोक है: आद्यन्तवन्तः, उनका आरंभ है और अंत है। यहाँ कुछ भी यह नहीं कहता कि वे बुरे हैं। यह कहता है कि वे अस्थायी हैं, और दुख उसी जगह से आता है क्योंकि वह उसी चीज़ का ख़त्म होना है।',
   'Sampark se aane wale sukh duhkha-yoni hain — wahi srot jahan se dukh bhi nikalta hai. Phir wajah, aur wajah hi poora shloka hai: adi-antavantah, unka aarambh hai aur ant hai. Yahan kuch bhi yeh nahi kehta ki woh bure hain. Yeh kehta hai ki woh asthayi hain, aur dukh usi jagah se aata hai kyunki woh usi cheez ka khatam hona hai.',
   'The last word settles what the verse is asking for: na teṣu ramate — the wise one does not take up residence in them. Not does not touch them, not does not enjoy them. Does not move in. Anybody who has organised a life around something with an end date — a role, a body, a person''s attention — knows the difference between enjoying a thing and building on it, and knows which of the two the ending takes down.',
   'आख़िरी शब्द तय कर देता है कि श्लोक माँग क्या रहा है: न तेषु रमते — ज्ञानी उनमें बसता नहीं। छूता नहीं, ऐसा नहीं। आनंद नहीं लेता, ऐसा भी नहीं। घर नहीं बसाता। जिसने भी अपनी ज़िंदगी किसी ऐसी चीज़ के इर्द-गिर्द जमाई है जिसकी तारीख़ तय है — कोई पद, कोई शरीर, किसी का ध्यान — वह जानता है कि किसी चीज़ का आनंद लेने और उस पर इमारत खड़ी करने में फ़र्क़ है, और यह भी कि अंत इन दोनों में से किसे गिराता है।',
   'Aakhiri shabd tay kar deta hai ki shloka maang kya raha hai: na teshu ramate — gyani unme basta nahi. Chhoota nahi, aisa nahi. Anand nahi leta, aisa bhi nahi. Ghar nahi basata. Jisne bhi apni zindagi kisi aisi cheez ke ird-gird jamayi hai jiski tareekh tay hai — koi pad, koi sharir, kisi ka dhyan — woh jaanta hai ki kisi cheez ka anand lene aur us par imaarat khadi karne mein farq hai, aur yeh bhi ki ant in dono mein se kise girata hai.'

  UNION ALL SELECT 23, 'beginner',
   'The chapter''s practical close. After several verses about seeing and understanding, this one describes something a person does, in a moment, with a timestamp on it.',
   'अध्याय का व्यावहारिक अंत। देखने और समझने के कई श्लोकों के बाद, यह वह चीज़ बताता है जो कोई व्यक्ति करता है, एक क्षण में, और जिस पर समय की मुहर लगी है।',
   'Chapter ka vyavharik ant. Dekhne aur samajhne ke kai shlokon ke baad, yeh woh cheez batata hai jo koi insaan karta hai, ek pal mein, aur jis par samay ki muhar lagi hai.',
   'The word is vega — a surge, a rush, the thing that comes up fast. Able to withstand the surge that arises from wanting and anger. And then the timestamp: iha eva, here itself, before the body is let go. Not later, not in some other arrangement. In this life, in the surge you had on Tuesday.',
   'शब्द है वेग — उछाल, रफ़्तार, वह चीज़ जो तेज़ी से उठती है। चाह और गुस्से से उठने वाले उस वेग को थाम पाना। और फिर समय की मुहर: इह एव, यहीं, शरीर छूटने से पहले। बाद में नहीं, किसी और इंतज़ाम में नहीं। इसी जीवन में, उसी वेग में जो मंगलवार को उठा था।',
   'Shabd hai veg — ubhaar, raftar, woh cheez jo tezi se uthti hai. Chaah aur gusse se uthne wale us veg ko thaam paana. Aur phir samay ki muhar: iha eva, yahin, sharir chhootne se pehle. Baad mein nahi, kisi aur intezaam mein nahi. Isi jeevan mein, usi veg mein jo Tuesday ko utha tha.',
   'Calling it a surge rather than a state is the useful part, because a surge has a shape: it comes up, it peaks, and if nothing is done it goes down again. What the verse asks for is outlasting one, which is a much smaller request than becoming a person who does not have them. Nobody has to stop having surges to do what this verse describes. They have to still be there at the end of one.',
   'इसे अवस्था नहीं, वेग कहना ही काम की बात है, क्योंकि वेग का एक आकार होता है: वह उठता है, चरम पर पहुँचता है, और कुछ न किया जाए तो फिर उतर जाता है। श्लोक जो माँगता है वह है एक वेग को झेल जाना, और यह उससे कहीं छोटी माँग है कि आदमी ऐसा बन जाए जिसमें वेग उठते ही न हों। इस श्लोक की बात करने के लिए किसी को वेग आना बंद नहीं करने पड़ते। उसे बस एक वेग के अंत तक वहीं मौजूद रहना है।',
   'Ise avastha nahi, veg kehna hi kaam ki baat hai, kyunki veg ka ek aakar hota hai: woh uthta hai, charam par pahunchta hai, aur kuch na kiya jaaye to phir utar jaata hai. Shloka jo maangta hai woh hai ek veg ko jhel jaana, aur yeh usse kahin chhoti maang hai ki aadmi aisa ban jaaye jisme veg uthte hi na hon. Is shloka ki baat karne ke liye kisi ko veg aana band nahi karne padte. Use bas ek veg ke ant tak wahin maujood rehna hai.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 5;

-- =====================================================================
-- 3. HOOKS, REFLECTIONS, PRACTICES, TOPICS
-- =====================================================================
-- Nothing here asks the reader to give anything up, and the 5.22
-- material is written so that "does not set up house in them" never
-- turns into "does not enjoy them". The 5.18 reflections ask the reader
-- about their own seeing. They do not ask anybody to rank anybody, and
-- they do not congratulate the reader for agreeing with the verse.
-- =====================================================================

DELETE m FROM verse_memory_aids m JOIN verses v ON v.id = m.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 5;
DELETE r FROM verse_reflections r JOIN verses v ON v.id = r.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 5;
DELETE p FROM verse_practices p JOIN verses v ON v.id = p.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 5;
DELETE vt FROM verse_topics vt JOIN verses v ON v.id = vt.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 5;

INSERT INTO verse_memory_aids (verse_id, hook_en, hook_hi, hook_hinglish, analogy_en, analogy_hi, analogy_hinglish, visual_cue)
SELECT v.id, m.h_en, m.h_hi, m.h_hing, m.a_en, m.a_hi, m.a_hing, m.cue FROM (
  SELECT 2 AS vn,
  'He asked which one. The answer is both, and then a preference.' AS h_en,
  'उसने पूछा कौन-सा। जवाब है दोनों, और फिर एक पसंद।' AS h_hi,
  'Usne poochha kaun sa. Jawab hai dono, aur phir ek pasand.' AS h_hing,
  'Like asking which of two doors leads out and being told both do, and one of them has fewer stairs.' AS a_en,
  'यह पूछने जैसा कि दो दरवाज़ों में से कौन बाहर ले जाता है और जवाब मिले कि दोनों, और एक में सीढ़ियाँ कम हैं।' AS a_hi,
  'Yeh poochhne jaisa ki do darwazon mein se kaun bahar le jaata hai aur jawab mile ki dono, aur ek mein seedhiyan kam hain.' AS a_hing,
  'Two doors, both open, one with a short flight of steps' AS cue

  UNION ALL SELECT 8,
  'Eight ordinary verbs in a row. The claim is made across all of them at once.',
  'लगातार आठ मामूली क्रियाएँ। दावा उन सब पर एक साथ किया जा रहा है।',
  'Lagataar aath mamooli kriyayen. Dawa un sab par ek saath kiya ja raha hai.',
  'Like reading the list of what a hand did today and noticing nobody had to be told to do any of it.',
  'यह पढ़ने जैसा कि आज एक हाथ ने क्या-क्या किया और यह देखना कि इनमें से कुछ भी करने को किसी ने कहना नहीं पड़ा।',
  'Yeh padhne jaisa ki aaj ek haath ne kya kya kiya aur yeh dekhna ki inme se kuch bhi karne ko kisi ne kehna nahi pada.',
  'A plain list of eight small verbs'

  UNION ALL SELECT 10,
  'Not out of the water. Just not soaked by it.',
  'पानी से बाहर नहीं। बस पानी में भीगा हुआ नहीं।',
  'Paani se bahar nahi. Bas paani mein bheega hua nahi.',
  'A lotus leaf sits in the pond all day and comes out dry. It never left the pond.',
  'कमल का पत्ता दिन भर तालाब में रहता है और सूखा निकलता है। वह तालाब से गया कभी नहीं।',
  'Kamal ka patta din bhar talaab mein rehta hai aur sookha nikalta hai. Woh talaab se gaya kabhi nahi.',
  'Water beaded on a broad green leaf'

  UNION ALL SELECT 12,
  'Two people, the same work, a different day.',
  'दो लोग, वही काम, अलग दिन।',
  'Do log, wahi kaam, alag din.',
  'Like two people carrying the same box, and one of them is also counting the steps left.',
  'दो लोग वही डिब्बा उठाए हुए, और उनमें से एक बचे हुए क़दम भी गिन रहा है।',
  'Do log wahi dibba uthaye hue, aur unme se ek bache hue kadam bhi gin raha hai.',
  'Two identical boxes, one with a tally scratched on it'

  UNION ALL SELECT 18,
  'The most respected and the most despised, in one sentence, on purpose.',
  'सबसे सम्मानित और सबसे तिरस्कृत, एक ही वाक्य में, जानबूझकर।',
  'Sabse sammanit aur sabse tiraskrit, ek hi vakya mein, jaanboojhkar.',
  'Like a list where everybody expected an order, and the person writing it refused to give one.',
  'ऐसी सूची जैसी जहाँ सब क्रम की उम्मीद कर रहे थे, और लिखने वाले ने क्रम देने से इनकार कर दिया।',
  'Aisi soochi jaisi jahan sab kram ki ummeed kar rahe the, aur likhne wale ne kram dene se inkaar kar diya.',
  'Five names written across one line, none numbered'

  UNION ALL SELECT 21,
  'Not a different happiness. The one that was there before anything arrived.',
  'कोई और सुख नहीं। वही जो किसी चीज़ के आने से पहले भी था।',
  'Koi aur sukh nahi. Wahi jo kisi cheez ke aane se pehle bhi tha.',
  'Like looking for the warmth of a room in the things you carried into it.',
  'यह ढूँढ़ने जैसा कि कमरे की गरमाहट उन चीज़ों में है जो आप उसमें लेकर आए थे।',
  'Yeh dhoondhne jaisa ki kamre ki garmahat un cheezon mein hai jo tum usme lekar aaye the.',
  'A warm empty room, door ajar'

  UNION ALL SELECT 22,
  'Same door in, same door out. That is the whole argument.',
  'जिस दरवाज़े से आया, उसी से जाएगा। पूरी दलील बस इतनी है।',
  'Jis darwaze se aaya, usi se jayega. Poori dalil bas itni hai.',
  'Anything with a start has a place where it stops, and that place is where the sorrow is standing.',
  'जिस चीज़ का आरंभ है उसकी एक जगह है जहाँ वह रुकती है, और उसी जगह दुख खड़ा है।',
  'Jis cheez ka aarambh hai uski ek jagah hai jahan woh rukti hai, aur usi jagah dukh khada hai.',
  'One doorway, drawn twice'

  UNION ALL SELECT 23,
  'A wave, not a weather. You have to outlast one, not become someone else.',
  'लहर, मौसम नहीं। एक को झेल जाना है, कोई और नहीं बन जाना है।',
  'Lehar, mausam nahi. Ek ko jhel jaana hai, koi aur nahi ban jaana hai.',
  'Like standing in surf. Nobody stops the wave. You are just still standing when it has gone past.',
  'लहरों में खड़े होने जैसा। लहर कोई नहीं रोकता। आप बस तब भी खड़े होते हैं जब वह निकल चुकी होती है।',
  'Lehron mein khade hone jaisa. Lehar koi nahi rokta. Tum bas tab bhi khade hote ho jab woh nikal chuki hoti hai.',
  'A wave cresting, a figure still upright'
) AS m
JOIN verses v ON v.verse_number = m.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 5;

INSERT INTO verse_reflections (verse_id, question_en, question_hi, question_hinglish, display_order)
SELECT v.id, r.q_en, r.q_hi, r.q_hing, r.ord FROM (
  SELECT 2 AS vn, 'Which question of yours right now is really "which one", when the answer might be "both"?' AS q_en, 'अभी आपका कौन-सा सवाल असल में "कौन-सा" है, जबकि जवाब शायद "दोनों" हो?' AS q_hi, 'Abhi tumhara kaun sa sawal asal mein "kaun sa" hai, jabki jawab shayad "dono" ho?' AS q_hing, 1 AS ord
  UNION ALL SELECT 2, 'When somebody gives you a preference rather than a rule, is that easier or harder to act on?', 'जब कोई आपको नियम नहीं, पसंद बताता है, तो उस पर चलना आसान होता है या मुश्किल?', 'Jab koi tumhe niyam nahi, pasand batata hai, to us par chalna aasan hota hai ya mushkil?', 2
  UNION ALL SELECT 2, 'Have you left something because it was wrong, or because leaving was easier to explain?', 'आपने कुछ इसलिए छोड़ा क्योंकि वह ग़लत था, या इसलिए कि छोड़ना समझाना आसान था?', 'Tumne kuch isliye chhoda kyunki woh galat tha, ya isliye ki chhodna samjhana aasan tha?', 3
  UNION ALL SELECT 8, 'Which of the eight did you do today without deciding to?', 'आठों में से आज आपने कौन-सा बिना तय किए किया?', 'Aathon mein se aaj tumne kaun sa bina tay kiye kiya?', 1
  UNION ALL SELECT 8, 'Where in your day is there real deciding, and where is there only the feeling of it?', 'आपके दिन में असली तय करना कहाँ है, और कहाँ सिर्फ़ उसका एहसास है?', 'Tumhare din mein asli tay karna kahan hai, aur kahan sirf uska ehsaas hai?', 2
  UNION ALL SELECT 8, 'If nothing about your work changed but the sense of being its author did, what would be different?', 'अगर आपके काम में कुछ न बदले, बस उसका कर्ता होने का एहसास बदल जाए, तो क्या अलग होगा?', 'Agar tumhare kaam mein kuch na badle, bas uska karta hone ka ehsaas badal jaaye, to kya alag hoga?', 3
  UNION ALL SELECT 10, 'What are you in, all day, that you would rather not carry home?', 'दिन भर आप किसमें रहते हैं जिसे आप घर तक नहीं ले जाना चाहेंगे?', 'Din bhar tum kisme rehte ho jise tum ghar tak nahi le jaana chahoge?', 1
  UNION ALL SELECT 10, 'The leaf does not leave the pond. What does that rule out as an answer for you?', 'पत्ता तालाब छोड़ता नहीं। यह आपके लिए किस जवाब को ख़ारिज कर देता है?', 'Patta talaab chhodta nahi. Yeh tumhare liye kaun se jawab ko khaarij kar deta hai?', 2
  UNION ALL SELECT 10, 'What stains you at work is usually one specific thing. Can you name it?', 'काम में जो आपको दागता है वह आमतौर पर एक ख़ास चीज़ होती है। उसका नाम बता सकते हैं?', 'Kaam mein jo tumhe daagta hai woh aam taur par ek khaas cheez hoti hai. Uska naam bata sakte ho?', 3
  UNION ALL SELECT 12, 'Think of two people doing the same work. What is actually different about their day?', 'वही काम करते दो लोगों के बारे में सोचिए। उनके दिन में असल में अलग क्या है?', 'Wahi kaam karte do logon ke baare mein socho. Unke din mein asal mein alag kya hai?', 1
  UNION ALL SELECT 12, 'What result are you currently tied to? Not hoping for. Tied to.', 'अभी आप किस नतीजे से बँधे हुए हैं? उम्मीद नहीं। बँधे हुए।', 'Abhi tum kis nateeje se bandhe hue ho? Ummeed nahi. Bandhe hue.', 2
  UNION ALL SELECT 12, 'Is the peace here described as a reward, or as what is left when something stops?', 'यहाँ जो शांति है, वह इनाम की तरह बताई गई है या उस चीज़ की तरह जो कुछ रुकने पर बचती है?', 'Yahan jo shanti hai, woh inaam ki tarah batai gayi hai ya us cheez ki tarah jo kuch rukne par bachti hai?', 3
  UNION ALL SELECT 18, 'Where does your own seeing sort people before you have noticed it happening?', 'आपकी अपनी नज़र लोगों को कहाँ छाँट देती है, इससे पहले कि आप उसे होते हुए देख पाएँ?', 'Tumhari apni nazar logon ko kahan chhaant deti hai, isse pehle ki tum use hote hue dekh pao?', 1
  UNION ALL SELECT 18, 'The verse and 4.13 are in the same book. What do you do with that?', 'यह श्लोक और 4.13 एक ही किताब में हैं। आप इसका क्या करते हैं?', 'Yeh shloka aur 4.13 ek hi kitaab mein hain. Tum iska kya karte ho?', 2
  UNION ALL SELECT 18, 'Whose name would you have put last in that list, honestly, before reading it?', 'सच बताइए — पढ़ने से पहले उस सूची में आप किसका नाम आख़िर में रखते?', 'Sach batao — padhne se pehle us soochi mein tum kiska naam aakhir mein rakhte?', 3
  UNION ALL SELECT 21, 'When was your last good day that nothing in particular caused?', 'पिछली बार आपका अच्छा दिन कब था जिसकी कोई ख़ास वजह नहीं थी?', 'Pichhli baar tumhara achha din kab tha jiski koi khaas wajah nahi thi?', 1
  UNION ALL SELECT 21, 'Where do you go looking for it, and has that place ever actually had it?', 'आप उसे कहाँ ढूँढ़ने जाते हैं, और क्या वह जगह कभी सचमुच उसकी थी?', 'Tum use kahan dhoondhne jaate ho, aur kya woh jagah kabhi sach mein uski thi?', 2
  UNION ALL SELECT 21, 'Does "already in there" sound like good news or like pressure to you? Both are honest.', '"पहले से भीतर है" — यह आपको अच्छी ख़बर लगती है या दबाव? दोनों ईमानदार जवाब हैं।', '"Pehle se bheetar hai" — yeh tumhe achhi khabar lagti hai ya dabaav? Dono imaandaar jawab hain.', 3
  UNION ALL SELECT 22, 'What have you built a life around that has a date on it?', 'आपने किस चीज़ के इर्द-गिर्द ज़िंदगी बनाई है जिस पर एक तारीख़ लगी है?', 'Tumne kis cheez ke ird-gird zindagi banayi hai jis par ek tareekh lagi hai?', 1
  UNION ALL SELECT 22, 'Enjoying a thing and living inside it are different. Where is that line for you?', 'किसी चीज़ का आनंद लेना और उसके भीतर रहना अलग हैं। आपके लिए वह रेखा कहाँ है?', 'Kisi cheez ka anand lena aur uske bheetar rehna alag hain. Tumhare liye woh rekha kahan hai?', 2
  UNION ALL SELECT 22, 'If this verse read as an argument for joylessness, what did it slip past you?', 'अगर यह श्लोक आपको आनंदहीनता की दलील लगा, तो उसमें से क्या छूट गया?', 'Agar yeh shloka tumhe anandheenta ki dalil laga, to usme se kya chhoot gaya?', 3
  UNION ALL SELECT 23, 'How long does one of your surges actually last? Most people have never timed it.', 'आपका एक वेग असल में कितनी देर टिकता है? ज़्यादातर लोगों ने कभी नापा ही नहीं।', 'Tumhara ek veg asal mein kitni der tikta hai? Zyadatar logon ne kabhi napa hi nahi.', 1
  UNION ALL SELECT 23, 'What is the smallest thing that has ever got you to the other side of one?', 'सबसे छोटी कौन-सी चीज़ है जिसने कभी आपको एक वेग के उस पार पहुँचाया?', 'Sabse chhoti kaun si cheez hai jisne kabhi tumhe ek veg ke us paar pahunchaya?', 2
  UNION ALL SELECT 23, 'The verse says here, in this life. What does that change about the ask?', 'श्लोक कहता है यहीं, इसी जीवन में। इससे माँग में क्या बदलता है?', 'Shloka kehta hai yahin, isi jeevan mein. Isse maang mein kya badalta hai?', 3
) AS r
JOIN verses v ON v.verse_number = r.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 5;

INSERT INTO verse_practices (verse_id, action_en, action_hi, action_hinglish, estimated_minutes, difficulty, display_order)
SELECT v.id, p.a_en, p.a_hi, p.a_hing, p.mins, p.diff, 1 FROM (
  SELECT 2 AS vn, 'Take one decision you have framed as either-or and write the version where both are allowed.' AS a_en, 'ऐसा एक फ़ैसला लीजिए जिसे आपने या-तो-यह-या-वह बनाकर रखा है और वह रूप लिखिए जिसमें दोनों की इजाज़त है।' AS a_hi, 'Aisa ek faisla lo jise tumne ya-to-yeh-ya-woh banakar rakha hai aur woh roop likho jisme dono ki ijazat hai.' AS a_hing, 8 AS mins, 'beginner' AS diff
  UNION ALL SELECT 8, 'For one hour, notice each time your body did something you never issued an instruction for.', 'एक घंटे तक हर बार ध्यान दीजिए जब आपके शरीर ने कुछ किया जिसका हुक्म आपने कभी नहीं दिया।', 'Ek ghante tak har baar dhyan do jab tumhare sharir ne kuch kiya jiska hukm tumne kabhi nahi diya.', 5, 'beginner'
  UNION ALL SELECT 10, 'Pick one thing from work you have been carrying home. Put it down at a specific point on the way.', 'काम की एक चीज़ चुनिए जिसे आप घर तक ढो रहे हैं। रास्ते में किसी तय जगह पर उसे रख दीजिए।', 'Kaam ki ek cheez chuno jise tum ghar tak dho rahe ho. Raaste mein kisi tay jagah par use rakh do.', 5, 'intermediate'
  UNION ALL SELECT 12, 'Do one task today and write down what you wanted from it before you start. Then do it anyway.', 'आज एक काम कीजिए और शुरू करने से पहले लिखिए कि आप उससे क्या चाहते थे। फिर वह काम फिर भी कीजिए।', 'Aaj ek kaam karo aur shuru karne se pehle likho ki tum usse kya chahte the. Phir woh kaam phir bhi karo.', 10, 'beginner'
  UNION ALL SELECT 18, 'Think of one person you deal with regularly and speak to less carefully than the others. Change nothing else today.', 'ऐसे एक व्यक्ति के बारे में सोचिए जिससे आपका रोज़ का वास्ता है और जिससे आप बाक़ियों से कम ध्यान से बात करते हैं। आज और कुछ मत बदलिए।', 'Aise ek insaan ke baare mein socho jisse tumhara roz ka waasta hai aur jisse tum baakiyon se kam dhyan se baat karte ho. Aaj aur kuch mat badlo.', 5, 'intermediate'
  UNION ALL SELECT 21, 'Recall one good day with no cause. Write down what was NOT happening that day.', 'एक ऐसा अच्छा दिन याद कीजिए जिसकी कोई वजह नहीं थी। लिखिए कि उस दिन क्या नहीं हो रहा था।', 'Ek aisa achha din yaad karo jiski koi wajah nahi thi. Likho ki us din kya nahi ho raha tha.', 6, 'beginner'
  UNION ALL SELECT 22, 'Name one thing you enjoy and one thing you live inside. Do not stop either. Just label them.', 'एक चीज़ बताइए जिसका आप आनंद लेते हैं और एक जिसके भीतर आप रहते हैं। दोनों में से कुछ बंद मत कीजिए। बस नाम दे दीजिए।', 'Ek cheez batao jiska tum anand lete ho aur ek jiske bheetar tum rehte ho. Dono mein se kuch band mat karo. Bas naam de do.', 7, 'intermediate'
  UNION ALL SELECT 23, 'Next time one comes up, look at a clock. Do nothing else. Look again when it has passed.', 'अगली बार जब कोई वेग उठे, घड़ी देख लीजिए। और कुछ मत कीजिए। जब वह गुज़र जाए तब फिर देखिए।', 'Agli baar jab koi veg uthe, ghadi dekh lo. Aur kuch mat karo. Jab woh guzar jaaye tab phir dekho.', 3, 'beginner'
) AS p
JOIN verses v ON v.verse_number = p.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 5;

INSERT INTO verse_topics (verse_id, topic_id, relevance)
SELECT v.id, t.id, x.rel FROM (
  SELECT 2 AS vn, 'hard-decisions' AS slug, 10 AS rel
  UNION ALL SELECT 2, 'action-without-attachment', 9
  UNION ALL SELECT 2, 'duty', 8
  UNION ALL SELECT 2, 'effort-without-result', 6
  UNION ALL SELECT 8, 'the-self', 10
  UNION ALL SELECT 8, 'action-without-attachment', 8
  UNION ALL SELECT 8, 'duty', 6
  UNION ALL SELECT 10, 'action-without-attachment', 10
  UNION ALL SELECT 10, 'burnout', 8
  UNION ALL SELECT 10, 'duty', 7
  UNION ALL SELECT 10, 'steadiness', 6
  UNION ALL SELECT 12, 'effort-without-result', 10
  UNION ALL SELECT 12, 'action-without-attachment', 9
  UNION ALL SELECT 12, 'steadiness', 7
  UNION ALL SELECT 12, 'desire', 6
  UNION ALL SELECT 18, 'comparison', 10
  UNION ALL SELECT 18, 'the-self', 9
  UNION ALL SELECT 18, 'hard-decisions', 6
  UNION ALL SELECT 21, 'desire', 9
  UNION ALL SELECT 21, 'steadiness', 9
  UNION ALL SELECT 21, 'the-self', 8
  UNION ALL SELECT 21, 'comparison', 6
  UNION ALL SELECT 22, 'impermanence', 10
  UNION ALL SELECT 22, 'desire', 9
  UNION ALL SELECT 22, 'grief', 7
  UNION ALL SELECT 22, 'steadiness', 6
  UNION ALL SELECT 23, 'anger', 10
  UNION ALL SELECT 23, 'desire', 9
  UNION ALL SELECT 23, 'restlessness', 8
  UNION ALL SELECT 23, 'steadiness', 7
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 5
JOIN topics t ON t.slug = x.slug;

-- =====================================================================
-- 4. MODERN EXAMPLES
-- =====================================================================
-- Four per verse, four distinct categories per verse, THIRTY-TWO in all.
--
-- THE 5.18 SET IS THE CAREFUL ONE
--   Not one of these four names a caste, a community, a religion or a
--   region. The verse is about the reader''s own seeing, so the examples
--   are about somebody noticing their own sorting — a queue, a ward, a
--   staff room, a lobby — and none of them lets the reader finish
--   feeling congratulated.
--
-- THE 5.22 SET GUARDS AGAINST JOYLESSNESS
--   In every one of the four the person keeps the thing they enjoy.
--   What changes is what they have built on top of it. A set where
--   somebody gives something up would teach the misreading.
-- =====================================================================

DELETE e FROM modern_examples e JOIN verses v ON v.id = e.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 5;

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

  SELECT 2 AS vn, 'everyday_life' AS cat, 1 AS ord,
  'The resignation letter in drafts' AS t_en, 'ड्राफ़्ट में पड़ा इस्तीफ़ा' AS t_hi, 'Draft mein pada resignation' AS t_hing,
  'Somebody has written a resignation letter and not sent it, four times in a year. The fifth time they read it back and notice that every line is about the job earning them nothing they wanted. They still do not send it. What they change instead is that they stop checking, at the end of each week, whether the week paid off.' AS s_en,
  'किसी ने साल भर में चार बार इस्तीफ़ा लिखा और भेजा नहीं। पाँचवीं बार वह उसे दोबारा पढ़ता है और देखता है कि हर पंक्ति इस बारे में है कि नौकरी से उसे वह नहीं मिल रहा जो वह चाहता था। वह फिर भी नहीं भेजता। बदलता वह यह है कि हर हफ़्ते के अंत में यह जाँचना बंद कर देता है कि हफ़्ता वसूल हुआ या नहीं।' AS s_hi,
  'Kisi ne saal bhar mein chaar baar resignation likha aur bheja nahi. Paanchvi baar woh use dobara padhta hai aur dekhta hai ki har line is baare mein hai ki naukri se use woh nahi mil raha jo woh chahta tha. Woh phir bhi nahi bhejta. Badalta woh yeh hai ki har hafte ke ant mein yeh jaanchna band kar deta hai ki hafta wasool hua ya nahi.' AS s_hing,
  'Both of the verse''s roads are in this story. Sending the letter is one. What he actually did is the other, and the verse says it too arrives. Notice that the second road looks like nothing from outside — the job is the same job on Monday. The change is in what he stopped asking of it.' AS c_en,
  'श्लोक के दोनों रास्ते इस कहानी में हैं। पत्र भेजना एक है। उसने जो किया वह दूसरा है, और श्लोक कहता है कि वह भी पहुँचाता है। ध्यान दीजिए कि दूसरा रास्ता बाहर से कुछ भी नहीं दिखता — सोमवार को नौकरी वही नौकरी है। बदलाव इसमें है कि उसने उससे माँगना क्या बंद किया।' AS c_hi,
  'Shloka ke dono raaste is kahani mein hain. Patra bhejna ek hai. Usne jo kiya woh doosra hai, aur shloka kehta hai ki woh bhi pahunchata hai. Dhyan do ki doosra raasta bahar se kuch bhi nahi dikhta — Monday ko naukri wahi naukri hai. Badlav isme hai ki usne usse maangna kya band kiya.' AS c_hing,
  'Leaving is a real road. So is staying differently, and nobody can see you take it.' AS l_en,
  'छोड़ना असली रास्ता है। अलग तरह से टिके रहना भी, और उस पर चलते हुए कोई आपको देख नहीं सकता।' AS l_hi,
  'Chhodna asli raasta hai. Alag tarah se tike rehna bhi, aur us par chalte hue koi tumhe dekh nahi sakta.' AS l_hing,
  NULL AS src, 'beginner' AS diff, 'work,choice,quitting,honesty,both-roads' AS tags

  UNION ALL SELECT 2, 'corporate', 2,
  'Two people left the same team', 'एक ही टीम से दो लोग गए', 'Ek hi team se do log gaye',
  'A team loses two people in a quarter. One resigns and takes a job elsewhere. The other stays and quietly stops volunteering for the visible projects, and starts doing the unglamorous work properly. A year later both of them describe that quarter as the moment something eased.',
  'एक तिमाही में एक टीम से दो लोग जाते हैं। एक इस्तीफ़ा देकर कहीं और चला जाता है। दूसरा टिका रहता है और चुपचाप उन प्रोजेक्ट्स के लिए हाथ उठाना बंद कर देता है जो दिखते हैं, और वह काम ठीक से करने लगता है जिसमें चमक नहीं है। साल भर बाद दोनों उस तिमाही को उस पल की तरह बताते हैं जब कुछ हल्का हुआ था।',
  'Ek quarter mein ek team se do log jaate hain. Ek resign karke kahin aur chala jaata hai. Doosra tika rehta hai aur chupchap un projects ke liye haath uthana band kar deta hai jo dikhte hain, aur woh kaam theek se karne lagta hai jisme chamak nahi hai. Saal bhar baad dono us quarter ko us pal ki tarah batate hain jab kuch halka hua tha.',
  'The verse refuses to say only one of these worked, and this is what that refusal looks like in an office. It does add a preference, though, and the preference is practical rather than moral: the one who stayed is still doing the work, so whatever he learned, he learned it where it applies.',
  'श्लोक यह कहने से इनकार करता है कि इनमें से सिर्फ़ एक ने काम किया, और दफ़्तर में वह इनकार ऐसा दिखता है। हाँ, वह एक पसंद ज़रूर जोड़ता है, और वह पसंद नैतिक नहीं, व्यावहारिक है: जो टिका रहा वह अब भी वही काम कर रहा है, तो उसने जो सीखा, वहीं सीखा जहाँ वह लागू होता है।',
  'Shloka yeh kehne se inkaar karta hai ki inme se sirf ek ne kaam kiya, aur daftar mein woh inkaar aisa dikhta hai. Haan, woh ek pasand zaroor jodta hai, aur woh pasand naitik nahi, vyavharik hai: jo tika raha woh ab bhi wahi kaam kar raha hai, to usne jo seekha, wahin seekha jahan woh laagu hota hai.',
  'The preference in the verse is about where you get to keep practising. It is not a verdict on the one who left.',
  'श्लोक की पसंद इस बारे में है कि अभ्यास करते रहने की जगह कहाँ बची रहती है। यह उस पर फ़ैसला नहीं है जो चला गया।',
  'Shloka ki pasand is baare mein hai ki abhyas karte rehne ki jagah kahan bachi rehti hai. Yeh us par faisla nahi hai jo chala gaya.',
  NULL, 'intermediate', 'work,teams,leaving,staying,practice'

  UNION ALL SELECT 2, 'college', 3,
  'The paper he did not drop', 'वह पर्चा जो उसने नहीं छोड़ा', 'Woh paper jo usne nahi chhoda',
  'A student is doing badly in one subject and the deadline to drop it passes on a Friday. He spends Thursday night deciding and lets the deadline go by. On Saturday he opens the textbook for the first time in a month, and reads it without checking how far behind he is.',
  'एक छात्र एक विषय में ख़राब कर रहा है और उसे छोड़ने की आख़िरी तारीख़ शुक्रवार को गुज़र जाती है। वह गुरुवार की रात तय करने में बिताता है और तारीख़ को निकल जाने देता है। शनिवार को वह महीने भर में पहली बार किताब खोलता है और यह जाँचे बिना पढ़ता है कि वह कितना पीछे है।',
  'Ek student ek subject mein kharab kar raha hai aur use chhodne ki aakhiri tareekh Friday ko guzar jaati hai. Woh Thursday ki raat tay karne mein bitata hai aur tareekh ko nikal jaane deta hai. Saturday ko woh mahine bhar mein pehli baar kitaab kholta hai aur yeh jaanche bina padhta hai ki woh kitna peechhe hai.',
  'Dropping the paper was a legitimate road and the verse would not have argued with it. What he took instead is the second one, and the marker of it is the small thing at the end: he read without measuring the gap. That is the letting-go the verse names, and it is a different act from staying.',
  'पर्चा छोड़ना जायज़ रास्ता था और श्लोक उससे बहस नहीं करता। उसने जो लिया वह दूसरा है, और उसकी पहचान आख़िर की छोटी बात है: उसने फ़ासला नापे बिना पढ़ा। यही वह छोड़ना है जिसका श्लोक नाम लेता है, और वह टिके रहने से अलग काम है।',
  'Paper chhodna jayaz raasta tha aur shloka usse behes nahi karta. Usne jo liya woh doosra hai, aur uski pehchan aakhir ki chhoti baat hai: usne faasla naape bina padha. Yahi woh chhodna hai jiska shloka naam leta hai, aur woh tike rehne se alag kaam hai.',
  'Staying is not the second road by itself. Staying without keeping score is.',
  'सिर्फ़ टिके रहना दूसरा रास्ता नहीं है। हिसाब रखे बिना टिके रहना है।',
  'Sirf tike rehna doosra raasta nahi hai. Hisaab rakhe bina tike rehna hai.',
  NULL, 'beginner', 'study,deadlines,scorekeeping,persistence'

  UNION ALL SELECT 2, 'healthcare', 4,
  'The ward she stopped counting', 'वह वार्ड जिसकी उसने गिनती छोड़ दी', 'Woh ward jiski usne ginti chhod di',
  'A doctor on a long rotation had been keeping a private tally of how many patients got better. It was making her worse, so she stopped keeping it. She did not change a single thing about how she worked. Two months later a colleague asked whether she had been moved to an easier ward.',
  'लंबी रोटेशन पर एक डॉक्टर चुपचाप गिनती रखती थी कि कितने मरीज़ ठीक हुए। इससे उसकी हालत बिगड़ रही थी, तो उसने गिनना छोड़ दिया। काम करने के तरीक़े में उसने एक भी चीज़ नहीं बदली। दो महीने बाद एक साथी ने पूछा कि क्या उसे किसी आसान वार्ड में भेज दिया गया है।',
  'Lambi rotation par ek doctor chupchap ginti rakhti thi ki kitne mareez theek hue. Isse uski haalat bigad rahi thi, to usne ginna chhod diya. Kaam karne ke tareeke mein usne ek bhi cheez nahi badli. Do mahine baad ek saathi ne poochha ki kya use kisi aasan ward mein bhej diya gaya hai.',
  'Two roads, and she took the one the verse prefers, which is why the work is unchanged and she is not. The tally was never part of the medicine. It was a separate thing she was also doing, and the verse is about noticing that it is separate and can be put down on its own.',
  'दो रास्ते, और उसने वह लिया जिसे श्लोक बेहतर कहता है, इसीलिए काम वही है और वह वही नहीं। गिनती कभी इलाज का हिस्सा नहीं थी। वह एक अलग चीज़ थी जो वह साथ-साथ कर रही थी, और श्लोक इसी बारे में है कि वह अलग है और अकेले रखी जा सकती है।',
  'Do raaste, aur usne woh liya jise shloka behtar kehta hai, isiliye kaam wahi hai aur woh wahi nahi. Ginti kabhi ilaaj ka hissa nahi thi. Woh ek alag cheez thi jo woh saath saath kar rahi thi, aur shloka isi baare mein hai ki woh alag hai aur akele rakhi ja sakti hai.',
  'The scorekeeping was never part of the job. That is why putting it down cost the job nothing.',
  'हिसाब रखना कभी काम का हिस्सा था ही नहीं। इसीलिए उसे रख देने से काम का कुछ नहीं गया।',
  'Hisaab rakhna kabhi kaam ka hissa tha hi nahi. Isiliye use rakh dene se kaam ka kuch nahi gaya.',
  NULL, 'intermediate', 'medicine,burnout,scorekeeping,outcomes'

  UNION ALL SELECT 8, 'technology', 1,
  'The keys he never looked at', 'वे बटन जिन्हें उसने देखा ही नहीं', 'Woh button jinhe usne dekha hi nahi',
  'Somebody who types for a living tries, as an experiment, to notice the decision to press each key. He manages it for about four words and then the sentence finishes itself while he is thinking about the next one. He is a fast typist. He has no idea where his fingers go.',
  'टाइप करके कमाने वाला कोई प्रयोग के तौर पर हर बटन दबाने के फ़ैसले पर ध्यान देने की कोशिश करता है। लगभग चार शब्दों तक वह कर पाता है और फिर वाक्य ख़ुद पूरा हो जाता है जबकि वह अगले के बारे में सोच रहा होता है। वह तेज़ टाइप करता है। उसे पता ही नहीं कि उसकी उँगलियाँ जाती कहाँ हैं।',
  'Type karke kamane wala koi prayog ke taur par har button dabane ke faisle par dhyan dene ki koshish karta hai. Lagbhag chaar shabdon tak woh kar paata hai aur phir vakya khud poora ho jaata hai jabki woh agle ke baare mein soch raha hota hai. Woh tez type karta hai. Use pata hi nahi ki uski ungliyan jaati kahan hain.',
  'The verse lists eight things a body does and says the one who has understood does not claim authorship of them. This is that, with a keyboard. Nobody is saying he did not type. The claim is narrower and stranger: the doing happened and the deciding is not findable anywhere in it.',
  'श्लोक शरीर के आठ काम गिनाता है और कहता है कि जिसने समझा है वह उनका कर्तापन नहीं लेता। यह वही है, कीबोर्ड के साथ। कोई यह नहीं कह रहा कि उसने टाइप नहीं किया। दावा उससे छोटा और अजीब है: करना हुआ, और उसमें तय करना कहीं ढूँढ़े नहीं मिलता।',
  'Shloka sharir ke aath kaam ginata hai aur kehta hai ki jisne samjha hai woh unka kartapan nahi leta. Yeh wahi hai, keyboard ke saath. Koi yeh nahi keh raha ki usne type nahi kiya. Dawa usse chhota aur ajeeb hai: karna hua, aur usme tay karna kahin dhoondhe nahi milta.',
  'The typing happened. Find the typist and you are looking for a while.',
  'टाइप होना हुआ। टाइप करने वाले को ढूँढ़ने बैठिए तो देर लगेगी।',
  'Type hona hua. Type karne wale ko dhoondhne baitho to der lagegi.',
  NULL, 'beginner', 'attention,habit,doership,noticing'

  UNION ALL SELECT 8, 'sports', 2,
  'The catch that finished before he decided', 'वह कैच जो तय करने से पहले पूरा हो गया', 'Woh catch jo tay karne se pehle poora ho gaya',
  'A fielder takes a hard catch at short range and cannot afterwards describe doing it. He describes seeing the ball and then holding the ball. Asked what happened in between, he says he moved, which is true and is not a description of anything.',
  'एक फ़ील्डर पास से आया मुश्किल कैच लपकता है और बाद में यह बता नहीं पाता कि उसने किया कैसे। वह बताता है कि गेंद दिखी और फिर गेंद हाथ में थी। बीच में क्या हुआ, पूछने पर वह कहता है कि वह हिला, जो सच है और किसी चीज़ का वर्णन नहीं है।',
  'Ek fielder paas se aaya mushkil catch lapakta hai aur baad mein yeh bata nahi paata ki usne kiya kaise. Woh batata hai ki gend dikhi aur phir gend haath mein thi. Beech mein kya hua, poochhne par woh kehta hai ki woh hila, jo sach hai aur kisi cheez ka varnan nahi hai.',
  'Seeing, touching, moving — three of the eight verbs, inside two seconds. The verse is not making a mystical claim here so much as an accurate one. Everyone who has done something quickly and well knows the gap in the middle of the memory.',
  'देखना, छूना, हिलना — आठ में से तीन क्रियाएँ, दो सेकंड के भीतर। श्लोक यहाँ रहस्यमय दावा उतना नहीं कर रहा जितना सही दावा। जिसने भी कुछ तेज़ी से और अच्छे से किया है, वह याद के बीच वाले उस ख़ाली हिस्से को जानता है।',
  'Dekhna, chhoona, hilna — aath mein se teen kriyayen, do second ke bheetar. Shloka yahan rahasyamay dawa utna nahi kar raha jitna sahi dawa. Jisne bhi kuch tezi se aur achhe se kiya hai, woh yaad ke beech wale us khaali hisse ko jaanta hai.',
  'The better you get at something, the harder it becomes to find yourself doing it.',
  'किसी चीज़ में आप जितने अच्छे होते जाते हैं, उसे करते हुए ख़ुद को ढूँढ़ना उतना ही मुश्किल होता जाता है।',
  'Kisi cheez mein tum jitne achhe hote jaate ho, use karte hue khud ko dhoondhna utna hi mushkil hota jaata hai.',
  NULL, 'beginner', 'skill,reflex,doership,attention'

  UNION ALL SELECT 8, 'everyday_life', 3,
  'Nobody breathed on purpose today', 'आज किसी ने जानबूझकर साँस नहीं ली', 'Aaj kisi ne jaanboojhkar saans nahi li',
  'A person reads this verse, gets to the word for breathing, and does the thing everybody does — starts breathing manually. It is uncomfortable for about a minute and then they forget, and it carries on without them, as it did for the whole of the morning they were not thinking about it.',
  'कोई यह श्लोक पढ़ता है, साँस वाले शब्द तक पहुँचता है, और वही करता है जो सब करते हैं — हाथ से साँस लेने लगता है। मिनट भर असहज रहता है और फिर भूल जाता है, और साँस उसके बिना चलती रहती है, जैसे पूरी सुबह चलती रही जब वह इस बारे में सोच ही नहीं रहा था।',
  'Koi yeh shloka padhta hai, saans wale shabd tak pahunchta hai, aur wahi karta hai jo sab karte hain — haath se saans lene lagta hai. Minute bhar asahaj rehta hai aur phir bhool jaata hai, aur saans uske bina chalti rehti hai, jaise poori subah chalti rahi jab woh is baare mein soch hi nahi raha tha.',
  'This is the cheapest demonstration of the verse available and it is why breathing is on the list. The list is long on purpose: the further down it you go, the harder it gets to keep claiming you are the one arranging all of it.',
  'यह श्लोक का सबसे सस्ता सबूत है और इसीलिए साँस सूची में है। सूची जानबूझकर लंबी है: उसमें जितना नीचे जाइए, यह दावा बनाए रखना उतना मुश्किल होता है कि यह सब आप ही जुटा रहे हैं।',
  'Yeh shloka ka sabse sasta saboot hai aur isiliye saans soochi mein hai. Soochi jaanboojhkar lambi hai: usme jitna neeche jao, yeh dawa banaye rakhna utna mushkil hota hai ki yeh sab tum hi juta rahe ho.',
  'The list is long on purpose. Somewhere down it, the claim of authorship runs out.',
  'सूची जानबूझकर लंबी है। उसमें कहीं नीचे जाकर कर्तापन का दावा ख़त्म हो जाता है।',
  'Soochi jaanboojhkar lambi hai. Usme kahin neeche jaakar kartapan ka dawa khatam ho jaata hai.',
  NULL, 'beginner', 'breathing,body,doership,noticing'

  UNION ALL SELECT 8, 'ai', 4,
  'Who wrote the paragraph', 'पैराग्राफ़ लिखा किसने', 'Paragraph likha kisne',
  'Somebody drafts a paragraph with a tool, rewrites four of the sentences, keeps two, and reorders the whole thing. Later they are asked whether they wrote it and find they cannot answer cleanly. The honest answer takes three sentences and still is not tidy.',
  'कोई एक औज़ार की मदद से पैराग्राफ़ लिखता है, उसके चार वाक्य दोबारा लिखता है, दो रखता है, और पूरे का क्रम बदल देता है। बाद में पूछा जाता है कि क्या यह उसने लिखा और वह साफ़ जवाब नहीं दे पाता। ईमानदार जवाब में तीन वाक्य लगते हैं और तब भी वह सुथरा नहीं होता।',
  'Koi ek auzaar ki madad se paragraph likhta hai, uske chaar vakya dobara likhta hai, do rakhta hai, aur poore ka kram badal deta hai. Baad mein poochha jaata hai ki kya yeh usne likha aur woh saaf jawab nahi de paata. Imaandaar jawab mein teen vakya lagte hain aur tab bhi woh suthra nahi hota.',
  'The verse is older than any of this and the difficulty is the same one. It is not saying nobody acted. It is saying that "I did it" is a shorter sentence than the situation supports, and that the discomfort of the longer sentence is where the verse lives.',
  'श्लोक इन सब से पुराना है और दिक़्क़त वही है। वह यह नहीं कह रहा कि किसी ने कुछ किया ही नहीं। वह कह रहा है कि "मैंने किया" उस वाक्य से छोटा है जिसे हालात संभाल सकते हैं, और लंबे वाक्य की जो असहजता है, श्लोक वहीं रहता है।',
  'Shloka in sab se purana hai aur dikkat wahi hai. Woh yeh nahi keh raha ki kisi ne kuch kiya hi nahi. Woh keh raha hai ki "maine kiya" us vakya se chhota hai jise haalat sambhal sakte hain, aur lambe vakya ki jo asahajta hai, shloka wahin rehta hai.',
  '"I did it" is often the shortest sentence available rather than the true one.',
  '"मैंने किया" अक्सर सबसे छोटा उपलब्ध वाक्य होता है, सच्चा नहीं।',
  '"Maine kiya" aksar sabse chhota uplabdh vakya hota hai, sachcha nahi.',
  NULL, 'intermediate', 'authorship,tools,honesty,doership'

  UNION ALL SELECT 10, 'healthcare', 1,
  'The dry twenty minutes', 'सूखे बीस मिनट', 'Sookhe bees minute',
  'A palliative care nurse drives home the same route every evening and has a rule that she does not think about the day until the second roundabout. After the roundabout she thinks about it as much as she needs to. In eight years she has not skipped a shift and has not stopped crying at some of them.',
  'उपशामक देखभाल की एक नर्स हर शाम एक ही रास्ते से घर जाती है और उसका नियम है कि दूसरे चौराहे तक वह दिन के बारे में नहीं सोचती। चौराहे के बाद जितना ज़रूरी हो उतना सोचती है। आठ साल में उसने कोई शिफ़्ट नहीं छोड़ी और कुछ शिफ़्टों पर रोना भी बंद नहीं किया।',
  'Upshamak dekhbhal ki ek nurse har shaam ek hi raaste se ghar jaati hai aur uska niyam hai ki doosre chaurahe tak woh din ke baare mein nahi sochti. Chaurahe ke baad jitna zaroori ho utna sochti hai. Aath saal mein usne koi shift nahi chhodi aur kuch shifton par rona bhi band nahi kiya.',
  'The leaf is in the water. She is not avoiding the ward, she is not numb, and she has not stopped being affected. What she has is a place where the water runs off, twenty minutes long and shaped like a roundabout. The verse is about the surface, not about the distance.',
  'पत्ता पानी में ही है। वह वार्ड से बच नहीं रही, सुन्न नहीं है, और उस पर असर होना बंद नहीं हुआ। उसके पास बस एक जगह है जहाँ पानी बह जाता है, बीस मिनट लंबी और एक चौराहे के आकार की। श्लोक सतह के बारे में है, दूरी के बारे में नहीं।',
  'Patta paani mein hi hai. Woh ward se bach nahi rahi, sunn nahi hai, aur us par asar hona band nahi hua. Uske paas bas ek jagah hai jahan paani beh jaata hai, bees minute lambi aur ek chaurahe ke aakar ki. Shloka satah ke baare mein hai, doori ke baare mein nahi.',
  'The leaf is not further from the water than anything else in the pond. It just does not hold it.',
  'पत्ता तालाब की बाक़ी चीज़ों से पानी से ज़्यादा दूर नहीं है। वह बस उसे पकड़ता नहीं।',
  'Patta talaab ki baaki cheezon se paani se zyada door nahi hai. Woh bas use pakadta nahi.',
  NULL, 'intermediate', 'medicine,boundaries,grief,routine'

  UNION ALL SELECT 10, 'corporate', 2,
  'He read the thread twice and replied once', 'उसने थ्रेड दो बार पढ़ा और जवाब एक बार दिया', 'Usne thread do baar padha aur jawab ek baar diya',
  'A long email chain goes badly and somebody is criticised in it, partly unfairly. He reads the whole thing twice, writes the reply that answers the fair part, and sends it. He does not answer the unfair part and he does not forgive it either. He simply does not reply to it.',
  'एक लंबी ईमेल चेन बिगड़ जाती है और उसमें किसी की आलोचना होती है, कुछ हद तक नाजायज़। वह पूरी चीज़ दो बार पढ़ता है, वह जवाब लिखता है जो जायज़ हिस्से का जवाब देता है, और भेज देता है। नाजायज़ हिस्से का जवाब वह नहीं देता और उसे माफ़ भी नहीं करता। वह बस उसका जवाब नहीं देता।',
  'Ek lambi email chain bigad jaati hai aur usme kisi ki aalochana hoti hai, kuch had tak najayaz. Woh poori cheez do baar padhta hai, woh jawab likhta hai jo jayaz hisse ka jawab deta hai, aur bhej deta hai. Najayaz hisse ka jawab woh nahi deta aur use maaf bhi nahi karta. Woh bas uska jawab nahi deta.',
  'This is not rising above anything. Rising above would be a claim about him. What the verse describes is narrower and easier to actually do: the unfair sentence arrived, it was read, and it did not get to set the agenda for the next hour of his work.',
  'यह किसी चीज़ से ऊपर उठना नहीं है। ऊपर उठना उसके बारे में दावा होता। श्लोक जो बताता है वह छोटा है और करने में आसान: नाजायज़ वाक्य आया, पढ़ा गया, और उसे उसके काम के अगले घंटे का एजेंडा तय करने का मौक़ा नहीं मिला।',
  'Yeh kisi cheez se upar uthna nahi hai. Upar uthna uske baare mein dawa hota. Shloka jo batata hai woh chhota hai aur karne mein aasan: najayaz vakya aaya, padha gaya, aur use uske kaam ke agle ghante ka agenda tay karne ka mauka nahi mila.',
  'Not answering something is not the same as being above it. The verse only asks for the first.',
  'किसी बात का जवाब न देना उससे ऊपर होना नहीं है। श्लोक सिर्फ़ पहली चीज़ माँगता है।',
  'Kisi baat ka jawab na dena usse upar hona nahi hai. Shloka sirf pehli cheez maangta hai.',
  NULL, 'intermediate', 'work,criticism,restraint,email'

  UNION ALL SELECT 10, 'parenting', 3,
  'The supermarket floor', 'सुपरमार्केट का फ़र्श', 'Supermarket ka farsh',
  'A four-year-old is on the floor of a supermarket aisle and a parent is crouched next to her, waiting. The parent is fully in it — talking, holding a hand, apologising to somebody with a trolley. What they are not doing is deciding, during it, what this says about them as a parent.',
  'सुपरमार्केट की गली के फ़र्श पर चार साल की बच्ची है और एक अभिभावक उसके पास उकड़ूँ बैठा इंतज़ार कर रहा है। वह पूरी तरह उसी में है — बोल रहा है, हाथ थामे है, ट्रॉली वाले किसी से माफ़ी माँग रहा है। जो वह नहीं कर रहा वह यह है कि उसी वक़्त तय करे कि इससे उसके अभिभावक होने के बारे में क्या पता चलता है।',
  'Supermarket ki gali ke farsh par chaar saal ki bachchi hai aur ek abhibhavak uske paas ukdoon baitha intezaar kar raha hai. Woh poori tarah usi mein hai — bol raha hai, haath thaame hai, trolley wale kisi se maafi maang raha hai. Jo woh nahi kar raha woh yeh hai ki usi waqt tay kare ki isse uske abhibhavak hone ke baare mein kya pata chalta hai.',
  'The water here is the aisle and the audience, and the parent is standing in all of it. The staining would have been the verdict — the sentence about what kind of parent this makes them, which is not information and is the part that follows you home.',
  'यहाँ पानी है वह गली और वे देखने वाले, और अभिभावक उन सब में खड़ा है। दाग़ फ़ैसला होता — वह वाक्य कि इससे वह किस तरह का अभिभावक बनता है, जो जानकारी नहीं है और वही हिस्सा है जो घर तक पीछा करता है।',
  'Yahan paani hai woh gali aur woh dekhne wale, aur abhibhavak un sab mein khada hai. Daag faisla hota — woh vakya ki isse woh kis tarah ka abhibhavak banta hai, jo jaankari nahi hai aur wahi hissa hai jo ghar tak peechha karta hai.',
  'The tantrum is water. The verdict about yourself is the stain, and it is optional.',
  'ज़िद पानी है। अपने बारे में फ़ैसला दाग़ है, और वह ज़रूरी नहीं।',
  'Zid paani hai. Apne baare mein faisla daag hai, aur woh zaroori nahi.',
  NULL, 'beginner', 'parenting,shame,public,self-judgement'

  UNION ALL SELECT 10, 'everyday_life', 4,
  'It used to arrive with him', 'पहले वह उसके साथ आता था', 'Pehle woh uske saath aata tha',
  'For years somebody arrived home and the day arrived with him — the tone of the day, in the first ten minutes, for whoever was there. Nothing about his job changed. What changed is that he started sitting in the car for three minutes before going in, which is a small enough thing that he was embarrassed to mention it.',
  'सालों तक कोई घर आता था और दिन उसके साथ आता था — दिन का मिज़ाज, पहले दस मिनट में, जो भी वहाँ होता उसके लिए। उसकी नौकरी में कुछ नहीं बदला। बदला यह कि वह अंदर जाने से पहले तीन मिनट गाड़ी में बैठने लगा, जो इतनी छोटी बात है कि उसे बताने में शर्म आती थी।',
  'Saalon tak koi ghar aata tha aur din uske saath aata tha — din ka mizaaj, pehle das minute mein, jo bhi wahan hota uske liye. Uski naukri mein kuch nahi badla. Badla yeh ki woh andar jaane se pehle teen minute gaadi mein baithne laga, jo itni chhoti baat hai ki use batane mein sharm aati thi.',
  'The verse is often read as a description of a rare person. Three minutes in a car is what it looks like when it is not rare. He is still in the water — he did the same day he always did. Something between the day and the front door stopped conducting.',
  'श्लोक अक्सर किसी दुर्लभ इंसान के वर्णन की तरह पढ़ा जाता है। गाड़ी में तीन मिनट वह रूप है जब वह दुर्लभ नहीं होता। वह अब भी पानी में है — दिन वही गुज़ारा जो हमेशा गुज़ारता था। दिन और घर के दरवाज़े के बीच कुछ था जिसने चालन बंद कर दिया।',
  'Shloka aksar kisi durlabh insaan ke varnan ki tarah padha jaata hai. Gaadi mein teen minute woh roop hai jab woh durlabh nahi hota. Woh ab bhi paani mein hai — din wahi guzara jo hamesha guzarta tha. Din aur ghar ke darwaze ke beech kuch tha jisne chalan band kar diya.',
  'The gap does not have to be long. It has to be somewhere.',
  'अंतराल लंबा होना ज़रूरी नहीं। कहीं होना ज़रूरी है।',
  'Antaral lamba hona zaroori nahi. Kahin hona zaroori hai.',
  NULL, 'beginner', 'home,commute,transition,small-steps'

  UNION ALL SELECT 12, 'startup', 1,
  'Two founders, the same pitch', 'दो संस्थापक, वही पिच', 'Do founders, wahi pitch',
  'Two people pitch the same company in the same week. One has decided in advance that this meeting decides whether the last two years were worth it. The other has decided the meeting is one of eleven. The pitch is word for word the same. One of them sleeps that night.',
  'दो लोग एक ही हफ़्ते में वही कंपनी पिच करते हैं। एक ने पहले से तय कर रखा है कि यह मीटिंग तय करेगी कि पिछले दो साल का कुछ मोल था या नहीं। दूसरे ने तय कर रखा है कि यह ग्यारह में से एक मीटिंग है। पिच शब्द-दर-शब्द वही है। उनमें से एक उस रात सोता है।',
  'Do log ek hi hafte mein wahi company pitch karte hain. Ek ne pehle se tay kar rakha hai ki yeh meeting tay karegi ki pichhle do saal ka kuch mol tha ya nahi. Doosre ne tay kar rakha hai ki yeh gyarah mein se ek meeting hai. Pitch shabd-dar-shabd wahi hai. Unme se ek us raat sota hai.',
  'The verse says the difference between the two is not in the work, and here the work is provably identical. What is different was decided before either of them walked in, and it is the thing the verse calls being tied to the result.',
  'श्लोक कहता है कि दोनों में फ़र्क़ काम में नहीं है, और यहाँ काम साबित तौर पर एक जैसा है। जो अलग है वह दोनों के अंदर जाने से पहले तय हो चुका था, और वही है जिसे श्लोक नतीजे से बँधा होना कहता है।',
  'Shloka kehta hai ki dono mein farq kaam mein nahi hai, aur yahan kaam saabit taur par ek jaisa hai. Jo alag hai woh dono ke andar jaane se pehle tay ho chuka tha, aur wahi hai jise shloka nateeje se bandha hona kehta hai.',
  'What the meeting is allowed to decide was settled before the meeting.',
  'मीटिंग को क्या तय करने की इजाज़त है, यह मीटिंग से पहले तय हो चुका था।',
  'Meeting ko kya tay karne ki ijazat hai, yeh meeting se pehle tay ho chuka tha.',
  NULL, 'intermediate', 'startups,pitching,stakes,outcomes'

  UNION ALL SELECT 12, 'school', 2,
  'Two teachers, one syllabus', 'दो शिक्षक, एक पाठ्यक्रम', 'Do shikshak, ek syllabus',
  'Two teachers cover the same chapter in the same fortnight. One of them checks the class average after every test and adjusts her mood accordingly. The other checks it too, writes down what to redo, and goes home. Their averages are within two marks of each other, every term, for four years.',
  'दो शिक्षक एक ही पखवाड़े में वही अध्याय पढ़ाते हैं। एक हर टेस्ट के बाद क्लास का औसत देखती है और उसी हिसाब से अपना मिज़ाज तय करती है। दूसरी भी देखती है, लिखती है कि क्या दोबारा करना है, और घर चली जाती है। चार साल तक, हर सत्र, उनके औसत में दो अंक का ही फ़र्क़ रहता है।',
  'Do shikshak ek hi pakhwade mein wahi adhyay padhate hain. Ek har test ke baad class ka ausat dekhti hai aur usi hisaab se apna mizaaj tay karti hai. Doosri bhi dekhti hai, likhti hai ki kya dobara karna hai, aur ghar chali jaati hai. Chaar saal tak, har satra, unke ausat mein do ank ka hi farq rehta hai.',
  'Both of them look at the number, which matters, because the verse is not against looking. The second one uses it and the first one is used by it. Four years of near-identical results is the verse''s own argument: the attachment did not improve the teaching.',
  'दोनों आँकड़ा देखती हैं, और यह मायने रखता है, क्योंकि श्लोक देखने के ख़िलाफ़ नहीं है। दूसरी उसका इस्तेमाल करती है और पहली का इस्तेमाल वह करता है। चार साल के लगभग एक जैसे नतीजे ख़ुद श्लोक की दलील हैं: चिपकने से पढ़ाना बेहतर नहीं हुआ।',
  'Dono aankda dekhti hain, aur yeh maayne rakhta hai, kyunki shloka dekhne ke khilaf nahi hai. Doosri uska istemaal karti hai aur pehli ka istemaal woh karta hai. Chaar saal ke lagbhag ek jaise nateeje khud shloka ki dalil hain: chipakne se padhana behtar nahi hua.',
  'Looking at the result is fine. Being told how to feel by it is the tie.',
  'नतीजा देखना ठीक है। उससे यह तय होना कि कैसा महसूस करना है — वही बंधन है।',
  'Nateeja dekhna theek hai. Usse yeh tay hona ki kaisa mehsoos karna hai — wahi bandhan hai.',
  NULL, 'beginner', 'teaching,results,mood,measurement'

  UNION ALL SELECT 12, 'relationships', 3,
  'The dinner that was cooked anyway', 'वह खाना जो फिर भी बना', 'Woh khana jo phir bhi bana',
  'Somebody cooks for a partner who has been distant for a fortnight. Halfway through, they notice they are cooking in order to be thanked, and that they have been rehearsing what they will feel if they are not. They finish the meal. They do not stop wanting the thanks. They just stop rehearsing.',
  'कोई अपने साथी के लिए खाना बनाता है जो पखवाड़े भर से दूर-दूर है। बीच में उसे लगता है कि वह शुक्रिया पाने के लिए बना रहा है, और यह भी कि वह मन ही मन तैयारी कर रहा है कि शुक्रिया न मिला तो क्या महसूस करेगा। वह खाना पूरा करता है। शुक्रिया की चाह ख़त्म नहीं होती। बस वह तैयारी करना बंद कर देता है।',
  'Koi apne saathi ke liye khana banata hai jo pakhwade bhar se door-door hai. Beech mein use lagta hai ki woh shukriya paane ke liye bana raha hai, aur yeh bhi ki woh man hi man taiyari kar raha hai ki shukriya na mila to kya mehsoos karega. Woh khana poora karta hai. Shukriya ki chaah khatam nahi hoti. Bas woh taiyari karna band kar deta hai.',
  'The verse describes two people, and this is one person crossing from one to the other in the middle of a task. The wanting did not have to go. What went was the rehearsal, which is what being tied to a result actually feels like from inside.',
  'श्लोक दो लोगों का वर्णन करता है, और यह एक इंसान है जो काम के बीच में एक से दूसरे की तरफ़ चला जाता है। चाह को जाना ज़रूरी नहीं था। जो गई वह तैयारी थी, और नतीजे से बँधा होना भीतर से असल में यही महसूस होता है।',
  'Shloka do logon ka varnan karta hai, aur yeh ek insaan hai jo kaam ke beech mein ek se doosre ki taraf chala jaata hai. Chaah ko jaana zaroori nahi tha. Jo gayi woh taiyari thi, aur nateeje se bandha hona bheetar se asal mein yahi mehsoos hota hai.',
  'You can want the thanks. The tie is in rehearsing what you will feel without it.',
  'शुक्रिया चाहना चल सकता है। बंधन इसमें है कि उसके बिना क्या महसूस करेंगे, इसकी पहले से तैयारी हो।',
  'Shukriya chahna chal sakta hai. Bandhan isme hai ki uske bina kya mehsoos karenge, iski pehle se taiyari ho.',
  NULL, 'intermediate', 'partners,giving,expectation,resentment'

  UNION ALL SELECT 12, 'everyday_life', 4,
  'Sent, then put down', 'भेजा, फिर रख दिया', 'Bheja, phir rakh diya',
  'A person sends a difficult message they have owed somebody for weeks. Then they put the phone in a drawer for the evening. The message is exactly as good as it was going to be. The evening is the part they got back.',
  'कोई वह मुश्किल संदेश भेजता है जो हफ़्तों से किसी को देना था। फिर शाम भर के लिए फ़ोन दराज़ में रख देता है। संदेश उतना ही अच्छा है जितना होने वाला था। शाम वह हिस्सा है जो उसे वापस मिला।',
  'Koi woh mushkil message bhejta hai jo hafton se kisi ko dena tha. Phir shaam bhar ke liye phone daraz mein rakh deta hai. Message utna hi achha hai jitna hone wala tha. Shaam woh hissa hai jo use wapas mila.',
  'This is the cheapest version of the verse anybody can run. The work was done well. What the drawer removes is the several hours of watching for a reply, which improve nothing about the message and are the entire difference between the two people in the verse.',
  'यह श्लोक का सबसे सस्ता रूप है जो कोई भी आज़मा सकता है। काम अच्छे से हुआ। दराज़ जो हटाती है वह हैं जवाब की ताक में बीतने वाले कई घंटे, जो संदेश में कुछ बेहतर नहीं करते और श्लोक के दो लोगों में पूरा फ़र्क़ बस यही है।',
  'Yeh shloka ka sabse sasta roop hai jo koi bhi aazma sakta hai. Kaam achhe se hua. Daraz jo hatati hai woh hain jawab ki taak mein beetne wale kai ghante, jo message mein kuch behtar nahi karte aur shloka ke do logon mein poora farq bas yahi hai.',
  'Waiting for the reply does not improve the message. It only spends the evening.',
  'जवाब का इंतज़ार संदेश को बेहतर नहीं करता। वह बस शाम ख़र्च करता है।',
  'Jawab ka intezaar message ko behtar nahi karta. Woh bas shaam kharch karta hai.',
  NULL, 'beginner', 'messages,waiting,letting-go,evening'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 5;

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

  SELECT 18 AS vn, 'healthcare' AS cat, 1 AS ord,
  'The two-minute difference' AS t_en, 'दो मिनट का फ़र्क़' AS t_hi, 'Do minute ka farq' AS t_hing,
  'A junior doctor times herself for a week, quietly, out of suspicion. She finds she spends about two minutes longer with patients who speak to her in English than with patients who do not. Nobody had ever complained. She had not noticed. The number is small and it is there every single day.' AS s_en,
  'एक जूनियर डॉक्टर एक हफ़्ते तक चुपचाप, शक के मारे, ख़ुद का समय नापती है। उसे पता चलता है कि जो मरीज़ उससे अंग्रेज़ी में बात करते हैं, उनके साथ वह क़रीब दो मिनट ज़्यादा बिताती है। किसी ने कभी शिकायत नहीं की थी। उसने ध्यान नहीं दिया था। आँकड़ा छोटा है और हर एक दिन मौजूद है।' AS s_hi,
  'Ek junior doctor ek hafte tak chupchap, shak ke maare, khud ka samay naapti hai. Use pata chalta hai ki jo mareez usse English mein baat karte hain, unke saath woh kareeb do minute zyada bitati hai. Kisi ne kabhi shikayat nahi ki thi. Usne dhyan nahi diya tha. Aankda chhota hai aur har ek din maujood hai.' AS s_hing,
  'The verse is about seeing, and this is what unequal seeing looks like when it is measured instead of argued about. She is not a bad doctor and the verse is not calling her one. It is saying the sorting happens below the level where she would have caught it, which is why she had to time it to find out.' AS c_en,
  'श्लोक देखने के बारे में है, और असमान देखना तब ऐसा दिखता है जब उस पर बहस के बजाय उसे नापा जाए। वह बुरी डॉक्टर नहीं है और श्लोक उसे बुरा कह भी नहीं रहा। वह कह रहा है कि छँटाई उस स्तर से नीचे होती है जहाँ वह उसे पकड़ पाती, इसीलिए पता करने के लिए उसे नापना पड़ा।' AS c_hi,
  'Shloka dekhne ke baare mein hai, aur asaman dekhna tab aisa dikhta hai jab us par behes ke bajaye use naapa jaaye. Woh buri doctor nahi hai aur shloka use bura keh bhi nahi raha. Woh keh raha hai ki chhantai us star se neeche hoti hai jahan woh use pakad paati, isiliye pata karne ke liye use naapna pada.' AS c_hing,
  'The sorting happens under the place where you would have caught it. That is why the verse is about seeing and not about opinions.' AS l_en,
  'छँटाई उस जगह से नीचे होती है जहाँ आप उसे पकड़ पाते। इसीलिए श्लोक देखने के बारे में है, राय के बारे में नहीं।' AS l_hi,
  'Chhantai us jagah se neeche hoti hai jahan tum use pakad paate. Isiliye shloka dekhne ke baare mein hai, raay ke baare mein nahi.' AS l_hing,
  NULL AS src, 'intermediate' AS diff, 'medicine,bias,attention,measurement,honesty' AS tags

  UNION ALL SELECT 18, 'school', 2,
  'Whose parents get called back', 'किसके माता-पिता को दोबारा फ़ोन जाता है', 'Kiske maa-baap ko dobara phone jaata hai',
  'A school looks at a year of its own phone records and finds that when a child is doing badly, some families get a call within a week and some get one within a month. Nobody in the staff room can point to a decision that produced this. It came out of a hundred small judgements about who would pick up.',
  'एक स्कूल अपने ही साल भर के फ़ोन रिकॉर्ड देखता है और पाता है कि जब कोई बच्चा ख़राब कर रहा हो तो कुछ परिवारों को हफ़्ते भर में फ़ोन जाता है और कुछ को महीने भर में। स्टाफ़ रूम में कोई ऐसा फ़ैसला नहीं बता सकता जिससे यह हुआ हो। यह सौ छोटे-छोटे अंदाज़ों से निकला कि कौन फ़ोन उठाएगा।',
  'Ek school apne hi saal bhar ke phone record dekhta hai aur paata hai ki jab koi bachcha kharab kar raha ho to kuch parivaron ko hafte bhar mein phone jaata hai aur kuch ko mahine bhar mein. Staff room mein koi aisa faisla nahi bata sakta jisse yeh hua ho. Yeh sau chhote chhote andaazon se nikla ki kaun phone uthayega.',
  'The verse puts five very different beings in one line and says the ones who see, see the same in all of them. This is the same claim read from the other end: where the seeing is uneven, it shows up as a delay, a tone, a second chance offered to one and not another. It rarely shows up as a stated opinion.',
  'श्लोक पाँच बहुत अलग प्राणियों को एक पंक्ति में रखता है और कहता है कि जो देखते हैं वे सबमें वही देखते हैं। यह वही दावा दूसरे सिरे से पढ़ा गया है: जहाँ देखना असमान है, वह देरी, लहजे, और एक को मिलने वाले दूसरे मौक़े के रूप में दिखता है जो किसी और को नहीं मिलता। वह शायद ही कभी कही हुई राय के रूप में दिखता है।',
  'Shloka paanch bahut alag praniyon ko ek line mein rakhta hai aur kehta hai ki jo dekhte hain woh sabme wahi dekhte hain. Yeh wahi dawa doosre sire se padha gaya hai: jahan dekhna asaman hai, woh deri, lehje, aur ek ko milne wale doosre mauke ke roop mein dikhta hai jo kisi aur ko nahi milta. Woh shayad hi kabhi kahi hui raay ke roop mein dikhta hai.',
  'Unequal seeing rarely announces itself. It shows up as who got called back.',
  'असमान देखना शायद ही ख़ुद को घोषित करता है। वह इस रूप में दिखता है कि दोबारा फ़ोन किसे गया।',
  'Asaman dekhna shayad hi khud ko ghoshit karta hai. Woh is roop mein dikhta hai ki dobara phone kise gaya.',
  NULL, 'intermediate', 'school,fairness,delay,unnoticed'

  UNION ALL SELECT 18, 'corporate', 3,
  'The name he never learned', 'वह नाम जो उसने कभी नहीं सीखा', 'Woh naam jo usne kabhi nahi seekha',
  'Somebody has worked in the same building for six years. He knows the names of everybody on his floor, the names of two people in finance, and the name of nobody who cleans the floor he works on, although one of them has been there longer than he has.',
  'कोई छह साल से उसी इमारत में काम कर रहा है। वह अपनी मंज़िल के सब लोगों के नाम जानता है, फ़ाइनेंस के दो लोगों के नाम जानता है, और जिस मंज़िल पर वह काम करता है उसकी सफ़ाई करने वाले किसी का नाम नहीं जानता, जबकि उनमें से एक उससे ज़्यादा पुराना है।',
  'Koi chhah saal se usi imaarat mein kaam kar raha hai. Woh apni manzil ke sab logon ke naam jaanta hai, finance ke do logon ke naam jaanta hai, aur jis manzil par woh kaam karta hai uski safai karne wale kisi ka naam nahi jaanta, jabki unme se ek usse zyada purana hai.',
  'Nobody decided this and that is the point of putting it next to the verse. He would say, correctly, that he has nothing against anybody. The verse is not asking about that. It is asking what his eyes did on the way to his desk, six years running.',
  'यह किसी ने तय नहीं किया और श्लोक के बग़ल में इसे रखने की वजह यही है। वह कहेगा, और सही कहेगा, कि उसे किसी से कोई बैर नहीं। श्लोक यह पूछ ही नहीं रहा। वह पूछ रहा है कि छह साल तक, अपनी मेज़ तक जाते हुए, उसकी आँखों ने क्या किया।',
  'Yeh kisi ne tay nahi kiya aur shloka ke bagal mein ise rakhne ki wajah yahi hai. Woh kahega, aur sahi kahega, ki use kisi se koi bair nahi. Shloka yeh poochh hi nahi raha. Woh poochh raha hai ki chhah saal tak, apni mez tak jaate hue, uski aankhon ne kya kiya.',
  'Having nothing against somebody and having seen them are different achievements.',
  'किसी से बैर न होना और उसे देखा होना — ये दो अलग उपलब्धियाँ हैं।',
  'Kisi se bair na hona aur use dekha hona — yeh do alag uplabdhiyan hain.',
  NULL, 'beginner', 'work,invisibility,names,noticing'

  UNION ALL SELECT 18, 'everyday_life', 4,
  'The reader who agreed too fast', 'वह पाठक जो बहुत जल्दी सहमत हो गया', 'Woh paathak jo bahut jaldi sehmat ho gaya',
  'Somebody reads this verse and feels good about it, and then remembers that the same book contains 4.13, and feels less good. Then they notice that the good feeling had arrived in about a second, before they had done anything at all, and that the verse had been used to award it.',
  'कोई यह श्लोक पढ़ता है और उसे अच्छा लगता है, फिर याद आता है कि उसी किताब में 4.13 भी है, और अच्छा लगना कम हो जाता है। फिर वह देखता है कि अच्छा लगना क़रीब एक सेकंड में आ गया था, इससे पहले कि उसने कुछ भी किया हो, और श्लोक का इस्तेमाल वह इनाम देने के लिए हुआ था।',
  'Koi yeh shloka padhta hai aur use achha lagta hai, phir yaad aata hai ki usi kitaab mein 4.13 bhi hai, aur achha lagna kam ho jaata hai. Phir woh dekhta hai ki achha lagna kareeb ek second mein aa gaya tha, isse pehle ki usne kuch bhi kiya ho, aur shloka ka istemaal woh inaam dene ke liye hua tha.',
  'This is the honest reading and it is uncomfortable in both directions. Using 5.18 to prove the tradition was always equal is the same move as using 4.13 to prove the opposite, run backwards. Both verses are in the book. This one is the one that levels, and its worth is that it exists and says what it says.',
  'यही ईमानदार पाठ है और यह दोनों तरफ़ से असहज है। 5.18 से यह साबित करना कि परंपरा हमेशा बराबरी वाली थी, वही चाल है जो 4.13 से उलटा साबित करना — बस उल्टी दिशा में। दोनों श्लोक किताब में हैं। यह वह है जो बराबर करता है, और इसका मोल यह है कि यह मौजूद है और जो कहता है वह कहता है।',
  'Yahi imaandaar paath hai aur yeh dono taraf se asahaj hai. 5.18 se yeh saabit karna ki parampara hamesha barabari wali thi, wahi chaal hai jo 4.13 se ulta saabit karna — bas ulti disha mein. Dono shloka kitaab mein hain. Yeh woh hai jo barabar karta hai, aur iska mol yeh hai ki yeh maujood hai aur jo kehta hai woh kehta hai.',
  'Agreeing with a verse in one second is not the same as being changed by it.',
  'एक सेकंड में किसी श्लोक से सहमत हो जाना उससे बदल जाना नहीं है।',
  'Ek second mein kisi shloka se sehmat ho jaana usse badal jaana nahi hai.',
  NULL, 'advanced', 'reading,honesty,self-congratulation,texts'

  UNION ALL SELECT 21, 'social_media', 1,
  'The evening that was already good', 'वह शाम जो पहले से अच्छी थी', 'Woh shaam jo pehle se achhi thi',
  'Somebody has a quiet, unremarkable, contented evening. Around nine o''clock they photograph part of it and post it, and then check the post eleven times. By eleven the evening has become a thing that is either doing well or not doing well, and it was not that at seven.',
  'किसी की शाम शांत, मामूली और संतुष्ट बीत रही है। नौ बजे के आसपास वह उसका एक हिस्सा तस्वीर में लेकर पोस्ट कर देता है, और फिर ग्यारह बार पोस्ट देखता है। ग्यारह बजे तक शाम ऐसी चीज़ बन चुकी है जो या तो चल रही है या नहीं चल रही, और सात बजे वह ऐसी नहीं थी।',
  'Kisi ki shaam shaant, mamooli aur santusht beet rahi hai. Nau baje ke aas paas woh uska ek hissa tasveer mein lekar post kar deta hai, aur phir gyarah baar post dekhta hai. Gyarah baje tak shaam aisi cheez ban chuki hai jo ya to chal rahi hai ya nahi chal rahi, aur saat baje woh aisi nahi thi.',
  'The verse locates a kind of happiness that is not made of things arriving. Here is the same evening before and after it was hooked up to arrivals. Nothing about the room changed. What changed is that the room now needed something from outside it to be confirmed.',
  'श्लोक एक ऐसे सुख की जगह बताता है जो आने वाली चीज़ों से नहीं बना। यहाँ वही शाम है, आने वाली चीज़ों से जुड़ने से पहले और बाद में। कमरे में कुछ नहीं बदला। बदला यह कि अब कमरे को अपनी पुष्टि के लिए बाहर से कुछ चाहिए था।',
  'Shloka ek aise sukh ki jagah batata hai jo aane wali cheezon se nahi bana. Yahan wahi shaam hai, aane wali cheezon se judne se pehle aur baad mein. Kamre mein kuch nahi badla. Badla yeh ki ab kamre ko apni pushti ke liye bahar se kuch chahiye tha.',
  'It was already good at seven. What arrived after nine could only take marks off.',
  'सात बजे वह पहले से अच्छी थी। नौ बजे के बाद जो आया वह सिर्फ़ अंक काट सकता था।',
  'Saat baje woh pehle se achhi thi. Nau baje ke baad jo aaya woh sirf ank kaat sakta tha.',
  NULL, 'beginner', 'social-media,contentment,validation,evening'

  UNION ALL SELECT 21, 'finance', 2,
  'The raise that lasted nine days', 'वह बढ़ोतरी जो नौ दिन चली', 'Woh badhotri jo nau din chali',
  'Somebody gets a significant raise. They are lighter for about nine days. On the tenth day they are exactly as they were on the day before the raise, with more money, and they notice this and are briefly annoyed by it, and then they forget again.',
  'किसी की तनख़्वाह अच्छी-ख़ासी बढ़ती है। क़रीब नौ दिन वह हल्का रहता है। दसवें दिन वह ठीक वैसा ही है जैसा बढ़ोतरी से पहले वाले दिन था, बस पैसे ज़्यादा हैं, और उसे यह दिखता है और थोड़ी देर खीझ होती है, और फिर वह भूल जाता है।',
  'Kisi ki tankhwah achhi khaasi badhti hai. Kareeb nau din woh halka rehta hai. Dasve din woh theek waisa hi hai jaisa badhotri se pehle wale din tha, bas paise zyada hain, aur use yeh dikhta hai aur thodi der kheejh hoti hai, aur phir woh bhool jaata hai.',
  'The verse says a certain kind of happiness does not run out, and the useful way to hear that is by contrast. This one ran out on a Thursday and could be dated. That is not an argument against raises, which are useful. It is an observation about which shelf that particular thing was on.',
  'श्लोक कहता है कि एक तरह का सुख चुकता नहीं, और इसे सुनने का काम का तरीक़ा तुलना से है। यह वाला गुरुवार को चुक गया और उसकी तारीख़ बताई जा सकती है। यह बढ़ोतरी के ख़िलाफ़ दलील नहीं है, जो काम की चीज़ है। यह इस बारे में है कि वह ख़ास चीज़ किस ताक़ पर रखी थी।',
  'Shloka kehta hai ki ek tarah ka sukh chukta nahi, aur ise sunne ka kaam ka tareeka tulna se hai. Yeh wala Thursday ko chuk gaya aur uski tareekh batai ja sakti hai. Yeh badhotri ke khilaf dalil nahi hai, jo kaam ki cheez hai. Yeh is baare mein hai ki woh khaas cheez kis taak par rakhi thi.',
  'The raise was worth having. It was just never going to be the thing that does not run out.',
  'बढ़ोतरी पाने लायक़ थी। वह बस कभी वह चीज़ थी ही नहीं जो चुकती नहीं।',
  'Badhotri paane layak thi. Woh bas kabhi woh cheez thi hi nahi jo chukti nahi.',
  NULL, 'beginner', 'money,adaptation,contentment,expectations'

  UNION ALL SELECT 21, 'friendship', 3,
  'Nothing happened all afternoon', 'पूरी दोपहर कुछ नहीं हुआ', 'Poori dopahar kuch nahi hua',
  'Two old friends spend an afternoon together in which nothing is planned, nothing is celebrated and nothing much is said. Afterwards, separately, both of them describe it as the best day either has had in months, and neither can name what was in it.',
  'दो पुराने दोस्त एक दोपहर साथ बिताते हैं जिसमें कुछ तय नहीं है, कुछ मनाया नहीं जाता और ख़ास कुछ कहा भी नहीं जाता। बाद में, अलग-अलग, दोनों उसे महीनों का सबसे अच्छा दिन बताते हैं, और कोई नहीं बता पाता कि उसमें था क्या।',
  'Do purane dost ek dopahar saath bitate hain jisme kuch tay nahi hai, kuch manaya nahi jaata aur khaas kuch kaha bhi nahi jaata. Baad mein, alag alag, dono use mahinon ka sabse achha din batate hain, aur koi nahi bata paata ki usme tha kya.',
  'They cannot name it because it was not made of anything that arrived. This is the everyday form of what the verse is pointing at, and it explains why it is so hard to repeat on purpose: people go back and try to reassemble the afternoon out of its parts, and the parts were never where it was.',
  'वे बता नहीं पाते क्योंकि वह किसी आने वाली चीज़ से बना ही नहीं था। श्लोक जिस तरफ़ इशारा कर रहा है, यह उसका रोज़मर्रा वाला रूप है, और यही बताता है कि जानबूझकर उसे दोहराना इतना मुश्किल क्यों है: लोग लौटकर उस दोपहर को उसके हिस्सों से दोबारा जोड़ने की कोशिश करते हैं, और वह हिस्सों में कभी थी ही नहीं।',
  'Woh bata nahi paate kyunki woh kisi aane wali cheez se bana hi nahi tha. Shloka jis taraf ishara kar raha hai, yeh uska rozmarra wala roop hai, aur yahi batata hai ki jaanboojhkar use dohrana itna mushkil kyun hai: log lautkar us dopahar ko uske hisson se dobara jodne ki koshish karte hain, aur woh hisson mein kabhi thi hi nahi.',
  'You cannot rebuild it from its parts, because it was never in the parts.',
  'आप उसे उसके हिस्सों से दोबारा नहीं बना सकते, क्योंकि वह हिस्सों में कभी थी ही नहीं।',
  'Tum use uske hisson se dobara nahi bana sakte, kyunki woh hisson mein kabhi thi hi nahi.',
  NULL, 'beginner', 'friendship,contentment,unrepeatable,quiet'

  UNION ALL SELECT 21, 'everyday_life', 4,
  'She kept buying the same candle', 'वह वही मोमबत्ती ख़रीदती रही', 'Woh wahi mombatti khareedti rahi',
  'Somebody had one very good week and, without quite deciding to, has been reproducing its furniture ever since — the same tea, the same candle, the same route. None of it works. It is not that these things are bad. It is that she is looking for the week in its props.',
  'किसी का एक बहुत अच्छा हफ़्ता बीता और तब से, बिना ठीक-ठीक तय किए, वह उसका सामान दोहराती आ रही है — वही चाय, वही मोमबत्ती, वही रास्ता। कुछ काम नहीं करता। बात यह नहीं कि ये चीज़ें बुरी हैं। बात यह है कि वह उस हफ़्ते को उसके सामान में ढूँढ़ रही है।',
  'Kisi ka ek bahut achha hafta beeta aur tab se, bina theek theek tay kiye, woh uska saman dohrati aa rahi hai — wahi chai, wahi mombatti, wahi raasta. Kuch kaam nahi karta. Baat yeh nahi ki yeh cheezein buri hain. Baat yeh hai ki woh us hafte ko uske saman mein dhoondh rahi hai.',
  'The verse says this thing is not stuck to what comes in from outside, and the candle is what comes in from outside. It is not being condemned. It is simply being asked to do a job it was never doing. The week was not made of the candle; the candle was in the week.',
  'श्लोक कहता है कि यह चीज़ बाहर से आने वाली चीज़ों से चिपकी नहीं है, और मोमबत्ती बाहर से आने वाली चीज़ है। उसकी निंदा नहीं हो रही। उससे बस वह काम माँगा जा रहा है जो वह कभी कर ही नहीं रही थी। हफ़्ता मोमबत्ती से बना नहीं था; मोमबत्ती हफ़्ते में थी।',
  'Shloka kehta hai ki yeh cheez bahar se aane wali cheezon se chipki nahi hai, aur mombatti bahar se aane wali cheez hai. Uski ninda nahi ho rahi. Usse bas woh kaam maanga ja raha hai jo woh kabhi kar hi nahi rahi thi. Hafta mombatti se bana nahi tha; mombatti hafte mein thi.',
  'The candle was in the week. The week was not in the candle.',
  'मोमबत्ती हफ़्ते में थी। हफ़्ता मोमबत्ती में नहीं था।',
  'Mombatti hafte mein thi. Hafta mombatti mein nahi tha.',
  NULL, 'beginner', 'habits,nostalgia,contentment,objects'

  UNION ALL SELECT 22, 'relationships', 1,
  'He still calls every Sunday', 'वह अब भी हर रविवार फ़ोन करता है', 'Woh ab bhi har Sunday phone karta hai',
  'A man in his forties speaks to his mother every Sunday and enjoys it. He has also, at some point, made those calls the place where he goes to be told he turned out fine. He has not stopped calling and does not intend to. What he has started doing is noticing which of the two he is doing on a given Sunday.',
  'चालीस पार का एक आदमी हर रविवार अपनी माँ से बात करता है और उसे अच्छा लगता है। कभी न कभी उसने उन फ़ोनों को वह जगह भी बना लिया है जहाँ वह यह सुनने जाता है कि वह ठीक निकला। उसने फ़ोन करना बंद नहीं किया और न ही इरादा है। उसने शुरू यह किया है कि वह देखता है कि किसी रविवार को वह इन दोनों में से क्या कर रहा है।',
  'Chalees paar ka ek aadmi har Sunday apni maa se baat karta hai aur use achha lagta hai. Kabhi na kabhi usne un phonon ko woh jagah bhi bana liya hai jahan woh yeh sunne jaata hai ki woh theek nikla. Usne phone karna band nahi kiya aur na hi iraada hai. Usne shuru yeh kiya hai ki woh dekhta hai ki kisi Sunday ko woh in dono mein se kya kar raha hai.',
  'The verse says the wise one does not set up house in these things. It does not say leave them. He kept every Sunday. What he took out of the house was the load-bearing wall — the part where his sense of having turned out fine was resting on a call that will one day not happen.',
  'श्लोक कहता है कि ज्ञानी इन चीज़ों में घर नहीं बसाता। यह नहीं कहता कि इन्हें छोड़ दो। उसने हर रविवार रखा। उसने घर से जो निकाला वह भार उठाने वाली दीवार थी — वह हिस्सा जहाँ उसका ठीक निकलने का एहसास एक ऐसे फ़ोन पर टिका था जो किसी दिन नहीं होगा।',
  'Shloka kehta hai ki gyani in cheezon mein ghar nahi basata. Yeh nahi kehta ki inhe chhod do. Usne har Sunday rakha. Usne ghar se jo nikala woh bhaar uthane wali deewar thi — woh hissa jahan uska theek nikalne ka ehsaas ek aise phone par tika tha jo kisi din nahi hoga.',
  'Keep the Sunday. Move the load-bearing wall.',
  'रविवार रखिए। भार उठाने वाली दीवार हटाइए।',
  'Sunday rakho. Bhaar uthane wali deewar hatao.',
  NULL, 'intermediate', 'family,dependence,impermanence,routine'

  UNION ALL SELECT 22, 'sports', 2,
  'The last season', 'आख़िरी सीज़न', 'Aakhiri season',
  'A club player in her thirties knows she has three or four seasons left. She plays every one of them and enjoys them more than the earlier ones. She has also, quietly, started coaching on Tuesdays. Both facts are about the same date on the calendar.',
  'तीस पार की एक क्लब खिलाड़ी जानती है कि उसके पास तीन-चार सीज़न बचे हैं। वह हर एक खेलती है और पहले वालों से ज़्यादा उनका मज़ा लेती है। उसने चुपचाप मंगलवार को कोचिंग देना भी शुरू कर दिया है। दोनों बातें कैलेंडर की एक ही तारीख़ के बारे में हैं।',
  'Tees paar ki ek club khilaadi jaanti hai ki uske paas teen chaar season bache hain. Woh har ek khelti hai aur pehle walon se zyada unka maza leti hai. Usne chupchap Tuesday ko coaching dena bhi shuru kar diya hai. Dono baatein calendar ki ek hi tareekh ke baare mein hain.',
  'Ādi-antavantaḥ — they have a beginning and an end. She has read that correctly, which is why the enjoyment went up rather than down. Knowing a thing ends is not the same as withdrawing from it. Setting up house would have been having no Tuesday.',
  'आद्यन्तवन्तः — उनका आरंभ है और अंत है। उसने इसे सही पढ़ा है, इसीलिए मज़ा कम होने के बजाय बढ़ा। किसी चीज़ का अंत जानना उससे हट जाना नहीं है। घर बसाना यह होता कि कोई मंगलवार होता ही नहीं।',
  'Adi-antavantah — unka aarambh hai aur ant hai. Usne ise sahi padha hai, isiliye maza kam hone ke bajaye badha. Kisi cheez ka ant jaanna usse hat jaana nahi hai. Ghar basana yeh hota ki koi Tuesday hota hi nahi.',
  'Knowing it ends made the season better, not smaller.',
  'यह जानने से कि यह ख़त्म होगा, सीज़न बेहतर हुआ, छोटा नहीं।',
  'Yeh jaanne se ki yeh khatam hoga, season behtar hua, chhota nahi.',
  NULL, 'intermediate', 'sport,ageing,impermanence,enjoyment'

  UNION ALL SELECT 22, 'corporate', 3,
  'The title on the email signature', 'ईमेल सिग्नेचर वाला ओहदा', 'Email signature wala ohda',
  'Somebody is promoted and genuinely likes the new title. Eight months later the company reorganises and the title goes. What actually hurts, he finds, is not the work he lost — the work barely changed — but the number of conversations he had held over the previous eight months in which the title was doing the standing.',
  'किसी की तरक़्क़ी होती है और उसे नया ओहदा सचमुच पसंद है। आठ महीने बाद कंपनी में फेरबदल होता है और ओहदा चला जाता है। असल में जो चुभता है, वह पाता है, वह खोया हुआ काम नहीं है — काम में शायद ही कुछ बदला — बल्कि पिछले आठ महीनों की वे तमाम बातचीतें हैं जिनमें खड़े रहने का काम ओहदा कर रहा था।',
  'Kisi ki tarakki hoti hai aur use naya ohda sach mein pasand hai. Aath mahine baad company mein pherbadal hota hai aur ohda chala jaata hai. Asal mein jo chubhta hai, woh paata hai, woh khoya hua kaam nahi hai — kaam mein shayad hi kuch badla — balki pichhle aath mahinon ki woh tamaam baatcheetein hain jinme khade rehne ka kaam ohda kar raha tha.',
  'The verse is precise about where the sorrow comes from: the same place the pleasure did. Liking the title was never the problem and he does not have to pretend he did not. The house was the eight months of letting it stand in for him in rooms.',
  'श्लोक इस बारे में साफ़ है कि दुख कहाँ से आता है: उसी जगह से जहाँ से सुख आया था। ओहदा पसंद आना कभी दिक़्क़त नहीं थी और उसे यह दिखावा नहीं करना है कि पसंद नहीं आया था। घर वे आठ महीने थे जिनमें कमरों में उसकी जगह ओहदा खड़ा रहा।',
  'Shloka is baare mein saaf hai ki dukh kahan se aata hai: usi jagah se jahan se sukh aaya tha. Ohda pasand aana kabhi dikkat nahi thi aur use yeh dikhava nahi karna hai ki pasand nahi aaya tha. Ghar woh aath mahine the jinme kamron mein uski jagah ohda khada raha.',
  'Enjoying the title cost nothing. Letting it stand in for you is where the bill was.',
  'ओहदे का आनंद लेने में कुछ नहीं गया। उसे अपनी जगह खड़ा करने में बिल बना।',
  'Ohde ka anand lene mein kuch nahi gaya. Use apni jagah khada karne mein bill bana.',
  NULL, 'intermediate', 'work,status,identity,reorganisation'

  UNION ALL SELECT 22, 'everyday_life', 4,
  'The good chair', 'अच्छी कुर्सी', 'Achhi kursi',
  'A family has a chair everybody likes. It breaks. There is a bad week about it that everybody agrees is disproportionate. Later somebody works out that the chair had become the place where three separate evening routines met, and that it was the routines that broke.',
  'एक परिवार में एक कुर्सी है जो सबको पसंद है। वह टूट जाती है। उसे लेकर एक बुरा हफ़्ता बीतता है जिसे सब मानते हैं कि ज़रूरत से ज़्यादा है। बाद में किसी की समझ में आता है कि वह कुर्सी वह जगह बन चुकी थी जहाँ शाम की तीन अलग-अलग आदतें मिलती थीं, और टूटीं दरअसल वे आदतें।',
  'Ek parivar mein ek kursi hai jo sabko pasand hai. Woh toot jaati hai. Use lekar ek bura hafta beetta hai jise sab maante hain ki zaroorat se zyada hai. Baad mein kisi ki samajh mein aata hai ki woh kursi woh jagah ban chuki thi jahan shaam ki teen alag alag aadatein milti thin, aur tooteen darasal woh aadatein.',
  'Nobody in this story did anything wrong and nobody needs to stop liking chairs. The verse is only pointing at the mechanism: the sorrow was the exact size of what had been built there, which is why it was out of proportion to a chair and in proportion to what the chair was holding up.',
  'इस कहानी में किसी ने कुछ ग़लत नहीं किया और किसी को कुर्सियाँ पसंद करना बंद नहीं करना है। श्लोक बस तंत्र की तरफ़ इशारा कर रहा है: दुख ठीक उतना बड़ा था जितना वहाँ बनाया गया था, इसीलिए वह कुर्सी के हिसाब से ज़्यादा था और उस चीज़ के हिसाब से ठीक जिसे कुर्सी थामे हुए थी।',
  'Is kahani mein kisi ne kuch galat nahi kiya aur kisi ko kursiyan pasand karna band nahi karna hai. Shloka bas tantra ki taraf ishara kar raha hai: dukh theek utna bada tha jitna wahan banaya gaya tha, isiliye woh kursi ke hisaab se zyada tha aur us cheez ke hisaab se theek jise kursi thaame hue thi.',
  'The sorrow is the size of what was built there, not the size of the thing.',
  'दुख उतना बड़ा होता है जितना वहाँ बनाया गया था, उतना नहीं जितनी वह चीज़ है।',
  'Dukh utna bada hota hai jitna wahan banaya gaya tha, utna nahi jitni woh cheez hai.',
  NULL, 'beginner', 'home,loss,routine,proportion'

  UNION ALL SELECT 23, 'parenting', 1,
  'The thing he did not say at bath time', 'नहाने के वक़्त जो उसने नहीं कहा', 'Nahane ke waqt jo usne nahi kaha',
  'A parent at the end of a long day has a sentence fully formed and about to be said to a six-year-old. He puts a towel on the rail instead, which takes maybe four seconds. The sentence is still there afterwards. It is noticeably worse than the one he says a minute later.',
  'लंबे दिन के आख़िर में एक अभिभावक के मुँह में एक पूरा वाक्य तैयार है, छह साल के बच्चे से कहने ही वाला है। वह इसके बजाय तौलिया रैक पर टाँग देता है, जिसमें शायद चार सेकंड लगते हैं। वाक्य बाद में भी वहीं है। एक मिनट बाद वह जो कहता है, उससे यह साफ़ तौर पर बदतर है।',
  'Lambe din ke aakhir mein ek abhibhavak ke munh mein ek poora vakya taiyar hai, chhah saal ke bachche se kehne hi wala hai. Woh iske bajaye tauliya rack par taang deta hai, jisme shayad chaar second lagte hain. Vakya baad mein bhi wahin hai. Ek minute baad woh jo kehta hai, usse yeh saaf taur par badtar hai.',
  'Vega is a surge and a surge has a shape. Four seconds with a towel is not self-mastery and the verse does not ask for self-mastery. It asks for still being there at the end of the wave, and this is what the end of a wave is worth in a bathroom on a Tuesday.',
  'वेग उछाल है और उछाल का एक आकार होता है। तौलिये के साथ चार सेकंड आत्म-नियंत्रण नहीं है और श्लोक आत्म-नियंत्रण माँगता भी नहीं। वह लहर के अंत तक वहीं होने को कहता है, और मंगलवार को बाथरूम में लहर का अंत इतने का होता है।',
  'Veg ubhaar hai aur ubhaar ka ek aakar hota hai. Tauliye ke saath chaar second aatm-niyantran nahi hai aur shloka aatm-niyantran maangta bhi nahi. Woh lehar ke ant tak wahin hone ko kehta hai, aur Tuesday ko bathroom mein lehar ka ant itne ka hota hai.',
  'Four seconds is not self-mastery. It is the length of the wave, and that was enough.',
  'चार सेकंड आत्म-नियंत्रण नहीं है। यह लहर की लंबाई है, और इतना काफ़ी था।',
  'Chaar second aatm-niyantran nahi hai. Yeh lehar ki lambai hai, aur itna kaafi tha.',
  NULL, 'beginner', 'parenting,anger,pause,small-steps'

  UNION ALL SELECT 23, 'social_media', 2,
  'The reply he wrote in notes', 'वह जवाब जो उसने नोट्स में लिखा', 'Woh jawab jo usne notes mein likha',
  'Somebody is attacked in a comment thread and writes a devastating reply — in a notes app, deliberately, with no field to post it in. He reads it twice, and does not move it across. Two days later he reads it again and is glad about the field that was not there.',
  'कमेंट थ्रेड में किसी पर हमला होता है और वह एक कड़ा जवाब लिखता है — जानबूझकर नोट्स ऐप में, जहाँ पोस्ट करने की जगह ही नहीं है। वह उसे दो बार पढ़ता है और वहाँ से हटाता नहीं। दो दिन बाद वह उसे फिर पढ़ता है और ख़ुश होता है कि वह जगह थी ही नहीं।',
  'Comment thread mein kisi par hamla hota hai aur woh ek kada jawab likhta hai — jaanboojhkar notes app mein, jahan post karne ki jagah hi nahi hai. Woh use do baar padhta hai aur wahan se hatata nahi. Do din baad woh use phir padhta hai aur khush hota hai ki woh jagah thi hi nahi.',
  'The verse asks for holding the surge, not for not having it. He had it completely. He wrote all of it down. What he did was put it somewhere with no exit, which is a mechanical solution to a mechanical problem and exactly the size of what the verse asks.',
  'श्लोक वेग को थामने को कहता है, वेग न उठने को नहीं। उसे वेग पूरा आया। उसने वह सब लिख डाला। उसने बस उसे ऐसी जगह रखा जहाँ से निकास नहीं था, जो एक यांत्रिक समस्या का यांत्रिक हल है और ठीक उतना ही बड़ा है जितना श्लोक माँगता है।',
  'Shloka veg ko thaamne ko kehta hai, veg na uthne ko nahi. Use veg poora aaya. Usne woh sab likh dala. Usne bas use aisi jagah rakha jahan se nikaas nahi tha, jo ek yantrik samasya ka yantrik hal hai aur theek utna hi bada hai jitna shloka maangta hai.',
  'He did not have less anger. He had it somewhere with no send button.',
  'उसका गुस्सा कम नहीं था। वह बस ऐसी जगह था जहाँ भेजने का बटन नहीं था।',
  'Uska gussa kam nahi tha. Woh bas aisi jagah tha jahan bhejne ka button nahi tha.',
  NULL, 'beginner', 'anger,online,restraint,writing'

  UNION ALL SELECT 23, 'corporate', 3,
  'Twenty minutes before the meeting', 'मीटिंग से बीस मिनट पहले', 'Meeting se bees minute pehle',
  'Somebody gets news twenty minutes before a meeting they are running, and the news is bad and personal. They run the meeting. It is not their best. Afterwards they sit in the stairwell for a while. Nobody in the meeting knew, and nobody needed to.',
  'किसी को मीटिंग से बीस मिनट पहले ख़बर मिलती है, और ख़बर बुरी और निजी है, और मीटिंग वही चला रहा है। वह मीटिंग चलाता है। वह उसकी सबसे अच्छी नहीं होती। बाद में वह कुछ देर सीढ़ियों में बैठा रहता है। मीटिंग में किसी को पता नहीं था, और किसी को पता होना ज़रूरी भी नहीं था।',
  'Kisi ko meeting se bees minute pehle khabar milti hai, aur khabar buri aur niji hai, aur meeting wahi chala raha hai. Woh meeting chalata hai. Woh uski sabse achhi nahi hoti. Baad mein woh kuch der seedhiyon mein baitha rehta hai. Meeting mein kisi ko pata nahi tha, aur kisi ko pata hona zaroori bhi nahi tha.',
  'Iha eva — here, in this life, in the hour you were actually given. The verse is not describing a person who felt nothing during that meeting. It is describing somebody who was still standing at the end of it, and the stairwell afterwards is part of the description rather than a failure of it.',
  'इह एव — यहीं, इसी जीवन में, उसी घंटे में जो सचमुच मिला था। श्लोक ऐसे इंसान का वर्णन नहीं कर रहा जिसे उस मीटिंग में कुछ महसूस नहीं हुआ। वह उसका वर्णन कर रहा है जो उसके अंत तक खड़ा रहा, और बाद की वे सीढ़ियाँ वर्णन का हिस्सा हैं, उसकी नाकामी नहीं।',
  'Iha eva — yahin, isi jeevan mein, usi ghante mein jo sach mein mila tha. Shloka aise insaan ka varnan nahi kar raha jise us meeting mein kuch mehsoos nahi hua. Woh uska varnan kar raha hai jo uske ant tak khada raha, aur baad ki woh seedhiyan varnan ka hissa hain, uski nakami nahi.',
  'The stairwell afterwards is not a failure. It is where the wave finished.',
  'बाद की सीढ़ियाँ नाकामी नहीं हैं। वहीं लहर ख़त्म हुई।',
  'Baad ki seedhiyan nakami nahi hain. Wahin lehar khatam hui.',
  NULL, 'intermediate', 'work,composure,grief,timing'

  UNION ALL SELECT 23, 'everyday_life', 4,
  'He timed it once', 'उसने एक बार नापा', 'Usne ek baar napa',
  'Somebody who describes himself as short-tempered decides, once, to look at the clock when it starts and again when it has gone. It is ninety seconds. He does not believe it and does it again the following week. It is about two minutes. He had spent years describing it as a feature of his personality.',
  'ख़ुद को ग़ुस्सैल बताने वाला कोई एक बार तय करता है कि जब यह शुरू हो तब घड़ी देखेगा और जब चला जाए तब फिर। नब्बे सेकंड निकलते हैं। उसे यक़ीन नहीं होता और अगले हफ़्ते वह दोबारा करता है। क़रीब दो मिनट। सालों से वह इसे अपनी शख़्सियत का हिस्सा बताता आया था।',
  'Khud ko gussail batane wala koi ek baar tay karta hai ki jab yeh shuru ho tab ghadi dekhega aur jab chala jaaye tab phir. Nabbe second nikalte hain. Use yakeen nahi hota aur agle hafte woh dobara karta hai. Kareeb do minute. Saalon se woh ise apni shakhsiyat ka hissa batata aaya tha.',
  'Calling it a surge rather than a state is the whole practical content of the verse, and a clock is how anybody can check. A state would have no end to outlast. Ninety seconds has an end, and the request the verse makes is suddenly the right size.',
  'इसे अवस्था नहीं, वेग कहना ही श्लोक की पूरी काम की बात है, और घड़ी वह तरीक़ा है जिससे कोई भी जाँच सकता है। अवस्था का कोई अंत नहीं होता जिसे झेला जाए। नब्बे सेकंड का अंत होता है, और श्लोक की माँग अचानक सही नाप की हो जाती है।',
  'Ise avastha nahi, veg kehna hi shloka ki poori kaam ki baat hai, aur ghadi woh tareeka hai jisse koi bhi jaanch sakta hai. Avastha ka koi ant nahi hota jise jhela jaaye. Nabbe second ka ant hota hai, aur shloka ki maang achanak sahi naap ki ho jaati hai.',
  'A personality has no end to wait out. Ninety seconds does.',
  'शख़्सियत का कोई अंत नहीं होता जिसका इंतज़ार किया जाए। नब्बे सेकंड का होता है।',
  'Shakhsiyat ka koi ant nahi hota jiska intezaar kiya jaaye. Nabbe second ka hota hai.',
  NULL, 'beginner', 'anger,timing,self-image,noticing'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 5;

-- =====================================================================
-- 5. CROSS REFERENCES
-- =====================================================================
-- THIRTEEN DECLARED. Every target below was checked against the seeded
-- verse list before it was written — a reference to an unseeded verse
-- joins to nothing and vanishes without an error. Count the loaded rows
-- against thirteen before shipping.
-- =====================================================================

DELETE x FROM verse_cross_references x JOIN verses v ON v.id = x.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 5;

INSERT INTO verse_cross_references
  (verse_id, reference_type, book, chapter, verse, target_verse_id,
   description_en, description_hi, description_hinglish, relationship, sort_order)
SELECT v.id, 'gita', 'Bhagavad Gita', CAST(x.tch AS CHAR), CAST(x.tvn AS CHAR), tv.id,
       x.d_en, x.d_hi, x.d_hing, x.rel, x.ord
FROM (
  SELECT 2 AS vn, 3 AS tch, 5 AS tvn, 1 AS ord,
    'Read 3.5 first and the preference in 5.2 stops being a matter of taste. If nobody stays actionless even for a moment, then walking away from the work is a shorter walk than it sounds.' AS d_en,
    'पहले 3.5 पढ़िए और 5.2 की पसंद स्वाद की बात नहीं रह जाती। अगर कोई एक क्षण भी बिना कर्म के नहीं रहता, तो काम से हट जाना उतना दूर नहीं जाता जितना सुनने में लगता है।' AS d_hi,
    'Pehle 3.5 padho aur 5.2 ki pasand swaad ki baat nahi reh jaati. Agar koi ek pal bhi bina karm ke nahi rehta, to kaam se hat jaana utna door nahi jaata jitna sunne mein lagta hai.' AS d_hing,
    'supports' AS rel
  UNION ALL SELECT 2, 18, 11, 2,
    'The later chapter says outright that an embodied person cannot give up actions completely, only their fruits. That is the same preference stated as a fact rather than as advice.',
    'बाद वाला अध्याय साफ़ कहता है कि देहधारी कर्मों को पूरी तरह छोड़ नहीं सकता, सिर्फ़ उनके फल छोड़ सकता है। वही पसंद, सलाह की तरह नहीं, तथ्य की तरह कही गई।',
    'Baad wala adhyay saaf kehta hai ki dehdhari karmon ko poori tarah chhod nahi sakta, sirf unke phal chhod sakta hai. Wahi pasand, salah ki tarah nahi, tathya ki tarah kahi gayi.',
    'same'
  UNION ALL SELECT 8, 3, 27, 1,
    'The same claim from the other side. 3.27 says the guṇas do the work and the mistaken one thinks "I did it"; 5.8 gives the list of eight things that get done while nobody is claiming them.',
    'वही दावा दूसरी तरफ़ से। 3.27 कहता है कि काम गुण करते हैं और भ्रम में पड़ा सोचता है "मैंने किया"; 5.8 उन आठ चीज़ों की सूची देता है जो होती रहती हैं जबकि कोई उनका दावा नहीं कर रहा।',
    'Wahi dawa doosri taraf se. 3.27 kehta hai ki kaam gun karte hain aur bhram mein pada sochta hai "maine kiya"; 5.8 un aath cheezon ki soochi deta hai jo hoti rehti hain jabki koi unka dawa nahi kar raha.',
    'same'
  UNION ALL SELECT 8, 18, 14, 2,
    'Five things go into any action. 5.8 is what it feels like from inside when you have stopped counting yourself as all five.',
    'किसी भी कर्म में पाँच चीज़ें लगती हैं। 5.8 वह है जो भीतर से महसूस होता है जब आपने ख़ुद को पाँचों गिनना बंद कर दिया हो।',
    'Kisi bhi karm mein paanch cheezein lagti hain. 5.8 woh hai jo bheetar se mehsoos hota hai jab tumne khud ko paanchon ginna band kar diya ho.',
    'supports'
  UNION ALL SELECT 10, 2, 47, 1,
    'The best-known verse in the book and the picture that goes with it. 2.47 says where your claim ends; the lotus leaf says what it looks like to stay in the water anyway.',
    'किताब का सबसे मशहूर श्लोक और उसके साथ की तस्वीर। 2.47 बताता है कि आपका दावा कहाँ ख़त्म होता है; कमल का पत्ता बताता है कि फिर भी पानी में बने रहना कैसा दिखता है।',
    'Kitaab ka sabse mashhoor shloka aur uske saath ki tasveer. 2.47 batata hai ki tumhara dawa kahan khatam hota hai; kamal ka patta batata hai ki phir bhi paani mein bane rehna kaisa dikhta hai.',
    'supports'
  UNION ALL SELECT 10, 3, 19, 2,
    'Do the work with the holding-on let go of. 3.19 gives the instruction; 5.10 gives the image, and the image is the part people remember.',
    'पकड़ छोड़कर काम कीजिए। 3.19 निर्देश देता है; 5.10 तस्वीर देता है, और लोगों को तस्वीर ही याद रहती है।',
    'Pakad chhodkar kaam karo. 3.19 nirdesh deta hai; 5.10 tasveer deta hai, aur logon ko tasveer hi yaad rehti hai.',
    'same'
  UNION ALL SELECT 12, 2, 48, 1,
    'Evenness in success and failure, and here the mechanism underneath it: what makes the two people different is not the work, and 2.48 names the thing that changes instead.',
    'सफलता और असफलता में समता, और यहाँ उसके नीचे का तंत्र: दोनों लोगों को अलग करने वाली चीज़ काम नहीं है, और 2.48 उस चीज़ का नाम लेता है जो बदलती है।',
    'Safalta aur asafalta mein samta, aur yahan uske neeche ka tantra: dono logon ko alag karne wali cheez kaam nahi hai, aur 2.48 us cheez ka naam leta hai jo badalti hai.',
    'same'
  UNION ALL SELECT 12, 12, 12, 2,
    'Letting go of the fruit brings peace immediately — that is the same word, śānti, and the same immediacy. Both verses are careful to say the peace follows the letting go rather than the result.',
    'फल छोड़ने से शांति तुरंत आती है — वही शब्द, शान्ति, और वही तुरंतपन। दोनों श्लोक ध्यान से कहते हैं कि शांति छोड़ने के पीछे आती है, नतीजे के पीछे नहीं।',
    'Phal chhodne se shanti turant aati hai — wahi shabd, shanti, aur wahi turantpan. Dono shloka dhyan se kehte hain ki shanti chhodne ke peechhe aati hai, nateeje ke peechhe nahi.',
    'same'
  UNION ALL SELECT 18, 12, 13, 1,
    'One asks for no hatred towards any being; the other says the seeing itself is already level. Read together they separate two different achievements — behaving well towards somebody, and having actually seen them.',
    'एक किसी भी प्राणी से द्वेष न रखने को कहता है; दूसरा कहता है कि देखना ही पहले से बराबर है। साथ पढ़िए तो ये दो अलग उपलब्धियाँ अलग हो जाती हैं — किसी के साथ अच्छा बरतना, और उसे सचमुच देखा होना।',
    'Ek kisi bhi prani se dwesh na rakhne ko kehta hai; doosra kehta hai ki dekhna hi pehle se barabar hai. Saath padho to yeh do alag uplabdhiyan alag ho jaati hain — kisi ke saath achha bartna, aur use sach mein dekha hona.',
    'supports'
  UNION ALL SELECT 18, 16, 4, 2,
    'Chapter 16 sorts qualities and is repeatedly misread as sorting people. 5.18 is the verse that makes that misreading hard to sustain, and it belongs next to it for exactly that reason.',
    'सोलहवाँ अध्याय गुणों को छाँटता है और बार-बार लोगों को छाँटने के तौर पर ग़लत पढ़ा जाता है। 5.18 वह श्लोक है जो उस ग़लत पाठ को टिकने नहीं देता, और ठीक इसीलिए उसके बग़ल में रखा गया है।',
    'Solahvan adhyay gunon ko chhaanta hai aur baar baar logon ko chhaantne ke taur par galat padha jaata hai. 5.18 woh shloka hai jo us galat paath ko tikne nahi deta, aur theek isiliye uske bagal mein rakha gaya hai.',
    'opposite'
  UNION ALL SELECT 21, 2, 70, 1,
    'The ocean the rivers pour into without raising it. Same claim: the thing was full before anything arrived, so arrivals are not what fills it.',
    'वह समुद्र जिसमें नदियाँ गिरती रहती हैं और वह बढ़ता नहीं। वही दावा: चीज़ किसी के आने से पहले भरी हुई थी, तो आने वाली चीज़ें उसे भरती नहीं।',
    'Woh samudra jisme nadiyan girti rehti hain aur woh badhta nahi. Wahi dawa: cheez kisi ke aane se pehle bhari hui thi, to aane wali cheezein use bharti nahi.',
    'same'
  UNION ALL SELECT 22, 2, 14, 1,
    'The contacts that bring cold and heat, pleasure and pain — they come and they go, says 2.14. 5.22 says why: they have a beginning and an end, and the sorrow comes out of the ending.',
    'वे संपर्क जो ठंड और गर्मी, सुख और दुख लाते हैं — वे आते हैं और जाते हैं, 2.14 कहता है। 5.22 वजह बताता है: उनका आरंभ है और अंत है, और दुख अंत से निकलता है।',
    'Woh sampark jo thand aur garmi, sukh aur dukh laate hain — woh aate hain aur jaate hain, 2.14 kehta hai. 5.22 wajah batata hai: unka aarambh hai aur ant hai, aur dukh ant se nikalta hai.',
    'same'
  UNION ALL SELECT 23, 2, 62, 1,
    'The chain: dwelling on a thing, then wanting it, then anger when it is blocked. 2.62 shows how the surge is built. 5.23 is about being there when it comes down.',
    'शृंखला: किसी चीज़ पर मन टिकना, फिर चाह, फिर रुकावट पर गुस्सा। 2.62 दिखाता है कि वेग बनता कैसे है। 5.23 उस समय वहाँ होने के बारे में है जब वह उतरता है।',
    'Shrinkhala: kisi cheez par man tikna, phir chaah, phir rukawat par gussa. 2.62 dikhata hai ki veg banta kaise hai. 5.23 us samay wahan hone ke baare mein hai jab woh utarta hai.',
    'supports'
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 5
JOIN verses tv ON tv.verse_number = x.tvn
JOIN chapters tc ON tc.id = tv.chapter_id AND tc.chapter_number = x.tch;

-- =====================================================================
-- 6. WORD BY WORD
-- =====================================================================
-- THE ŚVAPĀKA GLOSS IS THE ONE TO READ BEFORE EDITING ANYTHING HERE
--   The word is explained, not reproduced as a name. The gloss says
--   what it literally meant, says plainly that it was a term of
--   contempt aimed at people this society placed at its bottom, and
--   says it should not be used as a name now. Softening it into
--   something neutral would hide what the verse is doing; using it as
--   a label would do the harm the verse refuses. Both failures are
--   available and neither is taken.
--
-- vega is glossed as A SURGE, with the shape named, because the whole
-- 5.23 reading turns on it having an end.
-- =====================================================================

DELETE w FROM verse_word_meanings w JOIN verses v ON v.id = w.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 5;

INSERT INTO verse_word_meanings
  (verse_id, word_order, devanagari, transliteration,
   meaning_en, meaning_hi, meaning_hinglish, grammar, root_word)
SELECT v.id, w.ord, w.dev, w.tr, w.m_en, w.m_hi, w.m_hing, w.gram, w.root FROM (

  SELECT 2 AS vn, 1 AS ord, 'सन्न्यासः' AS dev, 'sannyāsaḥ' AS tr, 'setting down, laying aside — here, stepping out of the work' AS m_en, 'संन्यास — रख देना, हटा देना; यहाँ, काम से बाहर आ जाना' AS m_hi, 'sannyas — rakh dena, hata dena; yahan, kaam se bahar aa jaana' AS m_hing, 'nominative singular' AS gram, 'सम् + नि + अस्' AS root
  UNION ALL SELECT 2, 2, 'कर्मयोगः', 'karma-yogaḥ', 'staying joined to the work', 'कर्म से जुड़े रहना', 'karm se jude rehna', 'nominative singular', 'कृ + युज्'
  UNION ALL SELECT 2, 3, 'उभौ', 'ubhau', 'BOTH — dual, and the whole answer is in this one word', 'दोनों — द्विवचन, और पूरा जवाब इसी एक शब्द में है', 'dono — dvivachan, aur poora jawab isi ek shabd mein hai', 'nominative dual', NULL
  UNION ALL SELECT 2, 4, 'निःश्रेयसकरौ', 'niḥśreyasa-karau', 'making the highest good — said of both of them, in the dual', 'परम कल्याण करने वाले — दोनों के लिए कहा गया, द्विवचन में', 'param kalyan karne wale — dono ke liye kaha gaya, dvivachan mein', 'nominative dual', 'कृ'
  UNION ALL SELECT 2, 5, 'विशिष्यते', 'viśiṣyate', 'is distinguished, stands out — a preference, not a ruling', 'विशिष्ट ठहरता है, अलग दिखता है — पसंद, फ़ैसला नहीं', 'vishisht thehrta hai, alag dikhta hai — pasand, faisla nahi', 'passive, third person', 'वि + शिष्'

  UNION ALL SELECT 8, 1, 'न एव किञ्चित् करोमि', 'na eva kiñcit karomi', 'I do not do anything at all — the sentence the one who has understood thinks', 'मैं कुछ भी नहीं करता — वह वाक्य जो समझ चुका इंसान सोचता है', 'main kuch bhi nahi karta — woh vakya jo samajh chuka insaan sochta hai', 'present, first person', 'कृ'
  UNION ALL SELECT 8, 2, 'तत्त्ववित्', 'tattva-vit', 'one who knows how it actually is — literally, thatness-knower', 'तत्त्ववित् — जो जानता है कि असल में है कैसे; शब्दशः, तत्त्व का जानने वाला', 'tattvavit — jo jaanta hai ki asal mein hai kaise; shabdashah, tattva ka jaanne wala', 'nominative singular', 'विद्'
  UNION ALL SELECT 8, 3, 'युक्तः', 'yuktaḥ', 'joined up, fitted together', 'जुड़ा हुआ, बैठा हुआ', 'juda hua, baitha hua', 'past participle, nominative', 'युज्'
  UNION ALL SELECT 8, 4, 'पश्यन् शृण्वन् स्पृशन् जिघ्रन्', 'paśyan śṛṇvan spṛśan jighran', 'seeing, hearing, touching, smelling — four of the eight, all present participles, all going on right now', 'देखता, सुनता, छूता, सूँघता — आठ में से चार, सब वर्तमान कृदंत, सब अभी चल रहे', 'dekhta, sunta, chhoota, soonghta — aath mein se chaar, sab vartaman kridant, sab abhi chal rahe', 'present participles, nominative', NULL
  UNION ALL SELECT 8, 5, 'अश्नन् गच्छन् स्वपन् श्वसन्', 'aśnan gacchan svapan śvasan', 'eating, walking, sleeping, breathing — the other four. The last one is the cheapest to check', 'खाता, चलता, सोता, साँस लेता — बाक़ी चार। आख़िरी को जाँचना सबसे सस्ता है', 'khata, chalta, sota, saans leta — baaki chaar. Aakhiri ko jaanchna sabse sasta hai', 'present participles, nominative', NULL

  UNION ALL SELECT 10, 1, 'ब्रह्मणि आधाय', 'brahmaṇi ādhāya', 'having placed it in brahman — set down somewhere other than in yourself', 'ब्रह्म में रखकर — अपने में नहीं, कहीं और रख देकर', 'brahm mein rakhkar — apne mein nahi, kahin aur rakh dekar', 'locative + gerund', 'आ + धा'
  UNION ALL SELECT 10, 2, 'सङ्गम् त्यक्त्वा', 'saṅgaṁ tyaktvā', 'having let go of the sticking — saṅga is contact that adheres, not contact as such', 'संग छोड़कर — संग वह संपर्क है जो चिपक जाता है, हर संपर्क नहीं', 'sang chhodkar — sang woh sampark hai jo chipak jaata hai, har sampark nahi', 'accusative + gerund', 'सञ्ज्'
  UNION ALL SELECT 10, 3, 'लिप्यते', 'lipyate', 'is smeared, is stained — a surface word, not a distance word', 'लिपता है, दागी जाता है — यह सतह का शब्द है, दूरी का नहीं', 'lipta hai, daagi jaata hai — yeh satah ka shabd hai, doori ka nahi', 'passive, third person', 'लिप्'
  UNION ALL SELECT 10, 4, 'पद्मपत्रम्', 'padma-patram', 'a lotus leaf', 'कमल का पत्ता', 'kamal ka patta', 'accusative singular', NULL
  UNION ALL SELECT 10, 5, 'इव अम्भसा', 'iva ambhasā', 'as by water — the leaf is IN the water the whole time; nothing here says it left', 'जैसे पानी से — पत्ता पूरे समय पानी में ही है; यहाँ कुछ नहीं कहता कि वह निकल गया', 'jaise paani se — patta poore samay paani mein hi hai; yahan kuch nahi kehta ki woh nikal gaya', 'instrumental singular', 'अम्भस्'

  UNION ALL SELECT 12, 1, 'कर्मफलम् त्यक्त्वा', 'karma-phalaṁ tyaktvā', 'having let the fruit of the action go — the fruit, not the action', 'कर्म का फल छोड़कर — फल, कर्म नहीं', 'karm ka phal chhodkar — phal, karm nahi', 'accusative + gerund', 'त्यज्'
  UNION ALL SELECT 12, 2, 'शान्तिम्', 'śāntim', 'peace, settledness', 'शांति, ठहराव', 'shanti, thehrav', 'accusative singular', 'शम्'
  UNION ALL SELECT 12, 3, 'नैष्ठिकीम्', 'naiṣṭhikīm', 'of the kind that stays — settled, not a mood that passes', 'नैष्ठिकी — टिकने वाली; ठहरी हुई, बीत जाने वाली मनोदशा नहीं', 'naishthiki — tikne wali; thehri hui, beet jaane wali manodasha nahi', 'accusative singular, feminine', 'निष्ठा'
  UNION ALL SELECT 12, 4, 'अयुक्तः', 'ayuktaḥ', 'not joined up — the same word as in 5.8 with a negative in front', 'अयुक्त — जुड़ा हुआ नहीं; 5.8 वाला शब्द, आगे निषेध लगाकर', 'ayukt — juda hua nahi; 5.8 wala shabd, aage nishedh lagakar', 'nominative singular', 'युज्'
  UNION ALL SELECT 12, 5, 'कामकारेण', 'kāma-kāreṇa', 'by the working of wanting — by being driven along by it', 'चाह के चलाने से — उससे खिंचते चले जाने से', 'chaah ke chalane se — usse khinchte chale jaane se', 'instrumental singular', 'कृ'
  UNION ALL SELECT 12, 6, 'फले सक्तः', 'phale saktaḥ', 'stuck to the result — sakta is the participle of the same root as saṅga in 5.10', 'फल से चिपका — सक्त, वही धातु जिससे 5.10 का संग बना है', 'phal se chipka — sakt, wahi dhatu jisse 5.10 ka sang bana hai', 'locative + participle', 'सञ्ज्'
  UNION ALL SELECT 12, 7, 'निबध्यते', 'nibadhyate', 'is tied down', 'बाँध दिया जाता है', 'baandh diya jaata hai', 'passive, third person', 'नि + बन्ध्'

  UNION ALL SELECT 18, 1, 'विद्याविनयसम्पन्ने', 'vidyā-vinaya-sampanne', 'in one furnished with learning and good conduct — the most creditable person the list could have named', 'विद्या और विनय से संपन्न में — सूची जितना सम्मानित व्यक्ति नाम ले सकती थी, यह वही है', 'vidya aur vinay se sampann mein — soochi jitna sammanit vyakti naam le sakti thi, yeh wahi hai', 'locative singular', 'सम् + पद्'
  UNION ALL SELECT 18, 2, 'ब्राह्मणे', 'brāhmaṇe', 'in a brāhmaṇa — named here as the figure carrying the most standing in that society, which is why the list starts with him', 'ब्राह्मण में — यहाँ उस समाज में सबसे ज़्यादा प्रतिष्ठा रखने वाली हस्ती के तौर पर नाम लिया गया है, इसीलिए सूची उसी से शुरू होती है', 'brahman mein — yahan us samaj mein sabse zyada pratishtha rakhne wali hasti ke taur par naam liya gaya hai, isiliye soochi usi se shuru hoti hai', 'locative singular', NULL
  UNION ALL SELECT 18, 3, 'गवि हस्तिनि', 'gavi hastini', 'in a cow, in an elephant', 'गाय में, हाथी में', 'gaay mein, haathi mein', 'locative singular', 'गो, हस्तिन्'
  UNION ALL SELECT 18, 4, 'शुनि', 'śuni', 'in a dog — and in this list, placed just before the last name on purpose', 'कुत्ते में — और इस सूची में जानबूझकर आख़िरी नाम से ठीक पहले रखा गया', 'kutte mein — aur is soochi mein jaanboojhkar aakhiri naam se theek pehle rakha gaya', 'locative singular', 'श्वन्'
  UNION ALL SELECT 18, 5, 'श्वपाके', 'śvapāke', 'Literally "one who cooks dog". Not a description of anybody''s work — a term of contempt, used by people with standing against those this society pushed to its bottom and kept there. Glossed here because the verse''s force depends on how far down the word was meant to reach. It is not used as a name for anybody in the translation above, and must not be used as one now.', 'शब्दशः "जो कुत्ता पकाता है"। किसी के काम का वर्णन नहीं — तिरस्कार का शब्द, प्रतिष्ठा वालों द्वारा उनके लिए जिन्हें इस समाज ने सबसे नीचे धकेला और वहीं रखा। अर्थ इसलिए दिया है क्योंकि श्लोक की ताक़त इस पर टिकी है कि यह शब्द कितना नीचे तक पहुँचने को बना था। ऊपर के अनुवाद में इसे किसी का नाम बनाकर इस्तेमाल नहीं किया गया, और अब भी नहीं किया जाना चाहिए।', 'Shabdashah "jo kutta pakata hai". Kisi ke kaam ka varnan nahi — tiraskar ka shabd, pratishtha walon dwara un logon ke liye jinhe is samaj ne sabse neeche dhakela aur wahin rakha. Arth isliye diya hai kyunki shloka ki taakat is par tiki hai ki yeh shabd kitna neeche tak pahunchne ko bana tha. Upar ke anuvaad mein ise kisi ka naam banakar istemaal nahi kiya gaya, aur ab bhi nahi.', 'locative singular', 'श्वन् + पच्'
  UNION ALL SELECT 18, 6, 'पण्डिताः', 'paṇḍitāḥ', 'the learned ones — and the verse is about to tell them what learning actually looks like', 'पंडित — और श्लोक अभी उन्हें बताने वाला है कि सीखा होना असल में दिखता कैसा है', 'pandit — aur shloka abhi unhe batane wala hai ki seekha hona asal mein dikhta kaisa hai', 'nominative plural', 'पण्ड्'
  UNION ALL SELECT 18, 7, 'समदर्शिनः', 'sama-darśinaḥ', 'even-seeing ones — the claim is about the seeing, not about the behaviour that might follow it', 'समदर्शी — दावा देखने के बारे में है, उस बरताव के बारे में नहीं जो उसके बाद आ सकता है', 'samdarshi — dawa dekhne ke baare mein hai, us bartav ke baare mein nahi jo uske baad aa sakta hai', 'nominative plural', 'दृश्'

  UNION ALL SELECT 21, 1, 'बाह्यस्पर्शेषु', 'bāhya-sparśeṣu', 'in outside contacts — the things that arrive from elsewhere', 'बाहरी स्पर्शों में — वे चीज़ें जो कहीं और से आती हैं', 'bahari sparshon mein — woh cheezein jo kahin aur se aati hain', 'locative plural', 'स्पृश्'
  UNION ALL SELECT 21, 2, 'असक्तात्मा', 'asakta-ātmā', 'one whose self is not stuck — again sakta, again the sticking rather than the touching', 'जिसकी आत्मा चिपकी नहीं — फिर सक्त, फिर चिपकना, छूना नहीं', 'jiski atma chipki nahi — phir sakt, phir chipakna, chhoona nahi', 'nominative singular', 'सञ्ज्'
  UNION ALL SELECT 21, 3, 'आत्मनि यत् सुखम्', 'ātmani yat sukham', 'whatever happiness is in the self — a location, not an amount', 'आत्मा में जो सुख है — जगह, मात्रा नहीं', 'atma mein jo sukh hai — jagah, maatra nahi', 'locative + nominative', NULL
  UNION ALL SELECT 21, 4, 'ब्रह्मयोगयुक्तात्मा', 'brahma-yoga-yuktātmā', 'one joined up in the brahman-joining', 'ब्रह्मयोग में जुड़ी आत्मा वाला', 'brahmayog mein judi atma wala', 'nominative singular', 'युज्'
  UNION ALL SELECT 21, 5, 'अक्षयम्', 'akṣayam', 'not running out — the negative of decay, which is a claim about behaviour rather than size', 'अक्षय — जो चुकता नहीं; क्षय का निषेध, यानी आकार का नहीं, बरताव का दावा', 'akshay — jo chukta nahi; kshay ka nishedh, yani aakar ka nahi, bartav ka dawa', 'accusative singular', 'क्षि'

  UNION ALL SELECT 22, 1, 'संस्पर्शजाः', 'saṁsparśa-jāḥ', 'born of contact — where they come from, said before anything is said about them', 'संपर्क से जन्मे — वे आते कहाँ से हैं, यह उनके बारे में कुछ और कहने से पहले कहा गया', 'sampark se janme — woh aate kahan se hain, yeh unke baare mein kuch aur kehne se pehle kaha gaya', 'nominative plural', 'जन्'
  UNION ALL SELECT 22, 2, 'भोगाः', 'bhogāḥ', 'enjoyments, the good things — the word is not derogatory', 'भोग, अच्छी चीज़ें — शब्द में निंदा नहीं है', 'bhog, achhi cheezein — shabd mein ninda nahi hai', 'nominative plural', 'भुज्'
  UNION ALL SELECT 22, 3, 'दुःखयोनयः', 'duḥkha-yonayaḥ', 'wombs of sorrow — the same source, not a verdict that they are bad. Yoni is where a thing comes out of', 'दुख की योनियाँ — वही स्रोत, यह फ़ैसला नहीं कि वे बुरी हैं। योनि वह है जहाँ से कोई चीज़ निकलती है', 'dukh ki yoniyan — wahi srot, yeh faisla nahi ki woh buri hain. Yoni woh hai jahan se koi cheez nikalti hai', 'nominative plural', 'योनि'
  UNION ALL SELECT 22, 4, 'आद्यन्तवन्तः', 'ādy-antavantaḥ', 'having a beginning and an end — THIS is the reason the verse gives, and it is the whole reason', 'जिनका आरंभ और अंत है — श्लोक यही वजह देता है, और पूरी वजह यही है', 'jinka aarambh aur ant hai — shloka yahi wajah deta hai, aur poori wajah yahi hai', 'nominative plural', NULL
  UNION ALL SELECT 22, 5, 'न तेषु रमते', 'na teṣu ramate', 'does not take up residence in them — ramate is to dwell, to settle in. Not "does not touch" and not "does not enjoy"', 'उनमें बसता नहीं — रमते यानी बसना, टिक जाना। "छूता नहीं" नहीं, और "आनंद नहीं लेता" भी नहीं', 'unme basta nahi — ramate yani basna, tik jaana. "Chhoota nahi" nahi, aur "anand nahi leta" bhi nahi', 'present middle, third person', 'रम्'
  UNION ALL SELECT 22, 6, 'बुधः', 'budhaḥ', 'the one who has woken up to it', 'जिसकी आँख इस बात पर खुल गई', 'jiski aankh is baat par khul gayi', 'nominative singular', 'बुध्'

  UNION ALL SELECT 23, 1, 'शक्नोति', 'śaknoti', 'is able — the verse asks for ability in one thing, and names the thing', 'सक्षम है — श्लोक एक चीज़ में सक्षमता माँगता है, और उस चीज़ का नाम लेता है', 'saksham hai — shloka ek cheez mein saksamta maangta hai, aur us cheez ka naam leta hai', 'present, third person', 'शक्'
  UNION ALL SELECT 23, 2, 'इह एव', 'iha eva', 'here itself — in this life, not in some later arrangement. The timestamp is deliberate', 'यहीं — इसी जीवन में, किसी बाद के इंतज़ाम में नहीं। समय की यह मुहर जानबूझकर है', 'yahin — isi jeevan mein, kisi baad ke intezaam mein nahi. Samay ki yeh muhar jaanboojhkar hai', 'indeclinable', NULL
  UNION ALL SELECT 23, 3, 'प्राक् शरीरविमोक्षणात्', 'prāk śarīra-vimokṣaṇāt', 'before the letting go of the body', 'शरीर छूटने से पहले', 'sharir chhootne se pehle', 'ablative singular', 'वि + मुच्'
  UNION ALL SELECT 23, 4, 'कामक्रोधोद्भवम्', 'kāma-krodhodbhavam', 'arising out of wanting and anger — the two named together because they are one movement', 'चाह और गुस्से से उठने वाला — दोनों साथ नाम लिए गए क्योंकि वे एक ही गति हैं', 'chaah aur gusse se uthne wala — dono saath naam liye gaye kyunki woh ek hi gati hain', 'accusative singular', 'उद् + भू'
  UNION ALL SELECT 23, 5, 'वेगम्', 'vegam', 'A SURGE — a rush, a wave, something with a shape: it comes up, it peaks, it goes down. Not a state and not a temperament. The whole reading of this verse turns on it having an end', 'वेग — उछाल, लहर, वह चीज़ जिसका आकार है: वह उठती है, चरम पर जाती है, उतर जाती है। न अवस्था, न स्वभाव। इस श्लोक का पूरा पाठ इसी पर टिका है कि इसका अंत होता है', 'veg — ubhaar, lehar, woh cheez jiska aakar hai: woh uthti hai, charam par jaati hai, utar jaati hai. Na avastha, na swabhav. Is shloka ka poora paath isi par tika hai ki iska ant hota hai', 'accusative singular', 'विज्'
  UNION ALL SELECT 23, 6, 'सोढुम्', 'soḍhum', 'to withstand, to bear through — to be still there at the end of it', 'सह जाना, झेल जाना — उसके अंत तक वहीं बने रहना', 'seh jaana, jhel jaana — uske ant tak wahin bane rehna', 'infinitive', 'सह्'
  UNION ALL SELECT 23, 7, 'सुखी', 'sukhī', 'happy — stated flatly, in this life, as the second half of the same sentence', 'सुखी — सीधे-सीधे कहा गया, इसी जीवन में, उसी वाक्य के दूसरे हिस्से में', 'sukhi — seedhe seedhe kaha gaya, isi jeevan mein, usi vakya ke doosre hisse mein', 'nominative singular', 'सुख'
) AS w
JOIN verses v ON v.verse_number = w.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 5;
