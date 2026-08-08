import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';

class KarmaDetailScreen extends StatelessWidget {
  const KarmaDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bullets = [
      loc.translate('karmicBullet1'),
      loc.translate('karmicBullet2'),
      loc.translate('karmicBullet3'),
      loc.translate('karmicBullet4'),
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.navyBackgroundGradient : AppColors.lightBackgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded, color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: Text(
                        loc.translate('karmaExplanationTitle'),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cinzel(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.bookmark_outline_rounded, color: isDark ? AppColors.textGold : AppColors.lightTextGold),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Saved to your library! 🔖')),
                        );
                      },
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Karma Scales Emblem
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.03),
                            border: Border.all(color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.3)),
                          ),
                          child: const Center(
                            child: Text('⚖️', style: TextStyle(fontSize: 38)),
                          ),
                        ).animate().scale(duration: 600.ms),
                      ),

                      const SizedBox(height: 24),

                      // Intro Context Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.navyCard : AppColors.lightCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.translate('howKarmaRelates'),
                              style: GoogleFonts.cinzel(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              loc.translate('karmaIntroText'),
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 400.ms),

                      const SizedBox(height: 20),

                      // Karmic Effects Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.navyCard : AppColors.lightCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.translate('karmicEffects'),
                              style: GoogleFonts.cinzel(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 14),
                            ...bullets.map((bullet) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: [
                                    Text('🔹 ', style: TextStyle(fontSize: 10, color: isDark ? AppColors.goldPrimary : AppColors.lightPrimary)),
                                    Expanded(
                                      child: Text(
                                        bullet,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 13,
                                          color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ).animate().fadeIn(delay: 200.ms),

                      const SizedBox(height: 20),

                      // Positive Alternatives Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.navyCard : AppColors.lightCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.translate('positiveAlternatives'),
                              style: GoogleFonts.cinzel(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              loc.translate('positiveAltText'),
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 300.ms),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
