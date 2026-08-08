import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../guidance/screens/guidance_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<Map<String, String>> _historyItems = [
    {
      'query': 'How to deal with sudden grief and emotional loss?',
      'time': 'Today, 2:14 PM',
      'tag': 'Pali Sutta',
    },
    {
      'query': 'What is the Buddhist teaching on karma and rebirth?',
      'time': 'Yesterday, 9:30 AM',
      'tag': 'Karma',
    },
    {
      'query': 'How to start Metta Bhavana loving-kindness meditation?',
      'time': 'Aug 4, 2026',
      'tag': 'Meditation',
    },
    {
      'query': 'Jataka stories about patience and forgiveness',
      'time': 'Aug 2, 2026',
      'tag': 'Jataka Story',
    },
  ];

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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.translate('historyTitle'),
                      style: GoogleFonts.cinzel(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      loc.translate('recentQuestions'),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  itemCount: _historyItems.length,
                  itemBuilder: (context, index) {
                    final item = _historyItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => GuidanceScreen(initialQuery: item['query']),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.navyCard : AppColors.lightCard,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF1E2B4D) : const Color(0xFFF3E9CD),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  Icons.history_rounded,
                                  color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['query']!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Text(
                                          item['time']!,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 11,
                                            color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.15),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            item['tag']!,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete_outline_rounded,
                                  color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                                  size: 18,
                                ),
                                onPressed: () {
                                  setState(() => _historyItems.removeAt(index));
                                },
                              ),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(delay: (index * 60).ms),
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
