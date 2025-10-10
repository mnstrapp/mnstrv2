import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../models/monster.dart';
import '../theme.dart';
import '../utils/color.dart';
import 'monster_view.dart';

class MonsterContainer extends StatelessWidget {
  final Monster monster;
  final Size size;
  final double? width;
  final double? height;
  final double monsterScale;
  final BorderRadius? borderRadius;
  final bool showName;
  final bool showStats;

  const MonsterContainer({
    super.key,
    required this.monster,
    required this.size,
    this.width,
    this.height,
    this.monsterScale = 1.0,
    this.borderRadius,
    this.showName = true,
    this.showStats = true,
  });

  @override
  Widget build(BuildContext context) {
    final mnstr = monster.toMonsterModel();
    final width = this.width ?? size.width;
    final height = this.height ?? size.height;
    final backgroundColor = Color.lerp(mnstr.color, Colors.white, 0.5);
    final uiColor = lightenColor(
      Color.lerp(mnstr.color, Colors.black, 0.5) ?? Colors.black,
      0.1,
    );
    final theme = Theme.of(context);
    final monsterName = monster.mnstrName?.isNotEmpty ?? false
        ? monster.mnstrName!
        : 'unnamed';

    final detailSize = 16.0;
    final textSize = theme.textTheme.bodyMedium?.copyWith(
      fontSize: detailSize,
      fontWeight: FontWeight.bold,
      color: uiColor,
    );

    final isTablet = MediaQuery.sizeOf(context).width > tabletBreakpoint;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: backgroundColor),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: -80,
            child: MonsterView(
              monster: mnstr,
              monsterScale: monsterScale,
              height: height,
              width: width,
              size: size,
            ),
          ),
          Positioned(
            top: isTablet ? 75 : 115,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              spacing: 8,
              children: [
                Container(
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
                if (isTablet) _TabletStats(monster: monster),
                if (!isTablet) _PhoneStats(monster: monster),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PhoneStats extends StatelessWidget {
  final Monster monster;

  const _PhoneStats({required this.monster});

  @override
  Widget build(BuildContext context) {
    final mnstr = monster.toMonsterModel();
    final uiColor = lightenColor(
      Color.lerp(mnstr.color, Colors.black, 0.5) ?? Colors.black,
      0.1,
    );
    final detailSize = 16.0;
    final textSize = theme.textTheme.bodyMedium?.copyWith(
      fontSize: detailSize,
      fontWeight: FontWeight.bold,
      color: uiColor,
    );

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: uiColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Lv:', style: textSize),
                  Text(
                    '${monster.currentLevel ?? 0}',
                    style: textSize,
                  ),
                ],
              ),
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('XP:', style: textSize),
                  Text(
                    '${monster.currentExperience ?? 0}/${monster.experienceToNextLevel ?? 0}',
                    style: textSize,
                  ),
                ],
              ),
            ],
          ),
          Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Symbols.health_metrics_rounded,
                    color: uiColor,
                  ),
                  Text(
                    '${monster.maxHealth}',
                    style: textSize,
                  ),
                ],
              ),
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Symbols.swords_rounded,
                    color: uiColor,
                  ),
                  Text(
                    '${monster.maxAttack}',
                    style: textSize,
                  ),
                ],
              ),
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Symbols.magic_button_rounded,
                    color: uiColor,
                  ),
                  Text(
                    '${monster.maxMagic}',
                    style: textSize,
                  ),
                ],
              ),
            ],
          ),
          Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Symbols.shield_moon_rounded,
                    color: uiColor,
                  ),
                  Text(
                    '${monster.maxDefense}',
                    style: textSize,
                  ),
                ],
              ),
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Symbols.psychology_rounded,
                    color: uiColor,
                  ),
                  Text(
                    '${monster.maxIntelligence}',
                    style: textSize,
                  ),
                ],
              ),
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Symbols.speed_rounded,
                    color: uiColor,
                  ),
                  Text(
                    '${monster.maxSpeed}',
                    style: textSize,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TabletStats extends StatelessWidget {
  final Monster monster;

  const _TabletStats({required this.monster});

  @override
  Widget build(BuildContext context) {
    final mnstr = monster.toMonsterModel();
    final uiColor = lightenColor(
      Color.lerp(mnstr.color, Colors.black, 0.5) ?? Colors.black,
      0.1,
    );

    final detailSize = 16.0;
    final textSize = theme.textTheme.bodyMedium?.copyWith(
      fontSize: detailSize,
      fontWeight: FontWeight.bold,
      color: uiColor,
    );

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: uiColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Lv:', style: textSize),
                  Text(
                    '${monster.currentLevel ?? 0}',
                    style: textSize,
                  ),
                ],
              ),
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('XP:', style: textSize),
                  Text(
                    '${monster.currentExperience ?? 0}/${monster.experienceToNextLevel ?? 0}',
                    style: textSize,
                  ),
                ],
              ),
            ],
          ),
          Row(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Symbols.health_metrics_rounded,
                    color: uiColor,
                  ),
                  Text(
                    '${monster.maxHealth}',
                    style: textSize,
                  ),
                ],
              ),
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Symbols.swords_rounded,
                    color: uiColor,
                  ),
                  Text(
                    '${monster.maxAttack}',
                    style: textSize,
                  ),
                ],
              ),
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Symbols.magic_button_rounded,
                    color: uiColor,
                  ),
                  Text(
                    '${monster.maxMagic}',
                    style: textSize,
                  ),
                ],
              ),
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Symbols.shield_moon_rounded,
                    color: uiColor,
                  ),
                  Text(
                    '${monster.maxDefense}',
                    style: textSize,
                  ),
                ],
              ),
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Symbols.psychology_rounded,
                    color: uiColor,
                  ),
                  Text(
                    '${monster.maxIntelligence}',
                    style: textSize,
                  ),
                ],
              ),
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Symbols.speed_rounded,
                    color: uiColor,
                  ),
                  Text(
                    '${monster.maxSpeed}',
                    style: textSize,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
