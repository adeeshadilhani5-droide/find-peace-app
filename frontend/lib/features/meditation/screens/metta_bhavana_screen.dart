import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';

class MettaBhavanaScreen extends StatelessWidget {
  const MettaBhavanaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final steps = [
      loc.translate('step1'),
      loc.translate('step2'),
      loc.translate('step3'),
      loc.translate('step4'),
      loc.translate('step5'),
      loc.translate('step6'),
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
                        loc.translate('mettaBhavana'),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cinzel(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                          letterSpacing: 1.5,
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
                      // Subtitle Banner Card
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
                              loc.translate('mettaSub'),
                              style: GoogleFonts.cinzel(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              loc.translate('mettaIntroText'),
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

                      // Benefits Chips Row
                      Row(
                        children: [
                          _buildBenefitChip(loc.translate('reducesAnxiety'), isDark),
                          const SizedBox(width: 8),
                          _buildBenefitChip(loc.translate('increasesCompassion'), isDark),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Step by Step Practice Title
                      Text(
                        loc.translate('stepByStepPractice'),
                        style: GoogleFonts.cinzel(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                          letterSpacing: 1.2,
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Steps List
                      ...List.generate(steps.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.navyCard : AppColors.lightCard,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.15),
                                    border: Border.all(color: isDark ? AppColors.goldPrimary : AppColors.lightPrimary),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    steps[index],
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13,
                                      color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).animate().fadeIn(delay: (index * 60).ms),
                        );
                      }),

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

  Widget _buildBenefitChip(String label, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.3)),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textGold : AppColors.lightTextGold,
            ),
          ),
        ),
      ),
    );
  }
}
