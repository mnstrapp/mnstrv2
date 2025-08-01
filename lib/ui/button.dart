import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mnstrv2/utils/color.dart';
import '../shared/sounds.dart';

class UIButton extends StatefulWidget {
  const UIButton({
    super.key,
    this.onPressed,
    this.icon,
    required this.text,
    this.margin = 0,
    this.padding = 0,
    this.width,
    this.height,
    this.fontSize,
    this.foregroundColor,
    this.backgroundColor,
    this.iconSize,
    this.center = true,
    this.onPressedAsync,
  }) : assert(
         (onPressed != null && onPressedAsync == null) ||
             (onPressed == null && onPressedAsync != null),
         'Either onPressed or onPressedAsync must be provided',
       );

  final VoidCallback? onPressed;
  final Future<void> Function()? onPressedAsync;
  final IconData? icon;
  final String text;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? iconSize;
  final double? margin;
  final double? padding;
  final double? width;
  final double? height;
  final bool center;

  @override
  State<UIButton> createState() => _UIButtonState();
}

class _UIButtonState extends State<UIButton> {
  bool _isLoading = false;
  final _buttonSound = ButtonSound();

  Future<void> _onPressed() async {
    _buttonSound.play();
    if (_isLoading) {
      return;
    }
    if (widget.onPressedAsync != null) {
      setState(() {
        _isLoading = true;
      });
      log('onPressedAsync');
      await widget.onPressedAsync!();
      setState(() {
        _isLoading = false;
      });
    } else {
      widget.onPressed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSize =
        widget.fontSize ?? Theme.of(context).textTheme.titleMedium?.fontSize;
    final iconSize = widget.iconSize ?? fontSize! + 8;
    final padding = widget.padding ?? 8;
    final margin = widget.margin ?? 0;
    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: widget.foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
      fontSize: fontSize,
    );

    return Padding(
      padding: EdgeInsets.all(margin),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: FilledButton(
          onPressed: _onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: _isLoading
                ? lightenColor(widget.backgroundColor ?? Colors.grey)
                : widget.backgroundColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: widget.center
                  ? MainAxisAlignment.center
                  : widget.icon != null
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: _isLoading
                  ? [CircularProgressIndicator(color: widget.foregroundColor)]
                  : [
                      if (widget.icon != null && !widget.center) ...[
                        SizedBox(width: padding),
                        Icon(
                          widget.icon!,
                          size: iconSize,
                          color: widget.foregroundColor,
                        ),
                        SizedBox(width: padding),
                      ],
                      if (widget.icon != null && widget.center) ...[
                        Icon(
                          widget.icon!,
                          size: iconSize,
                          color: widget.foregroundColor,
                        ),
                        SizedBox(width: padding),
                      ],
                      Text(widget.text, style: textStyle),
                    ],
            ),
          ),
        ),
      ),
    );
  }
}
