import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
                      'PRIVACY POLICY',
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
                        'Last updated: August 1, 2026',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ).animate().fadeIn(duration: 300.ms),

                      const SizedBox(height: 16),

                      // Card 1: Information We Collect (Figma Screenshot 4)
                      _buildPolicyCard(
                        title: 'Information We Collect',
                        content:
                            'We collect the questions you ask, your saved content, and basic account information (name, email). We do not sell your data to third parties. Your spiritual journey is private.',
                        delayMs: 100,
                      ),

                      const SizedBox(height: 16),

                      // Card 2: How We Use Your Data
                      _buildPolicyCard(
                        title: 'How We Use Your Data',
                        content:
                            'Your questions are used solely to provide AI-powered Buddhist guidance. We use anonymized, aggregated data to improve our AI models. We never use your data for advertising.',
                        delayMs: 200,
                      ),

                      const SizedBox(height: 16),

                      // Card 3: Data Storage & Security
                      _buildPolicyCard(
                        title: 'Data Storage & Security',
                        content:
                            'All data is encrypted in transit (TLS 1.3) and at rest (AES-256). Your account data is stored on secure servers. You may request deletion of all your data at any time.',
                        delayMs: 300,
                      ),

                      const SizedBox(height: 16),

                      // Card 4: Third-Party Services
                      _buildPolicyCard(
                        title: 'Third-Party Services',
                        content:
                            'We use OpenAI for AI processing, Supabase for data storage, and Stripe for payments. Each has their own privacy policy. We share only the minimum data necessary.',
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

  Widget _buildPolicyCard({required String title, required String content, required int delayMs}) {
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
