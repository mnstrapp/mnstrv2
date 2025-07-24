import 'package:flutter/material.dart';

import 'stat_bar.dart';

class StatChangeBar extends StatelessWidget {
  const StatChangeBar({
    super.key,
    required this.currentValue,
    required this.totalValue,
    this.color,
    required this.onIncrease,
    required this.onDecrease,
    required this.width,
  });

  final int currentValue;
  final int totalValue;
  final Color? color;
  final Function(int) onIncrease;
  final Function(int) onDecrease;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => onDecrease(1),
          icon: const Icon(Icons.remove),
        ),
        StatBar(
          currentValue: currentValue,
          totalValue: totalValue,
          color: color,
          width: width,
        ),
        IconButton(onPressed: () => onIncrease(1), icon: const Icon(Icons.add)),
      ],
    );
  }
}
