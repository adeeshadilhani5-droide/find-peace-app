import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../home/screens/home_screen.dart';
import '../saved/screens/saved_library_screen.dart';
import '../history/screens/history_screen.dart';
import '../profile/screens/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SavedLibraryScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.navyCard : AppColors.lightCard,
          border: Border(top: BorderSide(color: isDark ? AppColors.navyBorder : AppColors.lightBorder)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() => _selectedIndex = index);
          },
          backgroundColor: isDark ? AppColors.navyCard : AppColors.lightCard,
          selectedItemColor: isDark ? AppColors.goldPrimary : AppColors.lightPrimary,
          unselectedItemColor: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
          selectedLabelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.normal,
          ),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home_rounded),
              label: loc.translate('home'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bookmark_outline_rounded),
              activeIcon: const Icon(Icons.bookmark_rounded),
              label: loc.translate('saved'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.history_rounded),
              activeIcon: const Icon(Icons.history_rounded),
              label: loc.translate('history'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline_rounded),
              activeIcon: const Icon(Icons.person_rounded),
              label: loc.translate('profile'),
            ),
          ],
        ),
      ),
    );
  }
}
