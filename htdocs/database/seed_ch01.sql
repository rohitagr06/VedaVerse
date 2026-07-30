-- =====================================================================
-- VedaVerse — database/seed_ch01.sql
-- =====================================================================
-- Chapter 1, Arjuna Viṣāda Yoga. Eight verses.
--
--   1.28  the body reacts before any argument arrives
--   1.29  the trembling, the bristling skin, the bow slipping
--   1.30  "I cannot stand up and my mind is going round"
--   1.31  the reasons arrive, and they are good reasons
--   1.32  what is any of it for
--   1.38  they cannot see it. I can.
--   1.46  the despair sentence                            [CARE]
--   1.47  he sits down                                    [CARE]
--
-- WHY THIS CHAPTER IS NOT ON THE BEGINNER PATH AND STILL HAD TO BE
-- WRITTEN
--   app.php puts chapter 1 late in the advanced track and leaves it off
--   the beginner one, for the reason recorded there: the collapse reads
--   far better once you know what the argument is going to be. That is
--   still the right call and it is unchanged by this file.
--
--   But the chapter is PUBLISHED and marked beginner, so it appears in
--   the chapter list as the first thing a browsing reader sees, and
--   until now it said "0 verses · Nothing here yet." A reader who opens
--   the Bhagavad Gita at chapter 1 and finds nothing there has been
--   told something about the product. That is what this file fixes.
--
-- 1.46 NEEDS CARE, AND OF A KIND NOTHING ELSE IN THE CORPUS HAS NEEDED
--   The line is "it would be better for me if they killed me, unarmed
--   and not resisting". Somebody in real distress can land on that page
--   and read a sentence that agrees with them, in a book presented as
--   wisdom. Three things are true of the treatment and all three are in
--   the explanation, in all three languages, at beginner depth.
--
--   1. IT IS NOT SOFTENED. The verse says what it says and pretending
--      otherwise would be its own kind of dishonesty. Despair talks
--      like this, and the text is unusual in writing the sentence down
--      instead of tidying it.
--
--   2. THE TEXT DOES NOT AGREE WITH IT. Recording a sentence is not
--      endorsing it. Nothing in the seventeen chapters that follow
--      treats it as a plan, returns to it, or grants it. What actually
--      happens next is the smallest and least mystical thing in the
--      book: somebody stays, and keeps talking to him.
--
--   3. IT POINTS AT A PERSON, NOT AT A CHAPTER. The explanation says
--      plainly that if the sentence is a live one rather than a line in
--      a book, what helps is a person and not a text, and that a book
--      agreeing with you is not what anybody needs at that point.
--
-- 1.28 TO 1.30 ARE A DESCRIPTION AND NOT A DIAGNOSIS
--   Limbs giving way, mouth drying, trembling, skin burning, unable to
--   stand, mind going round. It is an unusually precise account of an
--   acute stress response and it is tempting to say so and stop. The
--   explanations say it is a description of one man on one afternoon,
--   that it is not a claim about what is happening in anybody's body
--   now, and that this book is not treatment. Recognising yourself in a
--   verse is worth something. It is not worth a diagnosis.
--
-- 1.47 IS DESCRIBED WITHOUT CONTEMPT
--   Sañjaya reports a man sitting down and putting his weapons aside,
--   and does not call him weak, cowardly or unmanly. Chapter 2 opens
--   with a challenge and gets quoted as though the whole book despises
--   the collapse; the last verse of chapter 1 is the evidence that it
--   does not. The explanation says so and the smoke suite asserts it.
--
-- DELIBERATELY NOT IN THIS FILE — 1.40 TO 1.44
--   Arjuna's kula-dharma argument, which contains the claim that the
--   destruction of a family corrupts its women and produces varṇa-
--   saṅkara. It is the book's hardest passage on both gender and caste
--   and it is not written here as an oversight — it is deferred, on
--   purpose, to be done as one piece of work with 4.13, which is
--   deferred for the same reason. Skipping it quietly would have been
--   the wrong kind of easy; this comment is the record that it was a
--   decision. See CLAUDE.md §9.
--
-- CONTENT RULES — unchanged
--   Original writing throughout. Sanskrit unaltered, numbering
--   untouched. No praise or criticism of any living politician, party
--   or movement. No communal framing. Nothing in this file names a
--   condition, prescribes anything, or offers a number to call — the
--   1.46 explanation points at a person and stops there.
--
-- RUN AFTER seed_sample.sql. Re-runnable.
--
--     mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
--         < htdocs/database/seed_ch01.sql
--
-- global_order is the verse number: chapter 1 is the first chapter.
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

  SELECT 28 AS verse_number, 28 AS global_order, 1 AS is_curated, 'gita-1-28' AS slug,
    'दृष्ट्वेमं स्वजनं कृष्ण युयुत्सुं समुपस्थितम्।\nसीदन्ति मम गात्राणि मुखं च परिशुष्यति॥' AS sanskrit_devanagari,
    'dṛṣṭvemaṁ svajanaṁ kṛṣṇa yuyutsuṁ samupasthitam\nsīdanti mama gātrāṇi mukhaṁ ca pariśuṣyati' AS transliteration_iast,
    'drishtvemam svajanam krishna yuyutsum samupasthitam\nsidanti mama gatrani mukham cha parishushyati' AS transliteration_simple,
    'Seeing these my own people standing here wanting to fight, O Krishna, my limbs give way and my mouth dries up.' AS translation_literal,
    'Seeing my own people standing there, ready to fight, my legs are going and my mouth has gone dry.' AS translation_en,
    'अपने ही लोगों को वहाँ खड़ा देखकर, लड़ने को तैयार, मेरे पैर जवाब दे रहे हैं और मुँह सूख गया है।' AS translation_hi,
    'Apne hi logon ko wahan khada dekhkar, ladne ko taiyar, mere pair jawab de rahe hain aur munh sookh gaya hai.' AS translation_hinglish,
    'The first thing that happens is not a thought. It is a mouth going dry.' AS summary_en,
    'सबसे पहले जो होता है वह कोई विचार नहीं है। वह है मुँह का सूख जाना।' AS summary_hi,
    'Sabse pehle jo hota hai woh koi vichaar nahi hai. Woh hai munh ka sookh jaana.' AS summary_hinglish,
    'beginner' AS difficulty,
    'Gita 1.28: the body answers before the argument does' AS seo_title,
    'Arjuna sees who he is about to fight and his legs give way before he has thought anything. The Bhagavad Gita opens its first speech with a body, not an idea.' AS seo_description,
    1 AS published

  UNION ALL SELECT 29, 29, 1, 'gita-1-29',
    'वेपथुश्च शरीरे मे रोमहर्षश्च जायते।\nगाण्डीवं स्रंसते हस्तात्त्वक्चैव परिदह्यते॥',
    'vepathuś ca śarīre me roma-harṣaś ca jāyate\ngāṇḍīvaṁ sraṁsate hastāt tvak caiva paridahyate',
    'vepathush cha sharire me roma-harshash cha jayate\ngandivam sramsate hastat tvak chaiva paridahyate',
    'There is trembling in my body and my hair stands on end. The Gandiva bow slips from my hand and my skin is burning all over.',
    'I am shaking. The hair on my arms is standing up. The bow is sliding out of my hand and my skin is burning.',
    'मैं काँप रहा हूँ। बाँहों के रोएँ खड़े हो गए हैं। धनुष हाथ से फिसल रहा है और त्वचा जल रही है।',
    'Main kaanp raha hoon. Baanhon ke roye khade ho gaye hain. Dhanush haath se phisal raha hai aur twacha jal rahi hai.',
    'Four things, listed one after another, none of which he chose.',
    'चार चीज़ें, एक के बाद एक गिनाई गईं, और इनमें से कोई भी उसने चुनी नहीं।',
    'Chaar cheezein, ek ke baad ek ginayi gayin, aur inme se koi bhi usne chuni nahi.',
    'beginner',
    'Gita 1.29: shaking, burning skin, a bow that will not stay held',
    'The Bhagavad Gita lists what is happening in Arjuna''s body one item at a time. A description written down long before anybody had a name for it.',
    1

  UNION ALL SELECT 30, 30, 1, 'gita-1-30',
    'न च शक्नोम्यवस्थातुं भ्रमतीव च मे मनः।\nनिमित्तानि च पश्यामि विपरीतानि केशव॥',
    'na ca śaknomy avasthātuṁ bhramatīva ca me manaḥ\nnimittāni ca paśyāmi viparītāni keśava',
    'na cha shaknomy avasthatum bhramativa cha me manah\nnimittani cha pashyami viparitani keshava',
    'I am not able to stand, and my mind seems to be whirling. I see signs that point the wrong way, O Keshava.',
    'I cannot stay standing. My mind is going round and round. And everything I look at seems to be pointing the wrong way.',
    'मैं खड़ा नहीं रह पा रहा। मन गोल-गोल घूम रहा है। और जिस भी चीज़ को देखता हूँ वह उलटी दिशा में इशारा करती लगती है।',
    'Main khada nahi reh pa raha. Man gol-gol ghoom raha hai. Aur jis bhi cheez ko dekhta hoon woh ulti disha mein ishara karti lagti hai.',
    'Not able to stand, and the world has started confirming it. Both are in one line.',
    'खड़ा नहीं रह पा रहा, और दुनिया इसकी पुष्टि करने लगी है। दोनों एक ही पंक्ति में हैं।',
    'Khada nahi reh pa raha, aur duniya iski pushti karne lagi hai. Dono ek hi line mein hain.',
    'beginner',
    'Gita 1.30: the mind whirling, and the world agreeing with it',
    'Arjuna cannot stand up and everything he looks at seems to confirm the worst. The Bhagavad Gita puts both halves of that in a single line.',
    1

  UNION ALL SELECT 31, 31, 1, 'gita-1-31',
    'न च श्रेयोऽनुपश्यामि हत्वा स्वजनमाहवे।\nन काङ्क्षे विजयं कृष्ण न च राज्यं सुखानि च॥',
    'na ca śreyo ''nupaśyāmi hatvā svajanam āhave\nna kāṅkṣe vijayaṁ kṛṣṇa na ca rājyaṁ sukhāni ca',
    'na cha shreyo nupashyami hatva svajanam ahave\nna kankshe vijayam krishna na cha rajyam sukhani cha',
    'I do not see any good coming from killing my own people in battle. I do not want victory, Krishna, nor a kingdom, nor pleasures.',
    'I cannot see any good coming out of this. I do not want the win. I do not want what the win gets me.',
    'मुझे इसमें से कोई भलाई निकलती नहीं दिखती। मुझे जीत नहीं चाहिए। जीत से जो मिलेगा वह भी नहीं चाहिए।',
    'Mujhe isme se koi bhalai nikalti nahi dikhti. Mujhe jeet nahi chahiye. Jeet se jo milega woh bhi nahi chahiye.',
    'Now the reasons arrive. They arrived second, and they are good reasons.',
    'अब वजहें आती हैं। वे दूसरे नंबर पर आईं, और वे अच्छी वजहें हैं।',
    'Ab wajahein aati hain. Woh doosre number par aayin, aur woh achhi wajahein hain.',
    'beginner',
    'Gita 1.31: the reasons arrive after the body, and they are good ones',
    'Arjuna gives his argument only after his legs have already gone. The Bhagavad Gita is careful about that order, and the argument is not a bad one.',
    1

  UNION ALL SELECT 32, 32, 1, 'gita-1-32',
    'किं नो राज्येन गोविन्द किं भोगैर्जीवितेन वा।\nयेषामर्थे काङ्क्षितं नो राज्यं भोगाः सुखानि च॥',
    'kiṁ no rājyena govinda kiṁ bhogair jīvitena vā\nyeṣām arthe kāṅkṣitaṁ no rājyaṁ bhogāḥ sukhāni ca',
    'kim no rajyena govinda kim bhogair jivitena va\nyesham arthe kankshitam no rajyam bhogah sukhani cha',
    'What is a kingdom to us, Govinda, what are pleasures, or even life itself — when the very people for whose sake we wanted a kingdom, pleasures and happiness are standing here?',
    'What is any of it for? The kingdom, the comfort, life itself. The people it was all supposed to be for are the ones standing in front of me.',
    'यह सब है किसलिए? राज्य, आराम, ख़ुद यह जीवन। जिनके लिए यह सब होना था, वही तो सामने खड़े हैं।',
    'Yeh sab hai kisliye? Rajya, aaram, khud yeh jeevan. Jinke liye yeh sab hona tha, wahi to saamne khade hain.',
    'The question is not whether he can win. It is what winning would be for.',
    'सवाल यह नहीं है कि वह जीत सकता है या नहीं। सवाल यह है कि जीतना किसलिए होगा।',
    'Sawal yeh nahi hai ki woh jeet sakta hai ya nahi. Sawal yeh hai ki jeetna kisliye hoga.',
    'beginner',
    'Gita 1.32: what would winning even be for',
    'Arjuna asks what a kingdom is worth when the people it was meant for are the ones on the other side. The Bhagavad Gita lets the question stand.',
    1

  UNION ALL SELECT 38, 38, 1, 'gita-1-38',
    'यद्यप्येते न पश्यन्ति लोभोपहतचेतसः।\nकुलक्षयकृतं दोषं मित्रद्रोहे च पातकम्॥',
    'yady apy ete na paśyanti lobhopahata-cetasaḥ\nkula-kṣaya-kṛtaṁ doṣaṁ mitra-drohe ca pātakam',
    'yady apy ete na pashyanti lobhopahata-chetasah\nkula-kshaya-kritam dosham mitra-drohe cha patakam',
    'Even if these men, their understanding overpowered by greed, do not see the wrong done by destroying a family and the crime in betraying friends —',
    'Say they cannot see it. Their judgement has been taken over by wanting, so they do not see what breaking a family does, or what betraying a friend is.',
    'मान लीजिए उन्हें दिखता ही नहीं। उनकी समझ पर चाह क़ब्ज़ा कर चुकी है, तो उन्हें यह नहीं दिखता कि परिवार तोड़ने से क्या होता है, या दोस्त से दग़ा करना क्या होता है।',
    'Maan lijiye unhe dikhta hi nahi. Unki samajh par chaah kabza kar chuki hai, to unhe yeh nahi dikhta ki parivar todne se kya hota hai, ya dost se daga karna kya hota hai.',
    'He has just given himself the better eyesight of the two sides. Watch how fast that happened.',
    'उसने अभी-अभी दोनों पक्षों में बेहतर नज़र ख़ुद को दे दी। देखिए यह कितनी जल्दी हुआ।',
    'Usne abhi abhi dono pakshon mein behtar nazar khud ko de di. Dekho yeh kitni jaldi hua.',
    'beginner',
    'Gita 1.38: they cannot see it, and I can',
    'Arjuna explains that the other side is blinded by greed while he is not. The Bhagavad Gita records the move without commenting on it.',
    1

  UNION ALL SELECT 46, 46, 1, 'gita-1-46',
    'यदि मामप्रतीकारमशस्त्रं शस्त्रपाणयः।\nधार्तराष्ट्रा रणे हन्युस्तन्मे क्षेमतरं भवेत्॥',
    'yadi mām apratīkāram aśastraṁ śastra-pāṇayaḥ\ndhārtarāṣṭrā raṇe hanyus tan me kṣemataraṁ bhavet',
    'yadi mam apratikaram ashastram shastra-panayah\ndhartarashtra rane hanyus tan me kshemataram bhavet',
    'If the sons of Dhritarashtra, weapons in hand, were to kill me in this battle while I was unarmed and offering no resistance, that would be better for me.',
    'If they came at me armed, and I put nothing down in front of them and did not lift a hand, and it ended there — that would be the better outcome.',
    'अगर वे हथियार लिए मेरी तरफ़ आएँ, और मैं उनके आगे कुछ न रखूँ और हाथ भी न उठाऊँ, और बात वहीं ख़त्म हो जाए — वह बेहतर होगा।',
    'Agar woh hathiyar liye meri taraf aayein, aur main unke aage kuch na rakhoon aur haath bhi na uthaoon, aur baat wahin khatam ho jaaye — woh behtar hoga.',
    'This is the sentence despair produces. The book writes it down. It does not agree with it.',
    'यह वह वाक्य है जो हताशा बनाती है। किताब उसे लिख लेती है। उससे सहमत नहीं होती।',
    'Yeh woh vakya hai jo hataasha banati hai. Kitaab use likh leti hai. Usse sehmat nahi hoti.',
    'beginner',
    'Gita 1.46: the sentence despair produces, written down and not granted',
    'Arjuna says it would be better if it simply ended. The Bhagavad Gita records the sentence, never returns to it, and what happens next is that somebody stays.',
    1

  UNION ALL SELECT 47, 47, 1, 'gita-1-47',
    'एवमुक्त्वार्जुनः सङ्ख्ये रथोपस्थ उपाविशत्।\nविसृज्य सशरं चापं शोकसंविग्नमानसः॥',
    'evam uktvārjunaḥ saṅkhye rathopastha upāviśat\nvisṛjya sa-śaraṁ cāpaṁ śoka-saṁvigna-mānasaḥ',
    'evam uktvarjunah sankhye rathopastha upavishat\nvisrijya sa-sharam chapam shoka-samvigna-manasah',
    'Having spoken thus, Arjuna sat down on the seat of the chariot in the middle of the battle, letting go of his bow and arrows, his mind overwhelmed with sorrow.',
    'Having said all that, he sat down. In the middle of it. He let the bow and the arrows go, and his mind was overrun with grief.',
    'यह सब कहकर वह बैठ गया। बीचोंबीच। उसने धनुष और बाण छोड़ दिए, और उसका मन शोक से भर गया था।',
    'Yeh sab kehkar woh baith gaya. Beechonbeech. Usne dhanush aur baan chhod diye, aur uska man shok se bhar gaya tha.',
    'Nobody calls him weak. That absence is the most important thing on the page.',
    'कोई उसे कमज़ोर नहीं कहता। पन्ने पर सबसे ज़रूरी चीज़ यही ग़ैरहाज़िरी है।',
    'Koi use kamzor nahi kehta. Panne par sabse zaroori cheez yahi gairhazri hai.',
    'beginner',
    'Gita 1.47: he sits down, and the text does not call him weak',
    'The first chapter of the Bhagavad Gita ends with a man putting his weapons down and sitting on the floor of his chariot. Nobody in the text calls it cowardice.',
    1

) AS v
JOIN chapters c ON c.chapter_number = 1;

-- =====================================================================
-- 2. EXPLANATIONS
-- =====================================================================
-- Every verse gets a beginner depth, because the default reader is who
-- lands on the page — and on this chapter more than any other, the
-- reader who lands on the page may be having a bad day.
--
-- Three sets of sentences are load-bearing and smoke-test.sh asserts
-- all of them on the DEFAULT render rather than at a named level:
--   1.28  "a description and not a diagnosis"
--   1.46  "the text does not agree with it" + "somebody stays"
--         + the sentence that points at a person rather than a chapter
--   1.47  "nobody in the text calls him weak"
-- =====================================================================

DELETE ve FROM verse_explanations ve JOIN verses v ON v.id = ve.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 1;

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 28 AS vn, 'beginner' AS level,
   'Twenty-seven verses of the chapter have been armies, conches and names. This is the first sentence Arjuna speaks about himself, and it is the first thing in the book that is about a person rather than a situation.' AS h_en,
   'अध्याय के सत्ताईस श्लोक सेनाओं, शंखों और नामों के रहे हैं। यह पहला वाक्य है जो अर्जुन अपने बारे में कहते हैं, और किताब में यह पहली चीज़ है जो हालात के बारे में नहीं, एक इंसान के बारे में है।' AS h_hi,
   'Adhyay ke sattais shlok senaon, shankhon aur naamon ke rahe hain. Yeh pehla vakya hai jo Arjun apne baare mein kehte hain, aur kitaab mein yeh pehli cheez hai jo haalat ke baare mein nahi, ek insaan ke baare mein hai.' AS h_hing,
   'Notice the order. He sees, and then his legs go and his mouth dries. No argument has been made yet. Nothing has been decided. The body has already answered and the reasons are still three verses away.' AS p_en,
   'क्रम पर ध्यान दीजिए। वह देखता है, और फिर उसके पैर जवाब देते हैं और मुँह सूखता है। अभी कोई दलील नहीं दी गई है। कुछ तय नहीं हुआ है। शरीर जवाब दे चुका है और वजहें अभी तीन श्लोक दूर हैं।' AS p_hi,
   'Kram par dhyan do. Woh dekhta hai, aur phir uske pair jawab dete hain aur munh sookhta hai. Abhi koi dalil nahi di gayi hai. Kuch tay nahi hua hai. Sharir jawab de chuka hai aur wajahein abhi teen shloka door hain.' AS p_hing,
   'People recognise themselves here, and that is worth something. It is worth saying carefully what it is not. This is a description of one man on one afternoon, not a claim about what is happening in anybody''s body now, and this book is not treatment for anything. If you have been standing somewhere and found your mouth dry before you knew why, you have met this verse and that is all that means.' AS m_en,
   'लोग यहाँ ख़ुद को पहचानते हैं, और इसका मोल है। इसका मोल इतना ज़रूर है कि साफ़ कहा जाए यह क्या नहीं है। यह एक आदमी का, एक दोपहर का वर्णन है — इस बारे में दावा नहीं कि अभी किसी के शरीर में क्या हो रहा है, और यह किताब किसी चीज़ का इलाज नहीं है। अगर आप कहीं खड़े रहे हों और वजह जानने से पहले मुँह सूख गया हो, तो आप इस श्लोक से मिल चुके हैं, और इसका मतलब बस इतना है।' AS m_hi,
   'Log yahan khud ko pehchante hain, aur iska mol hai. Iska mol itna zaroor hai ki saaf kaha jaaye yeh kya nahi hai. Yeh ek aadmi ka, ek dopahar ka varnan hai — is baare mein dawa nahi ki abhi kisi ke sharir mein kya ho raha hai, aur yeh kitaab kisi cheez ka ilaaj nahi hai. Agar tum kahin khade rahe ho aur wajah jaanne se pehle munh sookh gaya ho, to tum is shloka se mil chuke ho, aur iska matlab bas itna hai.' AS m_hing

  UNION ALL SELECT 29, 'beginner',
   'The list continues, and it is a list — four separate things, named one at a time, with nothing joining them into a single word. No language available to him had one.',
   'सूची चलती रहती है, और यह सूची ही है — चार अलग चीज़ें, एक-एक करके नाम ली गईं, और उन्हें एक शब्द में जोड़ने वाला कुछ नहीं है। उसके पास मौजूद किसी भाषा में वह एक शब्द था ही नहीं।',
   'Soochi chalti rehti hai, aur yeh soochi hi hai — chaar alag cheezein, ek ek karke naam li gayin, aur unhe ek shabd mein jodne wala kuch nahi hai. Uske paas maujood kisi bhasha mein woh ek shabd tha hi nahi.',
   'The bow is the detail to stop at. Gāṇḍīva is the most famous weapon in the story and it belongs to the best archer alive. It is sliding out of his hand, and there is nothing he can do about that, and the verse does not pretend otherwise.',
   'रुकने लायक़ ब्यौरा धनुष है। गांडीव कहानी का सबसे मशहूर हथियार है और वह ज़िंदा सबसे बड़े धनुर्धर का है। वह उसके हाथ से फिसल रहा है, और वह इसके बारे में कुछ नहीं कर सकता, और श्लोक कोई बहाना नहीं बनाता।',
   'Rukne layak byora dhanush hai. Gandiv kahani ka sabse mashhoor hathiyar hai aur woh zinda sabse bade dhanurdhar ka hai. Woh uske haath se phisal raha hai, aur woh iske baare mein kuch nahi kar sakta, aur shloka koi bahana nahi banata.',
   'The reason a list works better here than a single word is that a list can be checked. Anybody can look at their own four things. A single word invites a person to decide what they are, which is a much bigger claim and a worse one to make about yourself on a bad afternoon.',
   'यहाँ एक शब्द से बेहतर सूची इसलिए काम करती है क्योंकि सूची जाँची जा सकती है। कोई भी अपनी चार चीज़ें देख सकता है। एक शब्द इंसान को यह तय करने को कहता है कि वह है क्या, जो कहीं बड़ा दावा है और किसी बुरी दोपहर में अपने बारे में करने के लिए कहीं ख़राब दावा है।',
   'Yahan ek shabd se behtar soochi isliye kaam karti hai kyunki soochi jaanchi ja sakti hai. Koi bhi apni chaar cheezein dekh sakta hai. Ek shabd insaan ko yeh tay karne ko kehta hai ki woh hai kya, jo kahin bada dawa hai aur kisi buri dopahar mein apne baare mein karne ke liye kahin kharab dawa hai.'

  UNION ALL SELECT 30, 'beginner',
   'The last of the three body verses, and the one that crosses over into the mind. Bhramati is a word for spinning — a wheel, a top, something going round on its own axis without going anywhere.',
   'शरीर वाले तीन श्लोकों में आख़िरी, और वही जो मन की तरफ़ पार करता है। भ्रमति घूमने का शब्द है — पहिया, लट्टू, कोई चीज़ जो अपनी ही धुरी पर घूमती रहे और कहीं जाए नहीं।',
   'Sharir wale teen shlokon mein aakhiri, aur wahi jo man ki taraf paar karta hai. Bhramati ghoomne ka shabd hai — pahiya, lattu, koi cheez jo apni hi dhuri par ghoomti rahe aur kahin jaaye nahi.',
   'Then the second half, which is easy to read past: I see signs pointing the wrong way. Everything he looks at has begun agreeing with him. That is a different claim from the first half and the verse puts them together on purpose.',
   'फिर दूसरा आधा, जिसे पढ़ते हुए निकल जाना आसान है: मुझे उलटी दिशा में इशारा करते संकेत दिख रहे हैं। जिस भी चीज़ को वह देखता है वह उससे सहमत होने लगी है। यह पहले आधे से अलग दावा है और श्लोक दोनों को जानबूझकर साथ रखता है।',
   'Phir doosra aadha, jise padhte hue nikal jaana aasan hai: mujhe ulti disha mein ishara karte sanket dikh rahe hain. Jis bhi cheez ko woh dekhta hai woh usse sehmat hone lagi hai. Yeh pehle aadhe se alag dawa hai aur shloka dono ko jaanboojhkar saath rakhta hai.',
   'This is the most useful line in the chapter for ordinary use, because it names something people rarely catch in themselves: when you are already down, the evidence starts arriving. The traffic, the message that went unanswered, the look somebody gave you. None of it is manufactured and none of it would have been evidence yesterday.',
   'रोज़ के इस्तेमाल के लिए यह अध्याय की सबसे काम की पंक्ति है, क्योंकि यह उस चीज़ का नाम लेती है जिसे लोग अपने भीतर कम ही पकड़ पाते हैं: जब आप पहले से गिरे हुए हों, तब सबूत आने लगते हैं। ट्रैफ़िक, वह संदेश जिसका जवाब नहीं आया, किसी की वह नज़र। इनमें से कुछ भी गढ़ा हुआ नहीं है और इनमें से कुछ भी कल सबूत नहीं होता।',
   'Roz ke istemaal ke liye yeh adhyay ki sabse kaam ki line hai, kyunki yeh us cheez ka naam leti hai jise log apne bheetar kam hi pakad paate hain: jab tum pehle se gire hue ho, tab saboot aane lagte hain. Traffic, woh message jiska jawab nahi aaya, kisi ki woh nazar. Inme se kuch bhi gadha hua nahi hai aur inme se kuch bhi kal saboot nahi hota.'

  UNION ALL SELECT 31, 'beginner',
   'Here the speech turns. Everything before this was report; from here on it is argument, and it runs for fifteen verses without a break.',
   'यहाँ भाषण मुड़ता है। इससे पहले सब कुछ ब्यौरा था; यहाँ से आगे दलील है, और वह पंद्रह श्लोक तक बिना रुके चलती है।',
   'Yahan bhashan mudta hai. Isse pehle sab kuch byora tha; yahan se aage dalil hai, aur woh pandrah shloka tak bina ruke chalti hai.',
   'The order matters and it is the whole reason this verse is on the page. The legs went in 1.28. The argument starts in 1.31. Whatever else is true, the reasons did not cause the collapse, because they arrived after it.',
   'क्रम मायने रखता है और यही पूरी वजह है कि यह श्लोक यहाँ है। पैर 1.28 में गए। दलील 1.31 में शुरू होती है। और चाहे जो भी सच हो, वजहों ने ढहना पैदा नहीं किया, क्योंकि वे उसके बाद आईं।',
   'Kram maayne rakhta hai aur yahi poori wajah hai ki yeh shloka yahan hai. Pair 1.28 mein gaye. Dalil 1.31 mein shuru hoti hai. Aur chahe jo bhi sach ho, wajahon ne dhehna paida nahi kiya, kyunki woh uske baad aayin.',
   'And here is the part that makes the chapter worth reading rather than diagnosing: the argument is good. Killing your own family to win a throne is a bad way to spend a life, and he is right about that, and seventeen chapters later nobody has told him he was wrong about it. What he is wrong about is something else entirely, and the book takes its time getting there. A reason that arrives after the fact is not automatically a bad reason. It is just not the cause.',
   'और यहीं वह हिस्सा है जो इस अध्याय को निदान करने लायक़ नहीं, पढ़ने लायक़ बनाता है: दलील अच्छी है। सिंहासन के लिए अपने ही परिवार को मारना ज़िंदगी बिताने का बुरा तरीक़ा है, और इस बारे में वह सही है, और सत्रह अध्याय बाद भी किसी ने उसे यह नहीं कहा कि वह इस बारे में ग़लत था। वह जिस बारे में ग़लत है वह बिलकुल कुछ और है, और किताब वहाँ पहुँचने में वक़्त लेती है। बाद में आई वजह अपने आप बुरी वजह नहीं हो जाती। वह बस कारण नहीं होती।',
   'Aur yahin woh hissa hai jo is adhyay ko nidan karne layak nahi, padhne layak banata hai: dalil achhi hai. Sinhasan ke liye apne hi parivar ko maarna zindagi bitane ka bura tareeka hai, aur is baare mein woh sahi hai, aur satrah adhyay baad bhi kisi ne use yeh nahi kaha ki woh is baare mein galat tha. Woh jis baare mein galat hai woh bilkul kuch aur hai, aur kitaab wahan pahunchne mein waqt leti hai. Baad mein aayi wajah apne aap buri wajah nahi ho jaati. Woh bas kaaran nahi hoti.'

  UNION ALL SELECT 32, 'beginner',
   'The kingdom is not an abstraction here. It is the specific thing the whole war is nominally about, and he has spent thirteen years in exile to get to the point of being able to fight for it.',
   'यहाँ राज्य कोई कल्पना नहीं है। यह वही ख़ास चीज़ है जिसके नाम पर पूरा युद्ध है, और वह तेरह साल वनवास में बिता चुका है ताकि इसके लिए लड़ पाने की जगह तक पहुँचे।',
   'Yahan rajya koi kalpana nahi hai. Yeh wahi khaas cheez hai jiske naam par poora yuddh hai, aur woh terah saal vanvaas mein bita chuka hai taaki iske liye lad paane ki jagah tak pahunche.',
   'The question is not "can I win" and it is not "is this allowed". It is "what would winning be for". Every answer he had to that question is currently standing on the other side of the field in armour.',
   'सवाल न "क्या मैं जीत सकता हूँ" है और न "क्या इसकी इजाज़त है"। सवाल है "जीतना किसलिए होगा"। उस सवाल के उसके पास जितने जवाब थे, वे सब इस वक़्त कवच पहने मैदान के दूसरी तरफ़ खड़े हैं।',
   'Sawal na "kya main jeet sakta hoon" hai aur na "kya iski ijazat hai". Sawal hai "jeetna kisliye hoga". Us sawal ke uske paas jitne jawab the, woh sab is waqt kavach pehne maidan ke doosri taraf khade hain.',
   'People arrive at this question from directions that have nothing to do with a war. The promotion that was for a marriage that has since ended. The house that was for a person who has since gone. The thing itself is unchanged and completely intact and has quietly stopped being for anything. That is a real problem and the verse does not pretend it is a small one — it takes the rest of the book to answer, and the answer is not "it was for you all along".',
   'लोग इस सवाल तक ऐसी दिशाओं से पहुँचते हैं जिनका किसी युद्ध से कोई लेना-देना नहीं। वह तरक़्क़ी जो एक शादी के लिए थी जो अब नहीं रही। वह घर जो एक इंसान के लिए था जो अब नहीं है। चीज़ ख़ुद वैसी की वैसी है, पूरी तरह सलामत, और चुपचाप किसी के लिए होना बंद कर चुकी है। यह असली समस्या है और श्लोक इसे छोटा नहीं बताता — इसका जवाब देने में बाक़ी पूरी किताब लगती है, और जवाब यह नहीं है कि "वह हमेशा से तुम्हारे लिए ही थी"।',
   'Log is sawal tak aisi dishaon se pahunchte hain jinka kisi yuddh se koi lena dena nahi. Woh tarakki jo ek shaadi ke liye thi jo ab nahi rahi. Woh ghar jo ek insaan ke liye tha jo ab nahi hai. Cheez khud waisi ki waisi hai, poori tarah salamat, aur chupchap kisi ke liye hona band kar chuki hai. Yeh asli samasya hai aur shloka ise chhota nahi batata — iska jawab dene mein baaki poori kitaab lagti hai, aur jawab yeh nahi hai ki "woh hamesha se tumhare liye hi thi".'

  UNION ALL SELECT 38, 'beginner',
   'By this point the argument has been running for seven verses and has begun to widen. It will widen further, into territory this file deliberately does not cover — see the header.',
   'यहाँ तक आते-आते दलील सात श्लोक चल चुकी है और फैलने लगी है। वह और फैलेगी, ऐसे इलाक़े में जिसे यह फ़ाइल जानबूझकर नहीं छूती — हेडर देखिए।',
   'Yahan tak aate aate dalil saat shloka chal chuki hai aur phailne lagi hai. Woh aur phailegi, aise ilaake mein jise yeh file jaanboojhkar nahi chhoti — header dekho.',
   'Read the sentence slowly. Their judgement has been taken over by wanting, so they cannot see the wrong. Mine has not, so I can. Nothing in the line says the second half out loud, and the second half is the whole point of the first.',
   'वाक्य धीरे पढ़िए। उनकी समझ पर चाह क़ब्ज़ा कर चुकी है, इसलिए उन्हें ग़लत दिखता नहीं। मेरी पर नहीं, इसलिए मुझे दिखता है। पंक्ति में दूसरा आधा ज़ोर से कहीं कहा नहीं गया, और पहले आधे का पूरा मक़सद वही दूसरा आधा है।',
   'Vakya dheere padho. Unki samajh par chaah kabza kar chuki hai, isliye unhe galat dikhta nahi. Meri par nahi, isliye mujhe dikhta hai. Line mein doosra aadha zor se kahin kaha nahi gaya, aur pehle aadhe ka poora maksad wahi doosra aadha hai.',
   'This is the most ordinary move in the chapter and the easiest one to catch yourself making, because it takes about a second and feels like observation. The other side is not thinking clearly. I am. Anybody who has been in a bad argument at work or at home has done it, usually while genuinely upset and usually with some evidence. The book does not stop to tell him off for it. It just puts it on the page, in his own voice, immediately after the part where he could not stand up.',
   'यह अध्याय की सबसे आम चाल है और अपने भीतर पकड़ने में सबसे आसान, क्योंकि इसमें एक सेकंड लगता है और यह टिप्पणी नहीं, अवलोकन जैसा लगता है। दूसरी तरफ़ साफ़ नहीं सोच रही। मैं सोच रहा हूँ। जिसका भी दफ़्तर में या घर में कोई बुरा झगड़ा हुआ है उसने यह किया है, आमतौर पर सचमुच परेशान होते हुए और आमतौर पर कुछ सबूत के साथ। किताब उसे इसके लिए डाँटने रुकती नहीं। वह बस इसे पन्ने पर रख देती है, उसी की आवाज़ में, ठीक उस हिस्से के बाद जहाँ वह खड़ा नहीं हो पा रहा था।',
   'Yeh adhyay ki sabse aam chaal hai aur apne bheetar pakadne mein sabse aasan, kyunki isme ek second lagta hai aur yeh tippani nahi, avlokan jaisa lagta hai. Doosri taraf saaf nahi soch rahi. Main soch raha hoon. Jiska bhi daftar mein ya ghar mein koi bura jhagda hua hai usne yeh kiya hai, aam taur par sach mein pareshan hote hue aur aam taur par kuch saboot ke saath. Kitaab use iske liye daantne rukti nahi. Woh bas ise panne par rakh deti hai, usi ki aawaz mein, theek us hisse ke baad jahan woh khada nahi ho pa raha tha.'

  UNION ALL SELECT 46, 'beginner',
   'The last thing Arjuna says in the chapter. After this there is one verse of narration and then chapter 2 begins.',
   'अध्याय में अर्जुन की कही आख़िरी बात। इसके बाद एक श्लोक वर्णन का है और फिर दूसरा अध्याय शुरू हो जाता है।',
   'Adhyay mein Arjun ki kahi aakhiri baat. Iske baad ek shloka varnan ka hai aur phir doosra adhyay shuru ho jaata hai.',
   'The word is kṣemataram — better, safer, more at ease. He is not asking for anything and he is not threatening anything. He is comparing two futures and reporting which one looks lighter from where he is sitting. That is what makes it recognisable rather than dramatic.',
   'शब्द है क्षेमतरम् — बेहतर, ज़्यादा सुरक्षित, ज़्यादा हल्का। वह कुछ माँग नहीं रहा और किसी चीज़ की धमकी नहीं दे रहा। वह दो भविष्यों की तुलना कर रहा है और बता रहा है कि जहाँ वह बैठा है वहाँ से कौन-सा हल्का दिखता है। यही इसे नाटकीय नहीं, पहचाना हुआ बनाता है।',
   'Shabd hai kshemataram — behtar, zyada surakshit, zyada halka. Woh kuch maang nahi raha aur kisi cheez ki dhamki nahi de raha. Woh do bhavishyon ki tulna kar raha hai aur bata raha hai ki jahan woh baitha hai wahan se kaun sa halka dikhta hai. Yahi ise natakiya nahi, pehchana hua banata hai.',
   'Three things have to be said here and none of them can be left out. The first: the line is not softened, because despair does talk like this and the text is unusual in writing the sentence down instead of tidying it away. The second: the text does not agree with it. Recording a sentence is not granting it, and in seventeen chapters nothing returns to this one, treats it as a plan, or takes it up — what actually happens next is the smallest thing in the book, which is that somebody stays and keeps talking to him. The third, and it is the one that matters most: if that sentence is a live one for you rather than a line in a book, what helps is a person and not a chapter. A book agreeing with you is not what anybody needs at that point, and this one does not.',
   'यहाँ तीन बातें कहनी हैं और इनमें से कोई छोड़ी नहीं जा सकती। पहली: पंक्ति नरम नहीं की गई है, क्योंकि हताशा ऐसे ही बोलती है और यह ग्रंथ इस मायने में अलग है कि उसने वाक्य को समेटने के बजाय लिख लिया। दूसरी: ग्रंथ इससे सहमत नहीं है। किसी वाक्य को दर्ज करना उसे मंज़ूरी देना नहीं है, और सत्रह अध्यायों में कुछ भी इस वाक्य पर लौटता नहीं, इसे योजना की तरह नहीं लेता, इसे उठाता नहीं — आगे जो असल में होता है वह किताब की सबसे छोटी चीज़ है, यानी कोई रुकता है और उससे बात करता रहता है। तीसरी, और सबसे ज़रूरी: अगर वह वाक्य आपके लिए किताब की पंक्ति नहीं, ज़िंदा वाक्य है, तो मदद किसी इंसान से मिलती है, किसी अध्याय से नहीं। उस जगह पर किसी को इसकी ज़रूरत नहीं होती कि कोई किताब उससे सहमत हो जाए, और यह किताब होती भी नहीं।',
   'Yahan teen baatein kehni hain aur inme se koi chhodi nahi ja sakti. Pehli: line naram nahi ki gayi hai, kyunki hataasha aise hi bolti hai aur yeh granth is maayne mein alag hai ki usne vakya ko sametne ke bajaye likh liya. Doosri: granth isse sehmat nahi hai. Kisi vakya ko darj karna use manzoori dena nahi hai, aur satrah adhyayon mein kuch bhi is vakya par lautta nahi, ise yojna ki tarah nahi leta, ise uthata nahi — aage jo asal mein hota hai woh kitaab ki sabse chhoti cheez hai, yani koi rukta hai aur usse baat karta rehta hai. Teesri, aur sabse zaroori: agar woh vakya tumhare liye kitaab ki line nahi, zinda vakya hai, to madad kisi insaan se milti hai, kisi adhyay se nahi. Us jagah par kisi ko iski zaroorat nahi hoti ki koi kitaab usse sehmat ho jaaye, aur yeh kitaab hoti bhi nahi.'

  UNION ALL SELECT 47, 'beginner',
   'Sañjaya is narrating the whole thing to a blind king many miles away. This is his line, not Arjuna''s, and it is the last verse of the chapter.',
   'संजय यह सब कई मील दूर बैठे एक अंधे राजा को सुना रहे हैं। यह पंक्ति उनकी है, अर्जुन की नहीं, और यह अध्याय का आख़िरी श्लोक है।',
   'Sanjay yeh sab kai meel door baithe ek andhe raja ko suna rahe hain. Yeh line unki hai, Arjun ki nahi, aur yeh adhyay ka aakhiri shloka hai.',
   'Read what Sañjaya does not do. He does not call it cowardice. He does not call it weakness or a failure of nerve or unbecoming of a warrior. He reports a man sitting down, letting go of a bow, and being overrun by grief, and then the chapter ends.',
   'देखिए संजय क्या नहीं करते। वे इसे कायरता नहीं कहते। वे इसे कमज़ोरी, हिम्मत का टूटना या किसी योद्धा के लिए अशोभनीय नहीं कहते। वे एक आदमी के बैठ जाने, धनुष छोड़ देने और शोक से भर जाने का ब्यौरा देते हैं, और फिर अध्याय ख़त्म हो जाता है।',
   'Dekho Sanjay kya nahi karte. Woh ise kayarta nahi kehte. Woh ise kamzori, himmat ka tootna ya kisi yoddha ke liye ashobhaniya nahi kehte. Woh ek aadmi ke baith jaane, dhanush chhod dene aur shok se bhar jaane ka byora dete hain, aur phir adhyay khatam ho jaata hai.',
   'That absence is the most important thing on the page, and it is worth holding on to, because chapter 2 opens with a challenge and gets quoted very often as though the whole book despises this moment. It does not. The last verse of chapter 1 is the evidence: the collapse is recorded at full length, in detail, with the bow and the sitting and the grief all named, and nobody in the text calls him weak. Everything the book goes on to say is said to a man on the floor of his chariot, and it is said to him rather than about him.',
   'पन्ने पर सबसे ज़रूरी चीज़ यही ग़ैरहाज़िरी है, और इसे थामे रखना काम आता है, क्योंकि दूसरा अध्याय एक ललकार से शुरू होता है और अक्सर ऐसे उद्धृत किया जाता है जैसे पूरी किताब इस पल से घृणा करती हो। नहीं करती। पहले अध्याय का आख़िरी श्लोक सबूत है: ढहना पूरा दर्ज है, ब्यौरे के साथ, धनुष, बैठना और शोक सब नाम लेकर, और ग्रंथ में कोई उसे कमज़ोर नहीं कहता। किताब आगे जो कुछ कहती है वह अपने रथ के फ़र्श पर बैठे एक आदमी से कहा जाता है, और उसके बारे में नहीं, उससे कहा जाता है।',
   'Panne par sabse zaroori cheez yahi gairhazri hai, aur ise thaame rakhna kaam aata hai, kyunki doosra adhyay ek lalkaar se shuru hota hai aur aksar aise uddhrit kiya jaata hai jaise poori kitaab is pal se ghrina karti ho. Nahi karti. Pehle adhyay ka aakhiri shloka saboot hai: dhehna poora darj hai, byore ke saath, dhanush, baithna aur shok sab naam lekar, aur granth mein koi use kamzor nahi kehta. Kitaab aage jo kuch kehti hai woh apne rath ke farsh par baithe ek aadmi se kaha jaata hai, aur uske baare mein nahi, usse kaha jaata hai.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 1;

-- =====================================================================
-- 3. HOOKS, REFLECTIONS, PRACTICES, TOPICS
-- =====================================================================
-- NO PRACTICE IN THIS FILE ASKS A READER TO SIT ALONE WITH THE WORST OF
-- IT. Chapter 1 is the one place in the corpus where a practice could
-- do harm by being introspective, so the 1.30, 1.46 and 1.47 practices
-- all point outward — at a room, at a person, at a piece of paper that
-- gets handed to somebody. The 1.46 practice is the only one in the
-- whole corpus that names another human being as the required step.
--
-- No reflection here asks the reader to rate, diagnose or explain
-- themselves, and none of them asks "why do you feel this way".
-- =====================================================================

DELETE m FROM verse_memory_aids m JOIN verses v ON v.id = m.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 1;
DELETE r FROM verse_reflections r JOIN verses v ON v.id = r.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 1;
DELETE p FROM verse_practices p JOIN verses v ON v.id = p.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 1;
DELETE vt FROM verse_topics vt JOIN verses v ON v.id = vt.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 1;

INSERT INTO verse_memory_aids (verse_id, hook_en, hook_hi, hook_hinglish, analogy_en, analogy_hi, analogy_hinglish, visual_cue)
SELECT v.id, m.h_en, m.h_hi, m.h_hing, m.a_en, m.a_hi, m.a_hing, m.cue FROM (
  SELECT 28 AS vn,
  'The body answered first. The argument is still three verses away.' AS h_en,
  'जवाब पहले शरीर ने दिया। दलील अभी तीन श्लोक दूर है।' AS h_hi,
  'Jawab pehle sharir ne diya. Dalil abhi teen shloka door hai.' AS h_hing,
  'Like standing up to speak and finding out from your own voice that you are nervous.' AS a_en,
  'बोलने के लिए खड़े होने और अपनी ही आवाज़ से यह पता चलने जैसा कि आप घबराए हुए हैं।' AS a_hi,
  'Bolne ke liye khade hone aur apni hi aawaz se yeh pata chalne jaisa ki tum ghabraye hue ho.' AS a_hing,
  'A glass of water nobody picked up' AS cue

  UNION ALL SELECT 29,
  'Four things, named one at a time. Not one word covering all of them.',
  'चार चीज़ें, एक-एक करके नाम ली गईं। एक भी शब्द ऐसा नहीं जो सबको ढक ले।',
  'Chaar cheezein, ek ek karke naam li gayin. Ek bhi shabd aisa nahi jo sabko dhak le.',
  'Like a doctor writing down four symptoms instead of one label. The list can be checked. The label cannot.',
  'ऐसे जैसे कोई डॉक्टर एक नाम की जगह चार लक्षण लिख दे। सूची जाँची जा सकती है। नाम नहीं।',
  'Aise jaise koi doctor ek naam ki jagah chaar lakshan likh de. Soochi jaanchi ja sakti hai. Naam nahi.',
  'A famous bow, sliding'

  UNION ALL SELECT 30,
  'The mind going round, and the world starting to agree with it.',
  'मन का गोल-गोल घूमना, और दुनिया का उससे सहमत होने लगना।',
  'Man ka gol-gol ghoomna, aur duniya ka usse sehmat hone lagna.',
  'Like a bad morning where the bus is late and the phone dies. None of it is invented. None of it was evidence yesterday.',
  'उस बुरी सुबह जैसी जहाँ बस देर से आती है और फ़ोन बंद हो जाता है। कुछ भी गढ़ा हुआ नहीं है। कुछ भी कल सबूत नहीं था।',
  'Us buri subah jaisi jahan bus der se aati hai aur phone band ho jaata hai. Kuch bhi gadha hua nahi hai. Kuch bhi kal saboot nahi tha.',
  'A wheel spinning on its own axle'

  UNION ALL SELECT 31,
  'The reasons came second, and they are good reasons.',
  'वजहें दूसरे नंबर पर आईं, और वे अच्छी वजहें हैं।',
  'Wajahein doosre number par aayin, aur woh achhi wajahein hain.',
  'Like explaining afterwards why you did not go. Every sentence true, none of them the cause.',
  'बाद में यह समझाने जैसा कि आप क्यों नहीं गए। हर वाक्य सच, और उनमें से कोई भी वजह नहीं।',
  'Baad mein yeh samjhane jaisa ki tum kyun nahi gaye. Har vakya sach, aur unme se koi bhi wajah nahi.',
  'A door already closed, with a note taped to it'

  UNION ALL SELECT 32,
  'The thing is intact. It has quietly stopped being for anything.',
  'चीज़ सलामत है। वह चुपचाप किसी के लिए होना बंद कर चुकी है।',
  'Cheez salamat hai. Woh chupchap kisi ke liye hona band kar chuki hai.',
  'Like a house built for people who no longer live in it. Nothing wrong with the house.',
  'उस घर जैसा जो उन लोगों के लिए बना था जो अब उसमें नहीं रहते। घर में कोई ख़राबी नहीं है।',
  'Us ghar jaisa jo un logon ke liye bana tha jo ab usme nahi rehte. Ghar mein koi kharabi nahi hai.',
  'A set table, no chairs pulled out'

  UNION ALL SELECT 38,
  'They cannot see it. I can. That took about a second.',
  'उन्हें दिखता नहीं। मुझे दिखता है। इसमें क़रीब एक सेकंड लगा।',
  'Unhe dikhta nahi. Mujhe dikhta hai. Isme kareeb ek second laga.',
  'Like every argument where the other side is being emotional and you are being reasonable.',
  'हर उस झगड़े जैसा जिसमें दूसरा पक्ष भावुक हो रहा है और आप समझदारी दिखा रहे हैं।',
  'Har us jhagde jaisa jisme doosra paksh bhavuk ho raha hai aur tum samajhdari dikha rahe ho.',
  'Two pairs of glasses, one being handed over'

  UNION ALL SELECT 46,
  'Despair talks like this. The book wrote it down and did not agree with it.',
  'हताशा ऐसे ही बोलती है। किताब ने उसे लिख लिया और उससे सहमत नहीं हुई।',
  'Hataasha aise hi bolti hai. Kitaab ne use likh liya aur usse sehmat nahi hui.',
  'Like someone saying the worst of it out loud and the other person not leaving the room.',
  'किसी के सबसे बुरी बात ज़ोर से कह देने और सामने वाले के कमरे से न जाने जैसा।',
  'Kisi ke sabse buri baat zor se keh dene aur saamne wale ke kamre se na jaane jaisa.',
  'Two people, one room, nobody at the door'

  UNION ALL SELECT 47,
  'He sits down. Nobody calls him weak. That is the whole verse.',
  'वह बैठ जाता है। कोई उसे कमज़ोर नहीं कहता। पूरा श्लोक बस इतना है।',
  'Woh baith jaata hai. Koi use kamzor nahi kehta. Poora shloka bas itna hai.',
  'Like a report written by somebody who saw everything and added no adjective.',
  'उस रिपोर्ट जैसी जो किसी ने सब कुछ देखकर लिखी हो और एक भी विशेषण न जोड़ा हो।',
  'Us report jaisi jo kisi ne sab kuch dekhkar likhi ho aur ek bhi visheshan na joda ho.',
  'A bow on the floor of a chariot'
) AS m
JOIN verses v ON v.verse_number = m.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 1;

INSERT INTO verse_reflections (verse_id, question_en, question_hi, question_hinglish, display_order)
SELECT v.id, r.q_en, r.q_hi, r.q_hing, r.ord FROM (
  SELECT 28 AS vn, 'When did your body last know something before you did?' AS q_en, 'पिछली बार आपके शरीर को कोई बात आपसे पहले कब पता चली?' AS q_hi, 'Pichhli baar tumhare sharir ko koi baat tumse pehle kab pata chali?' AS q_hing, 1 AS ord
  UNION ALL SELECT 28, 'What are you walking towards this week that you have not looked at directly yet?', 'इस हफ़्ते आप किस तरफ़ बढ़ रहे हैं जिसे आपने अब तक सीधे देखा नहीं है?', 'Is hafte tum kis taraf badh rahe ho jise tumne ab tak seedhe dekha nahi hai?', 2
  UNION ALL SELECT 28, 'He names it out loud to somebody standing next to him. Who is next to you?', 'वह पास खड़े किसी से यह ज़ोर से कहता है। आपके पास कौन खड़ा है?', 'Woh paas khade kisi se yeh zor se kehta hai. Tumhare paas kaun khada hai?', 3
  UNION ALL SELECT 29, 'If you had to list four things instead of using one word, what would the four be?', 'अगर एक शब्द के बजाय चार चीज़ें गिनानी हों, तो वे चार क्या होंगी?', 'Agar ek shabd ke bajaye chaar cheezein ginani hon, to woh chaar kya hongi?', 1
  UNION ALL SELECT 29, 'Is there something you are good at that has felt slippery lately?', 'कोई ऐसी चीज़ है जिसमें आप अच्छे हैं और जो हाल में हाथ से फिसलती लगी हो?', 'Koi aisi cheez hai jisme tum achhe ho aur jo haal mein haath se phisalti lagi ho?', 2
  UNION ALL SELECT 29, 'A list can be checked and a label cannot. Does that change anything for you?', 'सूची जाँची जा सकती है, नाम नहीं। इससे आपके लिए कुछ बदलता है?', 'Soochi jaanchi ja sakti hai, naam nahi. Isse tumhare liye kuch badalta hai?', 3
  UNION ALL SELECT 30, 'On a bad day, what starts looking like evidence that would not have been evidence yesterday?', 'बुरे दिन पर कौन-सी चीज़ें सबूत लगने लगती हैं जो कल सबूत नहीं होतीं?', 'Bure din par kaun si cheezein saboot lagne lagti hain jo kal saboot nahi hoteen?', 1
  UNION ALL SELECT 30, 'Has anybody ever pointed out to you that the signs were not signs?', 'क्या किसी ने कभी आपको बताया है कि वे संकेत संकेत थे ही नहीं?', 'Kya kisi ne kabhi tumhe bataya hai ki woh sanket sanket the hi nahi?', 2
  UNION ALL SELECT 30, 'The spinning and the signs are in one line. Which of the two do you notice first?', 'घूमना और संकेत एक ही पंक्ति में हैं। इन दोनों में से पहले आपको क्या दिखता है?', 'Ghoomna aur sanket ek hi line mein hain. In dono mein se pehle tumhe kya dikhta hai?', 3
  UNION ALL SELECT 31, 'Think of something you talked yourself out of. Did the reasons come before or after?', 'कोई ऐसी चीज़ सोचिए जिससे आपने ख़ुद को समझा-बुझाकर रोका। वजहें पहले आईं या बाद में?', 'Koi aisi cheez socho jisse tumne khud ko samjha-bujhakar roka. Wajahein pehle aayin ya baad mein?', 1
  UNION ALL SELECT 31, 'A reason arriving late does not make it false. Which of yours are still true?', 'देर से आई वजह झूठी नहीं हो जाती। आपकी वजहों में से कौन-सी अब भी सच हैं?', 'Der se aayi wajah jhoothi nahi ho jaati. Tumhari wajahon mein se kaun si ab bhi sach hain?', 2
  UNION ALL SELECT 31, 'Nobody ever tells him this argument was wrong. Does that surprise you?', 'कोई उसे कभी नहीं कहता कि यह दलील ग़लत थी। क्या यह आपको चौंकाता है?', 'Koi use kabhi nahi kehta ki yeh dalil galat thi. Kya yeh tumhe chaunkata hai?', 3
  UNION ALL SELECT 32, 'What did you build that was for somebody, and is it still for them?', 'आपने क्या बनाया जो किसी के लिए था, और क्या वह अब भी उन्हीं के लिए है?', 'Tumne kya banaya jo kisi ke liye tha, aur kya woh ab bhi unhi ke liye hai?', 1
  UNION ALL SELECT 32, 'Is there something you are still working towards out of momentum?', 'कोई ऐसी चीज़ है जिसकी तरफ़ आप बस रफ़्तार के मारे बढ़े जा रहे हैं?', 'Koi aisi cheez hai jiski taraf tum bas raftaar ke maare badhe ja rahe ho?', 2
  UNION ALL SELECT 32, 'He is not asking whether he can win. What are you not asking?', 'वह यह नहीं पूछ रहा कि वह जीत सकता है या नहीं। आप क्या नहीं पूछ रहे?', 'Woh yeh nahi poochh raha ki woh jeet sakta hai ya nahi. Tum kya nahi poochh rahe?', 3
  UNION ALL SELECT 38, 'When did you last decide somebody could not see clearly, and how long did it take?', 'पिछली बार आपने कब तय किया कि किसी को साफ़ नहीं दिख रहा, और उसमें कितना वक़्त लगा?', 'Pichhli baar tumne kab tay kiya ki kisi ko saaf nahi dikh raha, aur usme kitna waqt laga?', 1
  UNION ALL SELECT 38, 'What would the other side say your judgement had been taken over by?', 'दूसरा पक्ष क्या कहेगा कि आपकी समझ पर किसका क़ब्ज़ा है?', 'Doosra paksh kya kahega ki tumhari samajh par kiska kabza hai?', 2
  UNION ALL SELECT 38, 'The book does not tell him off for this. Why do you think it lets it stand?', 'किताब उसे इसके लिए डाँटती नहीं। आपको क्या लगता है वह इसे टिका क्यों रहने देती है?', 'Kitaab use iske liye daantti nahi. Tumhe kya lagta hai woh ise tika kyun rehne deti hai?', 3
  UNION ALL SELECT 46, 'Who is the person you would say a hard thing to, out loud, without editing it?', 'वह कौन है जिससे आप कोई कठिन बात, बिना काटे-छाँटे, ज़ोर से कह सकते हैं?', 'Woh kaun hai jisse tum koi kathin baat, bina kaate-chhante, zor se keh sakte ho?', 1
  UNION ALL SELECT 46, 'When somebody has said something heavy to you, what did you do that helped?', 'जब किसी ने आपसे कोई भारी बात कही, तब आपने क्या किया जिससे मदद हुई?', 'Jab kisi ne tumse koi bhaari baat kahi, tab tumne kya kiya jisse madad hui?', 2
  UNION ALL SELECT 46, 'The text records the sentence and does not agree with it. Is that a distinction you can use?', 'ग्रंथ वाक्य दर्ज करता है और उससे सहमत नहीं होता। क्या यह फ़र्क़ आपके काम आ सकता है?', 'Granth vakya darj karta hai aur usse sehmat nahi hota. Kya yeh farq tumhare kaam aa sakta hai?', 3
  UNION ALL SELECT 47, 'Has anybody ever seen you at your worst and not added an adjective?', 'क्या किसी ने कभी आपको आपके सबसे बुरे हाल में देखा है और कोई विशेषण नहीं जोड़ा?', 'Kya kisi ne kabhi tumhe tumhare sabse bure haal mein dekha hai aur koi visheshan nahi joda?', 1
  UNION ALL SELECT 47, 'What word do you use about yourself that nobody else has used about you?', 'अपने बारे में आप कौन-सा शब्द इस्तेमाल करते हैं जो और किसी ने आपके लिए नहीं किया?', 'Apne baare mein tum kaun sa shabd istemaal karte ho jo aur kisi ne tumhare liye nahi kiya?', 2
  UNION ALL SELECT 47, 'Everything the book says is said to a man on the floor. Does that change how you hear it?', 'किताब जो कुछ कहती है वह फ़र्श पर बैठे एक आदमी से कहा जाता है। क्या इससे आपके सुनने का ढंग बदलता है?', 'Kitaab jo kuch kehti hai woh farsh par baithe ek aadmi se kaha jaata hai. Kya isse tumhare sunne ka dhang badalta hai?', 3
) AS r
JOIN verses v ON v.verse_number = r.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 1;

INSERT INTO verse_practices (verse_id, action_en, action_hi, action_hinglish, estimated_minutes, difficulty, display_order)
SELECT v.id, p.a_en, p.a_hi, p.a_hing, p.mins, p.diff, 1 FROM (
  SELECT 28 AS vn, 'Once today, before deciding anything, notice what your shoulders and jaw are doing. Write the two words down. Do not explain them.' AS a_en, 'आज एक बार, कुछ भी तय करने से पहले, ध्यान दीजिए कि आपके कंधे और जबड़ा क्या कर रहे हैं। दो शब्द लिख लीजिए। उन्हें समझाइए मत।' AS a_hi, 'Aaj ek baar, kuch bhi tay karne se pehle, dhyan do ki tumhare kandhe aur jabda kya kar rahe hain. Do shabd likh lo. Unhe samjhao mat.' AS a_hing, 2 AS mins, 'beginner' AS diff
  UNION ALL SELECT 29, 'Instead of one word for how today went, write four separate things that happened in your body. Stop at four.', 'आज कैसा गया, इसके लिए एक शब्द के बजाय चार अलग चीज़ें लिखिए जो आपके शरीर में हुईं। चार पर रुक जाइए।', 'Aaj kaisa gaya, iske liye ek shabd ke bajaye chaar alag cheezein likho jo tumhare sharir mein hueen. Chaar par ruk jao.', 4, 'beginner'
  UNION ALL SELECT 30, 'Next time the signs start arriving, say one of them out loud to somebody in the room. Just the one.', 'अगली बार जब संकेत आने लगें, कमरे में मौजूद किसी से उनमें से एक ज़ोर से कह दीजिए। बस एक।', 'Agli baar jab sanket aane lagein, kamre mein maujood kisi se unme se ek zor se keh do. Bas ek.', 3, 'beginner'
  UNION ALL SELECT 31, 'Take a decision you have already made. Write the reasons. Then write when each one first occurred to you.', 'कोई फ़ैसला लीजिए जो आप कर चुके हैं। वजहें लिखिए। फिर लिखिए कि हर वजह पहली बार आपको कब सूझी।', 'Koi faisla lo jo tum kar chuke ho. Wajahein likho. Phir likho ki har wajah pehli baar tumhe kab soojhi.', 10, 'intermediate'
  UNION ALL SELECT 32, 'Pick one long-running thing you are working towards. Write down who it is for. If the name has changed, that is the finding.', 'कोई एक लंबे समय से चली आ रही चीज़ चुनिए जिसकी तरफ़ आप बढ़ रहे हैं। लिखिए वह किसके लिए है। अगर नाम बदल गया है, तो यही निष्कर्ष है।', 'Koi ek lambe samay se chali aa rahi cheez chuno jiski taraf tum badh rahe ho. Likho woh kiske liye hai. Agar naam badal gaya hai, to yahi nishkarsh hai.', 8, 'intermediate'
  UNION ALL SELECT 38, 'In your next disagreement, do not say the sentence about what is clouding their judgement. Say nothing in its place.', 'अगली असहमति में वह वाक्य मत कहिए कि उनकी समझ पर क्या छाया हुआ है। उसकी जगह कुछ मत कहिए।', 'Agli asehmati mein woh vakya mat kaho ki unki samajh par kya chhaya hua hai. Uski jagah kuch mat kaho.', 5, 'intermediate'
  UNION ALL SELECT 46, 'This one needs another person and does not work without them. Tell one person one true heavy thing, today, and let them answer.', 'इसके लिए दूसरा इंसान चाहिए और उसके बिना यह चलता नहीं। आज एक इंसान से एक सच्ची भारी बात कहिए, और उन्हें जवाब देने दीजिए।', 'Iske liye doosra insaan chahiye aur uske bina yeh chalta nahi. Aaj ek insaan se ek sachchi bhaari baat kaho, aur unhe jawab dene do.', 15, 'beginner'
  UNION ALL SELECT 47, 'Write one sentence describing a bad day of yours with no adjective in it at all. Read it back.', 'अपने किसी बुरे दिन का वर्णन एक वाक्य में लिखिए जिसमें एक भी विशेषण न हो। फिर उसे पढ़िए।', 'Apne kisi bure din ka varnan ek vakya mein likho jisme ek bhi visheshan na ho. Phir use padho.', 6, 'beginner'
) AS p
JOIN verses v ON v.verse_number = p.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 1;

INSERT INTO verse_topics (verse_id, topic_id, relevance)
SELECT v.id, t.id, x.rel FROM (
  SELECT 28 AS vn, 'fear' AS slug, 10 AS rel
  UNION ALL SELECT 28, 'the-self', 8
  UNION ALL SELECT 28, 'hard-decisions', 7
  UNION ALL SELECT 29, 'fear', 10
  UNION ALL SELECT 29, 'restlessness', 7
  UNION ALL SELECT 29, 'the-self', 6
  UNION ALL SELECT 30, 'restlessness', 10
  UNION ALL SELECT 30, 'fear', 9
  UNION ALL SELECT 30, 'steadiness', 7
  UNION ALL SELECT 31, 'hard-decisions', 10
  UNION ALL SELECT 31, 'duty', 8
  UNION ALL SELECT 31, 'grief', 7
  UNION ALL SELECT 32, 'grief', 9
  UNION ALL SELECT 32, 'effort-without-result', 8
  UNION ALL SELECT 32, 'hard-decisions', 8
  UNION ALL SELECT 32, 'impermanence', 6
  UNION ALL SELECT 38, 'anger', 9
  UNION ALL SELECT 38, 'comparison', 8
  UNION ALL SELECT 38, 'hard-decisions', 6
  UNION ALL SELECT 46, 'grief', 10
  UNION ALL SELECT 46, 'fear', 8
  UNION ALL SELECT 46, 'burnout', 7
  UNION ALL SELECT 47, 'grief', 10
  UNION ALL SELECT 47, 'burnout', 8
  UNION ALL SELECT 47, 'the-self', 7
  UNION ALL SELECT 47, 'duty', 6
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 1
JOIN topics t ON t.slug = x.slug;

-- =====================================================================
-- 4. MODERN EXAMPLES
-- =====================================================================
-- Four per verse, four distinct categories per verse, THIRTY-TWO total.
--
-- THE 1.46 SET IS THE MOST CAREFULLY WRITTEN IN THE CORPUS
--   All four turn on another person being in the room. Not one of them
--   describes a method, a plan, an attempt or an outcome, because a
--   worked example of despair is not a teaching aid — it is an
--   instruction. What each of them shows instead is the thing the text
--   itself does at this point: somebody hears a heavy sentence, does
--   not flinch, does not argue it down, and stays.
--
-- THE 1.28 TO 1.30 SET DESCRIBES, IT DOES NOT DIAGNOSE
--   No example names a condition or suggests one. Each describes what
--   happened in a body on a specific day and stops there.
-- =====================================================================

DELETE e FROM modern_examples e JOIN verses v ON v.id = e.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 1;

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

  SELECT 28 AS vn, 'healthcare' AS cat, 1 AS ord,
  'The corridor outside the room' AS t_en, 'कमरे के बाहर का गलियारा' AS t_hi, 'Kamre ke bahar ka galiyara' AS t_hing,
  'Somebody walks into a hospital to visit a relative who is unwell, having prepared what to say on the way. Outside the door their mouth goes dry and they have to stand still for a moment. Nothing has happened yet. They have not gone in and nobody has told them anything.' AS s_en,
  'कोई किसी बीमार रिश्तेदार से मिलने अस्पताल पहुँचता है, रास्ते भर यह तय करते हुए कि क्या कहना है। दरवाज़े के बाहर उसका मुँह सूख जाता है और उसे एक पल रुकना पड़ता है। अभी कुछ हुआ नहीं है। वह अंदर गया नहीं है और किसी ने उसे कुछ बताया नहीं है।' AS s_hi,
  'Koi kisi bimar rishtedaar se milne aspatal pahunchta hai, raaste bhar yeh tay karte hue ki kya kehna hai. Darwaze ke bahar uska munh sookh jaata hai aur use ek pal rukna padta hai. Abhi kuch hua nahi hai. Woh andar gaya nahi hai aur kisi ne use kuch bataya nahi hai.' AS s_hing,
  'This is the order the verse is careful about. He saw, and then his mouth went dry. The preparation on the way was real thinking and it did not touch this. Nothing here is a claim about what is happening inside anybody — it is one person, one corridor, one afternoon, described.' AS c_en,
  'श्लोक जिस क्रम को लेकर सावधान है, यह वही है। उसने देखा, और फिर मुँह सूख गया। रास्ते भर की तैयारी असली सोच थी और उसने इसे छुआ तक नहीं। यहाँ किसी के भीतर क्या हो रहा है, इस बारे में कोई दावा नहीं है — यह एक इंसान, एक गलियारा, एक दोपहर है, बस बताई हुई।' AS c_hi,
  'Shloka jis kram ko lekar savdhan hai, yeh wahi hai. Usne dekha, aur phir munh sookh gaya. Raaste bhar ki taiyari asli soch thi aur usne ise chhua tak nahi. Yahan kisi ke bheetar kya ho raha hai, is baare mein koi dawa nahi hai — yeh ek insaan, ek galiyara, ek dopahar hai, bas batayi hui.' AS c_hing,
  'The preparing happened on the way. The body did something else entirely at the door.' AS l_en,
  'तैयारी रास्ते में हुई। दरवाज़े पर शरीर ने कुछ बिलकुल और ही किया।' AS l_hi,
  'Taiyari raaste mein hui. Darwaze par sharir ne kuch bilkul aur hi kiya.' AS l_hing,
  NULL AS src, 'beginner' AS diff, 'hospital,fear,body,noticing' AS tags

  UNION ALL SELECT 28, 'corporate', 2,
  'He had the numbers', 'आँकड़े उसके पास थे', 'Aankde uske paas the',
  'Somebody has rehearsed a difficult presentation eleven times and knows every figure in it. He stands up, looks at the room, and finds his voice has gone thin. The figures are still all correct and he can still recall every one of them.',
  'किसी ने एक मुश्किल प्रेज़ेंटेशन ग्यारह बार दोहराया है और उसे उसका हर आँकड़ा याद है। वह खड़ा होता है, कमरे की तरफ़ देखता है, और पाता है कि उसकी आवाज़ पतली हो गई है। आँकड़े अब भी सब सही हैं और उसे उनमें से हर एक याद है।',
  'Kisi ne ek mushkil presentation gyarah baar dohraya hai aur use uska har aankda yaad hai. Woh khada hota hai, kamre ki taraf dekhta hai, aur paata hai ki uski aawaz patli ho gayi hai. Aankde ab bhi sab sahi hain aur use unme se har ek yaad hai.',
  'The best archer alive is about to drop his bow four verses from here, so the verse is not making a point about being underprepared. Preparation is not the thing this addresses. Something arrives before the argument does and arrives whether or not the argument is good.',
  'यहाँ से चार श्लोक बाद ज़िंदा सबसे बड़ा धनुर्धर अपना धनुष गिराने वाला है, तो श्लोक तैयारी की कमी की बात नहीं कर रहा। तैयारी वह चीज़ है ही नहीं जिसे यह छूता है। दलील से पहले कुछ आता है, और वह इससे बेपरवाह आता है कि दलील अच्छी है या नहीं।',
  'Yahan se chaar shloka baad zinda sabse bada dhanurdhar apna dhanush girane wala hai, to shloka taiyari ki kami ki baat nahi kar raha. Taiyari woh cheez hai hi nahi jise yeh chhota hai. Dalil se pehle kuch aata hai, aur woh isse beparwah aata hai ki dalil achhi hai ya nahi.',
  'Being ready and being steady are two different readinesses. He had one of them.',
  'तैयार होना और टिका होना दो अलग तैयारियाँ हैं। उसके पास एक थी।',
  'Taiyar hona aur tika hona do alag taiyariyan hain. Uske paas ek thi.',
  NULL, 'beginner', 'work,presenting,preparation,nerves'

  UNION ALL SELECT 28, 'school', 3,
  'The child at the gate', 'गेट पर खड़ा बच्चा', 'Gate par khada bachcha',
  'A child who has been going to the same school for two years stops at the gate one Monday and cannot go in. Asked why, she cannot say, and the not being able to say is the honest part. She wants to go in. Her feet are not moving.',
  'दो साल से उसी स्कूल जाती एक बच्ची एक सोमवार गेट पर रुक जाती है और अंदर नहीं जा पाती। पूछने पर वह बता नहीं पाती, और बता न पाना ही ईमानदार हिस्सा है। वह अंदर जाना चाहती है। उसके पैर नहीं चल रहे।',
  'Do saal se usi school jaati ek bachchi ek Monday gate par ruk jaati hai aur andar nahi ja paati. Poochhne par woh bata nahi paati, aur bata na paana hi imaandaar hissa hai. Woh andar jaana chahti hai. Uske pair nahi chal rahe.',
  'The most useful thing an adult can do here is what the verse does: describe rather than interpret. She is at the gate and her feet are not moving. That is a fact and it is worth saying back to her plainly, because it does not require her to produce a reason she does not have.',
  'यहाँ कोई बड़ा सबसे काम की चीज़ वही कर सकता है जो श्लोक करता है: व्याख्या नहीं, वर्णन। वह गेट पर है और उसके पैर नहीं चल रहे। यह तथ्य है और उसे साफ़-साफ़ उसी से कह देना काम आता है, क्योंकि इसके लिए उससे वह वजह नहीं माँगनी पड़ती जो उसके पास है ही नहीं।',
  'Yahan koi bada sabse kaam ki cheez wahi kar sakta hai jo shloka karta hai: vyakhya nahi, varnan. Woh gate par hai aur uske pair nahi chal rahe. Yeh tathya hai aur use saaf saaf usi se keh dena kaam aata hai, kyunki iske liye usse woh wajah nahi maangni padti jo uske paas hai hi nahi.',
  'Asking why can be a demand. Saying what is happening is not.',
  'क्यों पूछना माँग बन सकता है। जो हो रहा है वह कह देना नहीं बनता।',
  'Kyun poochhna maang ban sakta hai. Jo ho raha hai woh keh dena nahi banta.',
  NULL, 'beginner', 'children,school,fear,description'

  UNION ALL SELECT 28, 'everyday_life', 4,
  'The number on the screen', 'स्क्रीन पर वह नंबर', 'Screen par woh number',
  'A phone rings and somebody sees who is calling and their stomach drops before they have thought a single thing about it. They answer. It is nothing much. The drop happened anyway and had already finished by the time they said hello.',
  'फ़ोन बजता है, कोई देखता है कि किसका है, और कुछ भी सोचने से पहले पेट में एक गिरावट आ जाती है। वह फ़ोन उठाता है। कोई ख़ास बात नहीं होती। गिरावट फिर भी आई और "हैलो" कहने तक ख़त्म भी हो चुकी थी।',
  'Phone bajta hai, koi dekhta hai ki kiska hai, aur kuch bhi sochne se pehle pet mein ek girawat aa jaati hai. Woh phone uthata hai. Koi khaas baat nahi hoti. Girawat phir bhi aayi aur "hello" kehne tak khatam bhi ho chuki thi.',
  'The cheapest available version of the verse, and almost everybody has it. Seeing came first, the body came second, and any thought about what the call might be came a distant third. Arjuna''s afternoon was larger. The order was the same.',
  'श्लोक का सबसे सस्ता रूप, और लगभग हर किसी के पास है। पहले देखना आया, दूसरे नंबर पर शरीर, और यह सोच कि फ़ोन किस बारे में हो सकता है, बहुत पीछे तीसरे नंबर पर। अर्जुन की दोपहर बड़ी थी। क्रम वही था।',
  'Shloka ka sabse sasta roop, aur lagbhag har kisi ke paas hai. Pehle dekhna aaya, doosre number par sharir, aur yeh soch ki phone kis baare mein ho sakta hai, bahut peechhe teesre number par. Arjun ki dopahar badi thi. Kram wahi tha.',
  'The stomach had already answered before there was a question.',
  'सवाल बनने से पहले ही पेट जवाब दे चुका था।',
  'Sawal banne se pehle hi pet jawab de chuka tha.',
  NULL, 'beginner', 'phone,body,anticipation,noticing'

  UNION ALL SELECT 29, 'sports', 1,
  'The kick he had taken a thousand times', 'वह किक जो वह हज़ार बार ले चुका था', 'Woh kick jo woh hazaar baar le chuka tha',
  'A player who has taken penalties since he was nine walks up in a shoot-out and notices, on the way, that his hands are shaking. He has taken this exact kick a thousand times in training that week. The shaking is new and it is not about technique.',
  'नौ साल की उम्र से पेनल्टी लेता आया एक खिलाड़ी शूट-आउट में आगे बढ़ता है और रास्ते में देखता है कि उसके हाथ काँप रहे हैं। उसी हफ़्ते अभ्यास में वह यही किक हज़ार बार ले चुका है। काँपना नया है और उसका तकनीक से कोई लेना-देना नहीं।',
  'Nau saal ki umr se penalty leta aaya ek khilaadi shoot-out mein aage badhta hai aur raaste mein dekhta hai ki uske haath kaanp rahe hain. Usi hafte abhyas mein woh yahi kick hazaar baar le chuka hai. Kaanpna naya hai aur uska technique se koi lena dena nahi.',
  'The Gāṇḍīva is in this verse for the same reason. It is the most famous bow in the story, held by the best archer alive, and it is sliding out of his hand. Skill does not exempt anybody from this, and the verse chose the one object that proves it.',
  'गांडीव इस श्लोक में इसी वजह से है। वह कहानी का सबसे मशहूर धनुष है, ज़िंदा सबसे बड़े धनुर्धर के हाथ में, और वह उसके हाथ से फिसल रहा है। हुनर इससे किसी को छूट नहीं देता, और श्लोक ने वही एक चीज़ चुनी जो यह साबित करती है।',
  'Gandiv is shloka mein isi wajah se hai. Woh kahani ka sabse mashhoor dhanush hai, zinda sabse bade dhanurdhar ke haath mein, aur woh uske haath se phisal raha hai. Hunar isse kisi ko chhoot nahi deta, aur shloka ne wahi ek cheez chuni jo yeh saabit karti hai.',
  'The best hands in the story are the ones that cannot hold the bow.',
  'कहानी के सबसे अच्छे हाथ ही वे हैं जो धनुष नहीं थाम पा रहे।',
  'Kahani ke sabse achhe haath hi woh hain jo dhanush nahi thaam pa rahe.',
  NULL, 'beginner', 'sport,pressure,skill,hands'

  UNION ALL SELECT 29, 'college', 2,
  'Four things instead of one word', 'एक शब्द की जगह चार चीज़ें', 'Ek shabd ki jagah chaar cheezein',
  'A student who has been telling everybody she is "fine" is asked instead to say four specific things about the last hour. She says: did not eat, read the same paragraph four times, kept checking the door, cold hands. It takes her forty seconds and it is the most she has said in a fortnight.',
  'एक छात्रा जो सबको बता रही थी कि वह "ठीक" है, उससे इसके बजाय पिछले एक घंटे की चार ख़ास बातें कहने को कहा जाता है। वह कहती है: खाया नहीं, वही पैराग्राफ़ चार बार पढ़ा, बार-बार दरवाज़े की तरफ़ देखा, हाथ ठंडे। इसमें चालीस सेकंड लगते हैं और पखवाड़े भर में उसने इतना ही सबसे ज़्यादा कहा है।',
  'Ek chhatra jo sabko bata rahi thi ki woh "theek" hai, usse iske bajaye pichhle ek ghante ki chaar khaas baatein kehne ko kaha jaata hai. Woh kehti hai: khaya nahi, wahi paragraph chaar baar padha, baar baar darwaze ki taraf dekha, haath thande. Isme chalees second lagte hain aur pakhwade bhar mein usne itna hi sabse zyada kaha hai.',
  'The verse is a list and this is why lists are useful. A single word makes somebody decide what they are, which is a large claim to sign on a bad week. Four separate observations can be made without deciding anything, and they can be checked tomorrow.',
  'श्लोक एक सूची है और सूचियाँ इसीलिए काम की हैं। एक शब्द इंसान से यह तय करवाता है कि वह है क्या, जो किसी बुरे हफ़्ते में दस्तख़त करने के लिए बड़ा दावा है। चार अलग-अलग बातें बिना कुछ तय किए कही जा सकती हैं, और कल उन्हें जाँचा भी जा सकता है।',
  'Shloka ek soochi hai aur soochiyan isiliye kaam ki hain. Ek shabd insaan se yeh tay karvata hai ki woh hai kya, jo kisi bure hafte mein dastkhat karne ke liye bada dawa hai. Chaar alag alag baatein bina kuch tay kiye kahi ja sakti hain, aur kal unhe jaancha bhi ja sakta hai.',
  '"Fine" is a decision. Four observations are not.',
  '"ठीक हूँ" एक फ़ैसला है। चार बातें फ़ैसला नहीं हैं।',
  '"Theek hoon" ek faisla hai. Chaar baatein faisla nahi hain.',
  NULL, 'beginner', 'students,talking,description,specificity'

  UNION ALL SELECT 29, 'everyday_life', 3,
  'The kettle he filled twice', 'वह केतली जो उसने दो बार भरी', 'Woh ketli jo usne do baar bhari',
  'Somebody waiting for a result they have no control over notices, at the end of the afternoon, that they have filled the kettle three times and drunk nothing, and moved the same pile of post from one surface to another twice.',
  'किसी नतीजे का इंतज़ार करता कोई, जिस पर उसका कोई बस नहीं, दोपहर ढलते-ढलते देखता है कि उसने केतली तीन बार भरी है और पिया कुछ नहीं, और डाक का वही ढेर दो बार एक जगह से दूसरी जगह रखा है।',
  'Kisi nateeje ka intezaar karta koi, jis par uska koi bas nahi, dopahar dhalte dhalte dekhta hai ki usne ketli teen baar bhari hai aur piya kuch nahi, aur daak ka wahi dher do baar ek jagah se doosri jagah rakha hai.',
  'These are the small versions of the four things in the verse, and they are worth noticing for the same reason: they can be observed without a story attached. He did not decide to fill the kettle three times, which is exactly what makes it information.',
  'ये श्लोक की उन चार चीज़ों के छोटे रूप हैं, और इन्हें देखने की वजह भी वही है: इन्हें बिना कोई कहानी जोड़े देखा जा सकता है। उसने केतली तीन बार भरने का फ़ैसला नहीं किया, और यही इसे जानकारी बनाता है।',
  'Yeh shloka ki un chaar cheezon ke chhote roop hain, aur inhe dekhne ki wajah bhi wahi hai: inhe bina koi kahani jode dekha ja sakta hai. Usne ketli teen baar bharne ka faisla nahi kiya, aur yahi ise jaankari banata hai.',
  'What you did without deciding to is the part worth reading.',
  'जो आपने बिना तय किए किया, पढ़ने लायक़ हिस्सा वही है।',
  'Jo tumne bina tay kiye kiya, padhne layak hissa wahi hai.',
  NULL, 'beginner', 'waiting,habit,noticing,small-signs'

  UNION ALL SELECT 29, 'corporate', 4,
  'The email she could not send', 'वह ईमेल जो वह भेज नहीं पाई', 'Woh email jo woh bhej nahi payi',
  'A manager has written a resignation-adjacent email eleven times and each time closed the laptop. On the twelfth she notices her hand is not moving to the trackpad and stops trying to make it. She stands up and walks around the building instead.',
  'एक मैनेजर इस्तीफ़े जैसी ईमेल ग्यारह बार लिख चुकी है और हर बार लैपटॉप बंद कर दिया। बारहवीं बार वह देखती है कि उसका हाथ ट्रैकपैड की तरफ़ नहीं जा रहा और उसे ज़बरदस्ती ले जाने की कोशिश छोड़ देती है। वह उठकर इमारत का एक चक्कर लगा आती है।',
  'Ek manager isteefe jaisi email gyarah baar likh chuki hai aur har baar laptop band kar diya. Barahvi baar woh dekhti hai ki uska haath trackpad ki taraf nahi ja raha aur use zabardasti le jaane ki koshish chhod deti hai. Woh uthkar imaarat ka ek chakkar laga aati hai.',
  'The bow slipping is not a failure of will and the verse does not treat it as one. Something in the hand is refusing and it is information about the decision rather than about her character. Walking round the building is not a solution. It is what you do when you have stopped arguing with your own hand.',
  'धनुष का फिसलना इच्छाशक्ति की हार नहीं है और श्लोक उसे वैसे लेता भी नहीं। हाथ में कुछ इनकार कर रहा है और यह उसके चरित्र के बारे में नहीं, उस फ़ैसले के बारे में जानकारी है। इमारत का चक्कर कोई हल नहीं है। यह वह है जो आप तब करते हैं जब आपने अपने ही हाथ से बहस करना छोड़ दिया हो।',
  'Dhanush ka phisalna ichhashakti ki haar nahi hai aur shloka use waise leta bhi nahi. Haath mein kuch inkaar kar raha hai aur yeh uske charitra ke baare mein nahi, us faisle ke baare mein jaankari hai. Imaarat ka chakkar koi hal nahi hai. Yeh woh hai jo tum tab karte ho jab tumne apne hi haath se behes karna chhod diya ho.',
  'A hand that will not move is information, not a verdict on you.',
  'जो हाथ नहीं हिल रहा वह जानकारी है, आप पर फ़ैसला नहीं।',
  'Jo haath nahi hil raha woh jaankari hai, tum par faisla nahi.',
  NULL, 'intermediate', 'work,decisions,resistance,body'

  UNION ALL SELECT 30, 'everyday_life', 1,
  'The morning that agreed with him', 'वह सुबह जो उससे सहमत थी', 'Woh subah jo usse sehmat thi',
  'Somebody wakes up already low. The bus is late, a message goes unanswered, and somebody at the counter is short with him. By ten he has a complete case that today is against him. Every item in the case is true and none of it would have registered on Tuesday.',
  'कोई पहले से गिरा हुआ उठता है। बस देर से आती है, एक संदेश का जवाब नहीं आता, और काउंटर पर कोई उससे रूखा बोलता है। दस बजे तक उसके पास पूरा मुक़दमा तैयार है कि आज का दिन उसके ख़िलाफ़ है। मुक़दमे की हर बात सच है और मंगलवार को इनमें से कुछ भी दर्ज नहीं होता।',
  'Koi pehle se gira hua uthta hai. Bus der se aati hai, ek message ka jawab nahi aata, aur counter par koi usse rookha bolta hai. Das baje tak uske paas poora mukadma taiyar hai ki aaj ka din uske khilaf hai. Mukadme ki har baat sach hai aur Tuesday ko inme se kuch bhi darj nahi hota.',
  'This is the second half of the verse, which most readers pass over. He is not inventing the signs. They are all really there. What has changed is what counts as a sign, and that changed before any of them arrived.',
  'यह श्लोक का दूसरा आधा है, जिसे ज़्यादातर पढ़ने वाले लाँघ जाते हैं। वह संकेत गढ़ नहीं रहा। वे सब सचमुच हैं। बदला यह है कि संकेत गिना क्या जाता है, और वह इनमें से किसी के आने से पहले बदल चुका था।',
  'Yeh shloka ka doosra aadha hai, jise zyadatar padhne wale laangh jaate hain. Woh sanket gadh nahi raha. Woh sab sach mein hain. Badla yeh hai ki sanket gina kya jaata hai, aur woh inme se kisi ke aane se pehle badal chuka tha.',
  'He is not making the signs up. The threshold for what counts as one moved first.',
  'वह संकेत गढ़ नहीं रहा। पहले वह पैमाना खिसका कि संकेत गिना क्या जाए।',
  'Woh sanket gadh nahi raha. Pehle woh paimana khiska ki sanket gina kya jaaye.',
  NULL, 'beginner', 'mood,evidence,bad-days,noticing'

  UNION ALL SELECT 30, 'social_media', 2,
  'Three posts and a conclusion', 'तीन पोस्ट और एक नतीजा', 'Teen post aur ek nateeja',
  'Somebody at a low point scrolls for twenty minutes and sees three people they know doing well. They come away with a settled conclusion about where their own life has ended up. The three posts were the only three they stopped on out of two hundred.',
  'किसी बुरे दौर में कोई बीस मिनट स्क्रॉल करता है और तीन जान-पहचान वालों को अच्छा करते देखता है। वह यह पक्का नतीजा लेकर हटता है कि उसकी अपनी ज़िंदगी कहाँ पहुँची है। दो सौ में से वे तीन ही पोस्ट थीं जिन पर वह रुका।',
  'Kisi bure daur mein koi bees minute scroll karta hai aur teen jaan-pehchan walon ko achha karte dekhta hai. Woh yeh pakka nateeja lekar hatta hai ki uski apni zindagi kahan pahunchi hai. Do sau mein se woh teen hi post thin jin par woh ruka.',
  'The signs pointing the wrong way, in the exact modern form. Nothing on the screen was false. The selection was made by the mood and then the mood read its own selection back as evidence. The verse puts the spinning and the signs in one line because they are one mechanism.',
  'उलटी दिशा में इशारा करते संकेत, बिलकुल आज के रूप में। स्क्रीन पर कुछ भी झूठ नहीं था। छँटाई मिज़ाज ने की और फिर मिज़ाज ने अपनी ही छँटाई को सबूत की तरह पढ़ लिया। श्लोक घूमने और संकेतों को एक ही पंक्ति में रखता है क्योंकि वे एक ही तंत्र हैं।',
  'Ulti disha mein ishara karte sanket, bilkul aaj ke roop mein. Screen par kuch bhi jhooth nahi tha. Chhantai mizaaj ne ki aur phir mizaaj ne apni hi chhantai ko saboot ki tarah padh liya. Shloka ghoomne aur sanketon ko ek hi line mein rakhta hai kyunki woh ek hi tantra hain.',
  'The mood chose the three. Then it read the three back as proof.',
  'तीनों को मिज़ाज ने चुना। फिर उन्हीं तीनों को सबूत की तरह पढ़ लिया।',
  'Teenon ko mizaaj ne chuna. Phir unhi teenon ko saboot ki tarah padh liya.',
  NULL, 'beginner', 'social-media,comparison,evidence,mood'

  UNION ALL SELECT 30, 'healthcare', 3,
  'The night shift and the corridor light', 'रात की पाली और गलियारे की बत्ती', 'Raat ki paali aur galiyare ki batti',
  'Somebody on their fourth night shift in a row finds that a routine handover feels like criticism, a colleague''s silence feels like a judgement, and a small equipment fault feels like a sign of how the week is going. On the second day off, none of the three feels like anything at all.',
  'लगातार चौथी रात की पाली में किसी को लगता है कि रोज़ का हैंडओवर आलोचना है, साथी की चुप्पी कोई फ़ैसला है, और उपकरण की छोटी ख़राबी इस बात का संकेत है कि हफ़्ता कैसा जा रहा है। छुट्टी के दूसरे दिन इन तीनों में से कुछ भी कुछ नहीं लगता।',
  'Lagataar chauthi raat ki paali mein kisi ko lagta hai ki roz ka handover aalochana hai, saathi ki chuppi koi faisla hai, aur upkaran ki chhoti kharabi is baat ka sanket hai ki hafta kaisa ja raha hai. Chhutti ke doosre din in teenon mein se kuch bhi kuch nahi lagta.',
  'The same three events, read twice, by the same competent person. This is the verse''s claim tested under controlled conditions, and the useful part is that the second reading is available and can be waited for. Nothing in this describes a condition. It describes a fourth night shift.',
  'वही तीन घटनाएँ, दो बार पढ़ी गईं, उसी काबिल इंसान द्वारा। यह श्लोक का दावा है, नियंत्रित हालात में जाँचा हुआ, और काम की बात यह है कि दूसरा पाठ उपलब्ध है और उसका इंतज़ार किया जा सकता है। इसमें कुछ भी किसी बीमारी का वर्णन नहीं है। यह लगातार चौथी रात की पाली का वर्णन है।',
  'Wahi teen ghatnayen, do baar padhi gayin, usi kaabil insaan dwara. Yeh shloka ka dawa hai, niyantrit haalat mein jaancha hua, aur kaam ki baat yeh hai ki doosra paath uplabdh hai aur uska intezaar kiya ja sakta hai. Isme kuch bhi kisi bimari ka varnan nahi hai. Yeh lagataar chauthi raat ki paali ka varnan hai.',
  'The second reading exists. Sometimes the whole skill is waiting for it.',
  'दूसरा पाठ मौजूद है। कभी-कभी पूरा हुनर बस उसका इंतज़ार करना होता है।',
  'Doosra paath maujood hai. Kabhi kabhi poora hunar bas uska intezaar karna hota hai.',
  NULL, 'intermediate', 'shift-work,fatigue,interpretation,waiting'

  UNION ALL SELECT 30, 'finance', 4,
  'The chart he checked at midnight', 'वह चार्ट जो उसने आधी रात देखा', 'Woh chart jo usne aadhi raat dekha',
  'Somebody with money in something volatile checks it eleven times between waking and sleeping. On the good days he checks it twice. The number of checks is not tracking the market; it is tracking him, and he has never once noticed this while it was happening.',
  'जिसका पैसा किसी उतार-चढ़ाव वाली जगह लगा है, वह जागने से सोने के बीच ग्यारह बार उसे देखता है। अच्छे दिनों में दो बार। देखने की गिनती बाज़ार का पीछा नहीं कर रही; वह उसका पीछा कर रही है, और होते हुए उसने यह एक बार भी नहीं देखा।',
  'Jiska paisa kisi utaar-chadhav wali jagah laga hai, woh jaagne se sone ke beech gyarah baar use dekhta hai. Achhe dinon mein do baar. Dekhne ki ginti bazaar ka peechha nahi kar rahi; woh uska peechha kar rahi hai, aur hote hue usne yeh ek baar bhi nahi dekha.',
  'Bhramati is a word for going round without going anywhere, and eleven checks is what that looks like on a phone. The verse pairs it with the signs for a reason: each check produces a number, and a mind going round will find a way to read almost any number as confirmation.',
  'भ्रमति का मतलब है घूमते रहना और कहीं न पहुँचना, और फ़ोन पर ग्यारह बार देखना उसी का रूप है। श्लोक इसे संकेतों के साथ बेवजह नहीं जोड़ता: हर बार देखने से एक आँकड़ा मिलता है, और घूमता हुआ मन लगभग किसी भी आँकड़े को पुष्टि की तरह पढ़ने का रास्ता निकाल लेता है।',
  'Bhramati ka matlab hai ghoomte rehna aur kahin na pahunchna, aur phone par gyarah baar dekhna usi ka roop hai. Shloka ise sanketon ke saath bewajah nahi jodta: har baar dekhne se ek aankda milta hai, aur ghoomta hua man lagbhag kisi bhi aankde ko pushti ki tarah padhne ka raasta nikaal leta hai.',
  'Count the checks, not the number. The checks are about you.',
  'आँकड़ा नहीं, देखने की गिनती गिनिए। गिनती आपके बारे में है।',
  'Aankda nahi, dekhne ki ginti gino. Ginti tumhare baare mein hai.',
  NULL, 'intermediate', 'money,checking,anxiety,self-observation'

  UNION ALL SELECT 31, 'corporate', 1,
  'The reasons he gave the panel', 'वे वजहें जो उसने पैनल को दीं', 'Woh wajahein jo usne panel ko deen',
  'Somebody turns down a promotion and gives three reasons, all of them accurate: the travel, the team, the timing. Six months later he admits, to one person, that he had decided in the lift and found the three on the way back up.',
  'कोई तरक़्क़ी ठुकराता है और तीन वजहें देता है, तीनों सही: सफ़र, टीम, वक़्त। छह महीने बाद वह एक इंसान से मानता है कि उसने लिफ़्ट में तय कर लिया था और तीनों वजहें ऊपर लौटते हुए मिली थीं।',
  'Koi tarakki thukrata hai aur teen wajahein deta hai, teenon sahi: safar, team, waqt. Chhah mahine baad woh ek insaan se maanta hai ki usne lift mein tay kar liya tha aur teenon wajahein upar lautte hue mili thin.',
  'The verse is careful about exactly this order and does not treat it as dishonesty. The three reasons are true. They are also not the cause. Both things can be said about the same three sentences, and the second one does not cancel the first.',
  'श्लोक ठीक इसी क्रम को लेकर सावधान है और इसे बेईमानी नहीं मानता। तीनों वजहें सच हैं। और वे कारण भी नहीं हैं। इन्हीं तीन वाक्यों के बारे में दोनों बातें कही जा सकती हैं, और दूसरी पहली को काटती नहीं।',
  'Shloka theek isi kram ko lekar savdhan hai aur ise beimani nahi maanta. Teenon wajahein sach hain. Aur woh kaaran bhi nahi hain. Inhi teen vakyon ke baare mein dono baatein kahi ja sakti hain, aur doosri pehli ko kaatti nahi.',
  'True and not the cause are two different things, and both were true here.',
  'सच होना और कारण होना दो अलग बातें हैं, और यहाँ दोनों सच थीं।',
  'Sach hona aur kaaran hona do alag baatein hain, aur yahan dono sach thin.',
  NULL, 'intermediate', 'work,decisions,reasons,honesty'

  UNION ALL SELECT 31, 'relationships', 2,
  'She was right about all of it', 'वह हर बात के बारे में सही थी', 'Woh har baat ke baare mein sahi thi',
  'Somebody ends a long relationship and lists what was wrong with it. Everything on the list is accurate and friends who knew them both agree. It is also the case that she had been unable to sleep in that flat for four months before the first item on the list occurred to her.',
  'कोई एक लंबा रिश्ता ख़त्म करता है और गिनाता है कि उसमें ग़लत क्या था। सूची की हर बात सही है और दोनों को जानने वाले दोस्त भी मानते हैं। यह भी सच है कि सूची की पहली बात सूझने से चार महीने पहले से वह उस फ़्लैट में सो नहीं पा रही थी।',
  'Koi ek lamba rishta khatam karta hai aur ginata hai ki usme galat kya tha. Soochi ki har baat sahi hai aur dono ko jaanne wale dost bhi maante hain. Yeh bhi sach hai ki soochi ki pehli baat soojhne se chaar mahine pehle se woh us flat mein so nahi pa rahi thi.',
  'The verse does not say the argument is wrong and neither does anything here. It says the argument came second. Which matters because if you think the reasons caused the decision, you will keep arguing with the reasons, and the thing that actually moved is four months earlier and does not respond to argument.',
  'श्लोक यह नहीं कहता कि दलील ग़लत है और यहाँ भी कुछ नहीं कहता। वह कहता है कि दलील दूसरे नंबर पर आई। यह मायने रखता है क्योंकि अगर आपको लगे कि फ़ैसला वजहों ने किया, तो आप वजहों से बहस करते रहेंगे, और जो असल में हिला वह चार महीने पहले का है और बहस से हिलता नहीं।',
  'Shloka yeh nahi kehta ki dalil galat hai aur yahan bhi kuch nahi kehta. Woh kehta hai ki dalil doosre number par aayi. Yeh maayne rakhta hai kyunki agar tumhe lage ki faisla wajahon ne kiya, to tum wajahon se behes karte rahoge, aur jo asal mein hila woh chaar mahine pehle ka hai aur behes se hilta nahi.',
  'Arguing with the reasons will not reach the thing that moved four months earlier.',
  'वजहों से बहस करके उस चीज़ तक नहीं पहुँचा जा सकता जो चार महीने पहले हिली थी।',
  'Wajahon se behes karke us cheez tak nahi pahuncha ja sakta jo chaar mahine pehle hili thi.',
  NULL, 'intermediate', 'relationships,endings,reasons,timing'

  UNION ALL SELECT 31, 'ethics', 3,
  'The objection that was correct', 'वह आपत्ति जो सही थी', 'Woh aapatti jo sahi thi',
  'Somebody refuses to work on something on grounds they can state clearly, and the grounds hold up. Later they notice they had also been dreading the project for reasons that had nothing to do with ethics. Both were operating. The objection is still correct.',
  'कोई किसी काम से इनकार करता है और वजह साफ़-साफ़ बता सकता है, और वजह टिकती भी है। बाद में उसे लगता है कि वह उस प्रोजेक्ट से उन वजहों से भी घबरा रहा था जिनका नैतिकता से कोई लेना-देना नहीं था। दोनों काम कर रहे थे। आपत्ति फिर भी सही है।',
  'Koi kisi kaam se inkaar karta hai aur wajah saaf saaf bata sakta hai, aur wajah tikti bhi hai. Baad mein use lagta hai ki woh us project se un wajahon se bhi ghabra raha tha jinka naitikta se koi lena dena nahi tha. Dono kaam kar rahe the. Aapatti phir bhi sahi hai.',
  'This is the part of the chapter people get wrong in both directions. Some read it as proof that Arjuna''s ethics were a cover story. Others refuse to notice the order at all. The verse allows both to be true, and seventeen chapters later nobody has told him his objection was wrong.',
  'अध्याय का यह हिस्सा लोग दोनों तरफ़ से ग़लत पढ़ते हैं। कुछ इसे इस बात का सबूत मानते हैं कि अर्जुन की नैतिकता बहाना थी। कुछ क्रम को देखने से ही इनकार कर देते हैं। श्लोक दोनों को सच रहने देता है, और सत्रह अध्याय बाद भी किसी ने उससे यह नहीं कहा कि उसकी आपत्ति ग़लत थी।',
  'Adhyay ka yeh hissa log dono taraf se galat padhte hain. Kuch ise is baat ka saboot maante hain ki Arjun ki naitikta bahana thi. Kuch kram ko dekhne se hi inkaar kar dete hain. Shloka dono ko sach rehne deta hai, aur satrah adhyay baad bhi kisi ne usse yeh nahi kaha ki uski aapatti galat thi.',
  'Noticing the order does not demote the objection. It just stops it explaining everything.',
  'क्रम देख लेने से आपत्ति छोटी नहीं होती। बस वह हर चीज़ की व्याख्या करना छोड़ देती है।',
  'Kram dekh lene se aapatti chhoti nahi hoti. Bas woh har cheez ki vyakhya karna chhod deti hai.',
  NULL, 'advanced', 'ethics,motives,honesty,refusal'

  UNION ALL SELECT 31, 'everyday_life', 4,
  'Why he did not go to the wedding', 'वह शादी में क्यों नहीं गया', 'Woh shaadi mein kyun nahi gaya',
  'Somebody does not go to a wedding and gives the distance, the cost and the week he was having. All three were real. He also knows, without having admitted it to anybody, that he did not want to be looked at by that particular set of people this year.',
  'कोई एक शादी में नहीं जाता और दूरी, ख़र्च और अपने उस हफ़्ते का हवाला देता है। तीनों असली थे। उसे यह भी पता है, बिना किसी से माने, कि वह इस साल उन ख़ास लोगों की नज़रों में नहीं आना चाहता था।',
  'Koi ek shaadi mein nahi jaata aur doori, kharch aur apne us hafte ka hawala deta hai. Teenon asli the. Use yeh bhi pata hai, bina kisi se maane, ki woh is saal un khaas logon ki nazron mein nahi aana chahta tha.',
  'The verse in a form that costs nothing to check. Three good reasons, all true, all available, and one of them is the one that decided it. Most people can find an example from the last month, and finding one is the whole exercise.',
  'श्लोक ऐसे रूप में जिसे जाँचने में कुछ नहीं लगता। तीन अच्छी वजहें, तीनों सच, तीनों हाज़िर, और उनमें एक वह है जिसने तय किया। ज़्यादातर लोग पिछले महीने से एक उदाहरण निकाल सकते हैं, और एक निकाल लेना ही पूरा अभ्यास है।',
  'Shloka aise roop mein jise jaanchne mein kuch nahi lagta. Teen achhi wajahein, teenon sach, teenon hazir, aur unme ek woh hai jisne tay kiya. Zyadatar log pichhle mahine se ek udaharan nikaal sakte hain, aur ek nikaal lena hi poora abhyas hai.',
  'Three true reasons, and one of them did the deciding.',
  'तीन सच्ची वजहें, और उनमें से एक ने फ़ैसला किया।',
  'Teen sachchi wajahein, aur unme se ek ne faisla kiya.',
  NULL, 'beginner', 'social,avoidance,reasons,honesty'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 1;

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

  SELECT 32 AS vn, 'startup' AS cat, 1 AS ord,
  'The company and the two people it was for' AS t_en, 'कंपनी और वे दो लोग जिनके लिए वह थी' AS t_hi, 'Company aur woh do log jinke liye woh thi' AS t_hing,
  'Two people build something for six years. It works. By the time it works they have not had a conversation that was not about the company in over a year, and one of them is leaving. The thing they built is in excellent health.' AS s_en,
  'दो लोग छह साल में कुछ खड़ा करते हैं। वह चल निकलता है। जब तक वह चलता है, साल भर से ज़्यादा हो चुका है जब उनके बीच कोई ऐसी बातचीत हुई हो जो कंपनी के बारे में न रही हो, और उनमें से एक जा रहा है। जो चीज़ उन्होंने बनाई वह पूरी तरह स्वस्थ है।' AS s_hi,
  'Do log chhah saal mein kuch khada karte hain. Woh chal nikalta hai. Jab tak woh chalta hai, saal bhar se zyada ho chuka hai jab unke beech koi aisi baatcheet hui ho jo company ke baare mein na rahi ho, aur unme se ek ja raha hai. Jo cheez unhone banayi woh poori tarah swasth hai.' AS s_hing,
  'What is a kingdom to us, when the people it was for are standing over there. The verse is asked at the moment of victory rather than defeat, which is what makes it hard to answer. Nothing has gone wrong with the kingdom.' AS c_en,
  'राज्य हमारे किस काम का, जब जिनके लिए वह था वे वहाँ खड़े हैं। यह सवाल हार के नहीं, जीत के पल में पूछा गया है, और इसीलिए इसका जवाब मुश्किल है। राज्य में कुछ भी ग़लत नहीं हुआ।' AS c_hi,
  'Rajya hamare kis kaam ka, jab jinke liye woh tha woh wahan khade hain. Yeh sawal haar ke nahi, jeet ke pal mein poochha gaya hai, aur isiliye iska jawab mushkil hai. Rajya mein kuch bhi galat nahi hua.' AS c_hing,
  'The hardest version of the question is the one you get to ask after winning.' AS l_en,
  'इस सवाल का सबसे कठिन रूप वही है जो जीतने के बाद पूछने को मिलता है।' AS l_hi,
  'Is sawal ka sabse kathin roop wahi hai jo jeetne ke baad poochhne ko milta hai.' AS l_hing,
  NULL AS src, 'intermediate' AS diff, 'startups,success,cost,purpose' AS tags

  UNION ALL SELECT 32, 'marriage', 2,
  'The house with the good kitchen', 'अच्छी रसोई वाला घर', 'Achhi rasoi wala ghar',
  'A couple spends four years and everything they have on a house, choosing the kitchen carefully because of the cooking they were going to do in it. They move in. Neither of them has cooked anything in it that took longer than twenty minutes, and both of them have noticed.',
  'एक जोड़ा चार साल और अपना सब कुछ एक घर पर लगाता है, रसोई ध्यान से चुनते हुए क्योंकि उसमें बहुत कुछ पकाना था। वे रहने आते हैं। दोनों में से किसी ने उसमें बीस मिनट से ज़्यादा का कुछ नहीं पकाया, और दोनों ने यह देखा है।',
  'Ek joda chaar saal aur apna sab kuch ek ghar par lagata hai, rasoi dhyan se chunte hue kyunki usme bahut kuch pakana tha. Woh rehne aate hain. Dono mein se kisi ne usme bees minute se zyada ka kuch nahi pakaya, aur dono ne yeh dekha hai.',
  'Nothing is wrong with the house and nobody has done anything wrong. The verse is not an argument against houses. It is the observation that a thing can be complete, correct and paid for, and have quietly stopped being for whatever it was for.',
  'घर में कुछ ग़लत नहीं है और किसी ने कुछ ग़लत नहीं किया। श्लोक घरों के ख़िलाफ़ दलील नहीं है। यह वह बात है कि कोई चीज़ पूरी हो सकती है, सही हो सकती है, चुकाई जा चुकी हो सकती है — और चुपचाप उस काम की रह न गई हो जिसके लिए वह थी।',
  'Ghar mein kuch galat nahi hai aur kisi ne kuch galat nahi kiya. Shloka gharon ke khilaf dalil nahi hai. Yeh woh baat hai ki koi cheez poori ho sakti hai, sahi ho sakti hai, chukayi ja chuki ho sakti hai — aur chupchap us kaam ki reh na gayi ho jiske liye woh thi.',
  'The kitchen is perfect. It has stopped being for the cooking.',
  'रसोई बेहतरीन है। वह पकाने के लिए रह नहीं गई।',
  'Rasoi behtareen hai. Woh pakane ke liye reh nahi gayi.',
  NULL, 'beginner', 'home,couples,purpose,drift'

  UNION ALL SELECT 32, 'finance', 3,
  'The number he was saving to', 'वह आँकड़ा जिस तक वह बचा रहा था', 'Woh aankda jis tak woh bacha raha tha',
  'Somebody has been saving towards a figure for eleven years. He reaches it in March. In April he sets a new figure, roughly forty per cent higher, without discussing it with anybody, including himself.',
  'कोई ग्यारह साल से एक आँकड़े तक बचत कर रहा है। मार्च में वह वहाँ पहुँच जाता है। अप्रैल में वह क़रीब चालीस फ़ीसदी ऊँचा नया आँकड़ा तय कर लेता है, बिना किसी से बात किए, ख़ुद से भी नहीं।',
  'Koi gyarah saal se ek aankde tak bachat kar raha hai. March mein woh wahan pahunch jaata hai. April mein woh kareeb chalees feesdi ooncha naya aankda tay kar leta hai, bina kisi se baat kiye, khud se bhi nahi.',
  'The verse asks what the kingdom is for. This is what happens when the question is never asked: the target moves, quietly, and the asking is deferred by another eleven years. There is nothing wrong with saving. There is something worth noticing about a target that has never once been allowed to arrive.',
  'श्लोक पूछता है कि राज्य किसलिए है। जब यह सवाल कभी पूछा ही न जाए, तो यही होता है: निशाना चुपचाप खिसक जाता है, और पूछना ग्यारह साल और टल जाता है। बचत में कुछ ग़लत नहीं है। जिस निशाने को कभी पहुँचने ही न दिया गया हो, उसके बारे में ज़रूर कुछ देखने लायक़ है।',
  'Shloka poochhta hai ki rajya kisliye hai. Jab yeh sawal kabhi poochha hi na jaaye, to yahi hota hai: nishana chupchap khisak jaata hai, aur poochhna gyarah saal aur tal jaata hai. Bachat mein kuch galat nahi hai. Jis nishane ko kabhi pahunchne hi na diya gaya ho, uske baare mein zaroor kuch dekhne layak hai.',
  'A target that is never allowed to arrive is not a target. It is a way of not asking.',
  'जिस निशाने को कभी पहुँचने न दिया जाए वह निशाना नहीं है। वह न पूछने का तरीक़ा है।',
  'Jis nishane ko kabhi pahunchne na diya jaaye woh nishana nahi hai. Woh na poochhne ka tareeka hai.',
  NULL, 'intermediate', 'money,goals,deferral,purpose'

  UNION ALL SELECT 32, 'everyday_life', 4,
  'The tickets he still buys', 'वे टिकट जो वह अब भी ख़रीदता है', 'Woh ticket jo woh ab bhi khareedta hai',
  'Somebody buys a season ticket every year for a sport he started watching with his father. His father died four years ago. He has been twice this season and cannot work out whether he wants to go or whether he wants to have gone.',
  'कोई हर साल उस खेल का सीज़न टिकट ख़रीदता है जिसे उसने अपने पिता के साथ देखना शुरू किया था। उसके पिता चार साल पहले गुज़र गए। इस सीज़न वह दो बार गया है और तय नहीं कर पाता कि उसे जाना है या जा चुका होना है।',
  'Koi har saal us khel ka season ticket khareedta hai jise usne apne pita ke saath dekhna shuru kiya tha. Uske pita chaar saal pehle guzar gaye. Is season woh do baar gaya hai aur tay nahi kar paata ki use jaana hai ya ja chuka hona hai.',
  'The verse is asked about a kingdom and it works at any size. It is also worth saying that the verse does not tell him to stop buying the ticket, and neither does anything after it. Asking what a thing is for is not the same as being told to give it up.',
  'श्लोक राज्य के बारे में पूछा गया है और वह हर नाप पर चलता है। यह भी कहने लायक़ है कि श्लोक उसे टिकट ख़रीदना बंद करने को नहीं कहता, और उसके बाद भी कुछ नहीं कहता। किसी चीज़ के बारे में यह पूछना कि वह किसलिए है, उसे छोड़ देने को कह देना नहीं है।',
  'Shloka rajya ke baare mein poochha gaya hai aur woh har naap par chalta hai. Yeh bhi kehne layak hai ki shloka use ticket khareedna band karne ko nahi kehta, aur uske baad bhi kuch nahi kehta. Kisi cheez ke baare mein yeh poochhna ki woh kisliye hai, use chhod dene ko keh dena nahi hai.',
  'Asking what it is for is not the same as being told to stop.',
  'यह पूछना कि वह किसलिए है, यह कहा जाना नहीं है कि रुक जाओ।',
  'Yeh poochhna ki woh kisliye hai, yeh kaha jaana nahi hai ki ruk jao.',
  NULL, 'beginner', 'grief,ritual,purpose,family'

  UNION ALL SELECT 38, 'corporate', 1,
  'Two versions of the same meeting', 'एक ही मीटिंग के दो रूप', 'Ek hi meeting ke do roop',
  'After a bad meeting, one side says the other is protecting their budget and cannot see the bigger picture. The other side, in a different room, says almost exactly the same sentence about them. Both descriptions have supporting evidence and both are delivered calmly.',
  'एक बुरी मीटिंग के बाद एक पक्ष कहता है कि दूसरा अपना बजट बचा रहा है और बड़ी तस्वीर देख नहीं पा रहा। दूसरा पक्ष, किसी और कमरे में, उनके बारे में लगभग वही वाक्य कहता है। दोनों बातों के पास सबूत हैं और दोनों शांति से कही जाती हैं।',
  'Ek buri meeting ke baad ek paksh kehta hai ki doosra apna budget bacha raha hai aur badi tasveer dekh nahi pa raha. Doosra paksh, kisi aur kamre mein, unke baare mein lagbhag wahi vakya kehta hai. Dono baaton ke paas saboot hain aur dono shaanti se kahi jaati hain.',
  'Arjuna''s sentence, twice, from both rooms. Neither side is lying and both have a point. What neither has is a reason to think their own view arrived by a different route from the one they have just diagnosed in the other.',
  'अर्जुन का वाक्य, दो बार, दोनों कमरों से। कोई पक्ष झूठ नहीं बोल रहा और दोनों की बात में दम है। जो किसी के पास नहीं है वह यह वजह है कि उनका अपना नज़रिया किसी और रास्ते से आया होगा, उस रास्ते से नहीं जिसका निदान उन्होंने अभी सामने वाले में किया है।',
  'Arjun ka vakya, do baar, dono kamron se. Koi paksh jhooth nahi bol raha aur dono ki baat mein dum hai. Jo kisi ke paas nahi hai woh yeh wajah hai ki unka apna nazariya kisi aur raaste se aaya hoga, us raaste se nahi jiska nidan unhone abhi saamne wale mein kiya hai.',
  'The sentence works from both rooms. That is the problem with it.',
  'वाक्य दोनों कमरों से चलता है। दिक़्क़त यही है।',
  'Vakya dono kamron se chalta hai. Dikkat yahi hai.',
  NULL, 'intermediate', 'work,conflict,bias,symmetry'

  UNION ALL SELECT 38, 'relationships', 2,
  'One of us is being emotional', 'हममें से एक भावुक हो रहा है', 'Hum mein se ek bhavuk ho raha hai',
  'In the middle of an argument somebody says, quite gently, that the other person is too upset to think about this clearly and they should talk tomorrow. They mean it kindly. It ends the conversation and it ends it in their favour.',
  'झगड़े के बीच कोई काफ़ी नरमी से कहता है कि सामने वाला इतना परेशान है कि इस पर साफ़ नहीं सोच सकता, और कल बात करनी चाहिए। उसका इरादा नेक है। इससे बातचीत ख़त्म हो जाती है, और उसी के हक़ में ख़त्म होती है।',
  'Jhagde ke beech koi kaafi narmi se kehta hai ki saamne wala itna pareshan hai ki is par saaf nahi soch sakta, aur kal baat karni chahiye. Uska iraada nek hai. Isse baatcheet khatam ho jaati hai, aur usi ke haq mein khatam hoti hai.',
  'The move takes about a second and it does not feel like a move. It feels like noticing something. That is what makes it hard to catch, and the verse catches it by putting it in Arjuna''s own mouth immediately after he could not stand up.',
  'इस चाल में क़रीब एक सेकंड लगता है और यह चाल जैसी लगती नहीं। यह कुछ देख लेने जैसी लगती है। इसीलिए इसे पकड़ना मुश्किल है, और श्लोक इसे इस तरह पकड़ता है कि इसे अर्जुन के ही मुँह में रखता है, ठीक उसके बाद जब वह खड़ा नहीं हो पा रहा था।',
  'Is chaal mein kareeb ek second lagta hai aur yeh chaal jaisi lagti nahi. Yeh kuch dekh lene jaisi lagti hai. Isiliye ise pakadna mushkil hai, aur shloka ise is tarah pakadta hai ki ise Arjun ke hi munh mein rakhta hai, theek uske baad jab woh khada nahi ho pa raha tha.',
  'Saying they are too upset to think is a way of winning without arguing.',
  'यह कहना कि वे इतने परेशान हैं कि सोच नहीं सकते, बिना बहस किए जीत जाने का तरीक़ा है।',
  'Yeh kehna ki woh itne pareshan hain ki soch nahi sakte, bina behes kiye jeet jaane ka tareeka hai.',
  NULL, 'intermediate', 'arguments,fairness,calm,power'

  UNION ALL SELECT 38, 'social_media', 3,
  'Everyone on that side is angry', 'उस तरफ़ के सब लोग गुस्से में हैं', 'Us taraf ke sab log gusse mein hain',
  'Somebody reads a thread about a local planning dispute and comes away certain that one side is reasoning and the other side is reacting. Twenty minutes earlier, the same person had described their own position as one they had arrived at "after a lot of thought".',
  'कोई किसी स्थानीय योजना विवाद की थ्रेड पढ़ता है और यह यक़ीन लेकर हटता है कि एक पक्ष तर्क कर रहा है और दूसरा प्रतिक्रिया। बीस मिनट पहले उसी इंसान ने अपनी राय को ऐसा बताया था जिस तक वह "बहुत सोचने के बाद" पहुँचा।',
  'Koi kisi sthaniya yojna vivad ki thread padhta hai aur yeh yakeen lekar hatta hai ki ek paksh tark kar raha hai aur doosra pratikriya. Bees minute pehle usi insaan ne apni raay ko aisa bataya tha jis tak woh "bahut sochne ke baad" pahuncha.',
  'The asymmetry is the whole thing: my view has reasons, theirs has causes. It is not a claim anybody makes deliberately and almost nobody would defend it if it were said plainly. The verse says it plainly, in the voice of the sympathetic character.',
  'पूरी बात इस असंतुलन में है: मेरी राय के पीछे वजहें हैं, उनकी के पीछे कारण। यह दावा कोई जानबूझकर नहीं करता और अगर साफ़-साफ़ कह दिया जाए तो शायद ही कोई इसका बचाव करे। श्लोक इसे साफ़-साफ़ कहता है, और उसी किरदार की आवाज़ में जिससे हमारी सहानुभूति है।',
  'Poori baat is asantulan mein hai: meri raay ke peechhe wajahein hain, unki ke peechhe kaaran. Yeh dawa koi jaanboojhkar nahi karta aur agar saaf saaf keh diya jaaye to shayad hi koi iska bachav kare. Shloka ise saaf saaf kehta hai, aur usi kirdaar ki aawaz mein jisse hamari sahanubhuti hai.',
  'My view has reasons and theirs has causes. Nobody defends that sentence out loud.',
  'मेरी राय के पीछे वजहें हैं और उनकी के पीछे कारण। इस वाक्य का बचाव कोई ज़ोर से नहीं करता।',
  'Meri raay ke peechhe wajahein hain aur unki ke peechhe kaaran. Is vakya ka bachav koi zor se nahi karta.',
  NULL, 'intermediate', 'online,disagreement,asymmetry,honesty'

  UNION ALL SELECT 38, 'everyday_life', 4,
  'The neighbour and the parking space', 'पड़ोसी और पार्किंग की जगह', 'Padosi aur parking ki jagah',
  'Two neighbours have been in a low-grade dispute about a parking space for two years. Each has explained to other people that the other one has "made it about ego". Neither has ever described their own position that way, and neither has ever asked.',
  'दो पड़ोसी दो साल से पार्किंग की एक जगह को लेकर हल्की खटपट में हैं। दोनों ने और लोगों को समझाया है कि सामने वाले ने "इसे अहं का मामला बना दिया"। किसी ने कभी अपनी राय को इस तरह नहीं बताया, और किसी ने कभी पूछा भी नहीं।',
  'Do padosi do saal se parking ki ek jagah ko lekar halki khatpat mein hain. Dono ne aur logon ko samjhaya hai ki saamne wale ne "ise aham ka mamla bana diya". Kisi ne kabhi apni raay ko is tarah nahi bataya, aur kisi ne kabhi poochha bhi nahi.',
  'A small enough example to be able to look at it honestly, which is why it is here and the political version is not. The verse does not tell Arjuna off for this and nothing here tells either neighbour off. It just notes that the sentence gets said in both directions and is never tested in either.',
  'इतना छोटा उदाहरण कि इसे ईमानदारी से देखा जा सके, और इसीलिए यह यहाँ है और राजनीति वाला रूप नहीं है। श्लोक अर्जुन को इसके लिए डाँटता नहीं और यहाँ भी किसी पड़ोसी को डाँटा नहीं जा रहा। बस यह दर्ज है कि वाक्य दोनों तरफ़ से कहा जाता है और किसी तरफ़ कभी जाँचा नहीं जाता।',
  'Itna chhota udaharan ki ise imaandari se dekha ja sake, aur isiliye yeh yahan hai aur rajniti wala roop nahi hai. Shloka Arjun ko iske liye daantta nahi aur yahan bhi kisi padosi ko daanta nahi ja raha. Bas yeh darj hai ki vakya dono taraf se kaha jaata hai aur kisi taraf kabhi jaancha nahi jaata.',
  'Both of them are sure it is the other one who made it personal.',
  'दोनों को यक़ीन है कि इसे निजी बनाने वाला दूसरा है।',
  'Dono ko yakeen hai ki ise niji banane wala doosra hai.',
  NULL, 'beginner', 'neighbours,disputes,ego,symmetry'

  UNION ALL SELECT 46, 'friendship' AS cat, 1,
  'She did not leave the room', 'वह कमरे से नहीं गई', 'Woh kamre se nahi gayi',
  'Somebody says the heaviest sentence they have ever said out loud to a friend, in a kitchen, at about eleven at night. The friend does not have an answer and does not pretend to. She says: I am not going anywhere, and sits back down, and they are both still sitting there at one in the morning.',
  'कोई अपनी ज़िंदगी का सबसे भारी वाक्य एक दोस्त से ज़ोर से कहता है, रसोई में, क़रीब रात ग्यारह बजे। दोस्त के पास जवाब नहीं है और वह होने का दिखावा भी नहीं करती। वह कहती है: मैं कहीं नहीं जा रही, और वापस बैठ जाती है, और रात एक बजे भी दोनों वहीं बैठे हैं।',
  'Koi apni zindagi ka sabse bhaari vakya ek dost se zor se kehta hai, rasoi mein, kareeb raat gyarah baje. Dost ke paas jawab nahi hai aur woh hone ka dikhava bhi nahi karti. Woh kehti hai: main kahin nahi ja rahi, aur wapas baith jaati hai, aur raat ek baje bhi dono wahin baithe hain.',
  'This is what the text does at this exact point. Arjuna says the heaviest sentence in the chapter and what happens next is not a rebuttal, a rescue or a miracle. Somebody stays and keeps talking to him. That is the smallest and least mystical thing in the book and it is the thing the book actually does.',
  'ग्रंथ ठीक इसी जगह यही करता है। अर्जुन अध्याय का सबसे भारी वाक्य कहते हैं और आगे जो होता है वह न खंडन है, न बचाव, न कोई चमत्कार। कोई रुकता है और उससे बात करता रहता है। यह किताब की सबसे छोटी और सबसे कम रहस्यमय चीज़ है और असल में किताब यही करती है।',
  'Granth theek isi jagah yahi karta hai. Arjun adhyay ka sabse bhaari vakya kehte hain aur aage jo hota hai woh na khandan hai, na bachav, na koi chamatkar. Koi rukta hai aur usse baat karta rehta hai. Yeh kitaab ki sabse chhoti aur sabse kam rahasyamay cheez hai aur asal mein kitaab yahi karti hai.',
  'She had no answer. She had the room, and she stayed in it.',
  'उसके पास जवाब नहीं था। उसके पास कमरा था, और वह उसी में रही।',
  'Uske paas jawab nahi tha. Uske paas kamra tha, aur woh usi mein rahi.',
  NULL, 'beginner', 'friendship,listening,staying,heavy-things'

  UNION ALL SELECT 46, 'healthcare', 2,
  'The question the nurse asked plainly', 'वह सवाल जो नर्स ने सीधे पूछा', 'Woh sawal jo nurse ne seedhe poochha',
  'A nurse doing a routine review asks a patient a direct question, in ordinary words, without lowering her voice or looking away. The patient answers it honestly, which surprises them both. Nothing dramatic follows. An appointment gets made and somebody writes a name and a number on a card.',
  'रूटीन जाँच करती एक नर्स मरीज़ से एक सीधा सवाल पूछती है, आम शब्दों में, बिना आवाज़ धीमी किए और बिना नज़र हटाए। मरीज़ ईमानदारी से जवाब देता है, जिससे दोनों हैरान होते हैं। इसके बाद नाटकीय कुछ नहीं होता। एक अपॉइंटमेंट तय होता है और कोई एक कार्ड पर एक नाम और एक नंबर लिख देता है।',
  'Routine jaanch karti ek nurse mareez se ek seedha sawal poochhti hai, aam shabdon mein, bina aawaz dheemi kiye aur bina nazar hataye. Mareez imaandari se jawab deta hai, jisse dono hairan hote hain. Iske baad natakiya kuch nahi hota. Ek appointment tay hota hai aur koi ek card par ek naam aur ek number likh deta hai.',
  'The explanation of this verse says that if the sentence is a live one, what helps is a person and not a chapter. This is what that looks like from the other side of the desk: an ordinary question, asked plainly, by somebody who did not flinch. The verse is not the intervention here and does not pretend to be.',
  'इस श्लोक की व्याख्या कहती है कि अगर वाक्य ज़िंदा है, तो मदद किसी इंसान से मिलती है, किसी अध्याय से नहीं। मेज़ की दूसरी तरफ़ से वह ऐसा दिखता है: एक आम सवाल, सीधे पूछा गया, ऐसे किसी से जो झिझका नहीं। यहाँ श्लोक कोई इलाज नहीं है और होने का दावा भी नहीं करता।',
  'Is shloka ki vyakhya kehti hai ki agar vakya zinda hai, to madad kisi insaan se milti hai, kisi adhyay se nahi. Mez ki doosri taraf se woh aisa dikhta hai: ek aam sawal, seedhe poochha gaya, aise kisi se jo jhijhka nahi. Yahan shloka koi ilaaj nahi hai aur hone ka dawa bhi nahi karta.',
  'The chapter is not the help. A person asking plainly is.',
  'मदद अध्याय नहीं है। सीधे पूछता हुआ कोई इंसान है।',
  'Madad adhyay nahi hai. Seedhe poochhta hua koi insaan hai.',
  NULL, 'beginner', 'health,asking,plain-speech,help'

  UNION ALL SELECT 46, 'college', 3,
  'The message at four in the morning', 'सुबह चार बजे का संदेश', 'Subah chaar baje ka message',
  'A student sends a flatmate a message at four in the morning that is much heavier than anything they have said in person. The flatmate reads it at seven, does not reply in writing, and knocks on the door with two cups of tea before going anywhere.',
  'एक छात्र सुबह चार बजे अपने फ़्लैटमेट को एक संदेश भेजता है जो उसकी किसी भी आमने-सामने कही बात से कहीं भारी है। फ़्लैटमेट उसे सात बजे पढ़ता है, लिखकर जवाब नहीं देता, और कहीं जाने से पहले दो कप चाय लेकर दरवाज़ा खटखटाता है।',
  'Ek student subah chaar baje apne flatmate ko ek message bhejta hai jo uski kisi bhi aamne-saamne kahi baat se kahin bhaari hai. Flatmate use saat baje padhta hai, likhkar jawab nahi deta, aur kahin jaane se pehle do cup chai lekar darwaza khatkhatata hai.',
  'The reply is not the point and there was not a good one available. Turning up is the point. Everything the Gita goes on to say is said by somebody who is physically still there, and this verse is the last thing said before that becomes obvious.',
  'जवाब असली बात नहीं है और कोई अच्छा जवाब मौजूद भी नहीं था। असली बात है पहुँच जाना। गीता आगे जो कुछ कहती है वह कोई ऐसा कहता है जो शरीर से अब भी वहीं मौजूद है, और यह श्लोक वह आख़िरी बात है जो इसके साफ़ होने से पहले कही जाती है।',
  'Jawab asli baat nahi hai aur koi achha jawab maujood bhi nahi tha. Asli baat hai pahunch jaana. Gita aage jo kuch kehti hai woh koi aisa kehta hai jo sharir se ab bhi wahin maujood hai, aur yeh shloka woh aakhiri baat hai jo iske saaf hone se pehle kahi jaati hai.',
  'There was no good reply. Turning up was not a reply.',
  'कोई अच्छा जवाब था ही नहीं। पहुँच जाना जवाब था भी नहीं।',
  'Koi achha jawab tha hi nahi. Pahunch jaana jawab tha bhi nahi.',
  NULL, 'beginner', 'students,flatmates,turning-up,night'

  UNION ALL SELECT 46, 'everyday_life', 4,
  'He asked twice', 'उसने दो बार पूछा', 'Usne do baar poochha',
  'Somebody asks a colleague how they are and gets "fine". They ask again, differently, about ten minutes later, without making anything of it. The second answer is not fine, and it is the first time the colleague has said so to anybody in two months.',
  'कोई एक साथी से पूछता है कि वह कैसा है और जवाब मिलता है "ठीक"। वह क़रीब दस मिनट बाद, अलग तरीक़े से, दोबारा पूछता है, और इसका कोई बड़ा मसला नहीं बनाता। दूसरा जवाब "ठीक" नहीं है, और दो महीनों में यह पहली बार है जब साथी ने किसी से यह कहा है।',
  'Koi ek saathi se poochhta hai ki woh kaisa hai aur jawab milta hai "theek". Woh kareeb das minute baad, alag tareeke se, dobara poochhta hai, aur iska koi bada masla nahi banata. Doosra jawab "theek" nahi hai, aur do mahinon mein yeh pehli baar hai jab saathi ne kisi se yeh kaha hai.',
  'The smallest possible version of what happens after this verse, and the most repeatable. Nobody in this story is qualified, prepared or wise. One person asked a second time. That is the entire intervention and it is available to anybody reading this page.',
  'इस श्लोक के बाद जो होता है, यह उसका सबसे छोटा रूप है और सबसे दोहराने लायक़। इस कहानी में कोई प्रशिक्षित, तैयार या ज्ञानी नहीं है। एक इंसान ने दूसरी बार पूछा। पूरा हस्तक्षेप बस इतना है और यह पन्ना पढ़ने वाले हर किसी के पास मौजूद है।',
  'Is shloka ke baad jo hota hai, yeh uska sabse chhota roop hai aur sabse dohrane layak. Is kahani mein koi prashikshit, taiyar ya gyani nahi hai. Ek insaan ne doosri baar poochha. Poora hastakshep bas itna hai aur yeh panna padhne wale har kisi ke paas maujood hai.',
  'Asking a second time is a whole intervention, and anybody can do it.',
  'दूसरी बार पूछ लेना अपने आप में पूरा हस्तक्षेप है, और यह कोई भी कर सकता है।',
  'Doosri baar poochh lena apne aap mein poora hastakshep hai, aur yeh koi bhi kar sakta hai.',
  NULL, 'beginner', 'asking,colleagues,checking-in,small-steps'

  UNION ALL SELECT 47, 'sports', 1,
  'He sat down on the pitch', 'वह मैदान पर बैठ गया', 'Woh maidan par baith gaya',
  'A player sits down on the grass after a defeat and does not get up for a while. The camera stays on him. Two commentators talk over the pictures. One of them describes what is happening and the other explains what it says about his character.',
  'हार के बाद एक खिलाड़ी घास पर बैठ जाता है और कुछ देर उठता नहीं। कैमरा उसी पर टिका रहता है। तस्वीरों के ऊपर दो कमेंटेटर बोलते हैं। एक बताता है कि हो क्या रहा है और दूसरा समझाता है कि इससे उसके चरित्र के बारे में क्या पता चलता है।',
  'Haar ke baad ek khilaadi ghaas par baith jaata hai aur kuch der uthta nahi. Camera usi par tika rehta hai. Tasveeron ke upar do commentator bolte hain. Ek batata hai ki ho kya raha hai aur doosra samjhata hai ki isse uske charitra ke baare mein kya pata chalta hai.',
  'Sañjaya is the first commentator. He reports a man sitting down, letting go of a bow, and grief — and adds no adjective at all. He does not say weak, does not say cowardly, does not say unbecoming. That absence is the most important thing on the page.',
  'संजय पहले वाले कमेंटेटर हैं। वे एक आदमी के बैठ जाने, धनुष छोड़ देने और शोक का ब्यौरा देते हैं — और एक भी विशेषण नहीं जोड़ते। वे कमज़ोर नहीं कहते, कायर नहीं कहते, अशोभनीय नहीं कहते। पन्ने पर सबसे ज़रूरी चीज़ यही ग़ैरहाज़िरी है।',
  'Sanjay pehle wale commentator hain. Woh ek aadmi ke baith jaane, dhanush chhod dene aur shok ka byora dete hain — aur ek bhi visheshan nahi jodte. Woh kamzor nahi kehte, kaayar nahi kehte, ashobhaniya nahi kehte. Panne par sabse zaroori cheez yahi gairhazri hai.',
  'One of them described it. The other one graded him. Only one of those was reporting.',
  'एक ने ब्यौरा दिया। दूसरे ने अंक दिए। इनमें से रिपोर्टिंग सिर्फ़ एक थी।',
  'Ek ne byora diya. Doosre ne ank diye. Inme se reporting sirf ek thi.',
  NULL, 'beginner', 'sport,defeat,commentary,description'

  UNION ALL SELECT 47, 'corporate', 2,
  'What went in the note', 'नोट में क्या गया', 'Note mein kya gaya',
  'A manager writes up a difficult conversation for the record. The first draft says the person "became defensive and shut down". She rewrites it: the person stopped speaking for about a minute and then asked to continue on Thursday. Both drafts describe the same ninety seconds.',
  'एक मैनेजर रिकॉर्ड के लिए एक मुश्किल बातचीत लिखती है। पहले मसौदे में है कि वह व्यक्ति "बचाव में आ गया और बंद हो गया"। वह दोबारा लिखती है: वह व्यक्ति क़रीब एक मिनट बोलना बंद कर देता है और फिर गुरुवार को जारी रखने को कहता है। दोनों मसौदे उन्हीं नब्बे सेकंड का वर्णन हैं।',
  'Ek manager record ke liye ek mushkil baatcheet likhti hai. Pehle masaude mein hai ki woh vyakti "bachav mein aa gaya aur band ho gaya". Woh dobara likhti hai: woh vyakti kareeb ek minute bolna band kar deta hai aur phir Thursday ko jaari rakhne ko kehta hai. Dono masaude unhi nabbe second ka varnan hain.',
  'The second draft is Sañjaya''s. It costs nothing, survives being read back by the person it is about, and does not decide anything about them that the ninety seconds did not contain. The first draft has a verdict hidden inside two ordinary-sounding words.',
  'दूसरा मसौदा संजय का है। इसमें कुछ ख़र्च नहीं होता, यह उस व्यक्ति के सामने पढ़े जाने पर भी टिकता है जिसके बारे में है, और उसके बारे में कुछ भी ऐसा तय नहीं करता जो उन नब्बे सेकंड में था ही नहीं। पहले मसौदे में दो आम लगते शब्दों के भीतर एक फ़ैसला छिपा है।',
  'Doosra masauda Sanjay ka hai. Isme kuch kharch nahi hota, yeh us vyakti ke saamne padhe jaane par bhi tikta hai jiske baare mein hai, aur uske baare mein kuch bhi aisa tay nahi karta jo un nabbe second mein tha hi nahi. Pehle masaude mein do aam lagte shabdon ke bheetar ek faisla chhipa hai.',
  '"Shut down" is a verdict wearing the clothes of a description.',
  '"बंद हो गया" वर्णन के कपड़े पहने एक फ़ैसला है।',
  '"Band ho gaya" varnan ke kapde pehne ek faisla hai.',
  NULL, 'intermediate', 'work,records,language,judgement'

  UNION ALL SELECT 47, 'parenting', 3,
  'The floor of the hallway', 'गलियारे का फ़र्श', 'Galiyare ka farsh',
  'A teenager sits down on the hallway floor with their back against the wall and does not want to talk. A parent sits down a little way along the same wall, not opposite, and does not ask anything. They stay there for eleven minutes and then somebody mentions dinner.',
  'एक किशोर गलियारे के फ़र्श पर दीवार से टिककर बैठ जाता है और बात नहीं करना चाहता। एक अभिभावक उसी दीवार के साथ थोड़ी दूरी पर बैठ जाता है, सामने नहीं, और कुछ पूछता नहीं। वे ग्यारह मिनट वहाँ बैठे रहते हैं और फिर कोई खाने का ज़िक्र करता है।',
  'Ek kishor galiyare ke farsh par deewar se tikkar baith jaata hai aur baat nahi karna chahta. Ek abhibhavak usi deewar ke saath thodi doori par baith jaata hai, saamne nahi, aur kuch poochhta nahi. Woh gyarah minute wahan baithe rehte hain aur phir koi khane ka zikr karta hai.',
  'The whole of chapter 2 is delivered to somebody sitting on the floor of a chariot, and it is delivered to him rather than about him. Sitting a little way along the same wall is the physical form of that. Nobody in this story called anybody weak either.',
  'पूरा दूसरा अध्याय रथ के फ़र्श पर बैठे किसी को दिया जाता है, और उसके बारे में नहीं, उसी से कहा जाता है। उसी दीवार के साथ थोड़ी दूरी पर बैठना उसी का शारीरिक रूप है। इस कहानी में भी किसी ने किसी को कमज़ोर नहीं कहा।',
  'Poora doosra adhyay rath ke farsh par baithe kisi ko diya jaata hai, aur uske baare mein nahi, usi se kaha jaata hai. Usi deewar ke saath thodi doori par baithna usi ka sharirik roop hai. Is kahani mein bhi kisi ne kisi ko kamzor nahi kaha.',
  'He sat along the same wall, not opposite it. Everything after that was easier.',
  'वह उसी दीवार के साथ बैठा, सामने नहीं। उसके बाद सब कुछ आसान था।',
  'Woh usi deewar ke saath baitha, saamne nahi. Uske baad sab kuch aasan tha.',
  NULL, 'beginner', 'parenting,teenagers,presence,silence'

  UNION ALL SELECT 47, 'everyday_life', 4,
  'The word he had been using about himself', 'वह शब्द जो वह अपने बारे में इस्तेमाल कर रहा था', 'Woh shabd jo woh apne baare mein istemaal kar raha tha',
  'Somebody has been calling a bad six months "pathetic" in his own head, several times a day. Asked to describe the same six months to somebody else without that word, he takes a while, and what comes out is a list of things that happened. He does not recognise it at first.',
  'कोई अपने भीतर, दिन में कई बार, बीते छह ख़राब महीनों को "दयनीय" कह रहा है। जब उससे कहा जाता है कि इन्हीं छह महीनों का वर्णन किसी और से उस शब्द के बिना करे, तो उसे वक़्त लगता है, और जो निकलता है वह उन चीज़ों की सूची है जो हुईं। पहली बार में वह उसे पहचानता नहीं।',
  'Koi apne bheetar, din mein kai baar, beete chhah kharab mahinon ko "dayniya" keh raha hai. Jab usse kaha jaata hai ki inhi chhah mahinon ka varnan kisi aur se us shabd ke bina kare, to use waqt lagta hai, aur jo nikalta hai woh un cheezon ki soochi hai jo hueen. Pehli baar mein woh use pehchanta nahi.',
  'Sañjaya had every opportunity to use a word like that and did not. The absence is available to anybody about themselves, and it is not positive thinking — the list that comes out is not flattering. It is just a list, and a list is a different object from a verdict.',
  'संजय के पास ऐसा शब्द इस्तेमाल करने का पूरा मौक़ा था और उन्होंने नहीं किया। वह ग़ैरहाज़िरी कोई भी अपने बारे में इस्तेमाल कर सकता है, और यह सकारात्मक सोच नहीं है — जो सूची निकलती है वह चापलूसी नहीं करती। वह बस सूची है, और सूची फ़ैसले से अलग चीज़ है।',
  'Sanjay ke paas aisa shabd istemaal karne ka poora mauka tha aur unhone nahi kiya. Woh gairhazri koi bhi apne baare mein istemaal kar sakta hai, aur yeh sakaratmak soch nahi hai — jo soochi nikalti hai woh chaplusi nahi karti. Woh bas soochi hai, aur soochi faisle se alag cheez hai.',
  'Take the adjective out and what is left is a list. A list is a different object.',
  'विशेषण हटा दीजिए और जो बचता है वह सूची है। सूची अलग चीज़ है।',
  'Visheshan hata do aur jo bachta hai woh soochi hai. Soochi alag cheez hai.',
  NULL, 'intermediate', 'self-talk,language,description,honesty'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 1;

-- =====================================================================
-- 5. CROSS REFERENCES
-- =====================================================================
-- THIRTEEN DECLARED. Every target was checked against the seeded verse
-- list before it was written — a reference to an unseeded verse joins
-- to nothing and vanishes without an error. Count the loaded rows
-- against thirteen before shipping.
--
-- The two on 1.46 are the ones that matter. 6.5 is the verse about a
-- person being able to lift themselves, whose own explanation says out
-- loud that this is not a reason to stop asking anybody else for help;
-- 6.40 is the one that says nothing put into this is lost, addressed
-- with the word tāta, "dear one". Between them they are the text''s
-- own answer to 1.46, and they are what a reader on that page should be
-- offered next.
-- =====================================================================

DELETE x FROM verse_cross_references x JOIN verses v ON v.id = x.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 1;

INSERT INTO verse_cross_references
  (verse_id, reference_type, book, chapter, verse, target_verse_id,
   description_en, description_hi, description_hinglish, relationship, sort_order)
SELECT v.id, 'gita', 'Bhagavad Gita', CAST(x.tch AS CHAR), CAST(x.tvn AS CHAR), tv.id,
       x.d_en, x.d_hi, x.d_hing, x.rel, x.ord
FROM (
  SELECT 28 AS vn, 2 AS tch, 14 AS tvn, 1 AS ord,
    'The first substantive thing said back to him. Not "you should not feel that" — the contacts bring cold and heat, and they come and they go. The reply takes the body seriously enough to talk about temperature.' AS d_en,
    'उसे लौटकर कही गई पहली असल बात। यह नहीं कि "तुम्हें ऐसा महसूस नहीं करना चाहिए" — संपर्क ठंड और गर्मी लाते हैं, और वे आते हैं और जाते हैं। जवाब शरीर को इतनी गंभीरता से लेता है कि तापमान की बात करता है।' AS d_hi,
    'Use lautkar kahi gayi pehli asal baat. Yeh nahi ki "tumhe aisa mehsoos nahi karna chahiye" — sampark thand aur garmi laate hain, aur woh aate hain aur jaate hain. Jawab sharir ko itni gambhirta se leta hai ki tapman ki baat karta hai.' AS d_hing,
    'supports' AS rel
  UNION ALL SELECT 29, 6, 35, 1,
    'Arjuna says a thing is impossible and the answer begins asaṁśayam — without doubt, you are right. The text concedes difficulty rather than arguing with it, and chapter 1 is where that habit starts.',
    'अर्जुन कहते हैं कि यह नामुमकिन है और जवाब असंशयम् से शुरू होता है — निस्संदेह, तुम सही हो। ग्रंथ कठिनाई से बहस नहीं करता, उसे मान लेता है, और यह आदत पहले अध्याय से शुरू होती है।',
    'Arjun kehte hain ki yeh namumkin hai aur jawab asamshayam se shuru hota hai — nissandeh, tum sahi ho. Granth kathinai se behes nahi karta, use maan leta hai, aur yeh aadat pehle adhyay se shuru hoti hai.',
    'supports'
  UNION ALL SELECT 30, 2, 62, 1,
    'Bhramati is a mind going round without arriving. 2.62 traces the circuit it goes round: dwelling on a thing, then wanting it, then anger where it is blocked.',
    'भ्रमति वह मन है जो घूमता है और पहुँचता नहीं। 2.62 उस चक्कर को खींचकर दिखाता है: किसी चीज़ पर मन टिकना, फिर चाह, फिर रुकावट पर गुस्सा।',
    'Bhramati woh man hai jo ghoomta hai aur pahunchta nahi. 2.62 us chakkar ko kheenchkar dikhata hai: kisi cheez par man tikna, phir chaah, phir rukawat par gussa.',
    'supports'
  UNION ALL SELECT 30, 6, 34, 2,
    'Arjuna will say later that the mind is restless and as hard to hold as the wind. He is describing here, in chapter 1, the state he only finds words for in chapter 6.',
    'अर्जुन आगे कहेंगे कि मन चंचल है और हवा जितना ही मुश्किल से थमता है। पहले अध्याय में वह उस हालत का वर्णन कर रहा है जिसके लिए शब्द उसे छठे अध्याय में मिलते हैं।',
    'Arjun aage kahenge ki man chanchal hai aur hawa jitna hi mushkil se thamta hai. Pehle adhyay mein woh us haalat ka varnan kar raha hai jiske liye shabd use chhathe adhyay mein milte hain.',
    'same'
  UNION ALL SELECT 31, 2, 47, 1,
    'He says he sees no good coming out of it, which is a sentence about outcomes. 2.47 is the reply, and the reply is that outcomes were never the part he had a claim on.',
    'वह कहता है कि उसे इसमें से कोई भलाई निकलती नहीं दिखती, और यह नतीजों के बारे में वाक्य है। 2.47 जवाब है, और जवाब यह है कि नतीजे कभी वह हिस्सा थे ही नहीं जिस पर उसका दावा था।',
    'Woh kehta hai ki use isme se koi bhalai nikalti nahi dikhti, aur yeh nateejon ke baare mein vakya hai. 2.47 jawab hai, aur jawab yeh hai ki nateeje kabhi woh hissa the hi nahi jis par uska dawa tha.',
    'opposite'
  UNION ALL SELECT 32, 5, 21, 1,
    'What is a kingdom for, asked in chapter 1; a happiness that was not made of anything arriving, described in chapter 5. The second is not a consolation for the first. It is a different address.',
    'पहले अध्याय में पूछा गया कि राज्य किसलिए है; पाँचवें में बताया गया वह सुख जो किसी आने वाली चीज़ से बना ही नहीं। दूसरा पहले की तसल्ली नहीं है। वह अलग पता है।',
    'Pehle adhyay mein poochha gaya ki rajya kisliye hai; paanchve mein bataya gaya woh sukh jo kisi aane wali cheez se bana hi nahi. Doosra pehle ki tasalli nahi hai. Woh alag pata hai.',
    'supports'
  UNION ALL SELECT 32, 5, 22, 2,
    'The kingdom has a beginning and an end, which is 5.22''s whole claim about anything that arrives. Arjuna has worked that out on his own, four chapters early, and it has flattened him.',
    'राज्य का आरंभ है और अंत है, और आने वाली हर चीज़ के बारे में 5.22 का पूरा दावा यही है। अर्जुन यह चार अध्याय पहले ख़ुद समझ चुके हैं, और इसी ने उन्हें बिठा दिया है।',
    'Rajya ka aarambh hai aur ant hai, aur aane wali har cheez ke baare mein 5.22 ka poora dawa yahi hai. Arjun yeh chaar adhyay pehle khud samajh chuke hain, aur isi ne unhe bitha diya hai.',
    'same'
  UNION ALL SELECT 38, 16, 4, 1,
    'Here he sorts the field into those whose judgement has been taken over and those whose has not, and puts himself on one side of it. Chapter 16 is the chapter most often read as licensing exactly that, and its own explanation refuses the reading.',
    'यहाँ वह मैदान को उनमें बाँटता है जिनकी समझ पर क़ब्ज़ा हो चुका है और जिनकी पर नहीं, और ख़ुद को एक तरफ़ रख देता है। सोलहवाँ अध्याय वही है जिसे सबसे ज़्यादा इसी छूट की तरह पढ़ा जाता है, और उसकी अपनी व्याख्या इस पाठ से इनकार करती है।',
    'Yahan woh maidan ko unme baantta hai jinki samajh par kabza ho chuka hai aur jinki par nahi, aur khud ko ek taraf rakh deta hai. Solahvan adhyay wahi hai jise sabse zyada isi chhoot ki tarah padha jaata hai, aur uski apni vyakhya is paath se inkaar karti hai.',
    'opposite'
  UNION ALL SELECT 38, 3, 27, 2,
    'He credits their view to greed and leaves his own uncredited. 3.27 is about the same blind spot at a larger scale: what gets done is credited to a self that was not the whole cause.',
    'वह उनकी राय का श्रेय लोभ को देता है और अपनी का किसी को नहीं। 3.27 इसी अंधे कोने की बड़ी शक्ल है: जो होता है उसका श्रेय एक ऐसे "मैं" को मिल जाता है जो पूरा कारण था ही नहीं।',
    'Woh unki raay ka shrey lobh ko deta hai aur apni ka kisi ko nahi. 3.27 isi andhe kone ki badi shakl hai: jo hota hai uska shrey ek aise "main" ko mil jaata hai jo poora kaaran tha hi nahi.',
    'supports'
  UNION ALL SELECT 46, 6, 5, 1,
    'The verse most worth reading immediately after this one. It says a person is not only acted upon — and its own explanation says, in as many words, that this is not a reason to stop asking anybody else for a rope.',
    'इस श्लोक के तुरंत बाद पढ़ने लायक़ सबसे ज़रूरी श्लोक। वह कहता है कि आदमी सिर्फ़ वह नहीं जिस पर चीज़ें की जाती हैं — और उसकी अपनी व्याख्या साफ़ शब्दों में कहती है कि यह किसी और से रस्सी माँगना बंद कर देने की वजह नहीं है।',
    'Is shloka ke turant baad padhne layak sabse zaroori shloka. Woh kehta hai ki aadmi sirf woh nahi jis par cheezein ki jaati hain — aur uski apni vyakhya saaf shabdon mein kehti hai ki yeh kisi aur se rassi maangna band kar dene ki wajah nahi hai.',
    'opposite'
  UNION ALL SELECT 46, 6, 40, 2,
    'The other one. Nothing you have put into this is lost, and the word used is tāta — dear one, an affectionate address rather than a title. It is the text''s own answer to this verse and it arrives five chapters later.',
    'दूसरा वाला। इसमें आपने जो लगाया वह कुछ भी बेकार नहीं जाता, और जो शब्द इस्तेमाल हुआ है वह है तात — प्रिय, कोई उपाधि नहीं, स्नेह का संबोधन। यह इस श्लोक का ग्रंथ का अपना जवाब है और वह पाँच अध्याय बाद आता है।',
    'Doosra wala. Isme tumne jo lagaya woh kuch bhi bekaar nahi jaata, aur jo shabd istemaal hua hai woh hai taat — priya, koi upadhi nahi, sneh ka sambodhan. Yeh is shloka ka granth ka apna jawab hai aur woh paanch adhyay baad aata hai.',
    'opposite'
  UNION ALL SELECT 47, 18, 63, 1,
    'The first and last things that happen to the same man. Here he sits down without a word being said to him; seven hundred verses later he is told to think it over completely and then do as he wishes. Everything in between was said to somebody on the floor.',
    'एक ही आदमी के साथ होने वाली पहली और आख़िरी चीज़। यहाँ वह बैठ जाता है और उससे एक शब्द नहीं कहा गया; सात सौ श्लोक बाद उससे कहा जाता है कि पूरी तरह सोच लो और फिर जैसा चाहो वैसा करो। बीच का सब कुछ फ़र्श पर बैठे किसी से कहा गया था।',
    'Ek hi aadmi ke saath hone wali pehli aur aakhiri cheez. Yahan woh baith jaata hai aur usse ek shabd nahi kaha gaya; saat sau shloka baad usse kaha jaata hai ki poori tarah soch lo aur phir jaisa chaho waisa karo. Beech ka sab kuch farsh par baithe kisi se kaha gaya tha.',
    'supports'
  UNION ALL SELECT 47, 3, 5, 2,
    'He sits down and stops. 3.5 says nobody stays actionless even for a moment — which is not a rebuke here so much as an observation that sitting down is also something a person is doing.',
    'वह बैठ जाता है और रुक जाता है। 3.5 कहता है कि कोई एक क्षण भी बिना कर्म के नहीं रहता — और यहाँ यह उलाहना कम, यह बात ज़्यादा है कि बैठ जाना भी कुछ करना ही है।',
    'Woh baith jaata hai aur ruk jaata hai. 3.5 kehta hai ki koi ek pal bhi bina karm ke nahi rehta — aur yahan yeh ulahna kam, yeh baat zyada hai ki baith jaana bhi kuch karna hi hai.',
    'opposite'
) AS x
JOIN verses v  ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 1
JOIN chapters tc ON tc.chapter_number = x.tch
JOIN verses tv ON tv.verse_number = x.tvn AND tv.chapter_id = tc.id;

-- =====================================================================
-- 6. WORD BY WORD
-- =====================================================================
-- Three glosses carry weight and none of them may be shortened past
-- what they say:
--   kṣemataram (1.46)  is glossed as safer / more at ease, with the
--                      note that it is a comparison and not a request,
--                      because that is what makes the line recognisable
--                      rather than dramatic.
--   śoka-saṁvigna (1.47) is glossed as overrun by grief, and the gloss
--                      says explicitly that no word for weakness or
--                      cowardice appears anywhere in the verse.
--   bhramati (1.30)    is glossed as going round without arriving,
--                      because a reader who takes it as "confused"
--                      loses the whole second half of the verse.
-- Every gloss stays under 400 characters — verse_word_meanings.meaning_*
-- is varchar(400) and a longer one fails the load outright.
-- =====================================================================

DELETE w FROM verse_word_meanings w JOIN verses v ON v.id = w.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 1;

INSERT INTO verse_word_meanings
  (verse_id, word_order, devanagari, transliteration,
   meaning_en, meaning_hi, meaning_hinglish, grammar, root_word)
SELECT v.id, w.ord, w.dev, w.tr, w.m_en, w.m_hi, w.m_hing, w.gram, w.root FROM (

  SELECT 28 AS vn, 1 AS ord, 'दृष्ट्वा' AS dev, 'dṛṣṭvā' AS tr, 'having seen — the seeing is complete before the rest of the line starts' AS m_en, 'देखकर — बाक़ी पंक्ति शुरू होने से पहले देखना पूरा हो चुका है' AS m_hi, 'dekhkar — baaki line shuru hone se pehle dekhna poora ho chuka hai' AS m_hing, 'gerund' AS gram, 'दृश्' AS root
  UNION ALL SELECT 28, 2, 'स्वजनम्', 'svajanam', 'my own people — sva is "own", the same sva as in svadharma', 'अपने लोग — स्व यानी "अपना", वही स्व जो स्वधर्म में है', 'apne log — sva yani "apna", wahi sva jo swadharm mein hai', 'accusative singular', 'स्व + जन्'
  UNION ALL SELECT 28, 3, 'युयुत्सुम्', 'yuyutsum', 'wanting to fight — a desiderative, "in the state of wanting to"', 'लड़ने का इच्छुक — इच्छार्थक रूप, "चाहने की हालत में"', 'ladne ka ichhuk — ichhaarthak roop, "chahne ki haalat mein"', 'accusative singular', 'युध्'
  UNION ALL SELECT 28, 4, 'सीदन्ति', 'sīdanti', 'give way, sink down — used of legs, and of anything that settles under weight', 'जवाब दे जाते हैं, बैठ जाते हैं — पैरों के लिए, और उस हर चीज़ के लिए जो बोझ से धँस जाए', 'jawab de jaate hain, baith jaate hain — pairon ke liye, aur us har cheez ke liye jo bojh se dhans jaaye', 'present, third plural', 'सद्'
  UNION ALL SELECT 28, 5, 'गात्राणि', 'gātrāṇi', 'limbs, the body''s parts', 'अंग, शरीर के हिस्से', 'ang, sharir ke hisse', 'nominative plural', 'गा'
  UNION ALL SELECT 28, 6, 'परिशुष्यति', 'pariśuṣyati', 'dries up completely — pari is "all round", so it is not partial', 'पूरी तरह सूख जाता है — परि यानी "चारों ओर", यानी आंशिक नहीं', 'poori tarah sookh jaata hai — pari yani "chaaron or", yani aanshik nahi', 'present, third singular', 'परि + शुष्'

  UNION ALL SELECT 29, 1, 'वेपथुः', 'vepathuḥ', 'trembling, shaking', 'कँपकँपी, काँपना', 'kampkampi, kaanpna', 'nominative singular', 'वेप्'
  UNION ALL SELECT 29, 2, 'रोमहर्षः', 'roma-harṣaḥ', 'hair standing up — literally the bristling of body hair', 'रोंगटे खड़े होना — शब्दशः शरीर के रोओं का खड़ा होना', 'rongte khade hona — shabdashah sharir ke royon ka khada hona', 'nominative singular', 'हृष्'
  UNION ALL SELECT 29, 3, 'गाण्डीवम्', 'gāṇḍīvam', 'the Gandiva — the most famous bow in the story, and it is the thing chosen to slip', 'गांडीव — कहानी का सबसे मशहूर धनुष, और फिसलने के लिए यही चुना गया है', 'Gandiv — kahani ka sabse mashhoor dhanush, aur phisalne ke liye yahi chuna gaya hai', 'nominative singular', NULL
  UNION ALL SELECT 29, 4, 'स्रंसते', 'sraṁsate', 'slips, slides down — not thrown, not put down. It goes on its own', 'फिसलता है, खिसकता है — फेंका नहीं, रखा नहीं। वह अपने आप जाता है', 'phisalta hai, khiskta hai — pheka nahi, rakha nahi. Woh apne aap jaata hai', 'present middle, third singular', 'स्रंस्'
  UNION ALL SELECT 29, 5, 'त्वक्', 'tvak', 'skin', 'त्वचा, खाल', 'twacha, khaal', 'nominative singular', NULL
  UNION ALL SELECT 29, 6, 'परिदह्यते', 'paridahyate', 'is burning all over — passive, and pari again: all round, not in one place', 'चारों ओर जल रही है — कर्मवाच्य, और फिर परि: चारों ओर, किसी एक जगह नहीं', 'chaaron or jal rahi hai — karmvachya, aur phir pari: chaaron or, kisi ek jagah nahi', 'passive, third singular', 'परि + दह्'

  UNION ALL SELECT 30, 1, 'न शक्नोमि', 'na śaknomi', 'I am not able — the verb is ability, not permission and not willingness', 'मैं नहीं कर पा रहा — क्रिया सामर्थ्य की है, इजाज़त या इच्छा की नहीं', 'main nahi kar pa raha — kriya samarthya ki hai, ijazat ya ichha ki nahi', 'present, first singular', 'शक्'
  UNION ALL SELECT 30, 2, 'अवस्थातुम्', 'avasthātum', 'to stand, to stay standing — the root is the same one as in "state" and "steady"', 'खड़ा रहना, टिके रहना — धातु वही है जो "अवस्था" और "स्थिर" में है', 'khada rehna, tike rehna — dhatu wahi hai jo "avastha" aur "sthir" mein hai', 'infinitive', 'अव + स्था'
  UNION ALL SELECT 30, 3, 'भ्रमति इव', 'bhramati iva', 'seems to be going round — bhram is spinning on its own axis, like a wheel. It is movement WITHOUT arriving, which is why "confused" loses the verse', 'जैसे घूम रहा हो — भ्रम् यानी अपनी ही धुरी पर घूमना, पहिये जैसा। यह गति है, पहुँचना नहीं, और इसीलिए "उलझन" इस श्लोक को खो देता है', 'jaise ghoom raha ho — bhram yani apni hi dhuri par ghoomna, pahiye jaisa. Yeh gati hai, pahunchna nahi, aur isiliye "uljhan" is shloka ko kho deta hai', 'present, third singular', 'भ्रम्'
  UNION ALL SELECT 30, 4, 'निमित्तानि', 'nimittāni', 'signs, omens — things read as pointing at something else', 'निमित्त, संकेत — वे चीज़ें जो किसी और की तरफ़ इशारा मानी जाती हैं', 'nimitta, sanket — woh cheezein jo kisi aur ki taraf ishara maani jaati hain', 'accusative plural', NULL
  UNION ALL SELECT 30, 5, 'विपरीतानि', 'viparītāni', 'turned the other way, contrary — the signs are not absent, they are pointing the wrong way', 'उलटे हुए, विपरीत — संकेत ग़ैरहाज़िर नहीं हैं, वे उलटी दिशा में इशारा कर रहे हैं', 'ulte hue, viparit — sanket gairhazir nahi hain, woh ulti disha mein ishara kar rahe hain', 'accusative plural', 'वि + परि + इ'

  UNION ALL SELECT 31, 1, 'श्रेयः', 'śreyaḥ', 'good, better — the same word the whole book keeps returning to when it asks what is worth doing', 'श्रेय — भला, बेहतर; वही शब्द जिस पर पूरी किताब बार-बार लौटती है जब वह पूछती है कि करने लायक़ क्या है', 'shrey — bhala, behtar; wahi shabd jis par poori kitaab baar baar lautti hai jab woh poochhti hai ki karne layak kya hai', 'nominative singular', 'श्री'
  UNION ALL SELECT 31, 2, 'अनुपश्यामि', 'anupaśyāmi', 'I see, I see following on — anu carries "along after", so it is seeing consequences rather than objects', 'मैं देखता हूँ, आगे तक देखता हूँ — अनु में "पीछे-पीछे" है, तो यह चीज़ों को नहीं, नतीजों को देखना है', 'main dekhta hoon, aage tak dekhta hoon — anu mein "peechhe peechhe" hai, to yeh cheezon ko nahi, nateejon ko dekhna hai', 'present, first singular', 'अनु + दृश्'
  UNION ALL SELECT 31, 3, 'हत्वा', 'hatvā', 'having killed', 'मारकर', 'maarkar', 'gerund', 'हन्'
  UNION ALL SELECT 31, 4, 'आहवे', 'āhave', 'in battle', 'युद्ध में', 'yuddh mein', 'locative singular', 'आ + ह्वे'
  UNION ALL SELECT 31, 5, 'न काङ्क्षे', 'na kāṅkṣe', 'I do not want — kāṅkṣ is wanting with a lean towards, closer to longing than to choosing', 'मैं नहीं चाहता — काङ्क्ष् में झुकाव वाली चाह है, चुनने से ज़्यादा तरसने के पास', 'main nahi chahta — kanksh mein jhukav wali chaah hai, chunne se zyada tarasne ke paas', 'present middle, first singular', 'काङ्क्ष्'

  UNION ALL SELECT 32, 1, 'किम् नः राज्येन', 'kiṁ naḥ rājyena', 'what is a kingdom to us — the instrumental makes it "by means of", so: what would we do with one', 'राज्य से हमारा क्या — करण कारक इसे "किसके ज़रिए" बनाता है, यानी: उसका हम करेंगे क्या', 'rajya se hamara kya — karan karak ise "kiske zariye" banata hai, yani: uska hum karenge kya', 'instrumental singular', 'राज्'
  UNION ALL SELECT 32, 2, 'भोगैः', 'bhogaiḥ', 'by enjoyments, by the things a kingdom gets you', 'भोगों से, उन चीज़ों से जो राज्य दिलाता है', 'bhogon se, un cheezon se jo rajya dilata hai', 'instrumental plural', 'भुज्'
  UNION ALL SELECT 32, 3, 'जीवितेन', 'jīvitena', 'by life itself — he includes his own life in the list of things whose point is in question', 'ख़ुद जीवन से — वह अपने जीवन को भी उन चीज़ों में गिन लेता है जिनका मतलब सवाल में है', 'khud jeevan se — woh apne jeevan ko bhi un cheezon mein gin leta hai jinka matlab sawal mein hai', 'instrumental singular', 'जीव्'
  UNION ALL SELECT 32, 4, 'येषाम् अर्थे', 'yeṣām arthe', 'for whose sake — artha is purpose, and the whole verse turns on this phrase', 'जिनके लिए — अर्थ यानी प्रयोजन, और पूरा श्लोक इसी वाक्यांश पर घूमता है', 'jinke liye — arth yani prayojan, aur poora shloka isi vakyansh par ghoomta hai', 'genitive plural + locative', 'अर्थ'
  UNION ALL SELECT 32, 5, 'काङ्क्षितम्', 'kāṅkṣitam', 'wanted, longed for — past participle: the wanting is already done', 'चाहा हुआ — भूत कृदंत: चाहना पहले ही हो चुका है', 'chaha hua — bhoot kridant: chahna pehle hi ho chuka hai', 'past participle', 'काङ्क्ष्'

  UNION ALL SELECT 38, 1, 'यदि अपि', 'yady api', 'even if — the sentence is built as a concession from the start', 'भले ही — वाक्य शुरू से ही रियायत की शक्ल में बना है', 'bhale hi — vakya shuru se hi riyayat ki shakl mein bana hai', 'indeclinable', NULL
  UNION ALL SELECT 38, 2, 'न पश्यन्ति', 'na paśyanti', 'they do not see — the same root as in 1.28 and 5.18, and it is doing the same work: seeing, not opinion', 'उन्हें दिखता नहीं — वही धातु जो 1.28 और 5.18 में है, और वही काम कर रही है: देखना, राय नहीं', 'unhe dikhta nahi — wahi dhatu jo 1.28 aur 5.18 mein hai, aur wahi kaam kar rahi hai: dekhna, raay nahi', 'present, third plural', 'दृश्'
  UNION ALL SELECT 38, 3, 'लोभोपहतचेतसः', 'lobhopahata-cetasaḥ', 'their understanding struck down by greed — upahata is "struck", so the claim is that something happened TO their judgement', 'जिनकी चेतना लोभ से आहत है — उपहत यानी "मारा हुआ", यानी दावा यह है कि उनकी समझ के साथ कुछ हुआ', 'jinki chetna lobh se aahat hai — upahat yani "maara hua", yani dawa yeh hai ki unki samajh ke saath kuch hua', 'nominative plural', 'उप + हन्'
  UNION ALL SELECT 38, 4, 'कुलक्षयकृतम् दोषम्', 'kula-kṣaya-kṛtaṁ doṣam', 'the wrong done by the breaking of a family', 'कुल के नाश से हुआ दोष', 'kul ke naash se hua dosh', 'accusative singular', 'क्षि, कृ'
  UNION ALL SELECT 38, 5, 'मित्रद्रोहे', 'mitra-drohe', 'in the betrayal of a friend — droha is turning on somebody who trusted you', 'मित्र से द्रोह में — द्रोह यानी उस पर पलटना जिसने भरोसा किया', 'mitra se droh mein — droh yani us par palatna jisne bharosa kiya', 'locative singular', 'द्रुह्'
  UNION ALL SELECT 38, 6, 'पातकम्', 'pātakam', 'a fall, a grave wrong — from the root for falling', 'पातक — गिरना, गंभीर पाप; धातु गिरने की है', 'paatak — girna, gambhir paap; dhatu girne ki hai', 'accusative singular', 'पत्'

  UNION ALL SELECT 46, 1, 'अप्रतीकारम्', 'apratīkāram', 'making no counter-move, not resisting — prati-kāra is the answering action, and the a- removes it', 'जो कोई पलटवार न करे, प्रतिरोध न करे — प्रतीकार जवाबी कर्म है, और अ- उसे हटा देता है', 'jo koi palatvaar na kare, pratirodh na kare — pratikaar jawabi karm hai, aur a- use hata deta hai', 'accusative singular', 'प्रति + कृ'
  UNION ALL SELECT 46, 2, 'अशस्त्रम्', 'aśastram', 'without a weapon', 'बिना हथियार के', 'bina hathiyar ke', 'accusative singular', 'शस्'
  UNION ALL SELECT 46, 3, 'शस्त्रपाणयः', 'śastra-pāṇayaḥ', 'weapons in hand — said of them, in the same line where he has none', 'हाथ में हथियार लिए — उनके लिए कहा गया, उसी पंक्ति में जहाँ उसके पास कोई नहीं', 'haath mein hathiyar liye — unke liye kaha gaya, usi line mein jahan uske paas koi nahi', 'nominative plural', 'पाणि'
  UNION ALL SELECT 46, 4, 'क्षेमतरम्', 'kṣemataram', 'safer, more at ease — kṣema is well-being and the -tara is a comparative. He is comparing two futures and reporting which looks lighter. It is not a request and not a threat, and that is what makes the line recognisable rather than dramatic', 'ज़्यादा सुरक्षित, ज़्यादा हल्का — क्षेम यानी कुशल होना और -तर तुलनात्मक है। वह दो भविष्यों की तुलना कर रहा है और बता रहा है कि कौन-सा हल्का दिखता है। यह न माँग है न धमकी, और यही इसे नाटकीय नहीं, पहचाना हुआ बनाता है', 'zyada surakshit, zyada halka — kshem yani kushal hona aur -tar tulnatmak hai. Woh do bhavishyon ki tulna kar raha hai aur bata raha hai ki kaun sa halka dikhta hai. Yeh na maang hai na dhamki, aur yahi ise natakiya nahi, pehchana hua banata hai', 'accusative singular, comparative', 'क्षि'
  UNION ALL SELECT 46, 5, 'भवेत्', 'bhavet', 'would be — optative. The whole sentence is in the conditional and never leaves it', 'होता — विधिलिङ्। पूरा वाक्य शर्त में है और उससे बाहर कभी नहीं निकलता', 'hota — vidhiling. Poora vakya shart mein hai aur usse bahar kabhi nahi nikalta', 'optative, third singular', 'भू'

  UNION ALL SELECT 47, 1, 'एवम् उक्त्वा', 'evam uktvā', 'having spoken thus — the speech is over and what follows is action', 'यह कहकर — भाषण ख़त्म, और आगे जो है वह कर्म है', 'yeh kehkar — bhashan khatam, aur aage jo hai woh karm hai', 'gerund', 'वच्'
  UNION ALL SELECT 47, 2, 'रथोपस्थे', 'rathopasthe', 'on the seat of the chariot — the floor of it, not a throne', 'रथ के आसन पर — उसके फ़र्श पर, किसी सिंहासन पर नहीं', 'rath ke aasan par — uske farsh par, kisi sinhasan par nahi', 'locative singular', 'उप + स्था'
  UNION ALL SELECT 47, 3, 'उपाविशत्', 'upāviśat', 'sat down — an ordinary verb, used the way anybody sits down anywhere', 'बैठ गया — आम क्रिया, वैसी ही जैसे कोई कहीं भी बैठता है', 'baith gaya — aam kriya, waisi hi jaise koi kahin bhi baithta hai', 'past, third singular', 'उप + विश्'
  UNION ALL SELECT 47, 4, 'विसृज्य', 'visṛjya', 'having released, having let go — the same root as in "release"; not thrown down, not surrendered', 'छोड़कर, हाथ से जाने देकर — वही धातु जो "विसर्जन" में है; न पटका गया, न सौंपा गया', 'chhodkar, haath se jaane dekar — wahi dhatu jo "visarjan" mein hai; na pataka gaya, na saunpa gaya', 'gerund', 'वि + सृज्'
  UNION ALL SELECT 47, 5, 'सशरम् चापम्', 'sa-śaraṁ cāpam', 'the bow along with the arrows — both named, so nothing is left in his hands', 'बाणों समेत धनुष — दोनों का नाम लिया गया है, ताकि हाथ में कुछ न बचे', 'baanon samet dhanush — dono ka naam liya gaya hai, taaki haath mein kuch na bache', 'accusative singular', NULL
  UNION ALL SELECT 47, 6, 'शोकसंविग्नमानसः', 'śoka-saṁvigna-mānasaḥ', 'mind overrun by grief — saṁvigna is being thoroughly shaken. Note what is NOT here: no word for weak, cowardly, unmanly or unbecoming appears anywhere in the verse, and Sañjaya had every opportunity to use one', 'शोक से विह्वल मन — संविग्न यानी पूरी तरह हिल जाना। यह देखिए कि यहाँ क्या नहीं है: कमज़ोर, कायर, नामर्द या अशोभनीय जैसा एक भी शब्द इस श्लोक में कहीं नहीं है, और संजय के पास इस्तेमाल करने का पूरा मौक़ा था', 'shok se vihval man — samvigna yani poori tarah hil jaana. Yeh dekho ki yahan kya nahi hai: kamzor, kaayar, namard ya ashobhaniya jaisa ek bhi shabd is shloka mein kahin nahi hai, aur Sanjay ke paas istemaal karne ka poora mauka tha', 'nominative singular', 'सम् + विज्'
) AS w
JOIN verses v ON v.verse_number = w.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 1;
