import 'package:flutter/material.dart';
import 'dart:math';

class StarsView extends StatefulWidget {
  const StarsView({super.key});

  @override
  State<StarsView> createState() => _StarsViewState();
}

class _StarsViewState extends State<StarsView> with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<Offset>> _animations = [];
  final List<Offset> _targetPositions = [];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    for (var i = 0; i < 150; i++) {
      final controller = AnimationController(
        duration: Duration(milliseconds: 1000 + Random().nextInt(1000)),
        vsync: this,
      );

      final targetPosition = _generateRandomTarget();
      _targetPositions.add(targetPosition);

      final animation = Tween<Offset>(
        begin: const Offset(0.5, 0.5), // Center
        end: targetPosition,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutExpo));

      _controllers.add(controller);
      _animations.add(animation);

      // Start animation with staggered delay
      Future.delayed(Duration(milliseconds: Random().nextInt(500)), () {
        if (mounted) controller.forward();
      });
    }
  }

  Offset _generateRandomTarget() {
    final random = Random();
    // Generate position near edge (0.1 to 0.9 range)
    final x = random.nextDouble() * 0.8 + 0.1;
    final y = random.nextDouble() * 0.8 + 0.1;
    return Offset(x, y);
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Widget> stars = [];

    for (var i = 0; i < 150; i++) {
      stars.add(
        AnimatedBuilder(
          animation: _animations[i],
          builder: (context, child) {
            return Positioned(
              left: _animations[i].value.dx * size.width,
              top: _animations[i].value.dy * size.height,
              child: const _StarView(),
            );
          },
        ),
      );
    }

    return Stack(children: stars);
  }
}

class _StarView extends StatelessWidget {
  const _StarView();

  @override
  Widget build(BuildContext context) {
    final starIndex = Random().nextInt(5) + 1;
    return Image.asset(
      'assets/stars/star_$starIndex.png',
      width: 25,
      height: 25,
    );
  }
}
