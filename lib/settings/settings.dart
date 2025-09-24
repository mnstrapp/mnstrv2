import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/sounds.dart';
import '../shared/layout_scaffold.dart';
import '../shared/sounds.dart';
import '../ui/switch.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final backgroundSoundMuted = ref.watch(backgroundSoundProvider);
    final buttonSoundMuted = ref.watch(buttonSoundProvider);
    final collectSoundMuted = ref.watch(collectSoundProvider);

    return LayoutScaffold(
      child: SafeArea(
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
