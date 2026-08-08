import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../chat/screens/ai_chat_screen.dart';
import '../../guidance/screens/guidance_screen.dart';
import '../../story/screens/story_detail_screen.dart';
import '../../profile/screens/notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row (Logo, Title, Bell Icon)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('🪷', style: TextStyle(fontSize: 28)),
                        const SizedBox(height: 8),
                        Text(
                          loc.translate('appName'),
                          style: GoogleFonts.cinzel(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                            letterSpacing: 2.0,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          loc.translate('tagline'),
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark ? AppColors.navyCard : AppColors.lightCard,
                          border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                        ),
                        child: Icon(Icons.notifications_none_rounded, color: isDark ? AppColors.textGold : AppColors.lightTextGold, size: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                        );
                      },
                    ),
                  ],
                ).animate().fadeIn(duration: 400.ms),

                const SizedBox(height: 24),

                // Metta Sutta Verse Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF131B36) : const Color(0xFFFAF7EE),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isDark ? const Color(0xFF28345E) : AppColors.lightBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.translate('mettaQuote'),
                        style: GoogleFonts.plusJakartaSans(
                          color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '— Metta Sutta',
                        style: GoogleFonts.plusJakartaSans(
                          color: isDark ? const Color(0xFFA78BFA) : AppColors.lightPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),

                const SizedBox(height: 20),

                // Search Bar Input
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AIChatScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.navyCard : AppColors.lightCard,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded, color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            loc.translate('searchHint'),
                            style: GoogleFonts.plusJakartaSans(
                              color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark ? const Color(0xFF1E2B4D) : const Color(0xFFF3E9CD),
                          ),
                          child: Icon(Icons.mic_none_rounded, color: isDark ? AppColors.textGold : AppColors.lightTextGold, size: 18),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: 300.ms),

                const SizedBox(height: 28),

                // Popular Topics Title
                Text(
                  loc.translate('popularTopics'),
                  style: GoogleFonts.cinzel(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                  ),
                ),

                const SizedBox(height: 16),

                // Popular Topics 2x2 Grid
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.15,
                  children: [
                    _buildTopicCard(
                      context,
                      isDark: isDark,
                      icon: '☸️',
                      title: loc.translate('fourNobleTruths'),
                      subtitle: loc.translate('fourNobleTruthsSub'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => GuidanceScreen(initialQuery: loc.translate('fourNobleTruths')),
                          ),
                        );
                      },
                    ),
                    _buildTopicCard(
                      context,
                      isDark: isDark,
                      icon: '🪢',
                      title: loc.translate('eightfoldPath'),
                      subtitle: loc.translate('eightfoldPathSub'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => GuidanceScreen(initialQuery: loc.translate('eightfoldPath')),
                          ),
                        );
                      },
                    ),
                    _buildTopicCard(
                      context,
                      isDark: isDark,
                      icon: '🪷',
                      title: loc.translate('meditation'),
                      subtitle: loc.translate('meditationSub'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => GuidanceScreen(initialQuery: loc.translate('meditation')),
                          ),
                        );
                      },
                    ),
                    _buildTopicCard(
                      context,
                      isDark: isDark,
                      icon: '⚖️',
                      title: loc.translate('karmaRebirth'),
                      subtitle: loc.translate('karmaRebirthSub'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => GuidanceScreen(initialQuery: loc.translate('karmaRebirth')),
                          ),
                        );
                      },
                    ),
                  ],
                ).animate().fadeIn(delay: 400.ms),

                const SizedBox(height: 28),

                // Daily Wisdom Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      loc.translate('dailyWisdom'),
                      style: GoogleFonts.cinzel(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const StoryDetailScreen()),
                        );
                      },
                      child: Text(
                        loc.translate('readFeatured'),
                        style: GoogleFonts.plusJakartaSans(
                          color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Daily Wisdom Featured Card
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const StoryDetailScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.navyCard : AppColors.lightCard,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E2A4A) : const Color(0xFFF3E9CD),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Text('📜', style: TextStyle(fontSize: 24)),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jataka No. 122',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'The Patient Elephant King',
                                style: GoogleFonts.cinzel(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, color: isDark ? AppColors.textGold : AppColors.lightTextGold, size: 16),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: 500.ms),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopicCard(
    BuildContext context, {
    required bool isDark,
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E2A4A) : const Color(0xFFF3E9CD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(icon, style: const TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
