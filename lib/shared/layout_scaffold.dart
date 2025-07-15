import 'package:flutter/material.dart';
import '../utils/color.dart';

import 'sounds.dart';
import 'stat_bar.dart';

class LayoutScaffold extends StatefulWidget {
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
  State<LayoutScaffold> createState() => _LayoutScaffoldState();
}

class _LayoutScaffoldState extends State<LayoutScaffold> {
  bool _isMuted = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Stack(
        children: [
          widget.useSizedBox
              ? SizedBox(
                  height: size.height,
                  width: size.width,
                  child: widget.child,
                )
              : widget.child,
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(child: StatBar(color: widget.backgroundColor)),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: darkenColor(
                  widget.backgroundColor ?? Colors.white,
                  0.5,
                ).withAlpha(128),
              ),
              onPressed: () {
                if (_isMuted) {
                  BackgroundMusic().play();
                } else {
                  BackgroundMusic().pause();
                }
                setState(() {
                  _isMuted = !_isMuted;
                });
              },
              icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
            ),
          ),
        ],
      ),
    );
  }
}
