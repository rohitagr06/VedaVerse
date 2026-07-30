-- =====================================================================
-- VedaVerse — database/seed_ch14.sql
-- =====================================================================
-- Chapter 14, Guṇa Traya Vibhāga Yoga. Eight verses. Fourth chapter of
-- the INTERMEDIATE track (2, 3, 4, 5, 6, 12, 13, 14, 16, 17, 18).
--
--   14.5   three settings, and all three of them bind      [CARE]
--   14.6   the clear one binds too, by pleasure and knowing
--   14.7   the restless one binds through attachment to doing
--   14.8   the shut-down one                               [CARE]
--   14.11  how to tell which one is running
--   14.22  neither hating them nor missing them
--   14.23  "the settings are turning" — and the -vat suffix [CARE]
--   14.26  going past all three                            [CARE]
--
-- THIS IS 16.4 AGAIN AND THE ANSWER IS IN THE CHAPTER ITSELF
--   Chapter 14 sorts into three, and any chapter that sorts into three
--   can be read as sorting PEOPLE into three. Somebody has always been
--   willing to call another person tāmasic and mean it as a verdict on
--   who they are.
--
--   The refusal here is stronger than it was for chapter 16, because
--   this chapter argues against the misreading out loud. 14.10 says the
--   three take turns — each one rises by putting the other two down,
--   in the same person, repeatedly. A quality that alternates within an
--   afternoon cannot be an identity. Every explanation in this file
--   says "setting" and not "kind of person", and smoke-test.sh asserts
--   the sentence on the default render.
--
-- 14.8 IS THE VERSE THAT CAN HURT SOMEBODY
--   Tamas is glossed with pramāda, ālasya and nidrā — heedlessness,
--   indolence and sleep — and handed to an exhausted person, or a
--   depressed one, it reads as the book calling their state the lowest
--   quality of being. Three things are true and all three are in the
--   explanation:
--     1. It describes a setting that is running, not a person.
--     2. 14.10 makes it temporary by construction.
--     3. Being tired is not this. The verse names a state in which
--        nothing is being SEEN — ajñāna-ja, born of not-knowing. Rest
--        is not on trial anywhere in this chapter, and 6.17 asks for
--        sleep to be FITTED rather than reduced.
--
-- 14.6 IS THE ANTI-PERFECTIONISM ONE AND IT IS EASY TO MISS
--   The clear setting binds too — by attachment to feeling good and by
--   attachment to knowing. Anybody using this chapter as a scorecard is
--   being described by verse 6 while they do it.
--
-- 14.23 TURNS ON A SUFFIX
--   udāsīna-VAT, LIKE one indifferent. Same construction as śatru-vat
--   in 6.6, and doing the same work. It is a description of not being
--   moved by which setting is running, and it is NOT a licence to stop
--   caring about people. The gloss says so.
--
-- 14.26 CARRIES THE DEVOTIONAL FRAME
--   Same handling as 12.13: the verse is addressed to somebody who has
--   that frame or wants it, and a reader who does not share it is not
--   being asked to pretend. Said once, plainly, and not laboured.
--
-- CONTENT RULES — unchanged. Original writing throughout. Sanskrit
--   unaltered, numbering untouched. No praise or criticism of any living
--   politician, party or movement. No communal framing. NOTHING IN THIS
--   FILE NAMES A CONDITION, PRESCRIBES ANYTHING, OR TREATS SLEEP OR
--   REST AS A FAULT.
--
-- RUN AFTER seed_sample.sql. Re-runnable.
--
--     mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
--         < htdocs/database/seed_ch14.sql
--
-- global_order is 524 + verse_number: chapters 1 to 13 have 524 verses.
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

  SELECT 5 AS verse_number, 529 AS global_order, 1 AS is_curated, 'gita-14-5' AS slug,
    'सत्त्वं रजस्तम इति गुणाः प्रकृतिसम्भवाः।\nनिबध्नन्ति महाबाहो देहे देहिनमव्ययम्॥' AS sanskrit_devanagari,
    'sattvaṁ rajas tama iti guṇāḥ prakṛti-sambhavāḥ\nnibadhnanti mahā-bāho dehe dehinam avyayam' AS transliteration_iast,
    'sattvam rajas tama iti gunah prakriti-sambhavah\nnibadhnanti maha-baho dehe dehinam avyayam' AS transliteration_simple,
    'Sattva, rajas and tamas — these qualities, born of prakriti, bind the imperishable dweller in the body.' AS translation_literal,
    'Clear, restless, shut down. Three settings that come out of the material you are made of, and all three of them tie down the one living in the body.' AS translation_en,
    'साफ़, बेचैन, बुझा हुआ। तीन अवस्थाएँ जो उसी सामग्री से निकलती हैं जिससे आप बने हैं, और तीनों ही शरीर में रहने वाले को बाँधती हैं।' AS translation_hi,
    'Saaf, bechain, bujha hua. Teen avasthayein jo usi samagri se nikalti hain jisse tum bane ho, aur teenon hi sharir mein rehne wale ko baandhti hain.' AS translation_hinglish,
    'Three settings, not three kinds of person. And note that all three bind — including the good one.' AS summary_en,
    'तीन अवस्थाएँ, तीन क़िस्म के लोग नहीं। और ध्यान दीजिए कि तीनों बाँधती हैं — अच्छी वाली भी।' AS summary_hi,
    'Teen avasthayein, teen kism ke log nahi. Aur dhyan do ki teenon baandhti hain — achhi wali bhi.' AS summary_hinglish,
    'intermediate' AS difficulty,
    'Gita 14.5: three settings, and all three of them bind' AS seo_title,
    'The Bhagavad Gita names sattva, rajas and tamas. They are states that take turns in the same person, not categories of human being — and the verse says all three bind.' AS seo_description,
    1 AS published

  UNION ALL SELECT 6, 530, 1, 'gita-14-6',
    'तत्र सत्त्वं निर्मलत्वात्प्रकाशकमनामयम्।\nसुखसङ्गेन बध्नाति ज्ञानसङ्गेन चानघ॥',
    'tatra sattvaṁ nirmalatvāt prakāśakam anāmayam\nsukha-saṅgena badhnāti jñāna-saṅgena cānagha',
    'tatra sattvam nirmalatvat prakashakam anamayam\nsukha-sangena badhnati jnana-sangena chanagha',
    'Among them, sattva, being clear, is illuminating and free of affliction. It binds through attachment to happiness and through attachment to knowledge.',
    'The clear one lights things up and does not hurt. And it still ties you down — by getting you attached to feeling good, and by getting you attached to understanding.',
    'साफ़ वाली चीज़ों को रोशन करती है और चुभती नहीं। और वह फिर भी बाँधती है — अच्छा महसूस होने से चिपकाकर, और समझ से चिपकाकर।',
    'Saaf wali cheezon ko roshan karti hai aur chubhti nahi. Aur woh phir bhi baandhti hai — achha mehsoos hone se chipkakar, aur samajh se chipkakar.',
    'The good setting binds too, and one of the two ropes is being pleased with how much you understand.',
    'अच्छी अवस्था भी बाँधती है, और उसकी दो रस्सियों में से एक है इस पर ख़ुश होना कि आप कितना समझते हैं।',
    'Achhi avastha bhi baandhti hai, aur uski do rassiyon mein se ek hai is par khush hona ki tum kitna samajhte ho.',
    'intermediate',
    'Gita 14.6: even the clear setting binds, and knowing is one of its ropes',
    'The Bhagavad Gita says sattva binds through attachment to happiness and to knowledge. Anybody using this chapter as a scorecard is being described by this verse.',
    1

  UNION ALL SELECT 7, 531, 1, 'gita-14-7',
    'रजो रागात्मकं विद्धि तृष्णासङ्गसमुद्भवम्।\nतन्निबध्नाति कौन्तेय कर्मसङ्गेन देहिनम्॥',
    'rajo rāgātmakaṁ viddhi tṛṣṇā-saṅga-samudbhavam\ntan nibadhnāti kaunteya karma-saṅgena dehinam',
    'rajo ragatmakam viddhi trishna-sanga-samudbhavam\ntan nibadhnati kaunteya karma-sangena dehinam',
    'Know rajas to be of the nature of passion, arising from craving and attachment. It binds the embodied one through attachment to action.',
    'The restless one is made of wanting — it comes up out of thirst and sticking. And the way it ties you down is by getting you attached to doing.',
    'बेचैन वाली चाह से बनी है — वह प्यास और चिपकने से उठती है। और वह आपको बाँधती इस तरह है कि आपको करने से चिपका देती है।',
    'Bechain wali chaah se bani hai — woh pyaas aur chipakne se uthti hai. Aur woh tumhe baandhti is tarah hai ki tumhe karne se chipka deti hai.',
    'Not attachment to results. Attachment to activity itself.',
    'नतीजों से चिपकना नहीं। ख़ुद कर्म करते रहने से चिपकना।',
    'Nateejon se chipakna nahi. Khud karm karte rehne se chipakna.',
    'intermediate',
    'Gita 14.7: the restless setting binds you to doing, not to outcomes',
    'The Bhagavad Gita says rajas ties a person down through attachment to action itself. Being busy is the rope, and the rope does not need a result to hold.',
    1

  UNION ALL SELECT 8, 532, 1, 'gita-14-8',
    'तमस्त्वज्ञानजं विद्धि मोहनं सर्वदेहिनाम्।\nप्रमादालस्यनिद्राभिस्तन्निबध्नाति भारत॥',
    'tamas tv ajñāna-jaṁ viddhi mohanaṁ sarva-dehinām\npramādālasya-nidrābhis tan nibadhnāti bhārata',
    'tamas tv ajnana-jam viddhi mohanam sarva-dehinam\npramadalasya-nidrabhis tan nibadhnati bharata',
    'Know tamas to be born of not-knowing, deluding all embodied beings. It binds through heedlessness, indolence and sleep.',
    'The shut-down one comes out of not seeing. It clouds things. And it holds on through not noticing, through not starting, and through going under.',
    'बुझी हुई वाली न देख पाने से निकलती है। वह चीज़ों को धुँधला कर देती है। और वह थामे रहती है — ध्यान न जाने से, शुरू न कर पाने से, और डूब जाने से।',
    'Bujhi hui wali na dekh paane se nikalti hai. Woh cheezon ko dhundhla kar deti hai. Aur woh thaame rehti hai — dhyan na jaane se, shuru na kar paane se, aur doob jaane se.',
    'A setting that is running, not a person. And being tired is not what this verse is about.',
    'यह चलती हुई एक अवस्था है, कोई इंसान नहीं। और थका होना वह नहीं है जिसकी यह श्लोक बात कर रहा है।',
    'Yeh chalti hui ek avastha hai, koi insan nahi. Aur thaka hona woh nahi hai jiski yeh shloka baat kar raha hai.',
    'intermediate',
    'Gita 14.8: the shut-down setting, and what it is not about',
    'The Bhagavad Gita describes tamas as born of not-knowing. It names a state that is running, not a kind of person, and 14.10 says the three take turns.',
    1

  UNION ALL SELECT 11, 535, 1, 'gita-14-11',
    'सर्वद्वारेषु देहेऽस्मिन्प्रकाश उपजायते।\nज्ञानं यदा तदा विद्याद्विवृद्धं सत्त्वमित्युत॥',
    'sarva-dvāreṣu dehe ''smin prakāśa upajāyate\njñānaṁ yadā tadā vidyād vivṛddhaṁ sattvam ity uta',
    'sarva-dvareshu dehe smin prakasha upajayate\njnanam yada tada vidyad vivriddham sattvam ity uta',
    'When light and understanding arise in all the gates of this body, then one should know that sattva has grown strong.',
    'When there is light in every doorway of this body — when things are simply being seen — then you can tell the clear one has come up.',
    'जब इस शरीर के हर दरवाज़े पर रोशनी हो — जब चीज़ें बस दिख रही हों — तब आप जान सकते हैं कि साफ़ वाली उठ आई है।',
    'Jab is sharir ke har darwaze par roshni ho — jab cheezein bas dikh rahi hon — tab tum jaan sakte ho ki saaf wali uth aayi hai.',
    'A test you run on today, not a label you carry. All the gates, not some of them.',
    'यह आज पर चलाई जाने वाली कसौटी है, ढोया जाने वाला लेबल नहीं। सारे दरवाज़े, कुछ नहीं।',
    'Yeh aaj par chalayi jaane wali kasauti hai, dhoya jaane wala label nahi. Saare darwaze, kuch nahi.',
    'intermediate',
    'Gita 14.11: how to tell which setting is running today',
    'The Bhagavad Gita gives a test rather than a label: light in all the gates of the body means sattva has grown. It is a reading of now, not of you.',
    1

  UNION ALL SELECT 22, 546, 1, 'gita-14-22',
    'प्रकाशं च प्रवृत्तिं च मोहमेव च पाण्डव।\nन द्वेष्टि सम्प्रवृत्तानि न निवृत्तानि काङ्क्षति॥',
    'prakāśaṁ ca pravṛttiṁ ca moham eva ca pāṇḍava\nna dveṣṭi sampravṛttāni na nivṛttāni kāṅkṣati',
    'prakasham cha pravrittim cha moham eva cha pandava\nna dveshti sampravrittani na nivrittani kankshati',
    'He neither hates light, activity and delusion when they arise, nor longs for them when they cease.',
    'Light, activity, fog. He does not hate them when they turn up and does not miss them when they go.',
    'रोशनी, हलचल, धुंध। जब ये आती हैं तो वह इनसे नफ़रत नहीं करता, और जब चली जाती हैं तो इन्हें याद नहीं करता।',
    'Roshni, halchal, dhundh. Jab yeh aati hain to woh inse nafrat nahi karta, aur jab chali jaati hain to inhe yaad nahi karta.',
    'Not hating the fog is the easy half to say and the hard half to do.',
    'धुंध से नफ़रत न करना — कहने में यह आधा आसान है और करने में यही आधा मुश्किल।',
    'Dhundh se nafrat na karna — kehne mein yeh aadha aasan hai aur karne mein yahi aadha mushkil.',
    'intermediate',
    'Gita 14.22: not hating the fog when it comes, not missing the light when it goes',
    'The Bhagavad Gita describes somebody who has gone past the three settings as neither hating them when they arise nor longing for them when they stop.',
    1

  UNION ALL SELECT 23, 547, 1, 'gita-14-23',
    'उदासीनवदासीनो गुणैर्यो न विचाल्यते।\nगुणा वर्तन्त इत्येव योऽवतिष्ठति नेङ्गते॥',
    'udāsīnavad āsīno guṇair yo na vicālyate\nguṇā vartanta ity eva yo ''vatiṣṭhati neṅgate',
    'udasinavad asino gunair yo na vichalyate\nguna vartanta ity eva yo vatishthati nengate',
    'Seated as though indifferent, he is not shaken by the qualities. Standing firm in the thought "the qualities alone are turning", he does not waver.',
    'Sitting there like somebody uninvolved, he is not thrown about by the settings. "These are just turning over" — he stays with that, and does not move.',
    'वहाँ ऐसे बैठा जैसे उसका इसमें कुछ लगा ही न हो, वह अवस्थाओं से इधर-उधर नहीं होता। "ये तो बस बदलती रहती हैं" — वह इसी पर टिका रहता है, और हिलता नहीं।',
    'Wahan aise baitha jaise uska isme kuch laga hi na ho, woh avasthaon se idhar-udhar nahi hota. "Yeh to bas badalti rehti hain" — woh isi par tika rehta hai, aur hilta nahi.',
    'The word is "LIKE somebody uninvolved". The suffix is doing real work and it is not a licence to stop caring.',
    'शब्द है "उदासीन जैसा"। प्रत्यय असल काम कर रहा है और यह किसी की परवाह छोड़ देने की छूट नहीं है।',
    'Shabd hai "udaseen jaisa". Pratyay asal kaam kar raha hai aur yeh kisi ki parwah chhod dene ki chhoot nahi hai.',
    'intermediate',
    'Gita 14.23: like one uninvolved — and the suffix is the whole verse',
    'The Bhagavad Gita says udasina-vat, LIKE one indifferent. The same construction as shatru-vat in 6.6, and it is not an instruction to stop caring about anybody.',
    1

  UNION ALL SELECT 26, 550, 1, 'gita-14-26',
    'मां च योऽव्यभिचारेण भक्तियोगेन सेवते।\nस गुणान्समतीत्यैतान्ब्रह्मभूयाय कल्पते॥',
    'māṁ ca yo ''vyabhicāreṇa bhakti-yogena sevate\nsa guṇān samatītyaitān brahma-bhūyāya kalpate',
    'mam cha yo vyabhicharena bhakti-yogena sevate\nsa gunan samatityaitan brahma-bhuyaya kalpate',
    'And one who serves me with unwavering devotion, going completely beyond these qualities, becomes fit for brahman.',
    'And whoever stays with me without wandering off, through devotion — that one goes past all three of these settings and becomes fit for what is beyond them.',
    'और जो बिना भटके, प्रेम के रास्ते से, मेरे साथ बना रहता है — वह इन तीनों अवस्थाओं के पार चला जाता है और उसके योग्य हो जाता है जो इनसे परे है।',
    'Aur jo bina bhatke, prem ke raste se, mere saath bana rehta hai — woh in teenon avasthaon ke paar chala jaata hai aur uske yogya ho jaata hai jo inse pare hai.',
    'The chapter''s way out, offered in a frame not every reader shares. Said once, and you do not have to take it.',
    'अध्याय का बाहर निकलने का रास्ता, ऐसे ढाँचे में पेश किया गया जो हर पाठक का नहीं है। एक बार कह दिया गया, और इसे लेना ज़रूरी नहीं।',
    'Adhyay ka bahar nikalne ka raasta, aise dhaanche mein pesh kiya gaya jo har paathak ka nahi hai. Ek baar keh diya gaya, aur ise lena zaroori nahi.',
    'intermediate',
    'Gita 14.26: the way past all three, offered in a frame you need not share',
    'The Bhagavad Gita offers devotion as the way past the three gunas. It is addressed to somebody who has or wants that frame, and a reader who does not is not asked to pretend.',
    1

) AS v
JOIN chapters c ON c.chapter_number = 14;

-- =====================================================================
-- 2. EXPLANATIONS
-- =====================================================================
-- All at beginner depth. The load-bearing sentences, all asserted by
-- smoke-test.sh on the DEFAULT render:
--   14.5   "settings that take turns, not kinds of person"
--   14.8   "being tired is not what this verse is describing"
--   14.23  the -vat suffix, and that it is not a licence to stop caring
-- =====================================================================

DELETE ve FROM verse_explanations ve JOIN verses v ON v.id = ve.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 14;

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 5 AS vn, 'beginner' AS level,
   'The chapter opens by naming its three terms. Everything else in it — how to tell them apart, what each one costs, how to get past them — depends on what these three are taken to be.' AS h_en,
   'अध्याय अपनी तीन इकाइयों का नाम लेकर शुरू होता है। बाक़ी सब कुछ — उन्हें अलग कैसे पहचानें, हर एक की क़ीमत क्या है, इनके पार कैसे जाएँ — इस पर टिका है कि ये तीन क्या मानी जाती हैं।' AS h_hi,
   'Adhyay apni teen ikaaiyon ka naam lekar shuru hota hai. Baaki sab kuch — unhe alag kaise pehchanein, har ek ki keemat kya hai, inke paar kaise jaayein — is par tika hai ki yeh teen kya maani jaati hain.' AS h_hing,
   'Sattva, rajas, tamas — clear, restless, shut down. The verse calls them guṇas, which is closer to strand or setting than to virtue, and says all three come out of prakṛti: the material a person is made of, not a decision they took.' AS p_en,
   'सत्त्व, रजस्, तमस् — साफ़, बेचैन, बुझा हुआ। श्लोक इन्हें गुण कहता है, और यह "सद्गुण" से ज़्यादा "धागा" या "अवस्था" के पास है, और कहता है कि तीनों प्रकृति से निकलती हैं: उस सामग्री से जिससे इंसान बना है, किसी लिए हुए फ़ैसले से नहीं।' AS p_hi,
   'Sattva, rajas, tamas — saaf, bechain, bujha hua. Shloka inhe gun kehta hai, aur yeh "sadgun" se zyada "dhaga" ya "avastha" ke paas hai, aur kehta hai ki teenon prakriti se nikalti hain: us samagri se jisse insan bana hai, kisi liye hue faisle se nahi.' AS p_hing,
   'Any chapter that sorts into three can be read as sorting people into three, and somebody has always been willing to call another person tāmasic and mean it about who they are. This chapter argues against that itself, five verses from here: 14.10 says the three take turns, each one rising by putting the other two down, in the same person, over and over. A quality that alternates inside an afternoon is not an identity. These are settings that take turns, not kinds of person, and everything after this is written on that footing. Note also what the verse says about the clear one: it binds too.' AS m_en,
   'तीन में छाँटने वाले किसी भी अध्याय को लोगों को तीन में छाँटने के तौर पर पढ़ा जा सकता है, और किसी न किसी ने हमेशा दूसरे को तामसिक कहकर उसे उसकी पहचान बना दिया है। यह अध्याय ख़ुद इसके ख़िलाफ़ दलील देता है, यहाँ से पाँच श्लोक बाद: 14.10 कहता है कि तीनों बारी-बारी आती हैं, हर एक बाक़ी दो को दबाकर उठती है, उसी इंसान में, बार-बार। जो गुण एक दोपहर के भीतर बदलता रहे वह पहचान नहीं है। ये बारी-बारी चलने वाली अवस्थाएँ हैं, इंसानों की क़िस्में नहीं, और इसके बाद सब कुछ इसी बुनियाद पर लिखा है। यह भी देखिए कि श्लोक साफ़ वाली के बारे में क्या कहता है: वह भी बाँधती है।' AS m_hi,
   'Teen mein chhaantne wale kisi bhi adhyay ko logon ko teen mein chhaantne ke taur par padha ja sakta hai, aur kisi na kisi ne hamesha doosre ko tamasik kehkar use uski pehchan bana diya hai. Yeh adhyay khud iske khilaf dalil deta hai, yahan se paanch shloka baad: 14.10 kehta hai ki teenon baari-baari aati hain, har ek baaki do ko dabakar uthti hai, usi insan mein, baar baar. Jo gun ek dopahar ke bheetar badalta rahe woh pehchan nahi hai. Yeh baari-baari chalne wali avasthayein hain, insanon ki kismein nahi, aur iske baad sab kuch isi buniyad par likha hai. Yeh bhi dekho ki shloka saaf wali ke baare mein kya kehta hai: woh bhi baandhti hai.' AS m_hing

  UNION ALL SELECT 6, 'beginner',
   'The first of the three descriptions, and the one most readers skim because they already know sattva is the good one.',
   'तीनों वर्णनों में पहला, और वही जिसे ज़्यादातर पढ़ने वाले सरसरी तौर पर निकाल देते हैं क्योंकि उन्हें पहले से पता है कि सत्त्व अच्छा वाला है।',
   'Teenon varnanon mein pehla, aur wahi jise zyadatar padhne wale sarsari taur par nikaal dete hain kyunki unhe pehle se pata hai ki sattva achha wala hai.',
   'It lights things up and it does not hurt, and then comes the word the verse is actually here for: badhnāti, it binds. Two ropes are named. One is attachment to feeling good. The other is attachment to knowing.',
   'यह चीज़ों को रोशन करता है और चुभता नहीं, और फिर वह शब्द आता है जिसके लिए श्लोक असल में यहाँ है: बध्नाति, वह बाँधता है। दो रस्सियों का नाम लिया गया है। एक है अच्छा महसूस होने से चिपकना। दूसरी है जानने से चिपकना।',
   'Yeh cheezon ko roshan karta hai aur chubhta nahi, aur phir woh shabd aata hai jiske liye shloka asal mein yahan hai: badhnati, woh baandhta hai. Do rassiyon ka naam liya gaya hai. Ek hai achha mehsoos hone se chipakna. Doosri hai jaanne se chipakna.',
   'The second rope is the interesting one and it catches exactly the kind of reader who gets this far into a chapter about the guṇas. Somebody who has learned the three settings, can name which one is running, and enjoys being able to — that is jñāna-saṅga, described here in the sixth verse of the chapter they are using to do it. The verse is not against understanding. It is saying that being pleased with how much you understand is a rope like any other, and that this one is harder to see because it looks like progress.',
   'दूसरी रस्सी दिलचस्प है और वह ठीक उसी तरह के पाठक को पकड़ती है जो गुणों के अध्याय में इतना अंदर तक आ जाता है। जिसने तीनों अवस्थाएँ सीख ली हों, जो बता सके कि कौन-सी चल रही है, और जिसे बता पाना अच्छा लगता हो — वही ज्ञान-सङ्ग है, और उसी अध्याय के छठे श्लोक में उसका वर्णन है जिससे वह यह कर रहा है। श्लोक समझ के ख़िलाफ़ नहीं है। वह कह रहा है कि आप कितना समझते हैं, इस पर ख़ुश होना बाक़ियों जैसी ही एक रस्सी है, और यह वाली देखने में ज़्यादा मुश्किल है क्योंकि यह तरक़्क़ी जैसी दिखती है।',
   'Doosri rassi dilchasp hai aur woh theek usi tarah ke paathak ko pakadti hai jo gunon ke adhyay mein itna andar tak aa jaata hai. Jisne teenon avasthayein seekh li hon, jo bata sake ki kaun si chal rahi hai, aur jise bata paana achha lagta ho — wahi gyan-sang hai, aur usi adhyay ke chhathe shloka mein uska varnan hai jisse woh yeh kar raha hai. Shloka samajh ke khilaf nahi hai. Woh keh raha hai ki tum kitna samajhte ho, is par khush hona baakiyon jaisi hi ek rassi hai, aur yeh wali dekhne mein zyada mushkil hai kyunki yeh tarakki jaisi dikhti hai.'

  UNION ALL SELECT 7, 'beginner',
   'The middle one, and the setting most of the people reading this are in most of the time.',
   'बीच वाली, और यही वह अवस्था है जिसमें इसे पढ़ने वाले ज़्यादातर लोग ज़्यादातर वक़्त होते हैं।',
   'Beech wali, aur yahi woh avastha hai jisme ise padhne wale zyadatar log zyadatar waqt hote hain.',
   'Made of rāga — colour, pull, wanting — and coming up out of tṛṣṇā, which is thirst. Then the mechanism, and it is precise: karma-saṅgena, by attachment to action. Not to results. To the doing.',
   'राग से बनी — रंग, खिंचाव, चाह — और तृष्णा से उठती हुई, यानी प्यास से। फिर तंत्र, और वह साफ़ है: कर्म-सङ्गेन, कर्म से चिपकने से। नतीजों से नहीं। करने से।',
   'Raag se bani — rang, khinchav, chaah — aur trishna se uthti hui, yani pyaas se. Phir tantra, aur woh saaf hai: karma-sangena, karm se chipakne se. Nateejon se nahi. Karne se.',
   'That distinction is the whole use of this verse. Chapter 2 dealt with attachment to results and everybody remembers it. This is a different rope: being attached to activity itself, so that stopping feels wrong regardless of what stopping would cost or save. It is why somebody can let go of a specific outcome, genuinely, and still be unable to sit still on a Sunday. The rope does not need a result to hold. It only needs the next thing.',
   'यही फ़र्क़ इस श्लोक का पूरा काम है। दूसरा अध्याय नतीजों से चिपकने पर था और वह सबको याद है। यह अलग रस्सी है: ख़ुद हलचल से चिपक जाना, इस तरह कि रुकना ग़लत लगे, चाहे रुकने से कुछ बचता हो या बिगड़ता हो। इसीलिए कोई किसी ख़ास नतीजे को सचमुच छोड़ सकता है और फिर भी रविवार को चुपचाप बैठ नहीं पाता। रस्सी को थामने के लिए किसी नतीजे की ज़रूरत नहीं। उसे बस अगली चीज़ चाहिए।',
   'Yahi farq is shloka ka poora kaam hai. Doosra adhyay nateejon se chipakne par tha aur woh sabko yaad hai. Yeh alag rassi hai: khud halchal se chipak jaana, is tarah ki rukna galat lage, chahe rukne se kuch bachta ho ya bigadta ho. Isiliye koi kisi khaas nateeje ko sach mein chhod sakta hai aur phir bhi Sunday ko chupchap baith nahi pata. Rassi ko thaamne ke liye kisi nateeje ki zaroorat nahi. Use bas agli cheez chahiye.'

  UNION ALL SELECT 8, 'beginner',
   'The third description. It is the shortest of the three and it is the one that does the most damage when it is read as being about a person.',
   'तीसरा वर्णन। तीनों में सबसे छोटा, और वही जो सबसे ज़्यादा नुक़सान करता है जब उसे किसी इंसान के बारे में पढ़ लिया जाए।',
   'Teesra varnan. Teenon mein sabse chhota, aur wahi jo sabse zyada nuksaan karta hai jab use kisi insan ke baare mein padh liya jaaye.',
   'Ajñāna-ja — born of not-knowing. That is the definition, and it comes first, before any of the behaviour. Then three things it holds on by: pramāda, not noticing; ālasya, not starting; nidrā, going under.',
   'अज्ञानज — न जानने से उपजा। यही परिभाषा है, और वह पहले आती है, किसी भी बरताव से पहले। फिर तीन चीज़ें जिनसे वह थामे रहता है: प्रमाद, ध्यान न जाना; आलस्य, शुरू न कर पाना; निद्रा, डूब जाना।',
   'Agyan-ja — na jaanne se upja. Yahi paribhasha hai, aur woh pehle aati hai, kisi bhi bartav se pehle. Phir teen cheezein jinse woh thaame rehta hai: pramad, dhyan na jaana; aalasya, shuru na kar paana; nidra, doob jaana.',
   'Three things have to be said and none can be left out. First: this is a setting that is running, not a person, and 14.10 makes it temporary by construction — the three take turns in the same person, repeatedly. Nobody is one of these. Second, and this is the one that matters most: being tired is not what this verse is describing. The definition is ajñāna-ja, born of not-knowing — a state in which nothing is being seen. Somebody exhausted from a long week can see perfectly well what is happening to them, and this verse is not about them. Rest is not on trial anywhere in this chapter, and 6.17 asks for sleep to be FITTED rather than reduced. Third: if reading this page has produced a verdict about yourself, that verdict is the misuse the chapter itself argues against five verses from here.',
   'तीन बातें कहनी हैं और कोई छोड़ी नहीं जा सकती। पहली: यह चलती हुई एक अवस्था है, कोई इंसान नहीं, और 14.10 इसे बनावट से ही अस्थायी कर देता है — तीनों उसी इंसान में बारी-बारी आती हैं, बार-बार। कोई इनमें से "है" नहीं। दूसरी, और यही सबसे ज़्यादा मायने रखती है: थका होना वह नहीं है जिसका यह श्लोक वर्णन कर रहा है। परिभाषा है अज्ञानज, न जानने से उपजा — ऐसी हालत जिसमें कुछ दिख ही नहीं रहा। लंबे हफ़्ते से थका कोई ठीक-ठीक देख सकता है कि उसके साथ क्या हो रहा है, और यह श्लोक उसके बारे में नहीं है। इस अध्याय में कहीं आराम पर मुक़दमा नहीं है, और 6.17 नींद को कम करने को नहीं, नाप का करने को कहता है। तीसरी: अगर यह पन्ना पढ़कर अपने बारे में कोई फ़ैसला बना है, तो वही फ़ैसला वह दुरुपयोग है जिसके ख़िलाफ़ यह अध्याय ख़ुद यहाँ से पाँच श्लोक बाद दलील देता है।',
   'Teen baatein kehni hain aur koi chhodi nahi ja sakti. Pehli: yeh chalti hui ek avastha hai, koi insan nahi, aur 14.10 ise banawat se hi asthayi kar deta hai — teenon usi insan mein baari-baari aati hain, baar baar. Koi inme se "hai" nahi. Doosri, aur yahi sabse zyada maayne rakhti hai: thaka hona woh nahi hai jiska yeh shloka varnan kar raha hai. Paribhasha hai agyan-ja, na jaanne se upja — aisi haalat jisme kuch dikh hi nahi raha. Lambe hafte se thaka koi theek theek dekh sakta hai ki uske saath kya ho raha hai, aur yeh shloka uske baare mein nahi hai. Is adhyay mein kahin aaram par mukadma nahi hai, aur 6.17 neend ko kam karne ko nahi, naap ka karne ko kehta hai. Teesri: agar yeh panna padhkar apne baare mein koi faisla bana hai, to wahi faisla woh durupyog hai jiske khilaf yeh adhyay khud yahan se paanch shloka baad dalil deta hai.'

  UNION ALL SELECT 11, 'beginner',
   'The chapter turns from describing the three to telling you how to spot which one is running. Three verses do it, one each. This is the first.',
   'अध्याय तीनों का वर्णन करने से मुड़कर यह बताने लगता है कि कौन-सी चल रही है, यह पहचानें कैसे। तीन श्लोक यह करते हैं, हर एक के लिए एक। यह पहला है।',
   'Adhyay teenon ka varnan karne se mudkar yeh batane lagta hai ki kaun si chal rahi hai, yeh pehchanein kaise. Teen shloka yeh karte hain, har ek ke liye ek. Yeh pehla hai.',
   'Sarva-dvāreṣu — in all the gates. The gates are the senses and the word "all" is doing work: not the ones you are pointing at, all of them at once. Light and understanding arising there, on their own, is the sign.',
   'सर्वद्वारेषु — सारे दरवाज़ों में। दरवाज़े इंद्रियाँ हैं और "सारे" शब्द काम कर रहा है: वे नहीं जिनकी तरफ़ आप इशारा कर रहे हैं, बल्कि सब एक साथ। वहाँ रोशनी और समझ का अपने आप उठ आना ही संकेत है।',
   'Sarva-dvareshu — saare darwazon mein. Darwaze indriyan hain aur "saare" shabd kaam kar raha hai: woh nahi jinki taraf tum ishara kar rahe ho, balki sab ek saath. Wahan roshni aur samajh ka apne aap uth aana hi sanket hai.',
   'The shape of this is worth more than the content. It is a test you run on today — is there light in all of it, right now — and not a label you get issued and then carry. That matters because the same reader who could not be told which category they belong to can be told, accurately and usefully, what is running this afternoon. One of those is a diagnosis and the other is a thermometer. The chapter only ever offers the thermometer.',
   'इसकी बनावट इसकी बात से ज़्यादा क़ीमती है। यह आज पर चलाई जाने वाली कसौटी है — अभी हर जगह रोशनी है या नहीं — न कि कोई लेबल जो आपको जारी होकर ढोया जाए। यह मायने रखता है क्योंकि जिस पाठक को यह नहीं बताया जा सकता कि वह किस श्रेणी का है, उसे यह सही और काम की तरह बताया जा सकता है कि इस दोपहर क्या चल रहा है। इन दोनों में एक निदान है और दूसरा थर्मामीटर। अध्याय हमेशा सिर्फ़ थर्मामीटर देता है।',
   'Iski banawat iski baat se zyada keemti hai. Yeh aaj par chalayi jaane wali kasauti hai — abhi har jagah roshni hai ya nahi — na ki koi label jo tumhe jaari hokar dhoya jaaye. Yeh maayne rakhta hai kyunki jis paathak ko yeh nahi bataya ja sakta ki woh kis shreni ka hai, use yeh sahi aur kaam ki tarah bataya ja sakta hai ki is dopahar kya chal raha hai. In dono mein ek nidan hai aur doosra thermometer. Adhyay hamesha sirf thermometer deta hai.'

  UNION ALL SELECT 22, 'beginner',
   'Arjuna has asked how you recognise somebody who has gone past the three. The answer runs for four verses and this is the first of them.',
   'अर्जुन ने पूछा है कि जो तीनों के पार चला गया हो उसे पहचानें कैसे। जवाब चार श्लोक चलता है और यह उनमें पहला है।',
   'Arjun ne poochha hai ki jo teenon ke paar chala gaya ho use pehchanein kaise. Jawab chaar shloka chalta hai aur yeh unme pehla hai.',
   'Two halves, and both are needed. He does not hate them when they arrive — including the fog. He does not long for them when they leave — including the light. Neither half is about the settings changing. Both are about him not moving when they do.',
   'दो आधे, और दोनों ज़रूरी हैं। जब वे आती हैं तो वह उनसे नफ़रत नहीं करता — धुंध से भी नहीं। जब वे जाती हैं तो उन्हें याद नहीं करता — रोशनी को भी नहीं। कोई भी आधा अवस्थाओं के बदलने के बारे में नहीं है। दोनों इस बारे में हैं कि जब वे बदलती हैं तो वह हिलता नहीं।',
   'Do aadhe, aur dono zaroori hain. Jab woh aati hain to woh unse nafrat nahi karta — dhundh se bhi nahi. Jab woh jaati hain to unhe yaad nahi karta — roshni ko bhi nahi. Koi bhi aadha avasthaon ke badalne ke baare mein nahi hai. Dono is baare mein hain ki jab woh badalti hain to woh hilta nahi.',
   'Not hating the fog is the half worth stopping on. Most people who use a framework like this one use it to be at war with one of its categories — to notice the dull afternoon and immediately start fighting it, which is a second thing happening on top of the first and usually the more tiring of the two. The verse describes somebody who has stopped adding that. And the other half is a genuine cost: not missing the light either, which means giving up the habit of measuring today against the best day you had.',
   'रुकने लायक़ आधा है धुंध से नफ़रत न करना। ऐसे ढाँचे का इस्तेमाल करने वाले ज़्यादातर लोग उसका इस्तेमाल उसकी किसी एक श्रेणी से जंग लड़ने में करते हैं — सुस्त दोपहर को देखते ही उससे भिड़ जाना, जो पहली चीज़ के ऊपर दूसरी चीज़ है और आमतौर पर दोनों में ज़्यादा थकाने वाली। श्लोक ऐसे इंसान का वर्णन करता है जिसने वह जोड़ना बंद कर दिया है। और दूसरे आधे की असली क़ीमत है: रोशनी को भी याद न करना, यानी आज को अपने सबसे अच्छे दिन से नापने की आदत छोड़ देना।',
   'Rukne layak aadha hai dhundh se nafrat na karna. Aise dhaanche ka istemaal karne wale zyadatar log uska istemaal uski kisi ek shreni se jang ladne mein karte hain — sust dopahar ko dekhte hi usse bhid jaana, jo pehli cheez ke upar doosri cheez hai aur aam taur par dono mein zyada thakane wali. Shloka aise insan ka varnan karta hai jisne woh jodna band kar diya hai. Aur doosre aadhe ki asli keemat hai: roshni ko bhi yaad na karna, yani aaj ko apne sabse achhe din se naapne ki aadat chhod dena.'

  UNION ALL SELECT 23, 'beginner',
   'The second of the four, and the one people quote. It is also the one that gets quoted with the most important part of it removed.',
   'चारों में दूसरा, और वही जिसे लोग उद्धृत करते हैं। और वही जिसे उसका सबसे ज़रूरी हिस्सा हटाकर उद्धृत किया जाता है।',
   'Chaaron mein doosra, aur wahi jise log uddhrit karte hain. Aur wahi jise uska sabse zaroori hissa hatakar uddhrit kiya jaata hai.',
   'Udāsīna-VAT. Like one uninvolved. It is the same construction as śatru-vat in 6.6, where the mind behaves like an enemy without being one, and the suffix is doing exactly as much work here. He is not uninvolved. He is seated as though he were.',
   'उदासीन-वत्। उदासीन जैसा। यह वही बनावट है जो 6.6 में शत्रु-वत् की है, जहाँ मन शत्रु हुए बिना शत्रु जैसा बरतता है, और प्रत्यय यहाँ ठीक उतना ही काम कर रहा है। वह उदासीन नहीं है। वह ऐसे बैठा है जैसे हो।',
   'Udaseen-vat. Udaseen jaisa. Yeh wahi banawat hai jo 6.6 mein shatru-vat ki hai, jahan man shatru hue bina shatru jaisa bartta hai, aur pratyay yahan theek utna hi kaam kar raha hai. Woh udaseen nahi hai. Woh aise baitha hai jaise ho.',
   'Drop the suffix and the verse becomes a licence to stop caring about anybody, and it has been read that way — by people who wanted a reason, and by people who were tired. What is actually being described is narrower and much more useful: he is not thrown about by which setting happens to be running. "These are just turning over" is a sentence about the weather, not about the people standing in it. Chapter 12 spends eight verses on somebody who is friendly to every being and steady in pleasure and pain, and it is the same person. If a reading of 14.23 makes that person impossible, the reading is wrong.',
   'प्रत्यय हटा दीजिए और श्लोक किसी की परवाह न करने की छूट बन जाता है, और उसे ऐसे पढ़ा भी गया है — उन लोगों ने जिन्हें कोई बहाना चाहिए था, और उन्होंने जो थके हुए थे। असल में जिसका वर्णन है वह छोटा और कहीं ज़्यादा काम का है: वह इससे इधर-उधर नहीं होता कि इस वक़्त कौन-सी अवस्था चल रही है। "ये तो बस बदलती रहती हैं" मौसम के बारे में वाक्य है, उसमें खड़े लोगों के बारे में नहीं। बारहवाँ अध्याय आठ श्लोक ऐसे इंसान पर लगाता है जो हर प्राणी से मित्रवत है और सुख-दुख में समान है, और वह वही इंसान है। अगर 14.23 का कोई पाठ उस इंसान को नामुमकिन कर दे, तो पाठ ग़लत है।',
   'Pratyay hata do aur shloka kisi ki parwah na karne ki chhoot ban jaata hai, aur use aise padha bhi gaya hai — un logon ne jinhe koi bahana chahiye tha, aur unhone jo thake hue the. Asal mein jiska varnan hai woh chhota aur kahin zyada kaam ka hai: woh isse idhar-udhar nahi hota ki is waqt kaun si avastha chal rahi hai. "Yeh to bas badalti rehti hain" mausam ke baare mein vakya hai, usme khade logon ke baare mein nahi. Barahvan adhyay aath shloka aise insan par lagata hai jo har prani se mitravat hai aur sukh-dukh mein saman hai, aur woh wahi insan hai. Agar 14.23 ka koi paath us insan ko namumkin kar de, to paath galat hai.'

  UNION ALL SELECT 26, 'beginner',
   'The chapter has described the three settings and the person who is past them. This is the last thing it says about how somebody gets there.',
   'अध्याय तीनों अवस्थाओं का और उनके पार वाले इंसान का वर्णन कर चुका है। वहाँ तक पहुँचा कैसे जाता है, इस बारे में यह उसकी आख़िरी बात है।',
   'Adhyay teenon avasthaon ka aur unke paar wale insan ka varnan kar chuka hai. Wahan tak pahuncha kaise jaata hai, is baare mein yeh uski aakhiri baat hai.',
   'Avyabhicāreṇa — without wandering off, without going elsewhere. Then bhakti-yoga, and then a verb that means to serve or attend on. The claim is that staying with one thing without straying is itself what carries somebody past all three settings.',
   'अव्यभिचारेण — बिना भटके, कहीं और जाए बिना। फिर भक्तियोग, और फिर एक क्रिया जिसका मतलब है सेवा करना या साथ लगे रहना। दावा यह है कि बिना भटके एक चीज़ के साथ बने रहना ही वह है जो किसी को तीनों अवस्थाओं के पार ले जाता है।',
   'Avyabhicharen — bina bhatke, kahin aur jaaye bina. Phir bhakti-yog, aur phir ek kriya jiska matlab hai seva karna ya saath lage rehna. Dawa yeh hai ki bina bhatke ek cheez ke saath bane rehna hi woh hai jo kisi ko teenon avasthaon ke paar le jaata hai.',
   'This is addressed to somebody who has that frame or wants it, and it is worth saying so once and plainly. A reader who does not share it is not being asked to pretend, and the rest of the chapter does not depend on this verse — the three settings, the test in 14.11 and the person described in 14.22 and 14.23 all stand on their own. What is transferable here, and it is not small, is the shape of the claim: not effort against the settings, not managing them one by one, but attention that does not wander. The chapter has just spent twenty verses showing that fighting a setting is one more thing happening inside it.',
   'यह उसे संबोधित है जिसके पास वह ढाँचा है या जो उसे चाहता है, और यह एक बार साफ़-साफ़ कह देना ज़रूरी है। जो पाठक इसे साझा नहीं करता उससे दिखावे की माँग नहीं है, और बाक़ी अध्याय इस श्लोक पर टिका नहीं है — तीनों अवस्थाएँ, 14.11 की कसौटी और 14.22-23 वाला इंसान, सब अपने आप खड़े हैं। जो चीज़ यहाँ से ले जाई जा सकती है, और वह छोटी नहीं है, वह दावे की बनावट है: अवस्थाओं के ख़िलाफ़ ज़ोर नहीं, उन्हें एक-एक करके संभालना नहीं, बल्कि वह ध्यान जो भटकता नहीं। अध्याय अभी बीस श्लोक यह दिखाने में लगा चुका है कि किसी अवस्था से लड़ना उसी के भीतर हो रही एक और चीज़ है।',
   'Yeh use sambodhit hai jiske paas woh dhaancha hai ya jo use chahta hai, aur yeh ek baar saaf saaf keh dena zaroori hai. Jo paathak ise sajha nahi karta usse dikhave ki maang nahi hai, aur baaki adhyay is shloka par tika nahi hai — teenon avasthayein, 14.11 ki kasauti aur 14.22-23 wala insan, sab apne aap khade hain. Jo cheez yahan se le jaayi ja sakti hai, aur woh chhoti nahi hai, woh dawe ki banawat hai: avasthaon ke khilaf zor nahi, unhe ek-ek karke sambhalna nahi, balki woh dhyan jo bhatakta nahi. Adhyay abhi bees shloka yeh dikhane mein laga chuka hai ki kisi avastha se ladna usi ke bheetar ho rahi ek aur cheez hai.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 14;

-- =====================================================================
-- 3. HOOKS, REFLECTIONS, PRACTICES, TOPICS
-- =====================================================================
-- NO REFLECTION IN THIS FILE ASKS THE READER WHICH GUNA THEY ARE, and
-- none asks them to rate themselves. Every one of them is about today,
-- this afternoon, this week — the thermometer and not the diagnosis.
-- The 14.8 practice deliberately asks for nothing to be fixed.
-- =====================================================================

DELETE m FROM verse_memory_aids m JOIN verses v ON v.id = m.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 14;
DELETE r FROM verse_reflections r JOIN verses v ON v.id = r.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 14;
DELETE p FROM verse_practices p JOIN verses v ON v.id = p.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 14;
DELETE vt FROM verse_topics vt JOIN verses v ON v.id = vt.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 14;

INSERT INTO verse_memory_aids (verse_id, hook_en, hook_hi, hook_hinglish, analogy_en, analogy_hi, analogy_hinglish, visual_cue)
SELECT v.id, m.h_en, m.h_hi, m.h_hing, m.a_en, m.a_hi, m.a_hing, m.cue FROM (
  SELECT 5 AS vn,
  'Three settings that take turns. Not three kinds of person.' AS h_en,
  'बारी-बारी चलने वाली तीन अवस्थाएँ। तीन क़िस्म के लोग नहीं।' AS h_hi,
  'Baari-baari chalne wali teen avasthayein. Teen kism ke log nahi.' AS h_hing,
  'Like weather over one field. Nobody says the field is a rainstorm.' AS a_en,
  'एक ही खेत के ऊपर के मौसम जैसा। कोई यह नहीं कहता कि खेत बारिश है।' AS a_hi,
  'Ek hi khet ke upar ke mausam jaisa. Koi yeh nahi kehta ki khet baarish hai.' AS a_hing,
  'One field, three skies' AS cue

  UNION ALL SELECT 6,
  'Even the good one binds. One of its ropes is enjoying how much you understand.',
  'अच्छी वाली भी बाँधती है। उसकी एक रस्सी है यह अच्छा लगना कि आप कितना समझते हैं।',
  'Achhi wali bhi baandhti hai. Uski ek rassi hai yeh achha lagna ki tum kitna samajhte ho.',
  'Like a comfortable chair you stopped getting out of. Nothing wrong with the chair.',
  'उस आरामदेह कुर्सी जैसी जिससे आपने उठना बंद कर दिया। कुर्सी में कोई ख़राबी नहीं है।',
  'Us aaramdeh kursi jaisi jisse tumne uthna band kar diya. Kursi mein koi kharabi nahi hai.',
  'A good chair, well used'

  UNION ALL SELECT 7,
  'It ties you to the doing, not to the result.',
  'यह आपको करने से बाँधती है, नतीजे से नहीं।',
  'Yeh tumhe karne se baandhti hai, nateeje se nahi.',
  'Like a car that will idle all day. It does not need anywhere to go.',
  'उस गाड़ी जैसी जो दिन भर चालू खड़ी रह सकती है। उसे कहीं जाना ज़रूरी नहीं।',
  'Us gaadi jaisi jo din bhar chaalu khadi reh sakti hai. Use kahin jaana zaroori nahi.',
  'An engine running, handbrake on'

  UNION ALL SELECT 8,
  'Born of not seeing. Being tired is not this.',
  'न देख पाने से उपजी। थका होना यह नहीं है।',
  'Na dekh paane se upji. Thaka hona yeh nahi hai.',
  'Like fog on a windscreen, not like a driver who is resting.',
  'विंडस्क्रीन पर जमी धुंध जैसी, आराम कर रहे ड्राइवर जैसी नहीं।',
  'Windscreen par jami dhundh jaisi, aaram kar rahe driver jaisi nahi.',
  'A misted pane, from inside'

  UNION ALL SELECT 11,
  'A thermometer, not a diagnosis. It reads today.',
  'थर्मामीटर, निदान नहीं। यह आज को पढ़ता है।',
  'Thermometer, nidan nahi. Yeh aaj ko padhta hai.',
  'Like checking whether the lights are on in every room, right now.',
  'यह देखने जैसा कि अभी हर कमरे में बत्ती जल रही है या नहीं।',
  'Yeh dekhne jaisa ki abhi har kamre mein batti jal rahi hai ya nahi.',
  'A house at dusk, all windows lit'

  UNION ALL SELECT 22,
  'Not hating the fog. Not missing the light.',
  'धुंध से नफ़रत नहीं। रोशनी की याद नहीं।',
  'Dhundh se nafrat nahi. Roshni ki yaad nahi.',
  'Like weather you have stopped arguing with. It still rains.',
  'उस मौसम जैसा जिससे आपने बहस करना छोड़ दिया। बारिश फिर भी होती है।',
  'Us mausam jaisa jisse tumne behes karna chhod diya. Baarish phir bhi hoti hai.',
  'An umbrella, unopened, held loosely'

  UNION ALL SELECT 23,
  'LIKE somebody uninvolved. The suffix is the whole verse.',
  'उदासीन जैसा। प्रत्यय ही पूरा श्लोक है।',
  'Udaseen jaisa. Pratyay hi poora shloka hai.',
  'Like a nurse on a night shift. Calm is not the same as absent.',
  'रात की पाली वाली नर्स जैसा। शांत होना ग़ैरहाज़िर होना नहीं है।',
  'Raat ki paali wali nurse jaisa. Shaant hona gairhazir hona nahi hai.',
  'A steady hand on a rail'

  UNION ALL SELECT 26,
  'Not fighting the settings. Attention that does not wander.',
  'अवस्थाओं से लड़ना नहीं। वह ध्यान जो भटकता नहीं।',
  'Avasthaon se ladna nahi. Woh dhyan jo bhatakta nahi.',
  'Like walking past an argument you are not in. Nothing had to be won.',
  'ऐसी बहस के पास से गुज़रने जैसा जिसमें आप हैं ही नहीं। कुछ जीतना नहीं था।',
  'Aisi behes ke paas se guzarne jaisa jisme tum ho hi nahi. Kuch jeetna nahi tha.',
  'A door passed, not opened'
) AS m
JOIN verses v ON v.verse_number = m.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 14;

INSERT INTO verse_reflections (verse_id, question_en, question_hi, question_hinglish, display_order)
SELECT v.id, r.q_en, r.q_hi, r.q_hing, r.ord FROM (
  SELECT 5 AS vn, 'Think of one day this week in each of the three. Most people can find all three.' AS q_en, 'इस हफ़्ते का एक-एक दिन तीनों में से हर एक के लिए सोचिए। ज़्यादातर लोग तीनों निकाल लेते हैं।' AS q_hi, 'Is hafte ka ek-ek din teenon mein se har ek ke liye socho. Zyadatar log teenon nikaal lete hain.' AS q_hing, 1 AS ord
  UNION ALL SELECT 5, 'Have you ever been called one of these by somebody who meant it about you?', 'क्या कभी किसी ने आपको इनमें से कोई कहा है और उसका मतलब आपसे था?', 'Kya kabhi kisi ne tumhe inme se koi kaha hai aur uska matlab tumse tha?', 2
  UNION ALL SELECT 5, 'All three bind. Does that change what you were expecting from this chapter?', 'तीनों बाँधती हैं। क्या इससे वह बदलता है जिसकी आप इस अध्याय से उम्मीद कर रहे थे?', 'Teenon baandhti hain. Kya isse woh badalta hai jiski tum is adhyay se ummeed kar rahe the?', 3
  UNION ALL SELECT 6, 'Where does understanding something well leave you a little pleased with yourself?', 'किसी चीज़ को अच्छे से समझ लेना कहाँ आपको अपने पर थोड़ा ख़ुश छोड़ जाता है?', 'Kisi cheez ko achhe se samajh lena kahan tumhe apne par thoda khush chhod jaata hai?', 1
  UNION ALL SELECT 6, 'Is there a good state you have started trying to hold onto?', 'कोई अच्छी हालत है जिसे आपने थामे रखने की कोशिश शुरू कर दी है?', 'Koi achhi haalat hai jise tumne thaame rakhne ki koshish shuru kar di hai?', 2
  UNION ALL SELECT 6, 'The clear one does not hurt. Is that why it is harder to notice as a rope?', 'साफ़ वाली चुभती नहीं। क्या इसीलिए उसे रस्सी की तरह देखना ज़्यादा मुश्किल है?', 'Saaf wali chubhti nahi. Kya isiliye use rassi ki tarah dekhna zyada mushkil hai?', 3
  UNION ALL SELECT 7, 'When did you last stop doing things for an hour without earning it first?', 'पिछली बार आपने कब एक घंटा कुछ करना बंद किया बिना उसे पहले कमाए?', 'Pichhli baar tumne kab ek ghanta kuch karna band kiya bina use pehle kamaye?', 1
  UNION ALL SELECT 7, 'Is there something you keep doing that you have no result in mind for?', 'कोई ऐसी चीज़ है जो आप करते रहते हैं और जिसका कोई नतीजा आपके ज़ेहन में है ही नहीं?', 'Koi aisi cheez hai jo tum karte rehte ho aur jiska koi nateeja tumhare zehan mein hai hi nahi?', 2
  UNION ALL SELECT 7, 'What does stopping feel like to you? Not what does it cost — what does it feel like?', 'रुकना आपको कैसा लगता है? क्या ख़र्च होता है यह नहीं — कैसा लगता है?', 'Rukna tumhe kaisa lagta hai? Kya kharch hota hai yeh nahi — kaisa lagta hai?', 3
  UNION ALL SELECT 8, 'When something is unclear, can you usually tell that it is unclear?', 'जब कुछ साफ़ न हो, तो क्या आपको आमतौर पर यह पता चल जाता है कि वह साफ़ नहीं है?', 'Jab kuch saaf na ho, to kya tumhe aam taur par yeh pata chal jaata hai ki woh saaf nahi hai?', 1
  UNION ALL SELECT 8, 'The chapter says these take turns. What was running yesterday morning?', 'अध्याय कहता है कि ये बारी-बारी आती हैं। कल सुबह कौन-सी चल रही थी?', 'Adhyay kehta hai ki yeh baari-baari aati hain. Kal subah kaun si chal rahi thi?', 2
  UNION ALL SELECT 8, 'If you read this verse as being about you, what would you say to a friend who did?', 'अगर आपने इस श्लोक को अपने बारे में पढ़ा, तो जिस दोस्त ने ऐसा किया हो उससे आप क्या कहेंगे?', 'Agar tumne is shloka ko apne baare mein padha, to jis dost ne aisa kiya ho usse tum kya kahoge?', 3
  UNION ALL SELECT 11, 'Right now, is there light in all the gates or only in some of them?', 'अभी, क्या सारे दरवाज़ों पर रोशनी है या सिर्फ़ कुछ पर?', 'Abhi, kya saare darwazon par roshni hai ya sirf kuch par?', 1
  UNION ALL SELECT 11, 'When was the last afternoon where things were simply being seen?', 'पिछली बार वह दोपहर कब थी जब चीज़ें बस दिख रही थीं?', 'Pichhli baar woh dopahar kab thi jab cheezein bas dikh rahi thin?', 2
  UNION ALL SELECT 11, 'A thermometer reads now. Does that feel different from being told what you are?', 'थर्मामीटर अभी को पढ़ता है। क्या यह उससे अलग लगता है कि आपको बताया जाए कि आप क्या हैं?', 'Thermometer abhi ko padhta hai. Kya yeh usse alag lagta hai ki tumhe bataya jaaye ki tum kya ho?', 3
  UNION ALL SELECT 22, 'Which of the three do you fight when it turns up?', 'तीनों में से किससे आप भिड़ जाते हैं जब वह आती है?', 'Teenon mein se kisse tum bhid jaate ho jab woh aati hai?', 1
  UNION ALL SELECT 22, 'How much of a dull afternoon is the afternoon, and how much is arguing with it?', 'किसी सुस्त दोपहर में कितना दोपहर है और कितना उससे बहस करना है?', 'Kisi sust dopahar mein kitna dopahar hai aur kitna usse behes karna hai?', 2
  UNION ALL SELECT 22, 'Do you measure today against your best day? What would stopping cost?', 'क्या आप आज को अपने सबसे अच्छे दिन से नापते हैं? रुक जाने में क्या जाएगा?', 'Kya tum aaj ko apne sabse achhe din se naapte ho? Ruk jaane mein kya jayega?', 3
  UNION ALL SELECT 23, 'Do you know somebody who is calm without being absent? What do they do?', 'क्या आप किसी ऐसे को जानते हैं जो शांत है और ग़ैरहाज़िर नहीं? वह करता क्या है?', 'Kya tum kisi aise ko jaante ho jo shaant hai aur gairhazir nahi? Woh karta kya hai?', 1
  UNION ALL SELECT 23, 'The word is "like". What changes if you drop it?', 'शब्द है "जैसा"। इसे हटा दें तो क्या बदलता है?', 'Shabd hai "jaisa". Ise hata do to kya badalta hai?', 2
  UNION ALL SELECT 23, 'Where have you used steadiness as a way of not being there?', 'आपने कहाँ ठहराव को वहाँ न होने के तरीक़े की तरह इस्तेमाल किया है?', 'Tumne kahan thehrav ko wahan na hone ke tareeke ki tarah istemaal kiya hai?', 3
  UNION ALL SELECT 26, 'Where does your attention go when nothing is asking for it?', 'जब कोई आपका ध्यान नहीं माँग रहा होता, तब वह कहाँ चला जाता है?', 'Jab koi tumhara dhyan nahi maang raha hota, tab woh kahan chala jaata hai?', 1
  UNION ALL SELECT 26, 'Is there one thing you have stayed with, without wandering, for years?', 'कोई एक चीज़ है जिसके साथ आप सालों से बिना भटके बने रहे हैं?', 'Koi ek cheez hai jiske saath tum saalon se bina bhatke bane rahe ho?', 2
  UNION ALL SELECT 26, 'The frame here is not everybody''s. What in the verse survives without it?', 'यहाँ का ढाँचा हर किसी का नहीं है। श्लोक में उसके बिना क्या बचता है?', 'Yahan ka dhaancha har kisi ka nahi hai. Shloka mein uske bina kya bachta hai?', 3
) AS r
JOIN verses v ON v.verse_number = r.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 14;

INSERT INTO verse_practices (verse_id, action_en, action_hi, action_hinglish, estimated_minutes, difficulty, display_order)
SELECT v.id, p.a_en, p.a_hi, p.a_hing, p.mins, p.diff, 1 FROM (
  SELECT 5 AS vn, 'Write down three moments from this week, one in each setting. Use times of day, not adjectives about yourself.' AS a_en, 'इस हफ़्ते के तीन पल लिखिए, हर अवस्था का एक। दिन का समय लिखिए, अपने बारे में विशेषण नहीं।' AS a_hi, 'Is hafte ke teen pal likho, har avastha ka ek. Din ka samay likho, apne baare mein visheshan nahi.' AS a_hing, 6 AS mins, 'beginner' AS diff
  UNION ALL SELECT 6, 'Notice once today when explaining something to somebody felt good. Do not stop explaining. Just notice.', 'आज एक बार ध्यान दीजिए जब किसी को कुछ समझाना अच्छा लगा हो। समझाना बंद मत कीजिए। बस ध्यान दीजिए।', 'Aaj ek baar dhyan do jab kisi ko kuch samjhana achha laga ho. Samjhana band mat karo. Bas dhyan do.', 3, 'intermediate'
  UNION ALL SELECT 7, 'Take twenty minutes today in which you do nothing useful and have not earned it. Notice what wants to fill it.', 'आज बीस मिनट लीजिए जिनमें आप कोई काम की चीज़ न करें और जिन्हें आपने कमाया भी न हो। ध्यान दीजिए कि उन्हें भरना क्या चाहता है।', 'Aaj bees minute lo jinme tum koi kaam ki cheez na karo aur jinhe tumne kamaya bhi na ho. Dhyan do ki unhe bharna kya chahta hai.', 20, 'intermediate'
  UNION ALL SELECT 8, 'Next dull afternoon, write down what is happening and change nothing about it. The point is the noticing, not a fix.', 'अगली सुस्त दोपहर लिखिए कि क्या हो रहा है और उसमें कुछ मत बदलिए। बात ध्यान देने की है, ठीक करने की नहीं।', 'Agli sust dopahar likho ki kya ho raha hai aur usme kuch mat badlo. Baat dhyan dene ki hai, theek karne ki nahi.', 4, 'beginner'
  UNION ALL SELECT 11, 'Once today, stop and check all the gates: what can you actually see, hear and follow right now? Then carry on.', 'आज एक बार रुककर सारे दरवाज़े जाँचिए: अभी आप सचमुच क्या देख, सुन और समझ पा रहे हैं? फिर आगे बढ़िए।', 'Aaj ek baar rukkar saare darwaze jaancho: abhi tum sach mein kya dekh, sun aur samajh pa rahe ho? Phir aage badho.', 2, 'beginner'
  UNION ALL SELECT 22, 'The next time a dull stretch arrives, do not fight it for one hour. Notice how much of the tiredness was the fight.', 'अगली बार जब कोई सुस्त दौर आए, एक घंटे उससे मत भिड़िए। देखिए कि थकान का कितना हिस्सा वह भिड़ना था।', 'Agli baar jab koi sust daur aaye, ek ghante usse mat bhido. Dekho ki thakan ka kitna hissa woh bhidna tha.', 60, 'intermediate'
  UNION ALL SELECT 23, 'Pick one person you have been steady around. Ask yourself whether steady meant present or meant away.', 'ऐसा एक इंसान चुनिए जिसके आसपास आप ठहरे हुए रहे हैं। ख़ुद से पूछिए कि ठहरे होने का मतलब मौजूद होना था या दूर होना।', 'Aisa ek insan chuno jiske aas paas tum thehre hue rahe ho. Khud se poocho ki thehre hone ka matlab maujood hona tha ya door hona.', 8, 'intermediate'
  UNION ALL SELECT 26, 'Name one thing your attention returns to on its own. Give it fifteen unhurried minutes this week.', 'एक चीज़ बताइए जिस पर आपका ध्यान अपने आप लौटता है। इस हफ़्ते उसे बिना जल्दबाज़ी पंद्रह मिनट दीजिए।', 'Ek cheez batao jis par tumhara dhyan apne aap lautta hai. Is hafte use bina jaldbaazi pandrah minute do.', 15, 'beginner'
) AS p
JOIN verses v ON v.verse_number = p.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 14;

INSERT INTO verse_topics (verse_id, topic_id, relevance)
SELECT v.id, t.id, x.rel FROM (
  SELECT 5 AS vn, 'the-self' AS slug, 10 AS rel
  UNION ALL SELECT 5, 'impermanence', 8
  UNION ALL SELECT 5, 'comparison', 7
  UNION ALL SELECT 6, 'comparison', 9
  UNION ALL SELECT 6, 'the-self', 8
  UNION ALL SELECT 6, 'desire', 7
  UNION ALL SELECT 7, 'restlessness', 10
  UNION ALL SELECT 7, 'desire', 9
  UNION ALL SELECT 7, 'burnout', 8
  UNION ALL SELECT 7, 'action-without-attachment', 7
  UNION ALL SELECT 8, 'burnout', 10
  UNION ALL SELECT 8, 'restlessness', 7
  UNION ALL SELECT 8, 'grief', 6
  UNION ALL SELECT 11, 'steadiness', 9
  UNION ALL SELECT 11, 'the-self', 7
  UNION ALL SELECT 11, 'impermanence', 6
  UNION ALL SELECT 22, 'steadiness', 10
  UNION ALL SELECT 22, 'impermanence', 9
  UNION ALL SELECT 22, 'burnout', 7
  UNION ALL SELECT 22, 'comparison', 6
  UNION ALL SELECT 23, 'steadiness', 10
  UNION ALL SELECT 23, 'action-without-attachment', 8
  UNION ALL SELECT 23, 'the-self', 7
  UNION ALL SELECT 26, 'steadiness', 8
  UNION ALL SELECT 26, 'restlessness', 7
  UNION ALL SELECT 26, 'duty', 6
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 14
JOIN topics t ON t.slug = x.slug;

-- =====================================================================
-- 4. MODERN EXAMPLES
-- =====================================================================
-- Four per verse, four distinct categories per verse, THIRTY-TWO total.
--
-- NOT ONE EXAMPLE IN THIS FILE DESCRIBES A PERSON AS BEING ONE OF THE
-- THREE. Every one of them describes a stretch of time — an afternoon,
-- a fortnight, a Tuesday — and several show the same person in two
-- different settings, because that is what 14.10 says actually happens.
--
-- THE 14.8 SET SEPARATES NOT-SEEING FROM BEING TIRED
--   In every one of the four, somebody is either exhausted and can see
--   it perfectly well (which is NOT what the verse describes), or
--   cannot see something and is not tired at all. No example treats
--   rest, sleep or a slow week as a fault.
--
-- IN ALL FOUR OF THE 14.23 EXAMPLES THE PERSON IS STEADY AND PRESENT AT
-- ONCE, because a set where steadiness looked like withdrawal would
-- teach the reading the gloss on udāsīna-vat exists to refuse.
-- =====================================================================

DELETE e FROM modern_examples e JOIN verses v ON v.id = e.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 14;

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

  SELECT 5 AS vn, 'everyday_life' AS cat, 1 AS ord,
  'One Saturday, three people' AS t_en, 'एक शनिवार, तीन लोग' AS t_hi, 'Ek Saturday, teen log' AS t_hing,
  'The same person, one Saturday. At nine they read for an hour and follow all of it. At two they reorganise a cupboard nobody asked about and cannot sit down. At six they are on the sofa and could not tell you what is on the screen. Nothing went wrong at any point in the day.' AS s_en,
  'वही इंसान, एक शनिवार। नौ बजे वह घंटा भर पढ़ता है और सब समझ में आता है। दो बजे वह एक अलमारी ठीक कर रहा है जिसके बारे में किसी ने कहा नहीं था और बैठ नहीं पा रहा। छह बजे वह सोफ़े पर है और आपको बता नहीं सकता कि स्क्रीन पर क्या चल रहा है। दिन में कहीं कुछ ग़लत नहीं हुआ।' AS s_hi,
  'Wahi insan, ek Saturday. Nau baje woh ghanta bhar padhta hai aur sab samajh mein aata hai. Do baje woh ek almari theek kar raha hai jiske baare mein kisi ne kaha nahi tha aur baith nahi pa raha. Chhah baje woh sofe par hai aur tumhe bata nahi sakta ki screen par kya chal raha hai. Din mein kahin kuch galat nahi hua.' AS s_hing,
  'This is the chapter''s own argument against being used as a taxonomy of people. 14.10 says the three take turns, each rising by putting the other two down. Here that happens in nine hours to one person, and there is no honest way to say which of the three he is.' AS c_en,
  'यह ख़ुद अध्याय की दलील है कि उसे लोगों की श्रेणियाँ बनाने के लिए इस्तेमाल न किया जाए। 14.10 कहता है कि तीनों बारी-बारी आती हैं, हर एक बाक़ी दो को दबाकर उठती है। यहाँ यह एक ही इंसान के साथ नौ घंटे में हो जाता है, और यह कहने का कोई ईमानदार तरीक़ा नहीं है कि वह तीनों में से क्या है।' AS c_hi,
  'Yeh khud adhyay ki dalil hai ki use logon ki shreniyan banane ke liye istemaal na kiya jaaye. 14.10 kehta hai ki teenon baari-baari aati hain, har ek baaki do ko dabakar uthti hai. Yahan yeh ek hi insan ke saath nau ghante mein ho jaata hai, aur yeh kehne ka koi imaandaar tareeka nahi hai ki woh teenon mein se kya hai.' AS c_hing,
  'Three settings in nine hours, one person. That is what the chapter says happens.' AS l_en,
  'नौ घंटे में तीन अवस्थाएँ, एक इंसान। अध्याय कहता है कि यही होता है।' AS l_hi,
  'Nau ghante mein teen avasthayein, ek insan. Adhyay kehta hai ki yahi hota hai.' AS l_hing,
  NULL AS src, 'beginner' AS diff, 'days,states,turns,noticing' AS tags

  UNION ALL SELECT 5, 'corporate', 2,
  'The person they called difficult', 'जिसे उन्होंने मुश्किल कहा', 'Jise unhone mushkil kaha',
  'A team decides somebody is "just negative" after a run of hard months for that person. Two quarters later, on a different project, the same person is the one everybody goes to. Nothing about them was fixed and nobody apologised, because nobody had noticed making the judgement in the first place.',
  'एक टीम किसी के कई मुश्किल महीनों के बाद तय कर लेती है कि वह "बस नकारात्मक" है। दो तिमाही बाद, किसी और प्रोजेक्ट पर, वही इंसान वह है जिसके पास सब जाते हैं। उसमें कुछ ठीक नहीं किया गया और किसी ने माफ़ी नहीं माँगी, क्योंकि पहले वह फ़ैसला करते हुए किसी ने ध्यान ही नहीं दिया था।',
  'Ek team kisi ke kai mushkil mahinon ke baad tay kar leti hai ki woh "bas nakaratmak" hai. Do quarter baad, kisi aur project par, wahi insan woh hai jiske paas sab jaate hain. Usme kuch theek nahi kiya gaya aur kisi ne maafi nahi maangi, kyunki pehle woh faisla karte hue kisi ne dhyan hi nahi diya tha.',
  'This is exactly the misuse. A setting that was running for a few months became a description of a person, and it took two quarters of contrary evidence to quietly dissolve. The chapter has a word for the states and no word at all for the kind of person, and that absence is deliberate.',
  'यही वह दुरुपयोग है। कुछ महीने चलती रही एक अवस्था इंसान का वर्णन बन गई, और उसे चुपचाप घुलने में दो तिमाही के उलटे सबूत लगे। अध्याय के पास अवस्थाओं के लिए शब्द है और उस "क़िस्म के इंसान" के लिए कोई शब्द है ही नहीं, और यह ग़ैरहाज़िरी जानबूझकर है।',
  'Yahi woh durupyog hai. Kuch mahine chalti rahi ek avastha insan ka varnan ban gayi, aur use chupchap ghulne mein do quarter ke ulte saboot lage. Adhyay ke paas avasthaon ke liye shabd hai aur us "kism ke insan" ke liye koi shabd hai hi nahi, aur yeh gairhazri jaanboojhkar hai.',
  'The chapter has a word for the state and none for the kind of person.',
  'अध्याय के पास अवस्था के लिए शब्द है, "क़िस्म के इंसान" के लिए कोई नहीं।',
  'Adhyay ke paas avastha ke liye shabd hai, "kism ke insan" ke liye koi nahi.',
  NULL, 'intermediate', 'work,labels,judgement,teams'

  UNION ALL SELECT 5, 'sports', 3,
  'Form is not character', 'फ़ॉर्म चरित्र नहीं है', 'Form charitra nahi hai',
  'A batter has a bad six months and the word around the game becomes that he lacks temperament. He then has an excellent eighteen months. Both stretches are real and neither of them is a fact about his temperament, which nobody measured at any point.',
  'एक बल्लेबाज़ के छह महीने ख़राब जाते हैं और खेल में बात यह चलने लगती है कि उसमें मिज़ाज की कमी है। फिर उसके अठारह महीने बेहतरीन जाते हैं। दोनों दौर असली हैं और दोनों में से कोई भी उसके मिज़ाज के बारे में तथ्य नहीं है, जिसे किसी ने कभी नापा ही नहीं।',
  'Ek ballebaaz ke chhah mahine kharab jaate hain aur khel mein baat yeh chalne lagti hai ki usme mizaaj ki kami hai. Phir uske atharah mahine behtareen jaate hain. Dono daur asli hain aur dono mein se koi bhi uske mizaaj ke baare mein tathya nahi hai, jise kisi ne kabhi naapa hi nahi.',
  'The guṇas describe what is running, and form is the ordinary English word for the same idea. Nobody watching sport seriously confuses a bad six months with a permanent fact — and the chapter is asking for exactly that ordinary care to be extended to whole people rather than only to their output.',
  'गुण बताते हैं कि क्या चल रहा है, और "फ़ॉर्म" उसी ख़याल का रोज़मर्रा शब्द है। खेल को गंभीरता से देखने वाला कोई भी ख़राब छह महीनों को स्थायी तथ्य नहीं समझ बैठता — और अध्याय यही आम एहतियात माँग रहा है, सिर्फ़ किसी के प्रदर्शन के लिए नहीं, पूरे इंसान के लिए।',
  'Gun batate hain ki kya chal raha hai, aur "form" usi khayal ka rozmarra shabd hai. Khel ko gambhirta se dekhne wala koi bhi kharab chhah mahinon ko sthayi tathya nahi samajh baithta — aur adhyay yahi aam ehtiyat maang raha hai, sirf kisi ke pradarshan ke liye nahi, poore insan ke liye.',
  'Nobody confuses a bad six months with a permanent fact. The chapter asks for that everywhere.',
  'ख़राब छह महीनों को स्थायी तथ्य कोई नहीं समझता। अध्याय यही एहतियात हर जगह माँगता है।',
  'Kharab chhah mahinon ko sthayi tathya koi nahi samajhta. Adhyay yahi ehtiyat har jagah maangta hai.',
  NULL, 'beginner', 'sport,form,labels,temperament'

  UNION ALL SELECT 5, 'healthcare', 4,
  'Four nights and then two days off', 'चार रातें और फिर दो दिन की छुट्टी', 'Chaar raatein aur phir do din ki chhutti',
  'A nurse on the fourth night of a run is slow, short with people and cannot hold a thread. Forty hours later she is the calmest person on the ward. Nothing about her changed. The rota did.',
  'लगातार चौथी रात की पाली में एक नर्स धीमी है, लोगों से रूखी है और कोई बात पकड़ नहीं पा रही। चालीस घंटे बाद वह वार्ड की सबसे शांत इंसान है। उसमें कुछ नहीं बदला। रोस्टर बदला।',
  'Lagataar chauthi raat ki paali mein ek nurse dheemi hai, logon se rookhi hai aur koi baat pakad nahi pa rahi. Chalees ghante baad woh ward ki sabse shaant insan hai. Usme kuch nahi badla. Roster badla.',
  'The verse says these come out of prakṛti — the material a person is made of and is standing in — rather than out of a decision they took. Forty hours and a different rota is about as clear a demonstration as anybody could ask for, and it also removes any question of blame.',
  'श्लोक कहता है कि ये प्रकृति से निकलती हैं — उस सामग्री से जिससे इंसान बना है और जिसमें वह खड़ा है — किसी लिए हुए फ़ैसले से नहीं। चालीस घंटे और एक बदला हुआ रोस्टर इसका जितना साफ़ सबूत हो सकता है उतना है, और यह दोष का सवाल भी हटा देता है।',
  'Shloka kehta hai ki yeh prakriti se nikalti hain — us samagri se jisse insan bana hai aur jisme woh khada hai — kisi liye hue faisle se nahi. Chalees ghante aur ek badla hua roster iska jitna saaf saboot ho sakta hai utna hai, aur yeh dosh ka sawal bhi hata deta hai.',
  'Nothing about her changed. The rota did.',
  'उसमें कुछ नहीं बदला। रोस्टर बदला।',
  'Usme kuch nahi badla. Roster badla.',
  NULL, 'beginner', 'shift-work,fatigue,conditions,blame'

  UNION ALL SELECT 6, 'college', 1,
  'He knew the framework very well', 'उसे ढाँचा बहुत अच्छे से आता था', 'Use dhaancha bahut achhe se aata tha',
  'A student learns the three guṇas properly and begins classifying everybody around him within a week — that lecturer is rajasic, that flatmate is tamasic. He enjoys this a great deal. He is six verses into the chapter that describes what he is doing.',
  'एक छात्र तीनों गुण ठीक से सीख लेता है और हफ़्ते भर में अपने आसपास सबको श्रेणियों में बाँटने लगता है — वह प्रोफ़ेसर राजसिक है, वह फ़्लैटमेट तामसिक। उसे इसमें बहुत मज़ा आता है। वह उसी अध्याय के छह श्लोक अंदर है जो उसके इस काम का वर्णन करता है।',
  'Ek student teenon gun theek se seekh leta hai aur hafte bhar mein apne aas paas sabko shreniyon mein baantne lagta hai — woh professor rajasik hai, woh flatmate tamasik. Use isme bahut maza aata hai. Woh usi adhyay ke chhah shloka andar hai jo uske is kaam ka varnan karta hai.',
  'Jñāna-saṅga, attachment to knowing, described in verse 6 of the chapter he is using to do it. The verse is not against understanding the guṇas. It is saying that being pleased with how well you understand them is one of the two ropes sattva ties with, and this one is hard to spot because it looks like progress.',
  'ज्ञान-सङ्ग, जानने से चिपकना, उसी अध्याय के छठे श्लोक में वर्णित जिससे वह यह कर रहा है। श्लोक गुणों को समझने के ख़िलाफ़ नहीं है। वह कह रहा है कि आप उन्हें कितना अच्छा समझते हैं, इस पर ख़ुश होना सत्त्व की दो रस्सियों में से एक है, और इसे पकड़ना मुश्किल है क्योंकि यह तरक़्क़ी जैसी दिखती है।',
  'Gyan-sang, jaanne se chipakna, usi adhyay ke chhathe shloka mein varnit jisse woh yeh kar raha hai. Shloka gunon ko samajhne ke khilaf nahi hai. Woh keh raha hai ki tum unhe kitna achha samajhte ho, is par khush hona sattva ki do rassiyon mein se ek hai, aur ise pakadna mushkil hai kyunki yeh tarakki jaisi dikhti hai.',
  'The chapter describes him doing it, six verses in, while he does it.',
  'अध्याय छह श्लोक के भीतर ही, उसे यह करते हुए, उसका वर्णन कर देता है।',
  'Adhyay chhah shloka ke bheetar hi, use yeh karte hue, uska varnan kar deta hai.',
  NULL, 'intermediate', 'students,frameworks,cleverness,self-awareness'

  UNION ALL SELECT 6, 'corporate', 2,
  'The quarter that went well', 'वह तिमाही जो अच्छी गई', 'Woh quarter jo achhi gayi',
  'A team has an unusually good quarter — clear priorities, no firefighting, everybody rested. By week three of the next quarter they are anxious, because they have started measuring against it and nothing since has matched.',
  'एक टीम की तिमाही असामान्य रूप से अच्छी जाती है — प्राथमिकताएँ साफ़, कोई आग बुझाना नहीं, सब आराम में। अगली तिमाही के तीसरे हफ़्ते तक वे बेचैन हैं, क्योंकि उन्होंने उससे नापना शुरू कर दिया है और उसके बाद कुछ भी उतना नहीं हुआ।',
  'Ek team ki quarter asamanya roop se achhi jaati hai — prathmiktayein saaf, koi aag bujhana nahi, sab aaram mein. Agli quarter ke teesre hafte tak woh bechain hain, kyunki unhone usse naapna shuru kar diya hai aur uske baad kuch bhi utna nahi hua.',
  'Sukha-saṅga — attachment to feeling good — and it is the other rope. Nothing was wrong with the good quarter. What binds is the grip that formed afterwards, and 14.22 will name the same thing from the other side: not longing for the light when it has gone.',
  'सुख-सङ्ग — अच्छा महसूस होने से चिपकना — और यही दूसरी रस्सी है। अच्छी तिमाही में कुछ ग़लत नहीं था। बाँधती है वह पकड़ जो बाद में बनी, और 14.22 उसी चीज़ का नाम दूसरी तरफ़ से लेगा: रोशनी के चले जाने पर उसे याद न करना।',
  'Sukha-sang — achha mehsoos hone se chipakna — aur yahi doosri rassi hai. Achhi quarter mein kuch galat nahi tha. Baandhti hai woh pakad jo baad mein bani, aur 14.22 usi cheez ka naam doosri taraf se lega: roshni ke chale jaane par use yaad na karna.',
  'Nothing was wrong with the good quarter. The grip formed afterwards.',
  'अच्छी तिमाही में कुछ ग़लत नहीं था। पकड़ बाद में बनी।',
  'Achhi quarter mein kuch galat nahi tha. Pakad baad mein bani.',
  NULL, 'intermediate', 'work,good-times,measuring,anxiety'

  UNION ALL SELECT 6, 'social_media', 3,
  'The stretch he kept posting about', 'वह दौर जिसके बारे में वह पोस्ट करता रहा', 'Woh daur jiske baare mein woh post karta raha',
  'Somebody has a genuinely clear few weeks — sleeping well, thinking straight, kind to people — and starts writing about it publicly. By the fourth post the writing is about having had it rather than about having it, and he can feel the difference and posts anyway.',
  'किसी के कुछ हफ़्ते सचमुच साफ़ जाते हैं — नींद अच्छी, सोच सीधी, लोगों से नरमी — और वह इस बारे में सार्वजनिक रूप से लिखने लगता है। चौथी पोस्ट तक लिखना इस बारे में है कि वह दौर था, न कि यह कि वह है, और उसे फ़र्क़ महसूस होता है और वह फिर भी पोस्ट करता है।',
  'Kisi ke kuch hafte sach mein saaf jaate hain — neend achhi, soch seedhi, logon se narmi — aur woh is baare mein saarvajanik roop se likhne lagta hai. Chauthi post tak likhna is baare mein hai ki woh daur tha, na ki yeh ki woh hai, aur use farq mehsoos hota hai aur woh phir bhi post karta hai.',
  'Both ropes at once, and the verse names both: attachment to the pleasant state, and attachment to being the person who understands it. Neither is a moral failure and the chapter does not treat them as one. They are just ropes, and they hold better than the harsh ones because nobody wants to cut them.',
  'दोनों रस्सियाँ एक साथ, और श्लोक दोनों का नाम लेता है: सुखद हालत से चिपकना, और उसे समझने वाला इंसान होने से चिपकना। कोई नैतिक चूक नहीं है और अध्याय इन्हें वैसे लेता भी नहीं। ये बस रस्सियाँ हैं, और कठोर वाली रस्सियों से बेहतर पकड़ती हैं क्योंकि इन्हें कोई काटना नहीं चाहता।',
  'Dono rassiyan ek saath, aur shloka dono ka naam leta hai: sukhad haalat se chipakna, aur use samajhne wala insan hone se chipakna. Koi naitik chook nahi hai aur adhyay inhe waise leta bhi nahi. Yeh bas rassiyan hain, aur kathor wali rassiyon se behtar pakadti hain kyunki inhe koi kaatna nahi chahta.',
  'These ropes hold better than the harsh ones, because nobody wants to cut them.',
  'ये रस्सियाँ कठोर वालों से बेहतर पकड़ती हैं, क्योंकि इन्हें कोई काटना नहीं चाहता।',
  'Yeh rassiyan kathor walon se behtar pakadti hain, kyunki inhe koi kaatna nahi chahta.',
  NULL, 'intermediate', 'social-media,good-states,holding-on,honesty'

  UNION ALL SELECT 6, 'everyday_life', 4,
  'The chair he stopped getting out of', 'वह कुर्सी जिससे उसने उठना बंद कर दिया', 'Woh kursi jisse usne uthna band kar diya',
  'Somebody finds a routine that works — the walk, the early hour, the notebook — and after two months will not travel, will not accept invitations that break it, and is short with anybody who suggests one. The routine is genuinely good and has become the only place he is well.',
  'किसी को एक ऐसा ढर्रा मिल जाता है जो चलता है — वह सैर, वह सुबह का वक़्त, वह कॉपी — और दो महीने बाद वह सफ़र नहीं करता, वे निमंत्रण नहीं लेता जो इसे तोड़ें, और सुझाव देने वाले किसी से भी रूखा हो जाता है। ढर्रा सचमुच अच्छा है और अब वही अकेली जगह है जहाँ वह ठीक रहता है।',
  'Kisi ko ek aisa dharra mil jaata hai jo chalta hai — woh sair, woh subah ka waqt, woh copy — aur do mahine baad woh safar nahi karta, woh nimantran nahi leta jo ise todein, aur sujhav dene wale kisi se bhi rookha ho jaata hai. Dharra sach mein achha hai aur ab wahi akeli jagah hai jahan woh theek rehta hai.',
  'The verse says the clear one is anāmaya — free of affliction — and binds anyway. This is what that looks like at home. The routine did nothing wrong and does not need to be given up. What has happened is that a good state acquired conditions, and the conditions are now running the week.',
  'श्लोक कहता है कि साफ़ वाली अनामय है — पीड़ा रहित — और फिर भी बाँधती है। घर में वह ऐसा दिखता है। ढर्रे ने कुछ ग़लत नहीं किया और उसे छोड़ना ज़रूरी नहीं। हुआ यह है कि एक अच्छी हालत ने शर्तें जुटा लीं, और अब हफ़्ता वही शर्तें चला रही हैं।',
  'Shloka kehta hai ki saaf wali anamay hai — peeda rahit — aur phir bhi baandhti hai. Ghar mein woh aisa dikhta hai. Dharre ne kuch galat nahi kiya aur use chhodna zaroori nahi. Hua yeh hai ki ek achhi haalat ne shartein juta leen, aur ab hafta wahi shartein chala rahi hain.',
  'A good state acquired conditions, and the conditions now run the week.',
  'एक अच्छी हालत ने शर्तें जुटा लीं, और अब हफ़्ता वही शर्तें चलाती हैं।',
  'Ek achhi haalat ne shartein juta leen, aur ab hafta wahi shartein chalati hain.',
  NULL, 'beginner', 'routine,rigidity,good-habits,conditions'

  UNION ALL SELECT 7, 'startup', 1,
  'Between funding rounds', 'दो फ़ंडिंग राउंड के बीच', 'Do funding round ke beech',
  'A founder closes a round and has, for the first time in four years, nothing urgent for eleven days. She finds a problem to solve on day two. It is a real problem and it did not need solving that week, and she knows both of those things while doing it.',
  'एक संस्थापक एक राउंड बंद करती है और चार साल में पहली बार, ग्यारह दिन तक कुछ भी तत्काल नहीं है। दूसरे दिन उसे हल करने के लिए एक समस्या मिल जाती है। समस्या असली है और उसे उस हफ़्ते हल करने की ज़रूरत नहीं थी, और यह दोनों बातें उसे करते हुए पता हैं।',
  'Ek sansthapak ek round band karti hai aur chaar saal mein pehli baar, gyarah din tak kuch bhi tatkal nahi hai. Doosre din use hal karne ke liye ek samasya mil jaati hai. Samasya asli hai aur use us hafte hal karne ki zaroorat nahi thi, aur yeh dono baatein use karte hue pata hain.',
  'Karma-saṅga, attachment to the doing itself. Chapter 2 dealt with attachment to results and everybody remembers that one; this is a different rope. She was not chasing an outcome. She could not tolerate the absence of a task, which is a much stranger and more common thing.',
  'कर्म-सङ्ग, ख़ुद करने से चिपकना। दूसरा अध्याय नतीजों से चिपकने पर था और वह सबको याद है; यह अलग रस्सी है। वह किसी नतीजे के पीछे नहीं थी। वह काम की ग़ैरहाज़िरी बर्दाश्त नहीं कर पा रही थी, जो कहीं ज़्यादा अजीब और कहीं ज़्यादा आम बात है।',
  'Karma-sang, khud karne se chipakna. Doosra adhyay nateejon se chipakne par tha aur woh sabko yaad hai; yeh alag rassi hai. Woh kisi nateeje ke peechhe nahi thi. Woh kaam ki gairhazri bardasht nahi kar pa rahi thi, jo kahin zyada ajeeb aur kahin zyada aam baat hai.',
  'She was not chasing an outcome. She could not tolerate the absence of a task.',
  'वह किसी नतीजे के पीछे नहीं थी। वह काम का न होना बर्दाश्त नहीं कर पा रही थी।',
  'Woh kisi nateeje ke peechhe nahi thi. Woh kaam ka na hona bardasht nahi kar pa rahi thi.',
  NULL, 'intermediate', 'startups,busyness,rest,compulsion'

  UNION ALL SELECT 7, 'corporate', 2,
  'The meeting that did not need to exist', 'वह मीटिंग जिसका होना ज़रूरी नहीं था', 'Woh meeting jiska hona zaroori nahi tha',
  'A weekly sync survives eight months after the project it was for ended. Nobody defends it and nobody cancels it. Asked why they attend, four separate people give four different answers and none of them is about the project.',
  'एक साप्ताहिक बैठक उस प्रोजेक्ट के ख़त्म होने के आठ महीने बाद तक चलती रहती है जिसके लिए वह थी। कोई उसका बचाव नहीं करता और कोई उसे रद्द नहीं करता। पूछने पर कि वे आते क्यों हैं, चार अलग लोग चार अलग जवाब देते हैं और उनमें से कोई भी प्रोजेक्ट के बारे में नहीं है।',
  'Ek saptahik baithak us project ke khatam hone ke aath mahine baad tak chalti rehti hai jiske liye woh thi. Koi uska bachav nahi karta aur koi use radd nahi karta. Poochhne par ki woh aate kyun hain, chaar alag log chaar alag jawab dete hain aur unme se koi bhi project ke baare mein nahi hai.',
  'Rajas is described as coming out of tṛṣṇā — thirst — and binding through attachment to activity. An organisation can run this rope as easily as a person can. The meeting is not producing anything and is also not being stopped, and both facts have the same cause.',
  'रजस् का वर्णन तृष्णा से उठने वाली और कर्म से चिपकाकर बाँधने वाली अवस्था के तौर पर है। यह रस्सी संस्था उतनी ही आसानी से चला सकती है जितनी कोई इंसान। बैठक कुछ पैदा नहीं कर रही और रोकी भी नहीं जा रही, और दोनों बातों की वजह एक ही है।',
  'Rajas ka varnan trishna se uthne wali aur karm se chipkakar baandhne wali avastha ke taur par hai. Yeh rassi sanstha utni hi aasani se chala sakti hai jitni koi insan. Baithak kuch paida nahi kar rahi aur roki bhi nahi ja rahi, aur dono baaton ki wajah ek hi hai.',
  'It produces nothing and is not stopped. Both facts have the same cause.',
  'वह कुछ पैदा नहीं करती और रोकी भी नहीं जाती। दोनों बातों की वजह एक ही है।',
  'Woh kuch paida nahi karti aur roki bhi nahi jaati. Dono baaton ki wajah ek hi hai.',
  NULL, 'beginner', 'work,meetings,momentum,busyness'

  UNION ALL SELECT 7, 'everyday_life', 3,
  'Sunday afternoon', 'रविवार की दोपहर', 'Sunday ki dopahar',
  'Somebody sits down on a Sunday with nothing to do and is up again within nine minutes, having found a drawer. He is not behind on anything. There is no deadline. He simply could not stay in the chair.',
  'कोई रविवार को बिना किसी काम के बैठता है और नौ मिनट के भीतर उठ खड़ा होता है, उसे एक दराज़ मिल गई है। वह किसी चीज़ में पीछे नहीं है। कोई तारीख़ सिर पर नहीं है। वह बस कुर्सी में टिक नहीं पाया।',
  'Koi Sunday ko bina kisi kaam ke baithta hai aur nau minute ke bheetar uth khada hota hai, use ek daraz mil gayi hai. Woh kisi cheez mein peechhe nahi hai. Koi tareekh sir par nahi hai. Woh bas kursi mein tik nahi paya.',
  'Nine minutes is the useful number. The verse describes a rope rather than a fault, and a rope can be measured — most people have never checked how long they can sit with nothing to do before something is found to do.',
  'नौ मिनट काम का आँकड़ा है। श्लोक किसी ख़ामी का नहीं, एक रस्सी का वर्णन करता है, और रस्सी नापी जा सकती है — ज़्यादातर लोगों ने कभी जाँचा ही नहीं कि वे बिना किसी काम के कितनी देर बैठ सकते हैं इससे पहले कि करने को कुछ मिल जाए।',
  'Nau minute kaam ka aankda hai. Shloka kisi khaami ka nahi, ek rassi ka varnan karta hai, aur rassi naapi ja sakti hai — zyadatar logon ne kabhi jaancha hi nahi ki woh bina kisi kaam ke kitni der baith sakte hain isse pehle ki karne ko kuch mil jaaye.',
  'Nine minutes. Most people have never checked their own number.',
  'नौ मिनट। ज़्यादातर लोगों ने अपना आँकड़ा कभी जाँचा ही नहीं।',
  'Nau minute. Zyadatar logon ne apna aankda kabhi jaancha hi nahi.',
  NULL, 'beginner', 'rest,restlessness,sundays,measuring'

  UNION ALL SELECT 7, 'parenting', 4,
  'The holiday that got organised', 'वह छुट्टी जो इंतज़ाम बन गई', 'Woh chhutti jo intezaam ban gayi',
  'A parent plans a week away carefully so everybody can rest, and by day three has built a schedule for it. The children are having a good time. The parent has not sat down since Tuesday and cannot say what would happen if she did.',
  'एक अभिभावक हफ़्ते भर की छुट्टी ध्यान से बनाती है ताकि सब आराम कर सकें, और तीसरे दिन तक उसके लिए एक कार्यक्रम बना डालती है। बच्चों का वक़्त अच्छा गुज़र रहा है। अभिभावक मंगलवार से बैठी नहीं है और बता नहीं सकती कि बैठ जाए तो क्या होगा।',
  'Ek abhibhavak hafte bhar ki chhutti dhyan se banati hai taaki sab aaram kar sakein, aur teesre din tak uske liye ek karyakram bana daalti hai. Bachchon ka waqt achha guzar raha hai. Abhibhavak Tuesday se baithi nahi hai aur bata nahi sakti ki baith jaaye to kya hoga.',
  'The verse would not call the planning wrong and neither would the children. What it names is that the doing has a grip of its own, which is why a week designed for rest can be filled by the same person who designed it, without any of it being a decision.',
  'श्लोक योजना को ग़लत नहीं कहेगा और बच्चे भी नहीं कहेंगे। वह जिस चीज़ का नाम लेता है वह यह है कि करने की अपनी एक पकड़ होती है, और इसीलिए आराम के लिए बना हफ़्ता उसी इंसान से भर जाता है जिसने उसे बनाया था, और उसमें कुछ भी फ़ैसला नहीं होता।',
  'Shloka yojna ko galat nahi kahega aur bachche bhi nahi kahenge. Woh jis cheez ka naam leta hai woh yeh hai ki karne ki apni ek pakad hoti hai, aur isiliye aaram ke liye bana hafta usi insan se bhar jaata hai jisne use banaya tha, aur usme kuch bhi faisla nahi hota.',
  'A week designed for rest, filled by the person who designed it. None of it was a decision.',
  'आराम के लिए बना हफ़्ता, उसी से भर गया जिसने उसे बनाया था। उसमें कुछ भी फ़ैसला नहीं था।',
  'Aaram ke liye bana hafta, usi se bhar gaya jisne use banaya tha. Usme kuch bhi faisla nahi tha.',
  NULL, 'beginner', 'parenting,holidays,rest,planning'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 14;

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

  SELECT 8 AS vn, 'healthcare' AS cat, 1 AS ord,
  'Exhausted, and seeing it clearly' AS t_en, 'थकी हुई, और साफ़ देखती हुई' AS t_hi, 'Thaki hui, aur saaf dekhti hui' AS t_hing,
  'Somebody at the end of a very long stretch of caring for a relative is flattened — sleeping badly, doing the minimum, cancelling things. She can also describe exactly what is happening to her, why, and what would help. She is not confused about any of it.' AS s_en,
  'किसी रिश्तेदार की लंबे समय तक देखभाल करने के बाद कोई पूरी तरह चूर है — नींद ख़राब, कम से कम काम, चीज़ें रद्द। और वह ठीक-ठीक बता सकती है कि उसके साथ क्या हो रहा है, क्यों, और किससे मदद होगी। उसे इसमें से किसी बारे में कोई भ्रम नहीं है।' AS s_hi,
  'Kisi rishtedaar ki lambe samay tak dekhbhal karne ke baad koi poori tarah choor hai — neend kharab, kam se kam kaam, cheezein radd. Aur woh theek theek bata sakti hai ki uske saath kya ho raha hai, kyun, aur kisse madad hogi. Use isme se kisi baare mein koi bhram nahi hai.' AS s_hing,
  'This example is here to mark a boundary, and it is the most important one in the chapter. The verse defines tamas as ajñāna-ja, born of not-knowing — a state in which nothing is being seen. She sees all of it. Being exhausted is not what this verse describes, and the outward behaviour looking similar does not make it the same thing.' AS c_en,
  'यह उदाहरण एक सीमा खींचने के लिए है, और अध्याय में यही सबसे ज़रूरी सीमा है। श्लोक तमस् को अज्ञानज बताता है, न जानने से उपजा — ऐसी हालत जिसमें कुछ दिख ही नहीं रहा। उसे सब दिख रहा है। थका होना वह नहीं है जिसका यह श्लोक वर्णन करता है, और बाहर से बरताव मिलता-जुलता दिखने से वह वही चीज़ नहीं हो जाती।' AS c_hi,
  'Yeh udaharan ek seema kheenchne ke liye hai, aur adhyay mein yahi sabse zaroori seema hai. Shloka tamas ko agyan-ja batata hai, na jaanne se upja — aisi haalat jisme kuch dikh hi nahi raha. Use sab dikh raha hai. Thaka hona woh nahi hai jiska yeh shloka varnan karta hai, aur bahar se bartav milta-julta dikhne se woh wahi cheez nahi ho jaati.' AS c_hing,
  'She can see all of it. Whatever this verse is describing, it is not her.' AS l_en,
  'उसे सब दिख रहा है। यह श्लोक जो भी बता रहा हो, वह वह नहीं है।' AS l_hi,
  'Use sab dikh raha hai. Yeh shloka jo bhi bata raha ho, woh woh nahi hai.' AS l_hing,
  NULL AS src, 'intermediate' AS diff, 'caring,exhaustion,boundaries,not-a-verdict' AS tags

  UNION ALL SELECT 8, 'everyday_life', 2,
  'The letter he did not open', 'वह चिट्ठी जो उसने नहीं खोली', 'Woh chitthi jo usne nahi kholi',
  'A letter about something that needs dealing with sits unopened on a shelf for five weeks. He is not tired, not busy, and not avoiding it in any way he could describe. He passes it several times a day and each time it does not register as a thing to do.',
  'किसी ऐसी चीज़ की चिट्ठी जिसका निपटारा ज़रूरी है, पाँच हफ़्ते बिना खुले शेल्फ़ पर पड़ी रहती है। वह न थका है, न व्यस्त, और न ही उसे किसी ऐसे तरीक़े से टाल रहा है जिसे वह बता सके। वह दिन में कई बार उसके पास से गुज़रता है और हर बार वह करने लायक़ चीज़ की तरह दर्ज ही नहीं होती।',
  'Kisi aisi cheez ki chitthi jiska niptara zaroori hai, paanch hafte bina khule shelf par padi rehti hai. Woh na thaka hai, na vyast, aur na hi use kisi aise tareeke se taal raha hai jise woh bata sake. Woh din mein kai baar uske paas se guzarta hai aur har baar woh karne layak cheez ki tarah darj hi nahi hoti.',
  'This is what the verse is actually about, and note that he is not tired. Pramāda is not-noticing, and it is doing the work here rather than reluctance. The letter is in his field of view several times a day and is not being seen, which is the definition the verse gives before it lists any behaviour.',
  'श्लोक असल में इसी बारे में है, और ध्यान दीजिए कि वह थका नहीं है। प्रमाद ध्यान का न जाना है, और यहाँ काम वही कर रहा है, अनिच्छा नहीं। चिट्ठी दिन में कई बार उसकी नज़र में है और देखी नहीं जा रही, और श्लोक किसी बरताव को गिनाने से पहले यही परिभाषा देता है।',
  'Shloka asal mein isi baare mein hai, aur dhyan do ki woh thaka nahi hai. Pramad dhyan ka na jaana hai, aur yahan kaam wahi kar raha hai, anichha nahi. Chitthi din mein kai baar uski nazar mein hai aur dekhi nahi ja rahi, aur shloka kisi bartav ko ginane se pehle yahi paribhasha deta hai.',
  'He is not tired and not avoiding it. It simply is not registering.',
  'वह न थका है और न टाल रहा है। वह बस दर्ज ही नहीं हो रही।',
  'Woh na thaka hai aur na taal raha hai. Woh bas darj hi nahi ho rahi.',
  NULL, 'beginner', 'avoidance,noticing,admin,definition'

  UNION ALL SELECT 8, 'college', 3,
  'The module he could not describe', 'वह मॉड्यूल जिसे वह बता नहीं सका', 'Woh module jise woh bata nahi saka',
  'A student attends every lecture of a course and takes notes in all of them. Asked in week nine what the course is about, he cannot say. He has not missed a session and he is not behind on the reading.',
  'एक छात्र किसी कोर्स का हर लेक्चर लेता है और सबमें नोट्स बनाता है। नौवें हफ़्ते में पूछने पर कि कोर्स किस बारे में है, वह बता नहीं पाता। उसने कोई क्लास नहीं छोड़ी और पढ़ाई में भी पीछे नहीं है।',
  'Ek student kisi course ka har lecture leta hai aur sabme notes banata hai. Nauve hafte mein poochhne par ki course kis baare mein hai, woh bata nahi pata. Usne koi class nahi chhodi aur padhai mein bhi peechhe nahi hai.',
  'Mohana — the clouding — with full attendance and complete notes. This is the version of the verse nobody expects, and it is why the definition comes before the behaviour. Effort is not the axis. Whether anything is being seen is the axis.',
  'मोहन — धुँधलाना — पूरी हाज़िरी और पूरे नोट्स के साथ। यह श्लोक का वह रूप है जिसकी कोई उम्मीद नहीं करता, और इसीलिए परिभाषा बरताव से पहले आती है। धुरी मेहनत नहीं है। धुरी यह है कि कुछ दिख भी रहा है या नहीं।',
  'Mohana — dhundhlana — poori haziri aur poore notes ke saath. Yeh shloka ka woh roop hai jiski koi ummeed nahi karta, aur isiliye paribhasha bartav se pehle aati hai. Dhuri mehnat nahi hai. Dhuri yeh hai ki kuch dikh bhi raha hai ya nahi.',
  'Full attendance, complete notes, nothing seen. Effort was never the axis.',
  'पूरी हाज़िरी, पूरे नोट्स, और कुछ दिखा नहीं। धुरी कभी मेहनत थी ही नहीं।',
  'Poori haziri, poore notes, aur kuch dikha nahi. Dhuri kabhi mehnat thi hi nahi.',
  NULL, 'intermediate', 'students,attention,effort,seeing'

  UNION ALL SELECT 8, 'corporate', 4,
  'Everybody knew and nobody said', 'सब जानते थे और किसी ने कहा नहीं', 'Sab jaante the aur kisi ne kaha nahi',
  'A project runs eight months past the point where several people privately believed it would not work. Nobody was lying and nobody was lazy — the meetings were well attended and the updates were accurate. The one question that mattered was not on any agenda.',
  'एक प्रोजेक्ट उस बिंदु से आठ महीने आगे चलता है जहाँ कई लोग चुपचाप मान चुके थे कि यह चलेगा नहीं। कोई झूठ नहीं बोल रहा था और कोई आलसी नहीं था — बैठकों में हाज़िरी अच्छी थी और अपडेट सही थे। जो एक सवाल मायने रखता था वह किसी एजेंडे में नहीं था।',
  'Ek project us bindu se aath mahine aage chalta hai jahan kai log chupchap maan chuke the ki yeh chalega nahi. Koi jhooth nahi bol raha tha aur koi aalsi nahi tha — baithakon mein haziri achhi thi aur update sahi the. Jo ek sawal maayne rakhta tha woh kisi agenda mein nahi tha.',
  'The verse puts pramāda first for a reason, and organisations run it better than individuals do. There was no shortage of activity and no shortage of honesty. What was absent was anybody looking directly at the thing, which is precisely the state the verse defines and precisely not laziness.',
  'श्लोक प्रमाद को पहले वजह से रखता है, और संस्थाएँ इसे व्यक्तियों से बेहतर चलाती हैं। न हलचल की कमी थी और न ईमानदारी की। ग़ैरहाज़िर था कोई ऐसा जो उस चीज़ को सीधे देखे, और श्लोक जिस हालत की परिभाषा देता है वह ठीक यही है और ठीक आलस्य नहीं है।',
  'Shloka pramad ko pehle wajah se rakhta hai, aur sansthayein ise vyaktiyon se behtar chalati hain. Na halchal ki kami thi aur na imaandari ki. Gairhazir tha koi aisa jo us cheez ko seedhe dekhe, aur shloka jis haalat ki paribhasha deta hai woh theek yahi hai aur theek aalasya nahi hai.',
  'No shortage of activity and no shortage of honesty. Nobody was looking at it.',
  'न हलचल की कमी थी, न ईमानदारी की। बस कोई उसे देख नहीं रहा था।',
  'Na halchal ki kami thi, na imaandari ki. Bas koi use dekh nahi raha tha.',
  NULL, 'intermediate', 'work,projects,blind-spots,not-laziness'

  UNION ALL SELECT 11, 'everyday_life', 1,
  'The walk where he heard the birds', 'वह सैर जिसमें उसे चिड़ियाँ सुनाई दीं', 'Woh sair jisme use chidiyan sunayi deen',
  'Somebody walks the same route every morning. On most days he arrives without remembering any of it. On one Tuesday he hears birds, notices a wall he has passed four hundred times, and follows a thought all the way to the end. Nothing about the route changed.',
  'कोई हर सुबह वही रास्ता चलता है। ज़्यादातर दिन वह पहुँच जाता है और उसे उसमें से कुछ याद नहीं रहता। एक मंगलवार उसे चिड़ियाँ सुनाई देती हैं, वह एक दीवार पर ध्यान देता है जिसके पास से वह चार सौ बार गुज़रा है, और एक ख़याल को आख़िर तक साथ ले जाता है। रास्ते में कुछ नहीं बदला।',
  'Koi har subah wahi raasta chalta hai. Zyadatar din woh pahunch jaata hai aur use usme se kuch yaad nahi rehta. Ek Tuesday use chidiyan sunayi deti hain, woh ek deewar par dhyan deta hai jiske paas se woh chaar sau baar guzra hai, aur ek khayal ko aakhir tak saath le jaata hai. Raaste mein kuch nahi badla.',
  'Sarva-dvāreṣu — in all the gates. Hearing, seeing and following a thought, all at once, on a route that was identical. The verse gives this as a test you can run on a specific morning, which is a much smaller and more usable thing than a claim about who somebody is.',
  'सर्वद्वारेषु — सारे दरवाज़ों में। सुनना, देखना और एक ख़याल के साथ चलना, सब एक साथ, और रास्ता वही का वही। श्लोक इसे ऐसी कसौटी की तरह देता है जो किसी ख़ास सुबह पर चलाई जा सके, और यह इस दावे से कहीं छोटी और कहीं ज़्यादा काम की चीज़ है कि कोई इंसान है क्या।',
  'Sarva-dvareshu — saare darwazon mein. Sunna, dekhna aur ek khayal ke saath chalna, sab ek saath, aur raasta wahi ka wahi. Shloka ise aisi kasauti ki tarah deta hai jo kisi khaas subah par chalayi ja sake, aur yeh is dawe se kahin chhoti aur kahin zyada kaam ki cheez hai ki koi insan hai kya.',
  'The route was identical. All the gates were open on the Tuesday.',
  'रास्ता वही था। मंगलवार को सारे दरवाज़े खुले थे।',
  'Raasta wahi tha. Tuesday ko saare darwaze khule the.',
  NULL, 'beginner', 'walking,attention,mornings,test'

  UNION ALL SELECT 11, 'sports', 2,
  'The over he could describe ball by ball', 'वह ओवर जो वह गेंद-दर-गेंद बता सका', 'Woh over jo woh gend-dar-gend bata saka',
  'A bowler is asked about two spells from the same match. One he describes in detail — field, plan, what he saw the batter do with his feet. The other he cannot recall at all, and he took a wicket in it.',
  'एक गेंदबाज़ से उसी मैच के दो स्पेल के बारे में पूछा जाता है। एक का वह ब्यौरा देता है — फ़ील्ड, योजना, उसने बल्लेबाज़ के पैरों में क्या देखा। दूसरा उसे बिलकुल याद नहीं, और उसी में उसने विकेट लिया था।',
  'Ek gendbaaz se usi match ke do spell ke baare mein poochha jaata hai. Ek ka woh byora deta hai — field, yojna, usne ballebaaz ke pairon mein kya dekha. Doosra use bilkul yaad nahi, aur usi mein usne wicket liya tha.',
  'The result is not the test and this is the cleanest possible demonstration of that. He took a wicket in the spell he cannot describe. Light in all the gates is about what was being seen, and it does not track the scorecard in either direction.',
  'नतीजा कसौटी नहीं है और इसका इससे साफ़ सबूत नहीं हो सकता। जिस स्पेल का वह ब्यौरा नहीं दे सकता, विकेट उसी में लिया। सारे दरवाज़ों पर रोशनी इस बारे में है कि दिख क्या रहा था, और वह स्कोरकार्ड का किसी भी दिशा में पीछा नहीं करती।',
  'Nateeja kasauti nahi hai aur iska isse saaf saboot nahi ho sakta. Jis spell ka woh byora nahi de sakta, wicket usi mein liya. Saare darwazon par roshni is baare mein hai ki dikh kya raha tha, aur woh scorecard ka kisi bhi disha mein peechha nahi karti.',
  'He took the wicket in the spell he cannot remember. The result is not the test.',
  'जो स्पेल उसे याद नहीं, विकेट उसी में लिया। नतीजा कसौटी नहीं है।',
  'Jo spell use yaad nahi, wicket usi mein liya. Nateeja kasauti nahi hai.',
  NULL, 'intermediate', 'sport,attention,recall,results'

  UNION ALL SELECT 11, 'technology', 3,
  'Two hours of debugging, twice', 'दो घंटे की डीबगिंग, दो बार', 'Do ghante ki debugging, do baar',
  'Somebody spends two hours on a bug on Monday and gets nowhere, then two hours on the same bug on Wednesday and finds it in twenty minutes. He is not smarter on Wednesday. On Monday he was reading past the same three lines each time and never saw them.',
  'कोई सोमवार को दो घंटे एक बग पर लगाता है और कहीं नहीं पहुँचता, फिर बुधवार को उसी बग पर दो घंटे और उसे बीस मिनट में पा लेता है। वह बुधवार को ज़्यादा तेज़ नहीं है। सोमवार को वह हर बार उन्हीं तीन पंक्तियों से पढ़ते हुए निकल जा रहा था और उन्हें कभी देखा नहीं।',
  'Koi Monday ko do ghante ek bug par lagata hai aur kahin nahi pahunchta, phir Wednesday ko usi bug par do ghante aur use bees minute mein pa leta hai. Woh Wednesday ko zyada tez nahi hai. Monday ko woh har baar unhi teen lines se padhte hue nikal ja raha tha aur unhe kabhi dekha nahi.',
  'Same person, same problem, same effort, two days apart. The chapter says the three settings take turns, and this is what that looks like when the task is held constant. It also shows why the test in this verse is worth running before a long session rather than after it.',
  'वही इंसान, वही समस्या, वही मेहनत, दो दिन के फ़ासले पर। अध्याय कहता है कि तीनों अवस्थाएँ बारी-बारी आती हैं, और काम को स्थिर रखकर देखें तो वह ऐसा दिखता है। यह भी दिखता है कि इस श्लोक की कसौटी लंबी बैठक के बाद नहीं, उससे पहले चलाना काम का क्यों है।',
  'Wahi insan, wahi samasya, wahi mehnat, do din ke faasle par. Adhyay kehta hai ki teenon avasthayein baari-baari aati hain, aur kaam ko sthir rakhkar dekhein to woh aisa dikhta hai. Yeh bhi dikhta hai ki is shloka ki kasauti lambi baithak ke baad nahi, usse pehle chalana kaam ka kyun hai.',
  'He was not smarter on Wednesday. He could see on Wednesday.',
  'वह बुधवार को ज़्यादा तेज़ नहीं था। बुधवार को उसे दिख रहा था।',
  'Woh Wednesday ko zyada tez nahi tha. Wednesday ko use dikh raha tha.',
  NULL, 'beginner', 'debugging,attention,same-task,timing'

  UNION ALL SELECT 11, 'school', 4,
  'The lesson that landed on Thursday', 'वह पाठ जो गुरुवार को उतरा', 'Woh paath jo Thursday ko utra',
  'A teacher gives the same lesson to two classes on the same day. In one it lands and the questions are good. In the other it does not. Her preparation was identical and she cannot honestly attribute the difference to either group of children.',
  'एक शिक्षिका एक ही दिन दो कक्षाओं को वही पाठ पढ़ाती है। एक में वह उतरता है और सवाल अच्छे आते हैं। दूसरी में नहीं। उसकी तैयारी बिलकुल वही थी और वह ईमानदारी से इस फ़र्क़ का ज़िम्मा किसी भी समूह के बच्चों पर नहीं डाल सकती।',
  'Ek shikshika ek hi din do kakshaon ko wahi paath padhati hai. Ek mein woh utarta hai aur sawal achhe aate hain. Doosri mein nahi. Uski taiyari bilkul wahi thi aur woh imaandari se is farq ka zimma kisi bhi samooh ke bachchon par nahi daal sakti.',
  'The honest version of this verse is that the test reads a room and a moment, not a person and not a class. She could tell in the first ninety seconds which of the two she was in, and knowing that early is worth more than any explanation of why.',
  'इस श्लोक का ईमानदार रूप यह है कि कसौटी एक कमरे और एक पल को पढ़ती है, किसी इंसान या किसी कक्षा को नहीं। पहले नब्बे सेकंड में वह बता सकती थी कि वह दोनों में से किसमें है, और इतनी जल्दी यह जान लेना "क्यों" की किसी भी व्याख्या से ज़्यादा क़ीमती है।',
  'Is shloka ka imaandaar roop yeh hai ki kasauti ek kamre aur ek pal ko padhti hai, kisi insan ya kisi kaksha ko nahi. Pehle nabbe second mein woh bata sakti thi ki woh dono mein se kisme hai, aur itni jaldi yeh jaan lena "kyun" ki kisi bhi vyakhya se zyada keemti hai.',
  'The test reads a room and a moment. It does not read a class.',
  'कसौटी एक कमरे और एक पल को पढ़ती है। वह किसी कक्षा को नहीं पढ़ती।',
  'Kasauti ek kamre aur ek pal ko padhti hai. Woh kisi kaksha ko nahi padhti.',
  NULL, 'intermediate', 'teaching,rooms,moments,attribution'

  UNION ALL SELECT 22, 'healthcare', 1,
  'The flat week she did not fight', 'वह सपाट हफ़्ता जिससे वह नहीं भिड़ी', 'Woh sapaat hafta jisse woh nahi bhidi',
  'Somebody recovering from an illness has a flat week — no worse, no better, nothing moving. Instead of treating it as a setback she treats it as a week. She keeps the appointments, does the small things, and stops checking whether today is progress.',
  'किसी बीमारी से उबरते हुए किसी का एक सपाट हफ़्ता जाता है — न बदतर, न बेहतर, कुछ हिलता नहीं। उसे झटका मानने के बजाय वह उसे हफ़्ता मानती है। अपॉइंटमेंट रखती है, छोटे काम करती है, और यह जाँचना बंद कर देती है कि आज कोई प्रगति है या नहीं।',
  'Kisi bimari se ubarte hue kisi ka ek sapaat hafta jaata hai — na badtar, na behtar, kuch hilta nahi. Use jhatka maanne ke bajaye woh use hafta maanti hai. Appointment rakhti hai, chhote kaam karti hai, aur yeh jaanchna band kar deti hai ki aaj koi pragati hai ya nahi.',
  'Not hating it when it arrives. The flat week happened either way; what she stopped adding was the second thing on top of it, which is the fight, and which is usually the more tiring of the two. Nothing here is resignation — she kept every appointment.',
  'जब वह आया तो उससे नफ़रत न करना। सपाट हफ़्ता वैसे भी होता; उसने ऊपर से जो दूसरी चीज़ जोड़ना बंद किया वह है भिड़ना, और आमतौर पर दोनों में यही ज़्यादा थकाता है। यहाँ कुछ भी हार मान लेना नहीं है — उसने हर अपॉइंटमेंट रखा।',
  'Jab woh aaya to usse nafrat na karna. Sapaat hafta waise bhi hota; usne upar se jo doosri cheez jodna band ki woh hai bhidna, aur aam taur par dono mein yahi zyada thakata hai. Yahan kuch bhi haar maan lena nahi hai — usne har appointment rakha.',
  'The flat week happened either way. What she stopped was the fight on top of it.',
  'सपाट हफ़्ता वैसे भी होता। उसने ऊपर वाली लड़ाई रोकी।',
  'Sapaat hafta waise bhi hota. Usne upar wali ladai roki.',
  NULL, 'intermediate', 'recovery,plateau,acceptance,not-resignation'

  UNION ALL SELECT 22, 'everyday_life', 2,
  'He stopped ranking his mornings', 'उसने अपनी सुबहों को क्रम देना बंद कर दिया', 'Usne apni subahon ko kram dena band kar diya',
  'Somebody who kept a mood score for two years stops keeping it. He had noticed that on any day below his average he spent the first hour comparing it to the good weeks, and that the comparison was doing more damage than the mood.',
  'दो साल से मिज़ाज का अंक रखने वाला कोई उसे रखना बंद कर देता है। उसने देखा था कि औसत से नीचे के किसी भी दिन वह पहला घंटा उसे अच्छे हफ़्तों से मिलाने में बिताता है, और वह तुलना मिज़ाज से ज़्यादा नुक़सान कर रही थी।',
  'Do saal se mizaaj ka ank rakhne wala koi use rakhna band kar deta hai. Usne dekha tha ki ausat se neeche ke kisi bhi din woh pehla ghanta use achhe hafton se milane mein bitata hai, aur woh tulna mizaaj se zyada nuksaan kar rahi thi.',
  'The second half of the verse: not longing for them when they cease. Measuring today against your best day is exactly that longing, run daily, with a number attached. Giving it up is a real cost and the verse does not pretend otherwise.',
  'श्लोक का दूसरा आधा: जब वे चली जाएँ तो उन्हें याद न करना। आज को अपने सबसे अच्छे दिन से नापना ठीक वही याद है, रोज़ चलाई गई, और उस पर एक आँकड़ा चिपका हुआ। इसे छोड़ने की असली क़ीमत है और श्लोक इसका बहाना नहीं बनाता।',
  'Shloka ka doosra aadha: jab woh chali jaayein to unhe yaad na karna. Aaj ko apne sabse achhe din se naapna theek wahi yaad hai, roz chalayi gayi, aur us par ek aankda chipka hua. Ise chhodne ki asli keemat hai aur shloka iska bahana nahi banata.',
  'The comparison was doing more damage than the mood.',
  'तुलना मिज़ाज से ज़्यादा नुक़सान कर रही थी।',
  'Tulna mizaaj se zyada nuksaan kar rahi thi.',
  NULL, 'beginner', 'mood,measuring,comparison,letting-go'

  UNION ALL SELECT 22, 'relationships', 3,
  'The quiet stretch in a long marriage', 'लंबी शादी का शांत दौर', 'Lambi shaadi ka shaant daur',
  'Two people who have been together nineteen years go through a flat few months. Neither of them reads it as a verdict. They have been through four of these and each one ended without either of them working out why.',
  'उन्नीस साल साथ रहे दो लोग कुछ सपाट महीनों से गुज़रते हैं। दोनों में से कोई इसे फ़ैसला नहीं मानता। वे ऐसे चार दौर से गुज़र चुके हैं और हर एक ख़त्म हो गया बिना इसके कि कोई समझ पाता क्यों।',
  'Unnees saal saath rahe do log kuch sapaat mahinon se guzarte hain. Dono mein se koi ise faisla nahi maanta. Woh aise chaar daur se guzar chuke hain aur har ek khatam ho gaya bina iske ki koi samajh pata kyun.',
  'Experience of the turning is what makes the verse liveable. They are not stoics and neither of them is unbothered; they have simply seen this arrive and leave four times and have stopped treating the arrival as information about the marriage.',
  'बारी-बारी बदलने का अनुभव ही श्लोक को जीने लायक़ बनाता है। वे कोई स्थितप्रज्ञ नहीं हैं और दोनों में से किसी को कोई फ़र्क़ न पड़ता हो ऐसा भी नहीं; उन्होंने बस इसे चार बार आते और जाते देखा है और उसके आने को शादी के बारे में जानकारी मानना बंद कर दिया है।',
  'Baari-baari badalne ka anubhav hi shloka ko jeene layak banata hai. Woh koi sthitpragya nahi hain aur dono mein se kisi ko koi farq na padta ho aisa bhi nahi; unhone bas ise chaar baar aate aur jaate dekha hai aur uske aane ko shaadi ke baare mein jaankari maanna band kar diya hai.',
  'They have seen it arrive and leave four times. That is what makes the verse liveable.',
  'उन्होंने इसे चार बार आते और जाते देखा है। यही श्लोक को जीने लायक़ बनाता है।',
  'Unhone ise chaar baar aate aur jaate dekha hai. Yahi shloka ko jeene layak banata hai.',
  NULL, 'intermediate', 'marriage,plateaus,experience,patience'

  UNION ALL SELECT 22, 'finance', 4,
  'The year the portfolio did nothing', 'वह साल जब पोर्टफ़ोलियो कुछ नहीं हिला', 'Woh saal jab portfolio kuch nahi hila',
  'Somebody with long-term savings has a year in which the number barely moves. He does not sell, does not add, does not change anything, and mostly does not look. The following year is a good one and he did nothing differently to earn it.',
  'लंबी अवधि की बचत वाले किसी का एक साल ऐसा जाता है जिसमें आँकड़ा शायद ही हिलता है। वह न बेचता है, न जोड़ता है, न कुछ बदलता है, और ज़्यादातर देखता भी नहीं। अगला साल अच्छा जाता है और उसे कमाने के लिए उसने कुछ अलग नहीं किया।',
  'Lambi avadhi ki bachat wale kisi ka ek saal aisa jaata hai jisme aankda shayad hi hilta hai. Woh na bechta hai, na jodta hai, na kuch badalta hai, aur zyadatar dekhta bhi nahi. Agla saal achha jaata hai aur use kamane ke liye usne kuch alag nahi kiya.',
  'Neither hating the flat year nor longing for the good one — and here the discipline is visible as inaction rather than as an attitude. What the verse describes usually shows up as something somebody did not do, which is why it is hard to see in anybody and hard to claim about yourself.',
  'न सपाट साल से नफ़रत, न अच्छे साल की याद — और यहाँ अनुशासन किसी रवैये के तौर पर नहीं, न करने के तौर पर दिखता है। श्लोक जो बताता है वह आमतौर पर उस चीज़ के रूप में सामने आता है जो किसी ने नहीं की, और इसीलिए उसे किसी में देखना मुश्किल है और अपने बारे में दावा करना भी।',
  'Na sapaat saal se nafrat, na achhe saal ki yaad — aur yahan anushasan kisi ravaiye ke taur par nahi, na karne ke taur par dikhta hai. Shloka jo batata hai woh aam taur par us cheez ke roop mein saamne aata hai jo kisi ne nahi ki, aur isiliye use kisi mein dekhna mushkil hai aur apne baare mein dawa karna bhi.',
  'It shows up as something he did not do. That is why it is hard to see in anybody.',
  'वह उस चीज़ के रूप में दिखता है जो उसने नहीं की। इसीलिए उसे किसी में देखना मुश्किल है।',
  'Woh us cheez ke roop mein dikhta hai jo usne nahi ki. Isiliye use kisi mein dekhna mushkil hai.',
  NULL, 'intermediate', 'money,patience,inaction,long-term'

  UNION ALL SELECT 23, 'healthcare', 1,
  'The calmest person in the room, and the closest', 'कमरे में सबसे शांत, और सबसे पास', 'Kamre mein sabse shaant, aur sabse paas',
  'During an emergency the most composed person present is also the one holding somebody''s hand and using their name. Afterwards a junior says she seemed detached. Everybody who was actually being treated by her says the opposite.',
  'किसी आपात स्थिति में वहाँ मौजूद सबसे संयत इंसान वही है जो किसी का हाथ थामे है और उसका नाम लेकर बोल रहा है। बाद में एक जूनियर कहता है कि वह अलग-थलग लग रही थी। जिनका इलाज वह असल में कर रही थी, वे सब उल्टा कहते हैं।',
  'Kisi aapat sthiti mein wahan maujood sabse sanyat insan wahi hai jo kisi ka haath thaame hai aur uska naam lekar bol raha hai. Baad mein ek junior kehta hai ki woh alag-thalag lag rahi thi. Jinka ilaaj woh asal mein kar rahi thi, woh sab ulta kehte hain.',
  'Udāsīna-VAT — LIKE one uninvolved. The junior read the suffix out of the sentence and got detachment; the patients got the verse. She is not thrown about by what is happening. She is entirely in the room, and those are two different claims.',
  'उदासीन-वत् — उदासीन जैसा। जूनियर ने वाक्य से प्रत्यय निकाल दिया और उसे अलगाव मिला; मरीज़ों को श्लोक मिला। जो हो रहा है उससे वह इधर-उधर नहीं हो रही। वह पूरी तरह कमरे में है, और ये दो अलग दावे हैं।',
  'Udaseen-vat — udaseen jaisa. Junior ne vakya se pratyay nikaal diya aur use alagav mila; mareezon ko shloka mila. Jo ho raha hai usse woh idhar-udhar nahi ho rahi. Woh poori tarah kamre mein hai, aur yeh do alag dawe hain.',
  'The junior read the suffix out and got detachment. The patients got the verse.',
  'जूनियर ने प्रत्यय हटा दिया और उसे अलगाव मिला। मरीज़ों को श्लोक मिला।',
  'Junior ne pratyay hata diya aur use alagav mila. Mareezon ko shloka mila.',
  NULL, 'intermediate', 'emergency,composure,presence,suffix'

  UNION ALL SELECT 23, 'parenting', 2,
  'The parent who did not escalate', 'वह अभिभावक जो नहीं भड़का', 'Woh abhibhavak jo nahi bhadka',
  'A teenager says something designed to land. The parent does not rise to it, does not go cold, and answers the actual question underneath about twenty minutes later. Nothing was ignored and nothing was punished.',
  'एक किशोर कुछ ऐसा कहता है जो चुभने के लिए बना है। अभिभावक न भड़कता है, न ठंडा पड़ता है, और क़रीब बीस मिनट बाद नीचे छिपे असली सवाल का जवाब देता है। न कुछ अनदेखा किया गया और न किसी को सज़ा मिली।',
  'Ek kishor kuch aisa kehta hai jo chubhne ke liye bana hai. Abhibhavak na bhadakta hai, na thanda padta hai, aur kareeb bees minute baad neeche chhipe asli sawal ka jawab deta hai. Na kuch andekha kiya gaya aur na kisi ko saza mili.',
  'Not being moved is not the same as not being there, and going cold is the failure mode that looks most like the verse. The twenty minutes are the evidence: somebody who had genuinely withdrawn would not have come back with the answer.',
  'न हिलना वहाँ न होना नहीं है, और ठंडा पड़ जाना वह नाकामी है जो श्लोक जैसी सबसे ज़्यादा दिखती है। बीस मिनट ही सबूत हैं: जो सचमुच हट गया होता वह जवाब लेकर लौटता नहीं।',
  'Na hilna wahan na hona nahi hai, aur thanda pad jaana woh nakami hai jo shloka jaisi sabse zyada dikhti hai. Bees minute hi saboot hain: jo sach mein hat gaya hota woh jawab lekar lautta nahi.',
  'Going cold is the failure that looks most like this verse. The twenty minutes are the difference.',
  'ठंडा पड़ जाना वह नाकामी है जो इस श्लोक जैसी सबसे ज़्यादा दिखती है। फ़र्क़ वे बीस मिनट हैं।',
  'Thanda pad jaana woh nakami hai jo is shloka jaisi sabse zyada dikhti hai. Farq woh bees minute hain.',
  NULL, 'intermediate', 'parenting,teenagers,composure,withdrawal'

  UNION ALL SELECT 23, 'corporate', 3,
  'The week the numbers were bad', 'वह हफ़्ता जब आँकड़े ख़राब थे', 'Woh hafta jab aankde kharab the',
  'A manager gets a bad set of results and neither panics nor performs calm. She says the numbers out loud, says she does not yet know what they mean, and asks two specific questions. The room settles, and nobody could say afterwards what she did.',
  'एक मैनेजर को ख़राब नतीजे मिलते हैं और वह न घबराती है और न शांति का दिखावा करती है। वह आँकड़े ज़ोर से पढ़ती है, कहती है कि उसे अभी नहीं पता कि इनका मतलब क्या है, और दो ख़ास सवाल पूछती है। कमरा ठहर जाता है, और बाद में कोई नहीं बता पाता कि उसने किया क्या।',
  'Ek manager ko kharab nateeje milte hain aur woh na ghabrati hai aur na shaanti ka dikhava karti hai. Woh aankde zor se padhti hai, kehti hai ki use abhi nahi pata ki inka matlab kya hai, aur do khaas sawal poochhti hai. Kamra thehar jaata hai, aur baad mein koi nahi bata pata ki usne kiya kya.',
  '"These are just turning over" is not something she said and is close to what she did. Note that she engaged completely — read the numbers, admitted not knowing, asked questions. Steadiness here is a property of how she met the thing, not of how far away from it she stood.',
  '"ये तो बस बदलती रहती हैं" यह उसने कहा नहीं, और उसने जो किया वह इसके पास है। ध्यान दीजिए कि वह पूरी तरह जुटी — आँकड़े पढ़े, न जानना माना, सवाल पूछे। यहाँ ठहराव इस बात का गुण है कि उसने चीज़ से मिलना कैसे किया, इसका नहीं कि वह उससे कितनी दूर खड़ी थी।',
  '"Yeh to bas badalti rehti hain" yeh usne kaha nahi, aur usne jo kiya woh iske paas hai. Dhyan do ki woh poori tarah juti — aankde padhe, na jaanna maana, sawal poochhe. Yahan thehrav is baat ka gun hai ki usne cheez se milna kaise kiya, iska nahi ki woh usse kitni door khadi thi.',
  'Steadiness is a property of how she met it, not of how far away she stood.',
  'ठहराव इसका गुण है कि उसने उससे मिलना कैसे किया, इसका नहीं कि वह कितनी दूर खड़ी थी।',
  'Thehrav iska gun hai ki usne usse milna kaise kiya, iska nahi ki woh kitni door khadi thi.',
  NULL, 'intermediate', 'work,bad-news,composure,engagement'

  UNION ALL SELECT 23, 'friendship', 4,
  'He did not need it to go well', 'उसे इसका अच्छा जाना ज़रूरी नहीं था', 'Use iska achha jaana zaroori nahi tha',
  'Somebody sits with a friend through a long bad patch. He listens for months without needing any particular week to be an improvement on the last, and without going anywhere. The friend says afterwards that this was the only thing that helped.',
  'कोई अपने दोस्त के साथ एक लंबे बुरे दौर में बैठा रहता है। वह महीनों सुनता है, बिना इसकी ज़रूरत के कि कोई ख़ास हफ़्ता पिछले से बेहतर हो, और बिना कहीं गए। दोस्त बाद में कहता है कि मदद बस इसी एक चीज़ से हुई।',
  'Koi apne dost ke saath ek lambe bure daur mein baitha rehta hai. Woh mahinon sunta hai, bina iski zaroorat ke ki koi khaas hafta pichhle se behtar ho, aur bina kahin gaye. Dost baad mein kehta hai ki madad bas isi ek cheez se hui.',
  'Both verses at once. He does not hate the bad months when they arrive and does not long for the good ones — and 14.23 supplies the crucial half, which is that none of this is withdrawal. He was there the entire time. Somebody who had actually become indifferent would have stopped turning up in about the fifth week.',
  'दोनों श्लोक एक साथ। जब बुरे महीने आते हैं तो वह उनसे नफ़रत नहीं करता और अच्छे महीनों को याद नहीं करता — और 14.23 वह ज़रूरी आधा जोड़ता है, यानी इसमें कुछ भी हट जाना नहीं है। वह पूरे वक़्त वहीं था। जो सचमुच उदासीन हो गया होता वह पाँचवें हफ़्ते के आसपास आना बंद कर देता।',
  'Dono shloka ek saath. Jab bure mahine aate hain to woh unse nafrat nahi karta aur achhe mahinon ko yaad nahi karta — aur 14.23 woh zaroori aadha jodta hai, yani isme kuch bhi hat jaana nahi hai. Woh poore waqt wahin tha. Jo sach mein udaseen ho gaya hota woh paanchve hafte ke aas paas aana band kar deta.',
  'Somebody who had actually become indifferent would have stopped turning up.',
  'जो सचमुच उदासीन हो गया होता वह आना बंद कर देता।',
  'Jo sach mein udaseen ho gaya hota woh aana band kar deta.',
  NULL, 'beginner', 'friendship,staying,patience,presence'

  UNION ALL SELECT 26, 'everyday_life', 1,
  'The thing his attention goes back to', 'वह चीज़ जिस पर उसका ध्यान लौटता है', 'Woh cheez jis par uska dhyan lautta hai',
  'Somebody notices that in idle moments — queues, waiting rooms, the walk home — his mind goes to the same thing it has gone to for eleven years. He has never decided this and has never had to maintain it.',
  'कोई देखता है कि ख़ाली पलों में — क़तारों में, इंतज़ार के कमरों में, घर लौटते रास्ते में — उसका मन उसी चीज़ पर जाता है जिस पर ग्यारह साल से जाता आया है। उसने यह कभी तय नहीं किया और इसे कभी बनाए भी नहीं रखना पड़ा।',
  'Koi dekhta hai ki khaali palon mein — kataron mein, intezaar ke kamron mein, ghar lautte raaste mein — uska man usi cheez par jaata hai jis par gyarah saal se jaata aaya hai. Usne yeh kabhi tay nahi kiya aur ise kabhi banaye bhi nahi rakhna pada.',
  'Avyabhicāreṇa is without wandering off, and the shape of the verse is transferable even if its frame is not. Attention that returns to one thing on its own is doing something no amount of effort against the settings can do, and it is worth finding out what yours already returns to.',
  'अव्यभिचारेण का मतलब है बिना भटके, और श्लोक की बनावट ले जाई जा सकती है भले ही उसका ढाँचा न लिया जाए। जो ध्यान अपने आप एक चीज़ पर लौटता है वह ऐसा कुछ कर रहा है जो अवस्थाओं के ख़िलाफ़ कितनी भी मेहनत नहीं कर सकती, और यह पता करना काम का है कि आपका ध्यान पहले से कहाँ लौटता है।',
  'Avyabhicharen ka matlab hai bina bhatke, aur shloka ki banawat le jaayi ja sakti hai bhale hi uska dhaancha na liya jaaye. Jo dhyan apne aap ek cheez par lautta hai woh aisa kuch kar raha hai jo avasthaon ke khilaf kitni bhi mehnat nahi kar sakti, aur yeh pata karna kaam ka hai ki tumhara dhyan pehle se kahan lautta hai.',
  'Find out what your attention already returns to. It has been doing it for years.',
  'पता कीजिए कि आपका ध्यान पहले से कहाँ लौटता है। वह सालों से यही कर रहा है।',
  'Pata karo ki tumhara dhyan pehle se kahan lautta hai. Woh saalon se yahi kar raha hai.',
  NULL, 'beginner', 'attention,returning,idle-moments,noticing'

  UNION ALL SELECT 26, 'ethics', 2,
  'The line he never had to think about', 'वह रेखा जिसके बारे में उसे कभी सोचना नहीं पड़ा', 'Woh rekha jiske baare mein use kabhi sochna nahi pada',
  'Somebody is offered something that would be easy to take and hard to trace. He declines within a second and cannot afterwards reconstruct any reasoning, because none happened. He has been the same about this for thirty years.',
  'किसी को ऐसी चीज़ की पेशकश होती है जो लेना आसान होगी और जिसका पता लगाना मुश्किल। वह एक सेकंड में मना कर देता है और बाद में कोई तर्क दोबारा नहीं जोड़ पाता, क्योंकि तर्क हुआ ही नहीं। वह इस बारे में तीस साल से वैसा ही है।',
  'Kisi ko aisi cheez ki peshkash hoti hai jo lena aasan hogi aur jiska pata lagana mushkil. Woh ek second mein mana kar deta hai aur baad mein koi tark dobara nahi jod pata, kyunki tark hua hi nahi. Woh is baare mein tees saal se waisa hi hai.',
  'Sevate is closer to attending on something than to obeying it, and this is what steadiness of that kind looks like without any frame attached. The settings were turning over that day like every other. They did not get a say, because nothing was being decided.',
  'सेवते का मतलब आज्ञा मानने से ज़्यादा किसी के साथ लगे रहना है, और बिना किसी ढाँचे के उस तरह का ठहराव ऐसा दिखता है। उस दिन भी अवस्थाएँ बाक़ी दिनों जैसी ही बदल रही थीं। उनकी कोई राय नहीं चली, क्योंकि तय कुछ हो ही नहीं रहा था।',
  'Sevate ka matlab agya maanne se zyada kisi ke saath lage rehna hai, aur bina kisi dhaanche ke us tarah ka thehrav aisa dikhta hai. Us din bhi avasthayein baaki dinon jaisi hi badal rahi thin. Unki koi raay nahi chali, kyunki tay kuch ho hi nahi raha tha.',
  'The settings were turning that day like every other. They did not get a say.',
  'उस दिन भी अवस्थाएँ बाक़ी दिनों जैसी बदल रही थीं। उनकी कोई राय नहीं चली।',
  'Us din bhi avasthayein baaki dinon jaisi badal rahi thin. Unki koi raay nahi chali.',
  NULL, 'advanced', 'ethics,steadiness,no-deliberation,character'

  UNION ALL SELECT 26, 'sports', 3,
  'Twenty years at the same club', 'एक ही क्लब में बीस साल', 'Ek hi club mein bees saal',
  'A coach stays at one small club for twenty years through four relegations and two promotions. Asked how he kept going through the bad seasons, he says he never experienced them as a question about whether to keep going.',
  'एक कोच चार बार नीचे जाने और दो बार ऊपर आने के बीच बीस साल एक ही छोटे क्लब में रहता है। पूछने पर कि बुरे सीज़नों में वह चलता कैसे रहा, वह कहता है कि उसने उन्हें कभी इस सवाल की तरह जिया ही नहीं कि चलते रहना है या नहीं।',
  'Ek coach chaar baar neeche jaane aur do baar upar aane ke beech bees saal ek hi chhote club mein rehta hai. Poochhne par ki bure seasonon mein woh chalta kaise raha, woh kehta hai ki usne unhe kabhi is sawal ki tarah jiya hi nahi ki chalte rehna hai ya nahi.',
  'The verse says going past the three settings comes from staying with something without wandering, and here is the ordinary version. He did not manage the bad seasons better than anybody else. They were not, for him, occasions on which the question came up.',
  'श्लोक कहता है कि तीनों अवस्थाओं के पार जाना किसी चीज़ के साथ बिना भटके बने रहने से आता है, और यहाँ उसका रोज़मर्रा रूप है। उसने बुरे सीज़न किसी और से बेहतर नहीं संभाले। वे उसके लिए ऐसे मौक़े थे ही नहीं जिन पर वह सवाल उठता।',
  'Shloka kehta hai ki teenon avasthaon ke paar jaana kisi cheez ke saath bina bhatke bane rehne se aata hai, aur yahan uska rozmarra roop hai. Usne bure season kisi aur se behtar nahi sambhale. Woh uske liye aise mauke the hi nahi jin par woh sawal uthta.',
  'He did not manage the bad seasons better. For him the question did not come up.',
  'उसने बुरे सीज़न बेहतर नहीं संभाले। उसके लिए वह सवाल उठा ही नहीं।',
  'Usne bure season behtar nahi sambhale. Uske liye woh sawal utha hi nahi.',
  NULL, 'intermediate', 'coaching,loyalty,long-haul,steadiness'

  UNION ALL SELECT 26, 'marriage', 4,
  'Neither of them keeps score', 'दोनों में से कोई हिसाब नहीं रखता', 'Dono mein se koi hisaab nahi rakhta',
  'A couple in their sixties are asked what has kept them together. Neither offers a principle. One of them says they have simply never seriously considered the alternative, and the other laughs, which is the same answer.',
  'साठ पार के एक जोड़े से पूछा जाता है कि उन्हें साथ किसने रखा। दोनों में से कोई सिद्धांत नहीं देता। एक कहता है कि उन्होंने कभी गंभीरता से दूसरा विकल्प सोचा ही नहीं, और दूसरा हँस देता है, जो वही जवाब है।',
  'Saath paar ke ek jode se poochha jaata hai ki unhe saath kisne rakha. Dono mein se koi siddhant nahi deta. Ek kehta hai ki unhone kabhi gambhirta se doosra vikalp socha hi nahi, aur doosra hans deta hai, jo wahi jawab hai.',
  'Avyabhicāreṇa, without wandering off. The chapter has spent twenty verses showing that fighting a setting is one more thing happening inside it, and this is the alternative it offers: not better management of the states, but attention that was never up for negotiation in the first place.',
  'अव्यभिचारेण, बिना भटके। अध्याय बीस श्लोक यह दिखाने में लगा चुका है कि किसी अवस्था से लड़ना उसी के भीतर हो रही एक और चीज़ है, और यह उसका दिया विकल्प है: अवस्थाओं का बेहतर प्रबंधन नहीं, बल्कि वह ध्यान जो शुरू से बहस के लिए खुला ही नहीं था।',
  'Avyabhicharen, bina bhatke. Adhyay bees shloka yeh dikhane mein laga chuka hai ki kisi avastha se ladna usi ke bheetar ho rahi ek aur cheez hai, aur yeh uska diya vikalp hai: avasthaon ka behtar prabandhan nahi, balki woh dhyan jo shuru se behes ke liye khula hi nahi tha.',
  'Not better management of the states. Attention that was never up for negotiation.',
  'अवस्थाओं का बेहतर प्रबंधन नहीं। वह ध्यान जो कभी बहस के लिए खुला ही नहीं था।',
  'Avasthaon ka behtar prabandhan nahi. Woh dhyan jo kabhi behes ke liye khula hi nahi tha.',
  NULL, 'intermediate', 'marriage,constancy,steadiness,long-haul'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 14;

-- =====================================================================
-- 5. CROSS REFERENCES
-- =====================================================================
-- TWELVE DECLARED. Every target checked against the seeded verse list
-- first. Count the loaded rows against twelve before shipping.
--
-- The 14.8 -> 6.17 and 14.8 -> 17.19 pair is load-bearing: a reader who
-- has just read tamas as a verdict on themselves should be handed the
-- verse that asks for sleep to be FITTED rather than reduced, and the
-- verse that puts self-punishment in the bottom category.
-- =====================================================================

DELETE x FROM verse_cross_references x JOIN verses v ON v.id = x.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 14;

INSERT INTO verse_cross_references
  (verse_id, reference_type, book, chapter, verse, target_verse_id,
   description_en, description_hi, description_hinglish, relationship, sort_order)
SELECT v.id, 'gita', 'Bhagavad Gita', CAST(x.tch AS CHAR), CAST(x.tvn AS CHAR), tv.id,
       x.d_en, x.d_hi, x.d_hing, x.rel, x.ord
FROM (
  SELECT 5 AS vn, 16 AS tch, 4 AS tvn, 1 AS ord,
    'The corpus''s other sorting chapter, and it has the same trap. 16.4 describes two directions a person can face rather than two kinds of person; 14.10 makes the same argument here by saying the three take turns.' AS d_en,
    'संग्रह का दूसरा छाँटने वाला अध्याय, और उसमें वही जाल है। 16.4 दो तरह के लोगों का नहीं, दो दिशाओं का वर्णन करता है जिनकी तरफ़ इंसान मुँह कर सकता है; 14.10 यहाँ वही दलील यह कहकर देता है कि तीनों बारी-बारी आती हैं।' AS d_hi,
    'Sangrah ka doosra chhaantne wala adhyay, aur usme wahi jaal hai. 16.4 do tarah ke logon ka nahi, do dishaon ka varnan karta hai jinki taraf insan munh kar sakta hai; 14.10 yahan wahi dalil yeh kehkar deta hai ki teenon baari-baari aati hain.' AS d_hing,
    'same' AS rel
  UNION ALL SELECT 5, 17, 2, 1,
    'Chapter 17 sorts what people trust by the same three, and says outright that its tests are behavioural. Read together they close the door on either chapter being used to sort people by anything other than what they did.',
    'सत्रहवाँ अध्याय लोगों के भरोसे को उन्हीं तीन में छाँटता है, और साफ़ कहता है कि उसकी कसौटियाँ बरताव की हैं। साथ पढ़िए तो दोनों अध्यायों का यह इस्तेमाल बंद हो जाता है कि लोगों को उनके किए के अलावा किसी और आधार पर छाँटा जाए।',
    'Satrahvan adhyay logon ke bharose ko unhi teen mein chhaanta hai, aur saaf kehta hai ki uski kasautiyan bartav ki hain. Saath padho to dono adhyayon ka yeh istemaal band ho jaata hai ki logon ko unke kiye ke alawa kisi aur aadhar par chhaanta jaaye.',
    'supports'
  UNION ALL SELECT 6, 2, 48, 1,
    'Evenness in success and failure. 14.6 explains why that has to include success: the pleasant state has a rope of its own, and it is harder to see because nobody wants to cut it.',
    'सफलता और असफलता में समता। 14.6 बताता है कि इसमें सफलता को भी क्यों शामिल होना है: सुखद हालत की अपनी एक रस्सी है, और उसे देखना मुश्किल है क्योंकि उसे कोई काटना नहीं चाहता।',
    'Safalta aur asafalta mein samta. 14.6 batata hai ki isme safalta ko bhi kyun shamil hona hai: sukhad haalat ki apni ek rassi hai, aur use dekhna mushkil hai kyunki use koi kaatna nahi chahta.',
    'supports'
  UNION ALL SELECT 6, 5, 22, 1,
    'Pleasures that come from contact have a beginning and an end, so the sorrow comes out of the same place. 14.6 says the same about the clear state itself, which is a harder thing to hear.',
    'संपर्क से आने वाले सुखों का आरंभ है और अंत है, इसलिए दुख उसी जगह से निकलता है। 14.6 वही बात ख़ुद साफ़ हालत के बारे में कहता है, और यह सुनना ज़्यादा कठिन है।',
    'Sampark se aane wale sukhon ka aarambh hai aur ant hai, isliye dukh usi jagah se nikalta hai. 14.6 wahi baat khud saaf haalat ke baare mein kehta hai, aur yeh sunna zyada kathin hai.',
    'same'
  UNION ALL SELECT 7, 2, 47, 1,
    'The famous one is about attachment to results. 14.7 names a different rope: attachment to the doing itself, which holds even when there is no result in mind.',
    'मशहूर वाला नतीजों से चिपकने पर है। 14.7 अलग रस्सी का नाम लेता है: ख़ुद करने से चिपकना, जो तब भी पकड़े रहती है जब ज़ेहन में कोई नतीजा हो ही नहीं।',
    'Mashhoor wala nateejon se chipakne par hai. 14.7 alag rassi ka naam leta hai: khud karne se chipakna, jo tab bhi pakde rehti hai jab zehan mein koi nateeja ho hi nahi.',
    'opposite'
  UNION ALL SELECT 7, 3, 5, 1,
    'Nobody stays actionless even for a moment. 14.7 is what that looks like when it has become a grip rather than a fact — the difference between acting and not being able to stop.',
    'कोई एक क्षण भी बिना कर्म के नहीं रहता। 14.7 वह है जब यह तथ्य नहीं, पकड़ बन जाए — कर्म करने और रुक न पाने का फ़र्क़।',
    'Koi ek pal bhi bina karm ke nahi rehta. 14.7 woh hai jab yeh tathya nahi, pakad ban jaaye — karm karne aur ruk na paane ka farq.',
    'supports'
  UNION ALL SELECT 8, 6, 17, 1,
    'Read this immediately after 14.8. It asks for sleep to be FITTED rather than reduced, and rules out too little as firmly as too much. Nothing in chapter 14 puts rest on trial, and 6.17 is the proof.',
    '14.8 के तुरंत बाद यह पढ़िए। यह नींद को कम करने को नहीं, नाप का होने को कहता है, और "बहुत कम" को उतनी ही मज़बूती से ख़ारिज करता है जितना "बहुत ज़्यादा"। चौदहवें अध्याय में कहीं आराम पर मुक़दमा नहीं है, और 6.17 उसका सबूत है।',
    '14.8 ke turant baad yeh padho. Yeh neend ko kam karne ko nahi, naap ka hone ko kehta hai, aur "bahut kam" ko utni hi mazbooti se khaarij karta hai jitna "bahut zyada". Chaudahve adhyay mein kahin aaram par mukadma nahi hai, aur 6.17 uska saboot hai.',
    'opposite'
  UNION ALL SELECT 8, 17, 19, 1,
    'The other one to read next. If 14.8 has produced a verdict about yourself, 17.19 is the text putting practice-as-punishment in its own bottom category — so the verdict is not something the book is asking for.',
    'आगे पढ़ने लायक़ दूसरा। अगर 14.8 से अपने बारे में कोई फ़ैसला बना है, तो 17.19 वह जगह है जहाँ ग्रंथ ख़ुद अभ्यास-को-सज़ा-बनाने को सबसे नीचे रखता है — यानी वह फ़ैसला किताब की माँग नहीं है।',
    'Aage padhne layak doosra. Agar 14.8 se apne baare mein koi faisla bana hai, to 17.19 woh jagah hai jahan granth khud abhyas-ko-saza-banane ko sabse neeche rakhta hai — yani woh faisla kitaab ki maang nahi hai.',
    'opposite'
  UNION ALL SELECT 11, 6, 19, 1,
    'The lamp in the windless place. Both verses locate a good state in what is absent rather than in what is being done, and both are readings of a moment rather than of a person.',
    'बिना हवा की जगह पर रखा दीया। दोनों श्लोक अच्छी हालत को इसमें रखते हैं कि क्या ग़ैरहाज़िर है, इसमें नहीं कि क्या किया जा रहा है, और दोनों किसी इंसान का नहीं, किसी पल का पाठ हैं।',
    'Bina hawa ki jagah par rakha diya. Dono shloka achhi haalat ko isme rakhte hain ki kya gairhazir hai, isme nahi ki kya kiya ja raha hai, aur dono kisi insan ka nahi, kisi pal ka paath hain.',
    'same'
  UNION ALL SELECT 22, 2, 14, 1,
    'They come and they go, so bear them. 14.22 is the same instruction with the good ones included: not longing for the light either, which is the half people leave out.',
    'वे आते हैं और जाते हैं, इसलिए सह लीजिए। 14.22 वही हिदायत है, अच्छे वालों को भी शामिल करके: रोशनी को भी याद न करना, और यही वह आधा है जिसे लोग छोड़ देते हैं।',
    'Woh aate hain aur jaate hain, isliye seh lo. 14.22 wahi hidayat hai, achhe walon ko bhi shamil karke: roshni ko bhi yaad na karna, aur yahi woh aadha hai jise log chhod dete hain.',
    'same'
  UNION ALL SELECT 23, 6, 6, 1,
    'The suffix that makes this verse. 6.6 says the mind behaves LIKE an enemy without being one; 14.23 says he is seated LIKE somebody uninvolved without being uninvolved. Same construction, same work.',
    'वह प्रत्यय जो इस श्लोक को बनाता है। 6.6 कहता है कि मन शत्रु हुए बिना शत्रु जैसा बरतता है; 14.23 कहता है कि वह उदासीन हुए बिना उदासीन जैसा बैठा है। वही बनावट, वही काम।',
    'Woh pratyay jo is shloka ko banata hai. 6.6 kehta hai ki man shatru hue bina shatru jaisa bartta hai; 14.23 kehta hai ki woh udaseen hue bina udaseen jaisa baitha hai. Wahi banawat, wahi kaam.',
    'same'
  UNION ALL SELECT 23, 12, 13, 1,
    'Eight verses on somebody friendly to every being and steady in pleasure and pain — and it is the same person 14.23 describes. If a reading of 14.23 makes that person impossible, the reading is wrong.',
    'आठ श्लोक ऐसे इंसान पर जो हर प्राणी से मित्रवत है और सुख-दुख में समान — और यह वही इंसान है जिसका 14.23 वर्णन करता है। अगर 14.23 का कोई पाठ उस इंसान को नामुमकिन कर दे, तो पाठ ग़लत है।',
    'Aath shloka aise insan par jo har prani se mitravat hai aur sukh-dukh mein saman — aur yeh wahi insan hai jiska 14.23 varnan karta hai. Agar 14.23 ka koi paath us insan ko namumkin kar de, to paath galat hai.',
    'supports'
) AS x
JOIN verses v  ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 14
JOIN chapters tc ON tc.chapter_number = x.tch
JOIN verses tv ON tv.verse_number = x.tvn AND tv.chapter_id = tc.id;

-- =====================================================================
-- 6. WORD BY WORD
-- =====================================================================
-- Three glosses carry the chapter's safeguards:
--   guṇāḥ (14.5)      says strand or setting, never "type of person"
--   ajñāna-jam (14.8) says born of NOT-SEEING, and that tiredness is a
--                     different thing
--   udāsīna-vat (14.23) says the -vat suffix is doing real work
-- All glosses stay under 400 characters — the column is varchar(400).
-- =====================================================================

DELETE w FROM verse_word_meanings w JOIN verses v ON v.id = w.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 14;

INSERT INTO verse_word_meanings
  (verse_id, word_order, devanagari, transliteration,
   meaning_en, meaning_hi, meaning_hinglish, grammar, root_word)
SELECT v.id, w.ord, w.dev, w.tr, w.m_en, w.m_hi, w.m_hing, w.gram, w.root FROM (

  SELECT 5 AS vn, 1 AS ord, 'गुणाः' AS dev, 'guṇāḥ' AS tr, 'strands, settings — literally the threads of a rope. NOT "types of person" and not "virtues". A guṇa is what is running, and 14.10 says the three take turns in the same person' AS m_en, 'गुण — धागे, अवस्थाएँ; शब्दशः रस्सी की लड़ें। "क़िस्म के लोग" नहीं और "सद्गुण" नहीं। गुण वह है जो चल रहा है, और 14.10 कहता है कि तीनों उसी इंसान में बारी-बारी आती हैं' AS m_hi, 'gun — dhage, avasthayein; shabdashah rassi ki ladein. "Kism ke log" nahi aur "sadgun" nahi. Gun woh hai jo chal raha hai, aur 14.10 kehta hai ki teenon usi insan mein baari-baari aati hain' AS m_hing, 'nominative plural' AS gram, 'गुण' AS root
  UNION ALL SELECT 5, 2, 'प्रकृतिसम्भवाः', 'prakṛti-sambhavāḥ', 'arising from prakṛti — from the material a person is made of and standing in, rather than from a decision they took', 'प्रकृति से उत्पन्न — उस सामग्री से जिससे इंसान बना है और जिसमें वह खड़ा है, न कि किसी लिए हुए फ़ैसले से', 'prakriti se utpann — us samagri se jisse insan bana hai aur jisme woh khada hai, na ki kisi liye hue faisle se', 'nominative plural', 'सम् + भू'
  UNION ALL SELECT 5, 3, 'निबध्नन्ति', 'nibadhnanti', 'they bind — plural, and it covers all three. Including the clear one', 'वे बाँधते हैं — बहुवचन, और यह तीनों पर लागू है। साफ़ वाली पर भी', 'woh baandhte hain — bahuvachan, aur yeh teenon par laagu hai. Saaf wali par bhi', 'present, third plural', 'नि + बन्ध्'
  UNION ALL SELECT 5, 4, 'देहिनम् अव्ययम्', 'dehinam avyayam', 'the imperishable one dwelling in the body — what is bound is not the settings and not the body', 'शरीर में रहने वाला अव्यय — जो बँधता है वह न अवस्थाएँ हैं और न शरीर', 'sharir mein rehne wala avyay — jo bandhta hai woh na avasthayein hain aur na sharir', 'accusative singular', 'देह, वि + इ'

  UNION ALL SELECT 6, 1, 'निर्मलत्वात्', 'nirmalatvāt', 'because of being without stain — clear in the sense of transparent, not in the sense of virtuous', 'निर्मल होने के कारण — साफ़ इस अर्थ में कि पारदर्शी, इस अर्थ में नहीं कि पुण्यवान', 'nirmal hone ke kaaran — saaf is arth mein ki paardarshi, is arth mein nahi ki punyavan', 'ablative singular', 'मल'
  UNION ALL SELECT 6, 2, 'प्रकाशकम् अनामयम्', 'prakāśakam anāmayam', 'illuminating and free of affliction — the two good things said about it, immediately before the word that matters', 'प्रकाशित करने वाला और पीड़ा रहित — इसके बारे में कही गई दो अच्छी बातें, ठीक उस शब्द से पहले जो मायने रखता है', 'prakashit karne wala aur peeda rahit — iske baare mein kahi gayi do achhi baatein, theek us shabd se pehle jo maayne rakhta hai', 'accusative singular', 'काश्, आमय'
  UNION ALL SELECT 6, 3, 'बध्नाति', 'badhnāti', 'it binds — the word the verse is here for, said of the good one', 'वह बाँधता है — वही शब्द जिसके लिए श्लोक है, और वह अच्छी वाली के बारे में कहा गया है', 'woh baandhta hai — wahi shabd jiske liye shloka hai, aur woh achhi wali ke baare mein kaha gaya hai', 'present, third singular', 'बन्ध्'
  UNION ALL SELECT 6, 4, 'सुखसङ्गेन', 'sukha-saṅgena', 'by attachment to happiness — the first rope. Not by happiness; by the sticking to it', 'सुख से चिपकने से — पहली रस्सी। सुख से नहीं; उससे चिपकने से', 'sukh se chipakne se — pehli rassi. Sukh se nahi; usse chipakne se', 'instrumental singular', 'सञ्ज्'
  UNION ALL SELECT 6, 5, 'ज्ञानसङ्गेन', 'jñāna-saṅgena', 'by attachment to knowing — the second rope, and the harder one to notice because it looks like progress', 'ज्ञान से चिपकने से — दूसरी रस्सी, और देखने में ज़्यादा मुश्किल क्योंकि यह तरक़्क़ी जैसी दिखती है', 'gyan se chipakne se — doosri rassi, aur dekhne mein zyada mushkil kyunki yeh tarakki jaisi dikhti hai', 'instrumental singular', 'ज्ञा + सञ्ज्'

  UNION ALL SELECT 7, 1, 'रागात्मकम्', 'rāgātmakam', 'having the nature of rāga — colour, pull, wanting. Rāga is also the word for a musical mode, and both senses are about something that colours everything else', 'रागात्मक — रंग, खिंचाव, चाह के स्वभाव वाला। राग संगीत की पद्धति का भी शब्द है, और दोनों अर्थ उस चीज़ के बारे में हैं जो बाक़ी सब पर रंग चढ़ा देती है', 'ragatmak — rang, khinchav, chaah ke swabhav wala. Raag sangeet ki paddhati ka bhi shabd hai, aur dono arth us cheez ke baare mein hain jo baaki sab par rang chadha deti hai', 'accusative singular', 'रञ्ज्'
  UNION ALL SELECT 7, 2, 'तृष्णा', 'tṛṣṇā', 'thirst — the same root as "thirst" in English, and it means the wanting rather than the thing wanted', 'तृष्णा — प्यास; यह चाही हुई चीज़ नहीं, चाहना है', 'trishna — pyaas; yeh chaahi hui cheez nahi, chahna hai', 'in compound', 'तृष्'
  UNION ALL SELECT 7, 3, 'कर्मसङ्गेन', 'karma-saṅgena', 'by attachment to ACTION — not to results. This is the whole use of the verse: the rope holds even when nothing is expected from the doing', 'कर्म से चिपकने से — नतीजों से नहीं। श्लोक का पूरा काम यही है: रस्सी तब भी पकड़े रहती है जब करने से कुछ अपेक्षित ही न हो', 'karm se chipakne se — nateejon se nahi. Shloka ka poora kaam yahi hai: rassi tab bhi pakde rehti hai jab karne se kuch apekshit hi na ho', 'instrumental singular', 'कृ + सञ्ज्'

  UNION ALL SELECT 8, 1, 'अज्ञानजम्', 'ajñāna-jam', 'BORN OF NOT-KNOWING. This is the definition and it comes before any behaviour is listed. It names a state in which nothing is being seen — which is not the same as being tired. Somebody exhausted can see perfectly well what is happening to them', 'अज्ञान से उपजा। यही परिभाषा है और यह किसी भी बरताव के गिनाए जाने से पहले आती है। यह ऐसी हालत का नाम है जिसमें कुछ दिख ही नहीं रहा — और यह थका होने जैसा नहीं है। बुरी तरह थका कोई ठीक-ठीक देख सकता है कि उसके साथ क्या हो रहा है', 'agyan se upja. Yahi paribhasha hai aur yeh kisi bhi bartav ke ginaye jaane se pehle aati hai. Yeh aisi haalat ka naam hai jisme kuch dikh hi nahi raha — aur yeh thaka hone jaisa nahi hai. Buri tarah thaka koi theek theek dekh sakta hai ki uske saath kya ho raha hai', 'accusative singular', 'ज्ञा + जन्'
  UNION ALL SELECT 8, 2, 'मोहनम्', 'mohanam', 'clouding, bewildering — the same root as moha, and it is about things not being distinguishable rather than about not caring', 'मोहन — धुँधलाना, भ्रमित करना; वही धातु जो मोह की है, और यह चीज़ों के अलग न दिखने के बारे में है, परवाह न होने के बारे में नहीं', 'mohan — dhundhlana, bhramit karna; wahi dhatu jo moh ki hai, aur yeh cheezon ke alag na dikhne ke baare mein hai, parwah na hone ke baare mein nahi', 'accusative singular', 'मुह्'
  UNION ALL SELECT 8, 3, 'प्रमाद', 'pramāda', 'not noticing, heedlessness — the first of the three, and often the only one actually running', 'प्रमाद — ध्यान का न जाना; तीनों में पहला, और अक्सर अकेला जो सचमुच चल रहा होता है', 'pramad — dhyan ka na jaana; teenon mein pehla, aur aksar akela jo sach mein chal raha hota hai', 'in compound', 'प्र + मद्'
  UNION ALL SELECT 8, 4, 'आलस्य', 'ālasya', 'not starting — the gap between intending and beginning, rather than a judgement on somebody who rests', 'आलस्य — शुरू न कर पाना; इरादे और आरंभ के बीच का फ़ासला, आराम करने वाले पर कोई फ़ैसला नहीं', 'aalasya — shuru na kar paana; iraade aur aarambh ke beech ka faasla, aaram karne wale par koi faisla nahi', 'in compound', 'अलस्'
  UNION ALL SELECT 8, 5, 'निद्रा', 'nidrā', 'going under. Read with 6.17, which asks for sleep to be FITTED and rules out too little as firmly as too much, this cannot be a verse against rest', 'निद्रा — डूब जाना। 6.17 के साथ पढ़िए, जो नींद को नाप का होने को कहता है और "बहुत कम" को उतनी ही मज़बूती से ख़ारिज करता है — तो यह आराम के ख़िलाफ़ श्लोक हो ही नहीं सकता', 'nidra — doob jaana. 6.17 ke saath padho, jo neend ko naap ka hone ko kehta hai aur "bahut kam" ko utni hi mazbooti se khaarij karta hai — to yeh aaram ke khilaf shloka ho hi nahi sakta', 'in compound', 'नि + द्रा'

  UNION ALL SELECT 11, 1, 'सर्वद्वारेषु', 'sarva-dvāreṣu', 'in ALL the gates — the senses. "All" is doing work: not the ones being pointed at, all of them at once', 'सारे दरवाज़ों में — इंद्रियों में। "सारे" काम कर रहा है: वे नहीं जिनकी तरफ़ इशारा है, बल्कि सब एक साथ', 'saare darwazon mein — indriyon mein. "Saare" kaam kar raha hai: woh nahi jinki taraf ishara hai, balki sab ek saath', 'locative plural', 'द्वार'
  UNION ALL SELECT 11, 2, 'प्रकाशः उपजायते', 'prakāśa upajāyate', 'light arises — arises, not is produced. The verse describes a condition being met rather than an effort succeeding', 'प्रकाश उपजता है — उपजता है, बनाया नहीं जाता। श्लोक किसी मेहनत के सफल होने का नहीं, किसी शर्त के पूरे होने का वर्णन करता है', 'prakash upajta hai — upajta hai, banaya nahi jaata. Shloka kisi mehnat ke safal hone ka nahi, kisi shart ke poore hone ka varnan karta hai', 'present, third singular', 'उप + जन्'
  UNION ALL SELECT 11, 3, 'विवृद्धम्', 'vivṛddham', 'grown, increased — a reading of NOW. Not a permanent state and not a rank', 'विवृद्ध — बढ़ा हुआ; यह अभी का पाठ है। न स्थायी हालत, न कोई दर्जा', 'vivriddh — badha hua; yeh abhi ka paath hai. Na sthayi haalat, na koi darja', 'accusative singular', 'वि + वृध्'

  UNION ALL SELECT 22, 1, 'न द्वेष्टि', 'na dveṣṭi', 'does not hate — said of all three, including the fog. This is the half most readers skip', 'द्वेष नहीं करता — तीनों के बारे में कहा गया, धुंध के बारे में भी। ज़्यादातर पढ़ने वाले यही आधा लाँघ जाते हैं', 'dwesh nahi karta — teenon ke baare mein kaha gaya, dhundh ke baare mein bhi. Zyadatar padhne wale yahi aadha laangh jaate hain', 'present, third singular', 'द्विष्'
  UNION ALL SELECT 22, 2, 'सम्प्रवृत्तानि', 'sampravṛttāni', 'when they have fully arisen — the participle makes it about the moment of arrival', 'जब वे पूरी तरह उठ आई हों — कृदंत इसे आने के पल के बारे में बना देता है', 'jab woh poori tarah uth aayi hon — kridant ise aane ke pal ke baare mein bana deta hai', 'accusative plural', 'सम् + प्र + वृत्'
  UNION ALL SELECT 22, 3, 'न निवृत्तानि काङ्क्षति', 'na nivṛttāni kāṅkṣati', 'does not long for them when they have ceased — including the light. Giving this up is a real cost and the verse does not pretend otherwise', 'जब वे रुक गई हों तो उन्हें नहीं तरसता — रोशनी को भी नहीं। इसे छोड़ने की असली क़ीमत है और श्लोक इसका बहाना नहीं बनाता', 'jab woh ruk gayi hon to unhe nahi tarasta — roshni ko bhi nahi. Ise chhodne ki asli keemat hai aur shloka iska bahana nahi banata', 'present, third singular', 'काङ्क्ष्'

  UNION ALL SELECT 23, 1, 'उदासीनवत्', 'udāsīna-vat', 'LIKE one uninvolved. The -vat suffix is doing real work — same construction as śatru-vat in 6.6, where the mind behaves like an enemy without being one. He is not uninvolved; he is seated as though he were. Drop the suffix and the verse becomes a licence to stop caring, which it is not', 'उदासीन जैसा। -वत् प्रत्यय असल काम कर रहा है — वही बनावट जो 6.6 में शत्रु-वत् की है, जहाँ मन शत्रु हुए बिना शत्रु जैसा बरतता है। वह उदासीन नहीं है; वह ऐसे बैठा है जैसे हो। प्रत्यय हटा दीजिए और श्लोक परवाह छोड़ने की छूट बन जाता है, जो वह नहीं है', 'udaseen jaisa. -vat pratyay asal kaam kar raha hai — wahi banawat jo 6.6 mein shatru-vat ki hai, jahan man shatru hue bina shatru jaisa bartta hai. Woh udaseen nahi hai; woh aise baitha hai jaise ho. Pratyay hata do aur shloka parwah chhodne ki chhoot ban jaata hai, jo woh nahi hai', 'adverbial suffix', 'उद् + आस्'
  UNION ALL SELECT 23, 2, 'न विचाल्यते', 'na vicālyate', 'is not made to move about — passive. Something would have to move him, and nothing does', 'हिलाया नहीं जाता — कर्मवाच्य। उसे कुछ हिलाना पड़ता, और कुछ हिला नहीं पाता', 'hilaya nahi jaata — karmvachya. Use kuch hilana padta, aur kuch hila nahi pata', 'passive, third singular', 'वि + चल्'
  UNION ALL SELECT 23, 3, 'गुणा वर्तन्ते इति एव', 'guṇā vartanta ity eva', '"the settings alone are turning" — eva restricts it: it is the settings doing the turning, not him', '"बस अवस्थाएँ ही बदल रही हैं" — एव इसे सीमित करता है: बदल अवस्थाएँ रही हैं, वह नहीं', '"bas avasthayein hi badal rahi hain" — ev ise seemit karta hai: badal avasthayein rahi hain, woh nahi', 'present middle, third plural', 'वृत्'
  UNION ALL SELECT 23, 4, 'न इङ्गते', 'neṅgate', 'does not stir, does not waver — a small physical word, closer to a flicker than to a stance', 'हिलता नहीं, डिगता नहीं — छोटा शारीरिक शब्द, किसी रुख़ से ज़्यादा एक कँपकँपी के पास', 'hilta nahi, digta nahi — chhota sharirik shabd, kisi rukh se zyada ek kampkampi ke paas', 'present middle, third singular', 'इङ्ग्'

  UNION ALL SELECT 26, 1, 'अव्यभिचारेण', 'avyabhicāreṇa', 'without wandering off, without going elsewhere — the transferable part of the verse. It is about attention that does not stray, whatever the frame', 'बिना भटके, कहीं और गए बिना — श्लोक का वह हिस्सा जो ले जाया जा सकता है। यह उस ध्यान के बारे में है जो भटकता नहीं, ढाँचा जो भी हो', 'bina bhatke, kahin aur gaye bina — shloka ka woh hissa jo le jaya ja sakta hai. Yeh us dhyan ke baare mein hai jo bhatakta nahi, dhaancha jo bhi ho', 'instrumental singular', 'वि + अभि + चर्'
  UNION ALL SELECT 26, 2, 'भक्तियोगेन', 'bhakti-yogena', 'by the yoga of devotion — addressed to somebody who has that frame or wants it; a reader who does not is not being asked to pretend', 'भक्तियोग से — उसे संबोधित जिसके पास वह ढाँचा है या जो उसे चाहता है; जो पाठक इसे साझा नहीं करता उससे दिखावे की माँग नहीं है', 'bhakti-yog se — use sambodhit jiske paas woh dhaancha hai ya jo use chahta hai; jo paathak ise sajha nahi karta usse dikhave ki maang nahi hai', 'instrumental singular', 'भज्'
  UNION ALL SELECT 26, 3, 'सेवते', 'sevate', 'attends on, stays with — closer to keeping company than to obeying', 'सेवा करता है, साथ लगा रहता है — आज्ञा मानने से ज़्यादा साथ बने रहने के पास', 'seva karta hai, saath laga rehta hai — agya maanne se zyada saath bane rehne ke paas', 'present middle, third singular', 'सेव्'
  UNION ALL SELECT 26, 4, 'समतीत्य', 'samatītya', 'having gone completely past — not having defeated them and not having managed them. Past', 'पूरी तरह पार जाकर — उन्हें हराकर नहीं और उन्हें संभालकर नहीं। पार', 'poori tarah paar jaakar — unhe harakar nahi aur unhe sambhalkar nahi. Paar', 'gerund', 'सम् + अति + इ'
) AS w
JOIN verses v ON v.verse_number = w.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 14;
