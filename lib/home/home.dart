import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../collect/collect.dart';
import '../settings/settings.dart';
import '../ui/button.dart';
import '../providers/auth.dart';
import '../auth/login.dart';
import '../manage/list.dart';
import '../shared/layout_scaffold.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final loadingFigureSize = (size.width > size.height)
        ? size.height * 0.55
        : size.width * 0.55;
    final displayPortrait = (size.width > size.height);

    final buttons = [
      {
        'icon': Icons.library_add_rounded,
        'text': 'Catch',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Collect()),
          );
        },
      },
      {
        'icon': Icons.view_carousel_rounded,
        'text': 'MNSTRs',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ManageListView()),
          );
        },
      },
      {
        'icon': Icons.settings,
        'text': 'Settings',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsView()),
          );
        },
      },
      {
        'icon': Icons.logout,
        'text': 'Logout',
        'onPressed': () async {
          final navigator = Navigator.of(context);
          final messenger = ScaffoldMessenger.of(context);
          final error = await ref.read(authProvider.notifier).logout();
          if (error != null) {
            messenger.showSnackBar(SnackBar(content: Text(error)));
          }
          navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => LoginView()),
          );
        },
      },
    ];

    final buttonWidth = size.width * 0.66;
    final buttonHeight = 70.0;
    final buttonPadding = 8.0;
    final buttonFontSize = 24.0;
    final buttonColor = Theme.of(context).colorScheme.onPrimary;

    return LayoutScaffold(
      useSizedBox: true,
      disableBackButton: true,
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
            displayPortrait
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 64,
                      bottom: 16,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 4,
                                ),
                            itemBuilder: (context, index) => UIButton(
                              onPressed:
                                  buttons[index]['onPressed'] as VoidCallback?,
                              icon: buttons[index]['icon'] as IconData?,
                              text: buttons[index]['text'] as String?,
                              margin: buttonPadding,
                              padding: buttonPadding,
                              fontSize: buttonFontSize,
                              width: buttonWidth,
                              height: buttonHeight,
                              foregroundColor: buttonColor,
                            ),
                            itemCount: buttons.length,
                          ),
                        ),
                        SizedBox(width: size.width * 0.33),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: buttons
                        .map(
                          (button) => Center(
                            child: UIButton(
                              onPressed: button['onPressed'] as VoidCallback?,
                              icon: button['icon'] as IconData?,
                              text: button['text'] as String?,
                              margin: buttonPadding,
                              padding: buttonPadding,
                              fontSize: buttonFontSize,
                              width: buttonWidth,
                              height: buttonHeight,
                              foregroundColor: buttonColor,
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
