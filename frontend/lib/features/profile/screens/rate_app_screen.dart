import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class RateAppScreen extends StatefulWidget {
  const RateAppScreen({super.key});

  @override
  State<RateAppScreen> createState() => _RateAppScreenState();
}

class _RateAppScreenState extends State<RateAppScreen> {
  int _selectedStars = 5;
  final TextEditingController _feedbackController = TextEditingController();

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
                      'RATE FIND PEACE',
                      style: GoogleFonts.cinzel(
                        fontSize: 18,
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
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Glowing Emblem (Figma Screenshot 5)
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.03),
                          border: Border.all(color: AppColors.goldPrimary.withValues(alpha: 0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.goldPrimary.withValues(alpha: 0.15),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text('🪷', style: TextStyle(fontSize: 42)),
                        ),
                      ).animate().scale(duration: 600.ms),

                      const SizedBox(height: 28),

                      Text(
                        'ENJOYING FIND PEACE?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cinzel(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textGold,
                          letterSpacing: 1.5,
                        ),
                      ).animate().fadeIn(delay: 200.ms),

                      const SizedBox(height: 8),

                      Text(
                        'Your rating helps others discover this path',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ).animate().fadeIn(delay: 300.ms),

                      const SizedBox(height: 32),

                      // 5 Star Rating Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final starNumber = index + 1;
                          return IconButton(
                            iconSize: 38,
                            icon: Icon(
                              starNumber <= _selectedStars
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded,
                              color: AppColors.goldPrimary,
                            ),
                            onPressed: () {
                              setState(() => _selectedStars = starNumber);
                            },
                          );
                        }),
                      ).animate().fadeIn(delay: 400.ms),

                      const SizedBox(height: 28),

                      // Feedback Input Box
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.navyCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.navyBorder),
                        ),
                        child: TextField(
                          controller: _feedbackController,
                          maxLines: 4,
                          style: GoogleFonts.plusJakartaSans(color: AppColors.textWhite, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Share your experience with Find Peace (optional)...',
                            hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary, fontSize: 13),
                            border: InputBorder.none,
                          ),
                        ),
                      ).animate().fadeIn(delay: 500.ms),

                      const SizedBox(height: 32),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Thank you for your rating and feedback! 🙏')),
                            );
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.goldPrimary,
                            foregroundColor: AppColors.navyBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27),
                            ),
                          ),
                          child: Text(
                            'Submit Rating',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Maybe Later',
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
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
}
