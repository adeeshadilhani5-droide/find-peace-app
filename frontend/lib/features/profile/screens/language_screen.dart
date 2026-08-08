import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/localization/app_localizations.dart';

class LanguageOption {
  final String code;
  final String flag;
  final String englishName;
  final String nativeName;

  const LanguageOption({
    required this.code,
    required this.flag,
    required this.englishName,
    required this.nativeName,
  });
}

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  final List<LanguageOption> _languages = const [
    LanguageOption(
      code: 'en',
      flag: '🇺🇸',
      englishName: 'English',
      nativeName: 'English',
    ),
    LanguageOption(
      code: 'si',
      flag: '🇱🇰',
      englishName: 'Sinhala',
      nativeName: 'සිංහල',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.navyBackgroundGradient : AppColors.lightBackgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Row (Figma Screenshot)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded, color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      loc.translate('language'),
                      style: GoogleFonts.cinzel(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Language Notice
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.navyCard : AppColors.lightCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                  ),
                  child: Row(
                    children: [
                      const Text('🌐', style: TextStyle(fontSize: 22)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          loc.translate('selectLanguage'),
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Languages List (English & Sinhala Only)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    final lang = _languages[index];
                    final isSelected = currentLocale.languageCode == lang.code;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: GestureDetector(
                        onTap: () {
                          ref.read(localeProvider.notifier).setLocale(Locale(lang.code));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Language changed to ${lang.englishName}')),
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (isDark ? const Color(0xFF1B284A) : const Color(0xFFF3E9CD))
                                : (isDark ? AppColors.navyCard : AppColors.lightCard),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? (isDark ? AppColors.goldPrimary : AppColors.lightPrimary)
                                  : (isDark ? AppColors.navyBorder : AppColors.lightBorder),
                              width: isSelected ? 1.8 : 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(lang.flag, style: const TextStyle(fontSize: 28)),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lang.englishName,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                        color: isSelected
                                            ? (isDark ? AppColors.textGold : AppColors.lightTextGold)
                                            : (isDark ? AppColors.textWhite : AppColors.lightTextPrimary),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      lang.nativeName,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 13,
                                        color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isDark ? AppColors.goldPrimary : AppColors.lightPrimary,
                                  ),
                                  child: Icon(
                                    Icons.check_rounded,
                                    color: isDark ? AppColors.navyBackground : Colors.white,
                                    size: 16,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
