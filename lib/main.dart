import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'providers/auth.dart';
import 'providers/users.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final auth = await getAuth();
  final user = await getUser();

  final overrides = [
    authProvider.overrideWith(() => AuthNotifier(auth: auth)),
    userProvider.overrideWith(() => UserNotifier(user: user)),
  ];

  runApp(ProviderScope(overrides: overrides, child: const App()));
}
