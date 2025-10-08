import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'providers/auth.dart';
import 'providers/session_users.dart';
import 'providers/sounds.dart';
import 'shared/sounds.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getSoundPreferences();

  final auth = await getAuth();
  final user = await getSessionUser();

  final overrides = [
    authProvider.overrideWith(() => AuthNotifier(auth: auth)),
    sessionUserProvider.overrideWith(() => SessionUserNotifier(user: user)),
  ];

  if (!kIsWeb) {
    final backgroundSound = BackgroundMusic();
    backgroundSound.play();
  }

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://48d80286c61578525f7bfc797a43b7c7@o4510153534734336.ingest.us.sentry.io/4510153558720512';
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(
      SentryWidget(
        child: ProviderScope(overrides: overrides, child: const App()),
      ),
    ),
  );
}
