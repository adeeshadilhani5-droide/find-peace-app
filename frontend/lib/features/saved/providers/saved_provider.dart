import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedItem {
  final String id;
  final String icon;
  final String category; // 'SUTTA', 'JATAKA', 'MEDITATION', 'KARMA'
  final String title;
  final String preview;
  final String date;

  const SavedItem({
    required this.id,
    required this.icon,
    required this.category,
    required this.title,
    required this.preview,
    required this.date,
  });
}

class SavedNotifier extends StateNotifier<List<SavedItem>> {
  SavedNotifier()
      : super(const [
          SavedItem(
            id: '1',
            icon: '📜',
            category: 'SUTTA',
            title: 'Dhammapada — Mind Chapter',
            preview: '"Mind is the forerunner of all actions. All deeds are led by mind..."',
            date: 'Saved Aug 5',
          ),
          SavedItem(
            id: '2',
            icon: '🐘',
            category: 'JATAKA',
            title: 'The Patient Elephant King',
            preview: 'Jataka No. 122 · Patience (khanti) is the highest form of strength.',
            date: 'Saved Aug 3',
          ),
          SavedItem(
            id: '3',
            icon: '🪷',
            category: 'MEDITATION',
            title: 'Metta Bhavana Practice Guide',
            preview: 'Loving-Kindness Meditation · 15-20 min step-by-step instructions.',
            date: 'Saved Jul 28',
          ),
          SavedItem(
            id: '4',
            icon: '⚖️',
            category: 'KARMA',
            title: 'Understanding Karma & Grief',
            preview: 'Karma means intentional action. The grief you experience is not punishment.',
            date: 'Saved Jul 25',
          ),
        ]);

  void removeItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void toggleItem(SavedItem item) {
    if (state.any((e) => e.id == item.id)) {
      removeItem(item.id);
    } else {
      state = [item, ...state];
    }
  }

  bool isBookmarked(String id) {
    return state.any((e) => e.id == id);
  }
}

final savedProvider = StateNotifierProvider<SavedNotifier, List<SavedItem>>((ref) {
  return SavedNotifier();
});
