import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../auth/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _showWelcomeBack = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted && _showWelcomeBack) {
        setState(() => _showWelcomeBack = false);
      }
    });
  }

  void _onFinish() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.navyBackgroundGradient : AppColors.lightBackgroundGradient,
        ),
        child: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: _showWelcomeBack ? _buildWelcomeBackSplash(isDark) : _buildSlideViewer(isDark),
          ),
        ),
      ),
    );
  }

  // 1. Welcome Back Splash Screen
  Widget _buildWelcomeBackSplash(bool isDark) {
    final loc = AppLocalizations.of(context);

    return Column(
      key: const ValueKey('welcome_back'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),

        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.03),
            border: Border.all(color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.4), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.15),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Center(
            child: Text('🙏', style: TextStyle(fontSize: 42)),
          ),
        ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack),

        const SizedBox(height: 36),

        Text(
          loc.translate('welcomeBack'),
          style: GoogleFonts.cinzel(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textGold : AppColors.lightTextGold,
            letterSpacing: 2.0,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

        const SizedBox(height: 12),

        Text(
          'Arjun Sharma',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
          ),
        ).animate().fadeIn(delay: 400.ms),

        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            loc.translate('mettaQuote'),
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
              height: 1.5,
            ),
          ),
        ).animate().fadeIn(delay: 600.ms),

        const Spacer(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              minHeight: 3,
              backgroundColor: isDark ? AppColors.navyCard : AppColors.lightCard,
              color: isDark ? AppColors.goldPrimary : AppColors.lightPrimary,
            ),
          ),
        ).animate().fadeIn(delay: 800.ms),

        const SizedBox(height: 48),
      ],
    );
  }

  // 2. Main Onboarding PageView Slider
  Widget _buildSlideViewer(bool isDark) {
    final loc = AppLocalizations.of(context);

    final List<Map<String, String>> slides = [
      {
        'type': 'title_splash',
        'title': loc.translate('appName'),
        'subtitle': loc.translate('tagline'),
      },
      {
        'type': 'content',
        'image': 'assets/images/buddha.png',
        'badge': '☸️',
        'title': loc.translate('onboardingTitle1'),
        'description': loc.translate('onboardingDesc1'),
      },
      {
        'type': 'content',
        'image': 'assets/images/lotus.png',
        'badge': '🪷',
        'title': loc.translate('onboardingTitle2'),
        'description': loc.translate('onboardingDesc2'),
      },
      {
        'type': 'content',
        'image': 'assets/images/incense.png',
        'badge': '✨',
        'title': loc.translate('onboardingTitle3'),
        'description': loc.translate('onboardingDesc3'),
      },
    ];

    return Column(
      key: const ValueKey('slide_viewer'),
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: slides.length,
            itemBuilder: (context, index) {
              final slide = slides[index];
              if (slide['type'] == 'title_splash') {
                return _buildTitleSplashSlide(slide, isDark);
              } else {
                return _buildContentSlide(slide, isDark);
              }
            },
          ),
        ),

        // Indicator Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            slides.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 24 : 8,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: _currentPage == index
                    ? (isDark ? AppColors.goldPrimary : AppColors.lightPrimary)
                    : (isDark ? AppColors.navyBorder : AppColors.lightBorder),
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: _currentPage == slides.length - 1
              ? SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _onFinish,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? AppColors.goldPrimary : AppColors.lightPrimary,
                      foregroundColor: isDark ? AppColors.navyBackground : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      loc.translate('beginJourney'),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 50,
                        child: TextButton(
                          onPressed: _onFinish,
                          style: TextButton.styleFrom(
                            backgroundColor: isDark ? AppColors.buttonDark : const Color(0xFFE2E8F0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            loc.translate('skipBtn'),
                            style: GoogleFonts.plusJakartaSans(
                              color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeInOut,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark ? AppColors.goldPrimary : AppColors.lightPrimary,
                            foregroundColor: isDark ? AppColors.navyBackground : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            loc.translate('continueBtn'),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTitleSplashSlide(Map<String, String> slide, bool isDark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),

        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.03),
            border: Border.all(color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.3), width: 1),
            boxShadow: [
              BoxShadow(
                color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.12),
                blurRadius: 40,
                spreadRadius: 8,
              ),
            ],
          ),
          child: const Center(
            child: Text('🪷', style: TextStyle(fontSize: 48)),
          ),
        ).animate().scale(duration: 700.ms),

        const SizedBox(height: 40),

        Text(
          slide['title']!,
          style: GoogleFonts.cinzel(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textGold : AppColors.lightTextGold,
            letterSpacing: 3.0,
          ),
        ).animate().fadeIn(delay: 200.ms),

        const SizedBox(height: 16),

        Text(
          slide['subtitle']!,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
            letterSpacing: 2.0,
          ),
        ).animate().fadeIn(delay: 400.ms),

        const Spacer(),
      ],
    );
  }

  Widget _buildContentSlide(Map<String, String> slide, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    slide['image']!,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          (isDark ? AppColors.navyBackground : AppColors.lightBackground).withValues(alpha: 0.8),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (isDark ? AppColors.navyBackground : AppColors.lightCard).withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        slide['badge']!,
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),

          const SizedBox(height: 32),

          Text(
            slide['title']!,
            style: GoogleFonts.cinzel(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textGold : AppColors.lightTextGold,
              letterSpacing: 1.2,
              height: 1.3,
            ),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 16),

          Text(
            slide['description']!,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
              height: 1.6,
            ),
          ).animate().fadeIn(delay: 300.ms),
        ],
      ),
    );
  }
}
