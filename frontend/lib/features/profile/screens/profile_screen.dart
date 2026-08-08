import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/screens/login_screen.dart';
import 'app_settings_screen.dart';
import 'about_screen.dart';
import 'privacy_policy_screen.dart';
import 'terms_of_service_screen.dart';
import 'send_feedback_screen.dart';
import 'language_screen.dart';
import 'rate_app_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _showEditProfileSheet(BuildContext context, WidgetRef ref, UserModel user) {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    String selectedAvatar = user.avatar.isEmpty ? '🧘' : user.avatar;

    const avatars = ['🧘', '🕊️', '🪷', '☸️', '✨', '🐘'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.navyCard : AppColors.lightCard,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                  border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'EDIT PROFILE',
                          style: GoogleFonts.cinzel(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close_rounded, color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Avatar Selection
                    Text(
                      'SELECT AVATAR',
                      style: GoogleFonts.cinzel(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: avatars.map((av) {
                        final isSel = selectedAvatar == av;
                        return GestureDetector(
                          onTap: () => setState(() => selectedAvatar = av),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSel
                                  ? (isDark ? const Color(0xFF1B284A) : const Color(0xFFF3E9CD))
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSel
                                    ? (isDark ? AppColors.goldPrimary : AppColors.lightPrimary)
                                    : (isDark ? AppColors.navyBorder : AppColors.lightBorder),
                                width: isSel ? 2 : 1,
                              ),
                            ),
                            child: Text(av, style: const TextStyle(fontSize: 26)),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    // Name Field
                    Text(
                      'FULL NAME',
                      style: GoogleFonts.cinzel(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF131C38) : const Color(0xFFF8F6F0),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                      ),
                      child: TextField(
                        controller: nameController,
                        style: GoogleFonts.plusJakartaSans(
                          color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                          fontSize: 14,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Email Field
                    Text(
                      'EMAIL ADDRESS',
                      style: GoogleFonts.cinzel(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF131C38) : const Color(0xFFF8F6F0),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                      ),
                      child: TextField(
                        controller: emailController,
                        style: GoogleFonts.plusJakartaSans(
                          color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                          fontSize: 14,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          ref.read(authProvider.notifier).updateProfile(
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                avatar: selectedAvatar,
                              );
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Profile updated successfully! ✨')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? AppColors.goldPrimary : AppColors.lightPrimary,
                          foregroundColor: isDark ? AppColors.navyBackground : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        child: Text(
                          'Save Profile Changes',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showProUpgradeModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? AppColors.navyCard : AppColors.lightCard,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? const Color(0xFF1B284A) : const Color(0xFFF3E9CD),
                  border: Border.all(color: isDark ? AppColors.goldPrimary : AppColors.lightPrimary),
                ),
                child: const Center(child: Text('👑', style: TextStyle(fontSize: 34))),
              ),
              const SizedBox(height: 14),
              Text(
                'FIND PEACE PRO',
                style: GoogleFonts.cinzel(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Unlock Unlimited Wisdom & Offline Access',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 20),
              _buildProFeature(isDark, '⚡ Unlimited AI Buddhist Guidance & Chat'),
              _buildProFeature(isDark, '📜 Full Offline Access to 1,000+ Suttas & Jatakas'),
              _buildProFeature(isDark, '🎧 High-Quality Chanting Audio & Guided Meditations'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Thank you! Welcome to Find Peace PRO 👑')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? AppColors.goldPrimary : AppColors.lightPrimary,
                    foregroundColor: isDark ? AppColors.navyBackground : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: Text(
                    'Start 7-Day Free Trial (\$4.99/mo)',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProFeature(bool isDark, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          const Text('✔ ', style: TextStyle(color: AppColors.goldPrimary, fontSize: 14, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? AppColors.navyCard : AppColors.lightCard,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Sign Out',
            style: GoogleFonts.cinzel(
              color: isDark ? AppColors.textGold : AppColors.lightTextGold,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to sign out of Find Peace?',
            style: GoogleFonts.plusJakartaSans(
              color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.plusJakartaSans(
                  color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await ref.read(authProvider.notifier).logout();
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF87171),
                foregroundColor: Colors.white,
              ),
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
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
              // Header Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(
                  loc.translate('profile').toUpperCase(),
                  style: GoogleFonts.cinzel(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                    letterSpacing: 2.0,
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // User Info Card (Dynamic with Avatar & Edit Action)
                      Container(
                        padding: const EdgeInsets.all(18),
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
                        child: Row(
                          children: [
                            Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDark ? const Color(0xFF1B284A) : const Color(0xFFF3E9CD),
                                border: Border.all(color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.5)),
                              ),
                              child: Center(
                                child: Text(user.avatar.isEmpty ? (user.isGuest ? '🕊️' : '🧘') : user.avatar, style: const TextStyle(fontSize: 28)),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name.isEmpty ? 'Arjun Sharma' : user.name,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    user.email.isEmpty ? 'arjun@example.com' : user.email,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Text('⭐', style: TextStyle(fontSize: 11)),
                                      const SizedBox(width: 4),
                                      Text(
                                        user.isGuest ? 'Guest Pass' : 'Free Plan',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isDark ? const Color(0xFF131C38) : const Color(0xFFF8F6F0),
                                  border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                                ),
                                child: Icon(
                                  Icons.edit_rounded,
                                  color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                  size: 16,
                                ),
                              ),
                              onPressed: () => _showEditProfileSheet(context, ref, user),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 400.ms),

                      const SizedBox(height: 16),

                      // Spiritual Activity Stats Row
                      Row(
                        children: [
                          _buildStatCard(isDark, '🔥', '12 Days', 'Streak'),
                          const SizedBox(width: 10),
                          _buildStatCard(isDark, '💬', '24', 'Questions'),
                          const SizedBox(width: 10),
                          _buildStatCard(isDark, '🔖', '8', 'Saved'),
                          const SizedBox(width: 10),
                          _buildStatCard(isDark, '🧘', '140m', 'Meditated'),
                        ],
                      ).animate().fadeIn(delay: 200.ms),

                      const SizedBox(height: 20),

                      // Profile Options Menu List
                      _buildMenuItem(
                        context,
                        isDark: isDark,
                        icon: Icons.settings_outlined,
                        title: loc.translate('settings'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const AppSettingsScreen()),
                          );
                        },
                      ),
                      _buildMenuItem(
                        context,
                        isDark: isDark,
                        icon: Icons.workspace_premium_outlined,
                        title: 'Premium Upgrade',
                        badge: 'PRO',
                        onTap: () => _showProUpgradeModal(context),
                      ),
                      _buildMenuItem(
                        context,
                        isDark: isDark,
                        icon: Icons.language_rounded,
                        title: loc.translate('language'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const LanguageScreen()),
                          );
                        },
                      ),
                      _buildMenuItem(
                        context,
                        isDark: isDark,
                        icon: Icons.info_outline_rounded,
                        title: loc.translate('about'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const AboutScreen()),
                          );
                        },
                      ),
                      _buildMenuItem(
                        context,
                        isDark: isDark,
                        icon: Icons.lock_outline_rounded,
                        title: loc.translate('privacyPolicy'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
                          );
                        },
                      ),
                      _buildMenuItem(
                        context,
                        isDark: isDark,
                        icon: Icons.assignment_outlined,
                        title: loc.translate('termsOfService'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const TermsOfServiceScreen()),
                          );
                        },
                      ),
                      _buildMenuItem(
                        context,
                        isDark: isDark,
                        icon: Icons.chat_bubble_outline_rounded,
                        title: loc.translate('sendFeedback'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const SendFeedbackScreen()),
                          );
                        },
                      ),
                      _buildMenuItem(
                        context,
                        isDark: isDark,
                        icon: Icons.star_outline_rounded,
                        title: loc.translate('rateApp'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const RateAppScreen()),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      // Sign Out Button (Triggers alert dialog)
                      TextButton(
                        onPressed: () => _showSignOutDialog(context, ref),
                        child: Text(
                          loc.translate('signOut'),
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFFF87171),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
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

  Widget _buildStatCard(bool isDark, String icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.navyCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required bool isDark,
    required IconData icon,
    required String title,
    String? badge,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.navyCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
          ),
          child: Row(
            children: [
              Icon(icon, color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary, size: 20),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
                  ),
                ),
              ),
              if (badge != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1B284A) : const Color(0xFFF3E9CD),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: isDark ? AppColors.goldPrimary : AppColors.lightPrimary),
                  ),
                  child: Text(
                    badge,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Icon(Icons.arrow_forward_ios_rounded, color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary, size: 14),
            ],
          ),
        ),
      ),
    );
  }
}
