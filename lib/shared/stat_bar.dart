import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/session_users.dart';

class StatBar extends ConsumerStatefulWidget {
  const StatBar({super.key});

  @override
  ConsumerState<StatBar> createState() => _StatBarState();
}

class _StatBarState extends ConsumerState<StatBar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sessionUserProvider.notifier).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(sessionUserProvider);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final backgroundColor = _lightenColor(theme.primaryColor);
    final margin = EdgeInsets.only(left: 32, right: 32);
    final height = 40.0;
    final barBackgroundColor = _darkenColor(theme.primaryColor, 0.1);
    final barForegroundColor = _darkenColor(theme.primaryColor, 0.2);
    final barWidth = size.width * 0.33;
    final barHeight = 20.0;
    final barExperience = user.value?.experiencePoints ?? 1;
    final barExperienceToNextLevel = user.value?.experienceToNextLevel ?? 1;
    final barExperiencePercentage = barExperience / barExperienceToNextLevel;
    final barExperienceWidth = barWidth * barExperiencePercentage;
    final borderRadius = BorderRadius.circular(20);

    return SafeArea(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: backgroundColor,
          ),
          height: height,
          margin: margin,
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('LV: '),
                Text(
                  user.value?.experienceLevel.toString() ?? '0',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: barWidth,
                      height: barHeight,
                      margin: EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        color: barBackgroundColor,
                      ),
                    ),
                    Container(
                      width: barExperienceWidth,
                      height: barHeight,
                      margin: EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        color: barForegroundColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/items/coin.png', width: 20, height: 20),
                    Text(
                      user.value?.coins.toString() ?? '0',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Color _lightenColor(Color color, [double amount = 0.3]) {
  return HSLColor.fromColor(color)
      .withLightness((HSLColor.fromColor(color).lightness + amount).clamp(0, 1))
      .toColor();
}

Color _darkenColor(Color color, [double amount = 0.5]) {
  return HSLColor.fromColor(color)
      .withLightness((HSLColor.fromColor(color).lightness - amount).clamp(0, 1))
      .toColor();
}
