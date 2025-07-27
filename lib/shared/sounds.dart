import 'dart:async';

import 'package:flame_audio/flame_audio.dart';

class BackgroundMusic {
  static const String _backgroundMusic = 'mnstr-game-music.m4a';
  static bool _muted = false;

  Future<void> loop() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_muted) return;
      if (!FlameAudio.bgm.isPlaying) {
        FlameAudio.bgm.play(_backgroundMusic);
      }
    });
  }

  Future<void> play() async {
    if (_muted) {
      resume();
      return;
    }
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play(_backgroundMusic);
    loop();
  }

  Future<void> pause() async {
    FlameAudio.bgm.pause();
  }

  Future<void> resume() async {
    _muted = false;
    FlameAudio.bgm.resume();
  }

  Future<void> mute() async {
    _muted = true;
    FlameAudio.bgm.pause();
  }
}

class ButtonSound {
  static const String _buttonSound = 'accept-2.mp3';

  Future<void> play() async {
    FlameAudio.play(_buttonSound);
  }
}

class CollectSound {
  static const String _collectSound = 'collect-2.mp3';
  static AudioPlayer? _collectSoundPlayer;

  Future<void> play() async {
    _collectSoundPlayer = await FlameAudio.play(_collectSound, volume: 0.15);
  }

  Future<void> stop() async {
    await _collectSoundPlayer?.stop();
  }
}
