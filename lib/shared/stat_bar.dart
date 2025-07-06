import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/session_users.dart';

class StatBar extends ConsumerWidget {
  const StatBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
