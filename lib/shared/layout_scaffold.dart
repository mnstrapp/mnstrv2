import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme.dart';
import 'monster_xp_bar.dart';
import '../utils/color.dart';

class LayoutScaffold extends ConsumerStatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final bool showStatBar;
  final bool useSizedBox;
  final bool useSafeArea;
  final bool disableBackButton;

  const LayoutScaffold({
    super.key,
    required this.child,
    this.backgroundColor,
    this.showStatBar = true,
    this.useSizedBox = false,
    this.useSafeArea = false,
    this.disableBackButton = false,
  });

  @override
  ConsumerState<LayoutScaffold> createState() => LayoutScaffoldState();

  static LayoutScaffoldState of(BuildContext context) {
    LayoutScaffoldState? state = context
        .findAncestorStateOfType<LayoutScaffoldState>();

    assert(() {
      if (state == null) {
        throw FlutterError('LayoutScaffold not found in context');
      }
      return true;
    }());
    return state!;
  }

  static void setBackgroundColor(BuildContext context, Color color) {
    of(context).setBackgroundColor(color);
  }

  static Color? getBackgroundColor(BuildContext context) {
    return of(context).getBackgroundColor();
  }

  static void setUseSizedBox(BuildContext context, bool useSizedBox) {
    of(context).setUseSizedBox(useSizedBox);
  }

  static void setUseSafeArea(BuildContext context, bool useSafeArea) {
    of(context).setUseSafeArea(useSafeArea);
  }

  static void setShowStatBar(BuildContext context, bool showStatBar) {
    of(context).setShowStatBar(showStatBar);
  }

  static void setDisableBackButton(
    BuildContext context,
    bool disableBackButton,
  ) {
    of(context).setDisableBackButton(disableBackButton);
  }

  static void addMessage(
    BuildContext context,
    String message,
    IconData? icon,
    Color backgroundColor,
    Color foregroundColor,
  ) {
    of(context).addMessage(message, icon, backgroundColor, foregroundColor);
  }

  static void addError(BuildContext context, String message) {
    of(context).addError(message);
  }

  static void addSuccess(BuildContext context, String message) {
    of(context).addSuccess(message);
  }

  static void addInfo(BuildContext context, String message) {
    of(context).addInfo(message);
  }
}

class LayoutScaffoldState extends ConsumerState<LayoutScaffold> {
  Color? _backgroundColor;
  bool _useSizedBox = false;
  bool _useSafeArea = false;
  bool _showStatBar = true;
  bool _disableBackButton = false;
  _Message? _message;

  @override
  void initState() {
    super.initState();
    _backgroundColor = widget.backgroundColor;
    _useSizedBox = widget.useSizedBox;
    _useSafeArea = widget.useSafeArea;
    _showStatBar = widget.showStatBar;
    _disableBackButton = widget.disableBackButton;
  }

  void setBackgroundColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  Color? getBackgroundColor() {
    return _backgroundColor;
  }

  void setUseSizedBox(bool useSizedBox) {
    setState(() {
      _useSizedBox = useSizedBox;
    });
  }

  void setUseSafeArea(bool useSafeArea) {
    setState(() {
      _useSafeArea = useSafeArea;
    });
  }

  void setShowStatBar(bool showStatBar) {
    setState(() {
      _showStatBar = showStatBar;
    });
  }

  void setDisableBackButton(bool disableBackButton) {
    setState(() {
      _disableBackButton = disableBackButton;
    });
  }

  void addMessage(
    String message,
    IconData? icon,
    Color backgroundColor,
    Color foregroundColor,
  ) {
    setState(() {
      _message = _Message(
        message: message,
        icon: icon,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        onRemove: () {},
      );
    });
  }

  void addError(String message) {
    addMessage(
      message,
      Icons.error,
      lightenColor(Colors.red, 0.25),
      Colors.white,
    );
  }

  void addSuccess(String message) {
    addMessage(
      message,
      Icons.check,
      lightenColor(Colors.green, 0.25),
      Colors.white,
    );
  }

  void addInfo(String message) {
    addMessage(
      message,
      Icons.info,
      lightenColor(primaryColor, 0.25),
      Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Stack(
        children: [
          _useSizedBox
              ? SizedBox(
                  height: size.height,
                  width: size.width,
                  child: widget.child,
                )
              : _useSafeArea
              ? SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 48),
                    child: widget.child,
                  ),
                )
              : widget.child,
          if (_showStatBar)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: MonsterXpBar(
                  color: _backgroundColor,
                  disableBackButton: _disableBackButton,
                ),
              ),
            ),
          if (_message != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _message!.copyWith(
                onRemove: () {
                  setState(() {
                    _message = null;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  final String message;
  final IconData? icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onRemove;

  const _Message({
    required this.message,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onRemove,
  });

  _Message copyWith({
    String? message,
    IconData? icon,
    Color? backgroundColor,
    Color? foregroundColor,
    VoidCallback? onRemove,
  }) {
    return _Message(
      message: message ?? this.message,
      icon: icon ?? this.icon,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      onRemove: onRemove ?? this.onRemove,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      width: size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: InkWell(
        onTap: onRemove,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              if (icon != null) Icon(icon, color: foregroundColor),
              Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: foregroundColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
