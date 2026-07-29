-- =====================================================================
-- VedaVerse — database/seed_ch18.sql
-- =====================================================================
-- Chapter 18, Mokṣa Sannyāsa Yoga. Eight verses, and the last of the
-- beginner track.
--
--   18.11  nobody with a body gives up action; you give up the fruit
--   18.14  five things go into every action, and you are one of five
--   18.16  seeing yourself as the sole doer is seeing wrongly
--   18.32  the understanding that takes wrong for right
--   18.37  the happiness that is poison first and nectar afterwards
--   18.48  no undertaking is clean, as no fire is without smoke
--   18.59  "I will not fight" is a resolve nature will overrule
--   18.63  reflect on all of it, then do as you wish     [THE ANCHOR]
--
-- WHY THIS SET, AND WHY IT ENDS HERE
--   Chapter 18 is seventy-eight verses long and restates the whole
--   argument. Eight of them have to close the arcs the other four
--   chapters opened, so almost every verse here answers an earlier one:
--   18.11 finishes what 2.47 started, 18.16 finishes 3.27, 18.48 uses
--   the same word 12.16 turns on, and 18.59 is 3.5 said to one specific
--   frightened man by name.
--
--   And then 18.63. After seven hundred verses of argument the speaker
--   says: I have told you the whole of it, think it over completely,
--   and then do as you wish. Not obey. Not accept. Do as you wish.
--
--   That line is the reason this product can exist in the shape it has.
--   A text that ends by handing the decision back can be taught to
--   somebody with no background and no belief without either party
--   having to pretend. The 18.63 explanation says so directly, and it
--   is asserted in smoke-test.sh like the other safeguard sentences —
--   not because anybody is likely to attack it, but because it is the
--   sentence the whole product leans on and it should not be able to
--   drift out quietly.
--
-- TWO SMALLER THINGS THAT NEED CARE
--   18.48 — "no undertaking is free of fault" is one comma away from
--   becoming an excuse for doing harm. The explanation says what it
--   actually licenses: not waiting for a blameless option, which is a
--   argument against paralysis and not a permit.
--
--   18.32 — "the understanding that takes wrong for right" belongs to
--   the same family as chapter 16 and attracts the same misuse. Every
--   reflection and example on it points at the reader.
--
--   18.47 (svadharma restated) is deliberately NOT in this set. 3.35
--   already carries that verse with its safeguard, and repeating it
--   here would mean either repeating the safeguard or shipping the
--   verse without it. It is cross-referenced instead.
--
-- CONTENT RULES — unchanged
--   Original writing throughout. Sanskrit unaltered, numbering
--   untouched. No praise or criticism of any living politician, party
--   or movement. No communal framing anywhere.
--
-- RUN AFTER seed_sample.sql. Re-runnable.
--
--     mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
--         < htdocs/database/seed_ch18.sql
--
-- global_order is 623 + verse_number: chapters 1 to 17 have 623 verses
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

  SELECT 11 AS verse_number, 634 AS global_order, 1 AS is_curated, 'gita-18-11' AS slug,
    'न हि देहभृता शक्यं त्यक्तुं कर्माण्यशेषतः।\nयस्तु कर्मफलत्यागी स त्यागीत्यभिधीयते॥' AS sanskrit_devanagari,
    'na hi deha-bhṛtā śakyaṁ tyaktuṁ karmāṇy aśeṣataḥ\nyas tu karma-phala-tyāgī sa tyāgīty abhidhīyate' AS transliteration_iast,
    'na hi deha-bhrita shakyam tyaktum karmany asheshatah\nyas tu karma-phala-tyagi sa tyagity abhidhiyate' AS transliteration_simple,
    'It is not possible for one who bears a body to give up actions completely. But one who gives up the fruit of action is called a tyāgī.' AS translation_literal,
    'Nobody carrying a body can put all action down. So the word means something else: the one who lets go of what the work earns is the one who has given anything up.' AS translation_en,
    'शरीर लेकर चलने वाला कोई भी सारा कर्म रख नहीं सकता। इसलिए शब्द का मतलब कुछ और है: जो काम से मिलने वाली चीज़ को छोड़ता है, उसी ने कुछ छोड़ा है।' AS translation_hi,
    'Sharir lekar chalne wala koi bhi saara karm rakh nahi sakta. Isliye shabd ka matlab kuch aur hai: jo kaam se milne wali cheez ko chhodta hai, usi ne kuch chhoda hai.' AS translation_hinglish,
    'The book defines its own word at the end, and the definition rules out the version everybody assumed.' AS summary_en,
    'किताब अंत में अपना शब्द ख़ुद परिभाषित करती है, और वह परिभाषा उस रूप को ख़ारिज कर देती है जो सबने मान रखा था।' AS summary_hi,
    'Kitaab ant mein apna shabd khud paribhashit karti hai, aur woh paribhasha us roop ko khaarij kar deti hai jo sabne maan rakha tha.' AS summary_hinglish,
    'beginner' AS difficulty,
    'Gita 18.11: what giving up actually means' AS seo_title,
    'The Bhagavad Gita defines renunciation at the end of the book, and rules out the version most people assume: nobody with a body puts down action, only the fruit.' AS seo_description,
    1 AS published

  UNION ALL SELECT 14, 637, 1, 'gita-18-14',
    'अधिष्ठानं तथा कर्ता करणं च पृथग्विधम्।\nविविधाश्च पृथक्चेष्टा दैवं चैवात्र पञ्चमम्॥',
    'adhiṣṭhānaṁ tathā kartā karaṇaṁ ca pṛthag-vidham\nvividhāś ca pṛthak ceṣṭā daivaṁ caivātra pañcamam',
    'adhishthanam tatha karta karanam cha prithag-vidham\nvividhash cha prithak cheshta daivam chaivatra panchamam',
    'The seat, the doer, the instruments of various kinds, the various separate efforts, and providence as the fifth.',
    'Five things go into anything that gets done. Where it happens. Who does it. What they do it with. The particular effort they make. And the part nobody arranged.',
    'जो कुछ भी होता है उसमें पाँच चीज़ें लगती हैं। कहाँ हो रहा है। कौन कर रहा है। किससे कर रहा है। जो ख़ास कोशिश उसने की। और वह हिस्सा जो किसी ने जुटाया ही नहीं।',
    'Jo kuch bhi hota hai usme paanch cheezein lagti hain. Kahan ho raha hai. Kaun kar raha hai. Kisse kar raha hai. Jo khaas koshish usne ki. Aur woh hissa jo kisi ne jutaya hi nahi.',
    'A list of five, and you are one of them. Not the list.',
    'पाँच की सूची, और आप उनमें से एक हैं। पूरी सूची नहीं।',
    'Paanch ki list, aur tum unme se ek ho. Poori list nahi.',
    'beginner',
    'Gita 18.14: the five things in every action',
    'The Bhagavad Gita breaks any action into five parts: the setting, the doer, the instruments, the effort, and the part nobody arranged. You are one of five.',
    1

  UNION ALL SELECT 16, 639, 1, 'gita-18-16',
    'तत्रैवं सति कर्तारमात्मानं केवलं तु यः।\nपश्यत्यकृतबुद्धित्वान्न स पश्यति दुर्मतिः॥',
    'tatraivaṁ sati kartāram ātmānaṁ kevalaṁ tu yaḥ\npaśyaty akṛta-buddhitvān na sa paśyati durmatiḥ',
    'tatraivam sati kartaram atmanam kevalam tu yah\npashyaty akrita-buddhitvan na sa pashyati durmatih',
    'That being so, one who through an untrained understanding sees the self alone as the doer does not see, being of poor judgement.',
    'Given all five, anybody who looks at that and sees only himself doing it is not looking carefully. He is not wicked. He is just wrong about what he is seeing.',
    'पाँचों को देखते हुए, जो उधर देखकर सिर्फ़ ख़ुद को करते हुए देखता है, वह ध्यान से नहीं देख रहा। वह बुरा नहीं है। वह बस इस बारे में ग़लत है कि उसे दिख क्या रहा है।',
    'Paanchon ko dekhte hue, jo udhar dekhkar sirf khud ko karte hue dekhta hai, woh dhyan se nahi dekh raha. Woh bura nahi hai. Woh bas is baare mein galat hai ki use dikh kya raha hai.',
    'A claim about eyesight, not about morals. That distinction is the whole verse.',
    'यह नज़र के बारे में दावा है, नैतिकता के बारे में नहीं। पूरा श्लोक इसी फ़र्क़ पर टिका है।',
    'Yeh nazar ke baare mein claim hai, naitikta ke baare mein nahi. Poora shloka isi farq par tika hai.',
    'intermediate',
    'Gita 18.16: seeing yourself as the only one acting',
    'The Bhagavad Gita calls sole authorship a failure of seeing rather than a moral fault. The distinction changes what you can do about it.',
    1

  UNION ALL SELECT 32, 655, 1, 'gita-18-32',
    'अधर्मं धर्ममिति या मन्यते तमसावृता।\nसर्वार्थान्विपरीतांश्च बुद्धिः सा पार्थ तामसी॥',
    'adharmaṁ dharmam iti yā manyate tamasāvṛtā\nsarvārthān viparītāṁś ca buddhiḥ sā pārtha tāmasī',
    'adharmam dharmam iti ya manyate tamasavrita\nsarvarthan viparitamsh cha buddhih sa partha tamasi',
    'That understanding, covered in tamas, which takes what is not dharma to be dharma, and sees all things reversed — that is tāmasī, Partha.',
    'The kind of judgement that has the wrong thing marked as the right one, and gets everything else backwards from there. It is not lying. It is reading the map upside down and following it carefully.',
    'वह समझ जिसमें ग़लत चीज़ पर सही का निशान लगा है, और वहाँ से बाक़ी सब उल्टा हो जाता है। यह झूठ नहीं है। यह नक़्शे को उल्टा पकड़कर ध्यान से उसी पर चलना है।',
    'Woh samajh jisme galat cheez par sahi ka nishan laga hai, aur wahan se baaki sab ulta ho jaata hai. Yeh jhooth nahi hai. Yeh naqshe ko ulta pakadkar dhyan se usi par chalna hai.',
    'Not dishonesty. A map held upside down, and followed with care.',
    'बेईमानी नहीं। उल्टा पकड़ा हुआ नक़्शा, और उस पर ध्यान से चलना।',
    'Beimani nahi. Ulta pakda hua naqsha, aur us par dhyan se chalna.',
    'intermediate',
    'Gita 18.32: reading the map upside down',
    'The Bhagavad Gita describes an understanding that takes wrong for right and works outward consistently from there. It is not dishonesty; it is a reversed map.',
    1

  UNION ALL SELECT 37, 660, 1, 'gita-18-37',
    'यत्तदग्रे विषमिव परिणामेऽमृतोपमम्।\nतत्सुखं सात्त्विकं प्रोक्तमात्मबुद्धिप्रसादजम्॥',
    'yat tad agre viṣam iva pariṇāme ''mṛtopamam\ntat sukhaṁ sāttvikaṁ proktam ātma-buddhi-prasāda-jam',
    'yat tad agre visham iva parinameamritopamam\ntat sukham sattvikam proktam atma-buddhi-prasada-jam',
    'That which is like poison at first and like nectar in its result — that happiness is called sāttvika, born of the clearness of one''s own understanding.',
    'The kind that tastes like poison at the start and like something else entirely by the end. That one comes from your own head clearing, and it is the one worth having.',
    'वह तरह जो शुरू में ज़हर जैसी लगती है और अंत तक कुछ और ही हो जाती है। वह आपके अपने मन के साफ़ होने से आती है, और वही रखने लायक है।',
    'Woh tarah jo shuru mein zeher jaisi lagti hai aur ant tak kuch aur hi ho jaati hai. Woh tumhare apne man ke saaf hone se aati hai, aur wahi rakhne layak hai.',
    'The test is not how it feels now. It is which direction it is moving in.',
    'कसौटी यह नहीं कि अभी कैसा लग रहा है। कसौटी यह है कि वह किस दिशा में जा रहा है।',
    'Kasauti yeh nahi ki abhi kaisa lag raha hai. Kasauti yeh hai ki woh kis disha mein ja raha hai.',
    'beginner',
    'Gita 18.37: poison first, something else by the end',
    'The Bhagavad Gita sorts happiness by direction rather than by feeling. The best kind tastes like poison at the start, and the test is which way it is moving.',
    1

  UNION ALL SELECT 48, 671, 1, 'gita-18-48',
    'सहजं कर्म कौन्तेय सदोषमपि न त्यजेत्।\nसर्वारम्भा हि दोषेण धूमेनाग्निरिवावृताः॥',
    'saha-jaṁ karma kaunteya sa-doṣam api na tyajet\nsarvārambhā hi doṣeṇa dhūmenāgnir ivāvṛtāḥ',
    'saha-jam karma kaunteya sa-dosham api na tyajet\nsarvarambha hi doshena dhumenagnir ivavritah',
    'One should not give up the work born with one, Kaunteya, even though it has fault, for all undertakings are covered by fault as fire is by smoke.',
    'Do not drop the work that came with you just because it has something wrong in it. Everything you could start has something wrong in it, the way every fire has smoke.',
    'जो काम आपके साथ आया है उसे सिर्फ़ इसलिए मत छोड़िए कि उसमें कुछ ख़राबी है। जो भी आप शुरू कर सकते हैं उसमें कुछ ख़राबी है — जैसे हर आग में धुआँ है।',
    'Jo kaam tumhare saath aaya hai use sirf isliye mat chhodo ki usme kuch kharabi hai. Jo bhi tum shuru kar sakte ho usme kuch kharabi hai — jaise har aag mein dhuan hai.',
    'An argument against waiting for a clean option. Not a permit for a dirty one.',
    'साफ़ विकल्प के इंतज़ार के ख़िलाफ़ दलील। गंदे विकल्प की इजाज़त नहीं।',
    'Saaf option ke intezaar ke khilaf dalil. Gande option ki ijazat nahi.',
    'intermediate',
    'Gita 18.48: every fire has smoke',
    'The Bhagavad Gita argues against waiting for a blameless option, since every undertaking carries fault as every fire carries smoke. It is not a permit for harm.',
    1

  UNION ALL SELECT 59, 682, 1, 'gita-18-59',
    'यदहंकारमाश्रित्य न योत्स्य इति मन्यसे।\nमिथ्यैष व्यवसायस्ते प्रकृतिस्त्वां नियोक्ष्यति॥',
    'yad ahaṅkāram āśritya na yotsya iti manyase\nmithyaiṣa vyavasāyas te prakṛtis tvāṁ niyokṣyati',
    'yad ahankaram ashritya na yotsya iti manyase\nmithyaisha vyavasayas te prakritis tvam niyokshyati',
    'If, taking shelter in ego, you think "I shall not fight", this resolve of yours is false; nature will engage you.',
    'If you lean on your own idea of yourself and decide you are not doing this, that decision will not hold. What you are made of will put you back in it.',
    'अगर आप ख़ुद के बारे में अपनी धारणा के सहारे तय कर लें कि आप यह नहीं करेंगे, तो वह फ़ैसला टिकेगा नहीं। आप जिस चीज़ से बने हैं वह आपको फिर उसी में डाल देगी।',
    'Agar tum khud ke baare mein apni dharna ke sahare tay kar lo ki tum yeh nahi karoge, to woh faisla tikega nahi. Tum jis cheez se bane ho woh tumhe phir usi mein daal degi.',
    '3.5 said nobody opts out. This says it to one specific frightened man, by name.',
    '3.5 ने कहा था कि कोई बाहर नहीं हो सकता। यह वही बात एक ख़ास डरे हुए आदमी से, नाम लेकर कहता है।',
    '3.5 ne kaha tha ki koi bahar nahi ho sakta. Yeh wahi baat ek khaas dare hue aadmi se, naam lekar kehta hai.',
    'intermediate',
    'Gita 18.59: the decision that will not hold',
    'The Bhagavad Gita tells Arjuna that a refusal built on his own idea of himself will not survive contact with what he is actually made of.',
    1

  UNION ALL SELECT 63, 686, 1, 'gita-18-63',
    'इति ते ज्ञानमाख्यातं गुह्याद्गुह्यतरं मया।\nविमृश्यैतदशेषेण यथेच्छसि तथा कुरु॥',
    'iti te jñānam ākhyātaṁ guhyād guhyataraṁ mayā\nvimṛśyaitad aśeṣeṇa yathecchasi tathā kuru',
    'iti te jnanam akhyatam guhyad guhyataram maya\nvimrishyaitad asheshena yathechchhasi tatha kuru',
    'Thus knowledge more secret than the secret has been declared to you by me. Having reflected on this completely, do as you wish.',
    'That is all of it, told to you — including the part I do not tell everybody. Now think it through, the whole of it, leaving nothing out. Then do what you want.',
    'बस, यही सब है, आपसे कह दिया — वह हिस्सा भी जो मैं सबको नहीं बताता। अब इसे सोचिए, पूरा का पूरा, कुछ छोड़े बिना। फिर जो आप चाहें वह कीजिए।',
    'Bas, yahi sab hai, tumse keh diya — woh hissa bhi jo main sabko nahi batata. Ab ise socho, poora ka poora, kuch chhode bina. Phir jo tum chaho woh karo.',
    'Seven hundred verses of argument, and then the decision goes back to the person hearing it.',
    'सात सौ श्लोक की दलील, और फिर फ़ैसला सुनने वाले को वापस दे दिया जाता है।',
    'Saat sau shloka ki dalil, aur phir faisla sunne wale ko wapas de diya jaata hai.',
    'beginner',
    'Gita 18.63: think it through, then do as you wish',
    'After seven hundred verses the Bhagavad Gita hands the decision back: reflect on all of it, leaving nothing out, and then do what you want.',
    1

) AS v
JOIN chapters c ON c.chapter_number = 18;

-- =====================================================================
-- EXPLANATIONS
-- =====================================================================
-- 18.63 is the one that cannot be softened. It is the sentence the
-- product's whole stance rests on: a text that ends by handing the
-- decision back can be taught to somebody with no background and no
-- belief without either party pretending. Asserted in smoke-test.sh.
-- =====================================================================

DELETE ve FROM verse_explanations ve JOIN verses v ON v.id = ve.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 18;

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 11 AS vn, 'beginner' AS level,
   'Arjuna opened this chapter by asking for the difference between two words everybody had been using loosely — sannyāsa and tyāga, both usually rendered as renunciation. This is the answer, and it arrives about seven hundred verses after the question first mattered.' AS h_en,
   'अर्जुन ने यह अध्याय दो शब्दों का फ़र्क़ पूछकर शुरू किया था जिन्हें सब ढीले ढंग से इस्तेमाल करते आए थे — संन्यास और त्याग, दोनों का अनुवाद आमतौर पर "त्यागना" होता है। यही जवाब है, और यह उस सवाल के मायने रखने लगने के क़रीब सात सौ श्लोक बाद आता है।' AS h_hi,
   'Arjun ne yeh chapter do shabdon ka farq poochkar shuru kiya tha jinhe sab dheele dhang se istemaal karte aaye the — sannyasa aur tyaga, dono ka anuvaad aam taur par "tyagna" hota hai. Yahi jawab hai, aur yeh us sawaal ke maayne rakhne lagne ke karib saat sau shloka baad aata hai.' AS h_hing,
   'The first half is a flat statement of fact: a body means action, so putting all action down is not on the menu for anybody with one. The second half redefines the word rather than abandoning it. A tyāgī is not somebody who stopped doing things. It is somebody who stopped collecting what the doing earns.' AS p_en,
   'पहला आधा सीधी बात है: शरीर का मतलब है कर्म, इसलिए सारा कर्म रख देना किसी भी शरीर वाले के लिए विकल्प है ही नहीं। दूसरा आधा शब्द को छोड़ता नहीं, उसकी परिभाषा बदल देता है। त्यागी वह नहीं जिसने काम करना बंद कर दिया। वह है जिसने काम से मिलने वाली चीज़ बटोरना बंद कर दिया।' AS p_hi,
   'Pehla aadha seedhi baat hai: sharir ka matlab hai karm, isliye saara karm rakh dena kisi bhi sharir wale ke liye option hai hi nahi. Doosra aadha shabd ko chhodta nahi, uski paribhasha badal deta hai. Tyagi woh nahi jisne kaam karna band kar diya. Woh hai jisne kaam se milne wali cheez batorna band kar diya.' AS p_hing,
   'This is 2.47 finishing its own sentence eleven chapters later, and it is worth noticing what it rules out. Every version of renunciation that involves leaving — the job, the city, the family, the responsibilities — is defined out of the word here, by the text, in the chapter that sums the book up. What is left is harder and available on a Tuesday.' AS m_en,
   'यह 2.47 का अपना वाक्य ग्यारह अध्याय बाद पूरा करना है, और ध्यान देने लायक है कि यह किसे बाहर करता है। त्याग का हर वह रूप जिसमें छोड़कर जाना है — नौकरी, शहर, परिवार, ज़िम्मेदारियाँ — यहाँ इस शब्द से बाहर कर दिया जाता है, ग्रंथ के ही द्वारा, उसी अध्याय में जो पूरी किताब का सार है। जो बचता है वह ज़्यादा कठिन है और किसी भी मंगलवार को उपलब्ध है।' AS m_hi,
   'Yeh 2.47 ka apna vakya gyarah chapter baad poora karna hai, aur dhyan dene layak hai ki yeh kise bahar karta hai. Tyag ka har woh roop jisme chhodkar jaana hai — naukri, shehar, parivar, zimmedariyan — yahan is shabd se bahar kar diya jaata hai, granth ke hi dwara, usi chapter mein jo poori kitaab ka saar hai. Jo bachta hai woh zyada mushkil hai aur kisi bhi Tuesday ko uplabdh hai.' AS m_hing

  UNION ALL SELECT 14, 'beginner',
   'The chapter is in its summarising mode and this is the most structural thing in it: a breakdown of what any action is actually made of. Five components, named flatly, in the order a Sanskrit list takes them.',
   'अध्याय अपनी सार वाली चाल में है और इसमें सबसे ढाँचागत बात यही है: कोई भी कर्म असल में किन चीज़ों से बना है, इसका विभाजन। पाँच हिस्से, सीधे नाम लेकर, उसी क्रम में जिसमें संस्कृत की सूची चलती है।',
   'Chapter apni saar wali chaal mein hai aur isme sabse dhaanchagat baat yahi hai: koi bhi karm asal mein kin cheezon se bana hai, iska vibhajan. Paanch hisse, seedhe naam lekar, usi kram mein jisme Sanskrit ki list chalti hai.',
   'Adhiṣṭhāna, the seat or setting. Kartā, the doer. Karaṇa, whatever the doing is done with. Ceṣṭā, the particular effort made on the day. And daivam — the fifth, and the one with no good English word: the part nobody arranged, whatever you want to call that. Take any hour of your work and all five are in it.',
   'अधिष्ठान, यानी जगह या ज़मीन। कर्ता, यानी करने वाला। करण, यानी जिससे काम किया जा रहा है। चेष्टा, यानी उस दिन की गई ख़ास कोशिश। और दैवम् — पाँचवाँ, और वही जिसका कोई अच्छा अनुवाद नहीं: वह हिस्सा जो किसी ने जुटाया नहीं, आप उसे जो भी नाम दें। अपने काम का कोई भी घंटा लीजिए, पाँचों उसमें हैं।',
   'Adhishthana, yaani jagah ya zameen. Karta, yaani karne wala. Karan, yaani jisse kaam kiya ja raha hai. Cheshta, yaani us din ki gayi khaas koshish. Aur daivam — paanchwa, aur wahi jiska koi achha anuvaad nahi: woh hissa jo kisi ne jutaya nahi, tum use jo bhi naam do. Apne kaam ka koi bhi ghanta lo, paanchon usme hain.',
   'The useful thing here is that it is a list of five and not of one, and that the fifth is left deliberately unnamed in any confident way. You do not have to decide what daivam is — luck, circumstance, God, the weather, other people''s choices — to notice that something in that category was present and that you did not put it there. That noticing is what the next verse is about.',
   'यहाँ काम की बात यह है कि यह पाँच की सूची है, एक की नहीं, और पाँचवें को जानबूझकर किसी भरोसे वाले नाम से नहीं बाँधा गया। दैवम् क्या है — क़िस्मत, हालात, ईश्वर, मौसम, दूसरों के चुनाव — यह तय किए बिना भी आप देख सकते हैं कि उस श्रेणी की कोई चीज़ मौजूद थी और वह आपने नहीं रखी थी। अगला श्लोक इसी देखने के बारे में है।',
   'Yahan kaam ki baat yeh hai ki yeh paanch ki list hai, ek ki nahi, aur paanchwe ko jaanboojhkar kisi bharose wale naam se nahi baandha gaya. Daivam kya hai — kismat, haalat, ishwar, mausam, doosron ke chunav — yeh tay kiye bina bhi tum dekh sakte ho ki us shreni ki koi cheez maujood thi aur woh tumne nahi rakhi thi. Agla shloka isi dekhne ke baare mein hai.'

  UNION ALL SELECT 16, 'intermediate',
   'This follows immediately from the list of five, and the connecting words matter: tatra evaṁ sati — that being so. It is presented as a conclusion drawn from the previous verse rather than as a fresh claim.',
   'यह पाँच की सूची के ठीक बाद आता है, और जोड़ने वाले शब्द मायने रखते हैं: तत्र एवं सति — यानी ऐसा होते हुए। इसे पिछले श्लोक से निकाला गया निष्कर्ष बताया गया है, कोई नया दावा नहीं।',
   'Yeh paanch ki list ke theek baad aata hai, aur jodne wale shabd maayne rakhte hain: tatra evam sati — yaani aisa hote hue. Ise pichhle shloka se nikala gaya nishkarsh bataya gaya hai, koi naya dawa nahi.',
   'The word doing the work is akṛta-buddhitvāt — from an untrained or unfinished understanding. The verse is not calling anybody bad. It is saying they are looking at a scene with five things in it and reporting one, which is a mistake of the same kind as misreading a gauge. Durmati is harsher in tone, but the reason given is entirely about the seeing.',
   'काम कर रहा शब्द है अकृतबुद्धित्वात् — यानी बिना गढ़ी या अधूरी समझ से। श्लोक किसी को बुरा नहीं कह रहा। वह कह रहा है कि वे ऐसे दृश्य को देख रहे हैं जिसमें पाँच चीज़ें हैं और एक बता रहे हैं — यह वैसी ही ग़लती है जैसे कोई मीटर ग़लत पढ़ ले। दुर्मति लहजे में सख़्त है, पर दी गई वजह पूरी तरह देखने के बारे में है।',
   'Kaam kar raha shabd hai akrita-buddhitvat — yaani bina gadhi ya adhoori samajh se. Shloka kisi ko bura nahi keh raha. Woh keh raha hai ki woh aise drishya ko dekh rahe hain jisme paanch cheezein hain aur ek bata rahe hain — yeh waisi hi galti hai jaise koi meter galat padh le. Durmati lehje mein sakht hai, par di gayi wajah poori tarah dekhne ke baare mein hai.',
   'Calling this a seeing problem rather than a moral one changes what can be done about it, which is the practical value of the distinction. You cannot argue somebody out of a character flaw and you can walk them through a scene. Take a success and list the five; take a failure and list the five. The second is much harder, and the difficulty itself is informative.',
   'इसे नैतिक नहीं, देखने की समस्या कहना यह बदल देता है कि इस पर किया क्या जा सकता है — और यही इस फ़र्क़ की काम की क़ीमत है। किसी को बहस से उसके चरित्र की ख़ामी से बाहर नहीं निकाला जा सकता, पर उसे किसी दृश्य में साथ लेकर चला जा सकता है। एक सफलता लीजिए और पाँचों गिनिए; एक असफलता लीजिए और पाँचों गिनिए। दूसरा कहीं ज़्यादा कठिन है, और वह कठिनाई अपने आप में बताती है।',
   'Ise naitik nahi, dekhne ki samasya kehna yeh badal deta hai ki is par kiya kya ja sakta hai — aur yahi is farq ki kaam ki keemat hai. Kisi ko behes se uske charitra ki khami se bahar nahi nikala ja sakta, par use kisi drishya mein saath lekar chala ja sakta hai. Ek safalta lo aur paanchon gino; ek asafalta lo aur paanchon gino. Doosra kahin zyada mushkil hai, aur woh mushkil apne aap mein batati hai.'

  UNION ALL SELECT 32, 'intermediate',
   'The chapter is sorting things into threes — action, doer, understanding, resolve, happiness — and this is the third and last of the buddhi set, after one that sees clearly and one that gets the proportions wrong.',
   'अध्याय चीज़ों को तीन-तीन में बाँट रहा है — कर्म, कर्ता, बुद्धि, धृति, सुख — और यह बुद्धि वाले समूह का तीसरा और आख़िरी है, उस एक के बाद जो साफ़ देखती है और उस एक के बाद जो अनुपात ग़लत लगाती है।',
   'Chapter cheezon ko teen-teen mein baant raha hai — karm, karta, buddhi, dhriti, sukh — aur yeh buddhi wale samuh ka teesra aur aakhiri hai, us ek ke baad jo saaf dekhti hai aur us ek ke baad jo anupat galat lagati hai.',
   'The phrase to sit with is sarvārthān viparītān — everything reversed. It is not describing somebody who does not care about right and wrong. It is describing somebody who cares a great deal and has the labels swapped, and who therefore works outward from the swap with complete consistency. That consistency is why it is so hard to spot from inside.',
   'ठहरने लायक वाक्यांश है सर्वार्थान् विपरीतान् — यानी सब कुछ उल्टा। यह उस व्यक्ति का वर्णन नहीं है जिसे सही-ग़लत की परवाह नहीं। यह उस व्यक्ति का है जिसे बहुत परवाह है और जिसके लेबल आपस में बदल गए हैं, और जो इसलिए उस अदला-बदली से पूरी संगति के साथ आगे बढ़ता है। वही संगति है जिसकी वजह से इसे भीतर से पकड़ना इतना कठिन है।',
   'Thehrne layak vakyansh hai sarvarthan viparitan — yaani sab kuch ulta. Yeh us insaan ka varnan nahi hai jise sahi-galat ki parwah nahi. Yeh us insaan ka hai jise bahut parwah hai aur jiske label aapas mein badal gaye hain, aur jo isliye us adla-badli se poori sangati ke saath aage badhta hai. Wahi sangati hai jiski wajah se ise bheetar se pakadna itna mushkil hai.',
   'This verse belongs to the same family as chapter 16 and attracts the same misuse, so the same thing has to be said. It is a description of a state a mind can be in, not a category of person and certainly not of a group — and the one thing everybody in that state has in common is that they are sure they are not in it. Which means the only honest use of the verse is on yourself, and the only honest method is asking somebody else.',
   'यह श्लोक सोलहवें अध्याय के ही परिवार का है और उसी दुरुपयोग को खींचता है, इसलिए वही बात कहनी पड़ेगी। यह उस अवस्था का वर्णन है जिसमें कोई मन हो सकता है, न कि किसी तरह के व्यक्ति का, और किसी समूह का तो बिलकुल नहीं — और उस अवस्था में मौजूद सब लोगों में एक बात समान है कि उन्हें यक़ीन है कि वे उसमें नहीं हैं। इसका मतलब यह हुआ कि इस श्लोक का ईमानदार इस्तेमाल सिर्फ़ ख़ुद पर है, और ईमानदार तरीक़ा सिर्फ़ किसी और से पूछना है।',
   'Yeh shloka solahwe chapter ke hi parivar ka hai aur usi durupyog ko kheenchta hai, isliye wahi baat kehni padegi. Yeh us avastha ka varnan hai jisme koi man ho sakta hai, na ki kisi tarah ke insaan ka, aur kisi samuh ka to bilkul nahi — aur us avastha mein maujood sab logon mein ek baat samaan hai ki unhe yakeen hai ki woh usme nahi hain. Iska matlab yeh hua ki is shloka ka imaandar istemaal sirf khud par hai, aur imaandar tareeka sirf kisi aur se poochna hai.'

  UNION ALL SELECT 37, 'beginner',
   'Three kinds of happiness are being sorted, and this is the first. The sorting is not by how much or by what causes it — it is by which direction the thing moves in over time, which is an unusual axis and the reason these verses are still useful.',
   'तीन तरह के सुख छाँटे जा रहे हैं, और यह पहला है। छँटाई इस आधार पर नहीं है कि कितना है या किससे आता है — यह इस आधार पर है कि समय के साथ वह चीज़ किस दिशा में जाती है, जो एक असामान्य कसौटी है और यही वजह है कि ये श्लोक आज भी काम के हैं।',
   'Teen tarah ke sukh chhaante ja rahe hain, aur yeh pehla hai. Chhantai is aadhar par nahi hai ki kitna hai ya kisse aata hai — yeh is aadhar par hai ki samay ke saath woh cheez kis disha mein jaati hai, jo ek asamanya kasauti hai aur yahi wajah hai ki yeh shloka aaj bhi kaam ke hain.',
   'Poison at the start, something quite different at the end. The next verse describes the reverse — pleasant first, unpleasant afterwards — and between them they give you a test you can actually apply: not "is this good" but "which way is this heading". The last phrase says where the good kind comes from: ātma-buddhi-prasāda, your own understanding settling. Not from the thing itself.',
   'शुरू में ज़हर, अंत में कुछ बिलकुल और। अगला श्लोक उल्टा बताता है — पहले सुखद, बाद में नहीं — और दोनों मिलकर ऐसी कसौटी देते हैं जिसे सचमुच लगाया जा सकता है: "यह अच्छा है क्या" नहीं, बल्कि "यह किस तरफ़ जा रहा है"। आख़िरी वाक्यांश बताता है कि अच्छी वाली आती कहाँ से है: आत्मबुद्धिप्रसाद, यानी आपकी अपनी समझ का बैठ जाना। उस चीज़ से नहीं।',
   'Shuru mein zeher, ant mein kuch bilkul aur. Agla shloka ulta batata hai — pehle sukhad, baad mein nahi — aur dono milkar aisi kasauti dete hain jise sach mein lagaya ja sakta hai: "yeh achha hai kya" nahi, balki "yeh kis taraf ja raha hai". Aakhiri vakyansh batata hai ki achhi wali aati kahan se hai: atma-buddhi-prasad, yaani tumhari apni samajh ka baith jaana. Us cheez se nahi.',
   'Almost everything worth having is described by this verse and almost nothing is chosen by it, because the choosing happens at the moment when one option tastes like poison and the other does not. Learning an instrument, a hard conversation, exercise, most of the good parts of a long relationship — all of them fail the taste test on the day and pass on the year. The verse is not asking for endurance for its own sake. It is pointing out that the day is the wrong unit.',
   'रखने लायक लगभग हर चीज़ का वर्णन यह श्लोक करता है और चुनी लगभग कोई नहीं जाती, क्योंकि चुनाव उसी क्षण होता है जब एक विकल्प ज़हर जैसा लगता है और दूसरा नहीं। कोई वाद्य सीखना, कोई कठिन बातचीत, व्यायाम, किसी लंबे रिश्ते के ज़्यादातर अच्छे हिस्से — सब उस दिन की कसौटी पर गिरते हैं और साल की कसौटी पर पास होते हैं। श्लोक सहने के लिए सहना नहीं माँग रहा। वह बता रहा है कि "दिन" ग़लत इकाई है।',
   'Rakhne layak lagbhag har cheez ka varnan yeh shloka karta hai aur chuni lagbhag koi nahi jaati, kyunki chunav usi pal hota hai jab ek option zeher jaisa lagta hai aur doosra nahi. Koi instrument seekhna, koi mushkil baat, exercise, kisi lambe rishte ke zyadatar achhe hisse — sab us din ki kasauti par girte hain aur saal ki kasauti par pass hote hain. Shloka sehne ke liye sehna nahi maang raha. Woh bata raha hai ki "din" galat unit hai.'

  UNION ALL SELECT 48, 'intermediate',
   'Late in the chapter, and addressed to somebody who has spent the whole book looking for the clean option. Arjuna''s original objection was that both available courses were terrible, which was true and remains true.',
   'अध्याय के अंत के पास, और उस व्यक्ति से कहा गया जिसने पूरी किताब साफ़ विकल्प ढूँढ़ने में बिताई है। अर्जुन की मूल आपत्ति यही थी कि दोनों उपलब्ध रास्ते भयानक हैं, जो सच था और आज भी सच है।',
   'Chapter ke ant ke paas, aur us insaan se kaha gaya jisne poori kitaab saaf option dhoondhne mein bitayi hai. Arjun ki mool aapatti yahi thi ki dono uplabdh raste bhayanak hain, jo sach tha aur aaj bhi sach hai.',
   'The image is exact and worth keeping: fire and smoke are not two things, one of which could be removed. Smoke is what fire does. The verse is saying that fault is not a sign you picked the wrong undertaking; it is a property of undertakings. Which means "this has something wrong in it" cannot by itself be a reason to stop, because it will be true of the next one too.',
   'तस्वीर सटीक है और रखने लायक: आग और धुआँ दो चीज़ें नहीं हैं जिनमें से एक हटाई जा सके। धुआँ वही है जो आग करती है। श्लोक कह रहा है कि दोष इस बात की निशानी नहीं है कि आपने ग़लत काम चुना; दोष कामों का गुण है। इसका मतलब यह हुआ कि "इसमें कुछ ख़राबी है" अपने आप में रुकने की वजह नहीं हो सकती, क्योंकि यह अगले के बारे में भी सच होगी।',
   'Tasveer sateek hai aur rakhne layak: aag aur dhuan do cheezein nahi hain jinme se ek hatayi ja sake. Dhuan wahi hai jo aag karti hai. Shloka keh raha hai ki dosh is baat ki nishani nahi hai ki tumne galat kaam chuna; dosh kaamon ka gun hai. Iska matlab yeh hua ki "isme kuch kharabi hai" apne aap mein rukne ki wajah nahi ho sakti, kyunki yeh agle ke baare mein bhi sach hogi.',
   'This verse is one comma away from becoming an excuse, so it is worth being exact about what it licenses. It says: do not wait for a blameless option, because there is not one. It does not say: therefore any amount of harm is acceptable. The difference is that the first is an argument against paralysis and the second is a permit, and the chapter that contains this verse also contains a great deal about what the fault in a given undertaking actually is and what it costs. Somebody using this line to avoid looking at the smoke has stopped reading a verse too early.',
   'यह श्लोक बहाना बनने से एक अल्पविराम भर दूर है, इसलिए साफ़ कहना ज़रूरी है कि यह किसकी इजाज़त देता है। यह कहता है: बेदाग़ विकल्प का इंतज़ार मत कीजिए, क्योंकि ऐसा कोई है ही नहीं। यह यह नहीं कहता: इसलिए कितना भी नुक़सान चलेगा। फ़र्क़ यह है कि पहला जड़ता के ख़िलाफ़ दलील है और दूसरा इजाज़तनामा — और जिस अध्याय में यह श्लोक है उसी में यह भी बहुत कुछ है कि किसी काम में दोष असल में क्या है और उसकी क़ीमत क्या है। जो इस पंक्ति का इस्तेमाल धुएँ की तरफ़ न देखने के लिए कर रहा है, उसने एक श्लोक पहले पढ़ना बंद कर दिया है।',
   'Yeh shloka bahana banne se ek comma bhar door hai, isliye saaf kehna zaroori hai ki yeh kiski ijazat deta hai. Yeh kehta hai: bedaag option ka intezaar mat karo, kyunki aisa koi hai hi nahi. Yeh yeh nahi kehta: isliye kitna bhi nuksaan chalega. Farq yeh hai ki pehla jadta ke khilaf dalil hai aur doosra ijazatnama — aur jis chapter mein yeh shloka hai usi mein yeh bhi bahut kuch hai ki kisi kaam mein dosh asal mein kya hai aur uski keemat kya hai. Jo is line ka istemaal dhuen ki taraf na dekhne ke liye kar raha hai, usne ek shloka pehle padhna band kar diya hai.'

  UNION ALL SELECT 59, 'intermediate',
   'Almost the end. Arjuna''s original position — I will not do this — is picked up again by name and answered directly, and the answer is not moral pressure. It is a prediction.',
   'लगभग अंत। अर्जुन की मूल स्थिति — मैं यह नहीं करूँगा — फिर से नाम लेकर उठाई जाती है और सीधे जवाब दी जाती है, और वह जवाब नैतिक दबाव नहीं है। वह एक भविष्यवाणी है।',
   'Lagbhag ant. Arjun ki mool sthiti — main yeh nahi karunga — phir se naam lekar uthayi jaati hai aur seedhe jawab di jaati hai, aur woh jawab naitik dabav nahi hai. Woh ek bhavishyavani hai.',
   'The specific thing being called false is a resolve that rests on ahaṅkāra — on a picture of yourself. Not the refusal; the foundation under it. And the reason given is mechanical: prakṛti will put you back in it. What you are actually made of has more votes than what you have decided you are.',
   'जिसे ख़ास तौर पर झूठा कहा जा रहा है वह ऐसा संकल्प है जो अहंकार पर टिका है — यानी अपनी ही एक तस्वीर पर। इनकार पर नहीं; उसके नीचे की नींव पर। और जो वजह दी गई है वह यांत्रिक है: प्रकृति आपको फिर उसी में डाल देगी। आप असल में जिस चीज़ से बने हैं, उसके वोट उससे ज़्यादा हैं जो आपने तय कर रखा है कि आप हैं।',
   'Jise khaas taur par jhootha kaha ja raha hai woh aisa sankalp hai jo ahankaar par tika hai — yaani apni hi ek tasveer par. Inkaar par nahi; uske neeche ki neenv par. Aur jo wajah di gayi hai woh yantrik hai: prakriti tumhe phir usi mein daal degi. Tum asal mein jis cheez se bane ho, uske vote usse zyada hain jo tumne tay kar rakha hai ki tum ho.',
   'This is 3.5 arriving at a person instead of a principle, and the change of address is the interesting part. It is easy to accept in general that nobody opts out. It is a different experience to be told that this particular refusal, the one you are currently holding, is not going to survive the week. Most people have a version of this: the thing they announced they would never do again, and did, on a Thursday, for reasons that seemed sufficient.',
   'यह 3.5 है जो सिद्धांत की जगह एक व्यक्ति तक पहुँचता है, और पते का यह बदलना ही दिलचस्प हिस्सा है। आम तौर पर यह मान लेना आसान है कि कोई बाहर नहीं हो सकता। यह सुनना अलग अनुभव है कि यही ख़ास इनकार, जो आपने अभी थाम रखा है, हफ़्ता भी नहीं निकालेगा। ज़्यादातर लोगों के पास इसका अपना रूप है: वह चीज़ जिसके बारे में उन्होंने ऐलान किया था कि दोबारा कभी नहीं, और जो उन्होंने किसी गुरुवार को कर ली, ऐसी वजहों से जो काफ़ी लगीं।',
   'Yeh 3.5 hai jo siddhant ki jagah ek insaan tak pahunchta hai, aur pate ka yeh badalna hi dilchasp hissa hai. Aam taur par yeh maan lena aasan hai ki koi bahar nahi ho sakta. Yeh sunna alag anubhav hai ki yahi khaas inkaar, jo tumne abhi thaam rakha hai, hafta bhi nahi nikalega. Zyadatar logon ke paas iska apna roop hai: woh cheez jiske baare mein unhone elaan kiya tha ki dobara kabhi nahi, aur jo unhone kisi Thursday ko kar li, aisi wajahon se jo kaafi lagin.'

  UNION ALL SELECT 63, 'beginner',
   'Seven hundred verses. Two armies still standing where they were. A man who asked for advice at the start of the day and has been given rather more than that. And then this, which is the last thing said before the closing exchange.',
   'सात सौ श्लोक। दो सेनाएँ अब भी वहीं खड़ी हैं जहाँ थीं। एक आदमी जिसने दिन की शुरुआत में सलाह माँगी थी और जिसे उससे कहीं ज़्यादा मिल चुका है। और फिर यह, जो अंतिम बातचीत से पहले कही गई आख़िरी बात है।',
   'Saat sau shloka. Do senaayein ab bhi wahin khadi hain jahan thin. Ek aadmi jisne din ki shuruaat mein salah maangi thi aur jise usse kahin zyada mil chuka hai. Aur phir yeh, jo antim baatchit se pehle kahi gayi aakhiri baat hai.',
   'Three moves in one line. First: that is all of it, including the part not told to everybody. Second: vimṛśya aśeṣeṇa — think it over completely, leaving nothing out, which is an instruction to examine rather than to accept. Third: yathecchasi tathā kuru. As you wish, so do. Not obey, not follow, not surrender. Do what you want.',
   'एक ही पंक्ति में तीन चालें। पहली: यही सब है, वह हिस्सा भी जो सबको नहीं बताया जाता। दूसरी: विमृश्य अशेषेण — पूरा सोचिए, कुछ छोड़े बिना, जो मानने की नहीं, जाँचने की हिदायत है। तीसरी: यथेच्छसि तथा कुरु। जैसा आप चाहें, वैसा कीजिए। मानिए नहीं, चलिए नहीं, समर्पण नहीं। जो आप चाहते हैं वह कीजिए।',
   'Ek hi line mein teen chaalein. Pehli: yahi sab hai, woh hissa bhi jo sabko nahi bataya jaata. Doosri: vimrishya asheshena — poora socho, kuch chhode bina, jo maanne ki nahi, jaanchne ki hidayat hai. Teesri: yathechchhasi tatha kuru. Jaisa tum chaho, waisa karo. Maano nahi, chalo nahi, samarpan nahi. Jo tum chahte ho woh karo.',
   'This is the sentence this whole product rests on, so it is worth saying plainly. A text that spends seven hundred verses arguing and then hands the decision back can be read by somebody with no background, no Sanskrit and no belief without either side pretending anything. Nobody has to accept the metaphysics to use the psychology. Nobody has to convert to be allowed in. The permission is not a modern accommodation invented to make the book palatable — it is in the book, in the summarising chapter, in the speaker''s own mouth, immediately after the most sustained argument he makes. Every disagreement a reader has with any page of this product is one the text has already licensed.',
   'यही वह वाक्य है जिस पर यह पूरा उत्पाद टिका है, इसलिए इसे साफ़ कहना ज़रूरी है। जो ग्रंथ सात सौ श्लोक दलील देकर फिर फ़ैसला वापस सौंप देता है, उसे बिना किसी पृष्ठभूमि, बिना संस्कृत और बिना किसी मान्यता के पढ़ा जा सकता है — और दोनों में से किसी को कुछ भी बहाना नहीं करना पड़ता। मनोविज्ञान इस्तेमाल करने के लिए तत्त्वज्ञान मानना ज़रूरी नहीं। भीतर आने के लिए बदलना ज़रूरी नहीं। यह इजाज़त किताब को स्वीकार्य बनाने के लिए गढ़ी गई कोई आधुनिक रियायत नहीं है — यह किताब में है, सार वाले अध्याय में, वक्ता के अपने मुँह से, अपनी सबसे लंबी दलील के ठीक बाद। इस उत्पाद के किसी भी पन्ने से पाठक की जो भी असहमति हो, वह ग्रंथ पहले ही मंज़ूर कर चुका है।',
   'Yahi woh vakya hai jis par yeh poora product tika hai, isliye ise saaf kehna zaroori hai. Jo granth saat sau shloka dalil dekar phir faisla wapas saunp deta hai, use bina kisi background, bina Sanskrit aur bina kisi maanyata ke padha ja sakta hai — aur dono mein se kisi ko kuch bhi bahana nahi karna padta. Manovigyan istemaal karne ke liye tattvagyan maanna zaroori nahi. Bheetar aane ke liye badalna zaroori nahi. Yeh ijazat kitaab ko sweekarya banane ke liye gadhi gayi koi aadhunik riyayat nahi hai — yeh kitaab mein hai, saar wale chapter mein, vakta ke apne muh se, apni sabse lambi dalil ke theek baad. Is product ke kisi bhi panne se padhne wale ki jo bhi asahmati ho, woh granth pehle hi manzoor kar chuka hai.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 18;

-- =====================================================================
-- 3. HOOKS, REFLECTIONS, PRACTICES, TOPICS
-- =====================================================================

DELETE m FROM verse_memory_aids m JOIN verses v ON v.id = m.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 18;
DELETE r FROM verse_reflections r JOIN verses v ON v.id = r.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 18;
DELETE p FROM verse_practices p JOIN verses v ON v.id = p.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 18;
DELETE vt FROM verse_topics vt JOIN verses v ON v.id = vt.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 18;

INSERT INTO verse_memory_aids (verse_id, hook_en, hook_hi, hook_hinglish, analogy_en, analogy_hi, analogy_hinglish, visual_cue)
SELECT v.id, m.h_en, m.h_hi, m.h_hing, m.a_en, m.a_hi, m.a_hing, m.cue FROM (
  SELECT 11 AS vn,
  'Giving up does not mean leaving. It means not collecting.' AS h_en,
  'त्याग का मतलब छोड़कर जाना नहीं है। मतलब है बटोरना नहीं।' AS h_hi,
  'Tyag ka matlab chhodkar jaana nahi hai. Matlab hai batorna nahi.' AS h_hing,
  'Like a waiter carrying plates. Putting the plates down is not the job; letting go of the tip is.' AS a_en,
  'प्लेटें ले जाते वेटर जैसा। प्लेटें रख देना काम नहीं है; टिप छोड़ देना है।' AS a_hi,
  'Platein le jaate waiter jaisa. Platein rakh dena kaam nahi hai; tip chhod dena hai.' AS a_hing,
  'Full hands, open palm' AS cue

  UNION ALL SELECT 14,
  'Five things go into anything you do. You are one of five.',
  'जो कुछ आप करते हैं उसमें पाँच चीज़ें लगती हैं। आप उनमें से एक हैं।',
  'Jo kuch tum karte ho usme paanch cheezein lagti hain. Tum unme se ek ho.',
  'Like a photograph. The light, the lens, the moment, the hand, and whatever walked into frame.',
  'तस्वीर जैसा। रोशनी, लेंस, वह पल, हाथ, और जो भी फ़्रेम में चला आया।',
  'Tasveer jaisa. Roshni, lens, woh pal, haath, aur jo bhi frame mein chala aaya.',
  'Five overlapping circles, one of them small'

  UNION ALL SELECT 16,
  'Not a moral failing. A failure to count.',
  'नैतिक ख़ामी नहीं। गिनने की चूक।',
  'Naitik khami nahi. Ginne ki chook.',
  'Like misreading a gauge. You can be honest, careful, and wrong.',
  'मीटर ग़लत पढ़ने जैसा। आप ईमानदार, सावधान, और फिर भी ग़लत हो सकते हैं।',
  'Meter galat padhne jaisa. Tum imaandar, savdhan, aur phir bhi galat ho sakte ho.',
  'A dial with the needle between two numbers'

  UNION ALL SELECT 32,
  'Not dishonesty. A map held upside down and followed carefully.',
  'बेईमानी नहीं। उल्टा पकड़ा नक़्शा, और उस पर ध्यान से चलना।',
  'Beimani nahi. Ulta pakda naqsha, aur us par dhyan se chalna.',
  'Like a confident wrong turn. The confidence is what makes it expensive.',
  'भरोसे के साथ लिए ग़लत मोड़ जैसा। भरोसा ही उसे महँगा बनाता है।',
  'Bharose ke saath liye galat mod jaisa. Bharosa hi use mehnga banata hai.',
  'A map, north arrow pointing down'

  UNION ALL SELECT 37,
  'Poison first, something else by the end. The test is direction, not taste.',
  'पहले ज़हर, अंत तक कुछ और। कसौटी दिशा है, स्वाद नहीं।',
  'Pehle zeher, ant tak kuch aur. Kasauti disha hai, swaad nahi.',
  'Like the first two weeks of any instrument. Nobody enjoys them and nobody skips them.',
  'किसी भी वाद्य के पहले दो हफ़्तों जैसा। किसी को अच्छे नहीं लगते और कोई छोड़ भी नहीं सकता।',
  'Kisi bhi instrument ke pehle do hafton jaisa. Kisi ko achhe nahi lagte aur koi chhod bhi nahi sakta.',
  'Two cups, one steaming, one not'

  UNION ALL SELECT 48,
  'Every fire has smoke. Waiting for a clean one is how you stay cold.',
  'हर आग में धुआँ है। साफ़ आग का इंतज़ार करने से आप ठंडे ही बैठे रहते हैं।',
  'Har aag mein dhuan hai. Saaf aag ka intezaar karne se tum thande hi baithe rehte ho.',
  'Like waiting for a job with no bad part. There is one, and somebody else is doing it.',
  'ऐसी नौकरी के इंतज़ार जैसा जिसमें कोई बुरा हिस्सा न हो। ऐसी एक है, और उसे कोई और कर रहा है।',
  'Aisi naukri ke intezaar jaisa jisme koi bura hissa na ho. Aisi ek hai, aur use koi aur kar raha hai.',
  'A fire, and smoke, in the same frame'

  UNION ALL SELECT 59,
  'The refusal that rests on your idea of yourself will not hold the week.',
  'जो इनकार आपकी अपनी तस्वीर पर टिका है, वह हफ़्ता भी नहीं निकालेगा।',
  'Jo inkaar tumhari apni tasveer par tika hai, woh hafta bhi nahi nikalega.',
  'Like swearing off something at midnight. The person who swore is not the one who wakes up.',
  'आधी रात को कुछ छोड़ देने की क़सम जैसा। क़सम खाने वाला वह नहीं है जो सुबह उठता है।',
  'Aadhi raat ko kuch chhod dene ki kasam jaisa. Kasam khane wala woh nahi hai jo subah uthta hai.',
  'A written note, and a morning'

  UNION ALL SELECT 63,
  'Think it through completely. Then do what you want. That is how it ends.',
  'पूरा सोच लीजिए। फिर जो चाहें कीजिए। अंत ऐसे होता है।',
  'Poora soch lo. Phir jo chaho karo. Ant aise hota hai.',
  'Like a good teacher''s last day. The point was never that you agree.',
  'किसी अच्छे शिक्षक के आख़िरी दिन जैसा। बात कभी यह थी ही नहीं कि आप सहमत हों।',
  'Kisi achhe teacher ke aakhiri din jaisa. Baat kabhi yeh thi hi nahi ki tum sehmat ho.',
  'An open hand, nothing in it'
) AS m
JOIN verses v ON v.verse_number = m.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 18;

INSERT INTO verse_reflections (verse_id, question_en, question_hi, question_hinglish, display_order)
SELECT v.id, r.q_en, r.q_hi, r.q_hing, r.ord FROM (
  SELECT 11 AS vn, 'What have you imagined leaving? What would you actually be putting down?' AS q_en, 'आपने क्या छोड़ने की कल्पना की है? असल में आप क्या रख रहे होते?' AS q_hi, 'Tumne kya chhodne ki kalpana ki hai? Asal mein tum kya rakh rahe hote?' AS q_hing, 1 AS ord
  UNION ALL SELECT 11, 'Which of your work would you still do if the credit went to somebody else?', 'आपका कौन-सा काम आप तब भी करते अगर श्रेय किसी और को जाता?', 'Tumhara kaun sa kaam tum tab bhi karte agar credit kisi aur ko jaata?', 2
  UNION ALL SELECT 11, 'Is there something you call renunciation that is actually avoidance?', 'क्या कुछ ऐसा है जिसे आप त्याग कहते हैं और जो असल में टालना है?', 'Kya kuch aisa hai jise tum tyag kehte ho aur jo asal mein taalna hai?', 3
  UNION ALL SELECT 14, 'Take something you did well last month. Name all five.', 'पिछले महीने का कोई काम लीजिए जो अच्छा हुआ। पाँचों गिनाइए।', 'Pichhle mahine ka koi kaam lo jo achha hua. Paanchon ginao.', 1
  UNION ALL SELECT 14, 'Now take something that went badly. Which of the five is hardest to see?', 'अब कोई काम लीजिए जो बिगड़ा। पाँचों में से कौन-सा देखना सबसे कठिन है?', 'Ab koi kaam lo jo bigda. Paanchon mein se kaun sa dekhna sabse mushkil hai?', 2
  UNION ALL SELECT 14, 'What do you call the fifth one — the part nobody arranged?', 'पाँचवें को आप क्या कहते हैं — वह हिस्सा जो किसी ने जुटाया नहीं?', 'Paanchwe ko tum kya kehte ho — woh hissa jo kisi ne jutaya nahi?', 3
  UNION ALL SELECT 16, 'What are you the sole author of? Check the claim against the five.', 'आप किसके इकलौते कर्ता हैं? इस दावे को पाँचों के सामने रखकर देखिए।', 'Tum kiske iklaute karta ho? Is dawe ko paanchon ke saamne rakhkar dekho.', 1
  UNION ALL SELECT 16, 'Is it easier to count the five for a success or a failure? What does that say?', 'सफलता के लिए पाँचों गिनना आसान है या असफलता के लिए? इससे क्या पता चलता है?', 'Safalta ke liye paanchon ginna asaan hai ya asafalta ke liye? Isse kya pata chalta hai?', 2
  UNION ALL SELECT 16, 'If this is a seeing problem rather than a moral one, what would you do differently?', 'अगर यह नैतिक नहीं, देखने की समस्या है, तो आप क्या अलग करेंगे?', 'Agar yeh naitik nahi, dekhne ki samasya hai, to tum kya alag karoge?', 3
  UNION ALL SELECT 32, 'Where might your labels be swapped? How would you ever find out?', 'आपके लेबल कहाँ आपस में बदले हो सकते हैं? आपको यह पता कैसे चलेगा?', 'Tumhare label kahan aapas mein badle ho sakte hain? Tumhe yeh pata kaise chalega?', 1
  UNION ALL SELECT 32, 'When were you last confidently wrong for a long time? What ended it?', 'पिछली बार आप लंबे समय तक भरोसे के साथ ग़लत कब थे? उसे ख़त्म किसने किया?', 'Pichhli baar tum lambe samay tak bharose ke saath galat kab the? Use khatam kisne kiya?', 2
  UNION ALL SELECT 32, 'Who is allowed to tell you that you have something backwards?', 'आपको यह बताने की इजाज़त किसे है कि आपकी कोई बात उल्टी है?', 'Tumhe yeh batane ki ijazat kise hai ki tumhari koi baat ulti hai?', 3
  UNION ALL SELECT 37, 'Name something in your life that was poison at first. Was it worth it?', 'अपने जीवन की कोई चीज़ बताइए जो शुरू में ज़हर थी। क्या वह इस लायक थी?', 'Apne jeevan ki koi cheez batao jo shuru mein zeher thi. Kya woh is layak thi?', 1
  UNION ALL SELECT 37, 'What are you avoiding right now that would pass the year-test?', 'अभी आप किससे बच रहे हैं जो साल की कसौटी पर पास हो जाती?', 'Abhi tum kisse bach rahe ho jo saal ki kasauti par pass ho jaati?', 2
  UNION ALL SELECT 37, 'What tastes good today and is heading somewhere you would not choose?', 'क्या आज अच्छा लगता है और ऐसी जगह जा रहा है जिसे आप चुनते नहीं?', 'Kya aaj achha lagta hai aur aisi jagah ja raha hai jise tum chunte nahi?', 3
  UNION ALL SELECT 48, 'What have you not started because you could see what was wrong with it?', 'आपने क्या शुरू नहीं किया क्योंकि आपको उसमें ख़राबी दिख रही थी?', 'Tumne kya shuru nahi kiya kyunki tumhe usme kharabi dikh rahi thi?', 1
  UNION ALL SELECT 48, 'What is the smoke in the work you already do? Have you looked at it directly?', 'जो काम आप कर ही रहे हैं उसमें धुआँ क्या है? क्या आपने उसे सीधे देखा है?', 'Jo kaam tum kar hi rahe ho usme dhuan kya hai? Kya tumne use seedhe dekha hai?', 2
  UNION ALL SELECT 48, 'Is there a place you use this verse to avoid looking at something?', 'क्या कोई जगह है जहाँ आप इस श्लोक से किसी चीज़ की तरफ़ देखने से बचते हैं?', 'Kya koi jagah hai jahan tum is shloka se kisi cheez ki taraf dekhne se bachte ho?', 3
  UNION ALL SELECT 59, 'What have you announced you will never do again? How did that go?', 'आपने किस बारे में ऐलान किया था कि दोबारा कभी नहीं? उसका क्या हुआ?', 'Tumne kis baare mein elaan kiya tha ki dobara kabhi nahi? Uska kya hua?', 1
  UNION ALL SELECT 59, 'What are you refusing right now, and what is the refusal resting on?', 'अभी आप किससे इनकार कर रहे हैं, और वह इनकार किस पर टिका है?', 'Abhi tum kisse inkaar kar rahe ho, aur woh inkaar kis par tika hai?', 2
  UNION ALL SELECT 59, 'If a decision needs your self-image to survive, how strong is it?', 'अगर किसी फ़ैसले को टिकने के लिए आपकी अपनी तस्वीर चाहिए, तो वह कितना मज़बूत है?', 'Agar kisi faisle ko tikne ke liye tumhari apni tasveer chahiye, to woh kitna mazboot hai?', 3
  UNION ALL SELECT 63, 'What in all of this do you disagree with? The text says that is allowed.', 'इस सबमें आप किससे असहमत हैं? ग्रंथ कहता है कि यह मंज़ूर है।', 'Is sabme tum kisse asahmat ho? Granth kehta hai ki yeh manzoor hai.', 1
  UNION ALL SELECT 63, 'Which one idea from these chapters are you actually going to use?', 'इन अध्यायों में से कौन-सा एक विचार आप सचमुच इस्तेमाल करेंगे?', 'In chapters mein se kaun sa ek vichar tum sach mein istemaal karoge?', 2
  UNION ALL SELECT 63, 'The instruction is to think it over completely before deciding. Have you?', 'हिदायत यह है कि तय करने से पहले पूरा सोच लीजिए। क्या आपने सोचा?', 'Hidayat yeh hai ki tay karne se pehle poora soch lo. Kya tumne socha?', 3
) AS r
JOIN verses v ON v.verse_number = r.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 18;

INSERT INTO verse_practices (verse_id, action_en, action_hi, action_hinglish, estimated_minutes, difficulty, display_order)
SELECT v.id, p.a_en, p.a_hi, p.a_hing, p.mins, p.diff, 1 FROM (
  SELECT 11 AS vn, 'Do one piece of work this week and let somebody else describe it to others. Notice what that costs you.' AS a_en, 'इस हफ़्ते एक काम कीजिए और उसे दूसरों को कोई और बताए। देखिए इसकी आपको क्या क़ीमत लगती है।' AS a_hi, 'Is hafte ek kaam karo aur use doosron ko koi aur bataye. Dekho iski tumhe kya keemat lagti hai.' AS a_hing, 15 AS mins, 'intermediate' AS diff
  UNION ALL SELECT 14, 'Take one thing you did this week and write all five parts of it. Do not skip the fifth.', 'इस हफ़्ते किया कोई एक काम लीजिए और उसके पाँचों हिस्से लिखिए। पाँचवाँ मत छोड़िए।', 'Is hafte kiya koi ek kaam lo aur uske paanchon hisse likho. Paanchwa mat chhodo.', 10, 'beginner'
  UNION ALL SELECT 16, 'Do the five-part exercise once for a success and once for a failure. Notice which took longer.', 'पाँच हिस्सों वाला अभ्यास एक बार सफलता पर कीजिए और एक बार असफलता पर। देखिए किसमें ज़्यादा समय लगा।', 'Paanch hisson wala abhyas ek baar safalta par karo aur ek baar asafalta par. Dekho kisme zyada samay laga.', 15, 'intermediate'
  UNION ALL SELECT 32, 'Ask one person who disagrees with you about something to explain their position back to you until they say you have it right.', 'किसी एक ऐसे व्यक्ति से जो आपसे किसी बात पर असहमत है, कहिए कि वह अपनी बात समझाए — तब तक, जब तक वह न कहे कि आपने ठीक समझा।', 'Kisi ek aise insaan se jo tumse kisi baat par asahmat hai, kaho ki woh apni baat samjhaye — tab tak, jab tak woh na kahe ki tumne theek samjha.', 20, 'advanced'
  UNION ALL SELECT 37, 'Name one thing you are avoiding that would pass the year-test. Do fifteen minutes of it today.', 'ऐसी एक चीज़ बताइए जिससे आप बच रहे हैं और जो साल की कसौटी पर पास हो जाती। आज उसके पंद्रह मिनट कीजिए।', 'Aisi ek cheez batao jisse tum bach rahe ho aur jo saal ki kasauti par pass ho jaati. Aaj uske pandrah minute karo.', 15, 'beginner'
  UNION ALL SELECT 48, 'Write down the fault in the work you actually do. Not to fix it today — just to have looked at it.', 'जो काम आप सचमुच करते हैं उसमें जो दोष है वह लिखिए। आज ठीक करने के लिए नहीं — बस देख लेने के लिए।', 'Jo kaam tum sach mein karte ho usme jo dosh hai woh likho. Aaj theek karne ke liye nahi — bas dekh lene ke liye.', 10, 'intermediate'
  UNION ALL SELECT 59, 'Write down one thing you have decided you will not do. Underneath, write what the decision is resting on.', 'एक चीज़ लिखिए जिसके बारे में आपने तय किया है कि आप नहीं करेंगे। नीचे लिखिए कि वह फ़ैसला किस पर टिका है।', 'Ek cheez likho jiske baare mein tumne tay kiya hai ki tum nahi karoge. Neeche likho ki woh faisla kis par tika hai.', 8, 'intermediate'
  UNION ALL SELECT 63, 'Write down the one idea from these five chapters you intend to use, and one you reject. Both, in your own words.', 'इन पाँच अध्यायों में से वह एक विचार लिखिए जिसे आप इस्तेमाल करना चाहते हैं, और एक जिसे आप ख़ारिज करते हैं। दोनों, अपने शब्दों में।', 'In paanch chapters mein se woh ek vichar likho jise tum istemaal karna chahte ho, aur ek jise tum khaarij karte ho. Dono, apne shabdon mein.', 15, 'beginner'
) AS p
JOIN verses v ON v.verse_number = p.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 18;

INSERT INTO verse_topics (verse_id, topic_id, relevance)
SELECT v.id, t.id, x.rel FROM (
  SELECT 11 AS vn, 'action-without-attachment' AS slug, 10 AS rel
  UNION ALL SELECT 11, 'effort-without-result', 9
  UNION ALL SELECT 11, 'duty', 8
  UNION ALL SELECT 11, 'burnout', 6
  UNION ALL SELECT 14, 'the-self', 9
  UNION ALL SELECT 14, 'action-without-attachment', 8
  UNION ALL SELECT 14, 'comparison', 6
  UNION ALL SELECT 16, 'the-self', 10
  UNION ALL SELECT 16, 'comparison', 8
  UNION ALL SELECT 16, 'grief', 7
  UNION ALL SELECT 16, 'action-without-attachment', 7
  UNION ALL SELECT 32, 'hard-decisions', 8
  UNION ALL SELECT 32, 'the-self', 7
  UNION ALL SELECT 32, 'comparison', 6
  UNION ALL SELECT 37, 'steadiness', 9
  UNION ALL SELECT 37, 'desire', 9
  UNION ALL SELECT 37, 'burnout', 7
  UNION ALL SELECT 37, 'restlessness', 7
  UNION ALL SELECT 48, 'duty', 9
  UNION ALL SELECT 48, 'hard-decisions', 9
  UNION ALL SELECT 48, 'fear', 7
  UNION ALL SELECT 48, 'restlessness', 6
  UNION ALL SELECT 59, 'duty', 9
  UNION ALL SELECT 59, 'hard-decisions', 8
  UNION ALL SELECT 59, 'the-self', 8
  UNION ALL SELECT 59, 'fear', 6
  UNION ALL SELECT 63, 'hard-decisions', 10
  UNION ALL SELECT 63, 'duty', 7
  UNION ALL SELECT 63, 'the-self', 7
  UNION ALL SELECT 63, 'steadiness', 6
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 18
JOIN topics t ON t.slug = x.slug;

-- =====================================================================
-- 4. MODERN EXAMPLES
-- =====================================================================
-- Three per verse. The 18.48 set is the one to read closely: every
-- scenario there is about somebody choosing to act despite fault, and
-- none of them is about somebody using the verse to justify damage.
-- The last example in the file, on 18.63, is deliberately the plainest
-- thing in the corpus.
-- =====================================================================

DELETE e FROM modern_examples e JOIN verses v ON v.id = e.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 18;

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

  SELECT 11 AS vn, 'corporate' AS cat, 1 AS ord,
  'The sabbatical that solved nothing' AS t_en, 'वह अवकाश जिससे कुछ हल नहीं हुआ' AS t_hi, 'Woh sabbatical jisse kuch hal nahi hua' AS t_hing,
  'Somebody takes four months off to get away from a job that has been consuming them. Weeks one to three are excellent. By week six they have organised the time into a schedule with targets, and by week ten they are describing their reading as being behind. They return early, not from guilt but from noticing that the thing they wanted to leave had come along.' AS s_en,
  'कोई चार महीने की छुट्टी लेता है ताकि उस नौकरी से दूर हो सके जो उसे खा रही थी। पहले तीन हफ़्ते बेहतरीन हैं। छठे हफ़्ते तक वह उस समय को लक्ष्यों वाली एक समय-सारणी में बाँध चुका है, और दसवें तक अपनी पढ़ाई को "पिछड़ी हुई" बता रहा है। वह जल्दी लौट आता है — अपराधबोध से नहीं, बल्कि यह देखकर कि जिस चीज़ को छोड़ना चाहता था वह साथ ही चली आई है।' AS s_hi,
  'Koi chaar mahine ki chhutti leta hai taki us naukri se door ho sake jo use kha rahi thi. Pehle teen hafte behtareen hain. Chhathe hafte tak woh us samay ko lakshyon wali ek timetable mein baandh chuka hai, aur daswe tak apni padhai ko "pichhdi hui" bata raha hai. Woh jaldi laut aata hai — apradhbodh se nahi, balki yeh dekhkar ki jis cheez ko chhodna chahta tha woh saath hi chali aayi hai.' AS s_hing,
  'The verse says a body means action and putting all action down is not available. What it points at instead is the collecting, and this scenario is a clean demonstration: the location changed, the work changed, and the thing that was actually consuming him did not, because he brought it.' AS c_en,
  'श्लोक कहता है कि शरीर का मतलब कर्म है और सारा कर्म रख देना उपलब्ध ही नहीं। वह जिस तरफ़ इशारा करता है वह है बटोरना, और यह दृश्य उसका साफ़ प्रदर्शन है: जगह बदली, काम बदला, और जो चीज़ असल में उसे खा रही थी वह नहीं बदली, क्योंकि वह उसे साथ ले गया था।' AS c_hi,
  'Shloka kehta hai ki sharir ka matlab karm hai aur saara karm rakh dena uplabdh hi nahi. Woh jis taraf ishara karta hai woh hai batorna, aur yeh drishya uska saaf pradarshan hai: jagah badli, kaam badla, aur jo cheez asal mein use kha rahi thi woh nahi badli, kyunki woh use saath le gaya tha.' AS c_hing,
  'You can change the work and the place. Whatever you were doing to the work comes with you.' AS l_en,
  'काम और जगह बदली जा सकती है। आप काम के साथ जो कर रहे थे वह आपके साथ चला आता है।' AS l_hi,
  'Kaam aur jagah badli ja sakti hai. Tum kaam ke saath jo kar rahe the woh tumhare saath chala aata hai.' AS l_hing,
  NULL AS src, 'intermediate' AS diff, 'work,burnout,escape,renunciation,habits' AS tags

  UNION ALL SELECT 11, 'everyday_life', 2,
  'The volunteer nobody could name', 'वह स्वयंसेवक जिसका नाम कोई नहीं जानता था', 'Woh volunteer jiska naam koi nahi jaanta tha',
  'A community kitchen runs three evenings a week for eleven years. One of the people who set it up stopped attending the annual event years ago and is not on the board. He is still there at half past five on Wednesdays. Asked why he does not go to the event, he says he does not like them, which is the entire answer he gives.',
  'एक सामुदायिक रसोई ग्यारह साल से हफ़्ते में तीन शामें चलती है। जिन लोगों ने इसे शुरू किया था उनमें से एक ने सालाना कार्यक्रम में जाना बरसों पहले छोड़ दिया और वह समिति में भी नहीं है। वह बुधवार को साढ़े पाँच बजे अब भी वहीं होता है। पूछने पर कि कार्यक्रम में क्यों नहीं जाते, वह कहता है कि उसे वे पसंद नहीं — पूरा जवाब यही है।',
  'Ek samudayik rasoi gyarah saal se hafte mein teen shaamein chalti hai. Jin logon ne ise shuru kiya tha unme se ek ne saalana karyakram mein jaana barson pehle chhod diya aur woh committee mein bhi nahi hai. Woh Wednesday ko saade paanch baje ab bhi wahin hota hai. Poochne par ki karyakram mein kyun nahi jaate, woh kehta hai ki use woh pasand nahi — poora jawab yahi hai.',
  'Here is what the verse actually describes, without the vocabulary. He did not put down the work; he put down what the work earns. Eleven years is long enough for that to be a fact about him rather than a mood, and it is worth noticing how unremarkable it looks from outside.',
  'श्लोक जो असल में बताता है वह यही है, शब्दावली के बिना। उसने काम नहीं रखा; उसने वह रखा जो काम से मिलता है। ग्यारह साल इतने हैं कि यह उसके बारे में एक तथ्य हो, किसी मनोदशा का मामला नहीं — और ध्यान देने लायक है कि बाहर से यह कितना साधारण दिखता है।',
  'Shloka jo asal mein batata hai woh yahi hai, shabdavali ke bina. Usne kaam nahi rakha; usne woh rakha jo kaam se milta hai. Gyarah saal itne hain ki yeh uske baare mein ek tathya ho, kisi manodasha ka mamla nahi — aur dhyan dene layak hai ki bahar se yeh kitna sadharan dikhta hai.',
  'From outside, the real version of this looks like nothing at all. That is most of how you can tell.',
  'बाहर से इसका असली रूप कुछ भी नहीं जैसा दिखता है। पहचानने का ज़्यादातर तरीक़ा यही है।',
  'Bahar se iska asli roop kuch bhi nahi jaisa dikhta hai. Pehchanne ka zyadatar tareeka yahi hai.',
  NULL, 'beginner', 'community,service,credit,consistency,ordinary'

  UNION ALL SELECT 11, 'startup', 3,
  'The founder who stayed for the boring part', 'वह संस्थापक जो उबाऊ हिस्से के लिए रुका', 'Woh founder jo ubaau hisse ke liye ruka',
  'After an acquisition, one of two founders leaves within the month and the other stays three more years running something that is no longer hers, inside somebody else''s company, with none of the interesting decisions. Colleagues assume a lock-in. There is no lock-in. Asked, she says roughly forty people''s work runs through that system and she wanted it to still work in three years.',
  'अधिग्रहण के बाद दो संस्थापकों में से एक महीने भर में चली जाती है और दूसरी तीन साल और रुककर वह चीज़ चलाती है जो अब उसकी नहीं है, किसी और की कंपनी के भीतर, और दिलचस्प फ़ैसलों में से एक भी उसके पास नहीं। सहकर्मी मानते हैं कि कोई शर्त बाँधे हुए है। कोई शर्त नहीं है। पूछने पर वह कहती है कि क़रीब चालीस लोगों का काम उस सिस्टम से चलता है और वह चाहती थी कि तीन साल बाद भी वह चले।',
  'Adhigrahan ke baad do foundron mein se ek mahine bhar mein chali jaati hai aur doosri teen saal aur rukkar woh cheez chalati hai jo ab uski nahi hai, kisi aur ki company ke bheetar, aur dilchasp faislon mein se ek bhi uske paas nahi. Colleague maante hain ki koi shart baandhe hue hai. Koi shart nahi hai. Poochne par woh kehti hai ki karib chalis logon ka kaam us system se chalta hai aur woh chahti thi ki teen saal baad bhi woh chale.',
  'Both founders gave something up and only one of them fits the verse. Leaving put down the work. Staying put down the ownership, the credit and the interesting parts, and kept the work — which is the definition the chapter is offering, arrived at without anybody quoting it.',
  'दोनों संस्थापकों ने कुछ छोड़ा और उनमें से एक ही श्लोक पर बैठती है। जाने वाली ने काम रखा। रुकने वाली ने मालिकाना, श्रेय और दिलचस्प हिस्से रखे, और काम बनाए रखा — और यही परिभाषा अध्याय दे रहा है, बिना किसी के उद्धृत किए वहाँ पहुँची हुई।',
  'Dono foundron ne kuch chhoda aur unme se ek hi shloka par baithti hai. Jaane wali ne kaam rakha. Rukne wali ne malikana, credit aur dilchasp hisse rakhe, aur kaam banaye rakha — aur yahi paribhasha chapter de raha hai, bina kisi ke quote kiye wahan pahunchi hui.',
  'Both of them gave something up. Only one of them gave up the part the chapter is talking about.',
  'दोनों ने कुछ छोड़ा। उनमें से एक ने ही वह छोड़ा जिसकी बात अध्याय कर रहा है।',
  'Dono ne kuch chhoda. Unme se ek ne hi woh chhoda jiski baat chapter kar raha hai.',
  NULL, 'intermediate', 'work,business,ownership,credit,staying'

  UNION ALL SELECT 14, 'healthcare', 1,
  'Five things in one operating theatre', 'एक ऑपरेशन थिएटर में पाँच चीज़ें', 'Ek operation theatre mein paanch cheezein',
  'A difficult operation goes well. Afterwards the surgeon can list, unprompted and without modesty, the things that made it work: a theatre that had been rebuilt two years earlier, an anaesthetist she had worked with forty times, an instrument that arrived in the department in March, her own hands on a day when they were steady, and a patient whose anatomy happened to be textbook. She names all five and stops.',
  'एक कठिन ऑपरेशन अच्छा जाता है। बाद में सर्जन बिना पूछे और बिना विनम्रता ओढ़े वे चीज़ें गिना सकती हैं जिनसे यह चला: वह थिएटर जो दो साल पहले दोबारा बना था, वह एनेस्थेटिस्ट जिसके साथ वे चालीस बार काम कर चुकी थीं, वह उपकरण जो मार्च में विभाग में आया, उनके अपने हाथ उस दिन जब वे स्थिर थे, और वह मरीज़ जिसकी शरीर-रचना संयोग से किताबी थी। वे पाँचों गिनाकर रुक जाती हैं।',
  'Ek mushkil operation achha jaata hai. Baad mein surgeon bina poochhe aur bina vinamrata odhe woh cheezein gina sakti hain jinse yeh chala: woh theatre jo do saal pehle dobara bana tha, woh anaesthetist jiske saath woh chalis baar kaam kar chuki thin, woh upkaran jo March mein vibhag mein aaya, unke apne haath us din jab woh sthir the, aur woh mareez jiski sharir-rachna sanyog se kitaabi thi. Woh paanchon ginakar ruk jaati hain.',
  'The five map exactly: the setting, the doer, the instruments, the effort on the day, and the part nobody arranged. What makes this worth including is that she is not being humble. She is being accurate, and the accuracy is what lets her keep operating after the ones that go badly.',
  'पाँचों ठीक बैठते हैं: जगह, कर्ता, करण, उस दिन की चेष्टा, और वह हिस्सा जो किसी ने जुटाया नहीं। इसे रखने लायक यह बनाता है कि वे विनम्रता नहीं दिखा रहीं। वे सटीक हैं, और यही सटीकता उन्हें उन ऑपरेशनों के बाद भी काम करते रहने देती है जो बिगड़ते हैं।',
  'Paanchon theek baithte hain: jagah, karta, karan, us din ki cheshta, aur woh hissa jo kisi ne jutaya nahi. Ise rakhne layak yeh banata hai ki woh vinamrata nahi dikha rahin. Woh sateek hain, aur yahi sateekta unhe un operationon ke baad bhi kaam karte rehne deti hai jo bigadte hain.',
  'Counting all five is not modesty. It is accuracy, and it is what makes the bad days survivable.',
  'पाँचों गिनना विनम्रता नहीं है। यह सटीकता है, और यही बुरे दिनों को झेलने लायक बनाती है।',
  'Paanchon ginna vinamrata nahi hai. Yeh sateekta hai, aur yahi bure dinon ko jhelne layak banati hai.',
  NULL, 'intermediate', 'health,work,credit,causes,accuracy'

  UNION ALL SELECT 14, 'school', 2,
  'The class that did better than the last one', 'वह कक्षा जिसने पिछली से अच्छा किया', 'Woh class jisne pichhli se achha kiya',
  'Results improve sharply in one subject. In the review, the improvement is attributed to a new teaching approach. Also true, and not in the review: the year group is smaller, the room changed to one with windows, the exam board altered a paper, and one particularly disruptive timetable clash was removed. The approach may well have helped. It was one of five things.',
  'एक विषय के नतीजे तेज़ी से सुधरते हैं। समीक्षा में सुधार का श्रेय पढ़ाने के नए तरीक़े को दिया जाता है। यह भी सच है और समीक्षा में नहीं है: इस साल का समूह छोटा है, कमरा बदलकर खिड़कियों वाला हो गया, परीक्षा बोर्ड ने एक पर्चा बदला, और समय-सारणी की एक ख़ास गड़बड़ हटा दी गई। तरीक़े ने मदद की भी हो सकती है। वह पाँच में से एक चीज़ थी।',
  'Ek vishay ke results tezi se sudharte hain. Review mein sudhaar ka credit padhane ke naye tareeke ko diya jaata hai. Yeh bhi sach hai aur review mein nahi hai: is saal ka samuh chhota hai, kamra badalkar khidkiyon wala ho gaya, exam board ne ek paper badla, aur timetable ki ek khaas gadbad hata di gayi. Tareeke ne madad ki bhi ho sakti hai. Woh paanch mein se ek cheez thi.',
  'The verse is a counting instruction and this is what happens without it. Nobody lied. One of the five was named as though it were all five, and the following year, when the group is large again and the room reverts, the approach will be blamed for something it did not cause either.',
  'श्लोक गिनने की हिदायत है और उसके बिना यही होता है। किसी ने झूठ नहीं बोला। पाँच में से एक को ऐसे बताया गया जैसे वह पाँचों हो, और अगले साल, जब समूह फिर बड़ा होगा और कमरा वापस बदलेगा, उसी तरीक़े को उस चीज़ का दोष मिलेगा जो उसने की भी नहीं।',
  'Shloka ginne ki hidayat hai aur uske bina yahi hota hai. Kisi ne jhooth nahi bola. Paanch mein se ek ko aise bataya gaya jaise woh paanchon ho, aur agle saal, jab samuh phir bada hoga aur kamra wapas badlega, usi tareeke ko us cheez ka dosh milega jo usne ki bhi nahi.',
  'Naming one of five as though it were all five sets up next year''s wrong blame as well as this year''s wrong credit.',
  'पाँच में से एक को पाँचों बता देना इस साल के ग़लत श्रेय के साथ अगले साल का ग़लत दोष भी तय कर देता है।',
  'Paanch mein se ek ko paanchon bata dena is saal ke galat credit ke saath agle saal ka galat dosh bhi tay kar deta hai.',
  NULL, 'intermediate', 'school,results,attribution,causes,review'

  UNION ALL SELECT 14, 'sports', 3,
  'The season and the fifth thing', 'सत्र और पाँचवीं चीज़', 'Season aur paanchwi cheez',
  'A side wins a league by two points. Over the year they were the better team for long stretches and also had a goal wrongly allowed in October, an opponent''s injury crisis in February, and a fixture postponed by weather into a week that suited them. Their captain, asked whether they deserved it, says yes, and then says the other thing as well, in the same breath, without it sounding like a qualification.',
  'एक टीम दो अंकों से लीग जीतती है। साल भर वे लंबे दौर तक बेहतर टीम रहे और साथ ही अक्टूबर में एक ग़लत गोल उन्हें मिला, फ़रवरी में विरोधी टीम चोटों से जूझी, और मौसम से टला एक मैच ऐसे हफ़्ते में चला गया जो उन्हें सूट करता था। कप्तान से पूछा जाता है कि क्या वे इसके हक़दार थे, वे हाँ कहते हैं, और फिर उसी साँस में दूसरी बात भी कह देते हैं, बिना यह सफ़ाई जैसा लगे।',
  'Ek team do ank se league jeetti hai. Saal bhar woh lambe daur tak behtar team rahe aur saath hi October mein ek galat goal unhe mila, February mein virodhi team choton se joojhi, aur mausam se tala ek match aise hafte mein chala gaya jo unhe suit karta tha. Captain se poocha jaata hai ki kya woh iske haqdar the, woh haan kehte hain, aur phir usi saans mein doosri baat bhi keh dete hain, bina yeh safai jaisa lage.',
  'Both halves in one breath is the interesting part. The verse does not ask anybody to deny the effort — kartā and ceṣṭā are two of the five and they were real. It asks for the fifth to be in the sentence, and the captain manages it without either false modesty or defensiveness, which is rarer than either.',
  'दिलचस्प हिस्सा दोनों आधों का एक ही साँस में आना है। श्लोक किसी से मेहनत नकारने को नहीं कहता — कर्ता और चेष्टा पाँच में से दो हैं और वे सच्चे थे। वह माँगता है कि पाँचवाँ भी वाक्य में हो, और कप्तान यह बिना झूठी विनम्रता और बिना बचाव के कर लेते हैं, जो दोनों से ज़्यादा दुर्लभ है।',
  'Dilchasp hissa dono aadhon ka ek hi saans mein aana hai. Shloka kisi se mehnat nakaarne ko nahi kehta — karta aur cheshta paanch mein se do hain aur woh sachche the. Woh maangta hai ki paanchwa bhi vakya mein ho, aur captain yeh bina jhoothi vinamrata aur bina bachav ke kar lete hain, jo dono se zyada durlabh hai.',
  'Saying both halves in one breath, with neither as a qualification of the other, is the whole skill.',
  'दोनों आधे एक ही साँस में कहना, और कोई भी दूसरे की सफ़ाई न बने — पूरा हुनर यही है।',
  'Dono aadhe ek hi saans mein kehna, aur koi bhi doosre ki safai na bane — poora hunar yahi hai.',
  NULL, 'beginner', 'sport,luck,merit,credit,honesty'

  UNION ALL SELECT 16, 'finance', 1,
  'The decade that made somebody a genius', 'वह दशक जिसने किसी को प्रतिभाशाली बना दिया', 'Woh dashak jisne kisi ko pratibhashali bana diya',
  'An investor has a very good ten years and writes, honestly and well, about the method. The method is real. A colleague points out, without malice, that anyone holding almost anything through that decade did well, and that the method has not yet been tested by the other kind of decade. The investor agrees in the conversation and does not change a word of the writing.',
  'एक निवेशक के दस साल बहुत अच्छे जाते हैं और वह अपने तरीक़े पर ईमानदारी से और अच्छा लिखता है। तरीक़ा असली है। एक सहकर्मी बिना किसी दुर्भावना के कहता है कि उस दशक में लगभग कुछ भी थामे रखने वाले का अच्छा ही गया, और तरीक़े की परीक्षा दूसरी तरह के दशक ने अभी ली ही नहीं। निवेशक बातचीत में सहमत होता है और अपने लिखे में एक शब्द नहीं बदलता।',
  'Ek investor ke das saal bahut achhe jaate hain aur woh apne tareeke par imaandari se aur achha likhta hai. Tareeka asli hai. Ek colleague bina kisi durbhavna ke kehta hai ki us dashak mein lagbhag kuch bhi thame rakhne wale ka achha hi gaya, aur tareeke ki pariksha doosri tarah ke dashak ne abhi li hi nahi. Investor baatchit mein sehmat hota hai aur apne likhe mein ek shabd nahi badalta.',
  'The verse calls this a failure of seeing and the gap between the conversation and the writing is why that framing is the useful one. He is not lying in the article; he agreed with the objection out loud. The counting simply does not survive contact with the sentence he wants to write.',
  'श्लोक इसे देखने की चूक कहता है, और बातचीत तथा लिखे के बीच का यह फ़ासला ही बताता है कि वही ढाँचा काम का क्यों है। वह लेख में झूठ नहीं बोल रहा; उसने आपत्ति से ज़ोर से सहमति जताई थी। गिनती बस उस वाक्य से मुलाक़ात नहीं झेल पाती जो वह लिखना चाहता है।',
  'Shloka ise dekhne ki chook kehta hai, aur baatchit tatha likhe ke beech ka yeh faasla hi batata hai ki wahi dhaancha kaam ka kyun hai. Woh lekh mein jhooth nahi bol raha; usne aapatti se zor se sehmati jatayi thi. Ginti bas us vakya se mulaqat nahi jhel paati jo woh likhna chahta hai.',
  'Agreeing with the objection out loud and not changing the sentence is the ordinary form of this. It is not lying.',
  'आपत्ति से ज़ोर से सहमत होना और वाक्य न बदलना — इसका आम रूप यही है। यह झूठ नहीं है।',
  'Aapatti se zor se sehmat hona aur vakya na badalna — iska aam roop yahi hai. Yeh jhooth nahi hai.',
  NULL, 'advanced', 'money,luck,method,self-knowledge,writing'

  UNION ALL SELECT 16, 'parenting', 2,
  'The second child who was different', 'वह दूसरा बच्चा जो अलग था', 'Woh doosra bachcha jo alag tha',
  'Parents who did everything the same way twice describe the first child''s calmness as a result of their approach and the second child''s difficulty as a result of the second child. Both descriptions are given warmly and neither is offered as a criticism. They are simply two different accounts of causation applied to the same household.',
  'जिन माता-पिता ने दोनों बार सब कुछ एक जैसा किया, वे पहले बच्चे की शांति को अपने तरीक़े का नतीजा बताते हैं और दूसरे बच्चे की मुश्किल को दूसरे बच्चे का। दोनों बातें गर्मजोशी से कही जाती हैं और कोई भी आलोचना के तौर पर नहीं। ये बस एक ही घर पर लगाए गए कारण के दो अलग बयान हैं।',
  'Jin maa-baap ne dono baar sab kuch ek jaisa kiya, woh pehle bachche ki shanti ko apne tareeke ka nateeja batate hain aur doosre bachche ki mushkil ko doosre bachche ka. Dono baatein garmjoshi se kahi jaati hain aur koi bhi aalochna ke taur par nahi. Yeh bas ek hi ghar par lagaye gaye kaaran ke do alag bayan hain.',
  'This is the asymmetry the verse describes, in the setting where it does the most damage. The five factors were the same both times. Only the direction of the outcome changed, and the account of who caused it flipped with it, which is the tell.',
  'यह वही असमानता है जो श्लोक बताता है, और उस जगह पर जहाँ यह सबसे ज़्यादा नुक़सान करती है। पाँचों कारक दोनों बार वही थे। बदला सिर्फ़ नतीजे का रुख़, और उसी के साथ यह बयान भी पलट गया कि कारण कौन था — निशानी यही है।',
  'Yeh wahi asamanta hai jo shloka batata hai, aur us jagah par jahan yeh sabse zyada nuksaan karti hai. Paanchon kaarak dono baar wahi the. Badla sirf nateeje ka rukh, aur usi ke saath yeh bayan bhi palat gaya ki kaaran kaun tha — nishani yahi hai.',
  'When the account of who caused it flips with the direction of the outcome, that is the tell.',
  'जब कारण कौन था इसका बयान नतीजे के रुख़ के साथ पलट जाए, तो निशानी वही है।',
  'Jab kaaran kaun tha iska bayan nateeje ke rukh ke saath palat jaaye, to nishani wahi hai.',
  NULL, 'advanced', 'family,children,causes,attribution,fairness'

  UNION ALL SELECT 16, 'everyday_life', 3,
  'The five for a bad year', 'बुरे साल के पाँच', 'Bure saal ke paanch',
  'Somebody who has had a genuinely bad year sits down with a friend and lists the five factors for it, at the friend''s suggestion. It takes about an hour. Four of the five are things they had no hand in. They describe the exercise afterwards as not making them feel better and as making them feel accurate, which they say is a different and more useful thing.',
  'जिसका साल सचमुच बुरा गया है, वह एक दोस्त के साथ बैठकर उसके सुझाव पर उसके पाँच कारक गिनाता है। इसमें क़रीब एक घंटा लगता है। पाँच में से चार वे हैं जिनमें उसका कोई हाथ नहीं था। बाद में वह इस अभ्यास को यूँ बताता है कि इससे अच्छा नहीं लगा, सटीक लगा — और कहता है कि यह अलग और ज़्यादा काम की चीज़ है।',
  'Jiska saal sach mein bura gaya hai, woh ek dost ke saath baithkar uske sujhav par uske paanch kaarak ginata hai. Isme karib ek ghanta lagta hai. Paanch mein se chaar woh hain jinme uska koi haath nahi tha. Baad mein woh is abhyas ko yun batata hai ki isse achha nahi laga, sateek laga — aur kehta hai ki yeh alag aur zyada kaam ki cheez hai.',
  'The verse is usually met in its deflating direction — you are not the sole author of your successes. This is the same instruction pointed the other way, and it is the direction almost nobody applies it in. Four of five is not an excuse. It is a count.',
  'श्लोक से आमतौर पर उसकी उतारने वाली दिशा में मुलाक़ात होती है — आप अपनी सफलताओं के इकलौते कर्ता नहीं हैं। यह वही हिदायत दूसरी तरफ़ मोड़ी हुई है, और यह वह दिशा है जिसमें लगभग कोई इसे नहीं लगाता। पाँच में से चार कोई बहाना नहीं है। यह एक गिनती है।',
  'Shloka se aam taur par uski utaarne wali disha mein mulaqat hoti hai — tum apni safaltaon ke iklaute karta nahi ho. Yeh wahi hidayat doosri taraf modi hui hai, aur yeh woh disha hai jisme lagbhag koi ise nahi lagata. Paanch mein se chaar koi bahana nahi hai. Yeh ek ginti hai.',
  'Point the same counting at a bad year. Four of five is not an excuse; it is a count, and most people never do it.',
  'यही गिनती किसी बुरे साल पर लगाइए। पाँच में से चार बहाना नहीं है; वह गिनती है, और ज़्यादातर लोग कभी करते ही नहीं।',
  'Yahi ginti kisi bure saal par lagao. Paanch mein se chaar bahana nahi hai; woh ginti hai, aur zyadatar log kabhi karte hi nahi.',
  NULL, 'intermediate', 'self-blame,causes,bad-years,friendship,accuracy'

  UNION ALL SELECT 32, 'corporate', 1,
  'The metric that ate the thing it measured', 'वह पैमाना जिसने उसी चीज़ को खा लिया जिसे नापता था', 'Woh paimana jisne usi cheez ko kha liya jise naapta tha',
  'A support team is measured on how fast tickets close. Within a year the fastest closers are the most highly rated, and the team has quietly learned to close tickets the customer will have to reopen. Everybody is working hard, following the guidance, and being rewarded correctly. The customers are worse off than before the measurement existed.',
  'एक सपोर्ट टीम इस पर नापी जाती है कि टिकट कितनी जल्दी बंद होते हैं। साल भर में सबसे तेज़ बंद करने वालों की रेटिंग सबसे ऊँची हो जाती है, और टीम चुपचाप वे टिकट बंद करना सीख जाती है जिन्हें ग्राहक को दोबारा खोलना पड़ेगा। सब मेहनत कर रहे हैं, हिदायत मान रहे हैं, और ठीक से इनाम पा रहे हैं। ग्राहक उस हालत से बुरे हैं जब यह पैमाना था ही नहीं।',
  'Ek support team is par naapi jaati hai ki ticket kitni jaldi band hote hain. Saal bhar mein sabse tez band karne walon ki rating sabse oonchi ho jaati hai, aur team chupchap woh ticket band karna seekh jaati hai jinhe customer ko dobara kholna padega. Sab mehnat kar rahe hain, hidayat maan rahe hain, aur theek se inaam paa rahe hain. Customer us haalat se bure hain jab yeh paimana tha hi nahi.',
  'Sarvārthān viparītān — everything reversed, worked outward with complete consistency. Nobody here is cynical and nobody is cheating. One label got swapped at the top, and every honest, hardworking step after it went in the wrong direction because the steps were correct relative to the label.',
  'सर्वार्थान् विपरीतान् — सब कुछ उल्टा, और पूरी संगति के साथ आगे बढ़ा हुआ। यहाँ कोई कुटिल नहीं है और कोई धोखा नहीं कर रहा। ऊपर एक लेबल बदल गया, और उसके बाद का हर ईमानदार, मेहनती क़दम ग़लत दिशा में गया, क्योंकि हर क़दम उस लेबल के हिसाब से सही था।',
  'Sarvarthan viparitan — sab kuch ulta, aur poori sangati ke saath aage badha hua. Yahan koi kutil nahi hai aur koi dhokha nahi kar raha. Upar ek label badal gaya, aur uske baad ka har imaandar, mehnati kadam galat disha mein gaya, kyunki har kadam us label ke hisaab se sahi tha.',
  'One label swapped at the top, and every correct step after it goes the wrong way. That is what consistency does.',
  'ऊपर एक लेबल बदला, और उसके बाद का हर सही क़दम ग़लत तरफ़ जाता है। संगति यही करती है।',
  'Upar ek label badla, aur uske baad ka har sahi kadam galat taraf jaata hai. Sangati yahi karti hai.',
  NULL, 'intermediate', 'work,metrics,incentives,unintended,consistency'

  UNION ALL SELECT 32, 'relationships', 2,
  'Twelve years of being fair', 'न्याय करने के बारह साल', 'Nyay karne ke barah saal',
  'Somebody prides themselves on never raising their voice, and does not. Over twelve years they also never concede a point, never apologise first, and answer every complaint with a precisely accurate account of what was actually said. A counsellor, several sessions in, asks what they think fairness is for. The question does not land for another two months.',
  'किसी को गर्व है कि उसने कभी आवाज़ ऊँची नहीं की, और वह करता भी नहीं। बारह साल में वह यह भी कभी नहीं करता कि कोई बात मान ले, कभी पहले माफ़ी न माँगे, और हर शिकायत का जवाब इस बिलकुल सही ब्योरे से दे कि असल में कहा क्या गया था। कई सत्रों के बाद एक काउंसलर पूछती हैं कि उसके ख़याल से न्याय किसलिए होता है। यह सवाल अगले दो महीने तक उस तक पहुँचता ही नहीं।',
  'Kisi ko garv hai ki usne kabhi aawaz oonchi nahi ki, aur woh karta bhi nahi. Barah saal mein woh yeh bhi kabhi nahi karta ki koi baat maan le, kabhi pehle maafi na maange, aur har shikayat ka jawab is bilkul sahi byore se de ki asal mein kaha kya gaya tha. Kai session ke baad ek counsellor poochti hain ki uske khayal se nyay kisliye hota hai. Yeh sawaal agle do mahine tak us tak pahunchta hi nahi.',
  'A virtue is sitting in the place another one should be, and everything downstream is consistent with the substitution. Accuracy has been labelled fairness. Every individual act is defensible; the twelve years are not. The two months are how long it takes to see a label from inside.',
  'एक गुण उस जगह बैठा है जहाँ कोई दूसरा होना चाहिए था, और उसके बाद का सब कुछ इस अदला-बदली से संगत है। सटीकता पर न्याय का लेबल लगा दिया गया है। हर अलग-अलग काम का बचाव किया जा सकता है; बारह साल का नहीं। दो महीने वह समय है जो किसी लेबल को भीतर से देखने में लगता है।',
  'Ek gun us jagah baitha hai jahan koi doosra hona chahiye tha, aur uske baad ka sab kuch is adla-badli se sangat hai. Sateekta par nyay ka label laga diya gaya hai. Har alag-alag kaam ka bachav kiya ja sakta hai; barah saal ka nahi. Do mahine woh samay hai jo kisi label ko bheetar se dekhne mein lagta hai.',
  'Every individual act was defensible. The twelve years were not. That gap is where a swapped label lives.',
  'हर अलग काम का बचाव हो सकता था। बारह साल का नहीं। बदला हुआ लेबल उसी फ़ासले में रहता है।',
  'Har alag kaam ka bachav ho sakta tha. Barah saal ka nahi. Badla hua label usi faasle mein rehta hai.',
  NULL, 'advanced', 'relationships,fairness,accuracy,blind-spots,counselling'

  UNION ALL SELECT 32, 'everyday_life', 3,
  'The friend who said it early', 'वह दोस्त जिसने जल्दी कह दिया', 'Woh dost jisne jaldi keh diya',
  'Somebody makes a decision that three people privately think is a mistake. Two say nothing. The third says so, badly, and is not thanked. Two years later the decision has cost what it was going to cost, and the person describes the third friend as the only one who behaved decently, which is not how it felt at the time to anybody involved.',
  'कोई एक फ़ैसला करता है जिसे तीन लोग मन ही मन ग़लती मानते हैं। दो कुछ नहीं कहते। तीसरा कह देता है, ठीक से नहीं, और उसका शुक्रिया नहीं होता। दो साल बाद उस फ़ैसले की जो क़ीमत लगनी थी लग चुकी है, और वह व्यक्ति तीसरे दोस्त को इकलौता बताता है जिसने सही बरताव किया — जो उस वक़्त इसमें शामिल किसी को वैसा लगा नहीं था।',
  'Koi ek faisla karta hai jise teen log man hi man galti maante hain. Do kuch nahi kehte. Teesra keh deta hai, theek se nahi, aur uska shukriya nahi hota. Do saal baad us faisle ki jo keemat lagni thi lag chuki hai, aur woh insaan teesre dost ko iklauta batata hai jisne sahi bartav kiya — jo us waqt isme shamil kisi ko waisa laga nahi tha.',
  'A reversed map cannot be corrected from inside it, which is the practical consequence of what this verse describes. Somebody outside has to say something, and the verse offers no comfort about how that will be received at the time. The two silent friends were being kind. Only one of the three was being useful.',
  'उल्टा नक़्शा भीतर से सुधारा नहीं जा सकता — यह श्लोक जो बताता है उसका व्यावहारिक नतीजा यही है। किसी बाहर वाले को कुछ कहना पड़ता है, और श्लोक इस बारे में कोई तसल्ली नहीं देता कि उस वक़्त वह कैसे लिया जाएगा। दोनों चुप दोस्त दयालु थे। तीनों में से एक ही काम का था।',
  'Ulta naqsha bheetar se sudhara nahi ja sakta — yeh shloka jo batata hai uska vyavharik nateeja yahi hai. Kisi bahar wale ko kuch kehna padta hai, aur shloka is baare mein koi tasalli nahi deta ki us waqt woh kaise liya jayega. Dono chup dost dayalu the. Teenon mein se ek hi kaam ka tha.',
  'A reversed map cannot be corrected from inside. Somebody outside has to say something and will not be thanked for it.',
  'उल्टा नक़्शा भीतर से नहीं सुधरता। किसी बाहर वाले को कहना पड़ता है और उसका शुक्रिया नहीं होगा।',
  'Ulta naqsha bheetar se nahi sudharta. Kisi bahar wale ko kehna padta hai aur uska shukriya nahi hoga.',
  NULL, 'intermediate', 'friendship,honesty,advice,decisions,hindsight'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 18;

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

  SELECT 37 AS vn, 'everyday_life' AS cat, 1 AS ord,
  'Six weeks of sounding terrible' AS t_en, 'छह हफ़्ते बुरा बजने के' AS t_hi, 'Chhah hafte bura bajne ke' AS t_hing,
  'An adult starts learning an instrument. The first six weeks are, by their own description, unpleasant in a very specific way — not difficult, exactly, but embarrassing to be heard doing. At about week nine something small works, and at eighteen months they describe the practice hour as the part of the day they protect.' AS s_en,
  'एक वयस्क कोई वाद्य सीखना शुरू करता है। पहले छह हफ़्ते, उसके अपने कहे मुताबिक़, एक ख़ास तरह से अप्रिय हैं — कठिन ठीक-ठीक नहीं, बल्कि ऐसे कि करते हुए सुना जाना शर्मिंदा करता है। क़रीब नौवें हफ़्ते कुछ छोटा-सा काम करने लगता है, और अठारह महीने पर वह अभ्यास वाले घंटे को दिन का वह हिस्सा बताता है जिसे वह बचाकर रखता है।' AS s_hi,
  'Ek vayask koi instrument seekhna shuru karta hai. Pehle chhah hafte, uske apne kahe mutabik, ek khaas tarah se apriya hain — mushkil theek-theek nahi, balki aise ki karte hue suna jaana sharminda karta hai. Karib nauve hafte kuch chhota sa kaam karne lagta hai, aur atharah mahine par woh abhyas wale ghante ko din ka woh hissa batata hai jise woh bachakar rakhta hai.' AS s_hing,
  'Poison at the start, something else by the end, and the useful part is that the verse gives you a test rather than an encouragement. It does not say push through. It says sort by direction, and the six weeks were not a sign of a bad choice — they were what the good kind tastes like on day four.' AS c_en,
  'शुरू में ज़हर, अंत तक कुछ और — और काम की बात यह है कि श्लोक हौसला नहीं, कसौटी देता है। वह यह नहीं कहता कि झेल जाइए। वह कहता है कि दिशा से छाँटिए, और वे छह हफ़्ते ग़लत चुनाव की निशानी नहीं थे — अच्छी वाली चीज़ चौथे दिन ऐसी ही लगती है।' AS c_hi,
  'Shuru mein zeher, ant tak kuch aur — aur kaam ki baat yeh hai ki shloka hausla nahi, kasauti deta hai. Woh yeh nahi kehta ki jhel jao. Woh kehta hai ki disha se chhaanto, aur woh chhah hafte galat chunav ki nishani nahi the — achhi wali cheez chauthe din aisi hi lagti hai.' AS c_hing,
  'The bad first weeks were not a warning sign. They are what the good kind tastes like early on.' AS l_en,
  'शुरू के बुरे हफ़्ते चेतावनी नहीं थे। अच्छी वाली चीज़ शुरू में ऐसी ही लगती है।' AS l_hi,
  'Shuru ke bure hafte chetavni nahi the. Achhi wali cheez shuru mein aisi hi lagti hai.' AS l_hing,
  NULL AS src, 'beginner' AS diff, 'learning,music,practice,patience,beginnings' AS tags

  UNION ALL SELECT 37, 'relationships', 2,
  'The conversation both of them dreaded', 'वह बातचीत जिससे दोनों डरते थे', 'Woh baat jisse dono darte the',
  'Two people finally have a conversation they have avoided for a year. It goes badly for the first forty minutes in the way these things do. It is not resolved that evening. Six months later both of them separately date the improvement in how they are together to that night, and neither would describe the night itself as good.',
  'दो लोग आख़िरकार वह बातचीत करते हैं जिसे वे साल भर टालते रहे। पहले चालीस मिनट वैसे ही बुरे जाते हैं जैसे ऐसी बातें जाती हैं। उस शाम कुछ हल नहीं होता। छह महीने बाद दोनों अलग-अलग बताते हैं कि उनके बीच जो सुधार आया वह उसी रात से है, और दोनों में से कोई उस रात को अच्छी नहीं कहेगा।',
  'Do log aakhirkar woh baat karte hain jise woh saal bhar taalte rahe. Pehle chalis minute waise hi bure jaate hain jaise aisi baatein jaati hain. Us shaam kuch hal nahi hota. Chhah mahine baad dono alag-alag batate hain ki unke beech jo sudhaar aaya woh usi raat se hai, aur dono mein se koi us raat ko achhi nahi kahega.',
  'This is the verse''s test in the setting where it is hardest to apply, because the poison is not effort — it is the specific unpleasantness of a bad evening with somebody you care about. Nothing about that evening felt like progress. The axis the verse offers is the only one on which it registers at all.',
  'यह श्लोक की कसौटी उस जगह पर है जहाँ इसे लगाना सबसे कठिन है, क्योंकि यहाँ ज़हर मेहनत नहीं है — यह किसी अपने के साथ बीती एक बुरी शाम की ख़ास तकलीफ़ है। उस शाम में कुछ भी प्रगति जैसा नहीं लगा। श्लोक जो कसौटी देता है वही इकलौती है जिस पर वह दर्ज होती है।',
  'Yeh shloka ki kasauti us jagah par hai jahan ise lagana sabse mushkil hai, kyunki yahan zeher mehnat nahi hai — yeh kisi apne ke saath beeti ek buri shaam ki khaas takleef hai. Us shaam mein kuch bhi pragati jaisa nahi laga. Shloka jo kasauti deta hai wahi iklauti hai jis par woh darj hoti hai.',
  'Nothing about that evening felt like progress. On the only axis that matters, it was the whole of it.',
  'उस शाम में कुछ भी प्रगति जैसा नहीं लगा। जो इकलौती कसौटी मायने रखती है, उस पर वही सब कुछ थी।',
  'Us shaam mein kuch bhi pragati jaisa nahi laga. Jo iklauti kasauti maayne rakhti hai, us par wahi sab kuch thi.',
  NULL, 'intermediate', 'relationships,difficult-conversations,repair,patience,honesty'

  UNION ALL SELECT 37, 'social_media', 3,
  'Nectar first', 'पहले अमृत', 'Pehle amrit',
  'Somebody describes a habit they have: twenty minutes of something enjoyable before bed that leaves them, reliably, slightly worse than before. They can predict this. They have predicted it accurately for about two years. The prediction has never once altered the twenty minutes.',
  'कोई अपनी एक आदत बताता है: सोने से पहले बीस मिनट कुछ ऐसा जो अच्छा लगता है और जो उसे भरोसे के साथ पहले से थोड़ा ख़राब हालत में छोड़ जाता है। वह इसका अनुमान लगा सकता है। वह क़रीब दो साल से सही अनुमान लगा रहा है। उस अनुमान ने उन बीस मिनटों को एक बार भी नहीं बदला।',
  'Koi apni ek aadat batata hai: sone se pehle bees minute kuch aisa jo achha lagta hai aur jo use bharose ke saath pehle se thoda kharab haalat mein chhod jaata hai. Woh iska anuman laga sakta hai. Woh karib do saal se sahi anuman laga raha hai. Us anuman ne un bees minuton ko ek baar bhi nahi badla.',
  'The verse describes both directions and the next one describes this — pleasant at the start, the other thing afterwards. The honest finding here is that knowing which kind something is does not by itself move anybody, which is why the chapter puts the classification next to a discussion of what actually changes conduct rather than treating the classification as the answer.',
  'श्लोक दोनों दिशाएँ बताता है और अगला यही बताता है — शुरू में सुखद, बाद में दूसरी बात। यहाँ ईमानदार निष्कर्ष यह है कि किसी चीज़ की तरह जान लेना अपने आप किसी को हिलाता नहीं, और इसीलिए अध्याय इस वर्गीकरण को उसके बग़ल में रखता है कि बरताव असल में बदलता किससे है — वर्गीकरण को ही जवाब नहीं मान लेता।',
  'Shloka dono dishayein batata hai aur agla yahi batata hai — shuru mein sukhad, baad mein doosri baat. Yahan imaandar nishkarsh yeh hai ki kisi cheez ki tarah jaan lena apne aap kisi ko hilata nahi, aur isiliye chapter is vargikaran ko uske bagal mein rakhta hai ki bartav asal mein badalta kisse hai — vargikaran ko hi jawab nahi maan leta.',
  'Knowing which kind it is does not move anybody by itself. The classification is a description, not a lever.',
  'यह जान लेना कि वह किस तरह की है, अपने आप किसी को नहीं हिलाता। वर्गीकरण वर्णन है, कोई लीवर नहीं।',
  'Yeh jaan lena ki woh kis tarah ki hai, apne aap kisi ko nahi hilata. Vargikaran varnan hai, koi lever nahi.',
  NULL, 'intermediate', 'habits,evenings,self-knowledge,pleasure,honesty'

  UNION ALL SELECT 48, 'healthcare', 1,
  'The rota nobody could fix', 'वह ड्यूटी-सूची जिसे कोई ठीक नहीं कर सका', 'Woh duty-list jise koi theek nahi kar saka',
  'A senior nurse spends four years trying to get a rota changed that she believes is unsafe. It is improved twice and remains, in her view, wrong. She does not leave. Asked why she stays somewhere she can describe the fault in so precisely, she says the fault is describable everywhere she could go and here she knows where it is.',
  'एक वरिष्ठ नर्स चार साल एक ड्यूटी-सूची बदलवाने में लगाती हैं जिसे वे असुरक्षित मानती हैं। उसमें दो बार सुधार होता है और उनकी नज़र में वह अब भी ग़लत है। वे नौकरी नहीं छोड़तीं। पूछने पर कि जहाँ की ख़ामी वे इतनी सटीकता से बता सकती हैं वहीं क्यों रुकी हैं, वे कहती हैं कि ख़ामी हर उस जगह बताई जा सकती है जहाँ वे जा सकती हैं, और यहाँ उन्हें पता है कि वह कहाँ है।',
  'Ek varishth nurse chaar saal ek duty-list badalwane mein lagati hain jise woh asurakshit maanti hain. Usme do baar sudhaar hota hai aur unki nazar mein woh ab bhi galat hai. Woh naukri nahi chhodtin. Poochne par ki jahan ki khami woh itni sateekta se bata sakti hain wahin kyun ruki hain, woh kehti hain ki khami har us jagah batayi ja sakti hai jahan woh ja sakti hain, aur yahan unhe pata hai ki woh kahan hai.',
  'This is what the verse licenses and it is worth being exact. She did not accept the fault; she has spent four years on it and is still on it. What she declined was the idea that the fault is a reason to go. Fire and smoke: the smoke is real, it is being looked at directly, and it is not evidence that the fire is the wrong fire.',
  'श्लोक इसी की इजाज़त देता है और इस पर सटीक होना ज़रूरी है। उन्होंने ख़ामी मानी नहीं; वे चार साल उस पर लगा चुकी हैं और अब भी लगी हैं। उन्होंने जिसे ठुकराया वह यह विचार था कि ख़ामी जाने की वजह है। आग और धुआँ: धुआँ असली है, उसे सीधे देखा जा रहा है, और वह इस बात का सबूत नहीं है कि आग ग़लत आग है।',
  'Shloka isi ki ijazat deta hai aur is par sateek hona zaroori hai. Unhone khami maani nahi; woh chaar saal us par laga chuki hain aur ab bhi lagi hain. Unhone jise thukraya woh yeh vichar tha ki khami jaane ki wajah hai. Aag aur dhuan: dhuan asli hai, use seedhe dekha ja raha hai, aur woh is baat ka saboot nahi hai ki aag galat aag hai.',
  'She did not accept the fault. She declined the idea that a fault is by itself a reason to leave.',
  'उन्होंने ख़ामी मानी नहीं। उन्होंने यह विचार ठुकराया कि ख़ामी अपने आप में जाने की वजह है।',
  'Unhone khami maani nahi. Unhone yeh vichar thukraya ki khami apne aap mein jaane ki wajah hai.',
  NULL, 'advanced', 'health,work,systems,staying,integrity'

  UNION ALL SELECT 48, 'ethics', 2,
  'The clean option that was not on offer', 'वह साफ़ विकल्प जो था ही नहीं', 'Woh saaf option jo tha hi nahi',
  'A small charity has to choose between two suppliers. One is cheaper and has a labour record nobody is comfortable with. The other costs enough that a programme closes. The board spends three meetings looking for a third option and there is not one. They choose, write down why, write down what they are not happy about, and put a review date on it.',
  'एक छोटी संस्था को दो आपूर्तिकर्ताओं में से चुनना है। एक सस्ता है और उसका श्रम-रिकॉर्ड ऐसा है जिससे कोई सहज नहीं। दूसरा इतना महँगा है कि एक कार्यक्रम बंद हो जाएगा। समिति तीन बैठकें तीसरा विकल्प ढूँढ़ने में लगाती है और ऐसा कोई है नहीं। वे चुनते हैं, वजह लिखते हैं, यह भी लिखते हैं कि किस बात से वे ख़ुश नहीं हैं, और उस पर दोबारा देखने की तारीख़ डाल देते हैं।',
  'Ek chhoti sanstha ko do suppliers mein se chunna hai. Ek sasta hai aur uska labour record aisa hai jisse koi sahaj nahi. Doosra itna mehnga hai ki ek programme band ho jayega. Committee teen meeting teesra option dhoondhne mein lagati hai aur aisa koi hai nahi. Woh chunte hain, wajah likhte hain, yeh bhi likhte hain ki kis baat se woh khush nahi hain, aur us par dobara dekhne ki tareekh daal dete hain.',
  'Every part of this is what the verse licenses and none of it is what the verse is misused for. They looked for the clean option first. They named the fault out loud rather than around it. They wrote it down, which means somebody can hold them to it. And they put a date on revisiting it, which is the difference between accepting a fault and living with it deliberately.',
  'इसका हर हिस्सा वही है जिसकी श्लोक इजाज़त देता है और कोई भी हिस्सा वह नहीं जिसके लिए श्लोक का दुरुपयोग होता है। उन्होंने पहले साफ़ विकल्प ढूँढ़ा। उन्होंने ख़ामी का नाम लिया, उसके इर्द-गिर्द नहीं घूमे। उन्होंने उसे लिखा, यानी कोई उन्हें उस पर पकड़ सकता है। और उन्होंने दोबारा देखने की तारीख़ डाली, जो ख़ामी मान लेने और उसके साथ जानबूझकर जीने का फ़र्क़ है।',
  'Iska har hissa wahi hai jiski shloka ijazat deta hai aur koi bhi hissa woh nahi jiske liye shloka ka durupyog hota hai. Unhone pehle saaf option dhoondha. Unhone khami ka naam liya, uske ird-gird nahi ghoome. Unhone use likha, yaani koi unhe us par pakad sakta hai. Aur unhone dobara dekhne ki tareekh daali, jo khami maan lene aur uske saath jaanboojhkar jeene ka farq hai.',
  'Naming the fault, writing it down and dating a review is the difference between living with one and hiding behind this verse.',
  'ख़ामी का नाम लेना, उसे लिखना और दोबारा देखने की तारीख़ डालना — यही फ़र्क़ है उसके साथ जीने और इस श्लोक के पीछे छिपने में।',
  'Khami ka naam lena, use likhna aur dobara dekhne ki tareekh daalna — yahi farq hai uske saath jeene aur is shloka ke peechhe chhipne mein.',
  NULL, 'advanced', 'ethics,decisions,compromise,accountability,work'

  UNION ALL SELECT 48, 'everyday_life', 3,
  'The letter that was never good enough', 'वह चिट्ठी जो कभी अच्छी नहीं हुई', 'Woh chitthi jo kabhi achhi nahi hui',
  'Somebody needs to write to a relative they have not spoken to in six years. They draft it eleven times over four months, and every version has something in it they can see is wrong — too cold, too much, too late, too much about themselves. The twelfth version is not better than the fourth. They send the fourth.',
  'किसी को एक रिश्तेदार को लिखना है जिससे छह साल से बात नहीं हुई। वह चार महीनों में ग्यारह बार मसौदा बनाता है, और हर रूप में कुछ ऐसा है जो उसे ग़लत दिखता है — बहुत ठंडा, बहुत ज़्यादा, बहुत देर से, अपने ही बारे में बहुत। बारहवाँ रूप चौथे से बेहतर नहीं है। वह चौथा भेज देता है।',
  'Kisi ko ek rishtedar ko likhna hai jisse chhah saal se baat nahi hui. Woh chaar mahinon mein gyarah baar masauda banata hai, aur har roop mein kuch aisa hai jo use galat dikhta hai — bahut thanda, bahut zyada, bahut der se, apne hi baare mein bahut. Barahwa roop chauthe se behtar nahi hai. Woh chautha bhej deta hai.',
  'Four months of looking for the version without smoke. The verse''s claim is that there was not one, and the eleven drafts are the evidence rather than the counter-example. What ends it is not finding a clean letter; it is accepting that the fault in the fourth draft is the price of the letter existing at all.',
  'चार महीने उस रूप की तलाश में जिसमें धुआँ न हो। श्लोक का दावा है कि ऐसा कोई था ही नहीं, और वे ग्यारह मसौदे उल्टा उदाहरण नहीं, सबूत हैं। इसे ख़त्म कोई साफ़ चिट्ठी मिलने से नहीं होता; यह मान लेने से होता है कि चौथे मसौदे की ख़ामी ही उस चिट्ठी के होने की क़ीमत है।',
  'Chaar mahine us roop ki talash mein jisme dhuan na ho. Shloka ka dawa hai ki aisa koi tha hi nahi, aur woh gyarah masaude ulta udaharan nahi, saboot hain. Ise khatam koi saaf chitthi milne se nahi hota; yeh maan lene se hota hai ki chauthe masaude ki khami hi us chitthi ke hone ki keemat hai.',
  'The eleven drafts are the evidence, not the counter-example. There was never going to be a clean one.',
  'वे ग्यारह मसौदे सबूत हैं, उल्टा उदाहरण नहीं। साफ़ वाला कभी होने ही नहीं वाला था।',
  'Woh gyarah masaude saboot hain, ulta udaharan nahi. Saaf wala kabhi hone hi nahi wala tha.',
  NULL, 'beginner', 'family,writing,perfectionism,reconciliation,starting'

  UNION ALL SELECT 59, 'everyday_life', 1,
  'Never again, on a Thursday', 'दोबारा कभी नहीं, किसी गुरुवार को', 'Dobara kabhi nahi, kisi Thursday ko',
  'Somebody announces to two friends that they are done with a particular thing — said seriously, with reasons, at a moment when it was entirely true. Nine days later they do it again, and the reasons available on the day are good ones. Both friends notice. Neither says anything, and the person''s own account of it afterwards does not mention the announcement.',
  'कोई दो दोस्तों से ऐलान करता है कि वह एक ख़ास चीज़ अब नहीं करेगा — गंभीरता से कहा गया, वजहों के साथ, ऐसे क्षण में जब यह पूरी तरह सच था। नौ दिन बाद वह फिर करता है, और उस दिन जो वजहें उपलब्ध हैं वे अच्छी हैं। दोनों दोस्त देखते हैं। कोई कुछ नहीं कहता, और बाद में उस व्यक्ति का अपना बयान उस ऐलान का ज़िक्र तक नहीं करता।',
  'Koi do doston se elaan karta hai ki woh ek khaas cheez ab nahi karega — gambhirta se kaha gaya, wajahon ke saath, aise pal mein jab yeh poori tarah sach tha. Nau din baad woh phir karta hai, aur us din jo wajahein uplabdh hain woh achhi hain. Dono dost dekhte hain. Koi kuch nahi kehta, aur baad mein us insaan ka apna bayan us elaan ka zikr tak nahi karta.',
  'The verse says a resolve resting on your picture of yourself will not hold, and the giveaway here is the third sentence — the reasons available on the day were good ones. That is what the failure looks like from inside. Not weakness recognised, but a fresh and entirely sincere argument.',
  'श्लोक कहता है कि अपनी तस्वीर पर टिका संकल्प टिकेगा नहीं, और यहाँ निशानी तीसरा वाक्य है — उस दिन जो वजहें उपलब्ध थीं वे अच्छी थीं। भीतर से नाकामी ऐसी ही दिखती है। कमज़ोरी पहचानी हुई नहीं, बल्कि एक ताज़ा और पूरी तरह सच्ची दलील।',
  'Shloka kehta hai ki apni tasveer par tika sankalp tikega nahi, aur yahan nishani teesra vakya hai — us din jo wajahein uplabdh thi woh achhi thi. Bheetar se nakami aisi hi dikhti hai. Kamzori pehchani hui nahi, balki ek taza aur poori tarah sachchi dalil.',
  'From inside, the resolve does not fail. A better reason simply arrives.',
  'भीतर से संकल्प टूटता नहीं। बस एक बेहतर वजह आ जाती है।',
  'Bheetar se sankalp tootta nahi. Bas ek behtar wajah aa jaati hai.',
  NULL, 'beginner', 'habits,promises,self-image,honesty,friends'

  UNION ALL SELECT 59, 'corporate', 2,
  'The resignation that was drafted eight times', 'वह इस्तीफ़ा जो आठ बार लिखा गया', 'Woh resignation jo aath baar likha gaya',
  'A manager decides she is leaving, and tells herself so clearly and often for eleven months. She writes the letter eight times. She does not leave. When she eventually does go, it is not because the decision finally held — it is because a specific role appeared and somebody asked her to take it.',
  'एक मैनेजर तय करती हैं कि वे जा रही हैं, और ग्यारह महीने तक ख़ुद से यह साफ़ और बार-बार कहती हैं। वे चिट्ठी आठ बार लिखती हैं। वे जाती नहीं। जब वे आख़िरकार जाती हैं, तो इसलिए नहीं कि फ़ैसला आख़िर टिक गया — बल्कि इसलिए कि एक ख़ास पद सामने आया और किसी ने उन्हें लेने को कहा।',
  'Ek manager tay karti hain ki woh ja rahi hain, aur gyarah mahine tak khud se yeh saaf aur baar-baar kehti hain. Woh chitthi aath baar likhti hain. Woh jaati nahi. Jab woh aakhirkar jaati hain, to isliye nahi ki faisla aakhir tik gaya — balki isliye ki ek khaas pad saamne aaya aur kisi ne unhe lene ko kaha.',
  'The decision never did the work. Eleven months of holding it produced eight drafts and no departure; what produced the departure was a change in circumstances. The verse is unsentimental about this and it is not an insult — it is a claim about how much weight a resolve can carry on its own, and the honest answer is less than most people plan around.',
  'फ़ैसले ने कभी काम किया ही नहीं। ग्यारह महीने उसे थामे रहने से आठ मसौदे निकले और जाना नहीं; जाना हालात के बदलने से निकला। श्लोक इस पर भावुक नहीं होता और यह अपमान भी नहीं है — यह इस बारे में दावा है कि कोई संकल्प अकेले कितना वज़न उठा सकता है, और ईमानदार जवाब उससे कम है जितने पर ज़्यादातर लोग योजना बनाते हैं।',
  'Faisle ne kabhi kaam kiya hi nahi. Gyarah mahine use thame rehne se aath masaude nikle aur jaana nahi; jaana haalat ke badalne se nikla. Shloka is par bhavuk nahi hota aur yeh apmaan bhi nahi hai — yeh is baare mein dawa hai ki koi sankalp akele kitna wazan utha sakta hai, aur imaandar jawab usse kam hai jitne par zyadatar log yojna banate hain.',
  'A resolve on its own carries less weight than most people plan around. Circumstances did the work.',
  'अकेला संकल्प उतना वज़न नहीं उठाता जितने पर ज़्यादातर लोग योजना बनाते हैं। काम हालात ने किया।',
  'Akela sankalp utna wazan nahi uthata jitne par zyadatar log yojna banate hain. Kaam haalat ne kiya.',
  NULL, 'intermediate', 'work,decisions,resolve,change,circumstances'

  UNION ALL SELECT 59, 'ethics', 3,
  'Sitting it out', 'अलग रहना', 'Alag rehna',
  'A committee member decides not to take a side on a contested decision, on the grounds that it is not really his to take. He abstains. The abstention changes the threshold and the decision goes one way rather than the other. Two years later he describes himself as having stayed out of it, which is how it felt and is not what happened.',
  'एक समिति सदस्य किसी विवादित फ़ैसले में पक्ष न लेने का तय करते हैं, इस आधार पर कि यह सचमुच उनका लेने का है ही नहीं। वे मतदान से अलग रहते हैं। इस अलग रहने से सीमा बदल जाती है और फ़ैसला एक तरफ़ चला जाता है, दूसरी तरफ़ नहीं। दो साल बाद वे ख़ुद को यह बताते हैं कि वे इससे अलग रहे — जो महसूस वैसा ही हुआ था और जो हुआ वह नहीं है।',
  'Ek committee member kisi vivadit faisle mein paksh na lene ka tay karte hain, is aadhar par ki yeh sach mein unka lene ka hai hi nahi. Woh matdan se alag rehte hain. Is alag rehne se seema badal jaati hai aur faisla ek taraf chala jaata hai, doosri taraf nahi. Do saal baad woh khud ko yeh batate hain ki woh isse alag rahe — jo mehsoos waisa hi hua tha aur jo hua woh nahi hai.',
  'The verse and 3.5 meet here. His decision not to act was sincere and it was also an act, with a countable effect on the outcome. What did not survive was the idea that stepping back is a position outside the thing. Nature, here in the ordinary form of arithmetic, put him back in it.',
  'श्लोक और 3.5 यहीं मिलते हैं। काम न करने का उनका फ़ैसला सच्चा था और वह भी एक काम था, जिसका नतीजे पर गिना जा सकने वाला असर हुआ। जो नहीं टिका वह यह विचार था कि पीछे हट जाना उस चीज़ के बाहर की कोई स्थिति है। प्रकृति ने, यहाँ गणित के साधारण रूप में, उन्हें वापस उसी में डाल दिया।',
  'Shloka aur 3.5 yahin milte hain. Kaam na karne ka unka faisla sachcha tha aur woh bhi ek kaam tha, jiska nateeje par gina ja sakne wala asar hua. Jo nahi tika woh yeh vichar tha ki peechhe hat jaana us cheez ke bahar ki koi sthiti hai. Prakriti ne, yahan ganit ke sadharan roop mein, unhe wapas usi mein daal diya.',
  'Stepping back felt like a position outside the thing. Arithmetic disagreed.',
  'पीछे हटना उस चीज़ के बाहर की स्थिति जैसा लगा। गणित असहमत था।',
  'Peechhe hatna us cheez ke bahar ki sthiti jaisa laga. Ganit asahmat tha.',
  NULL, 'advanced', 'decisions,abstention,responsibility,committees,consequences'

  UNION ALL SELECT 63, 'everyday_life', 1,
  'The teacher who stopped talking', 'वह शिक्षक जिसने बोलना बंद कर दिया', 'Woh teacher jisne bolna band kar diya',
  'A student who has been taught intensively for two years asks a question at the end of the last session, expecting the usual answer. The teacher says what she thinks, at some length and without hedging, and then says that the student now knows everything she does about it and should do whatever he judges best. He describes that as the moment the two years actually landed.',
  'दो साल तक गहन पढ़ाई करने वाला एक छात्र आख़िरी सत्र के अंत में एक सवाल पूछता है, हमेशा वाले जवाब की उम्मीद में। शिक्षिका अपनी राय बताती हैं, विस्तार से और बिना किसी हिचक के, और फिर कहती हैं कि छात्र अब इस बारे में उतना ही जानता है जितना वे, और उसे वही करना चाहिए जो वह ठीक समझे। वह बताता है कि दो साल असल में उसी क्षण उतरे।',
  'Do saal tak gehan padhai karne wala ek student aakhiri session ke ant mein ek sawaal poochta hai, hamesha wale jawab ki ummeed mein. Teacher apni raay batati hain, vistar se aur bina kisi hichak ke, aur phir kehti hain ki student ab is baare mein utna hi jaanta hai jitna woh, aur use wahi karna chahiye jo woh theek samjhe. Woh batata hai ki do saal asal mein usi pal utre.',
  'This is the verse''s exact shape and the order is the whole thing. She did not withhold her view — she gave it fully and without softening. Then she handed over the decision. Doing only the first is instruction; doing only the second is abdication; the verse does both, in that order, and so does she.',
  'यह श्लोक का ठीक-ठीक आकार है और क्रम ही पूरी बात है। उन्होंने अपनी राय रोकी नहीं — उन्होंने पूरी दी, बिना नरम किए। फिर फ़ैसला सौंप दिया। सिर्फ़ पहला करना हिदायत है; सिर्फ़ दूसरा करना पल्ला झाड़ना है; श्लोक दोनों करता है, उसी क्रम में, और वे भी।',
  'Yeh shloka ka theek-theek aakar hai aur kram hi poori baat hai. Unhone apni raay roki nahi — unhone poori di, bina naram kiye. Phir faisla saunp diya. Sirf pehla karna hidayat hai; sirf doosra karna palla jhaadna hai; shloka dono karta hai, usi kram mein, aur woh bhi.',
  'Giving the view fully and then handing over the decision. Either half alone is a different and lesser thing.',
  'अपनी राय पूरी देना और फिर फ़ैसला सौंप देना। इनमें से कोई एक आधा अकेले अलग और कमतर चीज़ है।',
  'Apni raay poori dena aur phir faisla saunp dena. Inme se koi ek aadha akele alag aur kamtar cheez hai.',
  NULL, 'beginner', 'teaching,autonomy,advice,respect,endings'

  UNION ALL SELECT 63, 'healthcare', 2,
  'The consultation that ended with a choice', 'वह परामर्श जो एक चुनाव पर ख़त्म हुआ', 'Woh consultation jo ek chunav par khatam hua',
  'A patient with two viable treatment options is given both, with the doctor''s honest opinion about which he would choose and why, and then told that it is her decision and that he will support either. She chooses the other one. He does support it, without a single reference back to his preference over the following eighteen months.',
  'एक मरीज़ के सामने इलाज के दो चलने लायक विकल्प हैं। डॉक्टर दोनों बताते हैं, साथ में अपनी ईमानदार राय भी कि वे कौन-सा चुनते और क्यों, और फिर कहते हैं कि फ़ैसला उनका है और वे किसी भी विकल्प में साथ देंगे। वे दूसरा चुनती हैं। वे साथ देते हैं, और अगले अठारह महीनों में एक बार भी अपनी पसंद का ज़िक्र नहीं करते।',
  'Ek mareez ke saamne ilaaj ke do chalne layak option hain. Doctor dono batate hain, saath mein apni imaandar raay bhi ki woh kaun sa chunte aur kyun, aur phir kehte hain ki faisla unka hai aur woh kisi bhi option mein saath denge. Woh doosra chunti hain. Woh saath dete hain, aur agle atharah mahinon mein ek baar bhi apni pasand ka zikr nahi karte.',
  'The eighteen months are the part that makes this the verse rather than an imitation of it. Handing over a decision and then spending a year and a half being quietly right about it is not handing over a decision. The line ends with do as you wish and nothing after it takes it back.',
  'अठारह महीने ही वह हिस्सा हैं जो इसे नक़ल नहीं, श्लोक बनाते हैं। फ़ैसला सौंपकर फिर डेढ़ साल चुपचाप सही बने रहना फ़ैसला सौंपना नहीं है। पंक्ति "जो चाहें कीजिए" पर ख़त्म होती है और उसके बाद कुछ भी उसे वापस नहीं लेता।',
  'Atharah mahine hi woh hissa hain jo ise nakal nahi, shloka banate hain. Faisla saunpkar phir dedh saal chupchap sahi bane rehna faisla saunpna nahi hai. Line "jo chaho karo" par khatam hoti hai aur uske baad kuch bhi use wapas nahi leta.',
  'Handing over a decision and then being quietly right about it for a year is not handing over a decision.',
  'फ़ैसला सौंपकर फिर साल भर चुपचाप सही बने रहना फ़ैसला सौंपना नहीं है।',
  'Faisla saunpkar phir saal bhar chupchap sahi bane rehna faisla saunpna nahi hai.',
  NULL, 'intermediate', 'health,autonomy,decisions,respect,doctors'

  UNION ALL SELECT 63, 'parenting', 3,
  'Eighteen years of arguing, and then', 'अठारह साल की बहस, और फिर', 'Atharah saal ki behes, aur phir',
  'A parent who has argued with their child about everything for eighteen years — genuinely argued, with reasons, not shouted — reaches a decision they think is wrong and says so completely, once. Then they say it is not theirs to make and they mean it. The child makes the decision the parent thinks is wrong. They remain close.',
  'एक अभिभावक जिन्होंने अठारह साल अपने बच्चे से हर बात पर बहस की है — सचमुच बहस, वजहों के साथ, चिल्लाकर नहीं — ऐसे फ़ैसले पर पहुँचते हैं जिसे वे ग़लत मानते हैं और एक बार, पूरी तरह, कह देते हैं। फिर कहते हैं कि यह फ़ैसला उनका करने का नहीं है, और वे यह सचमुच मानते हैं। बच्चा वही फ़ैसला करता है जिसे अभिभावक ग़लत मानते हैं। दोनों क़रीब बने रहते हैं।',
  'Ek parent jinhone atharah saal apne bachche se har baat par behes ki hai — sach mein behes, wajahon ke saath, chillakar nahi — aise faisle par pahunchte hain jise woh galat maante hain aur ek baar, poori tarah, keh dete hain. Phir kehte hain ki yeh faisla unka karne ka nahi hai, aur woh yeh sach mein maante hain. Bachcha wahi faisla karta hai jise parent galat maante hain. Dono karib bane rehte hain.',
  'Eighteen years of argument followed by a handover is the shape of the whole book, compressed into one household. The arguing was not a failure of the handover and the handover does not cancel the arguing. That both can be true at once is the thing this verse establishes, and it is the reason a text this insistent can end by saying do what you want.',
  'अठारह साल की बहस और उसके बाद फ़ैसला सौंप देना — यह पूरी किताब का आकार है, एक घर में सिमटा हुआ। बहस सौंपने की नाकामी नहीं थी और सौंपना बहस को रद्द नहीं करता। दोनों एक साथ सच हो सकते हैं — यही यह श्लोक स्थापित करता है, और यही वजह है कि इतना ज़ोर देने वाला ग्रंथ अंत में यह कह सकता है कि जो चाहें कीजिए।',
  'Atharah saal ki behes aur uske baad faisla saunp dena — yeh poori kitaab ka aakar hai, ek ghar mein simta hua. Behes saunpne ki nakami nahi thi aur saunpna behes ko radd nahi karta. Dono ek saath sach ho sakte hain — yahi yeh shloka sthapit karta hai, aur yahi wajah hai ki itna zor dene wala granth ant mein yeh keh sakta hai ki jo chaho karo.',
  'Arguing hard and then handing the decision over are not in conflict. The whole book is that shape.',
  'ज़ोर से बहस करना और फिर फ़ैसला सौंप देना — इनमें टकराव नहीं है। पूरी किताब का आकार यही है।',
  'Zor se behes karna aur phir faisla saunp dena — inme takrav nahi hai. Poori kitaab ka aakar yahi hai.',
  NULL, 'intermediate', 'family,autonomy,disagreement,respect,adulthood'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 18;

-- =====================================================================
-- 5. CROSS REFERENCES
-- =====================================================================
-- This is the chapter that closes the arcs, so it carries more of these
-- than any other and almost all of them point backwards. A reader who
-- reaches 18.11 having read 2.47, or 18.16 having read 3.27, is having
-- a different experience from one who has not, and these links are how
-- that gets built.
--
-- FOURTEEN DECLARED. Count the loaded rows against that number before
-- shipping — a reference to an unseeded verse vanishes silently.
-- =====================================================================

DELETE x FROM verse_cross_references x JOIN verses v ON v.id = x.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 18;

INSERT INTO verse_cross_references
  (verse_id, reference_type, book, chapter, verse, target_verse_id,
   description_en, description_hi, description_hinglish, relationship, sort_order)
SELECT v.id, 'gita', 'Bhagavad Gita', CAST(x.tch AS CHAR), CAST(x.tvn AS CHAR), tv.id,
       x.d_en, x.d_hi, x.d_hing, x.rel, x.ord
FROM (
  SELECT 11 AS vn, 2 AS tch, 47 AS tvn, 1 AS ord,
    'The instruction, and the definition it was working towards. 2.47 says drop the fruit; 18.11 says that dropping IS what the word for renunciation means.' AS d_en,
    'हिदायत, और वह परिभाषा जिसकी तरफ़ वह जा रही थी। 2.47 कहता है फल छोड़िए; 18.11 कहता है कि यही छोड़ना ही त्याग शब्द का अर्थ है।' AS d_hi,
    'Hidayat, aur woh paribhasha jiski taraf woh ja rahi thi. 2.47 kehta hai phal chhodo; 18.11 kehta hai ki yahi chhodna hi tyag shabd ka arth hai.' AS d_hing,
    'same' AS rel
  UNION ALL SELECT 11, 3, 8, 2,
    'Chapter 3 argued that withdrawal is not available. Chapter 18 defines the word people use for withdrawal in a way that agrees.',
    'तीसरे अध्याय ने कहा था कि पीछे हटना उपलब्ध नहीं है। अठारहवाँ उस शब्द को ही ऐसे परिभाषित करता है जो इससे मेल खाता है।',
    'Teesre chapter ne kaha tha ki peechhe hatna uplabdh nahi hai. Atharahwa us shabd ko hi aise paribhashit karta hai jo isse mel khata hai.',
    'supports'
  UNION ALL SELECT 11, 12, 12, 3,
    'Letting go of the fruit was the top of the ladder there. Here it is the definition of the word.',
    'वहाँ फल छोड़ना सीढ़ी का सिरा था। यहाँ वही शब्द की परिभाषा है।',
    'Wahan phal chhodna seedhi ka sira tha. Yahan wahi shabd ki paribhasha hai.',
    'same'
  UNION ALL SELECT 14, 3, 27, 1,
    'Nature does the work and the ego signs the receipt. This is the same claim with the parts itemised.',
    'काम प्रकृति करती है और रसीद पर दस्तख़त अहंकार करता है। यह वही दावा है, हिस्से गिनाकर।',
    'Kaam prakriti karti hai aur receipt par dastkhat ahankaar karta hai. Yeh wahi dawa hai, hisse ginakar.',
    'same'
  UNION ALL SELECT 16, 3, 27, 1,
    'The two verses that say the same thing eleven chapters apart. 3.27 calls it confusion; 18.16 calls it not looking carefully, which is the more useful of the two.',
    'दो श्लोक जो ग्यारह अध्याय के अंतर पर एक ही बात कहते हैं। 3.27 इसे मोह कहता है; 18.16 इसे ध्यान से न देखना कहता है, जो दोनों में ज़्यादा काम का है।',
    'Do shloka jo gyarah chapter ke antar par ek hi baat kehte hain. 3.27 ise moh kehta hai; 18.16 ise dhyan se na dekhna kehta hai, jo dono mein zyada kaam ka hai.',
    'same'
  UNION ALL SELECT 16, 18, 14, 2,
    'Read the list of five first. This verse is stated as a conclusion drawn from it and does not stand on its own.',
    'पहले पाँच की सूची पढ़िए। यह श्लोक उसी से निकाले गए निष्कर्ष की तरह रखा गया है और अकेले खड़ा नहीं होता।',
    'Pehle paanch ki list padho. Yeh shloka usi se nikale gaye nishkarsh ki tarah rakha gaya hai aur akele khada nahi hota.',
    'supports'
  UNION ALL SELECT 32, 16, 4, 1,
    'The same family, and the same misuse. Both describe a state a mind can be in, and neither describes a kind of person.',
    'वही परिवार, और वही दुरुपयोग। दोनों उस अवस्था का वर्णन करते हैं जिसमें कोई मन हो सकता है, और कोई भी किसी तरह के व्यक्ति का वर्णन नहीं करता।',
    'Wahi parivar, aur wahi durupyog. Dono us avastha ka varnan karte hain jisme koi man ho sakta hai, aur koi bhi kisi tarah ke insaan ka varnan nahi karta.',
    'same'
  UNION ALL SELECT 37, 2, 14, 1,
    'Endure the coming and going, says 2.14. This says which of the things worth enduring can be told apart from the things not worth it, and how.',
    '2.14 कहता है कि आने-जाने को सह जाइए। यह बताता है कि सहने लायक चीज़ों को न सहने लायक से अलग कैसे पहचाना जाए।',
    '2.14 kehta hai ki aane-jaane ko seh jao. Yeh batata hai ki sehne layak cheezon ko na sehne layak se alag kaise pehchana jaaye.',
    'supports'
  UNION ALL SELECT 37, 12, 12, 2,
    'Peace immediately, from letting go. Here the good kind of happiness is traced to the same source — your own understanding settling, not the thing itself.',
    'छोड़ने से शांति तुरंत। यहाँ अच्छे सुख का स्रोत भी वही बताया गया है — आपकी अपनी समझ का बैठ जाना, वह चीज़ नहीं।',
    'Chhodne se shanti turant. Yahan achhe sukh ka srot bhi wahi bataya gaya hai — tumhari apni samajh ka baith jaana, woh cheez nahi.',
    'supports'
  UNION ALL SELECT 48, 12, 16, 1,
    'The same word, sarvārambha, in both verses. 12.16 says give up the starting; 18.48 says every starting has fault in it. Read together they rule out both the compulsive beginner and the person waiting for a clean beginning.',
    'दोनों श्लोकों में वही शब्द, सर्वारम्भ। 12.16 कहता है शुरू करना छोड़िए; 18.48 कहता है हर शुरुआत में दोष है। साथ पढ़ें तो दोनों बाहर हो जाते हैं — बार-बार शुरू करने वाला भी, और साफ़ शुरुआत का इंतज़ार करने वाला भी।',
    'Dono shlokon mein wahi shabd, sarvarambha. 12.16 kehta hai shuru karna chhodo; 18.48 kehta hai har shuruaat mein dosh hai. Saath padho to dono bahar ho jaate hain — baar-baar shuru karne wala bhi, aur saaf shuruaat ka intezaar karne wala bhi.',
    'supports'
  UNION ALL SELECT 48, 3, 35, 2,
    'Your own work done imperfectly, and the work that came with you kept despite its fault. The same argument, and 3.35 carries the warning about how it has been misused.',
    'अपना काम अधूरे ढंग से किया हुआ, और साथ आया काम अपने दोष के बावजूद थामा हुआ। वही दलील, और 3.35 वह चेतावनी उठाता है कि इसका दुरुपयोग कैसे हुआ है।',
    'Apna kaam adhoore dhang se kiya hua, aur saath aaya kaam apne dosh ke bawajood thama hua. Wahi dalil, aur 3.35 woh chetavni uthata hai ki iska durupyog kaise hua hai.',
    'supports'
  UNION ALL SELECT 59, 3, 5, 1,
    'Nobody stays actionless for a moment. This is that stated to one specific frightened man, by name, about the specific thing he has just refused.',
    'कोई एक क्षण भी निष्क्रिय नहीं रहता। यह वही बात एक ख़ास डरे हुए आदमी से, नाम लेकर, उसी चीज़ के बारे में जिससे उसने अभी इनकार किया है।',
    'Koi ek pal bhi nishkriya nahi rehta. Yeh wahi baat ek khaas dare hue aadmi se, naam lekar, usi cheez ke baare mein jisse usne abhi inkaar kiya hai.',
    'same'
  UNION ALL SELECT 63, 2, 47, 1,
    'The first instruction in the book and the last word about it. Everything between them is argument, and this verse says the argument was never a command.',
    'किताब की पहली हिदायत और उस पर आख़िरी शब्द। दोनों के बीच सब दलील है, और यह श्लोक कहता है कि वह दलील कभी आदेश थी ही नहीं।',
    'Kitaab ki pehli hidayat aur us par aakhiri shabd. Dono ke beech sab dalil hai, aur yeh shloka kehta hai ki woh dalil kabhi aadesh thi hi nahi.',
    'supports'
  UNION ALL SELECT 63, 16, 5, 2,
    'Both are places where the speaker stops arguing and turns to the person. One says do not grieve; the other says now decide. Neither assesses him.',
    'दोनों वे जगहें हैं जहाँ वक्ता बहस रोककर व्यक्ति की तरफ़ मुड़ते हैं। एक कहता है शोक मत करो; दूसरा कहता है अब तय कीजिए। कोई भी उसकी जाँच नहीं करता।',
    'Dono woh jagahein hain jahan vakta behes rokkar insaan ki taraf mudte hain. Ek kehta hai shok mat karo; doosra kehta hai ab tay karo. Koi bhi uski jaanch nahi karta.',
    'same'
) AS x
JOIN verses v  ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 18
JOIN chapters tc ON tc.chapter_number = x.tch
JOIN verses tv ON tv.verse_number = x.tvn AND tv.chapter_id = tc.id;

-- =====================================================================
-- 6. WORD BY WORD
-- =====================================================================

DELETE w FROM verse_word_meanings w JOIN verses v ON v.id = w.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 18;

INSERT INTO verse_word_meanings
  (verse_id, word_order, devanagari, transliteration,
   meaning_en, meaning_hi, meaning_hinglish, grammar, root_word)
SELECT v.id, w.ord, w.dev, w.tr, w.m_en, w.m_hi, w.m_hing, w.gram, w.root FROM (

  -- 18.11
  SELECT 11 AS vn, 1 AS ord, 'देहभृता' AS dev, 'deha-bhṛtā' AS tr, 'by one who carries a body' AS m_en, 'शरीर धारण करने वाले से' AS m_hi, 'sharir dharan karne wale se' AS m_hing, 'compound, instrumental' AS gram, 'भृ' AS root
  UNION ALL SELECT 11, 2, 'शक्यम्', 'śakyam', 'possible', 'संभव', 'sambhav', 'nominative singular', 'शक्'
  UNION ALL SELECT 11, 3, 'त्यक्तुम्', 'tyaktum', 'to give up', 'छोड़ना', 'chhodna', 'infinitive', 'त्यज्'
  UNION ALL SELECT 11, 4, 'अशेषतः', 'aśeṣataḥ', 'completely, without remainder', 'पूरी तरह, बिना कुछ बचाए', 'poori tarah, bina kuch bachaye', 'indeclinable', 'शिष्'
  UNION ALL SELECT 11, 5, 'कर्मफलत्यागी', 'karma-phala-tyāgī', 'one who gives up the fruit of action', 'कर्म का फल छोड़ने वाला', 'karm ka phal chhodne wala', 'compound, nominative', 'त्यज्'
  UNION ALL SELECT 11, 6, 'त्यागी', 'tyāgī', 'a tyāgī — the word being defined, and the definition rules out leaving', 'त्यागी — वही शब्द जिसे परिभाषित किया जा रहा है, और परिभाषा "छोड़कर जाना" को बाहर कर देती है', 'tyagi — wahi shabd jise paribhashit kiya ja raha hai, aur paribhasha "chhodkar jaana" ko bahar kar deti hai', 'nominative singular', 'त्यज्'
  UNION ALL SELECT 11, 7, 'अभिधीयते', 'abhidhīyate', 'is called, is named', 'कहा जाता है', 'kaha jaata hai', 'passive, third person', 'अभि + धा'

  -- 18.14
  UNION ALL SELECT 14, 1, 'अधिष्ठानम्', 'adhiṣṭhānam', 'the seat, the setting — where it takes place', 'अधिष्ठान — वह ज़मीन, वह जगह जहाँ हो रहा है', 'adhishthan — woh zameen, woh jagah jahan ho raha hai', 'nominative singular', 'अधि + स्था'
  UNION ALL SELECT 14, 2, 'कर्ता', 'kartā', 'the doer — one of five, not the list', 'कर्ता — पाँच में से एक, पूरी सूची नहीं', 'karta — paanch mein se ek, poori list nahi', 'nominative singular', 'कृ'
  UNION ALL SELECT 14, 3, 'करणम्', 'karaṇam', 'the instrument — whatever the doing is done with', 'करण — जिससे काम किया जाता है', 'karan — jisse kaam kiya jaata hai', 'nominative singular', 'कृ'
  UNION ALL SELECT 14, 4, 'पृथग्विधम्', 'pṛthag-vidham', 'of various separate kinds', 'अलग-अलग तरह का', 'alag-alag tarah ka', 'compound, nominative', 'विध्'
  UNION ALL SELECT 14, 5, 'चेष्टा', 'ceṣṭā', 'effort — the particular exertion made on the day', 'चेष्टा — उस दिन की गई ख़ास कोशिश', 'cheshta — us din ki gayi khaas koshish', 'nominative singular', 'चेष्ट्'
  UNION ALL SELECT 14, 6, 'दैवम्', 'daivam', 'the fifth — the part nobody arranged. Left deliberately open: luck, circumstance, providence, other people''s choices. You do not have to settle what it is to notice it was there', 'दैवम् — पाँचवाँ, वह हिस्सा जो किसी ने जुटाया नहीं। जानबूझकर खुला रखा गया: क़िस्मत, हालात, ईश्वर, दूसरों के चुनाव। यह तय किए बिना भी देखा जा सकता है कि वह मौजूद था', 'daivam — paanchwa, woh hissa jo kisi ne jutaya nahi. Jaanboojhkar khula rakha gaya: kismat, haalat, ishwar, doosron ke chunav. Yeh tay kiye bina bhi dekha ja sakta hai ki woh maujood tha', 'nominative singular', 'देव'
  UNION ALL SELECT 14, 7, 'पञ्चमम्', 'pañcamam', 'the fifth', 'पाँचवाँ', 'paanchwa', 'nominative singular', 'पञ्चन्'

  -- 18.16
  UNION ALL SELECT 16, 1, 'तत्र एवं सति', 'tatra evaṁ sati', 'that being so — this verse is a conclusion from the previous one', 'ऐसा होते हुए — यह श्लोक पिछले से निकला निष्कर्ष है', 'aisa hote hue — yeh shloka pichhle se nikla nishkarsh hai', 'locative absolute', 'अस्'
  UNION ALL SELECT 16, 2, 'कर्तारम्', 'kartāram', 'as the doer', 'कर्ता के रूप में', 'karta ke roop mein', 'accusative singular', 'कृ'
  UNION ALL SELECT 16, 3, 'केवलम्', 'kevalam', 'alone, only — the load-bearing word', 'केवल, अकेला — यही शब्द भार उठा रहा है', 'keval, akela — yahi shabd bhaar utha raha hai', 'accusative singular', 'केवल'
  UNION ALL SELECT 16, 4, 'पश्यति', 'paśyati', 'sees', 'देखता है', 'dekhta hai', 'present, third person', 'दृश्'
  UNION ALL SELECT 16, 5, 'अकृतबुद्धित्वात्', 'akṛta-buddhitvāt', 'from an unfinished or untrained understanding — the reason given, and it is about seeing rather than about morals', 'अकृतबुद्धित्व से — यानी अधूरी या बिना गढ़ी समझ से; दी गई वजह नैतिकता की नहीं, देखने की है', 'akrita-buddhitva se — yaani adhoori ya bina gadhi samajh se; di gayi wajah naitikta ki nahi, dekhne ki hai', 'ablative singular', 'बुध्'
  UNION ALL SELECT 16, 6, 'दुर्मतिः', 'durmatiḥ', 'of poor judgement', 'दुर्मति, कमज़ोर समझ वाला', 'durmati, kamzor samajh wala', 'nominative singular', 'मन्'

  -- 18.32
  UNION ALL SELECT 32, 1, 'अधर्मम्', 'adharmam', 'what is not dharma', 'अधर्म', 'adharm', 'accusative singular', 'धृ'
  UNION ALL SELECT 32, 2, 'धर्मम् इति', 'dharmam iti', 'as being dharma', 'धर्म समझकर', 'dharm samajhkar', 'accusative singular', 'धृ'
  UNION ALL SELECT 32, 3, 'मन्यते', 'manyate', 'thinks, takes to be', 'मानती है', 'maanti hai', 'present middle, third person', 'मन्'
  UNION ALL SELECT 32, 4, 'तमसा आवृता', 'tamasā āvṛtā', 'covered over by tamas — the heavy, unlit quality', 'तमस् से ढँकी — भारी, बिना रोशनी वाला गुण', 'tamas se dhanki — bhaari, bina roshni wala gun', 'instrumental, past participle', 'वृ'
  UNION ALL SELECT 32, 5, 'सर्वार्थान्', 'sarvārthān', 'all things, all meanings', 'सब चीज़ें, सब अर्थ', 'sab cheezein, sab arth', 'compound, accusative plural', 'अर्थ'
  UNION ALL SELECT 32, 6, 'विपरीतान्', 'viparītān', 'reversed — and the reversal is CONSISTENT, which is why it is invisible from inside', 'विपरीत — और यह उलटाव संगत है, इसीलिए भीतर से अदृश्य है', 'viparit — aur yeh ultav sangat hai, isiliye bheetar se adrishya hai', 'accusative plural', 'वि + परा + इ'
  UNION ALL SELECT 32, 7, 'बुद्धिः', 'buddhiḥ', 'the deciding faculty', 'बुद्धि', 'buddhi', 'nominative singular', 'बुध्'

  -- 18.37
  UNION ALL SELECT 37, 1, 'अग्रे', 'agre', 'at the start, in front', 'शुरू में', 'shuru mein', 'locative singular', 'अग्र'
  UNION ALL SELECT 37, 2, 'विषम् इव', 'viṣam iva', 'like poison', 'ज़हर जैसा', 'zeher jaisa', 'nominative singular', 'विष'
  UNION ALL SELECT 37, 3, 'परिणामे', 'pariṇāme', 'in its outcome, when it has ripened', 'परिणाम में, पकने पर', 'parinam mein, pakne par', 'locative singular', 'परि + नम्'
  UNION ALL SELECT 37, 4, 'अमृतोपमम्', 'amṛtopamam', 'like amṛta, like the deathless drink', 'अमृत जैसा', 'amrit jaisa', 'compound, nominative', 'उपमा'
  UNION ALL SELECT 37, 5, 'सुखम्', 'sukham', 'happiness, ease', 'सुख', 'sukh', 'nominative singular', 'सुख'
  UNION ALL SELECT 37, 6, 'सात्त्विकम्', 'sāttvikam', 'of the clear, settled quality', 'सात्त्विक — साफ़, ठहरे हुए गुण का', 'sattvik — saaf, thehre hue gun ka', 'nominative singular', 'सत्त्व'
  UNION ALL SELECT 37, 7, 'आत्मबुद्धिप्रसादजम्', 'ātma-buddhi-prasāda-jam', 'born from the settling of one''s own understanding — from you, not from the thing', 'अपनी ही बुद्धि के प्रसन्न होने से जन्मा — आपसे, उस चीज़ से नहीं', 'apni hi buddhi ke prasann hone se janma — tumse, us cheez se nahi', 'compound, nominative', 'जन्'

  -- 18.48
  UNION ALL SELECT 48, 1, 'सहजम्', 'saha-jam', 'born with one — the work that came with you', 'सहज — जो आपके साथ ही आया', 'sahaj — jo tumhare saath hi aaya', 'compound, accusative', 'जन्'
  UNION ALL SELECT 48, 2, 'सदोषम् अपि', 'sa-doṣam api', 'even though it has fault', 'दोष होने पर भी', 'dosh hone par bhi', 'accusative singular', 'दुष्'
  UNION ALL SELECT 48, 3, 'न त्यजेत्', 'na tyajet', 'should not give up', 'नहीं छोड़ना चाहिए', 'nahi chhodna chahiye', 'optative, third person', 'त्यज्'
  UNION ALL SELECT 48, 4, 'सर्वारम्भाः', 'sarvārambhāḥ', 'all undertakings — the same word 12.16 turns on', 'सब आरम्भ — वही शब्द जिस पर 12.16 टिका है', 'sab aarambh — wahi shabd jis par 12.16 tika hai', 'compound, nominative plural', 'आ + रभ्'
  UNION ALL SELECT 48, 5, 'दोषेण', 'doṣeṇa', 'by fault', 'दोष से', 'dosh se', 'instrumental singular', 'दुष्'
  UNION ALL SELECT 48, 6, 'धूमेन अग्निः इव', 'dhūmena agniḥ iva', 'as fire by smoke — smoke is what fire DOES, not a flaw in a particular fire', 'जैसे आग धुएँ से — धुआँ वही है जो आग करती है, किसी ख़ास आग की ख़राबी नहीं', 'jaise aag dhuen se — dhuan wahi hai jo aag karti hai, kisi khaas aag ki kharabi nahi', 'instrumental singular', 'धू'
  UNION ALL SELECT 48, 7, 'आवृताः', 'āvṛtāḥ', 'covered', 'ढँके हुए', 'dhanke hue', 'past participle, nominative plural', 'वृ'

  -- 18.59
  UNION ALL SELECT 59, 1, 'अहंकारम् आश्रित्य', 'ahaṅkāram āśritya', 'taking shelter in the I-maker — leaning on a picture of yourself', 'अहंकार का सहारा लेकर — अपनी ही तस्वीर पर टिककर', 'ahankaar ka sahara lekar — apni hi tasveer par tikkar', 'gerund', 'आ + श्रि'
  UNION ALL SELECT 59, 2, 'न योत्स्ये', 'na yotsye', 'I shall not fight', 'मैं नहीं लड़ूँगा', 'main nahi ladunga', 'future, first person', 'युध्'
  UNION ALL SELECT 59, 3, 'मन्यसे', 'manyase', 'you think', 'आप मानते हैं', 'tum maante ho', 'present middle, second person', 'मन्'
  UNION ALL SELECT 59, 4, 'मिथ्या', 'mithyā', 'false — said of the resolve, not of the person', 'मिथ्या — संकल्प के बारे में कहा गया, व्यक्ति के बारे में नहीं', 'mithya — sankalp ke baare mein kaha gaya, insaan ke baare mein nahi', 'indeclinable', 'मिथ्या'
  UNION ALL SELECT 59, 5, 'व्यवसायः', 'vyavasāyaḥ', 'resolve, determination', 'व्यवसाय, संकल्प', 'sankalp', 'nominative singular', 'वि + अव + सो'
  UNION ALL SELECT 59, 6, 'प्रकृतिः', 'prakṛtiḥ', 'nature — what you are actually made of', 'प्रकृति — आप असल में जिससे बने हैं', 'prakriti — tum asal mein jisse bane ho', 'nominative singular', 'प्र + कृ'
  UNION ALL SELECT 59, 7, 'नियोक्ष्यति', 'niyokṣyati', 'will engage you, will put you to it', 'लगा देगी, उसी में डाल देगी', 'laga degi, usi mein daal degi', 'future, third person', 'नि + युज्'

  -- 18.63
  UNION ALL SELECT 63, 1, 'इति', 'iti', 'thus — closing what has been said', 'इति — जो कहा गया उसे बंद करते हुए', 'iti — jo kaha gaya use band karte hue', 'indeclinable', NULL
  UNION ALL SELECT 63, 2, 'ज्ञानम्', 'jñānam', 'the knowledge', 'ज्ञान', 'gyan', 'nominative singular', 'ज्ञा'
  UNION ALL SELECT 63, 3, 'आख्यातम्', 'ākhyātam', 'has been declared, has been told', 'कह दिया गया है', 'keh diya gaya hai', 'past participle, nominative', 'आ + ख्या'
  UNION ALL SELECT 63, 4, 'गुह्याद् गुह्यतरम्', 'guhyād guhyataram', 'more secret than the secret', 'गुह्य से भी गुह्यतर', 'guhya se bhi guhyatar', 'comparative, nominative', 'गुह्'
  UNION ALL SELECT 63, 5, 'विमृश्य', 'vimṛśya', 'having examined, having thought it over — an instruction to WEIGH, not to accept', 'विमर्श करके, सोचकर — मानने की नहीं, तौलने की हिदायत', 'vimarsh karke, sochkar — maanne ki nahi, taulne ki hidayat', 'gerund', 'वि + मृश्'
  UNION ALL SELECT 63, 6, 'अशेषेण', 'aśeṣeṇa', 'completely, leaving nothing out', 'पूरा, कुछ छोड़े बिना', 'poora, kuch chhode bina', 'instrumental singular', 'शिष्'
  UNION ALL SELECT 63, 7, 'यथा इच्छसि', 'yathā icchasi', 'as you wish', 'जैसा आप चाहें', 'jaisa tum chaho', 'present, second person', 'इष्'
  UNION ALL SELECT 63, 8, 'तथा कुरु', 'tathā kuru', 'so do. Not obey, not follow, not surrender. Do.', 'वैसा कीजिए। मानिए नहीं, चलिए नहीं, समर्पण नहीं। कीजिए।', 'waisa karo. Maano nahi, chalo nahi, samarpan nahi. Karo.', 'imperative, second person', 'कृ'
) AS w
JOIN verses v ON v.verse_number = w.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 18;
