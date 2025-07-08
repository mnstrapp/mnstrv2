import 'package:flutter/material.dart';

import 'stat_bar.dart';

class LayoutScaffold extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const LayoutScaffold({super.key, required this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(child: child),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(child: StatBar()),
          ),
        ],
      ),
    );
  }
}
