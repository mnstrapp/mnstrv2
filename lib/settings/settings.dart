import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login.dart';
import '../providers/auth.dart';
import '../providers/local_storage.dart';
import '../providers/sounds.dart';
import '../providers/users.dart';
import '../shared/layout_scaffold.dart';
import '../shared/sounds.dart';
import '../ui/button.dart';
import '../ui/switch.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  final _overlayPortalController = OverlayPortalController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundSoundMuted = ref.watch(backgroundSoundProvider);
    final buttonSoundMuted = ref.watch(buttonSoundProvider);
    final collectSoundMuted = ref.watch(collectSoundProvider);

    final size = MediaQuery.sizeOf(context);

    return LayoutScaffold(
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(
                top: 64,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                spacing: 16,
                children: [
                  Text('Settings', style: theme.textTheme.titleLarge),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        spacing: 8,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Background Sound'),
                              UISwitch(
                                value: !backgroundSoundMuted,
                                onChanged: (value) async {
                                  await ref
                                      .read(backgroundSoundProvider.notifier)
                                      .setMuted(!value);
                                  ButtonSound().play();
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Button Sound'),
                              UISwitch(
                                value: !buttonSoundMuted,
                                onChanged: (value) async {
                                  await ref
                                      .read(buttonSoundProvider.notifier)
                                      .setMuted(!value);
                                  ButtonSound().play();
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Collect Sound'),
                              UISwitch(
                                value: !collectSoundMuted,
                                onChanged: (value) async {
                                  await ref
                                      .read(collectSoundProvider.notifier)
                                      .setMuted(!value);
                                  ButtonSound().play();
                                },
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Local MNSTRs'),
                              UIButton(
                                icon: Icons.delete_forever_rounded,
                                text: 'Clear',
                                onPressedAsync: () async {
                                  await LocalStorage.clearMnstrs();
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Local Preferences'),
                              UIButton(
                                icon: Icons.delete_forever_rounded,
                                text: 'Clear',
                                onPressedAsync: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.clear();
                                },
                              ),
                            ],
                          ),
                          Divider(),
                          UIButton(
                            icon: Icons.delete_forever_rounded,
                            text: 'Delete Account',
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            onPressed: () async {
                              _overlayPortalController.show();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            child: OverlayPortal(
              controller: _overlayPortalController,
              overlayChildBuilder: (context) {
                return Container(
                  padding: EdgeInsets.all(size.width * 0.25),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 16,
                        children: [
                          Text(
                            'Are you sure that you want to delete your account?',
                          ),
                          Text(
                            'This action is irreversible and will delete all your data.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.red,
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 32.0,
                              right: 32.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (_isLoading) {
                                      return;
                                    }
                                    _overlayPortalController.hide();
                                  },
                                  child: Text('Cancel'),
                                ),
                                FilledButton(
                                  onPressed: () async {
                                    if (_isLoading) {
                                      return;
                                    }
                                    final messenger = ScaffoldMessenger.of(
                                      context,
                                    );
                                    final navigator = Navigator.of(context);
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    final error = await ref
                                        .read(userProvider.notifier)
                                        .deleteAccount();
                                    if (error != null) {
                                      messenger.showSnackBar(
                                        SnackBar(content: Text(error)),
                                      );
                                      return;
                                    }
                                    await ref
                                        .read(authProvider.notifier)
                                        .logout();
                                    _overlayPortalController.hide();
                                    navigator.pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => LoginView(),
                                      ),
                                    );
                                    messenger.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Account deleted successfully',
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: _isLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          'Delete',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
