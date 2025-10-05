import 'package:flutter/material.dart';
import 'package:mnstrv2/shared/stat_bar.dart';

import '../utils/color.dart';

class StatBarContainer extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final double? width;
  final double? height;
  final int currentValue;
  final int totalValue;
  final Color? color;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const StatBarContainer({
    super.key,
    this.leading,
    this.trailing,
    this.width,
    this.height,
    required this.currentValue,
    required this.totalValue,
    this.color,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    final width = this.width ?? size.width * 0.66;
    final height = this.height ?? 32;
    final padding = this.padding ?? EdgeInsets.all(4);
    final margin = this.margin ?? EdgeInsets.all(0);

    Color? backgroundColor = Color.lerp(
      this.backgroundColor ?? (color ?? theme.primaryColor),
      Colors.white,
      0.5,
    );

    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          if (leading != null) leading!,
          Expanded(
            child: StatBar(
              currentValue: currentValue,
              totalValue: totalValue,
              color: color,
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
