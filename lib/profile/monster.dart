import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/monster.dart';
import '../providers/users.dart';

class MonsterView extends ConsumerWidget {
  const MonsterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final size = MediaQuery.of(context).size;
    final middle = Size(
      (size.width - (size.width - (size.width / scale))) / 4,
      (size.height - (size.height - (size.height / scale))) / 3,
    );
    return user.when(
      data: (user) {
        final monster = Monster.fromQRCode(user?.qrCode ?? '');
        final monsterParts = monster.monsterParts;

        return SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                bottom: middle.height - 90,
                left: middle.width,
                child: monsterParts[MonsterPart.body]!,
              ),
              Positioned(
                bottom: middle.height + 190,
                left: middle.width,
                child: monsterParts[MonsterPart.head]!,
              ),
              monsterParts[MonsterPart.horns] != null
                  ? Positioned(
                      bottom: middle.height + 370,
                      left: middle.width,
                      child: monsterParts[MonsterPart.horns]!,
                    )
                  : const SizedBox.shrink(),
              monsterParts[MonsterPart.tail] != null
                  ? Positioned(
                      bottom: middle.height - 198,
                      left: middle.width,
                      child: monsterParts[MonsterPart.tail]!,
                    )
                  : const SizedBox.shrink(),
              Positioned(
                bottom: middle.height + 19,
                left: middle.width,
                child: monsterParts[MonsterPart.arms]!,
              ),
              monster.legs == 0
                  ? Positioned(
                      bottom: middle.height - 189,
                      left: middle.width,
                      child: monsterParts[MonsterPart.legs]!,
                    )
                  : const SizedBox.shrink(),
              monster.legs == 1
                  ? Positioned(
                      bottom: middle.height - 189,
                      left: middle.width + 1,
                      child: monsterParts[MonsterPart.legs]!,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
