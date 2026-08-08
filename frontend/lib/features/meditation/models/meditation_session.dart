class MeditationSession {
  final String id;
  final String title;
  final String category;
  final int durationMinutes;
  final String description;
  final String audioUrl;
  final String imagePath;
  final String instructor;

  const MeditationSession({
    required this.id,
    required this.title,
    required this.category,
    required this.durationMinutes,
    required this.description,
    required this.audioUrl,
    required this.imagePath,
    required this.instructor,
  });

  static List<MeditationSession> get dummySessions => const [
        MeditationSession(
          id: '1',
          title: 'Morning Mindful Awakening',
          category: 'Focus',
          durationMinutes: 10,
          description: 'Start your morning with clarity, deep breathing, and purposeful peace.',
          audioUrl: 'https://assets.mixkit.co/active_storage/sfx/2571/2571-preview.mp3',
          imagePath: 'assets/images/morning.jpg',
          instructor: 'Elena Vance',
        ),
        MeditationSession(
          id: '2',
          title: 'Deep Ocean Relaxation',
          category: 'Sleep',
          durationMinutes: 20,
          description: 'Gentle waves and soothing ambient white noise to calm a restless mind.',
          audioUrl: 'https://assets.mixkit.co/active_storage/sfx/2432/2432-preview.mp3',
          imagePath: 'assets/images/ocean.jpg',
          instructor: 'Marcus Chen',
        ),
        MeditationSession(
          id: '3',
          title: 'Anxiety Release & Soft Breath',
          category: 'Stress Relief',
          durationMinutes: 15,
          description: 'Guided breathwork to release physical tension and unburden your thoughts.',
          audioUrl: 'https://assets.mixkit.co/active_storage/sfx/2874/2874-preview.mp3',
          imagePath: 'assets/images/calm.jpg',
          instructor: 'Sarah Jenkins',
        ),
        MeditationSession(
          id: '4',
          title: 'Forest Sanctuary Walk',
          category: 'Nature',
          durationMinutes: 12,
          description: 'Immerse yourself in gentle rainfall, birdsong, and whispering pines.',
          audioUrl: 'https://assets.mixkit.co/active_storage/sfx/2568/2568-preview.mp3',
          imagePath: 'assets/images/forest.jpg',
          instructor: 'David Miller',
        ),
      ];
}
