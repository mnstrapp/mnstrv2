import 'package:flutter/material.dart';

import '../utils/color.dart';
import 'monster_model.dart';
import 'monster_view.dart';

class MonsterContainer extends StatelessWidget {
  final MonsterModel monster;
  final Size size;
  final double? width;
  final double? height;
  final double? monsterScale;
  final BorderRadius? borderRadius;
  final bool showName;

  const MonsterContainer({
    super.key,
    required this.monster,
    required this.size,
    this.width,
    this.height,
    this.monsterScale,
    this.borderRadius,
    this.showName = true,
  });

  @override
  Widget build(BuildContext context) {
    final width = this.width ?? size.width;
    final height = this.height ?? size.height;
    final backgroundColor = Color.lerp(monster.color, Colors.white, 0.5);
    final uiColor = lightenColor(
      Color.lerp(monster.color, Colors.black, 0.5) ?? Colors.black,
      0.1,
    );
    final theme = Theme.of(context);
    final monsterName = monster.toMonster().name?.isNotEmpty ?? false
        ? monster.toMonster().name!
        : 'unnamed';

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: backgroundColor),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: MonsterView(
              monster: monster,
              monsterScale: monsterScale,
              height: height,
              width: width,
              size: size,
            ),
          ),
          if (showName)
            Positioned(
              bottom: size.height * 0.05,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  width: width,
                  margin: EdgeInsets.only(left: 16, right: 16),
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: uiColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    monsterName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.surface,
                      fontFamily: 'Silkscreen',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
