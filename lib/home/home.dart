import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../collect/collect.dart';
import '../ui/button.dart';
import '../providers/auth.dart';
import '../auth/login.dart';
import '../manage/list.dart';
import '../shared/layout_scaffold.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonWidth = 220.0;
    final buttonHeight = 70.0;
    final buttonPadding = 8.0;
    final buttonFontSize = 24.0;
    final buttonColor = Theme.of(context).colorScheme.onPrimary;
    final size = MediaQuery.sizeOf(context);
    final loadingFigureSize = (size.width > size.height)
        ? size.height * 0.55
        : size.width * 0.55;
    final displayPortrait = (size.width > size.height);

    return LayoutScaffold(
      useSizedBox: true,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              bottom: displayPortrait
                  ? (size.height / 2) - (loadingFigureSize / 2)
                  : 0,
              right: displayPortrait
                  ? (size.width / 8) - (loadingFigureSize / 8)
                  : (size.width / 2) - (loadingFigureSize / 2),
              child: Center(
                child: Image.asset(
                  'assets/loading_figure.png',
                  width: loadingFigureSize,
                  height: loadingFigureSize,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: UIButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Collect()),
                      );
                    },
                    icon: Icons.add,
                    text: 'Collect',
                    margin: buttonPadding,
                    padding: buttonPadding,
                    fontSize: buttonFontSize,
                    width: buttonWidth,
                    height: buttonHeight,
                    foregroundColor: buttonColor,
                  ),
                ),
                Center(
                  child: UIButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManageListView(),
                        ),
                      );
                    },
                    icon: Icons.settings,
                    text: 'Manage',
                    margin: buttonPadding,
                    padding: buttonPadding,
                    fontSize: buttonFontSize,
                    width: buttonWidth,
                    height: buttonHeight,
                    foregroundColor: buttonColor,
                  ),
                ),

                Center(
                  child: UIButton(
                    onPressedAsync: () async {
                      final navigator = Navigator.of(context);
                      final messenger = ScaffoldMessenger.of(context);

                      final error = await ref
                          .read(authProvider.notifier)
                          .logout();
                      if (error != null) {
                        messenger.showSnackBar(SnackBar(content: Text(error)));
                      }
                      navigator.pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginView()),
                      );
                    },
                    icon: Icons.logout,
                    text: 'Logout',
                    margin: buttonPadding,
                    padding: buttonPadding,
                    fontSize: buttonFontSize,
                    width: buttonWidth,
                    height: buttonHeight,
                    foregroundColor: buttonColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
