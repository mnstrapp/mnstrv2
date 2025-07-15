import 'dart:developer';

import 'package:just_audio/just_audio.dart';

class BackgroundMusic {
  static const String _backgroundMusic = 'assets/sound/mnstr-game-music.m4a';

  static final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> play() async {
    try {
      await _audioPlayer.setAudioSource(AudioSource.asset(_backgroundMusic));
      await _audioPlayer.play();
    } catch (e) {
      log('Error playing background music: $e');
    }
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }
}
