import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/journal/models/journal_entry.dart';

class JournalService {
  static const String _key = 'find_peace_journal_entries';
  static const String _streakKey = 'find_peace_streak_count';

  static Future<List<JournalEntry>> getEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonStr = prefs.getString(_key);
    if (jsonStr == null) {
      return [
        JournalEntry(
          id: '1',
          date: DateTime.now().subtract(const Duration(days: 1)),
          mood: 'Peaceful',
          title: 'Morning Silence in the Garden',
          content: 'Sat outside for 15 minutes before checking my phone. Felt deeply connected and present.',
          tags: ['Gratitude', 'Morning', 'Nature'],
        ),
        JournalEntry(
          id: '2',
          date: DateTime.now().subtract(const Duration(days: 2)),
          mood: 'Calm',
          title: 'Deep Breath Work After Work',
          content: 'Practiced 4-7-8 breathing when tension started rising. Noticeable drop in heart rate.',
          tags: ['Breathing', 'Work', 'Relief'],
        ),
      ];
    }
    final List<dynamic> jsonList = jsonDecode(jsonStr);
    return jsonList.map((e) => JournalEntry.fromJson(e)).toList();
  }

  static Future<void> saveEntry(JournalEntry entry) async {
    final entries = await getEntries();
    entries.insert(0, entry);
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(entries.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonStr);
    await incrementStreak();
  }

  static Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_streakKey) ?? 5; // Default initial streak
  }

  static Future<void> incrementStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final current = await getStreak();
    await prefs.setInt(_streakKey, current + 1);
  }
}
