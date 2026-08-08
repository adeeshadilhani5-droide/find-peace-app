import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    const sources = [
      'Pali Text Society Canon',
      'Access to Insight (accesstoinsight.org)',
      'Sutta Central (suttacentral.net)',
      'Bhikkhu Bodhi translations',
      'Bhikkhu Thanissaro translations',
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
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded, color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      loc.translate('about'),
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

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),

                      // Brand Emblem
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.03),
                          border: Border.all(color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.3)),
                        ),
                        child: const Center(
                          child: Text('🪷', style: TextStyle(fontSize: 38)),
                        ),
                      ).animate().scale(duration: 600.ms),

                      const SizedBox(height: 16),

                      Text(
                        loc.translate('appName'),
                        style: GoogleFonts.cinzel(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                          letterSpacing: 2.0,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Version 2.1.0 · August 2026',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Mission Statement Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.navyCard : AppColors.lightCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                        ),
                        child: Text(
                          'Find Peace was created with a single mission: to make the timeless wisdom of the Buddha accessible to anyone who is suffering. Drawing from the Pali Canon, Jataka stories, and meditation traditions, our AI searches verified, scholarly sources to provide guidance rooted in authentic Dhamma.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                            height: 1.6,
                          ),
                        ),
                      ).animate().fadeIn(delay: 200.ms),

                      const SizedBox(height: 20),

                      // Our Sources Card
                      Container(
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
                              loc.translate('ourSources'),
                              style: GoogleFonts.cinzel(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 14),
                            ...sources.map((src) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: [
                                    Text('🔸 ', style: TextStyle(fontSize: 10, color: isDark ? AppColors.goldPrimary : AppColors.lightPrimary)),
                                    Expanded(
                                      child: Text(
                                        src,
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
