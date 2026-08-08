import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  
  String _phaseText = 'Tap Start to Begin';
  int _completedCycles = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12), // 4s inhale, 4s hold, 4s exhale
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.6), weight: 4), // Inhale
      TweenSequenceItem(tween: ConstantTween(1.6), weight: 4),          // Hold
      TweenSequenceItem(tween: Tween(begin: 1.6, end: 1.0), weight: 4), // Exhale
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addListener(() {
      final value = _controller.value;
      if (!_isRunning) return;

      if (value < 0.33) {
        if (_phaseText != 'Inhale Deeply...') {
          setState(() => _phaseText = 'Inhale Deeply...');
        }
      } else if (value < 0.66) {
        if (_phaseText != 'Hold Your Breath...') {
          setState(() => _phaseText = 'Hold Your Breath...');
        }
      } else {
        if (_phaseText != 'Slowly Exhale...') {
          setState(() => _phaseText = 'Slowly Exhale...');
        }
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && _isRunning) {
        setState(() => _completedCycles++);
        _controller.forward(from: 0);
      }
    });
  }

  void _toggleBreathing() {
    setState(() {
      _isRunning = !_isRunning;
      if (_isRunning) {
        _controller.forward(from: 0);
      } else {
        _controller.stop();
        _phaseText = 'Paused';
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindful Breathing'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            // Animated Breathing Circle
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
                              .withValues(alpha: 0.4),
                          blurRadius: 30 * _scaleAnimation.value,
                          spreadRadius: 10 * _scaleAnimation.value,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                        child: const Icon(
                          Icons.air_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            const Spacer(),

            // Phase Text
            Text(
              _phaseText,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Completed Cycles: $_completedCycles',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),

            const Spacer(),

            // Controls
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _toggleBreathing,
                  icon: Icon(_isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded),
                  label: Text(_isRunning ? 'Pause Session' : 'Start Session'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
