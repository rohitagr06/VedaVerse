-- =====================================================================
-- VedaVerse — database/seed_ch03.sql
-- =====================================================================
-- Chapter 3, Karma Yoga. Eight verses, the chapter's full allocation.
--
--   3.5   nobody gets to opt out, not even for a moment
--   3.8   do the work in front of you; not acting is not neutral
--   3.16  taking without giving back
--   3.19  the instruction itself, stated cleanly
--   3.21  people copy what you do, not what you say
--   3.27  the machinery works and the ego signs the receipt
--   3.35  your own work badly beats somebody else's well   [MANDATORY]
--   3.37  the enemy, named
--
-- 3.35 NEEDS CARE AND GETS IT EXPLICITLY
--   Svadharma has been used for centuries to tell people that the
--   circumstances of their birth are their duty and that leaving them is
--   dangerous. That reading has done real harm, and a product teaching
--   this text to beginners cannot leave it to be inferred.
--
--   The explanation states plainly what the verse says — do your own
--   work, do not perform an imitation of somebody else's — and states
--   just as plainly that it is not an argument for staying in the social
--   position you were born into. Both sentences are load-bearing.
--   Removing the second one is how this verse becomes a defence of
--   something the rest of the chapter argues against.
--
-- CONTENT RULES — unchanged
--   Original writing throughout. Sanskrit unaltered, numbering
--   untouched. Films named as facts, no dialogue or lyrics. No praise or
--   criticism of any living politician, party or movement. No communal
--   framing anywhere, and 3.35 is the verse where that rule is tested.
--
-- RUN AFTER seed_sample.sql. Re-runnable.
--
--     mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
--         < htdocs/database/seed_ch03.sql
--
-- global_order is 119 + verse_number: chapter 1 has 47 verses and
-- chapter 2 has 72.
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

  SELECT 5 AS verse_number, 124 AS global_order, 1 AS is_curated, 'gita-3-5' AS slug,
    'न हि कश्चित्क्षणमपि जातु तिष्ठत्यकर्मकृत्।\nकार्यते ह्यवशः कर्म सर्वः प्रकृतिजैर्गुणैः॥' AS sanskrit_devanagari,
    'na hi kaścit kṣaṇam api jātu tiṣṭhaty akarma-kṛt\nkāryate hy avaśaḥ karma sarvaḥ prakṛti-jair guṇaiḥ' AS transliteration_iast,
    'na hi kashchit kshanam api jatu tishthaty akarma-krit\nkaryate hy avashah karma sarvah prakriti-jair gunaih' AS transliteration_simple,
    'Nobody, ever, remains even for a moment without performing action. Everyone is made to act, helplessly, by the qualities born of nature.' AS translation_literal,
    'Nobody stands still, not for one moment. You are being acted through by what you are made of, whether you have decided anything or not.' AS translation_en,
    'कोई एक क्षण भी निष्क्रिय नहीं रह पाता। आप जिस चीज़ से बने हैं वह आपके ज़रिये काम कर ही रही है — चाहे आपने कुछ तय किया हो या नहीं।' AS translation_hi,
    'Koi ek pal bhi bina kaam ke nahi reh paata. Tum jis cheez se bane ho woh tumhare zariye kaam kar hi rahi hai — chahe tumne kuch tay kiya ho ya nahi.' AS translation_hinglish,
    'Not acting is not available. It is just acting without admitting it.' AS summary_en,
    'न करना कोई विकल्प है ही नहीं। वह बस बिना माने काम करना है।' AS summary_hi,
    'Na karna koi option hai hi nahi. Woh bas bina maane kaam karna hai.' AS summary_hinglish,
    'beginner' AS difficulty,
    'Gita 3.5: why doing nothing is not an option' AS seo_title,
    'Staying out of it feels like neutrality. The Bhagavad Gita says there is no such position — you are acting either way, and the only question is whether you are choosing.' AS seo_description,
    1 AS published

  UNION ALL SELECT 8, 127, 1, 'gita-3-8',
    'नियतं कुरु कर्म त्वं कर्म ज्यायो ह्यकर्मणः।\nशरीरयात्रापि च ते न प्रसिद्ध्येदकर्मणः॥',
    'niyataṁ kuru karma tvaṁ karma jyāyo hy akarmaṇaḥ\nśarīra-yātrāpi ca te na prasiddhyed akarmaṇaḥ',
    'niyatam kuru karma tvam karma jyayo hy akarmanah\nsharira-yatrapi cha te na prasiddhyed akarmanah',
    'Perform your allotted action, for action is better than inaction. Even the maintenance of your body would not be accomplished by inaction.',
    'Do the work that is actually yours. Doing it beats not doing it. You could not even keep your body going by sitting still, so the idea that withdrawal is the pure option does not survive contact with a normal day.',
    'वह काम कीजिए जो सचमुच आपका है। करना, न करने से बेहतर है। बैठे रहकर तो आप शरीर भी नहीं चला पाते — इसलिए यह ख़याल कि हट जाना ही शुद्ध रास्ता है, एक सामान्य दिन के सामने भी नहीं टिकता।',
    'Woh kaam karo jo sach mein tumhara hai. Karna, na karne se behtar hai. Baithe reh ke to tum body bhi nahi chala paate — isliye yeh khayal ki hat jaana hi shuddh rasta hai, ek normal din ke saamne bhi nahi tikta.',
    'Withdrawal looks like purity from the outside and does not survive one honest day.',
    'हट जाना बाहर से पवित्रता जैसा दिखता है और एक ईमानदार दिन भी नहीं टिकता।',
    'Hat jaana bahar se purity jaisa dikhta hai aur ek imaandaar din bhi nahi tikta.',
    'beginner',
    'Gita 3.8 on why opting out is not the pure choice',
    'Stepping back can feel like the clean option. The Gita points out you could not keep your own body running that way, and asks what exactly is being avoided.',
    1

  UNION ALL SELECT 16, 135, 1, 'gita-3-16',
    'एवं प्रवर्तितं चक्रं नानुवर्तयतीह यः।\nअघायुरिन्द्रियारामो मोघं पार्थ स जीवति॥',
    'evaṁ pravartitaṁ cakraṁ nānuvartayatīha yaḥ\naghāyur indriyārāmo moghaṁ pārtha sa jīvati',
    'evam pravartitam chakram nanuvartayatiha yah\naghayur indriyaramo mogham partha sa jivati',
    'One who does not follow the wheel thus set in motion here, whose life is harmful and who delights in the senses, lives in vain, Partha.',
    'A wheel is already turning and you arrived onto it. Somebody grew what you ate this morning. To take from it for a lifetime and put nothing back is, the verse says bluntly, a wasted life.',
    'एक चक्र पहले से घूम रहा है और आप उसी पर आए। आज सुबह जो आपने खाया, वह किसी ने उगाया था। जीवन भर उससे लेते रहना और कुछ न लौटाना — श्लोक साफ़ कहता है — बेकार गया जीवन है।',
    'Ek chakra pehle se ghoom raha hai aur tum usi par aaye. Aaj subah jo tumne khaya, woh kisi ne ugaya tha. Zindagi bhar usse lete rehna aur kuch na lautana — shloka saaf kehta hai — bekaar gayi zindagi hai.',
    'You arrived onto something already running. The verse asks what you put back.',
    'आप ऐसी चीज़ पर आए जो पहले से चल रही थी। श्लोक पूछता है कि आपने लौटाया क्या।',
    'Tum aisi cheez par aaye jo pehle se chal rahi thi. Shloka poochta hai ki tumne lautaya kya.',
    'intermediate',
    'Gita 3.16: taking from a system you did not build',
    'Somebody grew your breakfast. The Bhagavad Gita has an unusually blunt line about living entirely on what others maintain and returning nothing.',
    1

  UNION ALL SELECT 19, 138, 1, 'gita-3-19',
    'तस्मादसक्तः सततं कार्यं कर्म समाचर।\nअसक्तो ह्याचरन्कर्म परमाप्नोति पूरुषः॥',
    'tasmād asaktaḥ satataṁ kāryaṁ karma samācara\nasakto hy ācaran karma param āpnoti pūruṣaḥ',
    'tasmad asaktah satatam karyam karma samachara\nasakto hy acharan karma param apnoti purushah',
    'Therefore, always perform the work that should be done, unattached. Performing action without attachment, a person attains the highest.',
    'So do what needs doing, without gripping it. Someone who works that way, continuously, gets to the thing everything else in this book is pointing at.',
    'तो जो करना है वह कीजिए, बिना जकड़े। जो लगातार इस तरह काम करता है, वह उस तक पहुँचता है जिसकी ओर इस किताब की बाकी हर बात इशारा कर रही है।',
    'To jo karna hai woh karo, bina jakde. Jo lagatar is tarah kaam karta hai, woh us tak pahunchta hai jiski taraf is kitaab ki baaki har baat ishara kar rahi hai.',
    'The instruction of the whole chapter, in one sentence, with nothing decorative in it.',
    'पूरे अध्याय का निर्देश, एक वाक्य में, बिना किसी सजावट के।',
    'Poore chapter ka instruction, ek line mein, bina kisi sajawat ke.',
    'beginner',
    'Gita 3.19: work without gripping it',
    'The plainest statement of karma yoga in the chapter. What acting without attachment means in practice, and what it is not.',
    1

  UNION ALL SELECT 21, 140, 1, 'gita-3-21',
    'यद्यदाचरति श्रेष्ठस्तत्तदेवेतरो जनः।\nस यत्प्रमाणं कुरुते लोकस्तदनुवर्तते॥',
    'yad yad ācarati śreṣṭhas tat tad evetaro janaḥ\nsa yat pramāṇaṁ kurute lokas tad anuvartate',
    'yad yad acharati shreshthas tat tad evetaro janah\nsa yat pramanam kurute lokas tad anuvartate',
    'Whatever a superior person does, other people do that very thing. Whatever standard he sets, the world follows it.',
    'People copy what the person in front does. Not what they announce — what they do. Whatever standard that person actually keeps becomes the standard, and they do not get a say in whether this is happening.',
    'लोग वही नकल करते हैं जो आगे वाला करता है। जो वह कहता है वह नहीं — जो वह करता है वह। वह असल में जो स्तर रखता है, वही स्तर बन जाता है — और यह हो रहा है या नहीं, इस पर उसका कोई वश नहीं।',
    'Log wahi copy karte hain jo aage wala karta hai. Jo woh kehta hai woh nahi — jo woh karta hai woh. Woh asal mein jo standard rakhta hai, wahi standard ban jaata hai — aur yeh ho raha hai ya nahi, ispe uska koi bas nahi.',
    'You are setting a standard whether you meant to or not. Only the content is up to you.',
    'आप कोई स्तर तय कर ही रहे हैं, चाहा हो या नहीं। बस उसमें क्या है, वह आपके हाथ में है।',
    'Tum koi standard tay kar hi rahe ho, chaha ho ya nahi. Bas usme kya hai, woh tumhare haath mein hai.',
    'beginner',
    'Gita 3.21: people copy what you do, not what you say',
    'Anyone others watch is setting a standard whether they intend to or not. The Gita is blunt about who this applies to and how little choice they have about it.',
    1

  UNION ALL SELECT 27, 146, 1, 'gita-3-27',
    'प्रकृतेः क्रियमाणानि गुणैः कर्माणि सर्वशः।\nअहङ्कारविमूढात्मा कर्ताहमिति मन्यते॥',
    'prakṛteḥ kriyamāṇāni guṇaiḥ karmāṇi sarvaśaḥ\nahaṅkāra-vimūḍhātmā kartāham iti manyate',
    'prakriteh kriyamanani gunaih karmani sarvashah\nahankara-vimudhatma kartaham iti manyate',
    'Actions are performed in every way by the qualities of nature. One whose self is deluded by ego thinks: I am the doer.',
    'The machinery does the work — temperament, conditions, everything you did not choose. Then something steps forward afterwards and signs its name to it.',
    'काम मशीन करती है — स्वभाव, हालात, वह सब जो आपने चुना नहीं। और फिर कोई बाद में आगे आकर उस पर अपना नाम लिख देता है।',
    'Kaam machine karti hai — swabhav, haalat, woh sab jo tumne chuna nahi. Aur phir koi baad mein aage aa ke uspe apna naam likh deta hai.',
    'The work happens. The claiming happens afterwards, and separately.',
    'काम होता है। दावा बाद में होता है, और अलग से।',
    'Kaam hota hai. Dawa baad mein hota hai, aur alag se.',
    'advanced',
    'Gita 3.27: who is actually doing the work',
    'The Gita''s most uncomfortable claim about credit. The machinery acts; the ego signs the receipt afterwards. What that changes about praise and blame.',
    1

  UNION ALL SELECT 35, 154, 1, 'gita-3-35',
    'श्रेयान्स्वधर्मो विगुणः परधर्मात्स्वनुष्ठितात्।\nस्वधर्मे निधनं श्रेयः परधर्मो भयावहः॥',
    'śreyān sva-dharmo viguṇaḥ para-dharmāt sv-anuṣṭhitāt\nsva-dharme nidhanaṁ śreyaḥ para-dharmo bhayāvahaḥ',
    'shreyan sva-dharmo vigunah para-dharmat sv-anushthitat\nsva-dharme nidhanam shreyah para-dharmo bhayavahah',
    'Better is one''s own duty, though imperfect, than the duty of another well performed. Better is death in one''s own duty; the duty of another brings danger.',
    'Your own work done badly beats somebody else''s done well. Better to fail at what is actually yours than to succeed at a performance of somebody else''s life — that road leads somewhere frightening.',
    'अपना काम ख़राब ढंग से भी, दूसरे के काम को अच्छे ढंग से करने से बेहतर है। जो सचमुच आपका है उसमें असफल होना, किसी और की ज़िंदगी की नक़ल में सफल होने से बेहतर है — वह रास्ता डरावनी जगह ले जाता है।',
    'Apna kaam kharab dhang se bhi, doosre ke kaam ko achhe dhang se karne se behtar hai. Jo sach mein tumhara hai usme fail hona, kisi aur ki zindagi ki nakal mein safal hone se behtar hai — woh rasta darawni jagah le jaata hai.',
    'One of the most misused verses in the book. Read the explanation before you use it on anybody.',
    'किताब के सबसे ग़लत इस्तेमाल होने वाले श्लोकों में एक। किसी पर इसे लगाने से पहले व्याख्या पढ़ लीजिए।',
    'Kitaab ke sabse galat istemaal hone wale shlokon mein ek. Kisi par ise lagane se pehle explanation padh lo.',
    'intermediate',
    'Gita 3.35: your own path, and how this verse gets misused',
    'Better your own work imperfectly than another''s well. What the verse argues, and why it is not an argument for staying where you were born.',
    1

  UNION ALL SELECT 37, 156, 1, 'gita-3-37',
    'काम एष क्रोध एष रजोगुणसमुद्भवः।\nमहाशनो महापाप्मा विद्ध्येनमिह वैरिणम्॥',
    'kāma eṣa krodha eṣa rajo-guṇa-samudbhavaḥ\nmahāśano mahā-pāpmā viddhy enam iha vairiṇam',
    'kama esha krodha esha rajo-guna-samudbhavah\nmahashano maha-papma viddhy enam iha vairinam',
    'It is desire, it is anger, born of the quality of rajas — all-devouring, greatly harmful. Know this to be the enemy here.',
    'Arjuna asks what drags a person into damage against their own intention. The answer is one thing wearing two faces: wanting, and the anger it turns into when blocked. It never fills up. That is the enemy.',
    'अर्जुन पूछता है कि आदमी को अपनी ही मर्ज़ी के ख़िलाफ़ नुक़सान में कौन घसीटता है। जवाब एक ही चीज़ है, दो चेहरों में: चाह, और रुकने पर वह जो गुस्सा बन जाती है। यह कभी भरती नहीं। दुश्मन यही है।',
    'Arjun poochta hai ki aadmi ko apni hi marzi ke khilaf nuksaan mein kaun ghaseetta hai. Jawab ek hi cheez hai, do chehron mein: chaah, aur rukne par woh jo gussa ban jaati hai. Yeh kabhi bharti nahi. Dushman yahi hai.',
    'Arjuna asks a real question and gets a direct answer. Wanting and anger are one thing, not two.',
    'अर्जुन सच्चा सवाल पूछता है और सीधा जवाब पाता है। चाह और गुस्सा दो चीज़ें नहीं, एक हैं।',
    'Arjun sachcha sawaal poochta hai aur seedha jawab paata hai. Chaah aur gussa do cheezein nahi, ek hain.',
    'intermediate',
    'Gita 3.37: what drags you into things you did not intend',
    'Arjuna asks what makes a person do damage against their own better judgement. The Gita names it in one line, and says wanting and anger are the same thing.',
    1

) AS v
JOIN chapters c ON c.chapter_number = 3;

-- =====================================================================
-- EXPLANATIONS
-- =====================================================================

DELETE ve FROM verse_explanations ve JOIN verses v ON v.id = ve.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 3;

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 5 AS vn, 'beginner' AS level,
   'Arjuna has just asked a reasonable question: if understanding is better than action, why send me into this? Chapter 3 is the answer, and it opens by removing the option Arjuna is quietly hoping for.' AS h_en,
   'अर्जुन ने अभी एक वाजिब सवाल पूछा है: अगर समझ कर्म से बेहतर है, तो मुझे इसमें क्यों भेज रहे हैं? तीसरा अध्याय उसी का जवाब है, और वह उस विकल्प को हटाकर शुरू होता है जिसकी अर्जुन चुपचाप उम्मीद कर रहा है।' AS h_hi,
   'Arjun ne abhi ek wajib sawaal poocha hai: agar samajh karm se behtar hai, to mujhe isme kyun bhej rahe hain? Chapter 3 usi ka jawab hai, aur woh us option ko hata ke shuru hota hai jiski Arjun chupchap umeed kar raha hai.' AS h_hing,
   'The claim is mechanical rather than moral. You are made of a temperament, a history and a body, and those are producing behaviour continuously. Sitting out is a behaviour they produce. So the choice was never between acting and not acting; it was between acting deliberately and acting while telling yourself you have not.' AS p_en,
   'दावा नैतिक नहीं, यांत्रिक है। आप एक स्वभाव, एक इतिहास और एक शरीर से बने हैं, और वे लगातार व्यवहार पैदा कर रहे हैं। अलग बैठ जाना भी उन्हीं का पैदा किया व्यवहार है। इसलिए चुनाव कभी करने और न करने के बीच था ही नहीं; वह सोच-समझकर करने और यह कहते हुए करने के बीच था कि मैंने कुछ किया ही नहीं।' AS p_hi,
   'Claim naitik nahi, mechanical hai. Tum ek swabhav, ek history aur ek body se bane ho, aur woh lagatar behaviour paida kar rahe hain. Alag baith jaana bhi unhi ka paida kiya behaviour hai. Isliye choice kabhi karne aur na karne ke beech thi hi nahi; woh soch-samajh ke karne aur yeh kehte hue karne ke beech thi ki maine kuch kiya hi nahi.' AS p_hing,
   'The version of this that shows up most is staying out of something at work or in a family — not taking a side, not saying the thing. It reads internally as restraint. Everybody else experiences it as a position, because the situation moves while you are not moving in it, and it moves in a direction your silence helped choose.' AS m_en,
   'इसका जो रूप सबसे ज़्यादा दिखता है वह है दफ़्तर या परिवार में किसी बात से अलग रह जाना — पक्ष न लेना, वह बात न कहना। भीतर से यह संयम लगता है। बाकी सबके लिए यह एक पक्ष है, क्योंकि स्थिति चलती रहती है जब आप उसमें नहीं चलते, और वह उसी दिशा में जाती है जिसे आपकी चुप्पी ने चुनने में मदद की।' AS m_hi,
   'Iska jo roop sabse zyada dikhta hai woh hai office ya parivar mein kisi baat se alag reh jaana — side na lena, woh baat na kehna. Andar se yeh sanyam lagta hai. Baaki sabke liye yeh ek position hai, kyunki situation chalti rehti hai jab tum usme nahi chalte, aur woh usi direction mein jaati hai jise tumhari chuppi ne chunne mein madad ki.' AS m_hing

  UNION ALL SELECT 8, 'beginner',
   'Still answering the same objection. Krishna moves from the abstract point to the practical one: even the most withdrawn life is a life of continuous action.',
   'वही आपत्ति का जवाब जारी है। कृष्ण अमूर्त बात से व्यावहारिक बात पर आते हैं: सबसे अलग-थलग जीवन भी लगातार कर्म का जीवन है।',
   'Wahi objection ka jawab jaari hai. Krishna abstract baat se practical baat par aate hain: sabse alag-thalag zindagi bhi lagatar karm ki zindagi hai.',
   'Niyatam is the work that is assigned or settled — yours specifically, not work in general. The verse is not saying be busy. It is saying there is a particular thing in front of you and doing it, imperfectly, beats a purity you cannot actually maintain for one day.',
   'नियतम् यानी वह काम जो तय है — ख़ास आपका, काम मात्र नहीं। श्लोक यह नहीं कह रहा कि व्यस्त रहिए। वह कह रहा है कि आपके सामने एक ख़ास चीज़ है, और उसे अधूरे ढंग से भी करना उस पवित्रता से बेहतर है जिसे आप एक दिन भी नहीं निभा सकते।',
   'Niyatam matlab woh kaam jo tay hai — khaas tumhara, kaam matra nahi. Shloka yeh nahi keh raha ki busy raho. Woh keh raha hai ki tumhare saamne ek khaas cheez hai, aur use adhoore dhang se bhi karna us purity se behtar hai jise tum ek din bhi nahi nibha sakte.',
   'Most modern withdrawal is not renunciation, it is deferral — leaving a job undone until conditions improve, not replying until you know what to say, not deciding until more information arrives. The verse points out that the deferral is itself a choice being made continuously, and that it has costs somebody is already paying.',
   'आज का ज़्यादातर हटना संन्यास नहीं, टालना है — हालात सुधरने तक काम अधूरा छोड़ना, जब तक ठीक शब्द न मिलें जवाब न देना, और जानकारी और आने तक फ़ैसला न करना। श्लोक बताता है कि यह टालना ख़ुद एक फ़ैसला है जो लगातार लिया जा रहा है, और उसकी क़ीमत कोई पहले से चुका रहा है।',
   'Aaj ka zyadatar hatna sanyas nahi, taalna hai — haalat sudharne tak kaam adhoora chhodna, jab tak theek shabd na milein jawab na dena, aur jaankari aur aane tak faisla na karna. Shloka batata hai ki yeh taalna khud ek faisla hai jo lagatar liya ja raha hai, aur uski keemat koi pehle se chuka raha hai.'

  UNION ALL SELECT 16, 'intermediate',
   'The wheel Krishna refers to is a cycle of mutual maintenance described in the preceding verses — rain, food, work, offering, rain again. The imagery is of its period; the structure of the argument is not.',
   'कृष्ण जिस चक्र की बात कर रहे हैं वह पिछले श्लोकों में बताया गया आपसी पोषण का चक्र है — वर्षा, अन्न, कर्म, यज्ञ, फिर वर्षा। चित्रण उस युग का है; दलील का ढाँचा नहीं।',
   'Krishna jis chakra ki baat kar rahe hain woh pichhle shlokon mein bataya gaya aapsi poshan ka chakra hai — varsha, anna, karm, yajna, phir varsha. Imagery us zamane ki hai; dalil ka structure nahi.',
   'The argument does not depend on the ritual vocabulary. It is about arriving into a system already running on other people''s work — roads, food, language, a body of knowledge — consuming from it for a lifetime, and returning nothing to it. The verse calls that life wasted, and it is one of the sharper judgements in the text.',
   'दलील अनुष्ठान की शब्दावली पर टिकी नहीं है। बात यह है कि आप ऐसी व्यवस्था में आते हैं जो पहले से दूसरों की मेहनत पर चल रही है — सड़कें, अन्न, भाषा, ज्ञान का पूरा भंडार — जीवन भर उससे लेते हैं, और कुछ नहीं लौटाते। श्लोक ऐसे जीवन को व्यर्थ कहता है, और यह ग्रंथ के तीखे निर्णयों में से एक है।',
   'Dalil ritual ki bhasha par tiki nahi hai. Baat yeh hai ki tum aisi vyavastha mein aate ho jo pehle se doosron ki mehnat par chal rahi hai — sadkein, anna, bhasha, gyaan ka poora bhandar — zindagi bhar usse lete ho, aur kuch nahi lautate. Shloka aisi zindagi ko vyarth kehta hai, aur yeh granth ke sabse teekhe faislon mein se ek hai.',
   'This is uncomfortable in a way worth sitting with rather than softening. It is not asking for charity or for visible service. It is asking whether the ledger, over a lifetime, has anything on the other side — and most people find the honest answer is yes, and also that they had never once looked.',
   'यह असहज है, और इसे नरम करने के बजाय इसके साथ बैठना बेहतर है। यह दान नहीं माँग रहा, न दिखने वाली सेवा। यह पूछ रहा है कि जीवन भर के बही-खाते के दूसरी तरफ़ कुछ है या नहीं — और ज़्यादातर लोगों को ईमानदार जवाब यह मिलता है कि हाँ है, और यह भी कि उन्होंने कभी उधर देखा ही नहीं था।',
   'Yeh asehaj hai, aur ise naram karne ke bajay iske saath baithna behtar hai. Yeh daan nahi maang raha, na dikhne wali seva. Yeh pooch raha hai ki zindagi bhar ke hisaab ke doosri taraf kuch hai ya nahi — aur zyadatar logon ko imaandaar jawab yeh milta hai ki haan hai, aur yeh bhi ki unhone kabhi udhar dekha hi nahi tha.'

  UNION ALL SELECT 19, 'beginner',
   'The conclusion of the chapter''s central argument. Everything from 3.4 onwards has been clearing objections; this is what the clearing was for.',
   'अध्याय की मुख्य दलील का निष्कर्ष। 3.4 से अब तक सब आपत्तियाँ हटाई जा रही थीं; हटाना इसी के लिए था।',
   'Chapter ki mukhya dalil ka nishkarsh. 3.4 se ab tak sab objections hataye ja rahe the; hatana isi ke liye tha.',
   'Asakta is unattached, and the word matters more than the translation suggests. It does not mean uninterested, and it does not mean careless. It means not gripping — able to put the thing down. A surgeon is not unattached to the operation. They are unattached in the sense that their hands do not shake with wanting it.',
   'असक्त यानी अनासक्त, और यह शब्द अनुवाद से ज़्यादा मायने रखता है। इसका अर्थ न उदासीन है, न लापरवाह। इसका अर्थ है न जकड़ना — यानी उसे नीचे रख पाना। सर्जन ऑपरेशन से अनासक्त नहीं होता। वह इस अर्थ में अनासक्त होता है कि उसके हाथ चाहत से काँपते नहीं।',
   'Asakta matlab anasakt, aur yeh shabd translation se zyada maayne rakhta hai. Iska matlab na udaseen hai, na laparwah. Iska matlab hai na jakadna — yaani use neeche rakh paana. Surgeon operation se anasakt nahi hota. Woh is arth mein anasakt hota hai ki uske haath chahat se kaanpte nahi.',
   'The practical test is simple and slightly unpleasant. Ask what you would do if this project succeeded and somebody else got the credit. If the answer changes how you would work on it today, the grip is there and you now know where.',
   'व्यावहारिक कसौटी आसान है और थोड़ी अप्रिय भी। पूछिए कि अगर यह काम सफल हो जाए और श्रेय किसी और को मिले, तो आप क्या करेंगे। अगर उस जवाब से बदल जाता है कि आप आज इस पर कैसे काम करेंगे, तो पकड़ मौजूद है — और अब आपको पता है कहाँ।',
   'Practical test aasan hai aur thoda unpleasant bhi. Poocho ki agar yeh kaam safal ho jaaye aur credit kisi aur ko mile, to tum kya karoge. Agar us jawab se badal jaata hai ki tum aaj is par kaise kaam karoge, to pakad maujood hai — aur ab tumhe pata hai kahan.'

  UNION ALL SELECT 21, 'beginner',
   'Krishna is arguing that even somebody with nothing left to gain should keep working, and the reason given is not about them. It is about who is watching.',
   'कृष्ण यह दलील दे रहे हैं कि जिसे अब कुछ पाना नहीं बचा उसे भी काम करते रहना चाहिए, और कारण उसके बारे में नहीं है। कारण यह है कि कौन देख रहा है।',
   'Krishna yeh dalil de rahe hain ki jise ab kuch paana nahi bacha use bhi kaam karte rehna chahiye, aur reason uske baare mein nahi hai. Reason yeh hai ki kaun dekh raha hai.',
   'Shreshtha is whoever is in front — senior, respected, or simply visible. The verse makes two claims. People imitate conduct rather than instruction. And whatever that person tolerates becomes the floor, without any announcement being made.',
   'श्रेष्ठ यानी जो आगे है — वरिष्ठ, सम्मानित, या बस दिखने वाला। श्लोक दो बातें कहता है। लोग उपदेश की नहीं, आचरण की नक़ल करते हैं। और वह व्यक्ति जिस चीज़ को चलने देता है, वही न्यूनतम स्तर बन जाती है — बिना किसी घोषणा के।',
   'Shreshtha matlab jo aage hai — senior, respected, ya bas dikhne wala. Shloka do baatein kehta hai. Log updesh ki nahi, aacharan ki nakal karte hain. Aur woh insaan jis cheez ko chalne deta hai, wahi minimum standard ban jaata hai — bina kisi announcement ke.',
   'Any manager can confirm the second half. A team''s real standard is not the one in the document; it is the worst thing the lead has visibly let pass. That is set by accident, usually on a busy day, and it is extremely hard to raise afterwards.',
   'कोई भी मैनेजर दूसरे हिस्से की पुष्टि कर देगा। टीम का असली स्तर दस्तावेज़ वाला नहीं होता; वह सबसे बुरी वह बात होती है जिसे लीड ने सबके सामने जाने दिया। वह संयोग से तय होता है, आमतौर पर किसी व्यस्त दिन, और बाद में उसे ऊपर उठाना बेहद मुश्किल होता है।',
   'Koi bhi manager doosre hisse ki tasdeeq kar dega. Team ka asli standard document wala nahi hota; woh sabse buri woh baat hoti hai jise lead ne sabke saamne jaane diya. Woh sanyog se tay hota hai, aksar kisi busy din, aur baad mein use upar uthana bahut mushkil hota hai.'

  UNION ALL SELECT 27, 'advanced',
   'Late in the chapter, and considerably further than the practical advice that precedes it. This is the metaphysical floor under karma yoga rather than an instruction.',
   'अध्याय के अंत के क़रीब, और उससे पहले की व्यावहारिक सलाह से कहीं आगे। यह कर्मयोग के नीचे की तात्त्विक ज़मीन है, कोई निर्देश नहीं।',
   'Chapter ke ant ke kareeb, aur usse pehle ki practical salah se kahin aage. Yeh karma yoga ke neeche ki zameen hai, koi instruction nahi.',
   'Gunas are the qualities or modes that constitute a person''s nature. The claim is that action arises from that constitution — inherited temperament, formation, circumstance — and that the sense of being the author is added afterwards. Ahankara is literally the I-maker: not vanity, but the faculty that produces the feeling of authorship.',
   'गुण वे तत्त्व हैं जिनसे किसी का स्वभाव बनता है। दावा यह है कि कर्म उसी संरचना से उठता है — विरासत में मिला स्वभाव, गढ़न, परिस्थिति — और कर्ता होने का एहसास बाद में जोड़ा जाता है। अहंकार का शाब्दिक अर्थ है "मैं" बनाने वाला: घमंड नहीं, बल्कि वह क्षमता जो कर्तापन का एहसास पैदा करती है।',
   'Gunas woh cheezein hain jinse kisi ka swabhav banta hai. Claim yeh hai ki karm usi structure se uthta hai — virasat mein mila swabhav, gadhan, paristhiti — aur karta hone ka ehsaas baad mein joda jaata hai. Ahankara ka literal matlab hai "main" banane wala: ghamand nahi, balki woh kshamta jo kartapan ka ehsaas paida karti hai.',
   'Taken carelessly this dissolves responsibility, and it is worth saying plainly that the text does not go there — it spends eighteen chapters telling somebody to act well. Taken carefully it does something narrower and more useful: it makes both credit and blame look like the same mistake, which is a strange relief. The person who cannot forgive themselves for something ten years old is holding a claim of authorship this verse quietly declines.',
   'लापरवाही से लें तो यह ज़िम्मेदारी घोल देता है, और साफ़ कहना चाहिए कि ग्रंथ वहाँ जाता नहीं — वह अठारह अध्याय किसी से अच्छा कर्म करने को कहता है। ध्यान से लें तो यह छोटा और ज़्यादा काम का काम करता है: यह श्रेय और दोष दोनों को एक ही भूल जैसा दिखा देता है, जो एक अजीब राहत है। जो व्यक्ति दस साल पुरानी किसी बात के लिए ख़ुद को माफ़ नहीं कर पा रहा, वह कर्तापन का वही दावा थामे है जिसे यह श्लोक चुपचाप अस्वीकार कर देता है।',
   'Laparwahi se lo to yeh zimmedari ghol deta hai, aur saaf kehna chahiye ki text wahan jaata nahi — woh atharah chapter kisi se achha karm karne ko kehta hai. Dhyan se lo to yeh chhota aur zyada kaam ka kaam karta hai: yeh credit aur blame dono ko ek hi galti jaisa dikha deta hai, jo ek ajeeb raahat hai. Jo insaan das saal purani kisi baat ke liye khud ko maaf nahi kar paa raha, woh kartapan ka wahi dawa thame hai jise yeh shloka chupchap thukra deta hai.'

  UNION ALL SELECT 35, 'beginner',
   'Krishna returns to Arjuna''s actual situation. Arjuna is a soldier proposing to withdraw and live as an ascetic — to take up somebody else''s life because his own has become unbearable. That is the specific move this verse is answering.',
   'कृष्ण अर्जुन की असली स्थिति पर लौटते हैं। अर्जुन सैनिक है और हटकर संन्यासी की तरह जीने का प्रस्ताव रख रहा है — यानी किसी और का जीवन उठा लेना, क्योंकि अपना असह्य हो गया है। यह श्लोक ठीक उसी चाल का जवाब है।',
   'Krishna Arjun ki asli situation par lautte hain. Arjun sainik hai aur hat ke sanyasi ki tarah jeene ka proposal rakh raha hai — yaani kisi aur ka jeevan utha lena, kyunki apna asahaniya ho gaya hai. Yeh shloka theek usi chaal ka jawab hai.',
   'The verse says: the work that is actually yours, done imperfectly, is better than a competent performance of somebody else''s. Arjuna is not being told that soldiering is noble. He is being told that becoming an ascetic to escape a hard decision would be an imitation, and that imitations do not hold under pressure.',
   'श्लोक कहता है: जो काम सचमुच आपका है, वह अधूरे ढंग से भी, किसी और के काम को कुशलता से करने से बेहतर है। अर्जुन से यह नहीं कहा जा रहा कि योद्धा होना महान है। उससे यह कहा जा रहा है कि कठिन फ़ैसले से बचने के लिए संन्यासी बन जाना नक़ल होगी, और नक़ल दबाव में टिकती नहीं।',
   'Shloka kehta hai: jo kaam sach mein tumhara hai, woh adhoore dhang se bhi, kisi aur ke kaam ko kushalta se karne se behtar hai. Arjun se yeh nahi kaha ja raha ki yoddha hona mahan hai. Usse yeh kaha ja raha hai ki mushkil faisle se bachne ke liye sanyasi ban jaana nakal hogi, aur nakal dabav mein tikti nahi.',
   'This verse has been used for centuries to tell people that the circumstances of their birth are their duty and that leaving them is dangerous. That reading has done real harm and this product does not hold it. Nothing in the line ties svadharma to birth — the word means what is genuinely yours, which is discovered rather than assigned, and which changes across a life. Read it as an argument against imitation, which is what the context supports. Anybody who has watched somebody follow a parent into a profession they never wanted knows exactly which of the two readings the verse actually describes.',
   'सदियों से इस श्लोक का इस्तेमाल लोगों को यह बताने के लिए हुआ है कि जन्म की परिस्थितियाँ ही उनका कर्तव्य हैं और उन्हें छोड़ना ख़तरनाक है। उस पाठ ने सचमुच नुक़सान किया है और यह उत्पाद उसे नहीं मानता। पंक्ति में कहीं भी स्वधर्म को जन्म से नहीं जोड़ा गया — शब्द का अर्थ है जो सचमुच आपका है, जो सौंपा नहीं जाता बल्कि खोजा जाता है, और जो जीवन भर बदलता है। इसे नक़ल के ख़िलाफ़ दलील की तरह पढ़िए, जिसे संदर्भ भी सहारा देता है। जिसने किसी को माता-पिता के पीछे ऐसे पेशे में जाते देखा है जो उसने कभी चाहा ही नहीं, वह ठीक-ठीक जानता है कि दोनों में से कौन-सा पाठ इस श्लोक का असली विषय है।',
   'Sadiyon se is shloka ka istemaal logon ko yeh batane ke liye hua hai ki janm ki paristhitiyan hi unka kartavya hain aur unhe chhodna khatarnak hai. Us padhne ne sach mein nuksaan kiya hai aur yeh product use nahi maanta. Line mein kahin bhi svadharma ko janm se joda nahi gaya — shabd ka matlab hai jo sach mein tumhara hai, jo saunpa nahi jaata balki khoja jaata hai, aur jo zindagi bhar badalta hai. Ise nakal ke khilaf dalil ki tarah padho, jise context bhi support karta hai. Jisne kisi ko maa-baap ke peeche aise peshe mein jaate dekha hai jo usne kabhi chaha hi nahi, woh theek-theek jaanta hai ki dono mein se kaun sa padhna is shloka ka asli vishay hai.'

  UNION ALL SELECT 37, 'beginner',
   'Arjuna has just asked the most human question in the chapter: what is it that drags a person into doing damage, as though pushed, even when they do not want to? This is the answer, given without hedging.',
   'अर्जुन ने अभी अध्याय का सबसे मानवीय सवाल पूछा है: वह क्या है जो आदमी को नुक़सान करने में घसीट ले जाता है, जैसे धक्का दे रहा हो, तब भी जब वह चाहता न हो? यही जवाब है, बिना किसी हिचक के।',
   'Arjun ne abhi chapter ka sabse insaani sawaal poocha hai: woh kya hai jo aadmi ko nuksaan karne mein ghaseet le jaata hai, jaise dhakka de raha ho, tab bhi jab woh chahta na ho? Yahi jawab hai, bina kisi hichak ke.',
   'Kama and krodha — wanting and anger — are named as one thing with two faces, which is the same claim 2.62 made from the other direction. Mahashana means great-eating: it never fills up. That is the part worth holding on to. It is not that wanting is wicked; it is that satisfying it does not end it.',
   'काम और क्रोध — चाह और गुस्सा — एक ही चीज़ के दो चेहरे बताए गए हैं, वही दावा जो 2.62 दूसरी तरफ़ से करता है। महाशन यानी बहुत खाने वाला: यह कभी भरता नहीं। पकड़ने लायक हिस्सा यही है। बात यह नहीं कि चाहना बुरा है; बात यह है कि उसे पूरा कर देने से वह ख़त्म नहीं होती।',
   'Kama aur krodha — chaah aur gussa — ek hi cheez ke do chehre bataye gaye hain, wahi claim jo 2.62 doosri taraf se karta hai. Mahashana matlab bahut khaane wala: yeh kabhi bharta nahi. Pakadne layak hissa yahi hai. Baat yeh nahi ki chahna bura hai; baat yeh hai ki use poora kar dene se woh khatam nahi hoti.',
   'Naming something as an enemy is unfashionable and, here, useful. It relocates the problem: the person is not defective, there is a specific mechanism operating in them that operates in everybody. Somebody who believes they are weak-willed behaves very differently from somebody who believes they are dealing with a known appetite that has a known shape.',
   'किसी चीज़ को दुश्मन कहना आजकल पसंद नहीं किया जाता, और यहाँ यह काम का है। यह समस्या की जगह बदल देता है: आदमी में कोई खोट नहीं है, उसमें एक ख़ास तंत्र चल रहा है जो सबमें चलता है। जो ख़ुद को कमज़ोर इरादे वाला मानता है, वह उससे बहुत अलग बरतता है जो मानता है कि उसका सामना एक जानी-पहचानी भूख से है जिसका आकार पता है।',
   'Kisi cheez ko dushman kehna aajkal pasand nahi kiya jaata, aur yahan yeh kaam ka hai. Yeh problem ki jagah badal deta hai: aadmi mein koi khot nahi hai, usme ek khaas mechanism chal raha hai jo sabme chalta hai. Jo khud ko kamzor iraade wala maanta hai, woh usse bahut alag barta hai jo maanta hai ki uska saamna ek jaani-pehchani bhookh se hai jiska shape pata hai.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 3;

-- =====================================================================
-- 3. HOOKS, REFLECTIONS, PRACTICES, TOPICS
-- =====================================================================
-- The hook is the sentence somebody repeats to a friend a week later.
-- It has to survive being said out loud with no context around it.
-- =====================================================================

DELETE m FROM verse_memory_aids m JOIN verses v ON v.id = m.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 3 AND v.verse_number IN (5,8,16,19,21,27,35,37);
DELETE r FROM verse_reflections r JOIN verses v ON v.id = r.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 3 AND v.verse_number IN (5,8,16,19,21,27,35,37);
DELETE p FROM verse_practices p JOIN verses v ON v.id = p.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 3 AND v.verse_number IN (5,8,16,19,21,27,35,37);
DELETE vt FROM verse_topics vt JOIN verses v ON v.id = vt.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 3 AND v.verse_number IN (5,8,16,19,21,27,35,37);

INSERT INTO verse_memory_aids (verse_id, hook_en, hook_hi, hook_hinglish, analogy_en, analogy_hi, analogy_hinglish, visual_cue)
SELECT v.id, m.h_en, m.h_hi, m.h_hing, m.a_en, m.a_hi, m.a_hing, m.cue FROM (
  SELECT 5 AS vn,
  'Not choosing is a choice that still runs on your legs.' AS h_en,
  'न चुनना भी एक चुनाव है, और चलता आपकी ही टाँगों पर है।' AS h_hi,
  'Na chunna bhi ek chunaav hai, aur chalta tumhari hi taangon par hai.' AS h_hing,
  'Like standing still on an escalator. You have stopped walking; you have not stopped arriving.' AS a_en,
  'एस्केलेटर पर खड़े रह जाने जैसा। चलना बंद किया है, पहुँचना नहीं।' AS a_hi,
  'Escalator par khade reh jaane jaisa. Chalna band kiya hai, pahunchna nahi.' AS a_hing,
  'A person standing still on a moving escalator' AS cue

  UNION ALL SELECT 8,
  'Doing the ordinary thing badly still beats doing nothing beautifully.',
  'साधारण काम ठीक से न होना भी, कुछ न करने से बेहतर है।',
  'Sadharan kaam theek se na hona bhi, kuch na karne se behtar hai.',
  'Like a body that stops moving. Rest was never the opposite of strain — disuse is.',
  'उस शरीर जैसा जो हिलना बंद कर दे। आराम कभी मेहनत का उल्टा था ही नहीं — बेकार पड़े रहना है।',
  'Us sharir jaisa jo hilna band kar de. Aaram kabhi mehnat ka ulta tha hi nahi — bekaar pade rehna hai.',
  'A door hinge, one oiled and one seized'

  UNION ALL SELECT 16,
  'If you only take from the wheel, you are not living. You are consuming.',
  'अगर आप चक्र से सिर्फ़ लेते हैं, तो जी नहीं रहे। बस खा रहे हैं।',
  'Agar tum chakr se sirf lete ho, to jee nahi rahe. Bas kha rahe ho.',
  'Like a shared kitchen where one person only ever eats. Nothing breaks the first month. By the sixth, nobody cooks.',
  'साझा रसोई जैसी जहाँ एक आदमी सिर्फ़ खाता है। पहले महीने कुछ नहीं टूटता। छठे तक कोई पकाता नहीं।',
  'Shared kitchen jaisi jahan ek aadmi sirf khata hai. Pehle mahine kuch nahi tootta. Chhathe tak koi pakata nahi.',
  'A wheel with one spoke missing, still turning, wobbling'

  UNION ALL SELECT 19,
  'Do the work. Put down the result. Both halves, or neither works.',
  'काम कीजिए। नतीजा रख दीजिए। दोनों आधे, वरना कोई नहीं चलता।',
  'Kaam karo. Result rakh do. Dono aadhe, warna koi nahi chalta.',
  'Like posting a letter. You wrote it as well as you could; the post box does not take instructions.',
  'चिट्ठी डालने जैसा। जितना अच्छा लिख सकते थे लिखा; डाकपेटी हिदायत नहीं लेती।',
  'Chitthi daalne jaisa. Jitna achha likh sakte the likha; letterbox hidayat nahi leti.',
  'A hand releasing an envelope into a post box'

  UNION ALL SELECT 21,
  'People do not copy what you say. They copy what you do when you think nobody is counting.',
  'लोग वह नक़ल नहीं करते जो आप कहते हैं। वह करते हैं जो आप तब करते हैं जब लगता है कोई गिन नहीं रहा।',
  'Log woh nakal nahi karte jo tum kehte ho. Woh karte hain jo tum tab karte ho jab lagta hai koi gin nahi raha.',
  'Like a household accent. Nobody in it was taught; everybody in it has one.',
  'घर के लहजे जैसा। किसी को सिखाया नहीं गया; सबका एक है।',
  'Ghar ke lehje jaisa. Kisi ko sikhaya nahi gaya; sabka ek hai.',
  'A row of footprints in snow, all following the first'

  UNION ALL SELECT 27,
  'Nature does the work. The ego signs the receipt.',
  'काम प्रकृति करती है। रसीद पर दस्तख़त अहंकार करता है।',
  'Kaam prakriti karti hai. Receipt par dastkhat ahankaar karta hai.',
  'Like taking credit for the weather because you carried an umbrella.',
  'मौसम का श्रेय लेने जैसा क्योंकि आप छाता ले गए थे।',
  'Mausam ka credit lene jaisa kyunki tum chhata le gaye the.',
  'A signature on a document somebody else wrote'

  UNION ALL SELECT 35,
  'Your own work, done badly, beats an excellent imitation of somebody else''s.',
  'अपना काम, ठीक से न भी हो, किसी और के काम की बेहतरीन नक़ल से बेहतर है।',
  'Apna kaam, theek se na bhi ho, kisi aur ke kaam ki behtareen nakal se behtar hai.',
  'Like wearing shoes a size too small because they are nicer. They are nicer. You will not get far.',
  'एक नंबर छोटे जूते पहनने जैसा क्योंकि वे सुंदर हैं। सुंदर हैं। दूर तक नहीं जाएँगे।',
  'Ek number chhote joote pehnne jaisa kyunki woh sundar hain. Sundar hain. Door tak nahi jaoge.',
  'Two pairs of shoes, one worn and shaped to a foot'

  UNION ALL SELECT 37,
  'Wanting and anger are one appetite with two faces. It never fills up.',
  'चाह और गुस्सा एक ही भूख के दो चेहरे हैं। वह कभी भरती नहीं।',
  'Chaah aur gussa ek hi bhookh ke do chehre hain. Woh kabhi bharti nahi.',
  'Like scratching. The relief is real and it is also the mechanism by which it gets worse.',
  'खुजाने जैसा। राहत सचमुच मिलती है, और वही तरीक़ा है जिससे यह बढ़ती है।',
  'Khujane jaisa. Raahat sach mein milti hai, aur wahi tareeka hai jisse yeh badhti hai.',
  'A fire being fed, the flame the same size'
) AS m
JOIN verses v ON v.verse_number = m.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 3;

INSERT INTO verse_reflections (verse_id, question_en, question_hi, question_hinglish, display_order)
SELECT v.id, r.q_en, r.q_hi, r.q_hing, r.ord FROM (
  SELECT 5 AS vn, 'What are you currently calling "not deciding yet"?' AS q_en, 'अभी आप किसे "अभी तय नहीं किया" कह रहे हैं?' AS q_hi, 'Abhi tum kise "abhi tay nahi kiya" keh rahe ho?' AS q_hing, 1 AS ord
  UNION ALL SELECT 5, 'If waiting is also a move, what has your waiting already cost or bought?', 'अगर इंतज़ार भी एक चाल है, तो आपके इंतज़ार ने अब तक क्या ख़र्च किया या क्या दिलाया?', 'Agar intezaar bhi ek chaal hai, to tumhare intezaar ne ab tak kya kharcha kiya ya kya dilaya?', 2
  UNION ALL SELECT 5, 'Which of your habits runs without you agreeing to it each time?', 'आपकी कौन-सी आदत हर बार आपकी सहमति के बिना चलती है?', 'Tumhari kaun si aadat har baar tumhari sehmati ke bina chalti hai?', 3
  UNION ALL SELECT 8, 'What is the ordinary work in front of you that you are avoiding for something more interesting?', 'सामने पड़ा वह साधारण काम कौन-सा है जिसे आप किसी ज़्यादा दिलचस्प चीज़ के लिए टाल रहे हैं?', 'Saamne pada woh sadharan kaam kaun sa hai jise tum kisi zyada interesting cheez ke liye taal rahe ho?', 1
  UNION ALL SELECT 8, 'Have you ever mistaken withdrawal for peace? How long did it hold?', 'क्या आपने कभी पीछे हट जाने को शांति समझ लिया है? वह कितने दिन टिका?', 'Kya tumne kabhi peechhe hat jaane ko shanti samajh liya hai? Woh kitne din tika?', 2
  UNION ALL SELECT 8, 'What would tomorrow look like if you only did the next required thing?', 'अगर आप सिर्फ़ अगला ज़रूरी काम करें, तो कल कैसा दिखेगा?', 'Agar tum sirf agla zaroori kaam karo, to kal kaisa dikhega?', 3
  UNION ALL SELECT 16, 'Name three things you used today that you did not make and did not pay the real cost of.', 'आज इस्तेमाल की तीन चीज़ें बताइए जो आपने बनाई नहीं और जिनकी असली क़ीमत आपने चुकाई नहीं।', 'Aaj use ki teen cheezein batao jo tumne banayi nahi aur jinki asli keemat tumne chukayi nahi.', 1
  UNION ALL SELECT 16, 'Where in your life are you a taker who has not noticed?', 'आपकी ज़िंदगी में वह जगह कौन-सी है जहाँ आप लेने वाले हैं और आपको ध्यान नहीं गया?', 'Tumhari zindagi mein woh jagah kaun si hai jahan tum lene wale ho aur tumhara dhyan nahi gaya?', 2
  UNION ALL SELECT 16, 'What did somebody keep running so that your ordinary week was possible?', 'आपका साधारण हफ़्ता मुमकिन हो, इसके लिए किसने क्या चलाए रखा?', 'Tumhara sadharan hafta mumkin ho, iske liye kisne kya chalaye rakha?', 3
  UNION ALL SELECT 19, 'Which half do you find harder — doing the work, or letting go of the result?', 'आपको कौन-सा आधा मुश्किल लगता है — काम करना, या नतीजा छोड़ना?', 'Tumhe kaun sa aadha mushkil lagta hai — kaam karna, ya result chhodna?', 1
  UNION ALL SELECT 19, 'What is a piece of work you did well and then spoiled by how you waited for the response?', 'ऐसा कौन-सा काम है जो आपने अच्छा किया और फिर जवाब का इंतज़ार करने के तरीक़े से बिगाड़ दिया?', 'Aisa kaun sa kaam hai jo tumne achha kiya aur phir jawab ka intezaar karne ke tareeke se bigaad diya?', 2
  UNION ALL SELECT 19, 'If the result were guaranteed, would you do this work differently? What does that tell you?', 'अगर नतीजा पक्का होता, तो क्या आप यह काम अलग तरह से करते? इससे क्या पता चलता है?', 'Agar result pakka hota, to kya tum yeh kaam alag tarah se karte? Isse kya pata chalta hai?', 3
  UNION ALL SELECT 21, 'Who is watching you that you have not counted?', 'आपको कौन देख रहा है जिसे आपने गिना ही नहीं?', 'Tumhe kaun dekh raha hai jise tumne gina hi nahi?', 1
  UNION ALL SELECT 21, 'What behaviour did you pick up from somebody who never taught it to you?', 'आपने कौन-सा बरताव उससे उठाया जिसने वह कभी सिखाया नहीं?', 'Tumne kaun sa behaviour usse uthaya jisne woh kabhi sikhaya nahi?', 2
  UNION ALL SELECT 21, 'Where do your instructions and your example currently disagree?', 'अभी आपकी हिदायत और आपका उदाहरण कहाँ आपस में नहीं मिलते?', 'Abhi tumhari hidayat aur tumhara example kahan aapas mein nahi milte?', 3
  UNION ALL SELECT 27, 'What are you taking credit for that also required a hundred things you did not arrange?', 'आप किस बात का श्रेय ले रहे हैं जिसके लिए सौ ऐसी चीज़ें भी चाहिए थीं जो आपने जुटाई नहीं?', 'Tum kis baat ka credit le rahe ho jiske liye sau aisi cheezein bhi chahiye thi jo tumne jutayi nahi?', 1
  UNION ALL SELECT 27, 'What are you blaming yourself for that also had a hundred causes?', 'आप किस बात के लिए ख़ुद को दोष दे रहे हैं जिसके सौ कारण थे?', 'Tum kis baat ke liye khud ko dosh de rahe ho jiske sau kaaran the?', 2
  UNION ALL SELECT 27, 'If credit and blame are the same mistake, which one do you make more often?', 'अगर श्रेय और दोष एक ही भूल हैं, तो आप कौन-सी ज़्यादा करते हैं?', 'Agar credit aur blame ek hi galti hain, to tum kaun si zyada karte ho?', 3
  UNION ALL SELECT 35, 'Whose life are you currently performing a version of?', 'आप इस वक़्त किसकी ज़िंदगी का कोई रूप निभा रहे हैं?', 'Tum is waqt kiski zindagi ka koi roop nibha rahe ho?', 1
  UNION ALL SELECT 35, 'Has this verse ever been used on you to keep you somewhere? What did it leave out?', 'क्या यह श्लोक कभी आप पर कहीं टिकाए रखने के लिए इस्तेमाल हुआ है? उसमें क्या छोड़ दिया गया था?', 'Kya yeh shloka kabhi tum par kahin tikaye rakhne ke liye use hua hai? Usme kya chhod diya gaya tha?', 2
  UNION ALL SELECT 35, 'What is genuinely yours — not what you were handed, and not what looks best?', 'सचमुच आपका क्या है — वह नहीं जो थमाया गया, और वह भी नहीं जो सबसे अच्छा दिखता है?', 'Sach mein tumhara kya hai — woh nahi jo thamaya gaya, aur woh bhi nahi jo sabse achha dikhta hai?', 3
  UNION ALL SELECT 37, 'What is the thing you keep feeding that has never once stayed fed?', 'वह क्या है जिसे आप खिलाते रहते हैं और जो एक बार भी भरा नहीं?', 'Woh kya hai jise tum khilate rehte ho aur jo ek baar bhi bhara nahi?', 1
  UNION ALL SELECT 37, 'When you are angry, what were you wanting just before?', 'जब गुस्सा आता है, उससे ठीक पहले आप क्या चाह रहे थे?', 'Jab gussa aata hai, usse theek pehle tum kya chah rahe the?', 2
  UNION ALL SELECT 37, 'Does calling this an enemy help you or does it make you fight yourself?', 'इसे दुश्मन कहना आपकी मदद करता है, या आपसे आपकी ही लड़ाई करा देता है?', 'Ise dushman kehna tumhari madad karta hai, ya tumse tumhari hi ladai kara deta hai?', 3
) AS r
JOIN verses v ON v.verse_number = r.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 3;

INSERT INTO verse_practices (verse_id, action_en, action_hi, action_hinglish, estimated_minutes, difficulty, display_order)
SELECT v.id, p.a_en, p.a_hi, p.a_hing, p.mins, p.diff, 1 FROM (
  SELECT 5 AS vn, 'Write down one decision you are postponing. Underneath it, write what is happening in the meantime.' AS a_en, 'एक फ़ैसला लिखिए जिसे आप टाल रहे हैं। उसके नीचे लिखिए कि इस बीच क्या हो रहा है।' AS a_hi, 'Ek faisla likho jise tum taal rahe ho. Uske neeche likho ki is beech kya ho raha hai.' AS a_hing, 5 AS mins, 'beginner' AS diff
  UNION ALL SELECT 8, 'Pick the smallest required task you have been avoiding and do it now, badly if necessary.', 'सबसे छोटा ज़रूरी काम चुनिए जिसे आप टाल रहे हैं और अभी कर डालिए, ज़रूरत हो तो ख़राब ही सही।', 'Sabse chhota zaroori kaam chuno jise tum taal rahe ho aur abhi kar daalo, zaroorat ho to kharab hi sahi.', 10, 'beginner'
  UNION ALL SELECT 16, 'List five things you used today. Beside each, name one person whose work made it available.', 'आज इस्तेमाल की पाँच चीज़ें लिखिए। हर एक के आगे एक व्यक्ति का नाम लिखिए जिसके काम से वह मिली।', 'Aaj use ki paanch cheezein likho. Har ek ke aage ek insaan ka naam likho jiske kaam se woh mili.', 8, 'beginner'
  UNION ALL SELECT 19, 'Before your next task, write the sentence "I am doing this well and I do not control what comes back." Then do it.', 'अगले काम से पहले यह वाक्य लिखिए — "मैं इसे अच्छा कर रहा हूँ और जो लौटेगा वह मेरे बस में नहीं।" फिर काम कीजिए।', 'Agle kaam se pehle yeh line likho — "Main ise achha kar raha hoon aur jo lautega woh mere bas mein nahi." Phir kaam karo.', 3, 'beginner'
  UNION ALL SELECT 21, 'Notice one thing you did today that somebody younger or junior could have seen. Ask whether you would recommend it.', 'आज किया कोई एक काम ध्यान में लाइए जिसे कोई छोटा या जूनियर देख सकता था। पूछिए कि क्या आप उसकी सिफ़ारिश करेंगे।', 'Aaj kiya koi ek kaam dhyan mein lao jise koi chhota ya junior dekh sakta tha. Poocho ki kya tum uski sifarish karoge.', 5, 'intermediate'
  UNION ALL SELECT 27, 'Take one recent success and list six things that had to be true that you did not arrange. Then do it for one failure.', 'हाल की एक सफलता लीजिए और छह ऐसी बातें लिखिए जो सच होनी थीं और आपने जुटाई नहीं थीं। फिर एक असफलता के लिए वही कीजिए।', 'Haal ki ek safalta lo aur chhah aisi baatein likho jo sach honi thi aur tumne jutayi nahi thi. Phir ek failure ke liye wahi karo.', 12, 'intermediate'
  UNION ALL SELECT 35, 'Write one sentence describing work that is genuinely yours. If it is somebody else''s description, start again.', 'एक वाक्य लिखिए जो उस काम को बताए जो सचमुच आपका है। अगर वह किसी और का बयान है, फिर से शुरू कीजिए।', 'Ek line likho jo us kaam ko bataye jo sach mein tumhara hai. Agar woh kisi aur ka bayan hai, phir se shuru karo.', 10, 'intermediate'
  UNION ALL SELECT 37, 'The next time you feel anger arriving, name out loud or on paper what you were wanting thirty seconds earlier.', 'अगली बार गुस्सा आता महसूस हो, तो बोलकर या लिखकर बताइए कि तीस सेकंड पहले आप क्या चाह रहे थे।', 'Agli baar gussa aata mehsoos ho, to bolkar ya likhkar batao ki tees second pehle tum kya chah rahe the.', 2, 'beginner'
) AS p
JOIN verses v ON v.verse_number = p.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 3;

INSERT INTO verse_topics (verse_id, topic_id, relevance)
SELECT v.id, t.id, x.rel FROM (
  SELECT 5 AS vn, 'duty' AS slug, 9 AS rel
  UNION ALL SELECT 5, 'hard-decisions', 9
  UNION ALL SELECT 5, 'restlessness', 7
  UNION ALL SELECT 5, 'action-without-attachment', 7
  UNION ALL SELECT 8, 'duty', 10
  UNION ALL SELECT 8, 'action-without-attachment', 8
  UNION ALL SELECT 8, 'restlessness', 7
  UNION ALL SELECT 8, 'burnout', 6
  UNION ALL SELECT 16, 'duty', 9
  UNION ALL SELECT 16, 'desire', 7
  UNION ALL SELECT 16, 'action-without-attachment', 6
  UNION ALL SELECT 19, 'action-without-attachment', 10
  UNION ALL SELECT 19, 'effort-without-result', 10
  UNION ALL SELECT 19, 'duty', 9
  UNION ALL SELECT 19, 'steadiness', 7
  UNION ALL SELECT 21, 'duty', 9
  UNION ALL SELECT 21, 'comparison', 7
  UNION ALL SELECT 21, 'steadiness', 6
  UNION ALL SELECT 27, 'the-self', 9
  UNION ALL SELECT 27, 'action-without-attachment', 8
  UNION ALL SELECT 27, 'comparison', 7
  UNION ALL SELECT 27, 'grief', 6
  UNION ALL SELECT 35, 'duty', 10
  UNION ALL SELECT 35, 'comparison', 10
  UNION ALL SELECT 35, 'hard-decisions', 9
  UNION ALL SELECT 35, 'the-self', 7
  UNION ALL SELECT 37, 'desire', 10
  UNION ALL SELECT 37, 'anger', 10
  UNION ALL SELECT 37, 'restlessness', 8
  UNION ALL SELECT 37, 'hard-decisions', 6
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 3
JOIN topics t ON t.slug = x.slug;

-- =====================================================================
-- 4. MODERN EXAMPLES
-- =====================================================================
-- Three per verse. Written from ordinary life rather than from anything
-- published: no film dialogue, no lyrics, no quoted translation.
--
-- The 3.35 set is the one to read closely. Every scenario there is about
-- a person choosing between their own work and an imitation of somebody
-- else's — never about the circumstances of anybody's birth. That is the
-- boundary the explanation draws and these examples do not cross it.
--
-- No living politician, party or movement is named, praised or
-- criticised anywhere in this file.
-- =====================================================================

DELETE e FROM modern_examples e JOIN verses v ON v.id = e.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 3 AND v.verse_number IN (5,8,16,19,21,27,35,37);

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

  SELECT 5 AS vn, 'corporate' AS cat, 1 AS ord,
  'The offer nobody answered' AS t_en, 'वह प्रस्ताव जिसका जवाब किसी ने नहीं दिया' AS t_hi, 'Woh offer jiska jawab kisi ne nahi diya' AS t_hing,
  'A job offer arrives with a two-week window. The person means to think about it properly, and does think about it, in the way you think about something at eleven at night without reaching a conclusion. On day fifteen the recruiter follows up once, politely, and then stops. Nothing was decided. Something was settled.' AS s_en,
  'नौकरी का प्रस्ताव दो हफ़्ते की मियाद के साथ आता है। आदमी ठीक से सोचना चाहता है, और सोचता भी है — उस तरह जैसे रात ग्यारह बजे किसी बात के बारे में सोचा जाता है, बिना किसी नतीजे पर पहुँचे। पंद्रहवें दिन भर्ती करने वाला एक बार शालीनता से याद दिलाता है, फिर चुप हो जाता है। तय कुछ नहीं हुआ। तय सब हो गया।' AS s_hi,
  'Job offer do hafte ki deadline ke saath aata hai. Aadmi theek se sochna chahta hai, aur sochta bhi hai — us tarah jaise raat gyarah baje kisi baat ke baare mein socha jaata hai, bina kisi nateeje par pahunche. Pandrahwe din recruiter ek baar shalinta se yaad dilata hai, phir chup ho jaata hai. Tay kuch nahi hua. Tay sab ho gaya.' AS s_hing,
  'The verse says nobody stays actionless for even a moment. Two weeks of not answering was not a pause before the decision — it was the decision, executed slowly and without anybody having to own it. The comfortable thing about deciding this way is that it never feels like a choice, so it never has to be defended.' AS c_en,
  'श्लोक कहता है कि कोई एक क्षण भी निष्क्रिय नहीं रहता। दो हफ़्ते जवाब न देना फ़ैसले से पहले का ठहराव नहीं था — वही फ़ैसला था, धीरे-धीरे लागू होता हुआ, और किसी को उसे अपना कहना भी नहीं पड़ा। इस तरह तय करने में सुविधा यही है कि यह चुनाव जैसा लगता ही नहीं, इसलिए इसका बचाव भी नहीं करना पड़ता।' AS c_hi,
  'Shloka kehta hai ki koi ek pal bhi nishkriya nahi rehta. Do hafte jawab na dena faisle se pehle ka thehrav nahi tha — wahi faisla tha, dheere-dheere lagoo hota hua, aur kisi ko use apna kehna bhi nahi pada. Is tarah tay karne mein suvidha yahi hai ki yeh choice jaisa lagta hi nahi, isliye iska bachav bhi nahi karna padta.' AS c_hing,
  'A decision you did not make is still a decision. It was just made without you present for it.' AS l_en,
  'जो फ़ैसला आपने नहीं किया वह भी फ़ैसला है। बस उस वक़्त आप वहाँ मौजूद नहीं थे।' AS l_hi,
  'Jo faisla tumne nahi kiya woh bhi faisla hai. Bas us waqt tum wahan maujood nahi the.' AS l_hing,
  NULL AS src, 'beginner' AS diff, 'work,decision,avoidance,time,default' AS tags

  UNION ALL SELECT 5, 'relationships', 2,
  'The conversation that kept not happening', 'वह बातचीत जो होती ही नहीं रही', 'Woh baat jo hoti hi nahi rahi',
  'Two people have needed to talk about the same thing for about eight months. Neither is avoiding it exactly; the moment is never right, and the moments that are right are the ones where things are going well and raising it would spoil them. In the eighth month one of them notices they have started planning around the other person rather than with them.',
  'दो लोगों को एक ही बात पर बात करनी है, क़रीब आठ महीने से। ठीक-ठीक कोई टाल नहीं रहा; मौक़ा कभी सही नहीं होता, और जो मौक़े सही होते हैं वे वही हैं जब सब अच्छा चल रहा हो और बात उठाना उसे बिगाड़ देगा। आठवें महीने में उनमें से एक को लगता है कि वह अब दूसरे के साथ नहीं, दूसरे को हिसाब में रखकर योजना बनाने लगा है।',
  'Do logon ko ek hi baat par baat karni hai, karib aath mahine se. Theek-theek koi taal nahi raha; mauka kabhi sahi nahi hota, aur jo mauke sahi hote hain woh wahi hain jab sab achha chal raha ho aur baat uthana use bigaad dega. Aathwe mahine mein unme se ek ko lagta hai ki woh ab doosre ke saath nahi, doosre ko hisaab mein rakh kar plan banane laga hai.',
  'Eight months of not having a conversation is not eight months of nothing. Something was built in that time, and it was built by the avoidance rather than by either person. The verse is unsentimental about this: you are being acted through whether or not you have agreed to anything.',
  'आठ महीने बात न करना आठ महीने का कुछ न होना नहीं है। उस दौरान कुछ बना, और वह टालने से बना, दोनों में से किसी के बनाने से नहीं। श्लोक इस पर भावुक नहीं होता: आपके ज़रिये काम हो रहा है, चाहे आपने किसी बात पर हामी भरी हो या नहीं।',
  'Aath mahine baat na karna aath mahine ka kuch na hona nahi hai. Us dauran kuch bana, aur woh taalne se bana, dono mein se kisi ke banane se nahi. Shloka is par bhavuk nahi hota: tumhare zariye kaam ho raha hai, chahe tumne kisi baat par haami bhari ho ya nahi.',
  'Avoidance is not a pause in the relationship. It is a thing the relationship is being built out of.',
  'टालना रिश्ते में ठहराव नहीं है। वह उस सामान में से एक है जिससे रिश्ता बन रहा है।',
  'Taalna rishte mein thehrav nahi hai. Woh us saamaan mein se ek hai jisse rishta ban raha hai.',
  NULL, 'intermediate', 'relationships,avoidance,communication,drift,time'

  UNION ALL SELECT 5, 'finance', 3,
  'The money sitting in the current account', 'चालू खाते में पड़ा पैसा', 'Current account mein pada paisa',
  'Somebody inherits a modest sum and decides not to do anything hasty with it, which is sensible. Three years later it is still in a current account earning nothing while prices have moved. They describe this to a friend as having been cautious. The friend, who is blunter than most friends, points out that they took a position — just not one they chose.',
  'किसी को थोड़ी विरासत मिलती है और वह तय करता है कि जल्दबाज़ी में कुछ नहीं करेगा, जो समझदारी है। तीन साल बाद वह पैसा अब भी चालू खाते में है, कुछ कमा नहीं रहा, जबकि दाम बढ़ चुके हैं। वह दोस्त को बताता है कि उसने सावधानी बरती। दोस्त, जो ज़्यादातर दोस्तों से ज़्यादा सीधा है, कहता है कि उसने एक स्थिति ली — बस वह उसकी चुनी हुई नहीं थी।',
  'Kisi ko thodi virasat milti hai aur woh tay karta hai ki jaldbaazi mein kuch nahi karega, jo samajhdari hai. Teen saal baad woh paisa ab bhi current account mein hai, kuch kama nahi raha, jabki daam badh chuke hain. Woh dost ko batata hai ki usne savdhani barti. Dost, jo zyadatar doston se zyada seedha hai, kehta hai ki usne ek position li — bas woh uski chuni hui nahi thi.',
  'Holding cash is a position. So is holding nothing, holding on, and waiting for clarity. The verse is not advice about money and it makes the structural point exactly: there is no square on the board marked "not playing". This is where a reader usually first believes the claim, because the arithmetic is visible.',
  'नक़दी रखना एक स्थिति है। कुछ न रखना, थामे रहना, साफ़ तस्वीर का इंतज़ार करना — ये भी। श्लोक पैसे की सलाह नहीं है और ढाँचे की बात ठीक-ठीक कह देता है: बोर्ड पर "नहीं खेल रहे" का कोई ख़ाना नहीं है। पाठक अक्सर पहली बार यहीं दावा मानता है, क्योंकि हिसाब दिख जाता है।',
  'Cash rakhna ek position hai. Kuch na rakhna, thaame rehna, saaf tasveer ka intezaar karna — yeh bhi. Shloka paise ki salah nahi hai aur dhaanche ki baat theek-theek keh deta hai: board par "nahi khel rahe" ka koi khaana nahi hai. Padhne wala aksar pehli baar yahin claim maanta hai, kyunki hisaab dikh jaata hai.',
  'There is no square on the board marked "not playing".',
  'बोर्ड पर "नहीं खेल रहे" का कोई ख़ाना नहीं है।',
  'Board par "nahi khel rahe" ka koi khaana nahi hai.',
  NULL, 'beginner', 'money,inaction,default,caution,time'

  UNION ALL SELECT 8, 'everyday_life', 1,
  'The flat that was going to be sorted properly', 'वह घर जो ठीक से जमाया जाना था', 'Woh ghar jo theek se jamaya jaana tha',
  'A person decides the flat needs a proper clear-out, not the usual tidying — a real one, with boxes and decisions, done over a weekend when there is time. Fourteen months pass. Meanwhile the surfaces get worse in the ordinary way, because the ordinary way was the only thing actually holding the line and it stopped.',
  'एक आदमी तय करता है कि घर की सही सफ़ाई होनी चाहिए, रोज़ वाली नहीं — असली वाली, डिब्बों और फ़ैसलों के साथ, किसी ऐसे सप्ताहांत पर जब वक़्त हो। चौदह महीने बीत जाते हैं। इस बीच जगहें उसी साधारण तरीक़े से बिगड़ती जाती हैं, क्योंकि वही साधारण तरीक़ा असल में मोर्चा थामे था और वह बंद हो गया।',
  'Ek aadmi tay karta hai ki ghar ki sahi safai honi chahiye, roz wali nahi — asli wali, dibbon aur faislon ke saath, kisi aise weekend par jab waqt ho. Chaudah mahine beet jaate hain. Is beech jagahein usi sadharan tareeke se bigadti jaati hain, kyunki wahi sadharan tareeka asal mein morcha thaame tha aur woh band ho gaya.',
  'The verse says do the required work, and it is worth noticing how modest the word "required" is. It does not say do the transformative work. Waiting for the weekend with enough time in it is one of the most reliable ways to stop doing the small thing that was working.',
  'श्लोक कहता है कि तय काम कीजिए, और ध्यान देने लायक है कि "तय" शब्द कितना मामूली है। वह यह नहीं कहता कि बदल देने वाला काम कीजिए। इतने वक़्त वाले सप्ताहांत का इंतज़ार करना उस छोटे काम को बंद करने के सबसे भरोसेमंद तरीक़ों में एक है जो चल रहा था।',
  'Shloka kehta hai ki tay kaam karo, aur dhyan dene layak hai ki "tay" shabd kitna mamooli hai. Woh yeh nahi kehta ki badal dene wala kaam karo. Itne waqt wale weekend ka intezaar karna us chhote kaam ko band karne ke sabse bharosemand tareekon mein ek hai jo chal raha tha.',
  'Waiting to do it properly is usually how you stop doing it at all.',
  'ठीक से करने का इंतज़ार अक्सर वही तरीक़ा है जिससे करना बिलकुल बंद हो जाता है।',
  'Theek se karne ka intezaar aksar wahi tareeka hai jisse karna bilkul band ho jaata hai.',
  NULL, 'beginner', 'habits,procrastination,home,small-actions,upkeep'

  UNION ALL SELECT 8, 'healthcare', 2,
  'The physiotherapy nobody enjoys', 'वह फ़िज़ियोथेरेपी जो किसी को अच्छी नहीं लगती', 'Woh physiotherapy jo kisi ko achhi nahi lagti',
  'After a knee injury the exercises are ten minutes, twice a day, and dull in a way that is hard to overstate. The patient does them for five weeks and then, feeling better, stops. Two months later the knee is worse than at week five. The physiotherapist has seen this so many times that she has a sentence ready for it and delivers it without any triumph.',
  'घुटने की चोट के बाद व्यायाम दस मिनट के हैं, दिन में दो बार, और इतने नीरस कि बताना मुश्किल है। मरीज़ पाँच हफ़्ते करता है और फिर, बेहतर महसूस होने पर, बंद कर देता है। दो महीने बाद घुटना पाँचवें हफ़्ते से भी ख़राब है। फ़िज़ियोथेरेपिस्ट यह इतनी बार देख चुकी है कि उसके पास एक वाक्य तैयार है, और वह उसे बिना किसी जीत के भाव के कह देती है।',
  'Ghutne ki chot ke baad exercise das minute ke hain, din mein do baar, aur itne boring ki batana mushkil hai. Mareez paanch hafte karta hai aur phir, behtar mehsoos hone par, band kar deta hai. Do mahine baad ghutna paanchwe hafte se bhi kharab hai. Physiotherapist yeh itni baar dekh chuki hai ki uske paas ek line tayyar hai, aur woh use bina kisi jeet ke bhaav ke keh deti hai.',
  'Stopping felt like rest and functioned like decline. That is the verse''s actual claim: not acting is not neutral, and the body is the place where this is easiest to verify because it keeps its own records. Nothing here requires believing anything metaphysical.',
  'रुकना आराम जैसा लगा और काम गिरावट का किया। श्लोक का असली दावा यही है: न करना तटस्थ नहीं होता, और शरीर वह जगह है जहाँ यह जाँचना सबसे आसान है क्योंकि वह अपना हिसाब ख़ुद रखता है। इसमें कुछ भी तत्त्व-संबंधी मानने की ज़रूरत नहीं।',
  'Rukna aaram jaisa laga aur kaam giravat ka kiya. Shloka ka asli claim yahi hai: na karna neutral nahi hota, aur sharir woh jagah hai jahan yeh jaanchna sabse asaan hai kyunki woh apna hisaab khud rakhta hai. Isme kuch bhi metaphysical maanne ki zaroorat nahi.',
  'Rest is not the opposite of strain. Disuse is, and the body keeps the receipts.',
  'आराम मेहनत का उल्टा नहीं है। बेकार पड़े रहना है, और शरीर रसीदें संभालकर रखता है।',
  'Aaram mehnat ka ulta nahi hai. Bekaar pade rehna hai, aur sharir receipt sambhal kar rakhta hai.',
  NULL, 'beginner', 'health,discipline,recovery,consistency,body'

  UNION ALL SELECT 8, 'startup', 3,
  'The founder who read for a year', 'वह संस्थापक जिसने एक साल पढ़ाई की', 'Woh founder jisne ek saal padhai ki',
  'Somebody preparing to start a business spends fourteen months reading, attending things, and refining a plan document that reaches its ninth version. The plan is genuinely better than version one. Nothing has been sold. When they finally speak to eleven potential customers in a fortnight, six of the nine versions turn out to have been solving a problem nobody described.',
  'व्यवसाय शुरू करने की तैयारी में कोई चौदह महीने पढ़ता है, कार्यक्रमों में जाता है, और एक योजना-पत्र सुधारता रहता है जो नौवें रूप तक पहुँच जाता है। योजना पहले रूप से सचमुच बेहतर है। बेचा कुछ नहीं गया। जब वह आख़िरकार दो हफ़्ते में ग्यारह संभावित ग्राहकों से बात करता है, तो नौ में से छह रूप ऐसी समस्या हल कर रहे निकलते हैं जो किसी ने बताई ही नहीं थी।',
  'Business shuru karne ki taiyari mein koi chaudah mahine padhta hai, events mein jaata hai, aur ek plan document sudharta rehta hai jo nauve version tak pahunch jaata hai. Plan pehle version se sach mein behtar hai. Becha kuch nahi gaya. Jab woh aakhirkar do hafte mein gyarah sambhavit customers se baat karta hai, to nau mein se chhah version aisi samasya hal karte nikalte hain jo kisi ne batayi hi nahi thi.',
  'Preparation can be the most respectable form of not acting, because it produces artefacts and looks like progress. The verse is not against thinking; it is against the idea that a period of not doing is a neutral holding pattern. Fourteen months bought nine versions and no contact with reality.',
  'तैयारी न करने का सबसे इज़्ज़तदार रूप हो सकती है, क्योंकि उससे कुछ बनता दिखता है और वह प्रगति जैसी लगती है। श्लोक सोचने के ख़िलाफ़ नहीं है; वह इस विचार के ख़िलाफ़ है कि न करने का दौर एक तटस्थ ठहराव है। चौदह महीनों ने नौ रूप दिए और हक़ीक़त से एक भी मुलाक़ात नहीं।',
  'Taiyari na karne ka sabse izzatdar roop ho sakti hai, kyunki usse kuch banta dikhta hai aur woh progress jaisi lagti hai. Shloka sochne ke khilaf nahi hai; woh is soch ke khilaf hai ki na karne ka daur ek neutral thehrav hai. Chaudah mahinon ne nau version diye aur haqiqat se ek bhi mulaqat nahi.',
  'Preparation that never meets reality is not preparation. It is a comfortable version of not starting.',
  'जो तैयारी हक़ीक़त से मिलती ही नहीं वह तैयारी नहीं है। वह शुरू न करने का आरामदेह रूप है।',
  'Jo taiyari haqiqat se milti hi nahi woh taiyari nahi hai. Woh shuru na karne ka aaramdeh roop hai.',
  NULL, 'intermediate', 'work,preparation,starting,business,avoidance'

  UNION ALL SELECT 16, 'everyday_life', 1,
  'The building with one committee', 'वह इमारत जिसमें एक ही समिति है', 'Woh building jisme ek hi committee hai',
  'A residential block of forty flats is run by four people who do the accounts, chase the water tanker, argue with the contractor and take the calls at odd hours. The other thirty-six households pay their dues and complain reasonably. When two of the four move away in the same year, it takes eleven months and a burst pipe for the rest to understand what those four had been absorbing.',
  'चालीस फ़्लैट की एक इमारत को चार लोग चलाते हैं जो हिसाब देखते हैं, पानी का टैंकर मँगवाते हैं, ठेकेदार से बहस करते हैं और बेवक़्त आने वाले फ़ोन उठाते हैं। बाक़ी छत्तीस घर अपना शुल्क देते हैं और वाजिब शिकायतें करते हैं। जब उन चार में से दो एक ही साल में चले जाते हैं, तो बाक़ियों को यह समझने में ग्यारह महीने और एक फटा हुआ पाइप लगता है कि वे चार क्या-क्या सोख रहे थे।',
  'Chalis flat ki ek building ko chaar log chalate hain jo hisaab dekhte hain, paani ka tanker mangwate hain, thekedar se behes karte hain aur bewaqt aane wale phone uthate hain. Baaki chhattis ghar apna shulk dete hain aur waajib shikayatein karte hain. Jab un chaar mein se do ek hi saal mein chale jaate hain, to baakiyon ko yeh samajhne mein gyarah mahine aur ek phata hua pipe lagta hai ki woh chaar kya-kya sokh rahe the.',
  'The verse calls somebody who takes from the wheel without turning it a thief, which is stronger language than most readers expect and is doing real work. Nobody in those thirty-six households did anything wrong. That is exactly the point: the arrangement fails without anybody breaking a rule.',
  'श्लोक उसे चोर कहता है जो चक्र से लेता है और उसे घुमाता नहीं — ज़्यादातर पाठकों की उम्मीद से सख़्त शब्द है और वह काम कर रहा है। उन छत्तीस घरों में किसी ने कुछ ग़लत नहीं किया। बात ठीक यही है: इंतज़ाम बिना किसी के नियम तोड़े ही बैठ जाता है।',
  'Shloka use chor kehta hai jo chakr se leta hai aur use ghumata nahi — zyadatar padhne walon ki ummeed se sakht shabd hai aur woh kaam kar raha hai. Un chhattis gharon mein kisi ne kuch galat nahi kiya. Baat theek yahi hai: intezaam bina kisi ke niyam tode hi baith jaata hai.',
  'Systems do not fail because somebody breaks them. They fail because everybody stops turning them.',
  'व्यवस्थाएँ इसलिए नहीं बैठतीं कि कोई तोड़ता है। वे इसलिए बैठती हैं कि सब घुमाना बंद कर देते हैं।',
  'Vyavasthayein isliye nahi baithti ki koi todta hai. Woh isliye baithti hain ki sab ghumana band kar dete hain.',
  NULL, 'beginner', 'community,contribution,free-riding,neighbours,systems'

  UNION ALL SELECT 16, 'technology', 2,
  'The library everybody depends on', 'वह लाइब्रेरी जिस पर सब टिके हैं', 'Woh library jis par sab tike hain',
  'A piece of free software sits underneath a very large amount of commercial work. It is maintained by two people in their evenings. Companies with substantial revenue file issues, request features and occasionally complain about response times. One maintainer writes a short, unangry note explaining that he is doing this after his children are asleep, and the note gets more attention than eight years of the work did.',
  'एक मुफ़्त सॉफ़्टवेयर बहुत सारे व्यावसायिक काम के नीचे बैठा है। उसे दो लोग अपनी शामों में संभालते हैं। अच्छी कमाई वाली कंपनियाँ समस्याएँ दर्ज करती हैं, नई सुविधाएँ माँगती हैं और कभी-कभी जवाब में देरी की शिकायत करती हैं। एक रखवाला एक छोटा-सा, बिना गुस्से वाला नोट लिखता है कि वह यह काम बच्चों के सो जाने के बाद करता है, और उस नोट पर आठ साल के काम से ज़्यादा ध्यान जाता है।',
  'Ek muft software bahut saare commercial kaam ke neeche baitha hai. Use do log apni shaamon mein sambhalte hain. Achhi kamai wali companies issues file karti hain, nayi features maangti hain aur kabhi-kabhi jawab mein deri ki shikayat karti hain. Ek maintainer ek chhota sa, bina gusse wala note likhta hai ki woh yeh kaam bachchon ke so jaane ke baad karta hai, aur us note par aath saal ke kaam se zyada dhyan jaata hai.',
  'This is the wheel in its clearest modern form. Everybody in the chain is behaving normally and nobody is stealing in the ordinary sense. The verse is still describing the situation accurately, which is a good argument for keeping its uncomfortable word rather than softening it.',
  'यह चक्र का सबसे साफ़ आधुनिक रूप है। कड़ी में सब सामान्य बरताव कर रहे हैं और आम मायने में कोई चोरी नहीं कर रहा। फिर भी श्लोक हालात ठीक-ठीक बता रहा है, जो उसके असहज शब्द को नरम करने के बजाय बनाए रखने की अच्छी दलील है।',
  'Yeh chakr ka sabse saaf aadhunik roop hai. Chain mein sab normal behave kar rahe hain aur aam maayne mein koi chori nahi kar raha. Phir bhi shloka haalat theek-theek bata raha hai, jo uske asahaj shabd ko naram karne ke bajaye banaye rakhne ki achhi dalil hai.',
  'Everybody behaving normally is how a wheel stops. That is why the verse uses a stronger word than "unfair".',
  'सबका सामान्य बरताव ही वह तरीक़ा है जिससे चक्र रुकता है। इसीलिए श्लोक "अन्याय" से सख़्त शब्द इस्तेमाल करता है।',
  'Sabka normal behave karna hi woh tareeka hai jisse chakr rukta hai. Isiliye shloka "anyay" se sakht shabd use karta hai.',
  NULL, 'intermediate', 'technology,open-source,contribution,labour,systems'

  UNION ALL SELECT 16, 'parenting', 3,
  'The house that ran itself', 'वह घर जो अपने आप चलता था', 'Woh ghar jo apne aap chalta tha',
  'A teenager is genuinely surprised, on the first week of living alone, by how many separate things a week contains: the bin has a day, the gas has a number, the fridge does not restock. They ring home not for help but slightly indignantly, as though somebody had been running a hidden process and never mentioned it. Somebody had.',
  'अकेले रहने के पहले हफ़्ते एक किशोर सचमुच हैरान होता है कि एक हफ़्ते में कितनी अलग-अलग चीज़ें होती हैं: कूड़े का एक दिन होता है, गैस का एक नंबर होता है, फ़्रिज ख़ुद नहीं भरता। वह घर फ़ोन करता है — मदद के लिए नहीं, बल्कि हल्की शिकायत के भाव से, जैसे कोई कोई छिपी प्रक्रिया चला रहा था और उसने कभी बताया नहीं। कोई चला ही रहा था।',
  'Akele rehne ke pehle hafte ek teenager sach mein hairan hota hai ki ek hafte mein kitni alag-alag cheezein hoti hain: kachre ka ek din hota hai, gas ka ek number hota hai, fridge khud nahi bharta. Woh ghar phone karta hai — madad ke liye nahi, balki halki shikayat ke bhaav se, jaise koi chhupi hui process chala raha tha aur usne kabhi bataya nahi. Koi chala hi raha tha.',
  'The verse is not asking anybody to feel guilty about having been a child. It is asking for the wheel to become visible, and the reliable way it becomes visible is when you have to turn it yourself. Most people learn this exactly once and it lands permanently.',
  'श्लोक किसी से यह नहीं कह रहा कि बच्चा रहने पर अपराधबोध महसूस करे। वह चाहता है कि चक्र दिखने लगे, और वह भरोसे से तब दिखता है जब उसे ख़ुद घुमाना पड़े। ज़्यादातर लोग यह ठीक एक बार सीखते हैं और वह हमेशा के लिए बैठ जाता है।',
  'Shloka kisi se yeh nahi keh raha ki bachcha rehne par guilt mehsoos kare. Woh chahta hai ki chakr dikhne lage, aur woh bharose se tab dikhta hai jab use khud ghumana pade. Zyadatar log yeh theek ek baar seekhte hain aur woh hamesha ke liye baith jaata hai.',
  'The wheel becomes visible the week you have to turn it yourself.',
  'चक्र उसी हफ़्ते दिखने लगता है जिस हफ़्ते आपको उसे ख़ुद घुमाना पड़ता है।',
  'Chakr usi hafte dikhne lagta hai jis hafte tumhe use khud ghumana padta hai.',
  NULL, 'beginner', 'family,growing-up,household,gratitude,labour'

  UNION ALL SELECT 19, 'school', 1,
  'The exam that was already written', 'वह परीक्षा जो लिखी जा चुकी थी', 'Woh exam jo likha ja chuka tha',
  'A student finishes a three-hour paper and spends the following six weeks in it — reconstructing question fourteen, asking classmates what they wrote, revising the estimate upwards and then downwards. The paper does not change during those six weeks. The student, by their own account afterwards, does.',
  'एक छात्र तीन घंटे का पर्चा ख़त्म करता है और अगले छह हफ़्ते उसी में बिताता है — चौदहवाँ सवाल दोबारा जोड़ता हुआ, सहपाठियों से पूछता हुआ कि उन्होंने क्या लिखा, अपना अनुमान कभी ऊपर कभी नीचे करता हुआ। उन छह हफ़्तों में पर्चा नहीं बदलता। छात्र, अपने ही बाद के कहे मुताबिक़, बदल जाता है।',
  'Ek student teen ghante ka paper khatam karta hai aur agle chhah hafte usi mein bitata hai — chaudahwa sawaal dobara jodta hua, classmates se poochta hua ki unhone kya likha, apna andaza kabhi upar kabhi neeche karta hua. Un chhah hafton mein paper nahi badalta. Student, apne hi baad ke kahe mutabik, badal jaata hai.',
  'Both halves of the instruction are visible here and only one of them was done. The work was completed properly; the result was carried for six weeks at real cost. The verse is not asking anybody to stop caring — it is pointing out that the caring is now being spent somewhere it cannot reach.',
  'हिदायत के दोनों आधे यहाँ दिख रहे हैं और उनमें से एक ही किया गया। काम ठीक से पूरा हुआ; नतीजा छह हफ़्ते तक असली क़ीमत पर ढोया गया। श्लोक किसी से परवाह छोड़ने को नहीं कह रहा — वह बता रहा है कि परवाह अब वहाँ ख़र्च हो रही है जहाँ वह पहुँच ही नहीं सकती।',
  'Hidayat ke dono aadhe yahan dikh rahe hain aur unme se ek hi kiya gaya. Kaam theek se poora hua; result chhah hafte tak asli keemat par dhoya gaya. Shloka kisi se parwah chhodne ko nahi keh raha — woh bata raha hai ki parwah ab wahan kharch ho rahi hai jahan woh pahunch hi nahi sakti.',
  'Caring about the result after it is out of your hands does not improve it. It only spends you.',
  'नतीजा हाथ से निकल जाने के बाद उसकी परवाह उसे बेहतर नहीं करती। वह सिर्फ़ आपको ख़र्च करती है।',
  'Result haath se nikal jaane ke baad uski parwah use behtar nahi karti. Woh sirf tumhe kharch karti hai.',
  NULL, 'beginner', 'exams,students,rumination,results,letting-go'

  UNION ALL SELECT 19, 'corporate', 2,
  'The proposal and the inbox', 'प्रस्ताव और इनबॉक्स', 'Proposal aur inbox',
  'A team submits a proposal on a Thursday. From Friday to the following Wednesday the lead checks email at a rate she would be embarrassed to have measured, and does check it, and it is measured, and the number is 61 times on the Monday alone. The proposal is accepted. She reports afterwards that she cannot remember Monday.',
  'एक टीम गुरुवार को प्रस्ताव भेजती है। शुक्रवार से अगले बुधवार तक टीम-प्रमुख ईमेल इतनी बार देखती है कि गिनती सामने आ जाए तो शर्म आए, और गिनती सामने आती है, और सोमवार को अकेले वह 61 है। प्रस्ताव मंज़ूर हो जाता है। वह बाद में बताती है कि उसे सोमवार याद ही नहीं।',
  'Ek team Thursday ko proposal bhejti hai. Friday se agle Wednesday tak team lead email itni baar dekhti hai ki ginti saamne aa jaaye to sharm aaye, aur ginti saamne aati hai, aur Monday ko akele woh 61 hai. Proposal manzoor ho jaata hai. Woh baad mein batati hai ki use Monday yaad hi nahi.',
  'The result was good and the five days were still lost, which is the cleanest demonstration of why this instruction is not about outcomes. Winning did not refund Monday. A version of her who had put the result down on Thursday evening would have had the same proposal accepted and five more days of her life.',
  'नतीजा अच्छा रहा और पाँच दिन फिर भी गए, जो इस बात का सबसे साफ़ सबूत है कि यह हिदायत नतीजों के बारे में नहीं है। जीत ने सोमवार लौटाया नहीं। उसका वह रूप जिसने गुरुवार शाम को नतीजा रख दिया होता, उसी प्रस्ताव की मंज़ूरी पाता और अपनी ज़िंदगी के पाँच दिन और।',
  'Result achha raha aur paanch din phir bhi gaye, jo is baat ka sabse saaf saboot hai ki yeh hidayat outcomes ke baare mein nahi hai. Jeet ne Monday lautaya nahi. Uska woh version jisne Thursday shaam ko result rakh diya hota, usi proposal ki manzoori paata aur apni zindagi ke paanch din aur.',
  'Winning does not refund the days you spent waiting to win.',
  'जीत उन दिनों को नहीं लौटाती जो आपने जीतने के इंतज़ार में ख़र्च किए।',
  'Jeet un dinon ko nahi lautati jo tumne jeetne ke intezaar mein kharch kiye.',
  NULL, 'intermediate', 'work,waiting,anxiety,results,time'

  UNION ALL SELECT 19, 'ethics', 3,
  'The report that was filed anyway', 'वह रिपोर्ट जो फिर भी दाख़िल हुई', 'Woh report jo phir bhi file hui',
  'An auditor finds something that will not be popular. She has watched two previous findings of the same kind get absorbed into a process and quietly disappear, and she has a fair estimate of what will happen to this one. She writes it accurately and files it. Asked why, given the odds, she says the odds were never the part she was responsible for.',
  'एक ऑडिटर को कुछ ऐसा मिलता है जो पसंद नहीं किया जाएगा। वह इसी तरह के दो पहले के निष्कर्षों को किसी प्रक्रिया में समा कर चुपचाप ग़ायब होते देख चुकी है, और उसे ठीक-ठीक अंदाज़ा है कि इसका क्या होगा। वह उसे सही-सही लिखती है और दाख़िल कर देती है। पूछे जाने पर कि जब आसार यही थे तो क्यों, वह कहती है कि आसार कभी उसकी ज़िम्मेदारी वाला हिस्सा थे ही नहीं।',
  'Ek auditor ko kuch aisa milta hai jo pasand nahi kiya jayega. Woh isi tarah ke do pehle ke findings ko kisi process mein sama kar chupchap gayab hote dekh chuki hai, aur use theek-theek andaza hai ki iska kya hoga. Woh use sahi-sahi likhti hai aur file kar deti hai. Poochhe jaane par ki jab aasar yahi the to kyun, woh kehti hai ki aasar kabhi uski zimmedari wala hissa the hi nahi.',
  'This is the instruction working at its full strength, and it is worth noticing that it produces action rather than resignation. If the result had been her remit she would have had a reason to stop. Because it was not, the only question left was whether the report was accurate.',
  'यह हिदायत अपनी पूरी ताक़त में काम करती दिख रही है, और ध्यान देने लायक है कि इससे कर्म निकलता है, हार नहीं। अगर नतीजा उसका दायरा होता तो उसके पास रुकने की वजह होती। चूँकि वह था नहीं, बचा हुआ इकलौता सवाल यही था कि रिपोर्ट सही है या नहीं।',
  'Yeh hidayat apni poori taakat mein kaam karti dikh rahi hai, aur dhyan dene layak hai ki isse karm nikalta hai, haar nahi. Agar result uska daayra hota to uske paas rukne ki wajah hoti. Chunki woh tha nahi, bacha hua iklauta sawaal yahi tha ki report sahi hai ya nahi.',
  'Letting go of the result is not resignation. It removes the main reason people give for not acting.',
  'नतीजा छोड़ देना हार मान लेना नहीं है। यह वह मुख्य वजह हटा देता है जो लोग काम न करने के लिए देते हैं।',
  'Result chhod dena haar maan lena nahi hai. Yeh woh mukhya wajah hata deta hai jo log kaam na karne ke liye dete hain.',
  NULL, 'advanced', 'integrity,work,courage,results,duty'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 3;

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

  SELECT 21 AS vn, 'parenting' AS cat, 1 AS ord,
  'The phone at the dinner table' AS t_en, 'खाने की मेज़ पर फ़ोन' AS t_hi, 'Khaane ki mez par phone' AS t_hing,
  'A house has a rule about phones at meals and the rule is enforced consistently on the children. A parent takes one work call at the table, then another, then treats the exception as understood. Within about five months the rule has quietly stopped existing, and the conversation in which it stopped never took place.' AS s_en,
  'घर में खाने के वक़्त फ़ोन का एक नियम है और वह बच्चों पर लगातार लागू होता है। एक अभिभावक मेज़ पर काम का एक फ़ोन लेता है, फिर दूसरा, फिर उस छूट को समझी हुई बात मान लेता है। क़रीब पाँच महीनों में नियम चुपचाप ख़त्म हो जाता है, और जिस बातचीत में वह ख़त्म हुआ वह कभी हुई ही नहीं।' AS s_hi,
  'Ghar mein khaane ke waqt phone ka ek niyam hai aur woh bachchon par lagatar lagu hota hai. Ek parent mez par kaam ka ek phone leta hai, phir doosra, phir us chhoot ko samjhi hui baat maan leta hai. Karib paanch mahinon mein niyam chupchap khatam ho jaata hai, aur jis baat mein woh khatam hua woh kabhi hui hi nahi.' AS s_hing,
  'The verse says people follow what the person in front does, not what they set as a standard. Nothing was announced here and the standard still moved, because the demonstration is what carries. The children did not disobey the rule; they learned the actual rule, which was different.' AS c_en,
  'श्लोक कहता है कि लोग वही करते हैं जो आगे वाला करता है, वह नहीं जो वह मानक बताता है। यहाँ कुछ घोषित नहीं हुआ और मानक फिर भी खिसक गया, क्योंकि असर उदाहरण का होता है। बच्चों ने नियम तोड़ा नहीं; उन्होंने असली नियम सीखा, जो अलग था।' AS c_hi,
  'Shloka kehta hai ki log wahi karte hain jo aage wala karta hai, woh nahi jo woh standard batata hai. Yahan kuch ghoshit nahi hua aur standard phir bhi khisak gaya, kyunki asar example ka hota hai. Bachchon ne niyam toda nahi; unhone asli niyam seekha, jo alag tha.' AS c_hing,
  'Children do not learn the rule you stated. They learn the rule you demonstrated.' AS l_en,
  'बच्चे वह नियम नहीं सीखते जो आपने बताया। वे वह सीखते हैं जो आपने कर के दिखाया।' AS l_hi,
  'Bachche woh niyam nahi seekhte jo tumne bataya. Woh wahi seekhte hain jo tumne kar ke dikhaya.' AS l_hing,
  NULL AS src, 'beginner' AS diff, 'parenting,example,rules,family,consistency' AS tags

  UNION ALL SELECT 21, 'leadership', 2,
  'The manager who replied at midnight', 'वह मैनेजर जो आधी रात जवाब देता था', 'Woh manager jo aadhi raat jawab deta tha',
  'A manager tells her team, repeatedly and sincerely, not to work late and to protect their evenings. She also answers messages at half past midnight because that is when she gets to her own inbox. Nobody is told to match this. Within two quarters three people on the team are visibly matching it, and one of them says in a review that she did not want to be the one who was offline.',
  'एक मैनेजर अपनी टीम से बार-बार और सच्चे मन से कहती है कि देर तक काम न करें और अपनी शामें बचाएँ। वह ख़ुद साढ़े बारह बजे संदेशों का जवाब देती है क्योंकि उसे अपना इनबॉक्स तभी मिलता है। किसी से नहीं कहा जाता कि ऐसा ही करें। दो तिमाहियों में टीम के तीन लोग साफ़ तौर पर वैसा ही कर रहे हैं, और उनमें से एक समीक्षा में कहती है कि वह अकेली नहीं दिखना चाहती थी जो ऑफ़लाइन है।',
  'Ek manager apni team se baar-baar aur sachche man se kehti hai ki der tak kaam na karein aur apni shaamein bachayein. Woh khud saade barah baje messages ka jawab deti hai kyunki use apna inbox tabhi milta hai. Kisi se nahi kaha jaata ki aisa hi karein. Do quarter mein team ke teen log saaf taur par waisa hi kar rahe hain, aur unme se ek review mein kehti hai ki woh akeli nahi dikhna chahti thi jo offline hai.',
  'Both things she did were real: the instruction was honest and the example was accidental. The verse claims the example wins, and it explains the mechanism — people take what the person in front does as the measure. Fixing this does not require a new policy. It requires the midnight replies to be scheduled for nine.',
  'उसके दोनों काम असली थे: हिदायत ईमानदार थी और उदाहरण अनजाने में बना। श्लोक कहता है कि उदाहरण जीतता है, और वजह भी बताता है — लोग आगे वाले के काम को ही पैमाना मान लेते हैं। इसे ठीक करने के लिए नई नीति नहीं चाहिए। चाहिए यह कि आधी रात के जवाब नौ बजे के लिए तय कर दिए जाएँ।',
  'Uske dono kaam asli the: hidayat imaandar thi aur example anjaane mein bana. Shloka kehta hai ki example jeetta hai, aur wajah bhi batata hai — log aage wale ke kaam ko hi paimana maan lete hain. Ise theek karne ke liye nayi policy nahi chahiye. Chahiye yeh ki aadhi raat ke jawab nau baje ke liye tay kar diye jaayein.',
  'Your instruction and your example are not equal witnesses. People believe the example.',
  'आपकी हिदायत और आपका उदाहरण बराबर गवाह नहीं हैं। लोग उदाहरण को मानते हैं।',
  'Tumhari hidayat aur tumhara example barabar gawah nahi hain. Log example ko maante hain.',
  NULL, 'intermediate', 'leadership,work,example,culture,boundaries'

  UNION ALL SELECT 21, 'sports', 3,
  'The senior who ran the warm-up',   'वह वरिष्ठ जो वॉर्म-अप करता था', 'Woh senior jo warm-up karta tha',
  'A club side has a captain who arrives twenty minutes early, does the unglamorous parts of the warm-up properly, and picks up the cones at the end without saying anything about it. Nobody makes a speech. Over two seasons the arrival time of the whole squad moves earlier by about a quarter of an hour, and a new player assumes this is simply how the club is.',
  'एक क्लब टीम का कप्तान बीस मिनट पहले आता है, वॉर्म-अप के बेरौनक़ हिस्से ठीक से करता है, और आख़िर में कोन उठाकर रख देता है, इस पर कुछ कहे बिना। कोई भाषण नहीं होता। दो सत्रों में पूरी टीम के आने का समय क़रीब पंद्रह मिनट पहले खिसक जाता है, और एक नया खिलाड़ी मान लेता है कि यह क्लब है ही ऐसा।',
  'Ek club team ka captain bees minute pehle aata hai, warm-up ke berounak hisse theek se karta hai, aur aakhir mein cone utha kar rakh deta hai, is par kuch kahe bina. Koi bhashan nahi hota. Do season mein poori team ke aane ka time karib pandrah minute pehle khisak jaata hai, aur ek naya player maan leta hai ki yeh club hai hi aisa.',
  'The verse works in this direction too, which is easy to forget when it is quoted as a warning. Nothing here was taught. A standard was set by somebody doing an unglamorous thing consistently, and then it was simply the water everybody swam in.',
  'श्लोक इस दिशा में भी काम करता है, जो तब भूल जाता है जब इसे चेतावनी की तरह उद्धृत किया जाता है। यहाँ कुछ सिखाया नहीं गया। एक मानक इसलिए बना कि कोई बेरौनक़ काम लगातार करता रहा, और फिर वही वह पानी बन गया जिसमें सब तैरते थे।',
  'Shloka is disha mein bhi kaam karta hai, jo tab bhool jaata hai jab ise chetavni ki tarah quote kiya jaata hai. Yahan kuch sikhaya nahi gaya. Ek standard isliye bana ki koi berounak kaam lagatar karta raha, aur phir wahi woh paani ban gaya jisme sab tairte the.',
  'The same mechanism that spreads a bad standard spreads a good one. It only asks for consistency.',
  'जो तंत्र ख़राब मानक फैलाता है वही अच्छा भी फैलाता है। वह सिर्फ़ निरंतरता माँगता है।',
  'Jo mechanism kharab standard failata hai wahi achha bhi failata hai. Woh sirf consistency maangta hai.',
  NULL, 'beginner', 'sport,leadership,example,culture,consistency'

  UNION ALL SELECT 27, 'corporate', 1,
  'The quarter that everybody had a theory about', 'वह तिमाही जिसके बारे में सबका एक सिद्धांत था', 'Woh quarter jiske baare mein sabka ek theory tha',
  'A product has an unexpectedly strong quarter. In the review, four people give four accounts of why, each of which happens to centre on their own contribution and each of which is plausible. A competitor''s outage that ran for nine days in the same window appears in none of the four.',
  'एक उत्पाद की तिमाही अप्रत्याशित रूप से अच्छी रहती है। समीक्षा में चार लोग चार वजहें बताते हैं, हर एक संयोग से अपने ही योगदान पर टिकी और हर एक भरोसेमंद लगती हुई। उसी दौरान नौ दिन चली एक प्रतिस्पर्धी की सेवा-रुकावट चारों में से किसी में नहीं आती।',
  'Ek product ka quarter unexpected roop se achha rehta hai. Review mein chaar log chaar wajahein batate hain, har ek sanyog se apne hi contribution par tiki aur har ek bharosemand lagti hui. Usi dauran nau din chali ek competitor ki outage chaaron mein se kisi mein nahi aati.',
  'The verse describes exactly this: the machinery runs and a sense of authorship attaches afterwards. Nobody in the room was lying. Each account was a real cause among many, promoted to the cause because that is what the ego does with a good outcome and it does it fast.',
  'श्लोक ठीक यही बताता है: मशीन चलती है और कर्तापन का भाव बाद में जुड़ जाता है। कमरे में कोई झूठ नहीं बोल रहा था। हर बयान कई कारणों में से एक असली कारण था, जिसे कारण बना दिया गया — क्योंकि अच्छे नतीजे के साथ अहंकार यही करता है, और तेज़ी से करता है।',
  'Shloka theek yahi batata hai: machine chalti hai aur kartapan ka bhaav baad mein jud jaata hai. Kamre mein koi jhooth nahi bol raha tha. Har bayan kai kaaranon mein se ek asli kaaran tha, jise kaaran bana diya gaya — kyunki achhe result ke saath ahankaar yahi karta hai, aur tezi se karta hai.',
  'The ego does not invent causes. It promotes one real cause to the only cause.',
  'अहंकार कारण गढ़ता नहीं। वह एक असली कारण को इकलौता कारण बना देता है।',
  'Ahankaar kaaran gadhta nahi. Woh ek asli kaaran ko iklauta kaaran bana deta hai.',
  NULL, 'intermediate', 'work,credit,attribution,ego,luck'

  UNION ALL SELECT 27, 'healthcare', 2,
  'The recovery that was mostly not the doctor', 'वह स्वास्थ्य-लाभ जो ज़्यादातर डॉक्टर का नहीं था', 'Woh recovery jo zyadatar doctor ki nahi thi',
  'A patient recovers well from a serious illness. The consultant is thanked warmly and deserves some of it. Also involved: a nurse who noticed something on a night shift, a drug developed by people nobody in the room could name, a body that responded, and an appointment that happened to fall three weeks earlier than it might have. The consultant, who is honest, mentions two of these and is not fully believed.',
  'एक मरीज़ गंभीर बीमारी से अच्छी तरह उबरता है। सलाहकार डॉक्टर का गर्मजोशी से शुक्रिया होता है और उसका हक़ भी बनता है। इसमें और भी शामिल थे: एक नर्स जिसने रात की पाली में कुछ देखा, एक दवा जिसे बनाने वालों का नाम कमरे में कोई नहीं जानता, एक शरीर जिसने जवाब दिया, और एक अपॉइंटमेंट जो संयोग से तीन हफ़्ते पहले पड़ गया। डॉक्टर, जो ईमानदार है, इनमें से दो का ज़िक्र करता है और उस पर पूरा यक़ीन नहीं किया जाता।',
  'Ek mareez gambhir bimari se achhi tarah ubarta hai. Consultant doctor ka garmjoshi se shukriya hota hai aur uska haq bhi banta hai. Isme aur bhi shamil the: ek nurse jisne raat ki shift mein kuch dekha, ek dawa jise banane walon ka naam kamre mein koi nahi jaanta, ek sharir jisne jawab diya, aur ek appointment jo sanyog se teen hafte pehle pad gaya. Doctor, jo imaandar hai, inme se do ka zikr karta hai aur us par poora yakeen nahi kiya jaata.',
  'The verse is not asking anybody to withhold thanks. It is describing where the sense of a single author comes from, and a hospital is a good place to see it because the number of contributing causes is unusually countable. Try the same exercise on a bad outcome and it gets much harder, which is the more useful half.',
  'श्लोक किसी से शुक्रिया रोकने को नहीं कह रहा। वह बता रहा है कि एक ही कर्ता का भाव आता कहाँ से है, और अस्पताल इसे देखने की अच्छी जगह है क्योंकि वहाँ जुड़े कारण असामान्य रूप से गिने जा सकते हैं। यही अभ्यास किसी बुरे नतीजे पर कीजिए और वह कहीं मुश्किल हो जाता है — और वही ज़्यादा काम का आधा है।',
  'Shloka kisi se shukriya rokne ko nahi keh raha. Woh bata raha hai ki ek hi karta ka bhaav aata kahan se hai, aur hospital ise dekhne ki achhi jagah hai kyunki wahan jude kaaran asamanya roop se gine ja sakte hain. Yahi abhyas kisi bure result par karo aur woh kahin mushkil ho jaata hai — aur wahi zyada kaam ka aadha hai.',
  'Counting the causes of a good outcome is easy and pleasant. Do it for a bad one and something loosens.',
  'अच्छे नतीजे के कारण गिनना आसान और सुखद है। बुरे नतीजे के लिए गिनिए, तो कुछ ढीला पड़ता है।',
  'Achhe result ke kaaran ginna asaan aur sukhad hai. Bure result ke liye gino, to kuch dheela padta hai.',
  NULL, 'intermediate', 'health,credit,causes,gratitude,ego'

  UNION ALL SELECT 27, 'everyday_life', 3,
  'Ten years of not forgiving yourself', 'ख़ुद को माफ़ न कर पाने के दस साल', 'Khud ko maaf na kar paane ke das saal',
  'Somebody has been carrying a decision made at twenty-three that they still describe as the worst thing they have done. Talked through slowly, the decision turns out to have involved information they did not have, pressure from two directions, a person who has since apologised for their part, and about four hours of sleep. None of this had ever been laid out beside each other before.',
  'कोई तेईस की उम्र में लिया एक फ़ैसला ढो रहा है जिसे वह आज भी अपनी सबसे बुरी करनी बताता है। धीरे-धीरे बात करने पर पता चलता है कि उस फ़ैसले में वह जानकारी शामिल थी जो उसके पास थी ही नहीं, दो तरफ़ से दबाव था, एक व्यक्ति था जो अपने हिस्से के लिए बाद में माफ़ी माँग चुका है, और लगभग चार घंटे की नींद थी। यह सब कभी एक साथ रखकर देखा ही नहीं गया था।',
  'Koi teis ki umar mein liya ek faisla dho raha hai jise woh aaj bhi apni sabse buri karni batata hai. Dheere-dheere baat karne par pata chalta hai ki us faisle mein woh jaankari shamil thi jo uske paas thi hi nahi, do taraf se dabav tha, ek insaan tha jo apne hisse ke liye baad mein maafi maang chuka hai, aur lagbhag chaar ghante ki neend thi. Yeh sab kabhi ek saath rakh kar dekha hi nahi gaya tha.',
  'This is the reading the explanation calls the useful one, and it is worth being precise about what it does and does not do. It does not cancel responsibility; the person still acted. It declines the specific claim of sole authorship that ten years of self-punishment was built on.',
  'व्याख्या इसी पाठ को काम का बताती है, और साफ़ कहना ज़रूरी है कि यह क्या करता है और क्या नहीं। यह ज़िम्मेदारी रद्द नहीं करता; उस व्यक्ति ने काम किया ही। यह इकलौते कर्ता होने का वह ख़ास दावा अस्वीकार करता है जिस पर दस साल की आत्म-सज़ा टिकी थी।',
  'Vyakhya isi padhne ko kaam ka batati hai, aur saaf kehna zaroori hai ki yeh kya karta hai aur kya nahi. Yeh zimmedari radd nahi karta; us insaan ne kaam kiya hi. Yeh iklaute karta hone ka woh khaas dawa thukra deta hai jis par das saal ki khud ko di gayi saza tiki thi.',
  'Responsibility survives this reading. Sole authorship does not, and that is usually the part doing the damage.',
  'इस पाठ में ज़िम्मेदारी बची रहती है। इकलौता कर्ता होना नहीं बचता, और नुक़सान अक्सर वही हिस्सा करता है।',
  'Is padhne mein zimmedari bachi rehti hai. Iklauta karta hona nahi bachta, aur nuksaan aksar wahi hissa karta hai.',
  NULL, 'advanced', 'guilt,self-blame,forgiveness,causes,past'

  UNION ALL SELECT 35, 'college', 1,
  'The degree that belonged to somebody else', 'वह डिग्री जो किसी और की थी', 'Woh degree jo kisi aur ki thi',
  'A student is two years into a course chosen because it was the sensible one and because somebody they admire did it. They are competent at it — marks are fine — and they can describe, with unusual precision, the specific dullness of a Tuesday. Changing course would cost a year and an argument at home. Staying costs something they have not put a number on.',
  'एक छात्र दो साल से उस पाठ्यक्रम में है जो इसलिए चुना गया कि वह समझदारी वाला था और इसलिए कि जिसे वह मानता है उसने वही किया था। वह इसमें सक्षम है — अंक ठीक हैं — और वह असामान्य सटीकता से मंगलवार की उस ख़ास ऊब का वर्णन कर सकता है। पाठ्यक्रम बदलने में एक साल और घर में एक बहस लगेगी। बने रहने की क़ीमत ऐसी है जिस पर उसने कोई अंक नहीं लगाया।',
  'Ek student do saal se us course mein hai jo isliye chuna gaya ki woh samajhdari wala tha aur isliye ki jise woh maanta hai usne wahi kiya tha. Woh isme saksham hai — marks theek hain — aur woh asamanya sateekta se Tuesday ki us khaas oob ka varnan kar sakta hai. Course badalne mein ek saal aur ghar mein ek behes lagegi. Bane rehne ki keemat aisi hai jis par usne koi ank nahi lagaya.',
  'The verse is about imitation, not about birth. Nothing here is settled by where this student came from; the whole difficulty is that they took up somebody else''s life because it looked competent and theirs did not have a description yet. Doing it well is not evidence that it is yours.',
  'श्लोक नक़ल के बारे में है, जन्म के बारे में नहीं। यहाँ कुछ भी इस बात से तय नहीं होता कि यह छात्र कहाँ से आया; पूरी मुश्किल यह है कि उसने किसी और का जीवन उठा लिया क्योंकि वह कुशल दिखता था और अपने का अब तक कोई ब्योरा नहीं था। अच्छा कर लेना इस बात का सबूत नहीं कि वह आपका है।',
  'Shloka nakal ke baare mein hai, janm ke baare mein nahi. Yahan kuch bhi is baat se tay nahi hota ki yeh student kahan se aaya; poori mushkil yeh hai ki usne kisi aur ka jeevan utha liya kyunki woh kushal dikhta tha aur apne ka ab tak koi byora nahi tha. Achha kar lena is baat ka saboot nahi ki woh tumhara hai.',
  'Being good at something is not evidence that it is yours.',
  'किसी काम में अच्छा होना इस बात का सबूत नहीं कि वह आपका है।',
  'Kisi kaam mein achha hona is baat ka saboot nahi ki woh tumhara hai.',
  NULL, 'beginner', 'study,choice,imitation,family,work'

  UNION ALL SELECT 35, 'corporate', 2,
  'The promotion into the wrong job', 'ग़लत काम में मिली तरक़्क़ी', 'Galat kaam mein mili tarakki',
  'An engineer who is very good at building things is promoted to manage people, because that is the shape the ladder has. Eighteen months later she is adequate at it, tired in a specific way, and no longer building anything. Asking to move back is available and reads, to her, as failure. Two people who did move back tell her it read that way to them for about a month.',
  'एक इंजीनियर जो चीज़ें बनाने में बहुत अच्छी है, लोगों को संभालने के पद पर पहुँचा दी जाती है, क्योंकि सीढ़ी का आकार वही है। अठारह महीने बाद वह इसमें ठीक-ठाक है, एक ख़ास तरह से थकी हुई, और अब कुछ बना नहीं रही। वापस जाने का रास्ता खुला है और उसे नाकामी जैसा लगता है। जो दो लोग वापस गए थे, वे बताते हैं कि उन्हें भी क़रीब एक महीने तक वैसा ही लगा था।',
  'Ek engineer jo cheezein banane mein bahut achhi hai, logon ko sambhalne ke pad par pahuncha di jaati hai, kyunki seedhi ka aakar wahi hai. Atharah mahine baad woh isme theek-thaak hai, ek khaas tarah se thaki hui, aur ab kuch bana nahi rahi. Wapas jaane ka rasta khula hai aur use nakami jaisa lagta hai. Jo do log wapas gaye the, woh batate hain ki unhe bhi karib ek mahine tak waisa hi laga tha.',
  'Svadharma is discovered rather than assigned, and this is what that looks like at thirty-four: the work that is genuinely hers was identifiable and she moved away from it for a reason that made sense at the time. The verse says the imitation, performed competently, is the worse of the two options. It does not say the move was stupid.',
  'स्वधर्म सौंपा नहीं जाता, खोजा जाता है, और चौंतीस की उम्र में वह ऐसा दिखता है: जो काम सचमुच उसका था वह पहचाना जा सकता था और वह उससे उस वजह से हटी जो उस वक़्त सही लगती थी। श्लोक कहता है कि नक़ल, कुशलता से निभाई गई भी, दोनों में बुरा विकल्प है। वह यह नहीं कहता कि वह क़दम बेवक़ूफ़ी था।',
  'Svadharma saunpa nahi jaata, khoja jaata hai, aur chauntis ki umar mein woh aisa dikhta hai: jo kaam sach mein uska tha woh pehchana ja sakta tha aur woh usse us wajah se hati jo us waqt sahi lagti thi. Shloka kehta hai ki nakal, kushalta se nibhayi gayi bhi, dono mein bura option hai. Woh yeh nahi kehta ki woh kadam bewakoofi tha.',
  'Svadharma is discovered, not assigned, and it changes across a life. Going back to it is not a demotion.',
  'स्वधर्म सौंपा नहीं जाता, खोजा जाता है, और वह जीवन भर बदलता है। उस पर लौटना पदावनति नहीं है।',
  'Svadharma saunpa nahi jaata, khoja jaata hai, aur woh zindagi bhar badalta hai. Us par lautna demotion nahi hai.',
  NULL, 'intermediate', 'work,career,imitation,identity,choice'

  UNION ALL SELECT 35, 'ethics', 3,
  'The verse quoted at somebody', 'वह श्लोक जो किसी पर चलाया गया', 'Woh shloka jo kisi par chalaya gaya',
  'A young person wanting to leave the work their family does is told this verse, in a tone that settles the matter. They go and read the chapter around it. What they find is eighteen verses arguing against withdrawal and imitation and none tying anybody''s work to their birth. The conversation afterwards is harder than the first one and considerably more honest.',
  'एक नौजवान अपने परिवार का काम छोड़ना चाहता है और उसे यह श्लोक सुनाया जाता है, ऐसे लहजे में जो बात ख़त्म कर दे। वह जाकर उसके आस-पास का अध्याय पढ़ता है। उसे वहाँ अठारह श्लोक मिलते हैं जो पीछे हटने और नक़ल के ख़िलाफ़ दलील देते हैं, और एक भी नहीं जो किसी के काम को उसके जन्म से बाँधता हो। इसके बाद वाली बातचीत पहली से ज़्यादा मुश्किल होती है और काफ़ी ज़्यादा ईमानदार।',
  'Ek naujawan apne parivar ka kaam chhodna chahta hai aur use yeh shloka sunaya jaata hai, aise lehje mein jo baat khatam kar de. Woh jaakar uske aas-paas ka chapter padhta hai. Use wahan atharah shloka milte hain jo peechhe hatne aur nakal ke khilaf dalil dete hain, aur ek bhi nahi jo kisi ke kaam ko uske janm se baandhta ho. Iske baad wali baat pehli se zyada mushkil hoti hai aur kaafi zyada imaandar.',
  'This is the misuse the explanation names, shown rather than described. The defence against a verse being used as a lid is the same as it has always been: read what is actually on the page and read what is around it. Neither the word svadharma nor anything else in this chapter attaches a person''s work to their birth.',
  'यह वही दुरुपयोग है जिसे व्याख्या नाम देती है — यहाँ बताया नहीं, दिखाया गया है। किसी श्लोक को ढक्कन की तरह इस्तेमाल होने से बचाव वही है जो हमेशा से रहा है: जो पन्ने पर सचमुच लिखा है वह पढ़िए और उसके आस-पास का भी पढ़िए। न स्वधर्म शब्द, न इस अध्याय की कोई और बात, किसी के काम को उसके जन्म से जोड़ती है।',
  'Yeh wahi durupyog hai jise vyakhya naam deti hai — yahan bataya nahi, dikhaya gaya hai. Kisi shloka ko dhakkan ki tarah use hone se bachav wahi hai jo hamesha se raha hai: jo panne par sach mein likha hai woh padho aur uske aas-paas ka bhi padho. Na svadharma shabd, na is chapter ki koi aur baat, kisi ke kaam ko uske janm se jodti hai.',
  'When a verse is used to close a conversation, read the twenty around it. That is usually enough.',
  'जब कोई श्लोक बातचीत बंद करने के लिए इस्तेमाल हो, तो उसके आस-पास के बीस पढ़ लीजिए। आमतौर पर इतना काफ़ी है।',
  'Jab koi shloka baat band karne ke liye use ho, to uske aas-paas ke bees padh lo. Aam taur par itna kaafi hai.',
  NULL, 'advanced', 'misuse,reading,family,work,honesty'

  UNION ALL SELECT 37, 'social_media', 1,
  'The feed that was never going to be finished', 'वह फ़ीड जो कभी ख़त्म होने वाली नहीं थी', 'Woh feed jo kabhi khatam hone wali nahi thi',
  'Somebody opens an app to check one thing and closes it forty minutes later without having checked it. The forty minutes were not enjoyable in any way they can describe afterwards. Asked what they were looking for, they say, accurately, that there was not a thing they were looking for — there was a feeling that the next one might be it.',
  'कोई एक चीज़ देखने के लिए ऐप खोलता है और चालीस मिनट बाद बिना वह चीज़ देखे बंद करता है। वे चालीस मिनट किसी भी ऐसे तरीक़े से सुखद नहीं थे जिसे वह बाद में बता सके। पूछने पर कि वह क्या ढूँढ़ रहा था, वह ठीक-ठीक कहता है कि ढूँढ़ने को कुछ था ही नहीं — बस यह भाव था कि अगली वाली शायद वही हो।',
  'Koi ek cheez dekhne ke liye app kholta hai aur chalis minute baad bina woh cheez dekhe band karta hai. Woh chalis minute kisi bhi aise tareeke se sukhad nahi the jise woh baad mein bata sake. Poochne par ki woh kya dhoondh raha tha, woh theek-theek kehta hai ki dhoondhne ko kuch tha hi nahi — bas yeh bhaav tha ki agli wali shayad wahi ho.',
  'Mahashana — great-eating, never filling up — is doing precise work here. The verse is not calling the app wicked and it is not calling the person weak. It is describing an appetite whose satisfaction is the mechanism by which it continues, which is why willpower is a poor tool against it.',
  'महाशन — बहुत खाने वाला, कभी न भरने वाला — यहाँ ठीक-ठीक काम कर रहा है। श्लोक ऐप को बुरा नहीं कह रहा और उस व्यक्ति को कमज़ोर नहीं कह रहा। वह एक ऐसी भूख बता रहा है जिसका तृप्त होना ही उसके चलते रहने का तरीक़ा है — इसीलिए इच्छाशक्ति इसके ख़िलाफ़ कमज़ोर औज़ार है।',
  'Mahashana — bahut khaane wala, kabhi na bharne wala — yahan theek-theek kaam kar raha hai. Shloka app ko bura nahi keh raha aur us insaan ko kamzor nahi keh raha. Woh ek aisi bhookh bata raha hai jiska poora hona hi uske chalte rehne ka tareeka hai — isiliye willpower iske khilaf kamzor auzaar hai.',
  'An appetite that grows by being fed is not fought with willpower. It is fought by not opening the door.',
  'जो भूख खाने से बढ़ती है, उससे इच्छाशक्ति से नहीं लड़ा जाता। उससे दरवाज़ा न खोलकर लड़ा जाता है।',
  'Jo bhookh khaane se badhti hai, usse willpower se nahi lada jaata. Usse darwaza na khol kar lada jaata hai.',
  NULL, 'beginner', 'attention,habits,technology,desire,scrolling'

  UNION ALL SELECT 37, 'finance', 2,
  'The number that kept moving', 'वह आँकड़ा जो खिसकता रहा', 'Woh number jo khiskta raha',
  'A person decides that a specific savings figure will mean they can stop worrying. They reach it in four years. Within about six weeks the figure has quietly moved, and the new one has a justification that is entirely reasonable. This has now happened three times and they can describe the pattern clearly while it continues to operate.',
  'एक व्यक्ति तय करता है कि बचत का एक ख़ास आँकड़ा मिलते ही चिंता ख़त्म हो जाएगी। वह उसे चार साल में पा लेता है। लगभग छह हफ़्तों में आँकड़ा चुपचाप खिसक जाता है, और नए के पीछे एक पूरी तरह वाजिब वजह है। यह अब तक तीन बार हो चुका है और वह इस ढर्रे को साफ़ बता सकता है, जबकि वह चलता रहता है।',
  'Ek insaan tay karta hai ki bachat ka ek khaas number milte hi chinta khatam ho jayegi. Woh use chaar saal mein paa leta hai. Lagbhag chhah hafton mein number chupchap khisak jaata hai, aur naye ke peechhe ek poori tarah waajib wajah hai. Yeh ab tak teen baar ho chuka hai aur woh is dharre ko saaf bata sakta hai, jabki woh chalta rehta hai.',
  'Being able to see the mechanism does not switch it off, which is the honest and slightly deflating finding here. What the verse offers is not a cure but a relocation: the person is not failing at contentment, they are dealing with something that behaves the same way in everybody and has done for a long time.',
  'तंत्र को देख पाना उसे बंद नहीं कर देता, और यही ईमानदार और थोड़ी निराश करने वाली बात है। श्लोक इलाज नहीं देता, जगह बदल देता है: वह व्यक्ति संतोष में नाकाम नहीं हो रहा, वह एक ऐसी चीज़ से निपट रहा है जो सबमें एक जैसी बरतती है और बहुत लंबे समय से बरतती आई है।',
  'Mechanism ko dekh paana use band nahi kar deta, aur yahi imaandar aur thodi nirash karne wali baat hai. Shloka ilaaj nahi deta, jagah badal deta hai: woh insaan santosh mein nakaam nahi ho raha, woh ek aisi cheez se nipat raha hai jo sabme ek jaisi bartti hai aur bahut lambe samay se bartti aayi hai.',
  'Seeing the mechanism does not stop it. It does stop you from concluding that you are the problem.',
  'तंत्र को देख लेना उसे रोकता नहीं। वह आपको यह नतीजा निकालने से ज़रूर रोकता है कि ख़राबी आपमें है।',
  'Mechanism ko dekh lena use rokta nahi. Woh tumhe yeh nateeja nikalne se zaroor rokta hai ki kharabi tumme hai.',
  NULL, 'intermediate', 'money,desire,contentment,goals,enough'

  UNION ALL SELECT 37, 'relationships', 3,
  'The argument that was about the dishes', 'वह झगड़ा जो बर्तनों का था', 'Woh jhagda jo bartanon ka tha',
  'Two people have a disproportionate row about washing up. Later, calmly, one of them can trace it: they had wanted to be asked how the day went, were not asked, did not say so, and forty minutes later found a subject that was available. The dishes were genuinely not washed. They were also not what happened.',
  'दो लोगों में बर्तन धोने पर हद से बड़ा झगड़ा होता है। बाद में, शांत होकर, उनमें से एक उसे पीछे तक जोड़ पाता है: वह चाहता था कि उससे दिन के बारे में पूछा जाए, पूछा नहीं गया, उसने कहा नहीं, और चालीस मिनट बाद उसे एक ऐसा विषय मिल गया जो उपलब्ध था। बर्तन सचमुच नहीं धुले थे। वे वह भी नहीं थे जो हुआ।',
  'Do logon mein bartan dhone par had se bada jhagda hota hai. Baad mein, shaant hokar, unme se ek use peechhe tak jod paata hai: woh chahta tha ki usse din ke baare mein poocha jaaye, poocha nahi gaya, usne kaha nahi, aur chalis minute baad use ek aisa vishay mil gaya jo uplabdh tha. Bartan sach mein nahi dhule the. Woh woh bhi nahi the jo hua.',
  'The verse names wanting and anger as one thing with two faces, and this is what that looks like in a kitchen. The anger arrived wearing a subject it had nothing to do with. The practical value is small and real: when anger turns up, the useful question is what was being wanted about half an hour earlier.',
  'श्लोक चाह और गुस्से को एक ही चीज़ के दो चेहरे बताता है, और रसोई में वह ऐसा दिखता है। गुस्सा एक ऐसा विषय ओढ़कर आया जिससे उसका कोई लेना-देना नहीं था। काम की बात छोटी और असली है: जब गुस्सा आए, तो पूछने लायक सवाल यह है कि क़रीब आधा घंटा पहले क्या चाहा जा रहा था।',
  'Shloka chaah aur gusse ko ek hi cheez ke do chehre batata hai, aur rasoi mein woh aisa dikhta hai. Gussa ek aisa vishay odh kar aaya jisse uska koi lena-dena nahi tha. Kaam ki baat chhoti aur asli hai: jab gussa aaye, to poochne layak sawaal yeh hai ki karib aadha ghanta pehle kya chaha ja raha tha.',
  'Anger usually arrives wearing a subject it has nothing to do with. Look thirty minutes earlier.',
  'गुस्सा अक्सर ऐसा विषय ओढ़कर आता है जिससे उसका कोई लेना-देना नहीं। तीस मिनट पीछे देखिए।',
  'Gussa aksar aisa vishay odh kar aata hai jisse uska koi lena-dena nahi. Tees minute peechhe dekho.',
  NULL, 'beginner', 'relationships,anger,desire,communication,arguments'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 3;

-- =====================================================================
-- 5. CROSS REFERENCES
-- =====================================================================
-- Only where the parallel genuinely illuminates. Chapter 3 earns more of
-- these than chapter 2 did, because half of it is chapter 2's argument
-- restated for somebody who has objected to it.
--
-- Targets are given as chapter AND verse, since these point backwards
-- into chapter 2 as well as within chapter 3.
-- =====================================================================

DELETE x FROM verse_cross_references x JOIN verses v ON v.id = x.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 3 AND v.verse_number IN (5,8,16,19,21,27,35,37);

INSERT INTO verse_cross_references
  (verse_id, reference_type, book, chapter, verse, target_verse_id,
   description_en, description_hi, description_hinglish, relationship, sort_order)
SELECT v.id, 'gita', 'Bhagavad Gita', CAST(x.tch AS CHAR), CAST(x.tvn AS CHAR), tv.id,
       x.d_en, x.d_hi, x.d_hing, x.rel, x.ord
FROM (
  SELECT 19 AS vn, 2 AS tch, 47 AS tvn, 1 AS ord,
    'The same instruction, given twice. 2.47 states it; 3.19 draws the conclusion — so act, rather than so stop wanting.' AS d_en,
    'वही हिदायत, दो बार। 2.47 उसे कहता है; 3.19 उससे नतीजा निकालता है — इसलिए काम कीजिए, न कि इसलिए चाहना बंद कीजिए।' AS d_hi,
    'Wahi hidayat, do baar. 2.47 use kehta hai; 3.19 usse nateeja nikalta hai — isliye kaam karo, na ki isliye chahna band karo.' AS d_hing,
    'same' AS rel
  UNION ALL SELECT 19, 2, 48, 2,
    'Evenness is what makes this instruction survivable. Nobody keeps working without the result unless they can hold both outcomes the same way.',
    'समता ही इस हिदायत को सह पाने लायक बनाती है। जो दोनों नतीजों को एक तरह नहीं थाम सकता, वह बिना नतीजे के काम करता नहीं रह सकता।',
    'Samta hi is hidayat ko seh paane layak banati hai. Jo dono results ko ek tarah nahi thaam sakta, woh bina result ke kaam karta nahi reh sakta.',
    'supports'
  UNION ALL SELECT 37, 2, 62, 1,
    'The chain in 2.62 shows wanting turning into anger step by step. This verse says they were one thing the whole time.',
    '2.62 की कड़ी दिखाती है कि चाह कैसे क़दम दर क़दम गुस्सा बनती है। यह श्लोक कहता है कि वे शुरू से एक ही चीज़ थे।',
    '2.62 ki chain dikhati hai ki chaah kaise kadam dar kadam gussa banti hai. Yeh shloka kehta hai ki woh shuru se ek hi cheez the.',
    'same'
  UNION ALL SELECT 37, 2, 70, 2,
    'The unfilled appetite here, and the ocean that takes every river without rising, are the same picture from opposite ends.',
    'यहाँ की न भरने वाली भूख, और वह समुद्र जो हर नदी लेकर भी नहीं बढ़ता — एक ही तस्वीर के दो सिरे हैं।',
    'Yahan ki na bharne wali bhookh, aur woh samudra jo har nadi lekar bhi nahi badhta — ek hi tasveer ke do sire hain.',
    'opposite'
  UNION ALL SELECT 5, 3, 8, 1,
    'This verse says you are acting whether you agree or not. The next one says: then act deliberately.',
    'यह श्लोक कहता है कि आप काम कर ही रहे हैं, हामी हो या न हो। अगला कहता है: तो सोच-समझकर कीजिए।',
    'Yeh shloka kehta hai ki tum kaam kar hi rahe ho, haami ho ya na ho. Agla kehta hai: to soch-samajh kar karo.',
    'supports'
  UNION ALL SELECT 8, 2, 47, 1,
    'Chapter 2 said do the work and drop the result. Arjuna heard "then why work at all". This is the answer to that.',
    'दूसरे अध्याय ने कहा था कि काम कीजिए और नतीजा छोड़िए। अर्जुन ने सुना "तो फिर काम ही क्यों"। यह उसी का जवाब है।',
    'Doosre chapter ne kaha tha ki kaam karo aur result chhodo. Arjun ne suna "to phir kaam hi kyun". Yeh usi ka jawab hai.',
    'supports'
  UNION ALL SELECT 27, 2, 47, 1,
    'If the work is not authored the way you think, the results were never yours to hold either. The two verses reach the same place by different roads.',
    'अगर कर्म का कर्ता वैसा नहीं जैसा आप सोचते हैं, तो नतीजे भी कभी आपके थामने को नहीं थे। दोनों श्लोक अलग रास्तों से एक ही जगह पहुँचते हैं।',
    'Agar karm ka karta waisa nahi jaisa tum sochte ho, to results bhi kabhi tumhare thaamne ko nahi the. Dono shloka alag raston se ek hi jagah pahunchte hain.',
    'supports'
  UNION ALL SELECT 35, 3, 5, 1,
    'Nobody escapes acting; 3.35 adds that acting as somebody else is not an escape either.',
    'कर्म से कोई बच नहीं सकता; 3.35 जोड़ता है कि किसी और की तरह करना भी बचना नहीं है।',
    'Karm se koi bach nahi sakta; 3.35 jodta hai ki kisi aur ki tarah karna bhi bachna nahi hai.',
    'supports'
  UNION ALL SELECT 16, 3, 19, 1,
    'The wheel turns because people do the required work. 3.19 is the instruction for turning it.',
    'चक्र इसलिए घूमता है कि लोग तय काम करते हैं। 3.19 उसे घुमाने की हिदायत है।',
    'Chakr isliye ghoomta hai ki log tay kaam karte hain. 3.19 use ghumane ki hidayat hai.',
    'supports'
  UNION ALL SELECT 21, 3, 19, 1,
    'Do the work without clinging to the result — and be visible while you do it, because somebody is measuring from you.',
    'नतीजे से चिपके बिना काम कीजिए — और करते हुए दिखिए भी, क्योंकि कोई आपसे नाप ले रहा है।',
    'Result se chipke bina kaam karo — aur karte hue dikho bhi, kyunki koi tumse naap le raha hai.',
    'supports'
) AS x
JOIN verses v  ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 3
JOIN chapters tc ON tc.chapter_number = x.tch
JOIN verses tv ON tv.verse_number = x.tvn AND tv.chapter_id = tc.id;

-- =====================================================================
-- 6. WORD BY WORD
-- =====================================================================
-- Every significant word in reading order, with a grammar note and the
-- root where it helps. Study and Research modes render this.
--
-- The gloss is the one place where being literal beats being readable.
-- The natural translation is elsewhere; here the job is to show which
-- Sanskrit word carried which piece of the meaning. Where a word has
-- been fought over — svadharma above all — the gloss says what the word
-- means and does not smuggle in the argument.
-- =====================================================================

DELETE w FROM verse_word_meanings w JOIN verses v ON v.id = w.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 3 AND v.verse_number IN (5,8,16,19,21,27,35,37);

INSERT INTO verse_word_meanings
  (verse_id, word_order, devanagari, transliteration,
   meaning_en, meaning_hi, meaning_hinglish, grammar, root_word)
SELECT v.id, w.ord, w.dev, w.tr, w.m_en, w.m_hi, w.m_hing, w.gram, w.root FROM (

  -- 3.5
  SELECT 5 AS vn, 1 AS ord, 'न हि' AS dev, 'na hi' AS tr, 'not at all, certainly not' AS m_en, 'बिलकुल नहीं' AS m_hi, 'bilkul nahi' AS m_hing, 'particles' AS gram, NULL AS root
  UNION ALL SELECT 5, 2, 'कश्चित्', 'kaścit', 'anybody at all', 'कोई भी', 'koi bhi', 'nominative singular', 'किम्'
  UNION ALL SELECT 5, 3, 'क्षणम्', 'kṣaṇam', 'for a moment', 'एक क्षण के लिए', 'ek pal ke liye', 'accusative of duration', 'क्षण'
  UNION ALL SELECT 5, 4, 'अपि', 'api', 'even', 'भी', 'bhi', 'indeclinable', NULL
  UNION ALL SELECT 5, 5, 'जातु', 'jātu', 'ever, at any time', 'कभी भी', 'kabhi bhi', 'indeclinable', NULL
  UNION ALL SELECT 5, 6, 'तिष्ठति', 'tiṣṭhati', 'remains, stands', 'ठहरता है', 'thehrta hai', 'present, third person', 'स्था'
  UNION ALL SELECT 5, 7, 'अकर्मकृत्', 'akarma-kṛt', 'one who does no action', 'जो कोई कर्म न करे', 'jo koi karm na kare', 'compound, nominative', 'अ + कृ'
  UNION ALL SELECT 5, 8, 'कार्यते', 'kāryate', 'is made to do', 'करवाया जाता है', 'karwaya jaata hai', 'causative passive, third person', 'कृ'
  UNION ALL SELECT 5, 9, 'अवशः', 'avaśaḥ', 'helplessly, not in control of it', 'बेबस, अपने बस में नहीं', 'bebas, apne bas mein nahi', 'nominative singular', 'वश'
  UNION ALL SELECT 5, 10, 'प्रकृतिजैः', 'prakṛti-jaiḥ', 'born of nature, of what one is made of', 'प्रकृति से जन्मे', 'prakriti se janme', 'compound, instrumental plural', 'जन्'
  UNION ALL SELECT 5, 11, 'गुणैः', 'guṇaiḥ', 'by the qualities, the strands of temperament', 'गुणों से, स्वभाव के धागों से', 'gunon se, swabhav ke dhaagon se', 'instrumental plural', 'गुण'

  -- 3.8
  UNION ALL SELECT 8, 1, 'नियतम्', 'niyatam', 'the required, the prescribed', 'तय किया हुआ, नियत', 'tay kiya hua, niyat', 'accusative singular', 'नि + यम्'
  UNION ALL SELECT 8, 2, 'कुरु', 'kuru', 'do', 'कीजिए', 'karo', 'imperative, second person', 'कृ'
  UNION ALL SELECT 8, 3, 'कर्म', 'karma', 'action, work', 'कर्म, काम', 'karm, kaam', 'accusative singular', 'कृ'
  UNION ALL SELECT 8, 4, 'ज्यायः', 'jyāyaḥ', 'better, greater', 'बेहतर', 'behtar', 'comparative, nominative', 'ज्या'
  UNION ALL SELECT 8, 5, 'अकर्मणः', 'akarmaṇaḥ', 'than inaction', 'अकर्म से', 'na karne se', 'ablative singular', 'अ + कृ'
  UNION ALL SELECT 8, 6, 'शरीरयात्रा', 'śarīra-yātrā', 'the journey of the body — its ordinary upkeep', 'शरीर की यात्रा — रोज़ का निर्वाह', 'sharir ki yatra — roz ka nirvah', 'compound, nominative', 'यात्रा'
  UNION ALL SELECT 8, 7, 'न प्रसिद्ध्येत्', 'na prasiddhyet', 'would not be accomplished', 'सिद्ध न होती', 'poori na hoti', 'optative, third person', 'प्र + सिध्'

  -- 3.16
  UNION ALL SELECT 16, 1, 'एवम्', 'evam', 'thus, in this way', 'इस तरह', 'is tarah', 'indeclinable', NULL
  UNION ALL SELECT 16, 2, 'प्रवर्तितम्', 'pravartitam', 'set turning', 'चलाया हुआ', 'chalaya hua', 'past participle, accusative', 'प्र + वृत्'
  UNION ALL SELECT 16, 3, 'चक्रम्', 'cakram', 'the wheel', 'चक्र, पहिया', 'chakr, pahiya', 'accusative singular', 'चक्र'
  UNION ALL SELECT 16, 4, 'न अनुवर्तयति', 'na anuvartayati', 'does not keep turning along with it', 'साथ में नहीं घुमाता', 'saath mein nahi ghumata', 'present causative, third person', 'अनु + वृत्'
  UNION ALL SELECT 16, 5, 'अघायुः', 'aghāyuḥ', 'whose life is harm, one who lives wrongly', 'जिसका जीवन ही पाप हो', 'jiska jeevan hi paap ho', 'compound, nominative', 'अघ + आयुस्'
  UNION ALL SELECT 16, 6, 'इन्द्रियारामः', 'indriyārāmaḥ', 'taking pleasure in the senses alone', 'इंद्रियों में ही रमने वाला', 'indriyon mein hi ramne wala', 'compound, nominative', 'आ + रम्'
  UNION ALL SELECT 16, 7, 'मोघम्', 'mogham', 'in vain, to no purpose', 'व्यर्थ', 'vyarth', 'adverbial accusative', 'मोघ'
  UNION ALL SELECT 16, 8, 'पार्थ', 'pārtha', 'son of Pritha — Arjuna', 'पृथा का पुत्र — अर्जुन', 'Pritha ka putra — Arjun', 'vocative', NULL
  UNION ALL SELECT 16, 9, 'स जीवति', 'sa jīvati', 'he lives', 'वह जीता है', 'woh jeeta hai', 'present, third person', 'जीव्'

  -- 3.19
  UNION ALL SELECT 19, 1, 'तस्मात्', 'tasmāt', 'therefore', 'इसलिए', 'isliye', 'ablative singular', 'तद्'
  UNION ALL SELECT 19, 2, 'असक्तः', 'asaktaḥ', 'unattached, not clinging', 'बिना चिपके', 'bina chipke', 'nominative singular', 'अ + सञ्ज्'
  UNION ALL SELECT 19, 3, 'सततम्', 'satatam', 'always, continually', 'हमेशा', 'hamesha', 'indeclinable', NULL
  UNION ALL SELECT 19, 4, 'कार्यम्', 'kāryam', 'what is to be done', 'जो करना है', 'jo karna hai', 'gerundive, accusative', 'कृ'
  UNION ALL SELECT 19, 5, 'समाचर', 'samācara', 'carry out, perform', 'कीजिए, निभाइए', 'karo, nibhao', 'imperative, second person', 'सम् + आ + चर्'
  UNION ALL SELECT 19, 6, 'आचरन्', 'ācaran', 'while performing', 'करते हुए', 'karte hue', 'present participle, nominative', 'आ + चर्'
  UNION ALL SELECT 19, 7, 'परम्', 'param', 'the highest, the further thing', 'परम, सबसे ऊँचा', 'param, sabse ooncha', 'accusative singular', 'पर'
  UNION ALL SELECT 19, 8, 'आप्नोति', 'āpnoti', 'reaches, obtains', 'पाता है', 'paata hai', 'present, third person', 'आप्'
  UNION ALL SELECT 19, 9, 'पूरुषः', 'pūruṣaḥ', 'the person', 'पुरुष, व्यक्ति', 'insaan', 'nominative singular', 'पुरुष'

  -- 3.21
  UNION ALL SELECT 21, 1, 'यद्यत्', 'yad yat', 'whatever, each thing that', 'जो-जो', 'jo-jo', 'correlative', 'यद्'
  UNION ALL SELECT 21, 2, 'आचरति', 'ācarati', 'does, conducts himself', 'करता है, बरतता है', 'karta hai, bartta hai', 'present, third person', 'आ + चर्'
  UNION ALL SELECT 21, 3, 'श्रेष्ठः', 'śreṣṭhaḥ', 'the foremost person, the one others look to', 'श्रेष्ठ, जिसे लोग देखते हैं', 'shreshth, jise log dekhte hain', 'superlative, nominative', 'श्री'
  UNION ALL SELECT 21, 4, 'इतरः जनः', 'itaraḥ janaḥ', 'other people', 'बाक़ी लोग', 'baaki log', 'nominative singular', 'जन्'
  UNION ALL SELECT 21, 5, 'प्रमाणम्', 'pramāṇam', 'the measure, the standard', 'प्रमाण, पैमाना', 'praman, paimana', 'accusative singular', 'प्र + मा'
  UNION ALL SELECT 21, 6, 'कुरुते', 'kurute', 'makes, sets', 'बनाता है', 'banata hai', 'present middle, third person', 'कृ'
  UNION ALL SELECT 21, 7, 'लोकः', 'lokaḥ', 'the world, people at large', 'लोक, दुनिया', 'duniya', 'nominative singular', 'लोक'
  UNION ALL SELECT 21, 8, 'अनुवर्तते', 'anuvartate', 'follows after', 'पीछे चलता है', 'peechhe chalta hai', 'present middle, third person', 'अनु + वृत्'

  -- 3.27
  UNION ALL SELECT 27, 1, 'प्रकृतेः', 'prakṛteḥ', 'of nature, of what things are made of', 'प्रकृति का', 'prakriti ka', 'genitive singular', 'प्र + कृ'
  UNION ALL SELECT 27, 2, 'क्रियमाणानि', 'kriyamāṇāni', 'being done', 'किए जा रहे', 'kiye ja rahe', 'passive participle, nominative plural', 'कृ'
  UNION ALL SELECT 27, 3, 'गुणैः', 'guṇaiḥ', 'by the qualities', 'गुणों से', 'gunon se', 'instrumental plural', 'गुण'
  UNION ALL SELECT 27, 4, 'कर्माणि', 'karmāṇi', 'actions', 'कर्म', 'karm', 'nominative plural', 'कृ'
  UNION ALL SELECT 27, 5, 'सर्वशः', 'sarvaśaḥ', 'in every way, all of them', 'हर तरह से, सब', 'har tarah se, sab', 'indeclinable', 'सर्व'
  UNION ALL SELECT 27, 6, 'अहङ्कारविमूढात्मा', 'ahaṅkāra-vimūḍhātmā', 'one whose sense of self is confused by the I-maker', 'जिसका मन अहंकार से भ्रमित है', 'jiska man ahankaar se bhramit hai', 'compound, nominative', 'अहम् + कृ'
  UNION ALL SELECT 27, 7, 'कर्ता अहम्', 'kartā aham', 'I am the doer', 'मैं करने वाला हूँ', 'main karne wala hoon', 'nominative', 'कृ'
  UNION ALL SELECT 27, 8, 'मन्यते', 'manyate', 'thinks, supposes', 'मानता है', 'maanta hai', 'present middle, third person', 'मन्'

  -- 3.35
  UNION ALL SELECT 35, 1, 'श्रेयान्', 'śreyān', 'better', 'बेहतर', 'behtar', 'comparative, nominative', 'श्री'
  UNION ALL SELECT 35, 2, 'स्वधर्मः', 'sva-dharmaḥ', 'one''s own work, what is genuinely one''s own to do — the word says "own", not "inherited"', 'अपना धर्म, जो सचमुच अपना करने का है — शब्द "अपना" कहता है, "विरासत में मिला" नहीं', 'apna dharm, jo sach mein apna karne ka hai — shabd "apna" kehta hai, "virasat mein mila" nahi', 'compound, nominative', 'स्व + धृ'
  UNION ALL SELECT 35, 3, 'विगुणः', 'viguṇaḥ', 'lacking in quality, done imperfectly', 'गुण में कम, अधूरे ढंग से', 'gun mein kam, adhoore dhang se', 'nominative singular', 'वि + गुण'
  UNION ALL SELECT 35, 4, 'परधर्मात्', 'para-dharmāt', 'than another''s work', 'दूसरे के धर्म से', 'doosre ke dharm se', 'compound, ablative', 'पर + धृ'
  UNION ALL SELECT 35, 5, 'स्वनुष्ठितात्', 'sv-anuṣṭhitāt', 'than one well carried out', 'अच्छी तरह निभाए गए से', 'achhi tarah nibhaye gaye se', 'ablative singular', 'अनु + स्था'
  UNION ALL SELECT 35, 6, 'निधनम्', 'nidhanam', 'death, coming to an end', 'मृत्यु, अंत', 'mrityu, ant', 'nominative singular', 'नि + धा'
  UNION ALL SELECT 35, 7, 'श्रेयः', 'śreyaḥ', 'better, more to be chosen', 'बेहतर', 'behtar', 'comparative, nominative', 'श्री'
  UNION ALL SELECT 35, 8, 'भयावहः', 'bhayāvahaḥ', 'bringing fear, dangerous', 'डर लाने वाला', 'dar laane wala', 'compound, nominative', 'भी + वह्'

  -- 3.37
  UNION ALL SELECT 37, 1, 'कामः', 'kāmaḥ', 'wanting, desire', 'काम, चाह', 'chaah', 'nominative singular', 'कम्'
  UNION ALL SELECT 37, 2, 'एषः', 'eṣaḥ', 'this one', 'यह', 'yeh', 'nominative singular', 'एतद्'
  UNION ALL SELECT 37, 3, 'क्रोधः', 'krodhaḥ', 'anger', 'क्रोध, गुस्सा', 'gussa', 'nominative singular', 'क्रुध्'
  UNION ALL SELECT 37, 4, 'रजोगुणसमुद्भवः', 'rajo-guṇa-samudbhavaḥ', 'arising from rajas — the restless, driving quality', 'रजोगुण से उठा — बेचैन, धकेलने वाला गुण', 'rajogun se utha — bechain, dhakelne wala gun', 'compound, nominative', 'सम् + उद् + भू'
  UNION ALL SELECT 37, 5, 'महाशनः', 'mahāśanaḥ', 'great-eating — it never fills up', 'बहुत खाने वाला — कभी भरता नहीं', 'bahut khaane wala — kabhi bharta nahi', 'compound, nominative', 'महत् + अश्'
  UNION ALL SELECT 37, 6, 'महापाप्मा', 'mahā-pāpmā', 'greatly harmful', 'बहुत नुक़सान करने वाला', 'bahut nuksaan karne wala', 'compound, nominative', 'पाप्मन्'
  UNION ALL SELECT 37, 7, 'विद्धि', 'viddhi', 'know', 'जानिए', 'jaano', 'imperative, second person', 'विद्'
  UNION ALL SELECT 37, 8, 'इह', 'iha', 'here, in this world', 'यहाँ', 'yahan', 'indeclinable', NULL
  UNION ALL SELECT 37, 9, 'वैरिणम्', 'vairiṇam', 'the enemy', 'शत्रु, दुश्मन', 'dushman', 'accusative singular', 'वैर'
) AS w
JOIN verses v ON v.verse_number = w.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 3;

-- =====================================================================
-- 7. BEGINNER-DEPTH EXPLANATIONS ADDED LATER
-- =====================================================================
-- 3.16 and 3.27 were seeded at intermediate and advanced respectively,
-- so the default reader met them through the repository's fallback.
-- This adds the beginner depth for both.
--
-- These live at the bottom of this file rather than in one of their own
-- because the DELETE in the explanations section clears the whole
-- chapter. A row added from elsewhere would vanish on the next re-run.
-- =====================================================================

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 16 AS vn, 'beginner' AS level,
   'Krishna has been describing a cycle — rain, food, work, giving, rain again — in which everything depends on something else being kept going. This verse is what he says about somebody standing outside it.' AS h_en,
   'कृष्ण एक चक्र बता रहे हैं — वर्षा, अन्न, कर्म, दान, फिर वर्षा — जिसमें हर चीज़ इस पर टिकी है कि कोई और चीज़ चलती रहे। यह श्लोक उस व्यक्ति के बारे में है जो उसके बाहर खड़ा है।' AS h_hi,
   'Krishna ek chakr bata rahe hain — varsha, anna, karm, daan, phir varsha — jisme har cheez is par tiki hai ki koi aur cheez chalti rahe. Yeh shloka us insaan ke baare mein hai jo uske bahar khada hai.' AS h_hing,
   'You arrived onto something already running. Roads, water, the people who taught you, the work somebody did before you got here. The verse asks a single question about that: what are you putting back? Somebody who only takes, it says, is not really living — just consuming.' AS p_en,
   'आप ऐसी चीज़ पर आए जो पहले से चल रही थी। सड़कें, पानी, वे लोग जिन्होंने आपको सिखाया, वह काम जो आपके आने से पहले किसी ने किया। श्लोक इस पर एक ही सवाल पूछता है: आप वापस क्या डाल रहे हैं? जो सिर्फ़ लेता है, वह कहता है, वह सचमुच जी नहीं रहा — बस खा रहा है।' AS p_hi,
   'Tum aisi cheez par aaye jo pehle se chal rahi thi. Sadkein, paani, woh log jinhone tumhe sikhaya, woh kaam jo tumhare aane se pehle kisi ne kiya. Shloka is par ek hi sawaal poochta hai: tum wapas kya daal rahe ho? Jo sirf leta hai, woh kehta hai, woh sach mein jee nahi raha — bas kha raha hai.' AS p_hing,
   'The word the verse uses is stronger than "unfair", and that is on purpose. But notice what it is not doing: it is not asking you to feel guilty about having been a child, or about using a road. It is asking the wheel to become visible, and it becomes visible the first time you have to turn a bit of it yourself.' AS m_en,
   'श्लोक जो शब्द इस्तेमाल करता है वह "अन्याय" से सख़्त है, और यह जानबूझकर है। पर ध्यान दीजिए वह क्या नहीं कर रहा: वह आपसे यह नहीं कह रहा कि बच्चा रहने पर या सड़क इस्तेमाल करने पर अपराधबोध महसूस कीजिए। वह चाहता है कि चक्र दिखने लगे, और वह पहली बार तब दिखता है जब उसका थोड़ा हिस्सा आपको ख़ुद घुमाना पड़े।' AS m_hi,
   'Shloka jo shabd istemaal karta hai woh "anyay" se sakht hai, aur yeh jaanboojhkar hai. Par dhyan do woh kya nahi kar raha: woh tumse yeh nahi keh raha ki bachcha rehne par ya sadak istemaal karne par apradhbodh mehsoos karo. Woh chahta hai ki chakr dikhne lage, aur woh pehli baar tab dikhta hai jab uska thoda hissa tumhe khud ghumana pade.' AS m_hing

  UNION ALL SELECT 27, 'beginner',
   'Krishna has been arguing that action is unavoidable. Here he goes one step further and says something about who is doing it, which is a stranger claim and the one the chapter is remembered for.',
   'कृष्ण कह रहे थे कि कर्म से बचा नहीं जा सकता। यहाँ वे एक क़दम और आगे जाकर यह बताते हैं कि कर रहा कौन है — जो ज़्यादा अजीब दावा है और जिसके लिए यह अध्याय याद रखा जाता है।',
   'Krishna keh rahe the ki karm se bacha nahi ja sakta. Yahan woh ek kadam aur aage jaakar yeh batate hain ki kar raha kaun hai — jo zyada ajeeb dawa hai aur jiske liye yeh chapter yaad rakha jaata hai.',
   'The claim is that the work is done by the machinery — your temperament, your training, the conditions of the day, none of which you chose — and that afterwards something steps forward and puts its name to it. The doing and the claiming are two separate events, and only the first one actually happened out in the world.',
   'दावा यह है कि काम मशीन करती है — आपका स्वभाव, आपकी तालीम, उस दिन के हालात, इनमें से कुछ भी आपने चुना नहीं — और बाद में कोई आगे आकर उस पर अपना नाम लिख देता है। करना और दावा करना दो अलग घटनाएँ हैं, और दुनिया में असल में पहली ही हुई।',
   'Dawa yeh hai ki kaam machine karti hai — tumhara swabhav, tumhari taleem, us din ke haalat, inme se kuch bhi tumne chuna nahi — aur baad mein koi aage aakar us par apna naam likh deta hai. Karna aur dawa karna do alag ghatnayein hain, aur duniya mein asal mein pehli hi hui.',
   'Taken carelessly this sounds like nobody is responsible for anything, and the book does not go there — it spends eighteen chapters telling somebody to act well. Taken carefully it does something smaller and more useful: it makes taking the credit and taking the blame look like the same mistake. Somebody who still cannot forgive themselves for a decision made ten years ago is holding exactly the claim this verse declines.',
   'लापरवाही से लें तो यह लगता है कि किसी की कोई ज़िम्मेदारी ही नहीं, और किताब वहाँ जाती नहीं — वह अठारह अध्याय किसी से अच्छा कर्म करने को कहती है। ध्यान से लें तो यह छोटा और ज़्यादा काम का काम करता है: यह श्रेय लेने और दोष लेने को एक ही भूल जैसा दिखा देता है। जो आज भी दस साल पुराने किसी फ़ैसले के लिए ख़ुद को माफ़ नहीं कर पा रहा, वह ठीक वही दावा थामे है जिसे यह श्लोक अस्वीकार करता है।',
   'Laparwahi se lo to yeh lagta hai ki kisi ki koi zimmedari hi nahi, aur kitaab wahan jaati nahi — woh atharah chapter kisi se achha karm karne ko kehti hai. Dhyan se lo to yeh chhota aur zyada kaam ka kaam karta hai: yeh credit lene aur blame lene ko ek hi galti jaisa dikha deta hai. Jo aaj bhi das saal purane kisi faisle ke liye khud ko maaf nahi kar paa raha, woh theek wahi dawa thame hai jise yeh shloka asweekar karta hai.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 3;

-- =====================================================================
-- 8. EXAMPLE TOP-UP — 3 PER VERSE TO 8
-- =====================================================================
-- The spec asks for eight to twelve modern examples per verse. This
-- chapter shipped with three, which was enough to prove the shape and
-- not enough to be the product. These forty take all eight verses to
-- eight, and sort_order continues from 4 so the original three still
-- lead.
--
-- CATEGORY SPREAD IS DELIBERATE
--   No verse repeats a setting. A reader who does not recognise
--   themselves in an office will find a hospital, a pitch, a marriage,
--   a classroom. That breadth is the whole argument for having eight
--   rather than three.
--
-- THE POLITICS EXAMPLES ARE STRUCTURAL AND NAME NOBODY
--   They describe the SHAPE of a situation — a vote, an abstention, a
--   term of office — and contain no living politician, party or
--   movement, and no praise or criticism of any. Same rule as
--   everywhere else in this corpus.
--
-- These live at the bottom of this file because the DELETE in the
-- examples section clears the whole chapter; rows added from a separate
-- file would vanish on the next re-run.
-- =====================================================================

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

  SELECT 5 AS vn, 'cricket' AS cat, 4 AS ord,
  'Leaving deliveries outside off' AS t_en, 'ऑफ़ के बाहर की गेंदें छोड़ना' AS t_hi, 'Off ke bahar ki gendein chhodna' AS t_hing,
  'A batsman decides to leave everything outside off stump for an hour. It is a real plan and a good one. What it is not is inaction: he is still choosing, ball by ball, and the bowler is reading the leave and adjusting his line. By the fortieth delivery the corridor has moved and the leave has become a stroke he did not intend to play.' AS s_en,
  'एक बल्लेबाज़ तय करता है कि वह एक घंटे तक ऑफ़ स्टंप के बाहर की हर गेंद छोड़ देगा। यह असली योजना है और अच्छी भी। जो यह नहीं है वह है निष्क्रियता: वह अब भी हर गेंद पर चुनाव कर रहा है, और गेंदबाज़ उसका छोड़ना पढ़कर अपनी लाइन बदल रहा है। चालीसवीं गेंद तक कॉरिडोर खिसक चुका है और छोड़ना एक ऐसा शॉट बन गया है जो वह खेलना नहीं चाहता था।' AS s_hi,
  'Ek batsman tay karta hai ki woh ek ghante tak off stump ke bahar ki har gend chhod dega. Yeh asli plan hai aur achha bhi. Jo yeh nahi hai woh hai nishkriyata: woh ab bhi har ball par chunav kar raha hai, aur bowler uska chhodna padhkar apni line badal raha hai. Chalisvi ball tak corridor khisak chuka hai aur chhodna ek aisa shot ban gaya hai jo woh khelna nahi chahta tha.' AS s_hing,
  'The verse says nobody stays actionless for even a moment, and a leave is the cleanest small proof of it. Not playing at the ball is a move. The other side is responding to it. An hour of leaves has changed the match as surely as an hour of driving would have, just in a direction nobody announced.' AS c_en,
  'श्लोक कहता है कि कोई एक क्षण भी निष्क्रिय नहीं रहता, और गेंद छोड़ना इसका सबसे साफ़ छोटा सबूत है। गेंद न खेलना भी एक चाल है। सामने वाला उस पर जवाब दे रहा है। एक घंटे के छोड़ने ने मैच उतना ही बदला है जितना एक घंटे के ड्राइव बदलते, बस उस दिशा में जिसकी किसी ने घोषणा नहीं की।' AS c_hi,
  'Shloka kehta hai ki koi ek pal bhi nishkriya nahi rehta, aur gend chhodna iska sabse saaf chhota saboot hai. Gend na khelna bhi ek chaal hai. Saamne wala us par jawab de raha hai. Ek ghante ke chhodne ne match utna hi badla hai jitna ek ghante ke drive badalte, bas us disha mein jiski kisi ne ghoshna nahi ki.' AS c_hing,
  'Not playing at the ball is a move, and the other side is already responding to it.' AS l_en,
  'गेंद न खेलना भी एक चाल है, और सामने वाला उस पर जवाब दे भी चुका है।' AS l_hi,
  'Gend na khelna bhi ek chaal hai, aur saamne wala us par jawab de bhi chuka hai.' AS l_hing,
  NULL AS src, 'beginner' AS diff, 'cricket,inaction,choice,sport,pressure' AS tags

  UNION ALL SELECT 5, 'technology', 5,
  'The upgrade that was postponed', 'वह अपग्रेड जो टलता रहा', 'Woh upgrade jo talta raha',
  'A team keeps deferring a framework upgrade because the current version works and the upgrade has risk. Every month the decision is re-taken in about four minutes and comes out the same way. Fourteen months later the version is out of support, the upgrade path now requires two intermediate hops, and the risk they were avoiding has roughly tripled.',
  'एक टीम फ़्रेमवर्क अपग्रेड टालती रहती है क्योंकि मौजूदा संस्करण चल रहा है और अपग्रेड में जोखिम है। हर महीने यह फ़ैसला क़रीब चार मिनट में दोबारा लिया जाता है और वही निकलता है। चौदह महीने बाद संस्करण समर्थन से बाहर है, अपग्रेड के रास्ते में अब दो बीच के पड़ाव हैं, और जिस जोखिम से वे बच रहे थे वह क़रीब तीन गुना हो चुका है।',
  'Ek team framework upgrade taalti rehti hai kyunki maujooda version chal raha hai aur upgrade mein jokhim hai. Har mahine yeh faisla karib chaar minute mein dobara liya jaata hai aur wahi nikalta hai. Chaudah mahine baad version support se bahar hai, upgrade ke raste mein ab do beech ke padav hain, aur jis jokhim se woh bach rahe the woh karib teen guna ho chuka hai.',
  'Each of those four-minute decisions felt like declining to act. None of them was. Not upgrading is a position on the codebase, taken monthly, and it compounds — which is exactly the verse''s claim that you are being acted through whether or not you agreed to anything.',
  'उन चार-चार मिनट के हर फ़ैसले में लगा कि काम करने से मना किया जा रहा है। उनमें से कोई ऐसा था नहीं। अपग्रेड न करना कोडबेस पर एक स्थिति है, हर महीने ली गई, और वह जुड़ती जाती है — और यही श्लोक का दावा है कि आपके ज़रिये काम हो रहा है, चाहे आपने किसी बात पर हामी भरी हो या नहीं।',
  'Un chaar-chaar minute ke har faisle mein laga ki kaam karne se mana kiya ja raha hai. Unme se koi aisa tha nahi. Upgrade na karna codebase par ek position hai, har mahine li gayi, aur woh judti jaati hai — aur yahi shloka ka dawa hai ki tumhare zariye kaam ho raha hai, chahe tumne kisi baat par haami bhari ho ya nahi.',
  'Deciding not to act, monthly, is not the absence of a decision. It is the same decision compounding.',
  'हर महीने यह तय करना कि काम नहीं करना — यह फ़ैसले की गैरहाज़िरी नहीं है। यह वही फ़ैसला है जो जुड़ता जा रहा है।',
  'Har mahine yeh tay karna ki kaam nahi karna — yeh faisle ki gairhaziri nahi hai. Yeh wahi faisla hai jo judta ja raha hai.',
  NULL, 'intermediate', 'technology,delay,risk,decisions,compounding'

  UNION ALL SELECT 5, 'healthcare', 6,
  'Watchful waiting', 'देखते हुए इंतज़ार', 'Dekhte hue intezaar',
  'A doctor recommends watchful waiting for a condition that may or may not need treating. The patient hears this as "we are not doing anything yet". The clinical note says otherwise: a monitoring interval, a set of thresholds, and a specific list of things that would change the plan. It is a treatment, and it has been chosen over two others.',
  'एक डॉक्टर ऐसी स्थिति के लिए "देखते हुए इंतज़ार" की सलाह देते हैं जिसका इलाज ज़रूरी हो भी सकता है और नहीं भी। मरीज़ इसे "अभी हम कुछ नहीं कर रहे" की तरह सुनता है। क्लिनिकल नोट कुछ और कहता है: निगरानी का अंतराल, कुछ सीमाएँ, और उन चीज़ों की एक ख़ास सूची जो योजना बदल देंगी। यह एक इलाज है, और इसे दो और विकल्पों के मुक़ाबले चुना गया है।',
  'Ek doctor aisi sthiti ke liye "dekhte hue intezaar" ki salah dete hain jiska ilaaj zaroori ho bhi sakta hai aur nahi bhi. Mareez ise "abhi hum kuch nahi kar rahe" ki tarah sunta hai. Clinical note kuch aur kehta hai: nigrani ka antaral, kuch seemayein, aur un cheezon ki ek khaas list jo yojna badal dengi. Yeh ek ilaaj hai, aur ise do aur options ke muqable chuna gaya hai.',
  'Medicine had to invent a name for this because the alternative was patients believing nothing was happening. The verse makes the same move at a wider scale: there is no square marked "not playing", so the honest thing is to describe what the waiting actually is and set the thresholds that would end it.',
  'चिकित्सा को इसके लिए एक नाम गढ़ना पड़ा क्योंकि वरना मरीज़ मान लेते कि कुछ हो ही नहीं रहा। श्लोक यही चाल बड़े पैमाने पर चलता है: "नहीं खेल रहे" का कोई ख़ाना है ही नहीं, इसलिए ईमानदारी यह है कि बताया जाए कि यह इंतज़ार असल में है क्या, और वे सीमाएँ तय की जाएँ जो उसे ख़त्म कर देंगी।',
  'Chikitsa ko iske liye ek naam gadhna pada kyunki warna mareez maan lete ki kuch ho hi nahi raha. Shloka yahi chaal bade paimane par chalta hai: "nahi khel rahe" ka koi khaana hai hi nahi, isliye imaandari yeh hai ki bataya jaaye ki yeh intezaar asal mein hai kya, aur woh seemayein tay ki jaayein jo use khatam kar dengi.',
  'Waiting deliberately has an interval and a threshold. Waiting by default has neither, and calls itself the same thing.',
  'सोच-समझकर किए इंतज़ार में एक अंतराल और एक सीमा होती है। यूँ ही हो रहे इंतज़ार में दोनों नहीं होते, और वह ख़ुद को वही कहता है।',
  'Soch-samajhkar kiye intezaar mein ek antaral aur ek seema hoti hai. Yun hi ho rahe intezaar mein dono nahi hote, aur woh khud ko wahi kehta hai.',
  NULL, 'intermediate', 'health,waiting,decisions,monitoring,default'

  UNION ALL SELECT 5, 'everyday_life', 7,
  'The subscription nobody uses', 'वह सब्सक्रिप्शन जो कोई इस्तेमाल नहीं करता', 'Woh subscription jo koi use nahi karta',
  'A monthly charge for a service last opened in March continues to leave an account every month. Cancelling takes four minutes and everybody in the house knows it. Nobody has decided to keep paying for it. Twenty-one months later the total is a number that would have bought something anybody in the house could name.',
  'मार्च में आख़िरी बार खोली गई सेवा का मासिक शुल्क हर महीने खाते से जाता रहता है। रद्द करने में चार मिनट लगते हैं और घर में सबको यह पता है। किसी ने तय नहीं किया कि इसके पैसे देते रहना है। इक्कीस महीने बाद कुल रक़म ऐसा आँकड़ा है जिससे घर में कोई भी कुछ ऐसा ख़रीद लेता जिसका वह नाम बता सकता।',
  'March mein aakhiri baar kholi gayi service ka monthly shulk har mahine khaate se jaata rehta hai. Radd karne mein chaar minute lagte hain aur ghar mein sabko yeh pata hai. Kisi ne tay nahi kiya ki iske paise dete rehna hai. Ikkis mahine baad kul rakam aisa number hai jisse ghar mein koi bhi kuch aisa kharid leta jiska woh naam bata sakta.',
  'This is the verse at its smallest and most literal. Nobody chose to spend the money. The money was spent anyway, monthly, by the arrangement rather than by a person — which is precisely what "you are being acted through" describes when it is not being philosophical about it.',
  'यह श्लोक अपने सबसे छोटे और सबसे सीधे रूप में है। किसी ने पैसे ख़र्च करने का फ़ैसला नहीं किया। पैसे फिर भी ख़र्च हुए, हर महीने, किसी व्यक्ति से नहीं बल्कि उस इंतज़ाम से — और "आपके ज़रिये काम हो रहा है" जब दार्शनिक नहीं हो रहा होता, तब ठीक यही बताता है।',
  'Yeh shloka apne sabse chhote aur sabse seedhe roop mein hai. Kisi ne paise kharch karne ka faisla nahi kiya. Paise phir bhi kharch hue, har mahine, kisi insaan se nahi balki us intezaam se — aur "tumhare zariye kaam ho raha hai" jab darshanik nahi ho raha hota, tab theek yahi batata hai.',
  'Nobody decided to spend it. It was spent anyway, by the arrangement rather than by a person.',
  'किसी ने ख़र्च करने का फ़ैसला नहीं किया। ख़र्च फिर भी हुआ — किसी व्यक्ति से नहीं, उस इंतज़ाम से।',
  'Kisi ne kharch karne ka faisla nahi kiya. Kharch phir bhi hua — kisi insaan se nahi, us intezaam se.',
  NULL, 'beginner', 'money,default,habits,household,inaction'

  UNION ALL SELECT 5, 'politics', 8,
  'The seat left empty', 'वह कुर्सी जो ख़ाली रही', 'Woh kursi jo khaali rahi',
  'A committee is deciding something on a simple majority. One member, believing the question is not really theirs to weigh in on, does not attend. The vote is close enough that the absence changes which way it goes. Nobody in the room notices this at the time, and the absent member describes themselves afterwards as having kept out of it.',
  'एक समिति साधारण बहुमत से कुछ तय कर रही है। एक सदस्य, यह मानते हुए कि यह सवाल सचमुच उनका तौलने का नहीं है, नहीं आते। मतदान इतना क़रीबी है कि उनकी गैरहाज़िरी तय कर देती है कि फ़ैसला किधर जाएगा। उस वक़्त कमरे में किसी का ध्यान इस पर नहीं जाता, और गैरहाज़िर सदस्य बाद में ख़ुद को यह बताते हैं कि वे इससे अलग रहे।',
  'Ek committee sadharan bahumat se kuch tay kar rahi hai. Ek sadasya, yeh maante hue ki yeh sawaal sach mein unka taulne ka nahi hai, nahi aate. Matdan itna karibi hai ki unki gairhaziri tay kar deti hai ki faisla kidhar jayega. Us waqt kamre mein kisi ka dhyan is par nahi jaata, aur gairhazir sadasya baad mein khud ko yeh batate hain ki woh isse alag rahe.',
  'The verse holds here as arithmetic rather than as philosophy, which is why the example is worth having. Absence has a value in a count. Standing outside a decision is a position inside it, and the only thing the standing-outside changed was that nobody had to defend it.',
  'यह श्लोक यहाँ दर्शन की तरह नहीं, गणित की तरह टिकता है — और इसीलिए यह उदाहरण रखने लायक है। गिनती में गैरहाज़िरी की भी एक क़ीमत होती है। किसी फ़ैसले से बाहर खड़ा होना उसी फ़ैसले के भीतर की एक स्थिति है, और बाहर खड़े होने से बस इतना बदला कि किसी को उसका बचाव नहीं करना पड़ा।',
  'Yeh shloka yahan darshan ki tarah nahi, ganit ki tarah tikta hai — aur isiliye yeh example rakhne layak hai. Ginti mein gairhaziri ki bhi ek keemat hoti hai. Kisi faisle se bahar khada hona usi faisle ke bheetar ki ek sthiti hai, aur bahar khade hone se bas itna badla ki kisi ko uska bachav nahi karna pada.',
  'Absence has a value in a count. Standing outside a decision is a position inside it.',
  'गिनती में गैरहाज़िरी की भी क़ीमत होती है। फ़ैसले से बाहर खड़ा होना उसी फ़ैसले के भीतर की स्थिति है।',
  'Ginti mein gairhaziri ki bhi keemat hoti hai. Faisle se bahar khada hona usi faisle ke bheetar ki sthiti hai.',
  NULL, 'intermediate', 'decisions,abstention,consequences,committees,responsibility'

  UNION ALL SELECT 8, 'cricket', 4,
  'The nets nobody watches', 'वह नेट जिसे कोई नहीं देखता', 'Woh nets jise koi nahi dekhta',
  'A player coming back from injury has a rehabilitation block that is four weeks of throwdowns in an empty net. No crowd, no video, no selectors. He describes it afterwards as the least interesting cricket of his life and the reason the season happened at all.',
  'चोट से लौट रहे एक खिलाड़ी का पुनर्वास चार हफ़्ते के थ्रोडाउन का है, ख़ाली नेट में। कोई भीड़ नहीं, कोई वीडियो नहीं, कोई चयनकर्ता नहीं। वह बाद में इसे अपने जीवन का सबसे नीरस क्रिकेट बताता है और वही वजह जिससे वह सत्र हुआ।',
  'Chot se laut rahe ek khiladi ka punarvas chaar hafte ke throwdown ka hai, khaali net mein. Koi bheed nahi, koi video nahi, koi selector nahi. Woh baad mein ise apne jeevan ka sabse neeras cricket batata hai aur wahi wajah jisse woh season hua.',
  'The verse says do the required work, and "required" is doing a lot of quiet work in that sentence. It does not say do the interesting work or the visible work. Four weeks in an empty net is the required work, and there is nothing in it that would make anybody want to do it except that the alternative is not playing.',
  'श्लोक कहता है तय काम कीजिए, और उस वाक्य में "तय" शब्द चुपचाप बहुत काम कर रहा है। वह यह नहीं कहता कि दिलचस्प काम कीजिए या दिखने वाला काम। ख़ाली नेट में चार हफ़्ते तय काम हैं, और उनमें ऐसा कुछ नहीं जो किसी को करने का मन कराए — सिवाय इसके कि दूसरा विकल्प न खेलना है।',
  'Shloka kehta hai tay kaam karo, aur us vakya mein "tay" shabd chupchap bahut kaam kar raha hai. Woh yeh nahi kehta ki dilchasp kaam karo ya dikhne wala kaam. Khaali net mein chaar hafte tay kaam hain, aur unme aisa kuch nahi jo kisi ko karne ka man karaye — siwaye iske ki doosra option na khelna hai.',
  '"Required" is not the same as interesting or visible, and the verse only asks for the first one.',
  '"तय" का मतलब दिलचस्प या दिखने वाला नहीं है, और श्लोक सिर्फ़ पहला माँगता है।',
  '"Tay" ka matlab dilchasp ya dikhne wala nahi hai, aur shloka sirf pehla maangta hai.',
  NULL, 'beginner', 'cricket,rehab,discipline,unglamorous,work'

  UNION ALL SELECT 8, 'school', 5,
  'The teacher who kept turning up', 'वह शिक्षक जो आता रहा', 'Woh teacher jo aata raha',
  'A school in a difficult year loses three staff and gains none. One teacher, who could reasonably reduce what she offers, keeps the Thursday afternoon extra class running for the four students who come. Two of the four later say it was the only part of that year that felt normal. She never described it as a stand for anything.',
  'एक मुश्किल साल में स्कूल के तीन शिक्षक चले जाते हैं और कोई नया नहीं आता। एक शिक्षिका, जो वाजिब तौर पर अपना काम घटा सकती थीं, गुरुवार दोपहर की अतिरिक्त कक्षा उन चार छात्रों के लिए चलाती रहती हैं जो आते हैं। उन चार में से दो बाद में कहते हैं कि उस साल का वही इकलौता हिस्सा था जो सामान्य लगा। उन्होंने कभी इसे किसी बात का मोर्चा नहीं बताया।',
  'Ek mushkil saal mein school ke teen teacher chale jaate hain aur koi naya nahi aata. Ek teacher, jo waajib taur par apna kaam ghata sakti thi, Thursday dopahar ki extra class un chaar students ke liye chalati rehti hain jo aate hain. Un chaar mein se do baad mein kehte hain ki us saal ka wahi iklauta hissa tha jo samanya laga. Unhone kabhi ise kisi baat ka morcha nahi bataya.',
  'Withdrawal was available and defensible and she did not take it. The verse''s claim is that not acting is not neutral — and in a year where three people had already stopped, the Thursday class was not just work continuing. It was the only thing holding a line that everybody could feel.',
  'पीछे हटना उपलब्ध भी था और जायज़ भी, और उन्होंने वह नहीं किया। श्लोक का दावा है कि न करना तटस्थ नहीं होता — और जिस साल तीन लोग पहले ही रुक चुके थे, उस साल गुरुवार की वह कक्षा सिर्फ़ काम का चलते रहना नहीं थी। वह इकलौती चीज़ थी जो एक मोर्चा थामे थी, और वह सबको महसूस होता था।',
  'Peechhe hatna uplabdh bhi tha aur jaayaz bhi, aur unhone woh nahi kiya. Shloka ka dawa hai ki na karna neutral nahi hota — aur jis saal teen log pehle hi ruk chuke the, us saal Thursday ki woh class sirf kaam ka chalte rehna nahi thi. Woh iklauti cheez thi jo ek morcha thame thi, aur woh sabko mehsoos hota tha.',
  'When enough people have already stopped, continuing stops being neutral and becomes the thing holding the line.',
  'जब काफ़ी लोग पहले ही रुक चुके हों, तो चलते रहना तटस्थ होना बंद कर देता है और वही मोर्चा थामने लगता है।',
  'Jab kaafi log pehle hi ruk chuke hon, to chalte rehna neutral hona band kar deta hai aur wahi morcha thaamne lagta hai.',
  NULL, 'intermediate', 'school,teaching,duty,continuing,ordinary'

  UNION ALL SELECT 8, 'marriage', 6,
  'The dishes, again', 'फिर वही बर्तन', 'Phir wahi bartan',
  'One person in a household has quietly stopped doing the small maintenance tasks — the bin, the bulb, the form that needed signing — on the reasonable grounds that they are tired and it is not fair that it always falls to them. It is not fair. Six weeks later the flat is measurably worse and the unfairness has not been discussed once.',
  'घर में एक व्यक्ति ने चुपचाप छोटे-मोटे काम करने बंद कर दिए हैं — कूड़ा, बल्ब, वह फ़ॉर्म जिस पर दस्तख़त होने थे — इस वाजिब आधार पर कि वह थका है और यह ठीक नहीं कि हर बार यही उसके ज़िम्मे आए। यह ठीक है भी नहीं। छह हफ़्ते बाद घर साफ़ तौर पर ख़राब हालत में है और इस नाइंसाफ़ी पर एक बार भी बात नहीं हुई।',
  'Ghar mein ek insaan ne chupchap chhote-mote kaam karne band kar diye hain — kachra, bulb, woh form jis par dastkhat hone the — is waajib aadhar par ki woh thaka hai aur yeh theek nahi ki har baar yahi uske zimme aaye. Yeh theek hai bhi nahi. Chhah hafte baad ghar saaf taur par kharab haalat mein hai aur is nainsaafi par ek baar bhi baat nahi hui.',
  'The grievance is legitimate and the method is the one the verse rules out. Stopping did not raise the issue; it just moved the cost onto the flat and onto the other person, without either of them having to say anything. The verse is not asking for silent endurance. It is pointing out that stopping is not the same as objecting.',
  'शिकायत जायज़ है और तरीक़ा वही है जिसे श्लोक ख़ारिज करता है। रुकने से बात उठी नहीं; उसने बस क़ीमत घर पर और दूसरे व्यक्ति पर डाल दी, और दोनों में से किसी को कुछ कहना नहीं पड़ा। श्लोक चुपचाप सहने को नहीं कह रहा। वह बता रहा है कि रुकना और आपत्ति करना एक बात नहीं है।',
  'Shikayat jaayaz hai aur tareeka wahi hai jise shloka khaarij karta hai. Rukne se baat uthi nahi; usne bas keemat ghar par aur doosre insaan par daal di, aur dono mein se kisi ko kuch kehna nahi pada. Shloka chupchap sehne ko nahi keh raha. Woh bata raha hai ki rukna aur aapatti karna ek baat nahi hai.',
  'Stopping is not the same as objecting. It moves the cost without raising the question.',
  'रुकना आपत्ति करना नहीं है। वह क़ीमत सरका देता है और सवाल उठाता ही नहीं।',
  'Rukna aapatti karna nahi hai. Woh keemat sarka deta hai aur sawaal uthata hi nahi.',
  NULL, 'intermediate', 'marriage,household,fairness,withdrawal,communication'

  UNION ALL SELECT 8, 'ai', 7,
  'Waiting for the better model', 'बेहतर मॉडल का इंतज़ार', 'Behtar model ka intezaar',
  'A small team wants to build something and decides to wait six months for capabilities that are clearly coming. The capabilities arrive on schedule. So does a competitor who spent those six months learning what their users actually needed, and who now knows things about the problem that no model release supplies.',
  'एक छोटी टीम कुछ बनाना चाहती है और तय करती है कि छह महीने उन क्षमताओं का इंतज़ार करेगी जो साफ़ तौर पर आने वाली हैं। क्षमताएँ समय पर आ जाती हैं। साथ ही एक प्रतिस्पर्धी भी, जिसने वे छह महीने यह सीखने में लगाए कि उसके उपयोगकर्ताओं को असल में चाहिए क्या, और जो अब उस समस्या के बारे में वे बातें जानता है जो किसी मॉडल रिलीज़ से नहीं मिलतीं।',
  'Ek chhoti team kuch banana chahti hai aur tay karti hai ki chhah mahine un kshamtaon ka intezaar karegi jo saaf taur par aane wali hain. Kshamtayein samay par aa jaati hain. Saath hi ek competitor bhi, jisne woh chhah mahine yeh seekhne mein lagaye ki uske users ko asal mein chahiye kya, aur jo ab us samasya ke baare mein woh baatein jaanta hai jo kisi model release se nahi miltin.',
  'The waiting was correct about the technology and wrong about what those six months were. They were not neutral time that passed equally for everybody. The verse''s point is that the clock does not stop for the person who has decided not to start, and somebody else''s six months were spent.',
  'इंतज़ार तकनीक के बारे में सही था और इस बारे में ग़लत कि वे छह महीने थे क्या। वे तटस्थ समय नहीं थे जो सबके लिए बराबर बीता। श्लोक की बात यह है कि जिसने शुरू न करने का तय किया है उसके लिए घड़ी रुकती नहीं, और किसी और के छह महीने ख़र्च हुए।',
  'Intezaar technology ke baare mein sahi tha aur is baare mein galat ki woh chhah mahine the kya. Woh neutral samay nahi the jo sabke liye barabar beeta. Shloka ki baat yeh hai ki jisne shuru na karne ka tay kiya hai uske liye ghadi rukti nahi, aur kisi aur ke chhah mahine kharch hue.',
  'The clock does not stop for the person who decided not to start. Somebody else spent those months.',
  'जिसने शुरू न करने का तय किया, उसके लिए घड़ी रुकती नहीं। वे महीने किसी और ने ख़र्च किए।',
  'Jisne shuru na karne ka tay kiya, uske liye ghadi rukti nahi. Woh mahine kisi aur ne kharch kiye.',
  NULL, 'intermediate', 'technology,waiting,building,competition,timing'

  UNION ALL SELECT 8, 'friendship', 8,
  'The message left on read', 'वह संदेश जो पढ़कर छोड़ दिया गया', 'Woh message jo padhkar chhod diya gaya',
  'Somebody receives a message from a friend they have drifted from. They mean to reply properly, which means not now, which means at the weekend, which means when they have thought about what to say. The weekend goes. Four months later the reply would need to be about the four months, so it does not get written either.',
  'किसी को उस दोस्त का संदेश मिलता है जिससे दूरी बन चुकी है। वह ठीक से जवाब देना चाहता है, यानी अभी नहीं, यानी सप्ताहांत पर, यानी जब वह सोच ले कि कहना क्या है। सप्ताहांत बीत जाता है। चार महीने बाद जवाब उन्हीं चार महीनों के बारे में होना पड़ेगा, इसलिए वह भी नहीं लिखा जाता।',
  'Kisi ko us dost ka message milta hai jisse doori ban chuki hai. Woh theek se jawab dena chahta hai, yaani abhi nahi, yaani weekend par, yaani jab woh soch le ki kehna kya hai. Weekend beet jaata hai. Chaar mahine baad jawab unhi chaar mahinon ke baare mein hona padega, isliye woh bhi nahi likha jaata.',
  'Nothing here was decided and a friendship changed shape anyway. The verse is not moralising about it. It is pointing at the mechanism: intending to do the thing properly is one of the more reliable ways of not doing it, and the not-doing keeps working the whole time.',
  'यहाँ कुछ तय नहीं हुआ और एक दोस्ती का आकार फिर भी बदल गया। श्लोक इस पर उपदेश नहीं दे रहा। वह तंत्र की तरफ़ इशारा कर रहा है: किसी काम को ठीक से करने का इरादा उसे न करने के भरोसेमंद तरीक़ों में एक है, और न करना पूरे समय काम करता रहता है।',
  'Yahan kuch tay nahi hua aur ek dosti ka aakar phir bhi badal gaya. Shloka is par updesh nahi de raha. Woh mechanism ki taraf ishara kar raha hai: kisi kaam ko theek se karne ka iraada use na karne ke bharosemand tareekon mein ek hai, aur na karna poore samay kaam karta rehta hai.',
  'Intending to do it properly is one of the more reliable ways of not doing it at all.',
  'ठीक से करने का इरादा उसे बिलकुल न करने के भरोसेमंद तरीक़ों में एक है।',
  'Theek se karne ka iraada use bilkul na karne ke bharosemand tareekon mein ek hai.',
  NULL, 'beginner', 'friendship,messages,drift,intention,delay'

  UNION ALL SELECT 16, 'healthcare', 4,
  'The blood on the shelf', 'शेल्फ़ पर रखा ख़ून', 'Shelf par rakha khoon',
  'Somebody needs three units during surgery. They receive them. At no point in the process does anybody involved learn the names of the three people who gave that blood, and the three people will never learn who received it. The system works precisely because neither end is asked to care about the other.',
  'किसी को सर्जरी के दौरान तीन यूनिट चाहिए। उसे मिल जाती हैं। पूरी प्रक्रिया में शामिल किसी को उन तीन लोगों के नाम पता नहीं चलते जिन्होंने वह ख़ून दिया, और वे तीन लोग कभी नहीं जान पाएँगे कि वह किसे मिला। यह व्यवस्था ठीक इसलिए चलती है कि किसी भी सिरे से दूसरे की परवाह करने को नहीं कहा जाता।',
  'Kisi ko surgery ke dauran teen unit chahiye. Use mil jaati hain. Poori prakriya mein shamil kisi ko un teen logon ke naam pata nahi chalte jinhone woh khoon diya, aur woh teen log kabhi nahi jaan payenge ki woh kise mila. Yeh vyavastha theek isliye chalti hai ki kisi bhi sire se doosre ki parwah karne ko nahi kaha jaata.',
  'The wheel in its most literal form. Nobody in this story met anybody. What kept it turning was a large number of people doing an unremarkable thing on an ordinary Tuesday, and the verse''s question — what are you putting back — has a very specific answer available here that takes about forty minutes.',
  'चक्र अपने सबसे सीधे रूप में। इस कहानी में कोई किसी से मिला ही नहीं। इसे घुमाए रखा बहुत सारे लोगों ने, किसी साधारण मंगलवार को कोई साधारण-सा काम करके — और श्लोक का सवाल, कि आप वापस क्या डाल रहे हैं, यहाँ एक बहुत ही ख़ास जवाब रखता है जिसमें क़रीब चालीस मिनट लगते हैं।',
  'Chakr apne sabse seedhe roop mein. Is kahani mein koi kisi se mila hi nahi. Ise ghumaye rakha bahut saare logon ne, kisi sadharan Tuesday ko koi sadharan sa kaam karke — aur shloka ka sawaal, ki tum wapas kya daal rahe ho, yahan ek bahut hi khaas jawab rakhta hai jisme karib chalis minute lagte hain.',
  'The wheel turns on people doing unremarkable things for strangers they will never meet.',
  'चक्र उन लोगों से घूमता है जो अनजानों के लिए साधारण काम करते हैं, जिनसे वे कभी मिलेंगे भी नहीं।',
  'Chakr un logon se ghoomta hai jo anjaano ke liye sadharan kaam karte hain, jinse woh kabhi milenge bhi nahi.',
  NULL, 'beginner', 'health,donation,strangers,systems,contribution'

  UNION ALL SELECT 16, 'college', 5,
  'The notes that circulated for nine years', 'वे नोट्स जो नौ साल चलते रहे', 'Woh notes jo nau saal chalte rahe',
  'A set of handwritten notes for a hard second-year paper passes from batch to batch, photocopied, then scanned, then re-typed. The original author graduated nine years ago. Nobody currently using them knows who she was, and nobody in nine years has made a second set for the paper that replaced hers.',
  'दूसरे साल के एक कठिन पर्चे के हाथ से लिखे नोट्स एक बैच से दूसरे बैच तक जाते रहते हैं — फ़ोटोकॉपी, फिर स्कैन, फिर दोबारा टाइप। मूल लिखने वाली नौ साल पहले पास आउट हो गई। अभी जो इन्हें इस्तेमाल कर रहे हैं उनमें से कोई नहीं जानता कि वह कौन थी, और नौ साल में किसी ने उस पर्चे के लिए दूसरा सेट नहीं बनाया जिसने उसके पर्चे की जगह ली।',
  'Doosre saal ke ek mushkil paper ke haath se likhe notes ek batch se doosre batch tak jaate rehte hain — photocopy, phir scan, phir dobara type. Mool likhne wali nau saal pehle pass out ho gayi. Abhi jo inhe use kar rahe hain unme se koi nahi jaanta ki woh kaun thi, aur nau saal mein kisi ne us paper ke liye doosra set nahi banaya jisne uske paper ki jagah li.',
  'Both halves of the verse in one artefact. Somebody turned the wheel once, hard, and nine years of students have been living off it. And the second half: nobody has turned it since, so the newer paper has nothing, and the students taking it are having a harder time for no reason anybody would defend.',
  'श्लोक के दोनों आधे एक ही चीज़ में। किसी ने चक्र एक बार, ज़ोर से घुमाया, और नौ साल के छात्र उसी पर जी रहे हैं। और दूसरा आधा: उसके बाद किसी ने नहीं घुमाया, इसलिए नए पर्चे के लिए कुछ नहीं है, और उसे देने वाले छात्रों को बिना किसी ऐसी वजह के ज़्यादा मुश्किल हो रही है जिसका कोई बचाव करे।',
  'Shloka ke dono aadhe ek hi cheez mein. Kisi ne chakr ek baar, zor se ghumaya, aur nau saal ke students usi par jee rahe hain. Aur doosra aadha: uske baad kisi ne nahi ghumaya, isliye naye paper ke liye kuch nahi hai, aur use dene wale students ko bina kisi aisi wajah ke zyada mushkil ho rahi hai jiska koi bachav kare.',
  'Somebody turned it once, hard. Nine years of people lived off that and nobody turned it again.',
  'किसी ने एक बार, ज़ोर से घुमाया। नौ साल के लोग उसी पर जिए और किसी ने दोबारा नहीं घुमाया।',
  'Kisi ne ek baar, zor se ghumaya. Nau saal ke log usi par jiye aur kisi ne dobara nahi ghumaya.',
  NULL, 'beginner', 'college,notes,sharing,contribution,students'

  UNION ALL SELECT 16, 'finance', 6,
  'The fund that everybody was in', 'वह फ़ंड जिसमें सब थे', 'Woh fund jisme sab the',
  'A widely held index fund works because a smaller number of people spend their working lives on price discovery — reading filings, arguing about valuations, being wrong expensively. The passive holder benefits from all of it and pays almost nothing for it. This is not a scandal; it is how the instrument is designed. It is also only stable while enough people are still doing the other job.',
  'एक व्यापक रूप से रखा गया इंडेक्स फ़ंड इसलिए चलता है कि कम लोग अपना कामकाजी जीवन क़ीमत तय होने की प्रक्रिया में लगाते हैं — फाइलिंग पढ़ना, मूल्यांकन पर बहस करना, महँगे ढंग से ग़लत होना। निष्क्रिय निवेशक इस सबका फ़ायदा उठाता है और उसके लिए लगभग कुछ नहीं देता। यह कोई घोटाला नहीं है; यह उपकरण की बनावट है। और यह तभी तक टिकाऊ है जब तक काफ़ी लोग वह दूसरा काम कर रहे हों।',
  'Ek vyapak roop se rakha gaya index fund isliye chalta hai ki kam log apna kaamkaji jeevan keemat tay hone ki prakriya mein lagate hain — filing padhna, mulyankan par behes karna, mehnge dhang se galat hona. Nishkriya nivehsak is sabka fayda uthata hai aur uske liye lagbhag kuch nahi deta. Yeh koi ghotala nahi hai; yeh upkaran ki banavat hai. Aur yeh tabhi tak tikaau hai jab tak kaafi log woh doosra kaam kar rahe hon.',
  'The verse is describing a structural risk rather than a personal failing, and this is the cleanest modern instance of it. Nobody holding the fund is behaving badly. The arrangement is nonetheless one where the taking is easy and cheap and the turning is hard and expensive, and arrangements shaped like that have a limit.',
  'श्लोक व्यक्तिगत ख़ामी नहीं, ढाँचे का जोखिम बता रहा है, और यह उसका सबसे साफ़ आधुनिक उदाहरण है। फ़ंड रखने वाला कोई बुरा बरताव नहीं कर रहा। फिर भी यह इंतज़ाम ऐसा है जिसमें लेना आसान और सस्ता है और घुमाना कठिन और महँगा — और इस आकार के इंतज़ामों की एक सीमा होती है।',
  'Shloka vyaktigat khami nahi, dhaanche ka jokhim bata raha hai, aur yeh uska sabse saaf aadhunik udaharan hai. Fund rakhne wala koi bura bartav nahi kar raha. Phir bhi yeh intezaam aisa hai jisme lena asaan aur sasta hai aur ghumana mushkil aur mehnga — aur is aakar ke intezaamon ki ek seema hoti hai.',
  'When taking is cheap and turning is expensive, the arrangement has a limit nobody has to break to reach.',
  'जब लेना सस्ता हो और घुमाना महँगा, तो उस इंतज़ाम की एक सीमा होती है, जिस तक पहुँचने के लिए किसी को कुछ तोड़ना नहीं पड़ता।',
  'Jab lena sasta ho aur ghumana mehnga, to us intezaam ki ek seema hoti hai, jis tak pahunchne ke liye kisi ko kuch todna nahi padta.',
  NULL, 'advanced', 'money,investing,systems,free-riding,structure'

  UNION ALL SELECT 16, 'ethics', 7,
  'Herd immunity', 'सामूहिक प्रतिरोध', 'Samoohik pratirodh',
  'A protection that works at population level depends on most people taking a small individual cost. Somebody who declines it is genuinely safer than they would be alone, because everybody around them did not decline. The logic is sound for one person and collapses at scale, which is the whole difficulty and is not solved by calling anybody names.',
  'आबादी के स्तर पर काम करने वाला एक बचाव इस पर टिका है कि ज़्यादातर लोग एक छोटी निजी क़ीमत चुकाएँ। जो इससे मना करता है वह अकेले होने की तुलना में सचमुच ज़्यादा सुरक्षित है, क्योंकि उसके आस-पास सबने मना नहीं किया। यह तर्क एक व्यक्ति के लिए ठीक बैठता है और पैमाने पर ढह जाता है — पूरी मुश्किल यही है और किसी को नाम देकर यह हल नहीं होती।',
  'Aabadi ke star par kaam karne wala ek bachav is par tika hai ki zyadatar log ek chhoti niji keemat chukayein. Jo isse mana karta hai woh akele hone ki tulna mein sach mein zyada surakshit hai, kyunki uske aas-paas sabne mana nahi kiya. Yeh tark ek insaan ke liye theek baithta hai aur paimane par dheh jaata hai — poori mushkil yahi hai aur kisi ko naam dekar yeh hal nahi hoti.',
  'The verse does not solve this either, and it is worth saying so. What it does is name the shape precisely: a wheel that keeps turning only while enough people turn it, and where the individually rational move and the collectively necessary one point in different directions. Naming it accurately is not nothing — most arguments about it never get that far.',
  'श्लोक भी इसे हल नहीं करता, और यह कह देना चाहिए। वह जो करता है वह है आकार को ठीक-ठीक नाम देना: ऐसा चक्र जो तभी तक घूमता है जब तक काफ़ी लोग घुमाएँ, और जहाँ व्यक्तिगत रूप से समझदारी वाली चाल और सामूहिक रूप से ज़रूरी चाल अलग दिशाओं में जाती हैं। इसे सही नाम दे देना कम नहीं है — इस पर होने वाली ज़्यादातर बहसें यहाँ तक पहुँचती ही नहीं।',
  'Shloka bhi ise hal nahi karta, aur yeh keh dena chahiye. Woh jo karta hai woh hai aakar ko theek-theek naam dena: aisa chakr jo tabhi tak ghoomta hai jab tak kaafi log ghumayein, aur jahan vyaktigat roop se samajhdari wali chaal aur samoohik roop se zaroori chaal alag dishaon mein jaati hain. Ise sahi naam de dena kam nahi hai — is par hone wali zyadatar behsein yahan tak pahunchti hi nahi.',
  'The individually rational move and the collectively necessary one can point different ways. The verse names that shape rather than solving it.',
  'व्यक्तिगत समझदारी वाली चाल और सामूहिक ज़रूरत वाली चाल अलग दिशाओं में जा सकती हैं। श्लोक इस आकार को हल नहीं करता, नाम देता है।',
  'Vyaktigat samajhdari wali chaal aur samoohik zaroorat wali chaal alag dishaon mein ja sakti hain. Shloka is aakar ko hal nahi karta, naam deta hai.',
  NULL, 'advanced', 'ethics,collective-action,systems,public-good,honesty'

  UNION ALL SELECT 16, 'military', 8,
  'The kit that came back clean', 'वह सामान जो साफ़ लौटा', 'Woh saamaan jo saaf lauta',
  'A unit has a standing rule that equipment is returned serviceable, not merely returned. Nobody checks most of the time. A soldier spends twenty minutes at the end of an exhausting week on kit he will not personally use again, for a person he will not meet, and the person who draws it three weeks later never learns that this happened.',
  'एक यूनिट में यह तय नियम है कि सामान लौटाया ही नहीं, चलने लायक हालत में लौटाया जाए। ज़्यादातर वक़्त कोई जाँचता नहीं। एक सैनिक थका देने वाले हफ़्ते के अंत में बीस मिनट ऐसे सामान पर लगाता है जो वह ख़ुद दोबारा इस्तेमाल नहीं करेगा, किसी ऐसे व्यक्ति के लिए जिससे वह मिलेगा नहीं, और तीन हफ़्ते बाद जो उसे लेता है उसे कभी पता नहीं चलता कि ऐसा हुआ था।',
  'Ek unit mein yeh tay niyam hai ki saamaan lautaya hi nahi, chalne layak haalat mein lautaya jaaye. Zyadatar waqt koi jaanchta nahi. Ek sainik thaka dene wale hafte ke ant mein bees minute aise saamaan par lagata hai jo woh khud dobara istemaal nahi karega, kisi aise insaan ke liye jisse woh milega nahi, aur teen hafte baad jo use leta hai use kabhi pata nahi chalta ki aisa hua tha.',
  'This is what turning the wheel looks like when nobody is watching and nothing is owed. The verse''s strong word is for the opposite case, and putting the two side by side is the point: the same twenty minutes, done or not done, is the entire difference between an arrangement that holds and one that quietly stops.',
  'जब कोई देख नहीं रहा और कुछ बकाया भी नहीं, तब चक्र घुमाना ऐसा दिखता है। श्लोक का सख़्त शब्द उल्टे मामले के लिए है, और दोनों को साथ रखना ही बात है: वही बीस मिनट, किए या न किए, उस इंतज़ाम और उस इंतज़ाम के बीच का पूरा फ़र्क़ हैं जो टिकता है और जो चुपचाप बैठ जाता है।',
  'Jab koi dekh nahi raha aur kuch bakaya bhi nahi, tab chakr ghumana aisa dikhta hai. Shloka ka sakht shabd ulte mamle ke liye hai, aur dono ko saath rakhna hi baat hai: wahi bees minute, kiye ya na kiye, us intezaam aur us intezaam ke beech ka poora farq hain jo tikta hai aur jo chupchap baith jaata hai.',
  'Twenty minutes nobody checks, for somebody you will not meet. That is the whole difference between a system that holds and one that stops.',
  'बीस मिनट जिन्हें कोई जाँचता नहीं, किसी ऐसे के लिए जिससे आप मिलेंगे नहीं। टिकने वाली और बैठ जाने वाली व्यवस्था में पूरा फ़र्क़ यही है।',
  'Bees minute jinhe koi jaanchta nahi, kisi aise ke liye jisse tum miloge nahi. Tikne wali aur baith jaane wali vyavastha mein poora farq yahi hai.',
  NULL, 'intermediate', 'military,discipline,unseen,systems,contribution'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 3;

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

  SELECT 19 AS vn, 'cricket' AS cat, 4 AS ord,
  'The declaration that did not come off' AS t_en, 'वह पारी घोषणा जो काम नहीं आई' AS t_hi, 'Woh declaration jo kaam nahi aayi' AS t_hing,
  'A captain declares with a lead he judges enough and forty overs to bowl. It rains for two sessions and the match is drawn. Every analyst agrees afterwards that the declaration was correct at the moment it was made. He is asked about it in eleven separate interviews over the following month.' AS s_en,
  'एक कप्तान उस बढ़त पर पारी घोषित करता है जिसे वह काफ़ी मानता है, और चालीस ओवर गेंदबाज़ी के लिए बचे हैं। दो सत्र बारिश होती है और मैच ड्रॉ हो जाता है। बाद में हर विश्लेषक मानता है कि जिस क्षण घोषणा हुई, वह उस क्षण सही थी। अगले महीने ग्यारह अलग-अलग इंटरव्यू में उससे इसी पर सवाल होता है।' AS s_hi,
  'Ek captain us badhat par paari ghoshit karta hai jise woh kaafi maanta hai, aur chalis over bowling ke liye bache hain. Do session baarish hoti hai aur match draw ho jaata hai. Baad mein har vishleshak maanta hai ki jis pal ghoshna hui, woh us pal sahi thi. Agle mahine gyarah alag-alag interview mein usse isi par sawaal hota hai.' AS s_hing,
  'The instruction has two halves and this is the cleanest place to see them come apart. The work — the judgement at the moment of declaring — was done well. The result was weather. Eleven interviews about the weather is what happens when the second half of the instruction is not taken up.' AS c_en,
  'हिदायत के दो आधे हैं और उन्हें अलग होते देखने की यह सबसे साफ़ जगह है। काम — घोषणा के क्षण का फ़ैसला — अच्छा हुआ। नतीजा मौसम था। मौसम पर ग्यारह इंटरव्यू वही है जो तब होता है जब हिदायत का दूसरा आधा उठाया नहीं जाता।' AS c_hi,
  'Hidayat ke do aadhe hain aur unhe alag hote dekhne ki yeh sabse saaf jagah hai. Kaam — declaration ke pal ka faisla — achha hua. Nateeja mausam tha. Mausam par gyarah interview wahi hai jo tab hota hai jab hidayat ka doosra aadha uthaya nahi jaata.' AS c_hing,
  'The decision was right at the moment it was made. Everything after that was weather, and weather is not yours.' AS l_en,
  'फ़ैसला उस क्षण सही था जब लिया गया। उसके बाद सब मौसम था, और मौसम आपका नहीं है।' AS l_hi,
  'Faisla us pal sahi tha jab liya gaya. Uske baad sab mausam tha, aur mausam tumhara nahi hai.' AS l_hing,
  NULL AS src, 'beginner' AS diff, 'cricket,captaincy,results,judgement,luck' AS tags

  UNION ALL SELECT 19, 'healthcare', 5,
  'The night the protocol was followed exactly', 'वह रात जब प्रोटोकॉल ठीक-ठीक निभाया गया', 'Woh raat jab protocol theek-theek nibhaya gaya',
  'A resuscitation is run correctly from the first minute to the last. Every drug, every interval, every escalation is right, and the patient dies. The team debriefs at four in the morning and can find nothing that should have been done differently. Two of them cannot sleep for a week and one of them can, and neither reaction is a comment on how much they cared.',
  'एक पुनर्जीवन प्रयास पहले मिनट से आख़िरी तक सही चलाया जाता है। हर दवा, हर अंतराल, हर अगला क़दम ठीक है, और मरीज़ नहीं बचता। टीम सुबह चार बजे समीक्षा करती है और ऐसा कुछ नहीं मिलता जो अलग किया जाना चाहिए था। उनमें से दो हफ़्ता भर सो नहीं पाते और एक सो पाता है, और दोनों में से कोई प्रतिक्रिया इस बात पर टिप्पणी नहीं है कि किसने कितनी परवाह की।',
  'Ek punarjeevan prayas pehle minute se aakhiri tak sahi chalaya jaata hai. Har dawa, har antaral, har agla kadam theek hai, aur mareez nahi bachta. Team subah chaar baje samiksha karti hai aur aisa kuch nahi milta jo alag kiya jaana chahiye tha. Unme se do hafta bhar so nahi paate aur ek so paata hai, aur dono mein se koi pratikriya is baat par tippani nahi hai ki kisne kitni parwah ki.',
  'This is the verse at the highest stakes it gets to, and it does not offer comfort — it offers a boundary. The work was theirs and it was done. The outcome was not theirs and no amount of carrying it afterwards moves it. Anybody who has to do this job for thirty years needs that line to be real rather than consoling.',
  'यह श्लोक अपने सबसे बड़े दाँव पर है, और वह तसल्ली नहीं देता — वह एक सीमा देता है। काम उनका था और हो गया। नतीजा उनका नहीं था और बाद में उसे कितना भी ढोने से वह हिलता नहीं। जिसे यह काम तीस साल करना है उसे यह पंक्ति सांत्वना नहीं, सच चाहिए।',
  'Yeh shloka apne sabse bade daanv par hai, aur woh tasalli nahi deta — woh ek seema deta hai. Kaam unka tha aur ho gaya. Nateeja unka nahi tha aur baad mein use kitna bhi dhone se woh hilta nahi. Jise yeh kaam tees saal karna hai use yeh line saantvana nahi, sach chahiye.',
  'The work was theirs and it was done. The outcome was not, and carrying it afterwards does not move it.',
  'काम उनका था और हो गया। नतीजा उनका नहीं था, और उसे बाद में ढोने से वह हिलता नहीं।',
  'Kaam unka tha aur ho gaya. Nateeja unka nahi tha, aur use baad mein dhone se woh hilta nahi.',
  NULL, 'advanced', 'health,outcomes,grief,duty,limits'

  UNION ALL SELECT 19, 'sports', 6,
  'The penalty taken properly', 'वह पेनल्टी जो ठीक से मारी गई', 'Woh penalty jo theek se maari gayi',
  'A player picks a corner, strikes it well, and the keeper guesses right and saves it. The same player, in the same competition two years earlier, mishit one badly and it went in off the post. In the interviews the first is a failure and the second was a goal, and he is the only person in the stadium who knows which of the two he took better.',
  'एक खिलाड़ी कोना चुनता है, अच्छी तरह मारता है, और गोलकीपर सही अंदाज़ा लगाकर रोक लेता है। उसी खिलाड़ी ने, उसी प्रतियोगिता में दो साल पहले, एक बुरी तरह ग़लत मारी थी और वह पोस्ट से लगकर अंदर चली गई थी। इंटरव्यू में पहली नाकामी है और दूसरी गोल थी, और स्टेडियम में वही इकलौता है जो जानता है कि दोनों में से कौन-सी उसने बेहतर मारी।',
  'Ek player kona chunta hai, achhi tarah maarta hai, aur goalkeeper sahi andaza lagakar rok leta hai. Usi player ne, usi competition mein do saal pehle, ek buri tarah galat maari thi aur woh post se lagkar andar chali gayi thi. Interview mein pehli nakami hai aur doosri goal thi, aur stadium mein wahi iklauta hai jo jaanta hai ki dono mein se kaun si usne behtar maari.',
  'The verse asks you to hold on to the part that was yours. Here the two are perfectly separated by chance and by two years, and the scoreboard has them the wrong way round. He does not get to argue with the scoreboard. He does get to know which one he took well.',
  'श्लोक कहता है कि जो हिस्सा आपका था उसे थामिए। यहाँ दोनों संयोग से और दो साल के अंतर से पूरी तरह अलग हो चुके हैं, और स्कोरबोर्ड ने उन्हें उल्टा रखा है। वह स्कोरबोर्ड से बहस नहीं कर सकता। वह यह ज़रूर जान सकता है कि उसने कौन-सी अच्छी मारी।',
  'Shloka kehta hai ki jo hissa tumhara tha use thaamo. Yahan dono sanyog se aur do saal ke antar se poori tarah alag ho chuke hain, aur scoreboard ne unhe ulta rakha hai. Woh scoreboard se behes nahi kar sakta. Woh yeh zaroor jaan sakta hai ki usne kaun si achhi maari.',
  'You do not get to argue with the scoreboard. You do get to know which one you took well.',
  'आप स्कोरबोर्ड से बहस नहीं कर सकते। आप यह ज़रूर जान सकते हैं कि आपने कौन-सी अच्छी मारी।',
  'Tum scoreboard se behes nahi kar sakte. Tum yeh zaroor jaan sakte ho ki tumne kaun si achhi maari.',
  NULL, 'beginner', 'sport,penalties,luck,judgement,results'

  UNION ALL SELECT 19, 'marriage', 7,
  'The apology that was not accepted', 'वह माफ़ी जो मानी नहीं गई', 'Woh maafi jo maani nahi gayi',
  'One person apologises properly — no explanation attached, no mention of the other side''s part, no timing chosen for advantage. It is not accepted, that day or that week. They can either apologise again, better, until it works, or let it stand. They let it stand, and describe the fortnight afterwards as the hardest part.',
  'एक व्यक्ति ठीक से माफ़ी माँगता है — कोई सफ़ाई जोड़े बिना, दूसरे के हिस्से का ज़िक्र किए बिना, फ़ायदे के लिए समय चुने बिना। वह मानी नहीं जाती, न उस दिन न उस हफ़्ते। अब वह या तो दोबारा, बेहतर माफ़ी माँगता रहे जब तक काम न कर जाए, या उसे वहीं रहने दे। वह उसे वहीं रहने देता है, और अगले पंद्रह दिनों को सबसे कठिन हिस्सा बताता है।',
  'Ek insaan theek se maafi maangta hai — koi safai jode bina, doosre ke hisse ka zikr kiye bina, fayde ke liye samay chune bina. Woh maani nahi jaati, na us din na us hafte. Ab woh ya to dobara, behtar maafi maangta rahe jab tak kaam na kar jaaye, ya use wahin rehne de. Woh use wahin rehne deta hai, aur agle pandrah dinon ko sabse mushkil hissa batata hai.',
  'An apology aimed at being accepted is a transaction, and the verse names exactly that boundary. The apology was the work. Whether it lands is the other person, and they are allowed to take their time or not take it at all. The fortnight is hard because the second half of the instruction always is.',
  'ऐसी माफ़ी जिसका निशाना मान लिया जाना हो, वह सौदा है — और श्लोक ठीक उसी सीमा का नाम लेता है। माफ़ी काम था। वह मानी जाती है या नहीं, यह दूसरा व्यक्ति है, और उसे समय लेने या बिलकुल न मानने का हक़ है। वे पंद्रह दिन इसलिए कठिन हैं कि हिदायत का दूसरा आधा हमेशा कठिन होता है।',
  'Aisi maafi jiska nishana maan liya jaana ho, woh sauda hai — aur shloka theek usi seema ka naam leta hai. Maafi kaam tha. Woh maani jaati hai ya nahi, yeh doosra insaan hai, aur use samay lene ya bilkul na maanne ka haq hai. Woh pandrah din isliye mushkil hain ki hidayat ka doosra aadha hamesha mushkil hota hai.',
  'An apology aimed at being accepted is a transaction. The apology was the work; the accepting is not yours.',
  'ऐसी माफ़ी जिसका निशाना मान लिया जाना हो, वह सौदा है। माफ़ी काम था; मान लेना आपका नहीं है।',
  'Aisi maafi jiska nishana maan liya jaana ho, woh sauda hai. Maafi kaam tha; maan lena tumhara nahi hai.',
  NULL, 'intermediate', 'marriage,apology,repair,letting-go,patience'

  UNION ALL SELECT 19, 'ai', 8,
  'The evaluation nobody read', 'वह मूल्यांकन जो किसी ने नहीं पढ़ा', 'Woh evaluation jo kisi ne nahi padha',
  'An engineer spends three weeks building a careful evaluation for a system, finds two real problems, writes them up clearly, and files it. The project ships on the original date. Eight months later somebody hits one of the two problems in production and finds the document while searching for prior art.',
  'एक इंजीनियर तीन हफ़्ते किसी सिस्टम के लिए सावधान मूल्यांकन बनाने में लगाता है, दो असली समस्याएँ पाता है, उन्हें साफ़ लिखता है, और दाख़िल कर देता है। परियोजना अपनी मूल तारीख़ पर ही रिलीज़ हो जाती है। आठ महीने बाद कोई उन्हीं दो में से एक समस्या से प्रोडक्शन में टकराता है और पहले के काम की तलाश करते हुए वह दस्तावेज़ पा लेता है।',
  'Ek engineer teen hafte kisi system ke liye savdhan evaluation banane mein lagata hai, do asli samasyayein paata hai, unhe saaf likhta hai, aur file kar deta hai. Project apni mool tareekh par hi release ho jaata hai. Aath mahine baad koi unhi do mein se ek samasya se production mein takrata hai aur pehle ke kaam ki talash karte hue woh dastavez paa leta hai.',
  'Nothing about the three weeks changed the ship date, which is the result he had no claim on. The document existing eight months later did change something. The verse is not promising that the work pays off — it is saying the work is the part you get to be responsible for, and this is what that looks like when the payoff arrives late and to somebody else.',
  'उन तीन हफ़्तों से रिलीज़ की तारीख़ नहीं बदली, और वह नतीजा उसका था ही नहीं। आठ महीने बाद उस दस्तावेज़ का मौजूद होना कुछ बदल गया। श्लोक यह वादा नहीं कर रहा कि मेहनत रंग लाएगी — वह कह रहा है कि मेहनत वह हिस्सा है जिसकी ज़िम्मेदारी आपकी है, और जब फल देर से और किसी और को मिले, तब वह ऐसा दिखता है।',
  'Un teen hafton se release ki tareekh nahi badli, aur woh nateeja uska tha hi nahi. Aath mahine baad us dastavez ka maujood hona kuch badal gaya. Shloka yeh wada nahi kar raha ki mehnat rang layegi — woh keh raha hai ki mehnat woh hissa hai jiski zimmedari tumhari hai, aur jab phal der se aur kisi aur ko mile, tab woh aisa dikhta hai.',
  'The work does not always change the thing it was aimed at. It still has to exist for anything later to find it.',
  'मेहनत हमेशा उस चीज़ को नहीं बदलती जिसके लिए की गई। फिर भी उसे मौजूद रहना पड़ता है ताकि बाद में कोई उसे पा सके।',
  'Mehnat hamesha us cheez ko nahi badalti jiske liye ki gayi. Phir bhi use maujood rehna padta hai taki baad mein koi use paa sake.',
  NULL, 'intermediate', 'technology,work,documentation,results,patience'

  UNION ALL SELECT 21, 'corporate', 4,
  'The expenses claim everybody saw', 'वह ख़र्च का दावा जो सबने देखा', 'Woh expense claim jo sabne dekha',
  'A director puts through a claim that is inside the letter of the policy and outside its spirit, and the finance team processes it without comment. Nothing is said. Within two quarters the average claim across the department has moved, in the same direction, by an amount somebody eventually charts.',
  'एक निदेशक ऐसा दावा भेजते हैं जो नीति के अक्षरों के भीतर है और उसकी भावना के बाहर, और वित्त टीम बिना कुछ कहे उसे पास कर देती है। कुछ कहा नहीं जाता। दो तिमाहियों में विभाग भर का औसत दावा उसी दिशा में इतना खिसक जाता है कि कोई आख़िरकार उसका ग्राफ़ बनाता है।',
  'Ek director aisa claim bhejte hain jo policy ke aksharon ke bheetar hai aur uski bhavna ke bahar, aur finance team bina kuch kahe use pass kar deti hai. Kuch kaha nahi jaata. Do quarter mein vibhag bhar ka ausat claim usi disha mein itna khisak jaata hai ki koi aakhirkar uska graph banata hai.',
  'The verse says people take the standard from whoever is in front, and nothing here was announced. It did not need to be. One processed claim, visible to a finance team who talk to people, moved a department''s behaviour further than any policy circular has ever moved it.',
  'श्लोक कहता है कि लोग पैमाना उसी से लेते हैं जो आगे है, और यहाँ कुछ घोषित नहीं हुआ। ज़रूरत भी नहीं थी। एक पास हुआ दावा, ऐसी वित्त टीम को दिखता जो लोगों से बात करती है, विभाग के बरताव को उससे ज़्यादा खिसका गया जितना कोई नीति-परिपत्र आज तक खिसका सका।',
  'Shloka kehta hai ki log paimana usi se lete hain jo aage hai, aur yahan kuch ghoshit nahi hua. Zaroorat bhi nahi thi. Ek pass hua claim, aisi finance team ko dikhta jo logon se baat karti hai, vibhag ke bartav ko usse zyada khiska gaya jitna koi policy circular aaj tak khiska saka.',
  'Inside the letter and outside the spirit is a standard too, and it travels faster than any circular.',
  'अक्षरों के भीतर और भावना के बाहर होना भी एक पैमाना है, और वह किसी परिपत्र से तेज़ चलता है।',
  'Aksharon ke bheetar aur bhavna ke bahar hona bhi ek paimana hai, aur woh kisi circular se tez chalta hai.',
  NULL, 'intermediate', 'work,ethics,example,culture,policy'

  UNION ALL SELECT 21, 'school', 5,
  'The queue at the gate', 'गेट पर क़तार', 'Gate par line',
  'A school asks parents not to park across the entrance. Most do not. Two or three do, every morning, and nothing happens to them. Within a term the number is eleven, and the parents who have started doing it are able to give an accurate and slightly aggrieved account of why the rule was never realistic.',
  'एक स्कूल अभिभावकों से कहता है कि प्रवेश द्वार के सामने गाड़ी न खड़ी करें। ज़्यादातर नहीं करते। दो-तीन रोज़ करते हैं, और उनका कुछ नहीं होता। एक सत्र में संख्या ग्यारह हो जाती है, और जिन अभिभावकों ने अभी शुरू किया है वे सटीक और हल्की शिकायत भरे लहजे में बता सकते हैं कि वह नियम कभी व्यावहारिक था ही नहीं।',
  'Ek school abhibhavkon se kehta hai ki pravesh dwar ke saamne gaadi na khadi karein. Zyadatar nahi karte. Do-teen roz karte hain, aur unka kuch nahi hota. Ek term mein sankhya gyarah ho jaati hai, aur jin parents ne abhi shuru kiya hai woh sateek aur halki shikayat bhare lehje mein bata sakte hain ki woh niyam kabhi vyavharik tha hi nahi.',
  'Nobody in this story decided to break a rule. Each of the eleven took the standard from the people already doing it, which is what the verse describes, and the justification arrived after the behaviour rather than before it. The two or three at the start were not villains either. They were just first.',
  'इस कहानी में किसी ने नियम तोड़ने का फ़ैसला नहीं किया। उन ग्यारह में से हर एक ने पैमाना उन्हीं से लिया जो पहले से कर रहे थे — और श्लोक यही बताता है — और सफ़ाई बरताव के बाद आई, पहले नहीं। शुरू के दो-तीन भी खलनायक नहीं थे। वे बस पहले थे।',
  'Is kahani mein kisi ne niyam todne ka faisla nahi kiya. Un gyarah mein se har ek ne paimana unhi se liya jo pehle se kar rahe the — aur shloka yahi batata hai — aur safai bartav ke baad aayi, pehle nahi. Shuru ke do-teen bhi khalnayak nahi the. Woh bas pehle the.',
  'Nobody decided to break it. Each one took the standard from whoever was already there, and the reason arrived afterwards.',
  'किसी ने तोड़ने का फ़ैसला नहीं किया। हर एक ने पैमाना उसी से लिया जो पहले से वहाँ था, और वजह बाद में आई।',
  'Kisi ne todne ka faisla nahi kiya. Har ek ne paimana usi se liya jo pehle se wahan tha, aur wajah baad mein aayi.',
  NULL, 'beginner', 'school,rules,norms,parents,example'

  UNION ALL SELECT 21, 'cricket', 6,
  'Walking', 'ख़ुद चल देना', 'Khud chal dena',
  'A batsman edges to the keeper, is not given, and walks anyway. It costs his side a wicket they would have kept. Nothing is said in the dressing room. Over the following two seasons three younger players in the same side start doing it, and none of them can point to a conversation in which it was discussed.',
  'एक बल्लेबाज़ की गेंद कीपर के पास जाती है, अंपायर आउट नहीं देता, और वह फिर भी ख़ुद चल देता है। इससे उसकी टीम को वह विकेट गँवाना पड़ता है जो बच जाता। ड्रेसिंग रूम में कुछ कहा नहीं जाता। अगले दो सत्रों में उसी टीम के तीन युवा खिलाड़ी ऐसा करने लगते हैं, और उनमें से कोई ऐसी बातचीत नहीं बता सकता जिसमें इस पर चर्चा हुई हो।',
  'Ek batsman ki gend keeper ke paas jaati hai, umpire out nahi deta, aur woh phir bhi khud chal deta hai. Isse uski team ko woh wicket ganwana padta hai jo bach jaata. Dressing room mein kuch kaha nahi jaata. Agle do season mein usi team ke teen yuva khiladi aisa karne lagte hain, aur unme se koi aisi baatchit nahi bata sakta jisme is par charcha hui ho.',
  'The verse works in this direction as easily as the other, which is easy to forget when it is quoted as a warning. He did not make a case for walking and did not ask anybody to follow. He walked, once, at a cost, in front of people. That is the entire mechanism.',
  'श्लोक इस दिशा में उतनी ही आसानी से काम करता है जितनी दूसरी में, जो तब भूल जाता है जब इसे चेतावनी की तरह उद्धृत किया जाता है। उसने चलने के पक्ष में दलील नहीं दी और किसी से पीछे चलने को नहीं कहा। वह चला, एक बार, क़ीमत देकर, लोगों के सामने। पूरा तंत्र यही है।',
  'Shloka is disha mein utni hi aasani se kaam karta hai jitni doosri mein, jo tab bhool jaata hai jab ise chetavni ki tarah quote kiya jaata hai. Usne chalne ke paksh mein dalil nahi di aur kisi se peechhe chalne ko nahi kaha. Woh chala, ek baar, keemat dekar, logon ke saamne. Poora mechanism yahi hai.',
  'He made no case for it and asked nobody to follow. He did it once, at a cost, where people could see.',
  'उसने इसके पक्ष में कोई दलील नहीं दी और किसी से पीछे चलने को नहीं कहा। उसने एक बार, क़ीमत देकर, वहाँ किया जहाँ लोग देख सकते थे।',
  'Usne iske paksh mein koi dalil nahi di aur kisi se peechhe chalne ko nahi kaha. Usne ek baar, keemat dekar, wahan kiya jahan log dekh sakte the.',
  NULL, 'beginner', 'cricket,honesty,example,sport,cost'

  UNION ALL SELECT 21, 'bollywood', 7,
  'The unit that finished on time', 'वह यूनिट जो समय पर ख़त्म करती थी', 'Woh unit jo samay par khatam karti thi',
  'A film crew is known for wrapping when it said it would. This is traced by people who have worked there to one first assistant director who leaves at the stated time herself, without announcement or complaint, and who has done so for eleven years. Crews she has never worked with have picked it up from crews she has.',
  'एक फ़िल्म यूनिट इस बात के लिए जानी जाती है कि वह जब कहती है तभी पैकअप करती है। वहाँ काम कर चुके लोग इसे एक फ़र्स्ट असिस्टेंट डायरेक्टर तक ले जाते हैं जो ख़ुद तय समय पर निकल जाती हैं, बिना किसी घोषणा या शिकायत के, और ग्यारह साल से ऐसा कर रही हैं। जिन यूनिटों के साथ उन्होंने कभी काम नहीं किया, उन्होंने भी यह उन यूनिटों से उठा लिया जिनके साथ किया है।',
  'Ek film unit is baat ke liye jaani jaati hai ki woh jab kehti hai tabhi packup karti hai. Wahan kaam kar chuke log ise ek first assistant director tak le jaate hain jo khud tay samay par nikal jaati hain, bina kisi ghoshna ya shikayat ke, aur gyarah saal se aisa kar rahi hain. Jin unit ke saath unhone kabhi kaam nahi kiya, unhone bhi yeh un unit se utha liya jinke saath kiya hai.',
  'An industry that runs on nobody leaving is exactly where this verse is most visible, because the standard is set entirely by who goes first. She never argued for it. The people who copied her mostly could not say when they started, which is what the verse means by the world following the measure somebody sets.',
  'जो उद्योग इस पर चलता है कि कोई जाता ही नहीं, वहीं यह श्लोक सबसे साफ़ दिखता है, क्योंकि पैमाना पूरी तरह इससे तय होता है कि पहले कौन उठता है। उन्होंने कभी इसके पक्ष में दलील नहीं दी। जिन्होंने उनकी नक़ल की उनमें से ज़्यादातर यह नहीं बता सकते कि उन्होंने कब शुरू किया — और यही श्लोक का मतलब है कि दुनिया उसी पैमाने के पीछे चलती है जो कोई तय कर देता है।',
  'Jo udyog is par chalta hai ki koi jaata hi nahi, wahin yeh shloka sabse saaf dikhta hai, kyunki paimana poori tarah isse tay hota hai ki pehle kaun uthta hai. Unhone kabhi iske paksh mein dalil nahi di. Jinhone unki nakal ki unme se zyadatar yeh nahi bata sakte ki unhone kab shuru kiya — aur yahi shloka ka matlab hai ki duniya usi paimane ke peechhe chalti hai jo koi tay kar deta hai.',
  'In a place where nobody leaves, the standard is set entirely by whoever goes first and says nothing about it.',
  'जहाँ कोई जाता ही नहीं, वहाँ पैमाना पूरी तरह वही तय करता है जो पहले उठता है और उस पर कुछ कहता नहीं।',
  'Jahan koi jaata hi nahi, wahan paimana poori tarah wahi tay karta hai jo pehle uthta hai aur us par kuch kehta nahi.',
  NULL, 'intermediate', 'film,work,hours,example,culture'

  UNION ALL SELECT 21, 'friendship', 8,
  'The one who never repeats things', 'वह जो बातें आगे नहीं बढ़ाता', 'Woh jo baatein aage nahi badhata',
  'In a group of six friends, one has never once passed on something said in confidence. Nobody has noticed this as a quality, because the evidence for it is a long absence of events. Over about four years the group''s conversations get noticeably franker, and if asked why, none of the six would name him.',
  'छह दोस्तों के समूह में एक ने कभी भी भरोसे में कही गई बात आगे नहीं बढ़ाई। किसी ने इसे गुण की तरह नोटिस नहीं किया, क्योंकि इसका सबूत घटनाओं की एक लंबी गैरहाज़िरी है। क़रीब चार साल में समूह की बातचीत साफ़ तौर पर ज़्यादा खुली हो जाती है, और पूछा जाए तो छहों में से कोई उसका नाम नहीं लेगा।',
  'Chhah doston ke samuh mein ek ne kabhi bhi bharose mein kahi gayi baat aage nahi badhayi. Kisi ne ise gun ki tarah notice nahi kiya, kyunki iska saboot ghatnaon ki ek lambi gairhaziri hai. Karib chaar saal mein samuh ki baatchit saaf taur par zyada khuli ho jaati hai, aur poocha jaaye to chhahon mein se koi uska naam nahi lega.',
  'Standards set by absence are the hardest to see and among the strongest. Nothing happened, repeatedly, in front of five people, and the room changed shape. The verse does not require the example to be visible — only that it be consistent.',
  'गैरहाज़िरी से बने पैमाने सबसे कठिन दिखते हैं और सबसे मज़बूत होते हैं। पाँच लोगों के सामने बार-बार कुछ नहीं हुआ, और कमरे का आकार बदल गया। श्लोक यह नहीं माँगता कि उदाहरण दिखे — सिर्फ़ यह कि वह लगातार हो।',
  'Gairhaziri se bane paimane sabse mushkil dikhte hain aur sabse mazboot hote hain. Paanch logon ke saamne baar-baar kuch nahi hua, aur kamre ka aakar badal gaya. Shloka yeh nahi maangta ki udaharan dikhe — sirf yeh ki woh lagatar ho.',
  'Nothing happened, repeatedly, in front of people. That is a standard too, and one of the strongest.',
  'लोगों के सामने बार-बार कुछ नहीं हुआ। वह भी एक पैमाना है, और सबसे मज़बूत में से एक।',
  'Logon ke saamne baar-baar kuch nahi hua. Woh bhi ek paimana hai, aur sabse mazboot mein se ek.',
  NULL, 'intermediate', 'friendship,trust,discretion,example,absence'

  UNION ALL SELECT 27, 'cricket', 4,
  'The catch that stuck', 'वह कैच जो टिक गया', 'Woh catch jo tik gaya',
  'A fielder takes a spectacular catch at short leg. Slowed down, the ball hits his hand at an angle nobody could plan, off a top edge that came from a delivery the bowler admits afterwards was not the one he wanted. The fielder is on the highlights reel for a decade and can describe, if asked honestly, roughly how much of it he did.',
  'एक फ़ील्डर शॉर्ट लेग पर शानदार कैच लेता है। धीमा करके देखें तो गेंद उसके हाथ पर ऐसे कोण से लगती है जिसकी योजना कोई नहीं बना सकता, एक टॉप एज से जो उस गेंद पर आया जिसे गेंदबाज़ बाद में मानता है कि वह वैसी नहीं थी जैसी वह चाहता था। फ़ील्डर एक दशक तक हाइलाइट्स में रहता है और ईमानदारी से पूछा जाए तो बता सकता है कि उसमें उसने लगभग कितना किया।',
  'Ek fielder short leg par shandar catch leta hai. Dheema karke dekhein to gend uske haath par aise kon se lagti hai jiski yojna koi nahi bana sakta, ek top edge se jo us gend par aaya jise bowler baad mein maanta hai ki woh waisi nahi thi jaisi woh chahta tha. Fielder ek dashak tak highlights mein rehta hai aur imaandari se poocha jaaye to bata sakta hai ki usme usne lagbhag kitna kiya.',
  'The reflexes were real and years of close-catching practice were real and neither of them chose the angle. The verse is not saying he did nothing. It is saying that a great deal happened that he did not arrange, and that the highlights reel has no way of showing which was which.',
  'प्रतिवर्त सच्चे थे और सालों का क्लोज़ कैचिंग अभ्यास भी सच्चा था, और उनमें से किसी ने वह कोण नहीं चुना। श्लोक यह नहीं कह रहा कि उसने कुछ नहीं किया। वह कह रहा है कि बहुत कुछ ऐसा हुआ जो उसने जुटाया नहीं था, और हाइलाइट्स के पास यह दिखाने का कोई तरीक़ा नहीं कि कौन-सा कौन-सा था।',
  'Prativart sachche the aur saalon ka close catching abhyas bhi sachcha tha, aur unme se kisi ne woh kon nahi chuna. Shloka yeh nahi keh raha ki usne kuch nahi kiya. Woh keh raha hai ki bahut kuch aisa hua jo usne jutaya nahi tha, aur highlights ke paas yeh dikhane ka koi tareeka nahi ki kaun sa kaun sa tha.',
  'The reflexes were his. The angle was not, and the highlights reel cannot tell them apart.',
  'प्रतिवर्त उसके थे। कोण नहीं था, और हाइलाइट्स दोनों में फ़र्क़ नहीं बता सकतीं।',
  'Prativart uske the. Kon nahi tha, aur highlights dono mein farq nahi bata saktin.',
  NULL, 'beginner', 'cricket,skill,luck,credit,highlights'

  UNION ALL SELECT 27, 'startup', 5,
  'The pitch that landed in the right week', 'वह पिच जो सही हफ़्ते में पड़ी', 'Woh pitch jo sahi hafte mein padi',
  'A founder raises on the eighth pitch. The deck for the eighth was better than the first, and she had also, by then, walked into a partner who had lost a deal in the same space nine days earlier and was looking for a reason to move. She knows this because he told her, cheerfully, at the closing dinner.',
  'एक संस्थापक आठवीं पिच पर निवेश जुटा लेती हैं। आठवीं का डेक पहली से बेहतर था, और तब तक वे ऐसे पार्टनर के सामने भी पहुँच चुकी थीं जिसने नौ दिन पहले इसी क्षेत्र में एक सौदा गँवाया था और आगे बढ़ने की वजह ढूँढ़ रहा था। उन्हें यह इसलिए पता है कि उसने ही, ख़ुशी-ख़ुशी, क्लोज़िंग डिनर पर बता दिया।',
  'Ek founder aathvi pitch par nivesh juta leti hain. Aathvi ka deck pehli se behtar tha, aur tab tak woh aise partner ke saamne bhi pahunch chuki thi jisne nau din pehle isi kshetra mein ek sauda ganwaya tha aur aage badhne ki wajah dhoondh raha tha. Unhe yeh isliye pata hai ki usne hi, khushi-khushi, closing dinner par bata diya.',
  'Both things are true and only one of them will be in the story she tells at conferences. The verse is not asking her to discount the seven earlier pitches — that work is what put her in the room. It is asking her to keep the nine days in the sentence, and almost nobody does.',
  'दोनों बातें सच हैं और उनमें से एक ही उस कहानी में रहेगी जो वे सम्मेलनों में सुनाएँगी। श्लोक उनसे पहली सात पिचों को कम आँकने को नहीं कह रहा — वही मेहनत उन्हें उस कमरे तक लाई। वह कह रहा है कि उन नौ दिनों को भी वाक्य में रखिए, और लगभग कोई नहीं रखता।',
  'Dono baatein sach hain aur unme se ek hi us kahani mein rahegi jo woh conference mein sunayengi. Shloka unse pehli saat pitchon ko kam aankne ko nahi keh raha — wahi mehnat unhe us kamre tak layi. Woh keh raha hai ki un nau dinon ko bhi vakya mein rakhiye, aur lagbhag koi nahi rakhta.',
  'The seven pitches put her in the room. The nine days decided what happened in it, and only one of them makes the story.',
  'सात पिचों ने उन्हें कमरे तक पहुँचाया। नौ दिनों ने तय किया कि कमरे में क्या हुआ, और कहानी में उनमें से एक ही आता है।',
  'Saat pitchon ne unhe kamre tak pahunchaya. Nau dinon ne tay kiya ki kamre mein kya hua, aur kahani mein unme se ek hi aata hai.',
  NULL, 'intermediate', 'business,fundraising,luck,credit,timing'

  UNION ALL SELECT 27, 'ai', 6,
  'The prompt that worked', 'वह प्रॉम्प्ट जो चल गया', 'Woh prompt jo chal gaya',
  'Somebody gets a very good result from a model and saves the prompt, believing the wording did it. Run again a month later against an updated model it produces something ordinary. The wording had helped. So had the model version, the example they happened to include, and the fact that the question was well posed before it was typed.',
  'किसी को किसी मॉडल से बहुत अच्छा नतीजा मिलता है और वह प्रॉम्प्ट सहेज लेता है, यह मानकर कि शब्द ही काम कर गए। एक महीने बाद अपडेट हुए मॉडल पर दोबारा चलाने पर वह साधारण-सा कुछ देता है। शब्दों ने मदद की थी। मॉडल के संस्करण ने भी, उस उदाहरण ने भी जो संयोग से उसमें था, और इस बात ने भी कि सवाल टाइप होने से पहले ही ठीक से बना हुआ था।',
  'Kisi ko kisi model se bahut achha nateeja milta hai aur woh prompt sahej leta hai, yeh maankar ki shabd hi kaam kar gaye. Ek mahine baad update hue model par dobara chalane par woh sadharan sa kuch deta hai. Shabdon ne madad ki thi. Model ke version ne bhi, us udaharan ne bhi jo sanyog se usme tha, aur is baat ne bhi ki sawaal type hone se pehle hi theek se bana hua tha.',
  'A saved prompt is a receipt with one name on it, and this is a good place to notice the habit because the machinery is unusually easy to enumerate. Four things produced that output and the person kept one, which is exactly the move the verse describes and does not require any mysticism to see.',
  'सहेजा हुआ प्रॉम्प्ट ऐसी रसीद है जिस पर एक ही नाम है, और यह इस आदत को देखने की अच्छी जगह है क्योंकि यहाँ मशीन के पुर्ज़े असामान्य रूप से आसानी से गिने जा सकते हैं। उस नतीजे को चार चीज़ों ने बनाया और आदमी ने एक रखी — और श्लोक ठीक यही चाल बताता है, जिसे देखने के लिए किसी रहस्यवाद की ज़रूरत नहीं।',
  'Saheja hua prompt aisi receipt hai jis par ek hi naam hai, aur yeh is aadat ko dekhne ki achhi jagah hai kyunki yahan machine ke purze asamanya roop se aasani se gine ja sakte hain. Us nateeje ko chaar cheezon ne banaya aur aadmi ne ek rakhi — aur shloka theek yahi chaal batata hai, jise dekhne ke liye kisi rahasyavad ki zaroorat nahi.',
  'Four things made that output. The saved prompt is a receipt with one of them on it.',
  'उस नतीजे को चार चीज़ों ने बनाया। सहेजा हुआ प्रॉम्प्ट ऐसी रसीद है जिस पर उनमें से एक है।',
  'Us nateeje ko chaar cheezon ne banaya. Saheja hua prompt aisi receipt hai jis par unme se ek hai.',
  NULL, 'beginner', 'technology,ai,credit,causes,tools'

  UNION ALL SELECT 27, 'marriage', 7,
  'Who kept it together', 'किसने संभाले रखा', 'Kisne sambhale rakha',
  'A couple comes through a hard three years. Each of them has a private account of what got them through, and the two accounts have almost nothing in common. Neither is dishonest. Told about the other''s version, both are surprised, and one of them is briefly hurt before finding it funny.',
  'एक जोड़ा तीन कठिन साल पार कर लेता है। दोनों के पास अपना-अपना निजी बयान है कि उन्हें किस चीज़ ने पार लगाया, और दोनों बयानों में लगभग कुछ भी साझा नहीं है। कोई भी बेईमान नहीं है। दूसरे का बयान सुनकर दोनों हैरान होते हैं, और उनमें से एक थोड़ी देर के लिए आहत होता है, फिर उसे यह मज़ेदार लगने लगता है।',
  'Ek joda teen mushkil saal paar kar leta hai. Dono ke paas apna-apna niji bayan hai ki unhe kis cheez ne paar lagaya, aur dono bayanon mein lagbhag kuch bhi saajha nahi hai. Koi bhi beimaan nahi hai. Doosre ka bayan sunkar dono hairan hote hain, aur unme se ek thodi der ke liye aahat hota hai, phir use yeh mazedaar lagne lagta hai.',
  'Two people in the same house for the same three years produced two single-author versions of the same events. The verse does not say either is wrong about what they did. It says the sense of being the author attaches afterwards, quietly, and it attaches to whoever is doing the remembering.',
  'एक ही घर में, उन्हीं तीन सालों में रहे दो लोगों ने उन्हीं घटनाओं के दो इकलौते-कर्ता वाले रूप बना लिए। श्लोक यह नहीं कहता कि उनमें से कोई अपने किए के बारे में ग़लत है। वह कहता है कि कर्ता होने का भाव बाद में चुपचाप जुड़ता है, और उसी से जुड़ता है जो याद कर रहा है।',
  'Ek hi ghar mein, unhi teen saalon mein rahe do logon ne unhi ghatnaon ke do iklaute-karta wale roop bana liye. Shloka yeh nahi kehta ki unme se koi apne kiye ke baare mein galat hai. Woh kehta hai ki karta hone ka bhaav baad mein chupchap judta hai, aur usi se judta hai jo yaad kar raha hai.',
  'The sense of being the author attaches afterwards, and it attaches to whoever is doing the remembering.',
  'कर्ता होने का भाव बाद में जुड़ता है, और उसी से जुड़ता है जो याद कर रहा है।',
  'Karta hone ka bhaav baad mein judta hai, aur usi se judta hai jo yaad kar raha hai.',
  NULL, 'advanced', 'marriage,memory,credit,perspective,hard-years'

  UNION ALL SELECT 27, 'college', 8,
  'The rank and the coaching', 'रैंक और कोचिंग', 'Rank aur coaching',
  'A student gets a rank they are proud of. Contributing: two years of their own work, a school that taught the syllabus properly, parents who did not need them to earn, a coaching institute, a quiet room, and a paper that happened to be light on the one topic they were weakest at. In the interviews afterwards the coaching institute claims the rank and so, differently, does the student.',
  'एक छात्र को ऐसी रैंक मिलती है जिस पर उसे गर्व है। इसमें योगदान: उसके अपने दो साल की मेहनत, वह स्कूल जिसने पाठ्यक्रम ठीक से पढ़ाया, वे माता-पिता जिन्हें उससे कमाई की ज़रूरत नहीं थी, एक कोचिंग संस्थान, एक शांत कमरा, और एक पर्चा जो संयोग से उसी विषय पर हल्का था जिसमें वह सबसे कमज़ोर था। बाद के इंटरव्यू में कोचिंग संस्थान उस रैंक पर दावा करता है और छात्र भी, अपने तरीक़े से।',
  'Ek student ko aisi rank milti hai jis par use garv hai. Isme yogdan: uske apne do saal ki mehnat, woh school jisne syllabus theek se padhaya, woh maa-baap jinhe usse kamai ki zaroorat nahi thi, ek coaching institute, ek shaant kamra, aur ek paper jo sanyog se usi vishay par halka tha jisme woh sabse kamzor tha. Baad ke interview mein coaching institute us rank par dawa karta hai aur student bhi, apne tareeke se.',
  'Six contributions, two claimants, and the two years of work were genuinely one of the six. The verse is not deflating the student. It is pointing out that the same mechanism producing the institute''s advertisement is producing the student''s sentence, and that the quiet room does not appear in either.',
  'छह योगदान, दो दावेदार, और वे दो साल की मेहनत सचमुच उन छह में से एक थी। श्लोक छात्र को छोटा नहीं कर रहा। वह बता रहा है कि जो तंत्र संस्थान का विज्ञापन बना रहा है वही छात्र का वाक्य भी बना रहा है, और वह शांत कमरा दोनों में से किसी में नहीं आता।',
  'Chhah yogdan, do dawedar, aur woh do saal ki mehnat sach mein un chhah mein se ek thi. Shloka student ko chhota nahi kar raha. Woh bata raha hai ki jo mechanism institute ka vigyapan bana raha hai wahi student ka vakya bhi bana raha hai, aur woh shaant kamra dono mein se kisi mein nahi aata.',
  'Six things contributed. Two of them are claiming it, and the quiet room appears in neither claim.',
  'छह चीज़ों का योगदान था। उनमें से दो दावा कर रही हैं, और शांत कमरा किसी दावे में नहीं आता।',
  'Chhah cheezon ka yogdan tha. Unme se do dawa kar rahi hain, aur shaant kamra kisi dawe mein nahi aata.',
  NULL, 'intermediate', 'study,exams,credit,privilege,causes'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 3;

-- ---------------------------------------------------------------------
-- The 3.35 additions are held to the same rule as the original three:
-- every one is about somebody choosing between their own work and an
-- imitation of somebody else's. Not one of them turns on where anybody
-- came from. That boundary is what the explanation draws and the
-- examples do not get to cross it just because there are more of them.
-- ---------------------------------------------------------------------

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

  SELECT 35 AS vn, 'bollywood' AS cat, 4 AS ord,
  'The actor who was good at the wrong thing' AS t_en, 'वह अभिनेता जो ग़लत चीज़ में अच्छा था' AS t_hi, 'Woh actor jo galat cheez mein achha tha' AS t_hing,
  'A performer builds a career on a kind of role he is reliably good at and does not much like. The work is competent and it keeps coming. At forty-one he takes a small part in something nobody expects to do well, and the reviews notice something they describe as him finally being present. He cannot afford to do only that, and he does not go back to doing none of it.' AS s_en,
  'एक कलाकार ऐसे किरदारों पर करियर बनाता है जिनमें वह भरोसे से अच्छा है और जो उसे ख़ास पसंद नहीं। काम कुशल है और आता रहता है। इकतालीस की उम्र में वह ऐसी किसी चीज़ में छोटा-सा हिस्सा लेता है जिससे किसी को उम्मीद नहीं, और समीक्षाएँ कुछ ऐसा नोटिस करती हैं जिसे वे "आख़िरकार वह मौजूद है" कहती हैं। वह सिर्फ़ वही करने की हैसियत में नहीं है, और वह उसे बिलकुल न करने पर भी नहीं लौटता।' AS s_hi,
  'Ek kalakar aise kirdaron par career banata hai jinme woh bharose se achha hai aur jo use khaas pasand nahi. Kaam kushal hai aur aata rehta hai. Iktalis ki umar mein woh aisi kisi cheez mein chhota sa hissa leta hai jisse kisi ko ummeed nahi, aur samikshayein kuch aisa notice karti hain jise woh "aakhirkar woh maujood hai" kehti hain. Woh sirf wahi karne ki haisiyat mein nahi hai, aur woh use bilkul na karne par bhi nahi lautta.' AS s_hing,
  'The verse is about imitation, not about origins, and this is what the distinction looks like in a career. Nothing about where he came from is in this story. What is in it is fifteen years of doing somebody else''s kind of work competently, and the fact that competence never once made it his.' AS c_en,
  'श्लोक नक़ल के बारे में है, जड़ों के बारे में नहीं, और करियर में यह फ़र्क़ ऐसा दिखता है। इस कहानी में इस बात का कोई ज़िक्र नहीं कि वह कहाँ से आया। इसमें जो है वह पंद्रह साल किसी और तरह का काम कुशलता से करना है, और यह कि कुशलता ने उसे एक बार भी उसका अपना नहीं बनाया।' AS c_hi,
  'Shloka nakal ke baare mein hai, jadon ke baare mein nahi, aur career mein yeh farq aisa dikhta hai. Is kahani mein is baat ka koi zikr nahi ki woh kahan se aaya. Isme jo hai woh pandrah saal kisi aur tarah ka kaam kushalta se karna hai, aur yeh ki kushalta ne use ek baar bhi uska apna nahi banaya.' AS c_hing,
  'Fifteen years of doing it well never once made it his. Competence is not ownership.' AS l_en,
  'पंद्रह साल अच्छा करने से वह एक बार भी उसका अपना नहीं हुआ। कुशलता मालिकाना नहीं है।' AS l_hi,
  'Pandrah saal achha karne se woh ek baar bhi uska apna nahi hua. Kushalta malikana nahi hai.' AS l_hing,
  NULL AS src, 'intermediate' AS diff, 'film,career,imitation,work,identity' AS tags

  UNION ALL SELECT 35, 'everyday_life', 5,
  'The hobby that was somebody else''s', 'वह शौक़ जो किसी और का था', 'Woh shauk jo kisi aur ka tha',
  'Two friends take up running together. One of them loves it. The other keeps at it for three years, is faster, and quietly dreads Sundays. In the fourth year she stops running and starts swimming, badly, and is happier in a way that she finds slightly embarrassing to explain given how much worse she is at it.',
  'दो दोस्त साथ दौड़ना शुरू करते हैं। एक को यह बहुत पसंद है। दूसरी तीन साल लगी रहती है, ज़्यादा तेज़ है, और चुपचाप रविवार से डरती है। चौथे साल वह दौड़ना छोड़कर तैरना शुरू करती है, बुरी तरह, और ऐसे तरीक़े से ज़्यादा ख़ुश है जिसे बताने में उसे हल्की झेंप होती है, यह देखते हुए कि वह इसमें कितनी कमज़ोर है।',
  'Do dost saath daudna shuru karte hain. Ek ko yeh bahut pasand hai. Doosri teen saal lagi rehti hai, zyada tez hai, aur chupchap Sunday se darti hai. Chauthe saal woh daudna chhodkar tairna shuru karti hai, buri tarah, aur aise tareeke se zyada khush hai jise batane mein use halki jhenp hoti hai, yeh dekhte hue ki woh isme kitni kamzor hai.',
  'This is the verse in miniature and with nothing at stake, which is the best way to meet it first. Her own thing done badly beat somebody else''s thing done well, and she had three years of evidence that being faster settled nothing.',
  'यह श्लोक छोटे रूप में है और यहाँ कोई बड़ा दाँव नहीं — और पहली बार इससे मिलने का यही सबसे अच्छा तरीक़ा है। अपनी चीज़ अधूरे ढंग से किसी और की चीज़ कुशलता से करने से बेहतर निकली, और उसके पास तीन साल का सबूत था कि ज़्यादा तेज़ होने से कुछ तय नहीं होता।',
  'Yeh shloka chhote roop mein hai aur yahan koi bada daanv nahi — aur pehli baar isse milne ka yahi sabse achha tareeka hai. Apni cheez adhoore dhang se kisi aur ki cheez kushalta se karne se behtar nikli, aur uske paas teen saal ka saboot tha ki zyada tez hone se kuch tay nahi hota.',
  'She was faster at the one she dreaded. Three years of being better at it settled nothing.',
  'जिससे वह डरती थी उसमें वह ज़्यादा तेज़ थी। तीन साल बेहतर होने से कुछ तय नहीं हुआ।',
  'Jisse woh darti thi usme woh zyada tez thi. Teen saal behtar hone se kuch tay nahi hua.',
  NULL, 'beginner', 'habits,hobbies,friends,choice,honesty'

  UNION ALL SELECT 35, 'friendship', 6,
  'Advice from somebody it worked for', 'उससे मिली सलाह जिस पर यह चला', 'Usse mili salah jis par yeh chala',
  'A friend who took a particular route and did well from it gives that advice generously and often. It is honest advice and it is working advice — for him. A third person follows it for two years and it does not take, and he spends most of those two years assuming the problem is that he is not trying hard enough.',
  'एक दोस्त जिसने कोई ख़ास रास्ता लिया और उससे अच्छा किया, वही सलाह खुले दिल से और बार-बार देता है। सलाह ईमानदार है और चलने वाली भी — उसके लिए। एक तीसरा व्यक्ति दो साल उस पर चलता है और बात बैठती नहीं, और वह उन दो सालों का ज़्यादातर हिस्सा यह मानते हुए बिताता है कि दिक़्क़त यह है कि वह पूरी कोशिश नहीं कर रहा।',
  'Ek dost jisne koi khaas rasta liya aur usse achha kiya, wahi salah khule dil se aur baar-baar deta hai. Salah imaandar hai aur chalne wali bhi — uske liye. Ek teesra insaan do saal us par chalta hai aur baat baithti nahi, aur woh un do saalon ka zyadatar hissa yeh maante hue bitata hai ki dikkat yeh hai ki woh poori koshish nahi kar raha.',
  'Nobody is behaving badly. The advice is good and it is somebody else''s, and the two years went into an imitation performed sincerely. The verse''s hardest part is that the imitation is often the sensible-looking option, recommended by somebody who means well and has the results to prove it.',
  'यहाँ कोई बुरा बरताव नहीं कर रहा। सलाह अच्छी है और किसी और की है, और वे दो साल एक ईमानदारी से निभाई गई नक़ल में गए। श्लोक का सबसे कठिन हिस्सा यही है कि नक़ल अक्सर समझदारी वाला दिखने वाला विकल्प होती है, और उसकी सिफ़ारिश वह करता है जिसकी नीयत साफ़ है और जिसके पास नतीजे भी हैं।',
  'Yahan koi bura bartav nahi kar raha. Salah achhi hai aur kisi aur ki hai, aur woh do saal ek imaandari se nibhayi gayi nakal mein gaye. Shloka ka sabse mushkil hissa yahi hai ki nakal aksar samajhdari wala dikhne wala option hoti hai, aur uski sifarish woh karta hai jiski niyat saaf hai aur jiske paas nateeje bhi hain.',
  'The imitation is usually the sensible-looking option, recommended by somebody who means well and has the results.',
  'नक़ल आमतौर पर समझदारी वाला दिखने वाला विकल्प होती है, जिसकी सिफ़ारिश वह करता है जिसकी नीयत अच्छी है और नतीजे भी।',
  'Nakal aam taur par samajhdari wala dikhne wala option hoti hai, jiski sifarish woh karta hai jiski niyat achhi hai aur nateeje bhi.',
  NULL, 'intermediate', 'friendship,advice,imitation,work,choice'

  UNION ALL SELECT 35, 'healthcare', 7,
  'The specialty that fit', 'वह विशेषज्ञता जो जँची', 'Woh specialty jo janchi',
  'A doctor two years into a prestigious specialty is competent and unwell. She moves to one with less status, longer relationships with patients and no dramatic days, taking a pay cut and a certain amount of comment. Eight years later she is regarded as unusually good at it, which she was not on track to be at the other thing.',
  'एक डॉक्टर दो साल से एक प्रतिष्ठित विशेषज्ञता में हैं, कुशल हैं और ठीक नहीं हैं। वे कम रुतबे वाली, मरीज़ों से लंबे रिश्तों वाली और बिना नाटकीय दिनों वाली विशेषज्ञता में चली जाती हैं, तनख़्वाह में कटौती और कुछ बातें सहते हुए। आठ साल बाद उन्हें उसमें असामान्य रूप से अच्छा माना जाता है, जो वे पहली वाली में होने के रास्ते पर नहीं थीं।',
  'Ek doctor do saal se ek pratishthit specialty mein hain, kushal hain aur theek nahi hain. Woh kam rutbe wali, marizon se lambe rishton wali aur bina natakiya dinon wali specialty mein chali jaati hain, tankhwah mein katauti aur kuch baatein sehte hue. Aath saal baad unhe usme asamanya roop se achha maana jaata hai, jo woh pehli wali mein hone ke raste par nahi thi.',
  'Svadharma is discovered rather than assigned, and this is what discovering it costs and pays. She did not find out by thinking; she found out by two years of being competent and unwell, which is the only instrument most people get.',
  'स्वधर्म सौंपा नहीं जाता, खोजा जाता है — और खोजने की क़ीमत और उसका फल यही है। उन्होंने यह सोचकर नहीं जाना; उन्होंने दो साल कुशल और अस्वस्थ रहकर जाना, और ज़्यादातर लोगों को यही इकलौता उपकरण मिलता है।',
  'Svadharma saunpa nahi jaata, khoja jaata hai — aur khojne ki keemat aur uska phal yahi hai. Unhone yeh sochkar nahi jaana; unhone do saal kushal aur aswasth rehkar jaana, aur zyadatar logon ko yahi iklauta upkaran milta hai.',
  'She did not find out by thinking. Two years of being competent and unwell is the instrument most people get.',
  'उन्होंने सोचकर नहीं जाना। दो साल कुशल और अस्वस्थ रहना ही वह उपकरण है जो ज़्यादातर लोगों को मिलता है।',
  'Unhone sochkar nahi jaana. Do saal kushal aur aswasth rehna hi woh upkaran hai jo zyadatar logon ko milta hai.',
  NULL, 'intermediate', 'health,career,choice,status,discovery'

  UNION ALL SELECT 35, 'technology', 8,
  'The manager who went back to building', 'वह मैनेजर जो बनाने पर लौट आई', 'Woh manager jo banane par laut aayi',
  'An engineer promoted into management is adequate at it for two years and misses building in a way she can describe precisely. Moving back is available and reads, to her, as a demotion. She does it. Her new team lead is somebody she used to manage, and the first month is as awkward as she expected and the second is not.',
  'प्रबंधन में भेजी गई एक इंजीनियर दो साल उसमें ठीक-ठाक रहती हैं और बनाने की कमी ऐसे महसूस करती हैं जिसे वे ठीक-ठीक बता सकती हैं। वापस जाना उपलब्ध है और उन्हें पदावनति जैसा लगता है। वे चली जाती हैं। उनकी नई टीम लीड वही हैं जिन्हें वे कभी संभालती थीं, और पहला महीना उतना ही असहज है जितना उन्होंने सोचा था और दूसरा नहीं है।',
  'Prabandhan mein bheji gayi ek engineer do saal usme theek-thaak rehti hain aur banane ki kami aise mehsoos karti hain jise woh theek-theek bata sakti hain. Wapas jaana uplabdh hai aur unhe demotion jaisa lagta hai. Woh chali jaati hain. Unki nayi team lead wahi hain jinhe woh kabhi sambhalti thi, aur pehla mahina utna hi asahaj hai jitna unhone socha tha aur doosra nahi hai.',
  'The verse says the imitation performed competently is the worse of the two options, and it does not say the move into it was stupid. The ladder had one shape and she followed it, which was reasonable. What it did not do was make management hers, and two years was long enough to establish that going back is not the same as going down.',
  'श्लोक कहता है कि कुशलता से निभाई गई नक़ल दोनों में बुरा विकल्प है, और वह यह नहीं कहता कि उसमें जाना बेवक़ूफ़ी थी। सीढ़ी का एक आकार था और वे उस पर चलीं, जो वाजिब था। उससे प्रबंधन उनका नहीं हो गया, और दो साल यह साबित करने के लिए काफ़ी थे कि वापस जाना और नीचे जाना एक बात नहीं है।',
  'Shloka kehta hai ki kushalta se nibhayi gayi nakal dono mein bura option hai, aur woh yeh nahi kehta ki usme jaana bewakoofi thi. Seedhi ka ek aakar tha aur woh us par chali, jo waajib tha. Usse prabandhan unka nahi ho gaya, aur do saal yeh sabit karne ke liye kaafi the ki wapas jaana aur neeche jaana ek baat nahi hai.',
  'Going back is not the same as going down, and two years of being adequate is enough evidence.',
  'वापस जाना नीचे जाना नहीं है, और दो साल ठीक-ठाक रहना इसका काफ़ी सबूत है।',
  'Wapas jaana neeche jaana nahi hai, aur do saal theek-thaak rehna iska kaafi saboot hai.',
  NULL, 'intermediate', 'work,career,management,imitation,choice'

  UNION ALL SELECT 37, 'cricket', 4,
  'The shot he had promised not to play', 'वह शॉट जो उसने न खेलने का वादा किया था', 'Woh shot jo usne na khelne ka wada kiya tha',
  'A batsman is out to the same stroke four innings running and tells the coach, meaning it, that he is not playing it again. In the fifth innings, on 38, a short ball arrives at the exact height and he plays it. He is back in the pavilion before the decision he made in the nets has finished being remembered.',
  'एक बल्लेबाज़ लगातार चार पारियों में उसी शॉट पर आउट होता है और कोच से, सच्चे मन से, कहता है कि वह इसे दोबारा नहीं खेलेगा। पाँचवीं पारी में, 38 पर, ठीक उसी ऊँचाई पर छोटी गेंद आती है और वह खेल देता है। नेट में लिया गया फ़ैसला पूरी तरह याद आने से पहले ही वह पवेलियन में है।',
  'Ek batsman lagatar chaar pariyon mein usi shot par out hota hai aur coach se, sachche man se, kehta hai ki woh ise dobara nahi khelega. Paanchvi paari mein, 38 par, theek usi oonchai par chhoti gend aati hai aur woh khel deta hai. Net mein liya gaya faisla poori tarah yaad aane se pehle hi woh pavilion mein hai.',
  'Naming the appetite is not the same as being free of it, and the verse is unsentimental about the gap. Kama at that speed is not a decision he lost — it arrived before deciding was available. Which is exactly why the useful work happens in the nets, on the trigger movement, and not in the promise.',
  'भूख का नाम रख देना उससे मुक्त हो जाना नहीं है, और श्लोक इस फ़ासले पर भावुक नहीं होता। उस रफ़्तार पर काम कोई फ़ैसला नहीं है जो वह हार गया — वह तय करने का मौक़ा आने से पहले पहुँच गया। और इसीलिए काम की मेहनत नेट में, ट्रिगर मूवमेंट पर होती है, वादे में नहीं।',
  'Bhookh ka naam rakh dena usse mukt ho jaana nahi hai, aur shloka is faasle par bhavuk nahi hota. Us raftar par kaam koi faisla nahi hai jo woh haar gaya — woh tay karne ka mauka aane se pehle pahunch gaya. Aur isiliye kaam ki mehnat net mein, trigger movement par hoti hai, wade mein nahi.',
  'It arrived before deciding was available. That is why the work happens in the nets and not in the promise.',
  'वह तय करने का मौक़ा आने से पहले पहुँच गया। इसीलिए मेहनत नेट में होती है, वादे में नहीं।',
  'Woh tay karne ka mauka aane se pehle pahunch gaya. Isiliye mehnat net mein hoti hai, wade mein nahi.',
  NULL, 'intermediate', 'cricket,habit,impulse,practice,discipline'

  UNION ALL SELECT 37, 'marriage', 5,
  'The row about the holiday', 'छुट्टी वाला झगड़ा', 'Chhutti wala jhagda',
  'A disagreement about where to go in April becomes, within twenty minutes, about something from two years ago. Both people can see it happening and neither can stop it. Afterwards one of them traces it back accurately: she had wanted the other to be pleased about a small piece of news from that morning, was not asked about it, and said nothing.',
  'अप्रैल में कहाँ जाना है, इस असहमति के बीस मिनट में ही यह दो साल पुरानी किसी बात पर आ जाती है। दोनों को यह होते हुए दिख रहा है और दोनों में से कोई रोक नहीं पा रहा। बाद में उनमें से एक इसे सही-सही पीछे तक जोड़ पाती है: वह चाहती थी कि उस सुबह की एक छोटी ख़बर पर दूसरा ख़ुश हो, उससे पूछा नहीं गया, और उसने कहा कुछ नहीं।',
  'April mein kahan jaana hai, is asahmati ke bees minute mein hi yeh do saal purani kisi baat par aa jaati hai. Dono ko yeh hote hue dikh raha hai aur dono mein se koi rok nahi paa raha. Baad mein unme se ek ise sahi-sahi peechhe tak jod paati hai: woh chahti thi ki us subah ki ek chhoti khabar par doosra khush ho, usse poocha nahi gaya, aur usne kaha kuch nahi.',
  'Wanting and anger as one thing with two faces, and the twenty minutes are the join. The anger arrived wearing a subject it had nothing to do with, which is what the verse describes, and the actual want was small enough that saying it out loud in the morning would have taken nine seconds.',
  'चाह और गुस्सा एक ही चीज़ के दो चेहरे, और वे बीस मिनट ही जोड़ हैं। गुस्सा ऐसा विषय ओढ़कर आया जिससे उसका कोई लेना-देना नहीं था — और श्लोक यही बताता है — और असली चाह इतनी छोटी थी कि सुबह उसे कह देने में नौ सेकंड लगते।',
  'Chaah aur gussa ek hi cheez ke do chehre, aur woh bees minute hi jod hain. Gussa aisa vishay odhkar aaya jisse uska koi lena-dena nahi tha — aur shloka yahi batata hai — aur asli chaah itni chhoti thi ki subah use keh dene mein nau second lagte.',
  'The actual want was small enough to say in nine seconds. Unsaid, it took twenty minutes and two years of material.',
  'असली चाह इतनी छोटी थी कि नौ सेकंड में कही जा सकती थी। न कही गई, तो उसने बीस मिनट और दो साल का सामान ले लिया।',
  'Asli chaah itni chhoti thi ki nau second mein kahi ja sakti thi. Na kahi gayi, to usne bees minute aur do saal ka saamaan le liya.',
  NULL, 'intermediate', 'marriage,anger,desire,communication,arguments'

  UNION ALL SELECT 37, 'ai', 6,
  'One more generation', 'एक और बार', 'Ek aur baar',
  'Somebody generating images for a small project has a usable result at attempt six. They run attempt seven because seven might be better. At attempt thirty-one they are choosing between images they can no longer tell apart, and the thing they liked about number six has been gone for about fifteen attempts.',
  'किसी छोटे काम के लिए तस्वीरें बना रहे व्यक्ति के पास छठी कोशिश पर काम लायक नतीजा है। वह सातवीं चलाता है क्योंकि सातवीं बेहतर हो सकती है। इकतीसवीं पर वह ऐसी तस्वीरों में से चुन रहा है जिनमें अब फ़र्क़ ही नहीं बता सकता, और छठी में जो उसे अच्छा लगा था वह क़रीब पंद्रह कोशिशों से ग़ायब है।',
  'Kisi chhote kaam ke liye tasveerein bana rahe insaan ke paas chhathi koshish par kaam layak nateeja hai. Woh saatvi chalata hai kyunki saatvi behtar ho sakti hai. Ikatisvi par woh aisi tasveeron mein se chun raha hai jinme ab farq hi nahi bata sakta, aur chhathi mein jo use achha laga tha woh karib pandrah koshishon se gayab hai.',
  'Mahashana — great-eating, never filling up — with a button attached and no marginal cost. The verse says satisfying the appetite is the mechanism by which it continues, and a generate button is the cleanest demonstration anybody has built: each result is a small satisfaction and each one makes the next attempt more likely, not less.',
  'महाशन — बहुत खाने वाला, कभी न भरने वाला — जिसके साथ एक बटन जुड़ा है और कोई अतिरिक्त लागत नहीं। श्लोक कहता है कि भूख का तृप्त होना ही उसके चलते रहने का तरीक़ा है, और जनरेट बटन इसका सबसे साफ़ प्रदर्शन है जो किसी ने बनाया: हर नतीजा एक छोटी तृप्ति है और हर एक अगली कोशिश को कम नहीं, ज़्यादा संभव बनाता है।',
  'Mahashana — bahut khaane wala, kabhi na bharne wala — jiske saath ek button juda hai aur koi extra laagat nahi. Shloka kehta hai ki bhookh ka tript hona hi uske chalte rehne ka tareeka hai, aur generate button iska sabse saaf pradarshan hai jo kisi ne banaya: har nateeja ek chhoti tripti hai aur har ek agli koshish ko kam nahi, zyada sambhav banata hai.',
  'Each result is a small satisfaction, and each one makes the next attempt more likely rather than less.',
  'हर नतीजा एक छोटी तृप्ति है, और हर एक अगली कोशिश को कम नहीं, ज़्यादा संभव बनाता है।',
  'Har nateeja ek chhoti tripti hai, aur har ek agli koshish ko kam nahi, zyada sambhav banata hai.',
  NULL, 'beginner', 'technology,ai,desire,iteration,enough'

  UNION ALL SELECT 37, 'everyday_life', 7,
  'The second helping', 'दूसरी बार', 'Doosri baar',
  'Somebody is full and takes more anyway, at a table where the food is good and the company is easy. There is no distress in this and no crisis. They notice, mildly, that they stopped wanting it about four mouthfuls before they stopped taking it, and that the noticing did not change anything.',
  'किसी का पेट भर चुका है और वह फिर भी और ले लेता है, ऐसी मेज़ पर जहाँ खाना अच्छा है और साथ आरामदेह। इसमें कोई तकलीफ़ नहीं है और कोई संकट नहीं। उसे हल्के से ध्यान आता है कि चाह उसने लेना बंद करने से क़रीब चार कौर पहले ख़त्म कर दी थी, और उस ध्यान से कुछ बदला नहीं।',
  'Kisi ka pet bhar chuka hai aur woh phir bhi aur le leta hai, aisi mez par jahan khana achha hai aur saath aaramdeh. Isme koi takleef nahi hai aur koi sankat nahi. Use halke se dhyan aata hai ki chaah usne lena band karne se karib chaar kaur pehle khatam kar di thi, aur us dhyan se kuch badla nahi.',
  'The verse names an enemy and this example is deliberately not one. Most encounters with the mechanism are this size — mild, harmless, and instructive precisely because nothing is at stake. The gap between stopping wanting and stopping taking is where the whole thing lives, and it is easiest to measure at a good dinner.',
  'श्लोक एक दुश्मन का नाम लेता है और यह उदाहरण जानबूझकर वैसा नहीं है। इस तंत्र से ज़्यादातर मुलाक़ातें इसी आकार की होती हैं — हल्की, बेज़रर, और सीखने लायक ठीक इसलिए कि कोई दाँव नहीं है। चाहना बंद होने और लेना बंद होने के बीच का फ़ासला ही वह जगह है जहाँ यह पूरी चीज़ रहती है, और उसे नापना किसी अच्छे खाने पर सबसे आसान है।',
  'Shloka ek dushman ka naam leta hai aur yeh udaharan jaanboojhkar waisa nahi hai. Is mechanism se zyadatar mulaqatein isi aakar ki hoti hain — halki, bezarar, aur seekhne layak theek isliye ki koi daanv nahi hai. Chahna band hone aur lena band hone ke beech ka faasla hi woh jagah hai jahan yeh poori cheez rehti hai, aur use naapna kisi achhe khaane par sabse aasan hai.',
  'The gap between stopping wanting and stopping taking is the whole thing, and dinner is the easiest place to measure it.',
  'चाहना बंद होने और लेना बंद होने के बीच का फ़ासला ही पूरी बात है, और उसे नापने की सबसे आसान जगह खाने की मेज़ है।',
  'Chahna band hone aur lena band hone ke beech ka faasla hi poori baat hai, aur use naapne ki sabse aasan jagah khaane ki mez hai.',
  NULL, 'beginner', 'food,desire,noticing,ordinary,enough'

  UNION ALL SELECT 37, 'healthcare', 8,
  'The last cigarette, several times', 'आख़िरी सिगरेट, कई बार', 'Aakhiri cigarette, kai baar',
  'Somebody quitting smoking succeeds for eleven weeks and then does not. What they describe afterwards is not craving in the way they expected — it is that a particular kind of bad afternoon produced a completely reasonable-sounding thought, and that the thought did not feel like wanting. It felt like a conclusion.',
  'धूम्रपान छोड़ रहा कोई ग्यारह हफ़्ते सफल रहता है और फिर नहीं। वह बाद में जो बताता है वह वैसी तलब नहीं है जैसी उसने सोची थी — बात यह है कि एक ख़ास तरह की बुरी दोपहर ने एक पूरी तरह वाजिब लगने वाला ख़याल पैदा किया, और वह ख़याल चाह जैसा महसूस ही नहीं हुआ। वह निष्कर्ष जैसा लगा।',
  'Dhoomrapan chhod raha koi gyarah hafte safal rehta hai aur phir nahi. Woh baad mein jo batata hai woh waisi talab nahi hai jaisi usne sochi thi — baat yeh hai ki ek khaas tarah ki buri dopahar ne ek poori tarah waajib lagne wala khayal paida kiya, aur woh khayal chaah jaisa mehsoos hi nahi hua. Woh nishkarsh jaisa laga.',
  'This is why the verse calls it an enemy rather than a weakness, and the distinction is practical rather than dramatic. A weakness is something you feel losing. This arrives already dressed as a reasonable conclusion, at a moment chosen for it, and the person is not aware of negotiating.',
  'इसीलिए श्लोक इसे कमज़ोरी नहीं, दुश्मन कहता है — और यह फ़र्क़ नाटकीय नहीं, काम का है। कमज़ोरी वह है जिसे आप हारते हुए महसूस करते हैं। यह पहले से एक वाजिब निष्कर्ष का कपड़ा पहनकर आता है, ऐसे क्षण में जो इसी के लिए चुना गया है, और आदमी को पता ही नहीं चलता कि मोलभाव हो रहा है।',
  'Isiliye shloka ise kamzori nahi, dushman kehta hai — aur yeh farq natakiya nahi, kaam ka hai. Kamzori woh hai jise tum haarte hue mehsoos karte ho. Yeh pehle se ek waajib nishkarsh ka kapda pehankar aata hai, aise pal mein jo isi ke liye chuna gaya hai, aur aadmi ko pata hi nahi chalta ki mol-bhaav ho raha hai.',
  'It does not arrive as wanting. It arrives already dressed as a reasonable conclusion.',
  'यह चाह बनकर नहीं आता। यह पहले से वाजिब निष्कर्ष का कपड़ा पहनकर आता है।',
  'Yeh chaah bankar nahi aata. Yeh pehle se waajib nishkarsh ka kapda pehankar aata hai.',
  NULL, 'advanced', 'health,habits,quitting,desire,self-deception'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 3;
