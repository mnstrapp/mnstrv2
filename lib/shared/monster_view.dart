import 'package:flutter/material.dart';

import '../theme.dart';
import 'monster_model.dart';

class MonsterView extends StatelessWidget {
  final MonsterModel monster;
  final double? monsterScale;
  final double? height;
  final double? width;
  final Size size;

  const MonsterView({
    super.key,
    required this.monster,
    this.monsterScale,
    this.height,
    this.width,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final isSmallPhone =
        (size.width > smallMobileMinimumBreakpoint) &&
        (size.width < smallMobileMaximumBreakpoint);
    final isLargePhone =
        (size.width > largeMobileMinimumBreakpoint) &&
        (size.width < largeMobileMaximumBreakpoint);
    final isFoldable =
        (size.width > foldableMinimumBreakpoint) &&
        (size.width < foldableMaximumBreakpoint);
    final isTablet =
        (size.width > tabletMinimumBreakpoint) &&
        (size.width < tabletMaximumBreakpoint);
    final isWidescreen = size.width > widescreenMinimumBreakpoint;
    final middle = Size(
      (size.width - (size.width - (size.width / (monsterScale ?? scale)))) /
          (isSmallPhone
              ? 6
              : isLargePhone
              ? 4
              : isFoldable
              ? 10.5
              : isTablet
              ? 6
              : isWidescreen
              ? 3
              : 4),
      (size.height - (size.height - (size.height / (monsterScale ?? scale)))) /
          (isLargePhone ? 2.3 : 2.5),
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
