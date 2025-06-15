import 'package:flutter/material.dart';

class UIButton extends StatelessWidget {
  const UIButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.text,
    this.margin = 0,
    this.padding = 0,
    this.width,
    this.height,
    this.fontSize,
    this.color,
    this.iconSize,
  });

  final VoidCallback onPressed;
  final IconData? icon;
  final String text;
  final double? fontSize;
  final Color? color;
  final double? iconSize;
  final double? margin;
  final double? padding;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final fontSize =
        this.fontSize ?? Theme.of(context).textTheme.titleMedium?.fontSize;
    final iconSize = this.iconSize ?? fontSize! + 8;
    final padding = this.padding ?? 8;
    final margin = this.margin ?? 0;
    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: color ?? Theme.of(context).colorScheme.onPrimary,
      fontSize: fontSize,
    );
    return Padding(
      padding: EdgeInsets.all(margin),
      child: SizedBox(
        width: width,
        height: height,
        child: FilledButton(
          onPressed: onPressed,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Row(
              mainAxisAlignment: icon != null
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  SizedBox(width: padding),
                  Icon(icon!, size: iconSize, color: color),
                  SizedBox(width: padding),
                ],
                Text(text, style: textStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
