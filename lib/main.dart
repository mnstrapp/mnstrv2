import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'providers/auth.dart';
import 'providers/local_storage.dart';
import 'providers/session_users.dart';
import 'providers/sounds.dart';
import 'providers/sync.dart';
import 'shared/sounds.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getSoundPreferences();

  final auth = await getAuth();
  final user = await getSessionUser();
  final previouslySynced = await getPreviouslySynced();

  await LocalStorage.init();

  final overrides = [
    authProvider.overrideWith(() => AuthNotifier(auth: auth)),
    sessionUserProvider.overrideWith(() => SessionUserNotifier(user: user)),
    previouslySyncedProvider.overrideWith(
      () => PreviouslySyncedNotifier(previouslySynced: previouslySynced),
    ),
  ];

  if (!kIsWeb) {
    final backgroundSound = BackgroundMusic();
    backgroundSound.play();
  }

  runApp(ProviderScope(overrides: overrides, child: const App()));
}
