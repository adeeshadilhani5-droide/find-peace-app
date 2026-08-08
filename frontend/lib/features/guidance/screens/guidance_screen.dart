import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../sutta/screens/sutta_detail_screen.dart';
import '../../story/screens/story_detail_screen.dart';
import '../../karma/screens/karma_detail_screen.dart';
import '../../meditation/screens/metta_bhavana_screen.dart';

class GuidanceScreen extends StatefulWidget {
  final String? initialQuery;
  const GuidanceScreen({super.key, this.initialQuery});

  @override
  State<GuidanceScreen> createState() => _GuidanceScreenState();
}

class _GuidanceScreenState extends State<GuidanceScreen> {
  int _selectedTab = 0;

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      loc.translate('yourGuidance'),
                      style: GoogleFonts.cinzel(
                        fontSize: 20,
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question Context Box
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF131C38) : const Color(0xFFFAF7EE),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.translate('yourQuestion').toUpperCase(),
                              style: GoogleFonts.cinzel(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              widget.initialQuery ?? 'How to cope with sudden loss of a loved one?',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 400.ms),

                      const SizedBox(height: 20),

                      // Tabs Bar (Overview / All Sources)
                      Row(
                        children: [
                          _buildTabButton(0, loc.translate('overview'), isDark),
                          const SizedBox(width: 12),
                          _buildTabButton(1, loc.translate('allSources'), isDark),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Guidance Result Cards List
                      _buildGuidanceCard(
                        context,
                        isDark: isDark,
                        badgeIcon: '📜',
                        badgeText: loc.translate('paliSutta'),
                        badgeColor: const Color(0xFFD97706),
                        title: loc.translate('dhammapadaMind'),
                        subtitle: loc.translate('suttaTranslationText'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const SuttaDetailScreen()),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      _buildGuidanceCard(
                        context,
                        isDark: isDark,
                        badgeIcon: '🐘',
                        badgeText: loc.translate('jatakaStory'),
                        badgeColor: const Color(0xFF059669),
                        title: loc.translate('elephantKingTitle'),
                        subtitle: loc.translate('elephantStoryText'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const StoryDetailScreen()),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      _buildGuidanceCard(
                        context,
                        isDark: isDark,
                        badgeIcon: '⚖️',
                        badgeText: loc.translate('karmaTag'),
                        badgeColor: const Color(0xFF2563EB),
                        title: loc.translate('karmaExplanationTitle'),
                        subtitle: loc.translate('karmaIntroText'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const KarmaDetailScreen()),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      _buildGuidanceCard(
                        context,
                        isDark: isDark,
                        badgeIcon: '🪷',
                        badgeText: loc.translate('meditation'),
                        badgeColor: const Color(0xFF7C3AED),
                        title: loc.translate('mettaBhavana'),
                        subtitle: loc.translate('mettaIntroText'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const MettaBhavanaScreen()),
                          );
                        },
                      ),

                      const SizedBox(height: 28),

                      // Save All Guidance Button
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Saved to your library! 🔖')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark ? AppColors.goldPrimary : AppColors.lightPrimary,
                            foregroundColor: isDark ? AppColors.navyBackground : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27),
                            ),
                          ),
                          child: Text(
                            loc.translate('saveAll'),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

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

  Widget _buildTabButton(int index, String label, bool isDark) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.goldPrimary : AppColors.lightPrimary)
              : (isDark ? AppColors.navyCard : AppColors.lightCard),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? (isDark ? AppColors.goldPrimary : AppColors.lightPrimary)
                : (isDark ? AppColors.navyBorder : AppColors.lightBorder),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            color: isSelected
                ? (isDark ? AppColors.navyBackground : Colors.white)
                : (isDark ? AppColors.textSecondary : AppColors.lightTextSecondary),
          ),
        ),
      ),
    );
  }

  Widget _buildGuidanceCard(
    BuildContext context, {
    required bool isDark,
    required String badgeIcon,
    required String badgeText,
    required Color badgeColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.navyCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: badgeColor.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    children: [
                      Text(badgeIcon, style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 6),
                      Text(
                        badgeText,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: badgeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary, size: 14),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: GoogleFonts.cinzel(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textGold : AppColors.lightTextGold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
