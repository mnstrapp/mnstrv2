import 'dart:developer';

import 'package:flutter/material.dart';

import '../theme.dart';
import 'monster_model.dart';

class MonsterView extends StatelessWidget {
  final MonsterModel monster;
  final double monsterScale;
  final double? height;
  final double? width;
  final Size size;
  final bool backside;

  const MonsterView({
    super.key,
    required this.monster,
    this.monsterScale = 1.0,
    this.height,
    this.width,
    required this.size,
    this.backside = false,
  });

  @override
  Widget build(BuildContext context) {
    final middle = Size(
      ((size.width * (monsterScale / 100)) + (size.width / 4)),
      size.height / 4,
    );

    final monsterParts = monster.monsterParts(
      scale: monsterScale,
      size: size,
      backside: backside,
    );

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
            bottom: middle.height,
            left: middle.width,
            child: monsterParts[MonsterPart.body]!,
          ),
          Positioned(
            bottom: middle.height,
            left: middle.width,
            child: monsterParts[MonsterPart.head]!,
          ),
          monsterParts[MonsterPart.horns] != null
              ? Positioned(
                  bottom: middle.height,
                  left: middle.width,
                  child: monsterParts[MonsterPart.horns]!,
                )
              : const SizedBox.shrink(),
          monsterParts[MonsterPart.tail] != null
              ? Positioned(
                  bottom: middle.height,
                  left: middle.width,
                  child: monsterParts[MonsterPart.tail]!,
                )
              : const SizedBox.shrink(),
          Positioned(
            bottom: middle.height,
            left: middle.width,
            child: monsterParts[MonsterPart.arms]!,
          ),
          monster.legs == 0
              ? Positioned(
                  bottom: middle.height,
                  left: middle.width,
                  child: monsterParts[MonsterPart.legs]!,
                )
              : const SizedBox.shrink(),
          monster.legs == 1
              ? Positioned(
                  bottom: middle.height,
                  left: middle.width + 1,
                  child: monsterParts[MonsterPart.legs]!,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
