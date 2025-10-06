import 'dart:async';

import 'package:flame_audio/flame_audio.dart';

import '../providers/sounds.dart';

class BackgroundMusic {
  static const String _backgroundMusic = 'mnstr-game-music.m4a';
  static bool _muted = false;
  static bool _paused = false;
  static bool _playing = false;
  static double _volume = 0.75;

  BackgroundMusic() {
    backgroundSoundMuted ? mute() : unmute();
  }

  Future<void> loop() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_muted) return;
      if (!FlameAudio.bgm.isPlaying) {
        FlameAudio.bgm.play(_backgroundMusic, volume: _volume);
      }
    });
  }

  Future<void> play() async {
    if (_muted) return;
    if (_paused) {
      _paused = false;
      FlameAudio.bgm.resume();
      return;
    }
    if (_playing) return;
    _playing = true;
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play(_backgroundMusic, volume: _volume);
    loop();
  }

  Future<void> pause() async {
    _paused = true;
    FlameAudio.bgm.pause();
  }

  Future<void> resume() async {
    _paused = false;
    FlameAudio.bgm.resume();
  }

  Future<void> mute() async {
    _muted = true;
    backgroundSoundMuted = true;
    await saveSoundPreferences();
    FlameAudio.bgm.pause();
  }

  Future<void> unmute() async {
    _muted = false;
    _paused = false;
    backgroundSoundMuted = false;
    await saveSoundPreferences();
    play();
  }

  static double get volume => _volume;
  static set volume(double value) {
    _volume = value;
  }

  static bool get isMuted => _muted;
}

class ButtonSound {
  static const String _buttonSound = 'accept-2.mp3';
  static bool _muted = false;
  static double _volume = 1.0;

  ButtonSound() {
    buttonSoundMuted ? mute() : unmute();
  }

  Future<void> play() async {
    if (_muted) return;
    FlameAudio.play(_buttonSound, volume: _volume);
  }

  Future<void> mute() async {
    _muted = true;
    buttonSoundMuted = true;
    await saveSoundPreferences();
    FlameAudio.bgm.stop();
  }

  Future<void> unmute() async {
    _muted = false;
    buttonSoundMuted = false;
    await saveSoundPreferences();
  }

  static double get volume => _volume;
  static set volume(double value) {
    _volume = value;
  }

  static bool get isMuted => _muted;
}

class CollectSound {
  static const String _collectSound = 'collect-2.mp3';
  static AudioPlayer? _collectSoundPlayer;
  static bool _muted = false;
  static double _volume = 0.15;

  CollectSound() {
    collectSoundMuted ? mute() : unmute();
  }

  Future<void> play() async {
    if (_muted) return;
    _collectSoundPlayer = await FlameAudio.play(_collectSound, volume: _volume);
  }

  Future<void> stop() async {
    await _collectSoundPlayer?.stop();
  }

  Future<void> mute() async {
    _muted = true;
    collectSoundMuted = true;
    await saveSoundPreferences();
    await _collectSoundPlayer?.stop();
  }

  Future<void> unmute() async {
    _muted = false;
    collectSoundMuted = false;
    await saveSoundPreferences();
  }

  static double get volume => _volume;
  static set volume(double value) {
    _volume = value;
  }

  static bool get isMuted => _muted;
}
