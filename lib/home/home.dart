import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mnstrv2/shared/stat_bar_container.dart';
import 'package:wiredash/wiredash.dart';

import '../auth/register.dart';
import '../battle/layout.dart';
import '../collect/collect.dart';
import '../providers/session_users.dart';
import '../providers/sync.dart';
import '../settings/settings.dart';
import '../ui/button.dart';
import '../providers/auth.dart';
import '../auth/login.dart';
import '../manage/list.dart';
import '../shared/layout_scaffold.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  List<Map<String, dynamic>> buttons = [];
  final GlobalKey<LayoutScaffoldState> layoutKey =
      GlobalKey<LayoutScaffoldState>();
  bool _syncing = false;

  Future<void> _buildButtons() async {
    debugPrint('building buttons');
    final auth = ref.watch(authProvider);
    debugPrint('auth: $auth');
    setState(() {
      buttons = [
        {
          'icon': Icons.qr_code_rounded,
          'text': 'Catch',
          'description': 'Catch MNSTRs',
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
          'description': 'Manage your MNSTRs',
          'onPressed': () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ManageListView()),
            );
          },
        },
        {
          'icon': Icons.map_rounded,
          'text': 'Battle',
          'description': 'Battle with other players',
          'onPressed': () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BattleLayoutView()),
            );
          },
        },
        {
          'icon': Icons.settings,
          'text': 'Settings',
          'description': 'Manage your account settings',
          'onPressed': () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsView()),
            );
          },
        },
        if (auth != null)
          {
            'icon': Icons.logout,
            'text': 'Logout',
            'description': 'Logout of your account',
            'onPressed': () async {
              final navigator = Navigator.of(context);

              final error = await ref.read(authProvider.notifier).logout();
              if (error != null) {
                layoutKey.currentState?.addError(error);
              }
              navigator.pushReplacement(
                MaterialPageRoute(builder: (context) => HomeView()),
              );
            },
          },
        if (auth == null)
          {
            'icon': Icons.login,
            'text': 'Login',
            'description': 'Login to your account',
            'onPressed': () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
              );
            },
          },
        if (auth == null)
          {
            'icon': Icons.person_add,
            'text': 'Register',
            'description': 'Register for an account',
            'onPressed': () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterView()),
              );
            },
          },
      ];
    });
  }

  Future<void> _sync() async {
    setState(() {
      _syncing = true;
    });
    String? error = await ref.read(syncProvider.notifier).sync(onlyPush: false);
    if (error != null) {
      debugPrint('Error syncing: $error');
    }
    setState(() {
      _syncing = false;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _buildButtons();
      final user = ref.watch(sessionUserProvider);
      Wiredash.trackEvent(
        'Home View',
        data: {
          'displayName': user?.displayName,
          'id': user?.id,
        },
      );
      final auth = ref.watch(authProvider);
      final previouslySynced = ref.watch(previouslySyncedProvider);
      if (auth != null && !previouslySynced) {
        _sync();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final loadingFigureSize = (size.width > size.height)
        ? size.height * 0.55
        : size.width * 0.55;
    final displayPortrait = (size.width > size.height);

    final buttonWidth = size.width * 0.66;
    final buttonHeight = 70.0;
    final buttonPadding = 8.0;
    final buttonFontSize = 24.0;
    final buttonColor = Theme.of(context).colorScheme.onPrimary;

    final syncState = ref.watch(syncProvider);
    final pushed = syncState.values
        .where((state) => state == SyncState.pushed)
        .length;
    final pulled = syncState.values
        .where((state) => state == SyncState.pulled)
        .length;

    final current = (pulled + pushed) > 0 ? (pulled + pushed) : 0;
    final total = syncState.isNotEmpty ? syncState.length : 0;

    return LayoutScaffold(
      key: layoutKey,
      useSizedBox: true,
      disableBackButton: true,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _syncing
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16,
                  children: [
                    Text('Syncing your local and remote MNSTRs'),
                    total > 0
                        ? StatBarContainer(
                            leading: Row(
                              spacing: 4,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.sync),
                                Text('Syncing'),
                              ],
                            ),
                            trailing: Text(
                              '$current/$total',
                            ),
                            currentValue: current,
                            totalValue: total,
                          )
                        : const CircularProgressIndicator(),
                  ],
                ),
              )
            : Stack(
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
                  (buttons.isNotEmpty && displayPortrait)
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
                                        buttons[index]['onPressed']
                                            as VoidCallback?,
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
                      : buttons.isNotEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: buttons
                              .map(
                                (button) => Center(
                                  child: UIButton(
                                    onPressed:
                                        button['onPressed'] as VoidCallback?,
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
                        )
                      : const Center(child: CircularProgressIndicator()),
                ],
              ),
      ),
    );
  }
}
