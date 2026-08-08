import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../providers/saved_provider.dart';
import '../../sutta/screens/sutta_detail_screen.dart';
import '../../story/screens/story_detail_screen.dart';
import '../../karma/screens/karma_detail_screen.dart';
import '../../meditation/screens/metta_bhavana_screen.dart';

class SavedLibraryScreen extends ConsumerStatefulWidget {
  const SavedLibraryScreen({super.key});

  @override
  ConsumerState<SavedLibraryScreen> createState() => _SavedLibraryScreenState();
}

class _SavedLibraryScreenState extends ConsumerState<SavedLibraryScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['All', 'Sutta', 'Jataka', 'Meditation', 'Karma'];

  @override
  Widget build(BuildContext context) {
    final savedItems = ref.watch(savedProvider);
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final selectedCat = _categories[_selectedCategoryIndex].toUpperCase();
    final filteredItems = savedItems.where((item) {
      if (selectedCat == 'ALL') return true;
      return item.category == selectedCat;
    }).toList();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.navyBackgroundGradient : AppColors.lightBackgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.translate('savedLibrary'),
                      style: GoogleFonts.cinzel(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      loc.translate('savedLibrarySub'),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Filter Category Chips Bar
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedCategoryIndex == index;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedCategoryIndex = index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (isDark ? AppColors.goldPrimary : AppColors.lightPrimary)
                                : (isDark ? AppColors.navyCard : AppColors.lightCard),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? (isDark ? AppColors.goldPrimary : AppColors.lightPrimary)
                                  : (isDark ? AppColors.navyBorder : AppColors.lightBorder),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _categories[index],
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                color: isSelected
                                    ? (isDark ? AppColors.navyBackground : Colors.white)
                                    : (isDark ? AppColors.textSecondary : AppColors.lightTextSecondary),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Saved Cards List or Empty State
              Expanded(
                child: filteredItems.isEmpty
                    ? _buildEmptyState(isDark)
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: _buildSavedCard(
                              context,
                              isDark: isDark,
                              item: item,
                              onTap: () => _navigateToDetail(context, item.category),
                              onDelete: () {
                                ref.read(savedProvider.notifier).removeItem(item.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Removed from library')),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, String category) {
    if (category == 'SUTTA') {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SuttaDetailScreen()));
    } else if (category == 'JATAKA') {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const StoryDetailScreen()));
    } else if (category == 'KARMA') {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const KarmaDetailScreen()));
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MettaBhavanaScreen()));
    }
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🪷', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(
            'No Saved Items Found',
            style: GoogleFonts.cinzel(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textGold : AppColors.lightTextGold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Items you bookmark will appear in your library',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ).animate().fadeIn(duration: 400.ms),
    );
  }

  Widget _buildSavedCard(
    BuildContext context, {
    required bool isDark,
    required SavedItem item,
    required VoidCallback onTap,
    required VoidCallback onDelete,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? AppColors.navyCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(item.icon, style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Text(
                      item.category,
                      style: GoogleFonts.cinzel(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(Icons.bookmark_rounded, color: isDark ? AppColors.goldPrimary : AppColors.lightPrimary, size: 20),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              item.title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.preview,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.date,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}
