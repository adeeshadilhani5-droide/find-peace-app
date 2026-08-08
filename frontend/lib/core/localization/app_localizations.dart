import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // General & Navigation
      'appName': 'FIND PEACE',
      'tagline': 'WISDOM  •  GUIDANCE  •  SERENITY',
      'welcomeBack': 'WELCOME BACK',
      'home': 'Home',
      'saved': 'Saved',
      'history': 'History',
      'profile': 'Profile',
      'searchHint': 'What is troubling you?',
      'popularTopics': 'Popular Topics',
      'fourNobleTruths': 'Four Noble Truths',
      'fourNobleTruthsSub': 'The foundation of Buddhist teaching',
      'eightfoldPath': 'Eightfold Path',
      'eightfoldPathSub': 'The middle way to liberation',
      'meditation': 'Meditation',
      'meditationSub': 'Mindfulness and inner stillness',
      'karmaRebirth': 'Karma & Rebirth',
      'karmaRebirthSub': 'Cause, effect, and intention',
      'dailyWisdom': 'Daily Wisdom',
      'readFeatured': 'Read Featured',
      'goodMorning': 'Good Morning,',
      'seekerOfPeace': 'Seeker of Peace ✨',
      'yourGuidance': 'YOUR GUIDANCE',
      'findPeaceAI': 'Find Peace AI',
      'savedLibrary': 'SAVED LIBRARY',
      'savedLibrarySub': 'Your personal collection of wisdom',
      'historyTitle': 'HISTORY',
      'recentQuestions': 'Your recent questions',
      'notifications': 'NOTIFICATIONS',
      'settings': 'SETTINGS',
      'language': 'LANGUAGE',
      'about': 'ABOUT FIND PEACE',
      'privacyPolicy': 'PRIVACY POLICY',
      'termsOfService': 'TERMS OF SERVICE',
      'sendFeedback': 'SEND FEEDBACK',
      'rateApp': 'RATE FIND PEACE',
      'beginJourney': 'Begin Your Journey',
      'continueBtn': 'Continue',
      'skipBtn': 'Skip',
      'saveAll': 'Save All Guidance',
      'submitFeedback': 'Submit Feedback',
      'submitRating': 'Submit Rating',
      'mettaQuote': '"May you be well and happy, free from suffering."',
      'selectLanguage': 'Select Application Language',
      'english': 'English',
      'sinhala': 'Sinhala (සිංහල)',
      'breathe': 'Breathe',
      'sanctuary': 'Sanctuary',

      // Onboarding Slides
      'onboardingTitle1': 'ANCIENT WISDOM,\nMODERN GUIDANCE',
      'onboardingDesc1': 'Access thousands of years of Buddhist teachings from the Pali Canon, Jataka Stories, and meditation traditions.',
      'onboardingTitle2': 'ASK ANYTHING,\nFIND PEACE',
      'onboardingDesc2': 'Share what troubles your heart and receive compassionate, scripture-backed guidance tailored to your situation.',
      'onboardingTitle3': 'WALK THE PATH OF\nAWAKENING',
      'onboardingDesc3': 'Save teachings, track your journey, and cultivate inner peace through daily wisdom and guided meditation.',

      // Guidance Screen
      'yourQuestion': 'Your question',
      'overview': 'Overview',
      'allSources': 'All Sources',
      'paliSutta': 'Pali Sutta',
      'jatakaStory': 'Jataka Story',
      'karmaTag': 'Karma',

      // Sutta & Story Details
      'dhammapadaMind': 'DHAMMAPADA — MIND CHAPTER',
      'originalPali': 'ORIGINAL PĀLI',
      'translation': 'TRANSLATION',
      'explanation': 'EXPLANATION',
      'suttaTranslationText': '"Mind is the forerunner of all actions. All deeds are led by mind, created by mind. If one speaks or acts with a corrupt mind, suffering follows, as the wheel follows the hoof of an ox."',
      'suttaExplanationText': 'The Buddha opens the Dhammapada by establishing the primacy of mind. Our suffering and happiness do not arise from external circumstances alone — they arise from the quality of mind with which we meet experience. The teaching invites us to return to the breath and purify intention.',

      // Karma Screen
      'karmaExplanationTitle': 'KARMA EXPLANATION',
      'howKarmaRelates': 'HOW KARMA RELATES TO YOUR GRIEF',
      'karmaIntroText': 'Karma (kamma in Pali) means intentional action. The grief you experience is not punishment — it is the natural result of love. The Buddha taught that attachment to what is impermanent inevitably gives rise to sorrow.',
      'karmicEffects': 'KARMIC EFFECTS OF GRIEF',
      'karmicBullet1': 'Clinging prolongs suffering',
      'karmicBullet2': 'Acceptance creates spaciousness',
      'karmicBullet3': 'Compassion purifies the heart',
      'karmicBullet4': 'Right action transforms sorrow',
      'positiveAlternatives': 'POSITIVE ALTERNATIVES',
      'positiveAltText': 'Channel grief into compassionate service. The Buddha taught dana (generosity) as a powerful antidote to personal suffering.',

      // Metta Meditation
      'mettaBhavana': 'METTA BHAVANA',
      'mettaSub': 'Loving-Kindness Meditation · 15–20 min',
      'mettaIntroText': 'Metta Bhavana (loving-kindness cultivation) is one of the four brahmaviharas — divine abodes. It directly counters grief by opening the heart to unconditional goodwill toward all beings.',
      'reducesAnxiety': 'Reduces Anxiety',
      'increasesCompassion': 'Increases Compassion',
      'promotesInnerPeace': 'Promotes Inner Peace',
      'stepByStepPractice': 'STEP-BY-STEP PRACTICE',
      'step1': 'Find a quiet place. Sit comfortably with your spine erect.',
      'step2': 'Close your eyes. Take 3 deep, slow breaths to settle.',
      'step3': 'Begin with yourself: "May I be happy. May I be at peace."',
      'step4': 'Extend to loved ones: "May they be happy. May they be free."',
      'step5': 'Gradually extend to all beings everywhere.',
      'step6': 'Rest in the warmth of this boundless goodwill for 10–20 minutes.',

      // Elephant King Story
      'elephantKingTitle': 'THE PATIENT ELEPHANT KING',
      'theStory': 'THE STORY',
      'elephantStoryText': 'Once the Bodhisatta was born as a great white elephant, king of a herd of eighty thousand. He was virtuous, gentle, and wise. One day, a cruel hunter who had lost his way in the forest was led to safety by the elephant\'s grace. But the hunter returned, intent on selling the elephant\'s tusks to a greedy king.\n\nAs the hunter prepared to cut the tusks, the elephant Bodhisatta felt no anger — only compassion.',
      'moralLesson': 'MORAL LESSON',
      'elephantMoralText': 'Patience (khanti) is not weakness — it is the highest form of strength. Those who cause us pain are often themselves suffering.',
      'lifeApplication': 'LIFE APPLICATION',
      'elephantAppText': 'When grief or anger arises, ask: "Can I meet this moment with compassion?"',

      // Profile & Settings
      'appearance': 'APPEARANCE',
      'light': 'Light',
      'dark': 'Dark',
      'system': 'System',
      'fontSize': 'Font Size',
      'preferences': 'PREFERENCES',
      'notificationsPref': 'Notifications',
      'offlineMode': 'Offline Mode',
      'clearCache': 'Clear Cache',
      'systemSec': 'SYSTEM',
      'signOut': 'Sign Out',
      'ourSources': 'OUR SOURCES',
      'category': 'CATEGORY',
      'general': 'General',
      'bugReport': 'Bug Report',
      'featureRequest': 'Feature Request',
      'contentIssue': 'Content Issue',
      'yourMessage': 'YOUR MESSAGE',
      'messageHint': 'Describe your feedback, suggestion, or issue in detail...',
      'enjoyingApp': 'ENJOYING FIND PEACE?',
      'ratingHelp': 'Your rating helps others discover this path',
      'maybeLater': 'Maybe Later',
    },
    'si': {
      // General & Navigation
      'appName': 'සිතට සහනය',
      'tagline': 'ප්‍රඥාව  •  මඟපෙන්වීම  •  සැනසීම',
      'welcomeBack': 'නැවත සාදරයෙන් පිළිගනිමු',
      'home': 'මුල් පිටුව',
      'saved': 'සුරැකි',
      'history': 'ඉතිහාසය',
      'profile': 'පැතිකඩ',
      'searchHint': 'ඔබගේ සිතට වදදෙන කරුණ කුමක්ද?',
      'popularTopics': 'ජනප්‍රිය මාතෘකා',
      'fourNobleTruths': 'චතුරාර්ය සත්‍යය',
      'fourNobleTruthsSub': 'බෞද්ධ දර්ශනයේ පදනම',
      'eightfoldPath': 'ආර්ය අෂ්ටාංගික මාර්ගය',
      'eightfoldPathSub': 'විමුක්තිය උදෙසා මැදුම් පිළිවෙත',
      'meditation': 'භාවනාව',
      'meditationSub': 'සිහිනුවණ සහ සන්සුන්බව',
      'karmaRebirth': 'කර්මය සහ පුනර්භවය',
      'karmaRebirthSub': 'හේතු ඵල ධර්මය සහ චේතනාව',
      'dailyWisdom': 'දිනපතා ධර්ම ප්‍රඥාව',
      'readFeatured': 'කියවන්න',
      'goodMorning': 'සුභ උදෑසනක්,',
      'seekerOfPeace': 'සැහැල්ලුව සොයන ඔබ ✨',
      'yourGuidance': 'ඔබේ මඟපෙන්වීම',
      'findPeaceAI': 'සිතට සහනය AI',
      'savedLibrary': 'සුරැකි දහම් එකතුව',
      'savedLibrarySub': 'ඔබ සුරැකි ධර්ම ප්‍රඥාව',
      'historyTitle': 'ඉතිහාසය',
      'recentQuestions': 'ඔබ ඇසූ මෑත ප්‍රශ්න',
      'notifications': 'දැනුම්දීම්',
      'settings': 'සැකසීම්',
      'language': 'භාෂාව',
      'about': 'සිතට සහනය ගැන',
      'privacyPolicy': 'පුද්ගලිකත්ව ප්‍රතිපත්තිය',
      'termsOfService': 'සේවා කොන්දේසි',
      'sendFeedback': 'අදහස් යොමු කරන්න',
      'rateApp': 'ඇප් එක ඇගයීමට ලක් කරන්න',
      'beginJourney': 'ගමන ආරම්භ කරන්න',
      'continueBtn': 'ඉදිරියට',
      'skipBtn': 'මඟ හරින්න',
      'saveAll': 'සියල්ල සුරකින්න',
      'submitFeedback': 'අදහස් යොමු කරන්න',
      'submitRating': 'ඇගයීම යොමු කරන්න',
      'mettaQuote': '"සියලු සත්වයෝ සුවපත් වෙත්වා, දුකින් මිදෙත්වා."',
      'selectLanguage': 'යෙදුමේ භාෂාව තෝරන්න',
      'english': 'English (ඉංග්‍රීසි)',
      'sinhala': 'සිංහල (Sinhala)',
      'breathe': 'ආශ්වාස ප්‍රශ්වාස',
      'sanctuary': 'සුව සෙවන',

      // Onboarding Slides
      'onboardingTitle1': 'පැරණි දහම් ප්‍රඥාව,\nනූතන මඟපෙන්වීම',
      'onboardingDesc1': 'පාලි ත්‍රිපිටකය, ජාතක කථා සහ භාවනා ක්‍රමවේදයන් ඇතුළත් ශ්‍රී සද්ධර්මයේ අනුශාසනා ලබන්න.',
      'onboardingTitle2': 'ඕනෑම දෙයක් අසන්න,\nසිතට සහනය ලබන්න',
      'onboardingDesc2': 'ඔබේ සිත පීඩාවට පත් කරන ඕනෑම කරුණක් යොමු කර ධර්මානුකූල අනුශාසනා සහ මඟපෙන්වීම් ලබාගන්න.',
      'onboardingTitle3': 'ප්‍රඥාවේ මාවතේ\nපියනඟන්න',
      'onboardingDesc3': 'දහම් කරුණු සුරකින්න, ඔබේ ප්‍රගතිය නිරීක්ෂණය කරන්න සහ දිනපතා භාවනා කර සිත සන්සුන් කරගන්න.',

      // Guidance Screen
      'yourQuestion': 'ඔබගේ ප්‍රශ්නය',
      'overview': 'සංක්ෂිප්තය',
      'allSources': 'සියලු මූලාශ්‍ර',
      'paliSutta': 'පාලි සූත්‍ර',
      'jatakaStory': 'ජාතක කථාව',
      'karmaTag': 'කර්මය',

      // Sutta & Story Details
      'dhammapadaMind': 'ධම්මපදය — චිත්ත වග්ගය',
      'originalPali': 'මුල් පාලි ගාථාව',
      'translation': 'සිංහල තේරුම',
      'explanation': 'විස්තරය',
      'suttaTranslationText': '"සෑම ක්‍රියාවකටම මනස පූර්වගාමී වේ. සිත ප්‍රධාන වේ, මනසින්ම හටගනී. කෙනෙකු දුෂිත සිතින් යමක් කියයිද කරයිද, ගොනා පිටුපස රෝදය එන්නාක් මෙන් ඔහු පසුපස දුක ලුහුබඳියි."',
      'suttaExplanationText': 'බුදුරජාණන් වහන්සේ මනසේ ප්‍රධානත්වය පැහැදිලි කරති. අපගේ සැපය හා දුක බාහිර කරුණු මතම නොව, අපගේ සිතේ පවතින ස්වභාවය මත තීරණය වේ.',

      // Karma Screen
      'karmaExplanationTitle': 'කර්මය පිළිබඳ විස්තරය',
      'howKarmaRelates': 'කර්මය ඔබේ ශෝකයට බලපාන ආකාරය',
      'karmaIntroText': 'කර්මය යනු චේතනාන්විත ක්‍රියාවයි. ඔබ විඳින දුක දඬුවමක් නොවේ — එය ඇලීමේ සහ අනිත්‍යභාවයේ ස්වභාවයයි. අනිත්‍ය දේට ඇලීම දුකට හේතුවන බව බුදුරජාණන් වහන්සේ වදාළහ.',
      'karmicEffects': 'ශෝකයේ කර්ම බලපෑම',
      'karmicBullet1': 'ඇලීම දුක දීර්ඝ කරයි',
      'karmicBullet2': 'උපේක්ෂාව සිත සැහැල්ලු කරයි',
      'karmicBullet3': 'මෛත්‍රිය සිත පිරිසිදු කරයි',
      'karmicBullet4': 'සම්මා කම්මන්තය ශෝකය දුරලයි',
      'positiveAlternatives': 'යහපත් විකල්පයන්',
      'positiveAltText': 'ඔබේ ශෝකය කරුණාවන්ත සේවයක් බවට පත්කරන්න. දානය සහ පරිත්‍යාගය දුක නිවන බලවත් ඖෂධයකි.',

      // Metta Meditation
      'mettaBhavana': 'මෛත්‍රී භාවනාව',
      'mettaSub': 'මෛත්‍රී භාවනාව · මිනිත්තු 15–20',
      'mettaIntroText': 'මෛත්‍රී භාවනාව යනු සතර බ්‍රහ්ම විහරණයන්ගෙන් එකකි. එය සියලු සත්වයන් කෙරෙහි අසීමිත කරුණාව පතුරුවමින් සිතේ පීඩනය දුරු කරයි.',
      'reducesAnxiety': 'මානසික පීඩනය අඩු කරයි',
      'increasesCompassion': 'කරුණාව වර්ධනය කරයි',
      'promotesInnerPeace': 'සිතේ සහනය ඇති කරයි',
      'stepByStepPractice': 'පියවරෙන් පියවර භාවනා ක්‍රමය',
      'step1': 'නිශ්ශබ්ද ස්ථානයක් තෝරාගෙන කොන්ද ඍජුව තබාගෙන වාඩිවන්න.',
      'step2': 'ඇස් පියාගෙන ගැඹුරු දිගු හුස්ම 3ක් ගන්න.',
      'step3': 'තමන්ගෙන් ආරම්භ කරන්න: "මම සුවපත් වෙම්වා. මම නීරෝගී වෙම්වා."',
      'step4': 'හිතවතුන්ට පතුරුවන්න: "ඔවුහු සුවපත් වෙත්වා. දුකින් මිදෙත්වා."',
      'step5': 'ක්‍රමයෙන් සියලු සත්වයන් කෙරෙහි පතුරුවන්න.',
      'step6': 'මිනිත්තු 10-20ක් මෙම මෛත්‍රී සිතුවිල්ලේ නිරත වන්න.',

      // Elephant King Story
      'elephantKingTitle': 'ක්‍ෂාන්තිවාදී හස්ති රාජයා',
      'theStory': 'කථා පුවත',
      'elephantStoryText': 'අප මහ බෝසතාණන් වහන්සේ අසූදහසක් ඇතුන්ට නායකත්වය දුන් මහා ශ්වේත හස්ති රාජයෙකුව උපන්හ. උන්වහන්සේ ගුණවත්, කරුණාවන්ත සහ ප්‍රඥාවන්ත වූහ. දිනක් වනයේ අතරමං වූ වැද්දෙකුට ජීවිත දානය දුන් නමුත්, එම වැද්දා ලෝභකමින් ඇත්දළ කපාගැනීමට පැමිණියේය. හස්ති රාජයා කෝප නොවී අසීමිත කරුණාවෙන් තම ඇත්දළ ලබාදුන්හ.',
      'moralLesson': 'ආදර්ශය',
      'elephantMoralText': 'ඉවසීම (ඛන්තී) යනු දුර්වලකමක් නොවේ — එය උසස්ම ශක්තියයි.',
      'lifeApplication': 'ජීවිතයට එකතු කරගැනීමට',
      'elephantAppText': 'කෝපය හෝ දුක ඇතිවන විට සිතන්න: "මට මෙම මොහොතට කරුණාවෙන් මුහුණ දිය හැකිද?"',

      // Profile & Settings
      'appearance': 'පෙනුම (තේමාව)',
      'light': 'ආලෝකවත්',
      'dark': 'අඳුරු',
      'system': 'පද්ධතිය අනුව',
      'fontSize': 'අකුරු ප්‍රමාණය',
      'preferences': 'මනාපයන්',
      'notificationsPref': 'දැනුම්දීම්',
      'offlineMode': 'ඔෆ්ලයින් මාදිලිය',
      'clearCache': 'කැෂේ එක පිරිසිදු කරන්න',
      'systemSec': 'පද්ධතිය',
      'signOut': 'ගිණුමෙන් ඉවත් වන්න',
      'ourSources': 'අපගේ මූලාශ්‍ර',
      'category': 'වර්ගය',
      'general': 'සාමාන්‍ය',
      'bugReport': 'දෝෂ වාර්තා',
      'featureRequest': 'අලුත් විශේෂාංග',
      'contentIssue': 'කරුණු පිළිබඳ ගැටලු',
      'yourMessage': 'ඔබේ පණිවිඩය',
      'messageHint': 'ඔබගේ අදහස හෝ ගැටලුව පැහැදිලිව සටහන් කරන්න...',
      'enjoyingApp': 'සිතට සහනය ඇප් එක ගැන සතුටුද?',
      'ratingHelp': 'ඔබගේ ඇගයීම අන් අයටත් මෙම මඟ සොයාගැනීමට උපකාරී වේ',
      'maybeLater': 'පසුව බලමු',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        key;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'si'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
