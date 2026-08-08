import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

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
                      'TERMS OF SERVICE',
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Effective: August 1, 2026',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ).animate().fadeIn(duration: 300.ms),

                      const SizedBox(height: 16),

                      // Card 1: 1. Acceptance of Terms (Figma Screenshot 2)
                      _buildTermsCard(
                        title: '1. Acceptance of Terms',
                        content:
                            'By using Find Peace, you agree to these Terms of Service. If you do not agree, please do not use the app. We may update these terms and will notify you of significant changes.',
                        delayMs: 100,
                      ),

                      const SizedBox(height: 16),

                      // Card 2: 2. Use of Service
                      _buildTermsCard(
                        title: '2. Use of Service',
                        content:
                            'Find Peace provides AI-generated Buddhist guidance for personal spiritual exploration. This is not a substitute for professional mental health care. If you are in crisis, please contact a qualified mental health professional.',
                        delayMs: 200,
                      ),

                      const SizedBox(height: 16),

                      // Card 3: 3. Account Responsibility
                      _buildTermsCard(
                        title: '3. Account Responsibility',
                        content:
                            'You are responsible for maintaining the security of your account credentials. Do not share your account. We are not responsible for unauthorized access resulting from your failure to keep credentials secure.',
                        delayMs: 300,
                      ),

                      const SizedBox(height: 16),

                      // Card 4: 4. Content
                      _buildTermsCard(
                        title: '4. Content',
                        content:
                            'Buddhist teachings provided are sourced from public domain texts and scholarly translations. AI interpretations are for guidance only and should be understood as such — not as definitive religious authority.',
                        delayMs: 400,
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

  Widget _buildTermsCard({required String title, required String content, required int delayMs}) {
    return Container(
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
            title,
            style: GoogleFonts.cinzel(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textGold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: AppColors.textWhite,
              height: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delayMs.ms).slideY(begin: 0.1, end: 0);
  }
}
