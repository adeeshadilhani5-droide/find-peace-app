import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _dailyWisdom = true;
  bool _meditationReminders = false;
  bool _newContent = true;
  bool _weeklyReflection = false;
  bool _soundsHaptics = true;
  TimeOfDay _wisdomTime = const TimeOfDay(hour: 7, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.navyBackgroundGradient,
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
                      icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textWhite),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'NOTIFICATIONS',
                      style: GoogleFonts.cinzel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textGold,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Banner Card
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF131C38),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.navyBorder),
                        ),
                        child: Row(
                          children: [
                            const Text('🙏', style: TextStyle(fontSize: 24)),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                'Allow Find Peace to send gentle reminders along your path. No spam — only wisdom.',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Switches List Card (Matching Figma Screenshot 4)
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.navyCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.navyBorder),
                        ),
                        child: Column(
                          children: [
                            _buildNotificationTile(
                              icon: '🌅',
                              title: 'Daily Wisdom',
                              subtitle: 'A morning quote from the Buddha\'s teachings',
                              value: _dailyWisdom,
                              onChanged: (val) => setState(() => _dailyWisdom = val),
                            ),
                            const Divider(height: 1, color: AppColors.navyBorder),
                            _buildNotificationTile(
                              icon: '🪷',
                              title: 'Meditation Reminders',
                              subtitle: 'Gentle reminders to sit and be still',
                              value: _meditationReminders,
                              onChanged: (val) => setState(() => _meditationReminders = val),
                            ),
                            const Divider(height: 1, color: AppColors.navyBorder),
                            _buildNotificationTile(
                              icon: '📜',
                              title: 'New Content',
                              subtitle: 'When new suttas or stories are added',
                              value: _newContent,
                              onChanged: (val) => setState(() => _newContent = val),
                            ),
                            const Divider(height: 1, color: AppColors.navyBorder),
                            _buildNotificationTile(
                              icon: '📊',
                              title: 'Weekly Reflection',
                              subtitle: 'A summary of your spiritual journey',
                              value: _weeklyReflection,
                              onChanged: (val) => setState(() => _weeklyReflection = val),
                            ),
                            const Divider(height: 1, color: AppColors.navyBorder),
                            _buildNotificationTile(
                              icon: '🔔',
                              title: 'Sounds & Haptics',
                              subtitle: 'Soft notification tones and vibrations',
                              value: _soundsHaptics,
                              onChanged: (val) => setState(() => _soundsHaptics = val),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Daily Wisdom Time Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.navyCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.navyBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DAILY WISDOM TIME',
                              style: GoogleFonts.cinzel(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textGold,
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
                                      'Morning Wisdom',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textWhite,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Receive your daily teaching',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final picked = await showTimePicker(
                                      context: context,
                                      initialTime: _wisdomTime,
                                    );
                                    if (picked != null) {
                                      setState(() => _wisdomTime = picked);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1B284A),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: AppColors.goldPrimary.withValues(alpha: 0.4)),
                                    ),
                                    child: Text(
                                      _wisdomTime.format(context),
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textGold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildNotificationTile({
    required String icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1B284A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(icon, style: const TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: AppColors.navyBackground,
            activeTrackColor: AppColors.goldPrimary,
            inactiveThumbColor: AppColors.textSecondary,
            inactiveTrackColor: const Color(0xFF1B284A),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
