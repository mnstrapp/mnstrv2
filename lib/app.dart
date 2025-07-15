import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme.dart';
import 'providers/auth.dart';
import 'home/home.dart';
import 'auth/login.dart';
import 'shared/sounds.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  late final _backgroundMusic = BackgroundMusic();

  @override
  void initState() {
    super.initState();
    _backgroundMusic.play();
  }

  @override
  void dispose() {
    _backgroundMusic.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    return MaterialApp(
      home: auth.when(
        data: (auth) {
          if (auth == null) {
            return LoginView();
          }
          return HomeView();
        },
        error: (error, stack) {
          log('Error: $error\n$stack');
          return const LoginView();
        },
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      debugShowCheckedModeBanner: false,
      theme: theme,
    );
  }
}
