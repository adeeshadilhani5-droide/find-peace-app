import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.dark) {
    _loadTheme();
  }

  static const String _key = 'find_peace_theme_mode';

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final String? themeStr = prefs.getString(_key);
    if (themeStr == 'light') {
      state = ThemeMode.light;
    } else if (themeStr == 'dark') {
      state = ThemeMode.dark;
    } else if (themeStr == 'system') {
      state = ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    if (mode == ThemeMode.light) {
      await prefs.setString(_key, 'light');
    } else if (mode == ThemeMode.dark) {
      await prefs.setString(_key, 'dark');
    } else {
      await prefs.setString(_key, 'system');
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

final fontSizeProvider = StateProvider<double>((ref) => 16.0);
