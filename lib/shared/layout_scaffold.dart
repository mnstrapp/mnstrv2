import 'package:flutter/material.dart';

import 'stat_bar.dart';

class LayoutScaffold extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final bool showStatBar;
  final bool useSizedBox;

  const LayoutScaffold({
    super.key,
    required this.child,
    this.backgroundColor,
    this.showStatBar = true,
    this.useSizedBox = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: useSizedBox
                ? SizedBox(height: size.height, width: size.width, child: child)
                : child,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(child: StatBar(color: backgroundColor)),
          ),
        ],
      ),
    );
  }
}
