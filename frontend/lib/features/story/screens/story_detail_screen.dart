import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';

class StoryDetailScreen extends StatelessWidget {
  const StoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        loc.translate('elephantKingTitle'),
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
                      // Story Card
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
                              loc.translate('theStory'),
                              style: GoogleFonts.cinzel(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              loc.translate('elephantStoryText'),
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

                      // Moral Lesson Card
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
                              loc.translate('moralLesson'),
                              style: GoogleFonts.cinzel(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              loc.translate('elephantMoralText'),
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 200.ms),

                      const SizedBox(height: 20),

                      // Life Application Card
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
                              loc.translate('lifeApplication'),
                              style: GoogleFonts.cinzel(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              loc.translate('elephantAppText'),
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
