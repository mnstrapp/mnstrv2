import 'package:flutter/material.dart';

class UINavigationBar extends StatefulWidget {
  final Function(int) onSelected;
  final List<UINavigationBarButton> buttons;
  final int selectedIndex;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final Color? foregroundColor;
  final Color? selectedForegroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? height;
  final double? width;
  final double margin;
  final double padding;
  final double elevation;
  const UINavigationBar({
    super.key,
    required this.onSelected,
    required this.buttons,
    this.selectedIndex = 0,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.foregroundColor,
    this.selectedForegroundColor,
    this.borderColor,
    this.borderRadius,
    this.height,
    this.width,
    this.margin = 0,
    this.padding = 0,
    this.elevation = 0,
  });

  @override
  State<UINavigationBar> createState() => _UINavigationBarState();
}

class _UINavigationBarState extends State<UINavigationBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final backgroundColor = widget.backgroundColor ?? theme.colorScheme.surface;
    final selectedBackgroundColor =
        widget.selectedBackgroundColor ?? theme.colorScheme.primary;
    final foregroundColor =
        widget.foregroundColor ?? theme.colorScheme.onSurface;
    final selectedForegroundColor =
        widget.selectedForegroundColor ?? theme.colorScheme.onPrimary;
    final borderColor = widget.borderColor;
    final borderRadius = widget.borderRadius ?? 20;
    final height = widget.height ?? 60;
    final width = widget.width ?? size.width;
    final margin = widget.margin;
    final elevation = widget.elevation;

    final buttons = widget.buttons
        .asMap()
        .entries
        .map(
          (entry) => Expanded(
            child: entry.value.copyWith(
              selected: entry.key == _selectedIndex,
              onPressed: () {
                setState(() {
                  _selectedIndex = entry.key;
                });
                widget.onSelected(entry.key);
              },
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              selectedBackgroundColor: selectedBackgroundColor,
              selectedForegroundColor: selectedForegroundColor,
            ),
          ),
        )
        .toList();

    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(margin),
      // padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor != null ? Border.all(color: borderColor) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: elevation,
            offset: Offset(0, elevation),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: buttons,
        ),
      ),
    );
  }
}

class UINavigationBarButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? height;
  final double? width;
  final double margin;
  final double padding;
  final Color? selectedBackgroundColor;
  final Color? selectedForegroundColor;
  final Function()? onPressed;

  const UINavigationBarButton({
    super.key,
    required this.label,
    required this.icon,
    this.selected = false,
    this.backgroundColor,
    this.foregroundColor,
    this.height,
    this.width,
    this.margin = 0,
    this.padding = 0,
    this.selectedBackgroundColor,
    this.selectedForegroundColor,
    this.onPressed,
  });

  UINavigationBarButton copyWith({
    String? label,
    IconData? icon,
    bool? selected,
    Color? backgroundColor,
    Color? foregroundColor,
    double? height,
    double? width,
    double? margin,
    double? padding,
    Color? selectedBackgroundColor,
    Color? selectedForegroundColor,
    Function()? onPressed,
  }) {
    return UINavigationBarButton(
      label: label ?? this.label,
      icon: icon ?? this.icon,
      selected: selected ?? this.selected,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      height: height ?? this.height,
      width: width ?? this.width,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      selectedBackgroundColor:
          selectedBackgroundColor ?? this.selectedBackgroundColor,
      selectedForegroundColor:
          selectedForegroundColor ?? this.selectedForegroundColor,
      onPressed: onPressed ?? this.onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.all(margin),
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: selected ? selectedBackgroundColor : backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected ? selectedForegroundColor : foregroundColor,
            ),
            Text(
              label,
              style: TextStyle(
                color: selected ? selectedForegroundColor : foregroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
