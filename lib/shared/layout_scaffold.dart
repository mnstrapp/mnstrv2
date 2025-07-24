import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/color.dart';

import '../providers/sounds.dart';
import 'sounds.dart';
import 'monster_xp_bar.dart';

class LayoutScaffold extends ConsumerWidget {
  final Widget child;
  final Color? backgroundColor;
  final bool showStatBar;
  final bool useSizedBox;
  final bool useSafeArea;

  const LayoutScaffold({
    super.key,
    required this.child,
    this.backgroundColor,
    this.showStatBar = true,
    this.useSizedBox = false,
    this.useSafeArea = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMuted = ref.watch(backgroundSoundProvider);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          useSizedBox
              ? SizedBox(height: size.height, width: size.width, child: child)
              : useSafeArea
              ? SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 48),
                    child: child,
                  ),
                )
              : child,
          if (showStatBar)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(child: MonsterXpBar(color: backgroundColor)),
            ),
          Positioned(
            bottom: 16,
            right: 16,
            child: IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: darkenColor(
                  backgroundColor ?? Colors.white,
                  0.5,
                ).withAlpha(128),
              ),
              onPressed: () {
                ref.read(backgroundSoundProvider.notifier).toggleMute();
                if (isMuted) {
                  BackgroundMusic().play();
                } else {
                  BackgroundMusic().pause();
                }
              },
              icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
            ),
          ),
        ],
      ),
    );
  }
}
