import 'package:flutter/material.dart';

class AppColors {
  // Rich Royal Navy & Gold Theme Tokens (Dark Mode)
  static const Color navyBackground = Color(0xFF070D1E);
  static const Color navyCard = Color(0xFF0F172E);
  static const Color navyBorder = Color(0xFF1B284A);
  
  // Gold Palette
  static const Color goldPrimary = Color(0xFFF4C447);
  static const Color goldAccent = Color(0xFFE5B84B);
  static const Color goldLight = Color(0xFFF9E29B);
  static const Color goldDark = Color(0xFFB88A24);

  // Text Colors (Dark Mode)
  static const Color textGold = Color(0xFFE5B84B);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF94A3B8);

  // Buttons & UI Elements
  static const Color buttonDark = Color(0xFF162038);
  static const Color buttonGold = Color(0xFFF4C447);

  // --- Light Mode Theme Tokens ---
  static const Color lightBackground = Color(0xFFF8F6F0);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightPrimary = Color(0xFFC8961D);
  static const Color lightSecondary = Color(0xFF64748B);
  static const Color lightAccent = Color(0xFFB48614);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightTextGold = Color(0xFFB48614);

  // --- Dark Mode Theme Tokens ---
  static const Color darkBackground = Color(0xFF070D1E);
  static const Color darkCard = Color(0xFF0F172E);
  static const Color darkBorder = Color(0xFF1B284A);
  static const Color darkPrimary = Color(0xFFF4C447);
  static const Color darkSecondary = Color(0xFF94A3B8);
  static const Color darkAccent = Color(0xFFE5B84B);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  // Gradients
  static const LinearGradient navyBackgroundGradient = LinearGradient(
    colors: [Color(0xFF0C142B), Color(0xFF050814)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient lightBackgroundGradient = LinearGradient(
    colors: [Color(0xFFFCFAF5), Color(0xFFF4F0E6)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFF9E29B), Color(0xFFE5B84B), Color(0xFFB88A24)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0F172E), Color(0xFF1B284A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [Color(0xFFE5B84B), Color(0xFFB88A24)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient nightGradient = LinearGradient(
    colors: [Color(0xFF070D1E), Color(0xFF050814)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
