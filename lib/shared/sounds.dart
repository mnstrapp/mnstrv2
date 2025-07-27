import 'dart:async';

import 'package:flame_audio/flame_audio.dart';

class BackgroundMusic {
  static const String _backgroundMusic = 'mnstr-game-music.m4a';

  Future<void> play() async {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play(_backgroundMusic);
  }

  Future<void> pause() async {
    FlameAudio.bgm.pause();
  }

  Future<void> resume() async {
    FlameAudio.bgm.resume();
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

  Future<void> play() async {
    FlameAudio.play(_collectSound);
  }
}
