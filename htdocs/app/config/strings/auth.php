<?php
/**
 * VedaVerse — app/config/strings/auth.php
 * ---------------------------------------------------------------------
 * Signing in, registering, recovering an account, and account settings.
 *
 * WHO THESE ARE WRITTEN FOR
 *   Somebody slightly anxious, because that is the state most people are
 *   in on a sign-in screen. Plain, short, no jargon.
 *
 * THE ONE PLACE THIS PRODUCT CANNOT RESCUE ANYBODY
 *   The host blocks outgoing mail, so there is no email password reset —
 *   there is a 12-character recovery code shown exactly once. Every
 *   string about it is deliberately blunt. A soft "keep this safe" would
 *   be kinder to write and crueller to receive six months later.
 *
 *   Do not soften auth.code.warning. It is the most important sentence
 *   in the interface.
 */

return array(

    // -----------------------------------------------------------------
    // Sign in
    // -----------------------------------------------------------------
    'auth.login.title'      => array('en' => 'Sign in', 'hi' => 'साइन इन करें', 'hinglish' => 'Sign in karo'),
    'auth.login.lead'       => array('en' => 'Welcome back. Your reading is where you left it.', 'hi' => 'वापसी पर स्वागत है। आपका पढ़ा हुआ वहीं है जहाँ छोड़ा था।', 'hinglish' => 'Wapas aa gaye. Jahan chhoda tha wahin se shuru karo.'),
    'auth.login.submit'     => array('en' => 'Sign in', 'hi' => 'साइन इन', 'hinglish' => 'Sign in'),
    'auth.login.no_account' => array('en' => 'No account yet?', 'hi' => 'अभी खाता नहीं है?', 'hinglish' => 'Account nahi hai?'),
    'auth.login.forgot'     => array('en' => 'Lost your password?', 'hi' => 'पासवर्ड भूल गए?', 'hinglish' => 'Password bhool gaye?'),
    'auth.login.welcome'    => array('en' => 'Signed in. Welcome back, :name.', 'hi' => 'साइन इन हो गया। वापसी पर स्वागत है, :name।', 'hinglish' => 'Sign in ho gaya. Welcome back, :name.'),

    // -----------------------------------------------------------------
    // Register
    // -----------------------------------------------------------------
    'auth.register.title'        => array('en' => 'Create an account', 'hi' => 'खाता बनाएँ', 'hinglish' => 'Account banao'),
    'auth.register.lead'         => array('en' => 'You can read everything without one. An account adds syncing across devices, the forum, and certificates.', 'hi' => 'बिना खाते के भी सब पढ़ सकते हैं। खाते से डिवाइस के बीच सिंक, फ़ोरम और प्रमाणपत्र मिलते हैं।', 'hinglish' => 'Bina account ke bhi sab padh sakte ho. Account se sync, forum aur certificate milte hain.'),
    'auth.register.submit'       => array('en' => 'Create my account', 'hi' => 'मेरा खाता बनाएँ', 'hinglish' => 'Account banao'),
    'auth.register.have_account' => array('en' => 'Already have one?', 'hi' => 'पहले से खाता है?', 'hinglish' => 'Pehle se account hai?'),
    'auth.register.no_email'     => array('en' => 'Your email is only used to sign in. Nothing is ever sent to it — this site sends no email at all.', 'hi' => 'ईमेल सिर्फ़ साइन इन के लिए है। कुछ भी नहीं भेजा जाता — यह साइट कोई ईमेल नहीं भेजती।', 'hinglish' => 'Email sirf sign in ke liye hai. Kuch bheja nahi jaata — yeh site koi email send hi nahi karti.'),
    'auth.register.done'         => array('en' => 'Your account is ready.', 'hi' => 'आपका खाता तैयार है।', 'hinglish' => 'Tumhara account ready hai.'),

    // -----------------------------------------------------------------
    // Recover
    // -----------------------------------------------------------------
    'auth.recover.title'   => array('en' => 'Recover your account', 'hi' => 'खाता वापस पाएँ', 'hinglish' => 'Account wapas lo'),
    'auth.recover.lead'    => array('en' => 'Enter your email, the recovery code you wrote down at signup, and a new password.', 'hi' => 'अपना ईमेल, साइनअप के समय लिखा गया रिकवरी कोड, और नया पासवर्ड डालें।', 'hinglish' => 'Email, signup ke time likha recovery code, aur naya password daalo.'),
    'auth.recover.submit'  => array('en' => 'Set a new password', 'hi' => 'नया पासवर्ड सेट करें', 'hinglish' => 'Naya password set karo'),
    'auth.recover.done'    => array('en' => 'Password changed. You have been signed out everywhere else.', 'hi' => 'पासवर्ड बदल गया। बाकी सब जगह से साइन आउट कर दिया गया है।', 'hinglish' => 'Password change ho gaya. Baaki sab jagah se sign out kar diya hai.'),
    'auth.recover.no_code' => array('en' => 'Lost the code as well? Then this account cannot be recovered — there is no email reset. You would need to create a new one.', 'hi' => 'कोड भी खो गया? तब यह खाता वापस नहीं मिल सकता — ईमेल रीसेट नहीं है। नया खाता बनाना होगा।', 'hinglish' => 'Code bhi kho gaya? Phir yeh account wapas nahi mil sakta — email reset hai hi nahi. Naya banana padega.'),

    // -----------------------------------------------------------------
    // The recovery code screen — shown exactly once
    // -----------------------------------------------------------------
    'auth.code.title'    => array('en' => 'Write this down now', 'hi' => 'इसे अभी लिख लें', 'hinglish' => 'Yeh abhi likh lo'),
    'auth.code.lead'     => array('en' => 'This is your recovery code. It is shown once, right now, and stored only as a hash — nobody can look it up later, including us.', 'hi' => 'यह आपका रिकवरी कोड है। यह सिर्फ़ अभी एक बार दिख रहा है और केवल हैश के रूप में सुरक्षित है — बाद में कोई इसे नहीं देख सकता, हम भी नहीं।', 'hinglish' => 'Yeh tumhara recovery code hai. Sirf abhi ek baar dikh raha hai, aur sirf hash ban ke store hota hai — baad mein koi dekh nahi sakta, hum bhi nahi.'),
    'auth.code.warning'  => array('en' => 'If you lose both your password and this code, the account cannot be recovered. There is no email reset, because this host blocks outgoing mail.', 'hi' => 'अगर पासवर्ड और यह कोड दोनों खो गए, तो खाता वापस नहीं मिलेगा। ईमेल रीसेट नहीं है, क्योंकि यह होस्ट ईमेल भेजने नहीं देता।', 'hinglish' => 'Password aur yeh code dono kho gaye to account wapas nahi milega. Email reset nahi hai, kyunki host email bhejne hi nahi deta.'),
    'auth.code.copy'     => array('en' => 'Copy the code', 'hi' => 'कोड कॉपी करें', 'hinglish' => 'Code copy karo'),
    'auth.code.copied'   => array('en' => 'Copied', 'hi' => 'कॉपी हो गया', 'hinglish' => 'Copy ho gaya'),
    'auth.code.continue' => array('en' => 'I have written it down — continue', 'hi' => 'मैंने लिख लिया — आगे बढ़ें', 'hinglish' => 'Likh liya — aage chalo'),
    'auth.code.where'    => array('en' => 'A note on your phone, a screenshot, or a page in a notebook. Anywhere you will still have it in a year.', 'hi' => 'फ़ोन का नोट, स्क्रीनशॉट, या कॉपी का एक पन्ना। कहीं भी, बस साल भर बाद भी मिलना चाहिए।', 'hinglish' => 'Phone ka note, screenshot, ya copy ka ek panna. Kahin bhi — bas saal bhar baad bhi milna chahiye.'),
    'auth.code.print'    => array('en' => 'Print this page', 'hi' => 'यह पेज प्रिंट करें', 'hinglish' => 'Yeh page print karo'),

    // -----------------------------------------------------------------
    // Fields and hints
    // -----------------------------------------------------------------
    'auth.field.name'             => array('en' => 'Your name', 'hi' => 'आपका नाम', 'hinglish' => 'Tumhara naam'),
    'auth.field.email'            => array('en' => 'Email', 'hi' => 'ईमेल', 'hinglish' => 'Email'),
    'auth.field.password'         => array('en' => 'Password', 'hi' => 'पासवर्ड', 'hinglish' => 'Password'),
    'auth.field.new_password'     => array('en' => 'New password', 'hi' => 'नया पासवर्ड', 'hinglish' => 'Naya password'),
    'auth.field.password_confirm' => array('en' => 'Password again', 'hi' => 'पासवर्ड दोबारा', 'hinglish' => 'Password phir se'),
    'auth.field.code'             => array('en' => 'Recovery code', 'hi' => 'रिकवरी कोड', 'hinglish' => 'Recovery code'),
    'auth.field.lang'             => array('en' => 'Reading language', 'hi' => 'पढ़ने की भाषा', 'hinglish' => 'Padhne ki bhasha'),
    'auth.field.track'            => array('en' => 'Where to start', 'hi' => 'कहाँ से शुरू करें', 'hinglish' => 'Kahan se shuru karein'),

    'auth.hint.password'   => array('en' => 'At least 10 characters, with upper and lower case, a number and a symbol.', 'hi' => 'कम से कम 10 अक्षर, बड़े और छोटे अक्षर, एक अंक और एक चिह्न।', 'hinglish' => 'Kam se kam 10 characters, upper aur lower case, ek number aur ek symbol.'),
    'auth.hint.track'      => array('en' => 'You can change this later without losing progress.', 'hi' => 'इसे बाद में बदल सकते हैं, प्रगति खोए बिना।', 'hinglish' => 'Baad mein change kar sakte ho, progress khoye bina.'),
    'auth.hint.name'       => array('en' => 'Whatever you would like to be called. It shows on anything you post.', 'hi' => 'जो भी नाम आपको पसंद हो। यह आपकी हर पोस्ट पर दिखेगा।', 'hinglish' => 'Jo bhi naam pasand ho. Yeh tumhari har post par dikhega.'),
    'auth.hint.show_password' => array('en' => 'Show password', 'hi' => 'पासवर्ड दिखाएँ', 'hinglish' => 'Password dikhao'),

    // -----------------------------------------------------------------
    // Tracks
    // -----------------------------------------------------------------
    'auth.track.beginner'     => array('en' => 'Beginner — chapters 2, 3, 12, 16, 18', 'hi' => 'शुरुआती — अध्याय 2, 3, 12, 16, 18', 'hinglish' => 'Beginner — chapter 2, 3, 12, 16, 18'),
    'auth.track.intermediate' => array('en' => 'Intermediate — adds 4, 5, 6, 13, 14, 17', 'hi' => 'मध्यम — साथ में 4, 5, 6, 13, 14, 17', 'hinglish' => 'Intermediate — inke saath 4, 5, 6, 13, 14, 17'),
    'auth.track.advanced'     => array('en' => 'Advanced — all eighteen chapters', 'hi' => 'उन्नत — सभी अठारह अध्याय', 'hinglish' => 'Advanced — poore atharah chapter'),

    // -----------------------------------------------------------------
    // Errors
    // -----------------------------------------------------------------
    // "That email and password do not match an account" rather than "no
    // such user" — the second one tells anybody with a list of email
    // addresses which of them have accounts here.
    'auth.error.invalid'             => array('en' => 'That email and password do not match an account.', 'hi' => 'यह ईमेल और पासवर्ड किसी खाते से मेल नहीं खाते।', 'hinglish' => 'Yeh email aur password kisi account se match nahi karte.'),
    'auth.error.email_taken'         => array('en' => 'There is already an account with that email. Try signing in, or recover it.', 'hi' => 'इस ईमेल से खाता पहले से है। साइन इन करें या रिकवर करें।', 'hinglish' => 'Is email se account pehle se hai. Sign in karo ya recover karo.'),
    'auth.error.recover_invalid'     => array('en' => 'That email and recovery code do not match.', 'hi' => 'यह ईमेल और रिकवरी कोड मेल नहीं खाते।', 'hinglish' => 'Yeh email aur recovery code match nahi karte.'),
    'auth.error.registration_closed' => array('en' => 'New accounts are closed at the moment. Reading is still open to everyone.', 'hi' => 'अभी नए खाते बंद हैं। पढ़ना सबके लिए खुला है।', 'hinglish' => 'Abhi naye account band hain. Padhna sabke liye khula hai.'),
    'auth.error.locked'              => array('en' => 'Too many failed attempts on this account. Wait :n minutes and try again.', 'hi' => 'इस खाते पर बहुत सारी असफल कोशिशें। :n मिनट रुककर दोबारा कोशिश करें।', 'hinglish' => 'Is account par bahut failed attempts. :n minute ruk ke try karo.'),
    'auth.error.suspended'           => array('en' => 'This account is suspended. Contact the site owner.', 'hi' => 'यह खाता निलंबित है। साइट के मालिक से संपर्क करें।', 'hinglish' => 'Yeh account suspend hai. Site owner se baat karo.'),

    // -----------------------------------------------------------------
    // Sessions
    // -----------------------------------------------------------------
    'auth.logged_out' => array('en' => 'Signed out. Your bookmarks on this device are still here.', 'hi' => 'साइन आउट हो गया। इस डिवाइस पर आपके बुकमार्क अब भी यहीं हैं।', 'hinglish' => 'Sign out ho gaya. Is device par tumhare bookmark abhi bhi yahin hain.'),
    'auth.merged'     => array('en' => 'Everything you saved before signing in has been added to your account.', 'hi' => 'साइन इन से पहले जो सेव किया था, वह आपके खाते में जुड़ गया है।', 'hinglish' => 'Sign in se pehle jo save kiya tha, woh account mein add ho gaya hai.'),
    'auth.sign_out'   => array('en' => 'Sign out', 'hi' => 'साइन आउट', 'hinglish' => 'Sign out'),
    'auth.sign_in'    => array('en' => 'Sign in', 'hi' => 'साइन इन', 'hinglish' => 'Sign in'),
    'auth.expired'    => array('en' => 'You were signed out because the session had been idle a long time.', 'hi' => 'लंबे समय तक निष्क्रिय रहने के कारण आपको साइन आउट कर दिया गया।', 'hinglish' => 'Bahut der tak idle rehne ki wajah se sign out kar diya gaya.'),

    // -----------------------------------------------------------------
    // Reading as a guest
    // -----------------------------------------------------------------
    // The anonymous path is a first-class way to use this product, not a
    // funnel toward registration. These strings say so plainly.
    'auth.guest.badge'   => array('en' => 'Reading as a guest', 'hi' => 'मेहमान के रूप में पढ़ रहे हैं', 'hinglish' => 'Guest ki tarah padh rahe ho'),
    'auth.guest.saved'   => array('en' => 'Saved on this device. Create an account to keep it when you switch phones.', 'hi' => 'इस डिवाइस पर सेव है। फ़ोन बदलने पर भी रखना है तो खाता बना लें।', 'hinglish' => 'Is device par save hai. Phone badalne par bhi rakhna hai to account bana lo.'),
    'auth.guest.explain' => array('en' => 'You do not need an account. Everything you read, bookmark and answer is kept on this device for a year.', 'hi' => 'खाते की ज़रूरत नहीं। आप जो पढ़ते, सहेजते और जवाब देते हैं, वह इस डिवाइस पर साल भर रहता है।', 'hinglish' => 'Account ki zaroorat nahi. Jo padha, save kiya aur answer kiya — sab is device par saal bhar rehta hai.'),

    // -----------------------------------------------------------------
    // Account settings
    // -----------------------------------------------------------------
    'account.title'            => array('en' => 'Your account', 'hi' => 'आपका खाता', 'hinglish' => 'Tumhara account'),
    'account.profile'          => array('en' => 'Name and language', 'hi' => 'नाम और भाषा', 'hinglish' => 'Naam aur bhasha'),
    'account.change_password'  => array('en' => 'Change password', 'hi' => 'पासवर्ड बदलें', 'hinglish' => 'Password badlo'),
    'account.current_password' => array('en' => 'Current password', 'hi' => 'मौजूदा पासवर्ड', 'hinglish' => 'Abhi wala password'),
    'account.password_changed' => array('en' => 'Password changed.', 'hi' => 'पासवर्ड बदल गया।', 'hinglish' => 'Password change ho gaya.'),
    'account.new_code'         => array('en' => 'Generate a new recovery code', 'hi' => 'नया रिकवरी कोड बनाएँ', 'hinglish' => 'Naya recovery code banao'),
    'account.new_code_note'    => array('en' => 'The old code stops working the moment a new one is made.', 'hi' => 'नया कोड बनते ही पुराना काम करना बंद कर देता है।', 'hinglish' => 'Naya code bante hi purana kaam karna band kar deta hai.'),
    'account.data'             => array('en' => 'Your data', 'hi' => 'आपका डेटा', 'hinglish' => 'Tumhara data'),
    'account.export'           => array('en' => 'Download everything you have written', 'hi' => 'आपका लिखा हुआ सब डाउनलोड करें', 'hinglish' => 'Jo likha hai sab download karo'),
    'account.delete'           => array('en' => 'Delete this account', 'hi' => 'यह खाता हटाएँ', 'hinglish' => 'Yeh account delete karo'),
    'account.delete_warning'   => array('en' => 'This removes your progress, notes and posts. It cannot be undone and there is no backup we can restore for you.', 'hi' => 'इससे आपकी प्रगति, नोट्स और पोस्ट हट जाएँगी। यह वापस नहीं हो सकता और हमारे पास लौटाने के लिए कोई बैकअप नहीं है।', 'hinglish' => 'Isse tumhari progress, notes aur posts hat jayengi. Undo nahi hoga, aur humare paas wapas laane ke liye koi backup nahi hai.'),
    'account.delete_confirm'   => array('en' => 'Type DELETE to confirm', 'hi' => 'पक्का करने के लिए DELETE लिखें', 'hinglish' => 'Confirm karne ke liye DELETE likho'),
    'account.deleted'          => array('en' => 'Account deleted.', 'hi' => 'खाता हट गया।', 'hinglish' => 'Account delete ho gaya.'),
);
