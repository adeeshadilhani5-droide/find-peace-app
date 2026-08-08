import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../models/meditation_session.dart';
import '../../../services/audio_service.dart';

class MeditationPlayerScreen extends StatefulWidget {
  final MeditationSession session;

  const MeditationPlayerScreen({super.key, required this.session});

  @override
  State<MeditationPlayerScreen> createState() => _MeditationPlayerScreenState();
}

class _MeditationPlayerScreenState extends State<MeditationPlayerScreen> {
  final AudioService _audioService = AudioService();
  bool _isPlaying = false;
  double _currentProgress = 0.3;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    await _audioService.playAudio(widget.session.audioUrl);
    if (!mounted) return;
    setState(() => _isPlaying = true);
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _audioService.playAudio(widget.session.audioUrl);
      } else {
        _audioService.pauseAudio();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.nightGradient : AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 32),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Text(
                      'MEDITATION SESSION',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite_border_rounded, color: Colors.white, size: 24),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to Favorites ❤️')),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Ambient Artwork / Animated Visualizer
              Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.15),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.self_improvement_rounded,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              ),

              const Spacer(),

              // Session Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    Text(
                      widget.session.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'With ${widget.session.instructor} • ${widget.session.category}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Audio Slider & Duration
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 4,
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.white24,
                        thumbColor: Colors.white,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                      ),
                      child: Slider(
                        value: _currentProgress,
                        onChanged: (val) {
                          setState(() => _currentProgress = val);
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('03:15', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          Text('10:00', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 32,
                    icon: const Icon(Icons.replay_10_rounded, color: Colors.white),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: _togglePlayPause,
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        color: AppColors.lightPrimary,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  IconButton(
                    iconSize: 32,
                    icon: const Icon(Icons.forward_10_rounded, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
