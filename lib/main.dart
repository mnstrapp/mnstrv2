import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'providers/auth.dart';
import 'providers/session_users.dart';
import 'shared/sounds.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final auth = await getAuth();
  final user = await getSessionUser();

  final overrides = [
    authProvider.overrideWith(() => AuthNotifier(auth: auth)),
    sessionUserProvider.overrideWith(() => SessionUserNotifier(user: user)),
  ];

  final backgroundSound = BackgroundMusic();
  backgroundSound.play();

  runApp(ProviderScope(overrides: overrides, child: const App()));
}
