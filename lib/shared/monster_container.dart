import 'package:flutter/material.dart';
import 'monster_model.dart';
import 'monster.dart';

class MonsterContainer extends StatelessWidget {
  final Monster monster;
  final double? width;
  final double? height;
  final double? monsterScale;
  final BorderRadius? borderRadius;
  const MonsterContainer({
    super.key,
    required this.monster,
    this.width,
    this.height,
    this.monsterScale,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = this.width ?? size.width;
    final height = this.height ?? size.height;
    final backgroundColor = Color.lerp(monster.color, Colors.white, 0.5);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(4),
      ),
      child: MonsterView(
        monster: monster,
        monsterScale: monsterScale,
        height: height,
        width: width,
      ),
    );
  }
}
