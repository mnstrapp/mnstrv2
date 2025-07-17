import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

class BackgroundMusic {
  static const String _backgroundMusic = 'sound/mnstr-game-music.m4a';

  static final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _loop() async {
    final assetSource = AssetSource(_backgroundMusic);
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      final currentPosition = await _audioPlayer.getCurrentPosition();
      if (currentPosition == null) {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.play(assetSource);
      }
    });
  }

  Future<void> play() async {
    final assetSource = AssetSource(_backgroundMusic);
    await _audioPlayer.setSource(assetSource);
    await _audioPlayer.play(assetSource);
    _loop();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> resume() async {
    await _audioPlayer.resume();
  }
}

class ButtonSound {
  static const String _buttonSound = 'sound/accept-2.mp3';

  static final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> play() async {
    final assetSource = AssetSource(_buttonSound);
    await _audioPlayer.setSource(assetSource);
    final duration = await _audioPlayer.getDuration();
    await _audioPlayer.play(assetSource);
    await Future.delayed(duration!);
    await BackgroundMusic().resume();
  }
}

class CollectSound {
  static const String _collectSound = 'sound/collect-2.mp3';

  static final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> play() async {
    await BackgroundMusic().pause();
    final assetSource = AssetSource(_collectSound);
    await _audioPlayer.setSource(assetSource);
    final duration = await _audioPlayer.getDuration();
    await _audioPlayer.play(assetSource);
    await Future.delayed(duration!);
    await BackgroundMusic().resume();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    await BackgroundMusic().resume();
  }
}
