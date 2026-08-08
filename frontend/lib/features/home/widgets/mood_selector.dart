import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class MoodSelector extends StatefulWidget {
  final Function(String mood)? onMoodSelected;

  const MoodSelector({super.key, this.onMoodSelected});

  @override
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  String _selectedMood = 'Peaceful';

  final List<Map<String, String>> _moods = const [
    {'name': 'Peaceful', 'emoji': '🌿'},
    {'name': 'Calm', 'emoji': '🌊'},
    {'name': 'Grateful', 'emoji': '☀️'},
    {'name': 'Anxious', 'emoji': '🌧️'},
    {'name': 'Tired', 'emoji': '🌙'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How are you feeling right now?',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _moods.length,
            itemBuilder: (context, index) {
              final mood = _moods[index];
              final isSelected = _selectedMood == mood['name'];
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedMood = mood['name']!);
                  widget.onMoodSelected?.call(mood['name']!);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
                        : (isDark ? AppColors.darkCard : AppColors.lightCard),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: (isDark ? AppColors.darkPrimary : AppColors.lightPrimary).withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : [],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        mood['emoji']!,
                        style: const TextStyle(fontSize: 28),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        mood['name']!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? Colors.white
                              : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
