import 'dart:developer';

import 'package:flutter/material.dart';

import '../utils/color.dart';

class StatBar extends StatelessWidget {
  const StatBar({
    super.key,
    required this.currentValue,
    required this.totalValue,
    this.color,
    this.width,
  });

  final int currentValue;
  final int totalValue;
  final Color? color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final width = this.width ?? size.width;

    final barBackgroundColor = darkenColor(color ?? theme.primaryColor, 0.25);
    final barForegroundColor = darkenColor(
      Color.lerp(color ?? theme.primaryColor, Colors.white, 0.25) ??
          theme.primaryColor,
      0.5,
    );
    final barWidth = width;
    final barHeight = 20.0;
    final barValue = currentValue >= 0 ? currentValue : 0;
    final barTotal = totalValue >= 0 ? totalValue : 0;
    final barValuePercentage = barValue / barTotal;
    final borderRadius = BorderRadius.circular(20);
    final barValueWidth = barWidth * barValuePercentage;

    log('barValuePercentage: $barValuePercentage');
    log('barValueWidth: $barValueWidth / $barWidth');

    return Stack(
      children: [
        Container(
          width: barWidth,
          height: barHeight,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: barBackgroundColor,
          ),
        ),
        Container(
          width: barValueWidth,
          height: barHeight,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: barForegroundColor,
          ),
        ),
      ],
    );
  }
}
