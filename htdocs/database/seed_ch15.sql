-- =====================================================================
-- VedaVerse — database/seed_ch15.sql
-- =====================================================================
-- Chapter 15, Puruṣottama Yoga. Eight verses. THE FIRST OF THE SIX
-- ADVANCED-ONLY CHAPTERS (7, 8, 9, 10, 11, 15).
--
-- WHY THIS CHAPTER AND WHY NOW
--   Until this file loads, the advanced track renders identically to
--   the intermediate one. app.tracks lists 7, 8, 9, 10, 11 and 15 for
--   advanced, PathService silently skips chapters with no seeded
--   verses, and so a reader who switches to advanced gains nothing but
--   chapter 1. That is the same family of bug as a published chapter
--   with no verses in it: nothing errors, no check fails, and the
--   product quietly does not do what it says. Chapter 15 is the
--   shortest of the six at twenty verses, so it goes first.
--
--   15.1   a tree with its roots in the air
--   15.3   you cannot see its shape from in here          [CARE]
--   15.5   what the ones who get out are carrying
--   15.7   a fragment of me, and it is doing the pulling  [CARE]
--   15.9   presiding over the senses, it engages
--   15.10  the deluded do not see it; some do
--   15.15  memory, knowledge — and their loss             [CARE]
--   15.20  the most secret thing, and what it makes of you
--
-- 15.7 IS THE CONSOLING VERSE AND THE MISUSABLE ONE
--   "An eternal fragment of me, having become a living being." It is
--   the warmest sentence in the book and it has been used as a licence:
--   I am already that, so what I do is beside the point. The refusal is
--   in the same verse. The second line says this fragment DRAWS the
--   senses and the mind, which are seated in prakṛti — so the fragment
--   is not sitting above the situation, it is in the body doing the
--   pulling, and it is having a hard time. Nothing here is finished.
--
-- 15.3's AXE IS NOT THE DETACHMENT MISUSE AGAIN
--   asaṅga-śastreṇa — with the weapon of not-sticking. Two things.
--   The tree is a tree; nothing in the verse points a weapon at a
--   person. And asaṅga is the same saṅga as in 5.10 and 14.7 — the
--   sticking, not the contact. The lotus leaf sits in the water all
--   day. This is not an instruction to stop feeling things, and 13.32's
--   gloss already settled that vocabulary.
--
-- 15.15 CONTAINS THE KINDEST WORD IN THE CHAPTER AND ALMOST NOBODY
-- QUOTES IT
--   "From me come memory, knowledge — and apohana." Their taking away.
--   The forgetting is named as coming from the same place as the
--   knowing. For a reader who has been treating their own blankness as
--   a personal failure, that is the text saying otherwise, in its own
--   voice, without being asked.
--
-- CONTENT RULES — unchanged. Original writing throughout. Sanskrit
--   unaltered, numbering untouched. No praise or criticism of any living
--   politician, party or movement. No communal framing. NOTHING IN THIS
--   FILE TREATS FORGETTING, BLANKNESS OR NOT-KNOWING AS A FAULT.
--
-- RUN AFTER seed_sample.sql. Re-runnable.
--
--     mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
--         < htdocs/database/seed_ch15.sql
--
-- global_order is 551 + verse_number: chapters 1 to 14 have 551 verses.
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

  SELECT 1 AS verse_number, 552 AS global_order, 1 AS is_curated, 'gita-15-1' AS slug,
    'ऊर्ध्वमूलमधःशाखमश्वत्थं प्राहुरव्ययम्।\nछन्दांसि यस्य पर्णानि यस्तं वेद स वेदवित्॥' AS sanskrit_devanagari,
    'ūrdhva-mūlam adhaḥ-śākham aśvatthaṁ prāhur avyayam\nchandāṁsi yasya parṇāni yas taṁ veda sa veda-vit' AS transliteration_iast,
    'urdhva-mulam adhah-shakham ashvattham prahur avyayam\nchandamsi yasya parnani yas tam veda sa veda-vit' AS transliteration_simple,
    'They speak of an imperishable ashvattha tree with its roots above and its branches below, whose leaves are the hymns. One who knows it knows the Vedas.' AS translation_literal,
    'They talk about a tree that does not wear out, with its roots in the air and its branches hanging down, and its leaves are the old songs. Whoever knows that tree knows what there is to know.' AS translation_en,
    'लोग एक ऐसे पेड़ की बात करते हैं जो घिसता नहीं, जिसकी जड़ें ऊपर हवा में हैं और शाखाएँ नीचे लटकी हैं, और जिसके पत्ते पुराने गीत हैं। जो उस पेड़ को जान ले वह जानने लायक़ सब जान गया।' AS translation_hi,
    'Log ek aise ped ki baat karte hain jo ghista nahi, jiski jadein upar hawa mein hain aur shakhayein neeche latki hain, aur jiske patte purane geet hain. Jo us ped ko jaan le woh jaanne layak sab jaan gaya.' AS translation_hinglish,
    'The roots are somewhere you cannot get to and the branches are all around you. That is the whole picture.' AS summary_en,
    'जड़ें वहाँ हैं जहाँ आप पहुँच नहीं सकते और शाखाएँ आपके चारों तरफ़ हैं। पूरी तस्वीर यही है।' AS summary_hi,
    'Jadein wahan hain jahan tum pahunch nahi sakte aur shakhayein tumhare chaaron taraf hain. Poori tasveer yahi hai.' AS summary_hinglish,
    'advanced' AS difficulty,
    'Gita 15.1: a tree with its roots in the air' AS seo_title,
    'The Bhagavad Gita opens chapter 15 with an inverted tree — roots above, branches below. The roots are where you cannot reach and the branches are everywhere you are.' AS seo_description,
    1 AS published

  UNION ALL SELECT 3, 554, 1, 'gita-15-3',
    'न रूपमस्येह तथोपलभ्यते नान्तो न चादिर्न च सम्प्रतिष्ठा।\nअश्वत्थमेनं सुविरूढमूलमसङ्गशस्त्रेण दृढेन छित्त्वा॥',
    'na rūpam asyeha tathopalabhyate nānto na cādir na ca sampratiṣṭhā\naśvattham enaṁ su-virūḍha-mūlam asaṅga-śastreṇa dṛḍhena chittvā',
    'na rupam asyeha tathopalabhyate nanto na chadir na cha sampratishtha\nashvattham enam su-virudha-mulam asanga-shastrena dridhena chittva',
    'Its form is not perceived here as such — no end, no beginning, no foundation. Having cut this deep-rooted ashvattha with the firm weapon of non-attachment...',
    'From in here you cannot make out its shape. No end to it, no beginning, nothing it is standing on. Cut this deep-rooted thing with the axe of not-sticking, and cut firmly.',
    'यहाँ भीतर से आप इसका आकार नहीं पहचान सकते। न इसका अंत, न आरंभ, न कोई ज़मीन जिस पर यह खड़ा हो। इस गहरी जड़ वाली चीज़ को न-चिपकने की कुल्हाड़ी से काटिए, और मज़बूती से काटिए।',
    'Yahan bheetar se tum iska aakar nahi pehchan sakte. Na iska ant, na aarambh, na koi zameen jis par yeh khada ho. Is gehri jad wali cheez ko na-chipakne ki kulhaadi se kaato, aur mazbooti se kaato.',
    'The text admits its own picture cannot be seen from where the reader is standing. That admission is rarer than the metaphor.',
    'ग्रंथ ख़ुद मानता है कि उसकी अपनी तस्वीर वहाँ से नहीं दिखती जहाँ पाठक खड़ा है। यह मान लेना उस रूपक से ज़्यादा दुर्लभ है।',
    'Granth khud maanta hai ki uski apni tasveer wahan se nahi dikhti jahan paathak khada hai. Yeh maan lena us roopak se zyada durlabh hai.',
    'advanced',
    'Gita 15.3: from in here you cannot make out its shape',
    'The Bhagavad Gita says the form of its own image is not perceptible from where you are, then hands you an axe. The axe is asanga — not-sticking, not not-feeling.',
    1

  UNION ALL SELECT 5, 556, 1, 'gita-15-5',
    'निर्मानमोहा जितसङ्गदोषा अध्यात्मनित्या विनिवृत्तकामाः।\nद्वन्द्वैर्विमुक्ताः सुखदुःखसंज्ञैर्गच्छन्त्यमूढाः पदमव्ययं तत्॥',
    'nirmāna-mohā jita-saṅga-doṣā adhyātma-nityā vinivṛtta-kāmāḥ\ndvandvair vimuktāḥ sukha-duḥkha-saṁjñair gacchanty amūḍhāḥ padam avyayaṁ tat',
    'nirmana-moha jita-sanga-dosha adhyatma-nitya vinivritta-kamah\ndvandvair vimuktah sukha-duhkha-samjnair gacchanty amudhah padam avyayam tat',
    'Free from pride and delusion, having conquered the fault of attachment, always in the self, with desires turned back, released from the dualities known as pleasure and pain — the undeluded reach that imperishable place.',
    'Without airs and without fog. Having got the better of the sticking. Steadily at home in themselves. The wanting turned back. Let go of the pairs that go by the names pleasure and pain. Those are the ones who get there.',
    'बिना दिखावे और बिना धुंध के। चिपकने पर काबू पा चुके। अपने भीतर टिककर बसे हुए। चाह लौटा दी गई। सुख और दुख नाम की जोड़ियों से छूटे हुए। पहुँचने वाले वही हैं।',
    'Bina dikhave aur bina dhundh ke. Chipakne par kaabu pa chuke. Apne bheetar tikkar base hue. Chaah lauta di gayi. Sukh aur dukh naam ki jodiyon se chhoote hue. Pahunchne wale wahi hain.',
    'A list of five, and the first item is not having airs. That is the order the chapter chose.',
    'पाँच की सूची, और पहली चीज़ है दिखावा न होना। अध्याय ने यही क्रम चुना।',
    'Paanch ki soochi, aur pehli cheez hai dikhava na hona. Adhyay ne yahi kram chuna.',
    'advanced',
    'Gita 15.5: the list starts with not having airs',
    'The Bhagavad Gita lists what the ones who get out are carrying, and puts nirmana — without pride — first, ahead of everything harder.',
    1

  UNION ALL SELECT 7, 558, 1, 'gita-15-7',
    'ममैवांशो जीवलोके जीवभूतः सनातनः।\nमनःषष्ठानीन्द्रियाणि प्रकृतिस्थानि कर्षति॥',
    'mamaivāṁśo jīva-loke jīva-bhūtaḥ sanātanaḥ\nmanaḥ-ṣaṣṭhānīndriyāṇi prakṛti-sthāni karṣati',
    'mamaivamsho jiva-loke jiva-bhutah sanatanah\nmanah-shashthanindriyani prakriti-sthani karshati',
    'An eternal fragment of my own self, having become a living being in the world of the living, draws the senses, with mind as the sixth, which are seated in prakriti.',
    'A piece of me, always there, having become something alive among the living. And it is the one pulling at the senses, and at the mind that makes six of them, all of which are set in the material.',
    'मेरा ही एक टुकड़ा, हमेशा से, जीवितों के बीच कुछ जीवित बन जाता है। और वही इंद्रियों को खींचता है, और उस मन को भी जो उन्हें छह बना देता है, और ये सब उस सामग्री में जड़े हैं।',
    'Mera hi ek tukda, hamesha se, jeeviton ke beech kuch jeevit ban jaata hai. Aur wahi indriyon ko kheenchta hai, aur us man ko bhi jo unhe chhah bana deta hai, aur yeh sab us samagri mein jade hain.',
    'The warmest line in the book, and the same verse puts it in a body, pulling, having a hard time.',
    'किताब की सबसे गर्म पंक्ति, और वही श्लोक उसे शरीर में रख देता है, खींचता हुआ, मुश्किल में।',
    'Kitaab ki sabse garam pankti, aur wahi shloka use sharir mein rakh deta hai, kheenchta hua, mushkil mein.',
    'advanced',
    'Gita 15.7: a fragment of me, and it is the one doing the pulling',
    'The Bhagavad Gita calls the living being an eternal fragment of itself and, in the next line, has that fragment struggling with the senses. Nothing here is finished.',
    1

  UNION ALL SELECT 9, 560, 1, 'gita-15-9',
    'श्रोत्रं चक्षुः स्पर्शनं च रसनं घ्राणमेव च।\nअधिष्ठाय मनश्चायं विषयानुपसेवते॥',
    'śrotraṁ cakṣuḥ sparśanaṁ ca rasanaṁ ghrāṇam eva ca\nadhiṣṭhāya manaś cāyaṁ viṣayān upasevate',
    'shrotram chakshuh sparshanam cha rasanam ghranam eva cha\nadhishthaya manash chayam vishayan upasevate',
    'Presiding over hearing, sight, touch, taste and smell, and over the mind, this one engages with the objects of the senses.',
    'Taking up its seat at hearing, at sight, at touch, at taste, at smell — and at the mind — this thing goes about among the things there are.',
    'सुनने पर, देखने पर, छूने पर, चखने पर, सूँघने पर — और मन पर — अपनी जगह लेकर, यह चीज़ जो कुछ है उसके बीच चलती-फिरती है।',
    'Sunne par, dekhne par, chhoone par, chakhne par, soonghne par — aur man par — apni jagah lekar, yeh cheez jo kuch hai uske beech chalti-firti hai.',
    'Six seats, all of them ordinary. There is no seventh one further back.',
    'छह जगहें, और सब आम। कोई सातवीं और पीछे नहीं है।',
    'Chhah jagahein, aur sab aam. Koi saatvi aur peechhe nahi hai.',
    'advanced',
    'Gita 15.9: six seats, and no seventh one further back',
    'The Bhagavad Gita seats this at hearing, sight, touch, taste, smell and mind. All six are ordinary and the list does not continue.',
    1

  UNION ALL SELECT 10, 561, 1, 'gita-15-10',
    'उत्क्रामन्तं स्थितं वापि भुञ्जानं वा गुणान्वितम्।\nविमूढा नानुपश्यन्ति पश्यन्ति ज्ञानचक्षुषः॥',
    'utkrāmantaṁ sthitaṁ vāpi bhuñjānaṁ vā guṇānvitam\nvimūḍhā nānupaśyanti paśyanti jñāna-cakṣuṣaḥ',
    'utkramantam sthitam vapi bhunjanam va gunanvitam\nvimudha nanupashyanti pashyanti jnana-chakshushah',
    'Whether it is departing, or staying, or experiencing, accompanied by the gunas — the deluded do not see it. Those with the eye of knowledge see.',
    'Leaving, staying, or in the middle of something and coloured by the settings — the ones in the fog do not see it at all. The ones with the eye for it do.',
    'जाते हुए, ठहरे हुए, या किसी चीज़ के बीच में और अवस्थाओं का रंग चढ़ाए हुए — धुंध वाले उसे देख ही नहीं पाते। जिनकी आँख उसके लिए है, वे देख लेते हैं।',
    'Jaate hue, thehre hue, ya kisi cheez ke beech mein aur avasthaon ka rang chadhaye hue — dhundh wale use dekh hi nahi paate. Jinki aankh uske liye hai, woh dekh lete hain.',
    'Jñāna-cakṣus — an eye for it. Not a belief about it and not a fact learned.',
    'ज्ञानचक्षु — उसके लिए एक आँख। उसके बारे में कोई मान्यता नहीं और कोई सीखा हुआ तथ्य नहीं।',
    'Gyan-chakshu — uske liye ek aankh. Uske baare mein koi manyata nahi aur koi seekha hua tathya nahi.',
    'advanced',
    'Gita 15.10: an eye for it, not a belief about it',
    'The Bhagavad Gita says some see it and some do not, and the faculty it names is jnana-chakshus — an eye. Not a doctrine and not a fact somebody has learned.',
    1

  UNION ALL SELECT 15, 566, 1, 'gita-15-15',
    'सर्वस्य चाहं हृदि सन्निविष्टो मत्तः स्मृतिर्ज्ञानमपोहनं च।\nवेदैश्च सर्वैरहमेव वेद्यो वेदान्तकृद्वेदविदेव चाहम्॥',
    'sarvasya cāhaṁ hṛdi sanniviṣṭo mattaḥ smṛtir jñānam apohanaṁ ca\nvedaiś ca sarvair aham eva vedyo vedānta-kṛd veda-vid eva cāham',
    'sarvasya chaham hridi sannivishto mattah smritir jnanam apohanam cha\nvedaish cha sarvair aham eva vedyo vedanta-krid veda-vid eva chaham',
    'I am seated in the heart of everyone. From me come memory, knowledge, and their taking away. I alone am what is to be known by all the Vedas. I am the maker of Vedanta and the knower of the Veda.',
    'I am settled in the heart of every one of them. Remembering comes from me, and understanding, and the losing of both. And I am what all the old books are trying to get at.',
    'मैं हर एक के हृदय में बैठा हूँ। याद आना मुझसे आता है, और समझ, और दोनों का चला जाना भी। और सारी पुरानी किताबें जिस तक पहुँचना चाहती हैं वह मैं हूँ।',
    'Main har ek ke hriday mein baitha hoon. Yaad aana mujhse aata hai, aur samajh, aur dono ka chala jaana bhi. Aur saari purani kitaabein jis tak pahunchna chahti hain woh main hoon.',
    'And their taking away. Apohana is on the list, and it is the kindest word in the chapter.',
    'और उनका चला जाना। अपोहन सूची में है, और वह इस अध्याय का सबसे दयालु शब्द है।',
    'Aur unka chala jaana. Apohan soochi mein hai, aur woh is adhyay ka sabse dayalu shabd hai.',
    'advanced',
    'Gita 15.15: memory, knowledge, and their taking away',
    'The Bhagavad Gita names apohana — the loss of memory and knowledge — as coming from the same place they do. The forgetting is on the list.',
    1

  UNION ALL SELECT 20, 571, 1, 'gita-15-20',
    'इति गुह्यतमं शास्त्रमिदमुक्तं मयानघ।\nएतद्बुद्ध्वा बुद्धिमान्स्यात्कृतकृत्यश्च भारत॥',
    'iti guhyatamaṁ śāstram idam uktaṁ mayānagha\netad buddhvā buddhimān syāt kṛta-kṛtyaś ca bhārata',
    'iti guhyatamam shastram idam uktam mayanagha\netad buddhva buddhiman syat krita-krityash cha bharata',
    'Thus this most secret teaching has been spoken by me, O sinless one. Having understood this, a person becomes one who has understanding, and one whose work is done.',
    'So that is the most closely held thing there is, and I have said it. Whoever takes it in becomes somebody who understands, and somebody whose work is finished.',
    'तो यही सबसे छिपाकर रखी गई चीज़ है, और मैंने कह दी। जो इसे भीतर ले ले वह समझने वाला हो जाता है, और वह भी जिसका काम पूरा हो गया।',
    'To yahi sabse chhipakar rakhi gayi cheez hai, aur maine keh di. Jo ise bheetar le le woh samajhne wala ho jaata hai, aur woh bhi jiska kaam poora ho gaya.',
    'The most secret thing, and it has just been said out loud to somebody who asked.',
    'सबसे छिपी हुई चीज़, और वह अभी उस इंसान से ज़ोर से कह दी गई जिसने पूछा था।',
    'Sabse chhipi hui cheez, aur woh abhi us insan se zor se keh di gayi jisne poochha tha.',
    'advanced',
    'Gita 15.20: the most closely held thing, said out loud',
    'The Bhagavad Gita calls chapter 15 the most secret teaching and has just finished saying all of it to somebody who asked. Secrecy that gets spoken is a different kind of secrecy.',
    1

) AS v
JOIN chapters c ON c.chapter_number = 15;

-- =====================================================================
-- 2. EXPLANATIONS
-- =====================================================================
-- All at beginner depth. This is an advanced-track chapter, but the
-- depth field describes the prose and not the reader's stamina, and
-- nothing in chapter 15 is improved by being written harder than it
-- needs to be.
--
-- The load-bearing sentences, all asserted by smoke-test.sh on the
-- DEFAULT render:
--   15.3   the axe in this verse is pointed at a tree
--   15.3   asanga is not-sticking, not not-feeling
--   15.7   the fragment is not sitting above the situation
--   15.15  the forgetting is on the list
-- =====================================================================

DELETE ve FROM verse_explanations ve JOIN verses v ON v.id = ve.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 15;

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 1 AS vn, 'beginner' AS level,
   'The chapter opens with a picture instead of an argument. An ashvattha — a peepal, the tree people actually sat under — drawn the wrong way up: roots in the air, branches coming down, and the leaves are the old hymns.' AS h_en,
   'अध्याय तर्क के बजाय एक तस्वीर से शुरू होता है। अश्वत्थ — पीपल, वही पेड़ जिसके नीचे लोग सचमुच बैठते थे — उल्टा बनाया गया है: जड़ें हवा में, टहनियाँ नीचे आती हुईं, और पत्ते पुराने गीत हैं।' AS h_hi,
   'Adhyay tark ke bajaye ek tasveer se shuru hota hai. Ashvattha — peepal, wahi ped jiske neeche log sachmuch baithte the — ulta banaya gaya hai: jadein hawa mein, tehniyan neeche aati huin, aur patte purane geet hain.' AS h_hing,
   'An upside-down tree is a tree whose beginning is not where you are standing. Everything a person can see of their own life — the branches, the leaves, the fruit — is the part that hangs down. Whatever it grows out of is in the other direction, and staring harder at the ground will not find it.' AS p_en,
   'उल्टा पेड़ वह पेड़ है जिसकी शुरुआत वहाँ नहीं है जहाँ आप खड़े हैं। अपनी ज़िंदगी का जो कुछ आदमी देख सकता है — टहनियाँ, पत्ते, फल — वह लटकता हुआ हिस्सा है। जिससे वह उगता है वह दूसरी दिशा में है, और ज़मीन को और ग़ौर से घूरने पर नहीं मिलेगा।' AS p_hi,
   'Ulta ped woh ped hai jiski shuruaat wahan nahi hai jahan aap khade hain. Apni zindagi ka jo kuch aadmi dekh sakta hai — tehniyan, patte, phal — woh latakta hua hissa hai. Jisse woh ugta hai woh doosri disha mein hai, aur zameen ko aur gaur se ghoorne par nahi milega.' AS p_hing,
   'This is a description of a situation, not a claim anybody is being asked to believe. Nothing in the verse requires a reader to accept a cosmology. What it requires is noticing that the thing they are standing inside was not designed by them and did not start with them. Anyone who has tried to explain why their own life has the shape it has — this job, this city, this particular way of getting anxious at four in the afternoon — has already run into the upside-down tree. The answers keep going up past where a person can see. Chapter 15 is not going to resolve that. It is going to say what to do while standing in it.' AS m_en,
   'यह एक हालत का वर्णन है, कोई दावा नहीं जिसे मानने को कहा जा रहा हो। श्लोक पाठक से किसी सृष्टि-सिद्धांत को मानने की माँग नहीं करता। वह इतना माँगता है कि आदमी यह देख ले कि जिसके भीतर वह खड़ा है वह उसका बनाया हुआ नहीं है और उससे शुरू नहीं हुआ। जिसने कभी समझाने की कोशिश की हो कि उसकी अपनी ज़िंदगी की शक्ल ऐसी क्यों है — यही नौकरी, यही शहर, दोपहर चार बजे घबराने का यही ख़ास तरीक़ा — वह उल्टे पेड़ से पहले ही टकरा चुका है। जवाब ऊपर की ओर वहाँ तक जाते रहते हैं जहाँ तक आदमी देख नहीं सकता। पंद्रहवाँ अध्याय इसे सुलझाने वाला नहीं है। वह यह बताने वाला है कि इसके भीतर खड़े-खड़े करना क्या है।' AS m_hi,
   'Yeh ek haalat ka varnan hai, koi dawa nahi jise maanne ko kaha ja raha ho. Shloka pathak se kisi srishti-siddhant ko maanne ki maang nahi karta. Woh itna maangta hai ki aadmi yeh dekh le ki jiske bheetar woh khada hai woh uska banaya hua nahi hai aur usse shuru nahi hua. Jisne kabhi samjhane ki koshish ki ho ki uski apni zindagi ki shakl aisi kyun hai — yahi naukri, yahi shehar, dopahar chaar baje ghabrane ka yahi khaas tareeka — woh ulte ped se pehle hi takra chuka hai. Jawab upar ki or wahan tak jaate rehte hain jahan tak aadmi dekh nahi sakta. Pandrahvan adhyay ise suljhane wala nahi hai. Woh yeh batane wala hai ki iske bheetar khade-khade karna kya hai.' AS m_hing

  UNION ALL SELECT 3, 'beginner',
   'Two verses on, the picture is qualified in a line that is easy to skip past: its shape is not perceived here, not its end, not its beginning, not what it stands on.',
   'दो श्लोक बाद तस्वीर पर एक शर्त लग जाती है जिसे नज़रअंदाज़ करना आसान है: उसका रूप यहाँ दिखाई नहीं देता, न उसका अंत, न शुरुआत, न वह जिस पर वह टिका है।',
   'Do shloka baad tasveer par ek shart lag jaati hai jise nazarandaz karna aasaan hai: uska roop yahan dikhai nahi deta, na uska ant, na shuruaat, na woh jis par woh tika hai.',
   'And then the instruction, which is where care is needed. Cut this tree with the axe of asanga. Asanga is not-sticking — the same word that ran through 5.10 and 14.7, where the lotus leaf sits in the water all day and does not come out wet. The leaf is not avoiding the water. It is in it.',
   'और फिर निर्देश, जहाँ सावधानी चाहिए। इस पेड़ को असंग की कुल्हाड़ी से काटो। असंग यानी न चिपकना — वही शब्द जो 5.10 और 14.7 में चलता है, जहाँ कमल का पत्ता दिन भर पानी में रहता है और भीगकर नहीं निकलता। पत्ता पानी से बच नहीं रहा। वह उसी में है।',
   'Aur phir nirdesh, jahan savdhani chahiye. Is ped ko asang ki kulhadi se kaato. Asang yani na chipakna — wahi shabd jo 5.10 aur 14.7 mein chalta hai, jahan kamal ka patta din bhar paani mein rehta hai aur bheegkar nahi nikalta. Patta paani se bach nahi raha. Woh usi mein hai.',
   'Two things, and both are in the line rather than in this note. First, the axe in this verse is pointed at a tree. There is no person anywhere in the image, and nothing here licenses anybody to take a blade to what they feel for the people in their life. Second, asanga is not-sticking, not not-feeling — 13.32 already had to draw that line and this verse needs it drawn again. What is actually under the axe is the assumption that the arrangement a person is standing inside is permanent and could not have been otherwise. That is difficult enough to be going on with, and it has nothing to do with caring about anyone less.',
   'दो बातें, और दोनों इसी पंक्ति में हैं, इस टिप्पणी में नहीं। पहली, इस श्लोक की कुल्हाड़ी एक पेड़ की ओर है। तस्वीर में कहीं कोई आदमी नहीं है, और यहाँ किसी को यह इजाज़त नहीं मिलती कि वह अपनी ज़िंदगी के लोगों के लिए जो महसूस करता है उस पर धार चलाए। दूसरी, असंग का मतलब न चिपकना है, न महसूस करना नहीं — 13.32 को यह रेखा पहले ही खींचनी पड़ी थी और इस श्लोक को दोबारा खींचनी पड़ रही है। कुल्हाड़ी के नीचे असल में यह मान्यता है कि जिस बंदोबस्त के भीतर आदमी खड़ा है वह स्थायी है और और कुछ हो ही नहीं सकता था। इतना ही काफ़ी मुश्किल है, और इसका किसी की परवाह कम करने से कोई लेना-देना नहीं।',
   'Do baatein, aur dono isi pankti mein hain, is tippani mein nahi. Pehli, is shloka ki kulhadi ek ped ki or hai. Tasveer mein kahin koi aadmi nahi hai, aur yahan kisi ko yeh ijazat nahi milti ki woh apni zindagi ke logon ke liye jo mehsoos karta hai us par dhaar chalaye. Doosri, asang ka matlab na chipakna hai, na mehsoos karna nahi — 13.32 ko yeh rekha pehle hi kheenchni padi thi aur is shloka ko dobara kheenchni pad rahi hai. Kulhadi ke neeche asal mein yeh manyata hai ki jis bandobast ke bheetar aadmi khada hai woh sthayi hai aur aur kuch ho hi nahi sakta tha. Itna hi kaafi mushkil hai, aur iska kisi ki parwah kam karne se koi lena-dena nahi.'

  UNION ALL SELECT 5, 'beginner',
   'A short list of what the ones who find their way out are carrying. It is worth reading twice, because of what kind of list it is.',
   'एक छोटी सूची कि जो लोग रास्ता निकाल लेते हैं वे क्या लिए चल रहे हैं। दो बार पढ़ने लायक़ है, इसलिए कि यह किस तरह की सूची है।',
   'Ek chhoti soochi ki jo log raasta nikaal lete hain we kya liye chal rahe hain. Do baar padhne layak hai, isliye ki yeh kis tarah ki soochi hai.',
   'Without the pride of standing. With the sticking-fault beaten. Settled in what is nearest to them. Wants turned back. Loose from the pairs — the hot and the cold of it, the praise and the blame. And not confused, they go.',
   'रुतबे के घमंड के बिना। चिपकने के दोष को जीते हुए। जो उनके सबसे क़रीब है उसमें टिके हुए। चाहतें लौटा दी गईं। जोड़ों से ढीले — गरमी और सरदी, तारीफ़ और इलज़ाम। और बिना उलझे, वे चले जाते हैं।',
   'Rutbe ke ghamand ke bina. Chipakne ke dosh ko jeete hue. Jo unke sabse kareeb hai usme tike hue. Chahatein lauta di gayin. Jodon se dheele — garmi aur sardi, tareef aur ilzaam. Aur bina uljhe, we chale jaate hain.',
   'Look at the grammar of the list. There is nothing on it to obtain. Nirmana-moha, vinivritta-kama, dvandvair vimukta — every single term is a subtraction. That is a relief for anybody who has read a passage like this and immediately started drawing up a plan to acquire five new qualities before the end of the year. What the verse describes is a person carrying less than they used to. And the last item is not somebody who has stopped feeling heat and cold. It is somebody whose afternoon is no longer being run by which of the two it currently is.',
   'सूची की बनावट देखिए। इसमें पाने लायक़ कुछ नहीं है। निर्मान-मोह, विनिवृत्त-काम, द्वंद्वैर् विमुक्त — हर एक शब्द घटाव है। यह उस किसी के लिए राहत है जिसने ऐसा हिस्सा पढ़ते ही साल ख़त्म होने से पहले पाँच नए गुण हासिल करने की योजना बनानी शुरू कर दी हो। श्लोक जिसका वर्णन करता है वह ऐसा आदमी है जो पहले से कम उठाए चल रहा है। और आख़िरी चीज़ वह आदमी नहीं है जिसे गरमी-सरदी लगनी बंद हो गई। वह आदमी है जिसकी दोपहर अब इस बात से नहीं चल रही कि अभी दोनों में से कौन-सी है।',
   'Soochi ki banawat dekhiye. Isme paane layak kuch nahi hai. Nirman-moh, vinivritta-kaam, dvandvair vimukta — har ek shabd ghatav hai. Yeh us kisi ke liye raahat hai jisne aisa hissa padhte hi saal khatm hone se pehle paanch naye gun haasil karne ki yojana banani shuru kar di ho. Shloka jiska varnan karta hai woh aisa aadmi hai jo pehle se kam uthaye chal raha hai. Aur aakhiri cheez woh aadmi nahi hai jise garmi-sardi lagni band ho gayi. Woh aadmi hai jiski dopahar ab is baat se nahi chal rahi ki abhi dono mein se kaun-si hai.'

  UNION ALL SELECT 7, 'beginner',
   'The warmest sentence in the book. And the second line of the same verse is the one that keeps it honest.',
   'किताब का सबसे गरम वाक्य। और उसी श्लोक की दूसरी पंक्ति वह है जो उसे ईमानदार रखती है।',
   'Kitaab ka sabse garam vakya. Aur usi shloka ki doosri pankti woh hai jo use imaandar rakhti hai.',
   'An eternal fragment of me, having become a living being among the living. And then, immediately: it draws the senses, with the mind as the sixth, which are seated in prakriti. The fragment is the one doing the pulling.',
   'मेरा ही एक सनातन अंश, जीवों के बीच जीव बना हुआ। और फिर, तुरंत: वह इंद्रियों को खींचता है, मन जिनमें छठा है, और जो प्रकृति में टिकी हुई हैं। खींचने का काम वही अंश कर रहा है।',
   'Mera hi ek sanatan ansh, jeevon ke beech jeev bana hua. Aur phir, turant: woh indriyon ko kheenchta hai, man jinme chhatha hai, aur jo prakriti mein tiki hui hain. Kheenchne ka kaam wahi ansh kar raha hai.',
   'This verse gets handed around as a permission slip — I am already a piece of the divine, so what I actually do is beside the point. The refusal is in the same verse and nowhere else. Read the second line: the fragment is not sitting above the situation, it is down in the body doing the pulling, and karshati is a strenuous word, the word for hauling something heavy across ground. Nothing here is finished. What the verse offers is not an exemption from the work; it is a description of who is doing it, and it is a considerably kinder description than most people give themselves at eleven at night.',
   'यह श्लोक एक छूट के परचे की तरह घुमाया जाता है — मैं तो पहले से ही ईश्वर का टुकड़ा हूँ, तो मैं असल में करता क्या हूँ यह बात बेकार है। इनकार उसी श्लोक में है और कहीं नहीं। दूसरी पंक्ति पढ़िए: वह अंश हालात के ऊपर बैठा नहीं है, वह नीचे शरीर में खींचने का काम कर रहा है, और कर्षति मेहनत का शब्द है, किसी भारी चीज़ को ज़मीन पर घसीटने का शब्द। यहाँ कुछ भी पूरा नहीं हुआ है। श्लोक काम से छुट्टी नहीं देता; वह बताता है कि काम कर कौन रहा है, और यह वर्णन उससे कहीं ज़्यादा नरम है जो ज़्यादातर लोग रात ग्यारह बजे अपने बारे में करते हैं।',
   'Yeh shloka ek chhoot ke parche ki tarah ghumaya jaata hai — main to pehle se hi ishwar ka tukda hoon, to main asal mein karta kya hoon yeh baat bekaar hai. Inkaar usi shloka mein hai aur kahin nahi. Doosri pankti padhiye: woh ansh haalat ke upar baitha nahi hai, woh neeche sharir mein kheenchne ka kaam kar raha hai, aur karshati mehnat ka shabd hai, kisi bhaari cheez ko zameen par ghaseetne ka shabd. Yahan kuch bhi poora nahi hua hai. Shloka kaam se chhutti nahi deta; woh batata hai ki kaam kar kaun raha hai, aur yeh varnan usse kahin zyada naram hai jo zyadatar log raat gyarah baje apne baare mein karte hain.'

  UNION ALL SELECT 9, 'beginner',
   'The same fragment, doing ordinary things. Hearing, seeing, touching, tasting, smelling, and the mind.',
   'वही अंश, आम काम करता हुआ। सुनना, देखना, छूना, चखना, सूँघना, और मन।',
   'Wahi ansh, aam kaam karta hua. Sunna, dekhna, chhoona, chakhna, soonghna, aur man.',
   'Presiding over these, it attends to what there is to be sensed. Upasevate — it goes towards them, it uses them, it takes them in. There is no complaint anywhere in the line.',
   'इनके सिरहाने बैठकर, वह उन चीज़ों तक जाता है जिन्हें महसूस किया जाना है। उपसेवते — वह उनकी ओर जाता है, उन्हें बरतता है, उन्हें भीतर लेता है। पूरी पंक्ति में कहीं कोई शिकायत नहीं है।',
   'Inke sirhane baithkar, woh un cheezon tak jaata hai jinhe mehsoos kiya jaana hai. Upasevate — woh unki or jaata hai, unhe baratta hai, unhe bheetar leta hai. Poori pankti mein kahin koi shikayat nahi hai.',
   'A verse two lines after the one about hauling could easily have turned the senses into an enemy, and it does not. Adhishthaya is a presiding word — the sense is of somebody seated at the head of a table, not somebody at war with the guests. That is worth holding on to in a book with a reputation for asking people to shut things down. Nothing in chapter 15 asks anybody to stop hearing or stop tasting. It describes a life being lived through five doors and a mind, and it picks a neutral verb to describe it with.',
   'खींचने वाले श्लोक के दो पंक्ति बाद का श्लोक इंद्रियों को आसानी से दुश्मन बना सकता था, और नहीं बनाता। अधिष्ठाय सिरहाने बैठने का शब्द है — भाव यह है कि कोई मेज़ के सिरे पर बैठा है, यह नहीं कि कोई मेहमानों से लड़ रहा है। ऐसी किताब में यह याद रखने लायक़ है जिसकी शोहरत यह है कि वह लोगों से चीज़ें बंद करवाती है। पंद्रहवाँ अध्याय किसी से सुनना या चखना बंद करने को नहीं कहता। वह पाँच दरवाज़ों और एक मन से जी जाती एक ज़िंदगी का वर्णन करता है, और उसके लिए एक तटस्थ क्रिया चुनता है।',
   'Kheenchne wale shloka ke do pankti baad ka shloka indriyon ko aasani se dushman bana sakta tha, aur nahi banata. Adhishthaya sirhane baithne ka shabd hai — bhaav yeh hai ki koi mez ke sire par baitha hai, yeh nahi ki koi mehmanon se lad raha hai. Aisi kitaab mein yeh yaad rakhne layak hai jiski shohrat yeh hai ki woh logon se cheezein band karwati hai. Pandrahvan adhyay kisi se sunna ya chakhna band karne ko nahi kehta. Woh paanch darwazon aur ek man se ji jaati ek zindagi ka varnan karta hai, aur uske liye ek tatasth kriya chunta hai.'

  UNION ALL SELECT 10, 'beginner',
   'Going out, staying, or taking things in — the confused do not see it. The ones with an eye for it do.',
   'निकलते हुए, ठहरे हुए, या भोगते हुए — उलझे हुए लोग उसे नहीं देखते। जिनके पास उसके लिए आँख है वे देखते हैं।',
   'Nikalte hue, thehre hue, ya bhogte hue — uljhe hue log use nahi dekhte. Jinke paas uske liye aankh hai we dekhte hain.',
   'Vimudha is a condition, not an insult. Everyone in this book is in it at some point, including the person the entire conversation is being held with, who spent all of chapter 1 unable to see what was in front of him.',
   'विमूढ़ एक हालत है, गाली नहीं। इस किताब में हर कोई किसी न किसी मौक़े पर उसमें है, वह आदमी भी जिससे यह पूरी बातचीत हो रही है, जिसने पूरा पहला अध्याय अपने सामने की चीज़ को न देख पाने में बिताया।',
   'Vimoodh ek haalat hai, gaali nahi. Is kitaab mein har koi kisi na kisi mauke par usme hai, woh aadmi bhi jisse yeh poori baatcheet ho rahi hai, jisne poora pehla adhyay apne saamne ki cheez ko na dekh paane mein bitaya.',
   'And the faculty named is jnana-chakshus — an eye for it. Not a belief about it and not a fact somebody has learned. That distinction carries more weight than it looks like it does, because it means nothing in this verse can be settled by agreeing with it. A person can hold every proposition in chapter 15 and be exactly where they started, and the verse says so without any scorn in it at all. The line here is not between the informed and the ignorant. It is between somebody who has looked and somebody who has read about looking.',
   'और जिस क्षमता का नाम लिया गया है वह ज्ञान-चक्षु है — उसके लिए एक आँख। उसके बारे में कोई मान्यता नहीं और कोई सीखा हुआ तथ्य नहीं। यह फ़र्क़ जितना दिखता है उससे ज़्यादा वज़नी है, क्योंकि इसका मतलब है कि इस श्लोक में कुछ भी सहमत हो जाने से तय नहीं होता। आदमी पंद्रहवें अध्याय की हर बात मान सकता है और ठीक वहीं खड़ा रह सकता है जहाँ से चला था, और श्लोक यह बात बिना किसी तंज़ के कहता है। यहाँ रेखा जानकार और अनजान के बीच नहीं है। वह उस आदमी के बीच है जिसने देखा है और उस आदमी के बीच जिसने देखने के बारे में पढ़ा है।',
   'Aur jis kshamata ka naam liya gaya hai woh gyan-chakshu hai — uske liye ek aankh. Uske baare mein koi manyata nahi aur koi seekha hua tathya nahi. Yeh farq jitna dikhta hai usse zyada wazni hai, kyunki iska matlab hai ki is shloka mein kuch bhi sehmat ho jaane se tay nahi hota. Aadmi pandrahven adhyay ki har baat maan sakta hai aur theek wahin khada reh sakta hai jahan se chala tha, aur shloka yeh baat bina kisi tanz ke kehta hai. Yahan rekha jaankar aur anjaan ke beech nahi hai. Woh us aadmi ke beech hai jisne dekha hai aur us aadmi ke beech jisne dekhne ke baare mein padha hai.'

  UNION ALL SELECT 15, 'beginner',
   'The most quoted half of a verse in the chapter, and the one word almost nobody carries out of it.',
   'अध्याय का सबसे ज़्यादा उद्धृत आधा श्लोक, और वह एक शब्द जिसे लगभग कोई साथ लेकर नहीं जाता।',
   'Adhyay ka sabse zyada uddhrit aadha shloka, aur woh ek shabd jise lagbhag koi saath lekar nahi jaata.',
   'From me come memory, and understanding, and apohana — their taking away. Three things, one source, one list, one breath. The forgetting is on the list.',
   'मुझसे स्मृति आती है, और ज्ञान, और अपोहन — उनका चला जाना। तीन चीज़ें, एक जगह से, एक ही सूची में, एक ही साँस में। भूलना उस सूची में है।',
   'Mujhse smriti aati hai, aur gyan, aur apohan — unka chala jaana. Teen cheezein, ek jagah se, ek hi soochi mein, ek hi saans mein. Bhoolna us soochi mein hai.',
   'Anybody who has sat in front of a page they read yesterday and cannot now recall, or lost a name in the middle of a sentence, or gone blank in a room they had prepared for, has treated it afterwards as a personal failure. This verse does not. It puts the losing exactly where it puts the having, in the same clause, unhedged, and without having been asked to. Nothing in the chapter suggests a reader ought to be holding on to more than they are. The forgetting is on the list, it is the kindest word in the chapter, and it is the word most people who quote this verse leave out.',
   'जिसने कभी कल पढ़े हुए पन्ने के सामने बैठकर पाया हो कि अब याद नहीं आ रहा, या वाक्य के बीच में कोई नाम खो दिया हो, या जिस कमरे के लिए तैयारी की थी उसी में जाकर दिमाग़ ख़ाली हो गया हो — उसने बाद में इसे अपनी नाकामी माना है। यह श्लोक नहीं मानता। वह खोने को ठीक वहीं रखता है जहाँ पाने को रखता है, उसी वाक्य में, बिना किसी हिचक के, और बिना पूछे गए। अध्याय में कहीं यह इशारा नहीं है कि पाठक को जितना है उससे ज़्यादा थामे रखना चाहिए। भूलना सूची में है, वह इस अध्याय का सबसे दयालु शब्द है, और वही शब्द है जिसे इस श्लोक को उद्धृत करने वाले ज़्यादातर लोग छोड़ देते हैं।',
   'Jisne kabhi kal padhe hue panne ke saamne baithkar paaya ho ki ab yaad nahi aa raha, ya vakya ke beech mein koi naam kho diya ho, ya jis kamre ke liye taiyari ki thi usi mein jaakar dimaag khaali ho gaya ho — usne baad mein ise apni nakami maana hai. Yeh shloka nahi maanta. Woh khone ko theek wahin rakhta hai jahan paane ko rakhta hai, usi vakya mein, bina kisi hichak ke, aur bina poochhe gaye. Adhyay mein kahin yeh ishara nahi hai ki pathak ko jitna hai usse zyada thaame rakhna chahiye. Bhoolna soochi mein hai, woh is adhyay ka sabse dayalu shabd hai, aur wahi shabd hai jise is shloka ko uddhrit karne wale zyadatar log chhod dete hain.'

  UNION ALL SELECT 20, 'beginner',
   'The closing verse. Guhyatamam — the most closely held of things — and it has just been said out loud, at length, to somebody who asked a question.',
   'आख़िरी श्लोक। गुह्यतमम् — सबसे छिपाकर रखी गई चीज़ — और वह अभी-अभी ज़ोर से, विस्तार से, उस आदमी से कह दी गई जिसने एक सवाल पूछा था।',
   'Aakhiri shloka. Guhyatamam — sabse chhipakar rakhi gayi cheez — aur woh abhi-abhi zor se, vistaar se, us aadmi se keh di gayi jisne ek sawal poochha tha.',
   'Krita-kritya is two words for done: the work done, and the doing done. It is not a promise that nothing will ever be required of anybody again.',
   'कृतकृत्य में पूरा होने के दो शब्द हैं: काम पूरा, और करना पूरा। यह कोई वादा नहीं है कि अब किसी से कभी कुछ नहीं माँगा जाएगा।',
   'Kritakritya mein poora hone ke do shabd hain: kaam poora, aur karna poora. Yeh koi waada nahi hai ki ab kisi se kabhi kuch nahi maanga jayega.',
   'A secret that gets spoken to whoever asks is a strange kind of secret, and it is worth noticing in a book that has been used to keep people out of itself. Nothing was withheld here on the basis of who Arjuna was; the chapter arrives because he was in the conversation and had asked. And krita-kritya, the last word of it, does not mean a person now has nothing left to do. It means the thing that was pulling at them — the sense of a debt that could never be paid down — has stopped being what runs the afternoon. The chapter is twenty verses long, which is short, and it does not ask anybody to read it again.',
   'ऐसा भेद जो पूछने वाले हर किसी से कह दिया जाए एक अजीब क़िस्म का भेद है, और ऐसी किताब में इसे नोट करना काम का है जिसे लोगों को उसी से बाहर रखने के लिए इस्तेमाल किया गया है। यहाँ अर्जुन कौन था इस आधार पर कुछ रोका नहीं गया; अध्याय इसलिए आता है कि वह बातचीत में था और उसने पूछा था। और कृतकृत्य, उसका आख़िरी शब्द, यह नहीं कहता कि अब आदमी के पास करने को कुछ बचा नहीं। वह कहता है कि जो चीज़ उसे खींच रही थी — वह एहसास कि एक क़र्ज़ है जो कभी उतरेगा नहीं — वह अब दोपहर चलाने वाली चीज़ नहीं रही। अध्याय बीस श्लोक का है, जो छोटा है, और वह किसी से इसे दोबारा पढ़ने को नहीं कहता।',
   'Aisa bhed jo poochhne wale har kisi se keh diya jaaye ek ajeeb kism ka bhed hai, aur aisi kitaab mein ise note karna kaam ka hai jise logon ko usi se bahar rakhne ke liye istemal kiya gaya hai. Yahan Arjun kaun tha is aadhaar par kuch roka nahi gaya; adhyay isliye aata hai ki woh baatcheet mein tha aur usne poochha tha. Aur kritakritya, uska aakhiri shabd, yeh nahi kehta ki ab aadmi ke paas karne ko kuch bacha nahi. Woh kehta hai ki jo cheez use kheench rahi thi — woh ehsaas ki ek karz hai jo kabhi utrega nahi — woh ab dopahar chalane wali cheez nahi rahi. Adhyay bees shloka ka hai, jo chhota hai, aur woh kisi se ise dobara padhne ko nahi kehta.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 15;

-- =====================================================================
-- 3. HOOKS, REFLECTIONS, PRACTICES, TOPICS
-- =====================================================================
-- NOTHING IN THIS SECTION TREATS FORGETTING, BLANKNESS OR NOT-KNOWING
-- AS A FAULT. 15.15 puts apohana on the same list as memory, and a
-- practice that quietly asks a reader to hold on to more would be
-- arguing with the verse it hangs off.
--
-- NO PRACTICE TURNS 15.3's AXE ON A PERSON OR ON A FEELING. The tree
-- is a tree. What the 15.3 practice asks about is an arrangement the
-- reader assumed could not be otherwise — a rota, a route, a rule
-- somebody made up once. Not an attachment to anybody.
--
-- NO PRACTICE USES 15.7 AS AN EXEMPTION. The 15.7 practice points at
-- the second line, which is the one about pulling.
--
-- 8 memory aids, 24 reflections, 8 practices, 26 topic rows.
-- =====================================================================

DELETE m FROM verse_memory_aids m JOIN verses v ON v.id = m.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 15;
DELETE r FROM verse_reflections r JOIN verses v ON v.id = r.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 15;
DELETE p FROM verse_practices p JOIN verses v ON v.id = p.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 15;
DELETE vt FROM verse_topics vt JOIN verses v ON v.id = vt.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 15;

INSERT INTO verse_memory_aids (verse_id, hook_en, hook_hi, hook_hinglish, analogy_en, analogy_hi, analogy_hinglish, visual_cue)
SELECT v.id, m.h_en, m.h_hi, m.h_hing, m.a_en, m.a_hi, m.a_hing, m.cue FROM (
  SELECT 1 AS vn,
  'A tree with its roots in the air. You cannot find the start of it by looking down.' AS h_en,
  'जड़ें हवा में लिए एक पेड़। नीचे देखकर उसकी शुरुआत नहीं मिलेगी।' AS h_hi,
  'Jadein hawa mein liye ek ped. Neeche dekhkar uski shuruaat nahi milegi.' AS h_hing,
  'Like asking why your street is where it is. The answer is older than the street.' AS a_en,
  'यह पूछने जैसा कि आपकी गली यहीं क्यों है। जवाब गली से पुराना है।' AS a_hi,
  'Yeh poochhne jaisa ki tumhari gali yahin kyun hai. Jawab gali se purana hai.' AS a_hing,
  'A tree drawn upside down' AS cue

  UNION ALL SELECT 3,
  'The axe is against a tree. Not against anybody you love.',
  'कुल्हाड़ी पेड़ पर है। किसी ऐसे पर नहीं जो आपको प्रिय है।',
  'Kulhadi ped par hai. Kisi aise par nahi jo tumhe priya hai.',
  'Like cutting a rope, not a hand. The rope was never the person holding it.',
  'रस्सी काटने जैसा, हाथ नहीं। रस्सी कभी वह आदमी नहीं थी जो उसे पकड़े था।',
  'Rassi kaatne jaisa, haath nahi. Rassi kabhi woh aadmi nahi thi jo use pakde tha.',
  'An axe, resting against bark'

  UNION ALL SELECT 5,
  'Every item on the list is something put down.',
  'सूची की हर चीज़ वह है जो रखी गई है, उठाई नहीं।',
  'Soochi ki har cheez woh hai jo rakhi gayi hai, uthai nahi.',
  'Like packing for a long walk by taking things out of the bag.',
  'लंबी पैदल यात्रा की तैयारी थैले से चीज़ें निकालकर करने जैसा।',
  'Lambi paidal yatra ki taiyari thaile se cheezein nikaalkar karne jaisa.',
  'A bag, lighter than it was'

  UNION ALL SELECT 7,
  'A fragment of me — and it is the one doing the pulling.',
  'मेरा ही एक अंश — और खींच वही रहा है।',
  'Mera hi ek ansh — aur kheench wahi raha hai.',
  'Like finding out the person you were waiting for was the one carrying the crate.',
  'यह पता चलने जैसा कि जिसका आप इंतज़ार कर रहे थे वही पेटी उठाए हुए था।',
  'Yeh pata chalne jaisa ki jiska tum intezaar kar rahe the wahi peti uthaye hua tha.',
  'Two hands on a heavy rope'

  UNION ALL SELECT 9,
  'It presides over the senses. It does not fight them.',
  'वह इंद्रियों के सिरहाने बैठता है। उनसे लड़ता नहीं।',
  'Woh indriyon ke sirhane baithta hai. Unse ladta nahi.',
  'Like the person at the head of the table. The guests are not the problem.',
  'मेज़ के सिरे पर बैठे आदमी जैसा। मेहमान मुसीबत नहीं हैं।',
  'Mez ke sire par baithe aadmi jaisa. Mehmaan museebat nahi hain.',
  'A table, laid, everyone seated'

  UNION ALL SELECT 10,
  'An eye for it. Not a belief about it.',
  'उसके लिए एक आँख। उसके बारे में कोई मान्यता नहीं।',
  'Uske liye ek aankh. Uske baare mein koi manyata nahi.',
  'Like the difference between tasting salt and reading about salt.',
  'नमक चखने और नमक के बारे में पढ़ने के फ़र्क़ जैसा।',
  'Namak chakhne aur namak ke baare mein padhne ke farq jaisa.',
  'An open eye, no book'

  UNION ALL SELECT 15,
  'Memory, understanding — and their taking away. All three on one list.',
  'स्मृति, समझ — और उनका चला जाना। तीनों एक ही सूची में।',
  'Smriti, samajh — aur unka chala jaana. Teenon ek hi soochi mein.',
  'Like a tide chart that lists the going out as well as the coming in.',
  'ऐसे ज्वार-चार्ट जैसा जो आना ही नहीं, जाना भी लिखता है।',
  'Aise jwaar-chart jaisa jo aana hi nahi, jaana bhi likhta hai.',
  'A list with three lines, none crossed out'

  UNION ALL SELECT 20,
  'The most closely held thing there is, said out loud to whoever asked.',
  'सबसे छिपाकर रखी गई चीज़, पूछने वाले से ज़ोर से कह दी गई।',
  'Sabse chhipakar rakhi gayi cheez, poochhne wale se zor se keh di gayi.',
  'Like a locked room whose door was never actually locked.',
  'ऐसे बंद कमरे जैसा जिसका दरवाज़ा असल में कभी बंद था ही नहीं।',
  'Aise band kamre jaisa jiska darwaza asal mein kabhi band tha hi nahi.',
  'A door, standing open'
) AS m
JOIN verses v ON v.verse_number = m.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 15;

INSERT INTO verse_reflections (verse_id, question_en, question_hi, question_hinglish, display_order)
SELECT v.id, r.q_en, r.q_hi, r.q_hing, r.ord FROM (
  SELECT 1 AS vn, 'Name one thing about your life you did not choose and could not have.' AS q_en, 'अपनी ज़िंदगी की एक ऐसी चीज़ का नाम लीजिए जो आपने चुनी नहीं और चुन भी नहीं सकते थे।' AS q_hi, 'Apni zindagi ki ek aisi cheez ka naam lo jo tumne chuni nahi aur chun bhi nahi sakte the.' AS q_hing, 1 AS ord
  UNION ALL SELECT 1, 'When you try to explain why your life has this shape, where do the answers stop being visible?', 'जब आप समझाने चलते हैं कि आपकी ज़िंदगी की शक्ल ऐसी क्यों है, जवाब कहाँ जाकर दिखना बंद हो जाते हैं?', 'Jab tum samjhane chalte ho ki tumhari zindagi ki shakl aisi kyun hai, jawab kahan jaakar dikhna band ho jaate hain?', 2
  UNION ALL SELECT 1, 'The verse gives a picture and no argument. Does that make it easier or harder to sit with?', 'श्लोक तस्वीर देता है, दलील नहीं। इससे उसके साथ बैठना आसान होता है या मुश्किल?', 'Shloka tasveer deta hai, daleel nahi. Isse uske saath baithna aasan hota hai ya mushkil?', 3
  UNION ALL SELECT 3, 'Which arrangement in your week do you treat as permanent that somebody simply decided once?', 'आपके हफ़्ते का कौन-सा बंदोबस्त आप स्थायी मानते हैं जो असल में किसी ने एक बार तय कर दिया था?', 'Tumhare hafte ka kaun sa bandobast tum sthayi maante ho jo asal mein kisi ne ek baar tay kar diya tha?', 1
  UNION ALL SELECT 3, 'The lotus leaf stays in the water. What does that rule out as a reading of this verse?', 'कमल का पत्ता पानी में ही रहता है। यह इस श्लोक के किस पाठ को ख़ारिज कर देता है?', 'Kamal ka patta paani mein hi rehta hai. Yeh is shloka ke kis paath ko khaarij kar deta hai?', 2
  UNION ALL SELECT 3, 'Has a line about non-attachment ever been used near you to justify not turning up?', 'क्या कभी आपके आसपास अनासक्ति की किसी बात का इस्तेमाल न पहुँचने का बहाना बनाने में हुआ है?', 'Kya kabhi tumhare aaspaas anasakti ki kisi baat ka istemaal na pahunchne ka bahana banane mein hua hai?', 3
  UNION ALL SELECT 5, 'Read the list again. What are you carrying that is not on it?', 'सूची फिर पढ़िए। आप क्या उठाए हुए हैं जो उसमें नहीं है?', 'Soochi phir padho. Tum kya uthaye hue ho jo usme nahi hai?', 1
  UNION ALL SELECT 5, 'Nothing on the list is acquired. Why might a passage about arriving be written entirely as subtraction?', 'सूची में कुछ भी हासिल करने का नहीं है। पहुँचने की बात पूरी तरह घटाव में क्यों लिखी गई होगी?', 'Soochi mein kuch bhi haasil karne ka nahi hai. Pahunchne ki baat poori tarah ghatav mein kyun likhi gayi hogi?', 2
  UNION ALL SELECT 5, 'Free of the pairs is not free of weather. What in your day is currently being run by which of two things it is?', 'जोड़ों से मुक्त होना मौसम से मुक्त होना नहीं है। आपके दिन में अभी क्या इस बात से चल रहा है कि दो में से कौन-सी चीज़ है?', 'Jodon se mukt hona mausam se mukt hona nahi hai. Tumhare din mein abhi kya is baat se chal raha hai ki do mein se kaun si cheez hai?', 3
  UNION ALL SELECT 7, 'The second line says the fragment is the one pulling. What does that do to the first line?', 'दूसरी पंक्ति कहती है कि खींच वही अंश रहा है। इससे पहली पंक्ति का क्या होता है?', 'Doosri pankti kehti hai ki kheench wahi ansh raha hai. Isse pehli pankti ka kya hota hai?', 1
  UNION ALL SELECT 7, 'Karshati is the word for hauling something heavy. Where in your week is that the honest verb?', 'कर्षति भारी चीज़ घसीटने का शब्द है। आपके हफ़्ते में कहाँ यही ईमानदार क्रिया है?', 'Karshati bhaari cheez ghaseetne ka shabd hai. Tumhare hafte mein kahan yahi imaandar kriya hai?', 2
  UNION ALL SELECT 7, 'How do you describe yourself at eleven at night? Is it kinder or harsher than this verse?', 'रात ग्यारह बजे आप ख़ुद को कैसे बताते हैं? यह इस श्लोक से नरम है या सख़्त?', 'Raat gyarah baje tum khud ko kaise batate ho? Yeh is shloka se naram hai ya sakht?', 3
  UNION ALL SELECT 9, 'The verse uses a neutral word for the senses. Where did you learn to use a hostile one?', 'श्लोक इंद्रियों के लिए तटस्थ शब्द बरतता है। आपने दुश्मनी वाला शब्द कहाँ से सीखा?', 'Shloka indriyon ke liye tatasth shabd baratta hai. Tumne dushmani wala shabd kahan se seekha?', 1
  UNION ALL SELECT 9, 'Which of the five doors did you actually use today, on purpose, for a minute?', 'आज आपने पाँच में से कौन-सा दरवाज़ा जानबूझकर, एक मिनट के लिए, सचमुच बरता?', 'Aaj tumne paanch mein se kaun sa darwaza jaanboojhkar, ek minute ke liye, sachmuch barata?', 2
  UNION ALL SELECT 9, 'Presiding is not fighting. What would presiding over your own attention look like this afternoon?', 'सिरहाने बैठना लड़ना नहीं है। आज दोपहर अपने ध्यान के सिरहाने बैठना कैसा दिखेगा?', 'Sirhane baithna ladna nahi hai. Aaj dopahar apne dhyan ke sirhane baithna kaisa dikhega?', 3
  UNION ALL SELECT 10, 'What do you know because you looked, and what do you know because you read it?', 'आप क्या इसलिए जानते हैं कि आपने देखा, और क्या इसलिए कि आपने पढ़ा?', 'Tum kya isliye jaante ho ki tumne dekha, aur kya isliye ki tumne padha?', 1
  UNION ALL SELECT 10, 'Vimudha is a condition, not an insult. Where have you seen it used as one?', 'विमूढ़ एक हालत है, गाली नहीं। आपने इसे गाली की तरह कहाँ इस्तेमाल होते देखा है?', 'Vimoodh ek haalat hai, gaali nahi. Tumne ise gaali ki tarah kahan istemaal hote dekha hai?', 2
  UNION ALL SELECT 10, 'Agreeing with the chapter settles nothing. Is that a relief or a problem?', 'अध्याय से सहमत हो जाने से कुछ तय नहीं होता। यह राहत है या मुसीबत?', 'Adhyay se sehmat ho jaane se kuch tay nahi hota. Yeh raahat hai ya museebat?', 3
  UNION ALL SELECT 15, 'The forgetting is on the list. Where have you been holding that against yourself?', 'भूलना सूची में है। आप इसे अपने ही ख़िलाफ़ कहाँ रखे हुए हैं?', 'Bhoolna soochi mein hai. Tum ise apne hi khilaf kahan rakhe hue ho?', 1
  UNION ALL SELECT 15, 'What is one thing you cannot recall that you have decided means something about you?', 'ऐसी एक चीज़ कौन-सी है जो आपको याद नहीं आती और जिसका मतलब आपने अपने बारे में कुछ निकाल लिया है?', 'Aisi ek cheez kaun si hai jo tumhe yaad nahi aati aur jiska matlab tumne apne baare mein kuch nikaal liya hai?', 2
  UNION ALL SELECT 15, 'Most people who quote this verse leave apohana out. Why do you think that is?', 'इस श्लोक को उद्धृत करने वाले ज़्यादातर लोग अपोहन छोड़ देते हैं। आपको क्या लगता है, क्यों?', 'Is shloka ko uddhrit karne wale zyadatar log apohan chhod dete hain. Tumhe kya lagta hai, kyun?', 3
  UNION ALL SELECT 20, 'A secret that gets told to whoever asks. What kind of secret is that?', 'ऐसा भेद जो पूछने वाले हर किसी को बता दिया जाए। यह किस क़िस्म का भेद है?', 'Aisa bhed jo poochhne wale har kisi ko bata diya jaaye. Yeh kis kism ka bhed hai?', 1
  UNION ALL SELECT 20, 'Krita-kritya is not nothing left to do. What is the debt you have been paying down that was never issued?', 'कृतकृत्य का मतलब यह नहीं कि करने को कुछ बचा नहीं। वह कौन-सा क़र्ज़ है जो आप उतार रहे हैं और जो कभी दिया ही नहीं गया?', 'Kritakritya ka matlab yeh nahi ki karne ko kuch bacha nahi. Woh kaun sa karz hai jo tum utaar rahe ho aur jo kabhi diya hi nahi gaya?', 2
  UNION ALL SELECT 20, 'Twenty verses, and it does not ask you to read them again. What do you make of that?', 'बीस श्लोक, और वह आपसे उन्हें दोबारा पढ़ने को नहीं कहता। आप इसका क्या मतलब निकालते हैं?', 'Bees shloka, aur woh tumse unhe dobara padhne ko nahi kehta. Tum iska kya matlab nikalte ho?', 3
) AS r
JOIN verses v ON v.verse_number = r.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 15;

INSERT INTO verse_practices (verse_id, action_en, action_hi, action_hinglish, estimated_minutes, difficulty, display_order)
SELECT v.id, p.a_en, p.a_hi, p.a_hing, p.mins, p.diff, 1 FROM (
  SELECT 1 AS vn, 'Write down three facts about your life you did not choose. Stop there. Do not write what you think about them.' AS a_en, 'अपनी ज़िंदगी के तीन तथ्य लिखिए जो आपने चुने नहीं। वहीं रुक जाइए। उनके बारे में आप क्या सोचते हैं, वह मत लिखिए।' AS a_hi, 'Apni zindagi ke teen tathya likho jo tumne chune nahi. Wahin ruk jao. Unke baare mein tum kya sochte ho, woh mat likho.' AS a_hing, 6 AS mins, 'beginner' AS diff
  UNION ALL SELECT 3, 'Find one arrangement in your week that somebody decided once and nobody has revisited — a rota, a route, a rule about when you reply. Ask one person whether it still needs to be that way.', 'अपने हफ़्ते का ऐसा एक बंदोबस्त ढूँढ़िए जो किसी ने एक बार तय किया और जिसे दोबारा किसी ने देखा नहीं — कोई रोस्टर, कोई रास्ता, कोई नियम कि आप जवाब कब देते हैं। किसी एक से पूछिए कि क्या यह अब भी ऐसा ही रहना ज़रूरी है।', 'Apne hafte ka aisa ek bandobast dhoondho jo kisi ne ek baar tay kiya aur jise dobara kisi ne dekha nahi — koi roster, koi raasta, koi niyam ki tum jawab kab dete ho. Kisi ek se poocho ki kya yeh ab bhi aisa hi rehna zaroori hai.', 10, 'intermediate'
  UNION ALL SELECT 5, 'Open the bag. Name one thing you have been carrying this month that nobody asked you to pick up.', 'थैला खोलिए। इस महीने आप जो एक चीज़ उठाए घूम रहे हैं और जिसे उठाने को किसी ने नहीं कहा था, उसका नाम लीजिए।', 'Thaila kholo. Is mahine tum jo ek cheez uthaye ghoom rahe ho aur jise uthane ko kisi ne nahi kaha tha, uska naam lo.', 5, 'beginner'
  UNION ALL SELECT 7, 'Take one thing that felt heavy today and describe it using the verb for hauling — I was pulling this. Notice that the sentence has somebody in it who was working.', 'आज जो एक चीज़ भारी लगी उसे लीजिए और घसीटने वाली क्रिया से बताइए — मैं इसे खींच रहा था। ध्यान दीजिए कि उस वाक्य में कोई है जो मेहनत कर रहा था।', 'Aaj jo ek cheez bhaari lagi use lo aur ghaseetne wali kriya se batao — main ise kheench raha tha. Dhyan do ki us vakya mein koi hai jo mehnat kar raha tha.', 6, 'beginner'
  UNION ALL SELECT 9, 'Use one of the five doors on purpose for sixty seconds — listen to one sound all the way through, or taste one mouthful without doing anything else. Nothing is being trained here.', 'साठ सेकंड के लिए पाँच में से एक दरवाज़ा जानबूझकर बरतिए — किसी एक आवाज़ को पूरा सुनिए, या एक कौर बिना कुछ और किए चखिए। यहाँ किसी चीज़ का अभ्यास नहीं कराया जा रहा।', 'Saath second ke liye paanch mein se ek darwaza jaanboojhkar barto — kisi ek awaaz ko poora suno, ya ek kaur bina kuch aur kiye chakho. Yahan kisi cheez ka abhyas nahi karaya ja raha.', 2, 'beginner'
  UNION ALL SELECT 10, 'Write one thing you believe about yourself, and next to it write whether you looked or were told. Leave both answers standing.', 'अपने बारे में एक बात लिखिए जो आप मानते हैं, और उसके बग़ल में लिखिए कि आपने देखा था या आपको बताया गया था। दोनों जवाब वैसे ही रहने दीजिए।', 'Apne baare mein ek baat likho jo tum maante ho, aur uske bagal mein likho ki tumne dekha tha ya tumhe bataya gaya tha. Dono jawab waise hi rehne do.', 7, 'intermediate'
  UNION ALL SELECT 15, 'Think of one thing you could not remember recently and said something unkind to yourself about. Say the verse back instead: the forgetting is on the list. Then leave it alone.', 'हाल की कोई एक चीज़ सोचिए जो आपको याद नहीं आई और जिस पर आपने ख़ुद से कुछ कड़वा कहा। उसकी जगह श्लोक दोहराइए: भूलना सूची में है। फिर उसे छोड़ दीजिए।', 'Haal ki koi ek cheez socho jo tumhe yaad nahi aayi aur jis par tumne khud se kuch kadwa kaha. Uski jagah shloka dohrao: bhoolna soochi mein hai. Phir use chhod do.', 4, 'beginner'
  UNION ALL SELECT 20, 'Name one debt you are paying down that nobody issued. Write who you think you owe it to. If the line comes out blank, that is the answer.', 'ऐसे एक क़र्ज़ का नाम लीजिए जो आप उतार रहे हैं और जो किसी ने दिया नहीं। लिखिए कि आपको लगता है वह किसका है। अगर पंक्ति ख़ाली रह जाए, तो वही जवाब है।', 'Aise ek karz ka naam lo jo tum utaar rahe ho aur jo kisi ne diya nahi. Likho ki tumhe lagta hai woh kiska hai. Agar pankti khaali reh jaaye, to wahi jawab hai.', 8, 'intermediate'
) AS p
JOIN verses v ON v.verse_number = p.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 15;

INSERT INTO verse_topics (verse_id, topic_id, relevance)
SELECT v.id, t.id, x.rel FROM (
  SELECT 1 AS vn, 'impermanence' AS slug, 9 AS rel
  UNION ALL SELECT 1, 'the-self', 8
  UNION ALL SELECT 1, 'hard-decisions', 6
  UNION ALL SELECT 3, 'action-without-attachment', 9
  UNION ALL SELECT 3, 'impermanence', 8
  UNION ALL SELECT 3, 'hard-decisions', 7
  UNION ALL SELECT 5, 'desire', 9
  UNION ALL SELECT 5, 'comparison', 8
  UNION ALL SELECT 5, 'steadiness', 7
  UNION ALL SELECT 7, 'the-self', 10
  UNION ALL SELECT 7, 'burnout', 8
  UNION ALL SELECT 7, 'restlessness', 7
  UNION ALL SELECT 9, 'restlessness', 8
  UNION ALL SELECT 9, 'desire', 7
  UNION ALL SELECT 9, 'the-self', 7
  UNION ALL SELECT 10, 'the-self', 9
  UNION ALL SELECT 10, 'comparison', 7
  UNION ALL SELECT 10, 'steadiness', 6
  UNION ALL SELECT 15, 'burnout', 10
  UNION ALL SELECT 15, 'fear', 7
  UNION ALL SELECT 15, 'impermanence', 7
  UNION ALL SELECT 15, 'steadiness', 6
  UNION ALL SELECT 20, 'effort-without-result', 9
  UNION ALL SELECT 20, 'burnout', 8
  UNION ALL SELECT 20, 'steadiness', 7
  UNION ALL SELECT 20, 'the-self', 6
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 15
JOIN topics t ON t.slug = x.slug;

-- =====================================================================
-- 4. MODERN EXAMPLES
-- =====================================================================
-- Four per verse, four distinct categories per verse, THIRTY-TWO total.
--
-- NOT ONE EXAMPLE IN THIS FILE TREATS FORGETTING, GOING BLANK OR NOT
-- KNOWING AS A FAULT. 15.15 puts apohana on the same list as memory,
-- and the four examples on that verse all run the other way: somebody
-- has been holding a lapse against themselves and stops.
--
-- THE 15.3 SET NEVER POINTS THE AXE AT A PERSON. In all four, what
-- gets cut is an arrangement somebody assumed was fixed.
--
-- THE 15.7 SET NEVER USES THE VERSE AS AN EXEMPTION. In all four,
-- somebody is doing the pulling and is tired, and the verse describes
-- them rather than excusing them.
-- =====================================================================

DELETE e FROM modern_examples e JOIN verses v ON v.id = e.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 15;

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

  SELECT 1 AS vn, 'everyday_life' AS cat, 1 AS ord,
  'Why the bus goes that way' AS t_en, 'बस उस रास्ते से क्यों जाती है' AS t_hi, 'Bus us raaste se kyun jaati hai' AS t_hing,
  'Somebody has taken the same bus for eleven years and one morning wonders why it loops through an industrial estate nobody works in any more. Nobody at the depot knows. The route was drawn when the mill was open and the mill closed in 1994.' AS s_en,
  'कोई ग्यारह साल से वही बस लेता आया है और एक सुबह सोचता है कि यह उस औद्योगिक इलाक़े से चक्कर काटकर क्यों जाती है जहाँ अब कोई काम नहीं करता। डिपो में किसी को नहीं पता। रास्ता तब खींचा गया था जब मिल चालू थी, और मिल 1994 में बंद हो गई।' AS s_hi,
  'Koi gyarah saal se wahi bus leta aaya hai aur ek subah sochta hai ki yeh us audyogik ilaake se chakkar kaatkar kyun jaati hai jahan ab koi kaam nahi karta. Depot mein kisi ko nahi pata. Raasta tab kheencha gaya tha jab mill chaalu thi, aur mill 1994 mein band ho gayi.' AS s_hing,
  'This is the tree with its roots in the air, at the scale of a bus route. Every branch is visible — the stops, the timing, the eleven years — and the root is somewhere above, in a decision nobody in the depot was present for. The verse is not asking anybody to trace it. It is pointing out that it goes up further than you can see from the seat.' AS c_en,
  'यह हवा में जड़ों वाला पेड़ है, एक बस रूट के पैमाने पर। हर टहनी दिखती है — स्टॉप, समय, ग्यारह साल — और जड़ कहीं ऊपर है, किसी ऐसे फ़ैसले में जिसके वक़्त डिपो में कोई मौजूद नहीं था। श्लोक किसी से उसे खोजने को नहीं कह रहा। वह इतना बता रहा है कि सीट से जितना दिखता है, वह उससे ऊपर तक जाता है।' AS c_hi,
  'Yeh hawa mein jadon wala ped hai, ek bus route ke paimane par. Har tehni dikhti hai — stop, samay, gyarah saal — aur jad kahin upar hai, kisi aise faisle mein jiske waqt depot mein koi maujood nahi tha. Shloka kisi se use khojne ko nahi keh raha. Woh itna bata raha hai ki seat se jitna dikhta hai, woh usse upar tak jaata hai.' AS c_hing,
  'The branches are where you are sitting. The root is a decision nobody present was there for.' AS l_en,
  'टहनियाँ वहीं हैं जहाँ आप बैठे हैं। जड़ वह फ़ैसला है जिसके वक़्त मौजूद कोई मौजूद नहीं था।' AS l_hi,
  'Tehniyan wahin hain jahan tum baithe ho. Jad woh faisla hai jiske waqt maujood koi maujood nahi tha.' AS l_hing,
  NULL AS src, 'beginner' AS diff, 'inheritance,routine,history,questions' AS tags

  UNION ALL SELECT 1, 'school', 2,
  'The syllabus nobody wrote', 'वह पाठ्यक्रम जो किसी ने लिखा नहीं', 'Woh paathyakram jo kisi ne likha nahi',
  'A new teacher asks why the chapter on measurement comes before the chapter on shapes, since her students clearly find shapes easier. The head of department says it has always been that way. The order came from a textbook that went out of print before either of them was hired.',
  'एक नई अध्यापिका पूछती है कि नाप वाला अध्याय आकृतियों वाले अध्याय से पहले क्यों आता है, जबकि उसके बच्चों को आकृतियाँ साफ़ तौर पर आसान लगती हैं। विभाग प्रमुख कहते हैं, हमेशा से ऐसा ही है। यह क्रम एक ऐसी किताब से आया था जो दोनों की नियुक्ति से पहले छपना बंद हो चुकी थी।',
  'Ek nayi adhyapika poochhti hai ki naap wala adhyay aakritiyon wale adhyay se pehle kyun aata hai, jabki uske bachchon ko aakritiyan saaf taur par aasan lagti hain. Vibhag pramukh kehte hain, hamesha se aisa hi hai. Yeh kram ek aisi kitaab se aaya tha jo dono ki niyukti se pehle chhapna band ho chuki thi.',
  'Chapter 15 opens on the observation that you are standing in the branches. What a person can see of an institution is the part hanging down at eye level — the order of the units, the marks, the timetable. Whatever produced it is in the other direction and looking harder at the classroom will not find it. The verse does not treat that as a scandal. It treats it as the situation.',
  'पंद्रहवाँ अध्याय इसी बात से शुरू होता है कि आप टहनियों में खड़े हैं। किसी संस्था का जो हिस्सा आदमी देख सकता है वह आँख की ऊँचाई पर लटका हुआ हिस्सा है — इकाइयों का क्रम, नंबर, समय-सारणी। जिसने उसे बनाया वह दूसरी दिशा में है और कक्षा को और ग़ौर से देखने पर नहीं मिलेगा। श्लोक इसे कांड नहीं मानता। वह इसे हालत मानता है।',
  'Pandrahvan adhyay isi baat se shuru hota hai ki aap tehniyon mein khade hain. Kisi sanstha ka jo hissa aadmi dekh sakta hai woh aankh ki oonchai par latka hua hissa hai — ikaiyon ka kram, number, samay-saarni. Jisne use banaya woh doosri disha mein hai aur kaksha ko aur gaur se dekhne par nahi milega. Shloka ise kaand nahi maanta. Woh ise haalat maanta hai.',
  'What you can see of an institution is the part hanging at eye level.',
  'किसी संस्था का जो आपको दिखता है वह आँख की ऊँचाई पर लटका हिस्सा है।',
  'Kisi sanstha ka jo tumhe dikhta hai woh aankh ki oonchai par latka hissa hai.',
  NULL, 'beginner', 'institutions,inherited,curriculum,why'

  UNION ALL SELECT 1, 'corporate', 3,
  'The field that has to stay in the form', 'वह ख़ाना जो फ़ॉर्म में बना रहना चाहिए', 'Woh khaana jo form mein bana rehna chahiye',
  'A team wants to remove a field from an internal form that nobody has filled in correctly for three years. Legal says keep it. Asked why, legal says an earlier legal team said so. The earlier team is gone and the note explaining it is not in the file.',
  'एक टीम आंतरिक फ़ॉर्म से वह ख़ाना हटाना चाहती है जिसे तीन साल से किसी ने ठीक से नहीं भरा। क़ानूनी विभाग कहता है, रहने दो। कारण पूछने पर वे कहते हैं कि पहले की क़ानूनी टीम ने ऐसा कहा था। वह टीम अब नहीं है और उसकी वजह बताने वाला नोट फ़ाइल में नहीं है।',
  'Ek team aantarik form se woh khaana hatana chahti hai jise teen saal se kisi ne theek se nahi bhara. Kanooni vibhag kehta hai, rehne do. Kaaran poochhne par we kehte hain ki pehle ki kanooni team ne aisa kaha tha. Woh team ab nahi hai aur uski wajah batane wala note file mein nahi hai.',
  'An upside-down tree in one field of one form. The leaf is visible daily; the root is a conversation that happened and was not written down. Chapter 15 spends two verses on this before it says anything at all about what to do, and that ordering is deliberate: the picture comes first, and the instruction comes after somebody has admitted they cannot see the top.',
  'एक फ़ॉर्म के एक ख़ाने में उल्टा पेड़। पत्ता रोज़ दिखता है; जड़ वह बातचीत है जो हुई और लिखी नहीं गई। पंद्रहवाँ अध्याय कुछ भी करने की बात कहने से पहले दो श्लोक इसी पर लगाता है, और यह क्रम जानबूझकर है: पहले तस्वीर, और निर्देश तब जब आदमी मान ले कि उसे ऊपर का सिरा दिखता नहीं।',
  'Ek form ke ek khaane mein ulta ped. Patta roz dikhta hai; jad woh baatcheet hai jo hui aur likhi nahi gayi. Pandrahvan adhyay kuch bhi karne ki baat kehne se pehle do shloka isi par lagata hai, aur yeh kram jaanboojhkar hai: pehle tasveer, aur nirdesh tab jab aadmi maan le ki use upar ka sira dikhta nahi.',
  'The picture comes first. The instruction comes after somebody admits they cannot see the top.',
  'पहले तस्वीर आती है। निर्देश तब आता है जब कोई मान ले कि उसे ऊपर का सिरा नहीं दिखता।',
  'Pehle tasveer aati hai. Nirdesh tab aata hai jab koi maan le ki use upar ka sira nahi dikhta.',
  NULL, 'intermediate', 'process,legacy,forms,undocumented'

  UNION ALL SELECT 1, 'technology', 4,
  'The line of code with a name on it', 'वह कोड की पंक्ति जिस पर एक नाम है', 'Woh code ki pankti jis par ek naam hai',
  'A developer runs the tool that shows who last changed each line. One condition, which everything else depends on, was written by somebody who left in 2016, in a commit whose message is the single word fix.',
  'एक डेवलपर वह औज़ार चलाता है जो बताता है कि हर पंक्ति आख़िरी बार किसने बदली। एक शर्त, जिस पर बाक़ी सब टिका है, 2016 में जा चुके किसी आदमी ने लिखी थी, ऐसे कमिट में जिसका संदेश सिर्फ़ एक शब्द है — fix।',
  'Ek developer woh auzaar chalata hai jo batata hai ki har pankti aakhiri baar kisne badli. Ek shart, jis par baaki sab tika hai, 2016 mein ja chuke kisi aadmi ne likhi thi, aise commit mein jiska sandesh sirf ek shabd hai — fix.',
  'Its shape is not perceived here, says the next-but-one verse, nor its end, nor its beginning. That is an unusually accurate description of reading somebody else''s codebase, and the point of the image is not despair. The tree is still standing and the work still runs. Not being able to see the root is the ordinary condition of being inside something, not a sign that something has gone wrong.',
  'अगले से अगला श्लोक कहता है कि उसका रूप यहाँ दिखाई नहीं देता, न अंत, न शुरुआत। किसी और के लिखे कोड को पढ़ने का यह असामान्य रूप से सटीक वर्णन है, और तस्वीर का मक़सद निराशा नहीं है। पेड़ अब भी खड़ा है और काम अब भी चल रहा है। जड़ का न दिखना किसी चीज़ के भीतर होने की आम हालत है, इस बात का सबूत नहीं कि कुछ बिगड़ गया है।',
  'Agle se agla shloka kehta hai ki uska roop yahan dikhai nahi deta, na ant, na shuruaat. Kisi aur ke likhe code ko padhne ka yeh asamanya roop se sateek varnan hai, aur tasveer ka maksad nirasha nahi hai. Ped ab bhi khada hai aur kaam ab bhi chal raha hai. Jad ka na dikhna kisi cheez ke bheetar hone ki aam haalat hai, is baat ka saboot nahi ki kuch bigad gaya hai.',
  'Not seeing the root is the ordinary condition of being inside something.',
  'जड़ का न दिखना किसी चीज़ के भीतर होने की आम हालत है।',
  'Jad ka na dikhna kisi cheez ke bheetar hone ki aam haalat hai.',
  NULL, 'intermediate', 'legacy,inheritance,code,unknown'

  UNION ALL SELECT 3, 'relationships', 1,
  'The Sunday that was never decided', 'वह इतवार जो कभी तय हुआ ही नहीं', 'Woh itwaar jo kabhi tay hua hi nahi',
  'Two people have spent every Sunday at one set of parents for six years. Neither of them chose it; it started because of a lift that was convenient in the first winter. When one of them finally says it out loud, the other says they had assumed it mattered to her.',
  'दो लोग छह साल से हर इतवार एक ही तरफ़ के माँ-बाप के यहाँ बिताते आए हैं। यह किसी ने चुना नहीं था; यह पहली सर्दी में एक सुविधाजनक लिफ़्ट की वजह से शुरू हुआ था। जब आख़िरकार एक इसे ज़ोर से कहता है, दूसरा कहता है कि उसे लगता था यह उसके लिए मायने रखता है।',
  'Do log chhah saal se har itwaar ek hi taraf ke maa-baap ke yahan bitate aaye hain. Yeh kisi ne chuna nahi tha; yeh pehli sardi mein ek suvidhajanak lift ki wajah se shuru hua tha. Jab aakhirkar ek ise zor se kehta hai, doosra kehta hai ki use lagta tha yeh uske liye maayne rakhta hai.',
  'This is what the axe in 15.3 is for. Note carefully what got cut and what did not: nobody stopped visiting anybody, nobody loved anybody less, and the parents were never the tree. What was cut was the assumption that a Sunday arranged once by a lift could not be arranged any other way. The weapon in this verse is pointed at a tree, and this is what a tree looks like at human scale.',
  'यही काम 15.3 की कुल्हाड़ी का है। ध्यान से देखिए कि कटा क्या और क्या नहीं: किसी ने किसी से मिलना बंद नहीं किया, किसी ने किसी को कम प्यार नहीं किया, और माँ-बाप कभी वह पेड़ थे ही नहीं। जो कटा वह यह मान्यता थी कि एक लिफ़्ट से एक बार तय हुआ इतवार किसी और तरह तय हो ही नहीं सकता। इस श्लोक का हथियार एक पेड़ की ओर है, और इंसानी पैमाने पर पेड़ ऐसा दिखता है।',
  'Yahi kaam 15.3 ki kulhadi ka hai. Dhyan se dekhiye ki kata kya aur kya nahi: kisi ne kisi se milna band nahi kiya, kisi ne kisi ko kam pyaar nahi kiya, aur maa-baap kabhi woh ped the hi nahi. Jo kata woh yeh manyata thi ki ek lift se ek baar tay hua itwaar kisi aur tarah tay ho hi nahi sakta. Is shloka ka hathiyaar ek ped ki or hai, aur insani paimane par ped aisa dikhta hai.',
  'Nobody stopped visiting anybody. What got cut was the assumption that it could not be otherwise.',
  'किसी ने किसी से मिलना बंद नहीं किया। कटी वह मान्यता कि और कुछ हो ही नहीं सकता था।',
  'Kisi ne kisi se milna band nahi kiya. Kati woh manyata ki aur kuch ho hi nahi sakta tha.',
  NULL, 'beginner', 'habit,assumption,asking,family'

  UNION ALL SELECT 3, 'startup', 2,
  'The stand-up at nine fifteen', 'सवा नौ की स्टैंड-अप', 'Sawa nau ki stand-up',
  'A company of forty people holds a daily meeting at nine fifteen. It was set at nine fifteen because the two founders used to get in at nine. Nobody gets in at nine any more, several people commute an hour, and no one has proposed moving it because it feels like the way things are.',
  'चालीस लोगों की एक कंपनी रोज़ सवा नौ बजे मीटिंग करती है। समय सवा नौ इसलिए तय हुआ था कि दोनों संस्थापक नौ बजे आते थे। अब कोई नौ बजे नहीं आता, कई लोग घंटे भर का सफ़र करते हैं, और किसी ने इसे बदलने की बात नहीं रखी क्योंकि यह चीज़ों के होने का तरीक़ा लगता है।',
  'Chalis logon ki ek company roz sawa nau baje meeting karti hai. Samay sawa nau isliye tay hua tha ki dono sansthapak nau baje aate the. Ab koi nau baje nahi aata, kai log ghante bhar ka safar karte hain, aur kisi ne ise badalne ki baat nahi rakhi kyunki yeh cheezon ke hone ka tareeka lagta hai.',
  'The verse says the tree''s shape is not perceived from inside it, and then hands over an axe. What is under the axe is the words the way things are. Forty people''s mornings are being run by two people''s commutes from a year that is over. Cutting that costs one sentence in one meeting and nothing else, which is usually true of the things people treat as fixed.',
  'श्लोक कहता है कि पेड़ का रूप उसके भीतर से नहीं दिखता, और फिर कुल्हाड़ी थमा देता है। कुल्हाड़ी के नीचे शब्द हैं — चीज़ों के होने का तरीक़ा। चालीस लोगों की सुबहें दो लोगों के उस सफ़र से चल रही हैं जो साल ख़त्म हो चुका है। इसे काटने में एक मीटिंग का एक वाक्य लगता है और कुछ नहीं, और जिन चीज़ों को लोग तय मान लेते हैं उनके बारे में अक्सर यही सच होता है।',
  'Shloka kehta hai ki ped ka roop uske bheetar se nahi dikhta, aur phir kulhadi thama deta hai. Kulhadi ke neeche shabd hain — cheezon ke hone ka tareeka. Chalis logon ki subhein do logon ke us safar se chal rahi hain jo saal khatm ho chuka hai. Ise kaatne mein ek meeting ka ek vakya lagta hai aur kuch nahi, aur jin cheezon ko log tay maan lete hain unke baare mein aksar yahi sach hota hai.',
  'What is under the axe is the phrase the way things are.',
  'कुल्हाड़ी के नीचे यह वाक्यांश है — चीज़ों के होने का तरीक़ा।',
  'Kulhadi ke neeche yeh vakyansh hai — cheezon ke hone ka tareeka.',
  NULL, 'beginner', 'meetings,defaults,time,questioning'

  UNION ALL SELECT 3, 'sports', 3,
  'The warm-up from an old coach', 'पुराने कोच की वॉर्म-अप', 'Purane coach ki warm-up',
  'A club side has done the same twenty-minute warm-up for nine seasons. The physiotherapist who joins in the tenth points out that two of the stretches are the ones her training told her to stop using in 2011. The coach who introduced them retired before half the squad joined.',
  'एक क्लब टीम नौ सीज़न से वही बीस मिनट की वॉर्म-अप करती आ रही है। दसवें सीज़न में आई फ़िज़ियोथेरेपिस्ट बताती है कि उनमें से दो स्ट्रेच वही हैं जिन्हें छोड़ने की सलाह उसकी ट्रेनिंग ने 2011 में दी थी। जिस कोच ने वे शुरू की थीं वह आधी टीम के आने से पहले रिटायर हो गया।',
  'Ek club team nau season se wahi bees minute ki warm-up karti aa rahi hai. Dasven season mein aayi physiotherapist batati hai ki unme se do stretch wahi hain jinhe chhodne ki salah uski training ne 2011 mein di thi. Jis coach ne we shuru ki thin woh aadhi team ke aane se pehle retire ho gaya.',
  'A thing worth noticing about the axe: it does not swing at the coach. He is not there, and the verse has no person in it. What gets cut is the inheritance itself — twenty minutes that arrived from above and were never looked at. Asanga is not-sticking, and what is not being stuck to here is not a person but a habit that came with the building.',
  'कुल्हाड़ी के बारे में एक बात ध्यान देने लायक़: वह कोच पर नहीं चलती। वह वहाँ है ही नहीं, और श्लोक में कोई आदमी है ही नहीं। जो कटता है वह विरासत ख़ुद है — बीस मिनट जो ऊपर से आए और जिन्हें कभी देखा नहीं गया। असंग यानी न चिपकना, और यहाँ जिससे नहीं चिपका जा रहा वह कोई आदमी नहीं, वह आदत है जो इमारत के साथ आई थी।',
  'Kulhadi ke baare mein ek baat dhyan dene layak: woh coach par nahi chalti. Woh wahan hai hi nahi, aur shloka mein koi aadmi hai hi nahi. Jo katta hai woh virasat khud hai — bees minute jo upar se aaye aur jinhe kabhi dekha nahi gaya. Asang yani na chipakna, aur yahan jisse nahi chipka ja raha woh koi aadmi nahi, woh aadat hai jo imaarat ke saath aayi thi.',
  'The axe does not swing at the coach. He is not in the image at all.',
  'कुल्हाड़ी कोच पर नहीं चलती। वह तस्वीर में है ही नहीं।',
  'Kulhadi coach par nahi chalti. Woh tasveer mein hai hi nahi.',
  NULL, 'intermediate', 'inheritance,practice,updating,evidence'

  UNION ALL SELECT 3, 'everyday_life', 4,
  'Where the detachment line got used', 'जहाँ अनासक्ति वाली बात इस्तेमाल हुई', 'Jahan anasakti wali baat istemaal hui',
  'A man misses his sister''s move to a new city and tells her afterwards that he has been working on non-attachment. She says she did not need him to be attached, she needed somebody to carry boxes.',
  'एक आदमी अपनी बहन के नए शहर जाने में नहीं पहुँचता और बाद में उसे बताता है कि वह अनासक्ति पर काम कर रहा है। वह कहती है कि उसे उसकी आसक्ति नहीं चाहिए थी, उसे कोई चाहिए था जो डिब्बे उठाए।',
  'Ek aadmi apni behen ke naye shehar jaane mein nahi pahunchta aur baad mein use batata hai ki woh anasakti par kaam kar raha hai. Woh kehti hai ki use uski aasakti nahi chahiye thi, use koi chahiye tha jo dibbe uthaye.',
  'This is the misuse the chapter has to be protected from, and the protection is in the verse rather than in anybody''s commentary. Asanga is not-sticking, not not-feeling and not not-turning-up. It is the same word that produced the lotus leaf in 5.10, and the leaf spends the entire day in the water. A reading that keeps somebody away from a van full of boxes has the word backwards.',
  'यही वह ग़लत इस्तेमाल है जिससे इस अध्याय को बचाना है, और बचाव श्लोक में है, किसी की टिप्पणी में नहीं। असंग यानी न चिपकना, न कि महसूस न करना और न कि न पहुँचना। यह वही शब्द है जिससे 5.10 का कमल-पत्ता बना, और पत्ता पूरा दिन पानी में बिताता है। जो पाठ किसी को डिब्बों से भरी गाड़ी से दूर रखे उसने शब्द उल्टा पढ़ा है।',
  'Yahi woh galat istemaal hai jisse is adhyay ko bachana hai, aur bachav shloka mein hai, kisi ki tippani mein nahi. Asang yani na chipakna, na ki mehsoos na karna aur na ki na pahunchna. Yeh wahi shabd hai jisse 5.10 ka kamal-patta bana, aur patta poora din paani mein bitata hai. Jo paath kisi ko dibbon se bhari gaadi se door rakhe usne shabd ulta padha hai.',
  'Asanga is not-sticking, not not-turning-up. The leaf spends the whole day in the water.',
  'असंग यानी न चिपकना, न पहुँचना नहीं। पत्ता पूरा दिन पानी में बिताता है।',
  'Asang yani na chipakna, na pahunchna nahi. Patta poora din paani mein bitata hai.',
  NULL, 'intermediate', 'misuse,showing-up,family,words'

  UNION ALL SELECT 5, 'finance', 1,
  'The subscriptions nobody chose', 'वे सदस्यताएँ जो किसी ने चुनी नहीं', 'We sadasyataein jo kisi ne chuni nahi',
  'Somebody opens their statement properly for the first time in two years and finds nine recurring payments, four of which they cannot identify. Cancelling them takes an afternoon. The relief is out of all proportion to the money.',
  'कोई दो साल में पहली बार अपना स्टेटमेंट ठीक से खोलता है और नौ नियमित भुगतान पाता है, जिनमें से चार को वह पहचान ही नहीं पाता। उन्हें बंद करने में एक दोपहर लगती है। जो राहत मिलती है वह पैसे के हिसाब से कहीं ज़्यादा है।',
  'Koi do saal mein pehli baar apna statement theek se kholta hai aur nau niyamit bhugtaan paata hai, jinme se chaar ko woh pehchaan hi nahi paata. Unhe band karne mein ek dopahar lagti hai. Jo raahat milti hai woh paise ke hisaab se kahin zyada hai.',
  'Every item on the 15.5 list is a subtraction — no pride of standing, wants turned back, loose from the pairs. Nothing is acquired anywhere in it. The relief being out of proportion to the money is the tell: what was heavy was not the amount, it was carrying nine things you had not agreed to.',
  '15.5 की सूची की हर चीज़ घटाव है — रुतबे का घमंड नहीं, चाहतें लौटा दी गईं, जोड़ों से ढीले। उसमें कहीं कुछ हासिल नहीं किया जाता। राहत का पैसे से बेमेल होना ही सुराग़ है: भारी रक़म नहीं थी, भारी वे नौ चीज़ें उठाना था जिनके लिए आपने हामी नहीं भरी थी।',
  '15.5 ki soochi ki har cheez ghatav hai — rutbe ka ghamand nahi, chahatein lauta di gayin, jodon se dheele. Usme kahin kuch haasil nahi kiya jaata. Raahat ka paise se bemel hona hi suraag hai: bhaari rakam nahi thi, bhaari we nau cheezein uthana tha jinke liye tumne haami nahi bhari thi.',
  'The relief was out of proportion to the money. That is the tell.',
  'राहत पैसे के अनुपात से बाहर थी। यही सुराग़ है।',
  'Raahat paise ke anupaat se bahar thi. Yahi suraag hai.',
  NULL, 'beginner', 'subtraction,clearing,money,relief'

  UNION ALL SELECT 5, 'college', 2,
  'The five new habits by December', 'दिसंबर तक पाँच नई आदतें', 'December tak paanch nayi aadatein',
  'A student reads a passage about equanimity and immediately writes a plan with five new practices in it, scheduled from Monday. By the third week she has failed four of them and added self-discipline to the list of things she is bad at.',
  'एक छात्रा समता पर एक हिस्सा पढ़ती है और तुरंत पाँच नए अभ्यासों वाली योजना लिख डालती है, सोमवार से शुरू। तीसरे हफ़्ते तक वह उनमें से चार में नाकाम हो चुकी है और आत्म-अनुशासन को उन चीज़ों की सूची में जोड़ चुकी है जिनमें वह ख़राब है।',
  'Ek chhatra samta par ek hissa padhti hai aur turant paanch naye abhyason wali yojana likh daalti hai, somwar se shuru. Teesre hafte tak woh unme se chaar mein nakaam ho chuki hai aur aatm-anushasan ko un cheezon ki soochi mein jod chuki hai jinme woh kharab hai.',
  'She read a list of subtractions as a list of acquisitions, which is the commonest way to read this verse and produces exactly this outcome. Nirmana-moha is the absence of a thing. Vinivritta-kama is a turning back. There is nothing on the list to be good at, and a person who has failed at it has usually been handed the wrong list by their own reading.',
  'उसने घटाव की सूची को हासिल करने की सूची की तरह पढ़ा, जो इस श्लोक को पढ़ने का सबसे आम तरीक़ा है और ठीक यही नतीजा देता है। निर्मान-मोह किसी चीज़ की ग़ैरमौजूदगी है। विनिवृत्त-काम एक लौटना है। सूची में कुछ भी ऐसा नहीं है जिसमें अच्छा होना हो, और जो इसमें नाकाम हुआ है उसे अक्सर उसके अपने पाठ ने ग़लत सूची थमा दी है।',
  'Usne ghatav ki soochi ko haasil karne ki soochi ki tarah padha, jo is shloka ko padhne ka sabse aam tareeka hai aur theek yahi nateeja deta hai. Nirman-moh kisi cheez ki gairmaujoodgi hai. Vinivritta-kaam ek lautna hai. Soochi mein kuch bhi aisa nahi hai jisme achha hona ho, aur jo isme nakaam hua hai use aksar uske apne paath ne galat soochi thama di hai.',
  'There is nothing on the list to be good at.',
  'सूची में कुछ भी ऐसा नहीं जिसमें अच्छा होना हो।',
  'Soochi mein kuch bhi aisa nahi jisme achha hona ho.',
  NULL, 'beginner', 'self-improvement,misreading,subtraction,pressure'

  UNION ALL SELECT 5, 'leadership', 3,
  'The manager who stopped announcing', 'वह मैनेजर जिसने ऐलान करना बंद कर दिया', 'Woh manager jisne elaan karna band kar diya',
  'A team lead notices he opens every review by summarising his own contribution first. He stops doing it. Nothing is added to his practice and no new skill is learned; a habit simply comes off. Three months later two people tell him meetings feel different and neither can say why.',
  'एक टीम लीड को लगता है कि वह हर समीक्षा की शुरुआत अपने ही योगदान का सार बताकर करता है। वह बंद कर देता है। उसके अभ्यास में कुछ जुड़ता नहीं और कोई नया हुनर नहीं सीखा जाता; बस एक आदत उतर जाती है। तीन महीने बाद दो लोग उससे कहते हैं कि मीटिंगें अलग लगती हैं और दोनों बता नहीं पाते क्यों।',
  'Ek team lead ko lagta hai ki woh har sameeksha ki shuruaat apne hi yogdaan ka saar batakar karta hai. Woh band kar deta hai. Uske abhyas mein kuch judta nahi aur koi naya hunar nahi seekha jaata; bas ek aadat utar jaati hai. Teen mahine baad do log usse kehte hain ki meetingein alag lagti hain aur dono bata nahi paate kyun.',
  'Nirmana-moha is the first item on the list and it is the pride of position rather than pride in general. Notice the shape of what he did: nothing added. That is what the whole verse is like, and it is why the people around him cannot name the change. Subtractions are hard to point at from outside.',
  'निर्मान-मोह सूची की पहली चीज़ है और वह आम घमंड नहीं, रुतबे का घमंड है। उसने जो किया उसकी शक्ल देखिए: कुछ जोड़ा नहीं गया। पूरा श्लोक ऐसा ही है, और इसीलिए उसके आसपास के लोग बदलाव का नाम नहीं ले पाते। घटाव को बाहर से दिखाना मुश्किल होता है।',
  'Nirman-moh soochi ki pehli cheez hai aur woh aam ghamand nahi, rutbe ka ghamand hai. Usne jo kiya uski shakl dekhiye: kuch joda nahi gaya. Poora shloka aisa hi hai, aur isiliye uske aaspaas ke log badlav ka naam nahi le paate. Ghatav ko bahar se dikhana mushkil hota hai.',
  'Subtractions are hard to point at from outside. Nothing was added.',
  'घटाव को बाहर से दिखाना मुश्किल है। कुछ जोड़ा नहीं गया।',
  'Ghatav ko bahar se dikhana mushkil hai. Kuch joda nahi gaya.',
  NULL, 'intermediate', 'humility,subtraction,meetings,change'

  UNION ALL SELECT 5, 'friendship', 4,
  'Hot and cold on the same walk', 'एक ही सैर में गरमी और सरदी', 'Ek hi sair mein garmi aur sardi',
  'Two friends walk the same route every week. One of them notices that whether the walk is good has stopped depending on whether the other one praised something he had done. It took four years and he cannot point to when it changed.',
  'दो दोस्त हर हफ़्ते वही रास्ता चलते हैं। उनमें से एक को लगता है कि सैर अच्छी रही या नहीं, यह अब इस पर नहीं टिकता कि दूसरे ने उसके किए किसी काम की तारीफ़ की या नहीं। इसमें चार साल लगे और वह बता नहीं सकता कि यह कब बदला।',
  'Do dost har hafte wahi raasta chalte hain. Unme se ek ko lagta hai ki sair achhi rahi ya nahi, yeh ab is par nahi tikta ki doosre ne uske kiye kisi kaam ki tareef ki ya nahi. Isme chaar saal lage aur woh bata nahi sakta ki yeh kab badla.',
  'Dvandvair vimuktah, loose from the pairs, and this is what it actually looks like — not somebody who stopped enjoying praise, but somebody whose walk is no longer being run by whether it arrived. The verse describes an outcome and gives no method for it, which is honest: four years and he cannot point to the week.',
  'द्वंद्वैर् विमुक्ताः, जोड़ों से ढीले, और असल में यह ऐसा दिखता है — वह आदमी नहीं जिसे तारीफ़ अच्छी लगनी बंद हो गई, बल्कि वह जिसकी सैर अब इस बात से नहीं चलती कि तारीफ़ आई या नहीं। श्लोक नतीजा बताता है और उसका तरीक़ा नहीं देता, जो ईमानदारी है: चार साल, और वह हफ़्ता बता नहीं सकता।',
  'Dvandvair vimuktah, jodon se dheele, aur asal mein yeh aisa dikhta hai — woh aadmi nahi jise tareef achhi lagni band ho gayi, balki woh jiski sair ab is baat se nahi chalti ki tareef aayi ya nahi. Shloka nateeja batata hai aur uska tareeka nahi deta, jo imaandari hai: chaar saal, aur woh hafta bata nahi sakta.',
  'Not somebody who stopped enjoying praise. Somebody whose walk is no longer run by it.',
  'वह नहीं जिसे तारीफ़ अच्छी लगनी बंद हो गई। वह जिसकी सैर अब उससे नहीं चलती।',
  'Woh nahi jise tareef achhi lagni band ho gayi. Woh jiski sair ab usse nahi chalti.',
  NULL, 'intermediate', 'praise,pairs,slow-change,friendship'

  UNION ALL SELECT 7, 'parenting', 1,
  'Eleven at night, the bag still open', 'रात ग्यारह बजे, बैग अब भी खुला', 'Raat gyarah baje, bag ab bhi khula',
  'A father finishes the school bag, the lunch and the form at eleven and sits down. What he says to himself is that he is doing a bad job. What is actually true is that he has been hauling since six in the morning.',
  'एक पिता ग्यारह बजे स्कूल बैग, टिफ़िन और फ़ॉर्म ख़त्म करके बैठता है। वह ख़ुद से कहता है कि वह ठीक से नहीं कर पा रहा। सच यह है कि वह सुबह छह बजे से घसीट रहा है।',
  'Ek pita gyarah baje school bag, tiffin aur form khatam karke baithta hai. Woh khud se kehta hai ki woh theek se nahi kar pa raha. Sach yeh hai ki woh subah chhah baje se ghaseet raha hai.',
  'Karshati is a hauling word, the word for dragging something heavy. That is the verb 15.7 chooses for the fragment, in the same verse that calls it eternal and its own. The sentence he is saying to himself at eleven is harsher than the one the text uses about him, and the text is not making an excuse — it is describing somebody at work.',
  'कर्षति घसीटने का शब्द है, भारी चीज़ खींचने वाला शब्द। 15.7 उसी अंश के लिए यही क्रिया चुनता है, उसी श्लोक में जो उसे सनातन और अपना कहता है। ग्यारह बजे वह अपने बारे में जो वाक्य कह रहा है वह उस वाक्य से सख़्त है जो ग्रंथ उसके बारे में बरतता है, और ग्रंथ बहाना नहीं बना रहा — वह काम में लगे आदमी का वर्णन कर रहा है।',
  'Karshati ghaseetne ka shabd hai, bhaari cheez kheenchne wala shabd. 15.7 usi ansh ke liye yahi kriya chunta hai, usi shloka mein jo use sanatan aur apna kehta hai. Gyarah baje woh apne baare mein jo vakya keh raha hai woh us vakya se sakht hai jo granth uske baare mein baratta hai, aur granth bahana nahi bana raha — woh kaam mein lage aadmi ka varnan kar raha hai.',
  'The text is not making an excuse for him. It is describing somebody at work.',
  'ग्रंथ उसके लिए बहाना नहीं बना रहा। वह काम में लगे आदमी का वर्णन कर रहा है।',
  'Granth uske liye bahana nahi bana raha. Woh kaam mein lage aadmi ka varnan kar raha hai.',
  NULL, 'beginner', 'exhaustion,self-talk,work,night'

  UNION ALL SELECT 7, 'healthcare', 2,
  'The nurse who was told she was a soul', 'वह नर्स जिसे बताया गया कि वह आत्मा है', 'Woh nurse jise bataya gaya ki woh aatma hai',
  'A nurse on her fourth night shift is told by a well-meaning relative that the tiredness is only the body and she is not the body. She smiles and goes back in. Nothing about the fourth night gets easier.',
  'चौथी रात की शिफ़्ट में लगी एक नर्स को एक भले रिश्तेदार बताते हैं कि थकान सिर्फ़ शरीर की है और वह शरीर नहीं है। वह मुस्कुराकर वापस भीतर चली जाती है। चौथी रात में कुछ भी आसान नहीं होता।',
  'Chauthi raat ki shift mein lagi ek nurse ko ek bhale rishtedar batate hain ki thakan sirf sharir ki hai aur woh sharir nahi hai. Woh muskurakar wapas bheetar chali jaati hai. Chauthi raat mein kuch bhi aasan nahi hota.',
  'This is 15.7 used as an exemption, and the second line of the verse takes it back. The fragment is not sitting above the situation, it is in the body doing the pulling. A reading that turns the tiredness into somebody else''s problem has read one line out of two, and the line it skipped is the one with the strenuous verb in it.',
  'यह 15.7 का छूट की तरह इस्तेमाल है, और श्लोक की दूसरी पंक्ति उसे वापस ले लेती है। वह अंश हालात के ऊपर बैठा नहीं है, वह शरीर में खींचने का काम कर रहा है। जो पाठ थकान को किसी और की मुसीबत बना देता है उसने दो में से एक पंक्ति पढ़ी है, और जो छोड़ी वही है जिसमें मेहनत वाली क्रिया है।',
  'Yeh 15.7 ka chhoot ki tarah istemaal hai, aur shloka ki doosri pankti use wapas le leti hai. Woh ansh haalat ke upar baitha nahi hai, woh sharir mein kheenchne ka kaam kar raha hai. Jo paath thakan ko kisi aur ki museebat bana deta hai usne do mein se ek pankti padhi hai, aur jo chhodi wahi hai jisme mehnat wali kriya hai.',
  'A reading that makes the tiredness somebody else''s has read one line out of two.',
  'जो पाठ थकान को किसी और की बना देता है उसने दो में से एक पंक्ति पढ़ी है।',
  'Jo paath thakan ko kisi aur ki bana deta hai usne do mein se ek pankti padhi hai.',
  NULL, 'intermediate', 'misuse,exhaustion,shift-work,comfort'

  UNION ALL SELECT 7, 'ai', 3,
  'The draft the tool did not write', 'वह मसौदा जो औज़ार ने नहीं लिखा', 'Woh masauda jo auzaar ne nahi likha',
  'A writer uses a tool for a first draft and then spends six hours on it. Asked how long the piece took, she says it wrote itself. She is the only person who knows that is not what happened, and she is also the person who feels least entitled to be tired.',
  'एक लेखिका पहले मसौदे के लिए एक औज़ार बरतती है और फिर उस पर छह घंटे लगाती है। पूछे जाने पर कि लेख में कितना वक़्त लगा, वह कहती है कि यह अपने आप लिख गया। यह बात सिर्फ़ वही जानती है कि ऐसा हुआ नहीं, और थकने का हक़ भी सबसे कम उसी को महसूस होता है।',
  'Ek lekhika pehle masaude ke liye ek auzaar barti hai aur phir us par chhah ghante lagati hai. Poochhe jaane par ki lekh mein kitna waqt laga, woh kehti hai ki yeh apne aap likh gaya. Yeh baat sirf wahi jaanti hai ki aisa hua nahi, aur thakne ka haq bhi sabse kam usi ko mehsoos hota hai.',
  'The verse insists on somebody doing the pulling, and this is a modern way of losing that person. What she has done is describe her own six hours as if nobody was there for them. Karshati puts a worker back in the sentence, which is what the verse is for and why its first line and its second line have to be read together.',
  'श्लोक ज़ोर देता है कि खींचने वाला कोई है, और यह उस आदमी को खो देने का आज का तरीक़ा है। उसने अपने छह घंटों का वर्णन ऐसे किया जैसे उनमें कोई मौजूद ही न हो। कर्षति वाक्य में मेहनत करने वाले को वापस रख देता है, श्लोक इसी के लिए है और इसीलिए उसकी पहली और दूसरी पंक्ति साथ पढ़नी पड़ती हैं।',
  'Shloka zor deta hai ki kheenchne wala koi hai, aur yeh us aadmi ko kho dene ka aaj ka tareeka hai. Usne apne chhah ghanton ka varnan aise kiya jaise unme koi maujood hi na ho. Karshati vakya mein mehnat karne wale ko wapas rakh deta hai, shloka isi ke liye hai aur isiliye uski pehli aur doosri pankti saath padhni padti hain.',
  'Karshati puts a worker back in the sentence.',
  'कर्षति वाक्य में मेहनत करने वाले को वापस रख देता है।',
  'Karshati vakya mein mehnat karne wale ko wapas rakh deta hai.',
  NULL, 'intermediate', 'tools,invisible-labour,credit,tiredness'

  UNION ALL SELECT 7, 'military', 4,
  'The kit that weighs what it weighs', 'सामान जिसका वज़न उतना ही है जितना है', 'Saamaan jiska wazan utna hi hai jitna hai',
  'A recruit is told the load is mental. Her sergeant, who has carried it for eleven years, tells her afterwards that the load is thirty-two kilograms and the mental part is what you say to yourself about the thirty-two kilograms.',
  'एक नई भर्ती को बताया जाता है कि बोझ दिमाग़ी है। उसकी सार्जेंट, जो ग्यारह साल से उसे उठाती आई है, बाद में उससे कहती है कि बोझ बत्तीस किलो है और दिमाग़ी हिस्सा वह है जो आप उन बत्तीस किलो के बारे में ख़ुद से कहती हैं।',
  'Ek nayi bharti ko bataya jaata hai ki bojh dimaagi hai. Uski sergeant, jo gyarah saal se use uthati aayi hai, baad mein usse kehti hai ki bojh battis kilo hai aur dimaagi hissa woh hai jo aap un battis kilo ke baare mein khud se kehti hain.',
  'The verse does the same division and refuses to collapse it. The fragment is eternal and it is also hauling. Neither half cancels the other. What 15.7 will not allow is the version where the weight is declared unreal, and what it also will not allow is the version where somebody carrying it is nothing but the weight.',
  'श्लोक यही बँटवारा करता है और उसे मिटने नहीं देता। अंश सनातन है और वह घसीट भी रहा है। कोई आधा दूसरे को रद्द नहीं करता। 15.7 उस रूप को नहीं मानता जिसमें वज़न को अवास्तविक कह दिया जाए, और उस रूप को भी नहीं जिसमें उसे उठाने वाला वज़न के सिवा कुछ न हो।',
  'Shloka yahi bantwara karta hai aur use mitne nahi deta. Ansh sanatan hai aur woh ghaseet bhi raha hai. Koi aadha doosre ko radd nahi karta. 15.7 us roop ko nahi maanta jisme wazan ko avastavik keh diya jaaye, aur us roop ko bhi nahi jisme use uthane wala wazan ke siva kuch na ho.',
  'The load is thirty-two kilograms. Neither half of the verse cancels the other.',
  'बोझ बत्तीस किलो है। श्लोक का कोई आधा दूसरे को रद्द नहीं करता।',
  'Bojh battis kilo hai. Shloka ka koi aadha doosre ko radd nahi karta.',
  NULL, 'intermediate', 'weight,self-talk,honesty,carrying'

  UNION ALL SELECT 9, 'cricket', 1,
  'The batter who stopped fighting his eyes', 'वह बल्लेबाज़ जिसने अपनी आँखों से लड़ना बंद किया', 'Woh ballebaaz jisne apni aankhon se ladna band kiya',
  'A club batter is coached to blank out the crowd, the noise, the fielders, everything. He gets worse. A different coach tells him to watch the ball and let the rest be there. He gets better, and nothing was shut down.',
  'एक क्लब बल्लेबाज़ को सिखाया जाता है कि भीड़, शोर, फ़ील्डर, सब कुछ दिमाग़ से मिटा दे। उसका खेल बिगड़ता है। दूसरा कोच कहता है कि गेंद देखो और बाक़ी को रहने दो। उसका खेल सुधरता है, और कुछ भी बंद नहीं किया गया।',
  'Ek club ballebaaz ko sikhaya jaata hai ki bheed, shor, fielder, sab kuch dimaag se mita de. Uska khel bigadta hai. Doosra coach kehta hai ki gend dekho aur baaki ko rehne do. Uska khel sudharta hai, aur kuch bhi band nahi kiya gaya.',
  'Adhishthaya is a presiding word, not a fighting word — the sense is of somebody seated at the head of a table rather than at war with the guests. The second coach is closer to the verse than the first. Chapter 15 nowhere asks anybody to stop hearing or stop seeing; it describes a life being lived through five doors and a mind, using a neutral verb.',
  'अधिष्ठाय सिरहाने बैठने का शब्द है, लड़ने का नहीं — भाव यह है कि कोई मेज़ के सिरे पर बैठा है, मेहमानों से लड़ नहीं रहा। दूसरा कोच पहले से श्लोक के ज़्यादा क़रीब है। पंद्रहवाँ अध्याय कहीं किसी से सुनना या देखना बंद करने को नहीं कहता; वह पाँच दरवाज़ों और एक मन से जी जाती ज़िंदगी का वर्णन करता है, एक तटस्थ क्रिया से।',
  'Adhishthaya sirhane baithne ka shabd hai, ladne ka nahi — bhaav yeh hai ki koi mez ke sire par baitha hai, mehmanon se lad nahi raha. Doosra coach pehle se shloka ke zyada kareeb hai. Pandrahvan adhyay kahin kisi se sunna ya dekhna band karne ko nahi kehta; woh paanch darwazon aur ek man se ji jaati zindagi ka varnan karta hai, ek tatasth kriya se.',
  'Presiding is not fighting. Nothing was shut down.',
  'सिरहाने बैठना लड़ना नहीं है। कुछ भी बंद नहीं किया गया।',
  'Sirhane baithna ladna nahi hai. Kuch bhi band nahi kiya gaya.',
  NULL, 'beginner', 'attention,senses,coaching,neutral'

  UNION ALL SELECT 9, 'marriage', 2,
  'Tea, tasted', 'चाय, चखी हुई', 'Chai, chakhi hui',
  'Two people have had tea together every morning for nineteen years and neither can describe how it tastes. One morning one of them puts the phone face down and drinks it. It is the same tea. She mentions it and he laughs, and then the next morning he does it too.',
  'दो लोग उन्नीस साल से हर सुबह साथ चाय पीते आए हैं और दोनों में से कोई नहीं बता सकता कि उसका स्वाद कैसा है। एक सुबह उनमें से एक फ़ोन उल्टा रखकर चाय पीती है। चाय वही है। वह इसका ज़िक्र करती है और वह हँसता है, और अगली सुबह वह भी वैसा ही करता है।',
  'Do log unnees saal se har subah saath chai peete aaye hain aur dono mein se koi nahi bata sakta ki uska swaad kaisa hai. Ek subah unme se ek phone ulta rakhkar chai peeti hai. Chai wahi hai. Woh iska zikr karti hai aur woh hansta hai, aur agli subah woh bhi waisa hi karta hai.',
  'Upasevate — it goes towards them, it uses them, it takes them in. The verse gives the senses a verb that has no complaint in it. Nineteen years of tea nobody tasted is not a moral failure and the verse does not call it one; it is simply what happens when the presiding is absent and the doors are open anyway.',
  'उपसेवते — वह उनकी ओर जाता है, उन्हें बरतता है, उन्हें भीतर लेता है। श्लोक इंद्रियों को ऐसी क्रिया देता है जिसमें कोई शिकायत नहीं है। उन्नीस साल की वह चाय जो किसी ने चखी नहीं, कोई नैतिक चूक नहीं है और श्लोक उसे ऐसा कहता भी नहीं; वह बस वही है जो तब होता है जब सिरहाने कोई नहीं बैठा और दरवाज़े फिर भी खुले हैं।',
  'Upasevate — woh unki or jaata hai, unhe baratta hai, unhe bheetar leta hai. Shloka indriyon ko aisi kriya deta hai jisme koi shikayat nahi hai. Unnees saal ki woh chai jo kisi ne chakhi nahi, koi naitik chook nahi hai aur shloka use aisa kehta bhi nahi; woh bas wahi hai jo tab hota hai jab sirhane koi nahi baitha aur darwaze phir bhi khule hain.',
  'The verse gives the senses a verb with no complaint in it.',
  'श्लोक इंद्रियों को ऐसी क्रिया देता है जिसमें शिकायत नहीं है।',
  'Shloka indriyon ko aisi kriya deta hai jisme shikayat nahi hai.',
  NULL, 'beginner', 'attention,ordinary,together,tasting'

  UNION ALL SELECT 9, 'social_media', 3,
  'The deletion that lasted nine days', 'वह डिलीट जो नौ दिन चला', 'Woh delete jo nau din chala',
  'Somebody deletes every app, declares the senses the problem, and reinstalls on day nine feeling worse than before. What actually changed things, months later, was deciding when he opened them rather than whether.',
  'कोई सारे ऐप हटा देता है, ऐलान करता है कि इंद्रियाँ ही मुसीबत हैं, और नौवें दिन पहले से बुरा महसूस करते हुए फिर से डाल लेता है। महीनों बाद जिस चीज़ ने असल में फ़र्क़ डाला वह यह तय करना था कि वह उन्हें कब खोलता है, यह नहीं कि खोलता है या नहीं।',
  'Koi saare app hata deta hai, elaan karta hai ki indriyan hi museebat hain, aur nauven din pehle se bura mehsoos karte hue phir se daal leta hai. Mahinon baad jis cheez ne asal mein farq daala woh yeh tay karna tha ki woh unhe kab kholta hai, yeh nahi ki kholta hai ya nahi.',
  'Declaring the senses the enemy is not what this verse does, and the nine days are the usual result of doing it. Adhishthaya is presiding — deciding when, from the head of the table. The verse leaves the guests at the table. It only asks who is sitting at the head of it.',
  'इंद्रियों को दुश्मन घोषित करना वह नहीं है जो यह श्लोक करता है, और नौ दिन उसी का आम नतीजा हैं। अधिष्ठाय यानी सिरहाने बैठना — मेज़ के सिरे से यह तय करना कि कब। श्लोक मेहमानों को मेज़ पर ही रहने देता है। वह सिर्फ़ यह पूछता है कि सिरे पर बैठा कौन है।',
  'Indriyon ko dushman ghoshit karna woh nahi hai jo yeh shloka karta hai, aur nau din usi ka aam nateeja hain. Adhishthaya yani sirhane baithna — mez ke sire se yeh tay karna ki kab. Shloka mehmanon ko mez par hi rehne deta hai. Woh sirf yeh poochhta hai ki sire par baitha kaun hai.',
  'The verse leaves the guests at the table. It asks who is at the head of it.',
  'श्लोक मेहमानों को मेज़ पर रहने देता है। वह पूछता है कि सिरे पर कौन है।',
  'Shloka mehmanon ko mez par rehne deta hai. Woh poochhta hai ki sire par kaun hai.',
  NULL, 'intermediate', 'abstinence,attention,timing,relapse'

  UNION ALL SELECT 9, 'everyday_life', 4,
  'Sixty seconds of one sound', 'एक आवाज़ के साठ सेकंड', 'Ek awaaz ke saath second',
  'On a bad afternoon somebody listens to one sound all the way through — a fan, a road, a kettle — for a minute. Nothing is fixed and no insight arrives. The afternoon is still bad and it is slightly less loud inside.',
  'किसी बुरी दोपहर में कोई एक आवाज़ को पूरा सुनता है — पंखा, सड़क, केतली — एक मिनट के लिए। कुछ ठीक नहीं होता और कोई अंतर्दृष्टि नहीं आती। दोपहर अब भी बुरी है और भीतर का शोर ज़रा कम है।',
  'Kisi buri dopahar mein koi ek awaaz ko poora sunta hai — pankha, sadak, ketli — ek minute ke liye. Kuch theek nahi hota aur koi antardrishti nahi aati. Dopahar ab bhi buri hai aur bheetar ka shor zara kam hai.',
  'That is the whole of what the verse supports and it is deliberately not more. Five doors and a mind, and something presiding over them. No claim is made here that a minute of listening resolves anything, and the chapter is better read when it is not asked to promise more than its verbs do.',
  'श्लोक इतने का ही समर्थन करता है और जानबूझकर इससे ज़्यादा का नहीं। पाँच दरवाज़े और एक मन, और उनके सिरहाने बैठा कुछ। यहाँ यह दावा नहीं है कि एक मिनट सुनने से कुछ सुलझ जाता है, और अध्याय तब बेहतर पढ़ा जाता है जब उससे उसकी क्रियाओं से ज़्यादा का वादा न माँगा जाए।',
  'Shloka itne ka hi samarthan karta hai aur jaanboojhkar isse zyada ka nahi. Paanch darwaze aur ek man, aur unke sirhane baitha kuch. Yahan yeh dawa nahi hai ki ek minute sunne se kuch sulajh jaata hai, aur adhyay tab behtar padha jaata hai jab usse uski kriyaon se zyada ka waada na maanga jaaye.',
  'No claim is made that a minute of listening resolves anything.',
  'यह दावा नहीं है कि एक मिनट सुनने से कुछ सुलझ जाता है।',
  'Yeh dawa nahi hai ki ek minute sunne se kuch sulajh jaata hai.',
  NULL, 'beginner', 'small,attention,honest-scope,bad-days'

  UNION ALL SELECT 10, 'school', 1,
  'The child who could not be told', 'वह बच्चा जिसे बताया नहीं जा सकता था', 'Woh bachcha jise bataya nahi ja sakta tha',
  'A boy is told forty times that the water level rises because the stone takes up room. He repeats it correctly in the test. In March he drops a stone in a bucket himself and looks up with an expression nobody has seen on him before.',
  'एक लड़के को चालीस बार बताया जाता है कि पानी का स्तर इसलिए बढ़ता है कि पत्थर जगह घेरता है। वह परीक्षा में इसे सही-सही दोहरा देता है। मार्च में वह ख़ुद एक बाल्टी में पत्थर डालता है और ऐसे चेहरे के साथ ऊपर देखता है जो उस पर पहले किसी ने नहीं देखा।',
  'Ek ladke ko chalis baar bataya jaata hai ki paani ka star isliye badhta hai ki patthar jagah gherta hai. Woh pariksha mein ise sahi-sahi dohra deta hai. March mein woh khud ek balti mein patthar daalta hai aur aise chehre ke saath upar dekhta hai jo us par pehle kisi ne nahi dekha.',
  'Jnana-chakshus is an eye for it, not a belief about it. The forty tellings were not wasted and the verse does not say they were, but they were a different thing from the bucket. Nothing in chapter 15 can be settled by agreeing with it, which is why the verse names a faculty rather than a doctrine.',
  'ज्ञान-चक्षु उसके लिए आँख है, उसके बारे में मान्यता नहीं। चालीस बार बताना बेकार नहीं गया और श्लोक ऐसा कहता भी नहीं, लेकिन वह बाल्टी से अलग चीज़ थी। पंद्रहवें अध्याय में कुछ भी सहमत हो जाने से तय नहीं होता, इसीलिए श्लोक किसी सिद्धांत का नहीं, एक क्षमता का नाम लेता है।',
  'Gyan-chakshu uske liye aankh hai, uske baare mein manyata nahi. Chalis baar batana bekaar nahi gaya aur shloka aisa kehta bhi nahi, lekin woh balti se alag cheez thi. Pandrahven adhyay mein kuch bhi sehmat ho jaane se tay nahi hota, isiliye shloka kisi siddhant ka nahi, ek kshamata ka naam leta hai.',
  'The forty tellings were not wasted. They were a different thing from the bucket.',
  'चालीस बार बताना बेकार नहीं गया। वह बाल्टी से अलग चीज़ थी।',
  'Chalis baar batana bekaar nahi gaya. Woh balti se alag cheez thi.',
  NULL, 'beginner', 'learning,seeing,teaching,difference'

  UNION ALL SELECT 10, 'technology', 2,
  'The bug everybody had read about', 'वह बग जिसके बारे में सबने पढ़ रखा था', 'Woh bug jiske baare mein sabne padh rakha tha',
  'A team has read the post about the race condition and can all describe it. It takes eight months and one outage before anybody actually sees it in their own logs, and the person who does is not the one who had read the most.',
  'एक टीम ने रेस कंडीशन वाला लेख पढ़ रखा है और सब उसे बता सकते हैं। अपने ही लॉग में उसे सचमुच देखने में आठ महीने और एक आउटेज लगते हैं, और जो देखता है वह वह नहीं है जिसने सबसे ज़्यादा पढ़ा था।',
  'Ek team ne race condition wala lekh padh rakha hai aur sab use bata sakte hain. Apne hi log mein use sachmuch dekhne mein aath mahine aur ek outage lagte hain, aur jo dekhta hai woh woh nahi hai jisne sabse zyada padha tha.',
  'The line in this verse is not between the informed and the ignorant. It is between somebody who has looked and somebody who has read about looking, and the second group in this story contained the most well-read person on the team. That is why vimudha is a condition rather than an insult: it is not about how much anybody knows.',
  'इस श्लोक की रेखा जानकार और अनजान के बीच नहीं है। वह उस आदमी के बीच है जिसने देखा और उसके बीच जिसने देखने के बारे में पढ़ा, और इस कहानी में दूसरे समूह में टीम का सबसे ज़्यादा पढ़ा-लिखा आदमी था। इसीलिए विमूढ़ गाली नहीं, हालत है: बात इसकी नहीं कि कौन कितना जानता है।',
  'Is shloka ki rekha jaankar aur anjaan ke beech nahi hai. Woh us aadmi ke beech hai jisne dekha aur uske beech jisne dekhne ke baare mein padha, aur is kahani mein doosre samooh mein team ka sabse zyada padha-likha aadmi tha. Isiliye vimoodh gaali nahi, haalat hai: baat iski nahi ki kaun kitna jaanta hai.',
  'The line is not between the informed and the ignorant.',
  'रेखा जानकार और अनजान के बीच नहीं है।',
  'Rekha jaankar aur anjaan ke beech nahi hai.',
  NULL, 'intermediate', 'seeing,reading,expertise,humility'

  UNION ALL SELECT 10, 'ethics', 3,
  'The policy everybody agreed with', 'वह नीति जिससे सब सहमत थे', 'Woh neeti jisse sab sehmat the',
  'An organisation adopts a strong statement about treating suppliers fairly. Everybody signs it. Two years later an audit finds the payment terms unchanged, and not one person involved remembers deciding to ignore the statement.',
  'एक संस्था आपूर्तिकर्ताओं के साथ न्यायसंगत व्यवहार पर एक मज़बूत घोषणा अपनाती है। सब उस पर दस्तख़त करते हैं। दो साल बाद एक जाँच में भुगतान की शर्तें ज्यों की त्यों मिलती हैं, और उसमें शामिल एक भी आदमी को याद नहीं कि उसने घोषणा को नज़रअंदाज़ करने का फ़ैसला किया हो।',
  'Ek sanstha aapoortikartaon ke saath nyaysangat vyavhar par ek mazboot ghoshna apnati hai. Sab us par dastkhat karte hain. Do saal baad ek jaanch mein bhugtaan ki shartein jyon ki tyon milti hain, aur usme shaamil ek bhi aadmi ko yaad nahi ki usne ghoshna ko nazarandaz karne ka faisla kiya ho.',
  'A person can hold every proposition in a document and be exactly where they started. The verse says this without scorn, which matters — nobody here is a villain and the audit found no decision to point at. That is what agreeing without seeing produces, and the verse names an eye precisely because signatures do not do the work.',
  'आदमी किसी दस्तावेज़ की हर बात मान सकता है और ठीक वहीं खड़ा रह सकता है जहाँ से चला था। श्लोक यह बिना तंज़ के कहता है, और यह मायने रखता है — यहाँ कोई खलनायक नहीं है और जाँच को दिखाने लायक़ कोई फ़ैसला मिला भी नहीं। बिना देखे सहमत होने से यही निकलता है, और श्लोक आँख का नाम इसीलिए लेता है कि दस्तख़त वह काम नहीं करते।',
  'Aadmi kisi dastavez ki har baat maan sakta hai aur theek wahin khada reh sakta hai jahan se chala tha. Shloka yeh bina tanz ke kehta hai, aur yeh maayne rakhta hai — yahan koi khalnayak nahi hai aur jaanch ko dikhane layak koi faisla mila bhi nahi. Bina dekhe sehmat hone se yahi nikalta hai, aur shloka aankh ka naam isiliye leta hai ki dastkhat woh kaam nahi karte.',
  'Signatures do not do the work. That is why the verse names an eye.',
  'दस्तख़त वह काम नहीं करते। इसीलिए श्लोक आँख का नाम लेता है।',
  'Dastkhat woh kaam nahi karte. Isiliye shloka aankh ka naam leta hai.',
  NULL, 'intermediate', 'agreement,practice,policy,seeing'

  UNION ALL SELECT 10, 'healthcare', 4,
  'The consultant who sat down', 'वह डॉक्टर जो बैठ गया', 'Woh doctor jo baith gaya',
  'A consultant has been taught, in three separate courses, that sitting down makes patients feel listened to. He does it for the first time on a Tuesday because his back hurts, and afterwards he cannot stop noticing what the conversation was like.',
  'एक डॉक्टर को तीन अलग-अलग कोर्सों में सिखाया गया है कि बैठ जाने से मरीज़ों को लगता है कि उन्हें सुना जा रहा है। वह पहली बार एक मंगलवार को बैठता है क्योंकि उसकी पीठ में दर्द है, और उसके बाद वह यह देखना बंद नहीं कर पाता कि बातचीत कैसी थी।',
  'Ek doctor ko teen alag-alag courson mein sikhaya gaya hai ki baith jaane se marizon ko lagta hai ki unhe suna ja raha hai. Woh pehli baar ek mangalwar ko baithta hai kyunki uski peeth mein dard hai, aur uske baad woh yeh dekhna band nahi kar paata ki baatcheet kaisi thi.',
  'Three courses is a belief about it. Tuesday is an eye for it. The verse does not rank the two people or say the courses were worthless; it says only that some see and some do not, and it names the faculty rather than the syllabus. Nothing in it suggests the seeing arrives by trying harder to agree.',
  'तीन कोर्स उसके बारे में मान्यता है। मंगलवार उसके लिए आँख है। श्लोक दोनों में से किसी को ऊपर-नीचे नहीं रखता और यह नहीं कहता कि कोर्स बेकार थे; वह इतना कहता है कि कोई देखता है और कोई नहीं, और वह पाठ्यक्रम का नहीं, क्षमता का नाम लेता है। उसमें कहीं यह इशारा नहीं है कि देखना और ज़ोर से सहमत होने से आ जाता है।',
  'Teen course uske baare mein manyata hai. Mangalwar uske liye aankh hai. Shloka dono mein se kisi ko upar-neeche nahi rakhta aur yeh nahi kehta ki course bekaar the; woh itna kehta hai ki koi dekhta hai aur koi nahi, aur woh paathyakram ka nahi, kshamata ka naam leta hai. Usme kahin yeh ishara nahi hai ki dekhna aur zor se sehmat hone se aa jaata hai.',
  'Three courses is a belief about it. Tuesday is an eye for it.',
  'तीन कोर्स उसके बारे में मान्यता हैं। मंगलवार उसके लिए आँख है।',
  'Teen course uske baare mein manyata hain. Mangalwar uske liye aankh hai.',
  NULL, 'intermediate', 'training,seeing,practice,accident'

  UNION ALL SELECT 15, 'school', 1,
  'The name that would not come', 'वह नाम जो आया ही नहीं', 'Woh naam jo aaya hi nahi',
  'A teacher of thirty-one years loses a pupil''s name in front of the class. She has known the child for two years. That evening she tells her husband she is going, and he asks whether she has ever lost a name before. She has, at twenty-four, and thought nothing of it.',
  'इकतीस साल की एक अध्यापिका पूरी कक्षा के सामने एक बच्चे का नाम भूल जाती है। वह उस बच्चे को दो साल से जानती है। उस शाम वह अपने पति से कहती है कि अब उसका जाने का वक़्त है, और वह पूछते हैं कि क्या पहले कभी उसने कोई नाम भुलाया है। भुलाया है, चौबीस की उम्र में, और तब उसने कुछ सोचा भी नहीं था।',
  'Iktees saal ki ek adhyapika poori kaksha ke saamne ek bachche ka naam bhool jaati hai. Woh us bachche ko do saal se jaanti hai. Us shaam woh apne pati se kehti hai ki ab uska jaane ka waqt hai, aur woh poochhte hain ki kya pehle kabhi usne koi naam bhulaya hai. Bhulaya hai, chaubees ki umr mein, aur tab usne kuch socha bhi nahi tha.',
  'Apohana is on the list with memory and knowledge, in the same clause, from the same source. The verse does not treat the losing as a defect in the person it happens to. What changed between twenty-four and fifty-five was not her memory; it was what she had started deciding a lapse meant about her.',
  'अपोहन स्मृति और ज्ञान के साथ, उसी वाक्य में, उसी जगह से आता है। श्लोक खोने को उस आदमी की ख़राबी नहीं मानता जिसके साथ वह होता है। चौबीस और पचपन के बीच जो बदला वह उसकी याददाश्त नहीं थी; वह यह था कि एक चूक का उसके बारे में क्या मतलब है, यह उसने तय करना शुरू कर दिया था।',
  'Apohan smriti aur gyan ke saath, usi vakya mein, usi jagah se aata hai. Shloka khone ko us aadmi ki kharabi nahi maanta jiske saath woh hota hai. Chaubees aur pachpan ke beech jo badla woh uski yaaddasht nahi thi; woh yeh tha ki ek chook ka uske baare mein kya matlab hai, yeh usne tay karna shuru kar diya tha.',
  'What changed was not her memory. It was what she decided a lapse meant.',
  'बदली उसकी याददाश्त नहीं थी। बदला यह था कि उसने चूक का मतलब क्या तय किया।',
  'Badli uski yaaddasht nahi thi. Badla yeh tha ki usne chook ka matlab kya tay kiya.',
  NULL, 'beginner', 'forgetting,kindness,age,meaning'

  UNION ALL SELECT 15, 'corporate', 2,
  'Blank in a room she had prepared for', 'उस कमरे में ख़ाली जिसके लिए उसने तैयारी की थी', 'Us kamre mein khaali jiske liye usne taiyari ki thi',
  'She has prepared for eleven days. Four minutes in, a figure she knows perfectly will not come. She says she will follow up, finishes, and spends the next fortnight replaying four minutes out of forty.',
  'उसने ग्यारह दिन तैयारी की है। चार मिनट में ही एक आँकड़ा, जो उसे अच्छी तरह याद है, आता ही नहीं। वह कहती है कि बाद में भेज देगी, बाक़ी पूरा करती है, और अगले पखवाड़े चालीस में से वही चार मिनट दोहराती रहती है।',
  'Usne gyarah din taiyari ki hai. Chaar minute mein hi ek aankda, jo use achhi tarah yaad hai, aata hi nahi. Woh kehti hai ki baad mein bhej degi, baaki poora karti hai, aur agle pakhwade chalis mein se wahi chaar minute dohrati rehti hai.',
  'This verse puts the taking away where it puts the having, unhedged and without being asked to. Nothing in it suggests she ought to have been holding on to more. The fortnight of replaying is not something the verse can stop, but it is something the verse disagrees with, in its own voice, in one word most people leave out when they quote it.',
  'यह श्लोक चले जाने को वहीं रखता है जहाँ पाने को रखता है, बिना हिचक के और बिना पूछे गए। उसमें कहीं यह इशारा नहीं है कि उसे इससे ज़्यादा थामे रखना चाहिए था। पखवाड़े भर का दोहराना श्लोक रोक नहीं सकता, लेकिन श्लोक उससे असहमत है, अपनी ही आवाज़ में, उस एक शब्द में जिसे उद्धृत करते वक़्त ज़्यादातर लोग छोड़ देते हैं।',
  'Yeh shloka chale jaane ko wahin rakhta hai jahan paane ko rakhta hai, bina hichak ke aur bina poochhe gaye. Usme kahin yeh ishara nahi hai ki use isse zyada thaame rakhna chahiye tha. Pakhwade bhar ka dohrana shloka rok nahi sakta, lekin shloka usse asehmat hai, apni hi awaaz mein, us ek shabd mein jise uddhrit karte waqt zyadatar log chhod dete hain.',
  'Nothing in the verse suggests she ought to have been holding on to more.',
  'श्लोक में कहीं यह इशारा नहीं कि उसे और ज़्यादा थामे रखना चाहिए था।',
  'Shloka mein kahin yeh ishara nahi ki use aur zyada thaame rakhna chahiye tha.',
  NULL, 'intermediate', 'forgetting,presentation,replaying,self-blame'

  UNION ALL SELECT 15, 'healthcare', 3,
  'What the doctor said about the word she lost', 'डॉक्टर ने उस शब्द के बारे में क्या कहा जो वह खो बैठी', 'Doctor ne us shabd ke baare mein kya kaha jo woh kho baithi',
  'A woman goes in convinced something is wrong because a word went missing mid-sentence at a wedding. The doctor asks a lot of questions, orders nothing, and says at the end that this happens to everybody and that being frightened of it is the part that keeps people awake.',
  'एक औरत यह मानकर जाती है कि कुछ गड़बड़ है, क्योंकि एक शादी में वाक्य के बीच एक शब्द ग़ायब हो गया था। डॉक्टर बहुत सवाल पूछती हैं, कोई जाँच नहीं लिखतीं, और आख़िर में कहती हैं कि यह सबके साथ होता है और इससे डरना ही वह हिस्सा है जो लोगों की नींद उड़ाता है।',
  'Ek aurat yeh maankar jaati hai ki kuch gadbad hai, kyunki ek shaadi mein vakya ke beech ek shabd gayab ho gaya tha. Doctor bahut sawal poochhti hain, koi jaanch nahi likhtin, aur aakhir mein kehti hain ki yeh sabke saath hota hai aur isse darna hi woh hissa hai jo logon ki neend udata hai.',
  'The verse and the doctor arrive at the same place from different directions. Apohana is named as coming from the same source as memory and knowledge — which is a way of saying it belongs to the arrangement rather than marking a fault in the person. Anybody worried about their own memory should of course go and ask somebody qualified, exactly as she did. What the verse can do is take away the extra weight she was carrying in on top of the question.',
  'श्लोक और डॉक्टर अलग-अलग रास्तों से एक ही जगह पहुँचते हैं। अपोहन का नाम उसी जगह से आने वाली चीज़ के तौर पर लिया गया है जहाँ से स्मृति और ज्ञान आते हैं — यह कहने का एक तरीक़ा कि वह इस बंदोबस्त का हिस्सा है, आदमी की ख़राबी का निशान नहीं। जिसे अपनी याददाश्त की फ़िक्र हो उसे बेशक किसी जानकार से पूछना चाहिए, ठीक जैसे उसने किया। श्लोक जो कर सकता है वह उस अतिरिक्त बोझ को हटाना है जो वह सवाल के ऊपर से उठाए ले जा रही थी।',
  'Shloka aur doctor alag-alag raaston se ek hi jagah pahunchte hain. Apohan ka naam usi jagah se aane wali cheez ke taur par liya gaya hai jahan se smriti aur gyan aate hain — yeh kehne ka ek tareeka ki woh is bandobast ka hissa hai, aadmi ki kharabi ka nishan nahi. Jise apni yaaddasht ki fikr ho use beshak kisi jaankar se poochhna chahiye, theek jaise usne kiya. Shloka jo kar sakta hai woh us atirikt bojh ko hatana hai jo woh sawal ke upar se uthaye le ja rahi thi.',
  'It belongs to the arrangement. It does not mark a fault in the person.',
  'वह इस बंदोबस्त का हिस्सा है। वह आदमी की ख़राबी का निशान नहीं है।',
  'Woh is bandobast ka hissa hai. Woh aadmi ki kharabi ka nishan nahi hai.',
  NULL, 'intermediate', 'forgetting,worry,asking,relief'

  UNION ALL SELECT 15, 'everyday_life', 4,
  'The book he read twice', 'वह किताब जो उसने दो बार पढ़ी', 'Woh kitaab jo usne do baar padhi',
  'A man realises halfway through a novel that he has read it before and remembers none of it. His first thought is that there is no point reading anything. His second, an hour later, is that he is enjoying it again.',
  'एक आदमी को उपन्यास के बीच में एहसास होता है कि वह इसे पहले पढ़ चुका है और उसे इसमें से कुछ याद नहीं। उसका पहला ख़याल यह है कि कुछ भी पढ़ने का कोई मतलब नहीं। एक घंटे बाद दूसरा ख़याल यह है कि उसे यह दोबारा अच्छा लग रहा है।',
  'Ek aadmi ko upanyas ke beech mein ehsaas hota hai ki woh ise pehle padh chuka hai aur use isme se kuch yaad nahi. Uska pehla khayal yeh hai ki kuch bhi padhne ka koi matlab nahi. Ek ghante baad doosra khayal yeh hai ki use yeh dobara achha lag raha hai.',
  'Both thoughts are honest and the verse is closer to the second. Apohana sits on a list with memory and knowledge and is given no lower status than either. A chapter that had wanted readers to hold on to more would not have named the letting go in the same breath as the having, and would certainly not have named it as coming from the same place.',
  'दोनों ख़याल ईमानदार हैं और श्लोक दूसरे के ज़्यादा क़रीब है। अपोहन स्मृति और ज्ञान की सूची में बैठता है और उसे इन दोनों से नीचा दर्जा नहीं दिया गया। जो अध्याय चाहता कि पाठक और ज़्यादा थामे रखें, वह छूट जाने का नाम पाने के साथ एक ही साँस में नहीं लेता, और यह तो बिल्कुल नहीं कहता कि वह उसी जगह से आता है।',
  'Dono khayal imaandar hain aur shloka doosre ke zyada kareeb hai. Apohan smriti aur gyan ki soochi mein baithta hai aur use in dono se neecha darja nahi diya gaya. Jo adhyay chahta ki pathak aur zyada thaame rakhein, woh chhoot jaane ka naam paane ke saath ek hi saans mein nahi leta, aur yeh to bilkul nahi kehta ki woh usi jagah se aata hai.',
  'A chapter wanting readers to hold on to more would not have named the letting go in the same breath.',
  'जो अध्याय चाहता कि पाठक और थामें, वह छूटने का नाम एक ही साँस में नहीं लेता।',
  'Jo adhyay chahta ki pathak aur thaamein, woh chhootne ka naam ek hi saans mein nahi leta.',
  NULL, 'beginner', 'forgetting,reading,again,acceptance'

  UNION ALL SELECT 20, 'leadership', 1,
  'The thing that was never actually secret', 'वह चीज़ जो असल में कभी छिपी थी ही नहीं', 'Woh cheez jo asal mein kabhi chhipi thi hi nahi',
  'A new joiner asks in her second week how the pricing is actually decided. Three people say nobody really knows. The fourth explains it in six minutes. Nobody had been keeping it from her; nobody had ever asked.',
  'एक नई कर्मचारी अपने दूसरे हफ़्ते में पूछती है कि क़ीमत असल में तय कैसे होती है। तीन लोग कहते हैं कि किसी को ठीक-ठीक पता नहीं। चौथा छह मिनट में समझा देता है। किसी ने उससे कुछ छिपाया नहीं था; किसी ने कभी पूछा नहीं था।',
  'Ek nayi karmchari apne doosre hafte mein poochhti hai ki keemat asal mein tay kaise hoti hai. Teen log kehte hain ki kisi ko theek-theek pata nahi. Chautha chhah minute mein samjha deta hai. Kisi ne usse kuch chhipaya nahi tha; kisi ne kabhi poochha nahi tha.',
  'Guhyatamam, the most closely held of things, and the whole chapter arrives because somebody was in the conversation and asked. Nothing was withheld on the basis of who Arjuna was. In a book that has been used to keep people out of itself, the closing verse is worth reading carefully: the secrecy in it is the kind that ends the moment a question is put.',
  'गुह्यतमम्, सबसे छिपाकर रखी गई चीज़, और पूरा अध्याय इसलिए आता है कि कोई बातचीत में था और उसने पूछा। अर्जुन कौन था इस आधार पर कुछ रोका नहीं गया। ऐसी किताब में, जिसे लोगों को उसी से बाहर रखने के लिए इस्तेमाल किया गया है, आख़िरी श्लोक ध्यान से पढ़ने लायक़ है: उसमें भेद वह क़िस्म है जो सवाल पूछते ही ख़त्म हो जाता है।',
  'Guhyatamam, sabse chhipakar rakhi gayi cheez, aur poora adhyay isliye aata hai ki koi baatcheet mein tha aur usne poochha. Arjun kaun tha is aadhaar par kuch roka nahi gaya. Aisi kitaab mein, jise logon ko usi se bahar rakhne ke liye istemaal kiya gaya hai, aakhiri shloka dhyan se padhne layak hai: usme bhed woh kism hai jo sawal poochhte hi khatm ho jaata hai.',
  'The secrecy in it is the kind that ends the moment a question is put.',
  'उसमें भेद वह क़िस्म है जो सवाल पूछते ही ख़त्म हो जाता है।',
  'Usme bhed woh kism hai jo sawal poochhte hi khatam ho jaata hai.',
  NULL, 'beginner', 'access,asking,openness,knowledge'

  UNION ALL SELECT 20, 'finance', 2,
  'The debt nobody issued', 'वह क़र्ज़ जो किसी ने दिया नहीं', 'Woh karz jo kisi ne diya nahi',
  'A woman clears the last of what she owes and feels nothing. Sitting with it, she works out that the amount she had been paying down was never the loan; it was a sense that she had cost her parents something by existing, and there is no schedule for that.',
  'एक औरत अपना आख़िरी बकाया चुकाती है और कुछ महसूस नहीं होता। उसके साथ बैठकर वह समझ पाती है कि वह जो रक़म उतार रही थी वह कभी क़र्ज़ थी ही नहीं; वह यह एहसास था कि उसके होने से माँ-बाप पर कुछ पड़ा, और उसकी कोई किश्त-सारणी नहीं होती।',
  'Ek aurat apna aakhiri bakaya chukati hai aur kuch mehsoos nahi hota. Uske saath baithkar woh samajh paati hai ki woh jo rakam utaar rahi thi woh kabhi karz thi hi nahi; woh yeh ehsaas tha ki uske hone se maa-baap par kuch pada, aur uski koi kisht-saarni nahi hoti.',
  'Krita-kritya does not mean a person now has nothing to do. It means the thing that was pulling at them — the sense of a debt that could never be paid down — has stopped being what runs the afternoon. The verse puts that at the end of the chapter rather than at the start, which is the right order: nobody arrives there by being told.',
  'कृतकृत्य का मतलब यह नहीं कि अब आदमी के पास करने को कुछ नहीं। इसका मतलब है कि जो चीज़ उसे खींच रही थी — वह एहसास कि एक क़र्ज़ है जो कभी उतरेगा नहीं — वह अब दोपहर चलाने वाली चीज़ नहीं रही। श्लोक इसे अध्याय के आख़िर में रखता है, शुरू में नहीं, और यही सही क्रम है: वहाँ कोई बताए जाने से नहीं पहुँचता।',
  'Kritakritya ka matlab yeh nahi ki ab aadmi ke paas karne ko kuch nahi. Iska matlab hai ki jo cheez use kheench rahi thi — woh ehsaas ki ek karz hai jo kabhi utrega nahi — woh ab dopahar chalane wali cheez nahi rahi. Shloka ise adhyay ke aakhir mein rakhta hai, shuru mein nahi, aur yahi sahi kram hai: wahan koi bataye jaane se nahi pahunchta.',
  'Krita-kritya is not nothing left to do. It is a debt that was never issued.',
  'कृतकृत्य का मतलब करने को कुछ न बचना नहीं है। वह क़र्ज़ है जो कभी दिया ही नहीं गया।',
  'Kritakritya ka matlab karne ko kuch na bachna nahi hai. Woh karz hai jo kabhi diya hi nahi gaya.',
  NULL, 'intermediate', 'debt,enough,parents,finishing'

  UNION ALL SELECT 20, 'friendship', 3,
  'Twenty verses, and no homework', 'बीस श्लोक, और कोई गृहकार्य नहीं', 'Bees shloka, aur koi grihkarya nahi',
  'Two friends read the chapter together over four evenings. On the fourth, one of them asks what they are supposed to do now. The other looks at the last verse and says it does not appear to ask for anything, and they sit with that for a while, mildly suspicious.',
  'दो दोस्त चार शामों में साथ यह अध्याय पढ़ते हैं। चौथी शाम एक पूछता है कि अब करना क्या है। दूसरा आख़िरी श्लोक देखता है और कहता है कि वह कुछ माँगता नहीं लगता, और वे कुछ देर उसी के साथ बैठे रहते हैं, हल्के शक के साथ।',
  'Do dost chaar shaamon mein saath yeh adhyay padhte hain. Chauthi shaam ek poochhta hai ki ab karna kya hai. Doosra aakhiri shloka dekhta hai aur kehta hai ki woh kuch maangta nahi lagta, aur we kuch der usi ke saath baithe rehte hain, halke shak ke saath.',
  'The suspicion is reasonable and the reading is correct. The chapter is twenty verses long, which is short, and it does not ask anybody to read it again. Whatever else that is, it is unusual for a text with a reputation this large, and it is worth noticing before reaching for something more demanding to do instead.',
  'शक वाजिब है और पाठ सही है। अध्याय बीस श्लोक का है, जो छोटा है, और वह किसी से इसे दोबारा पढ़ने को नहीं कहता। यह जो भी है, इतनी बड़ी शोहरत वाले ग्रंथ के लिए असामान्य है, और इसे नोट कर लेना काम का है — इससे पहले कि आदमी करने के लिए कुछ ज़्यादा माँग वाली चीज़ की तरफ़ हाथ बढ़ाए।',
  'Shak wajib hai aur paath sahi hai. Adhyay bees shloka ka hai, jo chhota hai, aur woh kisi se ise dobara padhne ko nahi kehta. Yeh jo bhi hai, itni badi shohrat wale granth ke liye asamanya hai, aur ise note kar lena kaam ka hai — isse pehle ki aadmi karne ke liye kuch zyada maang wali cheez ki taraf haath badhaye.',
  'It does not ask anybody to read it again.',
  'वह किसी से इसे दोबारा पढ़ने को नहीं कहता।',
  'Woh kisi se ise dobara padhne ko nahi kehta.',
  NULL, 'beginner', 'reading,together,no-demand,ending'

  UNION ALL SELECT 20, 'college', 4,
  'The last day of a course nobody had to take', 'उस कोर्स का आख़िरी दिन जो किसी को लेना ज़रूरी नहीं था', 'Us course ka aakhiri din jo kisi ko lena zaroori nahi tha',
  'An optional evening course ends with the tutor saying she has now told them everything she knows about the subject, and that it took eleven weeks and was not hidden from anybody. One student says afterwards that he had assumed there was a further level.',
  'एक वैकल्पिक शाम का कोर्स इस बात पर ख़त्म होता है कि शिक्षिका कहती हैं कि उन्होंने विषय के बारे में जो कुछ वे जानती हैं सब बता दिया, और इसमें ग्यारह हफ़्ते लगे और यह किसी से छिपा हुआ नहीं था। एक छात्र बाद में कहता है कि उसे लगता था इसके आगे भी कोई स्तर होगा।',
  'Ek vaikalpik shaam ka course is baat par khatam hota hai ki shikshika kehti hain ki unhone vishay ke baare mein jo kuch we jaanti hain sab bata diya, aur isme gyarah hafte lage aur yeh kisi se chhipa hua nahi tha. Ek chhatra baad mein kehta hai ki use lagta tha iske aage bhi koi star hoga.',
  'The assumption that there is a further level is exactly what guhyatamam gets used to feed, and the verse does the opposite of feeding it. The most closely held thing there is has just been said out loud, in twenty verses, to whoever was in the room. Believing there must be more behind it is a belief about the chapter, not something the chapter says.',
  'यह मान लेना कि आगे कोई और स्तर है, ठीक वही है जिसे गुह्यतमम् से खुराक मिलती है, और श्लोक उसे खुराक देने का उल्टा करता है। सबसे छिपाकर रखी गई चीज़ अभी-अभी ज़ोर से, बीस श्लोक में, कमरे में मौजूद हर किसी से कह दी गई। यह मानना कि इसके पीछे और कुछ ज़रूर होगा, अध्याय के बारे में एक मान्यता है, ऐसी बात नहीं जो अध्याय कहता हो।',
  'Yeh maan lena ki aage koi aur star hai, theek wahi hai jise guhyatamam se khuraak milti hai, aur shloka use khuraak dene ka ulta karta hai. Sabse chhipakar rakhi gayi cheez abhi-abhi zor se, bees shloka mein, kamre mein maujood har kisi se keh di gayi. Yeh maanna ki iske peechhe aur kuch zaroor hoga, adhyay ke baare mein ek manyata hai, aisi baat nahi jo adhyay kehta ho.',
  'Believing there must be more behind it is a belief about the chapter.',
  'यह मानना कि इसके पीछे और कुछ है, अध्याय के बारे में एक मान्यता है।',
  'Yeh maanna ki iske peechhe aur kuch hai, adhyay ke baare mein ek manyata hai.',
  NULL, 'intermediate', 'expectation,openness,levels,ending'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 15;

-- =====================================================================
-- 5. CROSS REFERENCES
-- =====================================================================
-- FIFTEEN DECLARED. Every target checked against the seeded verse list
-- first. Count the loaded rows against fifteen before shipping.
--
-- Chapters 7, 8, 9, 10 and 11 have no seeded verses yet, so nothing in
-- this file can link to them. That is a gap and not a judgement — 15.7
-- in particular belongs next to 7.5 once chapter 7 exists.
--
-- 15.15 -> 2.63 is the one marked opposite, and it is deliberate.
-- 2.63 describes memory collapsing inside a chain that starts with
-- anger. A reader who meets apohana and then remembers 2.63 could
-- easily conclude the text blames them for forgetting. It does not,
-- and the two verses are describing different things. The cross
-- reference exists to say so where the reader will meet it.
-- =====================================================================

DELETE x FROM verse_cross_references x JOIN verses v ON v.id = x.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 15;

INSERT INTO verse_cross_references
  (verse_id, reference_type, book, chapter, verse, target_verse_id,
   description_en, description_hi, description_hinglish, relationship, sort_order)
SELECT v.id, 'gita', 'Bhagavad Gita', CAST(x.tch AS CHAR), CAST(x.tvn AS CHAR), tv.id,
       x.d_en, x.d_hi, x.d_hing, x.rel, x.ord
FROM (
  SELECT 1 AS vn, 3 AS tch, 5 AS tvn, 1 AS ord,
    'Nobody stands still even for a moment; everybody is carried along by what they are made of. 3.5 says you are already inside something running, and 15.1 draws the picture of it.' AS d_en,
    'कोई एक पल भी ठहरा नहीं रहता; हर कोई अपनी बनावट से चलाया जाता है। 3.5 कहता है कि आप पहले से किसी चलती हुई चीज़ के भीतर हैं, और 15.1 उसकी तस्वीर खींचता है।' AS d_hi,
    'Koi ek pal bhi thehra nahi rehta; har koi apni banawat se chalaya jaata hai. 3.5 kehta hai ki aap pehle se kisi chalti hui cheez ke bheetar hain, aur 15.1 uski tasveer kheenchta hai.' AS d_hing,
    'supports' AS rel
  UNION ALL SELECT 1, 13, 20, 2,
    'Both verses point at something older than the person standing in it. 13.20 names prakriti as where the doing comes from; 15.1 says the root of it is not visible from where you are.',
    'दोनों श्लोक उस चीज़ की ओर इशारा करते हैं जो उसमें खड़े आदमी से पुरानी है। 13.20 प्रकृति को वह जगह बताता है जहाँ से करना आता है; 15.1 कहता है कि उसकी जड़ जहाँ आप हैं वहाँ से दिखती नहीं।',
    'Dono shloka us cheez ki or ishara karte hain jo usme khade aadmi se purani hai. 13.20 prakriti ko woh jagah batata hai jahan se karna aata hai; 15.1 kehta hai ki uski jad jahan aap hain wahan se dikhti nahi.',
    'supports'
  UNION ALL SELECT 3, 5, 10, 1,
    'The lotus leaf. Same word, sanga, and the leaf never leaves the water — which is what settles what asanga can and cannot be made to mean. Read 5.10 before acting on 15.3.',
    'कमल का पत्ता। वही शब्द, संग, और पत्ता पानी से जाता कभी नहीं — यही तय करता है कि असंग का मतलब क्या बनाया जा सकता है और क्या नहीं। 15.3 पर कुछ करने से पहले 5.10 पढ़िए।',
    'Kamal ka patta. Wahi shabd, sang, aur patta paani se jaata kabhi nahi — yahi tay karta hai ki asang ka matlab kya banaya ja sakta hai aur kya nahi. 15.3 par kuch karne se pehle 5.10 padhiye.',
    'same'
  UNION ALL SELECT 3, 14, 7, 2,
    'Chapter 14 uses sanga for the sticking that comes with rajas. 15.3 asks for a-sanga, the same word negated. The two are one vocabulary and neither of them is about feeling less.',
    'चौदहवाँ अध्याय रजस के साथ आने वाले चिपकने के लिए संग शब्द बरतता है। 15.3 अ-संग माँगता है, वही शब्द नकार के साथ। दोनों एक ही शब्दावली हैं और दोनों में से कोई कम महसूस करने की बात नहीं है।',
    'Chaudahvan adhyay rajas ke saath aane wale chipakne ke liye sang shabd baratta hai. 15.3 a-sang maangta hai, wahi shabd nakaar ke saath. Dono ek hi shabdavali hain aur dono mein se koi kam mehsoos karne ki baat nahi hai.',
    'term'
  UNION ALL SELECT 3, 13, 32, 3,
    'Not stained, says 13.32, which is not the same as not touched and not the same as not felt. That distinction is the one 15.3 needs and does not stop to make for itself.',
    '13.32 कहता है कि कुछ रिसता नहीं, जो न छुआ जाना नहीं है और न महसूस न होना है। यही फ़र्क़ 15.3 को चाहिए और वह रुककर ख़ुद यह नहीं करता।',
    '13.32 kehta hai ki kuch rista nahi, jo na chhua jaana nahi hai aur na mehsoos na hona hai. Yahi farq 15.3 ko chahiye aur woh rukkar khud yeh nahi karta.',
    'supports'
  UNION ALL SELECT 5, 2, 14, 1,
    'Cold and heat, pleasure and pain, arriving and going. 2.14 is the earliest statement of the pairs; 15.5 describes somebody they no longer run, without claiming they stopped arriving.',
    'सरदी और गरमी, सुख और दुख, आते और जाते। 2.14 जोड़ों का सबसे पहला कथन है; 15.5 उस आदमी का वर्णन करता है जिसे वे अब चलाते नहीं, यह दावा किए बिना कि वे आना बंद हो गए।',
    'Sardi aur garmi, sukh aur dukh, aate aur jaate. 2.14 jodon ka sabse pehla kathan hai; 15.5 us aadmi ka varnan karta hai jise we ab chalate nahi, yeh dawa kiye bina ki we aana band ho gaye.',
    'same'
  UNION ALL SELECT 5, 12, 13, 2,
    'Chapter 12 gives its own list of what somebody steady looks like, and it is built the same way: mostly things absent rather than things acquired. Two lists, one grammar.',
    'बारहवाँ अध्याय अपनी सूची देता है कि ठहरा हुआ आदमी कैसा दिखता है, और वह इसी तरह बनी है: ज़्यादातर वे चीज़ें जो नहीं हैं, वे नहीं जो हासिल की गईं। दो सूचियाँ, एक ही बनावट।',
    'Barahvan adhyay apni soochi deta hai ki thehra hua aadmi kaisa dikhta hai, aur woh isi tarah bani hai: zyadatar we cheezein jo nahi hain, we nahi jo haasil ki gayin. Do soochiyan, ek hi banawat.',
    'same'
  UNION ALL SELECT 5, 2, 70, 3,
    'The ocean that takes the rivers and does not rise. 2.70 is what vinivritta-kama looks like from inside: wants still arriving, and nothing being run by their arrival.',
    'वह समुद्र जो नदियों को लेता है और बढ़ता नहीं। 2.70 वही है जो विनिवृत्त-काम भीतर से दिखता है: चाहतें अब भी आ रही हैं, और उनके आने से कुछ चल नहीं रहा।',
    'Woh samudra jo nadiyon ko leta hai aur badhta nahi. 2.70 wahi hai jo vinivritta-kaam bheetar se dikhta hai: chahatein ab bhi aa rahi hain, aur unke aane se kuch chal nahi raha.',
    'supports'
  UNION ALL SELECT 7, 6, 5, 1,
    'Lift yourself by yourself and do not let yourself down. 6.5 and 15.7 are the two places the book is warmest about the person reading it, and both of them keep that person at work.',
    'अपने से अपने को उठाइए और अपने को गिरने मत दीजिए। 6.5 और 15.7 वे दो जगहें हैं जहाँ किताब पढ़ने वाले के प्रति सबसे नरम है, और दोनों उस आदमी को काम में लगा हुआ ही रखती हैं।',
    'Apne se apne ko uthaiye aur apne ko girne mat dijiye. 6.5 aur 15.7 we do jagahein hain jahan kitaab padhne wale ke prati sabse naram hai, aur dono us aadmi ko kaam mein laga hua hi rakhti hain.',
    'supports'
  UNION ALL SELECT 7, 13, 29, 2,
    'And therefore he does not harm himself. If 15.7 says what a person is, 13.29 says what follows from taking that seriously, and it is not an exemption from anything.',
    'और इसीलिए वह अपना नुक़सान नहीं करता। अगर 15.7 बताता है कि आदमी क्या है, तो 13.29 बताता है कि उसे गंभीरता से लेने से क्या निकलता है, और वह किसी चीज़ से छूट नहीं है।',
    'Aur isiliye woh apna nuksaan nahi karta. Agar 15.7 batata hai ki aadmi kya hai, to 13.29 batata hai ki use gambhirta se lene se kya nikalta hai, aur woh kisi cheez se chhoot nahi hai.',
    'supports'
  UNION ALL SELECT 9, 6, 17, 1,
    'Measured in eating, in moving about, in working, in sleeping and waking. 6.17 regulates the senses without once treating them as an enemy, and 15.9 uses a verb with no complaint in it for the same reason.',
    'खाने में, चलने-फिरने में, काम में, सोने और जागने में नाप। 6.17 इंद्रियों को साधता है और उन्हें एक बार भी दुश्मन नहीं बनाता, और 15.9 इसी वजह से ऐसी क्रिया बरतता है जिसमें कोई शिकायत नहीं है।',
    'Khane mein, chalne-firne mein, kaam mein, sone aur jaagne mein naap. 6.17 indriyon ko saadhta hai aur unhe ek baar bhi dushman nahi banata, aur 15.9 isi wajah se aisi kriya baratta hai jisme koi shikayat nahi hai.',
    'supports'
  UNION ALL SELECT 10, 4, 34, 1,
    'Go and ask the ones who have seen it, says 4.34 — tattva-darshinah, seers of the thing. Both verses put the weight on having looked rather than on having been told.',
    '4.34 कहता है कि उनके पास जाकर पूछिए जिन्होंने उसे देखा है — तत्त्वदर्शिनः, चीज़ को देखने वाले। दोनों श्लोक वज़न देखने पर रखते हैं, बताए जाने पर नहीं।',
    '4.34 kehta hai ki unke paas jaakar poochhiye jinhone use dekha hai — tattva-darshinah, cheez ko dekhne wale. Dono shloka wazan dekhne par rakhte hain, bataye jaane par nahi.',
    'supports'
  UNION ALL SELECT 15, 6, 26, 1,
    'Wherever the mind wanders off to, bring it back. 6.26 counts no wanderings and issues no verdict on them; 15.15 does the same for what goes missing. Neither verse is keeping score.',
    'मन जहाँ कहीं भटक जाए, उसे वापस ले आइए। 6.26 भटकनें गिनता नहीं और उन पर कोई फ़ैसला नहीं सुनाता; 15.15 वही उन चीज़ों के लिए करता है जो खो जाती हैं। कोई भी श्लोक हिसाब नहीं रख रहा।',
    'Man jahan kahin bhatak jaaye, use wapas le aaiye. 6.26 bhataknein ginta nahi aur un par koi faisla nahi sunata; 15.15 wahi un cheezon ke liye karta hai jo kho jaati hain. Koi bhi shloka hisaab nahi rakh raha.',
    'supports'
  UNION ALL SELECT 15, 2, 63, 2,
    'Read carefully alongside. 2.63 describes memory going under inside a chain that starts with anger — a specific sequence, in a specific state. It is not a verdict on ordinary forgetting, and 15.15 names apohana with no chain around it and no blame in it at all.',
    'साथ में ध्यान से पढ़िए। 2.63 उस स्मृति का वर्णन करता है जो क्रोध से शुरू होने वाली एक कड़ी के भीतर डूबती है — एक ख़ास क्रम, एक ख़ास हालत में। वह आम भूलने पर फ़ैसला नहीं है, और 15.15 अपोहन का नाम बिना किसी कड़ी के और बिना किसी दोष के लेता है।',
    'Saath mein dhyan se padhiye. 2.63 us smriti ka varnan karta hai jo krodh se shuru hone wali ek kadi ke bheetar doobti hai — ek khaas kram, ek khaas haalat mein. Woh aam bhoolne par faisla nahi hai, aur 15.15 apohan ka naam bina kisi kadi ke aur bina kisi dosh ke leta hai.',
    'opposite'
  UNION ALL SELECT 20, 18, 63, 1,
    'The whole thing has been told you; now reflect fully and do as you choose. 18.63 hands the decision back, and 15.20 says the closely held thing has already been spoken. The two endings work the same way.',
    'सब कुछ आपसे कह दिया गया; अब पूरी तरह विचार कीजिए और जैसा चाहें वैसा कीजिए। 18.63 फ़ैसला वापस थमा देता है, और 15.20 कहता है कि छिपाकर रखी गई चीज़ कही जा चुकी है। दोनों अंत एक ही तरह काम करते हैं।',
    'Sab kuch aapse keh diya gaya; ab poori tarah vichar kijiye aur jaisa chahein waisa kijiye. 18.63 faisla wapas thama deta hai, aur 15.20 kehta hai ki chhipakar rakhi gayi cheez kahi ja chuki hai. Dono ant ek hi tarah kaam karte hain.',
    'same'
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 15
JOIN chapters tc ON tc.chapter_number = x.tch
JOIN verses tv ON tv.chapter_id = tc.id AND tv.verse_number = x.tvn;

-- =====================================================================
-- 6. WORD BY WORD
-- =====================================================================
-- Four glosses carry the chapter's safeguards:
--   asaṅga-śastreṇa (15.3)  the axe is against a tree, and asanga is
--                           the same saṅga as 5.10 and 14.7
--   karṣati (15.7)          the fragment is the one hauling
--   jñāna-cakṣuṣaḥ (15.10)  an eye, not a belief
--   apohanam (15.15)        the taking away, named without blame
-- All glosses stay under 400 characters — the column is varchar(400).
-- THIRTY-TWO rows, four per verse.
-- =====================================================================

DELETE w FROM verse_word_meanings w JOIN verses v ON v.id = w.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 15;

INSERT INTO verse_word_meanings
  (verse_id, word_order, devanagari, transliteration,
   meaning_en, meaning_hi, meaning_hinglish, grammar, root_word)
SELECT v.id, w.ord, w.dev, w.tr, w.m_en, w.m_hi, w.m_hing, w.gram, w.root FROM (

  SELECT 1 AS vn, 1 AS ord, 'ऊर्ध्वमूलम्' AS dev, 'ūrdhva-mūlam' AS tr,
    'having its root above. The whole image turns on this: the beginning of the thing is not where the person looking at it is standing' AS m_en,
    'जिसकी जड़ ऊपर है। पूरी तस्वीर इसी पर घूमती है: चीज़ की शुरुआत वहाँ नहीं है जहाँ उसे देखने वाला खड़ा है' AS m_hi,
    'jiski jad upar hai. Poori tasveer isi par ghoomti hai: cheez ki shuruaat wahan nahi hai jahan use dekhne wala khada hai' AS m_hing,
    'accusative singular, compound' AS gram, 'मूल' AS root
  UNION ALL SELECT 1, 2, 'अधःशाखम्', 'adhaḥ-śākham',
    'with its branches below — the part that hangs down at eye level, which is everything anybody can actually see of it',
    'जिसकी शाखाएँ नीचे हैं — वह हिस्सा जो आँख की ऊँचाई पर लटकता है, और उसका इतना ही किसी को सचमुच दिखता है',
    'jiski shakhayein neeche hain — woh hissa jo aankh ki oonchai par latakta hai, aur uska itna hi kisi ko sachmuch dikhta hai',
    'accusative singular, compound', 'शाखा'
  UNION ALL SELECT 1, 3, 'अश्वत्थम्', 'aśvattham',
    'the peepal tree — an ordinary tree people sat under, not an exotic one. The image borrows something familiar and turns it the wrong way up',
    'पीपल का पेड़ — वही आम पेड़ जिसके नीचे लोग बैठते थे, कोई अनोखा नहीं। तस्वीर एक जानी-पहचानी चीज़ लेती है और उसे उल्टा कर देती है',
    'peepal ka ped — wahi aam ped jiske neeche log baithte the, koi anokha nahi. Tasveer ek jaani-pehchani cheez leti hai aur use ulta kar deti hai',
    'accusative singular', NULL
  UNION ALL SELECT 1, 4, 'अव्ययम्', 'avyayam',
    'not wearing out, not spending itself away. Said of the tree, not of anybody standing in it',
    'जो घिसता नहीं, जो ख़र्च होकर ख़त्म नहीं होता। यह पेड़ के बारे में कहा गया है, उसमें खड़े किसी के बारे में नहीं',
    'jo ghista nahi, jo kharch hokar khatam nahi hota. Yeh ped ke baare mein kaha gaya hai, usme khade kisi ke baare mein nahi',
    'accusative singular', 'वि + अय्'

  UNION ALL SELECT 3, 1, 'रूपम्', 'rūpam',
    'its form, its shape. The verse says the shape is not perceived here — not the end of it, not the beginning, not what it rests on',
    'उसका रूप, उसकी शक्ल। श्लोक कहता है कि यह शक्ल यहाँ दिखाई नहीं देती — न उसका अंत, न शुरुआत, न वह जिस पर वह टिका है',
    'uska roop, uski shakl. Shloka kehta hai ki yeh shakl yahan dikhai nahi deti — na uska ant, na shuruaat, na woh jis par woh tika hai',
    'nominative singular', 'रूप्'
  UNION ALL SELECT 3, 2, 'असङ्गशस्त्रेण', 'asaṅga-śastreṇa',
    'with the weapon of not-sticking. Two things, both in the line: the weapon is pointed at a tree and there is no person anywhere in the image, and asanga is the same sanga as 5.10 and 14.7 — the sticking, not the contact. The lotus leaf stays in the water all day',
    'न चिपकने के हथियार से। दो बातें, दोनों इसी पंक्ति में: हथियार एक पेड़ की ओर है और तस्वीर में कहीं कोई आदमी नहीं है, और असंग वही संग है जो 5.10 और 14.7 में है — चिपकना, छूना नहीं। कमल का पत्ता दिन भर पानी में ही रहता है',
    'na chipakne ke hathiyaar se. Do baatein, dono isi pankti mein: hathiyaar ek ped ki or hai aur tasveer mein kahin koi aadmi nahi hai, aur asang wahi sang hai jo 5.10 aur 14.7 mein hai — chipakna, chhoona nahi. Kamal ka patta din bhar paani mein hi rehta hai',
    'instrumental singular, compound', 'सञ्ज्'
  UNION ALL SELECT 3, 3, 'दृढेन', 'dṛḍhena',
    'firm, well-set. It qualifies the tool and not the person swinging it, and the verse gives no instruction about hardening anybody',
    'मज़बूत, जमा हुआ। यह औज़ार का विशेषण है, उसे चलाने वाले का नहीं, और श्लोक किसी को कड़ा बनाने का निर्देश नहीं देता',
    'mazboot, jama hua. Yeh auzaar ka visheshan hai, use chalane wale ka nahi, aur shloka kisi ko kada banane ka nirdesh nahi deta',
    'instrumental singular', 'दृंह्'
  UNION ALL SELECT 3, 4, 'छित्त्वा', 'chittvā',
    'having cut. A completed action before the next one starts — the verse puts the cutting first and the looking for what lies beyond it second',
    'काटकर। अगली क्रिया शुरू होने से पहले पूरी हुई क्रिया — श्लोक काटने को पहले रखता है और उसके आगे जो है उसे खोजने को बाद में',
    'kaatkar. Agli kriya shuru hone se pehle poori hui kriya — shloka kaatne ko pehle rakhta hai aur uske aage jo hai use khojne ko baad mein',
    'absolutive', 'छिद्'

  UNION ALL SELECT 5, 1, 'निर्मानमोहाः', 'nirmāna-mohāḥ',
    'without the pride of standing and without confusion. Mana here is position, rank, being thought of as somebody. It is an absence, not an achievement',
    'रुतबे के घमंड और उलझन के बिना। यहाँ मान का अर्थ पद, दर्जा, किसी के तौर पर गिना जाना है। यह किसी चीज़ का न होना है, कोई उपलब्धि नहीं',
    'rutbe ke ghamand aur uljhan ke bina. Yahan maan ka arth pad, darja, kisi ke taur par gina jaana hai. Yeh kisi cheez ka na hona hai, koi uplabdhi nahi',
    'nominative plural, compound', 'मन्'
  UNION ALL SELECT 5, 2, 'जितसङ्गदोषाः', 'jita-saṅga-doṣāḥ',
    'having beaten the fault that comes with sticking. Note that the fault is in the sticking, not in the contact — the same distinction 15.3 needs',
    'चिपकने के साथ आने वाले दोष को जीते हुए। ध्यान दीजिए कि दोष चिपकने में है, छूने में नहीं — वही फ़र्क़ जो 15.3 को चाहिए',
    'chipakne ke saath aane wale dosh ko jeete hue. Dhyan dijiye ki dosh chipakne mein hai, chhoone mein nahi — wahi farq jo 15.3 ko chahiye',
    'nominative plural, compound', 'जि'
  UNION ALL SELECT 5, 3, 'विनिवृत्तकामाः', 'vinivṛtta-kāmāḥ',
    'wants turned back. Turned back, not destroyed and not denied. The ocean in 2.70 is the picture of it: the rivers still arrive',
    'चाहतें लौटा दी गईं। लौटाई गईं, मिटाई नहीं गईं और नकारी नहीं गईं। 2.70 का समुद्र इसकी तस्वीर है: नदियाँ अब भी आती हैं',
    'chahatein lauta di gayin. Lautai gayin, mitai nahi gayin aur nakaari nahi gayin. 2.70 ka samudra iski tasveer hai: nadiyan ab bhi aati hain',
    'nominative plural, compound', 'वि + नि + वृत्'
  UNION ALL SELECT 5, 4, 'द्वन्द्वैर्विमुक्ताः', 'dvandvair vimuktāḥ',
    'loose from the pairs — hot and cold, praise and blame. Not somebody who stopped feeling them, but somebody whose day is no longer run by which one it currently is',
    'जोड़ों से ढीले — गरमी और सरदी, तारीफ़ और इलज़ाम। वह आदमी नहीं जिसे ये लगने बंद हो गए, बल्कि वह जिसका दिन अब इस बात से नहीं चलता कि अभी कौन-सा है',
    'jodon se dheele — garmi aur sardi, tareef aur ilzaam. Woh aadmi nahi jise ye lagne band ho gaye, balki woh jiska din ab is baat se nahi chalta ki abhi kaun sa hai',
    'nominative plural', 'वि + मुच्'

  UNION ALL SELECT 7, 1, 'ममैवांशः', 'mamaivāṁśaḥ',
    'a portion of me, and only of me. Amsha is a share or a part — the warmest word the book uses about the person reading it',
    'मेरा ही एक अंश। अंश यानी हिस्सा या भाग — पढ़ने वाले के बारे में किताब का बरता हुआ सबसे नरम शब्द',
    'mera hi ek ansh. Ansh yani hissa ya bhaag — padhne wale ke baare mein kitaab ka barata hua sabse naram shabd',
    'nominative singular', 'अंश'
  UNION ALL SELECT 7, 2, 'सनातनः', 'sanātanaḥ',
    'lasting, from long ago and going on. Said of the fragment. It is not said of the situation the fragment is in, and the second line of the verse makes that difference matter',
    'चिरंतन, बहुत पहले से और आगे तक चलता हुआ। यह अंश के बारे में कहा गया है। उस हालत के बारे में नहीं जिसमें अंश है, और श्लोक की दूसरी पंक्ति इस फ़र्क़ को मायने देती है',
    'chirantan, bahut pehle se aur aage tak chalta hua. Yeh ansh ke baare mein kaha gaya hai. Us haalat ke baare mein nahi jisme ansh hai, aur shloka ki doosri pankti is farq ko maayne deti hai',
    'nominative singular', NULL
  UNION ALL SELECT 7, 3, 'प्रकृतिस्थानि', 'prakṛti-sthāni',
    'seated in prakriti — said of the senses and the mind. They are where they are, and the verse does not ask anybody to move them',
    'प्रकृति में टिकी हुईं — यह इंद्रियों और मन के बारे में है। वे जहाँ हैं वहीं हैं, और श्लोक किसी से उन्हें हटाने को नहीं कहता',
    'prakriti mein tiki huin — yeh indriyon aur man ke baare mein hai. We jahan hain wahin hain, aur shloka kisi se unhe hatane ko nahi kehta',
    'accusative plural, compound', 'स्था'
  UNION ALL SELECT 7, 4, 'कर्षति', 'karṣati',
    'draws, drags, hauls — the word for pulling something heavy across ground. THE FRAGMENT IS THE SUBJECT. It is not sitting above the situation; it is down in it, doing the pulling, and that is what stops the first line becoming a permission slip',
    'खींचता है, घसीटता है — भारी चीज़ को ज़मीन पर खींचने का शब्द। कर्ता अंश ही है। वह हालात के ऊपर बैठा नहीं है; वह उसी के भीतर है, खींच रहा है, और यही पहली पंक्ति को छूट का परचा बनने से रोकता है',
    'kheenchta hai, ghaseetta hai — bhaari cheez ko zameen par kheenchne ka shabd. Karta ansh hi hai. Woh haalat ke upar baitha nahi hai; woh usi ke bheetar hai, kheench raha hai, aur yahi pehli pankti ko chhoot ka parcha banne se rokta hai',
    'present, third singular', 'कृष्'

  UNION ALL SELECT 9, 1, 'अधिष्ठाय', 'adhiṣṭhāya',
    'presiding over, standing at the head of. A seating word, not a fighting word — the sense is of somebody at the head of a table rather than at war with the guests',
    'सिरहाने बैठकर, सिरे पर खड़े होकर। यह बैठने का शब्द है, लड़ने का नहीं — भाव यह है कि कोई मेज़ के सिरे पर है, मेहमानों से लड़ नहीं रहा',
    'sirhane baithkar, sire par khade hokar. Yeh baithne ka shabd hai, ladne ka nahi — bhaav yeh hai ki koi mez ke sire par hai, mehmanon se lad nahi raha',
    'absolutive', 'अधि + स्था'
  UNION ALL SELECT 9, 2, 'श्रोत्रं चक्षुः', 'śrotraṁ cakṣuḥ',
    'hearing and seeing — the first two of the five doors the verse lists, named plainly and with nothing said against them',
    'सुनना और देखना — श्लोक जिन पाँच दरवाज़ों को गिनाता है उनमें से पहले दो, सीधे-सीधे नाम लिए गए और उनके ख़िलाफ़ कुछ कहे बिना',
    'sunna aur dekhna — shloka jin paanch darwazon ko ginata hai unme se pehle do, seedhe-seedhe naam liye gaye aur unke khilaf kuch kahe bina',
    'nominative singular', NULL
  UNION ALL SELECT 9, 3, 'विषयान्', 'viṣayān',
    'the objects of sense — what there is to be heard, seen, tasted. A neutral word here; the chapter attaches no verdict to it',
    'इंद्रियों के विषय — जो सुना, देखा, चखा जाना है। यहाँ यह तटस्थ शब्द है; अध्याय इस पर कोई फ़ैसला नहीं चिपकाता',
    'indriyon ke vishay — jo suna, dekha, chakha jaana hai. Yahan yeh tatasth shabd hai; adhyay is par koi faisla nahi chipkata',
    'accusative plural', NULL
  UNION ALL SELECT 9, 4, 'उपसेवते', 'upasevate',
    'attends to, goes towards, takes in. There is no complaint in the verb. Nothing in chapter 15 asks anybody to stop hearing or stop tasting',
    'सेवन करता है, उनकी ओर जाता है, भीतर लेता है। क्रिया में कोई शिकायत नहीं है। पंद्रहवाँ अध्याय किसी से सुनना या चखना बंद करने को नहीं कहता',
    'sevan karta hai, unki or jaata hai, bheetar leta hai. Kriya mein koi shikayat nahi hai. Pandrahvan adhyay kisi se sunna ya chakhna band karne ko nahi kehta',
    'present, third singular', 'उप + सेव्'

  UNION ALL SELECT 10, 1, 'उत्क्रामन्तम्', 'utkrāmantam',
    'going out, departing. One of three states the verse lists — going, staying, taking things in — and it treats all three the same way',
    'निकलते हुए, जाते हुए। श्लोक जिन तीन हालतों को गिनाता है उनमें से एक — जाना, ठहरना, भीतर लेना — और वह तीनों को एक ही तरह बरतता है',
    'nikalte hue, jaate hue. Shloka jin teen haalaton ko ginata hai unme se ek — jaana, thehrna, bheetar lena — aur woh teenon ko ek hi tarah baratta hai',
    'present participle, accusative', 'उत् + क्रम्'
  UNION ALL SELECT 10, 2, 'विमूढाः', 'vimūḍhāḥ',
    'confused, thrown off. A condition and not an insult — everybody in this book is in it somewhere, including the man the whole conversation is being had with, who spent all of chapter 1 unable to see what was in front of him',
    'उलझे हुए, चकराए हुए। यह हालत है, गाली नहीं — इस किताब में हर कोई कहीं न कहीं इसमें है, वह आदमी भी जिससे यह पूरी बातचीत हो रही है और जिसने पूरा पहला अध्याय अपने सामने की चीज़ न देख पाने में बिताया',
    'uljhe hue, chakraye hue. Yeh haalat hai, gaali nahi — is kitaab mein har koi kahin na kahin isme hai, woh aadmi bhi jisse yeh poori baatcheet ho rahi hai aur jisne poora pehla adhyay apne saamne ki cheez na dekh paane mein bitaya',
    'nominative plural', 'वि + मुह्'
  UNION ALL SELECT 10, 3, 'ज्ञानचक्षुषः', 'jñāna-cakṣuṣaḥ',
    'those who have an EYE for it. Not a belief about it and not a learned fact. The verse names a faculty rather than a doctrine, which is why agreeing with the chapter settles nothing in it',
    'जिनके पास उसके लिए आँख है। उसके बारे में कोई मान्यता नहीं और कोई सीखा हुआ तथ्य नहीं। श्लोक किसी सिद्धांत का नहीं, एक क्षमता का नाम लेता है, इसीलिए अध्याय से सहमत हो जाने से उसमें कुछ तय नहीं होता',
    'jinke paas uske liye aankh hai. Uske baare mein koi manyata nahi aur koi seekha hua tathya nahi. Shloka kisi siddhant ka nahi, ek kshamata ka naam leta hai, isiliye adhyay se sehmat ho jaane se usme kuch tay nahi hota',
    'nominative plural, compound', 'चक्ष्'
  UNION ALL SELECT 10, 4, 'अनुपश्यन्ति', 'anupaśyanti',
    'they see, they see along. The verb carries a sense of following something with the eye rather than arriving at a conclusion about it',
    'वे देखते हैं, साथ-साथ देखते हैं। क्रिया में किसी चीज़ को आँख से पीछा करने का भाव है, उसके बारे में किसी नतीजे पर पहुँचने का नहीं',
    'we dekhte hain, saath-saath dekhte hain. Kriya mein kisi cheez ko aankh se peechha karne ka bhaav hai, uske baare mein kisi nateeje par pahunchne ka nahi',
    'present, third plural', 'अनु + दृश्'

  UNION ALL SELECT 15, 1, 'हृदि सन्निविष्टः', 'hṛdi sanniviṣṭaḥ',
    'settled in the heart. Sanniviṣṭa is a sitting-down word, something that has come and stayed. And it is said of everyone, without a qualifying clause anywhere near it',
    'हृदय में बैठा हुआ। सन्निविष्ट बैठ जाने का शब्द है, वह जो आकर ठहर गया। और यह हर एक के बारे में कहा गया है, आसपास कहीं कोई शर्त लगाए बिना',
    'hriday mein baitha hua. Sannivishta baith jaane ka shabd hai, woh jo aakar thehar gaya. Aur yeh har ek ke baare mein kaha gaya hai, aaspaas kahin koi shart lagaye bina',
    'nominative singular', 'सम् + नि + विश्'
  UNION ALL SELECT 15, 2, 'स्मृतिः', 'smṛtiḥ',
    'memory, remembering. First of the three things the verse says come from one source',
    'स्मृति, याद आना। श्लोक जिन तीन चीज़ों को एक ही जगह से आया बताता है, उनमें पहली',
    'smriti, yaad aana. Shloka jin teen cheezon ko ek hi jagah se aaya batata hai, unme pehli',
    'nominative singular', 'स्मृ'
  UNION ALL SELECT 15, 3, 'ज्ञानम्', 'jñānam',
    'knowing, understanding. Second of the three, and the one people expect to be on the list',
    'जानना, समझ। तीनों में दूसरी, और वही जिसके सूची में होने की उम्मीद लोग करते हैं',
    'jaanna, samajh. Teenon mein doosri, aur wahi jiske soochi mein hone ki ummeed log karte hain',
    'nominative singular', 'ज्ञा'
  UNION ALL SELECT 15, 4, 'अपोहनम्', 'apohanam',
    'the taking away, the removal — of the two just named. Third on the same list, from the same source, in the same clause. THE FORGETTING IS ON THE LIST, and it is put there without a hedge and without anybody asking. Nothing in the chapter treats it as a fault',
    'हटा लेना, ले जाना — अभी नाम ली गई उन्हीं दो चीज़ों का। उसी सूची में तीसरी, उसी जगह से, उसी वाक्य में। भूलना सूची में है, और वह बिना किसी हिचक के और बिना किसी के पूछे वहाँ रखा गया है। अध्याय में कहीं उसे ख़राबी नहीं माना गया',
    'hata lena, le jaana — abhi naam li gayi unhi do cheezon ka. Usi soochi mein teesri, usi jagah se, usi vakya mein. Bhoolna soochi mein hai, aur woh bina kisi hichak ke aur bina kisi ke poochhe wahan rakha gaya hai. Adhyay mein kahin use kharabi nahi mana gaya',
    'nominative singular', 'अप + ऊह्'

  UNION ALL SELECT 20, 1, 'गुह्यतमम्', 'guhyatamam',
    'most closely held, most secret — superlative. And it has just been said out loud, in full, to somebody who was in the conversation and asked. Nothing was withheld on the basis of who he was',
    'सबसे छिपाकर रखी गई, सबसे गुप्त — उत्तम अवस्था। और वह अभी पूरी की पूरी, ज़ोर से, उस आदमी से कह दी गई जो बातचीत में था और जिसने पूछा था। वह कौन था, इस आधार पर कुछ रोका नहीं गया',
    'sabse chhipakar rakhi gayi, sabse gupt — uttam avastha. Aur woh abhi poori ki poori, zor se, us aadmi se keh di gayi jo baatcheet mein tha aur jisne poochha tha. Woh kaun tha, is aadhaar par kuch roka nahi gaya',
    'accusative singular, superlative', 'गुह्'
  UNION ALL SELECT 20, 2, 'शास्त्रम्', 'śāstram',
    'a teaching, something set out. Chapter 15 calls itself this, and it is twenty verses long',
    'शिक्षा, रखी हुई बात। पंद्रहवाँ अध्याय ख़ुद को यही कहता है, और वह बीस श्लोक का है',
    'shiksha, rakhi hui baat. Pandrahvan adhyay khud ko yahi kehta hai, aur woh bees shloka ka hai',
    'nominative singular', 'शास्'
  UNION ALL SELECT 20, 3, 'बुद्धिमान्', 'buddhimān',
    'one who has understanding. A description of what follows, not a rank conferred on anybody',
    'जिसके पास समझ है। यह उसका वर्णन है जो इसके बाद होता है, किसी को दिया गया दर्जा नहीं',
    'jiske paas samajh hai. Yeh uska varnan hai jo iske baad hota hai, kisi ko diya gaya darja nahi',
    'nominative singular', 'बुध्'
  UNION ALL SELECT 20, 4, 'कृतकृत्यः', 'kṛta-kṛtyaḥ',
    'the work done and the doing done — two words for finished, side by side. It does not mean a person now has nothing to do. It means the thing that was pulling at them, the sense of a debt that could never be paid down, has stopped being what runs the afternoon',
    'काम पूरा और करना पूरा — पूरा होने के दो शब्द, अगल-बगल। इसका मतलब यह नहीं कि अब आदमी के पास करने को कुछ नहीं। मतलब यह है कि जो चीज़ उसे खींच रही थी, वह एहसास कि एक क़र्ज़ है जो कभी उतरेगा नहीं, वह अब दोपहर चलाने वाली चीज़ नहीं रही',
    'kaam poora aur karna poora — poora hone ke do shabd, agal-bagal. Iska matlab yeh nahi ki ab aadmi ke paas karne ko kuch nahi. Matlab yeh hai ki jo cheez use kheench rahi thi, woh ehsaas ki ek karz hai jo kabhi utrega nahi, woh ab dopahar chalane wali cheez nahi rahi',
    'nominative singular, compound', 'कृ'

) AS w
JOIN verses v ON v.verse_number = w.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 15;
