import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // Light Theme Configuration (Clean Warm Cream & Gold)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.lightPrimary,
        secondary: AppColors.lightAccent,
        surface: AppColors.lightCard,
        onSurface: AppColors.lightTextPrimary,
        tertiary: AppColors.lightTextGold,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        displayLarge: GoogleFonts.cinzel(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.lightTextGold,
          letterSpacing: 1.5,
        ),
        headlineMedium: GoogleFonts.cinzel(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.lightTextGold,
          letterSpacing: 1.2,
        ),
        titleLarge: GoogleFonts.cinzel(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextGold,
          letterSpacing: 1.0,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: AppColors.lightTextPrimary,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.normal,
          color: AppColors.lightTextSecondary,
          height: 1.4,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.lightBorder, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightCard,
        selectedItemColor: AppColors.lightPrimary,
        unselectedItemColor: AppColors.lightTextSecondary,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // Dark Theme Configuration (Royal Navy & Gold)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.navyBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.goldPrimary,
        secondary: AppColors.goldAccent,
        surface: AppColors.navyCard,
        onSurface: AppColors.textWhite,
        tertiary: AppColors.textGold,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.cinzel(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textGold,
          letterSpacing: 1.5,
        ),
        headlineMedium: GoogleFonts.cinzel(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.textGold,
          letterSpacing: 1.2,
        ),
        titleLarge: GoogleFonts.cinzel(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textGold,
          letterSpacing: 1.0,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: AppColors.textWhite,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondary,
          height: 1.4,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.navyCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.navyBorder, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.goldPrimary,
          foregroundColor: AppColors.navyBackground,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.navyCard,
        selectedItemColor: AppColors.goldPrimary,
        unselectedItemColor: AppColors.textSecondary,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
