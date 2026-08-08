import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../../navigation/main_navigation_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isSignUp = false;
  bool _obscurePassword = true;
  bool _rememberMe = true;
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleAuth() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();

    if (email.isEmpty || password.isEmpty || (_isSignUp && name.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (_isSignUp) {
        await ref.read(authProvider.notifier).register(name, email, password);
      } else {
        await ref.read(authProvider.notifier).login(email, password);
      }

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handleGuestLogin() async {
    setState(() => _isLoading = true);
    await ref.read(authProvider.notifier).loginAsGuest();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    }
  }

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
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Glowing Lotus Logo
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.03),
                      border: Border.all(
                        color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.4),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.2),
                          blurRadius: 30,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('🪷', style: TextStyle(fontSize: 42)),
                    ),
                  ).animate().scale(duration: 700.ms, curve: Curves.easeOutBack),

                  const SizedBox(height: 20),

                  // App Title & Tagline
                  Text(
                    loc.translate('appName'),
                    style: GoogleFonts.cinzel(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                      letterSpacing: 2.5,
                    ),
                  ).animate().fadeIn(delay: 200.ms),

                  const SizedBox(height: 4),

                  Text(
                    loc.translate('tagline'),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                      letterSpacing: 1.5,
                    ),
                  ).animate().fadeIn(delay: 300.ms),

                  const SizedBox(height: 28),

                  // Toggle Tab Segment (Sign In / Create Account)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.navyCard : AppColors.lightCard,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isSignUp = false),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: !_isSignUp
                                    ? (isDark ? AppColors.goldPrimary : AppColors.lightPrimary)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Text(
                                  'Sign In',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: !_isSignUp ? FontWeight.bold : FontWeight.w600,
                                    color: !_isSignUp
                                        ? (isDark ? AppColors.navyBackground : Colors.white)
                                        : (isDark ? AppColors.textSecondary : AppColors.lightTextSecondary),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isSignUp = true),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: _isSignUp
                                    ? (isDark ? AppColors.goldPrimary : AppColors.lightPrimary)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Text(
                                  'Create Account',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: _isSignUp ? FontWeight.bold : FontWeight.w600,
                                    color: _isSignUp
                                        ? (isDark ? AppColors.navyBackground : Colors.white)
                                        : (isDark ? AppColors.textSecondary : AppColors.lightTextSecondary),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 400.ms),

                  const SizedBox(height: 24),

                  // Auth Input Form Card
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.navyCard : AppColors.lightCard,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
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
                        // Full Name Input (Sign Up mode only)
                        if (_isSignUp) ...[
                          Text(
                            'FULL NAME',
                            style: GoogleFonts.cinzel(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: _nameController,
                            hintText: 'Enter your full name',
                            icon: Icons.person_outline_rounded,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Email Address Input
                        Text(
                          'EMAIL ADDRESS',
                          style: GoogleFonts.cinzel(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _emailController,
                          hintText: 'name@example.com',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          isDark: isDark,
                        ),

                        const SizedBox(height: 16),

                        // Password Input
                        Text(
                          'PASSWORD',
                          style: GoogleFonts.cinzel(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _passwordController,
                          hintText: '••••••••',
                          icon: Icons.lock_outline_rounded,
                          obscureText: _obscurePassword,
                          isDark: isDark,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                              size: 18,
                            ),
                            onPressed: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Remember Me & Forgot Password Row
                        if (!_isSignUp)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                      value: _rememberMe,
                                      activeColor: isDark ? AppColors.goldPrimary : AppColors.lightPrimary,
                                      checkColor: isDark ? AppColors.navyBackground : Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      onChanged: (val) {
                                        if (val != null) setState(() => _rememberMe = val);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Remember me',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Password reset link sent to your email!')),
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                        const SizedBox(height: 22),

                        // Main Action Button (Sign In / Register)
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleAuth,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark ? AppColors.goldPrimary : AppColors.lightPrimary,
                              foregroundColor: isDark ? AppColors.navyBackground : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(27),
                              ),
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: isDark ? AppColors.navyBackground : Colors.white,
                                    ),
                                  )
                                : Text(
                                    _isSignUp ? 'Create Account' : 'Sign In',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 500.ms),

                  const SizedBox(height: 24),

                  // Divider OR
                  Row(
                    children: [
                      Expanded(child: Divider(color: isDark ? AppColors.navyBorder : AppColors.lightBorder)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR CONTINUE WITH',
                          style: GoogleFonts.cinzel(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: isDark ? AppColors.navyBorder : AppColors.lightBorder)),
                    ],
                  ).animate().fadeIn(delay: 600.ms),

                  const SizedBox(height: 20),

                  // Social Auth Buttons (Google & Apple)
                  Row(
                    children: [
                      Expanded(
                        child: _buildSocialButton(
                          icon: '🌐',
                          label: 'Google',
                          isDark: isDark,
                          onTap: _handleGuestLogin,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildSocialButton(
                          icon: '🍎',
                          label: 'Apple',
                          isDark: isDark,
                          onTap: _handleGuestLogin,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 700.ms),

                  const SizedBox(height: 28),

                  // Continue as Guest Button
                  GestureDetector(
                    onTap: _handleGuestLogin,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue as Guest',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                          size: 16,
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 800.ms),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool isDark,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131C38) : const Color(0xFFF8F6F0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: GoogleFonts.plusJakartaSans(
          color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          icon: Icon(icon, color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary, size: 20),
          hintText: hintText,
          hintStyle: GoogleFonts.plusJakartaSans(
            color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
            fontSize: 13,
          ),
          border: InputBorder.none,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required String label,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.navyCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
