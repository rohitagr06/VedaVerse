-- =====================================================================
-- VedaVerse — database/seed_ch06.sql
-- =====================================================================
-- Chapter 6, Ātma Saṁyama Yoga. Eight verses. First chapter of the
-- INTERMEDIATE track, which app.php already lists as
-- 2, 3, 4, 5, 6, 12, 13, 14, 16, 17, 18 — PathService skips the ones
-- not yet published, so this chapter joins the path on load with no
-- config change.
--
--   6.5   lift yourself by yourself; you are your own friend or enemy
--   6.6   which of the two, and what it depends on
--   6.17  the middle in eating, moving, working, sleeping
--   6.19  a lamp in a windless place
--   6.26  wherever it wanders off to, bring it back
--   6.34  Arjuna: the mind is as hard to hold as the wind
--   6.35  Krishna: agreed. Practice, and letting go of the grip
--   6.40  nobody who does good comes to a bad end
--
-- TWO CARE POINTS, AND BOTH ARE ABOUT THE READER RATHER THAN THE TEXT
--
--   6.5 AND 6.6 — "YOU ARE YOUR OWN ENEMY"
--     Handed to somebody who is depressed, this reads as "your
--     suffering is your own fault and you are failing to fix it". That
--     is not what the verse says and it is a foreseeable way to be
--     hurt by it, so the explanation says so directly rather than
--     leaving it to land wrong. The verse is about where leverage
--     is — that a person is not only acted upon — and a claim about
--     leverage is not a claim about blame. Both explanations carry
--     that sentence, and the beginner one carries it first.
--
--   6.17 — MODERATION, AND NOT GIVING ANYBODY A RESTRICTION SCRIPT
--     A verse about being measured in food and sleep can be read as
--     licence by somebody already restricting. The verse itself is the
--     defence: 6.16 rules out BOTH extremes by name — not for the one
--     who eats too much, and not for the one who does not eat — and
--     6.17 asks for yukta, fitted, in four things at once. The
--     explanation keeps both halves and never presents less as safer.
--     It also does not offer amounts, because it has none to offer.
--
-- 6.34 IS WHY THIS CHAPTER IS WORTH TEACHING
--   Arjuna interrupts to say the instruction is impossible. Krishna's
--   answer begins asaṁśayam — no doubt about it, you are right — and
--   only then gives the method. A text that concedes the difficulty
--   before answering it is a text a beginner can trust.
--
-- CONTENT RULES — unchanged
--   Original writing throughout. Sanskrit unaltered, numbering
--   untouched. No praise or criticism of any living politician, party
--   or movement. No communal framing. No amounts, targets or regimens
--   anywhere in this file.
--
-- RUN AFTER seed_sample.sql. Re-runnable.
--
--     mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
--         < htdocs/database/seed_ch06.sql
--
-- global_order is 233 + verse_number: chapters 1 to 5 have 233 verses
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

  SELECT 5 AS verse_number, 238 AS global_order, 1 AS is_curated, 'gita-6-5' AS slug,
    'उद्धरेदात्मनात्मानं नात्मानमवसादयेत्।\nआत्मैव ह्यात्मनो बन्धुरात्मैव रिपुरात्मनः॥' AS sanskrit_devanagari,
    'uddhared ātmanātmānaṁ nātmānam avasādayet\nātmaiva hy ātmano bandhur ātmaiva ripur ātmanaḥ' AS transliteration_iast,
    'uddhared atmanatmanam natmanam avasadayet\natmaiva hy atmano bandhur atmaiva ripur atmanah' AS transliteration_simple,
    'One should lift oneself by oneself; one should not let oneself sink. For the self alone is the friend of the self, and the self alone is the enemy of the self.' AS translation_literal,
    'Pull yourself up, using yourself. Do not let yourself go under. The same person is the only friend you have in there, and the only opponent.' AS translation_en,
    'ख़ुद को ऊपर खींचिए, ख़ुद से। ख़ुद को डूबने मत दीजिए। भीतर वही एक आदमी आपका इकलौता दोस्त है, और इकलौता विरोधी भी।' AS translation_hi,
    'Khud ko upar kheencho, khud se. Khud ko doobne mat do. Bheetar wahi ek aadmi tumhara iklauta dost hai, aur iklauta virodhi bhi.' AS translation_hinglish,
    'A claim about where the leverage is. Not a claim about whose fault anything is.' AS summary_en,
    'यह इस बारे में दावा है कि ज़ोर कहाँ लगता है। इस बारे में नहीं कि दोष किसका है।' AS summary_hi,
    'Yeh is baare mein dawa hai ki zor kahan lagta hai. Is baare mein nahi ki dosh kiska hai.' AS summary_hinglish,
    'intermediate' AS difficulty,
    'Gita 6.5: your own friend and your own opponent' AS seo_title,
    'The Bhagavad Gita says a person can lift themselves and can also let themselves sink. It is a claim about leverage, not about blame.' AS seo_description,
    1 AS published

  UNION ALL SELECT 6, 239, 1, 'gita-6-6',
    'बन्धुरात्मात्मनस्तस्य येनात्मैवात्मना जितः।\nअनात्मनस्तु शत्रुत्वे वर्तेतात्मैव शत्रुवत्॥',
    'bandhur ātmātmanas tasya yenātmaivātmanā jitaḥ\nanātmanas tu śatrutve vartetātmaiva śatru-vat',
    'bandhur atmatmanas tasya yenatmaivatmana jitah\nanatmanas tu shatrutve vartetatmaiva shatru-vat',
    'For one by whom the self has been conquered by the self, the self is the friend of the self. But for one who has not, the self remains in enmity, like an enemy.',
    'Which of the two you get depends on one thing, and the verse says it flatly: whether the person has got any purchase on themselves at all. Where they have, it works with them. Where they have not, it works against them, and it does not need to be malicious to do that.',
    'दोनों में से कौन-सा मिलेगा, यह एक ही बात पर टिका है, और श्लोक इसे सीधे कह देता है: उस व्यक्ति को अपने ऊपर कोई पकड़ मिली है या नहीं। जहाँ मिली है, वह उसके साथ काम करता है। जहाँ नहीं मिली, वह उसके ख़िलाफ़ काम करता है — और ऐसा करने के लिए उसका दुर्भावी होना ज़रूरी नहीं।',
    'Dono mein se kaun sa milega, yeh ek hi baat par tika hai, aur shloka ise seedhe keh deta hai: us insaan ko apne upar koi pakad mili hai ya nahi. Jahan mili hai, woh uske saath kaam karta hai. Jahan nahi mili, woh uske khilaf kaam karta hai — aur aisa karne ke liye uska durbhavi hona zaroori nahi.',
    'The enemy version is not hostile. It is just unattended, and unattended is enough.',
    'दुश्मन वाला रूप शत्रुतापूर्ण नहीं है। वह बस बिना देखभाल के है, और बिना देखभाल के होना काफ़ी है।',
    'Dushman wala roop shatrutapurn nahi hai. Woh bas bina dekhbhal ke hai, aur bina dekhbhal ke hona kaafi hai.',
    'intermediate',
    'Gita 6.6: unattended is enough to be working against you',
    'The Bhagavad Gita says the same self is friend or enemy depending on whether you have any purchase on it. The enemy version is not hostile, only unattended.',
    1

  UNION ALL SELECT 17, 250, 1, 'gita-6-17',
    'युक्ताहारविहारस्य युक्तचेष्टस्य कर्मसु।\nयुक्तस्वप्नावबोधस्य योगो भवति दुःखहा॥',
    'yuktāhāra-vihārasya yukta-ceṣṭasya karmasu\nyukta-svapnāvabodhasya yogo bhavati duḥkha-hā',
    'yuktahara-viharasya yukta-cheshtasya karmasu\nyukta-svapnavabodhasya yogo bhavati duhkha-ha',
    'For one who is measured in eating and moving about, measured in effort in actions, measured in sleeping and waking — yoga becomes the destroyer of sorrow.',
    'Fitted in what you eat and how you move. Fitted in how much you put into things. Fitted in sleeping and getting up. For that person the practice takes sorrow away — and the verse before this one names both ways to get it wrong, not one.',
    'जो आप खाते हैं और जैसे चलते-फिरते हैं, उसमें ठीक-ठीक। किसी काम में कितना लगाते हैं, उसमें ठीक-ठीक। सोने और उठने में ठीक-ठीक। ऐसे व्यक्ति के लिए यह अभ्यास दुख हर लेता है — और इससे पहले वाला श्लोक ग़लत होने के दोनों तरीक़े गिनाता है, एक नहीं।',
    'Jo tum khaate ho aur jaise chalte-firte ho, usme theek-theek. Kisi kaam mein kitna lagate ho, usme theek-theek. Sone aur uthne mein theek-theek. Aise insaan ke liye yeh abhyas dukh har leta hai — aur isse pehle wala shloka galat hone ke dono tareeke ginata hai, ek nahi.',
    'Yukta means fitted, not minimal. The verse before it rules out too little as loudly as too much.',
    'युक्त का मतलब है ठीक बैठा हुआ, कम नहीं। इससे पहले वाला श्लोक "बहुत कम" को उतनी ही ज़ोर से ख़ारिज करता है जितना "बहुत ज़्यादा" को।',
    'Yukta ka matlab hai theek baitha hua, kam nahi. Isse pehle wala shloka "bahut kam" ko utni hi zor se khaarij karta hai jitna "bahut zyada" ko.',
    'beginner',
    'Gita 6.17: fitted, not minimal',
    'The Bhagavad Gita asks for measure in eating, moving, working and sleeping. The verse before it rules out doing too little as explicitly as doing too much.',
    1

  UNION ALL SELECT 19, 252, 1, 'gita-6-19',
    'यथा दीपो निवातस्थो नेङ्गते सोपमा स्मृता।\nयोगिनो यतचित्तस्य युञ्जतो योगमात्मनः॥',
    'yathā dīpo nivāta-stho neṅgate sopamā smṛtā\nyogino yata-cittasya yuñjato yogam ātmanaḥ',
    'yatha dipo nivata-stho nengate sopama smrita\nyogino yata-chittasya yunjato yogam atmanah',
    'As a lamp in a windless place does not flicker — that is the simile remembered for the yogi of controlled mind, practising union with the self.',
    'A lamp in a room with no draught does not waver. That is the picture. Not a bigger flame — the same flame, with nothing pulling at it.',
    'जिस कमरे में हवा नहीं आती, वहाँ दीया काँपता नहीं। तस्वीर यही है। बड़ी लौ नहीं — वही लौ, और उसे खींचने वाला कुछ नहीं।',
    'Jis kamre mein hawa nahi aati, wahan diya kaanpta nahi. Tasveer yahi hai. Badi lau nahi — wahi lau, aur use kheenchne wala kuch nahi.',
    'Not a brighter flame. The same flame, with the draught removed.',
    'ज़्यादा तेज़ लौ नहीं। वही लौ, और हवा हटा दी गई।',
    'Zyada tez lau nahi. Wahi lau, aur hawa hata di gayi.',
    'beginner',
    'Gita 6.19: a lamp in a windless place',
    'The Bhagavad Gita compares a steady mind to a lamp where there is no draught. Not a bigger flame — the same flame, with nothing pulling at it.',
    1

  UNION ALL SELECT 26, 259, 1, 'gita-6-26',
    'यतो यतो निश्चरति मनश्चञ्चलमस्थिरम्।\nततस्ततो नियम्यैतदात्मन्येव वशं नयेत्॥',
    'yato yato niścarati manaś cañcalam asthiram\ntatas tato niyamyaitad ātmany eva vaśaṁ nayet',
    'yato yato nishcharati manash chanchalam asthiram\ntatas tato niyamyaitad atmany eva vasham nayet',
    'From whatever and wherever the restless, unsteady mind wanders away, from there restrain it and bring it back under the control of the self.',
    'Wherever it goes off to — and it will, and it is restless and does not hold still — from there, bring it back. That is the whole instruction, and it is meant to be done again.',
    'यह जहाँ भी चला जाए — और जाएगा, क्योंकि यह चंचल है और टिकता नहीं — वहीं से इसे वापस ले आइए। पूरी हिदायत यही है, और इसे दोबारा किया जाना ही है।',
    'Yeh jahan bhi chala jaaye — aur jayega, kyunki yeh chanchal hai aur tikta nahi — wahin se ise wapas le aao. Poori hidayat yahi hai, aur ise dobara kiya jaana hi hai.',
    'The instruction assumes it wanders. Bringing it back is the practice, not the recovery from failing at the practice.',
    'हिदायत यह मानकर चलती है कि यह भटकेगा। वापस लाना ही अभ्यास है — अभ्यास में नाकाम होने के बाद की भरपाई नहीं।',
    'Hidayat yeh maankar chalti hai ki yeh bhatkega. Wapas laana hi abhyas hai — abhyas mein nakaam hone ke baad ki bharpai nahi.',
    'beginner',
    'Gita 6.26: wherever it goes, bring it back',
    'The Bhagavad Gita assumes the mind wanders and says only this: from wherever it went, bring it back. The bringing back is the practice itself.',
    1

  UNION ALL SELECT 34, 267, 1, 'gita-6-34',
    'चञ्चलं हि मनः कृष्ण प्रमाथि बलवद्दृढम्।\nतस्याहं निग्रहं मन्ये वायोरिव सुदुष्करम्॥',
    'cañcalaṁ hi manaḥ kṛṣṇa pramāthi balavad dṛḍham\ntasyāhaṁ nigrahaṁ manye vāyor iva suduṣkaram',
    'chanchalam hi manah krishna pramathi balavad dridham\ntasyaham nigraham manye vayor iva sudushkaram',
    'For the mind is restless, Krishna, turbulent, strong and obstinate. I think restraining it is as very hard to do as restraining the wind.',
    'Arjuna interrupts. The mind is restless, it churns things up, it is strong and it will not budge. Holding it down, he says, is about as doable as holding down the wind.',
    'अर्जुन बीच में टोकते हैं। मन चंचल है, वह चीज़ों को मथ देता है, वह ताक़तवर है और वह हटता नहीं। उसे थामना, वे कहते हैं, लगभग उतना ही मुमकिन है जितना हवा को थामना।',
    'Arjun beech mein tokte hain. Man chanchal hai, woh cheezon ko math deta hai, woh taaqatwar hai aur woh hatta nahi. Use thaamna, woh kehte hain, lagbhag utna hi mumkin hai jitna hawa ko thaamna.',
    'The student says the instruction is impossible. The text keeps his objection in.',
    'छात्र कहता है कि हिदायत नामुमकिन है। ग्रंथ उसकी आपत्ति को रहने देता है।',
    'Chhatra kehta hai ki hidayat namumkin hai. Granth uski aapatti ko rehne deta hai.',
    'beginner',
    'Gita 6.34: as hard as holding the wind',
    'Arjuna interrupts the Bhagavad Gita to say the instruction cannot be done. The text keeps his objection in rather than editing it out.',
    1

  UNION ALL SELECT 35, 268, 1, 'gita-6-35',
    'असंशयं महाबाहो मनो दुर्निग्रहं चलम्।\nअभ्यासेन तु कौन्तेय वैराग्येण च गृह्यते॥',
    'asaṁśayaṁ mahā-bāho mano durnigrahaṁ calam\nabhyāsena tu kaunteya vairāgyeṇa ca gṛhyate',
    'asamshayam maha-baho mano durnigraham chalam\nabhyasena tu kaunteya vairagyena cha grihyate',
    'Without doubt, mighty-armed one, the mind is hard to restrain and unsteady. But by practice and by dispassion it is held.',
    'No argument. It is hard to hold and it does not stay still — you are right. And it is held, by two things: doing it repeatedly, and loosening the grip on outcomes.',
    'कोई बहस नहीं। इसे थामना कठिन है और यह टिकता नहीं — आप सही हैं। और यह थामा जाता है, दो चीज़ों से: बार-बार करने से, और नतीजों पर पकड़ ढीली करने से।',
    'Koi behes nahi. Ise thaamna mushkil hai aur yeh tikta nahi — tum sahi ho. Aur yeh thaama jaata hai, do cheezon se: baar-baar karne se, aur nateejon par pakad dheeli karne se.',
    'He agrees first and answers second. The order is the reason the answer is believable.',
    'वे पहले सहमत होते हैं, जवाब बाद में देते हैं। इसी क्रम से जवाब भरोसे लायक बनता है।',
    'Woh pehle sehmat hote hain, jawab baad mein dete hain. Isi kram se jawab bharose layak banta hai.',
    'beginner',
    'Gita 6.35: no doubt about it, and here is how',
    'Krishna does not argue with Arjuna. He agrees the mind is hard to hold, and then names two things that hold it: practice, and loosening the grip.',
    1

  UNION ALL SELECT 40, 273, 1, 'gita-6-40',
    'पार्थ नैवेह नामुत्र विनाशस्तस्य विद्यते।\nन हि कल्याणकृत्कश्चिद्दुर्गतिं तात गच्छति॥',
    'pārtha naiveha nāmutra vināśas tasya vidyate\nna hi kalyāṇa-kṛt kaścid durgatiṁ tāta gacchati',
    'partha naiveha namutra vinashas tasya vidyate\nna hi kalyana-krit kashchid durgatim tata gacchati',
    'Partha, there is no destruction for him either here or hereafter. For nobody who does good, dear one, comes to a bad end.',
    'Nothing is lost, here or later. Nobody who does something decent ends up somewhere bad — and he says it with the word you use for somebody you are fond of.',
    'कुछ नहीं जाता, न यहाँ न आगे। जो कोई भला काम करता है वह बुरी जगह नहीं पहुँचता — और यह वे उस शब्द के साथ कहते हैं जो अपने किसी प्यारे के लिए इस्तेमाल होता है।',
    'Kuch nahi jaata, na yahan na aage. Jo koi bhala kaam karta hai woh buri jagah nahi pahunchta — aur yeh woh us shabd ke saath kehte hain jo apne kisi pyare ke liye istemaal hota hai.',
    'Arjuna asked what happens to somebody who tries and does not get there. This is the answer, and the tone of it is the answer too.',
    'अर्जुन ने पूछा था कि उसका क्या होता है जो कोशिश करे और पहुँच न पाए। यही जवाब है, और जवाब उसका लहजा भी है।',
    'Arjun ne poocha tha ki uska kya hota hai jo koshish kare aur pahunch na paaye. Yahi jawab hai, aur jawab uska lehja bhi hai.',
    'beginner',
    'Gita 6.40: nothing is lost',
    'Arjuna asks what becomes of somebody who tries at this and falls short. The Bhagavad Gita answers that nothing is lost, and calls him dear one while doing it.',
    1

) AS v
JOIN chapters c ON c.chapter_number = 6;

-- =====================================================================
-- EXPLANATIONS
-- =====================================================================
-- The 6.5 and 6.6 explanations both carry the sentence separating
-- leverage from blame, and the beginner one carries it first, because
-- the beginner row is what a default reader sees. The 6.17 explanation
-- keeps both halves of the moderation claim and offers no amounts.
-- smoke-test.sh asserts both.
-- =====================================================================

DELETE ve FROM verse_explanations ve JOIN verses v ON v.id = ve.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 6;

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 5 AS vn, 'beginner' AS level,
   'Chapter 6 is the practical chapter — where to sit, what to eat, what to do when the mind will not settle. It opens not with a technique but with a claim about who is doing the work.' AS h_en,
   'छठा अध्याय व्यावहारिक अध्याय है — कहाँ बैठना है, क्या खाना है, मन न टिके तो क्या करना है। यह किसी तकनीक से नहीं, इस दावे से शुरू होता है कि काम कर कौन रहा है।' AS h_hi,
   'Chhatha chapter vyavharik chapter hai — kahan baithna hai, kya khana hai, man na tike to kya karna hai. Yeh kisi technique se nahi, is dawe se shuru hota hai ki kaam kar kaun raha hai.' AS h_hing,
   'Pull yourself up, using yourself. Do not let yourself sink. And then the reason: the same person is both the friend and the opponent in there. The word for lifting and the word for sinking are both active — the verse thinks something is being done in both directions.' AS p_en,
   'ख़ुद को ऊपर खींचिए, ख़ुद से। ख़ुद को डूबने मत दीजिए। और फिर वजह: भीतर वही एक आदमी दोस्त भी है और विरोधी भी। उठाने वाला शब्द और डूबने वाला शब्द दोनों सक्रिय हैं — श्लोक मानता है कि दोनों दिशाओं में कुछ किया जा रहा है।' AS p_hi,
   'Khud ko upar kheencho, khud se. Khud ko doobne mat do. Aur phir wajah: bheetar wahi ek aadmi dost bhi hai aur virodhi bhi. Uthane wala shabd aur doobne wala shabd dono sakriya hain — shloka maanta hai ki dono dishaon mein kuch kiya ja raha hai.' AS p_hing,
   'This verse is one of the easiest in the book to be hurt by, so it is worth saying plainly what it is not. Handed to somebody who is depressed it reads as "your suffering is your own doing and you are failing to fix it", and that is not in the line. This is a claim about where leverage is — that a person is not only something things happen to — and a claim about leverage is not a claim about blame. If you are in a hole, the useful part of this verse is that your own hands are among the tools available. It is not a verdict on how you got there, and it is not a reason to stop asking anybody else for a rope.' AS m_en,
   'इस श्लोक से चोट खाना किताब में सबसे आसान चीज़ों में है, इसलिए साफ़ कहना ज़रूरी है कि यह क्या नहीं है। किसी उदास व्यक्ति को थमाया जाए तो यह पढ़ा जाता है — "तुम्हारा दुख तुम्हारा किया है और तुम उसे ठीक नहीं कर पा रहे" — और यह बात पंक्ति में है ही नहीं। यह इस बारे में दावा है कि ज़ोर कहाँ लगता है — कि आदमी सिर्फ़ वह नहीं जिसके साथ चीज़ें होती हैं — और ज़ोर के बारे में दावा दोष के बारे में दावा नहीं होता। अगर आप गड्ढे में हैं, तो इस श्लोक का काम का हिस्सा यह है कि उपलब्ध औज़ारों में आपके अपने हाथ भी हैं। यह इस पर फ़ैसला नहीं है कि आप वहाँ पहुँचे कैसे, और यह किसी और से रस्सी माँगना बंद करने की वजह भी नहीं है।' AS m_hi,
   'Is shloka se chot khaana kitaab mein sabse aasan cheezon mein hai, isliye saaf kehna zaroori hai ki yeh kya nahi hai. Kisi udaas insaan ko thamaya jaaye to yeh padha jaata hai — "tumhara dukh tumhara kiya hai aur tum use theek nahi kar paa rahe" — aur yeh baat line mein hai hi nahi. Yeh is baare mein dawa hai ki zor kahan lagta hai — ki aadmi sirf woh nahi jiske saath cheezein hoti hain — aur zor ke baare mein dawa dosh ke baare mein dawa nahi hota. Agar tum gaddhe mein ho, to is shloka ka kaam ka hissa yeh hai ki uplabdh auzaaron mein tumhare apne haath bhi hain. Yeh is par faisla nahi hai ki tum wahan pahunche kaise, aur yeh kisi aur se rassi maangna band karne ki wajah bhi nahi hai.' AS m_hing

  UNION ALL SELECT 5, 'intermediate',
   'The chapter''s opening move, and worth reading against 3.27, which said the sense of being the doer is a mistake. Placed side by side the two look contradictory and are not, which is most of what makes this verse interesting.',
   'अध्याय की पहली चाल, और इसे 3.27 के सामने रखकर पढ़ना चाहिए, जो कहता है कि कर्ता होने का भाव एक भूल है। दोनों को साथ रखें तो वे विरोधी दिखते हैं और हैं नहीं — और यही इस श्लोक को दिलचस्प बनाता है।',
   'Chapter ki pehli chaal, aur ise 3.27 ke saamne rakhkar padhna chahiye, jo kehta hai ki karta hone ka bhaav ek bhool hai. Dono ko saath rakho to woh virodhi dikhte hain aur hain nahi — aur yahi is shloka ko dilchasp banata hai.',
   'The grammar is doing the argument. Ātmanā ātmānam — by the self, the self. The same word twice, in two cases, so the sentence has a subject and an object that are the same thing. Whatever this verse thinks a person is, it is something that can get hold of itself, which is a stranger claim than it looks.',
   'दलील व्याकरण चला रहा है। आत्मना आत्मानम् — आत्मा से, आत्मा को। वही शब्द दो बार, दो विभक्तियों में, इसलिए वाक्य में कर्ता और कर्म दोनों एक ही चीज़ हैं। यह श्लोक आदमी को जो भी मानता हो, वह ऐसी चीज़ है जो ख़ुद को पकड़ सकती है — और यह दावा दिखने से ज़्यादा अजीब है।',
   'Dalil vyakaran chala raha hai. Atmana atmanam — atma se, atma ko. Wahi shabd do baar, do vibhaktiyon mein, isliye vakya mein karta aur karm dono ek hi cheez hain. Yeh shloka aadmi ko jo bhi maanta ho, woh aisi cheez hai jo khud ko pakad sakti hai — aur yeh dawa dikhne se zyada ajeeb hai.',
   'The same sentence has to be said at this depth too, because the misreading does not get less likely with a better reader. This is about leverage and not about blame. What 3.27 removes is authorship of outcomes; what 6.5 asserts is that a person is not purely acted upon. Both can hold: you did not arrange the conditions and there is still somewhere to push. Anybody who has both talked themselves into a bad decision and talked themselves out of one has all the evidence for this verse that it needs.',
   'यही वाक्य इस गहराई पर भी कहना पड़ेगा, क्योंकि बेहतर पाठक मिलने से ग़लत पाठ की संभावना घटती नहीं। यह ज़ोर के बारे में है, दोष के बारे में नहीं। 3.27 नतीजों का कर्तापन हटाता है; 6.5 यह कहता है कि आदमी सिर्फ़ वह नहीं जिस पर चीज़ें की जाती हैं। दोनों साथ टिक सकते हैं: हालात आपने नहीं जुटाए और फिर भी ज़ोर लगाने की जगह है। जिसने ख़ुद को समझा-बुझाकर कोई बुरा फ़ैसला भी लिया है और ख़ुद को समझा-बुझाकर किसी से बचा भी है, उसके पास इस श्लोक के लिए ज़रूरी पूरा सबूत है।',
   'Yahi vakya is gehrai par bhi kehna padega, kyunki behtar padhne wala milne se galat padhne ki sambhavna ghatti nahi. Yeh zor ke baare mein hai, dosh ke baare mein nahi. 3.27 nateejon ka kartapan hatata hai; 6.5 yeh kehta hai ki aadmi sirf woh nahi jis par cheezein ki jaati hain. Dono saath tik sakte hain: haalat tumne nahi jutaye aur phir bhi zor lagane ki jagah hai. Jisne khud ko samjha-bujhakar koi bura faisla bhi liya hai aur khud ko samjha-bujhakar kisi se bacha bhi hai, uske paas is shloka ke liye zaroori poora saboot hai.'

  UNION ALL SELECT 6, 'beginner',
   'The previous verse said the same person is both friend and opponent. This one answers the obvious next question: which one, and what decides it.',
   'पिछले श्लोक ने कहा कि वही एक आदमी दोस्त भी है और विरोधी भी। यह अगला ज़ाहिर सवाल हल करता है: कौन-सा, और यह तय क्या करता है।',
   'Pichhle shloka ne kaha ki wahi ek aadmi dost bhi hai aur virodhi bhi. Yeh agla zaahir sawaal hal karta hai: kaun sa, aur yeh tay kya karta hai.',
   'One thing decides it: whether you have any purchase on yourself at all. Not whether you are good, not whether things are going well. Where somebody has some hold, the same machinery works with them. Where they have none, it works against them.',
   'एक ही बात तय करती है: आपको अपने ऊपर कोई पकड़ मिली है या नहीं। यह नहीं कि आप अच्छे हैं या नहीं, यह नहीं कि हालात ठीक चल रहे हैं या नहीं। जहाँ किसी को थोड़ी पकड़ है, वही मशीन उसके साथ काम करती है। जहाँ नहीं है, वह उसके ख़िलाफ़ काम करती है।',
   'Ek hi baat tay karti hai: tumhe apne upar koi pakad mili hai ya nahi. Yeh nahi ki tum achhe ho ya nahi, yeh nahi ki haalat theek chal rahe hain ya nahi. Jahan kisi ko thodi pakad hai, wahi machine uske saath kaam karti hai. Jahan nahi hai, woh uske khilaf kaam karti hai.',
   'The word to sit with is the last one — like an enemy. Not an enemy; like one. The verse is not saying part of you is out to get you. It is saying an unattended mind produces effects indistinguishable from hostility, which is both less alarming and more useful. Nothing in you is plotting. Something in you is unsupervised, and unsupervised is enough to do the damage.',
   'ठहरने लायक शब्द आख़िरी है — शत्रु जैसा। शत्रु नहीं; शत्रु जैसा। श्लोक यह नहीं कह रहा कि आपका कोई हिस्सा आपके पीछे पड़ा है। वह कह रहा है कि बिना देखभाल वाला मन ऐसे नतीजे देता है जिन्हें शत्रुता से अलग नहीं किया जा सकता — और यह कम डरावना भी है और ज़्यादा काम का भी। आपमें कोई साज़िश नहीं कर रहा। आपमें कुछ बिना निगरानी के है, और नुक़सान करने के लिए बिना निगरानी होना काफ़ी है।',
   'Thehrne layak shabd aakhiri hai — shatru jaisa. Shatru nahi; shatru jaisa. Shloka yeh nahi keh raha ki tumhara koi hissa tumhare peechhe pada hai. Woh keh raha hai ki bina dekhbhal wala man aise nateeje deta hai jinhe shatruta se alag nahi kiya ja sakta — aur yeh kam darawna bhi hai aur zyada kaam ka bhi. Tumme koi saazish nahi kar raha. Tumme kuch bina nigrani ke hai, aur nuksaan karne ke liye bina nigrani hona kaafi hai.'

  UNION ALL SELECT 17, 'beginner',
   'The chapter has been giving practical instructions and this is the one about the body. It follows directly from 6.16, and the two have to be read together because 6.16 is where the boundaries are set.',
   'अध्याय व्यावहारिक हिदायतें दे रहा है और यह शरीर वाली है। यह सीधे 6.16 से आती है, और दोनों को साथ पढ़ना पड़ेगा क्योंकि सीमाएँ 6.16 में तय होती हैं।',
   'Chapter vyavharik hidayatein de raha hai aur yeh sharir wali hai. Yeh seedhe 6.16 se aati hai, aur dono ko saath padhna padega kyunki seemayein 6.16 mein tay hoti hain.',
   'The word repeated four times is yukta — fitted, joined, matched to the thing. Fitted in eating and moving about. Fitted in the effort you put into work. Fitted in sleeping and waking. Yukta does not mean small. It means the right size for what you are actually doing, which is a different measurement and has to be taken by you.',
   'चार बार दोहराया गया शब्द है युक्त — ठीक बैठा हुआ, जुड़ा हुआ, उस चीज़ के नाप का। खाने और चलने-फिरने में युक्त। काम में जितना लगाते हैं उसमें युक्त। सोने और जागने में युक्त। युक्त का मतलब कम नहीं है। मतलब है — जो आप सचमुच कर रहे हैं उसके लिए सही नाप, जो अलग माप है और जिसे आपको ही लेना है।',
   'Chaar baar dohraya gaya shabd hai yukta — theek baitha hua, juda hua, us cheez ke naap ka. Khaane aur chalne-firne mein yukta. Kaam mein jitna lagate hain usme yukta. Sone aur jaagne mein yukta. Yukta ka matlab kam nahi hai. Matlab hai — jo tum sach mein kar rahe ho uske liye sahi naap, jo alag maap hai aur jise tumhe hi lena hai.',
   'It matters that the verse before this one names both ways to get it wrong and gives them equal weight: this is not for the one who eats too much, and it is not for the one who does not eat; not for the one who sleeps too much, and not for the one who stays awake. Anybody reading a moderation verse as permission to take less is reading half of it. Nothing here is a target and nothing here is an amount — the text gives none, and neither does this page, because the right size for a person doing physical work and the right size for somebody recovering from illness are not the same number and never were.',
   'यह मायने रखता है कि इससे पहले वाला श्लोक ग़लत होने के दोनों तरीक़े गिनाता है और दोनों को बराबर वज़न देता है: यह उसके लिए नहीं जो बहुत खाता है, और उसके लिए भी नहीं जो खाता ही नहीं; उसके लिए नहीं जो बहुत सोता है, और उसके लिए भी नहीं जो जागता रहता है। जो संयम वाले श्लोक को कम लेने की इजाज़त की तरह पढ़ रहा है, वह उसका आधा पढ़ रहा है। यहाँ कुछ भी लक्ष्य नहीं है और कोई मात्रा नहीं है — ग्रंथ कोई नहीं देता, और यह पन्ना भी नहीं, क्योंकि शारीरिक काम करने वाले के लिए सही नाप और बीमारी से उबर रहे किसी के लिए सही नाप एक ही आँकड़ा नहीं हैं और कभी थे भी नहीं।',
   'Yeh maayne rakhta hai ki isse pehle wala shloka galat hone ke dono tareeke ginata hai aur dono ko barabar wazan deta hai: yeh uske liye nahi jo bahut khata hai, aur uske liye bhi nahi jo khata hi nahi; uske liye nahi jo bahut sota hai, aur uske liye bhi nahi jo jaagta rehta hai. Jo sanyam wale shloka ko kam lene ki ijazat ki tarah padh raha hai, woh uska aadha padh raha hai. Yahan kuch bhi lakshya nahi hai aur koi maatra nahi hai — granth koi nahi deta, aur yeh panna bhi nahi, kyunki sharirik kaam karne wale ke liye sahi naap aur bimari se ubar rahe kisi ke liye sahi naap ek hi aankda nahi hain aur kabhi the bhi nahi.'

  UNION ALL SELECT 19, 'beginner',
   'The chapter pauses the instructions to give one image. It is the most quoted line in chapter 6 and the shortest thing in it.',
   'अध्याय हिदायतें रोककर एक तस्वीर देता है। यह छठे अध्याय की सबसे ज़्यादा उद्धृत पंक्ति है और उसमें सबसे छोटी चीज़।',
   'Chapter hidayatein rokkar ek tasveer deta hai. Yeh chhathe chapter ki sabse zyada quote ki jaane wali line hai aur usme sabse chhoti cheez.',
   'A lamp in a place with no draught does not flicker. Notice what is not being described: a bigger flame, a brighter one, a protected one. The same ordinary flame, in a room where nothing is pulling at it.',
   'जिस जगह हवा नहीं आती वहाँ दीया काँपता नहीं। ध्यान दीजिए किसका वर्णन नहीं हो रहा: बड़ी लौ नहीं, ज़्यादा तेज़ नहीं, सुरक्षित की गई नहीं। वही साधारण लौ, ऐसे कमरे में जहाँ उसे कुछ खींच नहीं रहा।',
   'Jis jagah hawa nahi aati wahan diya kaanpta nahi. Dhyan do kiska varnan nahi ho raha: badi lau nahi, zyada tez nahi, surakshit ki gayi nahi. Wahi sadharan lau, aise kamre mein jahan use kuch kheench nahi raha.',
   'Almost every self-improvement image is about adding something — more discipline, more energy, a stronger version of you. This one is about subtraction, and it is worth sitting with because it changes what you would go and do about it. The flame was always capable of burning straight. The work is finding the draught, and most people have a fair idea where theirs comes from.',
   'लगभग हर आत्म-सुधार वाली तस्वीर कुछ जोड़ने की होती है — और अनुशासन, और ऊर्जा, आपका कोई मज़बूत रूप। यह घटाने की है, और इस पर ठहरना चाहिए क्योंकि यह बदल देता है कि आप जाकर करेंगे क्या। लौ में सीधा जलने की क्षमता हमेशा थी। काम है हवा को ढूँढ़ना, और ज़्यादातर लोगों को ठीक-ठाक अंदाज़ा होता है कि उनकी वाली कहाँ से आती है।',
   'Lagbhag har self-improvement wali tasveer kuch jodne ki hoti hai — aur discipline, aur urja, tumhara koi mazboot roop. Yeh ghatane ki hai, aur is par thehrna chahiye kyunki yeh badal deta hai ki tum jaakar karoge kya. Lau mein seedha jalne ki kshamta hamesha thi. Kaam hai hawa ko dhoondhna, aur zyadatar logon ko theek-thaak andaza hota hai ki unki wali kahan se aati hai.'

  UNION ALL SELECT 26, 'beginner',
   'Practical instruction, and the most immediately usable line in the chapter. It comes after several verses of describing what a settled mind is like, and it is what you actually do.',
   'व्यावहारिक हिदायत, और अध्याय की सबसे तुरंत काम आने वाली पंक्ति। यह उन कई श्लोकों के बाद आती है जो बताते हैं कि टिका हुआ मन कैसा होता है, और यह वह है जो आप असल में करते हैं।',
   'Vyavharik hidayat, aur chapter ki sabse turant kaam aane wali line. Yeh un kai shlokon ke baad aati hai jo batate hain ki tika hua man kaisa hota hai, aur yeh woh hai jo tum asal mein karte ho.',
   'Wherever it wanders off to, from there bring it back. That is the whole instruction. Read the grammar: yato yatas, tatas tatas — from wherever, from there. It is built as a repeating structure, not a single act, and the verse expects to be used many times in one sitting.',
   'यह जहाँ भी भटक जाए, वहीं से इसे वापस ले आइए। पूरी हिदायत यही है। व्याकरण देखिए: यतो यतः, ततस्ततः — जहाँ-जहाँ से, वहीं-वहीं से। यह दोहराई जाने वाली बनावट है, कोई एक काम नहीं, और श्लोक उम्मीद करता है कि एक ही बैठक में इसे कई बार इस्तेमाल किया जाएगा।',
   'Yeh jahan bhi bhatak jaaye, wahin se ise wapas le aao. Poori hidayat yahi hai. Vyakaran dekho: yato yatah, tatas tatah — jahan-jahan se, wahin-wahin se. Yeh dohrayi jaane wali banavat hai, koi ek kaam nahi, aur shloka ummeed karta hai ki ek hi baithak mein ise kai baar istemaal kiya jayega.',
   'Almost everybody who tries this concludes within a week that they are bad at it, because the mind wandered. The verse has already accounted for that: it calls the mind restless and unsteady in the same breath as the instruction. The wandering is not the failure and bringing it back is not the recovery — the bringing back is the practice. Somebody who returned two hundred times did the thing two hundred times.',
   'लगभग हर कोई जो यह आज़माता है, हफ़्ते भर में तय कर लेता है कि वह इसमें ख़राब है, क्योंकि मन भटका। श्लोक इसका हिसाब पहले ही रख चुका है: वह हिदायत के साथ ही मन को चंचल और अस्थिर कहता है। भटकना नाकामी नहीं है और वापस लाना भरपाई नहीं है — वापस लाना ही अभ्यास है। जो दो सौ बार लौटा, उसने वह काम दो सौ बार किया।',
   'Lagbhag har koi jo yeh aazmata hai, hafte bhar mein tay kar leta hai ki woh isme kharab hai, kyunki man bhatka. Shloka iska hisaab pehle hi rakh chuka hai: woh hidayat ke saath hi man ko chanchal aur asthir kehta hai. Bhatakna nakami nahi hai aur wapas laana bharpai nahi hai — wapas laana hi abhyas hai. Jo do sau baar lauta, usne woh kaam do sau baar kiya.'

  UNION ALL SELECT 34, 'beginner',
   'Arjuna interrupts. He has been listening to instructions about seat, posture, gaze and breath, and he stops the teaching to say the central one cannot be done.',
   'अर्जुन बीच में टोकते हैं। वे आसन, मुद्रा, दृष्टि और साँस की हिदायतें सुनते आ रहे हैं, और पढ़ाई रोककर कहते हैं कि जो सबसे मुख्य है वह हो ही नहीं सकता।',
   'Arjun beech mein tokte hain. Woh aasan, mudra, drishti aur saans ki hidayatein sunte aa rahe hain, aur padhai rokkar kehte hain ki jo sabse mukhya hai woh ho hi nahi sakta.',
   'Four words for the mind, and they are not gentle: restless, churning, strong, unyielding. Then the comparison — holding it is about as doable as holding the wind. He is not being difficult. He is reporting what happened when he tried.',
   'मन के लिए चार शब्द, और वे नरम नहीं हैं: चंचल, मथने वाला, ताक़तवर, न झुकने वाला। फिर तुलना — इसे थामना लगभग उतना ही मुमकिन है जितना हवा को थामना। वे अड़ नहीं रहे। वे बता रहे हैं कि कोशिश करने पर क्या हुआ।',
   'Man ke liye chaar shabd, aur woh naram nahi hain: chanchal, mathne wala, taaqatwar, na jhukne wala. Phir tulna — ise thaamna lagbhag utna hi mumkin hai jitna hawa ko thaamna. Woh ad nahi rahe. Woh bata rahe hain ki koshish karne par kya hua.',
   'The interesting thing is that this is in the book at all. A text assembling itself to teach something could have left out the student saying it does not work. Keeping it does two things: it tells a reader who is struggling that the struggle is expected, and it makes the answer in the next verse worth something, because the answer is given to somebody who has actually tried and failed.',
   'दिलचस्प बात यह है कि यह किताब में है ही। कोई ग्रंथ जो कुछ सिखाने के लिए बन रहा हो, वह छात्र के यह कहने को छोड़ सकता था कि यह चलता नहीं। इसे रखने से दो काम होते हैं: जूझ रहे पाठक को पता चलता है कि जूझना अपेक्षित है, और अगले श्लोक का जवाब क़ीमती बन जाता है, क्योंकि वह जवाब उसे दिया जा रहा है जिसने सचमुच कोशिश की और नाकाम रहा।',
   'Dilchasp baat yeh hai ki yeh kitaab mein hai hi. Koi granth jo kuch sikhane ke liye ban raha ho, woh chhatra ke yeh kehne ko chhod sakta tha ki yeh chalta nahi. Ise rakhne se do kaam hote hain: joojh rahe padhne wale ko pata chalta hai ki joojhna apekshit hai, aur agle shloka ka jawab keemti ban jaata hai, kyunki woh jawab use diya ja raha hai jisne sach mein koshish ki aur nakaam raha.'

  UNION ALL SELECT 35, 'beginner',
   'The answer to the interruption, and the first word of it is the part that matters. Not a correction, not a rebuke, not a restatement of the instruction more slowly.',
   'टोकने का जवाब, और उसका पहला शब्द ही मायने रखता है। न सुधार, न झिड़की, न वही हिदायत धीरे-धीरे दोबारा।',
   'Tokne ka jawab, aur uska pehla shabd hi maayne rakhta hai. Na sudhaar, na jhidki, na wahi hidayat dheere-dheere dobara.',
   'Asaṁśayam — without doubt. You are right. It is hard to hold and it does not stay still. And then two things that do hold it: abhyāsa, doing it repeatedly, and vairāgya, letting go of the grip on how it turns out. Not one method. Two, and they work on different parts of the problem.',
   'असंशयम् — इसमें कोई संदेह नहीं। आप सही हैं। इसे थामना कठिन है और यह टिकता नहीं। और फिर दो चीज़ें जो इसे थामती हैं: अभ्यास, यानी बार-बार करना, और वैराग्य, यानी नतीजे पर पकड़ ढीली करना। एक तरीक़ा नहीं। दो, और वे समस्या के अलग-अलग हिस्सों पर काम करते हैं।',
   'Asamshayam — isme koi sandeh nahi. Tum sahi ho. Ise thaamna mushkil hai aur yeh tikta nahi. Aur phir do cheezein jo ise thaamti hain: abhyas, yaani baar-baar karna, aur vairagya, yaani nateeje par pakad dheeli karna. Ek tareeka nahi. Do, aur woh samasya ke alag-alag hisson par kaam karte hain.',
   'Agreeing first is the whole technique and it is rarer than it should be. Anybody who has been told that a thing they found impossible is actually easy knows what the other version does. And the two remedies are worth separating: practice is what you add, and vairāgya is what you stop — specifically, caring how well the sitting went. A great deal of failed practice is people practising and then grading themselves.',
   'पहले सहमत होना ही पूरी तकनीक है और यह उतना आम नहीं है जितना होना चाहिए। जिसे भी कभी यह कहा गया है कि जो उसे नामुमकिन लगा वह असल में आसान है, वह जानता है कि दूसरा रूप क्या करता है। और दोनों उपायों को अलग करना चाहिए: अभ्यास वह है जो आप जोड़ते हैं, और वैराग्य वह जो आप छोड़ते हैं — ख़ासकर यह परवाह कि बैठक कितनी अच्छी गई। बहुत सारा नाकाम अभ्यास दरअसल लोगों का अभ्यास करके ख़ुद को अंक देना है।',
   'Pehle sehmat hona hi poori technique hai aur yeh utna aam nahi hai jitna hona chahiye. Jise bhi kabhi yeh kaha gaya hai ki jo use namumkin laga woh asal mein aasan hai, woh jaanta hai ki doosra roop kya karta hai. Aur dono upayon ko alag karna chahiye: abhyas woh hai jo tum jodte ho, aur vairagya woh jo tum chhodte ho — khaaskar yeh parwah ki baithak kitni achhi gayi. Bahut saara nakaam abhyas darasal logon ka abhyas karke khud ko ank dena hai.'

  UNION ALL SELECT 40, 'beginner',
   'Arjuna has asked the question anybody starting something difficult eventually asks: what happens to the person who tries at this and does not get there? Falls between two stools, he says, and is lost.',
   'अर्जुन ने वही सवाल पूछा है जो कोई भी कठिन चीज़ शुरू करने वाला आख़िरकार पूछता है: उसका क्या होता है जो इसमें कोशिश करे और पहुँच न पाए? वे कहते हैं कि वह दोनों तरफ़ से जाता है और खो जाता है।',
   'Arjun ne wahi sawaal poocha hai jo koi bhi mushkil cheez shuru karne wala aakhirkar poochta hai: uska kya hota hai jo isme koshish kare aur pahunch na paaye? Woh kehte hain ki woh dono taraf se jaata hai aur kho jaata hai.',
   'Nothing is destroyed, here or afterwards. Nobody who does something good comes to a bad end. And then the word tāta, which is what you call somebody you are fond of — closer to "dear one" than to any title. The reassurance is in the vocabulary as much as in the claim.',
   'कुछ नष्ट नहीं होता, न यहाँ न आगे। जो कोई भला काम करता है वह बुरी जगह नहीं पहुँचता। और फिर शब्द तात, जो अपने किसी प्यारे के लिए इस्तेमाल होता है — किसी उपाधि से ज़्यादा "प्रिय" के पास। तसल्ली जितनी दावे में है उतनी ही शब्द में।',
   'Kuch nasht nahi hota, na yahan na aage. Jo koi bhala kaam karta hai woh buri jagah nahi pahunchta. Aur phir shabd taat, jo apne kisi pyare ke liye istemaal hota hai — kisi upadhi se zyada "priya" ke paas. Tasalli jitni dawe mein hai utni hi shabd mein.',
   'Whatever you make of the metaphysics, the structural point stands and is worth having: partial progress at something worth doing is not wasted, and the fear that it is wasted is itself one of the main reasons people stop. Most abandoned practices are abandoned in the middle, by somebody who has decided that not having arrived means not having moved. This verse exists because the person being taught said exactly that out loud.',
   'तत्त्व का आप जो भी करें, ढाँचे की बात टिकती है और रखने लायक है: करने लायक किसी चीज़ में अधूरी प्रगति बेकार नहीं जाती, और यह डर कि वह बेकार है, ख़ुद उन मुख्य वजहों में है जिनसे लोग रुक जाते हैं। ज़्यादातर छूटे हुए अभ्यास बीच में छूटते हैं, ऐसे व्यक्ति से जिसने तय कर लिया कि न पहुँचने का मतलब न चलना है। यह श्लोक इसलिए है कि जिसे सिखाया जा रहा था उसने ठीक यही ज़ोर से कहा।',
   'Tattva ka tum jo bhi karo, dhaanche ki baat tikti hai aur rakhne layak hai: karne layak kisi cheez mein adhoori pragati bekaar nahi jaati, aur yeh dar ki woh bekaar hai, khud un mukhya wajahon mein hai jinse log ruk jaate hain. Zyadatar chhoote hue abhyas beech mein chhootte hain, aise insaan se jisne tay kar liya ki na pahunchne ka matlab na chalna hai. Yeh shloka isliye hai ki jise sikhaya ja raha tha usne theek yahi zor se kaha.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 6;

-- =====================================================================
-- 3. HOOKS, REFLECTIONS, PRACTICES, TOPICS
-- =====================================================================
-- No practice in this file names an amount, a duration of fasting, a
-- weight, a calorie or a sleep target. The 6.17 practice is about
-- noticing a pattern, not about changing an intake. The 6.5 and 6.6
-- reflections ask where leverage is and never ask the reader to account
-- for how they got where they are.
-- =====================================================================

DELETE m FROM verse_memory_aids m JOIN verses v ON v.id = m.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 6;
DELETE r FROM verse_reflections r JOIN verses v ON v.id = r.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 6;
DELETE p FROM verse_practices p JOIN verses v ON v.id = p.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 6;
DELETE vt FROM verse_topics vt JOIN verses v ON v.id = vt.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 6;

INSERT INTO verse_memory_aids (verse_id, hook_en, hook_hi, hook_hinglish, analogy_en, analogy_hi, analogy_hinglish, visual_cue)
SELECT v.id, m.h_en, m.h_hi, m.h_hing, m.a_en, m.a_hi, m.a_hing, m.cue FROM (
  SELECT 5 AS vn,
  'A claim about where the leverage is. Not about whose fault anything is.' AS h_en,
  'यह दावा है कि ज़ोर कहाँ लगता है। इसका नहीं कि दोष किसका है।' AS h_hi,
  'Yeh dawa hai ki zor kahan lagta hai. Iska nahi ki dosh kiska hai.' AS h_hing,
  'Like being told the handle is on your side of the door. It says nothing about who shut it.' AS a_en,
  'यह बताए जाने जैसा कि हैंडल दरवाज़े की आपकी तरफ़ है। यह नहीं बताता कि दरवाज़ा बंद किसने किया।' AS a_hi,
  'Yeh bataye jaane jaisa ki handle darwaze ki tumhari taraf hai. Yeh nahi batata ki darwaza band kisne kiya.' AS a_hing,
  'A door handle, seen from the inside' AS cue

  UNION ALL SELECT 6,
  'It does not have to be hostile. Unattended is enough.',
  'इसका दुश्मन होना ज़रूरी नहीं। बिना देखभाल के होना काफ़ी है।',
  'Iska dushman hona zaroori nahi. Bina dekhbhal ke hona kaafi hai.',
  'Like a garden nobody is against. Six months of nobody being for it is the same picture.',
  'ऐसे बग़ीचे जैसा जिसके ख़िलाफ़ कोई नहीं है। छह महीने कोई उसके साथ भी न हो, तो तस्वीर वही बनती है।',
  'Aise bagiche jaisa jiske khilaf koi nahi hai. Chhah mahine koi uske saath bhi na ho, to tasveer wahi banti hai.',
  'A gate standing open on an overgrown path'

  UNION ALL SELECT 17,
  'Yukta means fitted. Not minimal — the verse before rules out too little as loudly as too much.',
  'युक्त मतलब ठीक बैठा हुआ। कम नहीं — पिछला श्लोक "बहुत कम" को उतनी ही ज़ोर से ख़ारिज करता है जितना "बहुत ज़्यादा" को।',
  'Yukta matlab theek baitha hua. Kam nahi — pichhla shloka "bahut kam" ko utni hi zor se khaarij karta hai jitna "bahut zyada" ko.',
  'Like a shoe size. There is no prize for a smaller number and the wrong one hurts either way.',
  'जूते के नाप जैसा। छोटे आँकड़े का कोई इनाम नहीं है और ग़लत नाप दोनों तरफ़ से चुभता है।',
  'Joote ke naap jaisa. Chhote aankde ka koi inaam nahi hai aur galat naap dono taraf se chubhta hai.',
  'A pair of shoes and a measuring gauge'

  UNION ALL SELECT 19,
  'Not a bigger flame. The same flame, with the draught removed.',
  'बड़ी लौ नहीं। वही लौ, और हवा हटा दी गई।',
  'Badi lau nahi. Wahi lau, aur hawa hata di gayi.',
  'Like a photograph that came out blurred. The camera was fine; something was moving.',
  'ऐसी तस्वीर जैसी जो धुंधली आई। कैमरा ठीक था; कुछ हिल रहा था।',
  'Aisi tasveer jaisi jo dhundhli aayi. Camera theek tha; kuch hil raha tha.',
  'A candle flame, perfectly vertical'

  UNION ALL SELECT 26,
  'Bringing it back is the practice. It is not the recovery from failing at the practice.',
  'वापस लाना ही अभ्यास है। यह अभ्यास में नाकाम होने के बाद की भरपाई नहीं है।',
  'Wapas laana hi abhyas hai. Yeh abhyas mein nakaam hone ke baad ki bharpai nahi hai.',
  'Like reps. Nobody thinks the lowering is the part where the exercise went wrong.',
  'रेप्स जैसा। कोई नहीं मानता कि वज़न नीचे लाना वह हिस्सा है जहाँ व्यायाम बिगड़ गया।',
  'Reps jaisa. Koi nahi maanta ki wazan neeche laana woh hissa hai jahan exercise bigad gaya.',
  'A counter clicking upward'

  UNION ALL SELECT 34,
  'The student says it cannot be done, and the book keeps it in.',
  'छात्र कहता है कि यह हो ही नहीं सकता, और किताब उसे रहने देती है।',
  'Chhatra kehta hai ki yeh ho hi nahi sakta, aur kitaab use rehne deti hai.',
  'Like a manual with the complaints printed in the margin. You trust it more, not less.',
  'ऐसी नियमावली जैसी जिसके हाशिये पर शिकायतें छपी हों। भरोसा घटता नहीं, बढ़ता है।',
  'Aisi manual jaisi jiske hashiye par shikayatein chhapi hon. Bharosa ghatta nahi, badhta hai.',
  'A page with a handwritten note in the margin'

  UNION ALL SELECT 35,
  'He agrees first and answers second. That order is why the answer is believable.',
  'वे पहले सहमत होते हैं, जवाब बाद में। इसी क्रम से जवाब भरोसे लायक बनता है।',
  'Woh pehle sehmat hote hain, jawab baad mein. Isi kram se jawab bharose layak banta hai.',
  'Like a physio who says yes, that will hurt, and then shows you the movement.',
  'ऐसे फ़िज़ियो जैसा जो कहे कि हाँ, इसमें दर्द होगा, और फिर हरकत करके दिखाए।',
  'Aise physio jaisa jo kahe ki haan, isme dard hoga, aur phir harkat karke dikhaye.',
  'Two hands, one steadying the other'

  UNION ALL SELECT 40,
  'Partial progress at something worth doing is not wasted. He says it to somebody afraid it is.',
  'करने लायक चीज़ में अधूरी प्रगति बेकार नहीं जाती। वे यह उससे कहते हैं जिसे डर है कि जाती है।',
  'Karne layak cheez mein adhoori pragati bekaar nahi jaati. Woh yeh usse kehte hain jise dar hai ki jaati hai.',
  'Like a language you stopped learning. You still hear more of it than you did.',
  'उस भाषा जैसी जिसे आपने सीखना छोड़ दिया। अब भी आप उसमें पहले से ज़्यादा सुन लेते हैं।',
  'Us bhasha jaisi jise tumne seekhna chhod diya. Ab bhi tum usme pehle se zyada sun lete ho.',
  'A staircase, part-built, going up'
) AS m
JOIN verses v ON v.verse_number = m.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 6;

INSERT INTO verse_reflections (verse_id, question_en, question_hi, question_hinglish, display_order)
SELECT v.id, r.q_en, r.q_hi, r.q_hing, r.ord FROM (
  SELECT 5 AS vn, 'Where, today, is there something you could actually push on? One thing is enough.' AS q_en, 'आज कौन-सी जगह है जहाँ आप सचमुच ज़ोर लगा सकते हैं? एक ही काफ़ी है।' AS q_hi, 'Aaj kaun si jagah hai jahan tum sach mein zor laga sakte ho? Ek hi kaafi hai.' AS q_hing, 1 AS ord
  UNION ALL SELECT 5, 'When have you talked yourself out of something bad? That happened too.', 'आपने कब ख़ुद को समझा-बुझाकर किसी बुरी चीज़ से बचाया है? वह भी हुआ है।', 'Tumne kab khud ko samjha-bujhakar kisi buri cheez se bachaya hai? Woh bhi hua hai.', 2
  UNION ALL SELECT 5, 'What would you say to a friend who read this line as an accusation?', 'जो दोस्त इस पंक्ति को इलज़ाम की तरह पढ़े, उससे आप क्या कहेंगे?', 'Jo dost is line ko ilzaam ki tarah padhe, usse tum kya kahoge?', 3
  UNION ALL SELECT 6, 'What in your life is not being attended to rather than being attacked?', 'आपकी ज़िंदगी में क्या है जिस पर हमला नहीं हो रहा, बस उसकी देखभाल नहीं हो रही?', 'Tumhari zindagi mein kya hai jis par hamla nahi ho raha, bas uski dekhbhal nahi ho rahi?', 1
  UNION ALL SELECT 6, 'Where do you already have some purchase on yourself? Name one place.', 'कहाँ आपको अपने ऊपर पहले से थोड़ी पकड़ है? एक जगह बताइए।', 'Kahan tumhe apne upar pehle se thodi pakad hai? Ek jagah batao.', 2
  UNION ALL SELECT 6, 'Does calling it "like an enemy" rather than "an enemy" change anything for you?', 'इसे "शत्रु" के बजाय "शत्रु जैसा" कहने से आपके लिए कुछ बदलता है?', 'Ise "shatru" ke bajaye "shatru jaisa" kehne se tumhare liye kuch badalta hai?', 3
  UNION ALL SELECT 17, 'Which of the four — eating, moving, working, sleeping — is furthest from fitted right now?', 'चारों में से — खाना, चलना-फिरना, काम, नींद — अभी कौन-सा ठीक नाप से सबसे दूर है?', 'Chaaron mein se — khana, chalna-firna, kaam, neend — abhi kaun sa theek naap se sabse door hai?', 1
  UNION ALL SELECT 17, 'The verse rules out too little as firmly as too much. Which direction do you drift?', 'श्लोक "बहुत कम" को उतनी ही मज़बूती से ख़ारिज करता है जितना "बहुत ज़्यादा" को। आप किस तरफ़ बहते हैं?', 'Shloka "bahut kam" ko utni hi mazbooti se khaarij karta hai jitna "bahut zyada" ko. Tum kis taraf behte ho?', 2
  UNION ALL SELECT 17, 'Fitted to what you are actually doing — has what you are doing changed lately?', 'जो आप सचमुच कर रहे हैं उसके नाप का — क्या हाल में वह बदला है जो आप कर रहे हैं?', 'Jo tum sach mein kar rahe ho uske naap ka — kya haal mein woh badla hai jo tum kar rahe ho?', 3
  UNION ALL SELECT 19, 'What is the draught in your room? Most people can name theirs.', 'आपके कमरे में हवा कहाँ से आती है? ज़्यादातर लोग अपनी वाली बता सकते हैं।', 'Tumhare kamre mein hawa kahan se aati hai? Zyadatar log apni wali bata sakte hain.', 1
  UNION ALL SELECT 19, 'Have you been trying to burn brighter when the problem was the draught?', 'क्या आप ज़्यादा तेज़ जलने की कोशिश करते रहे जबकि दिक़्क़त हवा थी?', 'Kya tum zyada tez jalne ki koshish karte rahe jabki dikkat hawa thi?', 2
  UNION ALL SELECT 19, 'When were you last steady without trying to be? What was absent?', 'पिछली बार आप बिना कोशिश किए कब टिके हुए थे? तब क्या ग़ैरहाज़िर था?', 'Pichhli baar tum bina koshish kiye kab tike hue the? Tab kya gairhazir tha?', 3
  UNION ALL SELECT 26, 'How many times did you decide you were bad at this before you had done it twenty times?', 'बीस बार करने से पहले आपने कितनी बार तय कर लिया कि आप इसमें ख़राब हैं?', 'Bees baar karne se pehle tumne kitni baar tay kar liya ki tum isme kharab ho?', 1
  UNION ALL SELECT 26, 'Where does yours usually go? The destination is often the same one.', 'आपका आमतौर पर कहाँ जाता है? मंज़िल अक्सर वही एक होती है।', 'Tumhara aam taur par kahan jaata hai? Manzil aksar wahi ek hoti hai.', 2
  UNION ALL SELECT 26, 'If returning is the practice, how much practice did you actually get yesterday?', 'अगर लौटना ही अभ्यास है, तो कल आपको असल में कितना अभ्यास मिला?', 'Agar lautna hi abhyas hai, to kal tumhe asal mein kitna abhyas mila?', 3
  UNION ALL SELECT 34, 'What have you privately concluded is impossible for you specifically?', 'आपने चुपचाप क्या तय कर रखा है कि यह ख़ास तौर पर आपके लिए नामुमकिन है?', 'Tumne chupchap kya tay kar rakha hai ki yeh khaas taur par tumhare liye namumkin hai?', 1
  UNION ALL SELECT 34, 'Who have you told? Arjuna said it out loud and got an answer.', 'आपने किससे कहा है? अर्जुन ने ज़ोर से कहा और जवाब मिला।', 'Tumne kisse kaha hai? Arjun ne zor se kaha aur jawab mila.', 2
  UNION ALL SELECT 34, 'Does it help to know the objection is in the book rather than being your failing?', 'यह जानकर मदद मिलती है कि आपत्ति किताब में है, आपकी ख़ामी नहीं है?', 'Yeh jaankar madad milti hai ki aapatti kitaab mein hai, tumhari khami nahi hai?', 3
  UNION ALL SELECT 35, 'Which of the two do you skip — the doing repeatedly, or the loosening?', 'दोनों में से आप कौन-सा छोड़ देते हैं — बार-बार करना, या पकड़ ढीली करना?', 'Dono mein se tum kaun sa chhod dete ho — baar-baar karna, ya pakad dheeli karna?', 1
  UNION ALL SELECT 35, 'Do you grade your practice afterwards? What does the grading cost?', 'क्या आप अभ्यास के बाद ख़ुद को अंक देते हैं? उस अंक देने की क्या क़ीमत लगती है?', 'Kya tum abhyas ke baad khud ko ank dete ho? Us ank dene ki kya keemat lagti hai?', 2
  UNION ALL SELECT 35, 'Who has ever agreed with you first before helping? What did that do?', 'किसने कभी मदद करने से पहले आपसे सहमति जताई है? उससे क्या हुआ?', 'Kisne kabhi madad karne se pehle tumse sehmati jatayi hai? Usse kya hua?', 3
  UNION ALL SELECT 40, 'What did you stop partway through and write off entirely?', 'आपने क्या बीच में छोड़ दिया और पूरी तरह बेकार मान लिया?', 'Tumne kya beech mein chhod diya aur poori tarah bekaar maan liya?', 1
  UNION ALL SELECT 40, 'What did you keep from it? There is usually something.', 'उससे आपके पास क्या बचा? आमतौर पर कुछ न कुछ बचता है।', 'Usse tumhare paas kya bacha? Aam taur par kuch na kuch bachta hai.', 2
  UNION ALL SELECT 40, 'Is the fear of wasting effort currently stopping you from starting something?', 'क्या मेहनत बेकार जाने का डर अभी आपको कुछ शुरू करने से रोक रहा है?', 'Kya mehnat bekaar jaane ka dar abhi tumhe kuch shuru karne se rok raha hai?', 3
) AS r
JOIN verses v ON v.verse_number = r.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 6;

INSERT INTO verse_practices (verse_id, action_en, action_hi, action_hinglish, estimated_minutes, difficulty, display_order)
SELECT v.id, p.a_en, p.a_hi, p.a_hing, p.mins, p.diff, 1 FROM (
  SELECT 5 AS vn, 'Write down one thing you did for yourself this week that a friend would have thanked you for.' AS a_en, 'इस हफ़्ते अपने लिए किया कोई एक काम लिखिए जिसके लिए कोई दोस्त आपका शुक्रिया करता।' AS a_hi, 'Is hafte apne liye kiya koi ek kaam likho jiske liye koi dost tumhara shukriya karta.' AS a_hing, 5 AS mins, 'beginner' AS diff
  UNION ALL SELECT 6, 'Pick one thing you have stopped attending to. Do the smallest possible piece of it today.', 'ऐसी एक चीज़ चुनिए जिसकी आपने देखभाल करना बंद कर दिया है। आज उसका सबसे छोटा मुमकिन हिस्सा कीजिए।', 'Aisi ek cheez chuno jiski tumne dekhbhal karna band kar di hai. Aaj uska sabse chhota mumkin hissa karo.', 10, 'beginner'
  UNION ALL SELECT 17, 'For three days, write down only WHEN you ate, slept and worked — not how much. Look for a pattern, not a number.', 'तीन दिन तक सिर्फ़ यह लिखिए कि आपने कब खाया, कब सोए, कब काम किया — कितना नहीं। ढर्रा ढूँढ़िए, आँकड़ा नहीं।', 'Teen din tak sirf yeh likho ki tumne kab khaya, kab soye, kab kaam kiya — kitna nahi. Dharra dhoondho, aankda nahi.', 6, 'beginner'
  UNION ALL SELECT 19, 'Name the draught. Then change one thing about the room rather than one thing about yourself.', 'हवा का नाम लीजिए। फिर अपने बारे में कुछ बदलने के बजाय कमरे के बारे में एक चीज़ बदलिए।', 'Hawa ka naam lo. Phir apne baare mein kuch badalne ke bajaye kamre ke baare mein ek cheez badlo.', 8, 'intermediate'
  UNION ALL SELECT 26, 'Sit for two minutes. Count how many times you bring it back. That number is the score, and higher is better.', 'दो मिनट बैठिए। गिनिए कि आपने कितनी बार उसे वापस लाया। वही अंक है, और ज़्यादा बेहतर है।', 'Do minute baitho. Gino ki tumne kitni baar use wapas laya. Wahi ank hai, aur zyada behtar hai.', 2, 'beginner'
  UNION ALL SELECT 34, 'Say the thing you think is impossible for you out loud to one person. Do not add a solution.', 'जो आपको अपने लिए नामुमकिन लगता है, वह एक व्यक्ति से ज़ोर से कहिए। साथ में कोई हल मत जोड़िए।', 'Jo tumhe apne liye namumkin lagta hai, woh ek insaan se zor se kaho. Saath mein koi hal mat jodo.', 5, 'intermediate'
  UNION ALL SELECT 35, 'Do the thing once today and deliberately do not assess how it went afterwards.', 'आज वह काम एक बार कीजिए और जानबूझकर बाद में यह मत आँकिए कि कैसा गया।', 'Aaj woh kaam ek baar karo aur jaanboojhkar baad mein yeh mat aanko ki kaisa gaya.', 10, 'intermediate'
  UNION ALL SELECT 40, 'List three things you abandoned partway. Beside each, write one thing you still have from it.', 'तीन चीज़ें लिखिए जो आपने बीच में छोड़ीं। हर एक के आगे लिखिए कि उससे आपके पास अब भी क्या है।', 'Teen cheezein likho jo tumne beech mein chhodin. Har ek ke aage likho ki usse tumhare paas ab bhi kya hai.', 8, 'beginner'
) AS p
JOIN verses v ON v.verse_number = p.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 6;

INSERT INTO verse_topics (verse_id, topic_id, relevance)
SELECT v.id, t.id, x.rel FROM (
  SELECT 5 AS vn, 'the-self' AS slug, 10 AS rel
  UNION ALL SELECT 5, 'steadiness', 8
  UNION ALL SELECT 5, 'hard-decisions', 7
  UNION ALL SELECT 5, 'burnout', 6
  UNION ALL SELECT 6, 'the-self', 10
  UNION ALL SELECT 6, 'steadiness', 8
  UNION ALL SELECT 6, 'restlessness', 7
  UNION ALL SELECT 17, 'burnout', 9
  UNION ALL SELECT 17, 'steadiness', 8
  UNION ALL SELECT 17, 'restlessness', 7
  UNION ALL SELECT 17, 'desire', 6
  UNION ALL SELECT 19, 'steadiness', 10
  UNION ALL SELECT 19, 'restlessness', 9
  UNION ALL SELECT 19, 'the-self', 6
  UNION ALL SELECT 26, 'restlessness', 10
  UNION ALL SELECT 26, 'steadiness', 9
  UNION ALL SELECT 26, 'desire', 6
  UNION ALL SELECT 34, 'restlessness', 10
  UNION ALL SELECT 34, 'hard-decisions', 7
  UNION ALL SELECT 34, 'fear', 6
  UNION ALL SELECT 35, 'restlessness', 9
  UNION ALL SELECT 35, 'steadiness', 9
  UNION ALL SELECT 35, 'action-without-attachment', 8
  UNION ALL SELECT 35, 'effort-without-result', 7
  UNION ALL SELECT 40, 'fear', 8
  UNION ALL SELECT 40, 'effort-without-result', 8
  UNION ALL SELECT 40, 'steadiness', 7
  UNION ALL SELECT 40, 'grief', 6
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 6
JOIN topics t ON t.slug = x.slug;

-- =====================================================================
-- 4. MODERN EXAMPLES
-- =====================================================================
-- Four per verse.
--
-- THE 6.5 AND 6.6 SET IS WRITTEN AGAINST THE MISREADING
--   None of these describes somebody whose difficulty is their own
--   fault, and one of them turns on asking another person for help —
--   because a verse about your own hands being available is not a verse
--   about doing it alone, and a set of examples where nobody ever asks
--   would teach the opposite of what the explanation says.
--
-- THE 6.17 SET RUNS IN BOTH DIRECTIONS
--   Two of the four are about somebody doing too little rather than too
--   much, for the same reason the verse names both. No example here
--   contains an amount, a target or a regimen.
-- =====================================================================

DELETE e FROM modern_examples e JOIN verses v ON v.id = e.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 6;

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
  'The appointment she made herself' AS t_en, 'वह अपॉइंटमेंट जो उसने ख़ुद लिया' AS t_hi, 'Woh appointment jo usne khud liya' AS t_hing,
  'Somebody who has been unwell for months, in the way that makes phone calls hard, books an appointment on a Tuesday morning. It takes eleven minutes and she has to sit down afterwards. Nothing about the illness changes that day. The appointment exists, which it did not before, and she did not have to be well to make it.' AS s_en,
  'महीनों से बीमार कोई — उस तरह से जिसमें फ़ोन करना मुश्किल हो जाता है — मंगलवार सुबह एक अपॉइंटमेंट ले लेती है। इसमें ग्यारह मिनट लगते हैं और बाद में उसे बैठना पड़ता है। उस दिन बीमारी में कुछ नहीं बदलता। अपॉइंटमेंट मौजूद है, जो पहले नहीं था, और उसे लेने के लिए उसका ठीक होना ज़रूरी नहीं था।' AS s_hi,
  'Mahinon se bimar koi — us tarah se jisme phone karna mushkil ho jaata hai — Tuesday subah ek appointment le leti hai. Isme gyarah minute lagte hain aur baad mein use baithna padta hai. Us din bimari mein kuch nahi badalta. Appointment maujood hai, jo pehle nahi tha, aur use lene ke liye uska theek hona zaroori nahi tha.' AS s_hing,
  'This is the verse read as it is meant and not as it is often heard. It says nothing about how she got here or whether she should have managed better. It says her own hands were among the tools available, and eleven minutes on a Tuesday is what that looked like. Note also what the appointment is for: the verse is not an argument for doing it alone.' AS c_en,
  'यह श्लोक वैसे पढ़ा गया है जैसा उसका इरादा है, वैसा नहीं जैसा अक्सर सुना जाता है। वह इस बारे में कुछ नहीं कहता कि वह यहाँ पहुँची कैसे या उसे बेहतर संभालना चाहिए था या नहीं। वह कहता है कि उपलब्ध औज़ारों में उसके अपने हाथ भी थे, और मंगलवार के ग्यारह मिनट उसका रूप थे। यह भी देखिए कि अपॉइंटमेंट किसलिए है: यह श्लोक अकेले कर लेने की दलील नहीं है।' AS c_hi,
  'Yeh shloka waise padha gaya hai jaisa uska iraada hai, waisa nahi jaisa aksar suna jaata hai. Woh is baare mein kuch nahi kehta ki woh yahan pahunchi kaise ya use behtar sambhalna chahiye tha ya nahi. Woh kehta hai ki uplabdh auzaaron mein uske apne haath bhi the, aur Tuesday ke gyarah minute uska roop the. Yeh bhi dekho ki appointment kisliye hai: yeh shloka akele kar lene ki dalil nahi hai.' AS c_hing,
  'She did not have to be well to make the call. That is the whole of what the verse claims.' AS l_en,
  'फ़ोन करने के लिए उसका ठीक होना ज़रूरी नहीं था। श्लोक बस इतना ही दावा करता है।' AS l_hi,
  'Phone karne ke liye uska theek hona zaroori nahi tha. Shloka bas itna hi dawa karta hai.' AS l_hing,
  NULL AS src, 'beginner' AS diff, 'health,help,agency,small-steps,honesty' AS tags

  UNION ALL SELECT 5, 'everyday_life', 2,
  'The two minutes before the reply', 'जवाब से पहले के दो मिनट', 'Jawab se pehle ke do minute',
  'Somebody reads a message that lands badly and begins typing. Halfway through they put the phone face down and go and fill the kettle. They come back four minutes later and send something shorter. Nothing about the original message changed and neither did how annoying it was.',
  'किसी को एक संदेश मिलता है जो बुरा लगता है और वह टाइप करने लगता है। बीच में ही वह फ़ोन उल्टा रखकर केतली भरने चला जाता है। चार मिनट बाद लौटकर वह कुछ छोटा भेजता है। मूल संदेश में कुछ नहीं बदला और यह भी नहीं कि वह कितना चुभने वाला था।',
  'Kisi ko ek message milta hai jo bura lagta hai aur woh type karne lagta hai. Beech mein hi woh phone ulta rakhkar ketli bharne chala jaata hai. Chaar minute baad lautkar woh kuch chhota bhejta hai. Mool message mein kuch nahi badla aur yeh bhi nahi ki woh kitna chubhne wala tha.',
  'Four minutes and a kettle is not a spiritual achievement, and that is why it is worth having as an example. The verse claims a person is not purely something things happen to. Most of the evidence for that claim is this size, and it accumulates.',
  'चार मिनट और एक केतली कोई आध्यात्मिक उपलब्धि नहीं है, और इसीलिए यह उदाहरण रखने लायक है। श्लोक कहता है कि आदमी सिर्फ़ वह नहीं जिसके साथ चीज़ें होती हैं। उस दावे के ज़्यादातर सबूत इसी आकार के होते हैं, और वे जुड़ते जाते हैं।',
  'Chaar minute aur ek ketli koi adhyatmik uplabdhi nahi hai, aur isiliye yeh udaharan rakhne layak hai. Shloka kehta hai ki aadmi sirf woh nahi jiske saath cheezein hoti hain. Us dawe ke zyadatar saboot isi aakar ke hote hain, aur woh judte jaate hain.',
  'Most of the evidence that you have any hold on yourself is this small, and it counts anyway.',
  'इस बात के ज़्यादातर सबूत कि आपकी अपने ऊपर कोई पकड़ है, इतने ही छोटे होते हैं, और वे फिर भी गिने जाते हैं।',
  'Is baat ke zyadatar saboot ki tumhari apne upar koi pakad hai, itne hi chhote hote hain, aur woh phir bhi gine jaate hain.',
  NULL, 'beginner', 'ordinary,restraint,messages,anger,small-steps'

  UNION ALL SELECT 5, 'sports', 3,
  'Between points', 'अंकों के बीच', 'Ankon ke beech',
  'A tennis player loses a point badly and has about twenty seconds. What she does with them — the towel, the strings, the walk to the baseline — is the same every time, and was built deliberately over two years with a coach. Her opponent has the same twenty seconds and does something different with them.',
  'एक टेनिस खिलाड़ी बुरी तरह एक अंक गँवाती है और उसके पास क़रीब बीस सेकंड हैं। वह उनका क्या करती है — तौलिया, तार, बेसलाइन तक की चाल — हर बार वही होता है, और दो साल में एक कोच के साथ जानबूझकर बनाया गया था। उसकी प्रतिद्वंद्वी के पास भी वही बीस सेकंड हैं और वह उनका कुछ और करती है।',
  'Ek tennis player buri tarah ek ank ganwati hai aur uske paas karib bees second hain. Woh unka kya karti hai — tauliya, taar, baseline tak ki chaal — har baar wahi hota hai, aur do saal mein ek coach ke saath jaanboojhkar banaya gaya tha. Uski pratidwandi ke paas bhi wahi bees second hain aur woh unka kuch aur karti hai.',
  'The verse says the same person is friend or opponent inside. Twenty seconds is where that gets decided in tennis, and the useful part is that the friendly version was constructed rather than inherited. Nobody is born with a between-points routine.',
  'श्लोक कहता है कि भीतर वही एक आदमी दोस्त है या विरोधी। टेनिस में यह बीस सेकंड में तय होता है, और काम की बात यह है कि दोस्त वाला रूप विरासत में नहीं मिला, बनाया गया था। अंकों के बीच की दिनचर्या लेकर कोई पैदा नहीं होता।',
  'Shloka kehta hai ki bheetar wahi ek aadmi dost hai ya virodhi. Tennis mein yeh bees second mein tay hota hai, aur kaam ki baat yeh hai ki dost wala roop virasat mein nahi mila, banaya gaya tha. Ankon ke beech ki dincharya lekar koi paida nahi hota.',
  'Nobody is born with a between-points routine. The friendly version gets built.',
  'अंकों के बीच की दिनचर्या लेकर कोई पैदा नहीं होता। दोस्त वाला रूप बनाया जाता है।',
  'Ankon ke beech ki dincharya lekar koi paida nahi hota. Dost wala roop banaya jaata hai.',
  NULL, 'intermediate', 'sport,routine,composure,practice,self-management'

  UNION ALL SELECT 5, 'corporate', 4,
  'The email she did not send at eleven', 'वह ईमेल जो उसने ग्यारह बजे नहीं भेजी', 'Woh email jo usne gyarah baje nahi bheji',
  'A manager writes a long, accurate and quite cutting email at eleven at night and schedules it for eight the next morning. At eight she reads it again and sends four sentences of it. She describes the scheduling feature afterwards as the single most useful thing anybody built for her.',
  'एक मैनेजर रात ग्यारह बजे एक लंबी, सटीक और काफ़ी चुभती हुई ईमेल लिखती हैं और उसे अगली सुबह आठ बजे के लिए शेड्यूल कर देती हैं। आठ बजे वे उसे दोबारा पढ़कर उसमें से चार वाक्य भेजती हैं। वे बाद में उस शेड्यूल सुविधा को अपने लिए बनाई गई सबसे काम की इकलौती चीज़ बताती हैं।',
  'Ek manager raat gyarah baje ek lambi, sateek aur kaafi chubhti hui email likhti hain aur use agli subah aath baje ke liye schedule kar deti hain. Aath baje woh use dobara padhkar usme se chaar vakya bhejti hain. Woh baad mein us schedule suvidha ko apne liye banayi gayi sabse kaam ki iklauti cheez batati hain.',
  'She did not become a calmer person at eleven. She put something between the eleven-o''clock version of herself and the send button, which is what "lift yourself by yourself" looks like when it is a design decision rather than a character trait.',
  'वे ग्यारह बजे शांत इंसान नहीं बन गईं। उन्होंने अपने ग्यारह बजे वाले रूप और सेंड बटन के बीच कुछ रख दिया — और "ख़ुद को ख़ुद से ऊपर खींचिए" तब ऐसा ही दिखता है जब वह चरित्र का गुण नहीं, बनावट का फ़ैसला हो।',
  'Woh gyarah baje shaant insaan nahi ban gayin. Unhone apne gyarah baje wale roop aur send button ke beech kuch rakh diya — aur "khud ko khud se upar kheencho" tab aisa hi dikhta hai jab woh charitra ka gun nahi, banavat ka faisla ho.',
  'She put something between the eleven-o''clock version of herself and the send button. That counts.',
  'उन्होंने अपने ग्यारह बजे वाले रूप और सेंड बटन के बीच कुछ रख दिया। वह भी गिना जाता है।',
  'Unhone apne gyarah baje wale roop aur send button ke beech kuch rakh diya. Woh bhi gina jaata hai.',
  NULL, 'beginner', 'work,email,restraint,design,anger'

  UNION ALL SELECT 6, 'relationships', 1,
  'Nobody was against it', 'कोई इसके ख़िलाफ़ नहीं था', 'Koi iske khilaf nahi tha',
  'A friendship of fifteen years thins out over about three. There is no falling out, no incident, nothing either of them could point to. Both are fond of the other and both are busy. At the end of the three years they see each other at a wedding and are warm, and neither suggests meeting.',
  'पंद्रह साल की एक दोस्ती क़रीब तीन साल में पतली पड़ जाती है। न कोई झगड़ा, न कोई घटना, ऐसा कुछ नहीं जिसकी तरफ़ दोनों में से कोई इशारा कर सके। दोनों एक-दूसरे को चाहते हैं और दोनों व्यस्त हैं। तीन साल के अंत में वे किसी शादी में मिलते हैं और गर्मजोशी से मिलते हैं, और दोनों में से कोई मिलने का सुझाव नहीं देता।',
  'Pandrah saal ki ek dosti karib teen saal mein patli pad jaati hai. Na koi jhagda, na koi ghatna, aisa kuch nahi jiski taraf dono mein se koi ishara kar sake. Dono ek-doosre ko chahte hain aur dono vyast hain. Teen saal ke ant mein woh kisi shaadi mein milte hain aur garmjoshi se milte hain, aur dono mein se koi milne ka sujhav nahi deta.',
  'The verse says the enemy version is not hostile — it is unattended. This is the same shape at the scale of a friendship, and it is worth noticing that the warmth at the wedding is real. Nothing was against it. Nothing was for it either, for three years, and that turned out to be sufficient.',
  'श्लोक कहता है कि दुश्मन वाला रूप शत्रुतापूर्ण नहीं है — वह बिना देखभाल का है। यह वही आकार है, एक दोस्ती के पैमाने पर, और ध्यान देने लायक है कि शादी वाली गर्मजोशी सच्ची है। कुछ भी इसके ख़िलाफ़ नहीं था। तीन साल तक कुछ भी इसके साथ भी नहीं था, और वह काफ़ी निकला।',
  'Shloka kehta hai ki dushman wala roop shatrutapurn nahi hai — woh bina dekhbhal ka hai. Yeh wahi aakar hai, ek dosti ke paimane par, aur dhyan dene layak hai ki shaadi wali garmjoshi sachchi hai. Kuch bhi iske khilaf nahi tha. Teen saal tak kuch bhi iske saath bhi nahi tha, aur woh kaafi nikla.',
  'Nothing was against it. Nothing was for it either, and that turned out to be enough.',
  'कुछ भी इसके ख़िलाफ़ नहीं था। इसके साथ भी कुछ नहीं था, और वह काफ़ी निकला।',
  'Kuch bhi iske khilaf nahi tha. Iske saath bhi kuch nahi tha, aur woh kaafi nikla.',
  NULL, 'beginner', 'friendship,drift,attention,neglect,ordinary'

  UNION ALL SELECT 6, 'technology', 2,
  'The service with no owner', 'वह सेवा जिसका कोई मालिक नहीं', 'Woh service jiska koi maalik nahi',
  'A small internal service runs fine for two years after the person who built it moves teams. Nobody is neglecting it; nobody has been asked to own it. When it finally fails it takes four hours to work out who should be looking, and the fix itself takes nine minutes.',
  'एक छोटी आंतरिक सेवा उस व्यक्ति के टीम बदलने के बाद दो साल ठीक चलती रहती है जिसने उसे बनाया था। कोई उसकी अनदेखी नहीं कर रहा; किसी से उसका मालिक बनने को कहा ही नहीं गया। जब वह आख़िरकार बंद होती है, तो यह पता करने में चार घंटे लगते हैं कि देखना किसे चाहिए, और ठीक करने में नौ मिनट।',
  'Ek chhoti aantarik service us insaan ke team badalne ke baad do saal theek chalti rehti hai jisne use banaya tha. Koi uski andekhi nahi kar raha; kisi se uska maalik banne ko kaha hi nahi gaya. Jab woh aakhirkar band hoti hai, to yeh pata karne mein chaar ghante lagte hain ki dekhna kise chahiye, aur theek karne mein nau minute.',
  'Nine minutes of fix and four hours of finding somebody is the whole distinction the verse draws. Unattended is not the same as attacked, and it produces effects that are indistinguishable from an attack while nobody involved has done anything wrong.',
  'नौ मिनट की मरम्मत और किसी को ढूँढ़ने के चार घंटे — यही पूरा फ़र्क़ है जो श्लोक खींचता है। बिना देखभाल होना हमला होना नहीं है, और यह ऐसे नतीजे देता है जिन्हें हमले से अलग नहीं किया जा सकता, जबकि इसमें शामिल किसी ने कुछ ग़लत नहीं किया।',
  'Nau minute ki marammat aur kisi ko dhoondhne ke chaar ghante — yahi poora farq hai jo shloka kheenchta hai. Bina dekhbhal hona hamla hona nahi hai, aur yeh aise nateeje deta hai jinhe hamle se alag nahi kiya ja sakta, jabki isme shamil kisi ne kuch galat nahi kiya.',
  'Nine minutes to fix, four hours to find an owner. Unattended costs more than attacked.',
  'ठीक करने में नौ मिनट, मालिक ढूँढ़ने में चार घंटे। बिना देखभाल होना हमले से महँगा पड़ता है।',
  'Theek karne mein nau minute, maalik dhoondhne mein chaar ghante. Bina dekhbhal hona hamle se mehnga padta hai.',
  NULL, 'intermediate', 'technology,ownership,neglect,systems,maintenance'

  UNION ALL SELECT 6, 'everyday_life', 3,
  'The room that became storage', 'वह कमरा जो गोदाम बन गया', 'Woh kamra jo godaam ban gaya',
  'A spare room is meant for something — a desk, a hobby, a guest. Over about eighteen months it collects the things that have nowhere else to go. Nobody decided it was storage. At the point somebody wants to use it for the original purpose, clearing it is a weekend and an argument.',
  'एक अतिरिक्त कमरा किसी काम के लिए है — मेज़, कोई शौक़, कोई मेहमान। क़रीब अठारह महीनों में उसमें वे चीज़ें जमा होती जाती हैं जिनके लिए और कोई जगह नहीं। किसी ने तय नहीं किया कि यह गोदाम है। जिस दिन कोई उसे उसके असली काम के लिए इस्तेमाल करना चाहता है, उसे ख़ाली करना एक सप्ताहांत और एक झगड़ा है।',
  'Ek atirikt kamra kisi kaam ke liye hai — mez, koi shauk, koi mehmaan. Karib atharah mahinon mein usme woh cheezein jama hoti jaati hain jinke liye aur koi jagah nahi. Kisi ne tay nahi kiya ki yeh godaam hai. Jis din koi use uske asli kaam ke liye istemaal karna chahta hai, use khaali karna ek weekend aur ek jhagda hai.',
  'The verse is about a mind and this is a room, and the mechanism is identical enough to be useful. Nothing was decided, nobody was against the original purpose, and eighteen months of nobody being for it produced a result somebody now has to spend a weekend undoing.',
  'श्लोक मन के बारे में है और यह एक कमरा है, और तंत्र इतना एक जैसा है कि काम आता है। कुछ तय नहीं हुआ, कोई असली मक़सद के ख़िलाफ़ नहीं था, और अठारह महीने कोई उसके साथ न होने से ऐसा नतीजा निकला जिसे पलटने में अब किसी को एक सप्ताहांत लगाना है।',
  'Shloka man ke baare mein hai aur yeh ek kamra hai, aur mechanism itna ek jaisa hai ki kaam aata hai. Kuch tay nahi hua, koi asli maqsad ke khilaf nahi tha, aur atharah mahine koi uske saath na hone se aisa nateeja nikla jise palatne mein ab kisi ko ek weekend lagana hai.',
  'Nobody decided it was storage. Eighteen months of nobody deciding anything decided it.',
  'किसी ने तय नहीं किया कि यह गोदाम है। अठारह महीने किसी के कुछ तय न करने ने तय कर दिया।',
  'Kisi ne tay nahi kiya ki yeh godaam hai. Atharah mahine kisi ke kuch tay na karne ne tay kar diya.',
  NULL, 'beginner', 'home,neglect,drift,decisions,ordinary'

  UNION ALL SELECT 6, 'startup', 4,
  'The founder who got a handle on Wednesdays', 'वह संस्थापक जिसे बुधवार पर पकड़ मिली', 'Woh founder jise Wednesday par pakad mili',
  'A founder whose weeks are chaos cannot fix the weeks. She fixes Wednesday morning: nothing scheduled, one hard problem, same room. Everything else stays chaotic for another year. She describes Wednesday afterwards as the thing that made the year survivable and is clear that it did not make the year good.',
  'एक संस्थापक जिसके हफ़्ते अफ़रा-तफ़री हैं, वह हफ़्ते ठीक नहीं कर पातीं। वे बुधवार की सुबह ठीक करती हैं: कुछ भी तय नहीं, एक कठिन समस्या, वही कमरा। बाक़ी सब एक साल और अफ़रा-तफ़री ही रहता है। वे बाद में बुधवार को वह चीज़ बताती हैं जिसने साल झेलने लायक बनाया, और साफ़ कहती हैं कि उसने साल अच्छा नहीं बनाया।',
  'Ek founder jiske hafte afra-tafri hain, woh hafte theek nahi kar paatin. Woh Wednesday ki subah theek karti hain: kuch bhi tay nahi, ek mushkil samasya, wahi kamra. Baaki sab ek saal aur afra-tafri hi rehta hai. Woh baad mein Wednesday ko woh cheez batati hain jisne saal jhelne layak banaya, aur saaf kehti hain ki usne saal achha nahi banaya.',
  'The verse says which version you get depends on whether you have any purchase at all — and any is doing the work in that sentence. One morning out of five is not control of the week. It was enough for the machinery to start working with her somewhere, and she is honest that somewhere was the whole of it.',
  'श्लोक कहता है कि कौन-सा रूप मिलेगा यह इस पर टिका है कि आपको कोई पकड़ मिली है या नहीं — और उस वाक्य में "कोई" ही काम कर रहा है। पाँच में से एक सुबह पूरे हफ़्ते पर क़ाबू नहीं है। यह इतना काफ़ी था कि मशीन कहीं तो उनके साथ काम करने लगे, और वे ईमानदारी से कहती हैं कि वह "कहीं" ही सब कुछ था।',
  'Shloka kehta hai ki kaun sa roop milega yeh is par tika hai ki tumhe koi pakad mili hai ya nahi — aur us vakya mein "koi" hi kaam kar raha hai. Paanch mein se ek subah poore hafte par kaabu nahi hai. Yeh itna kaafi tha ki machine kahin to unke saath kaam karne lage, aur woh imaandari se kehti hain ki woh "kahin" hi sab kuch tha.',
  'One morning out of five is not control of the week. The verse only asks for some purchase, not all of it.',
  'पाँच में से एक सुबह पूरे हफ़्ते पर क़ाबू नहीं है। श्लोक थोड़ी पकड़ माँगता है, पूरी नहीं।',
  'Paanch mein se ek subah poore hafte par kaabu nahi hai. Shloka thodi pakad maangta hai, poori nahi.',
  NULL, 'intermediate', 'business,chaos,routine,agency,honesty'

  UNION ALL SELECT 17, 'healthcare', 1,
  'The patient who was not eating enough', 'वह मरीज़ जो पर्याप्त नहीं खा रहा था', 'Woh mareez jo paryapt nahi kha raha tha',
  'Somebody recovering from an illness is doing everything right by their own account: no rich food, early nights, no strain. Their recovery stalls. The dietitian''s finding is not a discipline problem in the direction anybody expected — the body rebuilding tissue needed more than the body at rest, and less had been quietly treated as safer for four months.',
  'बीमारी से उबर रहा कोई अपने हिसाब से सब कुछ ठीक कर रहा है: कोई भारी खाना नहीं, जल्दी सोना, कोई ज़ोर नहीं। उनका उबरना अटक जाता है। आहार विशेषज्ञ का निष्कर्ष उस दिशा में अनुशासन की समस्या नहीं है जिसकी किसी ने उम्मीद की थी — ऊतक दोबारा बना रहे शरीर को आराम कर रहे शरीर से ज़्यादा चाहिए था, और चार महीने से "कम" को चुपचाप ज़्यादा सुरक्षित मान लिया गया था।',
  'Bimari se ubar raha koi apne hisaab se sab kuch theek kar raha hai: koi bhaari khana nahi, jaldi sona, koi zor nahi. Unka ubarna atak jaata hai. Aahar visheshagya ka nishkarsh us disha mein anushasan ki samasya nahi hai jiski kisi ne ummeed ki thi — utak dobara bana rahe sharir ko aaram kar rahe sharir se zyada chahiye tha, aur chaar mahine se "kam" ko chupchap zyada surakshit maan liya gaya tha.',
  'The verse before this one rules out both ways of getting it wrong, and this is the half that gets skipped. Yukta means fitted to what you are actually doing, and what this person was actually doing had changed. Less is not automatically safer, and the text never says it is.',
  'इससे पहले वाला श्लोक ग़लत होने के दोनों तरीक़े ख़ारिज करता है, और यही वह आधा है जो छोड़ दिया जाता है। युक्त का मतलब है — जो आप सचमुच कर रहे हैं उसके नाप का, और यह व्यक्ति सचमुच जो कर रहा था वह बदल चुका था। "कम" अपने आप सुरक्षित नहीं होता, और ग्रंथ ऐसा कभी नहीं कहता।',
  'Isse pehle wala shloka galat hone ke dono tareeke khaarij karta hai, aur yahi woh aadha hai jo chhod diya jaata hai. Yukta ka matlab hai — jo tum sach mein kar rahe ho uske naap ka, aur yeh insaan sach mein jo kar raha tha woh badal chuka tha. "Kam" apne aap surakshit nahi hota, aur granth aisa kabhi nahi kehta.',
  'Less is not automatically safer. Fitted means fitted to what you are actually doing now.',
  '"कम" अपने आप सुरक्षित नहीं होता। युक्त का मतलब है — जो आप अभी सचमुच कर रहे हैं उसके नाप का।',
  '"Kam" apne aap surakshit nahi hota. Yukta ka matlab hai — jo tum abhi sach mein kar rahe ho uske naap ka.',
  NULL, 'intermediate', 'health,recovery,moderation,assumptions,balance'

  UNION ALL SELECT 17, 'corporate', 2,
  'The four-hour day and the fourteen-hour one', 'चार घंटे का दिन और चौदह घंटे का', 'Chaar ghante ka din aur chaudah ghante ka',
  'A consultant works to whatever the week demands: some weeks are almost empty and some run to fourteen-hour days. Over a year the total is unremarkable. Her sleep, her temper and her output are all noticeably worse than a colleague working the same annual total spread evenly, and the two of them have compared notes enough to be sure of it.',
  'एक सलाहकार जितना हफ़्ता माँगे उतना काम करती हैं: कुछ हफ़्ते लगभग ख़ाली और कुछ में चौदह-चौदह घंटे के दिन। साल भर का कुल जोड़ कोई ख़ास नहीं है। उनकी नींद, उनका मिज़ाज और उनका काम — तीनों उस सहकर्मी से साफ़ तौर पर ख़राब हैं जो उतना ही सालाना कुल बराबर बाँटकर करती है, और दोनों ने आपस में इतनी बार मिलाया है कि उन्हें पक्का पता है।',
  'Ek salahkar jitna hafta maange utna kaam karti hain: kuch hafte lagbhag khaali aur kuch mein chaudah-chaudah ghante ke din. Saal bhar ka kul jod koi khaas nahi hai. Unki neend, unka mizaaj aur unka kaam — teenon us colleague se saaf taur par kharab hain jo utna hi saalana kul barabar baantkar karti hai, aur dono ne aapas mein itni baar milaya hai ki unhe pakka pata hai.',
  'Yukta is about fit rather than total, which is exactly what this comparison isolates. The annual number was the same. The verse asks for measure in eating, moving, working and sleeping as four things held at once, and an average across a year is not the same as measure.',
  'युक्त कुल जोड़ का नहीं, ठीक बैठने का मामला है — और यह तुलना ठीक वही अलग करके दिखाती है। सालाना आँकड़ा एक जैसा था। श्लोक खाने, चलने, काम और नींद में नाप माँगता है, चारों एक साथ थामे हुए, और साल भर का औसत नाप नहीं है।',
  'Yukta kul jod ka nahi, theek baithne ka mamla hai — aur yeh tulna theek wahi alag karke dikhati hai. Saalana aankda ek jaisa tha. Shloka khaane, chalne, kaam aur neend mein naap maangta hai, chaaron ek saath thame hue, aur saal bhar ka ausat naap nahi hai.',
  'The annual total was the same. An average across a year is not the same thing as measure.',
  'सालाना कुल जोड़ एक जैसा था। साल भर का औसत नाप नहीं होता।',
  'Saalana kul jod ek jaisa tha. Saal bhar ka ausat naap nahi hota.',
  NULL, 'intermediate', 'work,hours,balance,sleep,consistency'

  UNION ALL SELECT 17, 'college', 3,
  'The week before, and the week after', 'पहले वाला हफ़्ता, और बाद वाला', 'Pehle wala hafta, aur baad wala',
  'A student does almost nothing for eleven weeks and then does not sleep for two. It works, in the sense that the marks are acceptable. What is also true is that the fortnight afterwards is a write-off every single term, and this has now happened six terms running with the same person expressing surprise each time.',
  'एक छात्र ग्यारह हफ़्ते लगभग कुछ नहीं करता और फिर दो हफ़्ते सोता नहीं। यह चलता है, इस मायने में कि अंक ठीक-ठाक आते हैं। यह भी सच है कि बाद के पंद्रह दिन हर सत्र में बेकार जाते हैं, और यह अब लगातार छह सत्रों से हो रहा है, और हर बार वही व्यक्ति हैरानी जताता है।',
  'Ek student gyarah hafte lagbhag kuch nahi karta aur phir do hafte sota nahi. Yeh chalta hai, is maayne mein ki ank theek-thaak aate hain. Yeh bhi sach hai ki baad ke pandrah din har term mein bekaar jaate hain, aur yeh ab lagatar chhah term se ho raha hai, aur har baar wahi insaan hairani jataata hai.',
  'Both extremes in one term, from the same person, which is what makes this the clearest version. The verse is not asking for less effort in the fortnight; it is pointing out that a pattern of nothing-then-everything is measured in neither direction, and that the cost is paid in the weeks nobody counts.',
  'एक ही सत्र में दोनों अतियाँ, एक ही व्यक्ति से — और यही इसे सबसे साफ़ रूप बनाता है। श्लोक उन पंद्रह दिनों में कम मेहनत नहीं माँग रहा; वह बता रहा है कि "कुछ नहीं, फिर सब कुछ" वाला ढर्रा किसी भी दिशा में नपा हुआ नहीं है, और क़ीमत उन हफ़्तों में चुकती है जिन्हें कोई गिनता नहीं।',
  'Ek hi term mein dono atiyan, ek hi insaan se — aur yahi ise sabse saaf roop banata hai. Shloka un pandrah dinon mein kam mehnat nahi maang raha; woh bata raha hai ki "kuch nahi, phir sab kuch" wala dharra kisi bhi disha mein napa hua nahi hai, aur keemat un hafton mein chukti hai jinhe koi ginta nahi.',
  'Nothing-then-everything is not measured in either direction, and the cost lands in the weeks nobody counts.',
  '"कुछ नहीं, फिर सब कुछ" किसी भी दिशा में नपा हुआ नहीं है, और क़ीमत उन हफ़्तों में गिरती है जिन्हें कोई गिनता नहीं।',
  '"Kuch nahi, phir sab kuch" kisi bhi disha mein napa hua nahi hai, aur keemat un hafton mein girti hai jinhe koi ginta nahi.',
  NULL, 'beginner', 'study,cramming,balance,sleep,patterns'

  UNION ALL SELECT 17, 'sports', 4,
  'The rest day the coach enforced', 'वह आराम का दिन जो कोच ने लागू किया', 'Woh aaram ka din jo coach ne lagoo kiya',
  'An athlete who trains willingly and hard is told to take a full day off each week and resists it for a month. The coach does not argue about commitment; he shows her twelve weeks of her own numbers. The numbers do not care what either of them thinks and they are unambiguous.',
  'एक खिलाड़ी जो ख़ुशी से और कड़ी ट्रेनिंग करती है, उससे कहा जाता है कि हफ़्ते में एक पूरा दिन छुट्टी ले, और वह महीना भर इसका विरोध करती है। कोच प्रतिबद्धता पर बहस नहीं करते; वे उसे उसके अपने बारह हफ़्तों के आँकड़े दिखा देते हैं। आँकड़ों को इससे मतलब नहीं कि दोनों क्या सोचते हैं और वे साफ़ हैं।',
  'Ek khiladi jo khushi se aur kadi training karti hai, usse kaha jaata hai ki hafte mein ek poora din chhutti le, aur woh mahina bhar iska virodh karti hai. Coach pratibaddhata par behes nahi karte; woh use uske apne barah hafton ke aankde dikha dete hain. Aankdon ko isse matlab nahi ki dono kya sochte hain aur woh saaf hain.',
  'Yukta is about what fits the work, and here more did not. The verse names moving about and effort as two of the four things to be measured in, and it is worth noticing that resistance to the rest day was itself the symptom — somebody measured would not have needed a month.',
  'युक्त का मतलब है जो काम के नाप का हो, और यहाँ "ज़्यादा" उस नाप का नहीं था। श्लोक चलने-फिरने और मेहनत को नापी जाने वाली चार चीज़ों में से दो बताता है, और ध्यान देने लायक है कि आराम के दिन का विरोध ख़ुद एक लक्षण था — नपे हुए व्यक्ति को महीना नहीं लगता।',
  'Yukta ka matlab hai jo kaam ke naap ka ho, aur yahan "zyada" us naap ka nahi tha. Shloka chalne-firne aur mehnat ko naapi jaane wali chaar cheezon mein se do batata hai, aur dhyan dene layak hai ki aaram ke din ka virodh khud ek lakshan tha — nape hue insaan ko mahina nahi lagta.',
  'The resistance to the rest day was itself the symptom. Somebody measured would not have needed a month.',
  'आराम के दिन का विरोध ख़ुद ही लक्षण था। नपे हुए व्यक्ति को महीना नहीं लगता।',
  'Aaram ke din ka virodh khud hi lakshan tha. Nape hue insaan ko mahina nahi lagta.',
  NULL, 'intermediate', 'sport,training,rest,balance,evidence'

  UNION ALL SELECT 19, 'everyday_life', 1,
  'The notification that was the draught', 'वह नोटिफ़िकेशन जो हवा था', 'Woh notification jo hawa tha',
  'Somebody who cannot concentrate tries harder for six weeks: earlier starts, longer blocks, more coffee. Nothing improves. In the seventh week they turn off notifications for one application and the afternoon becomes usable. They report being slightly annoyed about the six weeks.',
  'जिससे ध्यान नहीं लगता, वह छह हफ़्ते ज़्यादा ज़ोर लगाता है: जल्दी शुरुआत, लंबे ब्लॉक, ज़्यादा कॉफ़ी। कुछ नहीं सुधरता। सातवें हफ़्ते वह एक ऐप्लिकेशन के नोटिफ़िकेशन बंद कर देता है और दोपहर काम लायक हो जाती है। वह बताता है कि उन छह हफ़्तों पर उसे हल्की खीझ है।',
  'Jisse dhyan nahi lagta, woh chhah hafte zyada zor lagata hai: jaldi shuruaat, lambe block, zyada coffee. Kuch nahi sudharta. Saatve hafte woh ek application ke notification band kar deta hai aur dopahar kaam layak ho jaati hai. Woh batata hai ki un chhah hafton par use halki kheejh hai.',
  'Six weeks of trying to burn brighter, one afternoon of removing the draught. The image is doing real work here: the flame was never the problem, and every intervention aimed at the flame was correctly executed and pointed at the wrong thing.',
  'छह हफ़्ते ज़्यादा तेज़ जलने की कोशिश, और एक दोपहर हवा हटाने की। यहाँ तस्वीर सचमुच काम कर रही है: लौ कभी समस्या थी ही नहीं, और लौ पर निशाना लगाने वाला हर उपाय ठीक से किया गया और ग़लत चीज़ की तरफ़ था।',
  'Chhah hafte zyada tez jalne ki koshish, aur ek dopahar hawa hatane ki. Yahan tasveer sach mein kaam kar rahi hai: lau kabhi samasya thi hi nahi, aur lau par nishana lagane wala har upay theek se kiya gaya aur galat cheez ki taraf tha.',
  'Every intervention aimed at the flame was done correctly and pointed at the wrong thing.',
  'लौ पर निशाना लगाने वाला हर उपाय ठीक से किया गया और ग़लत चीज़ की तरफ़ था।',
  'Lau par nishana lagane wala har upay theek se kiya gaya aur galat cheez ki taraf tha.',
  NULL, 'beginner', 'focus,attention,environment,distraction,work'

  UNION ALL SELECT 19, 'school', 2,
  'The child at the back by the door', 'दरवाज़े के पास पीछे बैठा बच्चा', 'Darwaze ke paas peechhe baitha bachcha',
  'A child described for two years as unable to settle is moved, for unrelated reasons, from the seat beside the corridor door to one by the window. The change in how much work he finishes is large enough that his teacher mentions it unprompted at the next parents'' evening.',
  'दो साल से जिस बच्चे के बारे में कहा जा रहा है कि वह टिक नहीं पाता, उसे किसी और वजह से गलियारे के दरवाज़े के बगल वाली सीट से खिड़की के पास वाली सीट पर बिठा दिया जाता है। वह कितना काम पूरा करता है, इसमें फ़र्क़ इतना बड़ा है कि अगली अभिभावक-शाम में उसकी शिक्षिका बिना पूछे इसका ज़िक्र करती हैं।',
  'Do saal se jis bachche ke baare mein kaha ja raha hai ki woh tik nahi paata, use kisi aur wajah se galiyare ke darwaze ke bagal wali seat se khidki ke paas wali seat par bitha diya jaata hai. Woh kitna kaam poora karta hai, isme farq itna bada hai ki agli parents-evening mein uski teacher bina poochhe iska zikr karti hain.',
  'Two years of a description that turned out to be about a seat. The verse offers subtraction where almost everything else offers addition, and this is why that matters: nobody had tried removing anything, because the account of the problem was about the child.',
  'दो साल का वह वर्णन जो निकला एक सीट के बारे में। श्लोक घटाना देता है जहाँ लगभग बाक़ी सब जोड़ना देते हैं, और यही मायने रखता है: किसी ने कुछ हटाकर देखा ही नहीं था, क्योंकि समस्या का बयान बच्चे के बारे में था।',
  'Do saal ka woh varnan jo nikla ek seat ke baare mein. Shloka ghatana deta hai jahan lagbhag baaki sab jodna dete hain, aur yahi maayne rakhta hai: kisi ne kuch hatakar dekha hi nahi tha, kyunki samasya ka bayan bachche ke baare mein tha.',
  'Nobody tried removing anything, because the account of the problem was about the child.',
  'किसी ने कुछ हटाकर नहीं देखा, क्योंकि समस्या का बयान बच्चे के बारे में था।',
  'Kisi ne kuch hatakar nahi dekha, kyunki samasya ka bayan bachche ke baare mein tha.',
  NULL, 'intermediate', 'school,children,environment,attention,labels'

  UNION ALL SELECT 19, 'cricket', 3,
  'Still at the crease', 'क्रीज़ पर स्थिर', 'Crease par sthir',
  'Two batsmen at the same level face the same bowling. One fidgets — glove, guard, a look at the sightscreen, a shuffle. The other does almost nothing between deliveries. Neither is calmer than the other by temperament; the second one worked on it, and commentators describe him with the word still without ever explaining what they mean.',
  'एक ही स्तर के दो बल्लेबाज़ वही गेंदबाज़ी खेल रहे हैं। एक हिलता-डुलता रहता है — दस्ताना, गार्ड, साइटस्क्रीन की तरफ़ एक नज़र, पैरों की हरकत। दूसरा गेंदों के बीच लगभग कुछ नहीं करता। स्वभाव से दोनों में कोई दूसरे से शांत नहीं है; दूसरे ने इस पर काम किया, और कमेंटेटर उसके लिए "स्थिर" शब्द इस्तेमाल करते हैं और कभी नहीं बताते कि उनका मतलब क्या है।',
  'Ek hi star ke do batsman wahi bowling khel rahe hain. Ek hilta-dulta rehta hai — dastana, guard, sightscreen ki taraf ek nazar, pairon ki harkat. Doosra gendon ke beech lagbhag kuch nahi karta. Swabhav se dono mein koi doosre se shaant nahi hai; doosre ne is par kaam kiya, aur commentator uske liye "sthir" shabd istemaal karte hain aur kabhi nahi batate ki unka matlab kya hai.',
  'What the commentators are describing without a vocabulary for it is the lamp. Not more talent and not more intensity — the same player with the flicker taken out. And the second batsman built it, which is the part the word still never conveys.',
  'कमेंटेटर बिना शब्दावली के जिसका वर्णन कर रहे हैं वह दीया है। और प्रतिभा नहीं, और तीव्रता नहीं — वही खिलाड़ी, कँपकँपी हटाकर। और दूसरे बल्लेबाज़ ने उसे बनाया, और "स्थिर" शब्द यह हिस्सा कभी नहीं बताता।',
  'Commentator bina shabdavali ke jiska varnan kar rahe hain woh diya hai. Aur pratibha nahi, aur teevrata nahi — wahi khiladi, kampkampi hatakar. Aur doosre batsman ne use banaya, aur "sthir" shabd yeh hissa kabhi nahi batata.',
  'Not more talent. The same player, with the flicker taken out, and he built that.',
  'और प्रतिभा नहीं। वही खिलाड़ी, कँपकँपी हटाकर — और वह उसने बनाया।',
  'Aur pratibha nahi. Wahi khiladi, kampkampi hatakar — aur woh usne banaya.',
  NULL, 'beginner', 'cricket,stillness,routine,composure,practice'

  UNION ALL SELECT 19, 'technology', 4,
  'The build that failed intermittently', 'वह बिल्ड जो कभी-कभी फ़ेल होता था', 'Woh build jo kabhi-kabhi fail hota tha',
  'A test suite fails about one run in nine. Three engineers spend a fortnight making the tests more robust — retries, longer timeouts, better assertions. A fourth spends an afternoon finding the shared fixture two tests were both writing to. After that the suite passes every time and all the robustness work is still in the codebase.',
  'एक टेस्ट सूट नौ में से क़रीब एक बार फ़ेल होता है। तीन इंजीनियर पंद्रह दिन टेस्ट को ज़्यादा मज़बूत बनाने में लगाते हैं — रीट्राई, लंबे टाइमआउट, बेहतर असर्शन। चौथा एक दोपहर में वह साझा फ़िक्स्चर ढूँढ़ लेता है जिस पर दो टेस्ट एक साथ लिख रहे थे। उसके बाद सूट हर बार पास होता है और मज़बूती वाला सारा काम कोडबेस में पड़ा रह जाता है।',
  'Ek test suite nau mein se karib ek baar fail hota hai. Teen engineer pandrah din test ko zyada mazboot banane mein lagate hain — retry, lambe timeout, behtar assertion. Chautha ek dopahar mein woh saajha fixture dhoondh leta hai jis par do test ek saath likh rahe the. Uske baad suite har baar pass hota hai aur mazbooti wala saara kaam codebase mein pada reh jaata hai.',
  'Two weeks of making the flame stronger and one afternoon of closing the window. The leftover robustness work is the detail worth keeping — it was not wrong, it was just aimed at a flame that had never been the problem, and now it is permanent overhead.',
  'दो हफ़्ते लौ को मज़बूत करने के और एक दोपहर खिड़की बंद करने की। बची हुई मज़बूती वाला काम रखने लायक ब्यौरा है — वह ग़लत नहीं था, वह बस उस लौ पर निशाना लगा रहा था जो कभी समस्या थी ही नहीं, और अब वह स्थायी बोझ है।',
  'Do hafte lau ko mazboot karne ke aur ek dopahar khidki band karne ki. Bachi hui mazbooti wala kaam rakhne layak byora hai — woh galat nahi tha, woh bas us lau par nishana laga raha tha jo kabhi samasya thi hi nahi, aur ab woh sthayi bojh hai.',
  'The robustness work was not wrong. It was aimed at a flame that had never been the problem, and it is permanent now.',
  'मज़बूती वाला काम ग़लत नहीं था। वह उस लौ पर था जो कभी समस्या थी ही नहीं, और अब वह स्थायी है।',
  'Mazbooti wala kaam galat nahi tha. Woh us lau par tha jo kabhi samasya thi hi nahi, aur ab woh sthayi hai.',
  NULL, 'advanced', 'technology,debugging,root-cause,effort,systems'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 6;

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

  SELECT 26 AS vn, 'everyday_life' AS cat, 1 AS ord,
  'Two hundred returns' AS t_en, 'दो सौ बार लौटना' AS t_hi, 'Do sau baar lautna' AS t_hing,
  'Somebody tries sitting quietly for ten minutes and reports afterwards that it did not work: the mind went to a work email roughly every fifteen seconds. Asked how many times they brought it back, they say they did not count, and then, after a moment, that it must have been dozens.' AS s_en,
  'कोई दस मिनट चुपचाप बैठने की कोशिश करता है और बाद में बताता है कि यह चला नहीं: मन क़रीब हर पंद्रह सेकंड में एक काम की ईमेल पर चला जाता रहा। पूछने पर कि उसने कितनी बार उसे वापस लाया, वह कहता है कि गिना नहीं, और फिर, एक पल बाद, कि दर्जनों बार तो रहा ही होगा।' AS s_hi,
  'Koi das minute chupchap baithne ki koshish karta hai aur baad mein batata hai ki yeh chala nahi: man karib har pandrah second mein ek kaam ki email par chala jaata raha. Poochne par ki usne kitni baar use wapas laya, woh kehta hai ki gina nahi, aur phir, ek pal baad, ki darjanon baar to raha hi hoga.' AS s_hing,
  'The verse builds the instruction as a repeating structure — from wherever, from there — and does not treat the wandering as a fault. By the verse''s own accounting this person did the practice dozens of times in ten minutes, which is not what "it did not work" describes.' AS c_en,
  'श्लोक हिदायत को दोहराई जाने वाली बनावट की तरह बनाता है — जहाँ-जहाँ से, वहीं-वहीं से — और भटकने को ख़ामी नहीं मानता। श्लोक के अपने हिसाब से इस व्यक्ति ने दस मिनट में दर्जनों बार अभ्यास किया, और "यह चला नहीं" इसका वर्णन नहीं है।' AS c_hi,
  'Shloka hidayat ko dohrayi jaane wali banavat ki tarah banata hai — jahan-jahan se, wahin-wahin se — aur bhatakne ko khami nahi maanta. Shloka ke apne hisaab se is insaan ne das minute mein darjanon baar abhyas kiya, aur "yeh chala nahi" iska varnan nahi hai.' AS c_hing,
  'By the verse''s own accounting they did the practice dozens of times. They reported it as a failure.' AS l_en,
  'श्लोक के अपने हिसाब से उन्होंने दर्जनों बार अभ्यास किया। उन्होंने इसे नाकामी बताया।' AS l_hi,
  'Shloka ke apne hisaab se unhone darjanon baar abhyas kiya. Unhone ise nakami bataya.' AS l_hing,
  NULL AS src, 'beginner' AS diff, 'practice,attention,expectations,meditation,ordinary' AS tags

  UNION ALL SELECT 26, 'school', 2,
  'The child who was brought back', 'वह बच्चा जिसे वापस लाया गया', 'Woh bachcha jise wapas laya gaya',
  'A teacher with a class of thirty has one child whose attention leaves every few minutes. She does not raise her voice and does not comment on it. She goes over, puts a finger on the page, and moves on. Over a year the interval lengthens, and neither of them ever discusses the arrangement.',
  'तीस बच्चों की कक्षा वाली एक शिक्षिका के पास एक बच्चा है जिसका ध्यान हर कुछ मिनट में चला जाता है। वे आवाज़ ऊँची नहीं करतीं और उस पर टिप्पणी नहीं करतीं। वे पास जाकर पन्ने पर उँगली रखती हैं और आगे बढ़ जाती हैं। साल भर में अंतराल बढ़ता जाता है, और दोनों में से कोई इस इंतज़ाम की चर्चा कभी नहीं करता।',
  'Tees bachchon ki class wali ek teacher ke paas ek bachcha hai jiska dhyan har kuch minute mein chala jaata hai. Woh aawaz oonchi nahi karti aur us par tippani nahi karti. Woh paas jaakar panne par ungli rakhti hain aur aage badh jaati hain. Saal bhar mein antaral badhta jaata hai, aur dono mein se koi is intezaam ki charcha kabhi nahi karta.',
  'This is the instruction performed by somebody else on your behalf, and it shows what the tone of it is meant to be. She is not correcting him and she is not disappointed. From wherever it went, back — repeated without comment, several hundred times, until the interval changed.',
  'यह वही हिदायत है जो कोई और आपकी तरफ़ से निभा रहा है, और इससे पता चलता है कि इसका लहजा कैसा होना चाहिए। वे उसे सुधार नहीं रहीं और निराश भी नहीं हैं। जहाँ से गया, वहीं से वापस — बिना टिप्पणी के, कई सौ बार, जब तक अंतराल बदल नहीं गया।',
  'Yeh wahi hidayat hai jo koi aur tumhari taraf se nibha raha hai, aur isse pata chalta hai ki iska lehja kaisa hona chahiye. Woh use sudhaar nahi rahi aur nirash bhi nahi hain. Jahan se gaya, wahin se wapas — bina tippani ke, kai sau baar, jab tak antaral badal nahi gaya.',
  'She was not correcting him and was not disappointed. That is the tone the instruction is meant to have.',
  'वे उसे सुधार नहीं रही थीं और निराश भी नहीं थीं। हिदायत का लहजा वही होना चाहिए।',
  'Woh use sudhaar nahi rahi thi aur nirash bhi nahi thi. Hidayat ka lehja wahi hona chahiye.',
  NULL, 'beginner', 'school,attention,patience,teaching,children'

  UNION ALL SELECT 26, 'social_media', 3,
  'Where it goes', 'यह जहाँ जाता है', 'Yeh jahan jaata hai',
  'Somebody keeps a note for a week of what their mind goes to when it drifts. The list is shorter than they expected — four things, and one of them accounts for most of it. They had assumed it was random and it is not remotely random.',
  'कोई एक हफ़्ते तक यह लिखता है कि भटकने पर उसका मन कहाँ जाता है। सूची उसकी उम्मीद से छोटी है — चार चीज़ें, और उनमें से एक ही ज़्यादातर हिस्सा घेरती है। उसने मान रखा था कि यह बेतरतीब है और यह बिलकुल भी बेतरतीब नहीं है।',
  'Koi ek hafte tak yeh likhta hai ki bhatakne par uska man kahan jaata hai. List uski ummeed se chhoti hai — chaar cheezein, aur unme se ek hi zyadatar hissa gherti hai. Usne maan rakha tha ki yeh betarteeb hai aur yeh bilkul bhi betarteeb nahi hai.',
  'The verse says yato yatas — from wherever — and treats the destination as incidental. It usually is not. Bringing it back is the instruction; noticing that it keeps going to the same four places is a piece of free information the instruction hands you if you are paying attention while you follow it.',
  'श्लोक कहता है यतो यतः — जहाँ-जहाँ से — और मंज़िल को गौण मानता है। आमतौर पर वह गौण होती नहीं। वापस लाना हिदायत है; यह नोटिस करना कि वह बार-बार उन्हीं चार जगहों पर जाता है, वह मुफ़्त जानकारी है जो हिदायत आपको तब देती है जब आप उस पर चलते हुए ध्यान भी दे रहे हों।',
  'Shloka kehta hai yato yatah — jahan-jahan se — aur manzil ko gaun maanta hai. Aam taur par woh gaun hoti nahi. Wapas laana hidayat hai; yeh notice karna ki woh baar-baar unhi chaar jagahon par jaata hai, woh muft jaankari hai jo hidayat tumhe tab deti hai jab tum us par chalte hue dhyan bhi de rahe ho.',
  'You assumed it was random. Write down where it goes for a week and it will not be.',
  'आपने माना कि यह बेतरतीब है। एक हफ़्ता लिखिए कि यह कहाँ जाता है, और यह बेतरतीब नहीं निकलेगा।',
  'Tumne maana ki yeh betarteeb hai. Ek hafta likho ki yeh kahan jaata hai, aur yeh betarteeb nahi niklega.',
  NULL, 'intermediate', 'attention,patterns,noticing,distraction,self-knowledge'

  UNION ALL SELECT 26, 'marriage', 4,
  'Back to the actual sentence', 'फिर उसी वाक्य पर', 'Phir usi vakya par',
  'A couple who argue badly agree on one rule: when either of them notices the conversation has moved to a different grievance, they say so and go back to the original one. It works about half the time. The half where it works, they report, is the difference between a disagreement and an evening.',
  'बुरी तरह झगड़ने वाला एक जोड़ा एक नियम पर सहमत होता है: जब भी दोनों में से किसी को लगे कि बातचीत किसी और शिकायत पर चली गई है, वह कह देगा और दोनों मूल बात पर लौट आएँगे। यह क़रीब आधी बार चलता है। जिन आधी बार चलता है, वे बताते हैं, वही एक असहमति और एक पूरी शाम का फ़र्क़ है।',
  'Buri tarah jhagadne wala ek joda ek niyam par sehmat hota hai: jab bhi dono mein se kisi ko lage ki baatchit kisi aur shikayat par chali gayi hai, woh keh dega aur dono mool baat par laut aayenge. Yeh karib aadhi baar chalta hai. Jin aadhi baar chalta hai, woh batate hain, wahi ek asahmati aur ek poori shaam ka farq hai.',
  'The same instruction applied to a conversation instead of a mind, and the same accounting applies. Half the time is not a failure rate — the alternative was zero, and nobody in this story is claiming to have stopped drifting. They just added the returning.',
  'वही हिदायत, मन की जगह बातचीत पर लगाई गई, और वही हिसाब लागू होता है। आधी बार चलना नाकामी की दर नहीं है — विकल्प शून्य था, और इस कहानी में कोई यह दावा नहीं कर रहा कि भटकना बंद हो गया। उन्होंने बस लौटना जोड़ लिया।',
  'Wahi hidayat, man ki jagah baatchit par lagayi gayi, aur wahi hisaab lagoo hota hai. Aadhi baar chalna nakami ki dar nahi hai — vikalp shoonya tha, aur is kahani mein koi yeh dawa nahi kar raha ki bhatakna band ho gaya. Unhone bas lautna jod liya.',
  'Nobody claimed to have stopped drifting. They added the returning, and half the time was the whole gain.',
  'किसी ने यह दावा नहीं किया कि भटकना बंद हो गया। उन्होंने लौटना जोड़ लिया, और आधी बार ही पूरा फ़ायदा था।',
  'Kisi ne yeh dawa nahi kiya ki bhatakna band ho gaya. Unhone lautna jod liya, aur aadhi baar hi poora fayda tha.',
  NULL, 'intermediate', 'marriage,arguments,attention,returning,repair'

  UNION ALL SELECT 34, 'everyday_life', 1,
  'Everybody else seems to manage', 'बाक़ी सबसे तो हो जाता है', 'Baaki sabse to ho jaata hai',
  'Somebody who has tried and abandoned a quiet-sitting practice four times assumes the problem is specific to them, because the people who recommend it describe it as simple. At a group session somebody asks whether anybody actually finds this easy, and eleven of the fourteen people present laugh.',
  'जिसने चुपचाप बैठने का अभ्यास चार बार आज़माकर छोड़ा है, वह मान लेता है कि दिक़्क़त ख़ास उसी में है, क्योंकि जो लोग इसकी सिफ़ारिश करते हैं वे इसे आसान बताते हैं। एक सामूहिक सत्र में कोई पूछता है कि क्या सचमुच किसी को यह आसान लगता है, और वहाँ मौजूद चौदह में से ग्यारह लोग हँस पड़ते हैं।',
  'Jisne chupchap baithne ka abhyas chaar baar aazmakar chhoda hai, woh maan leta hai ki dikkat khaas usi mein hai, kyunki jo log iski sifarish karte hain woh ise aasan batate hain. Ek samoohik session mein koi poochta hai ki kya sach mein kisi ko yeh aasan lagta hai, aur wahan maujood chaudah mein se gyarah log hans padte hain.',
  'This is why Arjuna''s objection is in the book. The difficulty is standard and the reporting of it is not, so anybody meeting it privately concludes it is theirs. A text that keeps the student saying "this cannot be done" is doing for the reader what those eleven people did in that room.',
  'इसीलिए अर्जुन की आपत्ति किताब में है। कठिनाई आम है और उसका ज़िक्र आम नहीं, इसलिए जो अकेले उससे टकराता है वह मान लेता है कि यह उसी की है। जो ग्रंथ छात्र के "यह हो ही नहीं सकता" को रहने देता है, वह पाठक के लिए वही कर रहा है जो उस कमरे में उन ग्यारह लोगों ने किया।',
  'Isiliye Arjun ki aapatti kitaab mein hai. Kathinai aam hai aur uska zikr aam nahi, isliye jo akele usse takrata hai woh maan leta hai ki yeh usi ki hai. Jo granth chhatra ke "yeh ho hi nahi sakta" ko rehne deta hai, woh padhne wale ke liye wahi kar raha hai jo us kamre mein un gyarah logon ne kiya.',
  'The difficulty is standard. The reporting of it is not, which is why everybody concludes it is theirs alone.',
  'कठिनाई आम है। उसका ज़िक्र आम नहीं, और इसीलिए हर कोई मान लेता है कि वह अकेले उसी की है।',
  'Kathinai aam hai. Uska zikr aam nahi, aur isiliye har koi maan leta hai ki woh akele usi ki hai.',
  NULL, 'beginner', 'practice,difficulty,shame,honesty,groups'

  UNION ALL SELECT 34, 'college', 2,
  'The question nobody asks', 'वह सवाल जो कोई नहीं पूछता', 'Woh sawaal jo koi nahi poochta',
  'A lecturer finishes a difficult derivation and asks whether that was clear. Nobody says anything. One student asks a question that begins with an apology, and afterwards six people tell her separately that they had not followed it either.',
  'एक व्याख्याता कठिन गणना पूरी करके पूछते हैं कि यह साफ़ हुआ या नहीं। कोई कुछ नहीं कहता। एक छात्रा माफ़ी से शुरू करते हुए सवाल पूछती है, और बाद में छह लोग अलग-अलग आकर उससे कहते हैं कि उन्हें भी समझ नहीं आया था।',
  'Ek lecturer mushkil ganana poori karke poochte hain ki yeh saaf hua ya nahi. Koi kuch nahi kehta. Ek chhatra maafi se shuru karte hue sawaal poochti hai, aur baad mein chhah log alag-alag aakar usse kehte hain ki unhe bhi samajh nahi aaya tha.',
  'Arjuna does not apologise before interrupting, which is worth noticing. The value of the objection is not that it was polite; it is that it was said out loud in a room, and the answer that follows is addressed to the whole room because of it.',
  'अर्जुन टोकने से पहले माफ़ी नहीं माँगते, और यह ध्यान देने लायक है। आपत्ति की क़ीमत यह नहीं कि वह शालीन थी; क़ीमत यह है कि वह एक कमरे में ज़ोर से कही गई, और इसी वजह से उसके बाद का जवाब पूरे कमरे को संबोधित है।',
  'Arjun tokne se pehle maafi nahi maangte, aur yeh dhyan dene layak hai. Aapatti ki keemat yeh nahi ki woh shalin thi; keemat yeh hai ki woh ek kamre mein zor se kahi gayi, aur isi wajah se uske baad ka jawab poore kamre ko sambodhit hai.',
  'Six people needed the answer. One person made it possible for all of them to get it.',
  'छह लोगों को जवाब चाहिए था। एक व्यक्ति ने उन सबके लिए वह मुमकिन बनाया।',
  'Chhah logon ko jawab chahiye tha. Ek insaan ne un sabke liye woh mumkin banaya.',
  NULL, 'beginner', 'college,questions,honesty,learning,courage'

  UNION ALL SELECT 34, 'healthcare', 3,
  'Told to relax', 'आराम करने को कहा गया', 'Aaram karne ko kaha gaya',
  'A patient with a long-term condition is advised to reduce stress. They already know. They have been told this by four people and none of them has yet asked what they have already tried. The fifth clinician opens by asking exactly that, and the consultation goes somewhere the previous four did not.',
  'लंबी बीमारी वाले एक मरीज़ को तनाव कम करने की सलाह दी जाती है। उन्हें पहले से पता है। चार लोग यह कह चुके हैं और उनमें से किसी ने अब तक यह नहीं पूछा कि वे पहले क्या-क्या आज़मा चुके हैं। पाँचवीं डॉक्टर ठीक यही पूछकर शुरू करती हैं, और परामर्श वहाँ पहुँचता है जहाँ पिछले चार नहीं पहुँचे।',
  'Lambi bimari wale ek mareez ko tanav kam karne ki salah di jaati hai. Unhe pehle se pata hai. Chaar log yeh keh chuke hain aur unme se kisi ne ab tak yeh nahi poocha ki woh pehle kya-kya aazma chuke hain. Paanchvi doctor theek yahi poochkar shuru karti hain, aur paramarsh wahan pahunchta hai jahan pichhle chaar nahi pahunche.',
  'Arjuna''s objection is a report from somebody who has tried, and the answer he gets in the next verse begins by accepting the report. Four clinicians gave correct advice to somebody who already had it. The fifth found out where they actually were first.',
  'अर्जुन की आपत्ति उस व्यक्ति की रिपोर्ट है जिसने कोशिश की है, और अगले श्लोक में उसे जो जवाब मिलता है वह उस रिपोर्ट को मानकर शुरू होता है। चार डॉक्टरों ने सही सलाह उसे दी जिसके पास वह पहले से थी। पाँचवीं ने पहले यह पता किया कि वे असल में हैं कहाँ।',
  'Arjun ki aapatti us insaan ki report hai jisne koshish ki hai, aur agle shloka mein use jo jawab milta hai woh us report ko maankar shuru hota hai. Chaar doctoron ne sahi salah use di jiske paas woh pehle se thi. Paanchvi ne pehle yeh pata kiya ki woh asal mein hain kahan.',
  'Correct advice given to somebody who already has it is not help. Asking what they have tried is.',
  'जिसके पास सलाह पहले से है उसे वही सही सलाह देना मदद नहीं है। यह पूछना कि उसने क्या आज़माया है, मदद है।',
  'Jiske paas salah pehle se hai use wahi sahi salah dena madad nahi hai. Yeh poochna ki usne kya aazmaya hai, madad hai.',
  NULL, 'intermediate', 'health,advice,listening,stress,consultation'

  UNION ALL SELECT 34, 'friendship', 4,
  'Saying it out loud once', 'एक बार ज़ोर से कह देना', 'Ek baar zor se keh dena',
  'Somebody tells a friend, for the first time in about two years, that they are finding a particular thing much harder than they have been letting on. Nothing is solved. The friend does not have a solution and does not offer one. Both of them describe the conversation afterwards as having changed something, and neither can say precisely what.',
  'कोई अपने दोस्त से, क़रीब दो साल में पहली बार, कहता है कि एक ख़ास चीज़ उसे उससे कहीं ज़्यादा मुश्किल लग रही है जितना वह दिखाता आया है। कुछ हल नहीं होता। दोस्त के पास कोई हल नहीं है और वह देता भी नहीं। दोनों बाद में उस बातचीत को यूँ बताते हैं कि उससे कुछ बदल गया, और दोनों में से कोई ठीक-ठीक नहीं बता सकता कि क्या।',
  'Koi apne dost se, karib do saal mein pehli baar, kehta hai ki ek khaas cheez use usse kahin zyada mushkil lag rahi hai jitna woh dikhata aaya hai. Kuch hal nahi hota. Dost ke paas koi hal nahi hai aur woh deta bhi nahi. Dono baad mein us baatchit ko yun batate hain ki usse kuch badal gaya, aur dono mein se koi theek-theek nahi bata sakta ki kya.',
  'Arjuna gets an answer in the next verse, but the value of this one does not depend on that. Saying the difficulty out loud to somebody is itself the move, and the book makes it the student who does it rather than the teacher who notices.',
  'अर्जुन को अगले श्लोक में जवाब मिलता है, पर इस श्लोक की क़ीमत उस पर टिकी नहीं है। कठिनाई किसी से ज़ोर से कह देना ख़ुद एक चाल है, और किताब यह काम शिक्षक के नोटिस करने पर नहीं, छात्र के करने पर रखती है।',
  'Arjun ko agle shloka mein jawab milta hai, par is shloka ki keemat us par tiki nahi hai. Kathinai kisi se zor se keh dena khud ek chaal hai, aur kitaab yeh kaam shikshak ke notice karne par nahi, chhatra ke karne par rakhti hai.',
  'The book makes it the student who says it, not the teacher who notices. That order matters.',
  'किताब यह छात्र से कहलवाती है, शिक्षक से नोटिस नहीं करवाती। वह क्रम मायने रखता है।',
  'Kitaab yeh chhatra se kehlwati hai, shikshak se notice nahi karwati. Woh kram maayne rakhta hai.',
  NULL, 'intermediate', 'friendship,honesty,difficulty,speaking,support'

  UNION ALL SELECT 35, 'cricket', 1,
  'Yes, it swings', 'हाँ, यह स्विंग होती है', 'Haan, yeh swing hoti hai',
  'A young batsman tells his coach he cannot pick the outswinger. A poor coach says he can if he watches the ball. This coach says: no, at that pace nobody picks it from the hand, you play the line and you leave on length — and then spends six weeks on leaving. The batsman describes the first sentence as the one that made the six weeks possible.',
  'एक युवा बल्लेबाज़ अपने कोच से कहता है कि वह आउटस्विंगर पढ़ नहीं पाता। कमज़ोर कोच कहता कि गेंद देखोगे तो पढ़ लोगे। यह कोच कहता है: नहीं, उस रफ़्तार पर उसे हाथ से कोई नहीं पढ़ता, तुम लाइन खेलोगे और लेंथ पर छोड़ोगे — और फिर छह हफ़्ते छोड़ने पर लगाता है। बल्लेबाज़ पहले वाक्य को वह बताता है जिसने वे छह हफ़्ते मुमकिन बनाए।',
  'Ek yuva batsman apne coach se kehta hai ki woh outswinger padh nahi paata. Kamzor coach kehta ki gend dekhoge to padh loge. Yeh coach kehta hai: nahi, us raftar par use haath se koi nahi padhta, tum line kheloge aur length par chhodoge — aur phir chhah hafte chhodne par lagata hai. Batsman pehle vakya ko woh batata hai jisne woh chhah hafte mumkin banaye.',
  'Asaṁśayam — no doubt about it, you are right — and then the method. The order is the technique. A student who has been told the impossible thing is actually easy stops reporting difficulties, and a coach who never hears about difficulties is coaching blind.',
  'असंशयम् — इसमें संदेह नहीं, आप सही हैं — और फिर तरीक़ा। क्रम ही तकनीक है। जिस छात्र से कहा जाए कि नामुमकिन लगने वाली चीज़ असल में आसान है, वह कठिनाइयाँ बताना बंद कर देता है, और जिस कोच तक कठिनाइयाँ पहुँचती ही नहीं वह अंधेरे में कोचिंग कर रहा है।',
  'Asamshayam — isme sandeh nahi, tum sahi ho — aur phir tareeka. Kram hi technique hai. Jis chhatra se kaha jaaye ki namumkin lagne wali cheez asal mein aasan hai, woh kathinaiyan batana band kar deta hai, aur jis coach tak kathinaiyan pahunchti hi nahi woh andhere mein coaching kar raha hai.',
  'A student told the impossible thing is easy stops reporting difficulties. Then nobody can coach them.',
  'जिस छात्र से कहा जाए कि नामुमकिन चीज़ आसान है, वह कठिनाइयाँ बताना बंद कर देता है। फिर उसे कोई सिखा नहीं सकता।',
  'Jis chhatra se kaha jaaye ki namumkin cheez aasan hai, woh kathinaiyan batana band kar deta hai. Phir use koi sikha nahi sakta.',
  NULL, 'beginner', 'cricket,coaching,honesty,method,difficulty'

  UNION ALL SELECT 35, 'corporate', 2,
  'The two-part answer', 'दो हिस्सों वाला जवाब', 'Do hisson wala jawab',
  'A team lead is told by three people that a deadline is not achievable. She agrees out loud that it is not, in the meeting, and then says what she is going to move. Nobody in the room has previously heard a manager concede the first half, and two of them mention it months later.',
  'एक टीम लीड से तीन लोग कहते हैं कि समयसीमा पूरी नहीं हो सकती। वे बैठक में ही ज़ोर से मान लेती हैं कि नहीं हो सकती, और फिर बताती हैं कि वे क्या खिसकाने जा रही हैं। कमरे में किसी ने पहले किसी मैनेजर को पहला आधा मानते नहीं सुना, और उनमें से दो महीनों बाद इसका ज़िक्र करते हैं।',
  'Ek team lead se teen log kehte hain ki samay-seema poori nahi ho sakti. Woh meeting mein hi zor se maan leti hain ki nahi ho sakti, aur phir batati hain ki woh kya khiskane ja rahi hain. Kamre mein kisi ne pehle kisi manager ko pehla aadha maante nahi suna, aur unme se do mahinon baad iska zikr karte hain.',
  'The concession and the plan are two separate acts and almost everybody skips to the second. What the first one buys is that the next time something is genuinely not achievable, three people will say so early rather than late.',
  'स्वीकार करना और योजना बताना दो अलग काम हैं और लगभग सब सीधे दूसरे पर कूद जाते हैं। पहला जो ख़रीदता है वह यह है कि अगली बार जब कुछ सचमुच मुमकिन नहीं होगा, तो तीन लोग वह देर से नहीं, जल्दी कह देंगे।',
  'Sweekar karna aur yojna batana do alag kaam hain aur lagbhag sab seedhe doosre par kood jaate hain. Pehla jo kharidta hai woh yeh hai ki agli baar jab kuch sach mein mumkin nahi hoga, to teen log woh der se nahi, jaldi keh denge.',
  'Conceding the first half buys you early warnings for years. Skipping to the plan costs them.',
  'पहला आधा मान लेना आपको सालों तक जल्दी चेतावनियाँ दिलाता है। सीधे योजना पर कूदना उन्हें गँवा देता है।',
  'Pehla aadha maan lena tumhe saalon tak jaldi chetavniyan dilata hai. Seedhe yojna par koodna unhe ganwa deta hai.',
  NULL, 'intermediate', 'work,leadership,honesty,deadlines,trust'

  UNION ALL SELECT 35, 'parenting', 3,
  'It is hard', 'यह मुश्किल है', 'Yeh mushkil hai',
  'A child says a piece of homework is too hard. The parent''s first instinct is to say it is not, because it is not, objectively, for a child of that age. Instead they say that it looks hard and sit down next to them. The homework gets done in about the same time it would have anyway, and the child asks for help again the following week.',
  'एक बच्चा कहता है कि होमवर्क बहुत मुश्किल है। अभिभावक की पहली प्रतिक्रिया यह कहने की है कि नहीं है, क्योंकि उस उम्र के बच्चे के लिए वस्तुनिष्ठ रूप से है नहीं। इसके बजाय वे कहते हैं कि यह मुश्किल दिखता है और उसके बगल में बैठ जाते हैं। होमवर्क लगभग उतने ही समय में हो जाता है जितने में वैसे भी होता, और अगले हफ़्ते बच्चा फिर मदद माँगता है।',
  'Ek bachcha kehta hai ki homework bahut mushkil hai. Parent ki pehli pratikriya yeh kehne ki hai ki nahi hai, kyunki us umar ke bachche ke liye objectively hai nahi. Iske bajaye woh kehte hain ki yeh mushkil dikhta hai aur uske bagal mein baith jaate hain. Homework lagbhag utne hi samay mein ho jaata hai jitne mein waise bhi hota, aur agle hafte bachcha phir madad maangta hai.',
  'The last sentence is the whole return on it. Krishna''s answer works because Arjuna keeps asking questions for another twelve chapters, and a child who is told the hard thing is easy stops saying which things are hard.',
  'आख़िरी वाक्य ही पूरा फल है। कृष्ण का जवाब इसलिए चलता है कि अर्जुन अगले बारह अध्याय तक सवाल पूछता रहता है, और जिस बच्चे से कहा जाए कि मुश्किल चीज़ आसान है, वह बताना बंद कर देता है कि कौन-सी चीज़ें मुश्किल हैं।',
  'Aakhiri vakya hi poora phal hai. Krishna ka jawab isliye chalta hai ki Arjun agle barah chapter tak sawaal poochta rehta hai, aur jis bachche se kaha jaaye ki mushkil cheez aasan hai, woh batana band kar deta hai ki kaun si cheezein mushkil hain.',
  'A child told the hard thing is easy stops telling you which things are hard.',
  'जिस बच्चे से कहा जाए कि मुश्किल चीज़ आसान है, वह बताना बंद कर देता है कि कौन-सी चीज़ें मुश्किल हैं।',
  'Jis bachche se kaha jaaye ki mushkil cheez aasan hai, woh batana band kar deta hai ki kaun si cheezein mushkil hain.',
  NULL, 'beginner', 'parenting,homework,validation,help,children'

  UNION ALL SELECT 35, 'ai', 4,
  'Practice and letting go, in that order', 'अभ्यास और छोड़ना, इसी क्रम में', 'Abhyas aur chhodna, isi kram mein',
  'Somebody learning to work with a new tool improves quickly for three weeks and then stops improving. What changes it is not more hours. It is that they stop evaluating every attempt as it comes out and start doing twenty in a row before looking at any of them.',
  'कोई नए औज़ार के साथ काम करना सीखते हुए तीन हफ़्ते तेज़ी से बेहतर होता है और फिर सुधरना बंद हो जाता है। इसे बदलता है और घंटे लगाना नहीं। इसे बदलता है यह कि वह हर कोशिश को आते ही आँकना बंद कर देता है और लगातार बीस करके तब किसी को देखता है।',
  'Koi naye auzaar ke saath kaam karna seekhte hue teen hafte tezi se behtar hota hai aur phir sudharna band ho jaata hai. Ise badalta hai aur ghante lagana nahi. Ise badalta hai yeh ki woh har koshish ko aate hi aankna band kar deta hai aur lagatar bees karke tab kisi ko dekhta hai.',
  'Abhyāsa and vairāgya as two separate remedies, and this is what happens when only the first is present. He had the practice. What he did not have was any distance from how each attempt turned out, and grading yourself continuously is the most common way to practise a great deal and improve slowly.',
  'अभ्यास और वैराग्य दो अलग उपाय हैं, और जब सिर्फ़ पहला मौजूद हो तो यही होता है। उसके पास अभ्यास था। जो नहीं था वह यह दूरी थी कि हर कोशिश कैसी निकली, और ख़ुद को लगातार अंक देना बहुत अभ्यास करके धीरे-धीरे सुधरने का सबसे आम तरीक़ा है।',
  'Abhyas aur vairagya do alag upay hain, aur jab sirf pehla maujood ho to yahi hota hai. Uske paas abhyas tha. Jo nahi tha woh yeh doori thi ki har koshish kaisi nikli, aur khud ko lagatar ank dena bahut abhyas karke dheere-dheere sudharne ka sabse aam tareeka hai.',
  'Grading yourself continuously is the most common way to practise a lot and improve slowly.',
  'ख़ुद को लगातार अंक देना बहुत अभ्यास करके धीरे सुधरने का सबसे आम तरीक़ा है।',
  'Khud ko lagatar ank dena bahut abhyas karke dheere sudharne ka sabse aam tareeka hai.',
  NULL, 'intermediate', 'learning,practice,detachment,feedback,tools'

  UNION ALL SELECT 40, 'college', 1,
  'The degree not finished', 'वह डिग्री जो पूरी नहीं हुई', 'Woh degree jo poori nahi hui',
  'Somebody leaves a course two years in. For a decade they describe those two years as wasted. At thirty-four, in a job that has nothing to do with the subject, they notice that a way of taking a problem apart which they use constantly came from a module in the second year.',
  'कोई दो साल बाद कोर्स छोड़ देता है। दस साल तक वह उन दो सालों को बेकार बताता है। चौंतीस की उम्र में, ऐसी नौकरी में जिसका उस विषय से कोई लेना-देना नहीं, उसे ध्यान आता है कि किसी समस्या को टुकड़ों में तोड़ने का जो तरीक़ा वह लगातार इस्तेमाल करता है वह दूसरे साल के एक मॉड्यूल से आया था।',
  'Koi do saal baad course chhod deta hai. Das saal tak woh un do saalon ko bekaar batata hai. Chauntis ki umar mein, aisi naukri mein jiska us vishay se koi lena-dena nahi, use dhyan aata hai ki kisi samasya ko tukdon mein todne ka jo tareeka woh lagatar istemaal karta hai woh doosre saal ke ek module se aaya tha.',
  'Nothing is destroyed, here or afterwards. The claim does not require any metaphysics to be useful — ten years of calling it wasted was a description that turned out to be wrong, and the wrongness was findable at any point by asking what he had kept.',
  'कुछ नष्ट नहीं होता, न यहाँ न आगे। इस दावे के काम आने के लिए किसी तत्त्वज्ञान की ज़रूरत नहीं — दस साल इसे बेकार कहना ऐसा वर्णन था जो ग़लत निकला, और यह ग़लती किसी भी समय यह पूछकर पकड़ी जा सकती थी कि उसके पास बचा क्या।',
  'Kuch nasht nahi hota, na yahan na aage. Is dawe ke kaam aane ke liye kisi tattvagyan ki zaroorat nahi — das saal ise bekaar kehna aisa varnan tha jo galat nikla, aur yeh galti kisi bhi samay yeh poochkar pakdi ja sakti thi ki uske paas bacha kya.',
  'Ten years of calling it wasted was wrong, and asking what he had kept would have found that at any point.',
  'दस साल उसे बेकार कहना ग़लत था, और यह पूछना कि उसके पास बचा क्या — किसी भी समय यह पकड़ लेता।',
  'Das saal use bekaar kehna galat tha, aur yeh poochna ki uske paas bacha kya — kisi bhi samay yeh pakad leta.',
  NULL, 'beginner', 'study,quitting,waste,hindsight,learning'

  UNION ALL SELECT 40, 'everyday_life', 2,
  'Six months of a language', 'किसी भाषा के छह महीने', 'Kisi bhasha ke chhah mahine',
  'Somebody learns a language for six months and stops. Four years later, in that country for a week, they cannot hold a conversation and can read most signs, follow the shape of an announcement, and be polite in a shop. They had described the six months as pointless for four years.',
  'कोई छह महीने कोई भाषा सीखता है और छोड़ देता है। चार साल बाद, उसी देश में एक हफ़्ते के लिए, वह बातचीत नहीं कर पाता और ज़्यादातर बोर्ड पढ़ लेता है, किसी घोषणा का ढाँचा समझ लेता है, और दुकान में शिष्टता से बात कर लेता है। वह चार साल से उन छह महीनों को बेमतलब बताता आया था।',
  'Koi chhah mahine koi bhasha seekhta hai aur chhod deta hai. Chaar saal baad, usi desh mein ek hafte ke liye, woh baatchit nahi kar paata aur zyadatar board padh leta hai, kisi ghoshna ka dhaancha samajh leta hai, aur dukaan mein shishtata se baat kar leta hai. Woh chaar saal se un chhah mahinon ko bematlab batata aaya tha.',
  'Arjuna''s question is about somebody who does not arrive, and this is the ordinary version of the answer. Not arriving is not the same as not moving, and the person is usually the last to check.',
  'अर्जुन का सवाल उसके बारे में है जो पहुँचता नहीं, और यह उस जवाब का साधारण रूप है। न पहुँचना और न चलना एक बात नहीं है, और जाँचने वाला आमतौर पर वह ख़ुद सबसे आख़िर में होता है।',
  'Arjun ka sawaal uske baare mein hai jo pahunchta nahi, aur yeh us jawab ka sadharan roop hai. Na pahunchna aur na chalna ek baat nahi hai, aur jaanchne wala aam taur par woh khud sabse aakhir mein hota hai.',
  'Not arriving is not the same as not moving, and you are usually the last to check.',
  'न पहुँचना न चलना नहीं है, और जाँचने वाले आमतौर पर आप ही सबसे आख़िर में होते हैं।',
  'Na pahunchna na chalna nahi hai, aur jaanchne wale aam taur par tum hi sabse aakhir mein hote ho.',
  NULL, 'beginner', 'learning,languages,quitting,progress,hindsight'

  UNION ALL SELECT 40, 'sports', 3,
  'The one who did not make it', 'वह जो नहीं बन पाया', 'Woh jo nahi ban paya',
  'A player in an academy from twelve to nineteen does not get a contract. At thirty-one he coaches, and describes the seven years as the reason he can tell within about ten minutes which child is going to need a different kind of attention. Nobody in the academy had a plan for the ones who did not make it.',
  'बारह से उन्नीस साल तक अकादमी में रहा एक खिलाड़ी अनुबंध नहीं पाता। इकतीस पर वह कोचिंग करता है, और उन सात सालों को वह वजह बताता है जिससे वह क़रीब दस मिनट में बता सकता है कि किस बच्चे को अलग तरह के ध्यान की ज़रूरत होगी। अकादमी के पास उनके लिए कोई योजना नहीं थी जो नहीं बन पाए।',
  'Barah se unnis saal tak academy mein raha ek khiladi anubandh nahi paata. Ikatis par woh coaching karta hai, aur un saat saalon ko woh wajah batata hai jisse woh karib das minute mein bata sakta hai ki kis bachche ko alag tarah ke dhyan ki zaroorat hogi. Academy ke paas unke liye koi yojna nahi thi jo nahi ban paaye.',
  'The verse is addressed precisely to this person and it is worth noting what it does not say: it does not say the contract was unimportant, and it does not say the seven years were secretly about coaching. It says nothing is destroyed. What he kept was real and it was not a consolation prize designed in advance.',
  'श्लोक ठीक इसी व्यक्ति को संबोधित है और ध्यान देने लायक है कि वह क्या नहीं कहता: वह यह नहीं कहता कि अनुबंध महत्वहीन था, और यह भी नहीं कि वे सात साल दरअसल कोचिंग के लिए थे। वह कहता है कि कुछ नष्ट नहीं होता। उसके पास जो बचा वह असली था और वह पहले से तय किया गया कोई सांत्वना पुरस्कार नहीं था।',
  'Shloka theek isi insaan ko sambodhit hai aur dhyan dene layak hai ki woh kya nahi kehta: woh yeh nahi kehta ki anubandh mahatvahin tha, aur yeh bhi nahi ki woh saat saal darasal coaching ke liye the. Woh kehta hai ki kuch nasht nahi hota. Uske paas jo bacha woh asli tha aur woh pehle se tay kiya gaya koi saantvana puraskar nahi tha.',
  'It does not say the contract was unimportant. It says nothing is destroyed, which is a different and smaller claim.',
  'वह यह नहीं कहता कि अनुबंध महत्वहीन था। वह कहता है कि कुछ नष्ट नहीं होता — जो अलग और छोटा दावा है।',
  'Woh yeh nahi kehta ki anubandh mahatvahin tha. Woh kehta hai ki kuch nasht nahi hota — jo alag aur chhota dawa hai.',
  NULL, 'intermediate', 'sport,academy,failure,second-careers,hindsight'

  UNION ALL SELECT 40, 'leadership', 4,
  'Dear one', 'प्रिय', 'Priya',
  'A manager delivers a difficult message to somebody whose project is being stopped after eighteen months. Everything factual is said clearly. What the person remembers two years later is not any of that; it is that she used his name at the start of the sentence and again at the end.',
  'एक मैनेजर उस व्यक्ति को मुश्किल ख़बर देती हैं जिसका अठारह महीने पुराना प्रोजेक्ट बंद किया जा रहा है। तथ्य की हर बात साफ़ कही जाती है। दो साल बाद उस व्यक्ति को उनमें से कुछ याद नहीं; याद यह है कि उन्होंने वाक्य की शुरुआत में उसका नाम लिया और अंत में फिर से।',
  'Ek manager us insaan ko mushkil khabar deti hain jiska atharah mahine purana project band kiya ja raha hai. Tathya ki har baat saaf kahi jaati hai. Do saal baad us insaan ko unme se kuch yaad nahi; yaad yeh hai ki unhone vakya ki shuruaat mein uska naam liya aur ant mein phir se.',
  'The verse ends with tāta — dear one — and the word is doing as much work as the claim. Arjuna asked whether the effort was wasted and got both a no and a form of address. The second one is why the answer landed, and it costs nothing to give.',
  'श्लोक तात पर ख़त्म होता है — प्रिय — और वह शब्द उतना ही काम कर रहा है जितना दावा। अर्जुन ने पूछा कि क्या मेहनत बेकार गई और उसे "नहीं" भी मिला और संबोधन भी। दूसरा ही वजह है कि जवाब उतरा, और उसे देने में कुछ नहीं लगता।',
  'Shloka taat par khatam hota hai — priya — aur woh shabd utna hi kaam kar raha hai jitna dawa. Arjun ne poocha ki kya mehnat bekaar gayi aur use "nahi" bhi mila aur sambodhan bhi. Doosra hi wajah hai ki jawab utra, aur use dene mein kuch nahi lagta.',
  'The claim and the form of address are doing separate jobs. Only one of them is remembered.',
  'दावा और संबोधन दो अलग काम कर रहे हैं। याद उनमें से एक ही रहता है।',
  'Dawa aur sambodhan do alag kaam kar rahe hain. Yaad unme se ek hi rehta hai.',
  NULL, 'intermediate', 'leadership,bad-news,kindness,words,memory'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 6;

-- =====================================================================
-- 5. CROSS REFERENCES
-- =====================================================================
-- ELEVEN DECLARED. Count the loaded rows against that number before
-- shipping — a reference to an unseeded verse vanishes silently.
-- =====================================================================

DELETE x FROM verse_cross_references x JOIN verses v ON v.id = x.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 6;

INSERT INTO verse_cross_references
  (verse_id, reference_type, book, chapter, verse, target_verse_id,
   description_en, description_hi, description_hinglish, relationship, sort_order)
SELECT v.id, 'gita', 'Bhagavad Gita', CAST(x.tch AS CHAR), CAST(x.tvn AS CHAR), tv.id,
       x.d_en, x.d_hi, x.d_hing, x.rel, x.ord
FROM (
  SELECT 5 AS vn, 3 AS tch, 27 AS tvn, 1 AS ord,
    'Read these two together or they look like a contradiction. 3.27 removes authorship of outcomes; 6.5 says a person is not purely acted upon. Both hold: you did not arrange the conditions and there is still somewhere to push.' AS d_en,
    'इन दोनों को साथ पढ़िए वरना ये विरोधी दिखते हैं। 3.27 नतीजों का कर्तापन हटाता है; 6.5 कहता है कि आदमी सिर्फ़ वह नहीं जिस पर चीज़ें की जाती हैं। दोनों टिकते हैं: हालात आपने नहीं जुटाए और फिर भी ज़ोर लगाने की जगह है।' AS d_hi,
    'In dono ko saath padho warna yeh virodhi dikhte hain. 3.27 nateejon ka kartapan hatata hai; 6.5 kehta hai ki aadmi sirf woh nahi jis par cheezein ki jaati hain. Dono tikte hain: haalat tumne nahi jutaye aur phir bhi zor lagane ki jagah hai.' AS d_hing,
    'opposite' AS rel
  UNION ALL SELECT 5, 18, 14, 2,
    'Five things go into any action and you are one of them. This verse is about that one, and about it being genuinely one of the five rather than none of them.',
    'किसी भी कर्म में पाँच चीज़ें लगती हैं और आप उनमें से एक हैं। यह श्लोक उसी एक के बारे में है, और इस बारे में कि वह सचमुच पाँच में से एक है, शून्य नहीं।',
    'Kisi bhi karm mein paanch cheezein lagti hain aur tum unme se ek ho. Yeh shloka usi ek ke baare mein hai, aur is baare mein ki woh sach mein paanch mein se ek hai, shoonya nahi.',
    'supports'
  UNION ALL SELECT 6, 16, 21, 1,
    'Three gates that take a person apart, and here the mechanism by which they get left open. Unattended is enough; nothing has to be hostile.',
    'तीन दरवाज़े जो आदमी को तोड़ देते हैं, और यहाँ वह तंत्र जिससे वे खुले रह जाते हैं। बिना देखभाल होना काफ़ी है; किसी का शत्रु होना ज़रूरी नहीं।',
    'Teen darwaze jo aadmi ko tod dete hain, aur yahan woh mechanism jisse woh khule reh jaate hain. Bina dekhbhal hona kaafi hai; kisi ka shatru hona zaroori nahi.',
    'supports'
  UNION ALL SELECT 17, 18, 37, 1,
    'One sorts happiness by which direction it moves in; the other asks for measure in four things at once. Both are arguments against judging a practice by how it feels today.',
    'एक सुख को इस आधार पर छाँटता है कि वह किस दिशा में जा रहा है; दूसरा एक साथ चार चीज़ों में नाप माँगता है। दोनों इस बात के ख़िलाफ़ दलील हैं कि किसी अभ्यास को आज कैसा लगता है, इससे आँका जाए।',
    'Ek sukh ko is aadhar par chhaanta hai ki woh kis disha mein ja raha hai; doosra ek saath chaar cheezon mein naap maangta hai. Dono is baat ke khilaf dalil hain ki kisi abhyas ko aaj kaisa lagta hai, isse aanka jaaye.',
    'supports'
  UNION ALL SELECT 19, 2, 70, 1,
    'The lamp with no draught and the ocean the rivers do not raise. Two pictures of the same thing, and neither is about being bigger.',
    'बिना हवा वाला दीया और वह समुद्र जिसे नदियाँ बढ़ाती नहीं। एक ही चीज़ की दो तस्वीरें, और कोई भी बड़ा होने के बारे में नहीं है।',
    'Bina hawa wala diya aur woh samudra jise nadiyan badhati nahi. Ek hi cheez ki do tasveerein, aur koi bhi bada hone ke baare mein nahi hai.',
    'same'
  UNION ALL SELECT 19, 12, 15, 2,
    'A flame nothing pulls at, and a person the room does not pull at. The second is the first with other people in it.',
    'ऐसी लौ जिसे कुछ खींचता नहीं, और ऐसा व्यक्ति जिसे कमरा खींचता नहीं। दूसरा वही पहला है, जिसमें और लोग भी हैं।',
    'Aisi lau jise kuch kheenchta nahi, aur aisa insaan jise kamra kheenchta nahi. Doosra wahi pehla hai, jisme aur log bhi hain.',
    'same'
  UNION ALL SELECT 26, 2, 62, 1,
    'Where the mind goes matters, and 2.62 is what happens when it is left there. This verse is the instruction that interrupts that chain at the first step.',
    'मन कहाँ जाता है यह मायने रखता है, और 2.62 बताता है कि उसे वहीं छोड़ दिया जाए तो क्या होता है। यह श्लोक वह हिदायत है जो उस कड़ी को पहली सीढ़ी पर ही तोड़ देती है।',
    'Man kahan jaata hai yeh maayne rakhta hai, aur 2.62 batata hai ki use wahin chhod diya jaaye to kya hota hai. Yeh shloka woh hidayat hai jo us chain ko pehli seedhi par hi tod deti hai.',
    'supports'
  UNION ALL SELECT 34, 3, 37, 1,
    'Arjuna says the mind cannot be held; 3.37 names what is doing the pulling. The objection and the diagnosis belong together.',
    'अर्जुन कहते हैं कि मन थामा नहीं जा सकता; 3.37 बताता है कि खींच क्या रहा है। आपत्ति और निदान साथ के हैं।',
    'Arjun kehte hain ki man thaama nahi ja sakta; 3.37 batata hai ki kheench kya raha hai. Aapatti aur nidan saath ke hain.',
    'supports'
  UNION ALL SELECT 35, 12, 12, 1,
    'Both rank abhyāsa and both put something above it. Here it is vairāgya; there it is letting go of what the work earns. The same second half, named twice.',
    'दोनों अभ्यास को क्रम में रखते हैं और दोनों उससे ऊपर कुछ रखते हैं। यहाँ वैराग्य; वहाँ काम से जो मिलता है उसे छोड़ना। वही दूसरा आधा, दो बार नाम लेकर।',
    'Dono abhyas ko kram mein rakhte hain aur dono usse upar kuch rakhte hain. Yahan vairagya; wahan kaam se jo milta hai use chhodna. Wahi doosra aadha, do baar naam lekar.',
    'same'
  UNION ALL SELECT 35, 2, 47, 2,
    'Vairāgya is not a mood. 2.47 is the same instruction in its most concrete form: do the work, put down what it earns.',
    'वैराग्य कोई मनोदशा नहीं है। 2.47 वही हिदायत अपने सबसे ठोस रूप में है: काम कीजिए, उससे जो मिलता है वह रख दीजिए।',
    'Vairagya koi manodasha nahi hai. 2.47 wahi hidayat apne sabse thos roop mein hai: kaam karo, usse jo milta hai woh rakh do.',
    'supports'
  UNION ALL SELECT 40, 18, 63, 1,
    'One says nothing you put into this is lost; the other says now decide for yourself. A text that says both is not asking to be obeyed.',
    'एक कहता है कि इसमें आपने जो लगाया वह कुछ भी बेकार नहीं जाता; दूसरा कहता है कि अब ख़ुद तय कीजिए। जो ग्रंथ दोनों कहता है वह माने जाने की माँग नहीं कर रहा।',
    'Ek kehta hai ki isme tumne jo lagaya woh kuch bhi bekaar nahi jaata; doosra kehta hai ki ab khud tay karo. Jo granth dono kehta hai woh maane jaane ki maang nahi kar raha.',
    'supports'
) AS x
JOIN verses v  ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 6
JOIN chapters tc ON tc.chapter_number = x.tch
JOIN verses tv ON tv.verse_number = x.tvn AND tv.chapter_id = tc.id;

-- =====================================================================
-- 6. WORD BY WORD
-- =====================================================================
-- yukta is glossed as FITTED rather than as restrained or minimal, and
-- the gloss says so, because the whole 6.17 safeguard turns on that
-- word not meaning "less".
-- =====================================================================

DELETE w FROM verse_word_meanings w JOIN verses v ON v.id = w.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 6;

INSERT INTO verse_word_meanings
  (verse_id, word_order, devanagari, transliteration,
   meaning_en, meaning_hi, meaning_hinglish, grammar, root_word)
SELECT v.id, w.ord, w.dev, w.tr, w.m_en, w.m_hi, w.m_hing, w.gram, w.root FROM (

  SELECT 5 AS vn, 1 AS ord, 'उद्धरेत्' AS dev, 'uddharet' AS tr, 'should lift up, should raise' AS m_en, 'ऊपर उठाए' AS m_hi, 'upar uthaye' AS m_hing, 'optative, third person' AS gram, 'उद् + हृ' AS root
  UNION ALL SELECT 5, 2, 'आत्मना', 'ātmanā', 'by the self — the instrument', 'आत्मा से — साधन', 'atma se — sadhan', 'instrumental singular', 'आत्मन्'
  UNION ALL SELECT 5, 3, 'आत्मानम्', 'ātmānam', 'the self — the object. Same word, two cases: the sentence has a subject and an object that are the same thing', 'आत्मा को — कर्म। वही शब्द, दो विभक्तियाँ: वाक्य में कर्ता और कर्म एक ही चीज़ हैं', 'atma ko — karm. Wahi shabd, do vibhaktiyan: vakya mein karta aur karm ek hi cheez hain', 'accusative singular', 'आत्मन्'
  UNION ALL SELECT 5, 4, 'न अवसादयेत्', 'na avasādayet', 'should not let sink, should not cause to sag', 'डूबने न दे, गिरने न दे', 'doobne na de, girne na de', 'causative optative', 'अव + सद्'
  UNION ALL SELECT 5, 5, 'बन्धुः', 'bandhuḥ', 'friend, kin', 'बंधु, अपना', 'bandhu, apna', 'nominative singular', 'बन्ध्'
  UNION ALL SELECT 5, 6, 'रिपुः', 'ripuḥ', 'opponent, adversary', 'रिपु, विरोधी', 'ripu, virodhi', 'nominative singular', 'रिप्'

  UNION ALL SELECT 6, 1, 'जितः', 'jitaḥ', 'conquered, got hold of', 'जीता हुआ, पकड़ में आया', 'jeeta hua, pakad mein aaya', 'past participle, nominative', 'जि'
  UNION ALL SELECT 6, 2, 'अनात्मनः', 'anātmanaḥ', 'of one who has not got hold of themselves', 'जिसे अपने ऊपर पकड़ नहीं मिली, उसका', 'jise apne upar pakad nahi mili, uska', 'genitive singular', 'आत्मन्'
  UNION ALL SELECT 6, 3, 'शत्रुत्वे', 'śatrutve', 'in enmity, in the state of being an opponent', 'शत्रुता में', 'shatruta mein', 'locative singular', 'शत्रु'
  UNION ALL SELECT 6, 4, 'वर्तेत', 'varteta', 'would remain, would carry on', 'बना रहेगा, चलता रहेगा', 'bana rahega, chalta rahega', 'optative middle, third person', 'वृत्'
  UNION ALL SELECT 6, 5, 'शत्रुवत्', 'śatru-vat', 'LIKE an enemy — the suffix is doing real work; not an enemy, one that behaves as one', 'शत्रु जैसा — प्रत्यय ही काम कर रहा है; शत्रु नहीं, शत्रु जैसा बरतने वाला', 'shatru jaisa — pratyay hi kaam kar raha hai; shatru nahi, shatru jaisa bartne wala', 'adverbial suffix', 'शत्रु'

  UNION ALL SELECT 17, 1, 'युक्त', 'yukta', 'FITTED, joined, matched to the thing — not "restrained" and not "minimal". The whole verse turns on this', 'युक्त — ठीक बैठा हुआ, जुड़ा हुआ, उस चीज़ के नाप का — "संयमित" नहीं और "कम" नहीं। पूरा श्लोक इसी पर टिका है', 'yukta — theek baitha hua, juda hua, us cheez ke naap ka — "sanyamit" nahi aur "kam" nahi. Poora shloka isi par tika hai', 'in compound', 'युज्'
  UNION ALL SELECT 17, 2, 'आहार', 'āhāra', 'taking in, eating', 'आहार, खाना', 'aahar, khana', 'in compound', 'आ + हृ'
  UNION ALL SELECT 17, 3, 'विहार', 'vihāra', 'moving about, recreation', 'विहार, चलना-फिरना', 'vihar, chalna-firna', 'in compound', 'वि + हृ'
  UNION ALL SELECT 17, 4, 'चेष्टस्य कर्मसु', 'ceṣṭasya karmasu', 'of effort in actions — how much you put in', 'कर्मों में चेष्टा का — कितना लगाते हैं', 'karmon mein cheshta ka — kitna lagate ho', 'genitive, locative plural', 'चेष्ट्'
  UNION ALL SELECT 17, 5, 'स्वप्नावबोधस्य', 'svapnāvabodhasya', 'of sleeping and waking', 'सोने और जागने का', 'sone aur jaagne ka', 'compound, genitive', 'स्वप्'
  UNION ALL SELECT 17, 6, 'दुःखहा', 'duḥkha-hā', 'destroyer of sorrow', 'दुख हरने वाला', 'dukh harne wala', 'compound, nominative', 'हन्'

  UNION ALL SELECT 19, 1, 'दीपः', 'dīpaḥ', 'a lamp', 'दीया', 'diya', 'nominative singular', 'दीप्'
  UNION ALL SELECT 19, 2, 'निवातस्थः', 'nivāta-sthaḥ', 'standing where there is no wind', 'जहाँ हवा न हो वहाँ खड़ा', 'jahan hawa na ho wahan khada', 'compound, nominative', 'स्था'
  UNION ALL SELECT 19, 3, 'न इङ्गते', 'na iṅgate', 'does not waver, does not flicker', 'काँपता नहीं', 'kaanpta nahi', 'present middle, third person', 'इङ्ग्'
  UNION ALL SELECT 19, 4, 'उपमा', 'upamā', 'the simile, the comparison', 'उपमा', 'upma', 'nominative singular', 'उप + मा'
  UNION ALL SELECT 19, 5, 'यतचित्तस्य', 'yata-cittasya', 'of one whose attention is held', 'जिसका चित्त थमा हुआ है, उसका', 'jiska chitt thama hua hai, uska', 'compound, genitive', 'यम्'

  UNION ALL SELECT 26, 1, 'यतो यतः', 'yato yataḥ', 'from wherever, from whatever — the doubling makes it repeating rather than single', 'जहाँ-जहाँ से, जिस-जिस से — दोहराव इसे एक बार का नहीं, बार-बार का बनाता है', 'jahan-jahan se, jis-jis se — dohrav ise ek baar ka nahi, baar-baar ka banata hai', 'correlative, ablative', 'यद्'
  UNION ALL SELECT 26, 2, 'निश्चरति', 'niścarati', 'wanders out, goes off', 'निकल भागता है', 'nikal bhagta hai', 'present, third person', 'निस् + चर्'
  UNION ALL SELECT 26, 3, 'चञ्चलम्', 'cañcalam', 'restless, moving', 'चंचल', 'chanchal', 'accusative singular', 'चञ्च्'
  UNION ALL SELECT 26, 4, 'अस्थिरम्', 'asthiram', 'unsteady, not holding still', 'अस्थिर, न टिकने वाला', 'asthir, na tikne wala', 'accusative singular', 'स्था'
  UNION ALL SELECT 26, 5, 'ततस्ततः', 'tatas tataḥ', 'from there, from there — matched to the doubling above', 'वहीं-वहीं से — ऊपर के दोहराव से मिलता हुआ', 'wahin-wahin se — upar ke dohrav se milta hua', 'correlative, ablative', 'तद्'
  UNION ALL SELECT 26, 6, 'नियम्य', 'niyamya', 'having restrained, having gathered', 'रोककर, समेटकर', 'rokkar, sametkar', 'gerund', 'नि + यम्'
  UNION ALL SELECT 26, 7, 'वशं नयेत्', 'vaśaṁ nayet', 'should bring under control', 'वश में लाए', 'vash mein laaye', 'optative, third person', 'नी'

  UNION ALL SELECT 34, 1, 'चञ्चलम्', 'cañcalam', 'restless', 'चंचल', 'chanchal', 'nominative singular', 'चञ्च्'
  UNION ALL SELECT 34, 2, 'प्रमाथि', 'pramāthi', 'churning, agitating — it stirs things up rather than merely moving', 'मथने वाला — यह सिर्फ़ हिलता नहीं, चीज़ें मथ देता है', 'mathne wala — yeh sirf hilta nahi, cheezein math deta hai', 'nominative singular', 'प्र + मथ्'
  UNION ALL SELECT 34, 3, 'बलवत्', 'balavat', 'strong', 'बलवान', 'balwan', 'nominative singular', 'बल'
  UNION ALL SELECT 34, 4, 'दृढम्', 'dṛḍham', 'obstinate, firmly set', 'दृढ़, अड़ा हुआ', 'dridh, ada hua', 'nominative singular', 'दृह्'
  UNION ALL SELECT 34, 5, 'निग्रहम्', 'nigraham', 'holding down, restraining', 'निग्रह, थामना', 'nigrah, thaamna', 'accusative singular', 'नि + ग्रह्'
  UNION ALL SELECT 34, 6, 'वायोः इव', 'vāyoḥ iva', 'as of the wind', 'हवा की तरह', 'hawa ki tarah', 'genitive singular', 'वायु'
  UNION ALL SELECT 34, 7, 'सुदुष्करम्', 'suduṣkaram', 'very hard to do', 'बहुत कठिन', 'bahut mushkil', 'accusative singular', 'दुष् + कृ'

  UNION ALL SELECT 35, 1, 'असंशयम्', 'asaṁśayam', 'without doubt — the FIRST word of the answer, and it is agreement rather than correction', 'असंशयम् — जवाब का पहला शब्द, और यह सुधार नहीं, सहमति है', 'asamshayam — jawab ka pehla shabd, aur yeh sudhaar nahi, sehmati hai', 'indeclinable', 'सम् + शी'
  UNION ALL SELECT 35, 2, 'दुर्निग्रहम्', 'durnigraham', 'hard to restrain', 'थामने में कठिन', 'thaamne mein mushkil', 'nominative singular', 'नि + ग्रह्'
  UNION ALL SELECT 35, 3, 'चलम्', 'calam', 'moving, unsteady', 'चलायमान', 'chalayaman', 'nominative singular', 'चल्'
  UNION ALL SELECT 35, 4, 'अभ्यासेन', 'abhyāsena', 'by practice — doing it again, repeatedly', 'अभ्यास से — बार-बार करने से', 'abhyas se — baar-baar karne se', 'instrumental singular', 'अभि + अस्'
  UNION ALL SELECT 35, 5, 'वैराग्येण', 'vairāgyeṇa', 'by dispassion — loosening the grip on how it turns out, not indifference to it', 'वैराग्य से — नतीजे पर पकड़ ढीली करने से, उसके प्रति बेरुख़ी नहीं', 'vairagya se — nateeje par pakad dheeli karne se, uske prati berukhi nahi', 'instrumental singular', 'वि + रञ्ज्'
  UNION ALL SELECT 35, 6, 'गृह्यते', 'gṛhyate', 'is held, is grasped', 'थामा जाता है', 'thaama jaata hai', 'passive, third person', 'ग्रह्'

  UNION ALL SELECT 40, 1, 'न इह न अमुत्र', 'na iha na amutra', 'not here and not there — neither in this world nor beyond it', 'न यहाँ न वहाँ — न इस लोक में न उसके आगे', 'na yahan na wahan — na is lok mein na uske aage', 'indeclinable', NULL
  UNION ALL SELECT 40, 2, 'विनाशः', 'vināśaḥ', 'destruction, loss', 'विनाश, नुक़सान', 'vinash, nuksaan', 'nominative singular', 'वि + नश्'
  UNION ALL SELECT 40, 3, 'कल्याणकृत्', 'kalyāṇa-kṛt', 'one who does good, one who does what is wholesome', 'भला करने वाला', 'bhala karne wala', 'compound, nominative', 'कृ'
  UNION ALL SELECT 40, 4, 'दुर्गतिम्', 'durgatim', 'a bad end, a bad going', 'दुर्गति, बुरी जगह', 'durgati, buri jagah', 'accusative singular', 'दुस् + गम्'
  UNION ALL SELECT 40, 5, 'तात', 'tāta', 'dear one — an affectionate address, closer to "my dear" than to any title. The reassurance is in this word as much as in the claim', 'तात — स्नेह भरा संबोधन, किसी उपाधि से ज़्यादा "प्रिय" के पास। तसल्ली जितनी दावे में है उतनी ही इस शब्द में', 'taat — sneh bhara sambodhan, kisi upadhi se zyada "priya" ke paas. Tasalli jitni dawe mein hai utni hi is shabd mein', 'vocative', NULL
  UNION ALL SELECT 40, 6, 'गच्छति', 'gacchati', 'goes, comes to', 'जाता है', 'jaata hai', 'present, third person', 'गम्'
) AS w
JOIN verses v ON v.verse_number = w.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 6;
