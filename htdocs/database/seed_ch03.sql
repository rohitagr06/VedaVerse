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
