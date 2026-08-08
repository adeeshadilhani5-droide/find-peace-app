import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class SendFeedbackScreen extends StatefulWidget {
  const SendFeedbackScreen({super.key});

  @override
  State<SendFeedbackScreen> createState() => _SendFeedbackScreenState();
}

class _SendFeedbackScreenState extends State<SendFeedbackScreen> {
  int _selectedCategory = 0;
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, String>> _categories = const [
    {'icon': '💬', 'label': 'General'},
    {'icon': '🐛', 'label': 'Bug Report'},
    {'icon': '✨', 'label': 'Feature Request'},
    {'icon': '📜', 'label': 'Content Issue'},
  ];

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
              // Header Row (Figma Screenshot 1)
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
                      'SEND FEEDBACK',
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
                      // Notice Banner Card
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF131C38),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.navyBorder),
                        ),
                        child: Row(
                          children: [
                            const Text('🙏', style: TextStyle(fontSize: 22)),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                'Your feedback helps us make Find Peace better for everyone on the path.',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 400.ms),

                      const SizedBox(height: 24),

                      // Category Title
                      Text(
                        'CATEGORY',
                        style: GoogleFonts.cinzel(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textGold,
                          letterSpacing: 1.2,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Category Selection Grid 2x2
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 2.5,
                        ),
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final cat = _categories[index];
                          final isSelected = _selectedCategory == index;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedCategory = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFF1B284A) : AppColors.navyCard,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected ? AppColors.goldPrimary : AppColors.navyBorder,
                                  width: isSelected ? 1.5 : 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(cat['icon']!, style: const TextStyle(fontSize: 16)),
                                  const SizedBox(width: 8),
                                  Text(
                                    cat['label']!,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                      color: isSelected ? AppColors.textGold : AppColors.textWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ).animate().fadeIn(delay: 200.ms),

                      const SizedBox(height: 24),

                      // Your Message Title
                      Text(
                        'YOUR MESSAGE',
                        style: GoogleFonts.cinzel(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textGold,
                          letterSpacing: 1.2,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Message Input Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.navyCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.navyBorder),
                        ),
                        child: TextField(
                          controller: _messageController,
                          maxLines: 5,
                          style: GoogleFonts.plusJakartaSans(color: AppColors.textWhite, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Describe your feedback, suggestion, or issue in detail...',
                            hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary, fontSize: 13),
                            border: InputBorder.none,
                          ),
                        ),
                      ).animate().fadeIn(delay: 300.ms),

                      const SizedBox(height: 32),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_messageController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter your feedback message')),
                              );
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Feedback submitted! Thank you 🙏')),
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
                            'Submit Feedback',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
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
}
