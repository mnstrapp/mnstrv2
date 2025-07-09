import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/session_users.dart';
import '../shared/layout_scaffold.dart';
import '../shared/monster.dart';
import '../shared/monster_model.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(sessionUserProvider);
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final monster = Monster.fromQRCode(user.value?.qrCode ?? '');

    return LayoutScaffold(
      useSizedBox: true,
      backgroundColor: Color.lerp(monster.color, Colors.white, 0.5),
      child: user.when(
        data: (user) {
          return Center(
            child: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: MonsterView(monster: monster),
                  ),
                  Positioned(
                    bottom: size.height * 0.05,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          user?.displayName ?? 'No user',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
