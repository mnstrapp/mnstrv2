import 'dart:developer';

import 'package:flutter/material.dart';

import '../utils/color.dart';

class StatBar extends StatelessWidget {
  const StatBar({
    super.key,
    required this.currentValue,
    required this.totalValue,
    this.color,
    required this.width,
  });

  final int currentValue;
  final int totalValue;
  final Color? color;
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final barBackgroundColor = darkenColor(color ?? theme.primaryColor, 0.1);
    final barForegroundColor = darkenColor(color ?? theme.primaryColor, 0.2);
    final barWidth = width;
    final barHeight = 20.0;
    final barValue = currentValue;
    final barTotal = totalValue;
    final borderRadius = BorderRadius.circular(20);
    final barValueWidth = barWidth * (barValue / barTotal);
    log(
      '[StatBar] barValueWidth: $barValueWidth, barWidth: $barWidth, barValue: $barValue, barTotal: $barTotal',
    );

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
