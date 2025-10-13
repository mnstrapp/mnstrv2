import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shared/analytics.dart';

import 'theme.dart';
import 'home/home.dart';
import 'config/env.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wiredash(
      projectId: wiredashProjectId,
      secret: wiredashApiKey,
      child: MaterialApp(
        home: const HomeView(),
        debugShowCheckedModeBanner: false,
        theme: theme,
      ),
    );
  }
}
