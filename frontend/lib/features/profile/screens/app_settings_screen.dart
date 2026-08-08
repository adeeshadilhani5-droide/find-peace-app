import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import 'privacy_policy_screen.dart';

class AppSettingsScreen extends ConsumerStatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  ConsumerState<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends ConsumerState<AppSettingsScreen> {
  bool _notifications = true;
  bool _offlineMode = false;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
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
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded, color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'SETTINGS',
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Card 1: APPEARANCE (Figma Screenshot 2)
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
                              'APPEARANCE',
                              style: GoogleFonts.cinzel(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                _buildThemeChip(ThemeMode.light, '❄️ Light', themeMode == ThemeMode.light, isDark),
                                const SizedBox(width: 10),
                                _buildThemeChip(ThemeMode.dark, '🌙 Dark', themeMode == ThemeMode.dark, isDark),
                                const SizedBox(width: 10),
                                _buildThemeChip(ThemeMode.system, '⚙️ System', themeMode == ThemeMode.system, isDark),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Font Size',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                                  ),
                                ),
                                Text(
                                  '16px',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Card 2: PREFERENCES
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
                              'PREFERENCES',
                              style: GoogleFonts.cinzel(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Notifications',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Daily wisdom reminders',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: _notifications,
                                  activeTrackColor: isDark ? AppColors.goldPrimary : AppColors.lightPrimary,
                                  activeThumbColor: isDark ? AppColors.navyBackground : Colors.white,
                                  onChanged: (val) => setState(() => _notifications = val),
                                ),
                              ],
                            ),
                            Divider(height: 24, color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Offline Mode',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Save content for offline',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: _offlineMode,
                                  activeTrackColor: isDark ? AppColors.goldPrimary : AppColors.lightPrimary,
                                  activeThumbColor: isDark ? AppColors.navyBackground : Colors.white,
                                  onChanged: (val) => setState(() => _offlineMode = val),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Card 3: SYSTEM
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
                              'SYSTEM',
                              style: GoogleFonts.cinzel(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Cache cleared (14 MB freed)')),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Clear Cache',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFFF87171),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Free up storage space',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded, color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary, size: 14),
                                ],
                              ),
                            ),
                            Divider(height: 24, color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Privacy Policy',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'How we handle your data',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded, color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary, size: 14),
                                ],
                              ),
                            ),
                            Divider(height: 24, color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Terms of Service',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Our terms and conditions',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded, color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary, size: 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Footer Build Info
                      Text(
                        'Find Peace v2.1.0 · Build 2026.08',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
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

  Widget _buildThemeChip(ThemeMode mode, String label, bool isSelected, bool isDark) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(themeProvider.notifier).setThemeMode(mode);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? const Color(0xFF1B284A) : const Color(0xFFF3E9CD))
                : (isDark ? const Color(0xFF131C38) : const Color(0xFFF8F6F0)),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? (isDark ? AppColors.goldPrimary : AppColors.lightPrimary)
                  : (isDark ? AppColors.navyBorder : AppColors.lightBorder),
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected
                    ? (isDark ? AppColors.textGold : AppColors.lightTextGold)
                    : (isDark ? AppColors.textSecondary : AppColors.lightTextSecondary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
