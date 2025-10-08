import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme.dart';
import 'monster_xp_bar.dart';

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
    Color backgroundColor,
    Color foregroundColor,
  ) {
    of(context).addMessage(message, backgroundColor, foregroundColor);
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
  final List<_Message> _messages = [];

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
    Color backgroundColor,
    Color foregroundColor,
  ) {
    setState(() {
      _messages.add(
        _Message(
          message: message,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          onRemove: () {},
        ),
      );
    });
  }

  void addError(String message) {
    addMessage(message, Colors.red, Colors.white);
  }

  void addSuccess(String message) {
    addMessage(message, Colors.green, Colors.white);
  }

  void addInfo(String message) {
    addMessage(message, primaryColor, Colors.white);
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
          if (_messages.isNotEmpty)
            Positioned(
              top: 16,
              left: 0,
              right: 0,
              child: Column(
                spacing: 16,
                children: _messages
                    .map(
                      (message) => message.copyWith(
                        onRemove: () {
                          setState(() {
                            _messages.remove(message);
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onRemove;

  const _Message({
    required this.message,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onRemove,
  });

  _Message copyWith({
    String? message,
    Color? backgroundColor,
    Color? foregroundColor,
    VoidCallback? onRemove,
  }) {
    return _Message(
      message: message ?? this.message,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      onRemove: onRemove ?? this.onRemove,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    return Container(
      width: size.width * 0.66,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onRemove,
        child: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: foregroundColor,
          ),
        ),
      ),
    );
  }
}
