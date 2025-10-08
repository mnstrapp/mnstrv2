import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';

class UISwitch extends StatefulWidget {
  final bool value;
  final Function(bool)? onChanged;
  final double? height;
  final double? width;
  final double? margin;
  final double? borderRadius;
  final Color? activeBackgroundColor;
  final Color? inactiveBackgroundColor;
  final Color? activeForegroundColor;
  final Color? inactiveForegroundColor;
  final Color? activeBorderColor;
  final Color? inactiveBorderColor;

  const UISwitch({
    super.key,
    this.value = false,
    this.onChanged,
    this.height = 30,
    this.width = 64,
    this.margin = 8,
    this.borderRadius = 16,
    this.activeBackgroundColor,
    this.inactiveBackgroundColor,
    this.activeForegroundColor,
    this.inactiveForegroundColor,
    this.activeBorderColor,
    this.inactiveBorderColor,
  });

  @override
  State<UISwitch> createState() => _UISwitchState();
}

class _UISwitchState extends State<UISwitch> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final margin = widget.margin ?? 8;
    final borderRadius = widget.borderRadius ?? 16;
    final width = widget.width ?? 64;
    final height = widget.height ?? 20;
    final inactiveBorderColor =
        widget.inactiveBorderColor ??
        Color.lerp(theme.colorScheme.primaryContainer, Colors.black, 0.66) ??
        theme.colorScheme.primaryContainer;
    final activeForegroundColor =
        widget.activeForegroundColor ??
        Color.lerp(theme.colorScheme.primary, Colors.white, 0.33);

    return InkWell(
      onTap: () {
        Wiredash.trackEvent(
          'UISwitch Tapped',
          data: {
            'value': _value,
          },
        );
        setState(() {
          _value = !_value;
        });
        widget.onChanged?.call(_value);
      },
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.all(margin / 2),
        padding: EdgeInsets.all(margin / 4),
        decoration: BoxDecoration(
          // color:
          //     Color.lerp(activeBackgroundColor, Colors.grey, 0.66) ??
          //     activeBackgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: inactiveBorderColor, width: 2),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                if (_value)
                  Expanded(
                    child: Container(
                      height: height,
                      decoration: BoxDecoration(
                        color: activeForegroundColor,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                  ),
              ],
            ),
            Positioned(
              left: _value ? null : 0,
              right: _value ? 0 : null,
              child: Container(
                width: height - 8,
                height: height - 8,
                decoration: BoxDecoration(
                  color: inactiveBorderColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
