-- =====================================================================
-- VedaVerse — database/seed_ch13.sql
-- =====================================================================
-- Chapter 13, Kṣetra Kṣetrajña Vibhāga Yoga. Eight verses. The last
-- chapter of the INTERMEDIATE track (2, 3, 4, 5, 6, 12, 13, 14, 16,
-- 17, 18 in app.php). Only chapter 4 remains after this one.
--
--   13.2   the field, and the one who knows the field     [CARE]
--   13.6   what is IN the field — including the wanting   [CARE]
--   13.8   "knowledge" turns out to be a list of behaviours
--   13.20  who does, and who undergoes
--   13.27  the same in all of them, undying among the dying
--   13.29  and therefore he does not injure himself       [CARE]
--   13.32  in the body, and not coloured by it            [CARE]
--   13.34  one sun lights the whole field
--
-- THIS CHAPTER CONTAINS THE MOST MISUSABLE IDEA IN THE BOOK
--   "You are not this. You are the one watching it." Handed to somebody
--   in physical pain, or grieving, or dissociating, that sentence is
--   not wisdom — it is a way of leaving. And unlike caste or gender,
--   nobody has to be arguing in bad faith for the harm to happen. The
--   reader does it to themselves, quietly, and feels like they are
--   making progress.
--
--   The chapter defends against this itself, in three places, and the
--   explanations use the text rather than arguing alongside it.
--
--   1. 13.6 PUTS AWARENESS INSIDE THE FIELD. The list of what the
--      field contains is: wanting, aversion, pleasure, pain, the
--      assembled body, cetanā — awareness — and dhṛti, holding
--      together. Awareness is on the list of things observed. So the
--      witness is not a place a person can go and sit, and any practice
--      that consists of climbing into it has misread the verse that
--      defines it.
--
--   2. 13.29 IS THE WELLBEING VERSE AND IT IS THE CHAPTER'S OWN.
--      "Seeing evenly everywhere, he does not injure himself by
--      himself." na hinasty ātmanā ātmānam. The chapter's claim is that
--      this seeing produces LESS self-harm, not more distance. Any
--      reading of 13.2 or 13.32 that leaves somebody further from
--      themselves has been contradicted twenty-seven verses later by
--      the same chapter.
--
--   3. 13.32's "na lipyate" IS THE LOTUS LEAF AGAIN. Not stained means
--      not coloured by, not soaked through. It does not mean not
--      touched and it does not mean not felt. 5.10 already established
--      that the leaf is IN the water the entire time.
--
--   The explanations say plainly that this is not an instruction to
--   stop feeling things, and that if pain is present then "you are not
--   this" is not a technique — it will not work, and the chapter does
--   not offer it as one.
--
-- 13.32 HAS A SECOND TRAP, POINTING THE OTHER WAY
--   "Does not act and is not stained" can be read as moral licence —
--   nothing I do attaches to me. 13.29 sits three verses earlier and
--   says the seeing produces less harm rather than permission, and
--   13.8's list of what knowledge actually is starts with humility and
--   includes ahiṁsā. A licence reading has to get past both.
--
-- CONTENT RULES — unchanged. Original writing throughout. Sanskrit
--   unaltered, numbering untouched (35-verse recension). No praise or
--   criticism of any living politician, party or movement. No communal
--   framing. NOTHING IN THIS FILE NAMES A CONDITION, PRESCRIBES
--   ANYTHING, OR OFFERS DETACHMENT AS A WAY TO STOP FEELING SOMETHING.
--
-- RUN AFTER seed_sample.sql. Re-runnable.
--
--     mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
--         < htdocs/database/seed_ch13.sql
--
-- global_order is 489 + verse_number: chapters 1 to 12 have 489 verses.
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

  SELECT 2 AS verse_number, 491 AS global_order, 1 AS is_curated, 'gita-13-2' AS slug,
    'इदं शरीरं कौन्तेय क्षेत्रमित्यभिधीयते।\nएतद्यो वेत्ति तं प्राहुः क्षेत्रज्ञ इति तद्विदः॥' AS sanskrit_devanagari,
    'idaṁ śarīraṁ kaunteya kṣetram ity abhidhīyate\netad yo vetti taṁ prāhuḥ kṣetrajña iti tad-vidaḥ' AS transliteration_iast,
    'idam shariram kaunteya kshetram ity abhidhiyate\netad yo vetti tam prahuh kshetrajna iti tad-vidah' AS transliteration_simple,
    'This body, Kaunteya, is called the field. The one who knows it, those who understand call the knower of the field.' AS translation_literal,
    'This body is what gets called the field. And whatever knows it — those who have thought about this call that the one who knows the field.' AS translation_en,
    'इस शरीर को ही क्षेत्र कहा जाता है। और जो इसे जानता है — जिन्होंने इस पर सोचा है वे उसे क्षेत्रज्ञ कहते हैं।' AS translation_hi,
    'Is sharir ko hi kshetra kaha jaata hai. Aur jo ise jaanta hai — jinhone is par socha hai woh use kshetragya kehte hain.' AS translation_hinglish,
    'Two words, and the whole chapter is about not letting them become a place to escape to.' AS summary_en,
    'दो शब्द, और पूरा अध्याय इस बारे में है कि इन्हें भाग जाने की जगह न बनने दिया जाए।' AS summary_hi,
    'Do shabd, aur poora adhyay is baare mein hai ki inhe bhaag jaane ki jagah na banne diya jaaye.' AS summary_hinglish,
    'intermediate' AS difficulty,
    'Gita 13.2: the field, and whatever knows the field' AS seo_title,
    'The Bhagavad Gita names the body the field and what knows it the knower of the field. Four verses later it puts awareness itself inside the field.' AS seo_description,
    1 AS published

  UNION ALL SELECT 6, 495, 1, 'gita-13-6',
    'इच्छा द्वेषः सुखं दुःखं संघातश्चेतना धृतिः।\nएतत्क्षेत्रं समासेन सविकारमुदाहृतम्॥',
    'icchā dveṣaḥ sukhaṁ duḥkhaṁ saṅghātaś cetanā dhṛtiḥ\netat kṣetraṁ samāsena sa-vikāram udāhṛtam',
    'ichchha dveshah sukham duhkham sanghatash chetana dhritih\netat kshetram samasena sa-vikaram udahritam',
    'Desire, aversion, pleasure, pain, the aggregate, awareness, firmness — this, in brief, is the field with its modifications.',
    'Wanting. Not wanting. Feeling good. Hurting. The whole assembled thing. Awareness. Holding together. That is the field, briefly, and everything that happens in it.',
    'चाह। न चाहना। अच्छा लगना। दुख होना। यह पूरा जुड़ा हुआ ढाँचा। चेतना। थामे रहना। संक्षेप में यही क्षेत्र है, और इसमें जो कुछ होता रहता है।',
    'Chaah. Na chahna. Achha lagna. Dukh hona. Yeh poora juda hua dhaancha. Chetna. Thaame rehna. Sankshep mein yahi kshetra hai, aur isme jo kuch hota rehta hai.',
    'Awareness is on the list of things observed. That is why the watcher is not a place you can climb into.',
    'चेतना उन चीज़ों की सूची में है जो देखी जाती हैं। इसीलिए देखने वाला कोई ऐसी जगह नहीं है जिसमें चढ़कर बैठा जा सके।',
    'Chetna un cheezon ki soochi mein hai jo dekhi jaati hain. Isiliye dekhne wala koi aisi jagah nahi hai jisme chadhkar baitha ja sake.',
    'intermediate',
    'Gita 13.6: awareness is on the list of things observed',
    'The Bhagavad Gita lists what the field contains and puts cetana — awareness — inside it. That one item rules out treating the witness as somewhere to go.',
    1

  UNION ALL SELECT 8, 497, 1, 'gita-13-8',
    'अमानित्वमदम्भित्वमहिंसा क्षान्तिरार्जवम्।\nआचार्योपासनं शौचं स्थैर्यमात्मविनिग्रहः॥',
    'amānitvam adambhitvam ahiṁsā kṣāntir ārjavam\nācāryopāsanaṁ śaucaṁ sthairyam ātma-vinigrahaḥ',
    'amanitvam adambhitvam ahimsa kshantir arjavam\nacharyopasanam shaucham sthairyam atma-vinigrahah',
    'Absence of self-importance, absence of pretence, non-injury, patience, straightness, attending on a teacher, cleanness, steadiness, self-restraint.',
    'Not making much of yourself. Not putting on a show. Not doing harm. Being able to wait. Being straight. Sitting with somebody who knows more. Being clean. Being steady. Some hold on yourself.',
    'अपने को बड़ा न बनाना। दिखावा न करना। नुक़सान न पहुँचाना। ठहर पाना। सीधा होना। ऐसे किसी के पास बैठना जो ज़्यादा जानता है। साफ़-सुथरा होना। टिका हुआ होना। अपने पर कुछ पकड़।',
    'Apne ko bada na banana. Dikhava na karna. Nuksaan na pahunchana. Thehar paana. Seedha hona. Aise kisi ke paas baithna jo zyada jaanta hai. Saaf-suthra hona. Tika hua hona. Apne par kuch pakad.',
    'The chapter was asked what knowledge is. It answers with a list of things people do.',
    'अध्याय से पूछा गया था कि ज्ञान क्या है। वह जवाब में उन चीज़ों की सूची देता है जो लोग करते हैं।',
    'Adhyay se poochha gaya tha ki gyan kya hai. Woh jawab mein un cheezon ki soochi deta hai jo log karte hain.',
    'intermediate',
    'Gita 13.8: asked what knowledge is, it answers with behaviour',
    'The Bhagavad Gita defines knowledge as a list of ordinary conduct beginning with not making much of yourself. Nothing on the list is a proposition.',
    1

  UNION ALL SELECT 20, 509, 1, 'gita-13-20',
    'कार्यकारणकर्तृत्वे हेतुः प्रकृतिरुच्यते।\nपुरुषः सुखदुःखानां भोक्तृत्वे हेतुरुच्यते॥',
    'kārya-kāraṇa-kartṛtve hetuḥ prakṛtir ucyate\npuruṣaḥ sukha-duḥkhānāṁ bhoktṛtve hetur ucyate',
    'karya-karana-kartritve hetuh prakritir uchyate\npurushah sukha-duhkhanam bhoktritve hetur uchyate',
    'Prakriti is said to be the cause in the matter of doing, of effect and instrument. Purusha is said to be the cause in the matter of undergoing pleasure and pain.',
    'When it comes to things getting done — the doing, the tools, the results — the cause is the material. When it comes to something being gone through, pleasant or painful, the cause is the one going through it.',
    'जब बात चीज़ों के होने की हो — करना, औज़ार, नतीजे — तो कारण है वह सामग्री। और जब बात किसी चीज़ से गुज़रने की हो, सुखद हो या दुखद, तो कारण है वह जो उससे गुज़र रहा है।',
    'Jab baat cheezon ke hone ki ho — karna, auzaar, nateeje — to kaaran hai woh samagri. Aur jab baat kisi cheez se guzarne ki ho, sukhad ho ya dukhad, to kaaran hai woh jo usse guzar raha hai.',
    'The doing is handed to the material. The undergoing is not, and the verse is careful about that.',
    'करना सामग्री को सौंप दिया गया है। गुज़रना नहीं, और श्लोक इस बारे में सावधान है।',
    'Karna samagri ko saunp diya gaya hai. Guzarna nahi, aur shloka is baare mein savdhan hai.',
    'intermediate',
    'Gita 13.20: the doing is handed over, the undergoing is not',
    'The Bhagavad Gita assigns action to prakriti and the experience of pleasure and pain to purusha. The second half is what stops this becoming a way of not being there.',
    1

  UNION ALL SELECT 27, 516, 1, 'gita-13-27',
    'समं सर्वेषु भूतेषु तिष्ठन्तं परमेश्वरम्।\nविनश्यत्स्वविनश्यन्तं यः पश्यति स पश्यति॥',
    'samaṁ sarveṣu bhūteṣu tiṣṭhantaṁ parameśvaram\nvinaśyatsv avinaśyantaṁ yaḥ paśyati sa paśyati',
    'samam sarveshu bhuteshu tishthantam parameshvaram\nvinashyatsv avinashyantam yah pashyati sa pashyati',
    'One who sees the supreme lord standing equally in all beings, undying among the dying — that one sees.',
    'The same thing standing in every one of them. Not being destroyed while everything around it is. Whoever sees that, sees.',
    'हर एक में वही चीज़ खड़ी है। जब चारों तरफ़ सब मिट रहा हो तब भी वह नहीं मिटती। जो यह देख लेता है, वही देखता है।',
    'Har ek mein wahi cheez khadi hai. Jab chaaron taraf sab mit raha ho tab bhi woh nahi mitti. Jo yeh dekh leta hai, wahi dekhta hai.',
    '"Sees, sees" — the same verb twice. Everybody else is doing something, and the verse declines to call it seeing.',
    '"देखता है, देखता है" — वही क्रिया दो बार। बाक़ी सब कुछ कर रहे हैं, और श्लोक उसे देखना कहने से इनकार कर देता है।',
    '"Dekhta hai, dekhta hai" — wahi kriya do baar. Baaki sab kuch kar rahe hain, aur shloka use dekhna kehne se inkaar kar deta hai.',
    'intermediate',
    'Gita 13.27: whoever sees that, sees',
    'The Bhagavad Gita repeats one verb: the person who sees the same thing standing in all beings is the one who sees. The same claim 5.18 makes.',
    1

  UNION ALL SELECT 29, 518, 1, 'gita-13-29',
    'समं पश्यन्हि सर्वत्र समवस्थितमीश्वरम्।\nन हिनस्त्यात्मनात्मानं ततो याति परां गतिम्॥',
    'samaṁ paśyan hi sarvatra samavasthitam īśvaram\nna hinasty ātmanātmānaṁ tato yāti parāṁ gatim',
    'samam pashyan hi sarvatra samavasthitam ishvaram\nna hinasty atmanatmanam tato yati param gatim',
    'Seeing the lord equally established everywhere, he does not injure himself by himself, and thereby goes to the highest state.',
    'Because he sees it standing the same everywhere, he does not do himself harm with his own hands. And that is how he gets where he is going.',
    'क्योंकि वह उसे हर जगह एक-सा खड़ा देखता है, वह अपने ही हाथों अपना नुक़सान नहीं करता। और वहीं से वह पहुँचता है जहाँ जाना है।',
    'Kyunki woh use har jagah ek-sa khada dekhta hai, woh apne hi haathon apna nuksaan nahi karta. Aur wahin se woh pahunchta hai jahan jaana hai.',
    'The chapter''s own wellbeing verse. Seeing this way produces less self-harm, not more distance.',
    'अध्याय का अपना कल्याण वाला श्लोक। इस तरह देखने से ख़ुद को नुक़सान कम होता है, दूरी ज़्यादा नहीं।',
    'Adhyay ka apna kalyan wala shloka. Is tarah dekhne se khud ko nuksaan kam hota hai, doori zyada nahi.',
    'intermediate',
    'Gita 13.29: he does not injure himself by himself',
    'The Bhagavad Gita says seeing evenly is what stops a person harming themselves. Any reading of this chapter that leaves you further from yourself is contradicted here.',
    1

  UNION ALL SELECT 32, 521, 1, 'gita-13-32',
    'अनादित्वान्निर्गुणत्वात्परमात्मायमव्ययः।\nशरीरस्थोऽपि कौन्तेय न करोति न लिप्यते॥',
    'anāditvān nirguṇatvāt paramātmāyam avyayaḥ\nśarīra-stho ''pi kaunteya na karoti na lipyate',
    'anaditvan nirgunatvat paramatmayam avyayah\nsharira-stho pi kaunteya na karoti na lipyate',
    'Being without beginning and without qualities, this supreme self is imperishable. Though situated in the body, Kaunteya, it neither acts nor is stained.',
    'Having no start and no settings of its own, this does not wear out. And although it is sitting right inside the body, it does not do the doing and nothing soaks into it.',
    'न इसकी कोई शुरुआत है और न इसकी अपनी कोई अवस्था, इसलिए यह घिसता नहीं। और शरीर के भीतर ही बैठा होने पर भी, यह करने वाला नहीं होता और इसमें कुछ रिसता नहीं।',
    'Na iski koi shuruaat hai aur na iski apni koi avastha, isliye yeh ghista nahi. Aur sharir ke bheetar hi baitha hone par bhi, yeh karne wala nahi hota aur isme kuch rista nahi.',
    'Śarīra-sthaḥ — sitting inside the body. The verse puts it there before it says anything else.',
    'शरीरस्थः — शरीर के भीतर बैठा। श्लोक कुछ और कहने से पहले उसे वहाँ रख देता है।',
    'Sharira-sthah — sharir ke bheetar baitha. Shloka kuch aur kehne se pehle use wahan rakh deta hai.',
    'intermediate',
    'Gita 13.32: sitting inside the body, and not soaked by it',
    'The Bhagavad Gita says the self is situated in the body and is not stained. Not stained means not coloured by. It does not mean not touched and it does not mean not felt.',
    1

  UNION ALL SELECT 34, 523, 1, 'gita-13-34',
    'यथा प्रकाशयत्येकः कृत्स्नं लोकमिमं रविः।\nक्षेत्रं क्षेत्री तथा कृत्स्नं प्रकाशयति भारत॥',
    'yathā prakāśayaty ekaḥ kṛtsnaṁ lokam imaṁ raviḥ\nkṣetraṁ kṣetrī tathā kṛtsnaṁ prakāśayati bhārata',
    'yatha prakashayaty ekah kritsnam lokam imam ravih\nkshetram kshetri tatha kritsnam prakashayati bharata',
    'As one sun lights up this entire world, so the owner of the field lights up the entire field.',
    'One sun lights the whole of this world. In the same way, whatever the field belongs to lights the whole of the field.',
    'एक ही सूरज इस पूरी दुनिया को रोशन करता है। उसी तरह, यह क्षेत्र जिसका है वह पूरे क्षेत्र को रोशन करता है।',
    'Ek hi sooraj is poori duniya ko roshan karta hai. Usi tarah, yeh kshetra jiska hai woh poore kshetra ko roshan karta hai.',
    'The whole field. Not the parts of it you approve of.',
    'पूरा क्षेत्र। उसके वे हिस्से नहीं जिन्हें आपकी मंज़ूरी है।',
    'Poora kshetra. Uske woh hisse nahi jinhe tumhari manzoori hai.',
    'intermediate',
    'Gita 13.34: one sun, and it lights the whole field',
    'The Bhagavad Gita closes chapter 13 with a sun that lights everything indiscriminately. The word is kritsnam — the whole of it, not the parts you approve of.',
    1

) AS v
JOIN chapters c ON c.chapter_number = 13;

-- =====================================================================
-- 2. EXPLANATIONS
-- =====================================================================
-- All at beginner depth. The load-bearing sentences, all asserted by
-- smoke-test.sh on the DEFAULT render:
--   13.6   awareness is on the list of things observed
--   13.29  the chapter's own wellbeing line
--   13.32  not stained means not coloured by, not not-felt
-- =====================================================================

DELETE ve FROM verse_explanations ve JOIN verses v ON v.id = ve.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 13;

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 2 AS vn, 'beginner' AS level,
   'Arjuna has asked a direct question with four terms in it, and the answer starts by defining two of them. This is the most technical opening in the book and it is worth going slowly.' AS h_en,
   'अर्जुन ने चार शब्दों वाला सीधा सवाल पूछा है, और जवाब उनमें से दो को परिभाषित करके शुरू होता है। किताब की यह सबसे तकनीकी शुरुआत है और यहाँ धीरे चलना ठीक रहेगा।' AS h_hi,
   'Arjun ne chaar shabdon wala seedha sawal poochha hai, aur jawab unme se do ko paribhashit karke shuru hota hai. Kitaab ki yeh sabse takneeki shuruaat hai aur yahan dheere chalna theek rahega.' AS h_hing,
   'Kṣetra is a field — an area of ground, something worked on. Kṣetrajña is whatever knows it. The verse does not say the second one is you and the first one is not; it says one is called this and the other is called that, and then spends thirty verses on what each contains.' AS p_en,
   'क्षेत्र यानी खेत — ज़मीन का एक टुकड़ा, कोई ऐसी चीज़ जिस पर काम किया जाता है। क्षेत्रज्ञ वह है जो उसे जानता है। श्लोक यह नहीं कहता कि दूसरा आप हैं और पहला नहीं; वह कहता है कि एक को यह कहते हैं और दूसरे को वह, और फिर तीस श्लोक इस पर लगाता है कि किसमें क्या है।' AS p_hi,
   'Kshetra yani khet — zameen ka ek tukda, koi aisi cheez jis par kaam kiya jaata hai. Kshetragya woh hai jo use jaanta hai. Shloka yeh nahi kehta ki doosra tum ho aur pehla nahi; woh kehta hai ki ek ko yeh kehte hain aur doosre ko woh, aur phir tees shloka is par lagata hai ki kisme kya hai.' AS p_hing,
   'A version of this chapter has been travelling around for a long time in the form of one sentence: you are not this, you are the one watching it. It is worth being careful, because handed to somebody in pain, or grieving, or already feeling unreal, that sentence is not wisdom — it is an exit. The chapter itself does not offer it as one. Four verses from here it puts awareness on the list of things being watched, and twenty-seven verses from here it says the point of all this is that a person stops harming themselves. Both of those make the exit reading impossible, and both are in the text rather than in this note.' AS m_en,
   'इस अध्याय का एक रूप लंबे समय से एक वाक्य की शक्ल में घूम रहा है: तुम यह नहीं हो, तुम वह हो जो इसे देख रहा है। सावधानी ज़रूरी है, क्योंकि दर्द में, शोक में, या पहले से ही अपने को अवास्तविक महसूस करते किसी को यह वाक्य दिया जाए तो वह ज्ञान नहीं, निकलने का रास्ता है। अध्याय ख़ुद इसे रास्ते की तरह नहीं देता। यहाँ से चार श्लोक बाद वह चेतना को उन चीज़ों की सूची में रख देता है जो देखी जाती हैं, और सत्ताईस श्लोक बाद कहता है कि इस सबका मतलब यह है कि आदमी ख़ुद को नुक़सान पहुँचाना बंद कर देता है। दोनों बातें उस निकास वाले पाठ को नामुमकिन कर देती हैं, और दोनों ग्रंथ में हैं, इस टिप्पणी में नहीं।' AS m_hi,
   'Is adhyay ka ek roop lambe samay se ek vakya ki shakl mein ghoom raha hai: tum yeh nahi ho, tum woh ho jo ise dekh raha hai. Savdhani zaroori hai, kyunki dard mein, shok mein, ya pehle se hi apne ko avastavik mehsoos karte kisi ko yeh vakya diya jaaye to woh gyan nahi, nikalne ka raasta hai. Adhyay khud ise raaste ki tarah nahi deta. Yahan se chaar shloka baad woh chetna ko un cheezon ki soochi mein rakh deta hai jo dekhi jaati hain, aur sattais shloka baad kehta hai ki is sabka matlab yeh hai ki aadmi khud ko nuksaan pahunchana band kar deta hai. Dono baatein us nikaas wale paath ko namumkin kar deti hain, aur dono granth mein hain, is tippani mein nahi.' AS m_hing

  UNION ALL SELECT 6, 'beginner',
   'Having named the field, the chapter now says what is in it. The list is short and the order is not decorative.',
   'क्षेत्र का नाम लेने के बाद अध्याय अब बताता है कि उसमें है क्या। सूची छोटी है और उसका क्रम सजावट नहीं है।',
   'Kshetra ka naam lene ke baad adhyay ab batata hai ki usme hai kya. Soochi chhoti hai aur uska kram sajawat nahi hai.',
   'Wanting, not wanting, feeling good, hurting, the assembled body, cetanā, dhṛti. The last two are the ones to stop on. Cetanā is awareness. Dhṛti is holding together, the thing that keeps a person in one piece. Both are inside the field.',
   'चाह, न चाहना, अच्छा लगना, दुख होना, यह जुड़ा हुआ ढाँचा, चेतना, धृति। रुकने लायक़ आख़िरी दो हैं। चेतना यानी होश। धृति यानी थामे रहना, वह चीज़ जो आदमी को एक टुकड़े में रखती है। दोनों क्षेत्र के भीतर हैं।',
   'Chaah, na chahna, achha lagna, dukh hona, yeh juda hua dhaancha, chetna, dhriti. Rukne layak aakhiri do hain. Chetna yani hosh. Dhriti yani thaame rehna, woh cheez jo aadmi ko ek tukde mein rakhti hai. Dono kshetra ke bheetar hain.',
   'That is the sentence the whole chapter turns on and almost nobody quotes it. If awareness is on the list of things observed, then the watcher is not a place a person can go and sit — and any practice that consists of climbing into it has misread the verse that defines it. What is left is something much smaller and much more usable: on a bad afternoon, the wanting and the hurting are contents of a field rather than the whole of what is there. That is a description, not a destination, and nobody has to leave anywhere to use it.',
   'यही वह वाक्य है जिस पर पूरा अध्याय टिका है और इसे लगभग कोई उद्धृत नहीं करता। अगर चेतना उन चीज़ों की सूची में है जो देखी जाती हैं, तो देखने वाला कोई ऐसी जगह नहीं है जहाँ आदमी जाकर बैठ सके — और जो अभ्यास उसमें चढ़ बैठने से बना हो उसने उसी श्लोक को ग़लत पढ़ा है जो उसे परिभाषित करता है। जो बचता है वह कहीं छोटा और कहीं ज़्यादा काम का है: किसी बुरी दोपहर में, चाह और दुख एक क्षेत्र की सामग्री हैं, वहाँ जो कुछ है उसका पूरा नहीं। यह वर्णन है, मंज़िल नहीं, और इसे बरतने के लिए किसी को कहीं से जाना नहीं पड़ता।',
   'Yahi woh vakya hai jis par poora adhyay tika hai aur ise lagbhag koi uddhrit nahi karta. Agar chetna un cheezon ki soochi mein hai jo dekhi jaati hain, to dekhne wala koi aisi jagah nahi hai jahan aadmi jaakar baith sake — aur jo abhyas usme chadh baithne se bana ho usne usi shloka ko galat padha hai jo use paribhashit karta hai. Jo bachta hai woh kahin chhota aur kahin zyada kaam ka hai: kisi buri dopahar mein, chaah aur dukh ek kshetra ki samagri hain, wahan jo kuch hai uska poora nahi. Yeh varnan hai, manzil nahi, aur ise baratne ke liye kisi ko kahin se jaana nahi padta.'

  UNION ALL SELECT 8, 'beginner',
   'Arjuna asked what jñāna is. This is where the answer starts, and it runs for five verses without a single claim about the nature of reality in it.',
   'अर्जुन ने पूछा था कि ज्ञान क्या है। जवाब यहाँ से शुरू होता है, और पाँच श्लोक चलता है जिनमें वास्तविकता की प्रकृति के बारे में एक भी दावा नहीं है।',
   'Arjun ne poochha tha ki gyan kya hai. Jawab yahan se shuru hota hai, aur paanch shloka chalta hai jinme vastavikta ki prakriti ke baare mein ek bhi dawa nahi hai.',
   'Not making much of yourself. Not putting on a show. Not doing harm. Being able to wait. Being straight. Every item is something a person does or refrains from doing, and it could be checked by somebody watching them for a fortnight.',
   'अपने को बड़ा न बनाना। दिखावा न करना। नुक़सान न पहुँचाना। ठहर पाना। सीधा होना। हर चीज़ वह है जो कोई करता है या करने से रुकता है, और पखवाड़े भर उसे देखने वाला कोई इन्हें जाँच सकता है।',
   'Apne ko bada na banana. Dikhava na karna. Nuksaan na pahunchana. Thehar paana. Seedha hona. Har cheez woh hai jo koi karta hai ya karne se rukta hai, aur pakhwade bhar use dekhne wala koi inhe jaanch sakta hai.',
   'A chapter about the difference between the body and what knows it defines knowledge as conduct. That is worth sitting with, because it is the opposite of what the chapter''s reputation would suggest. And note the first item: amānitva, not making much of yourself. Somebody who has understood chapter 13 well would be, by the chapter''s own account, less likely to say so. Ahiṁsā is third, and 13.29 will make it explicit that it applies to yourself as well as to everybody else.',
   'शरीर और उसे जानने वाले के फ़र्क़ का अध्याय ज्ञान को बरताव बता देता है। इस पर ठहरना काम का है, क्योंकि यह उसका उल्टा है जिसकी उम्मीद इस अध्याय की शोहरत से बनती है। और पहली चीज़ देखिए: अमानित्व, अपने को बड़ा न बनाना। जिसने तेरहवाँ अध्याय ठीक से समझ लिया हो, अध्याय के अपने हिसाब से, उसके यह कहने की संभावना कम होगी। अहिंसा तीसरे नंबर पर है, और 13.29 साफ़ कर देगा कि वह बाक़ी सबकी तरह ख़ुद पर भी लागू होती है।',
   'Sharir aur use jaanne wale ke farq ka adhyay gyan ko bartav bata deta hai. Is par thehrna kaam ka hai, kyunki yeh uska ulta hai jiski ummeed is adhyay ki shohrat se banti hai. Aur pehli cheez dekho: amanitva, apne ko bada na banana. Jisne terahvan adhyay theek se samajh liya ho, adhyay ke apne hisaab se, uske yeh kehne ki sambhavna kam hogi. Ahimsa teesre number par hai, aur 13.29 saaf kar dega ki woh baaki sabki tarah khud par bhi laagu hoti hai.'

  UNION ALL SELECT 20, 'beginner',
   'The chapter is halfway through and turns to the division of labour between the two things it named at the start.',
   'अध्याय आधा हो चुका है और अब उन दो चीज़ों के बीच काम के बँटवारे पर आता है जिनका नाम उसने शुरू में लिया था।',
   'Adhyay aadha ho chuka hai aur ab un do cheezon ke beech kaam ke bantware par aata hai jinka naam usne shuru mein liya tha.',
   'Two halves and they do not match. When it comes to doing — the action, the instrument, the result — the cause is prakṛti. When it comes to undergoing pleasure and pain, the cause is the puruṣa. Doing is handed over. Undergoing is not.',
   'दो आधे, और वे मेल नहीं खाते। जब बात करने की हो — कर्म, औज़ार, नतीजा — तो कारण प्रकृति है। जब बात सुख और दुख से गुज़रने की हो, तो कारण पुरुष है। करना सौंप दिया गया। गुज़रना नहीं।',
   'Do aadhe, aur woh mel nahi khate. Jab baat karne ki ho — karm, auzaar, nateeja — to kaaran prakriti hai. Jab baat sukh aur dukh se guzarne ki ho, to kaaran purush hai. Karna saunp diya gaya. Guzarna nahi.',
   'That asymmetry is the most useful thing in the chapter and it is easy to read straight past. If both halves had been handed to prakṛti, this would be a text about not being here — the doing is not yours and the feeling is not yours either, so nothing is happening to anybody. The verse declines to say that. Somebody is going through it. Chapter 3 already took authorship of outcomes away and chapter 5 took authorship of the doing; neither of them, and not this verse, takes away the fact that a person is the one it is happening to.',
   'यही असंतुलन इस अध्याय की सबसे काम की बात है और इसे पढ़ते हुए निकल जाना आसान है। अगर दोनों आधे प्रकृति को सौंप दिए जाते, तो यह वहाँ न होने का ग्रंथ होता — करना तुम्हारा नहीं और महसूस होना भी तुम्हारा नहीं, तो किसी के साथ कुछ हो ही नहीं रहा। श्लोक यह कहने से इनकार करता है। कोई इससे गुज़र रहा है। तीसरा अध्याय नतीजों का कर्तापन पहले ही हटा चुका है और पाँचवाँ करने का; उनमें से कोई भी, और यह श्लोक भी, यह नहीं हटाता कि जिसके साथ यह हो रहा है वह एक इंसान है।',
   'Yahi asantulan is adhyay ki sabse kaam ki baat hai aur ise padhte hue nikal jaana aasan hai. Agar dono aadhe prakriti ko saunp diye jaate, to yeh wahan na hone ka granth hota — karna tumhara nahi aur mehsoos hona bhi tumhara nahi, to kisi ke saath kuch ho hi nahi raha. Shloka yeh kehne se inkaar karta hai. Koi isse guzar raha hai. Teesra adhyay nateejon ka kartapan pehle hi hata chuka hai aur paanchwan karne ka; unme se koi bhi, aur yeh shloka bhi, yeh nahi hatata ki jiske saath yeh ho raha hai woh ek insan hai.'

  UNION ALL SELECT 27, 'beginner',
   'The chapter turns from what things are to what seeing them properly would look like. Three verses do it and this is the first.',
   'अध्याय चीज़ें क्या हैं, इससे मुड़कर इस तरफ़ आता है कि उन्हें ठीक से देखना कैसा होगा। तीन श्लोक यह करते हैं और यह पहला है।',
   'Adhyay cheezein kya hain, isse mudkar is taraf aata hai ki unhe theek se dekhna kaisa hoga. Teen shloka yeh karte hain aur yeh pehla hai.',
   'The same thing standing in all of them, not being destroyed while everything around it is. Then the last three words, and they are the whole verse: yaḥ paśyati sa paśyati — whoever sees, that one sees. The same verb twice, and nothing else offered.',
   'हर एक में वही चीज़ खड़ी है, और चारों तरफ़ सब मिटते हुए भी वह नहीं मिटती। फिर आख़िरी तीन शब्द, और वही पूरा श्लोक हैं: यः पश्यति स पश्यति — जो देखता है, वही देखता है। वही क्रिया दो बार, और कुछ नहीं दिया गया।',
   'Har ek mein wahi cheez khadi hai, aur chaaron taraf sab mitte hue bhi woh nahi mitti. Phir aakhiri teen shabd, aur wahi poora shloka hain: yah pashyati sa pashyati — jo dekhta hai, wahi dekhta hai. Wahi kriya do baar, aur kuch nahi diya gaya.',
   'This is 5.18 again in a different key. There the list was a scholar, a cow, an elephant, a dog and a śvapāka, and the wise saw the same in all five. Here there is no list at all, which makes it harder to argue with and harder to congratulate yourself about. The verse refuses to say what the ones who do not see are doing instead. It just declines to call it seeing.',
   'यह 5.18 ही है, दूसरे सुर में। वहाँ सूची थी — एक विद्वान, गाय, हाथी, कुत्ता और एक श्वपाक — और ज्ञानी पाँचों में वही देखते थे। यहाँ कोई सूची है ही नहीं, जिससे इससे बहस करना भी मुश्किल है और अपनी पीठ थपथपाना भी। श्लोक यह कहने से इनकार करता है कि जो नहीं देखते वे इसके बजाय क्या कर रहे हैं। वह बस उसे देखना कहने से मना कर देता है।',
   'Yeh 5.18 hi hai, doosre sur mein. Wahan soochi thi — ek vidwan, gaay, haathi, kutta aur ek shvapak — aur gyani paanchon mein wahi dekhte the. Yahan koi soochi hai hi nahi, jisse isse behes karna bhi mushkil hai aur apni peeth thapthapana bhi. Shloka yeh kehne se inkaar karta hai ki jo nahi dekhte woh iske bajaye kya kar rahe hain. Woh bas use dekhna kehne se mana kar deta hai.'

  UNION ALL SELECT 29, 'beginner',
   'The second of the three seeing verses, and the one that says what the seeing is for. It is the most important verse in the chapter and it is almost never quoted.',
   'देखने वाले तीन श्लोकों में दूसरा, और वही जो बताता है कि यह देखना किसलिए है। यह अध्याय का सबसे ज़रूरी श्लोक है और इसे लगभग कभी उद्धृत नहीं किया जाता।',
   'Dekhne wale teen shlokon mein doosra, aur wahi jo batata hai ki yeh dekhna kisliye hai. Yeh adhyay ka sabse zaroori shloka hai aur ise lagbhag kabhi uddhrit nahi kiya jaata.',
   'Na hinasty ātmanā ātmānam. He does not injure the self by the self. The construction is the same one as in 6.5, where a person can raise themselves or let themselves sink, and it points the same way: what you do to yourself is a thing the text is watching.',
   'न हिनस्त्यात्मनात्मानम्। वह ख़ुद अपने से अपना नुक़सान नहीं करता। बनावट वही है जो 6.5 में है, जहाँ आदमी ख़ुद को उठा सकता है या डूबने दे सकता है, और इशारा भी वही है: आप अपने साथ क्या करते हैं, ग्रंथ उस पर नज़र रखे हुए है।',
   'Na hinasty atmana atmanam. Woh khud apne se apna nuksaan nahi karta. Banawat wahi hai jo 6.5 mein hai, jahan aadmi khud ko utha sakta hai ya doobne de sakta hai, aur ishara bhi wahi hai: tum apne saath kya karte ho, granth us par nazar rakhe hue hai.',
   'This is the chapter''s own wellbeing verse and it settles the question the whole chapter raises. Whatever "you are not the field" is supposed to do, the text says it produces LESS self-harm — not more distance, not less feeling, not a way of standing somewhere else while something happens to you. So any reading of 13.2 or 13.32 that leaves somebody further from themselves has been contradicted by the same chapter, twenty-seven verses later. If a practice built on this chapter is making you harder on yourself, the chapter is not what is asking for that.',
   'यह अध्याय का अपना कल्याण वाला श्लोक है और यह उसी सवाल को तय कर देता है जो पूरा अध्याय उठाता है। "तुम क्षेत्र नहीं हो" से जो भी होना हो, ग्रंथ कहता है कि उससे ख़ुद को नुक़सान कम होता है — दूरी ज़्यादा नहीं, महसूस होना कम नहीं, और यह भी नहीं कि आपके साथ कुछ हो रहा हो और आप कहीं और खड़े हों। तो 13.2 या 13.32 का कोई भी पाठ जो किसी को अपने आप से और दूर कर दे, उसी अध्याय ने सत्ताईस श्लोक बाद उसे काट दिया है। अगर इस अध्याय पर बना कोई अभ्यास आपको अपने ऊपर और सख़्त बना रहा है, तो वह माँग अध्याय की नहीं है।',
   'Yeh adhyay ka apna kalyan wala shloka hai aur yeh usi sawal ko tay kar deta hai jo poora adhyay uthata hai. "Tum kshetra nahi ho" se jo bhi hona ho, granth kehta hai ki usse khud ko nuksaan kam hota hai — doori zyada nahi, mehsoos hona kam nahi, aur yeh bhi nahi ki tumhare saath kuch ho raha ho aur tum kahin aur khade ho. To 13.2 ya 13.32 ka koi bhi paath jo kisi ko apne aap se aur door kar de, usi adhyay ne sattais shloka baad use kaat diya hai. Agar is adhyay par bana koi abhyas tumhe apne upar aur sakht bana raha hai, to woh maang adhyay ki nahi hai.'

  UNION ALL SELECT 32, 'beginner',
   'Near the end, and the verse people carry away from this chapter. It is also the one that can be read in two wrong directions at once.',
   'अंत के पास, और यही वह श्लोक है जो लोग इस अध्याय से साथ ले जाते हैं। और यही वह भी है जिसे एक साथ दो ग़लत दिशाओं में पढ़ा जा सकता है।',
   'Ant ke paas, aur yahi woh shloka hai jo log is adhyay se saath le jaate hain. Aur yahi woh bhi hai jise ek saath do galat dishaon mein padha ja sakta hai.',
   'Śarīra-sthaḥ api — although situated in the body. The verse puts it inside before it says anything else, which is the same move 5.10 made with the leaf: the leaf is in the water the whole time. Then na karoti na lipyate — does not do the doing, and nothing soaks in.',
   'शरीरस्थोऽपि — शरीर के भीतर होते हुए भी। श्लोक कुछ और कहने से पहले उसे भीतर रख देता है, और यही चाल 5.10 ने पत्ते के साथ चली थी: पत्ता पूरे समय पानी में ही है। फिर न करोति न लिप्यते — करने वाला नहीं होता, और कुछ रिसता नहीं।',
   'Sharira-sthah api — sharir ke bheetar hote hue bhi. Shloka kuch aur kehne se pehle use bheetar rakh deta hai, aur yahi chaal 5.10 ne patte ke saath chali thi: patta poore samay paani mein hi hai. Phir na karoti na lipyate — karne wala nahi hota, aur kuch rista nahi.',
   'Two wrong readings and both need refusing. The first: not stained means not coloured by, not soaked through. It does not mean not touched and it does not mean not felt — the leaf sits in the water all day. This is not an instruction to stop feeling things, and if there is real pain present then "you are not this" is not a technique. It will not work, and the chapter does not offer it as one. The second reading runs the other way: nothing attaches to me, so nothing I do matters. That one has to get past 13.29, three verses earlier, which says this seeing produces less harm rather than permission — and past 13.8, which defines the whole business as humility, no pretence, and doing no injury.',
   'दो ग़लत पाठ, और दोनों को नकारना ज़रूरी है। पहला: लिप्त न होना यानी रंग न चढ़ना, भीतर तक न भीगना। इसका मतलब न छुआ जाना नहीं है और न महसूस होना नहीं है — पत्ता दिन भर पानी में ही बैठा रहता है। यह चीज़ें महसूस करना बंद करने का निर्देश नहीं है, और अगर सचमुच दर्द मौजूद है तो "तुम यह नहीं हो" कोई तरकीब नहीं है। वह चलेगी नहीं, और अध्याय उसे तरकीब की तरह देता भी नहीं। दूसरा पाठ उल्टी तरफ़ जाता है: मुझ पर कुछ चिपकता नहीं, तो मैं जो करूँ उसका कोई मोल नहीं। उसे 13.29 से पार पाना होगा, जो तीन श्लोक पहले कहता है कि यह देखना छूट नहीं, कम नुक़सान पैदा करता है — और 13.8 से भी, जो पूरे मामले को विनम्रता, दिखावे का अभाव और नुक़सान न पहुँचाना बता देता है।',
   'Do galat paath, aur dono ko nakaarna zaroori hai. Pehla: lipt na hona yani rang na chadhna, bheetar tak na bheegna. Iska matlab na chhua jaana nahi hai aur na mehsoos hona nahi hai — patta din bhar paani mein hi baitha rehta hai. Yeh cheezein mehsoos karna band karne ka nirdesh nahi hai, aur agar sach mein dard maujood hai to "tum yeh nahi ho" koi tarkeeb nahi hai. Woh chalegi nahi, aur adhyay use tarkeeb ki tarah deta bhi nahi. Doosra paath ulti taraf jaata hai: mujh par kuch chipakta nahi, to main jo karoon uska koi mol nahi. Use 13.29 se paar paana hoga, jo teen shloka pehle kehta hai ki yeh dekhna chhoot nahi, kam nuksaan paida karta hai — aur 13.8 se bhi, jo poore mamle ko vinamrata, dikhave ka abhav aur nuksaan na pahunchana bata deta hai.'

  UNION ALL SELECT 34, 'beginner',
   'The last verse of the chapter, and after thirty-three verses of definitions it ends with a picture instead.',
   'अध्याय का आख़िरी श्लोक, और तैंतीस श्लोक की परिभाषाओं के बाद वह एक तस्वीर पर ख़त्म होता है।',
   'Adhyay ka aakhiri shloka, aur taintees shloka ki paribhashaon ke baad woh ek tasveer par khatam hota hai.',
   'One sun lights this whole world. In the same way the owner of the field lights the whole field. The word doing the work is kṛtsnam — the whole of it, entire, used twice in two lines.',
   'एक सूरज इस पूरी दुनिया को रोशन करता है। उसी तरह क्षेत्र का स्वामी पूरे क्षेत्र को रोशन करता है। काम करने वाला शब्द है कृत्स्नम् — पूरा का पूरा, समूचा, दो पंक्तियों में दो बार।',
   'Ek sooraj is poori duniya ko roshan karta hai. Usi tarah kshetra ka swami poore kshetra ko roshan karta hai. Kaam karne wala shabd hai kritsnam — poora ka poora, samoocha, do panktiyon mein do baar.',
   'Kṛtsnam is the point. The sun does not light the parts of the world it approves of; it is not doing any sorting at all. So the field gets lit entire — the wanting, the aversion, the pain, all of it on the list from 13.6. Most people reading a chapter like this one arrive hoping to illuminate the good parts and leave the rest in the dark, and the closing image says that is not how light works. It is a gentler ending than the chapter''s reputation suggests, and it is the last thing said.',
   'बात कृत्स्नम् की है। सूरज दुनिया के उन हिस्सों को रोशन नहीं करता जिन्हें उसकी मंज़ूरी है; वह छँटाई कर ही नहीं रहा। तो क्षेत्र पूरा का पूरा रोशन होता है — चाह, द्वेष, दुख, 13.6 की सूची का सब कुछ। ऐसा अध्याय पढ़ने आने वाले ज़्यादातर लोग यह उम्मीद लेकर आते हैं कि अच्छे हिस्सों पर रोशनी पड़े और बाक़ी अँधेरे में रहें, और आख़िरी तस्वीर कहती है कि रोशनी ऐसे काम नहीं करती। यह अंत उससे नरम है जिसकी उम्मीद इस अध्याय की शोहरत से बनती है, और यही आख़िरी बात कही गई है।',
   'Baat kritsnam ki hai. Sooraj duniya ke un hisson ko roshan nahi karta jinhe uski manzoori hai; woh chhantai kar hi nahi raha. To kshetra poora ka poora roshan hota hai — chaah, dwesh, dukh, 13.6 ki soochi ka sab kuch. Aisa adhyay padhne aane wale zyadatar log yeh ummeed lekar aate hain ki achhe hisson par roshni pade aur baaki andhere mein rahein, aur aakhiri tasveer kehti hai ki roshni aise kaam nahi karti. Yeh ant usse naram hai jiski ummeed is adhyay ki shohrat se banti hai, aur yahi aakhiri baat kahi gayi hai.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 13;

-- =====================================================================
-- 3. HOOKS, REFLECTIONS, PRACTICES, TOPICS
-- =====================================================================
-- NO PRACTICE IN THIS FILE ASKS A READER TO STEP BACK FROM, DISIDENTIFY
-- FROM OR OBSERVE THEMSELVES FROM A DISTANCE. That is the one thing
-- this chapter must not be turned into an exercise for. Every practice
-- here points at conduct — the 13.8 list — or at another person, and
-- the 13.29 practice is the only one in the corpus that asks the reader
-- to notice how they speak to themselves.
--
-- No reflection asks "are you the body or the witness".
-- =====================================================================

DELETE m FROM verse_memory_aids m JOIN verses v ON v.id = m.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 13;
DELETE r FROM verse_reflections r JOIN verses v ON v.id = r.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 13;
DELETE p FROM verse_practices p JOIN verses v ON v.id = p.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 13;
DELETE vt FROM verse_topics vt JOIN verses v ON v.id = vt.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 13;

INSERT INTO verse_memory_aids (verse_id, hook_en, hook_hi, hook_hinglish, analogy_en, analogy_hi, analogy_hinglish, visual_cue)
SELECT v.id, m.h_en, m.h_hi, m.h_hing, m.a_en, m.a_hi, m.a_hing, m.cue FROM (
  SELECT 2 AS vn,
  'A field, and whatever knows the field. Two words, not two places.' AS h_en,
  'एक खेत, और जो उस खेत को जानता है। दो शब्द, दो जगहें नहीं।' AS h_hi,
  'Ek khet, aur jo us khet ko jaanta hai. Do shabd, do jagahein nahi.' AS h_hing,
  'Like naming the pitch and the person reading it. Nobody leaves the ground.' AS a_en,
  'मैदान और उसे पढ़ने वाले, दोनों का नाम लेने जैसा। कोई मैदान से बाहर नहीं जाता।' AS a_hi,
  'Maidan aur use padhne wale, dono ka naam lene jaisa. Koi maidan se bahar nahi jaata.' AS a_hing,
  'A ploughed field, edge to edge' AS cue

  UNION ALL SELECT 6,
  'Awareness is on the list of things being watched.',
  'चेतना उन चीज़ों की सूची में है जो देखी जा रही हैं।',
  'Chetna un cheezon ki soochi mein hai jo dekhi ja rahi hain.',
  'Like finding the camera in the photograph. There is no step further back.',
  'तस्वीर में ही कैमरा मिल जाने जैसा। इससे और पीछे कोई क़दम नहीं है।',
  'Tasveer mein hi camera mil jaane jaisa. Isse aur peechhe koi kadam nahi hai.',
  'A list, with one unexpected item on it'

  UNION ALL SELECT 8,
  'Asked what knowledge is, it answers with behaviour.',
  'ज्ञान क्या है, यह पूछे जाने पर वह बरताव में जवाब देता है।',
  'Gyan kya hai, yeh poochhe jaane par woh bartav mein jawab deta hai.',
  'Like asking what a good doctor knows and being shown how they enter a room.',
  'यह पूछने जैसा कि अच्छा डॉक्टर क्या जानता है और जवाब में यह दिखाया जाना कि वह कमरे में घुसता कैसे है।',
  'Yeh poochhne jaisa ki achha doctor kya jaanta hai aur jawab mein yeh dikhaya jaana ki woh kamre mein ghusta kaise hai.',
  'A doorway, entered quietly'

  UNION ALL SELECT 20,
  'The doing is handed over. The undergoing is not.',
  'करना सौंप दिया गया। गुज़रना नहीं।',
  'Karna saunp diya gaya. Guzarna nahi.',
  'Like being told the machine ran itself, and you were still the one standing in front of it.',
  'यह बताए जाने जैसा कि मशीन ख़ुद चली, और आप फिर भी वही थे जो उसके सामने खड़ा था।',
  'Yeh bataye jaane jaisa ki machine khud chali, aur tum phir bhi wahi the jo uske saamne khada tha.',
  'A lever moving, a person watching'

  UNION ALL SELECT 27,
  'Whoever sees that, sees. The same verb, twice, and nothing else offered.',
  'जो यह देख लेता है, वही देखता है। वही क्रिया, दो बार, और कुछ नहीं दिया गया।',
  'Jo yeh dekh leta hai, wahi dekhta hai. Wahi kriya, do baar, aur kuch nahi diya gaya.',
  'Like a word repeated until it means something. It refuses to explain itself.',
  'उस शब्द जैसा जो दोहराया जाता है जब तक उसका मतलब न बने। वह अपनी सफ़ाई देने से इनकार करता है।',
  'Us shabd jaisa jo dohraya jaata hai jab tak uska matlab na bane. Woh apni safai dene se inkaar karta hai.',
  'One word, written twice'

  UNION ALL SELECT 29,
  'And therefore he does not do himself harm. That is what the seeing is for.',
  'और इसीलिए वह अपना नुक़सान नहीं करता। देखना इसी के लिए है।',
  'Aur isiliye woh apna nuksaan nahi karta. Dekhna isi ke liye hai.',
  'Like discovering the whole argument was about how you speak to yourself.',
  'यह पता चलने जैसा कि पूरी बहस इस बारे में थी कि आप ख़ुद से बात कैसे करते हैं।',
  'Yeh pata chalne jaisa ki poori behes is baare mein thi ki tum khud se baat kaise karte ho.',
  'A hand, not raised'

  UNION ALL SELECT 32,
  'Sitting inside the body. Nothing soaks in. Both halves are needed.',
  'शरीर के भीतर बैठा। कुछ रिसता नहीं। दोनों आधे ज़रूरी हैं।',
  'Sharir ke bheetar baitha. Kuch rista nahi. Dono aadhe zaroori hain.',
  'The lotus leaf from 5.10 again. It never left the water.',
  'फिर वही 5.10 वाला कमल का पत्ता। वह पानी से गया कभी नहीं।',
  'Phir wahi 5.10 wala kamal ka patta. Woh paani se gaya kabhi nahi.',
  'A leaf, beaded, still floating'

  UNION ALL SELECT 34,
  'One sun. The whole field, not the parts you approve of.',
  'एक सूरज। पूरा क्षेत्र, वे हिस्से नहीं जिन्हें आपकी मंज़ूरी है।',
  'Ek sooraj. Poora kshetra, woh hisse nahi jinhe tumhari manzoori hai.',
  'Like light through a window. It does not decide what to land on.',
  'खिड़की से आती रोशनी जैसी। वह तय नहीं करती कि किस पर पड़े।',
  'Khidki se aati roshni jaisi. Woh tay nahi karti ki kis par pade.',
  'A room lit corner to corner'
) AS m
JOIN verses v ON v.verse_number = m.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 13;

INSERT INTO verse_reflections (verse_id, question_en, question_hi, question_hinglish, display_order)
SELECT v.id, r.q_en, r.q_hi, r.q_hing, r.ord FROM (
  SELECT 2 AS vn, 'Where have you heard "you are not this" used? Did it help the person it was said to?' AS q_en, 'आपने "तुम यह नहीं हो" कहाँ इस्तेमाल होते सुना है? जिससे कहा गया था, उसका भला हुआ?' AS q_hi, 'Tumne "tum yeh nahi ho" kahan istemaal hote suna hai? Jisse kaha gaya tha, uska bhala hua?' AS q_hing, 1 AS ord
  UNION ALL SELECT 2, 'A field is something worked on, not something escaped. Does that change the picture?', 'खेत वह है जिस पर काम किया जाता है, वह नहीं जिससे भागा जाता है। क्या इससे तस्वीर बदलती है?', 'Khet woh hai jis par kaam kiya jaata hai, woh nahi jisse bhaaga jaata hai. Kya isse tasveer badalti hai?', 2
  UNION ALL SELECT 2, 'The verse defines two words and makes no claim about which one you are. Why might that be deliberate?', 'श्लोक दो शब्दों को परिभाषित करता है और यह दावा नहीं करता कि आप इनमें से क्या हैं। यह जानबूझकर क्यों हो सकता है?', 'Shloka do shabdon ko paribhashit karta hai aur yeh dawa nahi karta ki tum inme se kya ho. Yeh jaanboojhkar kyun ho sakta hai?', 3
  UNION ALL SELECT 6, 'Wanting, not wanting, feeling good, hurting. Which of the four is loudest today?', 'चाह, न चाहना, अच्छा लगना, दुख होना। इन चारों में से आज सबसे तेज़ कौन-सा है?', 'Chaah, na chahna, achha lagna, dukh hona. In chaaron mein se aaj sabse tez kaun sa hai?', 1
  UNION ALL SELECT 6, 'Awareness is on the list. Where does that leave the idea of stepping back?', 'चेतना सूची में है। इससे पीछे हट जाने के ख़याल का क्या होता है?', 'Chetna soochi mein hai. Isse peechhe hat jaane ke khayal ka kya hota hai?', 2
  UNION ALL SELECT 6, 'Dhriti — holding together — is also on the list. Has yours been doing its job this week?', 'धृति — थामे रहना — भी सूची में है। इस हफ़्ते आपकी अपना काम कर रही है?', 'Dhriti — thaame rehna — bhi soochi mein hai. Is hafte tumhari apna kaam kar rahi hai?', 3
  UNION ALL SELECT 8, 'Nine items and every one is a behaviour. Which would somebody watching you for a fortnight say you have?', 'नौ चीज़ें और हर एक बरताव है। पखवाड़े भर आपको देखने वाला कौन-सी बताएगा कि आपमें है?', 'Nau cheezein aur har ek bartav hai. Pakhwade bhar tumhe dekhne wala kaun si bataega ki tumme hai?', 1
  UNION ALL SELECT 8, 'The first item is not making much of yourself. Where is that hardest for you?', 'पहली चीज़ है अपने को बड़ा न बनाना। यह आपके लिए कहाँ सबसे मुश्किल है?', 'Pehli cheez hai apne ko bada na banana. Yeh tumhare liye kahan sabse mushkil hai?', 2
  UNION ALL SELECT 8, 'A chapter about the self defines knowledge as conduct. Does that surprise you?', 'आत्मा का अध्याय ज्ञान को बरताव बता देता है। क्या यह आपको चौंकाता है?', 'Atma ka adhyay gyan ko bartav bata deta hai. Kya yeh tumhe chaunkata hai?', 3
  UNION ALL SELECT 20, 'Something is being gone through and somebody is going through it. Does the verse let you off that?', 'कुछ गुज़र रहा है और कोई उससे गुज़र रहा है। क्या श्लोक आपको इससे छूट देता है?', 'Kuch guzar raha hai aur koi usse guzar raha hai. Kya shloka tumhe isse chhoot deta hai?', 1
  UNION ALL SELECT 20, 'Where do you hand over the doing but keep the blame?', 'कहाँ आप करना तो सौंप देते हैं और दोष अपने पास रखते हैं?', 'Kahan tum karna to saunp dete ho aur dosh apne paas rakhte ho?', 2
  UNION ALL SELECT 20, 'If both halves had been handed over, what kind of book would this be?', 'अगर दोनों आधे सौंप दिए जाते, तो यह किस तरह की किताब होती?', 'Agar dono aadhe saunp diye jaate, to yeh kis tarah ki kitaab hoti?', 3
  UNION ALL SELECT 27, 'Who is the person you find hardest to see the same thing in?', 'वह कौन है जिसमें आपको वही चीज़ देखना सबसे मुश्किल लगता है?', 'Woh kaun hai jisme tumhe wahi cheez dekhna sabse mushkil lagta hai?', 1
  UNION ALL SELECT 27, 'The verse gives no list, unlike 5.18. Is that harder or easier to argue with?', '5.18 के उलट यह श्लोक कोई सूची नहीं देता। इससे बहस करना ज़्यादा मुश्किल है या आसान?', '5.18 ke ulat yeh shloka koi soochi nahi deta. Isse behes karna zyada mushkil hai ya aasan?', 2
  UNION ALL SELECT 27, 'It refuses to say what the others are doing instead. What do you make of that?', 'वह यह कहने से इनकार करता है कि बाक़ी लोग इसके बजाय क्या कर रहे हैं। आप इसका क्या मतलब निकालते हैं?', 'Woh yeh kehne se inkaar karta hai ki baaki log iske bajaye kya kar rahe hain. Tum iska kya matlab nikalte ho?', 3
  UNION ALL SELECT 29, 'How do you speak to yourself when something has gone badly? Say one sentence out loud.', 'जब कुछ बुरा हो जाए तब आप ख़ुद से कैसे बात करते हैं? एक वाक्य ज़ोर से कहिए।', 'Jab kuch bura ho jaaye tab tum khud se kaise baat karte ho? Ek vakya zor se kaho.', 1
  UNION ALL SELECT 29, 'Would you say that sentence to somebody you were fond of?', 'क्या आप वह वाक्य किसी ऐसे से कहेंगे जो आपको प्रिय है?', 'Kya tum woh vakya kisi aise se kahoge jo tumhe priya hai?', 2
  UNION ALL SELECT 29, 'The chapter says this seeing produces less self-harm. Has any practice of yours produced more?', 'अध्याय कहता है कि इस तरह देखने से ख़ुद को नुक़सान कम होता है। आपके किसी अभ्यास से ज़्यादा हुआ है?', 'Adhyay kehta hai ki is tarah dekhne se khud ko nuksaan kam hota hai. Tumhare kisi abhyas se zyada hua hai?', 3
  UNION ALL SELECT 32, 'The leaf never leaves the water. What does that rule out as a reading?', 'पत्ता पानी से जाता कभी नहीं। यह किस पाठ को ख़ारिज कर देता है?', 'Patta paani se jaata kabhi nahi. Yeh kis paath ko khaarij kar deta hai?', 1
  UNION ALL SELECT 32, 'Not soaked and not touched are different. Where does that difference matter to you?', 'न भीगना और न छुआ जाना अलग हैं। यह फ़र्क़ आपके लिए कहाँ मायने रखता है?', 'Na bheegna aur na chhua jaana alag hain. Yeh farq tumhare liye kahan maayne rakhta hai?', 2
  UNION ALL SELECT 32, 'Has anybody ever used a line like this one to avoid something?', 'क्या कभी किसी ने ऐसी पंक्ति का इस्तेमाल कुछ टालने के लिए किया है?', 'Kya kabhi kisi ne aisi line ka istemaal kuch taalne ke liye kiya hai?', 3
  UNION ALL SELECT 34, 'Which part of your own field do you keep in the dark on purpose?', 'अपने क्षेत्र का कौन-सा हिस्सा आप जानबूझकर अँधेरे में रखते हैं?', 'Apne kshetra ka kaun sa hissa tum jaanboojhkar andhere mein rakhte ho?', 1
  UNION ALL SELECT 34, 'The sun does no sorting. What would it be like to read yourself that way for an hour?', 'सूरज कोई छँटाई नहीं करता। एक घंटे ख़ुद को उस तरह पढ़ना कैसा होगा?', 'Sooraj koi chhantai nahi karta. Ek ghante khud ko us tarah padhna kaisa hoga?', 2
  UNION ALL SELECT 34, 'The chapter ends gently. Were you expecting that?', 'अध्याय नरमी से ख़त्म होता है। क्या आपको इसकी उम्मीद थी?', 'Adhyay narmi se khatam hota hai. Kya tumhe iski ummeed thi?', 3
) AS r
JOIN verses v ON v.verse_number = r.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 13;

INSERT INTO verse_practices (verse_id, action_en, action_hi, action_hinglish, estimated_minutes, difficulty, display_order)
SELECT v.id, p.a_en, p.a_hi, p.a_hing, p.mins, p.diff, 1 FROM (
  SELECT 2 AS vn, 'Write down what happened today in the plainest words you have, with no verdict about yourself anywhere in it.' AS a_en, 'आज क्या हुआ, अपने सबसे सादे शब्दों में लिखिए, और उसमें कहीं भी अपने बारे में कोई फ़ैसला मत रखिए।' AS a_hi, 'Aaj kya hua, apne sabse saade shabdon mein likho, aur usme kahin bhi apne baare mein koi faisla mat rakho.' AS a_hing, 8 AS mins, 'beginner' AS diff
  UNION ALL SELECT 6, 'Name the four — wanting, not wanting, feeling good, hurting — as they were for you today. Four words. Do not act on any of them.', 'चारों का नाम लीजिए — चाह, न चाहना, अच्छा लगना, दुख होना — जैसे वे आज आपके लिए थे। चार शब्द। इनमें से किसी पर कुछ मत कीजिए।', 'Chaaron ka naam lo — chaah, na chahna, achha lagna, dukh hona — jaise woh aaj tumhare liye the. Chaar shabd. Inme se kisi par kuch mat karo.', 4, 'beginner'
  UNION ALL SELECT 8, 'Pick one item off the list — not making much of yourself, not putting on a show, not doing harm. Do that one today. Tell nobody.', 'सूची से एक चीज़ चुनिए — अपने को बड़ा न बनाना, दिखावा न करना, नुक़सान न पहुँचाना। आज वही एक कीजिए। किसी को मत बताइए।', 'Soochi se ek cheez chuno — apne ko bada na banana, dikhava na karna, nuksaan na pahunchana. Aaj wahi ek karo. Kisi ko mat batao.', 10, 'beginner'
  UNION ALL SELECT 20, 'Take one thing that went wrong. Separate what you did from what happened to you. Two columns, no conclusions.', 'कोई एक चीज़ लीजिए जो बिगड़ी। अलग कीजिए कि आपने क्या किया और आपके साथ क्या हुआ। दो कॉलम, कोई निष्कर्ष नहीं।', 'Koi ek cheez lo jo bigdi. Alag karo ki tumne kya kiya aur tumhare saath kya hua. Do column, koi nishkarsh nahi.', 10, 'intermediate'
  UNION ALL SELECT 27, 'Think of somebody you have written off. Find one thing about their week that is the same as one thing about yours.', 'ऐसे किसी के बारे में सोचिए जिसे आपने ख़ारिज कर रखा है। उनके हफ़्ते की एक बात ढूँढ़िए जो आपके हफ़्ते की किसी बात जैसी हो।', 'Aise kisi ke baare mein socho jise tumne khaarij kar rakha hai. Unke hafte ki ek baat dhoondho jo tumhare hafte ki kisi baat jaisi ho.', 8, 'intermediate'
  UNION ALL SELECT 29, 'For one day, notice what you say to yourself after a mistake. Write down one sentence exactly as it came. Say it out loud to nobody, and notice how it lands.', 'एक दिन ध्यान दीजिए कि ग़लती के बाद आप ख़ुद से क्या कहते हैं। एक वाक्य ठीक वैसे ही लिखिए जैसे वह आया। उसे ज़ोर से कहिए, किसी से नहीं, और देखिए कि वह कैसा लगता है।', 'Ek din dhyan do ki galti ke baad tum khud se kya kehte ho. Ek vakya theek waise hi likho jaise woh aaya. Use zor se kaho, kisi se nahi, aur dekho ki woh kaisa lagta hai.', 6, 'beginner'
  UNION ALL SELECT 32, 'Pick one thing you carried home yesterday. Ask whether it soaked in or whether you were only touched by it.', 'कल आप जो एक चीज़ घर तक लाए, उसे लीजिए। पूछिए कि वह भीतर तक भीगी या आप उससे बस छू भर गए थे।', 'Kal tum jo ek cheez ghar tak laye, use lo. Poocho ki woh bheetar tak bheegi ya tum usse bas chhoo bhar gaye the.', 5, 'intermediate'
  UNION ALL SELECT 34, 'Write down the part of this week you have not looked at. Just write it down. Nothing else is required.', 'इस हफ़्ते का वह हिस्सा लिखिए जिसे आपने देखा नहीं है। बस लिख दीजिए। और कुछ ज़रूरी नहीं है।', 'Is hafte ka woh hissa likho jise tumne dekha nahi hai. Bas likh do. Aur kuch zaroori nahi hai.', 5, 'beginner'
) AS p
JOIN verses v ON v.verse_number = p.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 13;

INSERT INTO verse_topics (verse_id, topic_id, relevance)
SELECT v.id, t.id, x.rel FROM (
  SELECT 2 AS vn, 'the-self' AS slug, 10 AS rel
  UNION ALL SELECT 2, 'grief', 6
  UNION ALL SELECT 2, 'steadiness', 6
  UNION ALL SELECT 6, 'the-self', 10
  UNION ALL SELECT 6, 'desire', 8
  UNION ALL SELECT 6, 'restlessness', 7
  UNION ALL SELECT 6, 'grief', 6
  UNION ALL SELECT 8, 'duty', 9
  UNION ALL SELECT 8, 'comparison', 8
  UNION ALL SELECT 8, 'steadiness', 7
  UNION ALL SELECT 20, 'the-self', 9
  UNION ALL SELECT 20, 'action-without-attachment', 8
  UNION ALL SELECT 20, 'grief', 7
  UNION ALL SELECT 27, 'comparison', 10
  UNION ALL SELECT 27, 'the-self', 8
  UNION ALL SELECT 27, 'impermanence', 7
  UNION ALL SELECT 29, 'burnout', 10
  UNION ALL SELECT 29, 'comparison', 8
  UNION ALL SELECT 29, 'steadiness', 7
  UNION ALL SELECT 29, 'fear', 6
  UNION ALL SELECT 32, 'action-without-attachment', 9
  UNION ALL SELECT 32, 'burnout', 8
  UNION ALL SELECT 32, 'the-self', 8
  UNION ALL SELECT 34, 'the-self', 9
  UNION ALL SELECT 34, 'steadiness', 7
  UNION ALL SELECT 34, 'grief', 6
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 13
JOIN topics t ON t.slug = x.slug;

-- =====================================================================
-- 4. MODERN EXAMPLES
-- =====================================================================
-- Four per verse, four distinct categories per verse, THIRTY-TWO total.
--
-- NOT ONE EXAMPLE IN THIS FILE SHOWS SOMEBODY GETTING RELIEF BY
-- STEPPING OUTSIDE THEMSELVES. That is the failure mode this chapter
-- invites and a worked example of it would be an instruction. Where
-- somebody in these stories gets somewhere, they get there by naming
-- what is present, by conduct off the 13.8 list, or by another person.
--
-- THE 13.29 SET IS ABOUT SELF-TALK AND NOTHING ELSE. In all four,
-- somebody notices how they speak to themselves and the test applied is
-- whether they would say it to somebody they were fond of.
-- =====================================================================

DELETE e FROM modern_examples e JOIN verses v ON v.id = e.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 13;

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
  'The sentence somebody said at a funeral' AS t_en, 'वह वाक्य जो किसी ने अंतिम संस्कार में कहा' AS t_hi, 'Woh vakya jo kisi ne antim sanskar mein kaha' AS t_hing,
  'At a funeral somebody tells the person closest to the loss that the body is not what mattered and they should not be so attached. It is meant kindly. The person it is said to stops talking for the rest of the afternoon.' AS s_en,
  'अंतिम संस्कार में कोई उस इंसान से, जिसका नुक़सान सबसे बड़ा है, कहता है कि शरीर वह नहीं था जो मायने रखता था और इतना मोह नहीं रखना चाहिए। इरादा भला है। जिससे यह कहा गया, वह बाक़ी पूरी दोपहर चुप हो जाता है।' AS s_hi,
  'Antim sanskar mein koi us insan se, jiska nuksaan sabse bada hai, kehta hai ki sharir woh nahi tha jo maayne rakhta tha aur itna moh nahi rakhna chahiye. Iraada bhala hai. Jisse yeh kaha gaya, woh baaki poori dopahar chup ho jaata hai.' AS s_hing,
  'This is the chapter used as an exit and it is why the explanations here are so careful. The verse defines two words. It does not hand anybody a sentence to say to a grieving person, and four verses later it puts awareness itself inside the field — which makes "you are not this" a much harder thing to say to somebody than it sounds.' AS c_en,
  'यह अध्याय का निकास की तरह इस्तेमाल है और इसीलिए यहाँ की व्याख्याएँ इतनी सावधान हैं। श्लोक दो शब्दों को परिभाषित करता है। वह किसी को शोक में डूबे इंसान से कहने के लिए कोई वाक्य नहीं देता, और चार श्लोक बाद वह चेतना को ही क्षेत्र के भीतर रख देता है — जिससे "तुम यह नहीं हो" किसी से कहना उतना आसान नहीं रह जाता जितना लगता है।' AS c_hi,
  'Yeh adhyay ka nikaas ki tarah istemaal hai aur isiliye yahan ki vyakhyayein itni savdhan hain. Shloka do shabdon ko paribhashit karta hai. Woh kisi ko shok mein doobe insan se kehne ke liye koi vakya nahi deta, aur chaar shloka baad woh chetna ko hi kshetra ke bheetar rakh deta hai — jisse "tum yeh nahi ho" kisi se kehna utna aasan nahi reh jaata jitna lagta hai.' AS c_hing,
  'The verse defines two words. It does not issue anybody a sentence to say at a funeral.' AS l_en,
  'श्लोक दो शब्द परिभाषित करता है। वह किसी को अंतिम संस्कार में कहने के लिए कोई वाक्य जारी नहीं करता।' AS l_hi,
  'Shloka do shabd paribhashit karta hai. Woh kisi ko antim sanskar mein kehne ke liye koi vakya jaari nahi karta.' AS l_hing,
  NULL AS src, 'intermediate' AS diff, 'grief,misuse,comfort,silence' AS tags

  UNION ALL SELECT 2, 'healthcare', 2,
  'The chart and the person in the bed', 'चार्ट और बिस्तर पर लेटा इंसान', 'Chart aur bistar par leta insan',
  'A trainee learns to present a case: the history, the observations, the numbers. Six months in, a consultant stops her mid-sentence and asks what the patient is worried about. She does not know, and realises she has been presenting a field with nobody in it.',
  'एक प्रशिक्षु केस पेश करना सीखती है: इतिहास, निरीक्षण, आँकड़े। छह महीने बाद एक कंसल्टेंट उसे बीच वाक्य में रोककर पूछता है कि मरीज़ को किस बात की चिंता है। उसे नहीं पता, और उसे लगता है कि वह ऐसा क्षेत्र पेश करती आई है जिसमें कोई है ही नहीं।',
  'Ek prashikshu case pesh karna seekhti hai: itihaas, nirikshan, aankde. Chhah mahine baad ek consultant use beech vakya mein rokkar poochhta hai ki mareez ko kis baat ki chinta hai. Use nahi pata, aur use lagta hai ki woh aisa kshetra pesh karti aayi hai jisme koi hai hi nahi.',
  'Both words in the verse are doing work and this is what it looks like when only one of them is being used. The field was described accurately and completely. The question the consultant asked is about the other term, and no amount of detail about the first one produces it.',
  'श्लोक के दोनों शब्द काम कर रहे हैं और जब सिर्फ़ एक इस्तेमाल हो तो वह ऐसा दिखता है। क्षेत्र का वर्णन सही और पूरा था। कंसल्टेंट ने जो सवाल पूछा वह दूसरे शब्द का है, और पहले के बारे में कितना भी ब्यौरा उसे पैदा नहीं करता।',
  'Shloka ke dono shabd kaam kar rahe hain aur jab sirf ek istemaal ho to woh aisa dikhta hai. Kshetra ka varnan sahi aur poora tha. Consultant ne jo sawal poochha woh doosre shabd ka hai, aur pehle ke baare mein kitna bhi byora use paida nahi karta.',
  'She had described the field completely and left the other term out of it.',
  'उसने क्षेत्र का पूरा वर्णन कर दिया था और दूसरा शब्द छोड़ दिया था।',
  'Usne kshetra ka poora varnan kar diya tha aur doosra shabd chhod diya tha.',
  NULL, 'intermediate', 'medicine,training,attention,persons'

  UNION ALL SELECT 2, 'corporate', 3,
  'The dashboard and the team', 'डैशबोर्ड और टीम', 'Dashboard aur team',
  'A department has excellent instrumentation — throughput, cycle time, defect rates, all accurate and all current. Two people resign in a month and neither departure shows up anywhere in it, before or after.',
  'एक विभाग के पास बेहतरीन माप हैं — थ्रूपुट, साइकिल टाइम, ख़राबी की दर, सब सही और सब ताज़ा। एक महीने में दो लोग इस्तीफ़ा देते हैं और उनमें से कोई भी जाना इसमें कहीं नहीं दिखता, न पहले न बाद में।',
  'Ek vibhag ke paas behtareen maap hain — throughput, cycle time, kharabi ki dar, sab sahi aur sab taaza. Ek mahine mein do log isteefa dete hain aur unme se koi bhi jaana isme kahin nahi dikhta, na pehle na baad mein.',
  'A field can be measured exhaustively and still be only the field. The chapter is not against measurement — 13.6 is itself a list — but it names a second term, and the second term is not a harder-to-get number. It is a different kind of thing entirely.',
  'किसी क्षेत्र को पूरी तरह नापा जा सकता है और वह फिर भी सिर्फ़ क्षेत्र ही रहेगा। अध्याय नापने के ख़िलाफ़ नहीं है — 13.6 ख़ुद एक सूची है — पर वह एक दूसरा शब्द रखता है, और वह दूसरा शब्द कोई ज़्यादा मुश्किल आँकड़ा नहीं है। वह बिलकुल किसी और तरह की चीज़ है।',
  'Kisi kshetra ko poori tarah naapa ja sakta hai aur woh phir bhi sirf kshetra hi rahega. Adhyay naapne ke khilaf nahi hai — 13.6 khud ek soochi hai — par woh ek doosra shabd rakhta hai, aur woh doosra shabd koi zyada mushkil aankda nahi hai. Woh bilkul kisi aur tarah ki cheez hai.',
  'The instrumentation was not wrong. It was measuring one of the two terms.',
  'माप ग़लत नहीं थी। वह दोनों शब्दों में से एक को नाप रही थी।',
  'Maap galat nahi thi. Woh dono shabdon mein se ek ko naap rahi thi.',
  NULL, 'intermediate', 'work,metrics,people,blind-spots'

  UNION ALL SELECT 2, 'sports', 4,
  'The pitch report and the batter', 'पिच रिपोर्ट और बल्लेबाज़', 'Pitch report aur ballebaaz',
  'A batter reads the pitch — the bounce, the grass, where it will turn on day four — and gets it exactly right. He is out in the fourth over playing a shot the pitch had nothing to do with, and afterwards says he had been thinking about the fourth over since breakfast.',
  'एक बल्लेबाज़ पिच पढ़ता है — उछाल, घास, चौथे दिन कहाँ टर्न लेगी — और बिलकुल सही पढ़ता है। वह चौथे ओवर में ऐसा शॉट खेलकर आउट हो जाता है जिसका पिच से कोई लेना-देना नहीं था, और बाद में कहता है कि वह नाश्ते से ही चौथे ओवर के बारे में सोच रहा था।',
  'Ek ballebaaz pitch padhta hai — uchhal, ghaas, chauthe din kahan turn legi — aur bilkul sahi padhta hai. Woh chauthe over mein aisa shot khelkar out ho jaata hai jiska pitch se koi lena dena nahi tha, aur baad mein kehta hai ki woh nashte se hi chauthe over ke baare mein soch raha tha.',
  'The field was read correctly. What was going on in the one reading it was not part of the report, and the verse names that as a separate term. Notice that the second term is not somewhere he could have escaped to — it is the thing that got him out.',
  'क्षेत्र सही पढ़ा गया था। जो उसे पढ़ रहा था उसके भीतर क्या चल रहा था, वह रिपोर्ट का हिस्सा नहीं था, और श्लोक उसे अलग शब्द का नाम देता है। ध्यान दीजिए कि दूसरा शब्द कोई ऐसी जगह नहीं है जहाँ वह भाग सकता था — वही उसे आउट करा गया।',
  'Kshetra sahi padha gaya tha. Jo use padh raha tha uske bheetar kya chal raha tha, woh report ka hissa nahi tha, aur shloka use alag shabd ka naam deta hai. Dhyan do ki doosra shabd koi aisi jagah nahi hai jahan woh bhaag sakta tha — wahi use out kara gaya.',
  'The second term is not somewhere to escape to. It is what got him out.',
  'दूसरा शब्द भागने की जगह नहीं है। वही उसे आउट करा गया।',
  'Doosra shabd bhaagne ki jagah nahi hai. Wahi use out kara gaya.',
  NULL, 'intermediate', 'sport,preparation,attention,self'

  UNION ALL SELECT 6, 'healthcare', 1,
  'Naming four things in the waiting room', 'इंतज़ार के कमरे में चार चीज़ें बताना', 'Intezaar ke kamre mein chaar cheezein batana',
  'Somebody waiting for a result they are frightened of writes down four things: I want this to be over, I do not want to go in, my hands are cold, I have read the same poster three times. They stay in the chair. Nothing about the fear changes.',
  'किसी ऐसे नतीजे का इंतज़ार करता कोई जिससे उसे डर लगता है, चार चीज़ें लिखता है: मैं चाहता हूँ यह ख़त्म हो जाए, मैं अंदर नहीं जाना चाहता, मेरे हाथ ठंडे हैं, मैंने वही पोस्टर तीन बार पढ़ा है। वह कुर्सी पर बैठा रहता है। डर में कुछ नहीं बदलता।',
  'Kisi aise nateeje ka intezaar karta koi jisse use dar lagta hai, chaar cheezein likhta hai: main chahta hoon yeh khatam ho jaaye, main andar nahi jaana chahta, mere haath thande hain, maine wahi poster teen baar padha hai. Woh kursi par baitha rehta hai. Dar mein kuch nahi badalta.',
  'Wanting, not wanting, the body, the noticing. Four items straight off the verse''s list, and he did not go anywhere to write them. That is the whole difference between this and the reading the chapter gets misused for: naming what is in the field is done from inside the field, because there is no other address.',
  'चाह, न चाहना, शरीर, ध्यान का जाना। सीधे श्लोक की सूची से चार चीज़ें, और उन्हें लिखने के लिए वह कहीं गया नहीं। इस पाठ और उस पाठ में यही पूरा फ़र्क़ है जिसके लिए अध्याय का दुरुपयोग होता है: क्षेत्र में क्या है यह नाम लेना क्षेत्र के भीतर से ही होता है, क्योंकि और कोई पता है ही नहीं।',
  'Chaah, na chahna, sharir, dhyan ka jaana. Seedhe shloka ki soochi se chaar cheezein, aur unhe likhne ke liye woh kahin gaya nahi. Is paath aur us paath mein yahi poora farq hai jiske liye adhyay ka durupyog hota hai: kshetra mein kya hai yeh naam lena kshetra ke bheetar se hi hota hai, kyunki aur koi pata hai hi nahi.',
  'He did not go anywhere to write them down. There is no other address.',
  'उन्हें लिखने के लिए वह कहीं गया नहीं। और कोई पता है ही नहीं।',
  'Unhe likhne ke liye woh kahin gaya nahi. Aur koi pata hai hi nahi.',
  NULL, 'beginner', 'fear,naming,waiting,presence'

  UNION ALL SELECT 6, 'everyday_life', 2,
  'The evening he could not describe', 'वह शाम जो वह बता नहीं सका', 'Woh shaam jo woh bata nahi saka',
  'Asked how his evening was, somebody says "fine". Asked instead what was in it, he says: wanted to be left alone, was not, enjoyed the food, back hurt. It takes eleven seconds and is the most accurate thing he has said all week.',
  'शाम कैसी रही, पूछने पर कोई कहता है "ठीक"। इसके बजाय पूछा जाए कि उसमें क्या था, तो वह कहता है: अकेला छोड़ा जाना चाहता था, छोड़ा नहीं गया, खाना अच्छा लगा, कमर दुखी। इसमें ग्यारह सेकंड लगते हैं और पूरे हफ़्ते में यह उसकी सबसे सही बात है।',
  'Shaam kaisi rahi, poochhne par koi kehta hai "theek". Iske bajaye poochha jaaye ki usme kya tha, to woh kehta hai: akela chhoda jaana chahta tha, chhoda nahi gaya, khana achha laga, kamar dukhi. Isme gyarah second lagte hain aur poore hafte mein yeh uski sabse sahi baat hai.',
  'The verse is a list and lists can be checked. "Fine" is a verdict about a whole evening and it is almost never true; four items are four observations and any of them can be wrong on its own without the others collapsing.',
  'श्लोक एक सूची है और सूचियाँ जाँची जा सकती हैं। "ठीक" पूरी शाम पर फ़ैसला है और वह लगभग कभी सच नहीं होता; चार चीज़ें चार बातें हैं और उनमें से कोई भी अकेले ग़लत हो सकती है बिना बाक़ी के गिरे।',
  'Shloka ek soochi hai aur soochiyan jaanchi ja sakti hain. "Theek" poori shaam par faisla hai aur woh lagbhag kabhi sach nahi hota; chaar cheezein chaar baatein hain aur unme se koi bhi akele galat ho sakti hai bina baaki ke gire.',
  '"Fine" is a verdict on a whole evening. Four items are four observations.',
  '"ठीक" पूरी शाम पर फ़ैसला है। चार चीज़ें चार बातें हैं।',
  '"Theek" poori shaam par faisla hai. Chaar cheezein chaar baatein hain.',
  NULL, 'beginner', 'description,evenings,honesty,specificity'

  UNION ALL SELECT 6, 'college', 3,
  'The meditation that made it worse', 'वह ध्यान जिससे और बिगड़ा', 'Woh dhyan jisse aur bigda',
  'A student going through a bad patch reads about watching your thoughts from a distance and tries it for two weeks. He feels further from everything, including the things he liked. He stops, and tells a friend, and the friend asks him what he actually wants this month.',
  'बुरे दौर से गुज़रता एक छात्र दूर से अपने विचारों को देखने के बारे में पढ़ता है और दो हफ़्ते आज़माता है। उसे हर चीज़ से और दूरी महसूस होती है, उन चीज़ों से भी जो उसे अच्छी लगती थीं। वह रुक जाता है, एक दोस्त को बताता है, और दोस्त पूछता है कि इस महीने वह असल में चाहता क्या है।',
  'Bure daur se guzarta ek student door se apne vichaaron ko dekhne ke baare mein padhta hai aur do hafte aazmata hai. Use har cheez se aur doori mehsoos hoti hai, un cheezon se bhi jo use achhi lagti thin. Woh ruk jaata hai, ek dost ko batata hai, aur dost poochhta hai ki is mahine woh asal mein chahta kya hai.',
  'This verse is why that did not work, and it is not his fault for trying. Awareness is on the list of things in the field, so there is no distance to watch from — the attempt to find one is what produced the flatness. The friend''s question goes to the first item on the same list, icchā, wanting, and it puts him back in the field rather than further out of it.',
  'यह श्लोक बताता है कि वह क्यों नहीं चला, और कोशिश करने में उसका दोष नहीं है। चेतना क्षेत्र की चीज़ों की सूची में है, तो देखने के लिए कोई दूरी है ही नहीं — उसे ढूँढ़ने की कोशिश ने ही वह सपाटपन पैदा किया। दोस्त का सवाल उसी सूची की पहली चीज़ पर जाता है, इच्छा, चाह, और वह उसे क्षेत्र से और बाहर नहीं, वापस उसके भीतर रख देता है।',
  'Yeh shloka batata hai ki woh kyun nahi chala, aur koshish karne mein uska dosh nahi hai. Chetna kshetra ki cheezon ki soochi mein hai, to dekhne ke liye koi doori hai hi nahi — use dhoondhne ki koshish ne hi woh sapaatpan paida kiya. Dost ka sawal usi soochi ki pehli cheez par jaata hai, ichchha, chaah, aur woh use kshetra se aur bahar nahi, wapas uske bheetar rakh deta hai.',
  'There was no distance to watch from. Looking for one is what produced the flatness.',
  'देखने के लिए कोई दूरी थी ही नहीं। उसे ढूँढ़ने से ही वह सपाटपन आया।',
  'Dekhne ke liye koi doori thi hi nahi. Use dhoondhne se hi woh sapaatpan aaya.',
  NULL, 'advanced', 'practice,distance,flatness,friends'

  UNION ALL SELECT 6, 'relationships', 4,
  'Two lists on a Sunday', 'रविवार को दो सूचियाँ', 'Sunday ko do soochiyan',
  'Two people stuck in the same argument for a month try something else: each writes four things that are true for them right now, with no because attached. Eight items in total. Six of them turn out to be about tiredness and one house move.',
  'महीने भर से उसी झगड़े में फँसे दो लोग कुछ और आज़माते हैं: दोनों चार-चार बातें लिखते हैं जो अभी उनके लिए सच हैं, और उनके साथ कोई "क्योंकि" नहीं जोड़ते। कुल आठ बातें। उनमें से छह थकान और एक घर बदलने के बारे में निकलती हैं।',
  'Mahine bhar se usi jhagde mein phanse do log kuch aur aazmate hain: dono chaar-chaar baatein likhte hain jo abhi unke liye sach hain, aur unke saath koi "kyunki" nahi jodte. Kul aath baatein. Unme se chhah thakan aur ek ghar badalne ke baare mein nikalti hain.',
  'The verse describes the field without explaining it — there is no "because" anywhere in the list. That turns out to be the useful constraint here, because a because is an argument and an item is not. Neither of them had to become detached from anything to do this.',
  'श्लोक क्षेत्र का वर्णन करता है, उसकी व्याख्या नहीं — सूची में कहीं कोई "क्योंकि" नहीं है। यहाँ यही काम की शर्त निकलती है, क्योंकि "क्योंकि" एक दलील है और एक चीज़ दलील नहीं होती। इसे करने के लिए दोनों में से किसी को किसी चीज़ से अलग नहीं होना पड़ा।',
  'Shloka kshetra ka varnan karta hai, uski vyakhya nahi — soochi mein kahin koi "kyunki" nahi hai. Yahan yahi kaam ki shart nikalti hai, kyunki "kyunki" ek dalil hai aur ek cheez dalil nahi hoti. Ise karne ke liye dono mein se kisi ko kisi cheez se alag nahi hona pada.',
  'A because is an argument. An item is not. The list has no becauses in it.',
  '"क्योंकि" दलील है। एक चीज़ दलील नहीं। सूची में कोई "क्योंकि" नहीं है।',
  '"Kyunki" dalil hai. Ek cheez dalil nahi. Soochi mein koi "kyunki" nahi hai.',
  NULL, 'intermediate', 'couples,arguments,description,tiredness'

  UNION ALL SELECT 8, 'corporate', 1,
  'The person everybody checks with', 'जिससे सब पूछ लेते हैं', 'Jisse sab poochh lete hain',
  'In a large team one person is quietly the one everybody runs things past. She is not the most senior and not the most technically able. She does not oversell, does not take credit she did not earn, does not go cold when contradicted, and can wait.',
  'एक बड़ी टीम में चुपचाप एक इंसान वह है जिससे सब अपनी बात जाँच लेते हैं। वह न सबसे वरिष्ठ है और न तकनीकी रूप से सबसे काबिल। वह बढ़ा-चढ़ाकर नहीं बोलती, वह श्रेय नहीं लेती जो कमाया नहीं, विरोध होने पर ठंडी नहीं पड़ती, और इंतज़ार कर सकती है।',
  'Ek badi team mein chupchap ek insan woh hai jisse sab apni baat jaanch lete hain. Woh na sabse varishth hai aur na takneeki roop se sabse kaabil. Woh badha-chadhakar nahi bolti, woh shrey nahi leti jo kamaya nahi, virodh hone par thandi nahi padti, aur intezaar kar sakti hai.',
  'Four items off the 13.8 list, described without anybody using the word knowledge. That is what makes the verse strange and useful: asked what jñāna is, the chapter gives conduct, and this is what conduct looks like when it has accumulated for a few years.',
  '13.8 की सूची से चार चीज़ें, और वर्णन में किसी ने ज्ञान शब्द इस्तेमाल नहीं किया। यही इस श्लोक को अजीब और काम का बनाता है: ज्ञान क्या है, यह पूछे जाने पर अध्याय बरताव देता है, और कुछ साल जमा होने के बाद बरताव ऐसा दिखता है।',
  '13.8 ki soochi se chaar cheezein, aur varnan mein kisi ne gyan shabd istemaal nahi kiya. Yahi is shloka ko ajeeb aur kaam ka banata hai: gyan kya hai, yeh poochhe jaane par adhyay bartav deta hai, aur kuch saal jama hone ke baad bartav aisa dikhta hai.',
  'Nobody in the office would call it knowledge. The chapter would.',
  'दफ़्तर में कोई इसे ज्ञान नहीं कहेगा। अध्याय कहेगा।',
  'Daftar mein koi ise gyan nahi kahega. Adhyay kahega.',
  NULL, 'beginner', 'work,trust,conduct,quiet'

  UNION ALL SELECT 8, 'ethics', 2,
  'He did not mention it once', 'उसने एक बार भी इसका ज़िक्र नहीं किया', 'Usne ek baar bhi iska zikr nahi kiya',
  'Somebody spots a serious error before a decision goes out, gets it fixed, and never brings it up again — not in the review, not in the appraisal, not in the pub. Two years later a colleague finds out by accident.',
  'कोई किसी फ़ैसले के बाहर जाने से पहले एक गंभीर ग़लती पकड़ता है, उसे ठीक करवाता है, और उसका दोबारा कभी ज़िक्र नहीं करता — न समीक्षा में, न मूल्यांकन में, न बैठकर बातचीत में। दो साल बाद एक साथी को यह इत्तेफ़ाक़ से पता चलता है।',
  'Koi kisi faisle ke bahar jaane se pehle ek gambhir galti pakadta hai, use theek karvata hai, aur uska dobara kabhi zikr nahi karta — na sameeksha mein, na mulyankan mein, na baithkar baatcheet mein. Do saal baad ek saathi ko yeh ittefaq se pata chalta hai.',
  'Amānitva and adambhitva — not making much of yourself, not putting on a show — are the first two items on the list, in that order. The chapter puts them ahead of everything metaphysical it goes on to say, which is a claim about priority rather than an accident of arrangement.',
  'अमानित्व और अदम्भित्व — अपने को बड़ा न बनाना, दिखावा न करना — सूची की पहली दो चीज़ें हैं, इसी क्रम में। अध्याय इन्हें उन सब आध्यात्मिक बातों से आगे रखता है जो वह आगे कहता है, और यह क्रम का इत्तेफ़ाक़ नहीं, प्राथमिकता का दावा है।',
  'Amanitva aur adambhitva — apne ko bada na banana, dikhava na karna — soochi ki pehli do cheezein hain, isi kram mein. Adhyay inhe un sab aadhyatmik baaton se aage rakhta hai jo woh aage kehta hai, aur yeh kram ka ittefaq nahi, prathmikta ka dawa hai.',
  'The first two items come before anything metaphysical in the chapter. That is the claim.',
  'पहली दो चीज़ें अध्याय की हर आध्यात्मिक बात से पहले आती हैं। दावा यही है।',
  'Pehli do cheezein adhyay ki har aadhyatmik baat se pehle aati hain. Dawa yahi hai.',
  NULL, 'intermediate', 'ethics,credit,quiet,priority'

  UNION ALL SELECT 8, 'school', 3,
  'The teacher who said she did not know', 'वह शिक्षिका जिसने कहा उसे नहीं पता', 'Woh shikshika jisne kaha use nahi pata',
  'A student asks a question in class that the teacher cannot answer. She says so, plainly, in front of everybody, and says she will find out. Three students ask better questions the following week than they have asked all year.',
  'एक छात्र क्लास में ऐसा सवाल पूछता है जिसका जवाब शिक्षिका के पास नहीं है। वह साफ़-साफ़, सबके सामने, यह कह देती है और कहती है कि वह पता करेगी। अगले हफ़्ते तीन छात्र उससे बेहतर सवाल पूछते हैं जितने उन्होंने पूरे साल पूछे थे।',
  'Ek student class mein aisa sawal poochhta hai jiska jawab shikshika ke paas nahi hai. Woh saaf saaf, sabke saamne, yeh keh deti hai aur kehti hai ki woh pata karegi. Agle hafte teen student usse behtar sawal poochhte hain jitne unhone poore saal poochhe the.',
  'Ārjava is straightness — being the same shape all the way through. It is fifth on the list and it costs something here, in front of a room. What the following week shows is that it is not only a virtue; it changes what other people are willing to try.',
  'आर्जव यानी सीधापन — भीतर तक एक ही आकार का होना। यह सूची में पाँचवें नंबर पर है और यहाँ, पूरे कमरे के सामने, इसकी क़ीमत लगती है। अगला हफ़्ता जो दिखाता है वह यह कि यह सिर्फ़ कोई सद्गुण नहीं है; इससे यह बदल जाता है कि बाक़ी लोग क्या आज़माने को तैयार होते हैं।',
  'Aarjav yani seedhapan — bheetar tak ek hi aakar ka hona. Yeh soochi mein paanchve number par hai aur yahan, poore kamre ke saamne, iski keemat lagti hai. Agla hafta jo dikhata hai woh yeh ki yeh sirf koi sadgun nahi hai; isse yeh badal jaata hai ki baaki log kya aazmane ko taiyar hote hain.',
  'It cost her something in front of a room. It changed what the room was willing to try.',
  'पूरे कमरे के सामने इसकी उसे क़ीमत लगी। इससे बदल गया कि कमरा क्या आज़माने को तैयार था।',
  'Poore kamre ke saamne iski use keemat lagi. Isse badal gaya ki kamra kya aazmane ko taiyar tha.',
  NULL, 'beginner', 'teaching,honesty,not-knowing,straightness'

  UNION ALL SELECT 8, 'everyday_life', 4,
  'The queue and the man on the phone', 'क़तार और फ़ोन पर बात करता आदमी', 'Kataar aur phone par baat karta aadmi',
  'Somebody in a slow queue behind a man having a difficult phone call waits eleven minutes without sighing, checking the time visibly, or saying anything. He does not think of it as anything. The man on the phone thanks him afterwards, which surprises him.',
  'धीमी क़तार में मुश्किल फ़ोन कॉल पर लगे एक आदमी के पीछे खड़ा कोई ग्यारह मिनट इंतज़ार करता है — न आह भरता है, न दिखाकर घड़ी देखता है, न कुछ कहता है। वह इसे कुछ समझता ही नहीं। बाद में फ़ोन वाला आदमी उसका शुक्रिया करता है, जिससे वह चौंक जाता है।',
  'Dheemi kataar mein mushkil phone call par lage ek aadmi ke peechhe khada koi gyarah minute intezaar karta hai — na aah bharta hai, na dikhakar ghadi dekhta hai, na kuch kehta hai. Woh ise kuch samajhta hi nahi. Baad mein phone wala aadmi uska shukriya karta hai, jisse woh chaunk jaata hai.',
  'Kṣānti is on the list and it is usually translated as patience, which undersells it — it is closer to being able to bear something without making it anybody else''s problem. Eleven minutes in a queue is not spiritual attainment and the chapter would still count it.',
  'क्षान्ति सूची में है और आमतौर पर उसका अनुवाद धैर्य होता है, जो उसे कम कर देता है — वह किसी चीज़ को इस तरह सह लेने के ज़्यादा पास है कि वह किसी और की मुसीबत न बने। क़तार में ग्यारह मिनट कोई आध्यात्मिक उपलब्धि नहीं है और अध्याय फिर भी उसे गिनेगा।',
  'Kshanti soochi mein hai aur aam taur par uska anuvaad dhairya hota hai, jo use kam kar deta hai — woh kisi cheez ko is tarah seh lene ke zyada paas hai ki woh kisi aur ki musibat na bane. Kataar mein gyarah minute koi aadhyatmik uplabdhi nahi hai aur adhyay phir bhi use ginega.',
  'Eleven minutes in a queue is not attainment. The chapter counts it anyway.',
  'क़तार में ग्यारह मिनट कोई उपलब्धि नहीं है। अध्याय उसे फिर भी गिनता है।',
  'Kataar mein gyarah minute koi uplabdhi nahi hai. Adhyay use phir bhi ginta hai.',
  NULL, 'beginner', 'patience,queues,small-things,conduct'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 13;

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

  SELECT 20 AS vn, 'healthcare' AS cat, 1 AS ord,
  'The diagnosis nobody caused' AS t_en, 'वह निदान जो किसी ने पैदा नहीं किया' AS t_hi, 'Woh nidan jo kisi ne paida nahi kiya' AS t_hing,
  'Somebody receives a diagnosis with no lifestyle cause and no family history. Within a fortnight they have constructed three theories about what they did to bring it on. All three are wrong and none of them stops.' AS s_en,
  'किसी को ऐसा निदान मिलता है जिसकी न कोई जीवनशैली वजह है और न परिवार में कोई इतिहास। पखवाड़े भर में वह तीन सिद्धांत गढ़ चुका है कि उसने क्या किया जिससे यह हुआ। तीनों ग़लत हैं और उनमें से कोई रुकता नहीं।' AS s_hi,
  'Kisi ko aisa nidan milta hai jiski na koi jeevanshaili wajah hai aur na parivar mein koi itihaas. Pakhwade bhar mein woh teen siddhant gadh chuka hai ki usne kya kiya jisse yeh hua. Teenon galat hain aur unme se koi rukta nahi.' AS s_hing,
  'The verse splits this cleanly and the split is a relief rather than a demotion. The doing belongs to prakṛti — nobody arranged this. The undergoing does not get handed over, and that half matters: something is happening to a person, and the verse says so instead of dissolving it. He is not the author. He is still the one it is happening to.' AS c_en,
  'श्लोक इसे साफ़ बाँट देता है और यह बँटवारा किसी को छोटा करना नहीं, राहत है। करना प्रकृति का है — यह किसी ने नहीं जुटाया। गुज़रना सौंपा नहीं जाता, और यह आधा मायने रखता है: किसी इंसान के साथ कुछ हो रहा है, और श्लोक उसे घोलने के बजाय यह कहता है। वह कर्ता नहीं है। जिसके साथ यह हो रहा है, वह फिर भी वही है।' AS c_hi,
  'Shloka ise saaf baant deta hai aur yeh bantwara kisi ko chhota karna nahi, raahat hai. Karna prakriti ka hai — yeh kisi ne nahi jutaya. Guzarna saunpa nahi jaata, aur yeh aadha maayne rakhta hai: kisi insan ke saath kuch ho raha hai, aur shloka use gholne ke bajaye yeh kehta hai. Woh karta nahi hai. Jiske saath yeh ho raha hai, woh phir bhi wahi hai.' AS c_hing,
  'He is not the author of it. He is still the one it is happening to.' AS l_en,
  'वह इसका कर्ता नहीं है। जिसके साथ यह हो रहा है, वह फिर भी वही है।' AS l_hi,
  'Woh iska karta nahi hai. Jiske saath yeh ho raha hai, woh phir bhi wahi hai.' AS l_hing,
  NULL AS src, 'intermediate' AS diff, 'illness,blame,causes,undergoing' AS tags

  UNION ALL SELECT 20, 'corporate', 2,
  'The redundancy and the theories', 'छँटनी और सिद्धांत', 'Chhantni aur siddhant',
  'A whole department is closed for reasons decided two levels above and eighteen months earlier. Every single person in it constructs an account of what they personally did wrong, and four of them can name the meeting they think did it.',
  'एक पूरा विभाग उन वजहों से बंद कर दिया जाता है जो दो स्तर ऊपर और अठारह महीने पहले तय हुई थीं। उसमें हर एक इंसान यह ब्यौरा गढ़ता है कि उसने ख़ुद क्या ग़लत किया, और उनमें से चार वह मीटिंग तक बता सकते हैं जिसे वे इसकी वजह मानते हैं।',
  'Ek poora vibhag un wajahon se band kar diya jaata hai jo do star upar aur atharah mahine pehle tay hui thin. Usme har ek insan yeh byora gadhta hai ki usne khud kya galat kiya, aur unme se chaar woh meeting tak bata sakte hain jise woh iski wajah maante hain.',
  'The verse assigns doing to the material, and the material here is a decision they were not in the room for. But it does not then say nothing happened to anybody — the redundancy is real and being gone through, by all of them. Losing the authorship does not cost them the experience.',
  'श्लोक करना सामग्री को सौंपता है, और यहाँ सामग्री वह फ़ैसला है जिसके कमरे में वे थे ही नहीं। पर वह यह नहीं कहता कि इसके बाद किसी के साथ कुछ हुआ ही नहीं — छँटनी असली है और सब उससे गुज़र रहे हैं। कर्तापन जाने से उनका अनुभव नहीं जाता।',
  'Shloka karna samagri ko saunpta hai, aur yahan samagri woh faisla hai jiske kamre mein woh the hi nahi. Par woh yeh nahi kehta ki iske baad kisi ke saath kuch hua hi nahi — chhantni asli hai aur sab usse guzar rahe hain. Kartapan jaane se unka anubhav nahi jaata.',
  'Losing the authorship does not cost them the experience.',
  'कर्तापन जाने से उनका अनुभव नहीं जाता।',
  'Kartapan jaane se unka anubhav nahi jaata.',
  NULL, 'intermediate', 'work,redundancy,blame,causes'

  UNION ALL SELECT 20, 'parenting', 3,
  'The thing the child was always going to be', 'वह चीज़ जो बच्चा हमेशा होने वाला था', 'Woh cheez jo bachcha hamesha hone wala tha',
  'A parent of two notices that the same house, the same rules and roughly the same amount of attention have produced two completely different people. She had spent nine years believing she was building them.',
  'दो बच्चों की एक माँ देखती है कि एक ही घर, एक ही नियम और लगभग एक जितना ध्यान — इनसे दो बिलकुल अलग इंसान बने हैं। नौ साल वह यह मानती रही थी कि वह उन्हें बना रही है।',
  'Do bachchon ki ek maa dekhti hai ki ek hi ghar, ek hi niyam aur lagbhag ek jitna dhyan — inse do bilkul alag insan bane hain. Nau saal woh yeh maanti rahi thi ki woh unhe bana rahi hai.',
  'Prakṛti is the cause in the matter of doing, and that turns out to include a good deal she thought was hers. What the verse does not do is dissolve her — she is still the one who was there for nine years, and the second half of the verse is where that lives. Not being the author of somebody is different from not mattering to them.',
  'करने के मामले में कारण प्रकृति है, और उसमें वह बहुत कुछ आ जाता है जिसे वह अपना समझती थी। श्लोक जो नहीं करता वह है उसे घोल देना — वह अब भी वही है जो नौ साल वहाँ मौजूद थी, और श्लोक का दूसरा आधा यही रखता है। किसी का कर्ता न होना उसके लिए मायने न रखने से अलग बात है।',
  'Karne ke mamle mein kaaran prakriti hai, aur usme woh bahut kuch aa jaata hai jise woh apna samajhti thi. Shloka jo nahi karta woh hai use ghol dena — woh ab bhi wahi hai jo nau saal wahan maujood thi, aur shloka ka doosra aadha yahi rakhta hai. Kisi ka karta na hona uske liye maayne na rakhne se alag baat hai.',
  'Not being the author of somebody is different from not mattering to them.',
  'किसी का कर्ता न होना उसके लिए मायने न रखने से अलग बात है।',
  'Kisi ka karta na hona uske liye maayne na rakhne se alag baat hai.',
  NULL, 'intermediate', 'parenting,influence,siblings,authorship'

  UNION ALL SELECT 20, 'everyday_life', 4,
  'Two columns on the back of an envelope', 'लिफ़ाफ़े के पीछे दो कॉलम', 'Lifafe ke peechhe do column',
  'Somebody whose week went badly writes two columns: what I did, and what happened to me. The first column has four items in it. The second has eleven. He had been treating all fifteen as the first kind.',
  'जिसका हफ़्ता बुरा गया, वह दो कॉलम लिखता है: मैंने क्या किया, और मेरे साथ क्या हुआ। पहले कॉलम में चार चीज़ें हैं। दूसरे में ग्यारह। वह पंद्रहों को पहली वाली तरह मानता आ रहा था।',
  'Jiska hafta bura gaya, woh do column likhta hai: maine kya kiya, aur mere saath kya hua. Pehle column mein chaar cheezein hain. Doosre mein gyarah. Woh pandrahon ko pehli wali tarah maanta aa raha tha.',
  'The verse is a division of labour and this is it done with a pen. Neither column is empty and that is the point — a text that emptied the first would remove responsibility, and a text that emptied the second would remove the person. This one keeps both and just insists they are not the same column.',
  'श्लोक काम का बँटवारा है और यह वही, क़लम से किया हुआ। कोई कॉलम ख़ाली नहीं है और बात यही है — जो ग्रंथ पहला ख़ाली कर देता वह ज़िम्मेदारी हटा देता, और जो दूसरा ख़ाली करता वह इंसान को हटा देता। यह दोनों रखता है और बस इतना कहता है कि वे एक कॉलम नहीं हैं।',
  'Shloka kaam ka bantwara hai aur yeh wahi, kalam se kiya hua. Koi column khaali nahi hai aur baat yahi hai — jo granth pehla khaali kar deta woh zimmedari hata deta, aur jo doosra khaali karta woh insan ko hata deta. Yeh dono rakhta hai aur bas itna kehta hai ki woh ek column nahi hain.',
  'Empty the first column and responsibility goes. Empty the second and the person goes.',
  'पहला कॉलम ख़ाली कीजिए तो ज़िम्मेदारी जाती है। दूसरा ख़ाली कीजिए तो इंसान जाता है।',
  'Pehla column khaali karo to zimmedari jaati hai. Doosra khaali karo to insan jaata hai.',
  NULL, 'beginner', 'weeks,responsibility,sorting,honesty'

  UNION ALL SELECT 27, 'healthcare', 1,
  'The bed nobody wanted', 'वह बिस्तर जो किसी को नहीं चाहिए था', 'Woh bistar jo kisi ko nahi chahiye tha',
  'A ward has one patient everybody finds difficult — rude, demanding, ungrateful. One member of staff treats him exactly as she treats the others. Asked how, she says she has not worked out anything; she just cannot find the switch that would let her do otherwise.',
  'एक वार्ड में एक मरीज़ है जिसे सब मुश्किल पाते हैं — रूखा, माँग करने वाला, कृतघ्न। स्टाफ़ की एक सदस्य उसके साथ ठीक वैसा ही बरताव करती है जैसा बाक़ी सबके साथ। पूछने पर वह कहती है कि उसने कुछ सोचा-समझा नहीं है; उसे बस वह स्विच नहीं मिलता जिससे वह इसके अलावा कुछ और कर सके।',
  'Ek ward mein ek mareez hai jise sab mushkil paate hain — rookha, maang karne wala, kritaghn. Staff ki ek sadasya uske saath theek waisa hi bartav karti hai jaisa baaki sabke saath. Poochhne par woh kehti hai ki usne kuch socha-samjha nahi hai; use bas woh switch nahi milta jisse woh iske alawa kuch aur kar sake.',
  'Yaḥ paśyati sa paśyati — whoever sees, that one sees. The verse does not describe an effort or a policy, and neither does she. What is striking is the absence: there is no switch, no decision, no daily recommitment. Something is just being seen the same way in all of them.',
  'यः पश्यति स पश्यति — जो देखता है, वही देखता है। श्लोक न किसी मेहनत का वर्णन करता है न किसी नीति का, और वह भी नहीं करती। ख़ास बात यह ग़ैरहाज़िरी है: कोई स्विच नहीं, कोई फ़ैसला नहीं, रोज़ का कोई नया संकल्प नहीं। बस सबमें एक ही चीज़ एक तरह से दिख रही है।',
  'Yah pashyati sa pashyati — jo dekhta hai, wahi dekhta hai. Shloka na kisi mehnat ka varnan karta hai na kisi neeti ka, aur woh bhi nahi karti. Khaas baat yeh gairhazri hai: koi switch nahi, koi faisla nahi, roz ka koi naya sankalp nahi. Bas sabme ek hi cheez ek tarah se dikh rahi hai.',
  'No switch, no policy, no daily recommitment. She just cannot find the other setting.',
  'कोई स्विच नहीं, कोई नीति नहीं, रोज़ का कोई संकल्प नहीं। उसे बस दूसरी सेटिंग मिलती ही नहीं।',
  'Koi switch nahi, koi neeti nahi, roz ka koi sankalp nahi. Use bas doosri setting milti hi nahi.',
  NULL, 'intermediate', 'medicine,difficult-patients,evenness,effortless'

  UNION ALL SELECT 27, 'everyday_life', 2,
  'The name he learned in year seven', 'वह नाम जो उसने सातवें साल सीखा', 'Woh naam jo usne saatve saal seekha',
  'Somebody realises after six years in a building that he has never known the name of the person who empties the bins on his floor. He asks. It takes four seconds. He is embarrassed for about a week and then it is simply normal.',
  'किसी को छह साल एक इमारत में रहने के बाद एहसास होता है कि उसने कभी उस इंसान का नाम नहीं जाना जो उसकी मंज़िल का कूड़ा उठाता है। वह पूछ लेता है। चार सेकंड लगते हैं। हफ़्ते भर उसे शर्मिंदगी रहती है और फिर यह बस आम बात हो जाती है।',
  'Kisi ko chhah saal ek imaarat mein rehne ke baad ehsaas hota hai ki usne kabhi us insan ka naam nahi jaana jo uski manzil ka kooda uthata hai. Woh poochh leta hai. Chaar second lagte hain. Hafte bhar use sharmindagi rehti hai aur phir yeh bas aam baat ho jaati hai.',
  'This verse and 5.18 are making the same claim and this is what it looks like at the smallest possible size. Note the ordinary shape of it: he did not arrive at a philosophical position. He asked a question, was embarrassed, and then it stopped being anything.',
  'यह श्लोक और 5.18 वही दावा कर रहे हैं और सबसे छोटे नाप पर वह ऐसा दिखता है। इसकी आम बनावट देखिए: वह किसी दार्शनिक नतीजे तक नहीं पहुँचा। उसने एक सवाल पूछा, शर्मिंदा हुआ, और फिर वह कुछ रहा ही नहीं।',
  'Yeh shloka aur 5.18 wahi dawa kar rahe hain aur sabse chhote naap par woh aisa dikhta hai. Iski aam banawat dekho: woh kisi darshanik nateeje tak nahi pahuncha. Usne ek sawal poochha, sharminda hua, aur phir woh kuch raha hi nahi.',
  'He did not arrive at a position. He asked, was embarrassed, and it became normal.',
  'वह किसी नतीजे तक नहीं पहुँचा। उसने पूछा, शर्मिंदा हुआ, और यह आम बात हो गई।',
  'Woh kisi nateeje tak nahi pahuncha. Usne poochha, sharminda hua, aur yeh aam baat ho gayi.',
  NULL, 'beginner', 'names,noticing,ordinary,5-18'

  UNION ALL SELECT 27, 'corporate', 3,
  'The interview panel that changed one thing', 'वह पैनल जिसने एक चीज़ बदली', 'Woh panel jisne ek cheez badli',
  'A hiring panel keeps producing the same kind of candidate. They change nothing about the questions and one thing about the process: names and universities are removed from what the panel sees first. The next round looks different and nobody on the panel had thought they were doing anything.',
  'एक भर्ती पैनल बार-बार एक ही तरह के उम्मीदवार निकालता है। वे सवालों में कुछ नहीं बदलते और प्रक्रिया में एक चीज़: पैनल जो पहले देखता है उसमें से नाम और विश्वविद्यालय हटा दिए जाते हैं। अगला दौर अलग दिखता है और पैनल के किसी को नहीं लगता था कि वे कुछ कर रहे थे।',
  'Ek bharti panel baar baar ek hi tarah ke ummeedwar nikalta hai. Woh sawalon mein kuch nahi badalte aur prakriya mein ek cheez: panel jo pehle dekhta hai usme se naam aur vishwavidyalay hata diye jaate hain. Agla daur alag dikhta hai aur panel ke kisi ko nahi lagta tha ki woh kuch kar rahe the.',
  'The verse claims that seeing evenly is rare and does not claim it is easy. Nobody on this panel was hostile to anybody, and the sorting was happening below the level where any of them would have caught it. That is why the fix was to the process rather than to anybody''s intentions.',
  'श्लोक दावा करता है कि समान देखना दुर्लभ है, यह नहीं कि आसान है। इस पैनल में कोई किसी के ख़िलाफ़ नहीं था, और छँटाई उस स्तर से नीचे हो रही थी जहाँ उनमें से कोई उसे पकड़ पाता। इसीलिए सुधार किसी की नीयत में नहीं, प्रक्रिया में किया गया।',
  'Shloka dawa karta hai ki saman dekhna durlabh hai, yeh nahi ki aasan hai. Is panel mein koi kisi ke khilaf nahi tha, aur chhantai us star se neeche ho rahi thi jahan unme se koi use pakad pata. Isiliye sudhar kisi ki niyat mein nahi, prakriya mein kiya gaya.',
  'The sorting was happening below the level anybody would have caught it. So they changed the process.',
  'छँटाई उस स्तर से नीचे हो रही थी जहाँ कोई उसे पकड़ पाता। तो उन्होंने प्रक्रिया बदली।',
  'Chhantai us star se neeche ho rahi thi jahan koi use pakad pata. To unhone prakriya badli.',
  NULL, 'intermediate', 'hiring,bias,process,evenness'

  UNION ALL SELECT 27, 'friendship', 4,
  'The friend who is the same on both days', 'वह दोस्त जो दोनों दिन एक जैसा है', 'Woh dost jo dono din ek jaisa hai',
  'Somebody notices that one of his friends behaves identically towards him whether he has just had a good year or a bad one. He also notices that he cannot say the same about himself towards anybody.',
  'किसी को लगता है कि उसका एक दोस्त उसके साथ बिलकुल एक जैसा बरताव करता है, चाहे उसका साल अच्छा गया हो या बुरा। उसे यह भी लगता है कि वह अपने बारे में यही बात किसी के लिए नहीं कह सकता।',
  'Kisi ko lagta hai ki uska ek dost uske saath bilkul ek jaisa bartav karta hai, chahe uska saal achha gaya ho ya bura. Use yeh bhi lagta hai ki woh apne baare mein yahi baat kisi ke liye nahi keh sakta.',
  'The verse says the same thing stands in all of them, undying among the dying. Fortunes are among the things that die, and treating somebody the same across both is the most checkable version of this claim available. The second half of the story is why the verse says "that one sees" and does not say most people do.',
  'श्लोक कहता है कि वही चीज़ सबमें खड़ी है, मिटते हुओं के बीच बिना मिटे। किस्मत उन चीज़ों में है जो मिटती हैं, और दोनों हालतों में किसी के साथ एक जैसा बरतना इस दावे का सबसे जाँचने लायक़ रूप है। कहानी का दूसरा आधा बताता है कि श्लोक "वही देखता है" क्यों कहता है और यह क्यों नहीं कहता कि ज़्यादातर लोग देखते हैं।',
  'Shloka kehta hai ki wahi cheez sabme khadi hai, mitte huon ke beech bina mite. Kismat un cheezon mein hai jo mitti hain, aur dono haalaton mein kisi ke saath ek jaisa bartna is dawe ka sabse jaanchne layak roop hai. Kahani ka doosra aadha batata hai ki shloka "wahi dekhta hai" kyun kehta hai aur yeh kyun nahi kehta ki zyadatar log dekhte hain.',
  'Fortunes are among the things that die. He is the same across both.',
  'किस्मत उन चीज़ों में है जो मिटती हैं। वह दोनों में एक जैसा है।',
  'Kismat un cheezon mein hai jo mitti hain. Woh dono mein ek jaisa hai.',
  NULL, 'beginner', 'friendship,constancy,fortune,evenness'

  UNION ALL SELECT 29, 'everyday_life', 1,
  'The sentence he would not say to a friend', 'वह वाक्य जो वह किसी दोस्त से नहीं कहेगा', 'Woh vakya jo woh kisi dost se nahi kahega',
  'Somebody catches himself saying "you are useless" in his own head after a small mistake. He tries the test: would he say that to a friend who had made it? He would not say it to somebody he disliked. He does not fix anything. He just notices the gap.',
  'किसी को एक छोटी ग़लती के बाद अपने भीतर "तुम किसी काम के नहीं हो" कहते हुए पकड़ में आता है। वह कसौटी आज़माता है: क्या वह यही उस दोस्त से कहेगा जिसने वह ग़लती की हो? वह इसे उससे भी नहीं कहेगा जो उसे पसंद नहीं। वह कुछ ठीक नहीं करता। वह बस फ़ासला देख लेता है।',
  'Kisi ko ek chhoti galti ke baad apne bheetar "tum kisi kaam ke nahi ho" kehte hue pakad mein aata hai. Woh kasauti aazmata hai: kya woh yahi us dost se kahega jisne woh galti ki ho? Woh ise usse bhi nahi kahega jo use pasand nahi. Woh kuch theek nahi karta. Woh bas faasla dekh leta hai.',
  'Na hinasty ātmanā ātmānam — he does not injure the self by the self. This is the whole verse, in ordinary language, on an ordinary Tuesday. Note what the chapter is claiming: that seeing the same thing everywhere is what makes this stop, which means it applies inwards as well as outwards.',
  'न हिनस्त्यात्मनात्मानम् — वह ख़ुद अपने से अपना नुक़सान नहीं करता। यही पूरा श्लोक है, आम भाषा में, एक आम मंगलवार को। ध्यान दीजिए अध्याय क्या दावा कर रहा है: हर जगह वही चीज़ देखना ही इसे रोकता है, यानी यह जितना बाहर की तरफ़ लागू है उतना भीतर की तरफ़ भी।',
  'Na hinasty atmana atmanam — woh khud apne se apna nuksaan nahi karta. Yahi poora shloka hai, aam bhasha mein, ek aam Tuesday ko. Dhyan do adhyay kya dawa kar raha hai: har jagah wahi cheez dekhna hi ise rokta hai, yani yeh jitna bahar ki taraf laagu hai utna bheetar ki taraf bhi.',
  'He would not say it to somebody he disliked. He says it to himself.',
  'वह यह उससे भी नहीं कहेगा जो उसे पसंद नहीं। वह यह ख़ुद से कहता है।',
  'Woh yeh usse bhi nahi kahega jo use pasand nahi. Woh yeh khud se kehta hai.',
  NULL, 'beginner', 'self-talk,mistakes,test,noticing'

  UNION ALL SELECT 29, 'sports', 2,
  'What he said in the changing room and what he said in the car', 'चेंजिंग रूम में क्या कहा और गाड़ी में क्या', 'Changing room mein kya kaha aur gaadi mein kya',
  'A player who missed the decisive chance is generous to the teammate who also missed one — genuinely, and everyone hears it. On the drive home he says things to himself that nobody would tolerate being said to a nineteen-year-old.',
  'निर्णायक मौक़ा चूकने वाला एक खिलाड़ी उस साथी के साथ उदार है जिससे भी एक मौक़ा चूका — सचमुच, और सब सुनते हैं। घर लौटते हुए गाड़ी में वह अपने आप से ऐसी बातें कहता है जिन्हें किसी उन्नीस साल के लड़के से कहा जाए तो कोई बर्दाश्त न करे।',
  'Nirnayak mauka chookne wala ek khilaadi us saathi ke saath udaar hai jisse bhi ek mauka chooka — sach mein, aur sab sunte hain. Ghar lautte hue gaadi mein woh apne aap se aisi baatein kehta hai jinhe kisi unnees saal ke ladke se kaha jaaye to koi bardasht na kare.',
  'The verse says he sees it evenly everywhere and therefore does not injure himself. Here the seeing stops at the changing room door. Both halves of the verse are about the same faculty, and this story shows what it looks like when it is running in one direction only.',
  'श्लोक कहता है कि वह उसे हर जगह एक-सा देखता है और इसीलिए अपना नुक़सान नहीं करता। यहाँ देखना चेंजिंग रूम के दरवाज़े पर रुक जाता है। श्लोक के दोनों आधे एक ही क्षमता के बारे में हैं, और यह कहानी दिखाती है कि जब वह सिर्फ़ एक दिशा में चल रही हो तो वह कैसा दिखता है।',
  'Shloka kehta hai ki woh use har jagah ek-sa dekhta hai aur isiliye apna nuksaan nahi karta. Yahan dekhna changing room ke darwaze par ruk jaata hai. Shloka ke dono aadhe ek hi kshamta ke baare mein hain, aur yeh kahani dikhati hai ki jab woh sirf ek disha mein chal rahi ho to woh kaisa dikhta hai.',
  'The seeing stopped at the changing room door. The verse says it does not.',
  'देखना चेंजिंग रूम के दरवाज़े पर रुक गया। श्लोक कहता है कि वह रुकता नहीं।',
  'Dekhna changing room ke darwaze par ruk gaya. Shloka kehta hai ki woh rukta nahi.',
  NULL, 'intermediate', 'sport,self-talk,generosity,asymmetry'

  UNION ALL SELECT 29, 'corporate', 3,
  'The appraisal she wrote about herself', 'वह मूल्यांकन जो उसने अपने बारे में लिखा', 'Woh mulyankan jo usne apne baare mein likha',
  'A manager writes fair, specific, generous appraisals for seven people. Then she writes her own self-assessment and it reads like a prosecution. A colleague reads both and asks whether she would sign off the second one for anybody else.',
  'एक मैनेजर सात लोगों के लिए न्यायसंगत, ठोस और उदार मूल्यांकन लिखती है। फिर वह अपना ख़ुद का मूल्यांकन लिखती है और वह अभियोजन जैसा पढ़ा जाता है। एक साथी दोनों पढ़ता है और पूछता है कि क्या वह दूसरा वाला किसी और के लिए मंज़ूर करेगी।',
  'Ek manager saat logon ke liye nyaysangat, thos aur udaar mulyankan likhti hai. Phir woh apna khud ka mulyankan likhti hai aur woh abhiyojan jaisa padha jaata hai. Ek saathi dono padhta hai aur poochhta hai ki kya woh doosra wala kisi aur ke liye manzoor karegi.',
  'The chapter''s test, applied by a colleague with two documents. Nothing here requires her to be kinder to herself as a matter of policy; the question is only whether the standard she is applying is the same one. The verse says the seeing is one faculty, not two.',
  'अध्याय की कसौटी, दो दस्तावेज़ों के साथ एक साथी द्वारा लगाई गई। यहाँ किसी नीति के तौर पर उससे अपने साथ नरम होने की माँग नहीं है; सवाल बस यह है कि जो पैमाना वह लगा रही है वह वही है या नहीं। श्लोक कहता है कि देखना एक ही क्षमता है, दो नहीं।',
  'Adhyay ki kasauti, do dastavezon ke saath ek saathi dwara lagayi gayi. Yahan kisi neeti ke taur par usse apne saath naram hone ki maang nahi hai; sawal bas yeh hai ki jo paimana woh laga rahi hai woh wahi hai ya nahi. Shloka kehta hai ki dekhna ek hi kshamta hai, do nahi.',
  'Nobody asked her to be kinder. The question was whether the standard was the same.',
  'किसी ने उससे नरम होने को नहीं कहा। सवाल यह था कि पैमाना वही है या नहीं।',
  'Kisi ne usse naram hone ko nahi kaha. Sawal yeh tha ki paimana wahi hai ya nahi.',
  NULL, 'intermediate', 'work,appraisals,standards,self-talk'

  UNION ALL SELECT 29, 'college', 4,
  'The résumé of failures', 'नाकामियों की सूची', 'Nakamiyon ki soochi',
  'A student keeps a private list of everything he has been rejected from and reads it before applying to anything, on the theory that it keeps him realistic. A tutor asks how the list has changed his applications. It has not. It has only changed how he feels sending them.',
  'एक छात्र अपनी हर अस्वीकृति की निजी सूची रखता है और कहीं भी आवेदन करने से पहले उसे पढ़ता है, इस सोच के साथ कि इससे वह ज़मीन पर रहता है। एक ट्यूटर पूछता है कि इस सूची से उसके आवेदनों में क्या बदला। कुछ नहीं। बस यह बदला कि उन्हें भेजते हुए वह कैसा महसूस करता है।',
  'Ek student apni har asweekriti ki niji soochi rakhta hai aur kahin bhi aavedan karne se pehle use padhta hai, is soch ke saath ki isse woh zameen par rehta hai. Ek tutor poochhta hai ki is soochi se uske aavedanon mein kya badla. Kuch nahi. Bas yeh badla ki unhe bhejte hue woh kaisa mehsoos karta hai.',
  'The verse names self-injury as a thing a person does, not a thing that happens to them, and this is a clean instance: a deliberate practice, kept for years, with a reason attached. The tutor does not argue with the reason. She asks what it has produced, which is the only question that settles it.',
  'श्लोक ख़ुद को नुक़सान पहुँचाने को उस चीज़ का नाम देता है जो इंसान करता है, न कि जो उसके साथ होती है, और यह उसका साफ़ नमूना है: एक जानबूझकर किया अभ्यास, सालों से रखा, और उसके साथ एक वजह जुड़ी हुई। ट्यूटर वजह से बहस नहीं करती। वह पूछती है कि इससे निकला क्या, और यही अकेला सवाल इसे तय करता है।',
  'Shloka khud ko nuksaan pahunchane ko us cheez ka naam deta hai jo insan karta hai, na ki jo uske saath hoti hai, aur yeh uska saaf namoona hai: ek jaanboojhkar kiya abhyas, saalon se rakha, aur uske saath ek wajah judi hui. Tutor wajah se behes nahi karti. Woh poochhti hai ki isse nikla kya, aur yahi akela sawal ise tay karta hai.',
  'She did not argue with his reason. She asked what the practice had produced.',
  'उसने उसकी वजह से बहस नहीं की। उसने पूछा कि उस अभ्यास से निकला क्या।',
  'Usne uski wajah se behes nahi ki. Usne poochha ki us abhyas se nikla kya.',
  NULL, 'intermediate', 'students,rejection,self-punishment,reasons'

  UNION ALL SELECT 32, 'healthcare', 1,
  'Twenty minutes and a roundabout, again', 'फिर वही बीस मिनट और चौराहा', 'Phir wahi bees minute aur chauraha',
  'A nurse drives home the same route and does not think about the shift until the second roundabout. After it she thinks about it as much as she needs to, and sometimes cries. In eight years she has not skipped a shift.',
  'एक नर्स हर शाम उसी रास्ते से घर जाती है और दूसरे चौराहे तक शिफ़्ट के बारे में नहीं सोचती। उसके बाद जितना ज़रूरी हो उतना सोचती है, और कभी-कभी रोती है। आठ साल में उसने कोई शिफ़्ट नहीं छोड़ी।',
  'Ek nurse har shaam usi raaste se ghar jaati hai aur doosre chaurahe tak shift ke baare mein nahi sochti. Uske baad jitna zaroori ho utna sochti hai, aur kabhi kabhi roti hai. Aath saal mein usne koi shift nahi chhodi.',
  'Na lipyate — not soaked through. This is the same story that sits under 5.10 and it belongs here too, because 13.32 is the lotus leaf stated as a claim rather than as a picture. Look at what is NOT being described: she is not numb, she has not stopped being affected, and the crying is part of the account rather than a failure of it.',
  'न लिप्यते — भीतर तक न भीगना। यह वही कहानी है जो 5.10 के नीचे है और यहाँ भी बनती है, क्योंकि 13.32 कमल का पत्ता ही है, तस्वीर की तरह नहीं, दावे की तरह कहा हुआ। देखिए क्या नहीं बताया जा रहा: वह सुन्न नहीं है, उस पर असर होना बंद नहीं हुआ, और रोना ब्यौरे का हिस्सा है, उसकी नाकामी नहीं।',
  'Na lipyate — bheetar tak na bheegna. Yeh wahi kahani hai jo 5.10 ke neeche hai aur yahan bhi banti hai, kyunki 13.32 kamal ka patta hi hai, tasveer ki tarah nahi, dawe ki tarah kaha hua. Dekho kya nahi bataya ja raha: woh sunn nahi hai, us par asar hona band nahi hua, aur rona byore ka hissa hai, uski nakami nahi.',
  'She is not numb and has not stopped being affected. That is what not-soaked means.',
  'वह सुन्न नहीं है और उस पर असर होना बंद नहीं हुआ। न भीगने का मतलब यही है।',
  'Woh sunn nahi hai aur us par asar hona band nahi hua. Na bheegne ka matlab yahi hai.',
  NULL, 'intermediate', 'medicine,boundaries,not-numb,routine'

  UNION ALL SELECT 32, 'corporate', 2,
  'The one who said it did not matter', 'जिसने कहा कि इससे कोई फ़र्क़ नहीं पड़ता', 'Jisne kaha ki isse koi farq nahi padta',
  'Somebody who has read a little about detachment starts telling colleagues, calmly, that outcomes are not real and none of this ultimately matters. He misses two deadlines and is genuinely surprised that anybody is annoyed.',
  'अनासक्ति के बारे में थोड़ा पढ़ चुका कोई शांति से साथियों को बताने लगता है कि नतीजे असली नहीं हैं और आख़िरकार इसमें से किसी का कोई मोल नहीं। वह दो तारीख़ें चूकता है और सचमुच हैरान है कि कोई नाराज़ क्यों है।',
  'Anasakti ke baare mein thoda padh chuka koi shaanti se saathiyon ko batane lagta hai ki nateeje asli nahi hain aur aakhirkar isme se kisi ka koi mol nahi. Woh do tareekhein chookta hai aur sach mein hairan hai ki koi naraaz kyun hai.',
  'This is the second wrong reading and it has to get past two things. 13.29, three verses earlier, says the seeing produces less harm rather than permission. And 13.8 defines the whole business as humility, no pretence and doing no injury — which is a list of obligations, arriving twenty-four verses before this one.',
  'यह दूसरा ग़लत पाठ है और इसे दो चीज़ों से पार पाना होगा। 13.29, तीन श्लोक पहले, कहता है कि यह देखना छूट नहीं, कम नुक़सान पैदा करता है। और 13.8 पूरे मामले को विनम्रता, दिखावे का अभाव और नुक़सान न पहुँचाना बता देता है — जो ज़िम्मेदारियों की सूची है, और वह इस श्लोक से चौबीस श्लोक पहले आती है।',
  'Yeh doosra galat paath hai aur ise do cheezon se paar paana hoga. 13.29, teen shloka pehle, kehta hai ki yeh dekhna chhoot nahi, kam nuksaan paida karta hai. Aur 13.8 poore mamle ko vinamrata, dikhave ka abhav aur nuksaan na pahunchana bata deta hai — jo zimmedariyon ki soochi hai, aur woh is shloka se chaubees shloka pehle aati hai.',
  'The licence reading has to get past 13.29 and past a list that starts with humility.',
  'छूट वाले पाठ को 13.29 से और उस सूची से पार पाना होगा जो विनम्रता से शुरू होती है।',
  'Chhoot wale paath ko 13.29 se aur us soochi se paar paana hoga jo vinamrata se shuru hoti hai.',
  NULL, 'advanced', 'work,detachment,licence,obligations'

  UNION ALL SELECT 32, 'parenting', 3,
  'She stayed in the room', 'वह कमरे में रही', 'Woh kamre mein rahi',
  'A parent sits through forty minutes of a child being inconsolable about something small. She does not fix it, does not talk him out of it, and does not go somewhere else in her head. Afterwards she is tired and not damaged.',
  'एक अभिभावक चालीस मिनट बैठी रहती है जब बच्चा किसी छोटी बात पर चुप ही नहीं हो रहा। वह न उसे ठीक करती है, न समझा-बुझाकर हटाती है, और न अपने मन में कहीं और चली जाती है। बाद में वह थकी हुई है, टूटी हुई नहीं।',
  'Ek abhibhavak chalees minute baithi rehti hai jab bachcha kisi chhoti baat par chup hi nahi ho raha. Woh na use theek karti hai, na samjha-bujhakar hatati hai, aur na apne man mein kahin aur chali jaati hai. Baad mein woh thaki hui hai, tooti hui nahi.',
  'Śarīra-sthaḥ api — although situated right inside it. The verse puts it in the body before saying anything else, and this is the parenting version: she did not go anywhere in her head, which is the exact thing the misreading recommends. Tired and not damaged is what not-soaked actually looks like.',
  'शरीरस्थोऽपि — उसी के भीतर होते हुए भी। श्लोक कुछ और कहने से पहले उसे शरीर में रख देता है, और यह उसका अभिभावक वाला रूप है: वह अपने मन में कहीं गई नहीं, और ग़लत पाठ ठीक वही सुझाता है। थका होना और टूटा न होना — न भीगना असल में ऐसा दिखता है।',
  'Sharira-sthah api — usi ke bheetar hote hue bhi. Shloka kuch aur kehne se pehle use sharir mein rakh deta hai, aur yeh uska abhibhavak wala roop hai: woh apne man mein kahin gayi nahi, aur galat paath theek wahi sujhata hai. Thaka hona aur toota na hona — na bheegna asal mein aisa dikhta hai.',
  'She did not go anywhere in her head. Tired and not damaged is the whole claim.',
  'वह अपने मन में कहीं गई नहीं। थका होना और टूटा न होना — पूरा दावा यही है।',
  'Woh apne man mein kahin gayi nahi. Thaka hona aur toota na hona — poora dawa yahi hai.',
  NULL, 'beginner', 'parenting,presence,tiredness,staying'

  UNION ALL SELECT 32, 'everyday_life', 4,
  'The thing that did not soak in', 'वह चीज़ जो भीतर तक नहीं भीगी', 'Woh cheez jo bheetar tak nahi bheegi',
  'Two people get the same rude remark from the same stranger. One of them is still describing it at dinner. The other remembers it eleven days later only because somebody else brings it up, and finds he cannot recall being upset.',
  'दो लोगों को उसी अजनबी से वही रूखी बात सुननी पड़ती है। उनमें से एक रात के खाने तक उसका ज़िक्र कर रहा है। दूसरे को वह ग्यारह दिन बाद तभी याद आती है जब कोई और उसका ज़िक्र करता है, और उसे यह भी याद नहीं आता कि उसे बुरा लगा था।',
  'Do logon ko usi ajnabi se wahi rookhi baat sunni padti hai. Unme se ek raat ke khane tak uska zikr kar raha hai. Doosre ko woh gyarah din baad tabhi yaad aati hai jab koi aur uska zikr karta hai, aur use yeh bhi yaad nahi aata ki use bura laga tha.',
  'Both of them were touched by it — the second one was there, heard it and did not enjoy it. Only one of them was soaked. That is the distinction the verse is making, and it is not a distinction between feeling and not feeling. It is between something landing and something being absorbed.',
  'दोनों को वह छू गई थी — दूसरा भी वहीं था, उसने सुना और उसे अच्छा नहीं लगा। भीगा उनमें से सिर्फ़ एक। श्लोक यही फ़र्क़ कर रहा है, और यह महसूस होने और न होने का फ़र्क़ नहीं है। यह किसी चीज़ के पड़ने और किसी चीज़ के सोख लिए जाने का फ़र्क़ है।',
  'Dono ko woh chhoo gayi thi — doosra bhi wahin tha, usne suna aur use achha nahi laga. Bheega unme se sirf ek. Shloka yahi farq kar raha hai, aur yeh mehsoos hone aur na hone ka farq nahi hai. Yeh kisi cheez ke padne aur kisi cheez ke sokh liye jaane ka farq hai.',
  'Both were touched by it. One was soaked. Those are different things.',
  'दोनों को वह छू गई। भीगा एक। ये अलग चीज़ें हैं।',
  'Dono ko woh chhoo gayi. Bheega ek. Yeh alag cheezein hain.',
  NULL, 'beginner', 'rudeness,strangers,absorbing,difference'

  UNION ALL SELECT 34, 'everyday_life', 1,
  'The drawer he had not opened', 'वह दराज़ जो उसने खोली नहीं थी', 'Woh daraz jo usne kholi nahi thi',
  'Somebody sorting out a house opens a drawer he has been walking past for two years because he knows what is in it. It takes nineteen minutes. Nothing in it is as bad as the two years of not opening it had been.',
  'घर ठीक करता कोई एक दराज़ खोलता है जिसके पास से वह दो साल से गुज़र रहा था क्योंकि उसे पता है उसमें क्या है। उन्नीस मिनट लगते हैं। उसमें कुछ भी उतना बुरा नहीं है जितने वे दो साल थे जब वह उसे नहीं खोल रहा था।',
  'Ghar theek karta koi ek daraz kholta hai jiske paas se woh do saal se guzar raha tha kyunki use pata hai usme kya hai. Unnees minute lagte hain. Usme kuch bhi utna bura nahi hai jitne woh do saal the jab woh use nahi khol raha tha.',
  'Kṛtsnam — the whole of it. The sun does not light the parts of the world it approves of, and the closing image of the chapter is about indiscriminate light rather than about effort. Nineteen minutes is what the whole field looked like on one afternoon.',
  'कृत्स्नम् — पूरा का पूरा। सूरज दुनिया के उन हिस्सों को रोशन नहीं करता जिन्हें उसकी मंज़ूरी है, और अध्याय की आख़िरी तस्वीर बिना छँटाई वाली रोशनी की है, मेहनत की नहीं। एक दोपहर में पूरा क्षेत्र उन्नीस मिनट का दिखा।',
  'Kritsnam — poora ka poora. Sooraj duniya ke un hisson ko roshan nahi karta jinhe uski manzoori hai, aur adhyay ki aakhiri tasveer bina chhantai wali roshni ki hai, mehnat ki nahi. Ek dopahar mein poora kshetra unnees minute ka dikha.',
  'Nothing in the drawer was as bad as the two years of not opening it.',
  'दराज़ में कुछ भी उतना बुरा नहीं था जितने वे दो साल थे जब वह नहीं खुली।',
  'Daraz mein kuch bhi utna bura nahi tha jitne woh do saal the jab woh nahi khuli.',
  NULL, 'beginner', 'avoidance,drawers,light,whole'

  UNION ALL SELECT 34, 'relationships', 2,
  'The part of the year they did not discuss', 'साल का वह हिस्सा जिस पर बात नहीं हुई', 'Saal ka woh hissa jis par baat nahi hui',
  'Two people review a difficult year together and, without agreeing to, both leave out the same three weeks. On the fourth attempt one of them says the dates out loud. The conversation that follows is not pleasant and is the only one that changes anything.',
  'दो लोग एक मुश्किल साल पर साथ बैठकर बात करते हैं और बिना तय किए, दोनों वही तीन हफ़्ते छोड़ देते हैं। चौथी कोशिश में उनमें से एक तारीख़ें ज़ोर से बोल देता है। उसके बाद जो बातचीत होती है वह सुखद नहीं है और वही अकेली है जिससे कुछ बदलता है।',
  'Do log ek mushkil saal par saath baithkar baat karte hain aur bina tay kiye, dono wahi teen hafte chhod dete hain. Chauthi koshish mein unme se ek tareekhein zor se bol deta hai. Uske baad jo baatcheet hoti hai woh sukhad nahi hai aur wahi akeli hai jisse kuch badalta hai.',
  'The whole field, not the parts you approve of. The chapter does not promise that lighting all of it is comfortable — it says a sun does not sort, which is a claim about how light works rather than about how it feels. Three attempts got the tidy version and the fourth got the year.',
  'पूरा क्षेत्र, वे हिस्से नहीं जिन्हें आपकी मंज़ूरी है। अध्याय यह वादा नहीं करता कि सब कुछ रोशन करना सुखद होगा — वह कहता है कि सूरज छँटाई नहीं करता, और यह दावा इस बारे में है कि रोशनी काम कैसे करती है, इस बारे में नहीं कि महसूस कैसी होती है। तीन कोशिशों में सुथरा रूप मिला और चौथी में साल मिला।',
  'Poora kshetra, woh hisse nahi jinhe tumhari manzoori hai. Adhyay yeh waada nahi karta ki sab kuch roshan karna sukhad hoga — woh kehta hai ki sooraj chhantai nahi karta, aur yeh dawa is baare mein hai ki roshni kaam kaise karti hai, is baare mein nahi ki mehsoos kaisi hoti hai. Teen koshishon mein suthra roop mila aur chauthi mein saal mila.',
  'Three attempts got the tidy version. The fourth got the year.',
  'तीन कोशिशों में सुथरा रूप मिला। चौथी में साल मिला।',
  'Teen koshishon mein suthra roop mila. Chauthi mein saal mila.',
  NULL, 'intermediate', 'couples,avoidance,honesty,whole'

  UNION ALL SELECT 34, 'technology', 3,
  'The logs nobody had read', 'वे लॉग जो किसी ने नहीं पढ़े', 'Woh log jo kisi ne nahi padhe',
  'A team debugging an intermittent fault reads the error logs for three weeks. The cause turns out to be in the ordinary logs, which nobody had looked at because nothing in them was flagged as a problem.',
  'रह-रहकर आने वाली एक ख़राबी ढूँढ़ती एक टीम तीन हफ़्ते एरर लॉग पढ़ती है। वजह आम लॉग में निकलती है, जिन्हें किसी ने देखा ही नहीं था क्योंकि उनमें कुछ भी समस्या के तौर पर चिह्नित नहीं था।',
  'Reh-rehkar aane wali ek kharabi dhoondhti ek team teen hafte error log padhti hai. Wajah aam log mein nikalti hai, jinhe kisi ne dekha hi nahi tha kyunki unme kuch bhi samasya ke taur par chihnit nahi tha.',
  'Kṛtsnam, the whole of it, and the sun does no sorting. Three weeks were spent on the part of the field that had already been marked as worth lighting. The chapter''s closing image is a claim about coverage, and it applies wherever somebody has decided in advance where to look.',
  'कृत्स्नम्, पूरा का पूरा, और सूरज कोई छँटाई नहीं करता। तीन हफ़्ते क्षेत्र के उस हिस्से पर लगे जिसे पहले ही रोशन करने लायक़ चिह्नित कर दिया गया था। अध्याय की आख़िरी तस्वीर परिधि का दावा है, और वह हर उस जगह लागू होती है जहाँ किसी ने पहले से तय कर रखा हो कि देखना कहाँ है।',
  'Kritsnam, poora ka poora, aur sooraj koi chhantai nahi karta. Teen hafte kshetra ke us hisse par lage jise pehle hi roshan karne layak chihnit kar diya gaya tha. Adhyay ki aakhiri tasveer paridhi ka dawa hai, aur woh har us jagah laagu hoti hai jahan kisi ne pehle se tay kar rakha ho ki dekhna kahan hai.',
  'They lit the part of the field somebody had already marked as worth lighting.',
  'उन्होंने क्षेत्र का वही हिस्सा रोशन किया जिसे किसी ने पहले ही रोशन करने लायक़ मान लिया था।',
  'Unhone kshetra ka wahi hissa roshan kiya jise kisi ne pehle hi roshan karne layak maan liya tha.',
  NULL, 'intermediate', 'debugging,coverage,assumptions,whole'

  UNION ALL SELECT 34, 'marriage', 4,
  'Forty years and one unopened subject', 'चालीस साल और एक न खुला विषय', 'Chalees saal aur ek na khula vishay',
  'A couple married forty years are asked what they have never talked about. They look at each other and both know immediately. Neither of them says it, and both of them laugh, and something about the laugh is not entirely comfortable.',
  'चालीस साल से शादीशुदा एक जोड़े से पूछा जाता है कि उन्होंने किस बारे में कभी बात नहीं की। वे एक-दूसरे को देखते हैं और दोनों को फ़ौरन पता है। कोई कहता नहीं, दोनों हँस देते हैं, और उस हँसी में कुछ पूरी तरह सहज नहीं है।',
  'Chalees saal se shaadishuda ek jode se poochha jaata hai ki unhone kis baare mein kabhi baat nahi ki. Woh ek doosre ko dekhte hain aur dono ko fauran pata hai. Koi kehta nahi, dono hans dete hain, aur us hansi mein kuch poori tarah sahaj nahi hai.',
  'The chapter ends with light that does not choose, and this is what a field looks like when one corner has been kept dark for four decades. Nothing in the verse says they must open it. What the verse says is that the light does not stop at the edge of it, which is why they both knew immediately.',
  'अध्याय ऐसी रोशनी पर ख़त्म होता है जो चुनती नहीं, और चार दशक तक एक कोना अँधेरे में रखा जाए तो क्षेत्र ऐसा दिखता है। श्लोक में कुछ यह नहीं कहता कि उन्हें उसे खोलना ही है। श्लोक यह कहता है कि रोशनी उसके किनारे पर रुकती नहीं, और इसीलिए दोनों को फ़ौरन पता था।',
  'Adhyay aisi roshni par khatam hota hai jo chunti nahi, aur chaar dashak tak ek kona andhere mein rakha jaaye to kshetra aisa dikhta hai. Shloka mein kuch yeh nahi kehta ki unhe use kholna hi hai. Shloka yeh kehta hai ki roshni uske kinare par rukti nahi, aur isiliye dono ko fauran pata tha.',
  'Nobody has to open it. But both of them knew immediately, which is the verse''s point.',
  'किसी को उसे खोलना ज़रूरी नहीं। पर दोनों को फ़ौरन पता था, और श्लोक की बात यही है।',
  'Kisi ko use kholna zaroori nahi. Par dono ko fauran pata tha, aur shloka ki baat yahi hai.',
  NULL, 'intermediate', 'marriage,unspoken,knowing,light'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 13;

-- =====================================================================
-- 5. CROSS REFERENCES
-- =====================================================================
-- THIRTEEN DECLARED. Every target checked against the seeded verse list
-- first. Count the loaded rows against thirteen before shipping.
--
-- The 13.29 -> 6.5 and 13.29 -> 17.19 pair completes the corpus's
-- wellbeing triangle: three separate chapters, each saying in its own
-- vocabulary that what you do to yourself is a thing the text is
-- watching. A reader who lands on any one of them should be offered the
-- other two.
-- =====================================================================

DELETE x FROM verse_cross_references x JOIN verses v ON v.id = x.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 13;

INSERT INTO verse_cross_references
  (verse_id, reference_type, book, chapter, verse, target_verse_id,
   description_en, description_hi, description_hinglish, relationship, sort_order)
SELECT v.id, 'gita', 'Bhagavad Gita', CAST(x.tch AS CHAR), CAST(x.tvn AS CHAR), tv.id,
       x.d_en, x.d_hi, x.d_hing, x.rel, x.ord
FROM (
  SELECT 2 AS vn, 2 AS tch, 13 AS tvn, 1 AS ord,
    'The same distinction, made much earlier and much more gently: the body passes through childhood, youth and age and something is not confused by that. 2.13 is the version to read first.' AS d_en,
    'वही फ़र्क़, बहुत पहले और बहुत नरमी से कहा गया: शरीर बचपन, जवानी और बुढ़ापे से गुज़रता है और कोई चीज़ इससे भ्रमित नहीं होती। पहले 2.13 पढ़ना चाहिए।' AS d_hi,
    'Wahi farq, bahut pehle aur bahut narmi se kaha gaya: sharir bachpan, jawani aur budhape se guzarta hai aur koi cheez isse bhramit nahi hoti. Pehle 2.13 padhna chahiye.' AS d_hing,
    'same' AS rel
  UNION ALL SELECT 6, 14, 5, 1,
    'Chapter 14 lists three settings that take turns; this verse lists what the field contains and puts awareness among the contents. Both are inventories of what is running, and neither is a description of who somebody is.',
    'चौदहवाँ अध्याय बारी-बारी चलने वाली तीन अवस्थाएँ गिनाता है; यह श्लोक गिनाता है कि क्षेत्र में क्या है और चेतना को उसी सामग्री में रख देता है। दोनों इस बात की सूचियाँ हैं कि क्या चल रहा है, और कोई भी इसका वर्णन नहीं कि कोई है कौन।',
    'Chaudahvan adhyay baari-baari chalne wali teen avasthayein ginata hai; yeh shloka ginata hai ki kshetra mein kya hai aur chetna ko usi samagri mein rakh deta hai. Dono is baat ki soochiyan hain ki kya chal raha hai, aur koi bhi iska varnan nahi ki koi hai kaun.',
    'supports'
  UNION ALL SELECT 6, 5, 22, 1,
    'Pleasure and pain are on this chapter''s list of contents; 5.22 says where they come from and that they have a beginning and an end. Together they place the feelings without arguing that anybody should stop having them.',
    'सुख और दुख इस अध्याय की सामग्री की सूची में हैं; 5.22 बताता है कि वे आते कहाँ से हैं और उनका आरंभ और अंत है। दोनों मिलकर भावनाओं को उनकी जगह रख देते हैं, यह दलील दिए बिना कि किसी को उन्हें होना बंद कर देना चाहिए।',
    'Sukh aur dukh is adhyay ki samagri ki soochi mein hain; 5.22 batata hai ki woh aate kahan se hain aur unka aarambh aur ant hai. Dono milkar bhavnaon ko unki jagah rakh dete hain, yeh dalil diye bina ki kisi ko unhe hona band kar dena chahiye.',
    'supports'
  UNION ALL SELECT 8, 16, 3, 1,
    'Another list of conduct, and the overlap is the interesting part: both chapters, asked about something large, answer with ordinary behaviour rather than with a claim about reality.',
    'बरताव की एक और सूची, और दिलचस्प बात यह है कि दोनों मिलती हैं: दोनों अध्याय, किसी बड़ी चीज़ के बारे में पूछे जाने पर, वास्तविकता के बारे में दावे के बजाय आम बरताव में जवाब देते हैं।',
    'Bartav ki ek aur soochi, aur dilchasp baat yeh hai ki dono milti hain: dono adhyay, kisi badi cheez ke baare mein poochhe jaane par, vastavikta ke baare mein dawe ke bajaye aam bartav mein jawab dete hain.',
    'same'
  UNION ALL SELECT 8, 17, 15, 1,
    'The discipline of speech, held to four conditions at once. 13.8 puts ārjava — straightness — on its list, and 17.15 is what that looks like when it has to be done out loud.',
    'वाणी का अनुशासन, एक साथ चार शर्तों पर कसा हुआ। 13.8 अपनी सूची में आर्जव — सीधापन — रखता है, और 17.15 वह है जब उसे ज़ोर से करना पड़े।',
    'Vaani ka anushasan, ek saath chaar shartein par kasa hua. 13.8 apni soochi mein aarjav — seedhapan — rakhta hai, aur 17.15 woh hai jab use zor se karna pade.',
    'supports'
  UNION ALL SELECT 20, 3, 27, 1,
    'Actions are done by the guṇas and the mistaken one thinks "I did it". 13.20 makes the same handover and then stops — it does not hand over the undergoing, and that reservation is the whole difference.',
    'कर्म गुण करते हैं और भ्रम में पड़ा सोचता है "मैंने किया"। 13.20 वही सौंपना करता है और फिर रुक जाता है — वह गुज़रना नहीं सौंपता, और यही रोक पूरा फ़र्क़ है।',
    'Karm gun karte hain aur bhram mein pada sochta hai "maine kiya". 13.20 wahi saunpna karta hai aur phir ruk jaata hai — woh guzarna nahi saunpta, aur yahi rok poora farq hai.',
    'same'
  UNION ALL SELECT 20, 5, 8, 1,
    '"I am not doing anything" — while seeing, hearing, walking, breathing. 13.20 says which half of that is being handed over and which half is not.',
    '"मैं कुछ नहीं करता" — और साथ ही देखते, सुनते, चलते, साँस लेते हुए। 13.20 बताता है कि उसमें कौन-सा आधा सौंपा जा रहा है और कौन-सा नहीं।',
    '"Main kuch nahi karta" — aur saath hi dekhte, sunte, chalte, saans lete hue. 13.20 batata hai ki usme kaun sa aadha saunpa ja raha hai aur kaun sa nahi.',
    'supports'
  UNION ALL SELECT 27, 5, 18, 1,
    'The same claim with a list attached. 5.18 names five very different beings and says the wise see the same in all five; 13.27 makes the claim with no list at all, which is harder to argue with and harder to feel pleased about.',
    'वही दावा, सूची के साथ। 5.18 पाँच बहुत अलग प्राणियों का नाम लेता है और कहता है कि ज्ञानी पाँचों में वही देखते हैं; 13.27 वही दावा बिना किसी सूची के करता है, जिससे बहस करना भी मुश्किल है और ख़ुश होना भी।',
    'Wahi dawa, soochi ke saath. 5.18 paanch bahut alag praniyon ka naam leta hai aur kehta hai ki gyani paanchon mein wahi dekhte hain; 13.27 wahi dawa bina kisi soochi ke karta hai, jisse behes karna bhi mushkil hai aur khush hona bhi.',
    'same'
  UNION ALL SELECT 27, 12, 13, 1,
    'No hatred towards any being, friendly and compassionate. 12.13 describes the conduct; 13.27 describes the seeing that would make that conduct unremarkable rather than effortful.',
    'किसी प्राणी से द्वेष नहीं, मित्रवत और करुण। 12.13 बरताव बताता है; 13.27 वह देखना बताता है जो उस बरताव को मेहनत नहीं, सामान्य बना दे।',
    'Kisi prani se dwesh nahi, mitravat aur karun. 12.13 bartav batata hai; 13.27 woh dekhna batata hai jo us bartav ko mehnat nahi, samanya bana de.',
    'supports'
  UNION ALL SELECT 29, 6, 5, 1,
    'Read these together. 6.5 says a person can lift themselves or let themselves sink; 13.29 says the seeing described in this chapter is what stops them doing the second. Same construction, ātmanā ātmānam, in both.',
    'इन्हें साथ पढ़िए। 6.5 कहता है कि आदमी ख़ुद को उठा सकता है या डूबने दे सकता है; 13.29 कहता है कि इस अध्याय का बताया देखना ही उसे दूसरा करने से रोकता है। दोनों में वही बनावट है, आत्मना आत्मानम्।',
    'Inhe saath padho. 6.5 kehta hai ki aadmi khud ko utha sakta hai ya doobne de sakta hai; 13.29 kehta hai ki is adhyay ka bataya dekhna hi use doosra karne se rokta hai. Dono mein wahi banawat hai, atmana atmanam.',
    'same'
  UNION ALL SELECT 29, 17, 19, 1,
    'The third corner of the same triangle. 17.19 puts practice undertaken by hurting yourself in the bottom category; 13.29 says the seeing produces less self-harm. Both are the text watching what a reader does to themselves.',
    'उसी त्रिकोण का तीसरा कोना। 17.19 ख़ुद को तकलीफ़ देकर किए गए अभ्यास को सबसे नीचे रखता है; 13.29 कहता है कि यह देखना ख़ुद को नुक़सान कम करता है। दोनों में ग्रंथ यह देख रहा है कि पाठक अपने साथ क्या करता है।',
    'Usi trikon ka teesra kona. 17.19 khud ko takleef dekar kiye gaye abhyas ko sabse neeche rakhta hai; 13.29 kehta hai ki yeh dekhna khud ko nuksaan kam karta hai. Dono mein granth yeh dekh raha hai ki paathak apne saath kya karta hai.',
    'same'
  UNION ALL SELECT 32, 5, 10, 1,
    'The lotus leaf. 5.10 gives the picture and 13.32 states it as a claim, and the picture is what stops the claim being misread: the leaf is in the water the entire time.',
    'कमल का पत्ता। 5.10 तस्वीर देता है और 13.32 उसे दावे की तरह कहता है, और तस्वीर ही दावे को ग़लत पढ़े जाने से रोकती है: पत्ता पूरे समय पानी में ही है।',
    'Kamal ka patta. 5.10 tasveer deta hai aur 13.32 use dawe ki tarah kehta hai, aur tasveer hi dawe ko galat padhe jaane se rokti hai: patta poore samay paani mein hi hai.',
    'same'
  UNION ALL SELECT 34, 1, 30, 1,
    'A mind going round while everything looked like it was pointing the wrong way. 13.34 is the other end of the same instrument: light that does not choose what to land on, including the parts of a week somebody would rather not look at.',
    'घूमता हुआ मन, और सब कुछ उलटी दिशा में इशारा करता दिखता हुआ। 13.34 उसी औज़ार का दूसरा सिरा है: ऐसी रोशनी जो यह नहीं चुनती कि किस पर पड़े, हफ़्ते के उन हिस्सों पर भी जिन्हें कोई देखना नहीं चाहता।',
    'Ghoomta hua man, aur sab kuch ulti disha mein ishara karta dikhta hua. 13.34 usi auzaar ka doosra sira hai: aisi roshni jo yeh nahi chunti ki kis par pade, hafte ke un hisson par bhi jinhe koi dekhna nahi chahta.',
    'opposite'
) AS x
JOIN verses v  ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 13
JOIN chapters tc ON tc.chapter_number = x.tch
JOIN verses tv ON tv.verse_number = x.tvn AND tv.chapter_id = tc.id;

-- =====================================================================
-- 6. WORD BY WORD
-- =====================================================================
-- Four glosses carry the chapter's safeguards:
--   kṣetrajña (13.2)   says two words, not two places
--   cetanā (13.6)      says awareness is ON the list of things observed
--   ātmanā ātmānam (13.29) says the same construction as 6.5
--   na lipyate (13.32) says not coloured by, not not-felt
-- All glosses stay under 400 characters — the column is varchar(400).
-- =====================================================================

DELETE w FROM verse_word_meanings w JOIN verses v ON v.id = w.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 13;

INSERT INTO verse_word_meanings
  (verse_id, word_order, devanagari, transliteration,
   meaning_en, meaning_hi, meaning_hinglish, grammar, root_word)
SELECT v.id, w.ord, w.dev, w.tr, w.m_en, w.m_hi, w.m_hing, w.gram, w.root FROM (

  SELECT 2 AS vn, 1 AS ord, 'क्षेत्रम्' AS dev, 'kṣetram' AS tr, 'a field — a piece of ground, something worked on and worked in. Not something escaped from; a farmer does not leave the field to know it' AS m_en, 'क्षेत्र — ज़मीन का टुकड़ा, वह जिस पर और जिसके भीतर काम किया जाता है। वह नहीं जिससे भागा जाए; किसान खेत को जानने के लिए खेत छोड़कर नहीं जाता' AS m_hi, 'kshetra — zameen ka tukda, woh jis par aur jiske bheetar kaam kiya jaata hai. Woh nahi jisse bhaaga jaaye; kisan khet ko jaanne ke liye khet chhodkar nahi jaata' AS m_hing, 'nominative singular' AS gram, 'क्षि' AS root
  UNION ALL SELECT 2, 2, 'अभिधीयते', 'abhidhīyate', 'is called, is designated — passive. The verse is naming a term, not asserting a metaphysics', 'कहा जाता है, नाम दिया जाता है — कर्मवाच्य। श्लोक एक शब्द का नाम रख रहा है, कोई तत्त्वदर्शन नहीं ठोक रहा', 'kaha jaata hai, naam diya jaata hai — karmvachya. Shloka ek shabd ka naam rakh raha hai, koi tattvadarshan nahi thok raha', 'passive, third singular', 'अभि + धा'
  UNION ALL SELECT 2, 3, 'एतत् यः वेत्ति', 'etad yo vetti', 'whoever knows this — the definition is by function. It says what the second term DOES, and does not say where it is', 'जो इसे जानता है — परिभाषा काम से है। यह बताती है कि दूसरा शब्द करता क्या है, यह नहीं कि वह है कहाँ', 'jo ise jaanta hai — paribhasha kaam se hai. Yeh batati hai ki doosra shabd karta kya hai, yeh nahi ki woh hai kahan', 'present, third singular', 'विद्'
  UNION ALL SELECT 2, 4, 'क्षेत्रज्ञः', 'kṣetrajñaḥ', 'the knower of the field. Two words are being defined here, not two places named — nothing in the verse says one of them is you and the other is not, and the chapter never says it either', 'क्षेत्रज्ञ — क्षेत्र का जानने वाला। यहाँ दो शब्द परिभाषित हो रहे हैं, दो जगहों के नाम नहीं — श्लोक में कुछ यह नहीं कहता कि इनमें से एक आप हैं और दूसरा नहीं, और अध्याय भी यह कभी नहीं कहता', 'kshetragya — kshetra ka jaanne wala. Yahan do shabd paribhashit ho rahe hain, do jagahon ke naam nahi — shloka mein kuch yeh nahi kehta ki inme se ek tum ho aur doosra nahi, aur adhyay bhi yeh kabhi nahi kehta', 'nominative singular', 'ज्ञा'

  UNION ALL SELECT 6, 1, 'इच्छा द्वेषः', 'icchā dveṣaḥ', 'wanting and not wanting — the first two contents of the field, and the pair the rest of the book keeps returning to', 'इच्छा और द्वेष — क्षेत्र की पहली दो चीज़ें, और वही जोड़ी जिस पर बाक़ी किताब बार-बार लौटती है', 'ichchha aur dwesh — kshetra ki pehli do cheezein, aur wahi jodi jis par baaki kitaab baar baar lautti hai', 'nominative singular', 'इष्, द्विष्'
  UNION ALL SELECT 6, 2, 'सुखं दुःखम्', 'sukhaṁ duḥkham', 'pleasure and pain — contents of the field, which is why the chapter never asks anybody to stop having them', 'सुख और दुख — क्षेत्र की सामग्री, और इसीलिए अध्याय कभी किसी से इन्हें होना बंद करने को नहीं कहता', 'sukh aur dukh — kshetra ki samagri, aur isiliye adhyay kabhi kisi se inhe hona band karne ko nahi kehta', 'nominative singular', NULL
  UNION ALL SELECT 6, 3, 'संघातः', 'saṅghātaḥ', 'the aggregate — the assembled body, everything held together as one thing', 'संघात — जुड़ा हुआ ढाँचा, वह सब जो एक चीज़ की तरह थमा हुआ है', 'sanghat — juda hua dhaancha, woh sab jo ek cheez ki tarah thama hua hai', 'nominative singular', 'सम् + हन्'
  UNION ALL SELECT 6, 4, 'चेतना', 'cetanā', 'AWARENESS — and it is on the list of what the FIELD contains. That single placement rules out treating the watcher as a place a person can climb into, because awareness is among the things being watched', 'चेतना — और यह उस सूची में है कि क्षेत्र में क्या है। यही एक जगह रखना उस पाठ को ख़ारिज कर देता है जिसमें देखने वाला कोई ऐसी जगह हो जिसमें चढ़ बैठा जाए, क्योंकि चेतना ख़ुद देखी जाने वाली चीज़ों में है', 'chetna — aur yeh us soochi mein hai ki kshetra mein kya hai. Yahi ek jagah rakhna us paath ko khaarij kar deta hai jisme dekhne wala koi aisi jagah ho jisme chadh baitha jaaye, kyunki chetna khud dekhi jaane wali cheezon mein hai', 'nominative singular', 'चित्'
  UNION ALL SELECT 6, 5, 'धृतिः', 'dhṛtiḥ', 'holding together — what keeps a person in one piece. Also on the list, and also therefore not somewhere to stand', 'धृति — थामे रहना, वह जो आदमी को एक टुकड़े में रखता है। यह भी सूची में है, और इसलिए यह भी खड़े होने की जगह नहीं', 'dhriti — thaame rehna, woh jo aadmi ko ek tukde mein rakhta hai. Yeh bhi soochi mein hai, aur isliye yeh bhi khade hone ki jagah nahi', 'nominative singular', 'धृ'
  UNION ALL SELECT 6, 6, 'सविकारम्', 'sa-vikāram', 'with its changes — the field is not a static object; everything on the list moves', 'विकारों सहित — क्षेत्र कोई ठहरी हुई चीज़ नहीं है; सूची की हर चीज़ हिलती है', 'vikaaron sahit — kshetra koi thehri hui cheez nahi hai; soochi ki har cheez hilti hai', 'accusative singular', 'वि + कृ'

  UNION ALL SELECT 8, 1, 'अमानित्वम्', 'amānitvam', 'not making much of yourself — the FIRST item on the chapter''s definition of knowledge, ahead of everything metaphysical it goes on to say', 'अमानित्व — अपने को बड़ा न बनाना; ज्ञान की अध्याय की परिभाषा की पहली चीज़, उन सब आध्यात्मिक बातों से आगे जो वह आगे कहता है', 'amanitva — apne ko bada na banana; gyan ki adhyay ki paribhasha ki pehli cheez, un sab aadhyatmik baaton se aage jo woh aage kehta hai', 'nominative singular', 'मान्'
  UNION ALL SELECT 8, 2, 'अदम्भित्वम्', 'adambhitvam', 'not putting on a show — dambha is display, the performance of having something', 'अदम्भित्व — दिखावा न करना; दम्भ यानी प्रदर्शन, कुछ होने का अभिनय', 'adambhitva — dikhava na karna; dambh yani pradarshan, kuch hone ka abhinay', 'nominative singular', 'दम्भ्'
  UNION ALL SELECT 8, 3, 'अहिंसा', 'ahiṁsā', 'not doing injury. 13.29 will make explicit that this includes what a person does to themselves', 'अहिंसा — नुक़सान न पहुँचाना। 13.29 साफ़ कर देगा कि इसमें वह भी है जो कोई अपने साथ करता है', 'ahimsa — nuksaan na pahunchana. 13.29 saaf kar dega ki isme woh bhi hai jo koi apne saath karta hai', 'nominative singular', 'हिंस्'
  UNION ALL SELECT 8, 4, 'क्षान्तिः', 'kṣāntiḥ', 'being able to bear something — closer to enduring without making it somebody else''s problem than to "patience"', 'क्षान्ति — किसी चीज़ को सह लेना; "धैर्य" से ज़्यादा इसके पास कि उसे किसी और की मुसीबत न बनाया जाए', 'kshanti — kisi cheez ko seh lena; "dhairya" se zyada iske paas ki use kisi aur ki musibat na banaya jaaye', 'nominative singular', 'क्षम्'
  UNION ALL SELECT 8, 5, 'आर्जवम्', 'ārjavam', 'straightness — being the same shape all the way through, the opposite of bent', 'आर्जव — सीधापन; भीतर तक एक ही आकार का होना, टेढ़े का उलटा', 'aarjav — seedhapan; bheetar tak ek hi aakar ka hona, tedhe ka ulta', 'nominative singular', 'ऋजु'

  UNION ALL SELECT 20, 1, 'कार्यकारणकर्तृत्वे', 'kārya-kāraṇa-kartṛtve', 'in the matter of effect, instrument and doing — three words covering the whole business of things getting done', 'कार्य, कारण और कर्तृत्व के मामले में — तीन शब्द जो चीज़ों के होने का पूरा कारोबार ढक लेते हैं', 'karya, kaaran aur kartritva ke mamle mein — teen shabd jo cheezon ke hone ka poora karobar dhak lete hain', 'locative singular', 'कृ'
  UNION ALL SELECT 20, 2, 'प्रकृतिः', 'prakṛtiḥ', 'the material, nature — what things are made of and made by', 'प्रकृति — वह सामग्री, वह स्वभाव; जिससे चीज़ें बनी हैं और जिससे बनती हैं', 'prakriti — woh samagri, woh swabhav; jisse cheezein bani hain aur jisse banti hain', 'nominative singular', 'प्र + कृ'
  UNION ALL SELECT 20, 3, 'भोक्तृत्वे', 'bhoktṛtve', 'in the matter of UNDERGOING — of being the one something is happening to. This half is NOT handed to prakṛti, and that reservation is what stops the verse becoming a way of not being there', 'भोक्तृत्व के मामले में — उस होने में कि किसी के साथ कुछ हो रहा है। यह आधा प्रकृति को नहीं सौंपा गया, और यही रोक श्लोक को वहाँ न होने का तरीक़ा बनने से रोकती है', 'bhoktritva ke mamle mein — us hone mein ki kisi ke saath kuch ho raha hai. Yeh aadha prakriti ko nahi saunpa gaya, aur yahi rok shloka ko wahan na hone ka tareeka banne se rokti hai', 'locative singular', 'भुज्'
  UNION ALL SELECT 20, 4, 'पुरुषः', 'puruṣaḥ', 'the one in there — the term paired with prakṛti throughout this chapter', 'पुरुष — जो भीतर है; इस पूरे अध्याय में प्रकृति के साथ जोड़ा गया शब्द', 'purush — jo bheetar hai; is poore adhyay mein prakriti ke saath joda gaya shabd', 'nominative singular', NULL

  UNION ALL SELECT 27, 1, 'समम्', 'samam', 'the same, evenly — the same word as in 5.18''s sama-darśinaḥ, and doing the same work', 'समम् — वही, एक-सा; वही शब्द जो 5.18 के समदर्शिनः में है, और वही काम कर रहा है', 'samam — wahi, ek-sa; wahi shabd jo 5.18 ke samdarshinah mein hai, aur wahi kaam kar raha hai', 'accusative singular', 'सम'
  UNION ALL SELECT 27, 2, 'विनश्यत्सु अविनश्यन्तम्', 'vinaśyatsv avinaśyantam', 'undying among the dying — the same participle twice, once with a negative. Everything around it is going; this is not', 'मिटते हुओं के बीच बिना मिटता — वही कृदंत दो बार, एक बार निषेध के साथ। चारों तरफ़ सब जा रहा है; यह नहीं', 'mitte huon ke beech bina mitta — wahi kridant do baar, ek baar nishedh ke saath. Chaaron taraf sab ja raha hai; yeh nahi', 'locative + accusative', 'वि + नश्'
  UNION ALL SELECT 27, 3, 'यः पश्यति स पश्यति', 'yaḥ paśyati sa paśyati', 'whoever sees, that one sees. The same verb twice and nothing else offered. It declines to say what the others are doing instead — it just will not call it seeing', 'जो देखता है, वही देखता है। वही क्रिया दो बार और कुछ नहीं दिया गया। वह यह कहने से इनकार करता है कि बाक़ी क्या कर रहे हैं — वह बस उसे देखना नहीं कहेगा', 'jo dekhta hai, wahi dekhta hai. Wahi kriya do baar aur kuch nahi diya gaya. Woh yeh kehne se inkaar karta hai ki baaki kya kar rahe hain — woh bas use dekhna nahi kahega', 'present, third singular', 'दृश्'

  UNION ALL SELECT 29, 1, 'समं पश्यन् हि', 'samaṁ paśyan hi', 'BECAUSE he sees evenly — hi makes it causal. The seeing is what produces what comes next', 'क्योंकि वह एक-सा देखता है — हि इसे कारण बना देता है। आगे जो आता है वह इसी देखने से पैदा होता है', 'kyunki woh ek-sa dekhta hai — hi ise kaaran bana deta hai. Aage jo aata hai woh isi dekhne se paida hota hai', 'present participle', 'दृश्'
  UNION ALL SELECT 29, 2, 'न हिनस्ति', 'na hinasti', 'does not injure — the verb is from hiṁs, the same root as in ahiṁsā on the 13.8 list', 'हिंसा नहीं करता — क्रिया हिंस् से है, वही धातु जो 13.8 की सूची की अहिंसा में है', 'hinsa nahi karta — kriya hins se hai, wahi dhatu jo 13.8 ki soochi ki ahimsa mein hai', 'present, third singular', 'हिंस्'
  UNION ALL SELECT 29, 3, 'आत्मना आत्मानम्', 'ātmanā ātmānam', 'the self, by the self — instrumental and accusative of the same word, exactly as in 6.5, where a person can lift themselves or let themselves sink. What you do to yourself is a thing this text is watching, and this chapter says the seeing it describes makes LESS of it, not more distance', 'आत्मा से आत्मा को — एक ही शब्द के करण और कर्म रूप, ठीक 6.5 की तरह, जहाँ आदमी ख़ुद को उठा सकता है या डूबने दे सकता है। आप अपने साथ क्या करते हैं, ग्रंथ उस पर नज़र रखे है, और यह अध्याय कहता है कि उसका बताया देखना उसे कम करता है, दूरी नहीं बढ़ाता', 'atma se atma ko — ek hi shabd ke karan aur karm roop, theek 6.5 ki tarah, jahan aadmi khud ko utha sakta hai ya doobne de sakta hai. Tum apne saath kya karte ho, granth us par nazar rakhe hai, aur yeh adhyay kehta hai ki uska bataya dekhna use kam karta hai, doori nahi badhata', 'instrumental + accusative', 'आत्मन्'

  UNION ALL SELECT 32, 1, 'शरीरस्थः अपि', 'śarīra-stho ''pi', 'ALTHOUGH situated in the body — api is the concessive. The verse puts it inside before it says anything else, exactly as 5.10 keeps the leaf in the water', 'शरीर में स्थित होते हुए भी — अपि रियायत का शब्द है। श्लोक कुछ और कहने से पहले उसे भीतर रख देता है, ठीक जैसे 5.10 पत्ते को पानी में ही रखता है', 'sharir mein sthit hote hue bhi — api riyayat ka shabd hai. Shloka kuch aur kehne se pehle use bheetar rakh deta hai, theek jaise 5.10 patte ko paani mein hi rakhta hai', 'nominative singular', 'स्था'
  UNION ALL SELECT 32, 2, 'न करोति', 'na karoti', 'does not do the doing — the same handover as 13.20 and 3.27, and no wider than those', 'करने वाला नहीं होता — वही सौंपना जो 13.20 और 3.27 में है, और उनसे ज़्यादा चौड़ा नहीं', 'karne wala nahi hota — wahi saunpna jo 13.20 aur 3.27 mein hai, aur unse zyada chauda nahi', 'present, third singular', 'कृ'
  UNION ALL SELECT 32, 3, 'न लिप्यते', 'na lipyate', 'is not smeared, is not stained — the same verb as in 5.10. NOT COLOURED BY, not soaked through. It does not mean not touched and it does not mean not felt; the leaf sits in the water all day', 'लिपता नहीं, दागी नहीं जाता — वही क्रिया जो 5.10 में है। रंग नहीं चढ़ता, भीतर तक नहीं भीगता। इसका मतलब न छुआ जाना नहीं है और न महसूस होना नहीं; पत्ता दिन भर पानी में ही बैठा रहता है', 'lipta nahi, daagi nahi jaata — wahi kriya jo 5.10 mein hai. Rang nahi chadhta, bheetar tak nahi bheegta. Iska matlab na chhua jaana nahi hai aur na mehsoos hona nahi; patta din bhar paani mein hi baitha rehta hai', 'passive, third singular', 'लिप्'
  UNION ALL SELECT 32, 4, 'निर्गुणत्वात्', 'nirguṇatvāt', 'from having no guṇas of its own — the three settings of chapter 14 are not among its properties', 'निर्गुण होने के कारण — चौदहवें अध्याय की तीन अवस्थाएँ इसके गुणों में नहीं हैं', 'nirgun hone ke kaaran — chaudahve adhyay ki teen avasthayein iske gunon mein nahi hain', 'ablative singular', 'गुण'

  UNION ALL SELECT 34, 1, 'एकः रविः', 'ekaḥ raviḥ', 'one sun — one, and it does no sorting', 'एक सूरज — एक, और वह कोई छँटाई नहीं करता', 'ek sooraj — ek, aur woh koi chhantai nahi karta', 'nominative singular', NULL
  UNION ALL SELECT 34, 2, 'कृत्स्नम्', 'kṛtsnam', 'THE WHOLE OF IT, entire — used twice in two lines and it is the word doing the work. Not the parts of the field somebody approves of; light does not choose what to land on', 'कृत्स्नम् — पूरा का पूरा, समूचा; दो पंक्तियों में दो बार, और काम यही शब्द कर रहा है। क्षेत्र के वे हिस्से नहीं जिन्हें किसी की मंज़ूरी है; रोशनी यह नहीं चुनती कि किस पर पड़े', 'kritsnam — poora ka poora, samoocha; do panktiyon mein do baar, aur kaam yahi shabd kar raha hai. Kshetra ke woh hisse nahi jinhe kisi ki manzoori hai; roshni yeh nahi chunti ki kis par pade', 'accusative singular', NULL
  UNION ALL SELECT 34, 3, 'प्रकाशयति', 'prakāśayati', 'lights up, makes visible — causative. It does not change what is there; it makes it possible to see', 'प्रकाशित करता है, दिखने लायक़ बनाता है — प्रेरणार्थक। यह बदलता नहीं कि वहाँ क्या है; यह देख पाना मुमकिन करता है', 'prakashit karta hai, dikhne layak banata hai — prernarthak. Yeh badalta nahi ki wahan kya hai; yeh dekh paana mumkin karta hai', 'causative, third singular', 'प्र + काश्'
  UNION ALL SELECT 34, 4, 'क्षेत्री', 'kṣetrī', 'the one the field belongs to — a landholder word, ordinary and unmystical', 'क्षेत्री — जिसका वह क्षेत्र है; ज़मींदार वाला शब्द, आम और बिना किसी रहस्य के', 'kshetri — jiska woh kshetra hai; zamindar wala shabd, aam aur bina kisi rahasya ke', 'nominative singular', 'क्षेत्र'
) AS w
JOIN verses v ON v.verse_number = w.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 13;
