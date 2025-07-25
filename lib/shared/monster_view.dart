import 'package:flutter/material.dart';

import 'monster_model.dart';

class MonsterView extends StatelessWidget {
  final MonsterModel monster;
  final double? monsterScale;
  final double? height;
  final double? width;

  const MonsterView({
    super.key,
    required this.monster,
    this.monsterScale,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final middle = Size(
      (size.width - (size.width - (size.width / (monsterScale ?? scale)))) / 4,
      (size.height - (size.height - (size.height / (monsterScale ?? scale)))) /
          3,
    );
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
                  bottom: middle.height - 89,
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
  }
}
