import 'package:flutter_riverpod/flutter_riverpod.dart';

final backgroundSoundProvider =
    StateNotifierProvider<BackgroundSoundNotifier, bool>(
      (ref) => BackgroundSoundNotifier(),
    );

class BackgroundSoundNotifier extends StateNotifier<bool> {
  BackgroundSoundNotifier() : super(false);

  void toggleMute() {
    state = !state;
  }
}
