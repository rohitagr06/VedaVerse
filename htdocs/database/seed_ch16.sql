-- =====================================================================
-- VedaVerse — database/seed_ch16.sql
-- =====================================================================
-- Chapter 16, Daivāsura Sampad Vibhāga Yoga. Eight verses.
--
--   16.1   the first list opens with fearlessness
--   16.3   the rest of it, and it is unglamorous
--   16.4   the second list — six things, all recognisable
--   16.5   do not grieve; you are of the first kind      [MANDATORY]
--   16.10  the appetite that cannot be filled, wearing a face
--   16.13  the internal monologue, transcribed
--   16.16  the net, and what being caught in it looks like
--   16.21  three gates: wanting, anger, grabbing
--
-- THIS IS THE MOST DANGEROUS CHAPTER IN THE BOOK TO TEACH BADLY
--   It names two sets of qualities and calls one daivī and the other
--   āsurī. Read as a taxonomy of PERSONS, it hands anybody a vocabulary
--   for deciding that some people are a different kind of thing — and
--   that vocabulary has been used, in living memory, against
--   communities. A product teaching this text to beginners does not get
--   to leave that to inference.
--
--   Three things carry the safeguard, and all three are load-bearing:
--
--   1. The 16.4 explanation states that the chapter describes two
--      DIRECTIONS a person can face, not two kinds of person, and that
--      the second list is a list of things every reader has done.
--
--   2. The 16.5 explanation is the one that cannot be softened. The
--      moment the chapter could become a weapon, the text itself
--      defuses it: Krishna turns to the person in front of him and says
--      do not grieve, you are of the first kind. He does not audit
--      Arjuna. He reassures him, immediately, before the long
--      description that follows. Any reading in which this chapter
--      sorts other people has to explain that line away, and cannot.
--
--   3. Not one example, reflection or gloss in this file maps either
--      list onto a group, a profession, a party, a region or a
--      community. Two of the examples show the SAME person facing both
--      directions inside one week, which is the reading the chapter
--      supports and the strongest available answer to the other one.
--
-- ASURA AND NARAKA ARE TRANSLATED, NOT SENSATIONALISED
--   "Asura" is glossed as what the word does in this chapter — a
--   direction of character — rather than as "demon", which imports a
--   creature the verses are not discussing. "Naraka" is glossed as the
--   text's own word for where the trajectory ends, without illustration
--   and without an afterlife claim the product is not in a position to
--   make either way.
--
-- CONTENT RULES — unchanged, and this is the file they exist for
--   Original writing throughout. Sanskrit unaltered, numbering
--   untouched. No praise or criticism of any living politician, party
--   or movement. No communal framing anywhere. Nothing in this file
--   describes any group of people as belonging to either list.
--
-- RUN AFTER seed_sample.sql. Re-runnable.
--
--     mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
--         < htdocs/database/seed_ch16.sql
--
-- global_order is 571 + verse_number: chapters 1 to 15 have 571 verses
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

  SELECT 1 AS verse_number, 572 AS global_order, 1 AS is_curated, 'gita-16-1' AS slug,
    'अभयं सत्त्वसंशुद्धिर्ज्ञानयोगव्यवस्थितिः।\nदानं दमश्च यज्ञश्च स्वाध्यायस्तप आर्जवम्॥' AS sanskrit_devanagari,
    'abhayaṁ sattva-saṁśuddhir jñāna-yoga-vyavasthitiḥ\ndānaṁ damaś ca yajñaś ca svādhyāyas tapa ārjavam' AS transliteration_iast,
    'abhayam sattva-samshuddhir jnana-yoga-vyavasthitih\ndanam damash cha yajnash cha svadhyayas tapa arjavam' AS transliteration_simple,
    'Fearlessness, purity of being, steadiness in the yoga of knowledge, giving, restraint, sacrifice, self-study, austerity, straightness.' AS translation_literal,
    'Not being afraid. Being clear inside. Staying with what you understand. Giving. Holding yourself back. Putting something in. Reading yourself honestly. Doing without. Being straight.' AS translation_en,
    'डर में न रहना। भीतर से साफ़ होना। जो समझा है उस पर टिके रहना। देना। ख़ुद को रोक पाना। कुछ डालना। ख़ुद को ईमानदारी से पढ़ना। बिना काम चलाना। सीधा होना।' AS translation_hi,
    'Dar mein na rehna. Bheetar se saaf hona. Jo samjha hai us par tike rehna. Dena. Khud ko rok paana. Kuch daalna. Khud ko imaandari se padhna. Bina kaam chalana. Seedha hona.' AS translation_hinglish,
    'The first list opens with fearlessness, which tells you what the whole chapter thinks the root is.' AS summary_en,
    'पहली सूची अभय से शुरू होती है, जिससे पता चलता है कि पूरा अध्याय जड़ किसे मानता है।' AS summary_hi,
    'Pehli list abhay se shuru hoti hai, jisse pata chalta hai ki poora chapter jad kise maanta hai.' AS summary_hinglish,
    'beginner' AS difficulty,
    'Gita 16.1: the list that begins with fearlessness' AS seo_title,
    'The Bhagavad Gita opens its list of one direction of character with abhayam — fearlessness. Everything after it is downstream of that choice of first word.' AS seo_description,
    1 AS published

  UNION ALL SELECT 3, 574, 1, 'gita-16-3',
    'तेजः क्षमा धृतिः शौचमद्रोहो नातिमानिता।\nभवन्ति सम्पदं दैवीमभिजातस्य भारत॥',
    'tejaḥ kṣamā dhṛtiḥ śaucam adroho nāti-mānitā\nbhavanti sampadaṁ daivīm abhijātasya bhārata',
    'tejah kshama dhritih shaucham adroho nati-manita\nbhavanti sampadam daivim abhijatasya bharata',
    'Vigour, forgiveness, firmness, cleanliness, absence of malice, absence of excessive pride — these belong to one born to the divine nature, Bharata.',
    'Force in you. Letting things go. Not giving up partway. Clean dealings. Wishing nobody harm. And not thinking too much of yourself. These belong to somebody facing the first direction.',
    'भीतर दम। बातें छोड़ देना। बीच में हार न मानना। साफ़ लेन-देन। किसी का बुरा न चाहना। और ख़ुद को बहुत बड़ा न समझना। ये उस व्यक्ति के हैं जो पहली दिशा की तरफ़ है।',
    'Bheetar dam. Baatein chhod dena. Beech mein haar na maanna. Saaf len-den. Kisi ka bura na chahna. Aur khud ko bahut bada na samajhna. Yeh us insaan ke hain jo pehli disha ki taraf hai.',
    'Six more, and the last one quietly disqualifies anybody using the list to rank themselves.',
    'छह और, और आख़िरी वाली चुपचाप उसे बाहर कर देती है जो इस सूची से ख़ुद को ऊँचा बता रहा हो।',
    'Chhah aur, aur aakhiri wali chupchap use bahar kar deti hai jo is list se khud ko ooncha bata raha ho.',
    'beginner',
    'Gita 16.3: the quality that disqualifies you for claiming it',
    'The Bhagavad Gita ends its first list with na-ati-manita — not thinking too much of yourself. Anybody using the list to rank themselves has just failed the last item.',
    1

  UNION ALL SELECT 4, 575, 1, 'gita-16-4',
    'दम्भो दर्पोऽभिमानश्च क्रोधः पारुष्यमेव च।\nअज्ञानं चाभिजातस्य पार्थ सम्पदमासुरीम्॥',
    'dambho darpo ''bhimānaś ca krodhaḥ pāruṣyam eva ca\najñānaṁ cābhijātasya pārtha sampadam āsurīm',
    'dambho darpo bhimanash cha krodhah parushyam eva cha\najnanam chabhijatasya partha sampadam asurim',
    'Show, arrogance, self-importance, anger, harshness and unknowing belong to one born to the āsurī nature, Partha.',
    'Performing rather than being. Swagger. Thinking too much of yourself. Anger. Being hard on people. And not knowing that any of it is happening. These belong to somebody facing the other direction.',
    'होना नहीं, दिखाना। अकड़। ख़ुद को बहुत बड़ा समझना। गुस्सा। लोगों के साथ सख़्ती। और यह पता न होना कि इनमें से कुछ हो भी रहा है। ये उस व्यक्ति के हैं जो दूसरी दिशा की तरफ़ है।',
    'Hona nahi, dikhana. Akad. Khud ko bahut bada samajhna. Gussa. Logon ke saath sakhti. Aur yeh pata na hona ki inme se kuch ho bhi raha hai. Yeh us insaan ke hain jo doosri disha ki taraf hai.',
    'Six things, and every reader has done all six. That is the point, and it is not a list of people.',
    'छह बातें, और हर पाठक ने छहों की हैं। बात यही है, और यह लोगों की सूची नहीं है।',
    'Chhah baatein, aur har padhne wale ne chhahon ki hain. Baat yahi hai, aur yeh logon ki list nahi hai.',
    'intermediate',
    'Gita 16.4: six things, and you have done all six',
    'The Bhagavad Gita lists show, swagger, self-importance, anger, harshness and unknowing. It describes a direction a person can face, not a category of person.',
    1

  UNION ALL SELECT 5, 576, 1, 'gita-16-5',
    'दैवी सम्पद्विमोक्षाय निबन्धायासुरी मता।\nमा शुचः सम्पदं दैवीमभिजातोऽसि पाण्डव॥',
    'daivī sampad vimokṣāya nibandhāyāsurī matā\nmā śucaḥ sampadaṁ daivīm abhijāto ''si pāṇḍava',
    'daivi sampad vimokshaya nibandhayasuri mata\nma shuchah sampadam daivim abhijato si pandava',
    'The divine endowment is held to lead to freedom, the āsurī to bondage. Do not grieve; you are born to the divine endowment, Pandava.',
    'One direction opens things out. The other ties them up. Then, straight away: do not be upset — you are of the first kind.',
    'एक दिशा चीज़ों को खोलती है। दूसरी उन्हें बाँध देती है। और फिर, तुरंत: परेशान मत होइए — आप पहली वाले हैं।',
    'Ek disha cheezon ko kholti hai. Doosri unhe baandh deti hai. Aur phir, turant: pareshan mat ho — tum pehle wale ho.',
    'The moment the chapter could become a weapon, the text takes it out of the reader''s hand.',
    'जिस क्षण यह अध्याय हथियार बन सकता था, ग्रंथ उसे पाठक के हाथ से ले लेता है।',
    'Jis pal yeh chapter hathiyar ban sakta tha, granth use padhne wale ke haath se le leta hai.',
    'beginner',
    'Gita 16.5: do not grieve, you are of the first kind',
    'The Bhagavad Gita names two directions and then immediately reassures the person listening. The line that stops this chapter becoming a way of sorting other people.',
    1

  UNION ALL SELECT 10, 581, 1, 'gita-16-10',
    'काममाश्रित्य दुष्पूरं दम्भमानमदान्विताः।\nमोहाद्गृहीत्वासद्ग्राहान्प्रवर्तन्तेऽशुचिव्रताः॥',
    'kāmam āśritya duṣpūraṁ dambha-māna-madānvitāḥ\nmohād gṛhītvāsad-grāhān pravartante ''śuci-vratāḥ',
    'kamam ashritya dushpuram dambha-mana-madanvitah\nmohad grihitvasad-grahan pravartante shuchi-vratah',
    'Taking shelter in insatiable desire, filled with show, self-importance and intoxication, having seized false notions through delusion, they act with impure resolve.',
    'Leaning on a want that cannot be filled. Carrying show, self-importance and a kind of drunkenness. Holding on to things that are not true because letting go would cost something. And then acting on all of it, steadily.',
    'ऐसी चाह के सहारे जो भर ही नहीं सकती। दिखावा, अपने बड़प्पन का भाव और एक तरह का नशा साथ लिए। ऐसी बातों को थामे जो सच नहीं हैं, क्योंकि छोड़ना महँगा पड़ता। और फिर इन सबके हिसाब से लगातार काम करते हुए।',
    'Aisi chaah ke sahare jo bhar hi nahi sakti. Dikhava, apne badappan ka bhaav aur ek tarah ka nasha saath liye. Aisi baaton ko thame jo sach nahi hain, kyunki chhodna mehnga padta. Aur phir in sabke hisaab se lagatar kaam karte hue.',
    'The appetite from 3.37 again, this time wearing a face and giving reasons.',
    '3.37 वाली भूख फिर से, इस बार चेहरा ओढ़े और वजहें देती हुई।',
    '3.37 wali bhookh phir se, is baar chehra odhe aur wajahein deti hui.',
    'intermediate',
    'Gita 16.10: the want that cannot be filled, wearing a face',
    'The Bhagavad Gita describes leaning on an insatiable want, carrying show and self-importance, and holding false notions because letting go would cost something.',
    1

  UNION ALL SELECT 13, 584, 1, 'gita-16-13',
    'इदमद्य मया लब्धमिमं प्राप्स्ये मनोरथम्।\nइदमस्तीदमपि मे भविष्यति पुनर्धनम्॥',
    'idam adya mayā labdham imaṁ prāpsye manoratham\nidam astīdam api me bhaviṣyati punar dhanam',
    'idam adya maya labdham imam prapsye manoratham\nidam astidam api me bhavishyati punar dhanam',
    'This today has been gained by me; this desire I shall obtain. This is mine; this wealth also shall be mine hereafter.',
    'Got this today. Will get that next. This one is already mine. And that will be mine too, after.',
    'यह आज मिल गया। वह अगला मिलेगा। यह तो पहले से मेरा है। और वह भी मेरा हो जाएगा, उसके बाद।',
    'Yeh aaj mil gaya. Woh agla milega. Yeh to pehle se mera hai. Aur woh bhi mera ho jayega, uske baad.',
    'Not a description of somebody. A transcript of what runs in the head, and it sounds familiar.',
    'किसी का वर्णन नहीं। सिर में जो चलता है उसकी नक़ल, और वह जाना-पहचाना लगता है।',
    'Kisi ka varnan nahi. Sar mein jo chalta hai uski nakal, aur woh jaana-pehchana lagta hai.',
    'beginner',
    'Gita 16.13: the internal monologue, transcribed',
    'The Bhagavad Gita stops describing and starts quoting: got this today, will get that next, this is mine, that will be mine too. It is uncomfortably familiar.',
    1

  UNION ALL SELECT 16, 587, 1, 'gita-16-16',
    'अनेकचित्तविभ्रान्ता मोहजालसमावृताः।\nप्रसक्ताः कामभोगेषु पतन्ति नरकेऽशुचौ॥',
    'aneka-citta-vibhrāntā moha-jāla-samāvṛtāḥ\nprasaktāḥ kāma-bhogeṣu patanti narake ''śucau',
    'aneka-chitta-vibhranta moha-jala-samavritah\nprasaktah kama-bhogeshu patanti narake shuchau',
    'Bewildered by many thoughts, covered over by a net of delusion, attached to the enjoyment of desires, they fall into an unclean naraka.',
    'Pulled apart by too many wants at once. Wrapped in a net you cannot see because you are inside it. Stuck to what feels good. And down it goes from there.',
    'एक साथ बहुत सारी चाहों से बिखरा हुआ। ऐसे जाल में लिपटा जो दिखता नहीं क्योंकि आप उसके भीतर हैं। जो अच्छा लगता है उससे चिपका हुआ। और वहाँ से नीचे ही नीचे।',
    'Ek saath bahut saari chaahon se bikhra hua. Aise jaal mein lipta jo dikhta nahi kyunki tum uske bheetar ho. Jo achha lagta hai usse chipka hua. Aur wahan se neeche hi neeche.',
    'A net is only invisible from inside it. That is the whole image and it is a good one.',
    'जाल सिर्फ़ भीतर से अदृश्य होता है। पूरी तस्वीर यही है और अच्छी है।',
    'Jaal sirf bheetar se adrishya hota hai. Poori tasveer yahi hai aur achhi hai.',
    'intermediate',
    'Gita 16.16: a net you cannot see from inside',
    'The Bhagavad Gita describes being pulled apart by many wants and wrapped in a net of delusion. The image works because a net is only invisible from within.',
    1

  UNION ALL SELECT 21, 592, 1, 'gita-16-21',
    'त्रिविधं नरकस्येदं द्वारं नाशनमात्मनः।\nकामः क्रोधस्तथा लोभस्तस्मादेतत्त्रयं त्यजेत्॥',
    'tri-vidhaṁ narakasyedaṁ dvāraṁ nāśanam ātmanaḥ\nkāmaḥ krodhas tathā lobhas tasmād etat trayaṁ tyajet',
    'tri-vidham narakasyedam dvaram nashanam atmanah\nkamah krodhas tatha lobhas tasmad etat trayam tyajet',
    'Threefold is this gate of naraka, destroying the self: desire, anger and greed. Therefore one should abandon these three.',
    'Three doors down, and each one takes a person apart: wanting, anger, and grabbing. So let all three go.',
    'नीचे जाने के तीन दरवाज़े, और हर एक आदमी को तोड़ देता है: चाह, गुस्सा, और बटोरना। इसलिए तीनों छोड़ दीजिए।',
    'Neeche jaane ke teen darwaze, aur har ek aadmi ko tod deta hai: chaah, gussa, aur batorna. Isliye teenon chhod do.',
    'The most quoted line in the chapter, and the one that names three things rather than a kind of person.',
    'अध्याय की सबसे ज़्यादा उद्धृत पंक्ति, और वही जो किसी तरह के व्यक्ति का नहीं, तीन चीज़ों का नाम लेती है।',
    'Chapter ki sabse zyada quote ki jaane wali line, aur wahi jo kisi tarah ke insaan ka nahi, teen cheezon ka naam leti hai.',
    'beginner',
    'Gita 16.21: three gates — wanting, anger, grabbing',
    'The Bhagavad Gita names three things that take a person apart: kama, krodha and lobha. It names three mechanisms, not three kinds of people.',
    1

) AS v
JOIN chapters c ON c.chapter_number = 16;

-- =====================================================================
-- EXPLANATIONS
-- =====================================================================
-- 16.4 and 16.5 carry the safeguard between them. 16.4 says the chapter
-- describes directions rather than kinds of person and that the second
-- list is a list of things the reader has done. 16.5 shows the text
-- doing that itself. Neither sentence is decorative; removing either
-- one leaves the chapter usable as a way of sorting other people, which
-- is exactly the use it has been put to.
-- =====================================================================

DELETE ve FROM verse_explanations ve JOIN verses v ON v.id = ve.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 16;

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 1 AS vn, 'beginner' AS level,
   'The chapter opens without preamble, straight into a list, and the first word is abhayam — fearlessness. That placement is a claim: whatever else is on the list, this is the thing the others grow out of.' AS h_en,
   'अध्याय बिना किसी भूमिका के, सीधे सूची से शुरू होता है, और पहला शब्द है अभयम् — निर्भयता। यह जगह अपने आप में एक दावा है: सूची में और जो भी हो, बाक़ी सब इसी से निकलते हैं।' AS h_hi,
   'Chapter bina kisi bhoomika ke, seedhe list se shuru hota hai, aur pehla shabd hai abhayam — nirbhayta. Yeh jagah apne aap mein ek dawa hai: list mein aur jo bhi ho, baaki sab isi se nikalte hain.' AS h_hing,
   'Nothing on this list is impressive. Giving, holding yourself back, putting something in, reading yourself honestly, doing without, being straight. These are the qualities of somebody you would trust with a spare key, and the chapter is going to argue that they are the same qualities that make a life come apart or hold together.' AS p_en,
   'इस सूची में कुछ भी प्रभावशाली नहीं है। देना, ख़ुद को रोकना, कुछ डालना, ख़ुद को ईमानदारी से पढ़ना, बिना काम चलाना, सीधा होना। ये उस व्यक्ति के गुण हैं जिसे आप अपनी अतिरिक्त चाबी दे दें, और अध्याय यह कहने जा रहा है कि यही वे गुण हैं जिनसे जीवन बिखरता या टिकता है।' AS p_hi,
   'Is list mein kuch bhi impressive nahi hai. Dena, khud ko rokna, kuch daalna, khud ko imaandari se padhna, bina kaam chalana, seedha hona. Yeh us insaan ke gun hain jise tum apni extra chaabi de do, aur chapter yeh kehne ja raha hai ki yahi woh gun hain jinse zindagi bikharti ya tikti hai.' AS p_hing,
   'Putting fearlessness first is the interesting editorial decision. Most of what people do badly is downstream of being afraid — the harshness, the show, the grabbing, all of it reads better as fear management than as wickedness. That is not a soft reading; it is a more useful one, because you can do something about fear and you cannot do much with a verdict.' AS m_en,
   'अभय को पहले रखना दिलचस्प संपादकीय फ़ैसला है। लोग जो कुछ बुरा करते हैं उसका ज़्यादातर हिस्सा डर से निकलता है — सख़्ती, दिखावा, बटोरना, सब कुछ बुराई से बेहतर "डर संभालना" पढ़ा जाता है। यह नरम पाठ नहीं है; यह ज़्यादा काम का पाठ है, क्योंकि डर के बारे में कुछ किया जा सकता है और फ़ैसले के बारे में ज़्यादा कुछ नहीं।' AS m_hi,
   'Abhay ko pehle rakhna dilchasp editorial faisla hai. Log jo kuch bura karte hain uska zyadatar hissa dar se nikalta hai — sakhti, dikhava, batorna, sab kuch burai se behtar "dar sambhalna" padha jaata hai. Yeh naram padhna nahi hai; yeh zyada kaam ka padhna hai, kyunki dar ke baare mein kuch kiya ja sakta hai aur faisle ke baare mein zyada kuch nahi.' AS m_hing

  UNION ALL SELECT 3, 'beginner',
   'The list finishes here, and it finishes on a word worth sitting with: na-ati-mānitā, not thinking too much of yourself. Placed last, after eighteen qualities, it functions as a lock on the door.',
   'सूची यहाँ पूरी होती है, और जिस शब्द पर पूरी होती है उस पर ठहरना चाहिए: न-अति-मानिता, यानी ख़ुद को बहुत बड़ा न समझना। अठारह गुणों के बाद आख़िर में रखा गया, यह दरवाज़े पर लगे ताले का काम करता है।',
   'List yahan poori hoti hai, aur jis shabd par poori hoti hai us par thehrna chahiye: na-ati-manita, yaani khud ko bahut bada na samajhna. Atharah gunon ke baad aakhir mein rakha gaya, yeh darwaze par lage taale ka kaam karta hai.',
   'Read the six: force in you, letting things go, not giving up partway, clean dealings, wishing nobody harm, and not thinking too much of yourself. Now notice what the last one does to the exercise. Anybody who has just read the list and concluded that they are on it has failed the final item while reading it.',
   'छहों पढ़िए: भीतर दम, बातें छोड़ देना, बीच में हार न मानना, साफ़ लेन-देन, किसी का बुरा न चाहना, और ख़ुद को बहुत बड़ा न समझना। अब देखिए कि आख़िरी वाली इस पूरे काम के साथ क्या करती है। जिसने अभी सूची पढ़ी और तय कर लिया कि वह इसमें है, वह पढ़ते-पढ़ते ही आख़िरी बात पर गिर चुका है।',
   'Chhahon padho: bheetar dam, baatein chhod dena, beech mein haar na maanna, saaf len-den, kisi ka bura na chahna, aur khud ko bahut bada na samajhna. Ab dekho ki aakhiri wali is poore kaam ke saath kya karti hai. Jisne abhi list padhi aur tay kar liya ki woh isme hai, woh padhte-padhte hi aakhiri baat par gir chuka hai.',
   'This is the built-in defence against the chapter''s worst use, and it is elegant. A list you can score yourself well on is a list you have just failed. It works the same way in ordinary settings — the person in a meeting who describes themselves as blunt but fair is usually telling you which of the two they are.',
   'यह अध्याय के सबसे बुरे इस्तेमाल के ख़िलाफ़ भीतर बना बचाव है, और सुंदर है। जिस सूची पर आप ख़ुद को अच्छे अंक दे लें, वह सूची आप अभी हारे हैं। यह आम जगहों पर भी वैसे ही चलता है — बैठक में जो ख़ुद को "सीधा पर निष्पक्ष" बताता है, वह आमतौर पर बता रहा होता है कि दोनों में से वह कौन-सा है।',
   'Yeh chapter ke sabse bure istemaal ke khilaf bheetar bana bachav hai, aur sundar hai. Jis list par tum khud ko achhe ank de lo, woh list tum abhi haare ho. Yeh aam jagahon par bhi waise hi chalta hai — meeting mein jo khud ko "seedha par nishpaksh" batata hai, woh aam taur par bata raha hota hai ki dono mein se woh kaun sa hai.'

  UNION ALL SELECT 4, 'intermediate',
   'The second list arrives, and this is the sentence in the chapter that everything else has to be read against. Six things: performing rather than being, swagger, self-importance, anger, harshness, and not knowing any of it is happening.',
   'दूसरी सूची आती है, और यही वह वाक्य है जिसके सामने रखकर बाक़ी सब पढ़ा जाना चाहिए। छह बातें: होना नहीं दिखाना, अकड़, अपने बड़प्पन का भाव, गुस्सा, सख़्ती, और यह पता न होना कि इनमें से कुछ हो भी रहा है।',
   'Doosri list aati hai, aur yahi woh vakya hai jiske saamne rakhkar baaki sab padha jaana chahiye. Chhah baatein: hona nahi dikhana, akad, apne badappan ka bhaav, gussa, sakhti, aur yeh pata na hona ki inme se kuch ho bhi raha hai.',
   'Read the six slowly and the honest response is not recognition of somebody else. Everybody has performed rather than been. Everybody has been hard on somebody who did not deserve it and found a reason afterwards. The sixth — not knowing it is happening — is the one that makes the list impossible to apply confidently to anybody, including yourself, and especially to anybody you have already decided about.',
   'छहों धीरे-धीरे पढ़िए और ईमानदार प्रतिक्रिया किसी और को पहचानना नहीं है। हर किसी ने कभी होने की जगह दिखाया है। हर किसी ने किसी के साथ सख़्ती की है जो उसका हक़दार नहीं था, और वजह बाद में ढूँढ़ी है। छठी — यह पता न होना कि हो रहा है — वही है जो इस सूची को किसी पर भी भरोसे से लगाना नामुमकिन बना देती है, ख़ुद पर भी, और ख़ासकर उस पर जिसके बारे में आप पहले ही तय कर चुके हैं।',
   'Chhahon dheere-dheere padho aur imaandar pratikriya kisi aur ko pehchanna nahi hai. Har kisi ne kabhi hone ki jagah dikhaya hai. Har kisi ne kisi ke saath sakhti ki hai jo uska haqdar nahi tha, aur wajah baad mein dhoondhi hai. Chhathi — yeh pata na hona ki ho raha hai — wahi hai jo is list ko kisi par bhi bharose se lagana namumkin bana deti hai, khud par bhi, aur khaaskar us par jiske baare mein tum pehle hi tay kar chuke ho.',
   'So this has to be said plainly and this product says it. The chapter describes two DIRECTIONS a person can face, not two kinds of person, and it does not describe two kinds of people anywhere. Read as a taxonomy it becomes a vocabulary for deciding that some people are a different sort of thing, and that vocabulary has done real and recent damage when applied to communities. Nothing in these verses supports it: the word abhijāta is about what somebody is inclined towards, the qualities are behaviours rather than essences, and the very next verse has the speaker reassuring the listener rather than assessing him. A reader who finishes this chapter with a list of other people has read it backwards.',
   'तो यह साफ़-साफ़ कहना ज़रूरी है और यह उत्पाद कहता है। अध्याय दो दिशाएँ बताता है जिनकी तरफ़ कोई व्यक्ति मुड़ सकता है, दो तरह के लोग नहीं, और वह कहीं भी दो तरह के लोग नहीं बताता। वर्गीकरण की तरह पढ़ें तो यह ऐसी शब्दावली बन जाता है जिससे तय किया जाए कि कुछ लोग अलग किस्म की चीज़ हैं, और उस शब्दावली ने समुदायों पर लगाए जाने पर सचमुच और हाल ही में नुक़सान किया है। इन श्लोकों में कुछ भी उसका समर्थन नहीं करता: अभिजात शब्द इस बारे में है कि किसी का झुकाव किधर है, गुण स्वभाव नहीं बरताव हैं, और ठीक अगला श्लोक वक्ता को सुनने वाले की जाँच करते नहीं, उसे तसल्ली देते दिखाता है। जो पाठक यह अध्याय ख़त्म करके दूसरों की सूची बनाता है, उसने इसे उल्टा पढ़ा है।',
   'To yeh saaf-saaf kehna zaroori hai aur yeh product kehta hai. Chapter do dishayein batata hai jinki taraf koi insaan mud sakta hai, do tarah ke log nahi, aur woh kahin bhi do tarah ke log nahi batata. Vargikaran ki tarah padho to yeh aisi shabdavali ban jaata hai jisse tay kiya jaaye ki kuch log alag kism ki cheez hain, aur us shabdavali ne samudayon par lagaye jaane par sach mein aur haal hi mein nuksaan kiya hai. In shlokon mein kuch bhi uska samarthan nahi karta: abhijata shabd is baare mein hai ki kisi ka jhukav kidhar hai, gun swabhav nahi bartav hain, aur theek agla shloka vakta ko sunne wale ki jaanch karte nahi, use tasalli dete dikhata hai. Jo padhne wala yeh chapter khatam karke doosron ki list banata hai, usne ise ulta padha hai.'

  UNION ALL SELECT 5, 'beginner',
   'Two lists have just been read out, one of them unflattering, and the person hearing them is a man in the worst hour of his life who has already said he would rather beg than fight. Watch what the speaker does next. He does not ask which list Arjuna is on.',
   'अभी दो सूचियाँ पढ़ी गई हैं, जिनमें एक कड़वी है, और सुनने वाला वह आदमी है जो अपने जीवन के सबसे बुरे घंटे में है और कह चुका है कि लड़ने से भीख माँगना बेहतर। अब देखिए वक्ता आगे क्या करते हैं। वे यह नहीं पूछते कि अर्जुन किस सूची में है।',
   'Abhi do list padhi gayi hain, jinme ek kadwi hai, aur sunne wala woh aadmi hai jo apne jeevan ke sabse bure ghante mein hai aur keh chuka hai ki ladne se bheekh maangna behtar. Ab dekho vakta aage kya karte hain. Woh yeh nahi poochte ki Arjun kis list mein hai.',
   'The first half of the verse states the consequence: one direction opens things out, the other ties them up. The second half is four words of reassurance — mā śucaḥ, do not grieve — followed by a flat statement that Arjuna is of the first kind. No assessment, no conditions, no probation. The order matters: the reassurance comes before the long description of the other direction that occupies the rest of the chapter.',
   'श्लोक का पहला आधा नतीजा बताता है: एक दिशा चीज़ों को खोलती है, दूसरी बाँध देती है। दूसरा आधा चार शब्दों की तसल्ली है — मा शुचः, शोक मत करो — और उसके बाद सीधी बात कि अर्जुन पहली वाला है। कोई जाँच नहीं, कोई शर्त नहीं, कोई परख का समय नहीं। क्रम मायने रखता है: तसल्ली उस लंबे वर्णन से पहले आती है जो बाक़ी अध्याय घेरता है।',
   'Shloka ka pehla aadha nateeja batata hai: ek disha cheezon ko kholti hai, doosri baandh deti hai. Doosra aadha chaar shabdon ki tasalli hai — ma shuchah, shok mat karo — aur uske baad seedhi baat ki Arjun pehla wala hai. Koi jaanch nahi, koi shart nahi, koi parakh ka samay nahi. Kram maayne rakhta hai: tasalli us lambe varnan se pehle aati hai jo baaki chapter gherta hai.',
   'This line is why the chapter cannot honestly be used to sort people, and it is worth being blunt about that. At the exact moment the chapter becomes usable as a weapon, the text takes it out of the reader''s hand and points it the only place it works — at the person holding it, gently. Anybody who wants to read the two lists as categories of human being has to explain why the speaker''s first move is to tell the frightened man in front of him not to worry. There is no good explanation. There is only the plain reading, which is that the lists describe what a person is facing today and not what they are.',
   'यही पंक्ति है जिसकी वजह से इस अध्याय का इस्तेमाल लोगों को छाँटने के लिए ईमानदारी से नहीं हो सकता, और इस पर सीधा बोलना ज़रूरी है। ठीक उसी क्षण जब अध्याय हथियार बन सकता था, ग्रंथ उसे पाठक के हाथ से लेकर वहीं मोड़ देता है जहाँ वह काम करता है — उसी पर, जो उसे थामे है, और नरमी से। जो दोनों सूचियों को इंसानों की श्रेणियों की तरह पढ़ना चाहता है, उसे बताना होगा कि वक्ता का पहला काम सामने खड़े डरे हुए आदमी से यह कहना क्यों है कि परेशान मत हो। इसका कोई अच्छा जवाब नहीं है। सिर्फ़ सीधा पाठ है, कि सूचियाँ यह बताती हैं कि आदमी आज किस तरफ़ है, यह नहीं कि वह क्या है।',
   'Yahi line hai jiski wajah se is chapter ka istemaal logon ko chhaantne ke liye imaandari se nahi ho sakta, aur is par seedha bolna zaroori hai. Theek usi pal jab chapter hathiyar ban sakta tha, granth use padhne wale ke haath se lekar wahin mod deta hai jahan woh kaam karta hai — usi par, jo use thame hai, aur narmi se. Jo dono lists ko insaanon ki categories ki tarah padhna chahta hai, use batana hoga ki vakta ka pehla kaam saamne khade dare hue aadmi se yeh kehna kyun hai ki pareshan mat ho. Iska koi achha jawab nahi hai. Sirf seedha padhna hai, ki lists yeh batati hain ki aadmi aaj kis taraf hai, yeh nahi ki woh kya hai.'

  UNION ALL SELECT 10, 'intermediate',
   'A long description of the second direction is under way, and this verse is where it stops being a list of faults and becomes a machine with moving parts. It names the fuel, the disguise and the mechanism separately.',
   'दूसरी दिशा का लंबा वर्णन चल रहा है, और यह वही श्लोक है जहाँ वह ख़ामियों की सूची होना बंद करके चलती-फिरती मशीन बन जाता है। वह ईंधन, भेस और तंत्र — तीनों अलग-अलग बताता है।',
   'Doosri disha ka lamba varnan chal raha hai, aur yeh wahi shloka hai jahan woh khamiyon ki list hona band karke chalti-firti machine ban jaata hai. Woh eendhan, bhes aur mechanism — teenon alag-alag batata hai.',
   'Duṣpūram is the key word — literally hard to fill, and it is the same claim 3.37 made about kāma. What is added here is the covering: dambha, māna and mada, the performance and the self-importance and the slight drunkenness, sit on top of the appetite and give it respectable clothes. And then asad-grāhān: holding on to things that are not true. Not lying to others. Holding.',
   'दुष्पूरम् मुख्य शब्द है — शब्दशः जिसे भरना कठिन है, और यह वही दावा है जो 3.37 काम के बारे में करता है। यहाँ जो जुड़ता है वह ऊपर का आवरण है: दम्भ, मान और मद — दिखावा, अपना बड़प्पन और हल्का नशा — भूख के ऊपर बैठकर उसे इज़्ज़तदार कपड़े पहना देते हैं। और फिर असद्ग्राहान्: उन बातों को थामे रहना जो सच नहीं हैं। दूसरों से झूठ बोलना नहीं। थामे रहना।',
   'Dushpuram mukhya shabd hai — shabdashah jise bharna mushkil hai, aur yeh wahi claim hai jo 3.37 kaam ke baare mein karta hai. Yahan jo judta hai woh upar ka aavaran hai: dambh, maan aur mad — dikhava, apna badappan aur halka nasha — bhookh ke upar baithkar use izzatdar kapde pehna dete hain. Aur phir asad-grahan: un baaton ko thame rehna jo sach nahi hain. Doosron se jhooth bolna nahi. Thame rehna.',
   'The useful half is asad-grāhān, because it describes something people do without deciding to. Somebody holds a belief about a colleague, or about why a thing went wrong, that stopped matching the evidence three years ago — and the reason it is still held is not stupidity but cost. Letting go of it would require rewriting something else. That is the mechanism, and once named it is findable in a specific person on a specific Tuesday, which a general condemnation never is.',
   'काम की बात असद्ग्राहान् है, क्योंकि यह वह चीज़ बताती है जो लोग बिना तय किए करते हैं। किसी के मन में किसी सहकर्मी के बारे में, या किसी बात के बिगड़ने की वजह के बारे में, ऐसी धारणा है जो तीन साल पहले ही सबूतों से मेल खाना बंद कर चुकी — और वह अब भी इसलिए टिकी है कि मूर्खता नहीं, क़ीमत है। उसे छोड़ने पर कुछ और दोबारा लिखना पड़ेगा। यही तंत्र है, और नाम मिल जाने के बाद इसे किसी ख़ास व्यक्ति में किसी ख़ास मंगलवार को ढूँढ़ा जा सकता है, जो किसी आम निंदा से कभी नहीं होता।',
   'Kaam ki baat asad-grahan hai, kyunki yeh woh cheez batati hai jo log bina tay kiye karte hain. Kisi ke man mein kisi colleague ke baare mein, ya kisi baat ke bigadne ki wajah ke baare mein, aisi dharna hai jo teen saal pehle hi saboot se mel khana band kar chuki — aur woh ab bhi isliye tiki hai ki moorkhta nahi, keemat hai. Use chhodne par kuch aur dobara likhna padega. Yahi mechanism hai, aur naam mil jaane ke baad ise kisi khaas insaan mein kisi khaas Tuesday ko dhoondha ja sakta hai, jo kisi aam ninda se kabhi nahi hota.'

  UNION ALL SELECT 13, 'beginner',
   'The chapter changes technique here. It has been describing from outside; now it quotes. Four verses of direct speech follow, and they are presented without a frame, as though a microphone had been left on.',
   'यहाँ अध्याय अपना तरीक़ा बदल देता है। अब तक वह बाहर से वर्णन कर रहा था; अब वह उद्धृत करता है। चार श्लोक सीधे कथन के आते हैं, बिना किसी ढाँचे के, जैसे कोई माइक खुला छूट गया हो।',
   'Yahan chapter apna tareeka badal deta hai. Ab tak woh bahar se varnan kar raha tha; ab woh quote karta hai. Chaar shloka seedhe kathan ke aate hain, bina kisi dhaanche ke, jaise koi mic khula chhoot gaya ho.',
   'Read it as speech and notice the tense pattern: got, will get, have, will have. Past, future, present, future. The one tense missing is any moment of arriving. The sentence never lands anywhere; each clause hands off to the next, and the fourth is already reaching past the third.',
   'इसे बोली की तरह पढ़िए और काल का ढर्रा देखिए: मिल गया, मिलेगा, है, हो जाएगा। भूत, भविष्य, वर्तमान, भविष्य। जो काल ग़ायब है वह पहुँच जाने का कोई पल है। वाक्य कहीं टिकता ही नहीं; हर टुकड़ा अगले को सौंप देता है, और चौथा तीसरे के आगे पहले ही हाथ बढ़ा चुका है।',
   'Ise boli ki tarah padho aur kaal ka dharra dekho: mil gaya, milega, hai, ho jayega. Bhoot, bhavishya, vartman, bhavishya. Jo kaal gayab hai woh pahunch jaane ka koi pal hai. Vakya kahin tikta hi nahi; har tukda agle ko saunp deta hai, aur chautha teesre ke aage pehle hi haath badha chuka hai.',
   'What makes this verse land is that it does not sound like somebody else. Anybody who has had a good week and spent the drive home already spending the next one has run this exact sentence, in this exact order. The chapter is not describing a villain here; it has switched on a recording and handed the reader the headphones.',
   'यह श्लोक इसलिए लगता है क्योंकि यह किसी और जैसा नहीं लगता। जिसका भी कोई अच्छा हफ़्ता गुज़रा हो और जिसने घर लौटते हुए अगला हफ़्ता पहले से ख़र्च कर लिया हो, उसने यही वाक्य, इसी क्रम में चलाया है। अध्याय यहाँ किसी खलनायक का वर्णन नहीं कर रहा; उसने एक रिकॉर्डिंग चला दी है और पाठक को हेडफ़ोन थमा दिए हैं।',
   'Yeh shloka isliye lagta hai kyunki yeh kisi aur jaisa nahi lagta. Jiska bhi koi achha hafta guzra ho aur jisne ghar lautte hue agla hafta pehle se kharch kar liya ho, usne yahi vakya, isi kram mein chalaya hai. Chapter yahan kisi khalnayak ka varnan nahi kar raha; usne ek recording chala di hai aur padhne wale ko headphone thama diye hain.'

  UNION ALL SELECT 16, 'intermediate',
   'The quoted monologue has run for four verses and this is the summary of what it does to somebody. Three images, then a consequence stated in the chapter''s own vocabulary.',
   'उद्धृत एकालाप चार श्लोक चला है और यह उसका सार है कि वह किसी के साथ क्या करता है। तीन तस्वीरें, फिर नतीजा, अध्याय की अपनी शब्दावली में।',
   'Quote kiya gaya monologue chaar shloka chala hai aur yeh uska saar hai ki woh kisi ke saath kya karta hai. Teen tasveerein, phir nateeja, chapter ki apni shabdavali mein.',
   'Aneka-citta-vibhrāntā is the first and the most modern-sounding: scattered by many minds at once, not one want but a committee of them pulling in different directions. Then the net. Then attachment to what feels good. Naraka is the text''s own word for where this ends and this product leaves it as the text''s word rather than illustrating it or making a claim about an afterlife that neither the reader nor this product can settle.',
   'अनेकचित्तविभ्रान्ता पहली है और सबसे आधुनिक लगती है: एक साथ बहुत सारे मनों से बिखरा हुआ, एक चाह नहीं बल्कि चाहों की एक समिति जो अलग-अलग तरफ़ खींच रही है। फिर जाल। फिर जो अच्छा लगता है उससे चिपकना। नरक इस अंत के लिए ग्रंथ का अपना शब्द है और यह उत्पाद उसे ग्रंथ का शब्द ही रहने देता है — न उसका चित्र खींचता है, न परलोक के बारे में कोई ऐसा दावा करता है जिसे न पाठक तय कर सकता है न यह उत्पाद।',
   'Aneka-chitta-vibhranta pehli hai aur sabse aadhunik lagti hai: ek saath bahut saare mano se bikhra hua, ek chaah nahi balki chaahon ki ek committee jo alag-alag taraf kheench rahi hai. Phir jaal. Phir jo achha lagta hai usse chipakna. Narak is ant ke liye granth ka apna shabd hai aur yeh product use granth ka shabd hi rehne deta hai — na uska chitra kheenchta hai, na parlok ke baare mein koi aisa dawa karta hai jise na padhne wala tay kar sakta hai na yeh product.',
   'The net is the part worth keeping. A net is not invisible; it is invisible from inside, which is a different and much more specific claim. It explains why the person in it can describe everybody else''s net accurately and cannot find their own, and why being told about it rarely helps. Somebody has to be standing outside a thing to see its shape, and the whole difficulty is that nobody is standing outside their own.',
   'जाल वाला हिस्सा रखने लायक है। जाल अदृश्य नहीं होता; वह भीतर से अदृश्य होता है, जो अलग और कहीं ज़्यादा ख़ास दावा है। इससे पता चलता है कि उसमें फँसा आदमी बाक़ी सबके जाल ठीक-ठीक बता सकता है और अपना नहीं ढूँढ़ पाता, और इसीलिए बता देने से आमतौर पर मदद नहीं मिलती। किसी चीज़ का आकार देखने के लिए उसके बाहर खड़ा होना पड़ता है, और पूरी मुश्किल यह है कि अपने वाले के बाहर कोई खड़ा नहीं है।',
   'Jaal wala hissa rakhne layak hai. Jaal adrishya nahi hota; woh bheetar se adrishya hota hai, jo alag aur kahin zyada khaas claim hai. Isse pata chalta hai ki usme phansa aadmi baaki sabke jaal theek-theek bata sakta hai aur apna nahi dhoondh paata, aur isiliye bata dene se aam taur par madad nahi milti. Kisi cheez ka aakar dekhne ke liye uske bahar khada hona padta hai, aur poori mushkil yeh hai ki apne wale ke bahar koi khada nahi hai.'

  UNION ALL SELECT 21, 'beginner',
   'After twenty verses of description the chapter compresses everything into three words. This is the line people know, and it is the only place in the chapter where an instruction is given rather than a picture drawn.',
   'बीस श्लोकों के वर्णन के बाद अध्याय सब कुछ तीन शब्दों में समेट देता है। यही वह पंक्ति है जो लोगों को याद रहती है, और अध्याय में यही इकलौती जगह है जहाँ तस्वीर खींचने के बजाय हिदायत दी जाती है।',
   'Bees shlokon ke varnan ke baad chapter sab kuch teen shabdon mein samet deta hai. Yahi woh line hai jo logon ko yaad rehti hai, aur chapter mein yahi iklauti jagah hai jahan tasveer kheenchne ke bajaye hidayat di jaati hai.',
   'Kāma, krodha, lobha — wanting, anger, grabbing. 2.62 showed the first turning into the second; 3.37 said the first two were one thing with two faces. Lobha is the addition: not wanting a thing, but the reflex of closing your hand around what is already in it. And "nāśanam ātmanaḥ" says what they do — they take the person apart, which is a mechanical claim rather than a moral one.',
   'काम, क्रोध, लोभ — चाह, गुस्सा, बटोरना। 2.62 ने दिखाया था कि पहली दूसरी बनती है; 3.37 ने कहा कि पहली दो एक ही चीज़ के दो चेहरे हैं। लोभ नई बात है: किसी चीज़ को चाहना नहीं, बल्कि जो हाथ में पहले से है उस पर मुट्ठी बंद करने की प्रतिवर्त क्रिया। और "नाशनमात्मनः" बताता है कि ये करते क्या हैं — ये आदमी को तोड़ देते हैं, जो नैतिक नहीं, यांत्रिक दावा है।',
   'Kama, krodha, lobha — chaah, gussa, batorna. 2.62 ne dikhaya tha ki pehli doosri banti hai; 3.37 ne kaha ki pehli do ek hi cheez ke do chehre hain. Lobh nayi baat hai: kisi cheez ko chahna nahi, balki jo haath mein pehle se hai us par mutthi band karne ki reflex. Aur "nashanam atmanah" batata hai ki yeh karte kya hain — yeh aadmi ko tod dete hain, jo naitik nahi, yantrik claim hai.',
   'Notice what this verse does and does not name. It names three mechanisms and tells you to put them down. It does not name a kind of person, and after twenty verses of description that is a deliberate landing. Anybody who has read the chapter as a catalogue of other people reaches this line and finds it will not do the job — there is nobody in it to point at.',
   'ध्यान दीजिए यह श्लोक किसका नाम लेता है और किसका नहीं। यह तीन तंत्रों का नाम लेता है और उन्हें रख देने को कहता है। यह किसी तरह के व्यक्ति का नाम नहीं लेता, और बीस श्लोक के वर्णन के बाद यह जानबूझकर चुनी गई जगह है। जिसने यह अध्याय दूसरों की सूची की तरह पढ़ा है, वह इस पंक्ति पर पहुँचकर पाता है कि यह वह काम करेगी नहीं — इसमें उँगली उठाने के लिए कोई है ही नहीं।',
   'Dhyan do yeh shloka kiska naam leta hai aur kiska nahi. Yeh teen mechanism ka naam leta hai aur unhe rakh dene ko kehta hai. Yeh kisi tarah ke insaan ka naam nahi leta, aur bees shloka ke varnan ke baad yeh jaanboojhkar chuni gayi jagah hai. Jisne yeh chapter doosron ki list ki tarah padha hai, woh is line par pahunchkar paata hai ki yeh woh kaam karegi nahi — isme ungli uthane ke liye koi hai hi nahi.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 16;

-- =====================================================================
-- 3. HOOKS, REFLECTIONS, PRACTICES, TOPICS
-- =====================================================================
-- Every reflection here points the reader at themselves. Not one asks
-- them to consider which list somebody else is on, because that is the
-- question this chapter is most often misused to answer.
-- =====================================================================

DELETE m FROM verse_memory_aids m JOIN verses v ON v.id = m.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 16;
DELETE r FROM verse_reflections r JOIN verses v ON v.id = r.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 16;
DELETE p FROM verse_practices p JOIN verses v ON v.id = p.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 16;
DELETE vt FROM verse_topics vt JOIN verses v ON v.id = vt.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 16;

INSERT INTO verse_memory_aids (verse_id, hook_en, hook_hi, hook_hinglish, analogy_en, analogy_hi, analogy_hinglish, visual_cue)
SELECT v.id, m.h_en, m.h_hi, m.h_hing, m.a_en, m.a_hi, m.a_hing, m.cue FROM (
  SELECT 1 AS vn,
  'The list starts with fearlessness. Most of what people do badly is downstream of being afraid.' AS h_en,
  'सूची अभय से शुरू होती है। लोग जो बुरा करते हैं उसका ज़्यादातर हिस्सा डर से निकलता है।' AS h_hi,
  'List abhay se shuru hoti hai. Log jo bura karte hain uska zyadatar hissa dar se nikalta hai.' AS h_hing,
  'Like a dog that bites. Almost never the confident one.' AS a_en,
  'काटने वाले कुत्ते जैसा। लगभग कभी वह नहीं जो निश्चिंत हो।' AS a_hi,
  'Kaatne wale kutte jaisa. Lagbhag kabhi woh nahi jo nishchint ho.' AS a_hing,
  'A list, and the first line underlined' AS cue

  UNION ALL SELECT 3,
  'The list ends with not thinking too much of yourself. Score well on it and you have just failed it.',
  'सूची इस पर ख़त्म होती है कि ख़ुद को बहुत बड़ा न समझें। अच्छे अंक दे लीजिए और आप अभी हारे।',
  'List is par khatam hoti hai ki khud ko bahut bada na samjho. Achhe ank de lo aur tum abhi haare.',
  'Like a lock on the inside of the door. It only works against the person already in the room.',
  'दरवाज़े के भीतर लगे ताले जैसा। वह सिर्फ़ उसी पर चलता है जो पहले से कमरे में है।',
  'Darwaze ke bheetar lage taale jaisa. Woh sirf usi par chalta hai jo pehle se kamre mein hai.',
  'A list whose last line is a small closed lock'

  UNION ALL SELECT 4,
  'Six things, and you have done all six. It is a list of directions, not of people.',
  'छह बातें, और आपने छहों की हैं। यह दिशाओं की सूची है, लोगों की नहीं।',
  'Chhah baatein, aur tumne chhahon ki hain. Yeh dishaon ki list hai, logon ki nahi.',
  'Like a compass reading. It tells you which way you are facing, not what you are made of.',
  'कम्पास की सुई जैसा। वह बताती है आपका मुँह किधर है, यह नहीं कि आप बने किससे हैं।',
  'Compass ki sui jaisa. Woh batati hai tumhara muh kidhar hai, yeh nahi ki tum bane kisse ho.',
  'A compass needle, no map under it'

  UNION ALL SELECT 5,
  'The moment it could become a weapon, the text takes it out of your hand.',
  'जिस क्षण यह हथियार बन सकता था, ग्रंथ उसे आपके हाथ से ले लेता है।',
  'Jis pal yeh hathiyar ban sakta tha, granth use tumhare haath se le leta hai.',
  'Like handing somebody a knife and turning the handle towards them. The direction is the whole message.',
  'किसी को चाकू देते हुए मूठ उसकी तरफ़ करने जैसा। दिशा ही पूरा संदेश है।',
  'Kisi ko chaaku dete hue mooth uski taraf karne jaisa. Disha hi poora sandesh hai.',
  'A hand offering something handle-first'

  UNION ALL SELECT 10,
  'The want that cannot be filled, wearing respectable clothes and giving reasons.',
  'वह चाह जो भर नहीं सकती, इज़्ज़तदार कपड़े पहने और वजहें देती हुई।',
  'Woh chaah jo bhar nahi sakti, izzatdar kapde pehne aur wajahein deti hui.',
  'Like a leak with a cabinet built around it. The cabinet is why nobody has fixed the leak.',
  'ऐसे रिसाव जैसा जिसके चारों तरफ़ अलमारी बना दी गई हो। अलमारी ही वजह है कि रिसाव आज तक ठीक नहीं हुआ।',
  'Aise risav jaisa jiske chaaron taraf almari bana di gayi ho. Almari hi wajah hai ki risav aaj tak theek nahi hua.',
  'A cabinet door, and a stain spreading under it'

  UNION ALL SELECT 13,
  'Got this, will get that, have this, will have that. Four clauses and nowhere to arrive.',
  'यह मिला, वह मिलेगा, यह है, वह हो जाएगा। चार टुकड़े और पहुँचने की कोई जगह नहीं।',
  'Yeh mila, woh milega, yeh hai, woh ho jayega. Chaar tukde aur pahunchne ki koi jagah nahi.',
  'Like a staircase with no landing. Perfectly good stairs.',
  'ऐसी सीढ़ी जैसा जिसमें कोई पड़ाव नहीं। सीढ़ियाँ बिलकुल ठीक हैं।',
  'Aisi seedhi jaisa jisme koi padav nahi. Seedhiyan bilkul theek hain.',
  'Stairs continuing past the top of the frame'

  UNION ALL SELECT 16,
  'A net is not invisible. It is invisible from inside.',
  'जाल अदृश्य नहीं होता। वह भीतर से अदृश्य होता है।',
  'Jaal adrishya nahi hota. Woh bheetar se adrishya hota hai.',
  'Like your own accent. Everybody else can hear it immediately.',
  'अपने ही लहजे जैसा। बाक़ी सबको वह तुरंत सुनाई देता है।',
  'Apne hi lehje jaisa. Baaki sabko woh turant sunai deta hai.',
  'A net photographed from below, almost transparent'

  UNION ALL SELECT 21,
  'Wanting, anger, grabbing. Three doors, and the verse names no people at all.',
  'चाह, गुस्सा, बटोरना। तीन दरवाज़े, और श्लोक किसी व्यक्ति का नाम लेता ही नहीं।',
  'Chaah, gussa, batorna. Teen darwaze, aur shloka kisi insaan ka naam leta hi nahi.',
  'Like the three ways a house floods. None of them is a person.',
  'घर में पानी भरने के तीन रास्तों जैसा। उनमें से कोई आदमी नहीं है।',
  'Ghar mein paani bharne ke teen raston jaisa. Unme se koi aadmi nahi hai.',
  'Three doorways in a row, all standing open'
) AS m
JOIN verses v ON v.verse_number = m.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 16;

INSERT INTO verse_reflections (verse_id, question_en, question_hi, question_hinglish, display_order)
SELECT v.id, r.q_en, r.q_hi, r.q_hing, r.ord FROM (
  SELECT 1 AS vn, 'What are you afraid of right now, and what does the fear make you do?' AS q_en, 'अभी आपको किस बात का डर है, और वह डर आपसे क्या करवाता है?' AS q_hi, 'Abhi tumhe kis baat ka dar hai, aur woh dar tumse kya karwata hai?' AS q_hing, 1 AS ord
  UNION ALL SELECT 1, 'Think of your last unkind act. Was there fear underneath it?', 'अपनी पिछली निर्दयता सोचिए। उसके नीचे कोई डर था?', 'Apni pichhli nirdayata socho. Uske neeche koi dar tha?', 2
  UNION ALL SELECT 1, 'Which of the nine on this list would somebody who lives with you say you have?', 'इस सूची की नौ में से कौन-सी आपके साथ रहने वाला कहेगा कि आपमें है?', 'Is list ki nau mein se kaun si tumhare saath rehne wala kahega ki tumme hai?', 3
  UNION ALL SELECT 3, 'You have just read a list. Did you place yourself on it? What does the last item say about that?', 'आपने अभी एक सूची पढ़ी। क्या आपने ख़ुद को उसमें रखा? आख़िरी बात इस बारे में क्या कहती है?', 'Tumne abhi ek list padhi. Kya tumne khud ko usme rakha? Aakhiri baat is baare mein kya kehti hai?', 1
  UNION ALL SELECT 3, 'What are you not letting go of, and what would it cost to let it go?', 'आप क्या नहीं छोड़ पा रहे, और छोड़ने में क्या क़ीमत लगेगी?', 'Tum kya nahi chhod paa rahe, aur chhodne mein kya keemat lagegi?', 2
  UNION ALL SELECT 3, 'Where do you give up partway, and is it always at the same point?', 'आप कहाँ बीच में छोड़ देते हैं, और क्या हमेशा एक ही जगह?', 'Tum kahan beech mein chhod dete ho, aur kya hamesha ek hi jagah?', 3
  UNION ALL SELECT 4, 'Take the six one at a time. When did you last do each of them?', 'छहों को एक-एक करके लीजिए। हर एक आपने पिछली बार कब की?', 'Chhahon ko ek-ek karke lo. Har ek tumne pichhli baar kab ki?', 1
  UNION ALL SELECT 4, 'Which of the six do other people see in you that you would deny?', 'इन छह में से कौन-सी दूसरे आपमें देखते हैं जिससे आप इनकार करेंगे?', 'In chhah mein se kaun si doosre tumme dekhte hain jisse tum inkaar karoge?', 2
  UNION ALL SELECT 4, 'The sixth is not knowing it is happening. What does that do to your confidence about the first five?', 'छठी यह है कि पता ही न चले कि हो रहा है। इससे पहली पाँच के बारे में आपके भरोसे का क्या होता है?', 'Chhathi yeh hai ki pata hi na chale ki ho raha hai. Isse pehli paanch ke baare mein tumhare bharose ka kya hota hai?', 3
  UNION ALL SELECT 5, 'Has anybody ever told you what kind of person you are? What did it do to you?', 'क्या किसी ने कभी आपको बताया है कि आप किस तरह के इंसान हैं? उससे आपका क्या हुआ?', 'Kya kisi ne kabhi tumhe bataya hai ki tum kis tarah ke insaan ho? Usse tumhara kya hua?', 1
  UNION ALL SELECT 5, 'Who would you say this line to, if you could say it to one person today?', 'अगर आज आप यह पंक्ति किसी एक से कह सकें, तो किससे कहेंगे?', 'Agar aaj tum yeh line kisi ek se keh sako, to kisse kahoge?', 2
  UNION ALL SELECT 5, 'Would you accept it if somebody said it to you? What stops you?', 'अगर कोई आपसे यह कहे तो क्या आप मान लेंगे? क्या रोकता है?', 'Agar koi tumse yeh kahe to kya tum maan loge? Kya rokta hai?', 3
  UNION ALL SELECT 10, 'What belief are you holding that stopped matching the evidence a while ago?', 'ऐसी कौन-सी धारणा आप थामे हैं जो कुछ समय पहले सबूतों से मेल खाना बंद कर चुकी है?', 'Aisi kaun si dharna tum thame ho jo kuch samay pehle saboot se mel khana band kar chuki hai?', 1
  UNION ALL SELECT 10, 'What would you have to rewrite if you let that belief go?', 'अगर आप वह धारणा छोड़ दें तो आपको क्या दोबारा लिखना पड़ेगा?', 'Agar tum woh dharna chhod do to tumhe kya dobara likhna padega?', 2
  UNION ALL SELECT 10, 'Where does your wanting wear respectable clothes?', 'आपकी चाह कहाँ इज़्ज़तदार कपड़े पहनती है?', 'Tumhari chaah kahan izzatdar kapde pehenti hai?', 3
  UNION ALL SELECT 13, 'Read the verse as your own sentence. When did you last say it?', 'इस श्लोक को अपना वाक्य मानकर पढ़िए। आपने इसे पिछली बार कब कहा था?', 'Is shloka ko apna vakya maankar padho. Tumne ise pichhli baar kab kaha tha?', 1
  UNION ALL SELECT 13, 'When something good happened last, how long before you started spending the next one?', 'पिछली बार कुछ अच्छा हुआ, तो अगला ख़र्च करना शुरू करने में कितनी देर लगी?', 'Pichhli baar kuch achha hua, to agla kharch karna shuru karne mein kitni der lagi?', 2
  UNION ALL SELECT 13, 'What would arriving actually look like? Can you describe it?', 'पहुँच जाना असल में कैसा दिखेगा? क्या आप उसे बता सकते हैं?', 'Pahunch jaana asal mein kaisa dikhega? Kya tum use bata sakte ho?', 3
  UNION ALL SELECT 16, 'Whose net can you describe clearly? Who might be able to describe yours?', 'किसका जाल आप साफ़ बता सकते हैं? आपका कौन बता सकता है?', 'Kiska jaal tum saaf bata sakte ho? Tumhara kaun bata sakta hai?', 1
  UNION ALL SELECT 16, 'How many things do you want at once right now? Name them.', 'अभी आप एक साथ कितनी चीज़ें चाहते हैं? गिनाइए।', 'Abhi tum ek saath kitni cheezein chahte ho? Ginao.', 2
  UNION ALL SELECT 16, 'When somebody last described a pattern in you, what was your first reaction?', 'पिछली बार किसी ने आपमें कोई ढर्रा बताया था, तो आपकी पहली प्रतिक्रिया क्या थी?', 'Pichhli baar kisi ne tumme koi dharra bataya tha, to tumhari pehli pratikriya kya thi?', 3
  UNION ALL SELECT 21, 'Which of the three is loudest in you this month — wanting, anger, or grabbing?', 'इस महीने आपमें तीनों में से सबसे तेज़ कौन है — चाह, गुस्सा, या बटोरना?', 'Is mahine tumme teenon mein se sabse tez kaun hai — chaah, gussa, ya batorna?', 1
  UNION ALL SELECT 21, 'The verse says put them down, not fight them. What is the difference for you?', 'श्लोक कहता है इन्हें रख दीजिए, इनसे लड़िए नहीं। आपके लिए इनमें क्या फ़र्क़ है?', 'Shloka kehta hai inhe rakh do, inse lado nahi. Tumhare liye inme kya farq hai?', 2
  UNION ALL SELECT 21, 'The verse names three things and no people. What does that tell you about the chapter you just read?', 'श्लोक तीन चीज़ों का नाम लेता है, किसी व्यक्ति का नहीं। इससे अभी पढ़े अध्याय के बारे में क्या पता चलता है?', 'Shloka teen cheezon ka naam leta hai, kisi insaan ka nahi. Isse abhi padhe chapter ke baare mein kya pata chalta hai?', 3
) AS r
JOIN verses v ON v.verse_number = r.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 16;

INSERT INTO verse_practices (verse_id, action_en, action_hi, action_hinglish, estimated_minutes, difficulty, display_order)
SELECT v.id, p.a_en, p.a_hi, p.a_hing, p.mins, p.diff, 1 FROM (
  SELECT 1 AS vn, 'Write down one thing you did badly this week. Underneath it, write what you were afraid of at the time.' AS a_en, 'इस हफ़्ते किया कोई एक काम लिखिए जो ठीक नहीं हुआ। उसके नीचे लिखिए कि उस वक़्त आपको किस बात का डर था।' AS a_hi, 'Is hafte kiya koi ek kaam likho jo theek nahi hua. Uske neeche likho ki us waqt tumhe kis baat ka dar tha.' AS a_hing, 6 AS mins, 'beginner' AS diff
  UNION ALL SELECT 3, 'Read the six qualities. Instead of marking the ones you have, mark the one you would most like somebody to say about you, and ask why that one.', 'छहों गुण पढ़िए। जो आपमें हैं उन पर निशान लगाने के बजाय उस पर लगाइए जो आप सबसे ज़्यादा चाहेंगे कि कोई आपके बारे में कहे, और पूछिए वही क्यों।', 'Chhahon gun padho. Jo tumme hain un par nishan lagane ke bajaye us par lagao jo tum sabse zyada chahoge ki koi tumhare baare mein kahe, aur poocho wahi kyun.', 7, 'intermediate'
  UNION ALL SELECT 4, 'Take the six one at a time and find a specific occasion for each in the last year. Not a general admission — a date.', 'छहों को एक-एक करके लीजिए और हर एक के लिए पिछले साल का कोई ख़ास मौक़ा ढूँढ़िए। आम स्वीकार नहीं — एक तारीख़।', 'Chhahon ko ek-ek karke lo aur har ek ke liye pichhle saal ka koi khaas mauka dhoondho. Aam sweekar nahi — ek tareekh.', 12, 'advanced'
  UNION ALL SELECT 5, 'Think of somebody you have quietly written off. Write one sentence describing what they might be facing rather than what they are.', 'किसी ऐसे व्यक्ति को सोचिए जिसे आपने चुपचाप ख़ारिज कर दिया है। एक वाक्य लिखिए कि वह क्या झेल रहा हो सकता है — यह नहीं कि वह क्या है।', 'Kisi aise insaan ko socho jise tumne chupchap khaarij kar diya hai. Ek line likho ki woh kya jhel raha ho sakta hai — yeh nahi ki woh kya hai.', 8, 'intermediate'
  UNION ALL SELECT 10, 'Name one belief you hold about a person or a past event. Write the evidence for it. Notice how old the evidence is.', 'किसी व्यक्ति या पुरानी घटना के बारे में अपनी एक धारणा बताइए। उसके सबूत लिखिए। देखिए वे सबूत कितने पुराने हैं।', 'Kisi insaan ya purani ghatna ke baare mein apni ek dharna batao. Uske saboot likho. Dekho woh saboot kitne purane hain.', 10, 'intermediate'
  UNION ALL SELECT 13, 'The next time something goes well, sit with it for ten minutes without planning anything that comes after it.', 'अगली बार कुछ अच्छा हो, तो दस मिनट उसी के साथ बैठिए और उसके बाद की कोई योजना मत बनाइए।', 'Agli baar kuch achha ho, to das minute usi ke saath baitho aur uske baad ki koi yojna mat banao.', 10, 'beginner'
  UNION ALL SELECT 16, 'Ask one person you trust to describe a pattern they see in you. Say nothing for a full minute after they answer.', 'किसी एक भरोसेमंद व्यक्ति से पूछिए कि उसे आपमें कौन-सा ढर्रा दिखता है। उसके जवाब के बाद पूरा एक मिनट कुछ मत कहिए।', 'Kisi ek bharosemand insaan se poocho ki use tumme kaun sa dharra dikhta hai. Uske jawab ke baad poora ek minute kuch mat kaho.', 15, 'advanced'
  UNION ALL SELECT 21, 'Pick whichever of the three is loudest this month. For one week, note the time of day it turns up. Nothing else.', 'तीनों में से जो इस महीने सबसे तेज़ है उसे चुनिए। एक हफ़्ते तक सिर्फ़ यह लिखिए कि वह दिन के किस समय आती है। और कुछ नहीं।', 'Teenon mein se jo is mahine sabse tez hai use chuno. Ek hafte tak sirf yeh likho ki woh din ke kis time aati hai. Aur kuch nahi.', 5, 'beginner'
) AS p
JOIN verses v ON v.verse_number = p.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 16;

INSERT INTO verse_topics (verse_id, topic_id, relevance)
SELECT v.id, t.id, x.rel FROM (
  SELECT 1 AS vn, 'fear' AS slug, 10 AS rel
  UNION ALL SELECT 1, 'the-self', 7
  UNION ALL SELECT 1, 'steadiness', 7
  UNION ALL SELECT 1, 'duty', 6
  UNION ALL SELECT 3, 'steadiness', 8
  UNION ALL SELECT 3, 'anger', 7
  UNION ALL SELECT 3, 'comparison', 7
  UNION ALL SELECT 3, 'the-self', 6
  UNION ALL SELECT 4, 'anger', 9
  UNION ALL SELECT 4, 'the-self', 8
  UNION ALL SELECT 4, 'comparison', 8
  UNION ALL SELECT 4, 'fear', 6
  UNION ALL SELECT 5, 'fear', 9
  UNION ALL SELECT 5, 'the-self', 9
  UNION ALL SELECT 5, 'hard-decisions', 7
  UNION ALL SELECT 5, 'grief', 6
  UNION ALL SELECT 10, 'desire', 10
  UNION ALL SELECT 10, 'comparison', 7
  UNION ALL SELECT 10, 'restlessness', 7
  UNION ALL SELECT 13, 'desire', 10
  UNION ALL SELECT 13, 'restlessness', 9
  UNION ALL SELECT 13, 'comparison', 8
  UNION ALL SELECT 13, 'burnout', 6
  UNION ALL SELECT 16, 'restlessness', 10
  UNION ALL SELECT 16, 'desire', 9
  UNION ALL SELECT 16, 'the-self', 7
  UNION ALL SELECT 16, 'burnout', 6
  UNION ALL SELECT 21, 'anger', 10
  UNION ALL SELECT 21, 'desire', 10
  UNION ALL SELECT 21, 'restlessness', 8
  UNION ALL SELECT 21, 'hard-decisions', 6
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 16
JOIN topics t ON t.slug = x.slug;

-- =====================================================================
-- 4. MODERN EXAMPLES
-- =====================================================================
-- Three per verse. Read the whole set before editing any of it: not one
-- example describes a group, a profession, a party, a region or a
-- community as belonging to either list, and two of them (16.4 example
-- 1 and 16.5 example 2) show the SAME person facing both directions
-- inside one week. Those two are the strongest available answer to the
-- reading this chapter attracts, and they are not decorative.
-- =====================================================================

DELETE e FROM modern_examples e JOIN verses v ON v.id = e.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 16;

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

  SELECT 1 AS vn, 'corporate' AS cat, 1 AS ord,
  'The manager who could not be told anything' AS t_en, 'वह मैनेजर जिसे कुछ बताया नहीं जा सकता था' AS t_hi, 'Woh manager jise kuch bataya nahi ja sakta tha' AS t_hing,
  'A team lead reacts badly to every piece of bad news, so his team stops bringing him any until it cannot be avoided. This is described by everybody around him as arrogance. Two years later, after his own position becomes secure, the same man is noticeably easy to tell things to, and he has not attended a course or read a book.' AS s_en,
  'एक टीम लीड हर बुरी ख़बर पर ख़राब प्रतिक्रिया देता है, इसलिए उसकी टीम तब तक कोई ख़बर लाना बंद कर देती है जब तक टालना नामुमकिन न हो जाए। आस-पास के सब इसे घमंड कहते हैं। दो साल बाद, जब उसकी अपनी जगह पक्की हो जाती है, वही आदमी साफ़ तौर पर ऐसा हो जाता है जिससे बात कही जा सकती है, और उसने न कोई कोर्स किया है न कोई किताब पढ़ी है।' AS s_hi,
  'Ek team lead har buri khabar par kharab pratikriya deta hai, isliye uski team tab tak koi khabar laana band kar deti hai jab tak taalna namumkin na ho jaaye. Aas-paas ke sab ise ghamand kehte hain. Do saal baad, jab uski apni jagah pakki ho jaati hai, wahi aadmi saaf taur par aisa ho jaata hai jisse baat kahi ja sakti hai, aur usne na koi course kiya hai na koi kitaab padhi hai.' AS s_hing,
  'The verse puts fearlessness first, and this is why the placement is not sentimental. What everybody read as arrogance was a man who could not afford any more bad news. Remove the fear and the arrogance goes with it, without anybody addressing the arrogance.' AS c_en,
  'श्लोक अभय को पहले रखता है, और यही वजह है कि यह जगह भावुकता नहीं है। जिसे सबने घमंड पढ़ा, वह वह आदमी था जो और बुरी ख़बर झेल नहीं सकता था। डर हटाइए और घमंड उसके साथ चला जाता है, बिना किसी के घमंड पर काम किए।' AS c_hi,
  'Shloka abhay ko pehle rakhta hai, aur yahi wajah hai ki yeh jagah bhavukta nahi hai. Jise sabne ghamand padha, woh woh aadmi tha jo aur buri khabar jhel nahi sakta tha. Dar hatao aur ghamand uske saath chala jaata hai, bina kisi ke ghamand par kaam kiye.' AS c_hing,
  'Fix the fear and a surprising amount of what looked like character goes with it.' AS l_en,
  'डर ठीक कीजिए और जो चरित्र जैसा लगता था उसका हैरान करने वाला हिस्सा उसके साथ चला जाता है।' AS l_hi,
  'Dar theek karo aur jo charitra jaisa lagta tha uska hairan karne wala hissa uske saath chala jaata hai.' AS l_hing,
  NULL AS src, 'intermediate' AS diff, 'work,fear,leadership,arrogance,change' AS tags

  UNION ALL SELECT 1, 'parenting', 2,
  'The strictness that was about the neighbours', 'वह सख़्ती जो पड़ोसियों के बारे में थी', 'Woh sakhti jo padosiyon ke baare mein thi',
  'A parent is unusually hard about school results. Asked directly and in a calm moment what the worst outcome would actually be, they do not talk about their child''s future for the first several sentences. They talk about a specific conversation they expect to have at a wedding.',
  'एक अभिभावक स्कूल के नतीजों को लेकर असामान्य रूप से सख़्त हैं। शांत क्षण में सीधे पूछे जाने पर कि सबसे बुरा क्या हो जाएगा, वे पहले कई वाक्यों तक अपने बच्चे के भविष्य की बात करते ही नहीं। वे एक ख़ास बातचीत की बात करते हैं जो उन्हें किसी शादी में होने का अंदेशा है।',
  'Ek parent school ke results ko lekar asamanya roop se sakht hain. Shaant pal mein seedhe poochhe jaane par ki sabse bura kya ho jayega, woh pehle kai vakyon tak apne bachche ke bhavishya ki baat karte hi nahi. Woh ek khaas baatchit ki baat karte hain jo unhe kisi shaadi mein hone ka andesha hai.',
  'The chapter''s claim is that a great deal of harsh conduct is fear management. Nothing here is a verdict on this parent, who loves their child and is doing what frightened people do. The verse points at the fear because that is the thing that can actually be moved.',
  'अध्याय का दावा है कि बहुत सारी सख़्ती डर संभालना है। यहाँ इस अभिभावक पर कोई फ़ैसला नहीं है, जो अपने बच्चे से प्यार करते हैं और वही कर रहे हैं जो डरे हुए लोग करते हैं। श्लोक डर की तरफ़ इशारा करता है क्योंकि असल में वही हिलाया जा सकता है।',
  'Chapter ka claim hai ki bahut saari sakhti dar sambhalna hai. Yahan is parent par koi faisla nahi hai, jo apne bachche se pyaar karte hain aur wahi kar rahe hain jo dare hue log karte hain. Shloka dar ki taraf ishara karta hai kyunki asal mein wahi hilaya ja sakta hai.',
  'Ask what the worst outcome actually is. The first honest answer is often not about the child at all.',
  'पूछिए कि सबसे बुरा असल में क्या है। पहला ईमानदार जवाब अक्सर बच्चे के बारे में होता ही नहीं।',
  'Poocho ki sabse bura asal mein kya hai. Pehla imaandar jawab aksar bachche ke baare mein hota hi nahi.',
  NULL, 'intermediate', 'family,fear,school,pressure,honesty'

  UNION ALL SELECT 1, 'everyday_life', 3,
  'Nine ordinary things', 'नौ साधारण बातें', 'Nau sadharan baatein',
  'Somebody is asked to describe the most decent person they know. The answer takes a while and contains nothing remarkable: turns up, gives things away without mentioning it, does not talk about people who are not there, admits when they are wrong, and is the same at a wedding as at a funeral.',
  'किसी से पूछा जाता है कि उनके जानने वालों में सबसे भला इंसान कौन है। जवाब में समय लगता है और उसमें कुछ भी असाधारण नहीं होता: पहुँच जाता है, बिना बताए चीज़ें दे देता है, जो मौजूद नहीं उनकी बात नहीं करता, ग़लती होने पर मान लेता है, और शादी में वही रहता है जो अंतिम संस्कार में।',
  'Kisi se poocha jaata hai ki unke jaanne walon mein sabse bhala insaan kaun hai. Jawab mein samay lagta hai aur usme kuch bhi asadharan nahi hota: pahunch jaata hai, bina bataye cheezein de deta hai, jo maujood nahi unki baat nahi karta, galti hone par maan leta hai, aur shaadi mein wahi rehta hai jo antim sanskar mein.',
  'This is the list, arrived at independently and without the vocabulary. Nothing on the verse''s list is impressive and that is the point — it is a description of somebody you would leave a key with, and the chapter is going to argue that these unglamorous things are what a life holds together on.',
  'यह वही सूची है, अपने आप पहुँची और बिना शब्दावली के। श्लोक की सूची में कुछ भी प्रभावशाली नहीं है और बात यही है — यह उस व्यक्ति का वर्णन है जिसके पास आप चाबी छोड़ देंगे, और अध्याय कहने जा रहा है कि जीवन इन्हीं बेरौनक़ चीज़ों पर टिकता है।',
  'Yeh wahi list hai, apne aap pahunchi aur bina shabdavali ke. Shloka ki list mein kuch bhi impressive nahi hai aur baat yahi hai — yeh us insaan ka varnan hai jiske paas tum chaabi chhod doge, aur chapter kehne ja raha hai ki zindagi inhi berounak cheezon par tikti hai.',
  'Ask anybody to describe the most decent person they know. You will get this list, without the vocabulary.',
  'किसी से भी पूछिए कि उसका जाना हुआ सबसे भला इंसान कैसा है। यही सूची मिलेगी, बिना शब्दावली के।',
  'Kisi se bhi poocho ki uska jaana hua sabse bhala insaan kaisa hai. Yahi list milegi, bina shabdavali ke.',
  NULL, 'beginner', 'character,ordinary,decency,description,people'

  UNION ALL SELECT 3, 'social_media', 1,
  'The thread about humility', 'विनम्रता वाला धागा', 'Vinamrata wala thread',
  'A post explaining why humility is the most underrated quality reaches a large number of people. It is well written and largely correct. The account that wrote it spends the following two days replying to anybody who disagrees, at length, and quoting the more admiring responses.',
  'विनम्रता सबसे कम आँका गया गुण क्यों है — इस पर लिखी एक पोस्ट बहुत लोगों तक पहुँचती है। वह अच्छी लिखी है और काफ़ी हद तक सही है। जिस खाते ने लिखी है वह अगले दो दिन असहमत होने वाले हर व्यक्ति को लंबे जवाब देता है, और तारीफ़ वाली प्रतिक्रियाएँ उद्धृत करता है।',
  'Vinamrata sabse kam aanka gaya gun kyun hai — is par likhi ek post bahut logon tak pahunchti hai. Woh achhi likhi hai aur kaafi had tak sahi hai. Jis account ne likhi hai woh agle do din asahmat hone wale har insaan ko lambe jawab deta hai, aur tareef wali pratikriyayein quote karta hai.',
  'The verse closes its list with not thinking too much of yourself, and this is why the placement is a lock rather than an item. Everything in the post was true. The two days after it were the actual answer to the question the post was about, and nobody involved noticed the switch.',
  'श्लोक अपनी सूची इस पर ख़त्म करता है कि ख़ुद को बहुत बड़ा न समझें, और इसीलिए वह जगह एक और गुण नहीं, ताला है। पोस्ट में सब कुछ सच था। उसके बाद के दो दिन उसी सवाल का असली जवाब थे जिसके बारे में पोस्ट थी, और इसमें शामिल किसी ने बदलाव नोटिस नहीं किया।',
  'Shloka apni list is par khatam karta hai ki khud ko bahut bada na samjho, aur isiliye woh jagah ek aur gun nahi, taala hai. Post mein sab kuch sach tha. Uske baad ke do din usi sawaal ka asli jawab the jiske baare mein post thi, aur isme shamil kisi ne badlav notice nahi kiya.',
  'Writing well about a quality and having it are different activities, and one of them is much easier.',
  'किसी गुण पर अच्छा लिखना और वह गुण होना दो अलग काम हैं, और उनमें से एक कहीं आसान है।',
  'Kisi gun par achha likhna aur woh gun hona do alag kaam hain, aur unme se ek kahin asaan hai.',
  NULL, 'beginner', 'internet,humility,writing,self-image,irony'

  UNION ALL SELECT 3, 'sports', 2,
  'The captain who stopped mid-season', 'वह कप्तान जो सत्र के बीच रुक गया', 'Woh captain jo season ke beech ruk gaya',
  'A team is nine games into a bad season. The captain, who has every reason to protect himself in the press, stops doing the thing everybody expects — he neither blames the squad nor blames the officials, and he does not resign either. He keeps turning up to the unglamorous parts. The season does not improve much. Two of the younger players later describe that stretch as the most useful thing they saw.',
  'एक टीम के बुरे सत्र के नौ मैच हो चुके हैं। कप्तान, जिसके पास प्रेस में ख़ुद को बचाने की हर वजह है, वह करना बंद कर देता है जिसकी सब उम्मीद करते हैं — वह न टीम को दोष देता है, न अधिकारियों को, और इस्तीफ़ा भी नहीं देता। वह बेरौनक़ हिस्सों में पहुँचता रहता है। सत्र ज़्यादा नहीं सुधरता। दो युवा खिलाड़ी बाद में उस दौर को अपना देखा हुआ सबसे काम का हिस्सा बताते हैं।',
  'Ek team ke bure season ke nau match ho chuke hain. Captain, jiske paas press mein khud ko bachane ki har wajah hai, woh karna band kar deta hai jiski sab ummeed karte hain — woh na team ko dosh deta hai, na officials ko, aur resign bhi nahi deta. Woh berounak hisson mein pahunchta rehta hai. Season zyada nahi sudharta. Do yuva khiladi baad mein us daur ko apna dekha hua sabse kaam ka hissa batate hain.',
  'Three of the six are visible here and none is announced: dhṛti, not giving up partway; adroha, wishing nobody harm, which is what refusing to blame actually is; and the last one, since he never at any point describes himself as doing any of this.',
  'छह में से तीन यहाँ दिख रहे हैं और कोई घोषित नहीं है: धृति, यानी बीच में हार न मानना; अद्रोह, यानी किसी का बुरा न चाहना, जो दोष देने से इनकार करना असल में है; और आख़िरी वाली, क्योंकि वह कभी यह नहीं बताता कि वह ऐसा कुछ कर रहा है।',
  'Chhah mein se teen yahan dikh rahe hain aur koi ghoshit nahi hai: dhriti, yaani beech mein haar na maanna; adroha, yaani kisi ka bura na chahna, jo dosh dene se inkaar karna asal mein hai; aur aakhiri wali, kyunki woh kabhi yeh nahi batata ki woh aisa kuch kar raha hai.',
  'Refusing to blame is not passivity. It is one of the six, and it is most visible in a season that does not turn around.',
  'दोष देने से इनकार निष्क्रियता नहीं है। यह उन छह में से एक है, और उस सत्र में सबसे साफ़ दिखता है जो सुधरता नहीं।',
  'Dosh dene se inkaar nishkriyata nahi hai. Yeh un chhah mein se ek hai, aur us season mein sabse saaf dikhta hai jo sudharta nahi.',
  NULL, 'intermediate', 'sport,leadership,blame,endurance,example'

  UNION ALL SELECT 3, 'everyday_life', 3,
  'The apology with nothing after it', 'वह माफ़ी जिसके बाद कुछ नहीं था', 'Woh maafi jiske baad kuch nahi tha',
  'Two friends fall out over something small that got large. One of them apologises about a week later, in four sentences, with no explanation of context attached and no mention of the other person''s part in it. The other, who had a list ready, finds the list has nothing to attach itself to.',
  'दो दोस्तों में किसी छोटी बात पर अनबन हो जाती है जो बड़ी हो गई। उनमें से एक क़रीब एक हफ़्ते बाद माफ़ी माँगता है, चार वाक्यों में, बिना कोई सफ़ाई जोड़े और बिना दूसरे के हिस्से का ज़िक्र किए। दूसरा, जिसके पास एक सूची तैयार थी, पाता है कि सूची को टाँगने के लिए कुछ बचा ही नहीं।',
  'Do doston mein kisi chhoti baat par anban ho jaati hai jo badi ho gayi. Unme se ek karib ek hafte baad maafi maangta hai, chaar vakyon mein, bina koi safai jode aur bina doosre ke hisse ka zikr kiye. Doosra, jiske paas ek list tayyar thi, paata hai ki list ko taangne ke liye kuch bacha hi nahi.',
  'Kṣamā is on this list and it is usually translated as forgiveness, which makes it sound like something you grant. What happened here is closer to what the word does: an apology with nothing attached to it removes the material an argument runs on. Neither of them decided to be big about it. One of them just did not include the usual second half.',
  'क्षमा इस सूची में है और इसका अनुवाद आम तौर पर "माफ़ करना" होता है, जिससे यह कुछ ऐसा लगता है जो आप देते हैं। यहाँ जो हुआ वह इस शब्द के काम के ज़्यादा पास है: ऐसी माफ़ी जिसके साथ कुछ जुड़ा न हो, वह सामान हटा देती है जिस पर झगड़ा चलता है। दोनों में से किसी ने बड़ा बनने का फ़ैसला नहीं किया। एक ने बस आम तौर पर जुड़ने वाला दूसरा आधा नहीं जोड़ा।',
  'Kshama is list mein hai aur iska anuvaad aam taur par "maaf karna" hota hai, jisse yeh kuch aisa lagta hai jo tum dete ho. Yahan jo hua woh is shabd ke kaam ke zyada paas hai: aisi maafi jiske saath kuch juda na ho, woh saamaan hata deti hai jis par jhagda chalta hai. Dono mein se kisi ne bada banne ka faisla nahi kiya. Ek ne bas aam taur par judne wala doosra aadha nahi joda.',
  'An apology with nothing attached removes the material an argument runs on. Most apologies attach something.',
  'ऐसी माफ़ी जिसके साथ कुछ जुड़ा न हो, वह सामान हटा देती है जिस पर झगड़ा चलता है। ज़्यादातर माफ़ियों के साथ कुछ जुड़ा होता है।',
  'Aisi maafi jiske saath kuch juda na ho, woh saamaan hata deti hai jis par jhagda chalta hai. Zyadatar maafiyon ke saath kuch juda hota hai.',
  NULL, 'beginner', 'friendship,apology,forgiveness,arguments,repair'

  UNION ALL SELECT 4, 'corporate', 1,
  'The same person, Tuesday and Thursday', 'वही आदमी, मंगलवार और गुरुवार', 'Wahi aadmi, Tuesday aur Thursday',
  'On Tuesday a man stays forty minutes after hours to help a colleague he does not particularly like finish something, tells nobody, and leaves. On Thursday the same man, tired and having just been passed over for something, is short with a junior in front of two people, and constructs a reason for it on the walk to his car that holds up well enough that he never revisits it.',
  'मंगलवार को एक आदमी दफ़्तर के बाद चालीस मिनट रुककर एक ऐसे सहकर्मी का काम पूरा करवाता है जिसे वह ख़ास पसंद नहीं करता, किसी को बताता नहीं, और चला जाता है। गुरुवार को वही आदमी, थका हुआ और अभी-अभी किसी चीज़ में नज़रअंदाज़ किया गया, दो लोगों के सामने एक जूनियर से रूखा बोलता है, और गाड़ी तक चलते-चलते उसके लिए एक वजह बना लेता है जो इतनी ठीक बैठती है कि वह दोबारा उस पर लौटता ही नहीं।',
  'Tuesday ko ek aadmi office ke baad chalis minute rukkar ek aise colleague ka kaam poora karwata hai jise woh khaas pasand nahi karta, kisi ko batata nahi, aur chala jaata hai. Thursday ko wahi aadmi, thaka hua aur abhi-abhi kisi cheez mein nazarandaaz kiya gaya, do logon ke saamne ek junior se rookha bolta hai, aur gaadi tak chalte-chalte uske liye ek wajah bana leta hai jo itni theek baithti hai ki woh dobara us par lautta hi nahi.',
  'Both lists, one man, three days apart. This is the reading the chapter supports and the plainest refutation of the other one. Ask which list he is on and the question has no answer; ask which way he was facing on Thursday afternoon and it has a clear one, and something can be done about it.',
  'दोनों सूचियाँ, एक आदमी, तीन दिन के अंतर पर। यही वह पाठ है जिसका अध्याय समर्थन करता है और दूसरे का सबसे सीधा खंडन। पूछिए कि वह किस सूची में है और सवाल का कोई जवाब नहीं; पूछिए कि गुरुवार दोपहर उसका मुँह किधर था और जवाब साफ़ है, और उस पर कुछ किया भी जा सकता है।',
  'Dono list, ek aadmi, teen din ke antar par. Yahi woh padhna hai jiska chapter samarthan karta hai aur doosre ka sabse seedha khandan. Poocho ki woh kis list mein hai aur sawaal ka koi jawab nahi; poocho ki Thursday dopahar uska muh kidhar tha aur jawab saaf hai, aur us par kuch kiya bhi ja sakta hai.',
  '"Which list is he on" has no answer. "Which way was he facing on Thursday" has one, and you can do something with it.',
  '"वह किस सूची में है" का कोई जवाब नहीं। "गुरुवार को उसका मुँह किधर था" का जवाब है, और उससे कुछ किया जा सकता है।',
  '"Woh kis list mein hai" ka koi jawab nahi. "Thursday ko uska muh kidhar tha" ka jawab hai, aur usse kuch kiya ja sakta hai.',
  NULL, 'intermediate', 'work,character,direction,self-knowledge,ordinary'

  UNION ALL SELECT 4, 'social_media', 2,
  'The reason arrived afterwards', 'वजह बाद में आई', 'Wajah baad mein aayi',
  'Somebody posts something cutting about a stranger. Challenged by a friend in a message, they produce a justification that is coherent, defensible and was not present in their head at the time of posting. They can tell, faintly, that it arrived afterwards, and the feeling passes in about a minute.',
  'कोई किसी अनजान व्यक्ति के बारे में कुछ चुभता हुआ पोस्ट करता है। एक दोस्त संदेश में सवाल करता है, तो वह ऐसी सफ़ाई देता है जो तर्कसंगत है, बचाव लायक है, और पोस्ट करते वक़्त उसके दिमाग़ में थी ही नहीं। उसे हल्का-सा पता चलता है कि यह बाद में आई है, और वह एहसास क़रीब एक मिनट में चला जाता है।',
  'Koi kisi anjaan insaan ke baare mein kuch chubhta hua post karta hai. Ek dost message mein sawaal karta hai, to woh aisi safai deta hai jo tarksangat hai, bachav layak hai, aur post karte waqt uske dimaag mein thi hi nahi. Use halka sa pata chalta hai ki yeh baad mein aayi hai, aur woh ehsaas karib ek minute mein chala jaata hai.',
  'The sixth item on the list is ajñāna — not knowing it is happening — and this is what it looks like operationally. It is not stupidity and it is not lying. It is that the reason and the act arrived in the wrong order, and the ordinary mind tidies that up so fast that catching it takes an unusual kind of attention.',
  'सूची की छठी बात है अज्ञान — यह पता न होना कि हो रहा है — और चलते हुए यह ऐसा दिखता है। यह मूर्खता नहीं है और झूठ भी नहीं। यह है कि वजह और काम ग़लत क्रम में आए, और आम मन इसे इतनी तेज़ी से ठीक कर देता है कि इसे पकड़ने के लिए असामान्य ध्यान चाहिए।',
  'List ki chhathi baat hai ajnana — yeh pata na hona ki ho raha hai — aur chalte hue yeh aisa dikhta hai. Yeh moorkhta nahi hai aur jhooth bhi nahi. Yeh hai ki wajah aur kaam galat kram mein aaye, aur aam man ise itni tezi se theek kar deta hai ki ise pakadne ke liye asamanya dhyan chahiye.',
  'The reason arriving after the act is not lying. It is the sixth item, and it is why the list cannot be applied confidently to anybody.',
  'काम के बाद वजह का आना झूठ नहीं है। यह छठी बात है, और इसीलिए यह सूची किसी पर भरोसे से नहीं लगाई जा सकती।',
  'Kaam ke baad wajah ka aana jhooth nahi hai. Yeh chhathi baat hai, aur isiliye yeh list kisi par bharose se nahi lagayi ja sakti.',
  NULL, 'advanced', 'internet,self-knowledge,justification,attention,honesty'

  UNION ALL SELECT 4, 'relationships', 3,
  'Being right, harshly', 'सही होना, सख़्ती से', 'Sahi hona, sakhti se',
  'In an argument one person makes a point that is entirely correct and makes it in the most damaging available way, choosing the example that will land hardest. They win the argument. Three weeks later they can remember the sentence they used and cannot remember what the argument was about.',
  'बहस में एक व्यक्ति ऐसी बात कहता है जो पूरी तरह सही है और उसे सबसे ज़्यादा चोट पहुँचाने वाले तरीक़े से कहता है, वही उदाहरण चुनकर जो सबसे गहरा लगेगा। वह बहस जीत जाता है। तीन हफ़्ते बाद उसे वह वाक्य याद है और यह याद नहीं कि बहस किस बारे में थी।',
  'Behes mein ek insaan aisi baat kehta hai jo poori tarah sahi hai aur use sabse zyada chot pahunchane wale tareeke se kehta hai, wahi example chunkar jo sabse gehra lagega. Woh behes jeet jaata hai. Teen hafte baad use woh vakya yaad hai aur yeh yaad nahi ki behes kis baare mein thi.',
  'Pāruṣya, harshness, is on the list and being right is not a defence against it — the two are entirely compatible, which is what makes this the commonest of the six. The tell is not the content of what was said. It is the choosing of the version that would hurt most.',
  'पारुष्य, यानी सख़्ती, सूची में है और सही होना इसके ख़िलाफ़ बचाव नहीं है — दोनों साथ चल सकते हैं, और इसीलिए छह में से यह सबसे आम है। निशानी यह नहीं है कि क्या कहा गया। निशानी वह चुनाव है — उस रूप का चुनाव जो सबसे ज़्यादा दुखाएगा।',
  'Parushya, yaani sakhti, list mein hai aur sahi hona iske khilaf bachav nahi hai — dono saath chal sakte hain, aur isiliye chhah mein se yeh sabse aam hai. Nishani yeh nahi hai ki kya kaha gaya. Nishani woh chunav hai — us roop ka chunav jo sabse zyada dukhayega.',
  'Being right is not a defence against harshness. The tell is choosing the version that hurts most.',
  'सही होना सख़्ती के ख़िलाफ़ बचाव नहीं है। निशानी उस रूप का चुनाव है जो सबसे ज़्यादा दुखाता है।',
  'Sahi hona sakhti ke khilaf bachav nahi hai. Nishani us roop ka chunav hai jo sabse zyada dukhata hai.',
  NULL, 'intermediate', 'relationships,arguments,harshness,being-right,repair'

  UNION ALL SELECT 5, 'healthcare', 1,
  'What the doctor said first', 'डॉक्टर ने पहले क्या कहा', 'Doctor ne pehle kya kaha',
  'A patient arrives with a set of results they have already read online and a conclusion they have already reached about themselves. The consultant''s first sentence is not about the results. It is four words about the patient, said before anything else, and the patient reports afterwards that they did not hear the next two minutes because of it.',
  'एक मरीज़ ऐसे नतीजे लेकर आता है जो वह ऑनलाइन पढ़ चुका है और अपने बारे में एक निष्कर्ष जो वह निकाल चुका है। सलाहकार डॉक्टर का पहला वाक्य नतीजों के बारे में नहीं है। वह मरीज़ के बारे में चार शब्द हैं, बाक़ी सब से पहले कहे गए, और मरीज़ बाद में बताता है कि उसी वजह से उसने अगले दो मिनट सुने ही नहीं।',
  'Ek mareez aise results lekar aata hai jo woh online padh chuka hai aur apne baare mein ek nishkarsh jo woh nikaal chuka hai. Consultant doctor ka pehla vakya results ke baare mein nahi hai. Woh mareez ke baare mein chaar shabd hain, baaki sab se pehle kahe gaye, aur mareez baad mein batata hai ki usi wajah se usne agle do minute sune hi nahi.',
  'The verse''s order is the whole lesson: consequence first, then four words of reassurance, and only then twenty verses of description. The reassurance is not the conclusion of an assessment. It comes before the assessment, and that sequence is doing something a correct diagnosis delivered in the other order does not.',
  'श्लोक का क्रम ही पूरा सबक़ है: पहले नतीजा, फिर चार शब्दों की तसल्ली, और उसके बाद ही बीस श्लोक का वर्णन। तसल्ली किसी जाँच का निष्कर्ष नहीं है। वह जाँच से पहले आती है, और वह क्रम कुछ ऐसा करता है जो उल्टे क्रम में दिया गया सही निदान नहीं करता।',
  'Shloka ka kram hi poora sabak hai: pehle nateeja, phir chaar shabdon ki tasalli, aur uske baad hi bees shloka ka varnan. Tasalli kisi jaanch ka nishkarsh nahi hai. Woh jaanch se pehle aati hai, aur woh kram kuch aisa karta hai jo ulte kram mein diya gaya sahi nidan nahi karta.',
  'The reassurance came before the assessment, not after it. That order is the whole difference.',
  'तसल्ली जाँच के बाद नहीं, पहले आई। वही क्रम पूरा फ़र्क़ है।',
  'Tasalli jaanch ke baad nahi, pehle aayi. Wahi kram poora farq hai.',
  NULL, 'beginner', 'health,reassurance,fear,communication,sequence'

  UNION ALL SELECT 5, 'school', 2,
  'The week the teacher did not sort them', 'वह हफ़्ता जब शिक्षक ने उन्हें छाँटा नहीं', 'Woh hafta jab teacher ne unhe chhaanta nahi',
  'A class does badly on a piece of work. The teacher, who could reasonably separate the ones who tried from the ones who did not, does not do it. She says one sentence about the class as a whole being capable of this, then teaches the material again. One boy who had been visibly written off by two previous teachers hands in the retake, and it is fine.',
  'एक कक्षा किसी काम में ख़राब करती है। शिक्षिका, जो वाजिब तौर पर कोशिश करने वालों को न करने वालों से अलग कर सकती थीं, ऐसा नहीं करतीं। वे पूरी कक्षा के बारे में एक वाक्य कहती हैं कि यह उनके बस की बात है, और फिर वही पाठ दोबारा पढ़ाती हैं। एक लड़का, जिसे पिछले दो शिक्षक साफ़ तौर पर छोड़ चुके थे, दोबारा वाला काम जमा करता है, और वह ठीक है।',
  'Ek class kisi kaam mein kharab karti hai. Teacher, jo waajib taur par koshish karne walon ko na karne walon se alag kar sakti thi, aisa nahi karti. Woh poori class ke baare mein ek vakya kehti hain ki yeh unke bas ki baat hai, aur phir wahi paath dobara padhati hain. Ek ladka, jise pichhle do teacher saaf taur par chhod chuke the, dobara wala kaam jama karta hai, aur woh theek hai.',
  'The same move as the verse, in a classroom. She had the information to sort them and did not use it, and the reason it works is not kindness for its own sake — it is that being told what kind of person you are is one of the more reliable ways to become it. This is also the same man from the 16.4 example, seen from the other side.',
  'श्लोक वाली ही चाल, एक कक्षा में। उनके पास छाँटने की जानकारी थी और उन्होंने इस्तेमाल नहीं की, और यह इसलिए काम करता है कि दयालुता अपने आप में अच्छी है — ऐसा नहीं; यह इसलिए काम करता है कि आपको किस तरह का इंसान बताया गया है, वह वैसा बनने के भरोसेमंद तरीक़ों में एक है। यह 16.4 वाले उसी आदमी की दूसरी तरफ़ भी है।',
  'Shloka wali hi chaal, ek class mein. Unke paas chhaantne ki jaankari thi aur unhone istemaal nahi ki, aur yeh isliye kaam karta hai ki dayalta apne aap mein achhi hai — aisa nahi; yeh isliye kaam karta hai ki tumhe kis tarah ka insaan bataya gaya hai, woh waisa banne ke bharosemand tareekon mein ek hai. Yeh 16.4 wale usi aadmi ki doosri taraf bhi hai.',
  'Being told what kind of person you are is one of the more reliable ways to become it. That works in both directions.',
  'आपको किस तरह का इंसान बताया गया है, यह वैसा बनने के भरोसेमंद तरीक़ों में एक है। और यह दोनों दिशाओं में चलता है।',
  'Tumhe kis tarah ka insaan bataya gaya hai, yeh waisa banne ke bharosemand tareekon mein ek hai. Aur yeh dono dishaon mein chalta hai.',
  NULL, 'intermediate', 'school,teaching,labels,children,second-chances'

  UNION ALL SELECT 5, 'everyday_life', 3,
  'The sentence somebody still remembers', 'वह वाक्य जो किसी को आज भी याद है', 'Woh vakya jo kisi ko aaj bhi yaad hai',
  'Asked to name a sentence that changed something for them, several people in a room give answers that are almost identical in shape. None is advice. Each is somebody, at a bad moment, saying a version of the same thing about who the person already was.',
  'एक कमरे में कई लोगों से पूछा जाता है कि कोई ऐसा वाक्य बताइए जिसने उनके लिए कुछ बदला। जवाबों का आकार लगभग एक जैसा निकलता है। उनमें से कोई सलाह नहीं है। हर एक में कोई व्यक्ति, किसी बुरे क्षण में, इसी बात का कोई रूप कह रहा है कि वह पहले से क्या था।',
  'Ek kamre mein kai logon se poocha jaata hai ki koi aisa vakya batao jisne unke liye kuch badla. Jawabon ka aakar lagbhag ek jaisa nikalta hai. Unme se koi salah nahi hai. Har ek mein koi insaan, kisi bure pal mein, isi baat ka koi roop keh raha hai ki woh pehle se kya tha.',
  'This is the verse''s move, and the reason it is worth noticing is that it is not what people expect to be told. Nobody in that room named a piece of advice. They named somebody declining to reassess them at the moment they had already reassessed themselves.',
  'यह श्लोक वाली ही चाल है, और इस पर ध्यान देना इसलिए ज़रूरी है कि यह वह नहीं है जो लोग सुनने की उम्मीद करते हैं। उस कमरे में किसी ने कोई सलाह नहीं बताई। सबने किसी ऐसे को बताया जिसने उस क्षण उन्हें दोबारा आँकने से इनकार किया जब वे ख़ुद को दोबारा आँक चुके थे।',
  'Yeh shloka wali hi chaal hai, aur is par dhyan dena isliye zaroori hai ki yeh woh nahi hai jo log sunne ki ummeed karte hain. Us kamre mein kisi ne koi salah nahi batayi. Sabne kisi aise ko bataya jisne us pal unhe dobara aankne se inkaar kiya jab woh khud ko dobara aank chuke the.',
  'The sentences people remember are almost never advice. They are somebody declining to reassess them.',
  'जो वाक्य लोगों को याद रहते हैं वे लगभग कभी सलाह नहीं होते। वे किसी का उन्हें दोबारा आँकने से इनकार होते हैं।',
  'Jo vakya logon ko yaad rehte hain woh lagbhag kabhi salah nahi hote. Woh kisi ka unhe dobara aankne se inkaar hote hain.',
  NULL, 'beginner', 'memory,encouragement,words,people,turning-points'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 16;

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

  SELECT 10 AS vn, 'corporate' AS cat, 1 AS ord,
  'The belief that was three years out of date' AS t_en, 'वह धारणा जो तीन साल पुरानी पड़ चुकी थी' AS t_hi, 'Woh dharna jo teen saal purani pad chuki thi' AS t_hing,
  'A manager has held for years that a particular colleague is careless. It was true once. Reviewing three years of that colleague''s output at somebody else''s request, he cannot find an instance after the first year. He notices, with some discomfort, that dropping the belief would mean revisiting two decisions he made partly on the strength of it.' AS s_en,
  'एक मैनेजर सालों से मानता आया है कि एक ख़ास सहकर्मी लापरवाह है। यह कभी सच था। किसी और के कहने पर उस सहकर्मी के तीन साल का काम देखते हुए उसे पहले साल के बाद एक भी उदाहरण नहीं मिलता। उसे कुछ असहजता के साथ यह ध्यान आता है कि इस धारणा को छोड़ने का मतलब होगा अपने दो फ़ैसलों पर दोबारा जाना जो उसने कुछ हद तक इसी के बल पर लिए थे।' AS s_hi,
  'Ek manager saalon se maanta aaya hai ki ek khaas colleague laparwah hai. Yeh kabhi sach tha. Kisi aur ke kehne par us colleague ke teen saal ka kaam dekhte hue use pehle saal ke baad ek bhi udaharan nahi milta. Use kuch asahajta ke saath yeh dhyan aata hai ki is dharna ko chhodne ka matlab hoga apne do faislon par dobara jaana jo usne kuch had tak isi ke bal par liye the.' AS s_hing,
  'Asad-grāhān is the phrase — holding on to things that are not true — and this is the shape it actually takes. He is not lying and he is not stupid. The belief is load-bearing: two other things are resting on it, and dropping it means taking their weight somewhere else.' AS c_en,
  'असद्ग्राहान् वही वाक्यांश है — उन बातों को थामे रहना जो सच नहीं हैं — और असल में यह इसी आकार में आता है। वह झूठ नहीं बोल रहा और मूर्ख भी नहीं है। धारणा भार उठा रही है: दो और चीज़ें उस पर टिकी हैं, और उसे छोड़ने का मतलब है उनका वज़न कहीं और ले जाना।' AS c_hi,
  'Asad-grahan wahi vakyansh hai — un baaton ko thame rehna jo sach nahi hain — aur asal mein yeh isi aakar mein aata hai. Woh jhooth nahi bol raha aur moorkh bhi nahi hai. Dharna bhaar utha rahi hai: do aur cheezein us par tiki hain, aur use chhodne ka matlab hai unka wazan kahin aur le jaana.' AS c_hing,
  'A false belief that has nothing resting on it gets dropped easily. The ones that persist are load-bearing.' AS l_en,
  'जिस झूठी धारणा पर कुछ टिका न हो वह आसानी से छूट जाती है। जो टिकी रहती हैं वे भार उठा रही होती हैं।' AS l_hi,
  'Jis jhoothi dharna par kuch tika na ho woh aasani se chhoot jaati hai. Jo tiki rehti hain woh bhaar utha rahi hoti hain.' AS l_hing,
  NULL AS src, 'advanced' AS diff, 'work,belief,evidence,judgement,honesty' AS tags

  UNION ALL SELECT 10, 'finance', 2,
  'The number with a story attached', 'वह आँकड़ा जिसके साथ एक कहानी थी', 'Woh number jiske saath ek kahani thi',
  'Somebody wants a particular kind of car and can describe, fluently and at length, why it is the sensible purchase — resale, reliability, running costs. Every fact is accurate. A friend asks what they would buy if nobody ever saw them driving it, and the answer takes noticeably longer to arrive.',
  'किसी को एक ख़ास तरह की गाड़ी चाहिए और वह धाराप्रवाह और विस्तार से बता सकता है कि यह समझदारी वाली ख़रीद क्यों है — दोबारा बेचने का दाम, भरोसा, चलाने का ख़र्च। हर तथ्य सही है। एक दोस्त पूछता है कि अगर उन्हें कोई चलाते हुए कभी न देखे तो वे क्या ख़रीदेंगे, और जवाब आने में साफ़ तौर पर ज़्यादा समय लगता है।',
  'Kisi ko ek khaas tarah ki gaadi chahiye aur woh dhaarapravah aur vistar se bata sakta hai ki yeh samajhdari wali kharid kyun hai — dobara bechne ka daam, bharosa, chalane ka kharch. Har tathya sahi hai. Ek dost poochta hai ki agar unhe koi chalate hue kabhi na dekhe to woh kya kharidenge, aur jawab aane mein saaf taur par zyada samay lagta hai.',
  'This is the covering the verse describes — dambha, the performance layer that sits on top of the want and gives it respectable clothes. Nothing said was false. The question is only what the reasoning is for, and the pause is the answer.',
  'यह वही आवरण है जो श्लोक बताता है — दम्भ, वह दिखावे की परत जो चाह के ऊपर बैठकर उसे इज़्ज़तदार कपड़े पहना देती है। जो कहा गया उसमें कुछ झूठ नहीं था। सवाल सिर्फ़ यह है कि यह तर्क किसलिए है, और वह ठहराव ही जवाब है।',
  'Yeh wahi aavaran hai jo shloka batata hai — dambh, woh dikhave ki parat jo chaah ke upar baithkar use izzatdar kapde pehna deti hai. Jo kaha gaya usme kuch jhooth nahi tha. Sawaal sirf yeh hai ki yeh tark kisliye hai, aur woh thehrav hi jawab hai.',
  'Ask what you would choose if nobody saw. The length of the pause is the finding.',
  'पूछिए कि अगर कोई देखता ही नहीं तो आप क्या चुनते। ठहराव की लंबाई ही नतीजा है।',
  'Poocho ki agar koi dekhta hi nahi to tum kya chunte. Thehrav ki lambai hi nateeja hai.',
  NULL, 'beginner', 'money,status,reasons,honesty,purchase'

  UNION ALL SELECT 10, 'startup', 3,
  'Growth at any number', 'किसी भी आँकड़े पर बढ़त', 'Kisi bhi number par badhat',
  'A company hits every target it set for itself over four years and at no point does the pressure change. Each milestone is followed within about a fortnight by a new one that makes the previous one look like a base. A departing employee writes in an exit note that she never once heard anybody say a number was enough, and that she is not sure such a number exists.',
  'एक कंपनी चार साल में अपने तय किए हर लक्ष्य तक पहुँचती है और किसी भी मोड़ पर दबाव नहीं बदलता। हर पड़ाव के क़रीब दो हफ़्ते के भीतर एक नया पड़ाव आ जाता है जो पिछले को आधार जैसा दिखा देता है। जाती हुई एक कर्मचारी अपने विदाई नोट में लिखती है कि उसने कभी किसी को यह कहते नहीं सुना कि कोई आँकड़ा काफ़ी है, और उसे यक़ीन नहीं कि ऐसा कोई आँकड़ा है भी।',
  'Ek company chaar saal mein apne tay kiye har lakshya tak pahunchti hai aur kisi bhi mod par dabav nahi badalta. Har padav ke karib do hafte ke bheetar ek naya padav aa jaata hai jo pichhle ko aadhar jaisa dikha deta hai. Jaati hui ek karmchari apne vidai note mein likhti hai ki usne kabhi kisi ko yeh kehte nahi suna ki koi number kaafi hai, aur use yakeen nahi ki aisa koi number hai bhi.',
  'Duṣpūram — hard to fill — is a structural description rather than a moral one, and it applies to arrangements as readily as to people. Nobody here is behaving badly. The target moved every time it was reached, which is what the word describes, and four years is long enough to establish that it always will.',
  'दुष्पूरम् — जिसे भरना कठिन है — नैतिक नहीं, ढाँचे का वर्णन है, और यह लोगों जितनी ही आसानी से व्यवस्थाओं पर लगता है। यहाँ कोई बुरा बरताव नहीं कर रहा। लक्ष्य हर बार पहुँचने पर खिसक गया, और यही वह शब्द बताता है — और चार साल यह साबित करने के लिए काफ़ी हैं कि वह हमेशा खिसकेगा।',
  'Dushpuram — jise bharna mushkil hai — naitik nahi, dhaanche ka varnan hai, aur yeh logon jitni hi aasani se vyavasthaon par lagta hai. Yahan koi bura bartav nahi kar raha. Lakshya har baar pahunchne par khisak gaya, aur yahi woh shabd batata hai — aur chaar saal yeh sabit karne ke liye kaafi hain ki woh hamesha khiskega.',
  'Insatiable is a structural word, not a moral one. Arrangements can be it as easily as people.',
  'न भरने वाला ढाँचे का शब्द है, नैतिक नहीं। व्यवस्थाएँ भी उतनी ही आसानी से ऐसी हो सकती हैं जितने लोग।',
  'Na bharne wala dhaanche ka shabd hai, naitik nahi. Vyavasthayein bhi utni hi aasani se aisi ho sakti hain jitne log.',
  NULL, 'intermediate', 'business,targets,enough,pressure,culture'

  UNION ALL SELECT 13, 'corporate', 1,
  'The drive home after the good news', 'अच्छी ख़बर के बाद घर की ड्राइव', 'Achhi khabar ke baad ghar ki drive',
  'A promotion comes through at four in the afternoon. By the time the person reaches home at six they have worked out what the next one would be, roughly when it would come, and what they would need to have done by then. They tell their family the news at dinner and are already slightly bored of it.',
  'दोपहर चार बजे तरक़्क़ी की ख़बर आती है। छह बजे घर पहुँचते-पहुँचते वह व्यक्ति तय कर चुका है कि अगली क्या होगी, लगभग कब आएगी, और तब तक उसे क्या-क्या कर चुका होना होगा। रात के खाने पर वह परिवार को ख़बर सुनाता है और तब तक उससे हल्का ऊब भी चुका है।',
  'Dopahar chaar baje tarakki ki khabar aati hai. Chhah baje ghar pahunchte-pahunchte woh insaan tay kar chuka hai ki agli kya hogi, lagbhag kab aayegi, aur tab tak use kya-kya kar chuka hona hoga. Raat ke khaane par woh parivar ko khabar sunata hai aur tab tak usse halka oob bhi chuka hai.',
  'Two hours, and the verse is a transcript of them. Got this today, will get that next. Nothing here is a character flaw; the sentence runs in almost everybody and it runs fastest right after something good, which is the part worth knowing.',
  'दो घंटे, और श्लोक उन्हीं की नक़ल है। यह आज मिल गया, वह अगला मिलेगा। यहाँ कोई चरित्र की ख़ामी नहीं है; यह वाक्य लगभग सबमें चलता है और सबसे तेज़ तब चलता है जब अभी-अभी कुछ अच्छा हुआ हो, और जानने लायक हिस्सा यही है।',
  'Do ghante, aur shloka unhi ki nakal hai. Yeh aaj mil gaya, woh agla milega. Yahan koi charitra ki khami nahi hai; yeh vakya lagbhag sabme chalta hai aur sabse tez tab chalta hai jab abhi-abhi kuch achha hua ho, aur jaanne layak hissa yahi hai.',
  'The sentence runs fastest right after something good. That is when to catch it.',
  'यह वाक्य सबसे तेज़ तभी चलता है जब अभी-अभी कुछ अच्छा हुआ हो। पकड़ने का समय वही है।',
  'Yeh vakya sabse tez tabhi chalta hai jab abhi-abhi kuch achha hua ho. Pakadne ka samay wahi hai.',
  NULL, 'beginner', 'work,promotion,satisfaction,wanting,arriving'

  UNION ALL SELECT 13, 'everyday_life', 2,
  'The house that was going to be enough', 'वह घर जो काफ़ी होने वाला था', 'Woh ghar jo kaafi hone wala tha',
  'A couple who spent six years saving for a particular kind of home move into it. Both describe the first three weeks as genuinely happy. In the fourth week one of them mentions a room the house does not have, lightly, as a joke, and both of them notice the joke land differently than intended.',
  'एक जोड़ा, जिसने एक ख़ास तरह के घर के लिए छह साल बचत की, उसमें आ जाता है। दोनों पहले तीन हफ़्तों को सचमुच ख़ुशी वाले बताते हैं। चौथे हफ़्ते उनमें से एक हल्के-फुल्के मज़ाक़ में एक ऐसे कमरे का ज़िक्र करता है जो घर में नहीं है, और दोनों को लगता है कि मज़ाक़ वैसे नहीं गिरा जैसा इरादा था।',
  'Ek joda, jisne ek khaas tarah ke ghar ke liye chhah saal bachat ki, usme aa jaata hai. Dono pehle teen hafton ko sach mein khushi wale batate hain. Chauthe hafte unme se ek halke-fulke mazaak mein ek aise kamre ka zikr karta hai jo ghar mein nahi hai, aur dono ko lagta hai ki mazaak waise nahi gira jaisa iraada tha.',
  'The three weeks were real and the verse does not deny them. What it describes is the fourth, and the honest finding is not that the couple are ungrateful — it is that the sentence starts up again on its own, without permission, and being aware of it does not stop it starting.',
  'वे तीन हफ़्ते सच्चे थे और श्लोक उनसे इनकार नहीं करता। वह चौथे का वर्णन करता है, और ईमानदार निष्कर्ष यह नहीं है कि जोड़ा कृतघ्न है — यह है कि वाक्य अपने आप, बिना इजाज़त, फिर से चालू हो जाता है, और इसका पता होना उसे चालू होने से रोकता नहीं।',
  'Woh teen hafte sachche the aur shloka unse inkaar nahi karta. Woh chauthe ka varnan karta hai, aur imaandar nishkarsh yeh nahi hai ki joda kritaghna hai — yeh hai ki vakya apne aap, bina ijazat, phir se chaalu ho jaata hai, aur iska pata hona use chaalu hone se rokta nahi.',
  'The three good weeks were real. So is the fourth, and knowing about the fourth does not prevent it.',
  'वे तीन अच्छे हफ़्ते सच्चे थे। चौथा भी सच्चा है, और चौथे के बारे में जानना उसे रोकता नहीं।',
  'Woh teen achhe hafte sachche the. Chautha bhi sachcha hai, aur chauthe ke baare mein jaanna use rokta nahi.',
  NULL, 'beginner', 'home,contentment,wanting,couples,enough'

  UNION ALL SELECT 13, 'college', 3,
  'Four years of next', 'अगले के चार साल', 'Agle ke chaar saal',
  'A student describes their degree afterwards as four years spent preparing for the thing after it. First year for second-year options, second for internships, third for placements, fourth for the job. Asked what they enjoyed, they name one week in the second year when a scheduling error left them with nothing to prepare for.',
  'एक छात्र बाद में अपनी डिग्री को चार साल बताता है जो उसके बाद वाली चीज़ की तैयारी में गए। पहला साल दूसरे साल के विकल्पों के लिए, दूसरा इंटर्नशिप के लिए, तीसरा प्लेसमेंट के लिए, चौथा नौकरी के लिए। पूछने पर कि क्या अच्छा लगा, वह दूसरे साल का एक हफ़्ता बताता है जब समय-सारणी की एक ग़लती से उसके पास तैयारी करने को कुछ था ही नहीं।',
  'Ek student baad mein apni degree ko chaar saal batata hai jo uske baad wali cheez ki taiyari mein gaye. Pehla saal doosre saal ke options ke liye, doosra internship ke liye, teesra placement ke liye, chautha naukri ke liye. Poochne par ki kya achha laga, woh doosre saal ka ek hafta batata hai jab timetable ki ek galti se uske paas taiyari karne ko kuch tha hi nahi.',
  'Every clause of the verse handing off to the next, extended over four years. The week they name is the one clause that had nowhere to hand off to, and it is worth noticing that it is also the only part they remember enjoying.',
  'श्लोक का हर टुकड़ा अगले को सौंपता हुआ, चार साल तक खिंचा हुआ। जो हफ़्ता वे बताते हैं वह इकलौता टुकड़ा है जिसके पास सौंपने को कुछ था ही नहीं, और ध्यान देने लायक है कि वही इकलौता हिस्सा है जिसे उन्हें अच्छा लगना याद है।',
  'Shloka ka har tukda agle ko saunpta hua, chaar saal tak khincha hua. Jo hafta woh batate hain woh iklauta tukda hai jiske paas saunpne ko kuch tha hi nahi, aur dhyan dene layak hai ki wahi iklauta hissa hai jise unhe achha lagna yaad hai.',
  'The only part they remember enjoying is the one week that had nothing to hand off to.',
  'जो इकलौता हिस्सा उन्हें अच्छा लगना याद है वह वही हफ़्ता है जिसके पास सौंपने को कुछ था ही नहीं।',
  'Jo iklauta hissa unhe achha lagna yaad hai woh wahi hafta hai jiske paas saunpne ko kuch tha hi nahi.',
  NULL, 'intermediate', 'study,preparation,present,enjoyment,future'

  UNION ALL SELECT 16, 'social_media', 1,
  'Everybody else''s pattern', 'बाक़ी सबका ढर्रा', 'Baaki sabka dharra',
  'A person is unusually good at describing what drives other people — the friend who needs to be needed, the colleague who has to win small things. They are accurate often enough that others ask them about it. Asked once, gently, what somebody would say drives them, they give an answer that two people present recognise as not the real one, and nobody says so.',
  'एक व्यक्ति यह बताने में असामान्य रूप से अच्छा है कि दूसरों को क्या चलाता है — वह दोस्त जिसे ज़रूरत महसूस होना चाहिए, वह सहकर्मी जिसे छोटी चीज़ें जीतनी ही हैं। वह इतनी बार सही होता है कि लोग उससे पूछने लगते हैं। एक बार नरमी से पूछे जाने पर कि कोई उसके बारे में क्या कहेगा कि उसे क्या चलाता है, वह ऐसा जवाब देता है जिसे वहाँ मौजूद दो लोग असली नहीं मानते, और कोई कहता नहीं।',
  'Ek insaan yeh batane mein asamanya roop se achha hai ki doosron ko kya chalata hai — woh dost jise zaroorat mehsoos honi chahiye, woh colleague jise chhoti cheezein jeetni hi hain. Woh itni baar sahi hota hai ki log usse poochne lagte hain. Ek baar narmi se poochhe jaane par ki koi uske baare mein kya kahega ki use kya chalata hai, woh aisa jawab deta hai jise wahan maujood do log asli nahi maante, aur koi kehta nahi.',
  'A net is invisible from inside, and this is that claim in its cleanest form. The skill is real — they genuinely can see other people''s. The difficulty has nothing to do with skill, because seeing the shape of a thing requires standing outside it and nobody is standing outside their own.',
  'जाल भीतर से अदृश्य होता है, और यह उसी दावे का सबसे साफ़ रूप है। हुनर असली है — वे सचमुच दूसरों का देख सकते हैं। मुश्किल का हुनर से कोई लेना-देना नहीं, क्योंकि किसी चीज़ का आकार देखने के लिए उसके बाहर खड़ा होना पड़ता है और अपने वाले के बाहर कोई खड़ा नहीं है।',
  'Jaal bheetar se adrishya hota hai, aur yeh usi claim ka sabse saaf roop hai. Hunar asli hai — woh sach mein doosron ka dekh sakte hain. Mushkil ka hunar se koi lena-dena nahi, kyunki kisi cheez ka aakar dekhne ke liye uske bahar khada hona padta hai aur apne wale ke bahar koi khada nahi hai.',
  'Being good at reading other people is not evidence of being able to read yourself. It may be the opposite.',
  'दूसरों को पढ़ने में अच्छा होना इस बात का सबूत नहीं कि आप ख़ुद को पढ़ सकते हैं। शायद उल्टा हो।',
  'Doosron ko padhne mein achha hona is baat ka saboot nahi ki tum khud ko padh sakte ho. Shayad ulta ho.',
  NULL, 'advanced', 'self-knowledge,insight,blind-spots,friendship,honesty'

  UNION ALL SELECT 16, 'everyday_life', 2,
  'Six things wanted at once', 'एक साथ चाही गई छह चीज़ें', 'Ek saath chahi gayi chhah cheezein',
  'Somebody has a free Saturday and by two in the afternoon has done none of the six things they wanted to do with it. Each hour was spent partly on one of them and partly on deciding between the others. In the evening they describe the day as wasted, which is accurate, and as their own fault, which is less clearly the useful description.',
  'किसी के पास एक ख़ाली शनिवार है और दोपहर दो बजे तक उसने उन छह चीज़ों में से एक भी नहीं की जो वह करना चाहता था। हर घंटा कुछ हद तक उनमें से किसी एक पर गया और कुछ हद तक बाक़ी के बीच तय करने पर। शाम को वह दिन को बर्बाद बताता है, जो सही है, और अपनी ग़लती बताता है, जो उतना साफ़ काम का वर्णन नहीं है।',
  'Kisi ke paas ek khaali Saturday hai aur dopahar do baje tak usne un chhah cheezon mein se ek bhi nahi ki jo woh karna chahta tha. Har ghanta kuch had tak unme se kisi ek par gaya aur kuch had tak baaki ke beech tay karne par. Shaam ko woh din ko barbaad batata hai, jo sahi hai, aur apni galti batata hai, jo utna saaf kaam ka varnan nahi hai.',
  'Aneka-citta-vibhrāntā — scattered by many minds at once — is the phrase, and it describes a mechanism rather than a failing. Six wants pulling simultaneously do not produce a sixth of six things. They produce the afternoon this person had, and naming it as laziness makes it harder to fix rather than easier.',
  'अनेकचित्तविभ्रान्ता — एक साथ बहुत सारे मनों से बिखरा हुआ — यही वाक्यांश है, और यह किसी कमी का नहीं, एक तंत्र का वर्णन है। एक साथ खींचती छह चाहें छह चीज़ों का छठा हिस्सा नहीं देतीं। वे यही दोपहर देती हैं, और इसे आलस कहना इसे ठीक करना आसान नहीं, मुश्किल बनाता है।',
  'Aneka-chitta-vibhranta — ek saath bahut saare mano se bikhra hua — yahi vakyansh hai, aur yeh kisi kami ka nahi, ek mechanism ka varnan hai. Ek saath kheenchti chhah chaahein chhah cheezon ka chhatha hissa nahi deti. Woh yahi dopahar deti hain, aur ise aalas kehna ise theek karna asaan nahi, mushkil banata hai.',
  'Six wants pulling at once do not produce a sixth of six things. They produce an afternoon like that one.',
  'एक साथ खींचती छह चाहें छह चीज़ों का छठा हिस्सा नहीं देतीं। वे वैसी ही एक दोपहर देती हैं।',
  'Ek saath kheenchti chhah chaahein chhah cheezon ka chhatha hissa nahi deti. Woh waisi hi ek dopahar deti hain.',
  NULL, 'beginner', 'time,focus,wanting,procrastination,weekend'

  UNION ALL SELECT 16, 'relationships', 3,
  'The pattern somebody named out loud', 'वह ढर्रा जो किसी ने ज़ोर से बता दिया', 'Woh dharra jo kisi ne zor se bata diya',
  'A friend of many years says one sentence describing something the other does in every relationship. The immediate response is a counter-example, delivered quickly and with three supporting details. About four months later, in an unrelated conversation, the same person repeats the sentence back as though they had arrived at it themselves.',
  'बरसों के एक दोस्त एक वाक्य कहते हैं जो बताता है कि दूसरा हर रिश्ते में क्या करता है। तुरंत जवाब में एक उल्टा उदाहरण आता है, जल्दी से और तीन सहारा देते ब्यौरों के साथ। क़रीब चार महीने बाद, किसी और ही बातचीत में, वही व्यक्ति वह वाक्य ऐसे दोहराता है जैसे वह ख़ुद उस तक पहुँचा हो।',
  'Barson ke ek dost ek vakya kehte hain jo batata hai ki doosra har rishte mein kya karta hai. Turant jawab mein ek ulta example aata hai, jaldi se aur teen sahara dete byoron ke saath. Karib chaar mahine baad, kisi aur hi baat mein, wahi insaan woh vakya aise dohrata hai jaise woh khud us tak pahuncha ho.',
  'The speed of the counter-example is the interesting part — three supporting details assembled faster than the sentence took to say. The verse says the net is invisible from inside, and this is what the edge of it feels like from within: not disagreement, but a rebuttal arriving before the thought does.',
  'दिलचस्प हिस्सा उल्टे उदाहरण की तेज़ी है — तीन सहारा देते ब्यौरे उस वाक्य को कहने में लगे समय से भी जल्दी जुट गए। श्लोक कहता है कि जाल भीतर से अदृश्य है, और भीतर से उसका किनारा ऐसा ही लगता है: असहमति नहीं, बल्कि सोच से पहले पहुँच जाने वाला जवाब।',
  'Dilchasp hissa ulte example ki tezi hai — teen sahara dete byore us vakya ko kehne mein lage samay se bhi jaldi jut gaye. Shloka kehta hai ki jaal bheetar se adrishya hai, aur bheetar se uska kinara aisa hi lagta hai: asahmati nahi, balki soch se pehle pahunch jaane wala jawab.',
  'The tell is not disagreement. It is a rebuttal that arrives faster than the thought could have.',
  'निशानी असहमति नहीं है। निशानी वह जवाब है जो सोच से भी तेज़ पहुँच जाता है।',
  'Nishani asahmati nahi hai. Nishani woh jawab hai jo soch se bhi tez pahunch jaata hai.',
  NULL, 'advanced', 'friendship,feedback,defensiveness,self-knowledge,patterns'

  UNION ALL SELECT 21, 'everyday_life', 1,
  'Three doors in one evening', 'एक शाम में तीन दरवाज़े', 'Ek shaam mein teen darwaze',
  'An ordinary Tuesday evening: wanting something seen at six, being short with somebody at half past seven for a reason that turns out to connect to the six o''clock thing, and at nine refusing to lend out something that would have been no trouble to lend. Three separate small events. Nobody involved connects them, including the person they happened in.',
  'एक साधारण मंगलवार की शाम: छह बजे कुछ देखकर उसकी चाह, साढ़े सात बजे किसी से रूखा बोलना जिसकी वजह छह बजे वाली बात से जुड़ी निकलती है, और नौ बजे कोई चीज़ उधार देने से मना कर देना जिसे देने में कोई तकलीफ़ नहीं थी। तीन अलग-अलग छोटी घटनाएँ। इनमें शामिल कोई इन्हें जोड़ता नहीं, वह व्यक्ति भी नहीं जिसमें ये हुईं।',
  'Ek sadharan Tuesday ki shaam: chhah baje kuch dekhkar uski chaah, saade saat baje kisi se rookha bolna jiski wajah chhah baje wali baat se judi nikalti hai, aur nau baje koi cheez udhaar dene se mana kar dena jise dene mein koi takleef nahi thi. Teen alag-alag chhoti ghatnayein. Inme shamil koi inhe jodta nahi, woh insaan bhi nahi jisme yeh huin.',
  'Kāma, krodha, lobha in the order the verse names them, inside three hours, at a scale nobody would report. The verse calls them gates, which is the right word — they are not disasters, they are how a person gets somewhere they did not plan to go.',
  'काम, क्रोध, लोभ — उसी क्रम में जिसमें श्लोक उनका नाम लेता है, तीन घंटों के भीतर, इतने छोटे पैमाने पर कि कोई बताएगा भी नहीं। श्लोक इन्हें दरवाज़े कहता है, और यही सही शब्द है — ये आपदाएँ नहीं हैं, ये वह तरीक़ा हैं जिससे आदमी वहाँ पहुँच जाता है जहाँ जाने का उसका इरादा नहीं था।',
  'Kama, krodha, lobh — usi kram mein jisme shloka unka naam leta hai, teen ghanton ke bheetar, itne chhote paimane par ki koi bataega bhi nahi. Shloka inhe darwaze kehta hai, aur yahi sahi shabd hai — yeh aapdayein nahi hain, yeh woh tareeka hain jisse aadmi wahan pahunch jaata hai jahan jaane ka uska iraada nahi tha.',
  'They are gates, not disasters. Nobody walks through one on purpose and everybody walks through them.',
  'ये दरवाज़े हैं, आपदाएँ नहीं। इनसे कोई जानबूझकर नहीं गुज़रता और सब गुज़रते हैं।',
  'Yeh darwaze hain, aapdayein nahi. Inse koi jaanboojhkar nahi guzarta aur sab guzarte hain.',
  NULL, 'beginner', 'ordinary,anger,wanting,greed,evening'

  UNION ALL SELECT 21, 'finance', 2,
  'The thing that could not be given away', 'वह चीज़ जो दी नहीं जा सकी', 'Woh cheez jo di nahi ja saki',
  'Clearing a house after a death, a family finds a cupboard of things nobody has used in fifteen years and nobody can throw out. Several of the items have no value of any kind. One person notices that the difficulty is not sentiment — they cannot identify a memory attached to most of it — and that the difficulty is present anyway.',
  'किसी की मृत्यु के बाद घर ख़ाली करते हुए परिवार को एक अलमारी मिलती है जिसमें ऐसी चीज़ें हैं जिन्हें पंद्रह साल से किसी ने इस्तेमाल नहीं किया और कोई फेंक नहीं पा रहा। उनमें कई चीज़ों की कोई क़ीमत ही नहीं है। एक व्यक्ति को ध्यान आता है कि मुश्किल भावुकता नहीं है — ज़्यादातर चीज़ों से जुड़ी कोई याद वह बता ही नहीं सकता — और फिर भी मुश्किल मौजूद है।',
  'Kisi ki mrityu ke baad ghar khaali karte hue parivar ko ek almari milti hai jisme aisi cheezein hain jinhe pandrah saal se kisi ne istemaal nahi kiya aur koi phenk nahi paa raha. Unme kai cheezon ki koi keemat hi nahi hai. Ek insaan ko dhyan aata hai ki mushkil bhavukta nahi hai — zyadatar cheezon se judi koi yaad woh bata hi nahi sakta — aur phir bhi mushkil maujood hai.',
  'Lobha is the third gate and the least discussed of the three, partly because it is usually translated as greed and pictured as wanting more. What it describes here is narrower and more common: the reflex of closing the hand around what is already in it, operating independently of value, memory or use.',
  'लोभ तीसरा दरवाज़ा है और तीनों में सबसे कम चर्चा वाला, कुछ हद तक इसलिए कि इसका अनुवाद आम तौर पर लालच होता है और तस्वीर "और चाहिए" की बनती है। यहाँ यह जो बताता है वह छोटा और ज़्यादा आम है: जो हाथ में पहले से है उस पर मुट्ठी बंद करने की प्रतिवर्त क्रिया, जो क़ीमत, याद या उपयोग से अलग चलती है।',
  'Lobh teesra darwaza hai aur teenon mein sabse kam charcha wala, kuch had tak isliye ki iska anuvaad aam taur par laalach hota hai aur tasveer "aur chahiye" ki banti hai. Yahan yeh jo batata hai woh chhota aur zyada aam hai: jo haath mein pehle se hai us par mutthi band karne ki reflex, jo keemat, yaad ya upyog se alag chalti hai.',
  'Greed is not mainly wanting more. It is the hand closing around what is already in it, regardless of what that is.',
  'लोभ मुख्य रूप से "और चाहिए" नहीं है। यह उस मुट्ठी का बंद होना है जो पहले से भरी है, चाहे उसमें जो भी हो।',
  'Lobh mukhya roop se "aur chahiye" nahi hai. Yeh us mutthi ka band hona hai jo pehle se bhari hai, chahe usme jo bhi ho.',
  NULL, 'intermediate', 'possessions,greed,family,clearing,letting-go'

  UNION ALL SELECT 21, 'ethics', 3,
  'Put down, not fought', 'रख देना, लड़ना नहीं', 'Rakh dena, ladna nahi',
  'Somebody spends two years fighting a temper, with a technique for every situation and a record of every failure. The record grows. In the third year they change nothing about the temper and a great deal about their sleep, their commute and how much they agree to do in a week. The record stops growing.',
  'कोई दो साल अपने गुस्से से लड़ता है, हर स्थिति के लिए एक तरीक़ा और हर नाकामी का हिसाब रखते हुए। हिसाब बढ़ता जाता है। तीसरे साल वह गुस्से के बारे में कुछ नहीं बदलता और अपनी नींद, अपने आने-जाने और एक हफ़्ते में कितना करने को हाँ कहता है — इनमें बहुत कुछ बदलता है। हिसाब बढ़ना बंद हो जाता है।',
  'Koi do saal apne gusse se ladta hai, har sthiti ke liye ek tareeka aur har nakami ka hisaab rakhte hue. Hisaab badhta jaata hai. Teesre saal woh gusse ke baare mein kuch nahi badalta aur apni neend, apne aane-jaane aur ek hafte mein kitna karne ko haan kehta hai — inme bahut kuch badalta hai. Hisaab badhna band ho jaata hai.',
  'The verb in the verse is tyajet — let go, set down — and not a verb of combat, which is easy to skim past and turns out to matter. Two years of fighting produced a detailed record of losses. What worked was not a better fight; it was removing the conditions the thing needed.',
  'श्लोक की क्रिया त्यजेत् है — छोड़ दे, रख दे — न कि लड़ाई की कोई क्रिया, जिसे पढ़ते हुए छोड़ देना आसान है और जो मायने रखती है। दो साल की लड़ाई ने हार का ब्योरेवार हिसाब दिया। जो चला वह बेहतर लड़ाई नहीं थी; वे हालात हटाना था जो उस चीज़ को चाहिए थे।',
  'Shloka ki kriya tyajet hai — chhod de, rakh de — na ki ladai ki koi kriya, jise padhte hue chhod dena aasan hai aur jo maayne rakhti hai. Do saal ki ladai ne haar ka byorewar hisaab diya. Jo chala woh behtar ladai nahi thi; woh haalat hatana tha jo us cheez ko chahiye the.',
  'The verb is set down, not fight. Two years of fighting mostly produces a record of losing.',
  'क्रिया "रख दे" है, "लड़" नहीं। दो साल की लड़ाई ज़्यादातर हारने का हिसाब ही देती है।',
  'Kriya "rakh de" hai, "lad" nahi. Do saal ki ladai zyadatar haarne ka hisaab hi deti hai.',
  NULL, 'advanced', 'anger,habits,conditions,self-control,strategy'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 16;

-- =====================================================================
-- 5. CROSS REFERENCES
-- =====================================================================
-- 16.21 is the chapter's landing point and it lands on ground chapters 2
-- and 3 already prepared. Those links are not ornamental — a reader who
-- arrives at "three gates" having seen 2.62 and 3.37 reads it as a
-- mechanism, which is the reading that keeps this chapter safe.
-- =====================================================================

DELETE x FROM verse_cross_references x JOIN verses v ON v.id = x.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 16;

INSERT INTO verse_cross_references
  (verse_id, reference_type, book, chapter, verse, target_verse_id,
   description_en, description_hi, description_hinglish, relationship, sort_order)
SELECT v.id, 'gita', 'Bhagavad Gita', CAST(x.tch AS CHAR), CAST(x.tvn AS CHAR), tv.id,
       x.d_en, x.d_hi, x.d_hing, x.rel, x.ord
FROM (
  SELECT 21 AS vn, 2 AS tch, 62 AS tvn, 1 AS ord,
    'The chain in 2.62 runs from dwelling to wanting to anger. This verse names the same things as three doors and tells you to put them down.' AS d_en,
    '2.62 की कड़ी सोचते रहने से चाह और फिर गुस्से तक जाती है। यह श्लोक उन्हीं को तीन दरवाज़े कहता है और रख देने को कहता है।' AS d_hi,
    '2.62 ki chain sochte rehne se chaah aur phir gusse tak jaati hai. Yeh shloka unhi ko teen darwaze kehta hai aur rakh dene ko kehta hai.' AS d_hing,
    'same' AS rel
  UNION ALL SELECT 21, 3, 37, 2,
    'Kama and krodha were named as one enemy with two faces. Here lobha is added, and the three are called gates rather than an enemy — a mechanism, not a villain.',
    'काम और क्रोध को एक ही दुश्मन के दो चेहरे बताया गया था। यहाँ लोभ जुड़ता है, और तीनों को दुश्मन नहीं, दरवाज़े कहा जाता है — तंत्र, खलनायक नहीं।',
    'Kama aur krodha ko ek hi dushman ke do chehre bataya gaya tha. Yahan lobh judta hai, aur teenon ko dushman nahi, darwaze kaha jaata hai — mechanism, khalnayak nahi.',
    'supports'
  UNION ALL SELECT 10, 3, 37, 1,
    'The appetite that never fills up, met again. What 16.10 adds is the covering — the show and the self-importance that give it respectable clothes.',
    'वही भूख जो कभी भरती नहीं, फिर से। 16.10 जो जोड़ता है वह आवरण है — दिखावा और बड़प्पन, जो उसे इज़्ज़तदार कपड़े पहना देते हैं।',
    'Wahi bhookh jo kabhi bharti nahi, phir se. 16.10 jo jodta hai woh aavaran hai — dikhava aur badappan, jo use izzatdar kapde pehna dete hain.',
    'same'
  UNION ALL SELECT 13, 2, 70, 1,
    'The ocean that takes every river without rising, and a sentence that never arrives anywhere. The same claim about wanting, drawn once and transcribed once.',
    'वह समुद्र जो हर नदी लेकर भी नहीं बढ़ता, और वह वाक्य जो कहीं पहुँचता ही नहीं। चाह के बारे में एक ही दावा — एक बार खींचा गया, एक बार लिखा गया।',
    'Woh samudra jo har nadi lekar bhi nahi badhta, aur woh vakya jo kahin pahunchta hi nahi. Chaah ke baare mein ek hi claim — ek baar kheencha gaya, ek baar likha gaya.',
    'opposite'
  UNION ALL SELECT 1, 12, 13, 1,
    'Two lists of the same kind of person, written four chapters apart. Neither contains an achievement.',
    'एक ही तरह के व्यक्ति की दो सूचियाँ, चार अध्याय के अंतर पर लिखी गईं। किसी में कोई उपलब्धि नहीं है।',
    'Ek hi tarah ke insaan ki do list, chaar chapter ke antar par likhi gayin. Kisi mein koi uplabdhi nahi hai.',
    'same'
  UNION ALL SELECT 3, 12, 15, 1,
    'Not thinking too much of yourself, and not disturbing the room you walk into. Both are qualities other people can confirm and you cannot.',
    'ख़ुद को बहुत बड़ा न समझना, और जिस कमरे में जाएँ उसे न हिलाना। दोनों ऐसे गुण हैं जिनकी पुष्टि दूसरे कर सकते हैं, आप नहीं।',
    'Khud ko bahut bada na samajhna, aur jis kamre mein jao use na hilana. Dono aise gun hain jinki pushti doosre kar sakte hain, tum nahi.',
    'supports'
  UNION ALL SELECT 4, 16, 5, 1,
    'The list that could be used to sort people, and the line immediately after it that takes it out of the reader''s hand. Read them together or not at all.',
    'वह सूची जिससे लोगों को छाँटा जा सकता था, और ठीक उसके बाद की पंक्ति जो उसे पाठक के हाथ से ले लेती है। दोनों साथ पढ़िए, वरना कोई नहीं।',
    'Woh list jisse logon ko chhaanta ja sakta tha, aur theek uske baad ki line jo use padhne wale ke haath se le leti hai. Dono saath padho, warna koi nahi.',
    'supports'
  UNION ALL SELECT 5, 3, 35, 1,
    'The other verse in this book with a history of being used against people, and it has the same defence: read what is actually on the page. Neither line says what it has been made to say.',
    'इस किताब का दूसरा श्लोक जिसका इस्तेमाल लोगों के ख़िलाफ़ होता रहा है, और बचाव वही है: जो पन्ने पर सचमुच लिखा है वह पढ़िए। दोनों में से कोई पंक्ति वह नहीं कहती जो उससे कहलवाया गया है।',
    'Is kitaab ka doosra shloka jiska istemaal logon ke khilaf hota raha hai, aur bachav wahi hai: jo panne par sach mein likha hai woh padho. Dono mein se koi line woh nahi kehti jo usse kehlwaya gaya hai.',
    'same'
  UNION ALL SELECT 16, 2, 62, 1,
    'Being pulled apart by many wants at once, and the single chain from dwelling to anger. One describes the crowd, the other one thread in it.',
    'एक साथ बहुत सारी चाहों से बिखरना, और सोचते रहने से गुस्से तक की इकलौती कड़ी। एक भीड़ बताता है, दूसरा उसमें से एक धागा।',
    'Ek saath bahut saari chaahon se bikharna, aur sochte rehne se gusse tak ki iklauti chain. Ek bheed batata hai, doosra usme se ek dhaaga.',
    'supports'
  UNION ALL SELECT 13, 12, 19, 1,
    'Got this, will get that — and content with whatever comes. The two sentences a person can be running, put side by side.',
    'यह मिला, वह मिलेगा — और जो मिल जाए उसी में संतुष्ट। आदमी के भीतर चल सकने वाले दो वाक्य, आमने-सामने।',
    'Yeh mila, woh milega — aur jo mil jaaye usi mein santusht. Aadmi ke bheetar chal sakne wale do vakya, aamne-saamne.',
    'opposite'
) AS x
JOIN verses v  ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 16
JOIN chapters tc ON tc.chapter_number = x.tch
JOIN verses tv ON tv.verse_number = x.tvn AND tv.chapter_id = tc.id;

-- =====================================================================
-- 6. WORD BY WORD
-- =====================================================================
-- Two words in this chapter carry more than their weight and both are
-- glossed carefully rather than dramatically.
--
--   asura      — glossed as the direction of character the chapter is
--                describing. NOT "demon", which imports a creature the
--                verses are not discussing and hands the reader exactly
--                the category the explanations spend their length
--                refusing.
--
--   naraka     — left as the text's own word for where the trajectory
--                ends. Not illustrated, and no claim made about an
--                afterlife in either direction, which is not this
--                product's to settle.
-- =====================================================================

DELETE w FROM verse_word_meanings w JOIN verses v ON v.id = w.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 16;

INSERT INTO verse_word_meanings
  (verse_id, word_order, devanagari, transliteration,
   meaning_en, meaning_hi, meaning_hinglish, grammar, root_word)
SELECT v.id, w.ord, w.dev, w.tr, w.m_en, w.m_hi, w.m_hing, w.gram, w.root FROM (

  -- 16.1
  SELECT 1 AS vn, 1 AS ord, 'अभयम्' AS dev, 'abhayam' AS tr, 'fearlessness — placed first, and the chapter treats it as the root' AS m_en, 'अभय — पहले रखा गया, और अध्याय इसे जड़ मानता है' AS m_hi, 'abhay — pehle rakha gaya, aur chapter ise jad maanta hai' AS m_hing, 'nominative singular' AS gram, 'भी' AS root
  UNION ALL SELECT 1, 2, 'सत्त्वसंशुद्धिः', 'sattva-saṁśuddhiḥ', 'clearness of one''s own being', 'अपने भीतर की सफ़ाई', 'apne bheetar ki safai', 'compound, nominative', 'शुध्'
  UNION ALL SELECT 1, 3, 'ज्ञानयोगव्यवस्थितिः', 'jñāna-yoga-vyavasthitiḥ', 'staying settled in what one understands', 'जो समझा है उसमें जमे रहना', 'jo samjha hai usme jame rehna', 'compound, nominative', 'वि + अव + स्था'
  UNION ALL SELECT 1, 4, 'दानम्', 'dānam', 'giving', 'दान, देना', 'dena', 'nominative singular', 'दा'
  UNION ALL SELECT 1, 5, 'दमः', 'damaḥ', 'restraint — holding yourself back', 'दम — ख़ुद को रोक पाना', 'dam — khud ko rok paana', 'nominative singular', 'दम्'
  UNION ALL SELECT 1, 6, 'यज्ञः', 'yajñaḥ', 'offering — putting something in', 'यज्ञ — कुछ डालना', 'yajna — kuch daalna', 'nominative singular', 'यज्'
  UNION ALL SELECT 1, 7, 'स्वाध्यायः', 'svādhyāyaḥ', 'self-study — reading yourself as well as texts', 'स्वाध्याय — ग्रंथ के साथ ख़ुद को भी पढ़ना', 'svadhyay — granth ke saath khud ko bhi padhna', 'compound, nominative', 'अधि + इ'
  UNION ALL SELECT 1, 8, 'तपः', 'tapaḥ', 'austerity — doing without on purpose', 'तप — जानबूझकर बिना काम चलाना', 'tap — jaanboojhkar bina kaam chalana', 'nominative singular', 'तप्'
  UNION ALL SELECT 1, 9, 'आर्जवम्', 'ārjavam', 'straightness — the same in front and behind', 'आर्जव — सामने और पीठ पीछे एक जैसा', 'aarjav — saamne aur peeth peechhe ek jaisa', 'nominative singular', 'ऋजु'

  -- 16.3
  UNION ALL SELECT 3, 1, 'तेजः', 'tejaḥ', 'force, a kind of heat in a person', 'तेज — आदमी में एक तरह की आँच', 'tej — aadmi mein ek tarah ki aanch', 'nominative singular', 'तिज्'
  UNION ALL SELECT 3, 2, 'क्षमा', 'kṣamā', 'letting things go', 'क्षमा — बातें छोड़ देना', 'kshama — baatein chhod dena', 'nominative singular', 'क्षम्'
  UNION ALL SELECT 3, 3, 'धृतिः', 'dhṛtiḥ', 'holding on, not giving up partway', 'धृति — थामे रहना, बीच में न छोड़ना', 'dhriti — thame rehna, beech mein na chhodna', 'nominative singular', 'धृ'
  UNION ALL SELECT 3, 4, 'शौचम्', 'śaucam', 'cleanness — of dealings as much as of body', 'शौच — शरीर जितना ही लेन-देन का', 'shauch — sharir jitna hi len-den ka', 'nominative singular', 'शुच्'
  UNION ALL SELECT 3, 5, 'अद्रोहः', 'adrohaḥ', 'wishing nobody harm', 'अद्रोह — किसी का बुरा न चाहना', 'adroh — kisi ka bura na chahna', 'nominative singular', 'द्रुह्'
  UNION ALL SELECT 3, 6, 'नातिमानिता', 'nāti-mānitā', 'not thinking too much of yourself — placed LAST, and it locks the list', 'न-अति-मानिता — ख़ुद को बहुत बड़ा न समझना; आख़िर में रखा गया, और यह सूची पर ताला लगाता है', 'na-ati-manita — khud ko bahut bada na samajhna; aakhir mein rakha gaya, aur yeh list par taala lagata hai', 'compound, nominative', 'मन्'
  UNION ALL SELECT 3, 7, 'सम्पदम् दैवीम्', 'sampadam daivīm', 'the daivī endowment — the first of the two directions', 'दैवी सम्पद् — दो दिशाओं में पहली', 'daivi sampad — do dishaon mein pehli', 'accusative singular', 'सम् + पद्'
  UNION ALL SELECT 3, 8, 'अभिजातस्य', 'abhijātasya', 'of one inclined towards — what somebody tends to, not a caste or a birth category', 'अभिजात — जिसका झुकाव जिधर है; कोई जाति या जन्म-श्रेणी नहीं', 'abhijata — jiska jhukav jidhar hai; koi jaati ya janm-shreni nahi', 'genitive singular', 'अभि + जन्'

  -- 16.4
  UNION ALL SELECT 4, 1, 'दम्भः', 'dambhaḥ', 'show — performing a thing rather than being it', 'दम्भ — किसी चीज़ का होना नहीं, दिखाना', 'dambh — kisi cheez ka hona nahi, dikhana', 'nominative singular', 'दम्भ्'
  UNION ALL SELECT 4, 2, 'दर्पः', 'darpaḥ', 'swagger', 'दर्प — अकड़', 'darp — akad', 'nominative singular', 'दृप्'
  UNION ALL SELECT 4, 3, 'अभिमानः', 'abhimānaḥ', 'self-importance', 'अभिमान — अपने बड़प्पन का भाव', 'abhimaan — apne badappan ka bhaav', 'nominative singular', 'अभि + मन्'
  UNION ALL SELECT 4, 4, 'क्रोधः', 'krodhaḥ', 'anger', 'क्रोध, गुस्सा', 'gussa', 'nominative singular', 'क्रुध्'
  UNION ALL SELECT 4, 5, 'पारुष्यम्', 'pāruṣyam', 'harshness — and being right is no defence against it', 'पारुष्य — सख़्ती; और सही होना इसके ख़िलाफ़ बचाव नहीं है', 'parushya — sakhti; aur sahi hona iske khilaf bachav nahi hai', 'nominative singular', 'परुष'
  UNION ALL SELECT 4, 6, 'अज्ञानम्', 'ajñānam', 'not knowing — here, not knowing that any of the other five is happening', 'अज्ञान — यहाँ, यह पता न होना कि बाक़ी पाँच में से कुछ हो भी रहा है', 'ajnana — yahan, yeh pata na hona ki baaki paanch mein se kuch ho bhi raha hai', 'nominative singular', 'ज्ञा'
  UNION ALL SELECT 4, 7, 'सम्पदम् आसुरीम्', 'sampadam āsurīm', 'the āsurī endowment — the second DIRECTION of character. Not a species, not a kind of person, and nowhere in this chapter a group', 'आसुरी सम्पद् — चरित्र की दूसरी दिशा। न कोई प्रजाति, न किसी तरह का व्यक्ति, और इस अध्याय में कहीं भी कोई समूह नहीं', 'aasuri sampad — charitra ki doosri disha. Na koi prajati, na kisi tarah ka insaan, aur is chapter mein kahin bhi koi samuh nahi', 'accusative singular', 'असुर'

  -- 16.5
  UNION ALL SELECT 5, 1, 'दैवी सम्पत्', 'daivī sampat', 'the first endowment', 'पहली सम्पद्', 'pehli sampad', 'nominative singular', 'सम् + पद्'
  UNION ALL SELECT 5, 2, 'विमोक्षाय', 'vimokṣāya', 'towards release, towards things opening out', 'विमोक्ष की ओर, चीज़ों के खुलने की ओर', 'vimoksh ki or, cheezon ke khulne ki or', 'dative singular', 'वि + मुच्'
  UNION ALL SELECT 5, 3, 'निबन्धाय', 'nibandhāya', 'towards being tied up', 'बँध जाने की ओर', 'bandh jaane ki or', 'dative singular', 'नि + बन्ध्'
  UNION ALL SELECT 5, 4, 'मता', 'matā', 'is held to be, is considered', 'माना गया है', 'maana gaya hai', 'past participle, nominative', 'मन्'
  UNION ALL SELECT 5, 5, 'मा शुचः', 'mā śucaḥ', 'do not grieve — said to the listener BEFORE any assessment of him', 'मा शुचः — शोक मत करो; सुनने वाले से उसकी किसी जाँच से पहले कहा गया', 'ma shuchah — shok mat karo; sunne wale se uski kisi jaanch se pehle kaha gaya', 'prohibitive, second person', 'शुच्'
  UNION ALL SELECT 5, 6, 'अभिजातः असि', 'abhijātaḥ asi', 'you are inclined towards — a statement, with no condition attached', 'तुम्हारा झुकाव उधर है — बयान है, इसके साथ कोई शर्त नहीं', 'tumhara jhukav udhar hai — bayan hai, iske saath koi shart nahi', 'nominative, second person', 'अभि + जन्'
  UNION ALL SELECT 5, 7, 'पाण्डव', 'pāṇḍava', 'son of Pandu — Arjuna, addressed by name at exactly this moment', 'पाण्डु का पुत्र — अर्जुन, ठीक इसी क्षण नाम लेकर पुकारा गया', 'Pandu ka putra — Arjun, theek isi pal naam lekar pukara gaya', 'vocative', NULL

  -- 16.10
  UNION ALL SELECT 10, 1, 'कामम्', 'kāmam', 'wanting', 'काम, चाह', 'chaah', 'accusative singular', 'कम्'
  UNION ALL SELECT 10, 2, 'आश्रित्य', 'āśritya', 'having taken shelter in, leaning on', 'सहारा लेकर', 'sahara lekar', 'gerund', 'आ + श्रि'
  UNION ALL SELECT 10, 3, 'दुष्पूरम्', 'duṣpūram', 'hard to fill — a structural word, not a moral one', 'दुष्पूर — जिसे भरना कठिन है; ढाँचे का शब्द, नैतिक नहीं', 'dushpur — jise bharna mushkil hai; dhaanche ka shabd, naitik nahi', 'accusative singular', 'पॄ'
  UNION ALL SELECT 10, 4, 'दम्भमानमदान्विताः', 'dambha-māna-madānvitāḥ', 'accompanied by show, self-importance and a kind of intoxication', 'दम्भ, मान और मद से युक्त', 'dambh, maan aur mad se yukt', 'compound, nominative plural', 'अनु + इ'
  UNION ALL SELECT 10, 5, 'मोहात्', 'mohāt', 'out of confusion', 'मोह से', 'moh se', 'ablative singular', 'मुह्'
  UNION ALL SELECT 10, 6, 'असद्ग्राहान्', 'asad-grāhān', 'holdings that are not true — things gripped rather than things said', 'असत् ग्रह — ऐसी बातें जो सच नहीं, जिन्हें कहा नहीं, थामा जाता है', 'asat grah — aisi baatein jo sach nahi, jinhe kaha nahi, thama jaata hai', 'compound, accusative plural', 'ग्रह्'
  UNION ALL SELECT 10, 7, 'प्रवर्तन्ते', 'pravartante', 'they set out, they act', 'चल पड़ते हैं, काम करते हैं', 'chal padte hain, kaam karte hain', 'present middle, third plural', 'प्र + वृत्'

  -- 16.13
  UNION ALL SELECT 13, 1, 'इदम् अद्य मया लब्धम्', 'idam adya mayā labdham', 'this has been got by me today', 'यह आज मुझे मिल गया', 'yeh aaj mujhe mil gaya', 'nominative, past participle', 'लभ्'
  UNION ALL SELECT 13, 2, 'इमम् प्राप्स्ये', 'imam prāpsye', 'this I shall obtain', 'यह मैं पा लूँगा', 'yeh main paa loonga', 'future, first person', 'प्र + आप्'
  UNION ALL SELECT 13, 3, 'मनोरथम्', 'manoratham', 'a wish — literally a chariot of the mind', 'मनोरथ — शब्दशः मन का रथ', 'manorath — shabdashah man ka rath', 'accusative singular', 'मनस् + रथ'
  UNION ALL SELECT 13, 4, 'इदम् अस्ति', 'idam asti', 'this is already here', 'यह तो है ही', 'yeh to hai hi', 'present, third person', 'अस्'
  UNION ALL SELECT 13, 5, 'मे भविष्यति', 'me bhaviṣyati', 'shall be mine', 'मेरा हो जाएगा', 'mera ho jayega', 'future, third person', 'भू'
  UNION ALL SELECT 13, 6, 'पुनः', 'punaḥ', 'again, further', 'फिर, और', 'phir, aur', 'indeclinable', NULL
  UNION ALL SELECT 13, 7, 'धनम्', 'dhanam', 'wealth', 'धन', 'dhan', 'nominative singular', 'धन'

  -- 16.16
  UNION ALL SELECT 16, 1, 'अनेकचित्तविभ्रान्ताः', 'aneka-citta-vibhrāntāḥ', 'scattered by many minds at once', 'एक साथ बहुत सारे मनों से बिखरे हुए', 'ek saath bahut saare mano se bikhre hue', 'compound, nominative plural', 'वि + भ्रम्'
  UNION ALL SELECT 16, 2, 'मोहजालसमावृताः', 'moha-jāla-samāvṛtāḥ', 'covered over by a net of confusion', 'मोह के जाल से ढँके हुए', 'moh ke jaal se dhanke hue', 'compound, nominative plural', 'वृ'
  UNION ALL SELECT 16, 3, 'प्रसक्ताः', 'prasaktāḥ', 'stuck to, attached', 'चिपके हुए', 'chipke hue', 'past participle, nominative plural', 'प्र + सञ्ज्'
  UNION ALL SELECT 16, 4, 'कामभोगेषु', 'kāma-bhogeṣu', 'in the enjoyment of what is wanted', 'चाही हुई चीज़ों के भोग में', 'chahi hui cheezon ke bhog mein', 'compound, locative plural', 'भुज्'
  UNION ALL SELECT 16, 5, 'पतन्ति', 'patanti', 'they fall', 'गिरते हैं', 'girte hain', 'present, third plural', 'पत्'
  UNION ALL SELECT 16, 6, 'नरके', 'narake', 'in naraka — the text''s own word for where this ends; left as the text''s word', 'नरक में — इस अंत के लिए ग्रंथ का अपना शब्द; ग्रंथ का शब्द ही रहने दिया गया', 'narak mein — is ant ke liye granth ka apna shabd; granth ka shabd hi rehne diya gaya', 'locative singular', 'नरक'
  UNION ALL SELECT 16, 7, 'अशुचौ', 'aśucau', 'unclean', 'अशुचि, मैला', 'ashuchi, maila', 'locative singular', 'शुच्'

  -- 16.21
  UNION ALL SELECT 21, 1, 'त्रिविधम्', 'tri-vidham', 'threefold', 'तीन तरह का', 'teen tarah ka', 'nominative singular', 'त्रि'
  UNION ALL SELECT 21, 2, 'द्वारम्', 'dvāram', 'gate, doorway', 'द्वार, दरवाज़ा', 'darwaza', 'nominative singular', 'द्वार'
  UNION ALL SELECT 21, 3, 'नाशनम् आत्मनः', 'nāśanam ātmanaḥ', 'destroying of the self — a mechanical claim about what they do, not a verdict on who does them', 'आत्मा का नाश करने वाला — ये करते क्या हैं इसका यांत्रिक दावा, न कि करने वाले पर कोई फ़ैसला', 'aatma ka naash karne wala — yeh karte kya hain iska yantrik claim, na ki karne wale par koi faisla', 'nominative singular', 'नश्'
  UNION ALL SELECT 21, 4, 'कामः', 'kāmaḥ', 'wanting', 'काम, चाह', 'chaah', 'nominative singular', 'कम्'
  UNION ALL SELECT 21, 5, 'क्रोधः', 'krodhaḥ', 'anger', 'क्रोध, गुस्सा', 'gussa', 'nominative singular', 'क्रुध्'
  UNION ALL SELECT 21, 6, 'लोभः', 'lobhaḥ', 'grabbing — the hand closing around what is already in it', 'लोभ — जो हाथ में पहले से है उस पर मुट्ठी बंद होना', 'lobh — jo haath mein pehle se hai us par mutthi band hona', 'nominative singular', 'लुभ्'
  UNION ALL SELECT 21, 7, 'त्यजेत्', 'tyajet', 'should let go, should set down — NOT a verb of combat', 'छोड़ देना चाहिए, रख देना चाहिए — लड़ाई की क्रिया नहीं', 'chhod dena chahiye, rakh dena chahiye — ladai ki kriya nahi', 'optative, third person', 'त्यज्'
) AS w
JOIN verses v ON v.verse_number = w.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 16;

-- =====================================================================
-- 7. BEGINNER-DEPTH EXPLANATIONS ADDED LATER
-- =====================================================================
-- Three verses here were seeded at intermediate only, so the default
-- reader met them through the repository's fallback. This adds the
-- beginner depth.
--
-- 16.4's BEGINNER TEXT CARRIES THE SAFEGUARD TOO, AND MUST
--   The safeguard sentence — this chapter describes two directions a
--   person can face, NOT two kinds of person — was written into the
--   intermediate explanation, which is what the default reader was
--   being served by the fallback. The moment a beginner row exists,
--   that row is what the default reader sees instead. If the sentence
--   were only in the intermediate text it would silently disappear from
--   the page almost everybody lands on, which is the exact opposite of
--   what the safeguard is for. smoke-test.sh asserts it on the default
--   render, so this is enforced rather than remembered.
-- =====================================================================

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 4 AS vn, 'beginner' AS level,
   'A list of good qualities has just been read out. This is the other list, and it is short: six things, named without any softening.' AS h_en,
   'अभी अच्छे गुणों की एक सूची पढ़ी गई है। यह दूसरी सूची है, और छोटी है: छह बातें, बिना किसी नरमी के नाम लेकर।' AS h_hi,
   'Abhi achhe gunon ki ek list padhi gayi hai. Yeh doosri list hai, aur chhoti hai: chhah baatein, bina kisi narmi ke naam lekar.' AS h_hing,
   'Performing rather than being. Swagger. Thinking too much of yourself. Anger. Being hard on people. And the sixth, which is the strange one: not knowing that any of the other five is happening. Read them slowly and the honest response is not to think of somebody else. Everybody has done all six.' AS p_en,
   'होना नहीं, दिखाना। अकड़। ख़ुद को बहुत बड़ा समझना। गुस्सा। लोगों के साथ सख़्ती। और छठी, जो अजीब है: यह पता न होना कि बाक़ी पाँच में से कुछ हो भी रहा है। इन्हें धीरे पढ़िए और ईमानदार प्रतिक्रिया किसी और को याद करना नहीं है। हर किसी ने छहों की हैं।' AS p_hi,
   'Hona nahi, dikhana. Akad. Khud ko bahut bada samajhna. Gussa. Logon ke saath sakhti. Aur chhathi, jo ajeeb hai: yeh pata na hona ki baaki paanch mein se kuch ho bhi raha hai. Inhe dheere padho aur imaandar pratikriya kisi aur ko yaad karna nahi hai. Har kisi ne chhahon ki hain.' AS p_hing,
   'So here is the thing to be clear about before reading any further. This chapter describes two directions a person can face — it is not two kinds of person, and it never says it is. Read as a way of sorting people it becomes a vocabulary for deciding that some people are a different sort of thing, and that vocabulary has done real damage when it has been pointed at communities. Nothing in these verses supports it, and the very next one has the speaker turning to the frightened man in front of him and telling him not to worry. If you finish this chapter holding a list of other people, you have read it backwards.' AS m_en,
   'तो आगे पढ़ने से पहले एक बात साफ़ कर लीजिए। यह अध्याय दो दिशाएँ बताता है जिनकी तरफ़ कोई व्यक्ति मुड़ सकता है — यह दो तरह के लोग नहीं हैं, और यह कहीं कहता भी नहीं कि हैं। लोगों को छाँटने के तरीक़े की तरह पढ़ें तो यह ऐसी शब्दावली बन जाता है जिससे तय हो कि कुछ लोग अलग किस्म की चीज़ हैं, और उस शब्दावली ने समुदायों की तरफ़ मोड़े जाने पर सचमुच नुक़सान किया है। इन श्लोकों में कुछ भी उसका साथ नहीं देता, और ठीक अगले में वक्ता सामने खड़े डरे हुए आदमी की तरफ़ मुड़कर उससे कहते हैं कि परेशान मत हो। अगर आप यह अध्याय ख़त्म करके दूसरों की सूची थामे हैं, तो आपने इसे उल्टा पढ़ा है।' AS m_hi,
   'To aage padhne se pehle ek baat saaf kar lo. Yeh chapter do dishayein batata hai jinki taraf koi insaan mud sakta hai — yeh do tarah ke log nahi hain, aur yeh kahin kehta bhi nahi ki hain. Logon ko chhaantne ke tareeke ki tarah padho to yeh aisi shabdavali ban jaata hai jisse tay ho ki kuch log alag kism ki cheez hain, aur us shabdavali ne samudayon ki taraf mode jaane par sach mein nuksaan kiya hai. In shlokon mein kuch bhi uska saath nahi deta, aur theek agle mein vakta saamne khade dare hue aadmi ki taraf mudkar usse kehte hain ki pareshan mat ho. Agar tum yeh chapter khatam karke doosron ki list thame ho, to tumne ise ulta padha hai.' AS m_hing

  UNION ALL SELECT 10, 'beginner',
   'A long description of the second direction is under way. This verse is where it stops being a list of faults and starts describing something with moving parts.',
   'दूसरी दिशा का लंबा वर्णन चल रहा है। यह वही श्लोक है जहाँ वह ख़ामियों की सूची होना बंद करके ऐसी चीज़ बताने लगता है जिसमें चलते-फिरते पुर्ज़े हैं।',
   'Doosri disha ka lamba varnan chal raha hai. Yeh wahi shloka hai jahan woh khamiyon ki list hona band karke aisi cheez batane lagta hai jisme chalte-firte purze hain.',
   'Three parts. A want that cannot be filled, underneath everything. On top of it, show and self-importance and a slight drunkenness, which give it respectable clothes. And then holding on to things that are not true — not saying them to other people, holding them.',
   'तीन हिस्से। सबके नीचे एक ऐसी चाह जो भर नहीं सकती। उसके ऊपर दिखावा, अपना बड़प्पन और हल्का नशा, जो उसे इज़्ज़तदार कपड़े पहना देते हैं। और फिर उन बातों को थामे रहना जो सच नहीं हैं — दूसरों से कहना नहीं, थामे रहना।',
   'Teen hisse. Sabke neeche ek aisi chaah jo bhar nahi sakti. Uske upar dikhava, apna badappan aur halka nasha, jo use izzatdar kapde pehna dete hain. Aur phir un baaton ko thame rehna jo sach nahi hain — doosron se kehna nahi, thame rehna.',
   'The last part is the useful one because it describes something people do without deciding to. Somebody holds a belief about a colleague, or about why something went wrong, that stopped matching the evidence years ago. It is still held not out of stupidity but because letting go of it would mean rewriting something else. That is findable in a real person on a real Tuesday, which a general condemnation never is.',
   'आख़िरी हिस्सा काम का है क्योंकि यह वह चीज़ बताता है जो लोग बिना तय किए करते हैं। किसी के मन में किसी सहकर्मी के बारे में, या किसी बात के बिगड़ने की वजह के बारे में, ऐसी धारणा है जो सालों पहले सबूतों से मेल खाना बंद कर चुकी। वह अब भी मूर्खता से नहीं टिकी है, बल्कि इसलिए कि उसे छोड़ने पर कुछ और दोबारा लिखना पड़ेगा। यह किसी असली आदमी में किसी असली मंगलवार को ढूँढ़ा जा सकता है, जो किसी आम निंदा से कभी नहीं होता।',
   'Aakhiri hissa kaam ka hai kyunki yeh woh cheez batata hai jo log bina tay kiye karte hain. Kisi ke man mein kisi colleague ke baare mein, ya kisi baat ke bigadne ki wajah ke baare mein, aisi dharna hai jo saalon pehle saboot se mel khana band kar chuki. Woh ab bhi moorkhta se nahi tiki hai, balki isliye ki use chhodne par kuch aur dobara likhna padega. Yeh kisi asli aadmi mein kisi asli Tuesday ko dhoondha ja sakta hai, jo kisi aam ninda se kabhi nahi hota.'

  UNION ALL SELECT 16, 'beginner',
   'Four verses of somebody''s own words have just been quoted. This is the summary of what running that sentence does to a person.',
   'अभी किसी के अपने शब्दों के चार श्लोक उद्धृत हुए हैं। यह उसका सार है कि वह वाक्य चलाने से आदमी का क्या होता है।',
   'Abhi kisi ke apne shabdon ke chaar shloka quote hue hain. Yeh uska saar hai ki woh vakya chalane se aadmi ka kya hota hai.',
   'Pulled apart by too many wants at once — not one want but a committee of them, all pulling in different directions. Wrapped in a net. Stuck to whatever feels good. And down it goes from there.',
   'एक साथ बहुत सारी चाहों से बिखरा हुआ — एक चाह नहीं, बल्कि चाहों की एक समिति, सब अलग-अलग तरफ़ खींचती हुई। एक जाल में लिपटा। जो अच्छा लगता है उससे चिपका। और वहाँ से नीचे ही नीचे।',
   'Ek saath bahut saari chaahon se bikhra hua — ek chaah nahi, balki chaahon ki ek committee, sab alag-alag taraf kheenchti hui. Ek jaal mein lipta. Jo achha lagta hai usse chipka. Aur wahan se neeche hi neeche.',
   'The net is the part worth keeping. A net is not invisible — it is invisible from inside, which is a different and much more specific claim. It explains why somebody caught in one can describe everybody else''s accurately and cannot find their own, and why being told about it rarely helps. You have to be standing outside a thing to see its shape.',
   'जाल वाला हिस्सा रखने लायक है। जाल अदृश्य नहीं होता — वह भीतर से अदृश्य होता है, जो अलग और कहीं ज़्यादा ख़ास दावा है। इससे पता चलता है कि उसमें फँसा आदमी बाक़ी सबका जाल ठीक-ठीक बता सकता है और अपना नहीं ढूँढ़ पाता, और इसीलिए बता देने से आमतौर पर मदद नहीं मिलती। किसी चीज़ का आकार देखने के लिए उसके बाहर खड़ा होना पड़ता है।',
   'Jaal wala hissa rakhne layak hai. Jaal adrishya nahi hota — woh bheetar se adrishya hota hai, jo alag aur kahin zyada khaas claim hai. Isse pata chalta hai ki usme phansa aadmi baaki sabka jaal theek-theek bata sakta hai aur apna nahi dhoondh paata, aur isiliye bata dene se aam taur par madad nahi milti. Kisi cheez ka aakar dekhne ke liye uske bahar khada hona padta hai.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 16;
