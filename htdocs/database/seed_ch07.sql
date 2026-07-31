-- =====================================================================
-- VedaVerse — database/seed_ch07.sql
-- =====================================================================
-- Chapter 7, Jñāna-Vijñāna Yoga. Eight verses. THE SECOND OF THE SIX
-- ADVANCED-ONLY CHAPTERS (7, 8, 9, 10, 11, 15).
--
-- WHY THIS CHAPTER AND WHY NOW
--   Chapter 15 broke the tie between the advanced track and the
--   intermediate one. Chapter 7 is the next chapter on that path, and
--   15.7 has been waiting for 7.5 since the chapter 15 cross-reference
--   header said so out loud. The two verses are one idea split across
--   eight chapters: the living being is named as the higher of the two
--   natures in 7.5, and named as a fragment doing the hauling in 15.7.
--
--   7.3   one in thousands even tries                    [CARE]
--   7.5   the other nature, and it has become the living
--   7.8   the taste in water, the light in the moon
--   7.11  I am desire that is not against dharma         [CARE]
--   7.14  this is hard to get past, and it says so
--   7.16  four kinds come, and all four are called good  [CARE]
--   7.17  and then it ranks them                         [CARE]
--   7.21  whatever form, I steady that faith
--
-- 7.16 IS THE MOST IMPORTANT VERSE IN THIS BOOK FOR THIS PRODUCT
--   Four kinds of people come: the one in distress, the one who wants
--   to know, the one who wants something, and the one who knows. And
--   the word the verse puts on all four, before it separates them at
--   all, is sukṛtinaḥ — people who have done well. A reader who arrives
--   here because they are in trouble, or because they want something
--   out of it, is named as legitimate by the text itself, unprompted
--   and without qualification. Nothing in this project has a better
--   claim to being its licence.
--
-- 7.17 RANKS THEM, AND THE RANKING IS NOT ALLOWED TO BE HIDDEN
--   The very next verse says of these four the jñānī is distinguished,
--   and calls that one dear. Writing 7.16 and leaving 7.17 out would be
--   the most comfortable omission available in this chapter and it
--   would be a lie by arrangement. Both are written, adjacent, on the
--   same path cluster, and the 7.17 explanation says in as many words
--   that the verse ranks. What it also says is what the ranking is NOT:
--   7.16 has already counted all four in, so 7.17 sorts people who are
--   all inside, not people who are in against people who are out.
--
-- 7.11 IS THE BOOK ENDORSING DESIRE AND IT MUST NOT BE SOFTENED
--   dharmāviruddho bhūteṣu kāmo 'smi — I am desire in beings, the kind
--   not opposed to dharma. In a book with a reputation for telling
--   people to kill wanting, this says the wanting itself is divine when
--   it is not set against what holds things up. It is not a licence for
--   anything anybody wants and the qualifier is right there in the
--   compound. But it is also not a grudging exception, and rewriting it
--   as "only spiritual desire counts" would be putting a word in that
--   the verse does not contain.
--
-- 7.14 STATES ITS OWN DIFFICULTY
--   duratyayā — hard to get across. The verse says so before it says
--   anything about getting across. NO PAGE IN THIS FILE PROMISES THAT
--   ANY OF THIS IS EASY OR QUICK.
--
-- 7.3 IS NOT A RANKING OF HUMAN WORTH
--   Among thousands, one tries; among those who try, one knows. Read as
--   a scoreboard it tells almost everybody reading it that they are
--   nobody. It is a count of how many people are doing a particular
--   thing, which is a different kind of sentence, and thirteen verses
--   later the same chapter counts the distressed and the ones who want
--   something among the people who have done well.
--
-- CONTENT RULES — unchanged. Original writing throughout. Sanskrit
--   unaltered, numbering untouched. No praise or criticism of any living
--   politician, party or movement. No communal framing. NOTHING IN THIS
--   FILE TELLS A READER THAT ARRIVING IN TROUBLE IS A LESSER WAY IN.
--
-- RUN AFTER seed_sample.sql. Re-runnable.
--
--     mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
--         < htdocs/database/seed_ch07.sql
--
-- global_order is 280 + verse_number: chapters 1 to 6 have 280 verses.
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

  SELECT 3 AS verse_number, 283 AS global_order, 1 AS is_curated, 'gita-7-3' AS slug,
    'मनुष्याणां सहस्रेषु कश्चिद्यतति सिद्धये।\nयततामपि सिद्धानां कश्चिन्मां वेत्ति तत्त्वतः॥' AS sanskrit_devanagari,
    'manuṣyāṇāṁ sahasreṣu kaścid yatati siddhaye\nyatatām api siddhānāṁ kaścin māṁ vetti tattvataḥ' AS transliteration_iast,
    'manushyanam sahasreshu kashchid yatati siddhaye\nyatatam api siddhanam kashchin mam vetti tattvatah' AS transliteration_simple,
    'Among thousands of people, someone strives for completion. And among those who strive and reach it, someone knows me as I am.' AS translation_literal,
    'Out of thousands of people, one here and there sets about this. And of the ones who set about it and get somewhere, one here and there knows what they are dealing with.' AS translation_en,
    'हज़ारों लोगों में कोई एक इस काम पर लगता है। और जो लगते हैं और कहीं पहुँचते हैं, उनमें भी कोई एक जानता है कि उसका पाला किससे पड़ा है।' AS translation_hi,
    'Hazaron logon mein koi ek is kaam par lagta hai. Aur jo lagte hain aur kahin pahunchte hain, unme bhi koi ek jaanta hai ki uska paala kisse pada hai.' AS translation_hinglish,
    'A count of how many people are doing a particular thing. It is not a count of what anybody is worth.' AS summary_en,
    'यह गिनती है कि कितने लोग एक ख़ास काम कर रहे हैं। यह गिनती नहीं है कि कौन कितने मोल का है।' AS summary_hi,
    'Yeh ginti hai ki kitne log ek khaas kaam kar rahe hain. Yeh ginti nahi hai ki kaun kitne mol ka hai.' AS summary_hinglish,
    'advanced' AS difficulty,
    'Gita 7.3: one in thousands, and what that sentence is counting' AS seo_title,
    'The Bhagavad Gita says few people take this up and fewer finish. Read as a scoreboard it tells almost every reader they are nobody. It is counting an activity, not a worth.' AS seo_description,
    1 AS published

  UNION ALL SELECT 5, 285, 1, 'gita-7-5',
    'अपरेयमितस्त्वन्यां प्रकृतिं विद्धि मे पराम्।\nजीवभूतां महाबाहो ययेदं धार्यते जगत्॥',
    'apareyam itas tv anyāṁ prakṛtiṁ viddhi me parām\njīva-bhūtāṁ mahā-bāho yayedaṁ dhāryate jagat',
    'apareyam itas tv anyam prakritim viddhi me param\njiva-bhutam maha-baho yayedam dharyate jagat',
    'This is the lower one. Know my other nature, the higher, which has become the living being, by which this world is held up.',
    'That was the lower one. Know that there is another nature of mine, the higher, which has become the living, and it is what holds this world up.',
    'वह निचली थी। जान लो कि मेरी एक और प्रकृति है, ऊपर वाली, जो जीव बन चुकी है, और वही इस दुनिया को थामे हुए है।',
    'Woh nichli thi. Jaan lo ki meri ek aur prakriti hai, upar wali, jo jeev ban chuki hai, aur wahi is duniya ko thaame hue hai.',
    'The higher nature has become the living being. Not sits above it — has become it.',
    'ऊपर वाली प्रकृति जीव बन चुकी है। उसके ऊपर बैठी नहीं है — बन चुकी है।',
    'Upar wali prakriti jeev ban chuki hai. Uske upar baithi nahi hai — ban chuki hai.',
    'advanced',
    'Gita 7.5: the higher nature has become the living being',
    'The Bhagavad Gita names a second nature that has become the living beings themselves. The verb is become, not oversee, and 15.7 says the same thing from the other side.',
    1

  UNION ALL SELECT 8, 288, 1, 'gita-7-8',
    'रसोऽहमप्सु कौन्तेय प्रभास्मि शशिसूर्ययोः।\nप्रणवः सर्ववेदेषु शब्दः खे पौरुषं नृषु॥',
    'raso ''ham apsu kaunteya prabhāsmi śaśi-sūryayoḥ\npraṇavaḥ sarva-vedeṣu śabdaḥ khe pauruṣaṁ nṛṣu',
    'raso ''ham apsu kaunteya prabhasmi shashi-suryayoh\npranavah sarva-vedeshu shabdah khe paurusham nrishu',
    'I am the taste in water, the light in the moon and the sun, the syllable Om in all the Vedas, sound in space, and the capability in people.',
    'I am the taste in water. The shine in the moon and in the sun. The one syllable in all the old books, the sound in open air, and whatever it is in people that gets things done.',
    'मैं पानी में स्वाद हूँ। चाँद और सूरज में चमक। सारी पुरानी किताबों में वह एक अक्षर, खुली हवा में आवाज़, और लोगों में वह जो काम कर गुज़रता है।',
    'Main paani mein swaad hoon. Chaand aur sooraj mein chamak. Saari purani kitaabon mein woh ek akshar, khuli hawa mein awaaz, aur logon mein woh jo kaam kar guzarta hai.',
    'Not a list of holy things. Water, moonlight, sound in the air, and getting something done.',
    'पवित्र चीज़ों की सूची नहीं। पानी, चाँदनी, हवा में आवाज़, और कोई काम कर गुज़रना।',
    'Pavitra cheezon ki soochi nahi. Paani, chaandni, hawa mein awaaz, aur koi kaam kar guzarna.',
    'advanced',
    'Gita 7.8: the taste in water',
    'The Bhagavad Gita gives a list of where to find the thing it has been arguing about, and the items are ordinary — the taste of water, the light of the moon, the sound in open air.',
    1

  UNION ALL SELECT 11, 291, 1, 'gita-7-11',
    'बलं बलवतां चाहं कामरागविवर्जितम्।\nधर्माविरुद्धो भूतेषु कामोऽस्मि भरतर्षभ॥',
    'balaṁ balavatāṁ cāhaṁ kāma-rāga-vivarjitam\ndharmāviruddho bhūteṣu kāmo ''smi bharatarṣabha',
    'balam balavatam chaham kama-raga-vivarjitam\ndharmaviruddho bhuteshu kamo ''smi bharatarshabha',
    'I am the strength of the strong, free of craving and attachment. And in beings I am desire that is not opposed to dharma.',
    'I am the strength of the strong, the kind with no craving and no clinging in it. And in living beings I am desire — the desire that is not set against what holds things up.',
    'मैं बलवानों का बल हूँ, वह वाला जिसमें न ललक है न चिपकाव। और जीवों में मैं चाह हूँ — वह चाह जो उसके ख़िलाफ़ नहीं है जो चीज़ों को थामे रखता है।',
    'Main balwanon ka bal hoon, woh wala jisme na lalak hai na chipkav. Aur jeevon mein main chaah hoon — woh chaah jo uske khilaf nahi hai jo cheezon ko thaame rakhta hai.',
    'The book calls desire itself divine, with one condition, and the condition is in the compound.',
    'किताब चाह को ही दिव्य कहती है, एक शर्त के साथ, और शर्त उसी समास में है।',
    'Kitaab chaah ko hi divya kehti hai, ek shart ke saath, aur shart usi samas mein hai.',
    'advanced',
    'Gita 7.11: I am desire that is not against dharma',
    'A book with a reputation for telling people to kill wanting says here that desire itself is divine when it is not set against what holds things up. The qualifier is in the verse.',
    1

  UNION ALL SELECT 14, 294, 1, 'gita-7-14',
    'दैवी ह्येषा गुणमयी मम माया दुरत्यया।\nमामेव ये प्रपद्यन्ते मायामेतां तरन्ति ते॥',
    'daivī hy eṣā guṇa-mayī mama māyā duratyayā\nmām eva ye prapadyante māyām etāṁ taranti te',
    'daivi hy esha guna-mayi mama maya duratyaya\nmam eva ye prapadyante mayam etam taranti te',
    'This divine maya of mine, made of the gunas, is hard to get past. Those who come to me alone cross this maya.',
    'This is made of the three settings and it is hard to get across. Whoever comes to me does get across it.',
    'यह तीनों अवस्थाओं से बनी है और इसे पार करना मुश्किल है। जो मेरे पास आता है वह इसे पार कर जाता है।',
    'Yeh teenon avasthaon se bani hai aur ise paar karna mushkil hai. Jo mere paas aata hai woh ise paar kar jaata hai.',
    'Duratyaya. It says hard before it says anything about getting across.',
    'दुरत्यया। पार होने की बात कहने से पहले वह मुश्किल कहता है।',
    'Duratyaya. Paar hone ki baat kehne se pehle woh mushkil kehta hai.',
    'advanced',
    'Gita 7.14: it says hard before it says anything else',
    'The Bhagavad Gita calls this hard to get across, in the same line that says it can be crossed. The difficulty is stated by the text, not conceded by a commentator.',
    1

  UNION ALL SELECT 16, 296, 1, 'gita-7-16',
    'चतुर्विधा भजन्ते मां जनाः सुकृतिनोऽर्जुन।\nआर्तो जिज्ञासुरर्थार्थी ज्ञानी च भरतर्षभ॥',
    'catur-vidhā bhajante māṁ janāḥ sukṛtino ''rjuna\nārto jijñāsur arthārthī jñānī ca bharatarṣabha',
    'chatur-vidha bhajante mam janah sukritino ''rjuna\narto jijnasur arthartha jnani cha bharatarshabha',
    'Four kinds of people who have done well turn to me, Arjuna: the distressed, the one who wants to know, the one who wants something, and the one who knows.',
    'Four kinds of people come to me, and all four have done well: the one in trouble, the one who wants to understand, the one who wants something out of it, and the one who knows.',
    'चार तरह के लोग मेरे पास आते हैं, और चारों ने ठीक किया है: वह जो मुसीबत में है, वह जो समझना चाहता है, वह जो इससे कुछ चाहता है, और वह जो जानता है।',
    'Chaar tarah ke log mere paas aate hain, aur chaaron ne theek kiya hai: woh jo museebat mein hai, woh jo samajhna chahta hai, woh jo isse kuch chahta hai, aur woh jo jaanta hai.',
    'Sukritinah comes before the four are separated. The one in trouble is counted in, by name.',
    'सुकृतिनः शब्द चारों को अलग करने से पहले आता है। मुसीबत वाला नाम लेकर गिना गया है।',
    'Sukritinah shabd chaaron ko alag karne se pehle aata hai. Museebat wala naam lekar gina gaya hai.',
    'advanced',
    'Gita 7.16: four kinds come, and all four have done well',
    'The Bhagavad Gita names four kinds of people who turn to it, including the one in distress and the one who wants something, and calls all four people who have done well.',
    1

  UNION ALL SELECT 17, 297, 1, 'gita-7-17',
    'तेषां ज्ञानी नित्ययुक्त एकभक्तिर्विशिष्यते।\nप्रियो हि ज्ञानिनोऽत्यर्थमहं स च मम प्रियः॥',
    'teṣāṁ jñānī nitya-yukta eka-bhaktir viśiṣyate\npriyo hi jñānino ''tyartham ahaṁ sa ca mama priyaḥ',
    'tesham jnani nitya-yukta eka-bhaktir vishishyate\npriyo hi jnanino ''tyartham aham sa cha mama priyah',
    'Of these, the one who knows, always joined, holding to one, is distinguished. I am exceedingly dear to that one, and that one is dear to me.',
    'Of those four, the one who knows stands out — steady, and not divided. I matter very much to that one, and that one matters to me.',
    'उन चारों में जो जानता है वह अलग दिखता है — ठहरा हुआ, और बँटा हुआ नहीं। उसके लिए मैं बहुत मायने रखता हूँ, और वह मेरे लिए।',
    'Un chaaron mein jo jaanta hai woh alag dikhta hai — thehra hua, aur banta hua nahi. Uske liye main bahut maayne rakhta hoon, aur woh mere liye.',
    'The verse ranks. It ranks four people the verse before it had already counted in.',
    'श्लोक क्रम लगाता है। वह उन्हीं चारों का क्रम लगाता है जिन्हें पिछला श्लोक पहले ही गिन चुका है।',
    'Shloka kram lagata hai. Woh unhi chaaron ka kram lagata hai jinhe pichhla shloka pehle hi gin chuka hai.',
    'advanced',
    'Gita 7.17: and then it ranks them',
    'One verse after calling four kinds of seeker good, the Bhagavad Gita says one of the four stands out. The ranking is in the text and is not softened here.',
    1

  UNION ALL SELECT 21, 301, 1, 'gita-7-21',
    'यो यो यां यां तनुं भक्तः श्रद्धयार्चितुमिच्छति।\nतस्य तस्याचलां श्रद्धां तामेव विदधाम्यहम्॥',
    'yo yo yāṁ yāṁ tanuṁ bhaktaḥ śraddhayārcitum icchati\ntasya tasyācalāṁ śraddhāṁ tām eva vidadhāmy aham',
    'yo yo yam yam tanum bhaktah shraddhayarchitum ichchhati\ntasya tasyachalam shraddham tam eva vidadhamy aham',
    'Whichever form any devoted person wishes to honour with faith, I make that person''s faith in that very form steady.',
    'Whatever shape anybody wants to honour, and honours in good faith, I am the one who makes that faith of theirs steady — that one, the one they chose.',
    'कोई जिस भी रूप को श्रद्धा से पूजना चाहे, उसकी उसी श्रद्धा को मैं ही अडिग करता हूँ — उसी को, जिसे उसने चुना।',
    'Koi jis bhi roop ko shraddha se poojna chahe, uski usi shraddha ko main hi adig karta hoon — usi ko, jise usne chuna.',
    'That very one. The verse does not redirect anybody to a better form.',
    'उसी को। श्लोक किसी को बेहतर रूप की तरफ़ नहीं मोड़ता।',
    'Usi ko. Shloka kisi ko behtar roop ki taraf nahi modta.',
    'advanced',
    'Gita 7.21: whatever form, that is the faith made steady',
    'The Bhagavad Gita says whatever form somebody honours in good faith, it is that faith which gets made steady. The verse redirects nobody to a better one.',
    1

) AS v
JOIN chapters c ON c.chapter_number = 7;

-- =====================================================================
-- 2. EXPLANATIONS
-- =====================================================================
-- All at beginner depth. The load-bearing sentences, all asserted by
-- smoke-test.sh on the DEFAULT render:
--   7.3    it is counting an activity and not a worth
--   7.11   the qualifier is in the compound
--   7.16   the one in trouble is counted in, by name
--   7.17   the verse ranks, and this page is not going to pretend
--   7.14   nothing here is quick and the verse says so first
-- =====================================================================

DELETE ve FROM verse_explanations ve JOIN verses v ON v.id = ve.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 7;

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 3 AS vn, 'beginner' AS level,
   'Two verses into the chapter, before any of the content arrives, comes a sentence about how many people ever get to it.' AS h_en,
   'अध्याय के दो श्लोक बाद, कोई भी सामग्री आने से पहले, यह वाक्य आता है कि कितने लोग कभी वहाँ तक पहुँचते हैं।' AS h_hi,
   'Adhyay ke do shloka baad, koi bhi samagri aane se pehle, yeh vakya aata hai ki kitne log kabhi wahan tak pahunchte hain.' AS h_hing,
   'Out of thousands, one sets about it. Of those who set about it and get somewhere, one knows what they are dealing with. Two numbers, both small, and neither of them attached to a name.' AS p_en,
   'हज़ारों में से एक इस काम पर लगता है। जो लगते हैं और कहीं पहुँचते हैं, उनमें से एक जानता है कि उसका पाला किससे पड़ा है। दो आँकड़े, दोनों छोटे, और दोनों किसी नाम से जुड़े हुए नहीं।' AS p_hi,
   'Hazaron mein se ek is kaam par lagta hai. Jo lagte hain aur kahin pahunchte hain, unme se ek jaanta hai ki uska paala kisse pada hai. Do aankde, dono chhote, aur dono kisi naam se jude hue nahi.' AS p_hing,
   'Read as a scoreboard this verse tells almost everybody who opens it that they are nobody, and plenty of people have read it that way, usually about somebody else. But it is counting an activity and not a worth — how many people are doing a particular thing, which is the same kind of sentence as saying few people learn to sail. Nobody concludes from that that most people are lesser. And thirteen verses further on the same chapter counts the person in trouble and the person who wants something among those who have done well, which settles what sort of book is speaking here.' AS m_en,
   'तालिका की तरह पढ़ें तो यह श्लोक इसे खोलने वाले लगभग हर आदमी से कहता है कि वह कोई नहीं है, और बहुत लोगों ने इसे ऐसे ही पढ़ा है, आमतौर पर किसी और के बारे में। पर यह एक काम की गिनती है, किसी के मोल की नहीं — कितने लोग एक ख़ास काम कर रहे हैं, यह वैसा ही वाक्य है जैसे यह कहना कि नाव चलाना कम लोग सीखते हैं। इससे कोई यह नतीजा नहीं निकालता कि ज़्यादातर लोग कमतर हैं। और तेरह श्लोक आगे यही अध्याय मुसीबत में पड़े आदमी और कुछ चाहने वाले आदमी को उनमें गिनता है जिन्होंने ठीक किया, जिससे तय हो जाता है कि यहाँ किस तरह की किताब बोल रही है।' AS m_hi,
   'Talika ki tarah padhein to yeh shloka ise kholne wale lagbhag har aadmi se kehta hai ki woh koi nahi hai, aur bahut logon ne ise aise hi padha hai, aamtaur par kisi aur ke baare mein. Par yeh ek kaam ki ginti hai, kisi ke mol ki nahi — kitne log ek khaas kaam kar rahe hain, yeh waisa hi vakya hai jaise yeh kehna ki naav chalana kam log seekhte hain. Isse koi yeh nateeja nahi nikalta ki zyadatar log kamtar hain. Aur terah shloka aage yahi adhyay museebat mein pade aadmi aur kuch chahne wale aadmi ko unme ginta hai jinhone theek kiya, jisse tay ho jaata hai ki yahan kis tarah ki kitaab bol rahi hai.' AS m_hing

  UNION ALL SELECT 5, 'beginner',
   'The chapter has just listed a lower nature — earth, water, fire, air, space, mind, understanding, the sense of being a separate somebody. This verse says there is another one.',
   'अध्याय अभी-अभी एक निचली प्रकृति गिना चुका है — पृथ्वी, जल, अग्नि, वायु, आकाश, मन, बुद्धि, अलग कोई होने का भाव। यह श्लोक कहता है कि एक और भी है।',
   'Adhyay abhi-abhi ek nichli prakriti gina chuka hai — prithvi, jal, agni, vayu, aakash, man, buddhi, alag koi hone ka bhaav. Yeh shloka kehta hai ki ek aur bhi hai.',
   'And it does not say the higher one presides over the living or looks after it. It says jiva-bhutam — become the living. The verb is one of having turned into.',
   'और वह यह नहीं कहता कि ऊपर वाली जीव के ऊपर बैठी है या उसकी देखरेख करती है। वह कहता है जीवभूताम् — जीव बन चुकी। क्रिया बन जाने की है।',
   'Aur woh yeh nahi kehta ki upar wali jeev ke upar baithi hai ya uski dekhrekh karti hai. Woh kehta hai jiva-bhutam — jeev ban chuki. Kriya ban jaane ki hai.',
   'This is the verse 15.7 is the other half of, and reading them together is what stops either one being misused. 7.5 says the higher nature has become the living being — so nothing about a person is being placed outside the arrangement, on a shelf, waiting. And 15.7 says the fragment is the one hauling at the senses, which is what stops the same idea becoming a permission slip. Between them, a reader is told they are made of the good half and that this does not get them out of anything. Both halves are needed and neither is comfortable on its own.',
   'यही वह श्लोक है जिसका दूसरा आधा 15.7 है, और दोनों को साथ पढ़ना ही दोनों को ग़लत इस्तेमाल से बचाता है। 7.5 कहता है कि ऊपर वाली प्रकृति जीव बन चुकी है — तो आदमी की कोई चीज़ इस बंदोबस्त के बाहर, किसी ताक़ पर, इंतज़ार में नहीं रखी जा रही। और 15.7 कहता है कि इंद्रियों को खींचने वाला वही अंश है, और यही उसी बात को छूट का परचा बनने से रोकता है। दोनों मिलकर पाठक से कहते हैं कि वह अच्छे आधे से बना है और इससे उसे किसी चीज़ से छुटकारा नहीं मिलता। दोनों आधे ज़रूरी हैं और अकेले में कोई भी आरामदेह नहीं है।',
   'Yahi woh shloka hai jiska doosra aadha 15.7 hai, aur dono ko saath padhna hi dono ko galat istemaal se bachata hai. 7.5 kehta hai ki upar wali prakriti jeev ban chuki hai — to aadmi ki koi cheez is bandobast ke bahar, kisi taak par, intezaar mein nahi rakhi ja rahi. Aur 15.7 kehta hai ki indriyon ko kheenchne wala wahi ansh hai, aur yahi usi baat ko chhoot ka parcha banne se rokta hai. Dono milkar pathak se kehte hain ki woh achhe aadhe se bana hai aur isse use kisi cheez se chhutkara nahi milta. Dono aadhe zaroori hain aur akele mein koi bhi aaramdeh nahi hai.'

  UNION ALL SELECT 8, 'beginner',
   'Having spent seven verses on categories, the chapter suddenly stops arguing and starts pointing at things.',
   'सात श्लोक श्रेणियों पर लगाने के बाद अध्याय अचानक बहस करना छोड़ देता है और चीज़ों की तरफ़ इशारा करने लगता है।',
   'Saat shloka shreniyon par lagane ke baad adhyay achanak behes karna chhod deta hai aur cheezon ki taraf ishara karne lagta hai.',
   'The taste in water. The shine in the moon and the sun. The one syllable in the old books, the sound in open air, and whatever it is in people that gets something done.',
   'पानी में स्वाद। चाँद और सूरज में चमक। पुरानी किताबों में वह एक अक्षर, खुली हवा में आवाज़, और लोगों में वह जो कोई काम कर गुज़रता है।',
   'Paani mein swaad. Chaand aur sooraj mein chamak. Purani kitaabon mein woh ek akshar, khuli hawa mein awaaz, aur logon mein woh jo koi kaam kar guzarta hai.',
   'Notice what is not on the list. No temple, no ritual, no rank, no birth, nothing anybody has to be admitted to. Water is the first item and everyone reading this has drunk some today. That choice of examples is the argument: a chapter that had wanted to be exclusive had every opportunity here and picked the taste of water instead. It is also worth saying plainly that this is a list of where to look and not a list of things to worship — nothing in the verse asks anybody to do anything at all.',
   'ध्यान दीजिए कि सूची में क्या नहीं है। कोई मंदिर नहीं, कोई कर्मकांड नहीं, कोई दर्जा नहीं, कोई जन्म नहीं, कोई ऐसी चीज़ नहीं जिसमें दाख़िला लेना पड़े। पहली चीज़ पानी है और इसे पढ़ने वाले हर आदमी ने आज कुछ पिया है। मिसालों का यही चुनाव दलील है: जो अध्याय ख़ास लोगों का होना चाहता, उसके पास यहाँ पूरा मौक़ा था और उसने पानी का स्वाद चुना। यह भी साफ़ कह देना चाहिए कि यह कहाँ देखें की सूची है, किन चीज़ों की पूजा करें की नहीं — श्लोक किसी से कुछ भी करने को नहीं कहता।',
   'Dhyan dijiye ki soochi mein kya nahi hai. Koi mandir nahi, koi karmkaand nahi, koi darja nahi, koi janm nahi, koi aisi cheez nahi jisme daakhila lena pade. Pehli cheez paani hai aur ise padhne wale har aadmi ne aaj kuch piya hai. Misaalon ka yahi chunav dalil hai: jo adhyay khaas logon ka hona chahta, uske paas yahan poora mauka tha aur usne paani ka swaad chuna. Yeh bhi saaf keh dena chahiye ki yeh kahan dekhein ki soochi hai, kin cheezon ki pooja karein ki nahi — shloka kisi se kuch bhi karne ko nahi kehta.'

  UNION ALL SELECT 11, 'beginner',
   'The pointing continues, and then in the second line it lands somewhere most readers do not expect this book to go.',
   'इशारा करना जारी रहता है, और फिर दूसरी पंक्ति में वह वहाँ पहुँचता है जहाँ ज़्यादातर पाठक इस किताब से जाने की उम्मीद नहीं करते।',
   'Ishara karna jaari rehta hai, aur phir doosri pankti mein woh wahan pahunchta hai jahan zyadatar pathak is kitaab se jaane ki ummeed nahi karte.',
   'In living beings, I am desire — dharma-aviruddha, the kind not set against what holds things up. One word of qualification, joined onto the front, and nothing else.',
   'जीवों में, मैं चाह हूँ — धर्म-अविरुद्ध, वह वाली जो उसके ख़िलाफ़ नहीं खड़ी जो चीज़ों को थामे रखता है। शर्त का एक शब्द, आगे जुड़ा हुआ, और कुछ नहीं।',
   'Jeevon mein, main chaah hoon — dharma-aviruddha, woh wali jo uske khilaf nahi khadi jo cheezon ko thaame rakhta hai. Shart ka ek shabd, aage juda hua, aur kuch nahi.',
   'A book with a reputation for telling people to kill their wanting says here, in its own voice, that the wanting itself is divine. That is worth sitting with before it gets explained away. The qualifier is in the compound and it is real — this is not a licence for whatever anybody happens to want, and dharma-aviruddha rules out the wanting that is set against what holds things up. But it is also not a grudging exception, and it does not say only spiritual desire counts; that word is not in the line. Wanting to be good at something, wanting somebody to be all right, wanting a decent evening — none of these is set against anything, and the verse says what they are.',
   'जिस किताब की शोहरत यह है कि वह लोगों से उनकी चाह मारने को कहती है, वह यहाँ अपनी ही आवाज़ में कहती है कि चाह ख़ुद दिव्य है। इसे समझाकर हटा देने से पहले इस पर ठहरना काम का है। शर्त समास में है और असली है — यह किसी की भी किसी भी चाह की इजाज़त नहीं है, और धर्म-अविरुद्ध उस चाह को बाहर कर देता है जो चीज़ों को थामे रखने वाले के ख़िलाफ़ खड़ी हो। पर यह कोई कसमसाती हुई छूट भी नहीं है, और यह नहीं कहती कि सिर्फ़ आध्यात्मिक चाह गिनी जाएगी; वह शब्द पंक्ति में है ही नहीं। किसी काम में अच्छा होने की चाह, किसी के ठीक रहने की चाह, एक ढंग की शाम की चाह — इनमें से कोई किसी के ख़िलाफ़ नहीं है, और श्लोक बता देता है कि वे क्या हैं।',
   'Jis kitaab ki shohrat yeh hai ki woh logon se unki chaah maarne ko kehti hai, woh yahan apni hi awaaz mein kehti hai ki chaah khud divya hai. Ise samjhakar hata dene se pehle is par thehrna kaam ka hai. Shart samas mein hai aur asli hai — yeh kisi ki bhi kisi bhi chaah ki ijazat nahi hai, aur dharma-aviruddha us chaah ko bahar kar deta hai jo cheezon ko thaame rakhne wale ke khilaf khadi ho. Par yeh koi kasmasati hui chhoot bhi nahi hai, aur yeh nahi kehti ki sirf aadhyatmik chaah gini jayegi; woh shabd pankti mein hai hi nahi. Kisi kaam mein achha hone ki chaah, kisi ke theek rehne ki chaah, ek dhang ki shaam ki chaah — inme se koi kisi ke khilaf nahi hai, aur shloka bata deta hai ki we kya hain.'

  UNION ALL SELECT 14, 'beginner',
   'After a long stretch of where to look, a verse about why almost nobody does.',
   'कहाँ देखें के एक लंबे हिस्से के बाद, एक श्लोक इस पर कि लगभग कोई देखता क्यों नहीं।',
   'Kahan dekhein ke ek lambe hisse ke baad, ek shloka is par ki lagbhag koi dekhta kyun nahi.',
   'Made of the three settings, and duratyaya — hard to get across. The word order matters: the difficulty is stated first, and the way across is stated second.',
   'तीनों अवस्थाओं से बनी, और दुरत्यया — पार करना मुश्किल। शब्दों का क्रम मायने रखता है: पहले मुश्किल कही गई है, पार होने का रास्ता बाद में।',
   'Teenon avasthaon se bani, aur duratyaya — paar karna mushkil. Shabdon ka kram maayne rakhta hai: pehle mushkil kahi gayi hai, paar hone ka raasta baad mein.',
   'Nothing here is quick and the verse says so first, before it offers anything. That ordering is unusual and it is worth trusting. A reader who has been handed a great deal of writing promising that one insight, one practice or one weekend changes everything can put this verse next to all of it: the text itself opens with the word hard. What it offers after that is not a shortcut and not a schedule. Whatever anybody says about how long this takes, they are saying more than 7.14 does.',
   'यहाँ कुछ भी जल्दी नहीं है और श्लोक यह बात पहले कहता है, कुछ भी देने से पहले। यह क्रम असामान्य है और इस पर भरोसा करने लायक़ है। जिस पाठक के हाथ में बहुत सारा ऐसा लिखा आया हो जो वादा करता है कि एक समझ, एक अभ्यास या एक हफ़्ता सब बदल देता है, वह इस श्लोक को उन सबके बग़ल में रख सकता है: ग्रंथ ख़ुद मुश्किल शब्द से शुरू करता है। उसके बाद वह जो देता है वह न शॉर्टकट है न समय-सारणी। इसमें कितना वक़्त लगता है, इस बारे में जो कोई जो भी कहे, वह 7.14 से ज़्यादा कह रहा है।',
   'Yahan kuch bhi jaldi nahi hai aur shloka yeh baat pehle kehta hai, kuch bhi dene se pehle. Yeh kram asamanya hai aur is par bharosa karne layak hai. Jis pathak ke haath mein bahut saara aisa likha aaya ho jo waada karta hai ki ek samajh, ek abhyas ya ek hafta sab badal deta hai, woh is shloka ko un sabke bagal mein rakh sakta hai: granth khud mushkil shabd se shuru karta hai. Uske baad woh jo deta hai woh na shortcut hai na samay-saarni. Isme kitna waqt lagta hai, is baare mein jo koi jo bhi kahe, woh 7.14 se zyada keh raha hai.'

  UNION ALL SELECT 16, 'beginner',
   'A list of who comes. It is the only place in the book where the reasons people arrive are set out and counted.',
   'कौन आता है इसकी सूची। किताब में यही एक जगह है जहाँ लोग किन वजहों से आते हैं, वे रखी और गिनी गई हैं।',
   'Kaun aata hai iski soochi. Kitaab mein yahi ek jagah hai jahan log kin wajahon se aate hain, we rakhi aur gini gayi hain.',
   'The one in trouble. The one who wants to understand. The one who wants something out of it. The one who knows. And before any of the four is named, the word for all of them together: sukritinah, people who have done well.',
   'मुसीबत में पड़ा हुआ। जो समझना चाहता है। जो इससे कुछ चाहता है। जो जानता है। और इन चारों में से किसी का नाम लेने से पहले, चारों के लिए एक साथ आया शब्द: सुकृतिनः, जिन्होंने ठीक किया।',
   'Museebat mein pada hua. Jo samajhna chahta hai. Jo isse kuch chahta hai. Jo jaanta hai. Aur in chaaron mein se kisi ka naam lene se pehle, chaaron ke liye ek saath aaya shabd: sukritinah, jinhone theek kiya.',
   'The one in trouble is counted in, by name, first, and called somebody who has done well before any distinction is drawn. So is the one who came because they wanted something out of it — the reason most often treated as the shabby one, and the text does not treat it that way. Anybody who has arrived at a book like this in a bad month, and then felt they were doing it for the wrong reason, is reading a verse here that disagrees with them in its own words. The next verse will separate the four. This one does not, and the order of the two is not an accident.',
   'मुसीबत वाला गिना गया है, नाम लेकर, सबसे पहले, और कोई भेद खींचे जाने से पहले उसे उनमें कहा गया है जिन्होंने ठीक किया। वह भी जो इसलिए आया कि उसे इससे कुछ चाहिए था — वही वजह जिसे अक्सर घटिया माना जाता है, और ग्रंथ उसे ऐसा नहीं मानता। जो कोई किसी बुरे महीने में ऐसी किताब तक पहुँचा हो और फिर उसे लगा हो कि वह ग़लत वजह से यहाँ है, वह यहाँ एक ऐसा श्लोक पढ़ रहा है जो अपने ही शब्दों में उससे असहमत है। अगला श्लोक चारों को अलग करेगा। यह नहीं करता, और दोनों का यह क्रम इत्तेफ़ाक़ नहीं है।',
   'Museebat wala gina gaya hai, naam lekar, sabse pehle, aur koi bhed kheenche jaane se pehle use unme kaha gaya hai jinhone theek kiya. Woh bhi jo isliye aaya ki use isse kuch chahiye tha — wahi wajah jise aksar ghatiya mana jaata hai, aur granth use aisa nahi maanta. Jo koi kisi bure mahine mein aisi kitaab tak pahuncha ho aur phir use laga ho ki woh galat wajah se yahan hai, woh yahan ek aisa shloka padh raha hai jo apne hi shabdon mein usse asehmat hai. Agla shloka chaaron ko alag karega. Yeh nahi karta, aur dono ka yeh kram ittefaq nahi hai.'

  UNION ALL SELECT 17, 'beginner',
   'And then, immediately, the sorting the verse before it declined to do.',
   'और फिर, तुरंत, वही छँटाई जो पिछले श्लोक ने करने से इनकार किया था।',
   'Aur phir, turant, wahi chhantai jo pichhle shloka ne karne se inkaar kiya tha.',
   'Of those four, the one who knows stands out — steady, and holding to one thing rather than several. And then the sentence goes both ways: I matter very much to that one, and that one matters to me.',
   'उन चारों में जो जानता है वह अलग दिखता है — ठहरा हुआ, और कई चीज़ों के बजाय एक को थामे हुए। और फिर वाक्य दोनों तरफ़ जाता है: उसके लिए मैं बहुत मायने रखता हूँ, और वह मेरे लिए।',
   'Un chaaron mein jo jaanta hai woh alag dikhta hai — thehra hua, aur kai cheezon ke bajaye ek ko thaame hue. Aur phir vakya dono taraf jaata hai: uske liye main bahut maayne rakhta hoon, aur woh mere liye.',
   'The verse ranks, and this page is not going to pretend otherwise. Leaving 7.17 out and printing only 7.16 would have been the most comfortable thing available here and it would have been a lie by arrangement. What can honestly be said is what the ranking is not. 7.16 has already put all four inside, so this is a distinction drawn among people who are all in, not a line between those who are and those who are not — and nothing in either verse says the first three should be somewhere else, or should have come for a better reason, or should stop coming. The one who knows is also, by the chapter''s own account four verses later, extremely rare, which makes this a ranking almost nobody reading it is being placed at the top or the bottom of.',
   'श्लोक क्रम लगाता है, और यह पन्ना इससे उल्टा दिखाने वाला नहीं है। 7.17 को छोड़कर सिर्फ़ 7.16 छापना यहाँ सबसे आरामदेह काम होता और वह सजावट से बोला गया झूठ होता। ईमानदारी से जो कहा जा सकता है वह यह है कि यह क्रम क्या नहीं है। 7.16 चारों को पहले ही भीतर रख चुका है, तो यह भेद उन लोगों के बीच है जो सब भीतर हैं, उनके और उनके बीच की रेखा नहीं जो भीतर हैं और जो नहीं — और दोनों श्लोकों में कहीं यह नहीं है कि पहले तीन को कहीं और होना चाहिए, या बेहतर वजह से आना चाहिए था, या आना बंद कर देना चाहिए। जो जानता है वह, इसी अध्याय के अपने हिसाब से चार श्लोक बाद, बेहद दुर्लभ भी है, जिससे यह ऐसा क्रम बन जाता है जिसमें इसे पढ़ने वाले लगभग किसी को न सबसे ऊपर रखा जा रहा है न सबसे नीचे।',
   'Shloka kram lagata hai, aur yeh panna isse ulta dikhane wala nahi hai. 7.17 ko chhodkar sirf 7.16 chhapna yahan sabse aaramdeh kaam hota aur woh sajawat se bola gaya jhooth hota. Imaandari se jo kaha ja sakta hai woh yeh hai ki yeh kram kya nahi hai. 7.16 chaaron ko pehle hi bheetar rakh chuka hai, to yeh bhed un logon ke beech hai jo sab bheetar hain, unke aur unke beech ki rekha nahi jo bheetar hain aur jo nahi — aur dono shlokon mein kahin yeh nahi hai ki pehle teen ko kahin aur hona chahiye, ya behtar wajah se aana chahiye tha, ya aana band kar dena chahiye. Jo jaanta hai woh, isi adhyay ke apne hisaab se chaar shloka baad, behad durlabh bhi hai, jisse yeh aisa kram ban jaata hai jisme ise padhne wale lagbhag kisi ko na sabse upar rakha ja raha hai na sabse neeche.'

  UNION ALL SELECT 21, 'beginner',
   'Near the end of the chapter, a verse about what happens when somebody honours a form other than the one the speaker has been describing.',
   'अध्याय के अंत के पास, एक श्लोक इस पर कि क्या होता है जब कोई उससे अलग किसी रूप को पूजता है जिसका वर्णन बोलने वाला करता आया है।',
   'Adhyay ke ant ke paas, ek shloka is par ki kya hota hai jab koi usse alag kisi roop ko poojta hai jiska varnan bolne wala karta aaya hai.',
   'Whatever shape anybody wants to honour, and honours in good faith, it is that faith of theirs which gets made steady. Tam eva — that very one. Not a better one.',
   'कोई जिस भी रूप को श्रद्धा से पूजना चाहे, उसकी वही श्रद्धा अडिग की जाती है। ताम् एव — उसी को। किसी बेहतर को नहीं।',
   'Koi jis bhi roop ko shraddha se poojna chahe, uski wahi shraddha adig ki jaati hai. Tam eva — usi ko. Kisi behtar ko nahi.',
   'The verse redirects nobody. It would have been trivially easy to write this line so that the faith gets corrected, or transferred, or upgraded, and instead the emphatic word in it points back at the form the person themselves chose. For a reader with no background, or a different one, or none at all, this is the chapter saying that the choosing was theirs and stays theirs. It is also the reason this book can be read by somebody who does not share its frame without either side having to pretend, and that is a claim the text makes rather than a modern accommodation.',
   'श्लोक किसी को मोड़ता नहीं। इस पंक्ति को ऐसे लिखना बहुत आसान होता कि श्रद्धा सुधार दी जाए, या हटा दी जाए, या ऊपर कर दी जाए, और इसके बजाय उसका ज़ोर वाला शब्द वापस उसी रूप की ओर इशारा करता है जिसे उस आदमी ने ख़ुद चुना। जिस पाठक की कोई पृष्ठभूमि नहीं है, या अलग है, या है ही नहीं, उसके लिए यह अध्याय का यह कहना है कि चुनाव उसका था और उसका ही रहेगा। यही वजह भी है कि इस किताब को वह आदमी पढ़ सकता है जो इसका ढाँचा नहीं मानता, और किसी पक्ष को नाटक नहीं करना पड़ता, और यह दावा ग्रंथ करता है, यह कोई आधुनिक रियायत नहीं है।',
   'Shloka kisi ko modta nahi. Is pankti ko aise likhna bahut aasan hota ki shraddha sudhaar di jaaye, ya hata di jaaye, ya upar kar di jaaye, aur iske bajaye uska zor wala shabd wapas usi roop ki or ishara karta hai jise us aadmi ne khud chuna. Jis pathak ki koi prishthbhoomi nahi hai, ya alag hai, ya hai hi nahi, uske liye yeh adhyay ka yeh kehna hai ki chunav uska tha aur uska hi rahega. Yahi wajah bhi hai ki is kitaab ko woh aadmi padh sakta hai jo iska dhaancha nahi maanta, aur kisi paksh ko naatak nahi karna padta, aur yeh dawa granth karta hai, yeh koi aadhunik riyayat nahi hai.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 7;

-- =====================================================================
-- 3. HOOKS, REFLECTIONS, PRACTICES, TOPICS
-- =====================================================================
-- NO REFLECTION OR PRACTICE IN THIS SECTION ASKS A READER TO PLACE
-- THEMSELVES IN 7.3's COUNT OR ON 7.17's RANKING. Both verses invite
-- exactly that and the invitation is the misuse. What the 7.16 and
-- 7.17 material asks instead is which of the four doors the reader came
-- through, which is a question with four right answers.
--
-- NO PRACTICE PROMISES SPEED. 7.14 says duratyaya first and anything
-- here that implied a schedule would be arguing with it.
--
-- 8 memory aids, 24 reflections, 8 practices, 26 topic rows.
-- =====================================================================

DELETE m FROM verse_memory_aids m JOIN verses v ON v.id = m.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 7;
DELETE r FROM verse_reflections r JOIN verses v ON v.id = r.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 7;
DELETE p FROM verse_practices p JOIN verses v ON v.id = p.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 7;
DELETE vt FROM verse_topics vt JOIN verses v ON v.id = vt.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 7;

INSERT INTO verse_memory_aids (verse_id, hook_en, hook_hi, hook_hinglish, analogy_en, analogy_hi, analogy_hinglish, visual_cue)
SELECT v.id, m.h_en, m.h_hi, m.h_hing, m.a_en, m.a_hi, m.a_hing, m.cue FROM (
  SELECT 3 AS vn,
  'It counts an activity. It does not count anybody''s worth.' AS h_en,
  'यह एक काम गिनता है। यह किसी के मोल की गिनती नहीं है।' AS h_hi,
  'Yeh ek kaam ginta hai. Yeh kisi ke mol ki ginti nahi hai.' AS h_hing,
  'Like saying few people learn to sail. Nobody concludes the rest are lesser.' AS a_en,
  'यह कहने जैसा कि नाव चलाना कम लोग सीखते हैं। इससे कोई यह नहीं कहता कि बाक़ी कमतर हैं।' AS a_hi,
  'Yeh kehne jaisa ki naav chalana kam log seekhte hain. Isse koi yeh nahi kehta ki baaki kamtar hain.' AS a_hing,
  'A number, with no name attached' AS cue

  UNION ALL SELECT 5,
  'The higher nature has become the living. Not oversees it.',
  'ऊपर वाली प्रकृति जीव बन चुकी है। उसकी देखरेख नहीं कर रही।',
  'Upar wali prakriti jeev ban chuki hai. Uski dekhrekh nahi kar rahi.',
  'Like finding out the material and the thing made of it are the same news.',
  'यह पता चलने जैसा कि माल और उससे बनी चीज़ एक ही ख़बर हैं।',
  'Yeh pata chalne jaisa ki maal aur usse bani cheez ek hi khabar hain.',
  'One thing, not two stacked'

  UNION ALL SELECT 8,
  'The taste in water. First item on the list, and everybody has had some today.',
  'पानी में स्वाद। सूची की पहली चीज़, और आज सबने कुछ पिया है।',
  'Paani mein swaad. Soochi ki pehli cheez, aur aaj sabne kuch piya hai.',
  'Like being told where to look and being pointed at the tap.',
  'यह बताए जाने जैसा कि कहाँ देखो, और इशारा नल की तरफ़ हो।',
  'Yeh bataye jaane jaisa ki kahan dekho, aur ishara nal ki taraf ho.',
  'A glass of water, held up'

  UNION ALL SELECT 11,
  'I am desire — the kind not set against what holds things up.',
  'मैं चाह हूँ — वह वाली जो चीज़ों को थामे रखने वाले के ख़िलाफ़ नहीं है।',
  'Main chaah hoon — woh wali jo cheezon ko thaame rakhne wale ke khilaf nahi hai.',
  'Like a book everyone quotes against wanting, saying wanting is the good news.',
  'उस किताब जैसी जिसे सब चाह के ख़िलाफ़ उद्धृत करते हैं, और वह कहे कि चाह ही अच्छी ख़बर है।',
  'Us kitaab jaisi jise sab chaah ke khilaf uddhrit karte hain, aur woh kahe ki chaah hi achhi khabar hai.',
  'One word with a condition tied to its front'

  UNION ALL SELECT 14,
  'It says hard first, and offers the way across second.',
  'वह पहले मुश्किल कहता है, और पार का रास्ता बाद में देता है।',
  'Woh pehle mushkil kehta hai, aur paar ka raasta baad mein deta hai.',
  'Like a map that marks the river before it marks the bridge.',
  'ऐसे नक़्शे जैसा जो पुल से पहले नदी दिखाता है।',
  'Aise nakshe jaisa jo pul se pehle nadi dikhata hai.',
  'A river, then a bridge'

  UNION ALL SELECT 16,
  'Four kinds come, and the word for all four arrives before they are separated.',
  'चार तरह के लोग आते हैं, और चारों वाला शब्द उन्हें अलग करने से पहले आ जाता है।',
  'Chaar tarah ke log aate hain, aur chaaron wala shabd unhe alag karne se pehle aa jaata hai.',
  'Like a door with four handles and no bouncer.',
  'ऐसे दरवाज़े जैसा जिसमें चार हैंडल हैं और कोई रोकने वाला नहीं।',
  'Aise darwaze jaisa jisme chaar handle hain aur koi rokne wala nahi.',
  'One door, four handles'

  UNION ALL SELECT 17,
  'And then it ranks them. All four are already inside when it does.',
  'और फिर वह क्रम लगाता है। जब वह ऐसा करता है, चारों पहले से भीतर हैं।',
  'Aur phir woh kram lagata hai. Jab woh aisa karta hai, chaaron pehle se bheetar hain.',
  'Like seating a room. Nobody is being shown the door.',
  'कमरे में जगह देने जैसा। किसी को बाहर का रास्ता नहीं दिखाया जा रहा।',
  'Kamre mein jagah dene jaisa. Kisi ko bahar ka raasta nahi dikhaya ja raha.',
  'A room, everyone already seated'

  UNION ALL SELECT 21,
  'That very one. It redirects nobody.',
  'उसी को। वह किसी को नहीं मोड़ता।',
  'Usi ko. Woh kisi ko nahi modta.',
  'Like being asked which way you face and having the answer left alone.',
  'यह पूछे जाने जैसा कि आपका मुँह किधर है, और जवाब को छेड़ा न जाए।',
  'Yeh poochhe jaane jaisa ki tumhara munh kidhar hai, aur jawab ko chheda na jaaye.',
  'A door left where somebody put it'
) AS m
JOIN verses v ON v.verse_number = m.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 7;

INSERT INTO verse_reflections (verse_id, question_en, question_hi, question_hinglish, display_order)
SELECT v.id, r.q_en, r.q_hi, r.q_hing, r.ord FROM (
  SELECT 3 AS vn, 'Where have you seen a verse like this used to tell somebody they were nobody?' AS q_en, 'आपने ऐसा श्लोक कहाँ इस्तेमाल होते देखा है जिससे किसी को बताया गया हो कि वह कोई नहीं है?' AS q_hi, 'Tumne aisa shloka kahan istemaal hote dekha hai jisse kisi ko bataya gaya ho ki woh koi nahi hai?' AS q_hing, 1 AS ord
  UNION ALL SELECT 3, 'Few people learn to sail. Does that sentence rank anybody?', 'नाव चलाना कम लोग सीखते हैं। क्या यह वाक्य किसी का क्रम लगाता है?', 'Naav chalana kam log seekhte hain. Kya yeh vakya kisi ka kram lagata hai?', 2
  UNION ALL SELECT 3, 'Thirteen verses later the same chapter counts the person in trouble among those who have done well. What does that tell you about this one?', 'तेरह श्लोक बाद यही अध्याय मुसीबत वाले को उनमें गिनता है जिन्होंने ठीक किया। इससे इस श्लोक के बारे में क्या पता चलता है?', 'Terah shloka baad yahi adhyay museebat wale ko unme ginta hai jinhone theek kiya. Isse is shloka ke baare mein kya pata chalta hai?', 3
  UNION ALL SELECT 5, 'The verb is has become, not looks after. What changes if you read it that way?', 'क्रिया बन चुकी है, देखरेख करती है नहीं। इसे उस तरह पढ़ने से क्या बदलता है?', 'Kriya ban chuki hai, dekhrekh karti hai nahi. Ise us tarah padhne se kya badalta hai?', 1
  UNION ALL SELECT 5, 'Read alongside 15.7: you are made of the good half, and it does not get you out of anything. Which half is harder to hold?', '15.7 के साथ पढ़िए: आप अच्छे आधे से बने हैं, और इससे किसी चीज़ से छुटकारा नहीं मिलता। कौन-सा आधा थामना ज़्यादा मुश्किल है?', '15.7 ke saath padho: tum achhe aadhe se bane ho, aur isse kisi cheez se chhutkara nahi milta. Kaun sa aadha thaamna zyada mushkil hai?', 2
  UNION ALL SELECT 5, 'Nothing about you is being kept on a shelf, waiting. Is that a comfort or a demand?', 'आपकी कोई चीज़ किसी ताक़ पर, इंतज़ार में नहीं रखी जा रही। यह तसल्ली है या माँग?', 'Tumhari koi cheez kisi taak par, intezaar mein nahi rakhi ja rahi. Yeh tasalli hai ya maang?', 3
  UNION ALL SELECT 8, 'No temple is on the list and water is first. Why do you think that is?', 'सूची में कोई मंदिर नहीं है और पानी पहले है। आपको क्या लगता है, क्यों?', 'Soochi mein koi mandir nahi hai aur paani pehle hai. Tumhe kya lagta hai, kyun?', 1
  UNION ALL SELECT 8, 'Which item on the list did you meet today without noticing?', 'सूची की कौन-सी चीज़ आज आपसे मिली और आपने ध्यान नहीं दिया?', 'Soochi ki kaun si cheez aaj tumse mili aur tumne dhyan nahi diya?', 2
  UNION ALL SELECT 8, 'It says where to look and never says what to do. Does that suit you or frustrate you?', 'वह बताता है कहाँ देखें और कभी नहीं बताता क्या करें। यह आपको जँचता है या खलता है?', 'Woh batata hai kahan dekhein aur kabhi nahi batata kya karein. Yeh tumhe jamchta hai ya khalta hai?', 3
  UNION ALL SELECT 11, 'Name one thing you want that is not set against anything.', 'ऐसी एक चीज़ बताइए जो आप चाहते हैं और जो किसी के ख़िलाफ़ नहीं है।', 'Aisi ek cheez batao jo tum chahte ho aur jo kisi ke khilaf nahi hai.', 1
  UNION ALL SELECT 11, 'Who told you that wanting was the problem? Was it this book?', 'आपसे किसने कहा था कि चाह ही मुसीबत है? क्या यह किताब थी?', 'Tumse kisne kaha tha ki chaah hi museebat hai? Kya yeh kitaab thi?', 2
  UNION ALL SELECT 11, 'The qualifier is real and it is one word. What does it actually rule out?', 'शर्त असली है और एक शब्द की है। वह असल में क्या बाहर करती है?', 'Shart asli hai aur ek shabd ki hai. Woh asal mein kya bahar karti hai?', 3
  UNION ALL SELECT 14, 'The verse says hard before it says anything else. When did you last read that written down?', 'श्लोक कुछ भी कहने से पहले मुश्किल कहता है। आपने आख़िरी बार यह कब लिखा हुआ पढ़ा था?', 'Shloka kuch bhi kehne se pehle mushkil kehta hai. Tumne aakhiri baar yeh kab likha hua padha tha?', 1
  UNION ALL SELECT 14, 'What have you been promised would change everything in a weekend?', 'आपसे किस चीज़ का वादा किया गया था कि वह एक हफ़्ते में सब बदल देगी?', 'Tumse kis cheez ka waada kiya gaya tha ki woh ek hafte mein sab badal degi?', 2
  UNION ALL SELECT 14, 'Does knowing something is hard make it more or less possible to start?', 'यह जानना कि कोई चीज़ मुश्किल है, शुरू करना ज़्यादा मुमकिन बनाता है या कम?', 'Yeh jaanna ki koi cheez mushkil hai, shuru karna zyada mumkin banata hai ya kam?', 3
  UNION ALL SELECT 16, 'Which of the four doors did you come through? All four are named in the verse.', 'आप चार में से किस दरवाज़े से आए? चारों का नाम श्लोक में है।', 'Tum chaar mein se kis darwaze se aaye? Chaaron ka naam shloka mein hai.', 1
  UNION ALL SELECT 16, 'Have you ever felt you were reading something like this for the wrong reason?', 'क्या आपको कभी लगा है कि आप ऐसी कोई चीज़ ग़लत वजह से पढ़ रहे हैं?', 'Kya tumhe kabhi laga hai ki tum aisi koi cheez galat wajah se padh rahe ho?', 2
  UNION ALL SELECT 16, 'The word for all four arrives before they are separated. What is that word doing there?', 'चारों वाला शब्द उन्हें अलग करने से पहले आ जाता है। वह शब्द वहाँ क्या कर रहा है?', 'Chaaron wala shabd unhe alag karne se pehle aa jaata hai. Woh shabd wahan kya kar raha hai?', 3
  UNION ALL SELECT 17, 'The verse ranks. Would you have preferred it did not?', 'श्लोक क्रम लगाता है। आप चाहते कि न लगाता?', 'Shloka kram lagata hai. Tum chahte ki na lagata?', 1
  UNION ALL SELECT 17, 'Nobody in this verse is being shown the door. Does that change how the ranking reads?', 'इस श्लोक में किसी को बाहर का रास्ता नहीं दिखाया जा रहा। क्या इससे क्रम का पढ़ना बदलता है?', 'Is shloka mein kisi ko bahar ka raasta nahi dikhaya ja raha. Kya isse kram ka padhna badalta hai?', 2
  UNION ALL SELECT 17, 'When have you seen a ranking used to decide who gets to stay?', 'आपने क्रम को यह तय करने के लिए इस्तेमाल होते कब देखा है कि कौन रह सकता है?', 'Tumne kram ko yeh tay karne ke liye istemaal hote kab dekha hai ki kaun reh sakta hai?', 3
  UNION ALL SELECT 21, 'The verse redirects nobody. What would it have cost to write it the other way?', 'श्लोक किसी को नहीं मोड़ता। इसे दूसरी तरह लिखने में क्या ख़र्च होता?', 'Shloka kisi ko nahi modta. Ise doosri tarah likhne mein kya kharch hota?', 1
  UNION ALL SELECT 21, 'Where do you face when something matters? The verse leaves that where it is.', 'जब कोई चीज़ मायने रखती है तब आपका मुँह किधर होता है? श्लोक उसे वहीं रहने देता है।', 'Jab koi cheez maayne rakhti hai tab tumhara munh kidhar hota hai? Shloka use wahin rehne deta hai.', 2
  UNION ALL SELECT 21, 'Can somebody who shares none of this book''s frame use this chapter? What in the text says so?', 'क्या ऐसा कोई जो इस किताब का ढाँचा बिल्कुल नहीं मानता, इस अध्याय को बरत सकता है? ग्रंथ में ऐसा क्या है जो यह कहता हो?', 'Kya aisa koi jo is kitaab ka dhaancha bilkul nahi maanta, is adhyay ko barat sakta hai? Granth mein aisa kya hai jo yeh kehta ho?', 3
) AS r
JOIN verses v ON v.verse_number = r.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 7;

INSERT INTO verse_practices (verse_id, action_en, action_hi, action_hinglish, estimated_minutes, difficulty, display_order)
SELECT v.id, p.a_en, p.a_hi, p.a_hing, p.mins, p.diff, 1 FROM (
  SELECT 3 AS vn, 'Write down one thing few people do that you do not think less of anybody for skipping. Notice that this verse is that kind of sentence.' AS a_en, 'ऐसी एक चीज़ लिखिए जो कम लोग करते हैं और जिसे न करने पर आप किसी को कमतर नहीं मानते। ध्यान दीजिए कि यह श्लोक उसी तरह का वाक्य है।' AS a_hi, 'Aisi ek cheez likho jo kam log karte hain aur jise na karne par tum kisi ko kamtar nahi maante. Dhyan do ki yeh shloka usi tarah ka vakya hai.' AS a_hing, 5 AS mins, 'beginner' AS diff
  UNION ALL SELECT 5, 'Read 7.5 and 15.7 one after the other, in that order, once. Write one sentence about what the second one does to the first.', '7.5 और 15.7 को एक के बाद एक, इसी क्रम में, एक बार पढ़िए। एक वाक्य लिखिए कि दूसरा पहले के साथ क्या करता है।', '7.5 aur 15.7 ko ek ke baad ek, isi kram mein, ek baar padho. Ek vakya likho ki doosra pehle ke saath kya karta hai.', 8, 'intermediate'
  UNION ALL SELECT 8, 'Drink a glass of water and taste it. That is the whole practice and it is the first item on the verse''s own list.', 'एक गिलास पानी पीजिए और उसका स्वाद लीजिए। पूरा अभ्यास इतना ही है और श्लोक की अपनी सूची में यही पहली चीज़ है।', 'Ek gilas paani piyo aur uska swaad lo. Poora abhyas itna hi hai aur shloka ki apni soochi mein yahi pehli cheez hai.', 2, 'beginner'
  UNION ALL SELECT 11, 'List three things you want this month. Mark the ones that are set against nothing. Do not cross the others out — just notice how many there were.', 'इस महीने आप जो तीन चीज़ें चाहते हैं, लिखिए। उन पर निशान लगाइए जो किसी के ख़िलाफ़ नहीं हैं। बाक़ी को काटिए मत — बस देखिए कि वे कितनी थीं।', 'Is mahine tum jo teen cheezein chahte ho, likho. Un par nishan lagao jo kisi ke khilaf nahi hain. Baaki ko kaato mat — bas dekho ki we kitni thin.', 7, 'beginner'
  UNION ALL SELECT 14, 'Take something you have been trying to change and write down honestly how long it has already taken. No target date. The verse does not give one either.', 'ऐसी कोई चीज़ लीजिए जिसे आप बदलने की कोशिश कर रहे हैं और ईमानदारी से लिखिए कि इसमें अब तक कितना वक़्त लग चुका है। कोई तारीख़ मत रखिए। श्लोक भी नहीं देता।', 'Aisi koi cheez lo jise tum badalne ki koshish kar rahe ho aur imaandari se likho ki isme ab tak kitna waqt lag chuka hai. Koi tareekh mat rakho. Shloka bhi nahi deta.', 6, 'intermediate'
  UNION ALL SELECT 16, 'Write down, in one line, why you actually opened this. Not the reason that sounds best. The verse names four and does not rank them until the next one.', 'एक पंक्ति में लिखिए कि आपने असल में इसे क्यों खोला। वह वजह नहीं जो सबसे अच्छी लगती है। श्लोक चार का नाम लेता है और अगले श्लोक तक उनका क्रम नहीं लगाता।', 'Ek pankti mein likho ki tumne asal mein ise kyun khola. Woh wajah nahi jo sabse achhi lagti hai. Shloka chaar ka naam leta hai aur agle shloka tak unka kram nahi lagata.', 4, 'beginner'
  UNION ALL SELECT 17, 'Think of a room you have been in where a ranking decided who belonged. Write one line about what it cost. Do not apply the exercise to yourself.', 'ऐसे किसी कमरे के बारे में सोचिए जहाँ किसी क्रम ने तय किया कि कौन उसका है। एक पंक्ति लिखिए कि इसमें क्या ख़र्च हुआ। इस अभ्यास को अपने ऊपर मत लगाइए।', 'Aise kisi kamre ke baare mein socho jahan kisi kram ne tay kiya ki kaun uska hai. Ek pankti likho ki isme kya kharch hua. Is abhyas ko apne upar mat lagao.', 8, 'intermediate'
  UNION ALL SELECT 21, 'Name one thing you turn towards when something matters. Leave it exactly as it is. That is what the verse does with it.', 'ऐसी एक चीज़ बताइए जिसकी तरफ़ आप तब मुड़ते हैं जब कुछ मायने रखता है। उसे ठीक वैसे ही रहने दीजिए। श्लोक उसके साथ यही करता है।', 'Aisi ek cheez batao jiski taraf tum tab mudte ho jab kuch maayne rakhta hai. Use theek waise hi rehne do. Shloka uske saath yahi karta hai.', 4, 'beginner'
) AS p
JOIN verses v ON v.verse_number = p.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 7;

INSERT INTO verse_topics (verse_id, topic_id, relevance)
SELECT v.id, t.id, x.rel FROM (
  SELECT 3 AS vn, 'comparison' AS slug, 10 AS rel
  UNION ALL SELECT 3, 'effort-without-result', 8
  UNION ALL SELECT 3, 'steadiness', 6
  UNION ALL SELECT 5, 'the-self', 10
  UNION ALL SELECT 5, 'impermanence', 7
  UNION ALL SELECT 5, 'steadiness', 6
  UNION ALL SELECT 8, 'the-self', 8
  UNION ALL SELECT 8, 'restlessness', 7
  UNION ALL SELECT 8, 'steadiness', 7
  UNION ALL SELECT 11, 'desire', 10
  UNION ALL SELECT 11, 'duty', 7
  UNION ALL SELECT 11, 'hard-decisions', 6
  UNION ALL SELECT 14, 'effort-without-result', 9
  UNION ALL SELECT 14, 'burnout', 7
  UNION ALL SELECT 14, 'steadiness', 7
  UNION ALL SELECT 16, 'grief', 9
  UNION ALL SELECT 16, 'fear', 8
  UNION ALL SELECT 16, 'comparison', 8
  UNION ALL SELECT 16, 'desire', 7
  UNION ALL SELECT 17, 'comparison', 10
  UNION ALL SELECT 17, 'steadiness', 7
  UNION ALL SELECT 17, 'the-self', 6
  UNION ALL SELECT 21, 'hard-decisions', 8
  UNION ALL SELECT 21, 'steadiness', 8
  UNION ALL SELECT 21, 'comparison', 7
  UNION ALL SELECT 21, 'fear', 6
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 7
JOIN topics t ON t.slug = x.slug;

-- =====================================================================
-- 4. MODERN EXAMPLES
-- =====================================================================
-- Four per verse, four distinct categories per verse, THIRTY-TWO total.
--
-- NOT ONE EXAMPLE IN THIS FILE SHOWS SOMEBODY BEING TOLD THEY CAME FOR
-- A LESSER REASON. The 7.16 set is four people arriving in four
-- different states, and in all four the arrival is treated as the whole
-- qualification, because that is what the verse does.
--
-- THE 7.17 SET IS ABOUT WHAT A RANKING IS FOR. In all four, a ranking
-- exists and is real; what varies is whether it is used to sort people
-- who are all inside or to decide who is let in at all. The verse does
-- the first. Every example that shows the second shows it going wrong.
--
-- THE 7.14 SET NEVER PROMISES A TIMESCALE.
-- =====================================================================

DELETE e FROM modern_examples e JOIN verses v ON v.id = e.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 7;

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

  SELECT 3 AS vn, 'school' AS cat, 1 AS ord,
  'Two out of ninety take up the clarinet' AS t_en, 'नब्बे में से दो शहनाई उठाते हैं' AS t_hi, 'Nabbe mein se do shehnai uthate hain' AS t_hing,
  'A music teacher offers clarinet lessons to a whole year group. Two sign up. She is delighted, plans for two, and does not spend a second thinking about the eighty-eight who did not.' AS s_en,
  'एक संगीत शिक्षिका पूरे बैच को शहनाई सिखाने की पेशकश करती हैं। दो नाम लिखवाते हैं। वे ख़ुश होती हैं, दो के हिसाब से तैयारी करती हैं, और उन अठासी के बारे में एक पल भी नहीं सोचतीं जिन्होंने नहीं लिखवाया।' AS s_hi,
  'Ek sangeet shikshika poore batch ko shehnai sikhane ki peshkash karti hain. Do naam likhwate hain. We khush hoti hain, do ke hisaab se taiyari karti hain, aur un athasi ke baare mein ek pal bhi nahi sochtin jinhone nahi likhwaya.' AS s_hing,
  'That is the grammar of 7.3 and it is the reason the verse is not an insult. Two out of ninety is a count of who took something up. Nobody in that staffroom concludes the other eighty-eight are lesser, because a count of an activity is not a count of worth — and this verse is doing the first thing, in a chapter that will name the person in trouble as somebody who has done well thirteen verses later.' AS c_en,
  'यही 7.3 की बनावट है और यही वजह है कि श्लोक गाली नहीं है। नब्बे में से दो यह गिनती है कि किसने कोई चीज़ उठाई। उस स्टाफ़रूम में कोई यह नतीजा नहीं निकालता कि बाक़ी अठासी कमतर हैं, क्योंकि किसी काम की गिनती मोल की गिनती नहीं होती — और यह श्लोक पहला काम कर रहा है, उस अध्याय में जो तेरह श्लोक बाद मुसीबत में पड़े आदमी को उनमें गिनेगा जिन्होंने ठीक किया।' AS c_hi,
  'Yahi 7.3 ki banawat hai aur yahi wajah hai ki shloka gaali nahi hai. Nabbe mein se do yeh ginti hai ki kisne koi cheez uthai. Us staffroom mein koi yeh nateeja nahi nikalta ki baaki athasi kamtar hain, kyunki kisi kaam ki ginti mol ki ginti nahi hoti — aur yeh shloka pehla kaam kar raha hai, us adhyay mein jo terah shloka baad museebat mein pade aadmi ko unme ginega jinhone theek kiya.' AS c_hing,
  'A count of an activity is not a count of worth.' AS l_en,
  'किसी काम की गिनती मोल की गिनती नहीं है।' AS l_hi,
  'Kisi kaam ki ginti mol ki ginti nahi hai.' AS l_hing,
  NULL AS src, 'beginner' AS diff, 'counting,worth,rarity,teaching' AS tags

  UNION ALL SELECT 3, 'sports', 2,
  'The lane nobody is in', 'वह लेन जिसमें कोई नहीं है', 'Woh lane jisme koi nahi hai',
  'A swimming club has four hundred members and eleven who train before six. The eleven talk about the eleven. Once a year somebody says something sour about everyone else, and the coach shuts it down without ceremony.',
  'एक तैराकी क्लब में चार सौ सदस्य हैं और ग्यारह ऐसे जो छह से पहले अभ्यास करते हैं। ग्यारह ग्यारह की बात करते हैं। साल में एक बार कोई बाक़ी सबके बारे में कुछ कड़वा कहता है, और कोच बिना किसी तमाशे के उसे रोक देता है।',
  'Ek tairaki club mein chaar sau sadasya hain aur gyarah aise jo chhah se pehle abhyas karte hain. Gyarah gyarah ki baat karte hain. Saal mein ek baar koi baaki sabke baare mein kuch kadwa kehta hai, aur coach bina kisi tamashe ke use rok deta hai.',
  'The verse can be read either way and people have read it both. Eleven out of four hundred is true and says nothing about anybody. It becomes something else the moment one of the eleven uses it, and the coach who shuts that down is doing what the chapter does itself thirteen verses on. Rarity is a fact about a schedule. It is not a fact about a person.',
  'श्लोक दोनों तरह पढ़ा जा सकता है और लोगों ने दोनों तरह पढ़ा है। चार सौ में ग्यारह सच है और किसी के बारे में कुछ नहीं कहता। वह कुछ और तब बन जाता है जब उन ग्यारह में से कोई उसे बरतता है, और जो कोच उसे रोकता है वह वही कर रहा है जो अध्याय ख़ुद तेरह श्लोक बाद करता है। दुर्लभ होना समय-सारणी के बारे में तथ्य है। वह किसी आदमी के बारे में तथ्य नहीं है।',
  'Shloka dono tarah padha ja sakta hai aur logon ne dono tarah padha hai. Chaar sau mein gyarah sach hai aur kisi ke baare mein kuch nahi kehta. Woh kuch aur tab ban jaata hai jab un gyarah mein se koi use baratta hai, aur jo coach use rokta hai woh wahi kar raha hai jo adhyay khud terah shloka baad karta hai. Durlabh hona samay-saarni ke baare mein tathya hai. Woh kisi aadmi ke baare mein tathya nahi hai.',
  'Rarity is a fact about a schedule, not about a person.',
  'दुर्लभ होना समय-सारणी का तथ्य है, किसी आदमी का नहीं।',
  'Durlabh hona samay-saarni ka tathya hai, kisi aadmi ka nahi.',
  NULL, 'intermediate', 'rarity,superiority,training,correction'

  UNION ALL SELECT 3, 'corporate', 3,
  'The certification nobody needed', 'वह प्रमाणपत्र जिसकी किसी को ज़रूरत नहीं थी', 'Woh pramanpatra jiski kisi ko zaroorat nahi thi',
  'Four people out of two hundred hold a difficult qualification. For years it was just a fact. Then somebody puts it in an email signature, and within a quarter there are two groups in a department that used to be one.',
  'दो सौ में से चार लोगों के पास एक कठिन योग्यता है। सालों तक यह बस एक तथ्य था। फिर कोई उसे ईमेल के हस्ताक्षर में डाल देता है, और एक तिमाही के भीतर उस विभाग में दो समूह बन जाते हैं जो पहले एक था।',
  'Do sau mein se chaar logon ke paas ek kathin yogyata hai. Saalon tak yeh bas ek tathya tha. Phir koi use email ke hastakshar mein daal deta hai, aur ek timahi ke bheetar us vibhag mein do samooh ban jaate hain jo pehle ek tha.',
  'Nothing about the number changed. What changed was what it was being used for, and that is the entire difference between reading 7.3 as a count and reading it as a scoreboard. The verse itself does not put anything in a signature: it states two ratios and moves on, and the chapter it sits in goes on to count four kinds of arrival as equally good.',
  'आँकड़े में कुछ नहीं बदला। बदला यह कि उसे किस काम में लगाया जा रहा है, और 7.3 को गिनती की तरह पढ़ने और तालिका की तरह पढ़ने में यही पूरा फ़र्क़ है। श्लोक ख़ुद किसी हस्ताक्षर में कुछ नहीं डालता: वह दो अनुपात बताता है और आगे बढ़ जाता है, और जिस अध्याय में वह है वह आगे चलकर चार तरह के आने को बराबर अच्छा गिनता है।',
  'Aankde mein kuch nahi badla. Badla yeh ki use kis kaam mein lagaya ja raha hai, aur 7.3 ko ginti ki tarah padhne aur talika ki tarah padhne mein yahi poora farq hai. Shloka khud kisi hastakshar mein kuch nahi daalta: woh do anupaat batata hai aur aage badh jaata hai, aur jis adhyay mein woh hai woh aage chalkar chaar tarah ke aane ko barabar achha ginta hai.',
  'Nothing about the number changed. What changed was what it was for.',
  'आँकड़े में कुछ नहीं बदला। बदला यह कि वह किस काम के लिए था।',
  'Aankde mein kuch nahi badla. Badla yeh ki woh kis kaam ke liye tha.',
  NULL, 'intermediate', 'credentials,division,status,numbers'

  UNION ALL SELECT 3, 'everyday_life', 4,
  'The reader who put the book down', 'वह पाठक जिसने किताब रख दी', 'Woh pathak jisne kitaab rakh di',
  'Somebody opens a book like this one for the first time, reaches a line about how few people ever get anywhere with it, and closes it. She does not come back for six years.',
  'कोई इस जैसी किताब पहली बार खोलता है, ऐसी पंक्ति तक पहुँचता है कि कितने कम लोग इससे कहीं पहुँच पाते हैं, और उसे बंद कर देता है। वह छह साल तक वापस नहीं आती।',
  'Koi is jaisi kitaab pehli baar kholta hai, aisi pankti tak pahunchta hai ki kitne kam log isse kahin pahunch paate hain, aur use band kar deta hai. Woh chhah saal tak wapas nahi aati.',
  'This is the cost of the scoreboard reading and it is why this page says the other thing first. The verse counts an activity and not a worth. And whoever wrote the chapter put four kinds of arrival on the list thirteen verses later — including the one who came in trouble and the one who came because they wanted something — which means the door was never the narrow thing this verse looks like on its own.',
  'यह तालिका वाले पाठ की क़ीमत है और इसीलिए यह पन्ना दूसरी बात पहले कहता है। श्लोक एक काम गिनता है, किसी का मोल नहीं। और जिसने यह अध्याय लिखा उसने तेरह श्लोक बाद चार तरह के आने को सूची में रखा — उसे भी जो मुसीबत में आया और उसे भी जो इसलिए आया कि उसे कुछ चाहिए था — जिसका मतलब है कि दरवाज़ा कभी उतना सँकरा था ही नहीं जितना यह श्लोक अकेले में दिखता है।',
  'Yeh talika wale paath ki keemat hai aur isiliye yeh panna doosri baat pehle kehta hai. Shloka ek kaam ginta hai, kisi ka mol nahi. Aur jisne yeh adhyay likha usne terah shloka baad chaar tarah ke aane ko soochi mein rakha — use bhi jo museebat mein aaya aur use bhi jo isliye aaya ki use kuch chahiye tha — jiska matlab hai ki darwaza kabhi utna sankara tha hi nahi jitna yeh shloka akele mein dikhta hai.',
  'The door was never the narrow thing this verse looks like on its own.',
  'दरवाज़ा कभी उतना सँकरा था ही नहीं जितना यह श्लोक अकेले में दिखता है।',
  'Darwaza kabhi utna sankara tha hi nahi jitna yeh shloka akele mein dikhta hai.',
  NULL, 'beginner', 'discouragement,reading,doors,returning'

  UNION ALL SELECT 5, 'parenting', 1,
  'Made of, not looked after by', 'बना हुआ, देखरेख में नहीं', 'Bana hua, dekhrekh mein nahi',
  'A mother catches herself saying her son has a good heart underneath it all. Her sister asks what the underneath is doing there. She thinks about it and cannot answer, and afterwards she stops saying it that way.',
  'एक माँ ख़ुद को यह कहते पकड़ती है कि उसके बेटे का दिल सब कुछ के नीचे अच्छा है। उसकी बहन पूछती है कि यह नीचे वहाँ क्या कर रहा है। वह सोचती है और जवाब नहीं दे पाती, और उसके बाद वह ऐसे कहना छोड़ देती है।',
  'Ek maa khud ko yeh kehte pakadti hai ki uske bete ka dil sab kuch ke neeche achha hai. Uski behen poochhti hai ki yeh neeche wahan kya kar raha hai. Woh sochti hai aur jawab nahi de paati, aur uske baad woh aise kehna chhod deti hai.',
  'Jiva-bhutam. The higher nature has become the living being, and the verb is one of having turned into rather than one of sitting above. That is the difference between a good heart underneath everything and a person who is made of the thing. The first version quietly keeps the good part somewhere else, safe and uninvolved, and the verse does not put it there.',
  'जीवभूताम्। ऊपर वाली प्रकृति जीव बन चुकी है, और क्रिया बन जाने की है, ऊपर बैठे रहने की नहीं। नीचे कहीं अच्छे दिल और उस चीज़ से बने आदमी में यही फ़र्क़ है। पहले रूप में अच्छा हिस्सा चुपचाप कहीं और, सुरक्षित और अलग, रखा रहता है, और श्लोक उसे वहाँ नहीं रखता।',
  'Jiva-bhutam. Upar wali prakriti jeev ban chuki hai, aur kriya ban jaane ki hai, upar baithe rehne ki nahi. Neeche kahin achhe dil aur us cheez se bane aadmi mein yahi farq hai. Pehle roop mein achha hissa chupchap kahin aur, surakshit aur alag, rakha rehta hai, aur shloka use wahan nahi rakhta.',
  'A good heart underneath keeps the good part somewhere else. The verb here is has become.',
  'नीचे कहीं अच्छा दिल अच्छे हिस्से को कहीं और रखता है। यहाँ क्रिया है बन चुकी है।',
  'Neeche kahin achha dil achhe hisse ko kahin aur rakhta hai. Yahan kriya hai ban chuki hai.',
  NULL, 'intermediate', 'language,wholeness,children,noticing'

  UNION ALL SELECT 5, 'healthcare', 2,
  'The ward that is also the staff', 'वह वार्ड जो स्टाफ़ भी है', 'Woh ward jo staff bhi hai',
  'A hospital runs a wellbeing programme for its nurses and holds it in a room across the road. Attendance is poor. A new manager moves it into the ward''s own break room at handover time and attendance triples.',
  'एक अस्पताल अपनी नर्सों के लिए भलाई का कार्यक्रम चलाता है और उसे सड़क पार के एक कमरे में रखता है। हाज़िरी कम रहती है। एक नई मैनेजर उसे वार्ड के अपने ब्रेक रूम में, शिफ़्ट बदलने के वक़्त, ले आती हैं और हाज़िरी तिगुनी हो जाती है।',
  'Ek aspatal apni narson ke liye bhalai ka karyakram chalata hai aur use sadak paar ke ek kamre mein rakhta hai. Haaziri kam rehti hai. Ek nayi manager use ward ke apne break room mein, shift badalne ke waqt, le aati hain aur haaziri tiguni ho jaati hai.',
  'The programme across the road was built on the assumption that the good thing happens somewhere else and you go to it. 7.5 says the opposite about the arrangement it is describing: the higher nature has become the living, so there is no across-the-road. Read next to 15.7, which puts the same fragment in the body doing the hauling, the pair says a person is not divided into a part that matters and a part that turns up.',
  'सड़क पार का कार्यक्रम इस मान्यता पर बना था कि अच्छी चीज़ कहीं और होती है और आप उस तक जाते हैं। 7.5 जिस बंदोबस्त का वर्णन करता है उसके बारे में उल्टा कहता है: ऊपर वाली प्रकृति जीव बन चुकी है, तो सड़क पार कुछ है ही नहीं। 15.7 के बग़ल में पढ़िए, जो उसी अंश को शरीर में खींचता हुआ रखता है, और दोनों मिलकर कहते हैं कि आदमी उस हिस्से और उस हिस्से में बँटा नहीं है जो मायने रखता है और जो हाज़िर होता है।',
  'Sadak paar ka karyakram is manyata par bana tha ki achhi cheez kahin aur hoti hai aur aap us tak jaate hain. 7.5 jis bandobast ka varnan karta hai uske baare mein ulta kehta hai: upar wali prakriti jeev ban chuki hai, to sadak paar kuch hai hi nahi. 15.7 ke bagal mein padhiye, jo usi ansh ko sharir mein kheenchta hua rakhta hai, aur dono milkar kehte hain ki aadmi us hisse aur us hisse mein banta nahi hai jo maayne rakhta hai aur jo haazir hota hai.',
  'There is no across-the-road. That is what has become means.',
  'सड़क पार कुछ है ही नहीं। बन चुकी है का यही मतलब है।',
  'Sadak paar kuch hai hi nahi. Ban chuki hai ka yahi matlab hai.',
  NULL, 'intermediate', 'location,wholeness,work,attendance'

  UNION ALL SELECT 5, 'technology', 3,
  'The abstraction that was the thing', 'वह अमूर्तन जो ख़ुद वही चीज़ थी', 'Woh amoortan jo khud wahi cheez thi',
  'A junior engineer spends a week looking for the real system behind the interface she has been working on. There is not one. The interface is the system. Her lead says everybody does this once.',
  'एक जूनियर इंजीनियर पूरा हफ़्ता उस असली सिस्टम को ढूँढ़ने में लगाती है जो उस इंटरफ़ेस के पीछे है जिस पर वह काम कर रही है। ऐसा कुछ है ही नहीं। इंटरफ़ेस ही सिस्टम है। उसका लीड कहता है कि यह हर कोई एक बार करता है।',
  'Ek junior engineer poora hafta us asli system ko dhoondhne mein lagati hai jo us interface ke peechhe hai jis par woh kaam kar rahi hai. Aisa kuch hai hi nahi. Interface hi system hai. Uska lead kehta hai ki yeh har koi ek baar karta hai.',
  'Everybody does this once with the self as well. The verse forecloses the search in the same way: the higher nature has not stayed behind the living being as a truer version — it has become it. What the searching costs is a week here and considerably more elsewhere, which is why 7.5 and 15.7 are the pair to read together rather than either one alone.',
  'यह हर कोई एक बार आत्मा के साथ भी करता है। श्लोक उसी तरह खोज को बंद कर देता है: ऊपर वाली प्रकृति जीव के पीछे किसी और सच्चे रूप की तरह रुकी नहीं है — वह उसी में बदल चुकी है। खोजने में यहाँ एक हफ़्ता लगता है और कहीं और उससे कहीं ज़्यादा, और इसीलिए 7.5 और 15.7 को साथ पढ़ना है, अकेले किसी एक को नहीं।',
  'Yeh har koi ek baar aatma ke saath bhi karta hai. Shloka usi tarah khoj ko band kar deta hai: upar wali prakriti jeev ke peechhe kisi aur sachche roop ki tarah ruki nahi hai — woh usi mein badal chuki hai. Khojne mein yahan ek hafta lagta hai aur kahin aur usse kahin zyada, aur isiliye 7.5 aur 15.7 ko saath padhna hai, akele kisi ek ko nahi.',
  'There is no truer version standing behind it. It has become it.',
  'उसके पीछे कोई और सच्चा रूप खड़ा नहीं है। वह उसी में बदल चुकी है।',
  'Uske peechhe koi aur sachcha roop khada nahi hai. Woh usi mein badal chuki hai.',
  NULL, 'intermediate', 'searching,abstraction,identity,relief'

  UNION ALL SELECT 5, 'friendship', 4,
  'The friend who was not a stage', 'वह दोस्त जो कोई पड़ाव नहीं था', 'Woh dost jo koi padav nahi tha',
  'Two friends of eleven years. One of them mentions, lightly, that he used to think of this friendship as practice for something more serious later. They both laugh and then neither of them says anything for a while.',
  'ग्यारह साल के दो दोस्त। उनमें से एक हल्के-फुल्के ढंग से बताता है कि वह इस दोस्ती को आगे किसी ज़्यादा गंभीर चीज़ की तैयारी समझता था। दोनों हँसते हैं और फिर कुछ देर कोई कुछ नहीं कहता।',
  'Gyarah saal ke do dost. Unme se ek halke-fulke dhang se batata hai ki woh is dosti ko aage kisi zyada gambhir cheez ki taiyari samajhta tha. Dono hanste hain aur phir kuch der koi kuch nahi kehta.',
  'Treating what is here as the rehearsal for a realer version somewhere ahead is the habit this verse cuts across. The higher nature has become the living — not is preparing to, not will once conditions are right. Eleven years of a friendship is not practice for a friendship, and the grammar of jiva-bhutam is the same grammar.',
  'जो यहाँ है उसे आगे कहीं किसी ज़्यादा असली रूप की रिहर्सल मानना वही आदत है जिसे यह श्लोक काटता है। ऊपर वाली प्रकृति जीव बन चुकी है — बनने की तैयारी में नहीं, हालात ठीक होने पर बनेगी भी नहीं। ग्यारह साल की दोस्ती किसी दोस्ती की तैयारी नहीं होती, और जीवभूताम् की बनावट वही बनावट है।',
  'Jo yahan hai use aage kahin kisi zyada asli roop ki rehearsal maanna wahi aadat hai jise yeh shloka kaatta hai. Upar wali prakriti jeev ban chuki hai — banne ki taiyari mein nahi, haalat theek hone par banegi bhi nahi. Gyarah saal ki dosti kisi dosti ki taiyari nahi hoti, aur jiva-bhutam ki banawat wahi banawat hai.',
  'Not preparing to. Not once conditions are right. Has become.',
  'बनने की तैयारी में नहीं। हालात ठीक होने पर नहीं। बन चुकी है।',
  'Banne ki taiyari mein nahi. Haalat theek hone par nahi. Ban chuki hai.',
  NULL, 'beginner', 'rehearsal,presence,friendship,now'

  UNION ALL SELECT 8, 'everyday_life', 1,
  'A glass of water, tasted once', 'एक गिलास पानी, एक बार चखा हुआ', 'Ek gilas paani, ek baar chakha hua',
  'A man who has been reading about all this for two years is told by somebody impatient to just drink a glass of water and taste it. He does, feeling faintly cheated. It is the first thing in two years he can describe without quoting anybody.',
  'दो साल से यह सब पढ़ते आ रहे एक आदमी से कोई झुँझलाकर कहता है कि बस एक गिलास पानी पियो और उसका स्वाद लो। वह पीता है, हल्का ठगा हुआ महसूस करते हुए। दो साल में यही पहली चीज़ है जिसे वह किसी का हवाला दिए बिना बता सकता है।',
  'Do saal se yeh sab padhte aa rahe ek aadmi se koi jhunjhlakar kehta hai ki bas ek gilas paani piyo aur uska swaad lo. Woh peeta hai, halka thaga hua mehsoos karte hue. Do saal mein yahi pehli cheez hai jise woh kisi ka hawala diye bina bata sakta hai.',
  'The first item on the verse''s own list is the taste in water. A chapter that had wanted to be difficult, or exclusive, or expensive to enter had every opportunity here and named the tap. Nothing on that list is something anybody has to be admitted to, and the ordering is an argument the verse makes without stating it.',
  'श्लोक की अपनी सूची में पहली चीज़ पानी में स्वाद है। जो अध्याय मुश्किल, या ख़ास लोगों का, या भीतर आने में महँगा होना चाहता, उसके पास यहाँ पूरा मौक़ा था और उसने नल का नाम लिया। उस सूची में कुछ भी ऐसा नहीं जिसमें किसी को दाख़िला लेना पड़े, और यह क्रम ख़ुद एक दलील है जिसे श्लोक कहता नहीं।',
  'Shloka ki apni soochi mein pehli cheez paani mein swaad hai. Jo adhyay mushkil, ya khaas logon ka, ya bheetar aane mein mehnga hona chahta, uske paas yahan poora mauka tha aur usne nal ka naam liya. Us soochi mein kuch bhi aisa nahi jisme kisi ko daakhila lena pade, aur yeh kram khud ek dalil hai jise shloka kehta nahi.',
  'It had every opportunity to be difficult and it named the tap.',
  'उसके पास मुश्किल होने का पूरा मौक़ा था और उसने नल का नाम लिया।',
  'Uske paas mushkil hone ka poora mauka tha aur usne nal ka naam liya.',
  NULL, 'beginner', 'ordinary,accessible,water,first-hand'

  UNION ALL SELECT 8, 'cricket', 2,
  'The sound off the middle', 'बल्ले के बीच से आती आवाज़', 'Balle ke beech se aati awaaz',
  'A club player who has never described anything in his life as beautiful spends five minutes explaining to his daughter what a ball off the middle of the bat sounds like. He gets quite specific about it.',
  'एक क्लब खिलाड़ी, जिसने ज़िंदगी में कभी किसी चीज़ को सुंदर नहीं कहा, अपनी बेटी को पाँच मिनट समझाता है कि बल्ले के ठीक बीच से लगी गेंद की आवाज़ कैसी होती है। वह इसमें काफ़ी बारीक़ हो जाता है।',
  'Ek club khiladi, jisne zindagi mein kabhi kisi cheez ko sundar nahi kaha, apni beti ko paanch minute samjhata hai ki balle ke theek beech se lagi gend ki awaaz kaisi hoti hai. Woh isme kaafi bareek ho jaata hai.',
  'Shabdah khe — sound in open air, third from last on the list. The verse points at things people already know first-hand and have no vocabulary for, which is a different move from asking anybody to believe something. Five minutes of specific description from somebody who does not talk that way is what the list is for.',
  'शब्दः खे — खुली हवा में आवाज़, सूची में आख़िर से तीसरी। श्लोक उन चीज़ों की तरफ़ इशारा करता है जिन्हें लोग पहले से ख़ुद जानते हैं और जिनके लिए उनके पास शब्द नहीं हैं, और यह किसी से कुछ मानने को कहने से अलग चाल है। जो आदमी ऐसे बात नहीं करता उसका पाँच मिनट का बारीक़ वर्णन ही वह है जिसके लिए सूची है।',
  'Shabdah khe — khuli hawa mein awaaz, soochi mein aakhir se teesri. Shloka un cheezon ki taraf ishara karta hai jinhe log pehle se khud jaante hain aur jinke liye unke paas shabd nahi hain, aur yeh kisi se kuch maanne ko kehne se alag chaal hai. Jo aadmi aise baat nahi karta uska paanch minute ka bareek varnan hi woh hai jiske liye soochi hai.',
  'It points at what people already know first-hand and have no words for.',
  'वह उस तरफ़ इशारा करता है जिसे लोग पहले से ख़ुद जानते हैं और जिसके लिए शब्द नहीं हैं।',
  'Woh us taraf ishara karta hai jise log pehle se khud jaante hain aur jiske liye shabd nahi hain.',
  NULL, 'beginner', 'senses,vocabulary,ordinary,first-hand'

  UNION ALL SELECT 8, 'marriage', 3,
  'The moon on the way back from the shop', 'दुकान से लौटते हुए चाँद', 'Dukan se lautte hue chaand',
  'Two people walk back from the shop and one of them stops. There is nothing to say about the moon and she does not say anything. He stops too. They stand there for about forty seconds and then carry the bags home.',
  'दो लोग दुकान से लौट रहे हैं और उनमें से एक रुक जाती है। चाँद के बारे में कहने को कुछ नहीं है और वह कुछ कहती भी नहीं। वह भी रुक जाता है। वे क़रीब चालीस सेकंड वहाँ खड़े रहते हैं और फिर थैले लेकर घर चले जाते हैं।',
  'Do log dukan se laut rahe hain aur unme se ek ruk jaati hai. Chaand ke baare mein kehne ko kuch nahi hai aur woh kuch kehti bhi nahi. Woh bhi ruk jaata hai. We kareeb chalis second wahan khade rehte hain aur phir thaile lekar ghar chale jaate hain.',
  'Prabhasmi shashi-suryayoh — the shine in the moon and the sun, second on the list. Notice how little the verse asks for. It does not say to feel anything about the moon or to conclude anything from it. It says where the thing it has been talking about can be found, and forty seconds on a pavement with the shopping is not a lesser instance of that than anything else.',
  'प्रभास्मि शशिसूर्ययोः — चाँद और सूरज में चमक, सूची में दूसरी। ध्यान दीजिए कि श्लोक कितना कम माँगता है। वह यह नहीं कहता कि चाँद के बारे में कुछ महसूस करो या उससे कोई नतीजा निकालो। वह बताता है कि जिस चीज़ की बात वह करता आया है वह कहाँ मिलेगी, और सौदे के साथ फ़ुटपाथ पर चालीस सेकंड उसका किसी और से कमतर नमूना नहीं है।',
  'Prabhasmi shashi-suryayoh — chaand aur sooraj mein chamak, soochi mein doosri. Dhyan dijiye ki shloka kitna kam maangta hai. Woh yeh nahi kehta ki chaand ke baare mein kuch mehsoos karo ya usse koi nateeja nikalo. Woh batata hai ki jis cheez ki baat woh karta aaya hai woh kahan milegi, aur saude ke saath footpath par chalis second uska kisi aur se kamtar namoona nahi hai.',
  'It does not ask anybody to feel anything. It says where to find it.',
  'वह किसी से कुछ महसूस करने को नहीं कहता। वह बताता है कि कहाँ मिलेगी।',
  'Woh kisi se kuch mehsoos karne ko nahi kehta. Woh batata hai ki kahan milegi.',
  NULL, 'beginner', 'ordinary,together,noticing,small'

  UNION ALL SELECT 8, 'college', 4,
  'The list without a temple on it', 'वह सूची जिसमें कोई मंदिर नहीं', 'Woh soochi jisme koi mandir nahi',
  'A student who has been told all her life that she does not belong in these texts reads this verse in a library. Water, moonlight, one syllable, sound in air, and whatever gets things done in people. She reads it twice and takes a photograph of the page.',
  'एक छात्रा, जिसे सारी उम्र बताया गया कि इन ग्रंथों में उसकी जगह नहीं है, पुस्तकालय में यह श्लोक पढ़ती है। पानी, चाँदनी, एक अक्षर, हवा में आवाज़, और लोगों में वह जो काम कर गुज़रता है। वह उसे दो बार पढ़ती है और पन्ने की तस्वीर ले लेती है।',
  'Ek chhatra, jise saari umr bataya gaya ki in granthon mein uski jagah nahi hai, pustakalay mein yeh shloka padhti hai. Paani, chaandni, ek akshar, hawa mein awaaz, aur logon mein woh jo kaam kar guzarta hai. Woh use do baar padhti hai aur panne ki tasveer le leti hai.',
  'Look at what is not on the list: no temple, no rite, no rank, no birth, nothing anybody has to be let into. That is not a modern reading of the verse; it is what the verse contains and what it does not. The people who told her otherwise were not quoting this line, because this line does not help them.',
  'देखिए सूची में क्या नहीं है: कोई मंदिर नहीं, कोई कर्मकांड नहीं, कोई दर्जा नहीं, कोई जन्म नहीं, कोई ऐसी चीज़ नहीं जिसमें किसी को घुसने दिया जाना पड़े। यह श्लोक का कोई आधुनिक पाठ नहीं है; यह वही है जो श्लोक में है और जो नहीं है। जिन लोगों ने उसे उल्टा बताया वे इस पंक्ति का हवाला नहीं दे रहे थे, क्योंकि यह पंक्ति उनके काम की नहीं है।',
  'Dekhiye soochi mein kya nahi hai: koi mandir nahi, koi karmkaand nahi, koi darja nahi, koi janm nahi, koi aisi cheez nahi jisme kisi ko ghusne diya jaana pade. Yeh shloka ka koi aadhunik paath nahi hai; yeh wahi hai jo shloka mein hai aur jo nahi hai. Jin logon ne use ulta bataya we is pankti ka hawala nahi de rahe the, kyunki yeh pankti unke kaam ki nahi hai.',
  'No temple, no rite, no rank, no birth. That is what the line contains.',
  'कोई मंदिर नहीं, कोई कर्मकांड नहीं, कोई दर्जा नहीं, कोई जन्म नहीं। पंक्ति में यही है।',
  'Koi mandir nahi, koi karmkaand nahi, koi darja nahi, koi janm nahi. Pankti mein yahi hai.',
  NULL, 'intermediate', 'access,belonging,plainness,texts'

  UNION ALL SELECT 11, 'relationships', 1,
  'The want that was not a flaw', 'वह चाह जो ख़ामी नहीं थी', 'Woh chaah jo khaami nahi thi',
  'A man has spent four years treating his wish to be with somebody as a weakness he ought to have grown out of. A friend asks him which part of it is set against anybody. He cannot find one.',
  'एक आदमी चार साल से किसी के साथ होने की अपनी चाह को ऐसी कमज़ोरी मानता आया है जिससे उसे अब तक निकल जाना चाहिए था। एक दोस्त पूछता है कि इसका कौन-सा हिस्सा किसी के ख़िलाफ़ है। उसे कोई मिलता नहीं।',
  'Ek aadmi chaar saal se kisi ke saath hone ki apni chaah ko aisi kamzori maanta aaya hai jisse use ab tak nikal jaana chahiye tha. Ek dost poochhta hai ki iska kaun sa hissa kisi ke khilaf hai. Use koi milta nahi.',
  'Dharma-aviruddha is the whole qualifier and it is a narrow one: desire not set against what holds things up. It rules a great deal less out than most people assume, and the book that gets quoted against wanting says here, in its own voice, that this wanting is the divine thing. Four years is a long time to hold a verse against yourself that was never talking about you.',
  'धर्म-अविरुद्ध पूरी शर्त है और वह सँकरी है: वह चाह जो चीज़ों को थामे रखने वाले के ख़िलाफ़ न हो। यह उससे कहीं कम बाहर करती है जितना ज़्यादातर लोग मानते हैं, और जिस किताब का हवाला चाह के ख़िलाफ़ दिया जाता है वह यहाँ अपनी ही आवाज़ में कहती है कि यही चाह दिव्य चीज़ है। चार साल किसी ऐसे श्लोक को अपने ख़िलाफ़ थामे रखने के लिए लंबा वक़्त है जो आपके बारे में कभी था ही नहीं।',
  'Dharma-aviruddha poori shart hai aur woh sankari hai: woh chaah jo cheezon ko thaame rakhne wale ke khilaf na ho. Yeh usse kahin kam bahar karti hai jitna zyadatar log maante hain, aur jis kitaab ka hawala chaah ke khilaf diya jaata hai woh yahan apni hi awaaz mein kehti hai ki yahi chaah divya cheez hai. Chaar saal kisi aise shloka ko apne khilaf thaame rakhne ke liye lamba waqt hai jo tumhare baare mein kabhi tha hi nahi.',
  'The qualifier is narrow. It rules out far less than people assume.',
  'शर्त सँकरी है। वह लोगों की धारणा से कहीं कम बाहर करती है।',
  'Shart sankari hai. Woh logon ki dharna se kahin kam bahar karti hai.',
  NULL, 'beginner', 'desire,self-blame,permission,narrow-qualifier'

  UNION ALL SELECT 11, 'startup', 2,
  'Wanting the company to work', 'कंपनी के चलने की चाह', 'Company ke chalne ki chaah',
  'A founder tells an investor she has learned to be detached from outcomes. He asks whether she wants the company to work. She says of course. He asks how those two sentences fit, and she does not have an answer she believes.',
  'एक संस्थापक निवेशक से कहती है कि उसने नतीजों से अलग रहना सीख लिया है। वह पूछता है कि क्या वह चाहती है कि कंपनी चले। वह कहती है, ज़ाहिर है। वह पूछता है कि ये दोनों वाक्य साथ कैसे बैठते हैं, और उसके पास ऐसा कोई जवाब नहीं जिस पर वह ख़ुद यक़ीन करती हो।',
  'Ek sansthapak niveshak se kehti hai ki usne nateejon se alag rehna seekh liya hai. Woh poochhta hai ki kya woh chahti hai ki company chale. Woh kehti hai, zaahir hai. Woh poochhta hai ki ye dono vakya saath kaise baithte hain, aur uske paas aisa koi jawab nahi jis par woh khud yakeen karti ho.',
  'They do not fit, and the resolution is in this verse rather than in a better formula. Wanting the company to work is not set against anything, so by 7.11 it is not a problem to be solved. What 2.47 asks her to let go of is the claim on the result, which is a different sentence from having no wants — and this chapter says the wants themselves are the divine part.',
  'वे साथ बैठते नहीं, और हल इसी श्लोक में है, किसी बेहतर फ़ॉर्मूले में नहीं। कंपनी के चलने की चाह किसी के ख़िलाफ़ नहीं है, तो 7.11 के हिसाब से वह सुलझाने लायक़ मुसीबत है ही नहीं। 2.47 उससे नतीजे पर दावा छोड़ने को कहता है, और यह चाह न रखने से अलग वाक्य है — और यह अध्याय कहता है कि चाहें ख़ुद दिव्य हिस्सा हैं।',
  'We saath baithte nahi, aur hal isi shloka mein hai, kisi behtar formule mein nahi. Company ke chalne ki chaah kisi ke khilaf nahi hai, to 7.11 ke hisaab se woh suljhane layak museebat hai hi nahi. 2.47 usse nateeje par dawa chhodne ko kehta hai, aur yeh chaah na rakhne se alag vakya hai — aur yeh adhyay kehta hai ki chahein khud divya hissa hain.',
  'Letting go of the claim on a result is a different sentence from having no wants.',
  'नतीजे पर दावा छोड़ना चाह न रखने से अलग वाक्य है।',
  'Nateeje par dawa chhodna chaah na rakhne se alag vakya hai.',
  NULL, 'intermediate', 'desire,detachment,misuse,honesty'

  UNION ALL SELECT 11, 'leadership', 3,
  'Ambition, and the one question that sorts it', 'महत्वाकांक्षा, और वह एक सवाल जो उसे छाँटता है',
  'Mahatvakanksha, aur woh ek sawal jo use chhantta hai',
  'A manager writes down what he wants from the next three years. Then he goes through the list asking of each item whether getting it requires somebody else to lose. Two of seven do. He does not delete them; he marks them and sits with it.',
  'एक मैनेजर लिखता है कि उसे अगले तीन साल से क्या चाहिए। फिर वह सूची में हर चीज़ पर यह पूछते हुए जाता है कि उसे पाने के लिए किसी और का हारना ज़रूरी है या नहीं। सात में से दो में है। वह उन्हें मिटाता नहीं; निशान लगाता है और उसके साथ बैठता है।',
  'Ek manager likhta hai ki use agle teen saal se kya chahiye. Phir woh soochi mein har cheez par yeh poochhte hue jaata hai ki use paane ke liye kisi aur ka haarna zaroori hai ya nahi. Saat mein se do mein hai. Woh unhe mitata nahi; nishan lagata hai aur uske saath baithta hai.',
  'That is the qualifier doing actual work rather than being used to condemn wanting in general. Five of seven are not set against anything and the verse calls those divine without hedging. The two that are do not get deleted by the verse either — nothing here issues a verdict on him. It gives him a question and the question sorts the list.',
  'यही शर्त का असली काम है, यह नहीं कि उससे आम तौर पर चाह को दोषी ठहराया जाए। सात में से पाँच किसी के ख़िलाफ़ नहीं हैं और श्लोक उन्हें बिना हिचक के दिव्य कहता है। जो दो हैं उन्हें भी श्लोक मिटाता नहीं — यहाँ उसके बारे में कोई फ़ैसला नहीं सुनाया जाता। वह उसे एक सवाल देता है और सवाल सूची छाँट देता है।',
  'Yahi shart ka asli kaam hai, yeh nahi ki usse aam taur par chaah ko doshi thehraya jaaye. Saat mein se paanch kisi ke khilaf nahi hain aur shloka unhe bina hichak ke divya kehta hai. Jo do hain unhe bhi shloka mitata nahi — yahan uske baare mein koi faisla nahi sunaya jaata. Woh use ek sawal deta hai aur sawal soochi chhaant deta hai.',
  'It gives him a question, not a verdict. The question sorts the list.',
  'वह उसे सवाल देता है, फ़ैसला नहीं। सवाल सूची छाँट देता है।',
  'Woh use sawal deta hai, faisla nahi. Sawal soochi chhaant deta hai.',
  NULL, 'intermediate', 'ambition,sorting,questions,honesty'

  UNION ALL SELECT 11, 'school', 4,
  'The child who wanted to win', 'वह बच्चा जो जीतना चाहता था', 'Woh bachcha jo jeetna chahta tha',
  'A boy is told by a well-meaning adult that wanting to win is the wrong attitude. He stops saying it out loud and goes on wanting it, now with something extra attached. His coach, years later, tells him wanting to win is fine and wanting the other side to be hurt is not.',
  'एक लड़के से एक भले बड़े कहते हैं कि जीतने की चाह ग़लत रवैया है। वह इसे ज़ोर से कहना बंद कर देता है और चाहता रहता है, अब उसके साथ कुछ और भी जुड़ा हुआ। सालों बाद उसका कोच उससे कहता है कि जीतना चाहना ठीक है और सामने वाले का बुरा चाहना ठीक नहीं।',
  'Ek ladke se ek bhale bade kehte hain ki jeetne ki chaah galat ravaiya hai. Woh ise zor se kehna band kar deta hai aur chahta rehta hai, ab uske saath kuch aur bhi juda hua. Saalon baad uska coach usse kehta hai ki jeetna chahna theek hai aur saamne wale ka bura chahna theek nahi.',
  'The coach and the verse are saying the same thing and the well-meaning adult was not. Dharma-aviruddha draws the line between wanting something and wanting somebody to lose it, and that is a line a child can use. The version that condemns wanting outright does not remove the wanting; it just adds shame to it, which is the extra thing he was carrying for years.',
  'कोच और श्लोक एक ही बात कह रहे हैं और वे भले बड़े नहीं कह रहे थे। धर्म-अविरुद्ध कुछ चाहने और यह चाहने के बीच रेखा खींचता है कि कोई और हारे, और यह ऐसी रेखा है जिसे बच्चा भी बरत सकता है। जो रूप सीधे चाह को ही दोषी ठहराता है वह चाह हटाता नहीं; वह उसमें शर्म जोड़ देता है, और यही वह अतिरिक्त चीज़ थी जिसे वह सालों उठाए फिरा।',
  'Coach aur shloka ek hi baat keh rahe hain aur we bhale bade nahi keh rahe the. Dharma-aviruddha kuch chahne aur yeh chahne ke beech rekha kheenchta hai ki koi aur haare, aur yeh aisi rekha hai jise bachcha bhi barat sakta hai. Jo roop seedhe chaah ko hi doshi thehrata hai woh chaah hatata nahi; woh usme sharm jod deta hai, aur yahi woh atirikt cheez thi jise woh saalon uthaye phira.',
  'Condemning wanting outright does not remove it. It adds shame to it.',
  'सीधे चाह को दोषी ठहराने से चाह हटती नहीं। उसमें शर्म जुड़ जाती है।',
  'Seedhe chaah ko doshi thehrane se chaah hatti nahi. Usme sharm jud jaati hai.',
  NULL, 'beginner', 'desire,shame,children,line-drawing'

  UNION ALL SELECT 14, 'finance', 1,
  'Eleven years and no headline', 'ग्यारह साल और कोई सुर्ख़ी नहीं', 'Gyarah saal aur koi surkhi nahi',
  'A woman clears a large debt over eleven years. There is no month in which it turns around and no week she could point to. When it is finally gone she cannot think of anything to say about how she did it.',
  'एक औरत ग्यारह साल में एक बड़ा क़र्ज़ उतारती है। ऐसा कोई महीना नहीं जिसमें बात पलटी हो और ऐसा कोई हफ़्ता नहीं जिसकी वह ओर इशारा कर सके। जब वह आख़िरकार ख़त्म होता है तो उसे यह बताने को कुछ नहीं सूझता कि उसने किया कैसे।',
  'Ek aurat gyarah saal mein ek bada karz utaarti hai. Aisa koi mahina nahi jisme baat palti ho aur aisa koi hafta nahi jiski woh or ishara kar sake. Jab woh aakhirkar khatam hota hai to use yeh batane ko kuch nahi soojhta ki usne kiya kaise.',
  'Duratyaya. Hard to get across, said before anything is said about getting across. Eleven years with no turning point is what that word describes, and there is nothing wrong with her account of it. The verse offers no timescale and no method, which makes it a more honest companion to a story like this than most of what gets written about change.',
  'दुरत्यया। पार करना मुश्किल, और यह पार होने के बारे में कुछ कहने से पहले कहा गया। बिना किसी मोड़ के ग्यारह साल यही शब्द बताता है, और उसके बताने में कुछ ग़लत नहीं है। श्लोक न समय-सीमा देता है न तरीक़ा, जिससे वह ऐसी कहानी का उससे कहीं ईमानदार साथी बन जाता है जितना बदलाव पर लिखा ज़्यादातर।',
  'Duratyaya. Paar karna mushkil, aur yeh paar hone ke baare mein kuch kehne se pehle kaha gaya. Bina kisi mod ke gyarah saal yahi shabd batata hai, aur uske batane mein kuch galat nahi hai. Shloka na samay-seema deta hai na tareeka, jisse woh aisi kahani ka usse kahin imaandar saathi ban jaata hai jitna badlav par likha zyadatar.',
  'No turning point, no method, no timescale. The verse offers none either.',
  'न कोई मोड़, न तरीक़ा, न समय-सीमा। श्लोक भी कोई नहीं देता।',
  'Na koi mod, na tareeka, na samay-seema. Shloka bhi koi nahi deta.',
  NULL, 'beginner', 'slow,honesty,no-timescale,debt'

  UNION ALL SELECT 14, 'healthcare', 2,
  'What the physiotherapist would not say', 'फ़िज़ियोथेरेपिस्ट ने जो नहीं कहा', 'Physiotherapist ne jo nahi kaha',
  'A man after surgery asks how long until he is back to normal. The physiotherapist says she does not know, that it is usually longer than people are told, and that she is not going to guess. He is annoyed for a week and grateful for a year.',
  'सर्जरी के बाद एक आदमी पूछता है कि सामान्य होने में कितना वक़्त लगेगा। फ़िज़ियोथेरेपिस्ट कहती हैं कि उन्हें नहीं पता, कि आमतौर पर वह उससे ज़्यादा होता है जितना लोगों को बताया जाता है, और वे अंदाज़ा नहीं लगाएँगी। वह एक हफ़्ता चिढ़ा रहता है और एक साल शुक्रगुज़ार।',
  'Surgery ke baad ek aadmi poochhta hai ki samanya hone mein kitna waqt lagega. Physiotherapist kehti hain ki unhe nahi pata, ki aamtaur par woh usse zyada hota hai jitna logon ko bataya jaata hai, aur we andaza nahi lagayengi. Woh ek hafta chidha rehta hai aur ek saal shukarguzar.',
  'That refusal is 7.14''s word order. Difficulty stated first, honestly, and only then anything about the way across. A number would have been kinder for a week and worse for a year, and the verse chooses the same way. Nothing in this chapter promises a schedule, and anybody who gives one about this is saying more than the text does.',
  'यही इनकार 7.14 का शब्द-क्रम है। पहले मुश्किल, ईमानदारी से, और उसके बाद ही पार होने की कोई बात। कोई आँकड़ा एक हफ़्ते के लिए नरम होता और एक साल के लिए बुरा, और श्लोक भी वही चुनाव करता है। इस अध्याय में कहीं कोई समय-सारणी का वादा नहीं है, और जो कोई इस बारे में एक देता है वह ग्रंथ से ज़्यादा कह रहा है।',
  'Yahi inkaar 7.14 ka shabd-kram hai. Pehle mushkil, imaandari se, aur uske baad hi paar hone ki koi baat. Koi aankda ek hafte ke liye naram hota aur ek saal ke liye bura, aur shloka bhi wahi chunav karta hai. Is adhyay mein kahin koi samay-saarni ka waada nahi hai, aur jo koi is baare mein ek deta hai woh granth se zyada keh raha hai.',
  'A number would have been kinder for a week and worse for a year.',
  'कोई आँकड़ा एक हफ़्ते के लिए नरम होता और एक साल के लिए बुरा।',
  'Koi aankda ek hafte ke liye naram hota aur ek saal ke liye bura.',
  NULL, 'intermediate', 'honesty,recovery,no-promises,time'

  UNION ALL SELECT 14, 'sports', 3,
  'The plateau nobody mentions in the advert', 'वह पठार जिसका ज़िक्र विज्ञापन में नहीं होता', 'Woh pathar jiska zikr vigyapan mein nahi hota',
  'A runner improves quickly for four months and then not at all for two years. Every piece of advice she reads is written by somebody in month three. The one coach who says most people stay here a long time is the one she keeps going back to.',
  'एक धाविका चार महीने तेज़ी से सुधरती है और फिर दो साल कुछ भी नहीं। जो भी सलाह वह पढ़ती है वह किसी तीसरे महीने वाले की लिखी होती है। एक ही कोच जो कहता है कि ज़्यादातर लोग यहाँ लंबे समय रहते हैं, वही है जिसके पास वह लौटती रहती है।',
  'Ek dhavika chaar mahine tezi se sudharti hai aur phir do saal kuch bhi nahi. Jo bhi salah woh padhti hai woh kisi teesre mahine wale ki likhi hoti hai. Ek hi coach jo kehta hai ki zyadatar log yahan lambe samay rehte hain, wahi hai jiske paas woh lautti rehti hai.',
  'She keeps going back to the one who said hard first. That is the same reason 7.14 is worth trusting: the difficulty is stated by the text and not conceded by a commentator afterwards. A verse that leads with duratyaya is not managing anybody''s expectations. It is telling them what the situation is before it offers anything about it.',
  'वह उसी के पास लौटती है जिसने पहले मुश्किल कहा। 7.14 पर भरोसा करने की भी यही वजह है: मुश्किल ग्रंथ ख़ुद कहता है, कोई टीकाकार बाद में मान नहीं रहा। जो श्लोक दुरत्यया से शुरू होता है वह किसी की उम्मीदें नहीं सँभाल रहा। वह उसके बारे में कुछ देने से पहले बता रहा है कि हालत क्या है।',
  'Woh usi ke paas lautti hai jisne pehle mushkil kaha. 7.14 par bharosa karne ki bhi yahi wajah hai: mushkil granth khud kehta hai, koi tikakar baad mein maan nahi raha. Jo shloka duratyaya se shuru hota hai woh kisi ki ummeedein nahi sambhal raha. Woh uske baare mein kuch dene se pehle bata raha hai ki haalat kya hai.',
  'The difficulty is stated by the text, not conceded afterwards.',
  'मुश्किल ग्रंथ ख़ुद कहता है, बाद में मानी नहीं जाती।',
  'Mushkil granth khud kehta hai, baad mein maani nahi jaati.',
  NULL, 'intermediate', 'plateau,honesty,advice,trust'

  UNION ALL SELECT 14, 'everyday_life', 4,
  'The weekend that was going to fix it', 'वह हफ़्ता जो सब ठीक कर देने वाला था', 'Woh hafta jo sab theek kar dene wala tha',
  'Somebody comes back from a residential course certain that everything has changed. Eleven days later it has not. The second time this happens he is less certain and less disappointed, and the third time he stops going.',
  'कोई एक आवासीय कोर्स से यह पक्का मानकर लौटता है कि सब बदल गया है। ग्यारह दिन बाद नहीं बदला होता। दूसरी बार ऐसा होने पर वह कम पक्का होता है और कम मायूस, और तीसरी बार वह जाना बंद कर देता है।',
  'Koi ek aawasiya course se yeh pakka maankar lautta hai ki sab badal gaya hai. Gyarah din baad nahi badla hota. Doosri baar aisa hone par woh kam pakka hota hai aur kam mayoos, aur teesri baar woh jaana band kar deta hai.',
  'Eleven days is roughly what a promise of transformation is worth, and the disappointment is manufactured entirely by the promise. 7.14 makes no such offer. It says the thing is hard to get across, in the same breath as saying it can be, and a reader carrying that sentence is much harder to sell a weekend to.',
  'ग्यारह दिन क़रीब-क़रीब उतने ही हैं जितने रूपांतरण के वादे की क़ीमत है, और मायूसी पूरी की पूरी उसी वादे से बनी है। 7.14 ऐसा कोई प्रस्ताव नहीं देता। वह कहता है कि इसे पार करना मुश्किल है, उसी साँस में जिसमें कहता है कि किया जा सकता है, और जो पाठक यह वाक्य साथ रखता है उसे कोई हफ़्ता बेचना कहीं मुश्किल है।',
  'Gyarah din kareeb-kareeb utne hi hain jitne roopantaran ke waade ki keemat hai, aur mayoosi poori ki poori usi waade se bani hai. 7.14 aisa koi prastav nahi deta. Woh kehta hai ki ise paar karna mushkil hai, usi saans mein jisme kehta hai ki kiya ja sakta hai, aur jo pathak yeh vakya saath rakhta hai use koi hafta bechna kahin mushkil hai.',
  'The disappointment is manufactured entirely by the promise.',
  'मायूसी पूरी की पूरी वादे से बनी है।',
  'Mayoosi poori ki poori waade se bani hai.',
  NULL, 'beginner', 'promises,transformation,disappointment,honesty'

  UNION ALL SELECT 16, 'healthcare', 1,
  'She came because she could not sleep', 'वह इसलिए आई कि उसे नींद नहीं आ रही थी', 'Woh isliye aayi ki use neend nahi aa rahi thi',
  'A woman starts reading things like this in a month when she cannot sleep. Two years on she is still reading, and still slightly embarrassed that it started with insomnia rather than with a proper question.',
  'एक औरत ऐसी चीज़ें उस महीने पढ़ना शुरू करती है जब उसे नींद नहीं आती। दो साल बाद वह अब भी पढ़ रही है, और अब भी हल्की शर्मिंदा है कि शुरुआत किसी ढंग के सवाल से नहीं, नींद न आने से हुई।',
  'Ek aurat aisi cheezein us mahine padhna shuru karti hai jab use neend nahi aati. Do saal baad woh ab bhi padh rahi hai, aur ab bhi halki sharminda hai ki shuruaat kisi dhang ke sawal se nahi, neend na aane se hui.',
  'The verse names her first. Arta — the one in distress — is the first of the four, and the word sukritinah, people who have done well, arrives before any of them are separated. There is no version of this chapter in which coming because you could not sleep is the shabby way in. She has been carrying an embarrassment the text does not issue.',
  'श्लोक सबसे पहले उसी का नाम लेता है। आर्त — मुसीबत में पड़ा — चारों में पहला है, और सुकृतिनः शब्द, जिन्होंने ठीक किया, उनमें से किसी के अलग होने से पहले आ जाता है। इस अध्याय का ऐसा कोई रूप नहीं जिसमें नींद न आने की वजह से आना घटिया रास्ता हो। वह ऐसी शर्मिंदगी उठाए घूम रही है जो ग्रंथ जारी नहीं करता।',
  'Shloka sabse pehle usi ka naam leta hai. Aarta — museebat mein pada — chaaron mein pehla hai, aur sukritinah shabd, jinhone theek kiya, unme se kisi ke alag hone se pehle aa jaata hai. Is adhyay ka aisa koi roop nahi jisme neend na aane ki wajah se aana ghatiya raasta ho. Woh aisi sharmindagi uthaye ghoom rahi hai jo granth jaari nahi karta.',
  'She has been carrying an embarrassment the text does not issue.',
  'वह ऐसी शर्मिंदगी उठाए घूम रही है जो ग्रंथ जारी नहीं करता।',
  'Woh aisi sharmindagi uthaye ghoom rahi hai jo granth jaari nahi karta.',
  NULL, 'beginner', 'arrival,distress,legitimacy,shame'

  UNION ALL SELECT 16, 'everyday_life', 2,
  'He wanted something out of it', 'उसे इससे कुछ चाहिए था', 'Use isse kuch chahiye tha',
  'A man starts reading because he thinks it might help him get through a difficult year at work. He says so out loud in a group once and the room goes slightly quiet. Nobody says anything unkind. Nobody says anything at all.',
  'एक आदमी इसलिए पढ़ना शुरू करता है कि उसे लगता है इससे काम की एक मुश्किल साल निकालने में मदद मिलेगी। वह एक बार समूह में यह ज़ोर से कह देता है और कमरा हल्का चुप हो जाता है। कोई कुछ कड़वा नहीं कहता। कोई कुछ कहता ही नहीं।',
  'Ek aadmi isliye padhna shuru karta hai ki use lagta hai isse kaam ki ek mushkil saal nikalne mein madad milegi. Woh ek baar samooh mein yeh zor se keh deta hai aur kamra halka chup ho jaata hai. Koi kuch kadwa nahi kehta. Koi kuch kehta hi nahi.',
  'Artharthi — the one who wants something out of it — is third on the list and is called, along with the other three, somebody who has done well. That is the reason most often treated as the shabby one, and the verse counts it in by name without a qualifying clause anywhere near it. The room went quiet. The text did not.',
  'अर्थार्थी — जो इससे कुछ चाहता है — सूची में तीसरा है और बाक़ी तीन के साथ उसे भी वही कहा गया है जिसने ठीक किया। यही वह वजह है जिसे अक्सर घटिया माना जाता है, और श्लोक उसे नाम लेकर गिनता है, आसपास कहीं कोई शर्त लगाए बिना। कमरा चुप हो गया। ग्रंथ नहीं हुआ।',
  'Artharthi — jo isse kuch chahta hai — soochi mein teesra hai aur baaki teen ke saath use bhi wahi kaha gaya hai jisne theek kiya. Yahi woh wajah hai jise aksar ghatiya mana jaata hai, aur shloka use naam lekar ginta hai, aaspaas kahin koi shart lagaye bina. Kamra chup ho gaya. Granth nahi hua.',
  'The room went quiet. The text did not.',
  'कमरा चुप हो गया। ग्रंथ नहीं हुआ।',
  'Kamra chup ho gaya. Granth nahi hua.',
  NULL, 'beginner', 'arrival,wanting,legitimacy,groups'

  UNION ALL SELECT 16, 'college', 3,
  'She just wanted to know', 'वह बस जानना चाहती थी', 'Woh bas jaanna chahti thi',
  'A student takes an elective on this material out of straightforward curiosity. She is not in any trouble, wants nothing from it, and is not devout. Halfway through the term she wonders whether she is allowed to be there.',
  'एक छात्रा सीधी-सादी जिज्ञासा से इस विषय का ऐच्छिक कोर्स लेती है। वह किसी मुसीबत में नहीं है, उसे इससे कुछ नहीं चाहिए, और वह धार्मिक नहीं है। सत्र के बीच में उसे सवाल उठता है कि क्या उसका वहाँ होना जायज़ है।',
  'Ek chhatra seedhi-saadi jigyasa se is vishay ka aichhik course leti hai. Woh kisi museebat mein nahi hai, use isse kuch nahi chahiye, aur woh dharmik nahi hai. Satra ke beech mein use sawal uthta hai ki kya uska wahan hona jayaz hai.',
  'Jijnasu — the one who wants to know — is second on the list, and wanting to know is the entire qualification. The verse asks for no belief, no crisis and no stake. Four doors are named, hers is one of them, and all four are called good before the chapter separates them at all.',
  'जिज्ञासु — जो जानना चाहता है — सूची में दूसरा है, और जानना चाहना ही पूरी पात्रता है। श्लोक न कोई आस्था माँगता है, न कोई संकट, न कोई दाँव। चार दरवाज़े गिनाए गए हैं, उसका उनमें से एक है, और अध्याय उन्हें अलग करने से पहले ही चारों को अच्छा कहता है।',
  'Jijnasu — jo jaanna chahta hai — soochi mein doosra hai, aur jaanna chahna hi poori paatrata hai. Shloka na koi aastha maangta hai, na koi sankat, na koi daanv. Chaar darwaze ginaye gaye hain, uska unme se ek hai, aur adhyay unhe alag karne se pehle hi chaaron ko achha kehta hai.',
  'Wanting to know is the entire qualification. No belief, no crisis, no stake.',
  'जानना चाहना ही पूरी पात्रता है। न आस्था, न संकट, न दाँव।',
  'Jaanna chahna hi poori paatrata hai. Na aastha, na sankat, na daanv.',
  NULL, 'beginner', 'curiosity,belonging,no-belief-required,elective'

  UNION ALL SELECT 16, 'social_media', 4,
  'The comment under the post', 'पोस्ट के नीचे वाली टिप्पणी', 'Post ke neeche wali tippani',
  'Somebody posts that they started reading this because of a bad year. The first reply says that is the wrong reason and they should come to it in peace. The second reply quotes the verse.',
  'कोई पोस्ट करता है कि उसने यह एक बुरे साल की वजह से पढ़ना शुरू किया। पहला जवाब कहता है कि यह ग़लत वजह है और शांति में आना चाहिए। दूसरा जवाब श्लोक उद्धृत कर देता है।',
  'Koi post karta hai ki usne yeh ek bure saal ki wajah se padhna shuru kiya. Pehla jawab kehta hai ki yeh galat wajah hai aur shanti mein aana chahiye. Doosra jawab shloka uddhrit kar deta hai.',
  'The second reply is doing what this whole file is for. Arta is first on the list, named before the one who wants to know and the one who knows, and sukritinah covers all four. Anybody who tells a person in a bad year that they have come for the wrong reason is not quoting 7.16, because 7.16 does not permit it.',
  'दूसरा जवाब वही कर रहा है जिसके लिए यह पूरी फ़ाइल है। आर्त सूची में पहला है, जानना चाहने वाले और जानने वाले से पहले नाम लिया गया, और सुकृतिनः चारों को ढकता है। जो कोई बुरे साल में पड़े आदमी से कहे कि वह ग़लत वजह से आया है वह 7.16 का हवाला नहीं दे रहा, क्योंकि 7.16 इसकी इजाज़त नहीं देता।',
  'Doosra jawab wahi kar raha hai jiske liye yeh poori file hai. Aarta soochi mein pehla hai, jaanna chahne wale aur jaanne wale se pehle naam liya gaya, aur sukritinah chaaron ko dhakta hai. Jo koi bure saal mein pade aadmi se kahe ki woh galat wajah se aaya hai woh 7.16 ka hawala nahi de raha, kyunki 7.16 iski ijazat nahi deta.',
  'Anybody saying that is not quoting 7.16, because 7.16 does not permit it.',
  'जो ऐसा कहता है वह 7.16 का हवाला नहीं दे रहा, क्योंकि 7.16 इसकी इजाज़त नहीं देता।',
  'Jo aisa kehta hai woh 7.16 ka hawala nahi de raha, kyunki 7.16 iski ijazat nahi deta.',
  NULL, 'intermediate', 'gatekeeping,arrival,correction,quoting'

  UNION ALL SELECT 17, 'corporate', 1,
  'The ranking that decided who stayed', 'वह क्रम जिसने तय किया कौन रहेगा', 'Woh kram jisne tay kiya kaun rahega',
  'A company introduces a performance ranking. Year one it is used to decide who gets development. Year three it is used to decide who leaves. Nothing about the ranking changed in between.',
  'एक कंपनी प्रदर्शन का क्रम लागू करती है। पहले साल उसका इस्तेमाल यह तय करने में होता है कि किसे प्रशिक्षण मिलेगा। तीसरे साल उसका इस्तेमाल यह तय करने में होता है कि कौन जाएगा। इस बीच क्रम में कुछ नहीं बदला।',
  'Ek company pradarshan ka kram laagu karti hai. Pehle saal uska istemaal yeh tay karne mein hota hai ki kise prashikshan milega. Teesre saal uska istemaal yeh tay karne mein hota hai ki kaun jayega. Is beech kram mein kuch nahi badla.',
  'That is the whole question about 7.17. The verse ranks — this page is not going to pretend otherwise — but 7.16 has already put all four inside, so the ranking it draws sorts people who are all in rather than deciding who is let in. Year one and year three used the same list for two entirely different things, and the difference is the only thing worth watching in a ranking.',
  '7.17 के बारे में पूरा सवाल यही है। श्लोक क्रम लगाता है — यह पन्ना इससे उल्टा नहीं दिखाएगा — पर 7.16 चारों को पहले ही भीतर रख चुका है, तो वह जो क्रम खींचता है वह उन लोगों को छाँटता है जो सब भीतर हैं, यह तय नहीं करता कि किसे भीतर आने दिया जाए। पहले और तीसरे साल ने एक ही सूची दो बिल्कुल अलग कामों में लगाई, और किसी भी क्रम में देखने लायक़ बस यही फ़र्क़ है।',
  '7.17 ke baare mein poora sawal yahi hai. Shloka kram lagata hai — yeh panna isse ulta nahi dikhayega — par 7.16 chaaron ko pehle hi bheetar rakh chuka hai, to woh jo kram kheenchta hai woh un logon ko chhantta hai jo sab bheetar hain, yeh tay nahi karta ki kise bheetar aane diya jaaye. Pehle aur teesre saal ne ek hi soochi do bilkul alag kaamon mein lagai, aur kisi bhi kram mein dekhne layak bas yahi farq hai.',
  'The same list, two entirely different uses. That difference is the whole question.',
  'वही सूची, दो बिल्कुल अलग इस्तेमाल। पूरा सवाल यही फ़र्क़ है।',
  'Wahi soochi, do bilkul alag istemaal. Poora sawal yahi farq hai.',
  NULL, 'intermediate', 'ranking,belonging,use,drift'

  UNION ALL SELECT 17, 'school', 2,
  'Sets, and who is told about them', 'सेट, और किसे उनके बारे में बताया जाता है', 'Set, aur kise unke baare mein bataya jaata hai',
  'A school groups its maths classes by attainment. One teacher tells her group they are the ones who need more time. Another tells hers they are the bottom set. Both statements are about the same children and the same list.',
  'एक स्कूल गणित की कक्षाएँ स्तर के हिसाब से बाँटता है। एक अध्यापिका अपने समूह से कहती हैं कि उन्हें ज़्यादा वक़्त चाहिए। दूसरी अपने समूह से कहती हैं कि वे सबसे निचला सेट हैं। दोनों बातें उन्हीं बच्चों और उसी सूची के बारे में हैं।',
  'Ek school ganit ki kakshayein star ke hisaab se baantta hai. Ek adhyapika apne samooh se kehti hain ki unhe zyada waqt chahiye. Doosri apne samooh se kehti hain ki we sabse nichla set hain. Dono baatein unhi bachchon aur usi soochi ke baare mein hain.',
  'A ranking is real and the two teachers are not disagreeing about the facts. What differs is whether the people in it are still in the room afterwards. 7.17 draws its distinction one verse after 7.16 has already counted all four in — order that costs the text nothing and changes everything about how the ranking lands.',
  'क्रम असली है और दोनों अध्यापिकाएँ तथ्यों पर असहमत नहीं हैं। फ़र्क़ यह है कि उसमें रखे गए लोग बाद में कमरे में रहते हैं या नहीं। 7.17 अपना भेद उस श्लोक के एक ही श्लोक बाद खींचता है जिसमें 7.16 चारों को गिन चुका है — यह क्रम ग्रंथ का कुछ ख़र्च नहीं करता और उस भेद के गिरने का पूरा ढंग बदल देता है।',
  'Kram asli hai aur dono adhyapikayein tathyon par asehmat nahi hain. Farq yeh hai ki usme rakhe gaye log baad mein kamre mein rehte hain ya nahi. 7.17 apna bhed us shloka ke ek hi shloka baad kheenchta hai jisme 7.16 chaaron ko gin chuka hai — yeh kram granth ka kuch kharch nahi karta aur us bhed ke girne ka poora dhang badal deta hai.',
  'The facts are the same. Whether the people are still in the room afterwards is not.',
  'तथ्य वही हैं। बाद में लोग कमरे में हैं या नहीं, वह नहीं।',
  'Tathya wahi hain. Baad mein log kamre mein hain ya nahi, woh nahi.',
  NULL, 'intermediate', 'ranking,language,children,belonging'

  UNION ALL SELECT 17, 'ethics', 3,
  'What the ranking was for', 'क्रम किस काम के लिए था', 'Kram kis kaam ke liye tha',
  'A charity ranks its volunteers by hours given, intending to thank the top ten. Somebody points out that the list will also be read by the people not on it. They keep the ranking, publish nothing, and thank the top ten privately.',
  'एक संस्था अपने स्वयंसेवकों को दिए गए घंटों के हिसाब से क्रम में रखती है, इरादा ऊपर के दस को धन्यवाद देने का है। कोई बताता है कि यह सूची वे लोग भी पढ़ेंगे जो उसमें नहीं हैं। वे क्रम रखते हैं, छापते कुछ नहीं, और ऊपर के दस को निजी तौर पर धन्यवाद देते हैं।',
  'Ek sanstha apne swayamsevakon ko diye gaye ghanton ke hisaab se kram mein rakhti hai, iraada upar ke das ko dhanyavad dene ka hai. Koi batata hai ki yeh soochi we log bhi padhenge jo usme nahi hain. We kram rakhte hain, chhapte kuch nahi, aur upar ke das ko niji taur par dhanyavad dete hain.',
  'They did not abolish the ranking, because it was true, and they did not publish it, because of what it would do. That is a reasonable reading of what 7.17 is doing: it says one of the four stands out and it says so inside a chapter that has already made the other three welcome by name. A ranking with no door attached to it is a different object from one with a door.',
  'उन्होंने क्रम ख़त्म नहीं किया, क्योंकि वह सच था, और उसे छापा नहीं, क्योंकि वह क्या करता। 7.17 जो कर रहा है उसका यह वाजिब पाठ है: वह कहता है कि चारों में एक अलग दिखता है, और वह यह उस अध्याय के भीतर कहता है जो बाक़ी तीन का नाम लेकर उनका स्वागत कर चुका है। जिस क्रम से कोई दरवाज़ा नहीं जुड़ा वह उस क्रम से अलग चीज़ है जिससे जुड़ा है।',
  'Unhone kram khatam nahi kiya, kyunki woh sach tha, aur use chhapa nahi, kyunki woh kya karta. 7.17 jo kar raha hai uska yeh wajib paath hai: woh kehta hai ki chaaron mein ek alag dikhta hai, aur woh yeh us adhyay ke bheetar kehta hai jo baaki teen ka naam lekar unka swagat kar chuka hai. Jis kram se koi darwaza nahi juda woh us kram se alag cheez hai jisse juda hai.',
  'A ranking with no door attached is a different object from one with a door.',
  'जिस क्रम से दरवाज़ा नहीं जुड़ा वह उससे अलग चीज़ है जिससे जुड़ा है।',
  'Jis kram se darwaza nahi juda woh usse alag cheez hai jisse juda hai.',
  NULL, 'intermediate', 'ranking,publication,care,thanks'

  UNION ALL SELECT 17, 'friendship', 4,
  'The one who reads it properly', 'वह जो इसे ढंग से पढ़ता है', 'Woh jo ise dhang se padhta hai',
  'Two friends read this chapter together. One of them has been at it for years and the other started last month. The one who started last month says the ranking makes him feel like a guest. The other one says he has been reading it for years and it makes him feel like a guest too.',
  'दो दोस्त यह अध्याय साथ पढ़ते हैं। उनमें से एक सालों से इसमें लगा है और दूसरे ने पिछले महीने शुरू किया। पिछले महीने वाला कहता है कि इस क्रम से उसे मेहमान जैसा लगता है। दूसरा कहता है कि वह सालों से पढ़ रहा है और उसे भी मेहमान जैसा ही लगता है।',
  'Do dost yeh adhyay saath padhte hain. Unme se ek saalon se isme laga hai aur doosre ne pichhle mahine shuru kiya. Pichhle mahine wala kehta hai ki is kram se use mehmaan jaisa lagta hai. Doosra kehta hai ki woh saalon se padh raha hai aur use bhi mehmaan jaisa hi lagta hai.',
  'Four verses on, the chapter calls the one who knows extremely rare. Which means this is a ranking almost nobody reading it is being placed at the top or the bottom of, including the person who has been at it for years. That does not dissolve the ranking and nothing here should pretend it does. It does mean the two of them are standing in more or less the same place.',
  'चार श्लोक आगे अध्याय जानने वाले को बेहद दुर्लभ कहता है। जिसका मतलब है कि यह ऐसा क्रम है जिसमें इसे पढ़ने वाले लगभग किसी को न सबसे ऊपर रखा जा रहा है न सबसे नीचे, उस आदमी को भी नहीं जो सालों से लगा है। इससे क्रम मिट नहीं जाता और यहाँ किसी को ऐसा दिखाना भी नहीं चाहिए। इसका मतलब इतना है कि वे दोनों क़रीब-क़रीब एक ही जगह खड़े हैं।',
  'Chaar shloka aage adhyay jaanne wale ko behad durlabh kehta hai. Jiska matlab hai ki yeh aisa kram hai jisme ise padhne wale lagbhag kisi ko na sabse upar rakha ja raha hai na sabse neeche, us aadmi ko bhi nahi jo saalon se laga hai. Isse kram mit nahi jaata aur yahan kisi ko aisa dikhana bhi nahi chahiye. Iska matlab itna hai ki we dono kareeb-kareeb ek hi jagah khade hain.',
  'Almost nobody reading it is being placed at the top or the bottom.',
  'इसे पढ़ने वाले लगभग किसी को न सबसे ऊपर रखा जा रहा है न सबसे नीचे।',
  'Ise padhne wale lagbhag kisi ko na sabse upar rakha ja raha hai na sabse neeche.',
  NULL, 'intermediate', 'ranking,humility,together,rarity'

  UNION ALL SELECT 21, 'everyday_life', 1,
  'The photograph on the shelf', 'ताक़ पर रखी तस्वीर', 'Taak par rakhi tasveer',
  'A woman keeps a photograph of her grandmother where she can see it and talks to it sometimes. She has been told by two different people that this is not really what any of this is about. She keeps doing it.',
  'एक औरत अपनी दादी की तस्वीर वहाँ रखती है जहाँ उसे दिखती रहे और कभी-कभी उससे बात करती है। दो अलग-अलग लोग उसे बता चुके हैं कि यह असल में इस सबका मतलब नहीं है। वह करती रहती है।',
  'Ek aurat apni dadi ki tasveer wahan rakhti hai jahan use dikhti rahe aur kabhi-kabhi usse baat karti hai. Do alag-alag log use bata chuke hain ki yeh asal mein is sabka matlab nahi hai. Woh karti rehti hai.',
  'Tam eva — that very one. The verse could trivially have been written so that the faith gets corrected or transferred, and instead its emphatic word points back at the form the person chose for themselves. The two people who told her otherwise were doing something the text declines to do.',
  'ताम् एव — उसी को। इस श्लोक को ऐसे लिखना बहुत आसान होता कि श्रद्धा सुधार दी जाए या हटा दी जाए, और इसके बजाय उसका ज़ोर वाला शब्द वापस उसी रूप की ओर इशारा करता है जिसे उस आदमी ने ख़ुद चुना। जिन दो लोगों ने उसे उल्टा बताया वे वह कर रहे थे जो ग्रंथ करने से इनकार करता है।',
  'Tam eva — usi ko. Is shloka ko aise likhna bahut aasan hota ki shraddha sudhaar di jaaye ya hata di jaaye, aur iske bajaye uska zor wala shabd wapas usi roop ki or ishara karta hai jise us aadmi ne khud chuna. Jin do logon ne use ulta bataya we woh kar rahe the jo granth karne se inkaar karta hai.',
  'They were doing something the text declines to do.',
  'वे वह कर रहे थे जो ग्रंथ करने से इनकार करता है।',
  'We woh kar rahe the jo granth karne se inkaar karta hai.',
  NULL, 'beginner', 'form,correction,leaving-alone,memory'

  UNION ALL SELECT 21, 'military', 2,
  'Four faiths in one room', 'एक कमरे में चार आस्थाएँ', 'Ek kamre mein chaar aasthayein',
  'A unit of thirty has people who pray in four different ways and several who do not. Before a difficult deployment their commanding officer gives them twenty minutes and says nothing about what to do with it.',
  'तीस लोगों की एक टुकड़ी में चार अलग-अलग तरीक़ों से प्रार्थना करने वाले लोग हैं और कई ऐसे जो नहीं करते। एक मुश्किल तैनाती से पहले उनका कमांडिंग अफ़सर उन्हें बीस मिनट देता है और यह कुछ नहीं कहता कि उनका क्या करना है।',
  'Tees logon ki ek tukdi mein chaar alag-alag tareekon se prarthna karne wale log hain aur kai aise jo nahi karte. Ek mushkil tainati se pehle unka commanding officer unhe bees minute deta hai aur yeh kuch nahi kehta ki unka kya karna hai.',
  'Saying nothing about what to do with the twenty minutes is the whole of it. The verse makes the same choice: whatever form somebody honours in good faith, it is that faith of theirs which is made steady, and no better one is suggested anywhere. This is the line that lets the chapter be read in a room like that one without anybody having to pretend.',
  'बीस मिनट का क्या करना है, यह न कहना ही पूरी बात है। श्लोक भी वही चुनाव करता है: कोई जिस भी रूप को श्रद्धा से पूजता है, उसकी वही श्रद्धा अडिग की जाती है, और कहीं कोई बेहतर रूप सुझाया नहीं जाता। यही वह पंक्ति है जिसकी वजह से यह अध्याय ऐसे कमरे में पढ़ा जा सकता है और किसी को नाटक नहीं करना पड़ता।',
  'Bees minute ka kya karna hai, yeh na kehna hi poori baat hai. Shloka bhi wahi chunav karta hai: koi jis bhi roop ko shraddha se poojta hai, uski wahi shraddha adig ki jaati hai, aur kahin koi behtar roop sujhaya nahi jaata. Yahi woh pankti hai jiski wajah se yeh adhyay aise kamre mein padha ja sakta hai aur kisi ko naatak nahi karna padta.',
  'No better one is suggested anywhere in the verse.',
  'श्लोक में कहीं कोई बेहतर रूप सुझाया नहीं गया।',
  'Shloka mein kahin koi behtar roop sujhaya nahi gaya.',
  NULL, 'intermediate', 'plurality,respect,silence,together'

  UNION ALL SELECT 21, 'marriage', 3,
  'Two households, one Tuesday', 'दो घर, एक मंगलवार', 'Do ghar, ek mangalwar',
  'Two people from different traditions marry. For nineteen years each of them keeps their own practice and neither has ever asked the other to change. Their children describe the house as normal.',
  'अलग-अलग परंपराओं के दो लोग शादी करते हैं। उन्नीस साल तक दोनों अपना-अपना तरीक़ा रखते हैं और किसी ने कभी दूसरे से बदलने को नहीं कहा। उनके बच्चे घर को सामान्य बताते हैं।',
  'Alag-alag paramparaon ke do log shaadi karte hain. Unnees saal tak dono apna-apna tareeka rakhte hain aur kisi ne kabhi doosre se badalne ko nahi kaha. Unke bachche ghar ko samanya batate hain.',
  'That arrangement has a verse behind it whether or not either of them knows the verse. Whatever form anybody honours in good faith, it is that faith of theirs that gets made steady — tam eva, that very one. Nineteen years of nobody being redirected is what the line describes, and it is stated by the text rather than being a modern accommodation of it.',
  'उस बंदोबस्त के पीछे एक श्लोक है, चाहे दोनों में से कोई उसे जानता हो या नहीं। कोई जिस भी रूप को श्रद्धा से पूजना चाहे, उसकी वही श्रद्धा अडिग की जाती है — ताम् एव, उसी को। उन्नीस साल तक किसी का न मोड़ा जाना वही है जो यह पंक्ति बताती है, और यह ग्रंथ कहता है, यह उसकी कोई आधुनिक रियायत नहीं है।',
  'Us bandobast ke peechhe ek shloka hai, chahe dono mein se koi use jaanta ho ya nahi. Koi jis bhi roop ko shraddha se poojna chahe, uski wahi shraddha adig ki jaati hai — tam eva, usi ko. Unnees saal tak kisi ka na moda jaana wahi hai jo yeh pankti batati hai, aur yeh granth kehta hai, yeh uski koi aadhunik riyayat nahi hai.',
  'It is stated by the text rather than being a modern accommodation of it.',
  'यह ग्रंथ कहता है, यह उसकी कोई आधुनिक रियायत नहीं है।',
  'Yeh granth kehta hai, yeh uski koi aadhunik riyayat nahi hai.',
  NULL, 'beginner', 'plurality,marriage,respect,long-run'

  UNION ALL SELECT 21, 'technology', 4,
  'The onboarding that asked nothing', 'वह शुरुआत जिसने कुछ नहीं पूछा', 'Woh shuruaat jisne kuch nahi poochha',
  'A team building a reading app argues for a week about whether to ask new users their religion so the content can be tailored. They decide not to ask. Usage among people who would have skipped the question turns out to be their largest group.',
  'पढ़ने का ऐप बना रही एक टीम हफ़्ता भर बहस करती है कि नए लोगों से उनका धर्म पूछा जाए या नहीं ताकि सामग्री उसके हिसाब से हो। वे न पूछने का फ़ैसला करते हैं। जो लोग वह सवाल छोड़ देते, उनका इस्तेमाल सबसे बड़ा समूह निकलता है।',
  'Padhne ka app bana rahi ek team hafta bhar behes karti hai ki naye logon se unka dharm poochha jaaye ya nahi taki samagri uske hisaab se ho. We na poochhne ka faisla karte hain. Jo log woh sawal chhod dete, unka istemaal sabse bada samooh nikalta hai.',
  'The verse had already made the argument. It does not ask what form anybody honours before deciding what to do for them; it says whichever it is, that faith of theirs is the one made steady. A product that asks the question at the door is doing something the text specifically declines to do, and the largest group is usually the one who would have closed the tab.',
  'श्लोक यह दलील पहले ही दे चुका था। वह किसी के लिए कुछ तय करने से पहले यह नहीं पूछता कि वह किस रूप को पूजता है; वह कहता है कि जो भी हो, उसकी वही श्रद्धा अडिग की जाती है। जो उत्पाद दरवाज़े पर यह सवाल पूछता है वह ठीक वही कर रहा है जो ग्रंथ करने से साफ़ इनकार करता है, और सबसे बड़ा समूह आमतौर पर वही होता है जो टैब बंद कर देता।',
  'Shloka yeh dalil pehle hi de chuka tha. Woh kisi ke liye kuch tay karne se pehle yeh nahi poochhta ki woh kis roop ko poojta hai; woh kehta hai ki jo bhi ho, uski wahi shraddha adig ki jaati hai. Jo utpaad darwaze par yeh sawal poochhta hai woh theek wahi kar raha hai jo granth karne se saaf inkaar karta hai, aur sabse bada samooh aamtaur par wahi hota hai jo tab band kar deta.',
  'A product that asks at the door is doing what the text specifically declines to do.',
  'जो उत्पाद दरवाज़े पर पूछता है वह वही कर रहा है जो ग्रंथ साफ़ मना करता है।',
  'Jo utpaad darwaze par poochhta hai woh wahi kar raha hai jo granth saaf mana karta hai.',
  NULL, 'intermediate', 'design,no-gatekeeping,access,defaults'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 7;

-- =====================================================================
-- 5. CROSS REFERENCES
-- =====================================================================
-- FIFTEEN DECLARED. Every target checked against the seeded verse list
-- first. Count the loaded rows against fifteen before shipping.
--
-- Chapters 8, 9, 10 and 11 have no seeded verses yet, so nothing here
-- can link to them. 7.16 in particular belongs beside 9.30 and 9.32
-- once chapter 9 exists.
--
-- TWO ARE MARKED opposite AND BOTH ARE DELIBERATE.
--   7.3 -> 7.16   the same chapter, thirteen verses apart, pulling in
--                 opposite directions on who gets in. A reader who
--                 meets 7.3 alone should be handed 7.16 immediately.
--   7.11 -> 3.37  chapter 3 calls kama the enemy. Chapter 7 calls kama
--                 divine when it is not set against dharma. Both are in
--                 the same book and the qualifier is the hinge. Hiding
--                 the tension would be worse than naming it.
-- =====================================================================

DELETE x FROM verse_cross_references x JOIN verses v ON v.id = x.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 7;

INSERT INTO verse_cross_references
  (verse_id, reference_type, book, chapter, verse, target_verse_id,
   description_en, description_hi, description_hinglish, relationship, sort_order)
SELECT v.id, 'gita', 'Bhagavad Gita', CAST(x.tch AS CHAR), CAST(x.tvn AS CHAR), tv.id,
       x.d_en, x.d_hi, x.d_hing, x.rel, x.ord
FROM (
  SELECT 3 AS vn, 7 AS tch, 16 AS tvn, 1 AS ord,
    'Read on its own, 7.3 sounds like a door closing. Thirteen verses later the same chapter names four kinds of person who come — including the one in trouble and the one who wants something — and calls all four people who have done well. Read them together.' AS d_en,
    'अकेले पढ़ें तो 7.3 दरवाज़ा बंद होने जैसा लगता है। तेरह श्लोक बाद यही अध्याय चार तरह के आने वालों का नाम लेता है — उनमें मुसीबत वाला भी और कुछ चाहने वाला भी — और चारों को वह कहता है जिन्होंने ठीक किया। दोनों साथ पढ़िए।' AS d_hi,
    'Akele padhein to 7.3 darwaza band hone jaisa lagta hai. Terah shloka baad yahi adhyay chaar tarah ke aane walon ka naam leta hai — unme museebat wala bhi aur kuch chahne wala bhi — aur chaaron ko woh kehta hai jinhone theek kiya. Dono saath padhiye.' AS d_hing,
    'opposite' AS rel
  UNION ALL SELECT 3, 6, 40, 2,
    'Nobody who does good comes to a bad end. 6.40 is the sentence to have nearby when a verse about how few people get anywhere lands badly.',
    'भलाई करने वाले का बुरा अंत नहीं होता। जब यह श्लोक बुरा लगे कि कितने कम लोग कहीं पहुँचते हैं, तब 6.40 पास रखने लायक़ वाक्य है।',
    'Bhalai karne wale ka bura ant nahi hota. Jab yeh shloka bura lage ki kitne kam log kahin pahunchte hain, tab 6.40 paas rakhne layak vakya hai.',
    'supports'
  UNION ALL SELECT 5, 15, 7, 1,
    'The other half of this idea, and the two are meant to be read together. 7.5 says the higher nature has become the living being; 15.7 says that fragment is the one hauling at the senses. The first without the second becomes a permission slip.',
    'इसी बात का दूसरा आधा, और दोनों साथ पढ़े जाने के लिए हैं। 7.5 कहता है कि ऊपर वाली प्रकृति जीव बन चुकी है; 15.7 कहता है कि वही अंश इंद्रियों को खींच रहा है। दूसरे के बिना पहला छूट का परचा बन जाता है।',
    'Isi baat ka doosra aadha, aur dono saath padhe jaane ke liye hain. 7.5 kehta hai ki upar wali prakriti jeev ban chuki hai; 15.7 kehta hai ki wahi ansh indriyon ko kheench raha hai. Doosre ke bina pehla chhoot ka parcha ban jaata hai.',
    'same'
  UNION ALL SELECT 5, 13, 2, 2,
    'Chapter 13 defines a field and whatever knows it, and is careful to say it is naming two words rather than two places. 7.5 is the same restraint from the other side: the higher nature has become the living, so nothing is being put on a shelf.',
    'तेरहवाँ अध्याय क्षेत्र और उसे जानने वाले को परिभाषित करता है, और यह कहने में सावधान है कि वह दो शब्दों के नाम रख रहा है, दो जगहों के नहीं। 7.5 दूसरी तरफ़ से वही संयम है: ऊपर वाली प्रकृति जीव बन चुकी है, तो कुछ भी किसी ताक़ पर नहीं रखा जा रहा।',
    'Terahvan adhyay kshetra aur use jaanne wale ko paribhashit karta hai, aur yeh kehne mein savdhan hai ki woh do shabdon ke naam rakh raha hai, do jagahon ke nahi. 7.5 doosri taraf se wahi sanyam hai: upar wali prakriti jeev ban chuki hai, to kuch bhi kisi taak par nahi rakha ja raha.',
    'supports'
  UNION ALL SELECT 8, 13, 34, 1,
    'One sun lights the whole field and does no sorting. 7.8 is the same plainness in a list: taste, moonlight, sound in air. Neither verse asks anybody to be admitted to anything first.',
    'एक सूरज पूरे क्षेत्र को रोशन करता है और कोई छँटाई नहीं करता। 7.8 सूची की शक्ल में वही सादगी है: स्वाद, चाँदनी, हवा में आवाज़। कोई भी श्लोक पहले किसी दाख़िले की माँग नहीं करता।',
    'Ek sooraj poore kshetra ko roshan karta hai aur koi chhantai nahi karta. 7.8 soochi ki shakl mein wahi saadgi hai: swaad, chaandni, hawa mein awaaz. Koi bhi shloka pehle kisi daakhile ki maang nahi karta.',
    'supports'
  UNION ALL SELECT 8, 5, 18, 2,
    'The levelling verse. 5.18 says the same thing is seen in beings a society had ranked as far apart as it could manage; 7.8 says where that thing is to be found, and the list is water and moonlight.',
    'बराबरी वाला श्लोक। 5.18 कहता है कि वही चीज़ उन प्राणियों में देखी जाती है जिन्हें समाज ने जितना दूर रख सकता था उतना रखा; 7.8 बताता है कि वह चीज़ कहाँ मिलती है, और सूची में पानी और चाँदनी है।',
    'Barabari wala shloka. 5.18 kehta hai ki wahi cheez un praniyon mein dekhi jaati hai jinhe samaj ne jitna door rakh sakta tha utna rakha; 7.8 batata hai ki woh cheez kahan milti hai, aur soochi mein paani aur chaandni hai.',
    'supports'
  UNION ALL SELECT 11, 3, 37, 1,
    'Read these two side by side. Chapter 3 calls kama the enemy here; chapter 7 says kama that is not set against dharma is the divine thing itself. Both are in the same book, and the qualifier in 7.11 is the hinge between them — 3.37 is describing wanting that has taken the wheel, not wanting as such.',
    'इन दोनों को अगल-बगल पढ़िए। तीसरा अध्याय काम को यहाँ का शत्रु कहता है; सातवाँ कहता है कि जो काम धर्म के ख़िलाफ़ नहीं है वही दिव्य चीज़ है। दोनों एक ही किताब में हैं, और 7.11 की शर्त दोनों के बीच का जोड़ है — 3.37 उस चाह का वर्णन कर रहा है जिसने पहिया थाम लिया है, चाह का ऐसे नहीं।',
    'In dono ko agal-bagal padhiye. Teesra adhyay kaam ko yahan ka shatru kehta hai; saatvan kehta hai ki jo kaam dharm ke khilaf nahi hai wahi divya cheez hai. Dono ek hi kitaab mein hain, aur 7.11 ki shart dono ke beech ka jod hai — 3.37 us chaah ka varnan kar raha hai jisne pahiya thaam liya hai, chaah ka aise nahi.',
    'opposite'
  UNION ALL SELECT 11, 2, 70, 2,
    'The ocean the rivers enter without raising it. 2.70 is a picture of desire still arriving and nothing being run by its arrival, which is the closest the book gets to showing 7.11 in practice.',
    'वह समुद्र जिसमें नदियाँ आती हैं और वह बढ़ता नहीं। 2.70 उस चाह की तस्वीर है जो अब भी आ रही है और जिसके आने से कुछ चल नहीं रहा, और किताब में 7.11 को बरतते हुए दिखाने के सबसे क़रीब यही है।',
    'Woh samudra jisme nadiyan aati hain aur woh badhta nahi. 2.70 us chaah ki tasveer hai jo ab bhi aa rahi hai aur jiske aane se kuch chal nahi raha, aur kitaab mein 7.11 ko barat-te hue dikhane ke sabse kareeb yahi hai.',
    'supports'
  UNION ALL SELECT 14, 6, 35, 1,
    'The mind is hard to hold, says 6.35, and then gives two words rather than a promise. 7.14 uses the same honesty: it says hard first and offers the way across second.',
    '6.35 कहता है कि मन को थामना मुश्किल है, और फिर वादे के बजाय दो शब्द देता है। 7.14 वही ईमानदारी बरतता है: पहले मुश्किल कहता है, पार का रास्ता बाद में।',
    '6.35 kehta hai ki man ko thaamna mushkil hai, aur phir waade ke bajaye do shabd deta hai. 7.14 wahi imaandari baratta hai: pehle mushkil kehta hai, paar ka raasta baad mein.',
    'same'
  UNION ALL SELECT 14, 12, 5, 2,
    'Chapter 12 says outright that one of the two roads is harder, and then offers the other one. Both chapters state a difficulty before offering anything, and neither attaches a timescale to it.',
    'बारहवाँ अध्याय साफ़ कहता है कि दो रास्तों में से एक ज़्यादा मुश्किल है, और फिर दूसरा देता है। दोनों अध्याय कुछ देने से पहले मुश्किल बताते हैं, और कोई भी उसके साथ समय-सीमा नहीं जोड़ता।',
    'Barahvan adhyay saaf kehta hai ki do raaston mein se ek zyada mushkil hai, aur phir doosra deta hai. Dono adhyay kuch dene se pehle mushkil batate hain, aur koi bhi uske saath samay-seema nahi jodta.',
    'supports'
  UNION ALL SELECT 16, 4, 11, 1,
    'However people come to me, I meet them that way. 4.11 and 7.16 are the two verses that between them decide what kind of door this book has, and neither of them asks anybody why they turned up.',
    'लोग जिस तरह मेरे पास आते हैं, मैं उसी तरह उनसे मिलता हूँ। 4.11 और 7.16 वे दो श्लोक हैं जो मिलकर तय करते हैं कि इस किताब का दरवाज़ा किस तरह का है, और दोनों में से कोई किसी से यह नहीं पूछता कि वह आया क्यों।',
    'Log jis tarah mere paas aate hain, main usi tarah unse milta hoon. 4.11 aur 7.16 we do shloka hain jo milkar tay karte hain ki is kitaab ka darwaza kis tarah ka hai, aur dono mein se koi kisi se yeh nahi poochhta ki woh aaya kyun.',
    'supports'
  UNION ALL SELECT 16, 1, 28, 2,
    'The man this entire book is spoken to arrived in the first category. 1.28 is Arjuna in collapse, and everything after it is the answer somebody in distress was given.',
    'जिस आदमी से यह पूरी किताब कही गई है वह पहली श्रेणी में आया था। 1.28 में अर्जुन टूटा हुआ है, और उसके बाद का सब कुछ वह जवाब है जो मुसीबत में पड़े एक आदमी को दिया गया।',
    'Jis aadmi se yeh poori kitaab kahi gayi hai woh pehli shreni mein aaya tha. 1.28 mein Arjun toota hua hai, aur uske baad ka sab kuch woh jawab hai jo museebat mein pade ek aadmi ko diya gaya.',
    'story'
  UNION ALL SELECT 17, 16, 5, 1,
    'The moment chapter 16 becomes usable as a way of sorting people, the speaker turns to the frightened man in front of him and tells him not to grieve. 7.17 ranks inside a chapter that has already welcomed all four, and the structure is the same one.',
    'जिस पल सोलहवाँ अध्याय लोगों को छाँटने के काम आने लगता है, बोलने वाला अपने सामने खड़े डरे हुए आदमी की तरफ़ मुड़कर कहता है कि शोक मत कर। 7.17 उस अध्याय के भीतर क्रम लगाता है जो चारों का स्वागत कर चुका है, और बनावट वही है।',
    'Jis pal solahvan adhyay logon ko chhantne ke kaam aane lagta hai, bolne wala apne saamne khade dare hue aadmi ki taraf mudkar kehta hai ki shok mat kar. 7.17 us adhyay ke bheetar kram lagata hai jo chaaron ka swagat kar chuka hai, aur banawat wahi hai.',
    'supports'
  UNION ALL SELECT 21, 4, 11, 1,
    'However anybody comes, they are met that way. 4.11 and 7.21 say the same thing about two different things — the manner of arriving and the form honoured — and neither redirects anybody to a better one.',
    'कोई जिस तरह आता है, उससे उसी तरह मिला जाता है। 4.11 और 7.21 दो अलग चीज़ों के बारे में एक ही बात कहते हैं — आने का ढंग और पूजा जाने वाला रूप — और दोनों में से कोई किसी को बेहतर की तरफ़ नहीं मोड़ता।',
    'Koi jis tarah aata hai, usse usi tarah mila jaata hai. 4.11 aur 7.21 do alag cheezon ke baare mein ek hi baat kehte hain — aane ka dhang aur pooja jaane wala roop — aur dono mein se koi kisi ko behtar ki taraf nahi modta.',
    'same'
  UNION ALL SELECT 21, 18, 63, 2,
    'Think it over completely, then do as you wish. The last word of the book hands the decision back, and 7.21 hands back the form. Together they are why this text can be read by somebody who shares none of its frame.',
    'पूरी तरह विचार कर लो, फिर जैसा चाहो वैसा करो। किताब का आख़िरी शब्द फ़ैसला वापस थमा देता है, और 7.21 रूप वापस थमा देता है। दोनों मिलकर वह वजह हैं कि इस ग्रंथ को वह भी पढ़ सकता है जो इसका ढाँचा बिल्कुल नहीं मानता।',
    'Poori tarah vichar kar lo, phir jaisa chaho waisa karo. Kitaab ka aakhiri shabd faisla wapas thama deta hai, aur 7.21 roop wapas thama deta hai. Dono milkar woh wajah hain ki is granth ko woh bhi padh sakta hai jo iska dhaancha bilkul nahi maanta.',
    'supports'
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 7
JOIN chapters tc ON tc.chapter_number = x.tch
JOIN verses tv ON tv.chapter_id = tc.id AND tv.verse_number = x.tvn;

-- =====================================================================
-- 6. WORD BY WORD
-- =====================================================================
-- Five glosses carry the chapter's safeguards:
--   yatati (7.3)          the verb is tries, and it counts an activity
--   jīva-bhūtām (7.5)     has become, not oversees
--   dharmāviruddhaḥ (7.11) the qualifier, and how narrow it is
--   sukṛtinaḥ (7.16)      applied to all four before they are separated
--   viśiṣyate (7.17)      is distinguished — it ranks, and it says so
--
-- pauruṣaṁ nṛṣu (7.8) is glossed honestly rather than tidied. The root
-- is gendered and the gloss says so instead of pretending otherwise.
--
-- All glosses stay under 400 characters — the column is varchar(400).
-- THIRTY-TWO rows, four per verse.
-- =====================================================================

DELETE w FROM verse_word_meanings w JOIN verses v ON v.id = w.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 7;

INSERT INTO verse_word_meanings
  (verse_id, word_order, devanagari, transliteration,
   meaning_en, meaning_hi, meaning_hinglish, grammar, root_word)
SELECT v.id, w.ord, w.dev, w.tr, w.m_en, w.m_hi, w.m_hing, w.gram, w.root FROM (

  SELECT 3 AS vn, 1 AS ord, 'मनुष्याणां सहस्रेषु' AS dev, 'manuṣyāṇāṁ sahasreṣu' AS tr,
    'among thousands of people. A quantity, stated flatly, with no adjective anywhere near it' AS m_en,
    'हज़ारों लोगों में। एक मात्रा, सपाट कही गई, आसपास कहीं कोई विशेषण नहीं' AS m_hi,
    'hazaron logon mein. Ek maatra, sapaat kahi gayi, aaspaas kahin koi visheshan nahi' AS m_hing,
    'genitive and locative plural' AS gram, 'मनुष्य' AS root
  UNION ALL SELECT 3, 2, 'यतति', 'yatati',
    'tries, makes an effort, sets about it. The verb is about an activity being undertaken, which is why this line counts a doing and not a worth',
    'कोशिश करता है, यत्न करता है, उस काम पर लगता है। क्रिया किसी काम के उठाए जाने की है, इसीलिए यह पंक्ति करना गिनती है, मोल नहीं',
    'koshish karta hai, yatn karta hai, us kaam par lagta hai. Kriya kisi kaam ke uthaye jaane ki hai, isiliye yeh pankti karna ginti hai, mol nahi',
    'present, third singular', 'यत्'
  UNION ALL SELECT 3, 3, 'सिद्धये', 'siddhaye',
    'for completion, for the thing coming off. A destination word, not a rank',
    'सिद्धि के लिए, बात बन जाने के लिए। यह मंज़िल का शब्द है, दर्जे का नहीं',
    'siddhi ke liye, baat ban jaane ke liye. Yeh manzil ka shabd hai, darje ka nahi',
    'dative singular', 'सिध्'
  UNION ALL SELECT 3, 4, 'तत्त्वतः', 'tattvataḥ',
    'as it actually is, in its thatness. The second clause is about accuracy rather than about achievement',
    'जैसा वह असल में है, उसके तत्त्व से। दूसरा वाक्यांश उपलब्धि का नहीं, सटीकता का है',
    'jaisa woh asal mein hai, uske tattva se. Doosra vakyansh uplabdhi ka nahi, sateekta ka hai',
    'ablative adverb', 'तत्त्व'

  UNION ALL SELECT 5, 1, 'अपरा', 'aparā',
    'the lower, the nearer one — the eight-fold nature listed in the verse before. Aparā means not-higher, and the word is comparative rather than dismissive',
    'निचली, क़रीब वाली — पिछले श्लोक में गिनाई गई आठ वाली प्रकृति। अपरा यानी ऊपर वाली नहीं, और यह शब्द तुलना का है, ख़ारिज करने का नहीं',
    'nichli, kareeb wali — pichhle shloka mein ginai gayi aath wali prakriti. Apara yani upar wali nahi, aur yeh shabd tulna ka hai, khaarij karne ka nahi',
    'nominative singular', 'पर'
  UNION ALL SELECT 5, 2, 'पराम्', 'parām',
    'the higher, the further one. Said of a second nature, and the verse spends its remaining words on what that nature has done rather than on where it sits',
    'ऊपर वाली, आगे वाली। यह दूसरी प्रकृति के बारे में है, और श्लोक अपने बाक़ी शब्द इस पर लगाता है कि उस प्रकृति ने किया क्या है, यह नहीं कि वह बैठी कहाँ है',
    'upar wali, aage wali. Yeh doosri prakriti ke baare mein hai, aur shloka apne baaki shabd is par lagata hai ki us prakriti ne kiya kya hai, yeh nahi ki woh baithi kahan hai',
    'accusative singular', 'पर'
  UNION ALL SELECT 5, 3, 'जीवभूताम्', 'jīva-bhūtām',
    'HAVING BECOME the living being. Bhūta is a past participle of becoming, not a word for presiding or overseeing. Nothing about a person is being kept somewhere else, safe and uninvolved — and 15.7 says the same fragment is the one doing the hauling',
    'जीव बन चुकी। भूत बन जाने का भूतकालिक रूप है, ऊपर बैठने या देखरेख का शब्द नहीं। आदमी की कोई चीज़ कहीं और, सुरक्षित और अलग, नहीं रखी जा रही — और 15.7 कहता है कि खींचने का काम वही अंश कर रहा है',
    'jeev ban chuki. Bhoot ban jaane ka bhootkalik roop hai, upar baithne ya dekhrekh ka shabd nahi. Aadmi ki koi cheez kahin aur, surakshit aur alag, nahi rakhi ja rahi — aur 15.7 kehta hai ki kheenchne ka kaam wahi ansh kar raha hai',
    'accusative singular, compound', 'भू'
  UNION ALL SELECT 5, 4, 'धार्यते', 'dhāryate',
    'is held up, is carried. Passive — the world is the thing being supported, and the support is the living nature just named',
    'थामी जाती है, ढोई जाती है। कर्मवाच्य — दुनिया वह है जिसे सहारा दिया जा रहा है, और सहारा वही जीव-प्रकृति है जिसका अभी नाम लिया गया',
    'thaami jaati hai, dhoi jaati hai. Karmvachya — duniya woh hai jise sahara diya ja raha hai, aur sahara wahi jeev-prakriti hai jiska abhi naam liya gaya',
    'passive, third singular', 'धृ'

  UNION ALL SELECT 8, 1, 'रसः', 'rasaḥ',
    'taste, and also sap, and also the thing that makes something worth having. First item on the list, and everybody reading this has had some water today',
    'रस — स्वाद, और सार भी, और वह भी जो किसी चीज़ को पाने लायक़ बनाता है। सूची की पहली चीज़, और इसे पढ़ने वाले हर आदमी ने आज कुछ पानी पिया है',
    'ras — swaad, aur saar bhi, aur woh bhi jo kisi cheez ko paane layak banata hai. Soochi ki pehli cheez, aur ise padhne wale har aadmi ne aaj kuch paani piya hai',
    'nominative singular', 'रस्'
  UNION ALL SELECT 8, 2, 'प्रभा', 'prabhā',
    'shine, the light coming off something. Not the moon and the sun — the shining of them, which is a smaller and more exact claim',
    'चमक, किसी चीज़ से आती रोशनी। चाँद और सूरज नहीं — उनका चमकना, जो छोटा और ज़्यादा सटीक दावा है',
    'chamak, kisi cheez se aati roshni. Chaand aur sooraj nahi — unka chamakna, jo chhota aur zyada sateek dawa hai',
    'nominative singular', 'प्र + भा'
  UNION ALL SELECT 8, 3, 'शब्दः खे', 'śabdaḥ khe',
    'sound in open space. Third from last, and like the rest of the list it points at something a person already knows first-hand and has no vocabulary for',
    'खुली जगह में आवाज़। आख़िर से तीसरी, और बाक़ी सूची की तरह यह भी उस चीज़ की ओर इशारा करती है जिसे आदमी पहले से ख़ुद जानता है और जिसके लिए उसके पास शब्द नहीं',
    'khuli jagah mein awaaz. Aakhir se teesri, aur baaki soochi ki tarah yeh bhi us cheez ki or ishara karti hai jise aadmi pehle se khud jaanta hai aur jiske liye uske paas shabd nahi',
    'nominative singular, locative', 'शब्द'
  UNION ALL SELECT 8, 4, 'पौरुषं नृषु', 'pauruṣaṁ nṛṣu',
    'the capability in people. Said plainly: nṛ means a person and also a man, and pauruṣa is built on puruṣa, so the older sense is manliness. It is rendered here as what gets things done in people because that is what the word denotes, and the gendered root is named rather than tidied away',
    'लोगों में वह जो कर गुज़रता है। साफ़ कह दें: नृ का अर्थ आदमी भी है और पुरुष भी, और पौरुष पुरुष पर बना है, तो पुराना अर्थ मर्दानगी है। यहाँ इसे लोगों में काम कर गुज़रने वाली चीज़ कहा गया है क्योंकि शब्द यही बताता है, और लिंग वाली जड़ को छिपाया नहीं, नाम लिया गया है',
    'logon mein woh jo kar guzarta hai. Saaf keh dein: nri ka arth aadmi bhi hai aur purush bhi, aur paurush purush par bana hai, to purana arth mardanagi hai. Yahan ise logon mein kaam kar guzarne wali cheez kaha gaya hai kyunki shabd yahi batata hai, aur ling wali jad ko chhipaya nahi, naam liya gaya hai',
    'nominative singular, locative plural', 'पुरुष'

  UNION ALL SELECT 11, 1, 'बलम्', 'balam',
    'strength. Qualified immediately as the kind free of craving and clinging, which is the verse being careful about what it is claiming',
    'बल। तुरंत यह शर्त लगती है कि वह वाला जिसमें ललक और चिपकाव नहीं, और यही श्लोक की सावधानी है कि वह दावा किसका कर रहा है',
    'bal. Turant yeh shart lagti hai ki woh wala jisme lalak aur chipkav nahi, aur yahi shloka ki savdhani hai ki woh dawa kiska kar raha hai',
    'nominative singular', 'बल्'
  UNION ALL SELECT 11, 2, 'कामरागविवर्जितम्', 'kāma-rāga-vivarjitam',
    'free of craving and of clinging. Note that this qualifier is attached to STRENGTH, in the first line. The second line''s qualifier is a different one',
    'काम और राग से रहित। ध्यान दीजिए कि यह शर्त बल के साथ लगी है, पहली पंक्ति में। दूसरी पंक्ति की शर्त अलग है',
    'kaam aur raag se rahit. Dhyan dijiye ki yeh shart bal ke saath lagi hai, pehli pankti mein. Doosri pankti ki shart alag hai',
    'nominative singular, compound', 'वि + वृज्'
  UNION ALL SELECT 11, 3, 'धर्माविरुद्धः', 'dharmāviruddhaḥ',
    'not set against dharma. THE WHOLE QUALIFIER, and it is a narrow one — it rules out wanting that requires what holds things up to give way, and it rules out nothing else. The word for only-spiritual is not in this line and never was',
    'धर्म के विरुद्ध नहीं। पूरी शर्त यही है, और वह सँकरी है — वह उस चाह को बाहर करती है जिसके पूरा होने के लिए चीज़ों को थामे रखने वाले को हटना पड़े, और इसके सिवा कुछ बाहर नहीं करती। सिर्फ़-आध्यात्मिक वाला शब्द इस पंक्ति में न है न कभी था',
    'dharm ke viruddh nahi. Poori shart yahi hai, aur woh sankari hai — woh us chaah ko bahar karti hai jiske poora hone ke liye cheezon ko thaame rakhne wale ko hatna pade, aur iske siva kuch bahar nahi karti. Sirf-aadhyatmik wala shabd is pankti mein na hai na kabhi tha',
    'nominative singular, compound', 'वि + रुध्'
  UNION ALL SELECT 11, 4, 'कामः', 'kāmaḥ',
    'desire, wanting. The same word 3.37 calls the enemy. Both are in this book and 7.11''s qualifier is what stands between them: chapter 3 is describing wanting that has taken the wheel, not wanting as such',
    'काम, चाह। यही शब्द 3.37 शत्रु कहता है। दोनों इसी किताब में हैं और 7.11 की शर्त दोनों के बीच खड़ी है: तीसरा अध्याय उस चाह का वर्णन कर रहा है जिसने पहिया थाम लिया है, चाह का ऐसे नहीं',
    'kaam, chaah. Yahi shabd 3.37 shatru kehta hai. Dono isi kitaab mein hain aur 7.11 ki shart dono ke beech khadi hai: teesra adhyay us chaah ka varnan kar raha hai jisne pahiya thaam liya hai, chaah ka aise nahi',
    'nominative singular', 'कम्'

  UNION ALL SELECT 14, 1, 'दैवी', 'daivī',
    'belonging to the shining ones, of that order. An adjective about where it comes from, not a compliment',
    'देवों की, उस कोटि की। यह विशेषण बताता है कि वह आती कहाँ से है, यह तारीफ़ नहीं है',
    'devon ki, us koti ki. Yeh visheshan batata hai ki woh aati kahan se hai, yeh tareef nahi hai',
    'nominative singular feminine', 'देव'
  UNION ALL SELECT 14, 2, 'गुणमयी', 'guṇa-mayī',
    'made of the gunas — the three settings chapter 14 spends itself on. Made of, which is why it cannot be argued with from inside',
    'गुणों से बनी — वही तीन अवस्थाएँ जिन पर चौदहवाँ अध्याय ख़र्च होता है। बनी हुई, और इसीलिए उससे भीतर से बहस नहीं की जा सकती',
    'gunon se bani — wahi teen avasthayein jin par chaudahvan adhyay kharch hota hai. Bani hui, aur isiliye usse bheetar se behes nahi ki ja sakti',
    'nominative singular feminine, compound', 'गुण'
  UNION ALL SELECT 14, 3, 'दुरत्यया', 'duratyayā',
    'hard to get across. THE VERSE SAYS THIS FIRST, before it says anything at all about crossing. No page in this chapter promises a timescale, because the text does not offer one',
    'पार करना मुश्किल। श्लोक यह पहले कहता है, पार होने के बारे में कुछ भी कहने से पहले। इस अध्याय का कोई पन्ना समय-सीमा का वादा नहीं करता, क्योंकि ग्रंथ कोई नहीं देता',
    'paar karna mushkil. Shloka yeh pehle kehta hai, paar hone ke baare mein kuch bhi kehne se pehle. Is adhyay ka koi panna samay-seema ka waada nahi karta, kyunki granth koi nahi deta',
    'nominative singular feminine', 'दुर् + अति + इ'
  UNION ALL SELECT 14, 4, 'प्रपद्यन्ते', 'prapadyante',
    'come towards, put themselves in the way of. A verb of arriving rather than of achieving, and 7.16 is about to say four different ways of doing it are all fine',
    'पास आते हैं, अपने को उसके रास्ते में रख देते हैं। यह पहुँचने की क्रिया है, हासिल करने की नहीं, और 7.16 अभी कहने वाला है कि ऐसा करने के चार अलग तरीक़े सब ठीक हैं',
    'paas aate hain, apne ko uske raaste mein rakh dete hain. Yeh pahunchne ki kriya hai, haasil karne ki nahi, aur 7.16 abhi kehne wala hai ki aisa karne ke chaar alag tareeke sab theek hain',
    'present, third plural', 'प्र + पद्'

  UNION ALL SELECT 16, 1, 'चतुर्विधाः', 'catur-vidhāḥ',
    'of four kinds. A count of routes in, not a hierarchy — the sorting does not happen until the next verse',
    'चार तरह के। भीतर आने के रास्तों की गिनती, कोई सीढ़ी नहीं — छँटाई अगले श्लोक तक होती ही नहीं',
    'chaar tarah ke. Bheetar aane ke raaston ki ginti, koi seedhi nahi — chhantai agle shloka tak hoti hi nahi',
    'nominative plural, compound', 'चतुर्'
  UNION ALL SELECT 16, 2, 'सुकृतिनः', 'sukṛtinaḥ',
    'people who have done well. THE WORD IS APPLIED TO ALL FOUR AND IT ARRIVES BEFORE THEY ARE SEPARATED. Nothing in the verse makes it conditional, and nothing anywhere near it suggests one of the four earned it more',
    'जिन्होंने ठीक किया। यह शब्द चारों पर लगता है और उन्हें अलग किए जाने से पहले आता है। श्लोक में कुछ इसे शर्तिया नहीं बनाता, और आसपास कहीं यह इशारा नहीं कि चारों में से किसी ने इसे ज़्यादा कमाया',
    'jinhone theek kiya. Yeh shabd chaaron par lagta hai aur unhe alag kiye jaane se pehle aata hai. Shloka mein kuch ise shartiya nahi banata, aur aaspaas kahin yeh ishara nahi ki chaaron mein se kisi ne ise zyada kamaya',
    'nominative plural', 'सु + कृ'
  UNION ALL SELECT 16, 3, 'आर्तः', 'ārtaḥ',
    'the one in distress, hurt, in trouble. FIRST ON THE LIST. Whoever arrived at a book like this in a bad month is named here, by the text, before anybody else',
    'आर्त — पीड़ित, दुखी, मुसीबत में पड़ा। सूची में पहला। जो कोई बुरे महीने में ऐसी किताब तक पहुँचा हो, ग्रंथ यहाँ सबसे पहले उसी का नाम लेता है',
    'aarta — peedit, dukhi, museebat mein pada. Soochi mein pehla. Jo koi bure mahine mein aisi kitaab tak pahuncha ho, granth yahan sabse pehle usi ka naam leta hai',
    'nominative singular', 'ऋ'
  UNION ALL SELECT 16, 4, 'अर्थार्थी', 'arthārthī',
    'the one who wants something out of it. Third on the list and the reason most often treated as shabby. The verse counts it in by name with no qualifying clause anywhere near it',
    'अर्थार्थी — जो इससे कुछ चाहता है। सूची में तीसरा और वही वजह जिसे अक्सर घटिया माना जाता है। श्लोक उसे नाम लेकर गिनता है, आसपास कहीं कोई शर्त लगाए बिना',
    'artharthi — jo isse kuch chahta hai. Soochi mein teesra aur wahi wajah jise aksar ghatiya mana jaata hai. Shloka use naam lekar ginta hai, aaspaas kahin koi shart lagaye bina',
    'nominative singular, compound', 'अर्थ'

  UNION ALL SELECT 17, 1, 'विशिष्यते', 'viśiṣyate',
    'is distinguished, stands out. THE VERSE RANKS AND THIS IS THE WORD IT RANKS WITH. It is not softened here. What can be said is that 7.16 has already counted all four in, so this sorts people who are all inside rather than deciding who is let in',
    'अलग किया जाता है, अलग दिखता है। श्लोक क्रम लगाता है और यही वह शब्द है जिससे लगाता है। इसे यहाँ नरम नहीं किया गया। कहा इतना जा सकता है कि 7.16 चारों को पहले ही गिन चुका है, तो यह उन्हें छाँटता है जो सब भीतर हैं, यह तय नहीं करता कि किसे भीतर आने दिया जाए',
    'alag kiya jaata hai, alag dikhta hai. Shloka kram lagata hai aur yahi woh shabd hai jisse lagata hai. Ise yahan naram nahi kiya gaya. Kaha itna ja sakta hai ki 7.16 chaaron ko pehle hi gin chuka hai, to yeh unhe chhantta hai jo sab bheetar hain, yeh tay nahi karta ki kise bheetar aane diya jaaye',
    'passive, third singular', 'वि + शिष्'
  UNION ALL SELECT 17, 2, 'नित्ययुक्तः', 'nitya-yuktaḥ',
    'always joined, steadily connected. A description of a state that keeps, not of a rank awarded',
    'सदा जुड़ा हुआ, लगातार लगा हुआ। यह ठहरने वाली हालत का वर्णन है, दिए गए दर्जे का नहीं',
    'sada juda hua, lagatar laga hua. Yeh thehrne wali haalat ka varnan hai, diye gaye darje ka nahi',
    'nominative singular, compound', 'युज्'
  UNION ALL SELECT 17, 3, 'एकभक्तिः', 'eka-bhaktiḥ',
    'holding to one, undivided in what is given. Eka is one and not first; nothing in the word is about being ahead of anybody',
    'एक को थामे हुए, जो दिया जाता है उसमें बँटा हुआ नहीं। एक का अर्थ एक है, पहला नहीं; शब्द में कहीं किसी से आगे होने की बात नहीं',
    'ek ko thaame hue, jo diya jaata hai usme banta hua nahi. Ek ka arth ek hai, pehla nahi; shabd mein kahin kisi se aage hone ki baat nahi',
    'nominative singular, compound', 'भज्'
  UNION ALL SELECT 17, 4, 'प्रियः', 'priyaḥ',
    'dear. Said in both directions in the same line — dear to and dear from. A word about a relation rather than a score, and chapter 12 uses it of a much longer list of people',
    'प्रिय। एक ही पंक्ति में दोनों तरफ़ कहा गया — किसके लिए प्रिय और किसका प्रिय। यह रिश्ते का शब्द है, अंक का नहीं, और बारहवाँ अध्याय इसे लोगों की कहीं लंबी सूची के लिए बरतता है',
    'priya. Ek hi pankti mein dono taraf kaha gaya — kiske liye priya aur kiska priya. Yeh rishte ka shabd hai, ank ka nahi, aur barahvan adhyay ise logon ki kahin lambi soochi ke liye baratta hai',
    'nominative singular', 'प्री'

  UNION ALL SELECT 21, 1, 'यां यां तनुम्', 'yāṁ yāṁ tanum',
    'whichever form, whichever form. The doubling is the point — it is a distributive, meaning each person''s own, one by one, rather than some approved set',
    'जो जो रूप। दोहराव ही बात है — यह वितरण वाला प्रयोग है, यानी हर एक का अपना, एक-एक करके, कोई मंज़ूरशुदा सूची नहीं',
    'jo jo roop. Dohrav hi baat hai — yeh vitaran wala prayog hai, yani har ek ka apna, ek-ek karke, koi manzoorshuda soochi nahi',
    'accusative singular, repeated', 'तन्'
  UNION ALL SELECT 21, 2, 'श्रद्धया', 'śraddhayā',
    'with faith, with what somebody sets their heart on. The only condition in the verse, and it is about the person rather than about the form',
    'श्रद्धा से, उससे जिस पर कोई अपना मन रखता है। श्लोक की इकलौती शर्त, और वह रूप के बारे में नहीं, आदमी के बारे में है',
    'shraddha se, usse jis par koi apna man rakhta hai. Shloka ki iklauti shart, aur woh roop ke baare mein nahi, aadmi ke baare mein hai',
    'instrumental singular', 'श्रद् + धा'
  UNION ALL SELECT 21, 3, 'अचलाम्', 'acalām',
    'unmoving, not shifted. What is made steady is the faith that was already there — nothing is being replaced',
    'अचल, हिलाई नहीं गई। जो अडिग की जाती है वह वही श्रद्धा है जो पहले से थी — कुछ बदला नहीं जा रहा',
    'achal, hilai nahi gayi. Jo adig ki jaati hai woh wahi shraddha hai jo pehle se thi — kuch badla nahi ja raha',
    'accusative singular feminine', 'चल्'
  UNION ALL SELECT 21, 4, 'ताम् एव', 'tām eva',
    'THAT VERY ONE. Eva is the emphatic particle and it points back at the form the person chose for themselves. The line could trivially have redirected them to a better one and the emphatic word is there to stop it',
    'उसी को। एव ज़ोर देने वाला कण है और वह वापस उसी रूप की ओर इशारा करता है जिसे उस आदमी ने ख़ुद चुना। पंक्ति उसे बहुत आसानी से किसी बेहतर रूप की तरफ़ मोड़ सकती थी और यह ज़ोर वाला शब्द उसे रोकने के लिए है',
    'usi ko. Eva zor dene wala kan hai aur woh wapas usi roop ki or ishara karta hai jise us aadmi ne khud chuna. Pankti use bahut aasani se kisi behtar roop ki taraf mod sakti thi aur yeh zor wala shabd use rokne ke liye hai',
    'accusative singular with particle', NULL

) AS w
JOIN verses v ON v.verse_number = w.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 7;
