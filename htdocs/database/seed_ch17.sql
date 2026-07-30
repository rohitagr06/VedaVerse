-- =====================================================================
-- VedaVerse — database/seed_ch17.sql
-- =====================================================================
-- Chapter 17, Śraddhātraya Vibhāga Yoga. Eight verses. Third chapter of
-- the INTERMEDIATE track (2, 3, 4, 5, 6, 12, 13, 14, 16, 17, 18).
--
--   17.2   three kinds, and where they come from        [CARE]
--   17.3   you are what your śraddhā is                 [CARE]
--   17.7   food too comes in three kinds                [CARE]
--   17.15  the discipline of speech
--   17.16  the discipline of the mind
--   17.19  practice done by hurting yourself            [CARE]
--   17.20  giving to somebody who cannot repay you
--   17.28  done without śraddhā, it does not count
--
-- THIS CHAPTER HAS MORE CARE-VERSES THAN ANY OTHER IN THE CORPUS, AND
-- THEY ALL POINT THE SAME WAY: AT THE READER'S OWN WELLBEING.
--
-- 17.7 IS 6.17 AGAIN, WITH SHARPER TEETH
--   A verse that sorts food is a verse somebody restricting their
--   eating can read as a licence. The defence is the same and it is
--   also the text's own: the verse sorts by WHAT FOOD DOES, never by
--   how much of it there is. No amount appears in the Sanskrit and none
--   appears anywhere in this file. And the chapter itself rules out the
--   misuse twelve verses later, which is why 17.19 is in this batch.
--
-- 17.19 IS THE STRONGEST WELLBEING SENTENCE IN THE BOOK
--   Practice undertaken with stubborn delusion, by hurting yourself, is
--   named and placed in the lowest category by the text itself. Any
--   reader who has turned a practice into a punishment is not being
--   asked to try harder — they are being told, by the book, that they
--   have the wrong thing. The explanation says this plainly and
--   smoke-test.sh asserts it on the default render.
--
-- 17.2 AND 17.3 HAVE THE OPPOSITE TRAP AND IT IS A TWO-SIDED ONE
--   svabhāva-jā, "born of one's own nature", must NOT be read as
--   determined by birth, family or community — that reading is the same
--   move as 4.13 and this file refuses it in the explanation and in the
--   gloss. And "a person is what their śraddhā is" must not become
--   believe-hard-enough-and-it-is-true; the chapter's whole method is
--   the opposite, which is that you find out what somebody trusts by
--   watching what they eat, say and give, not by asking them.
--
-- CONTENT RULES — unchanged
--   Original writing throughout. Sanskrit unaltered, numbering
--   untouched. No praise or criticism of any living politician, party
--   or movement. No communal framing. NO PRACTICE, EXAMPLE OR
--   REFLECTION IN THIS FILE NAMES AN AMOUNT, A DURATION OF FASTING, A
--   WEIGHT, A CALORIE, A SLEEP TARGET OR A REGIMEN.
--
-- RUN AFTER seed_sample.sql. Re-runnable.
--
--     mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
--         < htdocs/database/seed_ch17.sql
--
-- global_order is 595 + verse_number: chapters 1 to 16 have 595 verses.
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

  SELECT 2 AS verse_number, 597 AS global_order, 1 AS is_curated, 'gita-17-2' AS slug,
    'त्रिविधा भवति श्रद्धा देहिनां सा स्वभावजा।\nसात्त्विकी राजसी चैव तामसी चेति तां शृणु॥' AS sanskrit_devanagari,
    'tri-vidhā bhavati śraddhā dehināṁ sā svabhāva-jā\nsāttvikī rājasī caiva tāmasī ceti tāṁ śṛṇu' AS transliteration_iast,
    'tri-vidha bhavati shraddha dehinam sa svabhava-ja\nsattviki rajasi chaiva tamasi cheti tam shrinu' AS transliteration_simple,
    'The faith of embodied beings is of three kinds, born of their own nature: sattvic, rajasic and tamasic. Hear about it.' AS translation_literal,
    'What people trust comes in three kinds, and it grows out of what they are already made of. Clear, restless, or shut down. Here is how to tell.' AS translation_en,
    'लोग जिस पर भरोसा करते हैं वह तीन तरह का होता है, और वह उसी से उगता है जिससे वे पहले से बने हैं। साफ़, बेचैन, या बुझा हुआ। पहचानने का तरीक़ा यह है।' AS translation_hi,
    'Log jis par bharosa karte hain woh teen tarah ka hota hai, aur woh usi se ugta hai jisse woh pehle se bane hain. Saaf, bechain, ya bujha hua. Pehchanne ka tareeka yeh hai.' AS translation_hinglish,
    'Three kinds, and they grow out of what a person already is. Not out of where they were born.' AS summary_en,
    'तीन तरह की, और वे उसी से उगती हैं जो इंसान पहले से है। इससे नहीं कि वह पैदा कहाँ हुआ।' AS summary_hi,
    'Teen tarah ki, aur woh usi se ugti hain jo insaan pehle se hai. Isse nahi ki woh paida kahan hua.' AS summary_hinglish,
    'intermediate' AS difficulty,
    'Gita 17.2: three kinds of trust, and where they grow from' AS seo_title,
    'The Bhagavad Gita sorts what people trust into three kinds and says it grows out of their own nature. Svabhava-ja does not mean determined by birth.' AS seo_description,
    1 AS published

  UNION ALL SELECT 3, 598, 1, 'gita-17-3',
    'सत्त्वानुरूपा सर्वस्य श्रद्धा भवति भारत।\nश्रद्धामयोऽयं पुरुषो यो यच्छ्रद्धः स एव सः॥',
    'sattvānurūpā sarvasya śraddhā bhavati bhārata\nśraddhāmayo ''yaṁ puruṣo yo yac-chraddhaḥ sa eva saḥ',
    'sattvanurupa sarvasya shraddha bhavati bharata\nshraddhamayo yam purusho yo yach-chhraddhah sa eva sah',
    'Everyone''s faith is according to their inner constitution. A person is made of faith: whatever their faith is, that is exactly what they are.',
    'What a person trusts fits what they are made of. And a person is made of what they trust — whatever it is they are trusting, that is what they are.',
    'इंसान जिस पर भरोसा करता है वह उसी से मेल खाता है जिससे वह बना है। और इंसान बना ही उससे है जिस पर वह भरोसा करता है — वह जिस पर भी भरोसा कर रहा हो, वही वह है।',
    'Insan jis par bharosa karta hai woh usi se mel khata hai jisse woh bana hai. Aur insan bana hi usse hai jis par woh bharosa karta hai — woh jis par bhi bharosa kar raha ho, wahi woh hai.',
    'The chapter''s one famous line. It is a description of how to find somebody out, not a promise about believing hard.',
    'अध्याय की एक मशहूर पंक्ति। यह किसी को पहचानने का तरीक़ा बताती है, ज़ोर से यक़ीन करने का वादा नहीं करती।',
    'Adhyay ki ek mashhoor line. Yeh kisi ko pehchanne ka tareeka batati hai, zor se yakeen karne ka waada nahi karti.',
    'intermediate',
    'Gita 17.3: whatever you trust, that is what you are',
    'The Bhagavad Gita says a person is made of their shraddha. It is a way of finding out what somebody actually trusts, not a claim that believing makes things true.',
    1

  UNION ALL SELECT 7, 602, 1, 'gita-17-7',
    'आहारस्त्वपि सर्वस्य त्रिविधो भवति प्रियः।\nयज्ञस्तपस्तथा दानं तेषां भेदमिमं शृणु॥',
    'āhāras tv api sarvasya tri-vidho bhavati priyaḥ\nyajñas tapas tathā dānaṁ teṣāṁ bhedam imaṁ śṛṇu',
    'aharas tv api sarvasya tri-vidho bhavati priyah\nyajnas tapas tatha danam tesham bhedam imam shrinu',
    'The food that is dear to each is also of three kinds, and so are sacrifice, austerity and giving. Hear the distinction between them.',
    'What a person likes to eat also comes in three kinds. So does what they offer, what they practise and what they give. Here is what separates them.',
    'इंसान को खाने में जो पसंद है वह भी तीन तरह का होता है। वैसे ही वह जो चढ़ाता है, जो अभ्यास करता है, जो देता है। इनमें फ़र्क़ यह है।',
    'Insan ko khane mein jo pasand hai woh bhi teen tarah ka hota hai. Waise hi woh jo chadhata hai, jo abhyas karta hai, jo deta hai. Inme farq yeh hai.',
    'It sorts food by what it does, and never once by how much of it there is.',
    'यह खाने को इस आधार पर छाँटता है कि वह करता क्या है, और कभी इस आधार पर नहीं कि कितना है।',
    'Yeh khane ko is aadhar par chhaanta hai ki woh karta kya hai, aur kabhi is aadhar par nahi ki kitna hai.',
    'intermediate',
    'Gita 17.7: food sorted by what it does, never by how much',
    'The Bhagavad Gita sorts food into three kinds. No amount appears anywhere in the verse, and twelve verses later the chapter rules out practice that hurts you.',
    1

  UNION ALL SELECT 15, 610, 1, 'gita-17-15',
    'अनुद्वेगकरं वाक्यं सत्यं प्रियहितं च यत्।\nस्वाध्यायाभ्यसनं चैव वाङ्मयं तप उच्यते॥',
    'anudvega-karaṁ vākyaṁ satyaṁ priya-hitaṁ ca yat\nsvādhyāyābhyasanaṁ caiva vāṅ-mayaṁ tapa ucyate',
    'anudvega-karam vakyam satyam priya-hitam cha yat\nsvadhyayabhyasanam chaiva van-mayam tapa uchyate',
    'Speech that causes no agitation, that is true, pleasant and beneficial, along with the regular practice of self-study — that is called the austerity of speech.',
    'Words that do not set somebody off. True. Not unkind. Actually useful. And the habit of reading yourself back. That is what discipline looks like when it happens in speech.',
    'ऐसे शब्द जो किसी को भड़काएँ नहीं। सच्चे। कठोर नहीं। सचमुच काम के। और ख़ुद को दोबारा पढ़ने की आदत। बोली में जब अनुशासन उतरता है तो वह ऐसा दिखता है।',
    'Aise shabd jo kisi ko bhadkayein nahi. Sachche. Kathor nahi. Sach mein kaam ke. Aur khud ko dobara padhne ki aadat. Boli mein jab anushasan utarta hai to woh aisa dikhta hai.',
    'Four conditions at once, and true is only one of them.',
    'एक साथ चार शर्तें, और सच होना उनमें से सिर्फ़ एक है।',
    'Ek saath chaar shartein, aur sach hona unme se sirf ek hai.',
    'intermediate',
    'Gita 17.15: true is only one of the four conditions on speech',
    'The Bhagavad Gita asks that speech be non-agitating, true, kind and useful all at once. Being right satisfies one of the four.',
    1

  UNION ALL SELECT 16, 611, 1, 'gita-17-16',
    'मनःप्रसादः सौम्यत्वं मौनमात्मविनिग्रहः।\nभावसंशुद्धिरित्येतत्तपो मानसमुच्यते॥',
    'manaḥ-prasādaḥ saumyatvaṁ maunam ātma-vinigrahaḥ\nbhāva-saṁśuddhir ity etat tapo mānasam ucyate',
    'manah-prasadah saumyatvam maunam atma-vinigrahah\nbhava-samshuddhir ity etat tapo manasam uchyate',
    'Clearness of mind, gentleness, silence, self-restraint, purity of intent — this is called the austerity of the mind.',
    'A settled mind. Gentleness. Being quiet. Some hold on yourself. And meaning what you appear to mean. That is the discipline that happens where nobody can see it.',
    'ठहरा हुआ मन। नरमी। चुप रहना। अपने ऊपर कुछ पकड़। और वही मतलब रखना जो दिखता है। यह वह अनुशासन है जो वहाँ होता है जहाँ कोई देख नहीं सकता।',
    'Thehra hua man. Narmi. Chup rehna. Apne upar kuch pakad. Aur wahi matlab rakhna jo dikhta hai. Yeh woh anushasan hai jo wahan hota hai jahan koi dekh nahi sakta.',
    'The first item is prasāda — settled, clear, not strained. Discipline of the mind starts by not being harsh with it.',
    'पहली चीज़ है प्रसाद — ठहरा हुआ, साफ़, तना हुआ नहीं। मन का अनुशासन उससे सख़्ती न बरतने से शुरू होता है।',
    'Pehli cheez hai prasad — thehra hua, saaf, tana hua nahi. Man ka anushasan usse sakhti na baratne se shuru hota hai.',
    'intermediate',
    'Gita 17.16: the discipline of the mind starts with settling it',
    'The Bhagavad Gita lists the austerity of the mind and puts clearness first. Gentleness is on the list. Harshness is not.',
    1

  UNION ALL SELECT 19, 614, 1, 'gita-17-19',
    'मूढग्राहेणात्मनो यत्पीडया क्रियते तपः।\nपरस्योत्सादनार्थं वा तत्तामसमुदाहृतम्॥',
    'mūḍha-grāheṇātmano yat pīḍayā kriyate tapaḥ\nparasyotsādanārthaṁ vā tat tāmasam udāhṛtam',
    'mudha-grahenatmano yat pidaya kriyate tapah\nparasyotsadanartham va tat tamasam udahritam',
    'Austerity undertaken with deluded stubbornness, involving self-torture, or done in order to destroy another, is declared to be tamasic.',
    'Practice taken up out of a stubborn wrong idea, done by hurting yourself, or done to wreck somebody else — the text puts that in the bottom category by name.',
    'ऐसा अभ्यास जो किसी ज़िद भरे ग़लत ख़याल से उठाया गया हो, ख़ुद को तकलीफ़ देकर किया जाता हो, या किसी और को तबाह करने के लिए हो — ग्रंथ उसे नाम लेकर सबसे नीचे रखता है।',
    'Aisa abhyas jo kisi zid bhare galat khayal se uthaya gaya ho, khud ko takleef dekar kiya jaata ho, ya kisi aur ko tabah karne ke liye ho — granth use naam lekar sabse neeche rakhta hai.',
    'The book''s own sentence against practice as punishment. It is not a warning. It is a category.',
    'अभ्यास को सज़ा बना लेने के ख़िलाफ़ ख़ुद ग्रंथ का वाक्य। यह चेतावनी नहीं है। यह श्रेणी है।',
    'Abhyas ko saza bana lene ke khilaf khud granth ka vakya. Yeh chetavni nahi hai. Yeh shreni hai.',
    'intermediate',
    'Gita 17.19: practice done by hurting yourself is named and ranked lowest',
    'The Bhagavad Gita puts austerity undertaken with self-torture in its lowest category by name. Anybody who has turned a practice into a punishment is not being asked to try harder.',
    1

  UNION ALL SELECT 20, 615, 1, 'gita-17-20',
    'दातव्यमिति यद्दानं दीयतेऽनुपकारिणे।\nदेशे काले च पात्रे च तद्दानं सात्त्विकं स्मृतम्॥',
    'dātavyam iti yad dānaṁ dīyate ''nupakāriṇe\ndeśe kāle ca pātre ca tad dānaṁ sāttvikaṁ smṛtam',
    'datavyam iti yad danam diyate nupakarine\ndeshe kale cha patre cha tad danam sattvikam smritam',
    'Giving that is given because it should be given, to one who cannot return the favour, in the right place, at the right time, to a fit recipient — that giving is remembered as sattvic.',
    'Giving because it ought to be given, to somebody who cannot pay you back, at a place and a time and to a person where it lands. That is the clear kind.',
    'इसलिए देना कि देना चाहिए, ऐसे किसी को जो लौटा नहीं सकता, ऐसी जगह और ऐसे वक़्त और ऐसे इंसान को जहाँ वह लगे। यही साफ़ वाला देना है।',
    'Isliye dena ki dena chahiye, aise kisi ko jo lauta nahi sakta, aisi jagah aur aise waqt aur aise insan ko jahan woh lage. Yahi saaf wala dena hai.',
    'Anupakāriṇe — to somebody who cannot return it. That one word does most of the work.',
    'अनुपकारिणे — ऐसे को जो लौटा नहीं सकता। ज़्यादातर काम यही एक शब्द करता है।',
    'Anupakarine — aise ko jo lauta nahi sakta. Zyadatar kaam yahi ek shabd karta hai.',
    'intermediate',
    'Gita 17.20: giving to somebody who cannot pay you back',
    'The Bhagavad Gita defines clear giving by who receives it: somebody who cannot return the favour. The test is in one word.',
    1

  UNION ALL SELECT 28, 623, 1, 'gita-17-28',
    'अश्रद्धया हुतं दत्तं तपस्तप्तं कृतं च यत्।\nअसदित्युच्यते पार्थ न च तत्प्रेत्य नो इह॥',
    'aśraddhayā hutaṁ dattaṁ tapas taptaṁ kṛtaṁ ca yat\nasad ity ucyate pārtha na ca tat pretya no iha',
    'ashraddhaya hutam dattam tapas taptam kritam cha yat\nasad ity uchyate partha na cha tat pretya no iha',
    'Whatever is offered, given, practised or done without faith is called asat, Partha. It is nothing, neither after nor here.',
    'Whatever you offer, give, practise or do without actually trusting it — the word for that is asat. It does not count. Not later, and not here either.',
    'जो कुछ आप चढ़ाते, देते, साधते या करते हैं बिना उस पर सचमुच भरोसा किए — उसका शब्द है असत्। वह गिना नहीं जाता। न बाद में, और न यहीं।',
    'Jo kuch tum chadhate, dete, saadhte ya karte ho bina us par sach mein bharosa kiye — uska shabd hai asat. Woh gina nahi jaata. Na baad mein, aur na yahin.',
    'The chapter''s last word, and it is about the doing rather than the doer.',
    'अध्याय का आख़िरी शब्द, और वह करने वाले के बारे में नहीं, करने के बारे में है।',
    'Adhyay ka aakhiri shabd, aur woh karne wale ke baare mein nahi, karne ke baare mein hai.',
    'intermediate',
    'Gita 17.28: done without trusting it, it does not count',
    'The Bhagavad Gita closes chapter 17 by saying that what is done without shraddha is asat. The judgement is on the act, not on the person.',
    1

) AS v
JOIN chapters c ON c.chapter_number = 17;

-- =====================================================================
-- 2. EXPLANATIONS
-- =====================================================================
-- All at beginner depth, because the default reader is who lands here.
-- The load-bearing sentences, all asserted by smoke-test.sh on the
-- DEFAULT render:
--   17.2   svabhava-ja is not about birth
--   17.7   sorts by what food does, never by how much
--   17.19  the book's own sentence against practice as punishment
-- =====================================================================

DELETE ve FROM verse_explanations ve JOIN verses v ON v.id = ve.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 17;

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 2 AS vn, 'beginner' AS level,
   'Arjuna has just asked what happens to people who do things sincerely but outside the rules. The answer does not address the rules at all. It turns the question into one about what a person is actually resting on.' AS h_en,
   'अर्जुन ने अभी पूछा है कि उन लोगों का क्या होता है जो सच्चे मन से काम करते हैं लेकिन नियमों के बाहर। जवाब नियमों की बात करता ही नहीं। वह सवाल को इस बात में बदल देता है कि इंसान असल में टिका किस पर है।' AS h_hi,
   'Arjun ne abhi poochha hai ki un logon ka kya hota hai jo sachche man se kaam karte hain lekin niyamon ke bahar. Jawab niyamon ki baat karta hi nahi. Woh sawal ko is baat mein badal deta hai ki insan asal mein tika kis par hai.' AS h_hing,
   'Śraddhā is not belief in the sense of holding an opinion. It is closer to what you actually put your weight on. Three kinds are named — clear, restless, shut down — and the chapter spends twenty-six verses showing how to tell them apart by looking at behaviour.' AS p_en,
   'श्रद्धा उस अर्थ में विश्वास नहीं है कि कोई राय रखना। वह उसके ज़्यादा पास है जिस पर आप सचमुच अपना भार डालते हैं। तीन तरह की नाम ली गई हैं — साफ़, बेचैन, बुझी हुई — और अध्याय छब्बीस श्लोक यह दिखाने में लगाता है कि इन्हें बरताव देखकर अलग कैसे किया जाए।' AS p_hi,
   'Shraddha us arth mein vishwas nahi hai ki koi raay rakhna. Woh uske zyada paas hai jis par tum sach mein apna bhaar daalte ho. Teen tarah ki naam li gayi hain — saaf, bechain, bujhi hui — aur adhyay chhabbis shloka yeh dikhane mein lagata hai ki inhe bartav dekhkar alag kaise kiya jaaye.' AS p_hing,
   'One word needs settling before the chapter can be read at all. Svabhāva-ja means born of one''s own nature, and it does NOT mean determined by birth, family, community or where somebody comes from. Reading it that way is the same move as reading 4.13 as a hereditary claim, and the rest of this chapter makes the reading impossible: every single test it gives is behavioural. What you eat, what you say, what you give, and how. None of it can be checked by knowing somebody''s name.' AS m_en,
   'अध्याय पढ़ने से पहले एक शब्द तय करना ज़रूरी है। स्वभावज का मतलब है अपने ही स्वभाव से उपजी, और इसका मतलब यह नहीं है कि जन्म, परिवार, समुदाय या कोई कहाँ से आता है इससे तय। ऐसा पढ़ना वही चाल है जो 4.13 को वंशगत दावे की तरह पढ़ना है, और बाक़ी अध्याय इस पाठ को नामुमकिन कर देता है: वह जितनी भी कसौटियाँ देता है, सब बरताव की हैं। आप क्या खाते हैं, क्या कहते हैं, क्या देते हैं, और कैसे। इनमें से कुछ भी किसी का नाम जानकर नहीं जाँचा जा सकता।' AS m_hi,
   'Adhyay padhne se pehle ek shabd tay karna zaroori hai. Svabhav-ja ka matlab hai apne hi swabhav se upji, aur iska matlab yeh nahi hai ki janm, parivar, samuday ya koi kahan se aata hai isse tay. Aisa padhna wahi chaal hai jo 4.13 ko vanshagat dawe ki tarah padhna hai, aur baaki adhyay is paath ko namumkin kar deta hai: woh jitni bhi kasautiyan deta hai, sab bartav ki hain. Tum kya khate ho, kya kehte ho, kya dete ho, aur kaise. Inme se kuch bhi kisi ka naam jaankar nahi jaancha ja sakta.' AS m_hing

  UNION ALL SELECT 3, 'beginner',
   'The one line from this chapter that most people have heard. It is usually quoted on its own, which is exactly what makes it go wrong.',
   'इस अध्याय की वह एक पंक्ति जो ज़्यादातर लोगों ने सुनी है। वह आमतौर पर अकेले उद्धृत होती है, और यही उसे ग़लत कर देता है।',
   'Is adhyay ki woh ek line jo zyadatar logon ne suni hai. Woh aam taur par akele uddhrit hoti hai, aur yahi use galat kar deti hai.',
   'Read in place, it is a method rather than a promise. The chapter has just said that what somebody trusts fits what they are made of; this line closes the loop and says the reverse also holds, so you can read one off the other. Watch what a person eats, says and gives, and you have found out what they trust — including when it is not what they say.',
   'अपनी जगह पर पढ़ें तो यह वादा नहीं, तरीक़ा है। अध्याय अभी कह चुका है कि इंसान जिस पर भरोसा करता है वह उससे मेल खाता है जिससे वह बना है; यह पंक्ति घेरा पूरा करती है और कहती है कि उलटा भी सच है, तो एक से दूसरे को पढ़ा जा सकता है। देखिए कोई क्या खाता है, क्या कहता है, क्या देता है — और आपको पता चल गया कि वह किस पर भरोसा करता है, तब भी जब वह कुछ और कहता हो।',
   'Apni jagah par padhein to yeh waada nahi, tareeka hai. Adhyay abhi keh chuka hai ki insan jis par bharosa karta hai woh usse mel khata hai jisse woh bana hai; yeh line ghera poora karti hai aur kehti hai ki ulta bhi sach hai, to ek se doosre ko padha ja sakta hai. Dekho koi kya khata hai, kya kehta hai, kya deta hai — aur tumhe pata chal gaya ki woh kis par bharosa karta hai, tab bhi jab woh kuch aur kehta ho.',
   'The misreading is believe-hard-enough-and-it-becomes-true, and the chapter is the opposite of that from beginning to end. Nothing here says trust makes a thing so. It says trust shows, and it names the three places to look. That is a much less comfortable claim, because it means nobody gets to settle what they believe by deciding it — the evidence is already lying around in what they did last Tuesday.',
   'ग़लत पाठ यह है कि ज़ोर से यक़ीन करो तो सच हो जाएगा, और अध्याय शुरू से आख़िर तक इसका उलटा है। यहाँ कुछ यह नहीं कहता कि भरोसा किसी चीज़ को सच कर देता है। यह कहता है कि भरोसा दिख जाता है, और तीन जगहों का नाम लेता है जहाँ देखना है। यह कहीं कम आरामदेह दावा है, क्योंकि इसका मतलब है कि कोई भी यह तय करके नहीं जान सकता कि वह क्या मानता है — सबूत पिछले मंगलवार के कामों में पहले से बिखरा पड़ा है।',
   'Galat paath yeh hai ki zor se yakeen karo to sach ho jayega, aur adhyay shuru se aakhir tak iska ulta hai. Yahan kuch yeh nahi kehta ki bharosa kisi cheez ko sach kar deta hai. Yeh kehta hai ki bharosa dikh jaata hai, aur teen jagahon ka naam leta hai jahan dekhna hai. Yeh kahin kam aaramdeh dawa hai, kyunki iska matlab hai ki koi bhi yeh tay karke nahi jaan sakta ki woh kya maanta hai — saboot pichhle Tuesday ke kaamon mein pehle se bikhra pada hai.'

  UNION ALL SELECT 7, 'beginner',
   'The hinge of the chapter. Having sorted trust into three, it announces that the same three run through food, offering, practice and giving — the four ordinary things a person does.',
   'अध्याय का जोड़। भरोसे को तीन में छाँटने के बाद यह घोषणा करता है कि वही तीन खाने, चढ़ावे, अभ्यास और दान में भी चलते हैं — यानी उन चार आम कामों में जो इंसान करता है।',
   'Adhyay ka jod. Bharose ko teen mein chhaantne ke baad yeh ghoshna karta hai ki wahi teen khane, chadhave, abhyas aur daan mein bhi chalte hain — yani un chaar aam kaamon mein jo insan karta hai.',
   'Note what the sort is made of. The verses after this one describe food by what it does — whether it settles somebody or leaves them agitated, whether it is fresh, whether it was made with any care. Not one of them names an amount, a weight, a time of day or a thing to leave out.',
   'ध्यान दीजिए कि छँटाई किस चीज़ से बनी है। इसके बाद के श्लोक खाने का वर्णन इस आधार पर करते हैं कि वह करता क्या है — किसी को ठहराता है या बेचैन छोड़ता है, ताज़ा है या नहीं, किसी ध्यान से बना है या नहीं। इनमें से एक भी न मात्रा बताता है, न वज़न, न दिन का समय, न कोई चीज़ जो छोड़नी है।',
   'Dhyan do ki chhantai kis cheez se bani hai. Iske baad ke shloka khane ka varnan is aadhar par karte hain ki woh karta kya hai — kisi ko thehrata hai ya bechain chhodta hai, taaza hai ya nahi, kisi dhyan se bana hai ya nahi. Inme se ek bhi na maatra batata hai, na wazan, na din ka samay, na koi cheez jo chhodni hai.',
   'A verse that sorts food is a verse that can be picked up and used against yourself, and that has to be said out loud rather than hoped about. Nothing here is a diet and nothing here is a rule. The chapter itself closes the door twelve verses later at 17.19, where practice undertaken by hurting yourself is named and placed in the lowest of the three categories. If reading this page has produced a plan about eating less, the chapter has already answered that, and the answer is in the text and not in this note.',
   'खाने को छाँटने वाला श्लोक वह श्लोक है जिसे उठाकर अपने ही ख़िलाफ़ इस्तेमाल किया जा सकता है, और यह उम्मीद करने के बजाय ज़ोर से कह देना ज़रूरी है। यहाँ कुछ भी परहेज़ नहीं है और कुछ भी नियम नहीं है। अध्याय ख़ुद बारह श्लोक बाद 17.19 पर दरवाज़ा बंद कर देता है, जहाँ ख़ुद को तकलीफ़ देकर किया गया अभ्यास नाम लेकर तीनों में सबसे नीचे रखा जाता है। अगर यह पन्ना पढ़कर कम खाने की कोई योजना बनी है, तो अध्याय उसका जवाब पहले ही दे चुका है, और जवाब ग्रंथ में है, इस टिप्पणी में नहीं।',
   'Khane ko chhaantne wala shloka woh shloka hai jise uthakar apne hi khilaf istemaal kiya ja sakta hai, aur yeh ummeed karne ke bajaye zor se keh dena zaroori hai. Yahan kuch bhi parhez nahi hai aur kuch bhi niyam nahi hai. Adhyay khud barah shloka baad 17.19 par darwaza band kar deta hai, jahan khud ko takleef dekar kiya gaya abhyas naam lekar teenon mein sabse neeche rakha jaata hai. Agar yeh panna padhkar kam khane ki koi yojna bani hai, to adhyay uska jawab pehle hi de chuka hai, aur jawab granth mein hai, is tippani mein nahi.'

  UNION ALL SELECT 15, 'beginner',
   'Tapas is usually translated as austerity and usually pictured as something extreme. The chapter breaks it into three ordinary places — body, speech and mind — and this is the middle one.',
   'तप का अनुवाद आमतौर पर तपस्या होता है और उसकी तस्वीर आमतौर पर किसी चरम चीज़ की बनती है। अध्याय उसे तीन आम जगहों में तोड़ देता है — शरीर, वाणी और मन — और यह बीच वाली है।',
   'Tap ka anuvaad aam taur par tapasya hota hai aur uski tasveer aam taur par kisi charam cheez ki banti hai. Adhyay use teen aam jagahon mein tod deta hai — sharir, vaani aur man — aur yeh beech wali hai.',
   'Four conditions, and they have to hold together. Does not set somebody off. True. Not unkind. Actually useful. Being right satisfies exactly one of the four, which is why this verse is uncomfortable for people who are usually right.',
   'चार शर्तें, और उन्हें साथ टिकना है। किसी को भड़काए नहीं। सच्ची। कठोर नहीं। सचमुच काम की। सही होना इन चारों में से ठीक एक को पूरा करता है, और इसीलिए यह श्लोक उन लोगों के लिए असहज है जो अक्सर सही होते हैं।',
   'Chaar shartein, aur unhe saath tikna hai. Kisi ko bhadkaye nahi. Sachchi. Kathor nahi. Sach mein kaam ki. Sahi hona in chaaron mein se theek ek ko poora karta hai, aur isiliye yeh shloka un logon ke liye asahaj hai jo aksar sahi hote hain.',
   'The condition people trip on is the first one, and it is worth being precise about it. Anudvega-kara means it does not throw the other person into agitation. That is not the same as saying nothing difficult — a doctor giving a diagnosis, a manager giving real feedback and a friend saying the hard thing can all clear this bar, and often the way they clear it is by timing and by tone rather than by softening the content. What fails it is the sentence delivered in a way that guarantees the other person cannot hear it.',
   'लोग जिस शर्त पर लड़खड़ाते हैं वह पहली है, और उसके बारे में साफ़ होना काम का है। अनुद्वेगकर का मतलब है कि वह सामने वाले को उथल-पुथल में न डाल दे। यह मुश्किल बात न कहने जैसा नहीं है — निदान बताता डॉक्टर, असली फ़ीडबैक देता मैनेजर और कठिन बात कहता दोस्त, तीनों यह कसौटी पार कर सकते हैं, और अक्सर वे इसे बात नरम करके नहीं, वक़्त और लहजे से पार करते हैं। जो नाकाम होता है वह है ऐसे ढंग से कही गई बात जो पक्का कर दे कि सामने वाला उसे सुन ही न सके।',
   'Log jis shart par ladkhadate hain woh pehli hai, aur uske baare mein saaf hona kaam ka hai. Anudvega-kar ka matlab hai ki woh saamne wale ko uthal-puthal mein na daal de. Yeh mushkil baat na kehne jaisa nahi hai — nidan batata doctor, asli feedback deta manager aur kathin baat kehta dost, teenon yeh kasauti paar kar sakte hain, aur aksar woh ise baat naram karke nahi, waqt aur lehje se paar karte hain. Jo nakaam hota hai woh hai aise dhang se kahi gayi baat jo pakka kar de ki saamne wala use sun hi na sake.'

  UNION ALL SELECT 16, 'beginner',
   'The third and last of the three tapas verses, and the only one that happens where nobody else can check it.',
   'तीन तप-श्लोकों में तीसरा और आख़िरी, और अकेला ऐसा जो वहाँ होता है जहाँ कोई और जाँच नहीं सकता।',
   'Teen tap-shlokon mein teesra aur aakhiri, aur akela aisa jo wahan hota hai jahan koi aur jaanch nahi sakta.',
   'The order of the list is the argument. Prasāda comes first — settled, clear, unforced, the same word used for something offered and received rather than seized. Then gentleness. Then quiet, then some hold on yourself, and only at the end, meaning what you appear to mean.',
   'सूची का क्रम ही दलील है। प्रसाद पहले आता है — ठहरा हुआ, साफ़, बिना ज़ोर के; वही शब्द जो किसी ऐसी चीज़ के लिए है जो दी और ली जाती है, छीनी नहीं जाती। फिर नरमी। फिर चुप्पी, फिर अपने ऊपर कुछ पकड़, और सबसे आख़िर में यह कि जो दिखता है वही मतलब हो।',
   'Soochi ka kram hi dalil hai. Prasad pehle aata hai — thehra hua, saaf, bina zor ke; wahi shabd jo kisi aisi cheez ke liye hai jo di aur li jaati hai, chheeni nahi jaati. Phir narmi. Phir chuppi, phir apne upar kuch pakad, aur sabse aakhir mein yeh ki jo dikhta hai wahi matlab ho.',
   'Almost everybody who sets out to discipline their own mind starts at item four and treats the whole thing as a matter of grip. The verse puts grip fourth, on purpose, behind settling and behind gentleness. A mind being held down hard is not doing what this verse describes, and 17.19 will say so in as many words three verses from now. Saumyatva — gentleness — is on the list. Severity is not on the list anywhere.',
   'अपने मन को साधने निकला लगभग हर इंसान चौथी चीज़ से शुरू करता है और पूरे मामले को पकड़ का मामला समझता है। श्लोक पकड़ को जानबूझकर चौथे नंबर पर रखता है, ठहराव के बाद और नरमी के बाद। ज़ोर से दबाया हुआ मन वह नहीं कर रहा जो यह श्लोक बताता है, और तीन श्लोक बाद 17.19 यही साफ़ शब्दों में कहेगा। सौम्यत्व — नरमी — सूची में है। कठोरता सूची में कहीं नहीं है।',
   'Apne man ko saadhne nikla lagbhag har insan chauthi cheez se shuru karta hai aur poore mamle ko pakad ka mamla samajhta hai. Shloka pakad ko jaanboojhkar chauthe number par rakhta hai, thehrav ke baad aur narmi ke baad. Zor se dabaya hua man woh nahi kar raha jo yeh shloka batata hai, aur teen shloka baad 17.19 yahi saaf shabdon mein kahega. Saumyatva — narmi — soochi mein hai. Kathorta soochi mein kahin nahi hai.'

  UNION ALL SELECT 19, 'beginner',
   'The chapter has been sorting practice into three. This is the bottom one, and the text does not hedge about what goes in it.',
   'अध्याय अभ्यास को तीन में छाँटता आ रहा है। यह सबसे नीचे वाला है, और ग्रंथ इसमें क्या जाता है, इस बारे में गोल-मोल नहीं बोलता।',
   'Adhyay abhyas ko teen mein chhaanta aa raha hai. Yeh sabse neeche wala hai, aur granth isme kya jaata hai, is baare mein gol-mol nahi bolta.',
   'Three things land in the bottom category, and they are listed side by side: taking something up out of a stubborn wrong idea, doing it by hurting yourself, and doing it in order to wreck somebody else. The second one is the one worth stopping on. Self-inflicted pain, as a practice, is named and ranked, by the book, at the bottom.',
   'तीन चीज़ें सबसे नीचे वाली श्रेणी में आती हैं, और वे साथ-साथ गिनाई गई हैं: किसी ज़िद भरे ग़लत ख़याल से कुछ उठा लेना, उसे ख़ुद को तकलीफ़ देकर करना, और उसे किसी और को तबाह करने के लिए करना। रुकने लायक़ दूसरी है। ख़ुद को दी गई तकलीफ़, अभ्यास के तौर पर, ग्रंथ द्वारा नाम लेकर सबसे नीचे रखी गई है।',
   'Teen cheezein sabse neeche wali shreni mein aati hain, aur woh saath saath ginayi gayi hain: kisi zid bhare galat khayal se kuch utha lena, use khud ko takleef dekar karna, aur use kisi aur ko tabah karne ke liye karna. Rukne layak doosri hai. Khud ko di gayi takleef, abhyas ke taur par, granth dwara naam lekar sabse neeche rakhi gayi hai.',
   'This matters because of who tends to read chapters like this one. Somebody who has turned a practice into a punishment — the eating, the training, the waking, the work — usually believes the problem is that they are not doing it hard enough. The text is unusually direct with them: it is not that you need more of this, it is that this is the wrong category of thing, and the wrongness is in the pīḍā, the hurting, and not in the amount. Nothing in this chapter asks anybody to be hard on themselves, and this verse is the reason it cannot be read that way.',
   'यह इसलिए मायने रखता है कि ऐसे अध्याय पढ़ता कौन है। जिसने किसी अभ्यास को सज़ा बना लिया है — खाना, कसरत, जागना, काम — वह आमतौर पर मानता है कि दिक़्क़त यह है कि वह इसे पर्याप्त सख़्ती से नहीं कर रहा। ग्रंथ उससे असामान्य रूप से सीधे बात करता है: बात यह नहीं कि तुम्हें इसकी और ज़रूरत है, बात यह है कि यह ग़लत क़िस्म की चीज़ है, और ग़लती पीड़ा में है, मात्रा में नहीं। इस अध्याय में कुछ भी किसी से अपने ऊपर सख़्ती नहीं माँगता, और यही श्लोक वह वजह है कि इसे वैसे पढ़ा नहीं जा सकता।',
   'Yeh isliye maayne rakhta hai ki aise adhyay padhta kaun hai. Jisne kisi abhyas ko saza bana liya hai — khana, kasrat, jaagna, kaam — woh aam taur par maanta hai ki dikkat yeh hai ki woh ise paryapt sakhti se nahi kar raha. Granth usse asamanya roop se seedhe baat karta hai: baat yeh nahi ki tumhe iski aur zaroorat hai, baat yeh hai ki yeh galat kism ki cheez hai, aur galti peeda mein hai, maatra mein nahi. Is adhyay mein kuch bhi kisi se apne upar sakhti nahi maangta, aur yahi shloka woh wajah hai ki ise waise padha nahi ja sakta.'

  UNION ALL SELECT 20, 'beginner',
   'Giving is the fourth of the four things the chapter runs its three categories through, and the sattvic version is defined by four conditions in a single line.',
   'दान उन चार चीज़ों में चौथी है जिनमें से अध्याय अपनी तीन श्रेणियाँ गुज़ारता है, और साफ़ वाला रूप एक ही पंक्ति में चार शर्तों से तय होता है।',
   'Daan un chaar cheezon mein chauthi hai jinme se adhyay apni teen shreniyan guzarta hai, aur saaf wala roop ek hi line mein chaar shartein se tay hota hai.',
   'Because it ought to be given. To somebody who cannot return it. At a place, at a time, and to a person where it actually lands. Four conditions, and the second is the one that does the work — anupakāriṇe, to one who cannot do you a favour back.',
   'इसलिए कि देना चाहिए। ऐसे किसी को जो लौटा नहीं सकता। ऐसी जगह, ऐसे वक़्त, और ऐसे इंसान को जहाँ वह सचमुच लगे। चार शर्तें, और काम दूसरी करती है — अनुपकारिणे, ऐसे को जो बदले में आपका कोई उपकार नहीं कर सकता।',
   'Isliye ki dena chahiye. Aise kisi ko jo lauta nahi sakta. Aisi jagah, aise waqt, aur aise insan ko jahan woh sach mein lage. Chaar shartein, aur kaam doosri karti hai — anupakarine, aise ko jo badle mein tumhara koi upkaar nahi kar sakta.',
   'Anupakāriṇe is a hard test and it is hard in an ordinary way. Most giving in most lives runs on a ledger nobody keeps out loud — the favour that will be remembered, the introduction that might come back, the person it is useful to have thought well of you. None of that is condemned here and the verse does not call it wrong. It just says the clear kind is the kind where the ledger cannot be opened, because the other person has no way of writing anything in it.',
   'अनुपकारिणे कठिन कसौटी है और वह आम तरीक़े से कठिन है। ज़्यादातर ज़िंदगियों में ज़्यादातर देना एक ऐसे बहीखाते पर चलता है जिसे कोई ज़ोर से नहीं रखता — वह एहसान जो याद रखा जाएगा, वह पहचान जो लौट सकती है, वह इंसान जिसका आपके बारे में अच्छा सोचना काम आता है। यहाँ इसमें से किसी की निंदा नहीं है और श्लोक इसे ग़लत भी नहीं कहता। वह बस कहता है कि साफ़ वाला रूप वह है जहाँ बहीखाता खोला ही नहीं जा सकता, क्योंकि सामने वाले के पास उसमें कुछ लिखने का कोई रास्ता नहीं है।',
   'Anupakarine kathin kasauti hai aur woh aam tareeke se kathin hai. Zyadatar zindagiyon mein zyadatar dena ek aise bahikhate par chalta hai jise koi zor se nahi rakhta — woh ehsaan jo yaad rakha jayega, woh pehchan jo laut sakti hai, woh insan jiska tumhare baare mein achha sochna kaam aata hai. Yahan isme se kisi ki ninda nahi hai aur shloka ise galat bhi nahi kehta. Woh bas kehta hai ki saaf wala roop woh hai jahan bahikhata khola hi nahi ja sakta, kyunki saamne wale ke paas usme kuch likhne ka koi raasta nahi hai.'

  UNION ALL SELECT 28, 'beginner',
   'The last verse of the chapter, and it closes the loop back to 17.3. Everything in between has been a way of finding out what somebody trusts. This says what it is worth when there is nothing there.',
   'अध्याय का आख़िरी श्लोक, और यह 17.3 तक घेरा पूरा कर देता है। बीच का सब कुछ यह पता करने का तरीक़ा रहा है कि कोई किस पर भरोसा करता है। यह बताता है कि जब वहाँ कुछ है ही नहीं तो उसका मोल क्या है।',
   'Adhyay ka aakhiri shloka, aur yeh 17.3 tak ghera poora kar deta hai. Beech ka sab kuch yeh pata karne ka tareeka raha hai ki koi kis par bharosa karta hai. Yeh batata hai ki jab wahan kuch hai hi nahi to uska mol kya hai.',
   'Asat is a strong word and it is worth being exact about what it is applied to. It is applied to the offering, the gift, the practice and the act — to things done, not to the person doing them. Nowhere does the verse say the person is asat. The judgement lands on the doing.',
   'असत् भारी शब्द है और यह ठीक-ठीक जानना ज़रूरी है कि वह किस पर लगाया गया है। वह चढ़ावे पर, दान पर, अभ्यास पर और कर्म पर लगाया गया है — की गई चीज़ों पर, करने वाले पर नहीं। श्लोक कहीं यह नहीं कहता कि इंसान असत् है। फ़ैसला करने पर गिरता है।',
   'Asat bhaari shabd hai aur yeh theek theek jaanna zaroori hai ki woh kis par lagaya gaya hai. Woh chadhave par, daan par, abhyas par aur karm par lagaya gaya hai — ki gayi cheezon par, karne wale par nahi. Shloka kahin yeh nahi kehta ki insan asat hai. Faisla karne par girta hai.',
   'The practical version of this is not spiritual and almost everybody has run into it. The gift bought because it was expected. The exercise done while resenting every minute of it. The apology given to end a conversation. None of them produced what the thing is supposed to produce, and the reason is not that they were done badly — they were often done perfectly. The reason is that nothing was resting on them. The chapter ends by saying that is not a small defect. It is the whole of what makes a thing count.',
   'इसका व्यावहारिक रूप आध्यात्मिक नहीं है और लगभग हर किसी का इससे सामना हुआ है। वह तोहफ़ा जो इसलिए ख़रीदा गया कि उम्मीद थी। वह कसरत जो हर मिनट कुढ़ते हुए की गई। वह माफ़ी जो बातचीत ख़त्म करने के लिए दी गई। इनमें से किसी ने वह नहीं दिया जो उस चीज़ को देना था, और वजह यह नहीं कि वे ख़राब ढंग से हुईं — वे अक्सर बिलकुल ठीक हुईं। वजह यह है कि उन पर कुछ टिका हुआ था ही नहीं। अध्याय यह कहकर ख़त्म होता है कि यह छोटी ख़ामी नहीं है। किसी चीज़ को गिनती में लाने वाली पूरी बात यही है।',
   'Iska vyavharik roop aadhyatmik nahi hai aur lagbhag har kisi ka isse samna hua hai. Woh tohfa jo isliye khareeda gaya ki ummeed thi. Woh kasrat jo har minute kudhte hue ki gayi. Woh maafi jo baatcheet khatam karne ke liye di gayi. Inme se kisi ne woh nahi diya jo us cheez ko dena tha, aur wajah yeh nahi ki woh kharab dhang se hueen — woh aksar bilkul theek hueen. Wajah yeh hai ki un par kuch tika hua tha hi nahi. Adhyay yeh kehkar khatam hota hai ki yeh chhoti khaami nahi hai. Kisi cheez ko ginti mein laane wali poori baat yahi hai.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 17;

-- =====================================================================
-- 3. HOOKS, REFLECTIONS, PRACTICES, TOPICS
-- =====================================================================
-- NOT ONE PRACTICE, REFLECTION OR HOOK IN THIS FILE NAMES AN AMOUNT, A
-- WEIGHT, A CALORIE, A DURATION OF FASTING OR A SLEEP TARGET, AND THE
-- 17.7 PRACTICE IS ABOUT NOTICING AN EFFECT RATHER THAN CHANGING AN
-- INTAKE. The 17.19 practice is the only one in the corpus that asks
-- the reader to STOP doing something they have been doing to themselves.
-- =====================================================================

DELETE m FROM verse_memory_aids m JOIN verses v ON v.id = m.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 17;
DELETE r FROM verse_reflections r JOIN verses v ON v.id = r.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 17;
DELETE p FROM verse_practices p JOIN verses v ON v.id = p.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 17;
DELETE vt FROM verse_topics vt JOIN verses v ON v.id = vt.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 17;

INSERT INTO verse_memory_aids (verse_id, hook_en, hook_hi, hook_hinglish, analogy_en, analogy_hi, analogy_hinglish, visual_cue)
SELECT v.id, m.h_en, m.h_hi, m.h_hing, m.a_en, m.a_hi, m.a_hing, m.cue FROM (
  SELECT 2 AS vn,
  'Born of your own nature. Not of where you were born.' AS h_en,
  'अपने स्वभाव से उपजी। इससे नहीं कि आप पैदा कहाँ हुए।' AS h_hi,
  'Apne swabhav se upji. Isse nahi ki tum paida kahan hue.' AS h_hing,
  'Like handwriting. Yours, formed over years, and nothing to do with your surname.' AS a_en,
  'लिखावट जैसी। आपकी, सालों में बनी, और आपके उपनाम से उसका कोई लेना-देना नहीं।' AS a_hi,
  'Likhawat jaisi. Tumhari, saalon mein bani, aur tumhare upnaam se uska koi lena dena nahi.' AS a_hing,
  'A signature, written twice' AS cue

  UNION ALL SELECT 3,
  'Not believe hard and it comes true. Watch closely and it shows.',
  'ज़ोर से यक़ीन करो और सच हो जाए, ऐसा नहीं। ग़ौर से देखो और वह दिख जाए, ऐसा।',
  'Zor se yakeen karo aur sach ho jaaye, aisa nahi. Gaur se dekho aur woh dikh jaaye, aisa.',
  'Like a bank statement. Nobody has to tell you what they value.',
  'बैंक स्टेटमेंट जैसा। किसी को यह बताना नहीं पड़ता कि उसे क्या ज़रूरी लगता है।',
  'Bank statement jaisa. Kisi ko yeh batana nahi padta ki use kya zaroori lagta hai.',
  'A statement, unfolded'

  UNION ALL SELECT 7,
  'Sorted by what it does. Never once by how much.',
  'इस आधार पर छाँटा गया कि वह करता क्या है। कभी इस आधार पर नहीं कि कितना।',
  'Is aadhar par chhaanta gaya ki woh karta kya hai. Kabhi is aadhar par nahi ki kitna.',
  'Like asking whether a meal left you steady, not whether it was small.',
  'यह पूछने जैसा कि खाने के बाद आप ठहरे हुए थे या नहीं, यह नहीं कि खाना कम था या नहीं।',
  'Yeh poochhne jaisa ki khane ke baad tum thehre hue the ya nahi, yeh nahi ki khana kam tha ya nahi.',
  'A plate, seen from above, no scale beside it'

  UNION ALL SELECT 15,
  'Four conditions at once. Being right meets one of them.',
  'एक साथ चार शर्तें। सही होना उनमें से एक पूरी करता है।',
  'Ek saath chaar shartein. Sahi hona unme se ek poori karta hai.',
  'Like a key that has to turn four levers. Three is still a locked door.',
  'उस चाबी जैसी जिसे चार लीवर घुमाने हैं। तीन का मतलब अब भी बंद दरवाज़ा है।',
  'Us chaabi jaisi jise chaar lever ghumane hain. Teen ka matlab ab bhi band darwaza hai.',
  'A key with four teeth'

  UNION ALL SELECT 16,
  'Grip is fourth on the list. Settling and gentleness come first.',
  'पकड़ सूची में चौथे नंबर पर है। ठहराव और नरमी पहले आते हैं।',
  'Pakad soochi mein chauthe number par hai. Thehrav aur narmi pehle aate hain.',
  'Like calming a horse before taking the reins. The order is not decorative.',
  'लगाम थामने से पहले घोड़े को शांत करने जैसा। यह क्रम सजावट नहीं है।',
  'Lagaam thaamne se pehle ghode ko shaant karne jaisa. Yeh kram sajawat nahi hai.',
  'A loose rein, held low'

  UNION ALL SELECT 19,
  'Hurting yourself is not the hard version of practice. It is the bottom category.',
  'ख़ुद को तकलीफ़ देना अभ्यास का कठिन रूप नहीं है। वह सबसे नीचे वाली श्रेणी है।',
  'Khud ko takleef dena abhyas ka kathin roop nahi hai. Woh sabse neeche wali shreni hai.',
  'Like being told the tool you have been forcing is the wrong tool, not that you need to push harder.',
  'यह बताए जाने जैसा कि जिस औज़ार पर आप ज़ोर लगा रहे हैं वह ग़लत औज़ार है, यह नहीं कि और ज़ोर लगाना है।',
  'Yeh bataye jaane jaisa ki jis auzaar par tum zor laga rahe ho woh galat auzaar hai, yeh nahi ki aur zor lagana hai.',
  'A tool set down, not gripped'

  UNION ALL SELECT 20,
  'To somebody who cannot pay you back. One word does the work.',
  'ऐसे किसी को जो लौटा नहीं सकता। काम एक ही शब्द करता है।',
  'Aise kisi ko jo lauta nahi sakta. Kaam ek hi shabd karta hai.',
  'Like a ledger the other person has no way of writing in.',
  'ऐसे बहीखाते जैसा जिसमें सामने वाले के पास कुछ लिखने का रास्ता ही नहीं।',
  'Aise bahikhate jaisa jisme saamne wale ke paas kuch likhne ka raasta hi nahi.',
  'A ledger with one column'

  UNION ALL SELECT 28,
  'Done perfectly, with nothing resting on it. The word for that is asat.',
  'बिलकुल ठीक किया गया, और उस पर कुछ टिका हुआ नहीं। उसका शब्द है असत्।',
  'Bilkul theek kiya gaya, aur us par kuch tika hua nahi. Uska shabd hai asat.',
  'Like a signature on a form nobody meant. Correct in every particular.',
  'ऐसे फ़ॉर्म पर दस्तख़त जैसा जिसका किसी का मतलब ही नहीं था। हर ब्यौरे में सही।',
  'Aise form par dastkhat jaisa jiska kisi ka matlab hi nahi tha. Har byore mein sahi.',
  'A signed page, unread'
) AS m
JOIN verses v ON v.verse_number = m.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 17;

INSERT INTO verse_reflections (verse_id, question_en, question_hi, question_hinglish, display_order)
SELECT v.id, r.q_en, r.q_hi, r.q_hing, r.ord FROM (
  SELECT 2 AS vn, 'If somebody watched a week of your life without hearing you speak, what would they say you trust?' AS q_en, 'अगर कोई आपकी ज़िंदगी का एक हफ़्ता देखे और आपकी बात एक बार भी न सुने, तो वह क्या कहेगा कि आप किस पर भरोसा करते हैं?' AS q_hi, 'Agar koi tumhari zindagi ka ek hafta dekhe aur tumhari baat ek baar bhi na sune, to woh kya kahega ki tum kis par bharosa karte ho?' AS q_hing, 1 AS ord
  UNION ALL SELECT 2, 'Has what you rest your weight on changed in the last five years?', 'पिछले पाँच साल में वह चीज़ बदली है जिस पर आप अपना भार डालते हैं?', 'Pichhle paanch saal mein woh cheez badli hai jis par tum apna bhaar daalte ho?', 2
  UNION ALL SELECT 2, 'The word is "born of your own nature". What does that rule out?', 'शब्द है "अपने स्वभाव से उपजी"। यह किसे ख़ारिज कर देता है?', 'Shabd hai "apne swabhav se upji". Yeh kise khaarij kar deta hai?', 3
  UNION ALL SELECT 3, 'Where is there a gap between what you say you value and what you spend on?', 'कहाँ फ़ासला है इसमें कि आप क्या ज़रूरी बताते हैं और किस पर ख़र्च करते हैं?', 'Kahan faasla hai isme ki tum kya zaroori batate ho aur kis par kharch karte ho?', 1
  UNION ALL SELECT 3, 'If this line is a method rather than a promise, what does it ask you to do?', 'अगर यह पंक्ति वादा नहीं, तरीक़ा है, तो वह आपसे क्या करने को कहती है?', 'Agar yeh line waada nahi, tareeka hai, to woh tumse kya karne ko kehti hai?', 2
  UNION ALL SELECT 3, 'What have you found out about somebody by watching rather than asking?', 'आपने किसी के बारे में क्या पूछकर नहीं, देखकर जाना है?', 'Tumne kisi ke baare mein kya poochhkar nahi, dekhkar jaana hai?', 3
  UNION ALL SELECT 7, 'After eating, are you usually steadier or more scattered? No other question here.', 'खाने के बाद आप आमतौर पर ज़्यादा ठहरे होते हैं या ज़्यादा बिखरे? यहाँ और कोई सवाल नहीं है।', 'Khane ke baad tum aam taur par zyada thehre hote ho ya zyada bikhre? Yahan aur koi sawal nahi hai.', 1
  UNION ALL SELECT 7, 'The verse sorts by effect and never by amount. Does your own thinking do that?', 'श्लोक असर से छाँटता है, मात्रा से कभी नहीं। क्या आपकी अपनी सोच ऐसा करती है?', 'Shloka asar se chhaanta hai, maatra se kabhi nahi. Kya tumhari apni soch aisa karti hai?', 2
  UNION ALL SELECT 7, 'What was the last meal you ate that somebody made with attention?', 'आख़िरी बार आपने कब वह खाना खाया जो किसी ने ध्यान से बनाया हो?', 'Aakhiri baar tumne kab woh khana khaya jo kisi ne dhyan se banaya ho?', 3
  UNION ALL SELECT 15, 'Think of the last true thing you said that landed badly. Which of the four did it miss?', 'आख़िरी बार कही अपनी वह सच्ची बात सोचिए जो बुरी लगी। वह चारों में से किस पर चूकी?', 'Aakhiri baar kahi apni woh sachchi baat socho jo buri lagi. Woh chaaron mein se kis par chooki?', 1
  UNION ALL SELECT 15, 'Is there something true you have been saying because it is true rather than because it helps?', 'कोई सच्ची बात है जो आप इसलिए कहते आ रहे हैं कि वह सच है, इसलिए नहीं कि उससे मदद होती है?', 'Koi sachchi baat hai jo tum isliye kehte aa rahe ho ki woh sach hai, isliye nahi ki usse madad hoti hai?', 2
  UNION ALL SELECT 15, 'When has somebody told you something hard in a way you could actually hear?', 'कब किसी ने आपसे कोई कठिन बात ऐसे कही जो आप सचमुच सुन पाए?', 'Kab kisi ne tumse koi kathin baat aise kahi jo tum sach mein sun paye?', 3
  UNION ALL SELECT 16, 'Grip is fourth on the list. Which item do you usually start at?', 'पकड़ सूची में चौथी है। आप आमतौर पर किससे शुरू करते हैं?', 'Pakad soochi mein chauthi hai. Tum aam taur par kisse shuru karte ho?', 1
  UNION ALL SELECT 16, 'Gentleness is on this list and severity is not. Does that match how you treat your own mind?', 'नरमी इस सूची में है और कठोरता नहीं। क्या यह उससे मेल खाता है जैसे आप अपने मन से पेश आते हैं?', 'Narmi is soochi mein hai aur kathorta nahi. Kya yeh usse mel khata hai jaise tum apne man se pesh aate ho?', 2
  UNION ALL SELECT 16, 'When were you last quiet without it being a way of withholding something?', 'पिछली बार आप कब चुप थे बिना इसके कि चुप्पी कुछ रोक रखने का तरीक़ा हो?', 'Pichhli baar tum kab chup the bina iske ki chuppi kuch rok rakhne ka tareeka ho?', 3
  UNION ALL SELECT 19, 'Is there something you do to yourself that you would not ask a friend to do?', 'कोई ऐसी चीज़ है जो आप अपने साथ करते हैं और किसी दोस्त से करने को नहीं कहेंगे?', 'Koi aisi cheez hai jo tum apne saath karte ho aur kisi dost se karne ko nahi kahoge?', 1
  UNION ALL SELECT 19, 'The text puts this at the bottom rather than warning about it. Does that change anything?', 'ग्रंथ इसे चेतावनी नहीं देता, सबसे नीचे रख देता है। क्या इससे कुछ बदलता है?', 'Granth ise chetavni nahi deta, sabse neeche rakh deta hai. Kya isse kuch badalta hai?', 2
  UNION ALL SELECT 19, 'What have you been telling yourself you are not doing hard enough?', 'आप ख़ुद से क्या कहते आ रहे हैं कि आप उसे पर्याप्त सख़्ती से नहीं कर रहे?', 'Tum khud se kya kehte aa rahe ho ki tum use paryapt sakhti se nahi kar rahe?', 3
  UNION ALL SELECT 20, 'When did you last give something to somebody who had no way of returning it?', 'पिछली बार आपने कब किसी ऐसे को कुछ दिया जिसके पास लौटाने का कोई रास्ता नहीं था?', 'Pichhli baar tumne kab kisi aise ko kuch diya jiske paas lautane ka koi raasta nahi tha?', 1
  UNION ALL SELECT 20, 'Is there a ledger you keep that nobody has ever seen?', 'कोई बहीखाता है जो आप रखते हैं और जिसे किसी ने कभी नहीं देखा?', 'Koi bahikhata hai jo tum rakhte ho aur jise kisi ne kabhi nahi dekha?', 2
  UNION ALL SELECT 20, 'The verse names place, time and person as well. Have you ever given at the wrong time?', 'श्लोक जगह, वक़्त और इंसान का भी नाम लेता है। क्या आपने कभी ग़लत वक़्त पर दिया है?', 'Shloka jagah, waqt aur insan ka bhi naam leta hai. Kya tumne kabhi galat waqt par diya hai?', 3
  UNION ALL SELECT 28, 'What do you do regularly, correctly, with nothing resting on it?', 'आप नियमित रूप से, ठीक-ठीक, क्या करते हैं जिस पर कुछ टिका हुआ नहीं है?', 'Tum niyamit roop se, theek theek, kya karte ho jis par kuch tika hua nahi hai?', 1
  UNION ALL SELECT 28, 'The judgement lands on the act and not on the person. Why does that distinction matter here?', 'फ़ैसला कर्म पर गिरता है, इंसान पर नहीं। यहाँ यह फ़र्क़ क्यों मायने रखता है?', 'Faisla karm par girta hai, insan par nahi. Yahan yeh farq kyun maayne rakhta hai?', 2
  UNION ALL SELECT 28, 'Is there something you could stop doing because nothing is resting on it?', 'कोई ऐसी चीज़ है जिसे आप इसलिए रोक सकते हैं कि उस पर कुछ टिका ही नहीं है?', 'Koi aisi cheez hai jise tum isliye rok sakte ho ki us par kuch tika hi nahi hai?', 3
) AS r
JOIN verses v ON v.verse_number = r.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 17;

INSERT INTO verse_practices (verse_id, action_en, action_hi, action_hinglish, estimated_minutes, difficulty, display_order)
SELECT v.id, p.a_en, p.a_hi, p.a_hing, p.mins, p.diff, 1 FROM (
  SELECT 2 AS vn, 'Write down three things you did this week that nobody asked you to do. Read them as evidence.' AS a_en, 'इस हफ़्ते की तीन ऐसी चीज़ें लिखिए जो आपसे किसी ने करने को नहीं कहा था। उन्हें सबूत की तरह पढ़िए।' AS a_hi, 'Is hafte ki teen aisi cheezein likho jo tumse kisi ne karne ko nahi kaha tha. Unhe saboot ki tarah padho.' AS a_hing, 8 AS mins, 'beginner' AS diff
  UNION ALL SELECT 3, 'Look at where your last ten discretionary hours went. Do not judge them. Just read what they say.', 'देखिए आपके पिछले दस मर्ज़ी वाले घंटे कहाँ गए। उन पर फ़ैसला मत दीजिए। बस पढ़िए कि वे क्या कहते हैं।', 'Dekho tumhare pichhle das marzi wale ghante kahan gaye. Un par faisla mat do. Bas padho ki woh kya kehte hain.', 10, 'intermediate'
  UNION ALL SELECT 7, 'For three days, note only how you felt an hour after eating — steady or scattered. Record nothing else. Change nothing.', 'तीन दिन तक सिर्फ़ यह लिखिए कि खाने के एक घंटे बाद आप कैसा महसूस कर रहे थे — ठहरा हुआ या बिखरा हुआ। और कुछ मत लिखिए। कुछ मत बदलिए।', 'Teen din tak sirf yeh likho ki khane ke ek ghante baad tum kaisa mehsoos kar rahe the — thehra hua ya bikhra hua. Aur kuch mat likho. Kuch mat badlo.', 5, 'beginner'
  UNION ALL SELECT 15, 'Before the next difficult thing you have to say, check it against all four. Change the timing, not the content.', 'अगली बार कोई मुश्किल बात कहने से पहले उसे चारों शर्तों पर जाँचिए। बात मत बदलिए, वक़्त बदलिए।', 'Agli baar koi mushkil baat kehne se pehle use chaaron shartein par jaancho. Baat mat badlo, waqt badlo.', 6, 'intermediate'
  UNION ALL SELECT 16, 'Once today, when you catch your mind wandering, do not tighten. Settle first, then return to it.', 'आज एक बार, जब मन भटकता पकड़ें, कसिए मत। पहले ठहरिए, फिर उस पर लौटिए।', 'Aaj ek baar, jab man bhatakta pakdo, kaso mat. Pehle thehro, phir us par lauto.', 3, 'beginner'
  UNION ALL SELECT 19, 'Name one thing you have been doing to yourself as a punishment. Stop doing that one thing today. Nothing replaces it.', 'एक चीज़ बताइए जो आप अपने साथ सज़ा की तरह कर रहे हैं। आज वह एक चीज़ करना बंद कर दीजिए। उसकी जगह कुछ नहीं आएगा।', 'Ek cheez batao jo tum apne saath saza ki tarah kar rahe ho. Aaj woh ek cheez karna band kar do. Uski jagah kuch nahi aayega.', 5, 'beginner'
  UNION ALL SELECT 20, 'Do one useful thing this week for somebody who will never know it was you.', 'इस हफ़्ते किसी ऐसे के लिए एक काम की चीज़ कीजिए जिसे कभी पता नहीं चलेगा कि वह आप थे।', 'Is hafte kisi aise ke liye ek kaam ki cheez karo jise kabhi pata nahi chalega ki woh tum the.', 15, 'intermediate'
  UNION ALL SELECT 28, 'Pick one recurring thing you do that nothing rests on. Decide whether to mean it or to stop it.', 'अपनी कोई एक दोहराई जाने वाली चीज़ चुनिए जिस पर कुछ टिका नहीं है। तय कीजिए कि उसका मतलब रखना है या उसे रोकना है।', 'Apni koi ek dohrayi jaane wali cheez chuno jis par kuch tika nahi hai. Tay karo ki uska matlab rakhna hai ya use rokna hai.', 10, 'intermediate'
) AS p
JOIN verses v ON v.verse_number = p.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 17;

INSERT INTO verse_topics (verse_id, topic_id, relevance)
SELECT v.id, t.id, x.rel FROM (
  SELECT 2 AS vn, 'the-self' AS slug, 10 AS rel
  UNION ALL SELECT 2, 'duty', 7
  UNION ALL SELECT 2, 'comparison', 6
  UNION ALL SELECT 3, 'the-self', 10
  UNION ALL SELECT 3, 'hard-decisions', 7
  UNION ALL SELECT 3, 'desire', 6
  UNION ALL SELECT 7, 'burnout', 9
  UNION ALL SELECT 7, 'steadiness', 8
  UNION ALL SELECT 7, 'restlessness', 7
  UNION ALL SELECT 15, 'anger', 9
  UNION ALL SELECT 15, 'hard-decisions', 7
  UNION ALL SELECT 15, 'duty', 6
  UNION ALL SELECT 16, 'steadiness', 10
  UNION ALL SELECT 16, 'restlessness', 9
  UNION ALL SELECT 16, 'the-self', 7
  UNION ALL SELECT 19, 'burnout', 10
  UNION ALL SELECT 19, 'steadiness', 8
  UNION ALL SELECT 19, 'effort-without-result', 8
  UNION ALL SELECT 19, 'fear', 6
  UNION ALL SELECT 20, 'action-without-attachment', 10
  UNION ALL SELECT 20, 'duty', 8
  UNION ALL SELECT 20, 'comparison', 6
  UNION ALL SELECT 28, 'effort-without-result', 10
  UNION ALL SELECT 28, 'action-without-attachment', 8
  UNION ALL SELECT 28, 'burnout', 7
  UNION ALL SELECT 28, 'the-self', 6
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 17
JOIN topics t ON t.slug = x.slug;

-- =====================================================================
-- 4. MODERN EXAMPLES
-- =====================================================================
-- Four per verse, four distinct categories per verse, THIRTY-TWO total.
--
-- THE 17.7 SET CONTAINS NO AMOUNT OF ANY KIND — no weight, no calorie,
-- no portion, no hours, no fasting window. Each one turns on an effect
-- somebody noticed, which is the axis the verse actually sorts on.
--
-- IN ALL FOUR OF THE 17.19 EXAMPLES SOMEBODY STOPS PUNISHING THEMSELVES
-- AND NOTHING REPLACES IT. A set where the punishment got swapped for a
-- gentler regimen would teach that the problem was the severity dial,
-- and the verse says the problem is the category.
-- =====================================================================

DELETE e FROM modern_examples e JOIN verses v ON v.id = e.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 17;

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

  SELECT 2 AS vn, 'corporate' AS cat, 1 AS ord,
  'The values on the wall and the calendar' AS t_en, 'दीवार पर लिखे मूल्य और कैलेंडर' AS t_hi, 'Deewar par likhe mulya aur calendar' AS t_hing,
  'A company has four values printed in the lobby. Somebody pulls a quarter of leadership calendars and finds where the hours actually went. Two of the four values have almost no time against them. Nobody was lying about anything.' AS s_en,
  'एक कंपनी की लॉबी में चार मूल्य छपे हैं। कोई एक तिमाही के नेतृत्व-कैलेंडर निकालकर देखता है कि घंटे असल में कहाँ गए। चारों में से दो मूल्यों के आगे लगभग कोई समय नहीं है। किसी ने किसी बारे में झूठ नहीं बोला था।' AS s_hi,
  'Ek company ki lobby mein chaar mulya chhape hain. Koi ek quarter ke netritva-calendar nikaalkar dekhta hai ki ghante asal mein kahan gaye. Chaaron mein se do mulyon ke aage lagbhag koi samay nahi hai. Kisi ne kisi baare mein jhooth nahi bola tha.' AS s_hing,
  'This is the chapter''s method rather than its conclusion. It does not ask what the company believes, because that question has an answer everybody already knows. It reads the behaviour and lets that be the answer, and the two things turn out not to match.' AS c_en,
  'यह अध्याय का नतीजा नहीं, तरीक़ा है। वह यह नहीं पूछता कि कंपनी क्या मानती है, क्योंकि उस सवाल का जवाब सबको पहले से पता है। वह बरताव पढ़ता है और उसी को जवाब मानता है, और दोनों चीज़ें मेल नहीं खातीं।' AS c_hi,
  'Yeh adhyay ka nateeja nahi, tareeka hai. Woh yeh nahi poochhta ki company kya maanti hai, kyunki us sawal ka jawab sabko pehle se pata hai. Woh bartav padhta hai aur usi ko jawab maanta hai, aur dono cheezein mel nahi khateen.' AS c_hing,
  'Nobody was lying. The calendar just answered a question nobody had asked it.' AS l_en,
  'किसी ने झूठ नहीं बोला। कैलेंडर ने बस उस सवाल का जवाब दे दिया जो उससे किसी ने पूछा ही नहीं था।' AS l_hi,
  'Kisi ne jhooth nahi bola. Calendar ne bas us sawal ka jawab de diya jo usse kisi ne poochha hi nahi tha.' AS l_hing,
  NULL AS src, 'intermediate' AS diff, 'work,values,evidence,calendars' AS tags

  UNION ALL SELECT 2, 'everyday_life', 2,
  'The handwriting, not the surname', 'लिखावट, उपनाम नहीं', 'Likhawat, upnaam nahi',
  'Two siblings raised in the same house, by the same people, with the same rules, turn out to trust completely different things. One saves obsessively and one gives things away. Neither of them decided this and neither can point to the moment it happened.',
  'एक ही घर में, एक ही लोगों के हाथों, एक ही नियमों में पले दो भाई-बहन बिलकुल अलग चीज़ों पर भरोसा करने लगते हैं। एक जुनूनी तरीक़े से बचाता है और एक चीज़ें बाँट देता है। दोनों में से किसी ने यह तय नहीं किया और कोई वह पल नहीं बता सकता जब यह हुआ।',
  'Ek hi ghar mein, ek hi logon ke haathon, ek hi niyamon mein pale do bhai-behen bilkul alag cheezon par bharosa karne lagte hain. Ek junooni tareeke se bachata hai aur ek cheezein baant deta hai. Dono mein se kisi ne yeh tay nahi kiya aur koi woh pal nahi bata sakta jab yeh hua.',
  'Svabhāva-ja means born of one''s own nature and this is the cheapest available proof of what it cannot mean. Same house, same family, same everything a birth-based reading would hold constant, and two different answers. The chapter reads behaviour precisely because names and origins do not predict it.',
  'स्वभावज का मतलब है अपने ही स्वभाव से उपजी, और यह उसका सबसे सस्ता सबूत है कि इसका मतलब क्या नहीं हो सकता। एक ही घर, एक ही परिवार, वह सब कुछ एक जो जन्म वाला पाठ स्थिर मानता — और दो अलग जवाब। अध्याय बरताव इसीलिए पढ़ता है क्योंकि नाम और मूल उसे बता नहीं पाते।',
  'Svabhav-ja ka matlab hai apne hi swabhav se upji, aur yeh uska sabse sasta saboot hai ki iska matlab kya nahi ho sakta. Ek hi ghar, ek hi parivar, woh sab kuch ek jo janm wala paath sthir maanta — aur do alag jawab. Adhyay bartav isiliye padhta hai kyunki naam aur mool use bata nahi paate.',
  'Same house, same name, two different answers. That is why the tests are behavioural.',
  'एक ही घर, एक ही नाम, दो अलग जवाब। इसीलिए कसौटियाँ बरताव की हैं।',
  'Ek hi ghar, ek hi naam, do alag jawab. Isiliye kasautiyan bartav ki hain.',
  NULL, 'beginner', 'family,character,origins,evidence'

  UNION ALL SELECT 2, 'school', 3,
  'What the class does when the teacher leaves', 'शिक्षक के जाने पर कक्षा क्या करती है', 'Shikshak ke jaane par kaksha kya karti hai',
  'A teacher steps out for six minutes. What happens in the room in those six minutes tells her more about what the class has taken from a year of teaching than any of the essays she has marked about it.',
  'एक शिक्षिका छह मिनट के लिए बाहर जाती है। उन छह मिनटों में कमरे में जो होता है, वह उसे साल भर की पढ़ाई से क्लास ने क्या लिया, इस बारे में उन तमाम निबंधों से ज़्यादा बताता है जो उसने इसी विषय पर जाँचे हैं।',
  'Ek shikshika chhah minute ke liye bahar jaati hai. Un chhah minuton mein kamre mein jo hota hai, woh use saal bhar ki padhai se class ne kya liya, is baare mein un tamaam nibandhon se zyada batata hai jo usne isi vishay par jaanche hain.',
  'The essays are what the class says it trusts. The six minutes are what it trusts. The chapter''s claim is that the second one is readable, and this teacher has just read it without asking a single question.',
  'निबंध वह हैं जो क्लास कहती है कि वह किस पर भरोसा करती है। वे छह मिनट वह हैं जिस पर वह भरोसा करती है। अध्याय का दावा है कि दूसरी चीज़ पढ़ी जा सकती है, और इस शिक्षिका ने अभी एक भी सवाल पूछे बिना उसे पढ़ लिया।',
  'Nibandh woh hain jo class kehti hai ki woh kis par bharosa karti hai. Woh chhah minute woh hain jis par woh bharosa karti hai. Adhyay ka dawa hai ki doosri cheez padhi ja sakti hai, aur is shikshika ne abhi ek bhi sawal poochhe bina use padh liya.',
  'The essays are the claim. The six minutes are the evidence.',
  'निबंध दावा हैं। वे छह मिनट सबूत हैं।',
  'Nibandh dawa hain. Woh chhah minute saboot hain.',
  NULL, 'beginner', 'school,character,evidence,unsupervised'

  UNION ALL SELECT 2, 'friendship', 4,
  'The friend who turns up', 'वह दोस्त जो पहुँच जाता है', 'Woh dost jo pahunch jaata hai',
  'Somebody has a large group of friends and, when something goes badly wrong, discovers that two of them are at the door within a day and the rest send messages. Nobody in either group has changed. He had simply never had occasion to find out.',
  'किसी का दोस्तों का बड़ा घेरा है और जब कुछ बहुत बुरा होता है, तो उसे पता चलता है कि उनमें से दो एक दिन के भीतर दरवाज़े पर हैं और बाक़ी संदेश भेजते हैं। किसी भी तरफ़ का कोई बदला नहीं है। उसे बस पता करने का मौक़ा कभी नहीं आया था।',
  'Kisi ka doston ka bada ghera hai aur jab kuch bahut bura hota hai, to use pata chalta hai ki unme se do ek din ke bheetar darwaze par hain aur baaki message bhejte hain. Kisi bhi taraf ka koi badla nahi hai. Use bas pata karne ka mauka kabhi nahi aaya tha.',
  'The chapter says trust is legible from behaviour, and the uncomfortable corollary is that it is legible about you too. He is not owed the two who came, and the ones who sent messages are not being convicted of anything. It is simply that a question got asked and everybody answered it truthfully without speaking.',
  'अध्याय कहता है कि भरोसा बरताव से पढ़ा जा सकता है, और असहज नतीजा यह है कि आपके बारे में भी पढ़ा जा सकता है। जो दो आए वे उसका हक़ नहीं थे, और जिन्होंने संदेश भेजे उन पर कोई दोष नहीं सिद्ध हो रहा। बस इतना हुआ कि एक सवाल पूछा गया और सबने बिना बोले सच्चा जवाब दे दिया।',
  'Adhyay kehta hai ki bharosa bartav se padha ja sakta hai, aur asahaj nateeja yeh hai ki tumhare baare mein bhi padha ja sakta hai. Jo do aaye woh uska haq nahi the, aur jinhone message bheje un par koi dosh nahi siddh ho raha. Bas itna hua ki ek sawal poochha gaya aur sabne bina bole sachcha jawab de diya.',
  'Nobody changed. A question got asked and everybody answered it without speaking.',
  'कोई नहीं बदला। एक सवाल पूछा गया और सबने बिना बोले जवाब दे दिया।',
  'Koi nahi badla. Ek sawal poochha gaya aur sabne bina bole jawab de diya.',
  NULL, 'beginner', 'friendship,crisis,evidence,turning-up'

  UNION ALL SELECT 3, 'finance', 1,
  'The statement nobody had to interpret', 'वह स्टेटमेंट जिसकी व्याख्या ज़रूरी नहीं थी', 'Woh statement jiski vyakhya zaroori nahi thi',
  'A couple sitting down to plan the year prints twelve months of spending. Neither of them says anything for a while. The document is not an accusation and contains no opinions. It is simply a list of what mattered enough to pay for.',
  'साल की योजना बनाने बैठा एक जोड़ा बारह महीने का ख़र्च छापता है। कुछ देर दोनों में से कोई कुछ नहीं कहता। दस्तावेज़ कोई इलज़ाम नहीं है और उसमें कोई राय नहीं है। वह बस उन चीज़ों की सूची है जो इतनी ज़रूरी थीं कि उनके पैसे दिए गए।',
  'Saal ki yojna banane baitha ek joda barah mahine ka kharch chhapta hai. Kuch der dono mein se koi kuch nahi kehta. Dastavez koi ilzaam nahi hai aur usme koi raay nahi hai. Woh bas un cheezon ki soochi hai jo itni zaroori thin ki unke paise diye gaye.',
  'Whatever their śraddhā is, that is what they are. The verse is not saying money is the measure of a person; it is saying the measure is somewhere in the behaviour rather than in the statement of intent, and this happens to be one of the places it is written down in full.',
  'उनकी श्रद्धा जो है, वही वे हैं। श्लोक यह नहीं कह रहा कि पैसा इंसान का पैमाना है; वह कह रहा है कि पैमाना इरादे के बयान में नहीं, बरताव में कहीं है, और यह उन जगहों में से एक है जहाँ वह पूरा लिखा हुआ मिल जाता है।',
  'Unki shraddha jo hai, wahi woh hain. Shloka yeh nahi keh raha ki paisa insan ka paimana hai; woh keh raha hai ki paimana iraade ke bayan mein nahi, bartav mein kahin hai, aur yeh un jagahon mein se ek hai jahan woh poora likha hua mil jaata hai.',
  'It contains no opinions. That is exactly why it was hard to look at.',
  'उसमें कोई राय नहीं है। इसीलिए तो उसे देखना मुश्किल था।',
  'Usme koi raay nahi hai. Isiliye to use dekhna mushkil tha.',
  NULL, 'intermediate', 'money,evidence,couples,honesty'

  UNION ALL SELECT 3, 'social_media', 2,
  'What he shares and what he reads', 'वह क्या साझा करता है और क्या पढ़ता है', 'Woh kya sajha karta hai aur kya padhta hai',
  'Somebody shares long posts about being present and unhurried. His own screen-time summary, which nobody else sees, shows the same four apps opened between two and three hundred times a week. Both facts are about the same person and neither is performance.',
  'कोई ठहरकर, बिना हड़बड़ी जीने के बारे में लंबी पोस्ट साझा करता है। उसका अपना स्क्रीन-टाइम सारांश, जो कोई और नहीं देखता, दिखाता है कि वही चार ऐप हफ़्ते में दो-तीन सौ बार खोले गए। दोनों बातें एक ही इंसान के बारे में हैं और कोई भी दिखावा नहीं है।',
  'Koi thehrkar, bina hadbadi jeene ke baare mein lambi post sajha karta hai. Uska apna screen-time saaransh, jo koi aur nahi dekhta, dikhata hai ki wahi chaar app hafte mein do-teen sau baar khole gaye. Dono baatein ek hi insan ke baare mein hain aur koi bhi dikhava nahi hai.',
  'This is why the verse is a method and not a promise. If believing hard enough made it so, the posts would be the answer. The chapter says look at the behaviour instead, and the behaviour here is not a hypocrisy — it is simply the more accurate of the two documents.',
  'यही वजह है कि श्लोक वादा नहीं, तरीक़ा है। अगर ज़ोर से यक़ीन करने से चीज़ें हो जातीं, तो पोस्ट ही जवाब होतीं। अध्याय कहता है कि इसके बजाय बरताव देखो, और यहाँ बरताव पाखंड नहीं है — वह बस दोनों दस्तावेज़ों में ज़्यादा सही वाला है।',
  'Yahi wajah hai ki shloka waada nahi, tareeka hai. Agar zor se yakeen karne se cheezein ho jaateen, to post hi jawab hoteen. Adhyay kehta hai ki iske bajaye bartav dekho, aur yahan bartav pakhand nahi hai — woh bas dono dastavezon mein zyada sahi wala hai.',
  'Not hypocrisy. Just the more accurate of the two documents.',
  'पाखंड नहीं। बस दोनों दस्तावेज़ों में ज़्यादा सही वाला।',
  'Pakhand nahi. Bas dono dastavezon mein zyada sahi wala.',
  NULL, 'beginner', 'social-media,attention,evidence,honesty'

  UNION ALL SELECT 3, 'relationships', 3,
  'She knew before he said it', 'उसने उसके कहने से पहले जान लिया', 'Usne uske kehne se pehle jaan liya',
  'Somebody works out that a relationship has ended about five weeks before the conversation happens. Asked later how, she cannot name a single incident. She says he stopped telling her small things, which is not an incident and is not deniable.',
  'किसी को क़रीब पाँच हफ़्ते पहले समझ आ जाता है कि रिश्ता ख़त्म हो चुका है, और बातचीत बाद में होती है। बाद में पूछने पर वह एक भी घटना नहीं बता पाती। वह कहती है कि उसने छोटी-छोटी बातें बतानी बंद कर दी थीं, जो घटना नहीं है और जिससे इनकार भी नहीं किया जा सकता।',
  'Kisi ko kareeb paanch hafte pehle samajh aa jaata hai ki rishta khatam ho chuka hai, aur baatcheet baad mein hoti hai. Baad mein poochhne par woh ek bhi ghatna nahi bata paati. Woh kehti hai ki usne chhoti chhoti baatein batani band kar di thin, jo ghatna nahi hai aur jisse inkaar bhi nahi kiya ja sakta.',
  'Whatever a person''s trust is, that is what they are — and it is legible long before anybody puts it into a sentence. Nothing was hidden and nothing was announced. The small things stopping was the whole document, and she read it correctly five weeks early.',
  'किसी का भरोसा जो है, वही वह है — और वह किसी के वाक्य में डालने से बहुत पहले पढ़ा जा सकता है। कुछ छिपाया नहीं गया और कुछ घोषित नहीं हुआ। छोटी बातों का रुक जाना ही पूरा दस्तावेज़ था, और उसने उसे पाँच हफ़्ते पहले सही पढ़ लिया।',
  'Kisi ka bharosa jo hai, wahi woh hai — aur woh kisi ke vakya mein daalne se bahut pehle padha ja sakta hai. Kuch chhipaya nahi gaya aur kuch ghoshit nahi hua. Chhoti baaton ka ruk jaana hi poora dastavez tha, aur usne use paanch hafte pehle sahi padh liya.',
  'She could not name an incident. She did not need one.',
  'वह एक भी घटना नहीं बता पाई। उसे किसी की ज़रूरत भी नहीं थी।',
  'Woh ek bhi ghatna nahi bata payi. Use kisi ki zaroorat bhi nahi thi.',
  NULL, 'intermediate', 'relationships,endings,small-things,reading'

  UNION ALL SELECT 3, 'everyday_life', 4,
  'The thing he does when he is tired', 'थकने पर वह क्या करता है', 'Thakne par woh kya karta hai',
  'Somebody notices that when he is exhausted he calls his sister, and when things are going well he does not. He has never thought of himself as somebody who leans on family. Twelve years of phone records disagree, gently.',
  'कोई देखता है कि जब वह बुरी तरह थका हो तो अपनी बहन को फ़ोन करता है, और जब सब ठीक चल रहा हो तो नहीं करता। उसने ख़ुद को कभी परिवार पर टिकने वाला नहीं समझा। बारह साल के फ़ोन रिकॉर्ड नरमी से असहमत हैं।',
  'Koi dekhta hai ki jab woh buri tarah thaka ho to apni behen ko phone karta hai, aur jab sab theek chal raha ho to nahi karta. Usne khud ko kabhi parivar par tikne wala nahi samjha. Barah saal ke phone record narmi se asehmat hain.',
  'The verse works on yourself as well as on other people, and this is the friendlier direction. What he trusts turned out to be something he had never claimed and would not have listed. Reading behaviour does not only catch people out. Sometimes it tells them something good they did not know.',
  'श्लोक दूसरों पर जितना चलता है उतना अपने पर भी, और यह ज़्यादा दोस्ताना दिशा है। वह जिस पर भरोसा करता है वह ऐसी चीज़ निकली जिसका उसने कभी दावा नहीं किया और जिसे वह गिनाता भी नहीं। बरताव पढ़ना सिर्फ़ लोगों को पकड़ता नहीं। कभी-कभी वह उन्हें कोई अच्छी बात बता देता है जो उन्हें पता नहीं थी।',
  'Shloka doosron par jitna chalta hai utna apne par bhi, aur yeh zyada dostana disha hai. Woh jis par bharosa karta hai woh aisi cheez nikli jiska usne kabhi dawa nahi kiya aur jise woh ginata bhi nahi. Bartav padhna sirf logon ko pakadta nahi. Kabhi kabhi woh unhe koi achhi baat bata deta hai jo unhe pata nahi thi.',
  'Reading the behaviour does not only catch people out. Sometimes it tells them something good.',
  'बरताव पढ़ना सिर्फ़ पकड़ता नहीं। कभी-कभी वह कोई अच्छी बात बता देता है।',
  'Bartav padhna sirf pakadta nahi. Kabhi kabhi woh koi achhi baat bata deta hai.',
  NULL, 'beginner', 'family,self-knowledge,evidence,habits'

  UNION ALL SELECT 7, 'healthcare', 1,
  'The question that was about effect', 'वह सवाल जो असर के बारे में था', 'Woh sawal jo asar ke baare mein tha',
  'Somebody keeps a note for a fortnight of one thing only: whether they felt settled or scattered an hour after eating. They record no quantities and change nothing. At the end of it a pattern is visible that had been there for years without ever being visible.',
  'कोई पखवाड़े भर सिर्फ़ एक चीज़ लिखता है: खाने के एक घंटे बाद वह ठहरा हुआ महसूस कर रहा था या बिखरा हुआ। वह कोई मात्रा नहीं लिखता और कुछ नहीं बदलता। आख़िर में एक ढर्रा दिखने लगता है जो सालों से मौजूद था और कभी दिखा नहीं था।',
  'Koi pakhwade bhar sirf ek cheez likhta hai: khane ke ek ghante baad woh thehra hua mehsoos kar raha tha ya bikhra hua. Woh koi maatra nahi likhta aur kuch nahi badalta. Aakhir mein ek dharra dikhne lagta hai jo saalon se maujood tha aur kabhi dikha nahi tha.',
  'This is the axis the verse actually sorts on, and it is worth being exact: the verses after 17.7 describe food by what it does to somebody, and not one of them names an amount. A note that records only the effect is running the chapter''s own test and cannot turn into a target.',
  'श्लोक असल में इसी धुरी पर छाँटता है, और यह ठीक-ठीक कहना ज़रूरी है: 17.7 के बाद के श्लोक खाने का वर्णन इस आधार पर करते हैं कि वह किसी के साथ करता क्या है, और उनमें से एक भी मात्रा नहीं बताता। सिर्फ़ असर लिखने वाला नोट अध्याय की अपनी कसौटी चला रहा है और वह किसी निशाने में बदल नहीं सकता।',
  'Shloka asal mein isi dhuri par chhaanta hai, aur yeh theek theek kehna zaroori hai: 17.7 ke baad ke shloka khane ka varnan is aadhar par karte hain ki woh kisi ke saath karta kya hai, aur unme se ek bhi maatra nahi batata. Sirf asar likhne wala note adhyay ki apni kasauti chala raha hai aur woh kisi nishane mein badal nahi sakta.',
  'An effect can be noticed. A target can be missed. The verse only ever asks for the first.',
  'असर देखा जा सकता है। निशाना चूका जा सकता है। श्लोक हमेशा सिर्फ़ पहली चीज़ माँगता है।',
  'Asar dekha ja sakta hai. Nishana chooka ja sakta hai. Shloka hamesha sirf pehli cheez maangta hai.',
  NULL, 'beginner', 'health,noticing,effects,no-targets'

  UNION ALL SELECT 7, 'sports', 2,
  'What he ate before the good games', 'अच्छे मैचों से पहले वह क्या खाता था', 'Achhe matchon se pehle woh kya khata tha',
  'A club player works out, over a season, that he plays better after meals somebody cooked than after meals he grabbed. He cannot separate the food from the sitting down, and after a while he stops trying to.',
  'एक क्लब खिलाड़ी एक सीज़न में समझता है कि वह उन खानों के बाद बेहतर खेलता है जो किसी ने बनाए हों, बनिस्बत उनके जो उसने जल्दबाज़ी में उठाए हों। वह खाने को बैठकर खाने से अलग नहीं कर पाता, और कुछ देर बाद कोशिश करना छोड़ देता है।',
  'Ek club khilaadi ek season mein samajhta hai ki woh un khanon ke baad behtar khelta hai jo kisi ne banaye hon, banisbat unke jo usne jaldbaazi mein uthaye hon. Woh khane ko baithkar khane se alag nahi kar paata, aur kuch der baad koshish karna chhod deta hai.',
  'The verses after this one describe sattvic food partly in terms of care — fresh, made properly, not snatched. He has arrived at the same finding from the other end, and the fact that the food and the sitting down cannot be separated is not a flaw in his experiment. It may be the point.',
  'इसके बाद के श्लोक सात्त्विक खाने का वर्णन कुछ हद तक ध्यान के हिसाब से करते हैं — ताज़ा, ठीक से बना, झपटकर लिया हुआ नहीं। वह दूसरे सिरे से उसी नतीजे पर पहुँचा है, और यह कि खाना और बैठकर खाना अलग नहीं हो पाते, उसके प्रयोग की ख़ामी नहीं है। शायद यही बात है।',
  'Iske baad ke shloka sattvik khane ka varnan kuch had tak dhyan ke hisaab se karte hain — taaza, theek se bana, jhapatkar liya hua nahi. Woh doosre sire se usi nateeje par pahuncha hai, aur yeh ki khana aur baithkar khana alag nahi ho paate, uske prayog ki khaami nahi hai. Shayad yahi baat hai.',
  'He could not separate the food from the sitting down. That may have been the finding.',
  'वह खाने को बैठकर खाने से अलग नहीं कर पाया। शायद निष्कर्ष यही था।',
  'Woh khane ko baithkar khane se alag nahi kar paya. Shayad nishkarsh yahi tha.',
  NULL, 'beginner', 'sport,food,care,attention'

  UNION ALL SELECT 7, 'everyday_life', 3,
  'The lunch somebody made', 'वह दोपहर का खाना जो किसी ने बनाया', 'Woh dopahar ka khana jo kisi ne banaya',
  'Two lunches on two days. One eaten standing at a counter reading a screen, one eaten at a table with somebody who made it. The person could not tell you what was in either of them and can tell you exactly how the afternoons went.',
  'दो दिन के दो दोपहर के खाने। एक काउंटर पर खड़े होकर स्क्रीन पढ़ते हुए खाया गया, एक मेज़ पर किसी के साथ जिसने उसे बनाया था। वह इंसान आपको यह नहीं बता सकता कि दोनों में था क्या और यह ठीक-ठीक बता सकता है कि दोनों दोपहरें कैसी गुज़रीं।',
  'Do din ke do dopahar ke khane. Ek counter par khade hokar screen padhte hue khaya gaya, ek mez par kisi ke saath jisne use banaya tha. Woh insan tumhe yeh nahi bata sakta ki dono mein tha kya aur yeh theek theek bata sakta hai ki dono dopaharein kaisi guzreen.',
  'The chapter puts food alongside offering, practice and giving — four ordinary things done in a state. That is a hint about what it is actually sorting. What went on the plate is only part of it, and the part almost nobody logs is the rest.',
  'अध्याय खाने को चढ़ावे, अभ्यास और दान के साथ रखता है — किसी हालत में किए गए चार आम काम। यह इशारा है कि वह छाँट क्या रहा है। थाली में क्या गया वह उसका सिर्फ़ एक हिस्सा है, और जो हिस्सा लगभग कोई नहीं लिखता वह बाक़ी है।',
  'Adhyay khane ko chadhave, abhyas aur daan ke saath rakhta hai — kisi haalat mein kiye gaye chaar aam kaam. Yeh ishara hai ki woh chhaant kya raha hai. Thali mein kya gaya woh uska sirf ek hissa hai, aur jo hissa lagbhag koi nahi likhta woh baaki hai.',
  'He could not name what was on either plate. He could name both afternoons.',
  'वह यह नहीं बता सका कि दोनों थालियों में क्या था। वह दोनों दोपहरें बता सका।',
  'Woh yeh nahi bata saka ki dono thaliyon mein kya tha. Woh dono dopaharein bata saka.',
  NULL, 'beginner', 'food,attention,company,afternoons'

  UNION ALL SELECT 7, 'college', 4,
  'The week the kitchen closed', 'वह हफ़्ता जब रसोई बंद रही', 'Woh hafta jab rasoi band rahi',
  'A student whose hall kitchen shuts for a week eats standing up, alone, at odd hours, out of packets. Nothing about the week is a disaster and everything about it is slightly harder than it should be. He notices this without being able to say why.',
  'एक छात्र, जिसके हॉस्टल की रसोई हफ़्ते भर बंद है, खड़े होकर, अकेले, अजीब वक़्तों पर, पैकेट से खाता है। हफ़्ते में कुछ भी आपदा नहीं है और सब कुछ ज़रा-सा ज़्यादा मुश्किल है। उसे यह दिखता है और वह वजह नहीं बता पाता।',
  'Ek student, jiske hostel ki rasoi hafte bhar band hai, khade hokar, akele, ajeeb waqton par, packet se khata hai. Hafte mein kuch bhi aapda nahi hai aur sab kuch zara sa zyada mushkil hai. Use yeh dikhta hai aur woh wajah nahi bata pata.',
  'The chapter would say the state travelled with the eating rather than the eating causing the state, and that the two are hard to pull apart on purpose. Nothing here is a rule about packets. It is a week where several ordinary supports were absent at once, and food was one of them.',
  'अध्याय कहेगा कि हालत खाने के साथ-साथ चली, न कि खाने ने हालत बनाई, और दोनों को अलग करना जानबूझकर मुश्किल है। यहाँ पैकेट के बारे में कोई नियम नहीं है। यह एक ऐसा हफ़्ता है जिसमें कई आम सहारे एक साथ ग़ैरहाज़िर थे, और खाना उनमें से एक था।',
  'Adhyay kahega ki haalat khane ke saath saath chali, na ki khane ne haalat banayi, aur dono ko alag karna jaanboojhkar mushkil hai. Yahan packet ke baare mein koi niyam nahi hai. Yeh ek aisa hafta hai jisme kai aam sahaare ek saath gairhazir the, aur khana unme se ek tha.',
  'Several ordinary supports went missing at once. Food was one of them, not the cause.',
  'कई आम सहारे एक साथ ग़ायब हो गए। खाना उनमें से एक था, वजह नहीं।',
  'Kai aam sahaare ek saath gayab ho gaye. Khana unme se ek tha, wajah nahi.',
  NULL, 'beginner', 'students,routine,support,food'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 17;

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

  SELECT 15 AS vn, 'corporate' AS cat, 1 AS ord,
  'Right, and completely unusable' AS t_en, 'सही, और बिलकुल बेकार' AS t_hi, 'Sahi, aur bilkul bekaar' AS t_hing,
  'Somebody points out a genuine flaw in a colleague''s work, accurately, in front of eleven people, at the end of a long meeting. Every word is correct. The flaw does not get fixed for another two months.' AS s_en,
  'कोई एक साथी के काम में असली ख़ामी बताता है, बिलकुल सही, ग्यारह लोगों के सामने, एक लंबी मीटिंग के आख़िर में। हर शब्द सही है। ख़ामी अगले दो महीने तक ठीक नहीं होती।' AS s_hi,
  'Koi ek saathi ke kaam mein asli khaami batata hai, bilkul sahi, gyarah logon ke saamne, ek lambi meeting ke aakhir mein. Har shabd sahi hai. Khaami agle do mahine tak theek nahi hoti.' AS s_hing,
  'The verse asks for four things at once and he has one of them. It is worth being precise about which: the content did not need softening. The room and the hour did. Anudvega-kara is not a rule against saying hard things, it is a rule against saying them in a way that guarantees they cannot be heard.' AS c_en,
  'श्लोक एक साथ चार चीज़ें माँगता है और उसके पास एक है। ठीक-ठीक कहना ज़रूरी है कि कौन-सी: बात को नरम करने की ज़रूरत नहीं थी। कमरे और घड़ी को थी। अनुद्वेगकर कठिन बातें न कहने का नियम नहीं है, यह उन्हें ऐसे कहने के ख़िलाफ़ नियम है जिससे पक्का हो जाए कि वे सुनी नहीं जाएँगी।' AS c_hi,
  'Shloka ek saath chaar cheezein maangta hai aur uske paas ek hai. Theek theek kehna zaroori hai ki kaun si: baat ko naram karne ki zaroorat nahi thi. Kamre aur ghadi ko thi. Anudvega-kar kathin baatein na kehne ka niyam nahi hai, yeh unhe aise kehne ke khilaf niyam hai jisse pakka ho jaaye ki woh suni nahi jayengi.' AS c_hing,
  'The content did not need softening. The room and the hour did.' AS l_en,
  'बात को नरम करने की ज़रूरत नहीं थी। कमरे और घड़ी को थी।' AS l_hi,
  'Baat ko naram karne ki zaroorat nahi thi. Kamre aur ghadi ko thi.' AS l_hing,
  NULL AS src, 'intermediate' AS diff, 'work,feedback,timing,truth' AS tags

  UNION ALL SELECT 15, 'parenting', 2,
  'The same sentence at two different times', 'वही वाक्य दो अलग वक़्तों पर', 'Wahi vakya do alag waqton par',
  'A parent needs to say something about a child''s behaviour at a party. Version one is said in the car on the way home while both of them are tired. Version two is said on Sunday morning over breakfast. The sentence is nearly identical. Only one of them gets discussed.',
  'एक अभिभावक को किसी पार्टी में बच्चे के बरताव के बारे में कुछ कहना है। पहला रूप घर लौटते हुए गाड़ी में कहा जाता है जब दोनों थके हुए हैं। दूसरा रविवार सुबह नाश्ते पर। वाक्य लगभग वही है। उनमें से सिर्फ़ एक पर बात होती है।',
  'Ek abhibhavak ko kisi party mein bachche ke bartav ke baare mein kuch kehna hai. Pehla roop ghar lautte hue gaadi mein kaha jaata hai jab dono thake hue hain. Doosra Sunday subah nashte par. Vakya lagbhag wahi hai. Unme se sirf ek par baat hoti hai.',
  'Two of the four conditions — not agitating, and actually useful — are almost entirely about when. The verse asks for four things at once, and it turns out that two of them can often be satisfied without changing a single word.',
  'चारों में से दो शर्तें — न भड़काना, और सचमुच काम की होना — लगभग पूरी तरह इस बारे में हैं कि कब। श्लोक एक साथ चार चीज़ें माँगता है, और पता चलता है कि उनमें से दो अक्सर एक भी शब्द बदले बिना पूरी की जा सकती हैं।',
  'Chaaron mein se do shartein — na bhadkana, aur sach mein kaam ki hona — lagbhag poori tarah is baare mein hain ki kab. Shloka ek saath chaar cheezein maangta hai, aur pata chalta hai ki unme se do aksar ek bhi shabd badle bina poori ki ja sakti hain.',
  'Two of the four conditions are satisfied by the clock, not by the wording.',
  'चारों में से दो शर्तें शब्दों से नहीं, घड़ी से पूरी होती हैं।',
  'Chaaron mein se do shartein shabdon se nahi, ghadi se poori hoti hain.',
  NULL, 'beginner', 'parenting,timing,speech,tiredness'

  UNION ALL SELECT 15, 'healthcare', 3,
  'How she gives bad news', 'वह बुरी ख़बर कैसे देती है', 'Woh buri khabar kaise deti hai',
  'A consultant giving a serious diagnosis sits down, says the important sentence early and plainly, then stops talking for a while. She does not soften anything and she does not hurry. Patients remember her as gentle. What she actually did was not rush.',
  'गंभीर निदान बताती एक कंसल्टेंट बैठ जाती है, ज़रूरी वाक्य जल्दी और सीधे कह देती है, फिर कुछ देर बोलना बंद कर देती है। वह कुछ नरम नहीं करती और जल्दबाज़ी नहीं करती। मरीज़ उसे नरम-दिल के तौर पर याद रखते हैं। उसने असल में जो किया वह था जल्दी न करना।',
  'Gambhir nidan batati ek consultant baith jaati hai, zaroori vakya jaldi aur seedhe keh deti hai, phir kuch der bolna band kar deti hai. Woh kuch naram nahi karti aur jaldbaazi nahi karti. Mareez use naram-dil ke taur par yaad rakhte hain. Usne asal mein jo kiya woh tha jaldi na karna.',
  'All four conditions, met at once, on the hardest possible content. This is the answer to anybody who reads the verse as a rule against difficult speech: nothing here was softened, the truth arrived early, and it still did not throw the person across the room.',
  'चारों शर्तें, एक साथ पूरी, सबसे कठिन संभव बात पर। यह उनका जवाब है जो श्लोक को कठिन बात कहने के ख़िलाफ़ नियम की तरह पढ़ते हैं: यहाँ कुछ नरम नहीं किया गया, सच जल्दी आया, और फिर भी उसने सामने वाले को उथल-पुथल में नहीं फेंका।',
  'Chaaron shartein, ek saath poori, sabse kathin sambhav baat par. Yeh unka jawab hai jo shloka ko kathin baat kehne ke khilaf niyam ki tarah padhte hain: yahan kuch naram nahi kiya gaya, sach jaldi aaya, aur phir bhi usne saamne wale ko uthal-puthal mein nahi phenka.',
  'She softened nothing. She sat down and she did not hurry.',
  'उसने कुछ नरम नहीं किया। वह बैठ गई और जल्दी नहीं की।',
  'Usne kuch naram nahi kiya. Woh baith gayi aur jaldi nahi ki.',
  NULL, 'intermediate', 'medicine,bad-news,pace,kindness'

  UNION ALL SELECT 15, 'everyday_life', 4,
  'The message he read back before sending', 'वह संदेश जो उसने भेजने से पहले दोबारा पढ़ा', 'Woh message jo usne bhejne se pehle dobara padha',
  'Somebody writes a long message settling an old grievance, then reads it as though he were receiving it. He finds three sentences that are true, unkind and unnecessary, and cuts them. The message gets shorter and the point survives intact.',
  'कोई एक पुरानी शिकायत निपटाता लंबा संदेश लिखता है, फिर उसे ऐसे पढ़ता है जैसे वह उसे मिल रहा हो। उसे तीन ऐसे वाक्य मिलते हैं जो सच हैं, कठोर हैं और ग़ैरज़रूरी हैं, और वह उन्हें काट देता है। संदेश छोटा हो जाता है और बात पूरी बची रहती है।',
  'Koi ek purani shikayat niptata lamba message likhta hai, phir use aise padhta hai jaise woh use mil raha ho. Use teen aise vakya milte hain jo sach hain, kathor hain aur gairzaroori hain, aur woh unhe kaat deta hai. Message chhota ho jaata hai aur baat poori bachi rehti hai.',
  'Svādhyāya — reading yourself back — is in the same verse as the four conditions, and this is why. The three sentences all passed the truth test and failed the other three, and the only way to catch that is to read your own words from the other side of them.',
  'स्वाध्याय — ख़ुद को दोबारा पढ़ना — उसी श्लोक में है जिसमें चारों शर्तें हैं, और वजह यही है। तीनों वाक्य सच की कसौटी पर खरे उतरे और बाक़ी तीन पर नाकाम रहे, और इसे पकड़ने का एक ही तरीक़ा है कि आप अपने ही शब्द उनकी दूसरी तरफ़ से पढ़ें।',
  'Svadhyay — khud ko dobara padhna — usi shloka mein hai jisme chaaron shartein hain, aur wajah yahi hai. Teenon vakya sach ki kasauti par khare utre aur baaki teen par nakaam rahe, aur ise pakadne ka ek hi tareeka hai ki tum apne hi shabd unki doosri taraf se padho.',
  'All three were true. All three failed the other three tests.',
  'तीनों सच थे। तीनों बाक़ी तीन कसौटियों पर नाकाम रहे।',
  'Teenon sach the. Teenon baaki teen kasautiyon par nakaam rahe.',
  NULL, 'beginner', 'messages,editing,truth,kindness'

  UNION ALL SELECT 16, 'everyday_life', 1,
  'She stopped tightening', 'उसने कसना बंद कर दिया', 'Usne kasna band kar diya',
  'Somebody trying to concentrate notices her mind has wandered and, out of habit, grips harder. It works for about forty seconds. The next time she notices, she does nothing except sit back slightly, and then returns to the work. That one holds.',
  'ध्यान लगाने की कोशिश करती किसी को दिखता है कि मन भटक गया है और आदतन वह और कसकर पकड़ती है। यह क़रीब चालीस सेकंड चलता है। अगली बार जब उसे दिखता है, वह कुछ नहीं करती सिवाय ज़रा पीछे टिकने के, और फिर काम पर लौट आती है। यह वाला टिकता है।',
  'Dhyan lagane ki koshish karti kisi ko dikhta hai ki man bhatak gaya hai aur aadatan woh aur kaskar pakadti hai. Yeh kareeb chalees second chalta hai. Agli baar jab use dikhta hai, woh kuch nahi karti siwaye zara peechhe tikne ke, aur phir kaam par laut aati hai. Yeh wala tikta hai.',
  'The list in the verse puts prasāda first and vinigraha — the holding — fourth. Almost everybody starts at fourth. The order is not decorative: something settled can be held, and something held hard has to be held again in forty seconds.',
  'श्लोक की सूची प्रसाद को पहले रखती है और विनिग्रह — पकड़ — को चौथे नंबर पर। लगभग हर कोई चौथे से शुरू करता है। यह क्रम सजावट नहीं है: जो ठहरा हुआ है उसे थामा जा सकता है, और जिसे ज़ोर से थामा गया है उसे चालीस सेकंड में फिर थामना पड़ता है।',
  'Shloka ki soochi prasad ko pehle rakhti hai aur vinigrah — pakad — ko chauthe number par. Lagbhag har koi chauthe se shuru karta hai. Yeh kram sajawat nahi hai: jo thehra hua hai use thaama ja sakta hai, aur jise zor se thaama gaya hai use chalees second mein phir thaamna padta hai.',
  'Grip lasts forty seconds. Settling lasts.',
  'पकड़ चालीस सेकंड चलती है। ठहराव चलता है।',
  'Pakad chalees second chalti hai. Thehrav chalta hai.',
  NULL, 'beginner', 'attention,gentleness,concentration,order'

  UNION ALL SELECT 16, 'sports', 2,
  'The coach who lowered his voice', 'वह कोच जिसने आवाज़ धीमी की', 'Woh coach jisne aawaz dheemi ki',
  'A youth coach known for shouting spends a season not shouting, on a bet with himself. The technical instruction is identical. Results are about the same. What changes is that four players who used to freeze at the moment of decision stop freezing.',
  'चिल्लाने के लिए मशहूर एक जूनियर कोच ख़ुद से लगाई शर्त पर एक सीज़न बिना चिल्लाए बिताता है। तकनीकी हिदायत बिलकुल वही है। नतीजे लगभग वही हैं। बदलाव यह होता है कि जो चार खिलाड़ी फ़ैसले के पल पर जम जाते थे, वे जमना बंद कर देते हैं।',
  'Chillane ke liye mashhoor ek junior coach khud se lagayi shart par ek season bina chillaye bitata hai. Takneeki hidayat bilkul wahi hai. Nateeje lagbhag wahi hain. Badlav yeh hota hai ki jo chaar khilaadi faisle ke pal par jam jaate the, woh jamna band kar dete hain.',
  'Saumyatva — gentleness — is on this list and severity is nowhere on it. The instruction was never the problem, which is why the results held. What the shouting was adding was agitation, and agitation is the exact thing prasāda names the absence of.',
  'सौम्यत्व — नरमी — इस सूची में है और कठोरता इसमें कहीं नहीं। हिदायत कभी दिक़्क़त थी ही नहीं, इसीलिए नतीजे टिके रहे। चिल्लाना जो जोड़ रहा था वह थी उथल-पुथल, और प्रसाद ठीक उसी की ग़ैरहाज़िरी का नाम है।',
  'Saumyatva — narmi — is soochi mein hai aur kathorta isme kahin nahi. Hidayat kabhi dikkat thi hi nahi, isiliye nateeje tike rahe. Chillana jo jod raha tha woh thi uthal-puthal, aur prasad theek usi ki gairhazri ka naam hai.',
  'The instruction was never the problem. What the volume added was agitation.',
  'हिदायत कभी दिक़्क़त थी ही नहीं। आवाज़ जो जोड़ रही थी वह उथल-पुथल थी।',
  'Hidayat kabhi dikkat thi hi nahi. Aawaz jo jod rahi thi woh uthal-puthal thi.',
  NULL, 'intermediate', 'coaching,gentleness,pressure,performance'

  UNION ALL SELECT 16, 'college', 3,
  'The silence that was not withholding', 'वह चुप्पी जो रोकना नहीं थी', 'Woh chuppi jo rokna nahi thi',
  'Two flatmates fall out. One of them goes quiet for three days as a punishment. The other goes quiet for an evening because she has nothing considered to say yet. Both are silent. Only one of the two silences is on the list in this verse.',
  'दो फ़्लैटमेट्स में अनबन हो जाती है। उनमें से एक तीन दिन सज़ा के तौर पर चुप रहता है। दूसरी एक शाम चुप रहती है क्योंकि अभी उसके पास सोची-समझी कोई बात नहीं है। दोनों चुप हैं। इन दोनों चुप्पियों में से सिर्फ़ एक इस श्लोक की सूची में है।',
  'Do flatmates mein anban ho jaati hai. Unme se ek teen din saza ke taur par chup rehta hai. Doosri ek shaam chup rehti hai kyunki abhi uske paas sochi-samjhi koi baat nahi hai. Dono chup hain. In dono chuppiyon mein se sirf ek is shloka ki soochi mein hai.',
  'Mauna sits between gentleness and self-restraint in the list, and the company it keeps is the definition. Silence used as a weapon is agitation with the sound off. The verse is describing the other kind, which is what you do while something settles.',
  'मौन सूची में नरमी और आत्म-संयम के बीच बैठा है, और वह जिसकी संगत में है वही उसकी परिभाषा है। हथियार की तरह इस्तेमाल की गई चुप्पी आवाज़ बंद करके की गई उथल-पुथल है। श्लोक दूसरी क़िस्म का वर्णन कर रहा है, वह जो आप तब करते हैं जब कुछ ठहर रहा हो।',
  'Maun soochi mein narmi aur aatm-sanyam ke beech baitha hai, aur woh jiski sangat mein hai wahi uski paribhasha hai. Hathiyar ki tarah istemaal ki gayi chuppi aawaz band karke ki gayi uthal-puthal hai. Shloka doosri kism ka varnan kar raha hai, woh jo tum tab karte ho jab kuch thehr raha ho.',
  'Silence used as a weapon is agitation with the sound off.',
  'हथियार की तरह इस्तेमाल की गई चुप्पी आवाज़ बंद करके की गई उथल-पुथल है।',
  'Hathiyar ki tarah istemaal ki gayi chuppi aawaz band karke ki gayi uthal-puthal hai.',
  NULL, 'intermediate', 'flatmates,silence,conflict,definitions'

  UNION ALL SELECT 16, 'technology', 4,
  'Meaning what the message appears to mean', 'वही मतलब जो संदेश में दिखता है', 'Wahi matlab jo message mein dikhta hai',
  'Somebody sends "sure, no problem" about a request he has real objections to. The objections come out three weeks later in a different meeting, attached to a different decision, where nobody can trace them back.',
  'कोई एक ऐसे अनुरोध के बारे में "हाँ, कोई दिक़्क़त नहीं" भेजता है जिस पर उसे असली आपत्तियाँ हैं। आपत्तियाँ तीन हफ़्ते बाद किसी और मीटिंग में निकलती हैं, किसी और फ़ैसले से जुड़ी हुईं, जहाँ कोई उन्हें पीछे तक नहीं जोड़ पाता।',
  'Koi ek aise anurodh ke baare mein "haan, koi dikkat nahi" bhejta hai jis par use asli aapattiyan hain. Aapattiyan teen hafte baad kisi aur meeting mein nikalti hain, kisi aur faisle se judi hueen, jahan koi unhe peechhe tak nahi jod paata.',
  'Bhāva-saṁśuddhi is last on the list and it is the one that costs most: meaning what you appear to mean. Nothing was lied about. The gap between the message and the intent simply had to come out somewhere, and where it came out was three weeks and one decision away from where it belonged.',
  'भावसंशुद्धि सूची में आख़िरी है और वही सबसे महँगी है: वही मतलब रखना जो दिखता है। किसी बारे में झूठ नहीं बोला गया। संदेश और नीयत के बीच का फ़ासला बस कहीं न कहीं निकलना ही था, और वह वहाँ निकला जो अपनी जगह से तीन हफ़्ते और एक फ़ैसला दूर थी।',
  'Bhav-samshuddhi soochi mein aakhiri hai aur wahi sabse mehngi hai: wahi matlab rakhna jo dikhta hai. Kisi baare mein jhooth nahi bola gaya. Message aur niyat ke beech ka faasla bas kahin na kahin nikalna hi tha, aur woh wahan nikla jo apni jagah se teen hafte aur ek faisla door thi.',
  'The gap had to come out somewhere. It came out three weeks from where it belonged.',
  'फ़ासले को कहीं न कहीं निकलना ही था। वह अपनी जगह से तीन हफ़्ते दूर निकला।',
  'Faasle ko kahin na kahin nikalna hi tha. Woh apni jagah se teen hafte door nikla.',
  NULL, 'intermediate', 'work,agreement,intent,delay'

  UNION ALL SELECT 19, 'sports', 1,
  'He stopped running on the bad ankle', 'उसने ख़राब टख़ने पर दौड़ना बंद कर दिया', 'Usne kharab takhne par daudna band kar diya',
  'An amateur runner has been training through a hurt ankle for five months on the theory that stopping would prove something about him. He stops. Nothing takes its place — no substitute programme, no cross-training plan. He just stops, and the week is strange, and then it is not.',
  'एक शौक़िया धावक पाँच महीने से चोटिल टख़ने पर इस सोच के साथ अभ्यास कर रहा है कि रुकना उसके बारे में कुछ साबित कर देगा। वह रुक जाता है। उसकी जगह कुछ नहीं आता — न कोई विकल्प कार्यक्रम, न कोई और योजना। वह बस रुक जाता है, और हफ़्ता अजीब लगता है, और फिर नहीं लगता।',
  'Ek shaukiya dhavak paanch mahine se chotil takhne par is soch ke saath abhyas kar raha hai ki rukna uske baare mein kuch saabit kar dega. Woh ruk jaata hai. Uski jagah kuch nahi aata — na koi vikalp karyakram, na koi aur yojna. Woh bas ruk jaata hai, aur hafta ajeeb lagta hai, aur phir nahi lagta.',
  'Mūḍha-grāha is a stubborn wrong idea held onto, and his was that stopping would mean something about him. Note what does not happen here: nothing replaces it. Swapping the punishment for a gentler regimen would say the problem was the severity. The verse says the problem is the category.',
  'मूढ़ग्राह ज़िद से पकड़ा हुआ ग़लत ख़याल है, और उसका यह था कि रुकने का उसके बारे में कोई मतलब निकलेगा। ध्यान दीजिए यहाँ क्या नहीं होता: उसकी जगह कुछ नहीं आता। सज़ा को किसी नरम कार्यक्रम से बदल देना यह कहता कि दिक़्क़त सख़्ती थी। श्लोक कहता है कि दिक़्क़त श्रेणी है।',
  'Mudh-grah zid se pakda hua galat khayal hai, aur uska yeh tha ki rukne ka uske baare mein koi matlab niklega. Dhyan do yahan kya nahi hota: uski jagah kuch nahi aata. Saza ko kisi naram karyakram se badal dena yeh kehta ki dikkat sakhti thi. Shloka kehta hai ki dikkat shreni hai.',
  'Nothing replaced it. Swapping in a gentler version would have missed the verse entirely.',
  'उसकी जगह कुछ नहीं आया। कोई नरम रूप रख देना श्लोक को पूरी तरह चूक जाना होता।',
  'Uski jagah kuch nahi aaya. Koi naram roop rakh dena shloka ko poori tarah chook jaana hota.',
  NULL, 'beginner', 'training,injury,stopping,self-punishment'

  UNION ALL SELECT 19, 'healthcare', 2,
  'The rule she had made for herself', 'वह नियम जो उसने ख़ुद के लिए बनाया था', 'Woh niyam jo usne khud ke liye banaya tha',
  'Somebody has a private rule that she is not allowed to sit down until a particular list is finished. It has been in force for about two years and she has never told anybody about it. She says it out loud to one person, and hearing it out loud is most of what happens.',
  'किसी का अपना एक नियम है कि जब तक एक ख़ास सूची पूरी न हो, उसे बैठने की इजाज़त नहीं। यह क़रीब दो साल से चल रहा है और उसने कभी किसी को इसके बारे में नहीं बताया। वह इसे एक इंसान से ज़ोर से कहती है, और ज़ोर से सुनना ही ज़्यादातर काम कर जाता है।',
  'Kisi ka apna ek niyam hai ki jab tak ek khaas soochi poori na ho, use baithne ki ijazat nahi. Yeh kareeb do saal se chal raha hai aur usne kabhi kisi ko iske baare mein nahi bataya. Woh ise ek insan se zor se kehti hai, aur zor se sunna hi zyadatar kaam kar jaata hai.',
  'The verse names three things and pīḍā — hurting yourself — is the middle one. A rule that runs for two years and has never been said out loud is doing exactly that, and the text puts it in the bottom category rather than treating it as discipline that went slightly too far.',
  'श्लोक तीन चीज़ें गिनाता है और पीड़ा — ख़ुद को तकलीफ़ देना — बीच वाली है। दो साल चलने वाला और कभी ज़ोर से न कहा गया नियम ठीक यही कर रहा है, और ग्रंथ उसे उस अनुशासन की तरह नहीं लेता जो थोड़ा ज़्यादा हो गया — वह उसे सबसे नीचे रख देता है।',
  'Shloka teen cheezein ginata hai aur peeda — khud ko takleef dena — beech wali hai. Do saal chalne wala aur kabhi zor se na kaha gaya niyam theek yahi kar raha hai, aur granth use us anushasan ki tarah nahi leta jo thoda zyada ho gaya — woh use sabse neeche rakh deta hai.',
  'A rule you have never said out loud to anybody is worth saying out loud to somebody.',
  'जो नियम आपने कभी किसी से ज़ोर से नहीं कहा, वह किसी से ज़ोर से कहने लायक़ है।',
  'Jo niyam tumne kabhi kisi se zor se nahi kaha, woh kisi se zor se kehne layak hai.',
  NULL, 'beginner', 'self-punishment,rules,saying-it,stopping'

  UNION ALL SELECT 19, 'corporate', 3,
  'The hours that were proving something', 'वे घंटे जो कुछ साबित कर रहे थे', 'Woh ghante jo kuch saabit kar rahe the',
  'Somebody has been working late for eleven months, and when he examines it honestly the work does not require it. The hours are proving something to somebody who left the company a year ago. He goes home at six on a Tuesday and nothing happens.',
  'कोई ग्यारह महीने से देर तक काम कर रहा है, और ईमानदारी से देखने पर काम को इसकी ज़रूरत नहीं है। वे घंटे किसी ऐसे को कुछ साबित कर रहे हैं जो साल भर पहले कंपनी छोड़ चुका है। वह एक मंगलवार छह बजे घर चला जाता है और कुछ नहीं होता।',
  'Koi gyarah mahine se der tak kaam kar raha hai, aur imaandari se dekhne par kaam ko iski zaroorat nahi hai. Woh ghante kisi aise ko kuch saabit kar rahe hain jo saal bhar pehle company chhod chuka hai. Woh ek Tuesday chhah baje ghar chala jaata hai aur kuch nahi hota.',
  'Mūḍha-grāha is the first item in the verse and this is what it looks like in an office: a stubbornly held idea driving a practice long after the idea stopped applying. The verse is unusually blunt about it. This is not admirable and it is not even middling; it is the bottom of the three.',
  'मूढ़ग्राह श्लोक की पहली चीज़ है और दफ़्तर में वह ऐसा दिखता है: ज़िद से पकड़ा हुआ एक ख़याल, जो उस ख़याल के लागू होना बंद हो जाने के बहुत बाद तक एक अभ्यास चला रहा है। श्लोक इस बारे में असामान्य रूप से दो-टूक है। यह प्रशंसनीय नहीं है और बीच का भी नहीं है; यह तीनों में सबसे नीचे है।',
  'Mudh-grah shloka ki pehli cheez hai aur daftar mein woh aisa dikhta hai: zid se pakda hua ek khayal, jo us khayal ke laagu hona band ho jaane ke bahut baad tak ek abhyas chala raha hai. Shloka is baare mein asamanya roop se do-took hai. Yeh prashansaniya nahi hai aur beech ka bhi nahi hai; yeh teenon mein sabse neeche hai.',
  'The hours were for somebody who left a year ago. He went home at six and nothing happened.',
  'वे घंटे किसी ऐसे के लिए थे जो साल भर पहले जा चुका था। वह छह बजे घर गया और कुछ नहीं हुआ।',
  'Woh ghante kisi aise ke liye the jo saal bhar pehle ja chuka tha. Woh chhah baje ghar gaya aur kuch nahi hua.',
  NULL, 'intermediate', 'work,overwork,proving,stopping'

  UNION ALL SELECT 19, 'everyday_life', 4,
  'The list he kept about himself', 'वह सूची जो उसने अपने बारे में रखी', 'Woh soochi jo usne apne baare mein rakhi',
  'Somebody keeps a running mental tally of everything he has failed at, and reviews it, most nights, deliberately, on the grounds that it keeps him honest. He stops reviewing it. The tally is still there. He simply stops going through it at eleven at night.',
  'कोई अपने भीतर हर उस चीज़ की चलती हुई गिनती रखता है जिसमें वह नाकाम रहा, और ज़्यादातर रातों को जानबूझकर उसे दोहराता है, इस आधार पर कि इससे वह ईमानदार बना रहता है। वह दोहराना बंद कर देता है। गिनती अब भी वहीं है। वह बस रात ग्यारह बजे उससे गुज़रना बंद कर देता है।',
  'Koi apne bheetar har us cheez ki chalti hui ginti rakhta hai jisme woh nakaam raha, aur zyadatar raaton ko jaanboojhkar use dohrata hai, is aadhar par ki isse woh imaandar bana rehta hai. Woh dohrana band kar deta hai. Ginti ab bhi wahin hai. Woh bas raat gyarah baje usse guzarna band kar deta hai.',
  'The theory that it keeps him honest is the mūḍha-grāha, and the nightly review is the pīḍā. Note again what does not happen: he does not replace it with a gratitude list or anything else. The verse does not ask for a better practice in this slot. It says the slot was the mistake.',
  'यह सोच कि इससे वह ईमानदार बना रहता है, वही मूढ़ग्राह है, और रात का दोहराना वही पीड़ा है। फिर देखिए क्या नहीं होता: वह उसकी जगह कोई कृतज्ञता-सूची या कुछ और नहीं रखता। श्लोक इस ख़ाने में कोई बेहतर अभ्यास नहीं माँगता। वह कहता है कि ख़ाना ही ग़लती थी।',
  'Yeh soch ki isse woh imaandar bana rehta hai, wahi mudh-grah hai, aur raat ka dohrana wahi peeda hai. Phir dekho kya nahi hota: woh uski jagah koi kritagyata-soochi ya kuch aur nahi rakhta. Shloka is khaane mein koi behtar abhyas nahi maangta. Woh kehta hai ki khaana hi galti thi.',
  'The verse does not ask for a better practice in that slot. It says the slot was the mistake.',
  'श्लोक उस ख़ाने में कोई बेहतर अभ्यास नहीं माँगता। वह कहता है कि ख़ाना ही ग़लती थी।',
  'Shloka us khaane mein koi behtar abhyas nahi maangta. Woh kehta hai ki khaana hi galti thi.',
  NULL, 'intermediate', 'self-talk,rumination,stopping,honesty'

  UNION ALL SELECT 20, 'ethics', 1,
  'The reference nobody will trace', 'वह सिफ़ारिश जिसका कोई पता नहीं लगाएगा', 'Woh sifarish jiska koi pata nahi lagayega',
  'Somebody writes a careful recommendation for a person who is leaving the industry entirely and will never be in a position to do anything for them. It takes forty minutes and it is the best one they have written that year.',
  'कोई एक ऐसे इंसान के लिए ध्यान से सिफ़ारिश लिखता है जो यह पूरा क्षेत्र छोड़कर जा रहा है और कभी इस हालत में नहीं होगा कि उसके लिए कुछ कर सके। इसमें चालीस मिनट लगते हैं और यह उस साल की उसकी सबसे अच्छी सिफ़ारिश है।',
  'Koi ek aise insan ke liye dhyan se sifarish likhta hai jo yeh poora kshetra chhodkar ja raha hai aur kabhi is haalat mein nahi hoga ki uske liye kuch kar sake. Isme chalees minute lagte hain aur yeh us saal ki uski sabse achhi sifarish hai.',
  'Anupakāriṇe — to somebody who cannot return it — is the condition doing the work, and this is a clean instance of it. The forty minutes is what makes it interesting: it is not that he gave nothing away, it is that he gave the good version to the one person who could not pay him back for it.',
  'अनुपकारिणे — ऐसे को जो लौटा नहीं सकता — वही शर्त है जो काम करती है, और यह उसका साफ़ नमूना है। दिलचस्प बात चालीस मिनट हैं: बात यह नहीं कि उसने कुछ मुफ़्त दे दिया, बात यह है कि उसने अच्छा वाला रूप उसी एक इंसान को दिया जो उसका बदला नहीं चुका सकता था।',
  'Anupakarine — aise ko jo lauta nahi sakta — wahi shart hai jo kaam karti hai, aur yeh uska saaf namoona hai. Dilchasp baat chalees minute hain: baat yeh nahi ki usne kuch muft de diya, baat yeh hai ki usne achha wala roop usi ek insan ko diya jo uska badla nahi chuka sakta tha.',
  'He gave the good version to the one person who could never pay him back for it.',
  'उसने अच्छा वाला रूप उसी एक इंसान को दिया जो कभी उसका बदला नहीं चुका सकता था।',
  'Usne achha wala roop usi ek insan ko diya jo kabhi uska badla nahi chuka sakta tha.',
  NULL, 'intermediate', 'giving,references,ledger,quiet'

  UNION ALL SELECT 20, 'everyday_life', 2,
  'The right week, not the right amount', 'सही हफ़्ता, सही रक़म नहीं', 'Sahi hafta, sahi rakam nahi',
  'A neighbour is having a hard month. One person offers money and is refused. Another turns up on the Thursday with a cooked meal and takes the bins out on the way in. The second one is accepted without any discussion at all.',
  'एक पड़ोसी का महीना मुश्किल जा रहा है। एक इंसान पैसे देने की पेशकश करता है और मना कर दिया जाता है। दूसरा गुरुवार को पका हुआ खाना लेकर पहुँचता है और अंदर आते हुए कूड़ा भी बाहर रख देता है। दूसरे को बिना किसी बहस के स्वीकार कर लिया जाता है।',
  'Ek padosi ka mahina mushkil ja raha hai. Ek insan paise dene ki peshkash karta hai aur mana kar diya jaata hai. Doosra Thursday ko paka hua khana lekar pahunchta hai aur andar aate hue kooda bhi bahar rakh deta hai. Doosre ko bina kisi behes ke sweekar kar liya jaata hai.',
  'The verse names four conditions and two of them are deśe and kāle — place and time. This is what those two are for. Nothing was wrong with the money and the person offering it was not being worse. It arrived somewhere it could not land.',
  'श्लोक चार शर्तें गिनाता है और उनमें दो हैं देशे और काले — जगह और वक़्त। ये दोनों इसी काम की हैं। पैसों में कुछ ग़लत नहीं था और देने वाला बुरा नहीं था। वह ऐसी जगह पहुँचा जहाँ वह टिक नहीं सकता था।',
  'Shloka chaar shartein ginata hai aur unme do hain deshe aur kaale — jagah aur waqt. Yeh dono isi kaam ki hain. Paison mein kuch galat nahi tha aur dene wala bura nahi tha. Woh aisi jagah pahuncha jahan woh tik nahi sakta tha.',
  'Nothing was wrong with the offer. It arrived somewhere it could not land.',
  'पेशकश में कुछ ग़लत नहीं था। वह ऐसी जगह पहुँची जहाँ टिक नहीं सकती थी।',
  'Peshkash mein kuch galat nahi tha. Woh aisi jagah pahunchi jahan tik nahi sakti thi.',
  NULL, 'beginner', 'neighbours,help,timing,form'

  UNION ALL SELECT 20, 'finance', 3,
  'The standing order he forgot about', 'वह स्थायी भुगतान जो वह भूल गया', 'Woh sthayi bhugtaan jo woh bhool gaya',
  'Somebody sets up a small monthly payment to a cause and then forgets it exists for six years. He finds it during a bank review and his first feeling is mild embarrassment that he was not thinking about it.',
  'कोई किसी काम के लिए एक छोटा मासिक भुगतान लगा देता है और फिर छह साल तक भूल जाता है कि वह मौजूद है। बैंक की जाँच में वह उसे पाता है और उसका पहला भाव हल्की शर्मिंदगी है कि वह उसके बारे में सोच ही नहीं रहा था।',
  'Koi kisi kaam ke liye ek chhota masik bhugtaan laga deta hai aur phir chhah saal tak bhool jaata hai ki woh maujood hai. Bank ki jaanch mein woh use paata hai aur uska pehla bhaav halki sharmindagi hai ki woh uske baare mein soch hi nahi raha tha.',
  'The embarrassment is the interesting part and it is misplaced. Nothing in the verse requires the giver to be present, warm or aware. It requires the recipient to be unable to return it — and forgetting for six years is one of the more reliable ways of ensuring the ledger stays shut.',
  'दिलचस्प हिस्सा वही शर्मिंदगी है और वह बेजा है। श्लोक में कुछ भी देने वाले से मौजूद, भावुक या सचेत होने की माँग नहीं करता। वह यह माँगता है कि पाने वाला लौटा न सके — और छह साल भूल जाना बहीखाता बंद रखने के ज़्यादा भरोसेमंद तरीक़ों में से एक है।',
  'Dilchasp hissa wahi sharmindagi hai aur woh beja hai. Shloka mein kuch bhi dene wale se maujood, bhavuk ya sachet hone ki maang nahi karta. Woh yeh maangta hai ki paane wala lauta na sake — aur chhah saal bhool jaana bahikhata band rakhne ke zyada bharosemand tareekon mein se ek hai.',
  'The verse does not require the giver to be present. It requires the ledger to stay shut.',
  'श्लोक देने वाले से मौजूद रहने की माँग नहीं करता। वह माँगता है कि बहीखाता बंद रहे।',
  'Shloka dene wale se maujood rehne ki maang nahi karta. Woh maangta hai ki bahikhata band rahe.',
  NULL, 'beginner', 'giving,money,forgetting,ledger'

  UNION ALL SELECT 20, 'friendship', 4,
  'The favour that was never mentioned again', 'वह एहसान जिसका दोबारा ज़िक्र नहीं हुआ', 'Woh ehsaan jiska dobara zikr nahi hua',
  'A friend does something considerable for somebody at a bad time. Eight years later it has never been mentioned by either of them, in any context, including the several occasions when mentioning it would have won an argument.',
  'एक दोस्त बुरे वक़्त में किसी के लिए बड़ा काम कर देता है। आठ साल बाद भी दोनों में से किसी ने उसका कहीं ज़िक्र नहीं किया, उन कई मौक़ों पर भी नहीं जब उसका ज़िक्र कोई बहस जिता देता।',
  'Ek dost bure waqt mein kisi ke liye bada kaam kar deta hai. Aath saal baad bhi dono mein se kisi ne uska kahin zikr nahi kiya, un kai maukon par bhi nahi jab uska zikr koi behes jita deta.',
  'Anupakāriṇe is usually read as a fact about the recipient. This is the other half of it: a gift given to somebody who could repay it, and then never entered into the ledger by the giver either. The several arguments not won are the evidence, and they are the only evidence there is.',
  'अनुपकारिणे को आमतौर पर पाने वाले के बारे में तथ्य की तरह पढ़ा जाता है। यह उसका दूसरा आधा है: ऐसे किसी को दिया गया जो लौटा सकता था, और फिर देने वाले ने भी उसे बहीखाते में कभी नहीं चढ़ाया। वे कई न जीती गई बहसें ही सबूत हैं, और सबूत बस वही हैं।',
  'Anupakarine ko aam taur par paane wale ke baare mein tathya ki tarah padha jaata hai. Yeh uska doosra aadha hai: aise kisi ko diya gaya jo lauta sakta tha, aur phir dene wale ne bhi use bahikhate mein kabhi nahi chadhaya. Woh kai na jeeti gayi behesein hi saboot hain, aur saboot bas wahi hain.',
  'The arguments he did not win with it are the only evidence there is.',
  'जो बहसें उसने इससे नहीं जीतीं, सबूत बस वही हैं।',
  'Jo behesein usne isse nahi jeeteen, saboot bas wahi hain.',
  NULL, 'intermediate', 'friendship,giving,restraint,ledger'

  UNION ALL SELECT 28, 'marriage', 1,
  'The anniversary that was handled', 'वह सालगिरह जो निपटा दी गई', 'Woh saalgirah jo nipta di gayi',
  'Somebody books the right restaurant, buys the right thing and says the right words on an anniversary, and both of them come home knowing it did not happen. Nothing went wrong and nobody can point to a mistake.',
  'कोई सालगिरह पर सही रेस्तराँ बुक करता है, सही चीज़ ख़रीदता है और सही शब्द कहता है, और दोनों घर लौटते हैं यह जानते हुए कि वह हुआ ही नहीं। कुछ ग़लत नहीं हुआ और कोई किसी ग़लती की तरफ़ इशारा नहीं कर सकता।',
  'Koi saalgirah par sahi restaurant book karta hai, sahi cheez khareedta hai aur sahi shabd kehta hai, aur dono ghar lautte hain yeh jaante hue ki woh hua hi nahi. Kuch galat nahi hua aur koi kisi galti ki taraf ishara nahi kar sakta.',
  'Asat is not the word for done badly. Everything here was done correctly. It is the word for done with nothing resting on it, and the reason the evening did not work is not findable in any of the individual decisions, which were all right.',
  'असत् का मतलब बुरी तरह किया गया नहीं है। यहाँ सब कुछ ठीक-ठीक किया गया। यह उस चीज़ का शब्द है जिस पर कुछ टिका हुआ न हो, और वह शाम क्यों नहीं चली, इसकी वजह किसी भी अलग फ़ैसले में नहीं मिलेगी, क्योंकि वे सब सही थे।',
  'Asat ka matlab buri tarah kiya gaya nahi hai. Yahan sab kuch theek theek kiya gaya. Yeh us cheez ka shabd hai jis par kuch tika hua na ho, aur woh shaam kyun nahi chali, iski wajah kisi bhi alag faisle mein nahi milegi, kyunki woh sab sahi the.',
  'Every decision was right. The word for what was missing is asat.',
  'हर फ़ैसला सही था। जो नहीं था उसका शब्द है असत्।',
  'Har faisla sahi tha. Jo nahi tha uska shabd hai asat.',
  NULL, 'intermediate', 'marriage,ritual,meaning,correctness'

  UNION ALL SELECT 28, 'corporate', 2,
  'The values workshop', 'मूल्यों वाली वर्कशॉप', 'Mulyon wali workshop',
  'A company runs a well-designed two-day session on its principles. The facilitator is good, the exercises are sound and the output document is genuinely thoughtful. Nobody refers to it again, and nobody was pretending during it either.',
  'एक कंपनी अपने सिद्धांतों पर दो दिन का अच्छा तैयार किया गया सत्र चलाती है। सूत्रधार अच्छा है, अभ्यास ठोस हैं और निकला दस्तावेज़ सचमुच सोचा-समझा है। उसका फिर कभी ज़िक्र नहीं होता, और उस दौरान कोई दिखावा भी नहीं कर रहा था।',
  'Ek company apne siddhanton par do din ka achha taiyar kiya gaya satra chalati hai. Sutradhar achha hai, abhyas thos hain aur nikla dastavez sach mein socha-samjha hai. Uska phir kabhi zikr nahi hota, aur us dauran koi dikhava bhi nahi kar raha tha.',
  'The verse would not call the workshop bad and neither would anybody who was there. It would call it asat, which is a different charge: nothing was resting on it. That is why a well-run session and a badly-run one can end up in exactly the same place.',
  'श्लोक वर्कशॉप को बुरा नहीं कहेगा और वहाँ मौजूद कोई भी नहीं कहेगा। वह उसे असत् कहेगा, और यह अलग इलज़ाम है: उस पर कुछ टिका हुआ नहीं था। इसीलिए अच्छी चलाई गई और बुरी चलाई गई, दोनों बैठकें ठीक एक ही जगह पहुँच जाती हैं।',
  'Shloka workshop ko bura nahi kahega aur wahan maujood koi bhi nahi kahega. Woh use asat kahega, aur yeh alag ilzaam hai: us par kuch tika hua nahi tha. Isiliye achhi chalayi gayi aur buri chalayi gayi, dono baithakein theek ek hi jagah pahunch jaati hain.',
  'A well-run session with nothing resting on it lands in the same place as a badly-run one.',
  'अच्छी चलाई गई बैठक जिस पर कुछ टिका न हो, वहीं पहुँचती है जहाँ बुरी चलाई गई।',
  'Achhi chalayi gayi baithak jis par kuch tika na ho, wahin pahunchti hai jahan buri chalayi gayi.',
  NULL, 'intermediate', 'work,workshops,meaning,follow-through'

  UNION ALL SELECT 28, 'everyday_life', 3,
  'The apology that ended the conversation', 'वह माफ़ी जिसने बातचीत ख़त्म कर दी', 'Woh maafi jisne baatcheet khatam kar di',
  'Somebody apologises properly — names the thing, does not add a because, does not ask for anything back. It is a textbook apology. It is also offered mainly so that the conversation will stop, and the other person knows this within about four seconds.',
  'कोई ठीक से माफ़ी माँगता है — चीज़ का नाम लेता है, कोई "क्योंकि" नहीं जोड़ता, बदले में कुछ नहीं माँगता। यह किताबी माफ़ी है। और यह मुख्य रूप से इसलिए दी गई है कि बातचीत रुक जाए, और सामने वाले को यह क़रीब चार सेकंड में पता चल जाता है।',
  'Koi theek se maafi maangta hai — cheez ka naam leta hai, koi "kyunki" nahi jodta, badle mein kuch nahi maangta. Yeh kitabi maafi hai. Aur yeh mukhya roop se isliye di gayi hai ki baatcheet ruk jaaye, aur saamne wale ko yeh kareeb chaar second mein pata chal jaata hai.',
  'The form was perfect and the other person still knew. That is the chapter''s whole claim in four seconds: what somebody is resting on is legible, and it does not become illegible by being well-formed. Asat is the word for the gap.',
  'रूप बिलकुल सही था और सामने वाले को फिर भी पता चल गया। यही अध्याय का पूरा दावा है, चार सेकंड में: कोई किस पर टिका है वह पढ़ा जा सकता है, और ठीक ढंग से किए जाने से वह अपठनीय नहीं हो जाता। असत् उसी फ़ासले का शब्द है।',
  'Roop bilkul sahi tha aur saamne wale ko phir bhi pata chal gaya. Yahi adhyay ka poora dawa hai, chaar second mein: koi kis par tika hai woh padha ja sakta hai, aur theek dhang se kiye jaane se woh apathniya nahi ho jaata. Asat usi faasle ka shabd hai.',
  'The form was perfect. She knew within four seconds anyway.',
  'रूप बिलकुल सही था। उसे फिर भी चार सेकंड में पता चल गया।',
  'Roop bilkul sahi tha. Use phir bhi chaar second mein pata chal gaya.',
  NULL, 'beginner', 'apology,form,intent,legibility'

  UNION ALL SELECT 28, 'parenting', 4,
  'Reading the same page for the fourth time', 'वही पन्ना चौथी बार पढ़ना', 'Wahi panna chauthi baar padhna',
  'A parent reads a bedtime story while thinking about work, and gets to the end without remembering any of it. The next night the same book, six minutes, fully there. The child asks for the second one to happen again and cannot explain what was different.',
  'एक अभिभावक काम के बारे में सोचते हुए सोने से पहले की कहानी पढ़ता है, और आख़िर तक पहुँचकर उसे कुछ याद नहीं रहता। अगली रात वही किताब, छह मिनट, पूरी तरह मौजूद। बच्चा कहता है कि दूसरा वाला फिर हो, और यह नहीं बता पाता कि फ़र्क़ क्या था।',
  'Ek abhibhavak kaam ke baare mein sochte hue sone se pehle ki kahani padhta hai, aur aakhir tak pahunchkar use kuch yaad nahi rehta. Agli raat wahi kitaab, chhah minute, poori tarah maujood. Bachcha kehta hai ki doosra wala phir ho, aur yeh nahi bata paata ki farq kya tha.',
  'The same words, the same book, the same six minutes. One of the two counts and one does not, and a four-year-old can tell which is which without having a word for it. That is the chapter''s claim, tested by somebody with no theory at all.',
  'वही शब्द, वही किताब, वही छह मिनट। दोनों में से एक गिना जाता है और एक नहीं, और चार साल का बच्चा बिना कोई शब्द जाने बता सकता है कि कौन-सा कौन है। यही अध्याय का दावा है, और इसे किसी ऐसे ने जाँचा जिसके पास कोई सिद्धांत ही नहीं है।',
  'Wahi shabd, wahi kitaab, wahi chhah minute. Dono mein se ek gina jaata hai aur ek nahi, aur chaar saal ka bachcha bina koi shabd jaane bata sakta hai ki kaun sa kaun hai. Yahi adhyay ka dawa hai, aur ise kisi aise ne jaancha jiske paas koi siddhant hi nahi hai.',
  'A four-year-old could tell the difference without having a word for it.',
  'चार साल का बच्चा बिना कोई शब्द जाने फ़र्क़ बता सकता था।',
  'Chaar saal ka bachcha bina koi shabd jaane farq bata sakta tha.',
  NULL, 'beginner', 'parenting,presence,reading,attention'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 17;

-- =====================================================================
-- 5. CROSS REFERENCES
-- =====================================================================
-- TWELVE DECLARED. Every target checked against the seeded verse list
-- first. Count the loaded rows against twelve before shipping.
--
-- The 17.7 -> 6.17 pair and the 17.19 -> 6.17 pair are load-bearing:
-- together they are the corpus's two wellbeing verses about practice
-- pointing at each other, and a reader who lands on either should be
-- offered the other.
-- =====================================================================

DELETE x FROM verse_cross_references x JOIN verses v ON v.id = x.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 17;

INSERT INTO verse_cross_references
  (verse_id, reference_type, book, chapter, verse, target_verse_id,
   description_en, description_hi, description_hinglish, relationship, sort_order)
SELECT v.id, 'gita', 'Bhagavad Gita', CAST(x.tch AS CHAR), CAST(x.tvn AS CHAR), tv.id,
       x.d_en, x.d_hi, x.d_hing, x.rel, x.ord
FROM (
  SELECT 2 AS vn, 5 AS tch, 18 AS tvn, 1 AS ord,
    'Read together, these settle what svabhāva-ja cannot mean. 5.18 refuses to rank five very different beings; a birth-based reading of "born of one''s own nature" would have to argue with it.' AS d_en,
    'साथ पढ़िए तो ये तय कर देते हैं कि स्वभावज का मतलब क्या नहीं हो सकता। 5.18 पाँच बहुत अलग प्राणियों में क्रम लगाने से इनकार करता है; "अपने स्वभाव से उपजी" का जन्म-आधारित पाठ उससे बहस करने पर मजबूर होगा।' AS d_hi,
    'Saath padho to yeh tay kar dete hain ki svabhav-ja ka matlab kya nahi ho sakta. 5.18 paanch bahut alag praniyon mein kram lagane se inkaar karta hai; "apne swabhav se upji" ka janm-aadharit paath usse behes karne par majboor hoga.' AS d_hing,
    'supports' AS rel
  UNION ALL SELECT 3, 16, 4, 1,
    'Both chapters sort. This one sorts by what a person does; chapter 16 is the one most often misread as sorting people themselves, and 16.4''s own explanation refuses that.',
    'दोनों अध्याय छाँटते हैं। यह इस आधार पर छाँटता है कि इंसान करता क्या है; सोलहवाँ वही है जिसे सबसे ज़्यादा ख़ुद लोगों को छाँटने के तौर पर ग़लत पढ़ा जाता है, और 16.4 की अपनी व्याख्या इससे इनकार करती है।',
    'Dono adhyay chhaante hain. Yeh is aadhar par chhaanta hai ki insan karta kya hai; solahvan wahi hai jise sabse zyada khud logon ko chhaantne ke taur par galat padha jaata hai, aur 16.4 ki apni vyakhya isse inkaar karti hai.',
    'supports'
  UNION ALL SELECT 3, 3, 21, 1,
    'What a person of standing does, everybody else does. 3.21 is about behaviour being read; 17.3 says the reading works and tells you what it reveals.',
    'बड़ा आदमी जो करता है, बाक़ी सब वही करते हैं। 3.21 इस बारे में है कि बरताव पढ़ा जाता है; 17.3 कहता है कि वह पढ़ना चलता है और बताता है कि उससे क्या खुलता है।',
    'Bada aadmi jo karta hai, baaki sab wahi karte hain. 3.21 is baare mein hai ki bartav padha jaata hai; 17.3 kehta hai ki woh padhna chalta hai aur batata hai ki usse kya khulta hai.',
    'supports'
  UNION ALL SELECT 7, 6, 17, 1,
    'The corpus''s other food verse, and the pair to read this one with. 6.17 asks for measure and rules out too little as firmly as too much; neither verse names an amount, and both of them sort by fit rather than by quantity.',
    'संग्रह का दूसरा खाने वाला श्लोक, और इसे इसी के साथ पढ़ना चाहिए। 6.17 नाप माँगता है और "बहुत कम" को उतनी ही मज़बूती से ख़ारिज करता है जितना "बहुत ज़्यादा"; कोई भी श्लोक मात्रा नहीं बताता, और दोनों मात्रा से नहीं, ठीक बैठने से छाँटते हैं।',
    'Sangrah ka doosra khane wala shloka, aur ise isi ke saath padhna chahiye. 6.17 naap maangta hai aur "bahut kam" ko utni hi mazbooti se khaarij karta hai jitna "bahut zyada"; koi bhi shloka maatra nahi batata, aur dono maatra se nahi, theek baithne se chhaante hain.',
    'same'
  UNION ALL SELECT 15, 12, 13, 1,
    'The portrait of somebody without hostility towards any being, and here the same thing narrowed to a single channel — what comes out of the mouth, held to four conditions at once.',
    'ऐसे इंसान का चित्र जिसे किसी प्राणी से बैर नहीं, और यहाँ वही चीज़ एक ही रास्ते तक सीमित — जो मुँह से निकलता है, एक साथ चार शर्तों पर कसा हुआ।',
    'Aise insan ka chitra jise kisi prani se bair nahi, aur yahan wahi cheez ek hi raste tak seemit — jo munh se nikalta hai, ek saath chaar shartein par kasa hua.',
    'supports'
  UNION ALL SELECT 15, 16, 21, 1,
    'Three gates that take a person apart. This verse is one of the few places the book describes a gate being kept rather than named, and it does it in speech.',
    'तीन दरवाज़े जो आदमी को तोड़ देते हैं। यह श्लोक उन गिनी-चुनी जगहों में है जहाँ किताब किसी दरवाज़े का नाम नहीं लेती, उसे सँभालते हुए दिखाती है — और वह बोली में करती है।',
    'Teen darwaze jo aadmi ko tod dete hain. Yeh shloka un gini-chuni jagahon mein hai jahan kitaab kisi darwaze ka naam nahi leti, use sambhalte hue dikhati hai — aur woh boli mein karti hai.',
    'supports'
  UNION ALL SELECT 16, 6, 19, 1,
    'The lamp in the windless place. Prasāda is what that picture is a picture of, and both verses locate steadiness in the absence of agitation rather than in the strength of the grip.',
    'बिना हवा की जगह पर रखा दीया। प्रसाद उसी तस्वीर की चीज़ है, और दोनों श्लोक ठहराव को पकड़ की ताक़त में नहीं, उथल-पुथल की ग़ैरहाज़िरी में रखते हैं।',
    'Bina hawa ki jagah par rakha diya. Prasad usi tasveer ki cheez hai, aur dono shloka thehrav ko pakad ki taakat mein nahi, uthal-puthal ki gairhazri mein rakhte hain.',
    'same'
  UNION ALL SELECT 16, 6, 26, 1,
    'Bring it back, each time it goes. 6.26 is the mechanics; 17.16 is the manner, and the manner is gentle rather than forceful.',
    'हर बार जब वह जाए, उसे वापस लाइए। 6.26 तरीक़ा है; 17.16 ढंग है, और ढंग ज़ोर वाला नहीं, नरम है।',
    'Har baar jab woh jaaye, use wapas laao. 6.26 tareeka hai; 17.16 dhang hai, aur dhang zor wala nahi, naram hai.',
    'supports'
  UNION ALL SELECT 19, 6, 17, 1,
    'The two wellbeing verses of the corpus, and they should be read as one. 6.17 rules out too little; 17.19 rules out hurting yourself. Between them there is no reading of either chapter that licenses a practice built on self-punishment.',
    'संग्रह के दो कल्याण वाले श्लोक, और इन्हें एक साथ पढ़ना चाहिए। 6.17 "बहुत कम" को ख़ारिज करता है; 17.19 ख़ुद को तकलीफ़ देने को। दोनों मिलकर किसी भी अध्याय का ऐसा कोई पाठ नहीं छोड़ते जो ख़ुद को सज़ा देने पर टिके अभ्यास की छूट दे।',
    'Sangrah ke do kalyan wale shloka, aur inhe ek saath padhna chahiye. 6.17 "bahut kam" ko khaarij karta hai; 17.19 khud ko takleef dene ko. Dono milkar kisi bhi adhyay ka aisa koi paath nahi chhodte jo khud ko saza dene par tike abhyas ki chhoot de.',
    'same'
  UNION ALL SELECT 19, 6, 5, 1,
    'A person can lift themselves and can let themselves sink. Read next to 17.19 it is clear that lifting is not the same as being hard on yourself, and the chapter that says one says the other.',
    'इंसान ख़ुद को उठा सकता है और ख़ुद को डूबने भी दे सकता है। 17.19 के बग़ल में पढ़िए तो साफ़ है कि उठाना अपने ऊपर सख़्ती करना नहीं है, और जो अध्याय एक कहता है वही दूसरा भी कहता है।',
    'Insan khud ko utha sakta hai aur khud ko doobne bhi de sakta hai. 17.19 ke bagal mein padho to saaf hai ki uthana apne upar sakhti karna nahi hai, aur jo adhyay ek kehta hai wahi doosra bhi kehta hai.',
    'supports'
  UNION ALL SELECT 20, 3, 19, 1,
    'Do the work with the holding-on let go of. Giving to somebody who cannot return it is the same instruction applied to a single act, and anupakāriṇe is the mechanism that makes it checkable.',
    'पकड़ छोड़कर काम कीजिए। ऐसे किसी को देना जो लौटा नहीं सकता, वही हिदायत है एक ही काम पर लागू, और अनुपकारिणे वह तंत्र है जो इसे जाँचने लायक़ बनाता है।',
    'Pakad chhodkar kaam karo. Aise kisi ko dena jo lauta nahi sakta, wahi hidayat hai ek hi kaam par laagu, aur anupakarine woh tantra hai jo ise jaanchne layak banata hai.',
    'same'
  UNION ALL SELECT 28, 2, 47, 1,
    'Your claim is on the doing. 17.28 adds the condition that makes the doing count at all: something has to be resting on it, or the act is correct and empty.',
    'आपका दावा करने पर है। 17.28 वह शर्त जोड़ता है जो करने को गिनती में लाती है: उस पर कुछ टिका होना चाहिए, वरना कर्म सही रहेगा और ख़ाली।',
    'Tumhara dawa karne par hai. 17.28 woh shart jodta hai jo karne ko ginti mein laati hai: us par kuch tika hona chahiye, warna karm sahi rahega aur khaali.',
    'supports'
) AS x
JOIN verses v  ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 17
JOIN chapters tc ON tc.chapter_number = x.tch
JOIN verses tv ON tv.verse_number = x.tvn AND tv.chapter_id = tc.id;

-- =====================================================================
-- 6. WORD BY WORD
-- =====================================================================
-- Three glosses carry the chapter's safeguards:
--   svabhāva-jā (17.2)  says explicitly that it is not about birth
--   āhāra (17.7)        says the sort is by effect and never by amount
--   pīḍayā (17.19)      says the wrongness is in the hurting, not in
--                       the amount, and that the category is the point
-- All glosses stay under 400 characters — the column is varchar(400).
-- =====================================================================

DELETE w FROM verse_word_meanings w JOIN verses v ON v.id = w.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 17;

INSERT INTO verse_word_meanings
  (verse_id, word_order, devanagari, transliteration,
   meaning_en, meaning_hi, meaning_hinglish, grammar, root_word)
SELECT v.id, w.ord, w.dev, w.tr, w.m_en, w.m_hi, w.m_hing, w.gram, w.root FROM (

  SELECT 2 AS vn, 1 AS ord, 'त्रिविधा' AS dev, 'tri-vidhā' AS tr, 'of three kinds' AS m_en, 'तीन तरह की' AS m_hi, 'teen tarah ki' AS m_hing, 'nominative singular' AS gram, 'विध्' AS root
  UNION ALL SELECT 2, 2, 'श्रद्धा', 'śraddhā', 'what you put your weight on — closer to trust than to belief. Śrat is heart, dhā is to place: literally, where the heart is set down', 'श्रद्धा — जिस पर आप अपना भार डालते हैं; "मान्यता" से ज़्यादा "भरोसा" के पास। श्रत् यानी हृदय, धा यानी रखना: शब्दशः, जहाँ हृदय रखा जाता है', 'shraddha — jis par tum apna bhaar daalte ho; "manyata" se zyada "bharosa" ke paas. Shrat yani hriday, dha yani rakhna: shabdashah, jahan hriday rakha jaata hai', 'nominative singular', 'श्रत् + धा'
  UNION ALL SELECT 2, 3, 'देहिनाम्', 'dehinām', 'of embodied beings — of anybody who has a body, which is everybody', 'देहधारियों की — किसी भी ऐसे की जिसके पास शरीर है, यानी सबकी', 'dehdhariyon ki — kisi bhi aise ki jiske paas sharir hai, yani sabki', 'genitive plural', 'देह'
  UNION ALL SELECT 2, 4, 'स्वभावजा', 'svabhāva-jā', 'born of one''s own nature. NOT determined by birth, family, community or origin — that reading is the same move as reading 4.13 as hereditary, and the rest of the chapter makes it impossible, because every test it gives is behavioural', 'अपने स्वभाव से उपजी। जन्म, परिवार, समुदाय या मूल से तय नहीं — ऐसा पढ़ना वही चाल है जो 4.13 को वंशगत पढ़ना है, और बाक़ी अध्याय इसे नामुमकिन कर देता है, क्योंकि वह जो भी कसौटी देता है वह बरताव की है', 'apne swabhav se upji. Janm, parivar, samuday ya mool se tay nahi — aisa padhna wahi chaal hai jo 4.13 ko vanshagat padhna hai, aur baaki adhyay ise namumkin kar deta hai, kyunki woh jo bhi kasauti deta hai woh bartav ki hai', 'nominative singular', 'स्व + भू + जन्'
  UNION ALL SELECT 2, 5, 'सात्त्विकी राजसी तामसी', 'sāttvikī rājasī tāmasī', 'clear, restless, shut down — the three settings, named as qualities of the trust and not as types of person', 'साफ़, बेचैन, बुझी हुई — तीन अवस्थाएँ, भरोसे के गुणों के तौर पर नाम ली गईं, इंसानों की क़िस्मों के तौर पर नहीं', 'saaf, bechain, bujhi hui — teen avasthayein, bharose ke gunon ke taur par naam li gayin, insanon ki kismon ke taur par nahi', 'nominative singular', NULL

  UNION ALL SELECT 3, 1, 'सत्त्वानुरूपा', 'sattvānurūpā', 'according to the make-up — fitting what somebody is constituted of', 'सत्त्व के अनुरूप — उससे मेल खाती जिससे कोई बना है', 'sattva ke anuroop — usse mel khati jisse koi bana hai', 'nominative singular', 'रूप'
  UNION ALL SELECT 3, 2, 'श्रद्धामयः', 'śraddhā-mayaḥ', 'made of śraddhā — the -maya suffix means constituted of, the way a clay pot is mṛn-maya', 'श्रद्धा से बना — -मय प्रत्यय का मतलब है उससे बना हुआ, जैसे मिट्टी का घड़ा मृन्मय होता है', 'shraddha se bana — -may pratyay ka matlab hai usse bana hua, jaise mitti ka ghada mrinmay hota hai', 'nominative singular', 'मय'
  UNION ALL SELECT 3, 3, 'यः यत् श्रद्धः', 'yo yac-chraddhaḥ', 'whoever has whatever trust — the construction is deliberately open; it names no content', 'जिसका जो भरोसा हो — रचना जानबूझकर खुली है; वह किसी विषय का नाम नहीं लेती', 'jiska jo bharosa ho — rachna jaanboojhkar khuli hai; woh kisi vishay ka naam nahi leti', 'nominative singular', 'श्रद्धा'
  UNION ALL SELECT 3, 4, 'स एव सः', 'sa eva saḥ', 'that is exactly what they are — eva makes it flat and leaves no gap between the two', 'वही ठीक वही है — एव इसे सपाट कर देता है और दोनों के बीच कोई फ़ासला नहीं छोड़ता', 'wahi theek wahi hai — ev ise sapaat kar deta hai aur dono ke beech koi faasla nahi chhodta', 'nominative singular', NULL

  UNION ALL SELECT 7, 1, 'आहारः', 'āhāraḥ', 'food, what is taken in — literally what is brought towards. The verses after this sort it by WHAT IT DOES: whether it settles or agitates, whether it is fresh, whether it was made with care. Not one of them names an amount, a weight or a time', 'आहार, जो भीतर लिया जाए — शब्दशः जो पास लाया जाए। इसके बाद के श्लोक उसे इस आधार पर छाँटते हैं कि वह करता क्या है: ठहराता है या बेचैन करता है, ताज़ा है या नहीं, ध्यान से बना है या नहीं। उनमें से एक भी मात्रा, वज़न या समय नहीं बताता', 'aahar, jo bheetar liya jaaye — shabdashah jo paas laya jaaye. Iske baad ke shloka use is aadhar par chhaante hain ki woh karta kya hai: thehrata hai ya bechain karta hai, taaza hai ya nahi, dhyan se bana hai ya nahi. Unme se ek bhi maatra, wazan ya samay nahi batata', 'nominative singular', 'आ + हृ'
  UNION ALL SELECT 7, 2, 'प्रियः', 'priyaḥ', 'dear, preferred — the verse is about what somebody LIKES, which is evidence, rather than about what they should have', 'प्रिय, पसंदीदा — श्लोक इस बारे में है कि किसी को क्या अच्छा लगता है, जो सबूत है; इस बारे में नहीं कि उसे क्या लेना चाहिए', 'priya, pasandida — shloka is baare mein hai ki kisi ko kya achha lagta hai, jo saboot hai; is baare mein nahi ki use kya lena chahiye', 'nominative singular', 'प्री'
  UNION ALL SELECT 7, 3, 'यज्ञः तपः दानम्', 'yajñaḥ tapaḥ dānam', 'offering, practice, giving — food is put alongside these three, which is a hint about what is being sorted', 'यज्ञ, तप, दान — खाने को इन तीनों के साथ रखा गया है, और यह इशारा है कि छाँटा क्या जा रहा है', 'yagya, tap, daan — khane ko in teenon ke saath rakha gaya hai, aur yeh ishara hai ki chhaanta kya ja raha hai', 'nominative singular', NULL

  UNION ALL SELECT 15, 1, 'अनुद्वेगकरम्', 'anudvega-karam', 'not producing agitation — udvega is being thrown up and out of yourself. Not a rule against difficult speech; a rule against speech shaped so it cannot be heard', 'उद्वेग न करने वाला — उद्वेग यानी अपने आप से उखड़ जाना। कठिन बात कहने के ख़िलाफ़ नियम नहीं; ऐसे ढंग की बात के ख़िलाफ़ नियम जिसे सुना ही न जा सके', 'udveg na karne wala — udveg yani apne aap se ukhad jaana. Kathin baat kehne ke khilaf niyam nahi; aise dhang ki baat ke khilaf niyam jise suna hi na ja sake', 'accusative singular', 'उद् + विज्'
  UNION ALL SELECT 15, 2, 'सत्यम्', 'satyam', 'true — one of the four conditions, not the only one', 'सत्य — चारों शर्तों में से एक, अकेली नहीं', 'satya — chaaron shartein mein se ek, akeli nahi', 'accusative singular', 'सत्'
  UNION ALL SELECT 15, 3, 'प्रियहितम्', 'priya-hitam', 'kind and beneficial — two more conditions in one compound, and hita is about use rather than pleasantness', 'प्रिय और हितकारी — एक ही समास में दो और शर्तें, और हित सुखद होने का नहीं, काम आने का शब्द है', 'priya aur hitkari — ek hi samas mein do aur shartein, aur hit sukhad hone ka nahi, kaam aane ka shabd hai', 'accusative singular', 'हि'
  UNION ALL SELECT 15, 4, 'स्वाध्यायाभ्यसनम्', 'svādhyāyābhyasanam', 'the regular practice of reading yourself back — sva-adhyāya is literally own-study', 'ख़ुद को दोबारा पढ़ने का नियमित अभ्यास — स्व-अध्याय शब्दशः अपना-अध्ययन है', 'khud ko dobara padhne ka niyamit abhyas — sva-adhyay shabdashah apna-adhyayan hai', 'accusative singular', 'अधि + इ'
  UNION ALL SELECT 15, 5, 'वाङ्मयम् तपः', 'vāṅ-mayaṁ tapaḥ', 'discipline made of speech — the same -maya as in 17.3', 'वाणी से बना तप — वही -मय जो 17.3 में है', 'vaani se bana tap — wahi -may jo 17.3 mein hai', 'nominative singular', 'वाच्'

  UNION ALL SELECT 16, 1, 'मनःप्रसादः', 'manaḥ-prasādaḥ', 'clearness of mind — prasāda is settled, unforced, the same word as for something given and received rather than seized. It is FIRST on the list, ahead of any holding', 'मन का प्रसाद — प्रसाद यानी ठहरा हुआ, बिना ज़ोर के; वही शब्द जो दी और ली गई चीज़ के लिए है, छीनी हुई के लिए नहीं। यह सूची में पहले है, किसी भी पकड़ से आगे', 'man ka prasad — prasad yani thehra hua, bina zor ke; wahi shabd jo di aur li gayi cheez ke liye hai, chheeni hui ke liye nahi. Yeh soochi mein pehle hai, kisi bhi pakad se aage', 'nominative singular', 'प्र + सद्'
  UNION ALL SELECT 16, 2, 'सौम्यत्वम्', 'saumyatvam', 'gentleness — on this list. Severity is not on this list anywhere', 'सौम्यता, नरमी — इस सूची में है। कठोरता इस सूची में कहीं नहीं है', 'saumyata, narmi — is soochi mein hai. Kathorta is soochi mein kahin nahi hai', 'nominative singular', 'सोम'
  UNION ALL SELECT 16, 3, 'मौनम्', 'maunam', 'quiet — sitting between gentleness and self-restraint, and the company defines it. Not silence used as a weapon', 'मौन — नरमी और आत्म-संयम के बीच बैठा, और संगत ही उसे परिभाषित करती है। हथियार की तरह इस्तेमाल की गई चुप्पी नहीं', 'maun — narmi aur aatm-sanyam ke beech baitha, aur sangat hi use paribhashit karti hai. Hathiyar ki tarah istemaal ki gayi chuppi nahi', 'nominative singular', 'मुनि'
  UNION ALL SELECT 16, 4, 'आत्मविनिग्रहः', 'ātma-vinigrahaḥ', 'some hold on yourself — FOURTH on the list, behind settling and gentleness, and the order is the argument', 'अपने ऊपर कुछ पकड़ — सूची में चौथे नंबर पर, ठहराव और नरमी के पीछे, और क्रम ही दलील है', 'apne upar kuch pakad — soochi mein chauthe number par, thehrav aur narmi ke peechhe, aur kram hi dalil hai', 'nominative singular', 'नि + ग्रह्'
  UNION ALL SELECT 16, 5, 'भावसंशुद्धिः', 'bhāva-saṁśuddhiḥ', 'clearness of intent — meaning what you appear to mean', 'भाव की संशुद्धि — वही मतलब रखना जो दिखता है', 'bhaav ki samshuddhi — wahi matlab rakhna jo dikhta hai', 'nominative singular', 'शुध्'

  UNION ALL SELECT 19, 1, 'मूढग्राहेण', 'mūḍha-grāheṇa', 'by a stubbornly held wrong idea — grāha is a grip, mūḍha is deluded. Something gripped rather than something believed', 'ज़िद से पकड़े हुए ग़लत ख़याल से — ग्राह यानी पकड़, मूढ़ यानी भ्रमित। कोई मानी हुई चीज़ नहीं, पकड़ी हुई चीज़', 'zid se pakde hue galat khayal se — grah yani pakad, mudh yani bhramit. Koi maani hui cheez nahi, pakdi hui cheez', 'instrumental singular', 'ग्रह्'
  UNION ALL SELECT 19, 2, 'आत्मनः पीडया', 'ātmanaḥ pīḍayā', 'by hurting oneself. The wrongness the verse names is in the pīḍā — the hurting — and NOT in the amount. This is why a gentler version of the same practice is not what the verse is asking for; it puts the whole category at the bottom', 'ख़ुद को पीड़ा देकर। श्लोक जिस ग़लती का नाम लेता है वह पीड़ा में है — तकलीफ़ में — मात्रा में नहीं। इसीलिए उसी अभ्यास का नरम रूप वह नहीं है जो श्लोक माँगता है; वह पूरी श्रेणी को सबसे नीचे रख देता है', 'khud ko peeda dekar. Shloka jis galti ka naam leta hai woh peeda mein hai — takleef mein — maatra mein nahi. Isiliye usi abhyas ka naram roop woh nahi hai jo shloka maangta hai; woh poori shreni ko sabse neeche rakh deta hai', 'genitive + instrumental', 'पीड्'
  UNION ALL SELECT 19, 3, 'तपः', 'tapaḥ', 'practice, discipline — literally heat. The chapter has already broken it into body, speech and mind, all of them ordinary', 'तप, अभ्यास — शब्दशः ताप। अध्याय इसे पहले ही शरीर, वाणी और मन में बाँट चुका है, और तीनों आम हैं', 'tap, abhyas — shabdashah taap. Adhyay ise pehle hi sharir, vaani aur man mein baant chuka hai, aur teenon aam hain', 'nominative singular', 'तप्'
  UNION ALL SELECT 19, 4, 'परस्य उत्सादनार्थम्', 'parasyotsādanārtham', 'for the purpose of destroying another — the third thing in the bottom category, listed beside self-harm', 'दूसरे को उजाड़ने के मक़सद से — सबसे नीचे वाली श्रेणी की तीसरी चीज़, ख़ुद को नुक़सान पहुँचाने के बग़ल में गिनाई गई', 'doosre ko ujaadne ke maksad se — sabse neeche wali shreni ki teesri cheez, khud ko nuksaan pahunchane ke bagal mein ginayi gayi', 'genitive + accusative', 'उद् + सद्'
  UNION ALL SELECT 19, 5, 'तामसम् उदाहृतम्', 'tāmasam udāhṛtam', 'is declared tamasic — udāhṛta is "given as an example of", so this is a category assignment rather than a warning', 'तामस कहा गया है — उदाहृत यानी "का उदाहरण बताया गया", यानी यह चेतावनी नहीं, श्रेणी में रख देना है', 'tamas kaha gaya hai — udahrit yani "ka udaharan bataya gaya", yani yeh chetavni nahi, shreni mein rakh dena hai', 'nominative singular', 'उद् + आ + हृ'

  UNION ALL SELECT 20, 1, 'दातव्यम् इति', 'dātavyam iti', 'thinking "it is to be given" — the reason, and it contains no reference to the giver', '"देना चाहिए" — यही वजह है, और इसमें देने वाले का कोई ज़िक्र नहीं है', '"dena chahiye" — yahi wajah hai, aur isme dene wale ka koi zikr nahi hai', 'gerundive', 'दा'
  UNION ALL SELECT 20, 2, 'अनुपकारिणे', 'anupakāriṇe', 'to one who cannot do a favour in return — upakāra is the return favour and the a- removes the possibility. This one word does most of the verse''s work: the test is whether the ledger CAN be opened, not whether you intend to open it', 'ऐसे को जो बदले में उपकार नहीं कर सकता — उपकार बदले का एहसान है और अ- उसकी संभावना ही हटा देता है। श्लोक का ज़्यादातर काम यही एक शब्द करता है: कसौटी यह है कि बहीखाता खोला जा सकता है या नहीं, यह नहीं कि आप खोलना चाहते हैं या नहीं', 'aise ko jo badle mein upkaar nahi kar sakta — upkaar badle ka ehsaan hai aur a- uski sambhavna hi hata deta hai. Shloka ka zyadatar kaam yahi ek shabd karta hai: kasauti yeh hai ki bahikhata khola ja sakta hai ya nahi, yeh nahi ki tum kholna chahte ho ya nahi', 'dative singular', 'उप + कृ'
  UNION ALL SELECT 20, 3, 'देशे काले च पात्रे च', 'deśe kāle ca pātre ca', 'in the place, at the time, and to the fit recipient — three more conditions, all of them about landing rather than about intention', 'जगह में, समय में, और पात्र में — तीन और शर्तें, और तीनों इरादे के बारे में नहीं, पहुँचने के बारे में हैं', 'jagah mein, samay mein, aur paatra mein — teen aur shartein, aur teenon iraade ke baare mein nahi, pahunchne ke baare mein hain', 'locative singular', NULL

  UNION ALL SELECT 28, 1, 'अश्रद्धया', 'aśraddhayā', 'without śraddhā — without anything resting on it. Not without skill and not without correctness', 'श्रद्धा के बिना — बिना इसके कि उस पर कुछ टिका हो। हुनर के बिना नहीं, और सही होने के बिना भी नहीं', 'shraddha ke bina — bina iske ki us par kuch tika ho. Hunar ke bina nahi, aur sahi hone ke bina bhi nahi', 'instrumental singular', 'श्रत् + धा'
  UNION ALL SELECT 28, 2, 'हुतम् दत्तम् तप्तम् कृतम्', 'hutaṁ dattaṁ taptaṁ kṛtam', 'offered, given, practised, done — four past participles. Note that all four are ACTS. The verse is about things done, not about the person doing them', 'चढ़ाया, दिया, साधा, किया — चार भूत कृदंत। ध्यान दीजिए कि चारों कर्म हैं। श्लोक की गई चीज़ों के बारे में है, करने वाले के बारे में नहीं', 'chadhaya, diya, saadha, kiya — chaar bhoot kridant. Dhyan do ki chaaron karm hain. Shloka ki gayi cheezon ke baare mein hai, karne wale ke baare mein nahi', 'past participles', NULL
  UNION ALL SELECT 28, 3, 'असत्', 'asat', 'not real, not counting — the negative of sat, which is what is. Applied here to the act and nowhere to the person', 'असत् — जो नहीं है, जो गिना नहीं जाता; सत् का निषेध, यानी जो है उसका। यहाँ यह कर्म पर लगाया गया है, इंसान पर कहीं नहीं', 'asat — jo nahi hai, jo gina nahi jaata; sat ka nishedh, yani jo hai uska. Yahan yeh karm par lagaya gaya hai, insan par kahin nahi', 'nominative singular', 'अस्'
  UNION ALL SELECT 28, 4, 'न च तत् प्रेत्य नो इह', 'na ca tat pretya no iha', 'not after and not here either — the second half is the useful one: the claim is about now, not only about later', 'न बाद में और न यहीं — दूसरा आधा काम का है: दावा अभी के बारे में है, सिर्फ़ बाद के बारे में नहीं', 'na baad mein aur na yahin — doosra aadha kaam ka hai: dawa abhi ke baare mein hai, sirf baad ke baare mein nahi', 'indeclinable', 'प्र + इ'
) AS w
JOIN verses v ON v.verse_number = w.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 17;
