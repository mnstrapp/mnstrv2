import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/sounds.dart';

enum SoundType { background, button, collect }

bool backgroundSoundMuted = false;
bool buttonSoundMuted = false;
bool collectSoundMuted = false;

Future<void> getSoundPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  backgroundSoundMuted = prefs.getBool(SoundType.background.name) ?? false;
  buttonSoundMuted = prefs.getBool(SoundType.button.name) ?? false;
  collectSoundMuted = prefs.getBool(SoundType.collect.name) ?? false;
}

Future<void> saveSoundPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(SoundType.background.name, backgroundSoundMuted);
  prefs.setBool(SoundType.button.name, buttonSoundMuted);
  prefs.setBool(SoundType.collect.name, collectSoundMuted);
}

final backgroundSoundProvider =
    StateNotifierProvider<BackgroundSoundNotifier, bool>(
      (ref) => BackgroundSoundNotifier(),
    );

class BackgroundSoundNotifier extends StateNotifier<bool> {
  BackgroundSoundNotifier() : super(backgroundSoundMuted);

  void toggleMute() {
    setMuted(!state);
  }

  Future<void> setMuted(bool value) async {
    state = value;
    backgroundSoundMuted = value;
    await saveSoundPreferences();
    !value ? BackgroundMusic().unmute() : BackgroundMusic().mute();
  }
}

final buttonSoundProvider = StateNotifierProvider<ButtonSoundNotifier, bool>(
  (ref) => ButtonSoundNotifier(),
);

class ButtonSoundNotifier extends StateNotifier<bool> {
  ButtonSoundNotifier() : super(buttonSoundMuted);

  void toggleMute() {
    setMuted(!state);
  }

  Future<void> setMuted(bool value) async {
    state = value;
    buttonSoundMuted = value;
    await saveSoundPreferences();
    !value ? ButtonSound().unmute() : ButtonSound().mute();
  }
}

final collectSoundProvider = StateNotifierProvider<CollectSoundNotifier, bool>(
  (ref) => CollectSoundNotifier(),
);

class CollectSoundNotifier extends StateNotifier<bool> {
  CollectSoundNotifier() : super(collectSoundMuted);

  void toggleMute() {
    setMuted(!state);
  }

  Future<void> setMuted(bool value) async {
    state = value;
    collectSoundMuted = value;
    await saveSoundPreferences();
    !value ? CollectSound().unmute() : CollectSound().mute();
  }
}
