-- =====================================================================
-- VedaVerse — database/seed_ch02.sql
-- =====================================================================
-- Chapter 2, batch A: the seven remaining MANDATORY verses.
--
--   2.20  what does not die            the flat denial, stated plainly
--   2.22  the change of clothes        the image everybody remembers
--   2.23  weapons do not cut it        four elements, four negations
--   2.27  death is certain, so is birth   the argument from inevitability
--   2.48  yoga is evenness             the definition, in one line
--   2.50  yoga is skill in action      the other definition
--   2.63  what anger costs             the chain continues from 2.62
--
-- With the five in seed_sample.sql — 2.13, 2.14, 2.47, 2.62, 2.70 —
-- every verse §8.1 marks mandatory for chapter 2 is now written.
--
-- STILL TO COME IN BATCH B
--   Six discretionary verses to reach the chapter's allocation of 18,
--   and a pass taking every chapter 2 verse from four modern examples
--   to the specified eight to twelve. Nothing here is rewritten by that
--   pass; it only adds.
--
-- CONTENT RULES — the same ones, and the ones easiest to break at volume
--   * Every translation, summary, explanation and example is ORIGINAL.
--     No published translation is reproduced anywhere.
--   * The Sanskrit is quoted unaltered. Numbering is never changed.
--   * Films and matches are named as facts, described in our own words.
--     No dialogue, no lyrics. Spoilers flagged.
--   * No praise or criticism of any living politician, party or
--     movement. Public-life examples describe the shape of a dilemma.
--   * 2.20 and 2.23 make metaphysical claims. The explanations say what
--     the text says and are explicit that a reader does not have to
--     accept it for the psychology to work — this product teaches the
--     Gita as practical psychology to people of any belief or none, and
--     that promise is easiest to break exactly here.
--
-- RUN AFTER seed_sample.sql. Re-runnable.
--
--     mariadb --skip-ssl -h 127.0.0.1 -u vedaverse -p vedaverse_db \
--         < htdocs/database/seed_ch02.sql
-- =====================================================================

SET NAMES utf8mb4;

-- =====================================================================
-- 1. THE VERSES
-- =====================================================================
-- global_order is 47 + verse_number: chapter 1 has 47 verses, and this
-- is what drives next/previous across chapter boundaries.
-- =====================================================================

INSERT IGNORE INTO verses
  (chapter_id, verse_number, global_order, is_curated, slug,
   sanskrit_devanagari, transliteration_iast, transliteration_simple,
   translation_literal,
   translation_en, translation_hi, translation_hinglish,
   summary_en, summary_hi, summary_hinglish,
   difficulty, seo_title, seo_description, published)
SELECT c.id, v.* FROM (

  SELECT
    20 AS verse_number, 67 AS global_order, 1 AS is_curated, 'gita-2-20' AS slug,
    'न जायते म्रियते वा कदाचिन्नायं भूत्वा भविता वा न भूयः।\nअजो नित्यः शाश्वतोऽयं पुराणो न हन्यते हन्यमाने शरीरे॥' AS sanskrit_devanagari,
    'na jāyate mriyate vā kadācin nāyaṁ bhūtvā bhavitā vā na bhūyaḥ\najo nityaḥ śāśvato ''yaṁ purāṇo na hanyate hanyamāne śarīre' AS transliteration_iast,
    'na jayate mriyate va kadachin nayam bhutva bhavita va na bhuyah\najo nityah shashvato yam purano na hanyate hanyamane sharire' AS transliteration_simple,
    'It is not born, nor does it ever die. Having been, it does not cease to be. Unborn, eternal, everlasting, ancient — it is not killed when the body is killed.' AS translation_literal,
    'It is not born and it does not die. It did not begin, and it does not stop. Unborn, continuous, old beyond counting — when the body is destroyed, this is not.' AS translation_en,
    'यह न जन्मता है, न मरता है। न इसकी शुरुआत हुई, न यह रुकता है। अजन्मा, निरंतर, गिनती से परे पुराना — शरीर नष्ट होने पर भी यह नष्ट नहीं होता।' AS translation_hi,
    'Yeh na paida hota hai, na marta hai. Na iski shuruaat hui, na yeh rukta hai. Ajanma, lagatar, ginti se pare purana — sharir khatam hone par bhi yeh khatam nahi hota.' AS translation_hinglish,
    'The flattest sentence in the chapter, and the one everything else rests on.' AS summary_en,
    'अध्याय का सबसे सीधा वाक्य, और वही जिस पर बाकी सब टिका है।' AS summary_hi,
    'Chapter ka sabse seedha vaakya, aur wahi jispe baaki sab tika hai.' AS summary_hinglish,
    'intermediate' AS difficulty,
    'Gita 2.20: what the Bhagavad Gita says does not die' AS seo_title,
    'The Gita''s flattest metaphysical claim, stated without hedging — and what a reader who does not share the belief can still take from it.' AS seo_description,
    1 AS published

  UNION ALL SELECT
    22, 69, 1, 'gita-2-22',
    'वासांसि जीर्णानि यथा विहाय नवानि गृह्णाति नरोऽपराणि।\nतथा शरीराणि विहाय जीर्णान्यन्यानि संयाति नवानि देही॥',
    'vāsāṁsi jīrṇāni yathā vihāya navāni gṛhṇāti naro ''parāṇi\ntathā śarīrāṇi vihāya jīrṇāny anyāni saṁyāti navāni dehī',
    'vasamsi jirnani yatha vihaya navani grihnati naro parani\ntatha sharirani vihaya jirnany anyani samyati navani dehi',
    'As a person casts off worn-out garments and takes up other new ones, so the embodied one casts off worn-out bodies and takes up other new ones.',
    'The way somebody takes off clothes that have worn through and puts on others, the one inside puts down a body that is finished and picks up another.',
    'जैसे कोई घिस चुके कपड़े उतारकर दूसरे पहन लेता है, वैसे ही भीतर वाला थक चुका शरीर रखकर दूसरा ले लेता है।',
    'Jaise koi ghis chuke kapde utaar ke doosre pehen leta hai, waise hi andar wala thak chuka sharir rakh ke doosra le leta hai.',
    'The most quoted image in the chapter — and the one most often used to shut grief down.',
    'अध्याय की सबसे उद्धृत उपमा — और वही जिससे अक्सर शोक को चुप करा दिया जाता है।',
    'Chapter ki sabse quote hone wali upma — aur wahi jisse aksar shok ko chup kara diya jaata hai.',
    'beginner',
    'Gita 2.22: the change of clothes, and how it gets misused',
    'The Bhagavad Gita''s best-known image for death. What it actually claims, and why quoting it at a grieving person is a misuse of it.',
    1

  UNION ALL SELECT
    23, 70, 1, 'gita-2-23',
    'नैनं छिन्दन्ति शस्त्राणि नैनं दहति पावकः।\nन चैनं क्लेदयन्त्यापो न शोषयति मारुतः॥',
    'nainaṁ chindanti śastrāṇi nainaṁ dahati pāvakaḥ\nna cainaṁ kledayanty āpo na śoṣayati mārutaḥ',
    'nainam chhindanti shastrani nainam dahati pavakah\nna chainam kledayanty apo na shoshayati marutah',
    'Weapons do not cut it. Fire does not burn it. Water does not wet it. Wind does not dry it.',
    'Blades do not cut it. Fire does not burn it. Water does not soak it. Wind does not dry it out. Nothing that can be done to a thing can be done to this.',
    'हथियार इसे काट नहीं सकते। आग जला नहीं सकती। पानी भिगो नहीं सकता। हवा सुखा नहीं सकती। जो किसी चीज़ के साथ किया जा सकता है, वह इसके साथ नहीं।',
    'Hathiyar ise kaat nahi sakte. Aag jala nahi sakti. Paani bhigo nahi sakta. Hawa sukha nahi sakti. Jo kisi cheez ke saath ho sakta hai, woh iske saath nahi.',
    'Four ways of destroying a thing, and four denials. The point is the pattern.',
    'किसी चीज़ को नष्ट करने के चार तरीक़े, और चार इनकार। बात इसी क्रम की है।',
    'Kisi cheez ko khatam karne ke chaar tareeke, aur chaar inkaar. Baat isi pattern ki hai.',
    'intermediate',
    'Gita 2.23: the four negations',
    'Blades, fire, water, wind — the four ways an ancient audience knew to destroy something, and the Gita denying all four in one line.',
    1

  UNION ALL SELECT
    27, 74, 1, 'gita-2-27',
    'जातस्य हि ध्रुवो मृत्युर्ध्रुवं जन्म मृतस्य च।\nतस्मादपरिहार्येऽर्थे न त्वं शोचितुमर्हसि॥',
    'jātasya hi dhruvo mṛtyur dhruvaṁ janma mṛtasya ca\ntasmād aparihārye ''rthe na tvaṁ śocitum arhasi',
    'jatasya hi dhruvo mrityur dhruvam janma mritasya cha\ntasmad apariharye rthe na tvam shochitum arhasi',
    'For one who is born, death is certain; for one who has died, birth is certain. Therefore you should not grieve over what cannot be avoided.',
    'Whatever is born will die. Whatever dies comes round again. You are grieving over the one thing in the whole arrangement that was never up for negotiation.',
    'जो जन्मा है वह मरेगा। जो मरा है वह लौटेगा। आप उसी एक बात का शोक कर रहे हैं जिस पर कभी कोई मोलभाव था ही नहीं।',
    'Jo paida hua hai woh marega. Jo mara hai woh laut aayega. Tum usi ek baat ka shok kar rahe ho jispe kabhi koi mol-bhaav tha hi nahi.',
    'Not a comfort. An argument — and it only works on the part of grief that is protest.',
    'यह सांत्वना नहीं, दलील है — और यह शोक के सिर्फ़ उस हिस्से पर चलती है जो विरोध है।',
    'Yeh saantvana nahi, dalil hai — aur yeh shok ke sirf us hisse par chalti hai jo virodh hai.',
    'beginner',
    'Gita 2.27 on grieving what could never have been otherwise',
    'Death is certain and the Gita says so bluntly. Read carefully it is narrower than it sounds: it argues with the part of grief that protests, not the part that misses somebody.',
    1

  UNION ALL SELECT
    48, 95, 1, 'gita-2-48',
    'योगस्थः कुरु कर्माणि सङ्गं त्यक्त्वा धनञ्जय।\nसिद्ध्यसिद्ध्योः समो भूत्वा समत्वं योग उच्यते॥',
    'yogasthaḥ kuru karmāṇi saṅgaṁ tyaktvā dhanañjaya\nsiddhy-asiddhyoḥ samo bhūtvā samatvaṁ yoga ucyate',
    'yogasthah kuru karmani sangam tyaktva dhananjaya\nsiddhy-asiddhyoh samo bhutva samatvam yoga uchyate',
    'Established in yoga, perform actions, abandoning attachment, Dhananjaya, remaining the same in success and failure. Evenness is called yoga.',
    'Do the work from a steady place. Let go of the clinging. Be the same person whether it comes off or does not. That evenness is what the word yoga means here.',
    'काम स्थिर जगह से कीजिए। पकड़ छोड़ दीजिए। बात बने या न बने, वही इंसान रहिए। यहाँ योग का अर्थ यही समता है।',
    'Kaam sthir jagah se karo. Pakad chhod do. Baat bane ya na bane, wahi insaan raho. Yahan yoga ka matlab yahi samta hai.',
    'The verse that defines the word. Yoga here is not posture — it is not changing shape when the result lands.',
    'यही श्लोक शब्द की परिभाषा देता है। यहाँ योग आसन नहीं है — नतीजा आने पर रूप न बदलना है।',
    'Yahi shloka shabd ki definition deta hai. Yahan yoga aasan nahi hai — result aane par shakal na badalna hai.',
    'beginner',
    'Gita 2.48: what the word yoga actually means',
    'Not posture and not breathing. The Bhagavad Gita defines yoga in one line as evenness — being the same person whether the thing worked or did not.',
    1

  UNION ALL SELECT
    50, 97, 1, 'gita-2-50',
    'बुद्धियुक्तो जहातीह उभे सुकृतदुष्कृते।\nतस्माद्योगाय युज्यस्व योगः कर्मसु कौशलम्॥',
    'buddhi-yukto jahātīha ubhe sukṛta-duṣkṛte\ntasmād yogāya yujyasva yogaḥ karmasu kauśalam',
    'buddhi-yukto jahatiha ubhe sukrita-dushkrite\ntasmad yogaya yujyasva yogah karmasu kaushalam',
    'One joined to discernment casts off, here, both good and bad deeds. Therefore yoke yourself to yoga. Yoga is skill in actions.',
    'Someone working with a clear head puts down both the credit and the blame. So train for that. Doing the work well, from that place, is itself the practice.',
    'साफ़ दिमाग़ से काम करने वाला श्रेय और दोष, दोनों नीचे रख देता है। इसलिए उसी का अभ्यास कीजिए। उस जगह से काम को अच्छे से करना ही साधना है।',
    'Saaf dimaag se kaam karne wala credit aur blame, dono neeche rakh deta hai. Isliye usi ki practice karo. Us jagah se kaam achhe se karna hi sadhana hai.',
    'The line people put on posters. In context it is about putting down credit, not about working harder.',
    'यही पंक्ति पोस्टरों पर लगती है। संदर्भ में यह श्रेय छोड़ने की बात है, ज़्यादा मेहनत की नहीं।',
    'Yahi line posters par lagti hai. Context mein yeh credit chhodne ki baat hai, zyada mehnat ki nahi.',
    'intermediate',
    'Gita 2.50: yoga is skill in action — what that really means',
    'The most poster-friendly line in the Gita, and the most decontextualised. Read with the line before it, it is about putting down credit and blame, not about working harder.',
    1

  UNION ALL SELECT
    63, 110, 1, 'gita-2-63',
    'क्रोधाद्भवति सम्मोहः सम्मोहात्स्मृतिविभ्रमः।\nस्मृतिभ्रंशाद् बुद्धिनाशो बुद्धिनाशात्प्रणश्यति॥',
    'krodhād bhavati sammohaḥ sammohāt smṛti-vibhramaḥ\nsmṛti-bhraṁśād buddhi-nāśo buddhi-nāśāt praṇaśyati',
    'krodhad bhavati sammohah sammohat smriti-vibhramah\nsmriti-bhramshad buddhi-nasho buddhi-nashat pranashyati',
    'From anger comes delusion; from delusion, confusion of memory; from loss of memory, destruction of discernment; from destruction of discernment, one is lost.',
    'Anger clouds you. Clouded, you forget what you know. Having forgotten, your judgement goes. And with judgement gone, so are you. That is the rest of the chain.',
    'गुस्सा धुंधला कर देता है। धुंधलाहट में आप भूल जाते हैं कि आप क्या जानते हैं। भूल गए तो समझ चली जाती है। और समझ गई तो आप गए। कड़ी का बाकी हिस्सा यही है।',
    'Gussa dhundhla kar deta hai. Dhundhlahat mein tum bhool jaate ho jo tum jaante ho. Bhool gaye to samajh chali jaati hai. Aur samajh gayi to tum gaye. Chain ka baaki hissa yahi hai.',
    'Where 2.62 ends, this begins. Four more steps, and the last one is the whole person.',
    '2.62 जहाँ ख़त्म होता है, यह वहीं से शुरू। चार और सीढ़ियाँ, और आख़िरी पर पूरा आदमी।',
    '2.62 jahan khatam hota hai, yeh wahin se shuru. Chaar aur seedhiyan, aur aakhri par poora aadmi.',
    'intermediate',
    'Gita 2.63: what anger actually costs you',
    'The chain that starts in 2.62 does not end at anger. Four more links — clouding, forgetting, losing judgement — and the Gita is blunt about where it finishes.',
    1

) AS v
JOIN chapters c ON c.chapter_number = 2;

-- =====================================================================
-- 2. EXPLANATIONS
-- =====================================================================
-- Beginner for all seven. Intermediate where the verse is genuinely
-- contested or where the Sanskrit does work the English cannot carry.
--
-- 2.20 and 2.23 are where this product is most likely to break its own
-- promise. They make a flat metaphysical claim, and the audience is
-- explicitly people of any belief or none. The explanations say what the
-- text says without softening it, and then say plainly that you do not
-- have to accept it for the rest to be useful. Neither converting nor
-- apologising.
-- =====================================================================

DELETE ve FROM verse_explanations ve JOIN verses v ON v.id = ve.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 2 AND v.verse_number IN (20, 22, 23, 27, 48, 50, 63);

INSERT INTO verse_explanations
  (verse_id, level,
   historical_context_en, historical_context_hi, historical_context_hinglish,
   practical_meaning_en, practical_meaning_hi, practical_meaning_hinglish,
   modern_interpretation_en, modern_interpretation_hi, modern_interpretation_hinglish)
SELECT v.id, x.level, x.h_en, x.h_hi, x.h_hing, x.p_en, x.p_hi, x.p_hing, x.m_en, x.m_hi, x.m_hing
FROM (

  SELECT 20 AS vn, 'beginner' AS level,
   'Krishna has been circling this for several verses. Here he stops arguing and simply states it, in the flattest language in the chapter, with no image and no comparison.' AS h_en,
   'कृष्ण कई श्लोकों से इसके इर्द-गिर्द घूम रहे थे। यहाँ वे बहस रोककर सीधे कह देते हैं — अध्याय की सबसे सपाट भाषा में, बिना किसी उपमा के।' AS h_hi,
   'Krishna kai shlokon se iske aas-paas ghoom rahe the. Yahan woh behes rok ke seedha keh dete hain — chapter ki sabse flat bhasha mein, bina kisi upma ke.' AS h_hing,
   'The claim is that something in you was not made and therefore cannot be unmade. Notice it is not a claim about you surviving pleasantly, or about being reunited with anybody. It is narrower and colder than most comfort about death, and that is part of why it has lasted.' AS p_en,
   'दावा यह है कि आपमें कुछ ऐसा है जो बनाया नहीं गया, इसलिए मिटाया भी नहीं जा सकता। ध्यान दीजिए, यह दावा यह नहीं कहता कि आप सुख से बचे रहेंगे, या किसी से फिर मिलेंगे। यह मृत्यु पर दी जाने वाली ज़्यादातर सांत्वनाओं से छोटा और ठंडा है — और शायद इसीलिए टिका है।' AS p_hi,
   'Claim yeh hai ki tumme kuch aisa hai jo banaya nahi gaya, isliye mitaya bhi nahi ja sakta. Dhyan do, yeh nahi keh raha ki tum aaram se bache rahoge, ya kisi se phir miloge. Yeh maut par di jaane wali zyadatar saantvanaon se chhota aur thanda hai — aur shayad isiliye tika hai.' AS p_hing,
   'You do not have to believe this for the chapter to be useful, and nothing in this product asks you to. Read as a claim about the universe it is a religious statement, and you are free to reject it. Read as a claim about where your attention sits, it does a different job: almost everything you fear losing is a role, a position or a body, and noticing that they were always separable from you is available whatever you think happens afterwards.' AS m_en,
   'अध्याय काम करे, इसके लिए इस पर विश्वास करना ज़रूरी नहीं, और यह उत्पाद आपसे कहीं ऐसा माँगता भी नहीं। ब्रह्मांड के बारे में दावा मानें तो यह धार्मिक कथन है, और आप इसे अस्वीकार करने के लिए स्वतंत्र हैं। ध्यान कहाँ टिका है, इस बारे में दावा मानें तो यह अलग काम करता है: जिन चीज़ों के खोने का डर है उनमें लगभग सब कोई भूमिका, पद या शरीर है — और यह देख लेना कि वे हमेशा आपसे अलग की जा सकती थीं, आपके किसी भी विश्वास के साथ संभव है।' AS m_hi,
   'Chapter kaam kare, iske liye ispe vishwas karna zaroori nahi, aur yeh product tumse kahin aisa maangta bhi nahi. Universe ke baare mein claim maano to yeh religious statement hai, aur tum ise reject karne ke liye azad ho. Dhyan kahan tika hai, is baare mein claim maano to yeh alag kaam karta hai: jin cheezon ke khone ka dar hai unme lagbhag sab koi role, position ya body hai — aur yeh dekh lena ki woh hamesha tumse alag ki ja sakti thi, tumhare kisi bhi vishwas ke saath mumkin hai.' AS m_hing

  UNION ALL SELECT 22, 'beginner',
   'The image arrives after several verses of flat assertion. Krishna has said the thing plainly and Arjuna has not moved, so he reaches for something a person can picture.',
   'यह उपमा कई सपाट कथनों के बाद आती है। कृष्ण सीधी बात कह चुके हैं और अर्जुन हिला नहीं, इसलिए वे कुछ ऐसा उठाते हैं जिसे आदमी देख सके।',
   'Yeh upma kai flat statements ke baad aati hai. Krishna seedhi baat keh chuke hain aur Arjun hila nahi, isliye woh kuch aisa uthate hain jo aadmi dekh sake.',
   'The comparison is doing one specific job: it makes the change ordinary. Nobody holds a funeral for a shirt. Whether you accept the claim or not, notice what the image is arguing against — not against sadness, but against the sense that something unthinkable and unprecedented is happening.',
   'यह उपमा एक ही ख़ास काम कर रही है: बदलाव को साधारण बना देना। कमीज़ का अंतिम संस्कार कोई नहीं करता। दावा मानें या न मानें, यह देखिए कि उपमा किसके ख़िलाफ़ है — उदासी के नहीं, बल्कि इस एहसास के कि कुछ अकल्पनीय और अभूतपूर्व घट रहा है।',
   'Yeh upma ek hi khaas kaam kar rahi hai: badlav ko saadharan bana dena. Kameez ka antim sanskar koi nahi karta. Claim maano ya na maano, yeh dekho ki upma kiske khilaf hai — udasi ke nahi, balki us ehsaas ke ki kuch akalpaniya aur pehli baar ho raha hai.',
   'This is the most misused line in the book. Somebody says it to a person three days into a bereavement, and what the grieving person hears is that their loss was trivial — a wardrobe change. Read where it sits, it is addressed to a soldier arguing that he cannot act, not to a mourner asking to be held. It is an argument against paralysis. It was never a thing to say at a funeral, and using it there is how a genuinely useful idea got a bad name.',
   'यह किताब की सबसे ग़लत इस्तेमाल होने वाली पंक्ति है। कोई इसे शोक के तीसरे दिन किसी से कह देता है, और सुनने वाले को लगता है कि उसका नुक़सान मामूली था — कपड़े बदलने जैसा। जहाँ यह रखी है वहाँ पढ़िए: यह उस सैनिक से कही गई है जो तर्क दे रहा है कि वह काम नहीं कर सकता, उस शोकाकुल से नहीं जो सहारा माँग रहा है। यह जड़ता के ख़िलाफ़ दलील है। इसे शवयात्रा में कहने के लिए कभी बनाया ही नहीं गया, और वहीं कहने से एक सचमुच काम की बात बदनाम हुई।',
   'Yeh kitaab ki sabse galat istemaal hone wali line hai. Koi ise shok ke teesre din kisi se keh deta hai, aur sunne wale ko lagta hai ki uska nuksaan mamooli tha — kapde badalne jaisa. Jahan yeh rakhi hai wahan padho: yeh us sainik se kahi gayi hai jo tark de raha hai ki woh kaam nahi kar sakta, us shok mein doobe insaan se nahi jo sahara maang raha hai. Yeh jadta ke khilaf dalil hai. Ise shok mein kehne ke liye kabhi banaya hi nahi gaya, aur wahin kehne se ek sach mein kaam ki baat badnaam hui.'

  UNION ALL SELECT 23, 'beginner',
   'Four ways an ancient audience knew to destroy a thing — blade, fire, water, wind — and four denials, in the same order, in one line.',
   'किसी चीज़ को नष्ट करने के चार तरीक़े जो उस समय के श्रोता जानते थे — हथियार, आग, पानी, हवा — और उसी क्रम में चार इनकार, एक ही पंक्ति में।',
   'Kisi cheez ko khatam karne ke chaar tareeke jo us waqt ke log jaante the — hathiyar, aag, paani, hawa — aur usi order mein chaar inkaar, ek hi line mein.',
   'The structure is the argument. Cutting, burning, soaking, drying — that is the complete list of what can be done to a physical object. Denying all four in sequence is a way of saying: this is not the kind of thing any of that applies to. Not a stronger object. A different category.',
   'ढाँचा ही दलील है। काटना, जलाना, भिगोना, सुखाना — किसी भौतिक वस्तु के साथ जो किया जा सकता है, यह उसकी पूरी सूची है। क्रम से चारों का इनकार यह कहने का तरीक़ा है: यह उस तरह की चीज़ ही नहीं है जिस पर ये लागू हों। मज़बूत वस्तु नहीं। अलग श्रेणी।',
   'Structure hi dalil hai. Kaatna, jalana, bhigona, sukhana — kisi physical cheez ke saath jo ho sakta hai, yeh uski poori list hai. Order se chaaron ka inkaar yeh kehne ka tareeka hai: yeh us tarah ki cheez hi nahi hai jispe yeh lagoo hon. Mazboot cheez nahi. Alag category.',
   'The four elements are period detail; the move is not. Any time you catch yourself asking how much damage something can take — a reputation, a relationship, a sense of who you are — the verse is pointing at a prior question: is this the kind of thing damage even applies to. Often it is. Sometimes the question dissolves the fear.',
   'चार तत्त्व उस युग का ब्योरा हैं; चाल नहीं। जब भी आप ख़ुद को यह पूछते पकड़ें कि कोई चीज़ कितनी चोट सह सकती है — कोई साख, कोई रिश्ता, अपनी कोई पहचान — श्लोक उससे पहले वाले सवाल की ओर इशारा कर रहा है: क्या यह उस तरह की चीज़ है जिस पर चोट लागू भी होती है। अक्सर होती है। कभी-कभी सवाल ही डर को घोल देता है।',
   'Chaar tatva us zamane ka detail hain; move nahi. Jab bhi khud ko yeh poochte pakdo ki koi cheez kitni chot seh sakti hai — koi reputation, koi rishta, apni koi pehchan — shloka usse pehle wale sawaal ki taraf ishara kar raha hai: kya yeh us tarah ki cheez hai jispe chot lagoo bhi hoti hai. Aksar hoti hai. Kabhi kabhi sawaal hi dar ko ghol deta hai.'

  UNION ALL SELECT 27, 'beginner',
   'Krishna offers this as an argument that should work even if Arjuna rejects everything metaphysical said so far. It stands on its own.',
   'कृष्ण इसे ऐसी दलील की तरह रखते हैं जो तब भी चले जब अर्जुन अब तक की सारी तत्त्व-बातें ख़ारिज कर दे। यह अपने आप में खड़ी है।',
   'Krishna ise aisi dalil ki tarah rakhte hain jo tab bhi chale jab Arjun ab tak ki saari metaphysics khaarij kar de. Yeh apne aap mein khadi hai.',
   'Read it narrowly. It does not say do not be sad. It says do not grieve over the unavoidable — and grief has two parts. There is missing somebody, which no argument touches. And there is protest: this should not have happened, it is not fair, it should have been otherwise. The second part is what this verse is talking to, and the second part is the one that keeps a person awake.',
   'इसे संकीर्ण अर्थ में पढ़िए। यह नहीं कहता कि दुखी मत होइए। यह कहता है कि जो टल ही नहीं सकता उसका शोक मत कीजिए — और शोक के दो हिस्से होते हैं। एक, किसी की कमी खलना, जिसे कोई दलील नहीं छूती। दूसरा, विरोध: ऐसा नहीं होना चाहिए था, यह ठीक नहीं, कुछ और होना चाहिए था। यह श्लोक दूसरे हिस्से से बात कर रहा है — और रात भर जगाता भी वही है।',
   'Ise chhote arth mein padho. Yeh nahi kehta ki dukhi mat ho. Yeh kehta hai ki jo tal hi nahi sakta uska shok mat karo — aur shok ke do hisse hote hain. Ek, kisi ki kami khalna, jise koi dalil chhoo nahi sakti. Doosra, virodh: aisa nahi hona chahiye tha, yeh theek nahi, kuch aur hona chahiye tha. Yeh shloka doosre hisse se baat kar raha hai — aur raat bhar jagata bhi wahi hai.',
   'Most of what exhausts a person after a loss is not the sadness. It is the re-running: the earlier appointment, the different hospital, the call not made. That machinery is looking for a version of events in which the unavoidable was avoided, and it never finds one because there is not one. This verse is aimed precisely there.',
   'नुक़सान के बाद जो थकाता है, वह ज़्यादातर उदासी नहीं होती। वह दोहराव होता है: पहले लिया गया समय, दूसरा अस्पताल, वह फ़ोन जो नहीं किया। यह मशीन घटनाओं का ऐसा रूप ढूँढ़ रही है जिसमें जो टल नहीं सकता था वह टल गया हो — और वह कभी मिलता नहीं, क्योंकि है ही नहीं। यह श्लोक ठीक वहीं निशाना लगाता है।',
   'Nuksaan ke baad jo thakata hai woh zyadatar udasi nahi hoti. Woh dohrav hota hai: pehle liya gaya appointment, doosra hospital, woh call jo nahi kiya. Yeh machine ghatnaon ka aisa version dhoondh rahi hai jisme jo tal nahi sakta tha woh tal gaya ho — aur woh kabhi milta nahi, kyunki hai hi nahi. Yeh shloka theek wahin nishana lagata hai.'

  UNION ALL SELECT 48, 'beginner',
   'One verse after 2.47 said the result is not yours. Arjuna could reasonably ask what is left to stand on. This is the answer, and it is where the word yoga gets its working definition in this text.',
   '2.47 के ठीक बाद, जहाँ कहा गया कि नतीजा आपका नहीं। अर्जुन पूछ सकता है कि फिर खड़े किस पर हों। यही जवाब है, और यहीं इस ग्रंथ में योग शब्द की काम की परिभाषा बनती है।',
   '2.47 ke theek baad, jahan kaha gaya ki result tumhara nahi. Arjun pooch sakta hai ki phir khade kis par hon. Yahi jawab hai, aur yahin is text mein yoga shabd ki kaam ki definition banti hai.',
   'Three instructions and a definition. Work from a steady place. Drop the clinging. Be the same whether it lands or not. Then: that sameness is what this book means by yoga. Not posture, not breathing, not withdrawal — evenness while still working.',
   'तीन निर्देश और एक परिभाषा। स्थिर जगह से काम कीजिए। पकड़ छोड़िए। बात बने या न बने, वही रहिए। और फिर: यही समता है जिसे यह किताब योग कहती है। न आसन, न प्राणायाम, न पलायन — काम करते हुए समता।',
   'Teen instructions aur ek definition. Sthir jagah se kaam karo. Pakad chhodo. Baat bane ya na bane, wahi raho. Aur phir: yahi samta hai jise yeh kitaab yoga kehti hai. Na aasan, na breathing, na bhaagna — kaam karte hue samta.',
   'The word has travelled a long way from this. Most people now hear yoga and picture a mat. The text uses it for something closer to a temperament: not changing shape when the result arrives. On that definition somebody who has never held a posture in their life can be doing it at their desk, and somebody who is very flexible may not be.',
   'शब्द यहाँ से बहुत दूर चला गया है। आज ज़्यादातर लोग योग सुनकर चटाई सोचते हैं। ग्रंथ इसे स्वभाव के क़रीब किसी चीज़ के लिए इस्तेमाल करता है: नतीजा आने पर रूप न बदलना। इस परिभाषा पर वह व्यक्ति भी यह कर सकता है जिसने कभी कोई आसन नहीं किया, और बहुत लचीला व्यक्ति शायद न कर रहा हो।',
   'Shabd yahan se bahut door chala gaya hai. Aaj zyadatar log yoga sun ke chatai sochte hain. Text ise swabhav ke kareeb kisi cheez ke liye use karta hai: result aane par shakal na badalna. Is definition par woh insaan bhi yeh kar sakta hai jisne kabhi koi aasan nahi kiya, aur bahut flexible insaan shayad na kar raha ho.'

  UNION ALL SELECT 50, 'intermediate',
   'Two verses after the definition of yoga as evenness, and immediately after a line about discernment leaving both good and bad results behind. The second half is a summary of what has just been argued, not a new claim.',
   'योग को समता कहने के दो श्लोक बाद, और उस पंक्ति के ठीक बाद जहाँ कहा गया कि विवेक अच्छे और बुरे दोनों फलों को पीछे छोड़ देता है। दूसरा हिस्सा अभी कही गई बात का सार है, कोई नया दावा नहीं।',
   'Yoga ko samta kehne ke do shloka baad, aur us line ke theek baad jahan kaha gaya ki vivek achhe aur bure dono phalon ko peeche chhod deta hai. Doosra hissa abhi kahi baat ka saar hai, koi naya claim nahi.',
   'Kaushalam is skill or dexterity; karmasu is in actions. But the sentence before it decides what the skill is IN. It is not skill at producing outcomes — the previous fifty verses have been dismantling that. It is skill at acting while holding neither the credit nor the blame, which is much harder and looks much less impressive.',
   'कौशलम् यानी कुशलता; कर्मसु यानी कर्मों में। पर उससे पहले वाला वाक्य तय करता है कि कुशलता किसमें है। यह नतीजे पैदा करने की कुशलता नहीं है — पिछले पचास श्लोक उसी को तोड़ते आए हैं। यह उस तरह काम करने की कुशलता है जिसमें न श्रेय पकड़ा जाए न दोष, जो कहीं कठिन है और कहीं कम प्रभावशाली दिखता है।',
   'Kaushalam matlab kushalta; karmasu matlab karmon mein. Par usse pehle wala vaakya tay karta hai ki kushalta kisme hai. Yeh result banane ki kushalta nahi hai — pichhle pachaas shlok usi ko tod rahe the. Yeh us tarah kaam karne ki kushalta hai jisme na credit pakda jaaye na blame — jo kahin mushkil hai aur kahin kam impressive dikhta hai.',
   'Lifted out of the chapter, this line becomes a productivity slogan: do your work excellently. That is not wrong, and it is not what the verse says. On a poster it means work harder. In place it means work without collecting, which is closer to the opposite of what most people take from the poster.',
   'अध्याय से निकाल दें तो यह पंक्ति उत्पादकता का नारा बन जाती है: काम बढ़िया कीजिए। यह ग़लत नहीं है, और यह वह नहीं है जो श्लोक कहता है। पोस्टर पर इसका अर्थ है ज़्यादा मेहनत। अपनी जगह पर इसका अर्थ है बिना बटोरे काम करना — जो पोस्टर से लोग जो समझते हैं, उसके लगभग उलट है।',
   'Chapter se nikaal do to yeh line productivity ka slogan ban jaati hai: kaam badhiya karo. Yeh galat nahi hai, aur yeh woh nahi hai jo shloka kehta hai. Poster par iska matlab hai zyada mehnat. Apni jagah par iska matlab hai bina batore kaam karna — jo poster se log jo samajhte hain uske lagbhag ulta hai.'

  UNION ALL SELECT 63, 'beginner',
   'The second half of the chain that began in 2.62. Krishna is still answering the question of how you would recognise a steady person, by describing what happens to an unsteady one.',
   '2.62 से शुरू हुई कड़ी का दूसरा हिस्सा। कृष्ण अब भी उसी सवाल का जवाब दे रहे हैं कि स्थिर व्यक्ति को पहचानें कैसे — यह बताकर कि अस्थिर के साथ क्या होता है।',
   '2.62 se shuru hui chain ka doosra hissa. Krishna abhi bhi usi sawaal ka jawab de rahe hain ki sthir insaan ko pehchane kaise — yeh bata ke ki asthir ke saath kya hota hai.',
   'Four more steps. Anger clouds. Clouded, you lose access to what you actually know — not your memory of facts, but your memory of what matters, who this person is to you, what you decided last week. With that gone, judgement goes. And the verse does not soften the last step.',
   'चार और सीढ़ियाँ। गुस्सा धुंधला करता है। धुंधलाहट में आप उस तक नहीं पहुँच पाते जो आप जानते हैं — तथ्यों की याद नहीं, बल्कि यह याद कि क्या मायने रखता है, यह व्यक्ति आपका कौन है, पिछले हफ़्ते आपने क्या तय किया था। वह गया तो समझ गई। और आख़िरी सीढ़ी पर श्लोक कोई नरमी नहीं बरतता।',
   'Chaar aur seedhiyan. Gussa dhundhla karta hai. Dhundhlahat mein tum us tak nahi pahunch paate jo tum jaante ho — facts ki yaad nahi, balki yeh yaad ki kya maayne rakhta hai, yeh insaan tumhara kaun hai, pichhle hafte tumne kya tay kiya tha. Woh gaya to samajh gayi. Aur aakhri seedhi par shloka koi narmi nahi barta.',
   'Anybody who has said something in a temper that took a year to undo knows this chain from the inside. The useful part is still the ordering. By the time judgement has gone, nothing can be done. Two steps earlier — at clouding — there is still a person there who can leave the room. That is the whole practical content of both verses: intervene early, because late does not exist.',
   'जिसने भी गुस्से में कुछ ऐसा कहा है जिसे सुलझाने में साल लगा, वह इस कड़ी को भीतर से जानता है। काम की बात अब भी क्रम है। जब तक समझ जा चुकी हो, कुछ नहीं किया जा सकता। दो सीढ़ी पहले — धुंधलाहट पर — वहाँ अब भी एक आदमी है जो कमरे से निकल सकता है। दोनों श्लोकों की पूरी व्यावहारिक बात यही है: जल्दी दख़ल दीजिए, क्योंकि देर से का कोई विकल्प है ही नहीं।',
   'Jisne bhi gusse mein kuch aisa kaha hai jise sulajhane mein saal laga, woh is chain ko andar se jaanta hai. Kaam ki baat abhi bhi order hai. Jab tak samajh ja chuki ho, kuch nahi kiya ja sakta. Do seedhi pehle — dhundhlahat par — wahan abhi bhi ek aadmi hai jo kamre se nikal sakta hai. Dono shlokon ki poori practical baat yahi hai: jaldi dakhal do, kyunki der se ka koi option hai hi nahi.'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2;

-- =====================================================================
-- 3. HOOKS, REFLECTIONS, PRACTICES, TOPICS
-- =====================================================================

DELETE m FROM verse_memory_aids m JOIN verses v ON v.id = m.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 2 AND v.verse_number IN (20,22,23,27,48,50,63);
DELETE r FROM verse_reflections r JOIN verses v ON v.id = r.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 2 AND v.verse_number IN (20,22,23,27,48,50,63);
DELETE p FROM verse_practices p JOIN verses v ON v.id = p.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 2 AND v.verse_number IN (20,22,23,27,48,50,63);
DELETE vt FROM verse_topics vt JOIN verses v ON v.id = vt.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 2 AND v.verse_number IN (20,22,23,27,48,50,63);

INSERT INTO verse_memory_aids (verse_id, hook_en, hook_hi, hook_hinglish, analogy_en, analogy_hi, analogy_hinglish, visual_cue)
SELECT v.id, m.h_en, m.h_hi, m.h_hing, m.a_en, m.a_hi, m.a_hing, m.cue FROM (
  SELECT 20 AS vn,
  'Whatever was never made cannot be unmade.' AS h_en,
  'जो कभी बनाया ही नहीं गया, वह मिटाया नहीं जा सकता।' AS h_hi,
  'Jo kabhi banaya hi nahi gaya, woh mitaya nahi ja sakta.' AS h_hing,
  'Like the number seven. You can burn every book it is written in and you have not touched it.' AS a_en,
  'सात की संख्या जैसा। जिन किताबों में लिखा है सब जला दीजिए, उसे कुछ नहीं हुआ।' AS a_hi,
  'Saat ke number ki tarah. Jin kitaabon mein likha hai sab jala do, use kuch nahi hua.' AS a_hing,
  'A number carved in stone, and the same number in chalk' AS cue

  UNION ALL SELECT 22,
  'A shirt wears out. Nobody holds a funeral for a shirt.',
  'कमीज़ घिस जाती है। कमीज़ का अंतिम संस्कार कोई नहीं करता।',
  'Kameez ghis jaati hai. Kameez ka antim sanskar koi nahi karta.',
  'Like moving house. The address changes and the family does not.',
  'घर बदलने जैसा। पता बदलता है, परिवार नहीं।',
  'Ghar badalne jaisa. Address badalta hai, parivar nahi.',
  'A folded stack of worn clothes beside new ones'

  UNION ALL SELECT 23,
  'Cut it, burn it, soak it, dry it. That is the whole list, and none of it applies.',
  'काटिए, जलाइए, भिगोइए, सुखाइए। पूरी सूची यही है, और कोई लागू नहीं होता।',
  'Kaato, jalao, bhigoo, sukhao. Poori list yahi hai, aur koi lagoo nahi hota.',
  'Like trying to tear a promise. You can burn the paper it is written on.',
  'किसी वादे को फाड़ने की कोशिश जैसा। जिस काग़ज़ पर लिखा है, वह जला सकते हैं।',
  'Kisi waade ko phaadne ki koshish jaisi. Jis kaagaz par likha hai woh jala sakte ho.',
  'Four elements arranged around an untouched centre'

  UNION ALL SELECT 27,
  'You are arguing with the one part of this that was never negotiable.',
  'आप इसी एक हिस्से से लड़ रहे हैं जिस पर कभी मोलभाव था ही नहीं।',
  'Tum usi ek hisse se lad rahe ho jispe kabhi mol-bhaav tha hi nahi.',
  'Like replaying a match you have already lost, looking for the ball that could have gone differently.',
  'हारे हुए मैच को दोबारा चलाने जैसा, यह ढूँढ़ते हुए कि कौन-सी गेंद और हो सकती थी।',
  'Haare hue match ko dobara chalane jaisa, yeh dhoondhte hue ki kaun si ball aur ho sakti thi.',
  'A replay paused on one frame'

  UNION ALL SELECT 48,
  'Yoga is not the mat. It is being the same person after the result comes in.',
  'योग चटाई नहीं है। योग यह है कि नतीजा आने के बाद भी वही इंसान रहें।',
  'Yoga chatai nahi hai. Yoga yeh hai ki result aane ke baad bhi wahi insaan raho.',
  'Like a good umpire. Same face for the appeal that is out and the one that is not.',
  'अच्छे अंपायर जैसा। जो आउट है और जो नहीं, दोनों अपील पर वही चेहरा।',
  'Achhe umpire ki tarah. Jo out hai aur jo nahi, dono appeal par wahi chehra.',
  'An umpire mid-decision, crowd blurred'

  UNION ALL SELECT 50,
  'Skill in action means acting without collecting. Not working harder.',
  'कर्म में कुशलता यानी बिना बटोरे काम करना। ज़्यादा मेहनत नहीं।',
  'Karm mein kushalta matlab bina batore kaam karna. Zyada mehnat nahi.',
  'Like a surgeon who does not keep the scoreboard. The hands work better for it.',
  'उस सर्जन जैसा जो स्कोर नहीं गिनता। हाथ इसी से बेहतर चलते हैं।',
  'Us surgeon ki tarah jo score nahi ginta. Haath isi se behtar chalte hain.',
  'Hands mid-procedure, no clock in frame'

  UNION ALL SELECT 63,
  'Anger clouds, clouding forgets, forgetting decides. Leave the room at step one.',
  'गुस्सा धुंधलाता है, धुंधलाहट भुलाती है, भूल फ़ैसला करती है। पहली सीढ़ी पर ही कमरा छोड़िए।',
  'Gussa dhundhlata hai, dhundhlahat bhulati hai, bhool faisla karti hai. Pehli seedhi par hi kamra chhod do.',
  'Like driving into fog. The time to slow down is when you first cannot see the verge.',
  'कोहरे में गाड़ी चलाने जैसा। धीमे होने का समय वही है जब किनारा पहली बार दिखना बंद हो।',
  'Kohre mein gaadi chalane jaisa. Dheere hone ka time wahi hai jab kinara pehli baar dikhna band ho.',
  'Headlights entering fog'
) AS m
JOIN verses v ON v.verse_number = m.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2;

INSERT INTO verse_reflections (verse_id, question_en, question_hi, question_hinglish, display_order)
SELECT v.id, r.q_en, r.q_hi, r.q_hing, r.ord FROM (
  SELECT 20 AS vn, 'What are you most afraid of losing, and is it a thing or a role?' AS q_en, 'आपको किसके खोने का सबसे ज़्यादा डर है — वह कोई चीज़ है या कोई भूमिका?' AS q_hi, 'Tumhe kiske khone ka sabse zyada dar hai — woh koi cheez hai ya koi role?' AS q_hing, 1 AS ord
  UNION ALL SELECT 20, 'If you do not accept this claim, does anything in the chapter still work for you?', 'अगर आप यह दावा नहीं मानते, तो क्या अध्याय की कोई बात फिर भी आपके काम की है?', 'Agar tum yeh claim nahi maante, to kya chapter ki koi baat phir bhi tumhare kaam ki hai?', 2
  UNION ALL SELECT 20, 'What has already survived every version of you so far?', 'अब तक के आपके हर रूप के बाद भी क्या बचा रहा है?', 'Ab tak ke tumhare har version ke baad bhi kya bacha raha hai?', 3
  UNION ALL SELECT 22, 'Has anybody ever said this to you at the wrong moment? What did you need instead?', 'क्या किसी ने यह बात आपसे ग़लत वक़्त पर कही है? आपको तब क्या चाहिए था?', 'Kya kisi ne yeh baat tumse galat waqt par kahi hai? Tumhe tab kya chahiye tha?', 1
  UNION ALL SELECT 22, 'Which of your bodies are you already nostalgic for?', 'अपने कौन-से शरीर की आपको अभी से याद आती है?', 'Apne kaun se sharir ki tumhe abhi se yaad aati hai?', 2
  UNION ALL SELECT 22, 'What would change if you treated this as an argument against paralysis rather than against sadness?', 'अगर आप इसे उदासी के नहीं, जड़ता के ख़िलाफ़ दलील मानें तो क्या बदलेगा?', 'Agar tum ise udasi ke nahi, jadta ke khilaf dalil maano to kya badlega?', 3
  UNION ALL SELECT 23, 'What are you protecting that may not need protecting?', 'आप किसकी रक्षा कर रहे हैं जिसे शायद रक्षा की ज़रूरत ही नहीं?', 'Tum kiski raksha kar rahe ho jise shayad raksha ki zaroorat hi nahi?', 1
  UNION ALL SELECT 23, 'When you fear damage to your reputation, what exactly do you picture being damaged?', 'जब साख को नुक़सान का डर होता है, तब आप ठीक-ठीक किसे चोट खाते देखते हैं?', 'Jab reputation ko nuksaan ka dar hota hai, tab tum theek-theek kise chot khaate dekhte ho?', 2
  UNION ALL SELECT 23, 'Name something about you that no event last year managed to touch.', 'अपनी कोई एक बात बताइए जिसे पिछले साल की किसी घटना ने छुआ तक नहीं।', 'Apni koi ek baat batao jise pichhle saal ki kisi ghatna ne chhua tak nahi.', 3
  UNION ALL SELECT 27, 'Which version of events do you keep replaying, and what are you looking for in it?', 'आप कौन-सा दृश्य बार-बार दोहराते हैं, और उसमें ढूँढ़ क्या रहे हैं?', 'Tum kaun sa scene baar-baar dohrate ho, aur usme dhoondh kya rahe ho?', 1
  UNION ALL SELECT 27, 'Separate the missing from the protesting. Which one is keeping you up?', 'कमी खलना और विरोध करना अलग कीजिए। इनमें से कौन आपको जगाए रखता है?', 'Kami khalna aur virodh karna alag karo. Inme se kaun tumhe jagaye rakhta hai?', 2
  UNION ALL SELECT 27, 'What would you tell a friend who was re-running the same afternoon?', 'जो दोस्त उसी दोपहर को बार-बार दोहरा रहा हो, उससे आप क्या कहेंगे?', 'Jo dost usi dopahar ko baar-baar dohra raha ho, usse tum kya kahoge?', 3
  UNION ALL SELECT 48, 'Think of your last win and your last loss. Were you the same person in the week after each?', 'अपनी पिछली जीत और पिछली हार सोचिए। दोनों के बाद वाले हफ़्ते में आप वही इंसान थे?', 'Apni pichhli jeet aur pichhli haar socho. Dono ke baad wale hafte mein tum wahi insaan the?', 1
  UNION ALL SELECT 48, 'Who around you visibly changes shape when a result lands? What does it cost them?', 'आपके आस-पास कौन नतीजा आते ही साफ़ बदल जाता है? उसे इसकी क्या क़ीमत चुकानी पड़ती है?', 'Tumhare aas-paas kaun result aate hi saaf badal jaata hai? Use iski kya keemat chukani padti hai?', 2
  UNION ALL SELECT 48, 'What would evenness cost you, if you had it?', 'अगर आपमें यह समता हो, तो उसकी क्या क़ीमत होगी?', 'Agar tumme yeh samta ho, to uski kya keemat hogi?', 3
  UNION ALL SELECT 50, 'Where do you collect credit, and would the work be worse without collecting it?', 'आप श्रेय कहाँ बटोरते हैं, और बिना बटोरे क्या काम ख़राब हो जाता?', 'Tum credit kahan batorte ho, aur bina batore kya kaam kharab ho jaata?', 1
  UNION ALL SELECT 50, 'Have you ever used this line to justify working harder? What was it actually asking for?', 'क्या आपने कभी इस पंक्ति से ज़्यादा मेहनत को जायज़ ठहराया है? यह असल में क्या माँग रही थी?', 'Kya tumne kabhi is line se zyada mehnat ko sahi thehraya hai? Yeh asal mein kya maang rahi thi?', 2
  UNION ALL SELECT 50, 'Which of your recent work would look the same if nobody knew you did it?', 'हाल का आपका कौन-सा काम वैसा ही होता अगर किसी को पता ही न चलता कि आपने किया?', 'Haal ka tumhara kaun sa kaam waisa hi hota agar kisi ko pata hi na chalta ki tumne kiya?', 3
  UNION ALL SELECT 63, 'Recall a decision you made while angry. What did it cost to undo?', 'गुस्से में लिया कोई फ़ैसला याद कीजिए। उसे पलटने में क्या लगा?', 'Gusse mein liya koi faisla yaad karo. Use palatne mein kya laga?', 1
  UNION ALL SELECT 63, 'What is your own first sign of clouding — the one you can catch?', 'आपकी धुंधलाहट की पहली निशानी क्या है — वह जिसे आप पकड़ सकते हैं?', 'Tumhari dhundhlahat ki pehli nishani kya hai — woh jise tum pakad sakte ho?', 2
  UNION ALL SELECT 63, 'Who can tell you are angry before you can?', 'आपसे पहले कौन जान जाता है कि आपको गुस्सा आ गया है?', 'Tumse pehle kaun jaan jaata hai ki tumhe gussa aa gaya hai?', 3
) AS r
JOIN verses v ON v.verse_number = r.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2;

INSERT INTO verse_practices (verse_id, action_en, action_hi, action_hinglish, estimated_minutes, difficulty, display_order)
SELECT v.id, p.a_en, p.a_hi, p.a_hing, p.mins, p.diff, 1 FROM (
  SELECT 20 AS vn, 'Write down three things you would still be if you lost your job tomorrow.' AS a_en, 'तीन बातें लिखिए जो आप कल नौकरी चली जाने पर भी रहेंगे।' AS a_hi, 'Teen baatein likho jo tum kal job chali jaane par bhi rahoge.' AS a_hing, 5 AS mins, 'beginner' AS diff
  UNION ALL SELECT 22, 'Think of one person you have said something like this to. Consider whether they needed the argument or the company.', 'एक व्यक्ति सोचिए जिससे आपने ऐसा कुछ कहा है। सोचिए उसे दलील चाहिए थी या साथ।', 'Ek insaan socho jisse tumne aisa kuch kaha hai. Socho use dalil chahiye thi ya saath.', 4, 'beginner'
  UNION ALL SELECT 23, 'Name one fear you are carrying. Ask whether the thing you fear for can actually be cut, burned, soaked or dried.', 'एक डर बताइए जो आप ढो रहे हैं। पूछिए कि जिसके लिए डर है वह सचमुच कट, जल, भीग या सूख सकता है?', 'Ek dar batao jo tum dho rahe ho. Poocho ki jiske liye dar hai woh sach mein kat, jal, bheeg ya sookh sakta hai?', 5, 'intermediate'
  UNION ALL SELECT 27, 'Write out the version of events you keep replaying. Then underline the part that was never in anybody''s control.', 'जो दृश्य आप बार-बार दोहराते हैं उसे लिख डालिए। फिर उस हिस्से को रेखांकित कीजिए जो कभी किसी के बस में नहीं था।', 'Jo scene tum baar-baar dohrate ho use likh daalo. Phir us hisse ko underline karo jo kabhi kisi ke bas mein tha hi nahi.', 10, 'intermediate'
  UNION ALL SELECT 48, 'Before your next result arrives — a reply, a score, a decision — write one sentence about how you intend to be either way.', 'अगला नतीजा आने से पहले — कोई जवाब, कोई स्कोर, कोई फ़ैसला — एक वाक्य लिखिए कि दोनों हाल में आप कैसे रहना चाहते हैं।', 'Agla result aane se pehle — koi reply, koi score, koi faisla — ek line likho ki dono haal mein tum kaise rehna chahte ho.', 3, 'beginner'
  UNION ALL SELECT 50, 'Do one piece of work today that nobody will know you did. Notice whether the quality drops.', 'आज एक काम ऐसा कीजिए जिसका किसी को पता न चले। देखिए गुणवत्ता गिरती है या नहीं।', 'Aaj ek kaam aisa karo jiska kisi ko pata na chale. Dekho quality girti hai ya nahi.', 15, 'intermediate'
  UNION ALL SELECT 63, 'Agree with yourself now on one physical signal — standing up, leaving the room — that you will use the next time you notice clouding.', 'अभी ख़ुद से एक शारीरिक संकेत तय कर लीजिए — खड़े हो जाना, कमरे से निकल जाना — जिसे अगली बार धुंधलाहट पर इस्तेमाल करेंगे।', 'Abhi khud se ek physical signal tay kar lo — khade ho jaana, kamre se nikal jaana — jise agli baar dhundhlahat par use karoge.', 3, 'beginner'
) AS p
JOIN verses v ON v.verse_number = p.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2;

INSERT INTO verse_topics (verse_id, topic_id, relevance)
SELECT v.id, t.id, x.rel FROM (
  SELECT 20 AS vn, 'the-self' AS slug, 10 AS rel
  UNION ALL SELECT 20, 'fear', 8
  UNION ALL SELECT 20, 'grief', 7
  UNION ALL SELECT 20, 'impermanence', 7
  UNION ALL SELECT 22, 'grief', 9
  UNION ALL SELECT 22, 'impermanence', 10
  UNION ALL SELECT 22, 'the-self', 8
  UNION ALL SELECT 23, 'the-self', 9
  UNION ALL SELECT 23, 'fear', 9
  UNION ALL SELECT 23, 'steadiness', 7
  UNION ALL SELECT 27, 'grief', 10
  UNION ALL SELECT 27, 'impermanence', 8
  UNION ALL SELECT 27, 'fear', 6
  UNION ALL SELECT 48, 'steadiness', 10
  UNION ALL SELECT 48, 'action-without-attachment', 10
  UNION ALL SELECT 48, 'effort-without-result', 9
  UNION ALL SELECT 48, 'comparison', 6
  UNION ALL SELECT 50, 'action-without-attachment', 10
  UNION ALL SELECT 50, 'duty', 8
  UNION ALL SELECT 50, 'burnout', 7
  UNION ALL SELECT 50, 'comparison', 6
  UNION ALL SELECT 63, 'anger', 10
  UNION ALL SELECT 63, 'desire', 7
  UNION ALL SELECT 63, 'hard-decisions', 7
  UNION ALL SELECT 63, 'restlessness', 6
) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2
JOIN topics t ON t.slug = x.slug;

-- =====================================================================
-- 4. MODERN EXAMPLES
-- =====================================================================
-- Four per verse. Batch B raises every chapter 2 verse to eight to
-- twelve; nothing here is rewritten by that pass.
--
-- The public-life example on 2.48 describes the SHAPE of a dilemma and
-- names nobody. No living politician, party or movement is praised or
-- criticised anywhere in this file.
-- =====================================================================

DELETE e FROM modern_examples e JOIN verses v ON v.id = e.verse_id JOIN chapters c ON c.id = v.chapter_id WHERE c.chapter_number = 2 AND v.verse_number IN (20,22,23,27,48,50,63);

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

  SELECT 20 AS vn, 'corporate' AS cat, 1 AS ord,
  'The title that went with the restructure' AS t_en, 'पुनर्गठन में गया पद' AS t_hi, 'Restructure mein gaya designation' AS t_hing,
  'A reorganisation removes a layer of management. Nobody loses their job; several people lose their titles. One of them spends three months describing the change to anybody who will listen, and finds that the sentence he keeps reaching for is not about money or scope. It is that he does not know what to say at weddings when somebody asks what he does.' AS s_en,
  'पुनर्गठन में प्रबंधन की एक परत हट जाती है। नौकरी किसी की नहीं जाती; कई लोगों के पद चले जाते हैं। उनमें से एक तीन महीने तक हर सुनने वाले को यह बदलाव समझाता रहता है, और पाता है कि जो वाक्य बार-बार आता है वह पैसे या दायरे का नहीं है। वह यह है कि शादी में कोई पूछे कि आप क्या करते हैं, तो क्या कहे।' AS s_hi,
  'Restructure mein management ki ek layer hat jaati hai. Naukri kisi ki nahi jaati; kai logon ke designation chale jaate hain. Unme se ek teen mahine tak har sunne wale ko yeh badlav samjhata rehta hai, aur paata hai ki jo line baar-baar aati hai woh paise ya scope ki nahi hai. Woh yeh hai ki shaadi mein koi pooche kya karte ho, to kya kahe.' AS s_hing,
  'The verse claims something in you was not made and cannot be unmade. Whatever you think of that as metaphysics, it separates two things this man has fused: what he is, and what he is called. The title was assigned by somebody and could be unassigned by somebody. The question is what was underneath it.' AS c_en,
  'श्लोक कहता है कि आपमें कुछ ऐसा है जो बनाया नहीं गया और मिटाया नहीं जा सकता। तत्त्व के तौर पर आप जो भी मानें, यह दो चीज़ों को अलग कर देता है जिन्हें इस आदमी ने एक कर लिया था: वह क्या है, और उसे क्या कहा जाता है। पद किसी ने दिया था और कोई वापस ले सकता था। सवाल यह है कि उसके नीचे क्या था।' AS c_hi,
  'Shloka kehta hai ki tumme kuch aisa hai jo banaya nahi gaya aur mitaya nahi ja sakta. Metaphysics ke taur par tum jo bhi maano, yeh do cheezein alag kar deta hai jinhe is aadmi ne ek kar liya tha: woh kya hai, aur use kya kaha jaata hai. Designation kisi ne diya tha aur koi wapas le sakta tha. Sawaal yeh hai ki uske neeche kya tha.' AS c_hing,
  'If somebody could assign it, somebody can remove it — which tells you it was never the thing itself.' AS l_en,
  'अगर कोई इसे दे सकता था, तो कोई हटा भी सकता है — इसी से पता चलता है कि वह वह चीज़ थी ही नहीं।' AS l_hi,
  'Agar koi ise de sakta tha, to koi hata bhi sakta hai — isi se pata chalta hai ki woh woh cheez thi hi nahi.' AS l_hing,
  NULL AS src, 'beginner' AS diff, 'identity,work,title,loss,self' AS tags

  UNION ALL SELECT 20, 'healthcare', 2,
  'The diagnosis that changed the plan', 'वह जाँच जिसने योजना बदल दी', 'Woh diagnosis jisne plan badal diya',
  'A long-term condition is confirmed in someone''s early forties. The treatment is manageable; the plan is not. Everything they had assumed about the next thirty years quietly reorganises over about a fortnight. What they report finding hardest is not the symptoms. It is that they had been treating a projected future as a possession, and it turned out not to be one.',
  'चालीस के शुरुआती सालों में किसी की लंबी बीमारी की पुष्टि होती है। इलाज संभल जाता है; योजना नहीं। अगले तीस साल के बारे में जो कुछ मान रखा था, वह लगभग दो हफ़्ते में चुपचाप फिर से जमता है। सबसे मुश्किल वे लक्षणों को नहीं बताते। मुश्किल यह है कि वे एक कल्पित भविष्य को संपत्ति की तरह बरत रहे थे, और वह संपत्ति निकली ही नहीं।',
  'Chalis ke shuruaati saalon mein kisi ki lambi bimari confirm hoti hai. Ilaaj sambhal jaata hai; plan nahi. Agle tees saal ke baare mein jo maan rakha tha, woh lagbhag do hafte mein chupchap phir se jamta hai. Sabse mushkil woh symptoms ko nahi batate. Mushkil yeh hai ki woh ek soche hue future ko property ki tarah baratt rahe the, aur woh property nikli hi nahi.',
  'Read as metaphysics this verse may or may not persuade you. Read as an inventory it is immediately useful: it asks what in you was not assembled out of circumstances. A projected future was assembled. So was the body it was projected for.',
  'तत्त्व की तरह पढ़ें तो यह श्लोक आपको मनाए या न मनाए। सूची की तरह पढ़ें तो यह तुरंत काम का है: यह पूछता है कि आपमें क्या है जो परिस्थितियों से जोड़ा नहीं गया। कल्पित भविष्य जोड़ा गया था। जिस शरीर के लिए जोड़ा गया, वह भी।',
  'Metaphysics ki tarah padho to yeh shloka tumhe manaye ya na manaye. List ki tarah padho to yeh turant kaam ka hai: yeh poochta hai ki tumme kya hai jo circumstances se joda nahi gaya. Socha hua future joda gaya tha. Jis body ke liye joda gaya, woh bhi.',
  'A future is a plan, not a possession, however long you have held it.',
  'भविष्य योजना है, संपत्ति नहीं — चाहे कितने भी समय से पकड़ रखा हो।',
  'Future ek plan hai, property nahi — chahe kitne bhi time se pakad rakha ho.',
  NULL, 'intermediate', 'identity,illness,loss,future,self'

  UNION ALL SELECT 20, 'social_media', 3,
  'The account that got deleted', 'वह अकाउंट जो हट गया', 'Woh account jo delete ho gaya',
  'Eleven years of posts vanish in a platform error. Ninety thousand followers, gone, along with the archive. The person affected describes the first week as genuinely disorienting, and the second as clarifying: nobody who actually knew them had gone anywhere, and the number had been standing in for something it was not.',
  'ग्यारह साल की पोस्टें प्लेटफ़ॉर्म की एक गड़बड़ी में ग़ायब हो जाती हैं। नब्बे हज़ार फ़ॉलोअर, और पूरा संग्रह भी। जिसके साथ यह हुआ, वह पहले हफ़्ते को सचमुच भटकाने वाला बताता है और दूसरे को साफ़ करने वाला: जो लोग उसे असल में जानते थे उनमें से कोई कहीं नहीं गया, और वह संख्या किसी ऐसी चीज़ की जगह खड़ी थी जो वह थी नहीं।',
  'Gyarah saal ki posts platform ki ek galti mein gayab ho jaati hain. Nabbe hazaar followers, aur poora archive bhi. Jiske saath yeh hua woh pehle hafte ko sach mein bhatkane wala batata hai aur doosre ko saaf karne wala: jo log use asal mein jaante the unme se koi kahin nahi gaya, aur woh number kisi aisi cheez ki jagah khada tha jo woh thi nahi.',
  'A count is a thing that was made, and things that were made can be unmade. The verse points at whatever is on the other side of that line. The second week is the verse arriving on its own, without anybody quoting it.',
  'गिनती बनाई गई चीज़ है, और बनाई गई चीज़ें मिटाई जा सकती हैं। श्लोक उस रेखा के दूसरी ओर जो है उसकी ओर इशारा करता है। दूसरा हफ़्ता वही श्लोक है, अपने आप आया हुआ, बिना किसी के उद्धृत किए।',
  'Ginti banayi gayi cheez hai, aur banayi gayi cheezein mit sakti hain. Shloka us lakeer ke doosri taraf jo hai uski taraf ishara karta hai. Doosra hafta wahi shloka hai, apne aap aaya hua, bina kisi ke quote kiye.',
  'Anything with a number on it was assembled, and anything assembled can come apart.',
  'जिस पर कोई संख्या लगी है वह जोड़ी गई थी, और जो जोड़ा गया वह बिखर भी सकता है।',
  'Jispe koi number laga hai woh jodi gayi thi, aur jo joda gaya woh bikhar bhi sakta hai.',
  NULL, 'beginner', 'identity,social media,loss,followers,self'

  UNION ALL SELECT 20, 'sports', 4,
  'The injury that ended it early', 'वह चोट जिसने जल्दी ख़त्म कर दिया', 'Woh chot jisne jaldi khatam kar diya',
  'A career ends at twenty-six rather than thirty-four. The player is fit enough for ordinary life and not for the top level, which is a specific and unusual kind of loss — the body is fine, and the thing the body was for is over. The hardest question in the first year is not what to do next. It is who is asking.',
  'छब्बीस की उम्र में करियर ख़त्म हो जाता है, चौंतीस की जगह। खिलाड़ी आम ज़िंदगी के लिए फ़िट है, सबसे ऊपरी स्तर के लिए नहीं — यह एक ख़ास और असामान्य नुक़सान है: शरीर ठीक है, और शरीर जिस काम के लिए था वह ख़त्म। पहले साल का सबसे मुश्किल सवाल यह नहीं कि अब क्या करें। सवाल यह है कि पूछ कौन रहा है।',
  'Chhabbis ki umar mein career khatam ho jaata hai, chauntis ki jagah. Player aam zindagi ke liye fit hai, top level ke liye nahi — yeh ek khaas aur alag tarah ka nuksaan hai: body theek hai, aur body jis kaam ke liye thi woh khatam. Pehle saal ka sabse mushkil sawaal yeh nahi ki ab kya karein. Sawaal yeh hai ki pooch kaun raha hai.',
  'The verse asserts a continuity underneath the changing situation. Whether or not you take that literally, the practical form of it is exactly this question — the one that survives when the role does not, and that has to be answered by somebody.',
  'श्लोक बदलती स्थिति के नीचे एक निरंतरता का दावा करता है। आप इसे शब्दशः लें या न लें, इसका व्यावहारिक रूप ठीक यही सवाल है — वह जो भूमिका के जाने पर भी बचता है, और जिसका जवाब किसी को देना ही है।',
  'Shloka badalti situation ke neeche ek continuity ka claim karta hai. Tum ise literally lo ya na lo, iska practical roop theek yahi sawaal hai — woh jo role ke jaane par bhi bachta hai, aur jiska jawab kisi ko dena hi hai.',
  'When the role ends, somebody is still there asking what happens now. Start with them.',
  'भूमिका ख़त्म होने पर भी कोई वहाँ खड़ा पूछ रहा होता है कि अब क्या। शुरुआत उसी से कीजिए।',
  'Role khatam hone par bhi koi wahan khada poochta hai ki ab kya. Shuruaat usi se karo.',
  NULL, 'beginner', 'identity,sport,injury,retirement,self'

  UNION ALL SELECT 22, 'everyday_life', 1,
  'Clearing out a parent''s wardrobe', 'माता-पिता की अलमारी ख़ाली करना', 'Maa-baap ki almari khaali karna',
  'Three weeks after a funeral the family sorts through a wardrobe. Most of it goes to a donation bag without much discussion. Then somebody finds a coat that still smells of the house and the room stops. Nobody can explain why that coat and not the eleven shirts, and nobody tries.',
  'अंतिम संस्कार के तीन हफ़्ते बाद परिवार अलमारी छाँटता है। ज़्यादातर सामान बिना बहस दान वाले थैले में चला जाता है। फिर किसी को एक कोट मिलता है जिससे अब भी घर की गंध आती है और कमरा रुक जाता है। कोई नहीं बता पाता कि वही कोट क्यों और ग्यारह कमीज़ें क्यों नहीं, और कोई कोशिश भी नहीं करता।',
  'Antim sanskar ke teen hafte baad parivar almari chhaantta hai. Zyadatar saamaan bina behes donation ke thaile mein chala jaata hai. Phir kisi ko ek coat milta hai jisse abhi bhi ghar ki khushboo aati hai aur kamra ruk jaata hai. Koi nahi bata paata ki wahi coat kyun aur gyarah kameezein kyun nahi, aur koi koshish bhi nahi karta.',
  'The verse uses clothes to make death ordinary. This room is doing the reverse and doing it correctly — the clothes have become the person, briefly, because grief works that way. Both are true. The verse is not an instruction to stop what happened in that room.',
  'श्लोक कपड़ों के ज़रिये मृत्यु को साधारण बनाता है। यह कमरा उल्टा कर रहा है, और ठीक कर रहा है — कपड़े थोड़ी देर के लिए वह व्यक्ति बन गए हैं, क्योंकि शोक ऐसे ही चलता है। दोनों सच हैं। श्लोक इस कमरे में जो हुआ उसे रोकने का आदेश नहीं है।',
  'Shloka kapdon ke zariye maut ko saadharan banata hai. Yeh kamra ulta kar raha hai, aur theek kar raha hai — kapde thodi der ke liye woh insaan ban gaye hain, kyunki shok aise hi chalta hai. Dono sach hain. Shloka is kamre mein jo hua use rokne ka order nahi hai.',
  'The image is for the person who cannot act. It was never for the person holding the coat.',
  'यह उपमा उसके लिए है जो काम नहीं कर पा रहा। उसके लिए कभी नहीं थी जो कोट थामे खड़ा है।',
  'Yeh upma uske liye hai jo kaam nahi kar paa raha. Uske liye kabhi nahi thi jo coat thame khada hai.',
  NULL, 'beginner', 'grief,family,death,clothes,mourning'

  UNION ALL SELECT 22, 'bollywood', 2,
  'The soldier who does not come home', 'वह सैनिक जो लौटता नहीं', 'Woh sainik jo lautta nahi',
  'Shershaah tells a story whose ending is public record before the film starts. The audience knows. The film''s interest is therefore not in the outcome but in what the people around him do with a loss they could see coming and could not prevent — which is a different subject entirely from suspense.',
  'शेरशाह ऐसी कहानी कहती है जिसका अंत फ़िल्म शुरू होने से पहले ही सार्वजनिक है। दर्शक जानते हैं। इसलिए फ़िल्म की दिलचस्पी नतीजे में नहीं, बल्कि इसमें है कि उसके आस-पास के लोग उस नुक़सान का क्या करते हैं जिसे आते देखा जा सकता था और रोका नहीं जा सकता था — जो रहस्य से पूरी तरह अलग विषय है।',
  'Shershaah aisi kahani kehti hai jiska ant film shuru hone se pehle hi public hai. Audience jaanti hai. Isliye film ki dilchaspi result mein nahi, balki isme hai ki uske aas-paas ke log us nuksaan ka kya karte hain jise aate dekha ja sakta tha aur roka nahi ja sakta tha — jo suspense se bilkul alag vishay hai.',
  'A story where everybody knows the ending is the closest a film gets to the position this verse assumes. The question stops being whether it happens and becomes how the people left standing carry it — which is what Krishna is actually addressing on that battlefield.',
  'जिस कहानी का अंत सब जानते हैं, वह फ़िल्म उस स्थिति के सबसे क़रीब है जो यह श्लोक मानकर चलता है। सवाल यह रहता ही नहीं कि होगा या नहीं; सवाल यह बनता है कि जो खड़े रह गए वे इसे कैसे उठाते हैं — कुरुक्षेत्र पर कृष्ण असल में इसी को संबोधित कर रहे हैं।',
  'Jis kahani ka ant sab jaante hain, woh film us position ke sabse kareeb hai jo yeh shloka maan ke chalta hai. Sawaal yeh rehta hi nahi ki hoga ya nahi; sawaal yeh banta hai ki jo khade reh gaye woh ise kaise uthate hain — Kurukshetra par Krishna asal mein isi ko address kar rahe hain.',
  'When the ending is not in question, the only remaining question is how you carry it.',
  'जब अंत पर सवाल ही न हो, तब बचा हुआ इकलौता सवाल यह है कि आप उसे कैसे उठाते हैं।',
  'Jab ant par sawaal hi na ho, tab bacha hua ek hi sawaal hai ki tum use kaise uthate ho.',
  'Shershaah (2021)', 'beginner', 'grief,duty,film,loss,inevitability'

  UNION ALL SELECT 22, 'technology', 3,
  'Migrating off the old system', 'पुराने सिस्टम से हटना', 'Purane system se hatna',
  'A company replaces a platform that has run the business for fourteen years. Technically the migration is fine. What surprises everyone is the mourning — people who complained about that system weekly for a decade turn out to have organised their working identity around knowing it, and for a few months nobody is quite as good at their job.',
  'एक कंपनी उस प्लेटफ़ॉर्म को बदलती है जिस पर चौदह साल से कारोबार चला है। तकनीकी रूप से माइग्रेशन ठीक रहता है। सबको हैरानी होती है शोक से — जो लोग दस साल से हर हफ़्ते उस सिस्टम की शिकायत करते थे, उनकी कामकाजी पहचान उसी को जानने पर टिकी निकलती है, और कुछ महीने कोई भी अपने काम में उतना अच्छा नहीं रहता।',
  'Ek company us platform ko badalti hai jispe chaudah saal se business chala hai. Technically migration theek rehta hai. Sabko hairani hoti hai shok se — jo log das saal se har hafte us system ki shikayat karte the, unki working identity usi ko jaanne par tiki nikalti hai, aur kuch mahine koi bhi apne kaam mein utna achha nahi rehta.',
  'The verse says the wearer continues and the garment does not. Here the garment is expertise in a particular tool, and the discovery is how much of what people took to be competence was garment. The competence returns. It just has to be re-clothed.',
  'श्लोक कहता है कि पहनने वाला बना रहता है, कपड़ा नहीं। यहाँ कपड़ा है किसी एक औज़ार की महारत, और खोज यह है कि जिसे लोग योग्यता समझते थे उसका कितना हिस्सा कपड़ा था। योग्यता लौट आती है। बस उसे दोबारा पहनाना पड़ता है।',
  'Shloka kehta hai ki pehnne wala bana rehta hai, kapda nahi. Yahan kapda hai kisi ek tool ki maharat, aur khoj yeh hai ki jise log kabiliyat samajhte the uska kitna hissa kapda tha. Kabiliyat laut aati hai. Bas use dobara pehnana padta hai.',
  'Some of what feels like competence is a particular set of clothes. It grows back.',
  'जिसे योग्यता समझते हैं उसका कुछ हिस्सा एक ख़ास पोशाक होती है। वह दोबारा उग आती है।',
  'Jise kabiliyat samajhte ho uska kuch hissa ek khaas poshak hoti hai. Woh dobara ug aati hai.',
  NULL, 'intermediate', 'change,work,identity,technology,expertise'

  UNION ALL SELECT 22, 'school', 4,
  'The last day of school', 'स्कूल का आख़िरी दिन', 'School ka aakhri din',
  'Eighteen-year-olds sign each other''s shirts and cry in a corridor they have complained about for six years. Within four months most of them cannot reconstruct why it felt so final. Nothing they were afraid of losing was lost; the friendships that were going to survive did, and the ones that were not had already been thinning for a year.',
  'अठारह साल के बच्चे एक-दूसरे की कमीज़ों पर हस्ताक्षर करते हैं और उसी गलियारे में रोते हैं जिसकी शिकायत वे छह साल से कर रहे थे। चार महीने के भीतर उनमें से ज़्यादातर यह जोड़ ही नहीं पाते कि इतना आख़िरी क्यों लगा था। जिसके खोने का डर था, वह कुछ खोया नहीं; जो दोस्तियाँ टिकने वाली थीं टिक गईं, और जो नहीं थीं वे साल भर से पतली पड़ रही थीं।',
  'Atharah saal ke bachche ek doosre ki kameezon par sign karte hain aur usi corridor mein rote hain jiski shikayat woh chhe saal se kar rahe the. Chaar mahine ke andar unme se zyadatar yeh jod hi nahi paate ki itna aakhri kyun laga tha. Jiske khone ka dar tha woh kuch khoya nahi; jo dostiyaan tikne wali thi tik gayin, aur jo nahi thi woh saal bhar se patli pad rahi thi.',
  'A uniform is the most literal version of the verse''s image, and it comes off on a known date. What the corridor is actually grieving is a shape of life, not the people in it — and the shape was always temporary in a way everybody had agreed not to think about.',
  'वर्दी इस श्लोक की उपमा का सबसे शाब्दिक रूप है, और वह एक तय तारीख़ पर उतरती है। गलियारा असल में जिस चीज़ का शोक कर रहा है वह ज़िंदगी का एक आकार है, उसमें मौजूद लोग नहीं — और वह आकार हमेशा से अस्थायी था, बस सबने उस पर न सोचने की सहमति बना रखी थी।',
  'Vardi is shloka ki upma ka sabse literal roop hai, aur woh ek tay date par utarti hai. Corridor asal mein jis cheez ka shok kar raha hai woh zindagi ka ek shape hai, usme maujood log nahi — aur woh shape hamesha temporary tha, bas sabne uspe na sochne ki sehmati bana rakhi thi.',
  'You are usually mourning the shape of a life, not the people in it. The people are reachable.',
  'आप आमतौर पर ज़िंदगी के आकार का शोक करते हैं, उसमें मौजूद लोगों का नहीं। लोग तो पहुँच में हैं।',
  'Tum aksar zindagi ke shape ka shok karte ho, usme maujood logon ka nahi. Log to pahunch mein hain.',
  NULL, 'beginner', 'change,school,friendship,endings,identity'

  UNION ALL SELECT 23, 'ethics', 1,
  'The complaint that was investigated and dropped', 'वह शिकायत जिसकी जाँच हुई और बात ख़त्म हुई', 'Woh shikayat jiski jaanch hui aur baat khatam hui',
  'An allegation is made about someone at work. It is investigated over five weeks and found to be unsupported. The finding is circulated. Two years later they still notice a pause before certain people speak to them, and cannot tell whether the pause is real or something they are supplying themselves.',
  'दफ़्तर में किसी पर आरोप लगता है। पाँच हफ़्ते जाँच होती है और आरोप निराधार पाया जाता है। नतीजा सबको भेजा जाता है। दो साल बाद भी उन्हें कुछ लोगों के बोलने से पहले एक ठहराव महसूस होता है, और वे तय नहीं कर पाते कि वह ठहराव सचमुच है या वे ख़ुद उसे जोड़ रहे हैं।',
  'Office mein kisi par aarop lagta hai. Paanch hafte jaanch hoti hai aur aarop galat paaya jaata hai. Result sabko bhej diya jaata hai. Do saal baad bhi unhe kuch logon ke bolne se pehle ek thehrav mehsoos hota hai, aur woh tay nahi kar paate ki woh thehrav sach mein hai ya woh khud use jod rahe hain.',
  'The verse asks a prior question: is this the kind of thing damage applies to. A reputation demonstrably is — it can be cut. But the verse separates that from whatever is underneath, and the two-year pause suggests this person has stopped distinguishing them.',
  'श्लोक उससे पहले वाला सवाल पूछता है: क्या यह उस तरह की चीज़ है जिस पर चोट लागू होती है। साख पर तो साफ़ होती है — वह काटी जा सकती है। पर श्लोक उसे उस चीज़ से अलग करता है जो नीचे है, और दो साल का वह ठहराव बताता है कि इस व्यक्ति ने दोनों में फ़र्क़ करना छोड़ दिया है।',
  'Shloka usse pehle wala sawaal poochta hai: kya yeh us tarah ki cheez hai jispe chot lagoo hoti hai. Reputation par to saaf hoti hai — woh kaati ja sakti hai. Par shloka use us cheez se alag karta hai jo neeche hai, aur do saal ka woh thehrav batata hai ki is insaan ne dono mein farq karna chhod diya hai.',
  'What people think of you can be cut. Whether you did the thing cannot.',
  'लोग आपके बारे में क्या सोचते हैं, वह काटा जा सकता है। आपने वह किया या नहीं, वह नहीं।',
  'Log tumhare baare mein kya sochte hain woh kaata ja sakta hai. Tumne woh kiya ya nahi, woh nahi.',
  NULL, 'advanced', 'reputation,fear,work,integrity,self'

  UNION ALL SELECT 23, 'social_media', 2,
  'The pile-on', 'सामूहिक हमला', 'Pile-on',
  'A badly worded post reaches the wrong audience on a Sunday evening. By Monday morning there are four thousand replies, most from people who have never met the author and will not remember this by Wednesday. The author reads all four thousand.',
  'रविवार शाम एक बुरी तरह लिखी पोस्ट ग़लत लोगों तक पहुँच जाती है। सोमवार सुबह तक चार हज़ार जवाब हैं, ज़्यादातर उन लोगों के जो लेखक से कभी मिले नहीं और बुधवार तक यह याद भी नहीं रखेंगे। लेखक चारों हज़ार पढ़ता है।',
  'Ravivar shaam ek buri tarah likhi post galat logon tak pahunch jaati hai. Somwar subah tak chaar hazaar replies hain, zyadatar un logon ke jo lekhak se kabhi mile nahi aur budhwar tak yeh yaad bhi nahi rakhenge. Lekhak chaaron hazaar padhta hai.',
  'The verse lists four ways of destroying a thing and denies all four. The pile-on is a fifth way that did not exist when it was written, and the question it raises is the same one: what exactly is being cut here. Reading all four thousand is the act of somebody who has answered "me".',
  'श्लोक नष्ट करने के चार तरीक़े गिनाकर चारों का इनकार करता है। यह सामूहिक हमला पाँचवाँ तरीक़ा है, जो लिखे जाते समय था ही नहीं, और सवाल वही उठता है: यहाँ कट क्या रहा है। चारों हज़ार पढ़ना उस आदमी का काम है जिसने जवाब दे दिया है — "मैं"।',
  'Shloka khatam karne ke chaar tareeke gina ke chaaron ka inkaar karta hai. Yeh pile-on paanchwa tareeka hai, jo likhe jaate waqt tha hi nahi, aur sawaal wahi uthta hai: yahan kat kya raha hai. Chaaron hazaar padhna us aadmi ka kaam hai jisne jawab de diya hai — "main".',
  'Reading all of them is not research. It is agreeing with them about what can be cut.',
  'सब पढ़ लेना जाँच नहीं है। वह उनसे सहमत होना है कि कट क्या सकता है।',
  'Sab padh lena research nahi hai. Woh unse sehmat hona hai ki kat kya sakta hai.',
  NULL, 'beginner', 'fear,social media,criticism,self,pile-on'

  UNION ALL SELECT 23, 'startup', 3,
  'The company that failed publicly', 'वह कंपनी जो सबके सामने बंद हुई', 'Woh company jo sabke saamne band hui',
  'A well-funded startup shuts down and the coverage is unkind. Two of the three founders take contract work quietly for a year. The third writes a long, exact account of what went wrong, publishes it, and is hiring for something new within eight months — not because the account was flattering, but because it demonstrated the thing the failure had supposedly destroyed.',
  'अच्छी फ़ंडिंग वाली एक कंपनी बंद होती है और कवरेज कड़वी रहती है। तीन में से दो संस्थापक साल भर चुपचाप ठेके का काम करते हैं। तीसरा जो गलत हुआ उसका लंबा, सटीक ब्योरा लिखता है, छापता है, और आठ महीने में कुछ नया शुरू करके भर्ती कर रहा होता है — इसलिए नहीं कि ब्योरा तारीफ़ भरा था, बल्कि इसलिए कि उसने वही दिखा दिया जिसे असफलता ने कथित रूप से नष्ट किया था।',
  'Achhi funding wali ek company band hoti hai aur coverage kadwi rehti hai. Teen mein se do founders saal bhar chupchap contract kaam karte hain. Teesra jo galat hua uska lamba, theek-theek byora likhta hai, publish karta hai, aur aath mahine mein kuch naya shuru kar ke hiring kar raha hota hai — isliye nahi ki byora taareef bhara tha, balki isliye ki usne wahi dikha diya jise failure ne kathit roop se khatam kiya tha.',
  'The verse insists that some things are not the kind of thing that can be destroyed. Judgement, honesty and the capacity to look straight at a mistake are in that category. The coverage cut the company. It never had access to those.',
  'श्लोक ज़ोर देता है कि कुछ चीज़ें उस तरह की हैं ही नहीं जिन्हें नष्ट किया जा सके। विवेक, ईमानदारी और अपनी ग़लती को सीधे देख पाने की क्षमता उसी श्रेणी में हैं। कवरेज ने कंपनी को काटा। उन चीज़ों तक उसकी पहुँच कभी थी ही नहीं।',
  'Shloka zor deta hai ki kuch cheezein us tarah ki hain hi nahi jinhe khatam kiya ja sake. Vivek, imaandari aur apni galti ko seedha dekh paane ki kshamta usi category mein hain. Coverage ne company ko kaata. Un cheezon tak uski pahunch kabhi thi hi nahi.',
  'A failure can take the company. It has no mechanism for taking your judgement.',
  'असफलता कंपनी ले जा सकती है। आपका विवेक ले जाने का उसके पास कोई तरीक़ा नहीं।',
  'Failure company le ja sakti hai. Tumhara vivek le jaane ka uske paas koi tareeka nahi.',
  NULL, 'intermediate', 'failure,startup,reputation,self,recovery'

  UNION ALL SELECT 23, 'military', 4,
  'What the training is actually for', 'प्रशिक्षण असल में किसलिए है', 'Training asal mein kis liye hai',
  'Selection for a demanding unit is designed to find the point where somebody stops being themselves — cold, hungry, sleepless, and asked to make decisions. Most people who fail do not fail physically. They fail at the moment the discomfort persuades them that the discomfort is who they now are.',
  'किसी कठिन इकाई का चयन इसी के लिए बना है कि वह बिंदु मिल जाए जहाँ आदमी ख़ुद होना बंद कर देता है — ठंड, भूख, बिना नींद, और ऊपर से फ़ैसले लेने को कहा जाए। जो असफल होते हैं उनमें ज़्यादातर शारीरिक रूप से असफल नहीं होते। वे उस पल असफल होते हैं जब तकलीफ़ उन्हें यह मना लेती है कि अब वे तकलीफ़ ही हैं।',
  'Kisi mushkil unit ka selection isi ke liye bana hai ki woh point mil jaaye jahan aadmi khud hona band kar deta hai — thand, bhookh, bina neend, aur upar se decisions lene ko kaha jaaye. Jo fail hote hain unme zyadatar physically fail nahi hote. Woh us pal fail hote hain jab takleef unhe yeh mana leti hai ki ab woh takleef hi hain.',
  'Fire, water and wind are on the verse''s list, and this is what testing all three at once looks like. The claim being tested is exactly the verse''s: whether there is something in a person that the elements do not reach.',
  'आग, पानी और हवा श्लोक की सूची में हैं, और तीनों को एक साथ जाँचना ऐसा ही दिखता है। जिस दावे की परीक्षा हो रही है वह ठीक श्लोक का दावा है: क्या आदमी में कुछ ऐसा है जहाँ तत्त्व पहुँचते ही नहीं।',
  'Aag, paani aur hawa shloka ki list mein hain, aur teenon ko ek saath test karna aisa hi dikhta hai. Jis claim ka test ho raha hai woh theek shloka ka claim hai: kya aadmi mein kuch aisa hai jahan tatva pahunchte hi nahi.',
  'Most people do not break. They agree, at some point, that the conditions are now their identity.',
  'ज़्यादातर लोग टूटते नहीं। वे किसी मोड़ पर मान लेते हैं कि अब हालात ही उनकी पहचान हैं।',
  'Zyadatar log tootte nahi. Woh kisi mod par maan lete hain ki ab haalat hi unki pehchan hain.',
  NULL, 'advanced', 'endurance,identity,pressure,service,self'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2;

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

  SELECT 27 AS vn, 'healthcare' AS cat, 1 AS ord,
  'The appointment that was three weeks earlier' AS t_en, 'वह अपॉइंटमेंट जो तीन हफ़्ते पहले था' AS t_hi, 'Woh appointment jo teen hafte pehle tha' AS t_hing,
  'After a death in the family, one person returns repeatedly to a decision made months earlier — a scan that could have been booked sooner. The clinicians have said, more than once and without hedging, that it would have made no difference. The information does not stop the replaying. It runs most nights between about eleven and one.' AS s_en,
  'परिवार में मृत्यु के बाद एक व्यक्ति महीनों पुराने एक फ़ैसले पर बार-बार लौटता है — एक जाँच जो जल्दी करवाई जा सकती थी। डॉक्टर एक से ज़्यादा बार, बिना किसी हिचक के कह चुके हैं कि इससे कोई फ़र्क़ नहीं पड़ता। यह जानकारी दोहराव को रोकती नहीं। वह ज़्यादातर रातों में ग्यारह से एक के बीच चलता है।' AS s_hi,
  'Parivar mein maut ke baad ek insaan mahinon purane ek faisle par baar-baar lautta hai — ek scan jo jaldi karwaya ja sakta tha. Doctors ek se zyada baar, bina kisi hichak ke keh chuke hain ki isse koi farq nahi padta. Yeh jaankari dohrav ko rokti nahi. Woh zyadatar raaton mein gyarah se ek ke beech chalta hai.' AS s_hing,
  'The verse is aimed exactly here, and it is worth being precise about what it does and does not reach. It has nothing to say to the missing. It speaks only to the machinery searching for a version of events in which the unavoidable was avoided — and that machinery is what the eleven-to-one shift is.' AS c_en,
  'श्लोक का निशाना ठीक यहीं है, और यह साफ़ कहना ज़रूरी है कि वह कहाँ तक पहुँचता है और कहाँ नहीं। कमी खलने से उसे कुछ नहीं कहना। वह सिर्फ़ उस मशीन से बात करता है जो घटनाओं का ऐसा रूप ढूँढ़ रही है जिसमें जो टल नहीं सकता था वह टल गया हो — और ग्यारह से एक की वह पाली वही मशीन है।' AS c_hi,
  'Shloka ka nishana theek yahin hai, aur yeh saaf kehna zaroori hai ki woh kahan tak pahunchta hai aur kahan nahi. Kami khalne se use kuch nahi kehna. Woh sirf us machine se baat karta hai jo ghatnaon ka aisa version dhoondh rahi hai jisme jo tal nahi sakta tha woh tal gaya ho — aur gyarah se ek ki woh shift wahi machine hai.' AS c_hing,
  'The search is not for information. It is for a version of events that does not exist.' AS l_en,
  'यह खोज जानकारी की नहीं है। यह घटनाओं के ऐसे रूप की है जो है ही नहीं।' AS l_hi,
  'Yeh khoj jaankari ki nahi hai. Yeh ghatnaon ke aise version ki hai jo hai hi nahi.' AS l_hing,
  NULL AS src, 'intermediate' AS diff, 'grief,guilt,illness,rumination,family' AS tags

  UNION ALL SELECT 27, 'everyday_life', 2,
  'The pet that got old', 'वह पालतू जो बूढ़ा हो गया', 'Woh pet jo boodha ho gaya',
  'A dog reaches fourteen. Everybody in the house has known for two years roughly how this ends, and knowing has not helped at all in the week it actually happens. A child asks why they did not get a dog that lives longer, which is the most honest version of the question the adults are also asking.',
  'कुत्ता चौदह का हो जाता है। घर में सबको दो साल से लगभग पता है कि यह कैसे ख़त्म होगा, और जिस हफ़्ते सचमुच होता है उस हफ़्ते जानने से कोई मदद नहीं मिलती। एक बच्चा पूछता है कि ऐसा कुत्ता क्यों नहीं लिया जो ज़्यादा जीता — जो उसी सवाल का सबसे ईमानदार रूप है जो बड़े भी पूछ रहे हैं।',
  'Kutta chaudah ka ho jaata hai. Ghar mein sabko do saal se lagbhag pata hai ki yeh kaise khatam hoga, aur jis hafte sach mein hota hai us hafte jaanne se koi madad nahi milti. Ek bachcha poochta hai ki aisa kutta kyun nahi liya jo zyada jeeta — jo usi sawaal ka sabse imaandaar roop hai jo bade bhi pooch rahe hain.',
  'The child''s question is the verse''s subject stated without any of the adult decoration. There was no arrangement available in which you got the fourteen years and not the ending. Knowing that in advance turns out to help with planning and not at all with the week itself, which the verse does not pretend otherwise about.',
  'बच्चे का सवाल श्लोक का ही विषय है, बड़ों वाली सजावट के बिना। ऐसा कोई इंतज़ाम था ही नहीं जिसमें चौदह साल मिलते और अंत न मिलता। यह पहले से जानना योजना में काम आता है और उस हफ़्ते में बिलकुल नहीं — और श्लोक इस बारे में कुछ और होने का दावा भी नहीं करता।',
  'Bachche ka sawaal shloka ka hi vishay hai, badon wali sajawat ke bina. Aisa koi intezaam tha hi nahi jisme chaudah saal milte aur ant na milta. Yeh pehle se jaanna planning mein kaam aata hai aur us hafte mein bilkul nahi — aur shloka iske baare mein kuch aur hone ka dawa bhi nahi karta.',
  'Knowing in advance helps with planning. It does not help with the week, and it was never meant to.',
  'पहले से जानना योजना में मदद करता है। उस हफ़्ते में नहीं, और उसका ऐसा इरादा कभी था भी नहीं।',
  'Pehle se jaanna planning mein madad karta hai. Us hafte mein nahi, aur uska aisa iraada kabhi tha bhi nahi.',
  NULL, 'beginner', 'grief,family,pets,inevitability,children'

  UNION ALL SELECT 27, 'finance', 3,
  'The market that was always going to turn', 'वह बाज़ार जो मुड़ना ही था', 'Woh market jo mudna hi tha',
  'A downturn arrives after a long run of good years. Somebody who has been investing for two decades knows the cycle in the abstract and still spends the first month furious — not at any decision they made, which were reasonable, but at the fact of the cycle itself, as though it had broken a promise nobody made.',
  'कई अच्छे सालों के बाद मंदी आती है। दो दशक से निवेश कर रहा कोई व्यक्ति चक्र को सिद्धांत रूप में जानता है और फिर भी पहला महीना ग़ुस्से में बिताता है — अपने किसी फ़ैसले पर नहीं, जो ठीक ही थे, बल्कि चक्र के होने पर ही, मानो उसने कोई वादा तोड़ा हो जो किसी ने किया ही नहीं था।',
  'Kai achhe saalon ke baad mandi aati hai. Do dashak se invest kar raha koi insaan cycle ko theory mein jaanta hai aur phir bhi pehla mahina gusse mein bitata hai — apne kisi faisle par nahi, jo theek hi the, balki cycle ke hone par hi, jaise usne koi waada toda ho jo kisi ne kiya hi nahi tha.',
  'The verse separates two responses that feel identical from the inside: adjusting to a fact, and objecting to it. Twenty years of experience handles the first perfectly well. The furious month is entirely the second, and no amount of further experience shortens it.',
  'श्लोक दो प्रतिक्रियाओं को अलग करता है जो भीतर से एक जैसी लगती हैं: किसी तथ्य के अनुसार ढलना, और उस तथ्य पर आपत्ति करना। बीस साल का अनुभव पहली को बख़ूबी सँभाल लेता है। ग़ुस्से वाला महीना पूरा दूसरा है, और और अनुभव उसे छोटा नहीं करता।',
  'Shloka do reactions ko alag karta hai jo andar se ek jaisi lagti hain: kisi fact ke hisaab se dhalna, aur us fact par objection karna. Bees saal ka experience pehli ko achhe se sambhal leta hai. Gusse wala mahina poora doosra hai, aur aur experience use chhota nahi karta.',
  'Experience teaches you to adjust. It does not stop you objecting, and objecting is the expensive part.',
  'अनुभव ढलना सिखाता है। आपत्ति करना नहीं रोकता — और महँगा हिस्सा आपत्ति ही है।',
  'Experience dhalna sikhata hai. Objection karna nahi rokta — aur mehnga hissa objection hi hai.',
  NULL, 'intermediate', 'money,markets,acceptance,anger,cycles'

  UNION ALL SELECT 48, 'cricket', 1,
  'The captain who looks the same at 40 for 3', 'वह कप्तान जो 40 पर 3 विकेट पर भी वही दिखता है', 'Woh captain jo 40 par 3 par bhi wahi dikhta hai',
  'Two hours into a Test match the side is three down for not very many, and the camera goes to the balcony. Some captains are visibly rearranging their face. A few are not — same posture, same instructions, same tone with the twelfth man. The dressing room reads that in about four seconds and plays accordingly for the rest of the day.',
  'टेस्ट मैच के दो घंटे में टीम के तीन विकेट कम रन पर गिर चुके हैं, और कैमरा बालकनी की ओर जाता है। कुछ कप्तान साफ़ दिखते हुए अपना चेहरा ठीक कर रहे होते हैं। कुछ नहीं — वही मुद्रा, वही निर्देश, बारहवें खिलाड़ी से वही लहजा। ड्रेसिंग रूम इसे लगभग चार सेकंड में पढ़ लेता है और बाकी दिन उसी हिसाब से खेलता है।',
  'Test match ke do ghante mein team ke teen wicket kam run par gir chuke hain, aur camera balcony ki taraf jaata hai. Kuch captains saaf dikhte hue apna chehra theek kar rahe hote hain. Kuch nahi — wahi posture, wahi instructions, barahvein khiladi se wahi lehja. Dressing room ise lagbhag chaar second mein padh leta hai aur baaki din usi hisaab se khelta hai.',
  'This is samatvam with a camera on it. The verse defines yoga as being the same in success and failure, and a captaincy is the rare job where that quality is directly observable and immediately consequential. Nobody in that room is reading the scoreboard for information about how worried to be. They are reading a face.',
  'यह समत्व है, कैमरे के सामने। श्लोक योग को सफलता और असफलता में एक-सा रहना कहता है, और कप्तानी उन दुर्लभ कामों में है जहाँ यह गुण सीधे दिखता है और तुरंत असर करता है। उस कमरे में कोई भी स्कोरबोर्ड से यह नहीं पढ़ रहा कि कितना घबराना है। सब एक चेहरा पढ़ रहे हैं।',
  'Yeh samatvam hai, camera ke saamne. Shloka yoga ko safalta aur asafalta mein ek-sa rehna kehta hai, aur captaincy un rare kaamon mein hai jahan yeh quality seedha dikhti hai aur turant asar karti hai. Us kamre mein koi bhi scoreboard se yeh nahi padh raha ki kitna ghabrana hai. Sab ek chehra padh rahe hain.',
  'Evenness is not a private virtue. In any group, one person''s face is everybody else''s information.',
  'समता निजी गुण नहीं है। किसी भी समूह में एक आदमी का चेहरा बाकी सबकी जानकारी होता है।',
  'Samta private virtue nahi hai. Kisi bhi group mein ek aadmi ka chehra baaki sabki information hota hai.',
  NULL, 'beginner', 'steadiness,leadership,cricket,pressure,yoga'

  UNION ALL SELECT 48, 'politics', 2,
  'Conceding without changing shape', 'हार मानते हुए भी वही रहना', 'Haar maante hue bhi wahi rehna',
  'An official body loses a long argument it had made in good faith. The decision goes the other way. What the people watching notice is not the outcome, which was reported in one line, but whether those who lost implement it with the same care they would have given their own position. Some do. The difference is visible for years afterwards in how much anybody trusts the process.',
  'कोई संस्था अपनी ही ईमानदारी से रखी लंबी दलील हार जाती है। फ़ैसला दूसरी ओर जाता है। देखने वालों की नज़र नतीजे पर नहीं जाती, जो एक पंक्ति में छप गया, बल्कि इस पर जाती है कि हारने वाले उसे उसी ध्यान से लागू करते हैं या नहीं जो अपनी बात को देते। कुछ करते हैं। यह फ़र्क़ सालों तक इसमें दिखता है कि प्रक्रिया पर कोई कितना भरोसा करता है।',
  'Koi sanstha apni hi imaandari se rakhi lambi dalil haar jaati hai. Faisla doosri taraf jaata hai. Dekhne walon ki nazar result par nahi jaati, jo ek line mein chhap gaya, balki is par jaati hai ki haarne wale use usi dhyan se lagoo karte hain ya nahi jo apni baat ko dete. Kuch karte hain. Yeh farq saalon tak isme dikhta hai ki process par koi kitna bharosa karta hai.',
  'Siddhi and asiddhi — success and failure — is exactly this pair. The verse does not ask anybody to stop having a position. It asks for the same person to be present after the result as before it. This is the shape of that dilemma, stated without reference to any particular body or any particular argument.',
  'सिद्धि और असिद्धि — सफलता और असफलता — यही जोड़ी है। श्लोक किसी से यह नहीं कहता कि अपनी राय रखना छोड़ दे। वह यह कहता है कि नतीजे के बाद भी वही आदमी मौजूद रहे जो पहले था। यह उसी दुविधा का ढाँचा है, बिना किसी ख़ास संस्था या ख़ास दलील के संदर्भ के।',
  'Siddhi aur asiddhi — safalta aur asafalta — yahi jodi hai. Shloka kisi se yeh nahi kehta ki apni raay rakhna chhod de. Woh yeh kehta hai ki result ke baad bhi wahi aadmi maujood rahe jo pehle tha. Yeh usi dilemma ka shape hai, bina kisi khaas sanstha ya khaas dalil ke reference ke.',
  'Losing well is a separate skill from arguing well, and it is the one people remember.',
  'अच्छे से हारना, अच्छी दलील देने से अलग कौशल है — और लोग वही याद रखते हैं।',
  'Achhe se haarna, achhi dalil dene se alag skill hai — aur log wahi yaad rakhte hain.',
  NULL, 'advanced', 'steadiness,duty,institutions,defeat,integrity'

  UNION ALL SELECT 48, 'relationships', 3,
  'The one who is the same after either answer', 'वह जो दोनों जवाबों के बाद वही रहता है', 'Woh jo dono jawabon ke baad wahi rehta hai',
  'Somebody asks a friend for a significant favour — money, a reference, a place to stay. The friend says no, with a reason. What happens over the following fortnight is the actual test: whether the person who asked is the same towards them as they were before, or whether a small permanent adjustment has been made and neither of them will name it.',
  'कोई दोस्त से बड़ा एहसान माँगता है — पैसा, सिफ़ारिश, रहने की जगह। दोस्त कारण बताकर मना कर देता है। असली परीक्षा अगले पंद्रह दिन में होती है: जिसने माँगा था वह उसके प्रति वैसा ही रहता है जैसा पहले था, या कोई छोटा स्थायी समायोजन हो जाता है जिसे दोनों में से कोई नाम नहीं देगा।',
  'Koi dost se bada ehsaan maangta hai — paisa, reference, rehne ki jagah. Dost wajah bata ke mana kar deta hai. Asli test agle pandrah din mein hota hai: jisne maanga tha woh uske prati waisa hi rehta hai jaisa pehle tha, ya koi chhota permanent adjustment ho jaata hai jise dono mein se koi naam nahi dega.',
  'The verse is usually read as being about your own outcomes. It applies just as exactly to how you hold other people once they have produced an outcome you did not want. Evenness here is not indifference to the no. It is the friendship not being repriced by it.',
  'श्लोक को आमतौर पर अपने नतीजों के बारे में पढ़ा जाता है। यह उतना ही ठीक इस पर भी लागू होता है कि जब कोई आपको मनचाहा नतीजा न दे, तब आप उसे कैसे थामे रहते हैं। यहाँ समता उस मना पर उदासीनता नहीं है। यह है कि दोस्ती की क़ीमत उससे दोबारा तय न हो।',
  'Shloka ko aksar apne results ke baare mein padha jaata hai. Yeh utna hi theek is par bhi lagoo hota hai ki jab koi tumhe manchaha result na de, tab tum use kaise thame rehte ho. Yahan samta us mana par udaseenta nahi hai. Yeh hai ki dosti ki keemat usse dobara tay na ho.',
  'Evenness is not only about your results. It is about not repricing people who gave you the wrong one.',
  'समता सिर्फ़ अपने नतीजों की बात नहीं है। यह उन लोगों की क़ीमत दोबारा तय न करने की बात है जिन्होंने ग़लत नतीजा दिया।',
  'Samta sirf apne results ki baat nahi hai. Yeh un logon ki keemat dobara tay na karne ki baat hai jinhone galat jawab diya.',
  NULL, 'intermediate', 'steadiness,friendship,rejection,relationships,yoga'

  UNION ALL SELECT 50, 'corporate', 1,
  'The handover nobody saw', 'वह हैंडओवर जो किसी ने नहीं देखा', 'Woh handover jo kisi ne nahi dekha',
  'Somebody leaving a role spends their last fortnight writing documentation nobody asked for — what breaks, who to call, which decisions were deliberate and which were accidents that stuck. They are gone before anybody reads it. Eighteen months later three people who never met them are still working from that document.',
  'भूमिका छोड़ रहा कोई व्यक्ति अपने आख़िरी पंद्रह दिन ऐसा दस्तावेज़ लिखने में लगाता है जो किसी ने माँगा नहीं — क्या टूटता है, किसे फ़ोन करना है, कौन-से फ़ैसले जानबूझकर थे और कौन-से हादसे थे जो टिक गए। पढ़ने से पहले ही वह जा चुका होता है। अठारह महीने बाद तीन ऐसे लोग, जो उससे कभी मिले नहीं, अब भी उसी दस्तावेज़ से काम कर रहे हैं।',
  'Role chhod raha koi insaan apne aakhri pandrah din aisa document likhne mein lagata hai jo kisi ne maanga nahi — kya tootta hai, kise phone karna hai, kaun se faisle jaan-boojh ke the aur kaun se haadse the jo tik gaye. Padhne se pehle hi woh ja chuka hota hai. Atharah mahine baad teen aise log, jo usse kabhi mile nahi, abhi bhi usi document se kaam kar rahe hain.',
  'This is the verse''s definition rather than the poster''s. There was no credit available — they had already left, and nobody was watching. What remained was skill in the action itself, performed with the credit and the blame both put down because neither was on offer.',
  'यह पोस्टर वाली नहीं, श्लोक वाली परिभाषा है। यहाँ श्रेय था ही नहीं — वह जा चुका था और कोई देख नहीं रहा था। जो बचा वह कर्म में ही कुशलता थी, श्रेय और दोष दोनों नीचे रखकर की गई, क्योंकि दोनों में से कोई उपलब्ध ही नहीं था।',
  'Yeh poster wali nahi, shloka wali definition hai. Yahan credit tha hi nahi — woh ja chuka tha aur koi dekh nahi raha tha. Jo bacha woh karm mein hi kushalta thi, credit aur blame dono neeche rakh ke ki gayi, kyunki dono mein se koi available hi nahi tha.',
  'The clearest test of skill in action is work done where no credit was ever available.',
  'कर्म में कुशलता की सबसे साफ़ परीक्षा वह काम है जिसमें श्रेय था ही नहीं।',
  'Karm mein kushalta ka sabse saaf test woh kaam hai jisme credit tha hi nahi.',
  NULL, 'beginner', 'work,credit,handover,skill,detachment'

  UNION ALL SELECT 50, 'bollywood', 2,
  'The teacher who is not the point', 'वह शिक्षक जो ख़ुद मुद्दा नहीं है', 'Woh teacher jo khud mudda nahi hai',
  'In Taare Zameen Par a teacher works out what is wrong with a child and then spends the rest of the film arranging for other people — parents, the school, the boy himself — to see it. The film is careful about this: the sequence that resolves everything belongs to the child, not to him, and he is standing at the back of the room for it.',
  'तारे ज़मीन पर में एक शिक्षक समझ लेता है कि बच्चे के साथ क्या है, और बाकी फ़िल्म यह इंतज़ाम करने में लगाता है कि दूसरे लोग — माता-पिता, स्कूल, ख़ुद वह लड़का — इसे देख सकें। फ़िल्म इस बारे में सावधान है: जो दृश्य सब सुलझाता है वह बच्चे का है, उसका नहीं, और वह उस समय कमरे के पीछे खड़ा है।',
  'Taare Zameen Par mein ek teacher samajh leta hai ki bachche ke saath kya hai, aur baaki film yeh intezaam karne mein lagata hai ki doosre log — maa-baap, school, khud woh ladka — ise dekh sakein. Film is baare mein saavdhan hai: jo scene sab sulajhata hai woh bachche ka hai, uska nahi, aur woh us waqt kamre ke peeche khada hai.',
  'Skill in action, in the sense this verse means, looks like arranging an outcome you will not be standing in front of. The teacher is extremely good at his job and the job is structured so that its success belongs to somebody else. That is what putting down both the credit and the blame looks like when it is done well.',
  'इस श्लोक के अर्थ में कर्म-कुशलता ऐसी दिखती है: ऐसा नतीजा बनाना जिसके सामने आप खड़े नहीं होंगे। वह शिक्षक अपने काम में बेहद अच्छा है और काम का ढाँचा ऐसा है कि उसकी सफलता किसी और की होती है। श्रेय और दोष दोनों नीचे रखना, ठीक से किया जाए तो ऐसा ही दिखता है।',
  'Is shloka ke arth mein karm-kushalta aisi dikhti hai: aisa result banana jiske saamne tum khade nahi hoge. Woh teacher apne kaam mein bahut achha hai aur kaam ka structure aisa hai ki uski safalta kisi aur ki hoti hai. Credit aur blame dono neeche rakhna, theek se kiya jaaye to aisa hi dikhta hai.',
  'Some work is built so that if you did it well, somebody else is standing in the light.',
  'कुछ काम ऐसे बने होते हैं कि अगर आपने अच्छा किया, तो रोशनी में कोई और खड़ा होता है।',
  'Kuch kaam aise bane hote hain ki agar tumne achha kiya, to roshni mein koi aur khada hota hai.',
  'Taare Zameen Par (2007)', 'beginner', 'work,credit,teaching,skill,film'

  UNION ALL SELECT 63, 'corporate', 1,
  'The email sent at the end of the meeting', 'मीटिंग के अंत में भेजा गया ईमेल', 'Meeting ke ant mein bheja gaya email',
  'A meeting goes badly and somebody sends a summary email eleven minutes later, copying two levels up. Every fact in it is accurate. The framing is not, in a way they cannot see at the time and can see perfectly by Thursday. Undoing it takes four conversations and it never fully goes.',
  'एक मीटिंग बुरी तरह चलती है और कोई ग्यारह मिनट बाद सारांश वाला ईमेल भेज देता है, दो स्तर ऊपर तक कॉपी करके। उसमें हर तथ्य सही है। ढाँचा नहीं, और यह उस समय उसे दिखता नहीं जबकि गुरुवार तक पूरी तरह दिखने लगता है। इसे सुलझाने में चार बातचीत लगती हैं और यह पूरी तरह कभी नहीं जाता।',
  'Ek meeting buri tarah chalti hai aur koi gyarah minute baad summary wala email bhej deta hai, do level upar tak copy kar ke. Usme har fact sahi hai. Framing nahi, aur yeh us waqt use dikhta nahi jabki Thursday tak poori tarah dikhne lagta hai. Ise sulajhane mein chaar baatein lagti hain aur yeh poori tarah kabhi nahi jaata.',
  'The chain is visible in the timestamps. Anger, then clouding — and the specific thing that clouded was not the facts but the judgement about what the facts would look like to two levels up. Memory of that had gone. Eleven minutes is roughly how long the whole descent takes.',
  'कड़ी टाइमस्टैम्प में दिखती है। गुस्सा, फिर धुंधलाहट — और जो धुंधलाया वह तथ्य नहीं थे, बल्कि यह समझ थी कि ये तथ्य दो स्तर ऊपर कैसे दिखेंगे। उसकी याद जा चुकी थी। पूरी ढलान में लगभग ग्यारह मिनट लगते हैं।',
  'Chain timestamps mein dikhti hai. Gussa, phir dhundhlahat — aur jo dhundhlaya woh facts nahi the, balki yeh samajh thi ki yeh facts do level upar kaise dikhenge. Uski yaad ja chuki thi. Poori dhalan mein lagbhag gyarah minute lagte hain.',
  'Every fact can be accurate and the judgement about sending it still gone.',
  'हर तथ्य सही हो सकता है और भेजने का विवेक फिर भी जा चुका हो सकता है।',
  'Har fact sahi ho sakta hai aur bhejne ka vivek phir bhi ja chuka ho sakta hai.',
  NULL, 'beginner', 'anger,work,email,judgement,regret'

  UNION ALL SELECT 63, 'marriage', 2,
  'The sentence that gets quoted back for years', 'वह वाक्य जो सालों तक दोहराया जाता है', 'Woh vaakya jo saalon tak dohraya jaata hai',
  'In an argument late at night one partner says something specific and true and cruel — the sort of thing you can only say about somebody you know extremely well. It is retracted within the hour and apologised for properly. It is also quoted back, without malice and almost affectionately, for the next nine years.',
  'रात देर से हुई बहस में एक साथी कुछ ऐसा कहता है जो ख़ास है, सच है और क्रूर है — वैसी बात जो किसी के बारे में तभी कही जा सकती है जब आप उसे बहुत गहराई से जानते हों। एक घंटे के भीतर वह वापस ले ली जाती है और ठीक से माफ़ी भी माँगी जाती है। और वह अगले नौ साल तक, बिना द्वेष के और लगभग स्नेह से, दोहराई भी जाती है।',
  'Raat der se hui behes mein ek partner kuch aisa kehta hai jo khaas hai, sach hai aur kroor hai — waisi baat jo kisi ke baare mein tabhi kahi ja sakti hai jab tum use bahut gehrai se jaante ho. Ek ghante ke andar woh wapas le li jaati hai aur theek se maafi bhi maangi jaati hai. Aur woh agle nau saal tak, bina dwesh ke aur lagbhag pyaar se, dohrayi bhi jaati hai.',
  'This is the last step of the chain and the verse does not soften it. What anger reached in that moment was the archive — everything known about the other person, available and usable. Judgement is exactly the faculty that keeps that archive shut, and it was the thing that had gone.',
  'यह कड़ी की आख़िरी सीढ़ी है और श्लोक इसमें कोई नरमी नहीं बरतता। उस पल गुस्सा जिस तक पहुँचा वह संग्रह था — दूसरे व्यक्ति के बारे में जाना हुआ सब कुछ, उपलब्ध और इस्तेमाल लायक। विवेक ठीक वही क्षमता है जो उस संग्रह को बंद रखती है, और वही जा चुकी थी।',
  'Yeh chain ki aakhri seedhi hai aur shloka isme koi narmi nahi barta. Us pal gussa jis tak pahuncha woh archive tha — doosre insaan ke baare mein jaana hua sab kuch, available aur use karne layak. Vivek theek wahi kshamta hai jo us archive ko band rakhti hai, aur wahi ja chuki thi.',
  'Judgement is what keeps the archive shut. Anger is what gets the key.',
  'विवेक वही है जो संग्रह को बंद रखता है। गुस्सा वही है जिसे चाबी मिल जाती है।',
  'Vivek wahi hai jo archive band rakhta hai. Gussa wahi hai jise chaabi mil jaati hai.',
  NULL, 'intermediate', 'anger,marriage,regret,words,judgement'

  UNION ALL SELECT 63, 'sports', 3,
  'The dismissal for arguing', 'बहस करने पर बाहर', 'Behes karne par bahar',
  'A player disputes a decision, keeps disputing it, and is sent off. His side plays the remaining thirty minutes a man down and loses a match they were drawing. In the interview afterwards he says, accurately, that the original decision was wrong. Both things are true and only one of them is on the scoreboard.',
  'एक खिलाड़ी फ़ैसले पर बहस करता है, करता ही जाता है, और बाहर कर दिया जाता है। उसकी टीम बाकी तीस मिनट एक खिलाड़ी कम लेकर खेलती है और वह मैच हार जाती है जो बराबरी पर था। बाद के इंटरव्यू में वह सही कहता है कि मूल फ़ैसला ग़लत था। दोनों बातें सच हैं और स्कोरबोर्ड पर उनमें से एक ही है।',
  'Ek player faisle par behes karta hai, karta hi jaata hai, aur bahar kar diya jaata hai. Uski team baaki tees minute ek khiladi kam le kar khelti hai aur woh match haar jaati hai jo barabari par tha. Baad ke interview mein woh sahi kehta hai ki original faisla galat tha. Dono baatein sach hain aur scoreboard par unme se ek hi hai.',
  'Being right is not one of the four steps. The chain runs from anger through clouding to lost judgement regardless of whether the anger was justified, and this verse is describing a mechanism rather than assigning blame. The referee''s error and the player''s descent are two separate events that happened to be adjacent.',
  'सही होना उन चार सीढ़ियों में नहीं है। कड़ी गुस्से से धुंधलाहट होते हुए विवेक के जाने तक चलती है, चाहे गुस्सा जायज़ रहा हो या नहीं — और यह श्लोक दोष नहीं दे रहा, तंत्र बता रहा है। रेफ़री की ग़लती और खिलाड़ी की ढलान दो अलग घटनाएँ हैं जो संयोग से पास-पास हुईं।',
  'Sahi hona un chaar seedhiyon mein nahi hai. Chain gusse se dhundhlahat hote hue vivek ke jaane tak chalti hai, chahe gussa jaayaz raha ho ya nahi — aur yeh shloka blame nahi de raha, mechanism bata raha hai. Referee ki galti aur player ki dhalan do alag ghatnayein hain jo sanyog se paas-paas huin.',
  'Being right does not exempt you from the chain. It just makes the descent feel earned.',
  'सही होना आपको इस कड़ी से छूट नहीं देता। बस ढलान जायज़ महसूस होने लगती है।',
  'Sahi hona tumhe is chain se chhoot nahi deta. Bas dhalan jaayaz mehsoos hone lagti hai.',
  NULL, 'beginner', 'anger,sport,discipline,judgement,justification'

) AS x
JOIN verses v ON v.verse_number = x.vn
JOIN chapters c ON c.id = v.chapter_id AND c.chapter_number = 2;
