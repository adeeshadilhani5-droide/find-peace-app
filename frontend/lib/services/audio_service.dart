import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  String? _currentAudioUrl;

  AudioPlayer get player => _player;
  bool get isPlaying => _isPlaying;
  String? get currentAudioUrl => _currentAudioUrl;

  Future<void> playAudio(String url) async {
    try {
      if (_currentAudioUrl != url) {
        _currentAudioUrl = url;
        await _player.setUrl(url);
      }
      await _player.play();
      _isPlaying = true;
    } catch (e) {
      print('Audio playback error: $e');
    }
  }

  Future<void> pauseAudio() async {
    await _player.pause();
    _isPlaying = false;
  }

  Future<void> stopAudio() async {
    await _player.stop();
    _isPlaying = false;
    _currentAudioUrl = null;
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  void dispose() {
    _player.dispose();
  }
}
