import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiredash/wiredash.dart';

import 'theme.dart';
import 'providers/auth.dart';
import 'home/home.dart';
import 'auth/login.dart';
import 'config/env.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('[app] wiredashProjectId: $wiredashProjectId');
    log('[app] wiredashApiKey: $wiredashApiKey');
    final auth = ref.watch(authProvider);
    return Wiredash(
      projectId: wiredashProjectId,
      secret: wiredashApiKey,
      child: MaterialApp(
        home: auth.when(
          data: (auth) {
            if (auth == null) {
              return const LoginView();
            }
            return const HomeView();
          },
          error: (error, stack) {
            log('Error: $error\n$stack');
            return const LoginView();
          },
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        ),
        debugShowCheckedModeBanner: false,
        theme: theme,
      ),
    );
  }
}
