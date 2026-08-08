class JournalEntry {
  final String id;
  final DateTime date;
  final String mood; // Peaceful, Calm, Grateful, Anxious, Tired
  final String title;
  final String content;
  final List<String> tags;

  const JournalEntry({
    required this.id,
    required this.date,
    required this.mood,
    required this.title,
    required this.content,
    required this.tags,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'mood': mood,
        'title': title,
        'content': content,
        'tags': tags,
      };

  factory JournalEntry.fromJson(Map<String, dynamic> json) => JournalEntry(
        id: json['id'],
        date: DateTime.parse(json['date']),
        mood: json['mood'],
        title: json['title'],
        content: json['content'],
        tags: List<String>.from(json['tags'] ?? []),
      );
}
