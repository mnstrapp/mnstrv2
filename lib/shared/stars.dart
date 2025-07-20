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
  final int _starsCount = 1000;
  final List<Widget> _stars = [];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    for (var i = 0; i < _starsCount; i++) {
      final controller = AnimationController(
        duration: Duration(milliseconds: 1000 + Random().nextInt(1000)),
        vsync: this,
        reverseDuration: Duration(milliseconds: 1000 + Random().nextInt(1000)),
      );
      controller.addStatusListener(_checkStatus(i));

      final targetPosition = _generateRandomTarget();
      _targetPositions.add(targetPosition);

      final animation =
          Tween<Offset>(
            begin: const Offset(0.5, 0.5), // Center
            end: targetPosition,
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: Curves.easeOutExpo,
              reverseCurve: Curves.easeInExpo,
            ),
          );

      _controllers.add(controller);
      _animations.add(animation);

      Future.delayed(Duration(milliseconds: Random().nextInt(500)), () {
        if (!mounted) return;
        controller.forward();
      });
    }
  }

  void Function(AnimationStatus) _checkStatus(int index) {
    return (status) {
      if (!mounted) return;
      if (status == AnimationStatus.completed) {
        Future.delayed(
          Duration(milliseconds: 3000 + Random().nextInt(1000)),
          () {
            if (!mounted) return;
            _controllers[index].reverse();
          },
        );
      }
    };
  }

  Offset _generateRandomTarget() {
    final random = Random();
    final x = random.nextDouble();
    final y = random.nextDouble();
    return Offset(x, y);
  }

  void _addStars(Size size) {
    for (var i = 0; i < _starsCount; i++) {
      _stars.add(
        AnimatedBuilder(
          animation: _animations[i],
          builder: (context, child) {
            return Positioned(
              left: (_animations[i].value.dx * size.width) - 12.5,
              top: (_animations[i].value.dy * size.height) - 12.5,
              child: const _StarView(),
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    for (var i = 0; i < _starsCount; i++) {
      _controllers[i].removeStatusListener(_checkStatus(i));
      _controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _addStars(size);

    return Stack(children: _stars);
  }
}

class _StarView extends StatefulWidget {
  const _StarView();

  @override
  State<_StarView> createState() => _StarViewState();
}

class _StarViewState extends State<_StarView> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    final duration = Duration(milliseconds: 100 + Random().nextInt(400));
    _controller = AnimationController(
      duration: duration,
      vsync: this,
      reverseDuration: duration,
    );

    _controller?.addStatusListener(_checkStatus);

    _opacityAnimation = Tween<double>(
      begin: 1,
      end: 0.7,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOutExpo));

    _controller?.forward();
  }

  void _checkStatus(AnimationStatus status) {
    if (!mounted) return;
    if (status == AnimationStatus.completed) {
      Future.delayed(Duration(milliseconds: 100 + Random().nextInt(400)), () {
        if (!mounted) return;
        _controller?.reverse();
      });
    }
    if (status == AnimationStatus.dismissed) {
      Future.delayed(Duration(milliseconds: 100 + Random().nextInt(400)), () {
        if (!mounted) return;
        _controller?.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller?.removeStatusListener(_checkStatus);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final starIndex = Random().nextInt(5) + 1;
    return AnimatedBuilder(
      animation: _opacityAnimation!,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation!.value,
          child: Image.asset(
            'assets/stars/star_$starIndex.png',
            width: 25,
            height: 25,
          ),
        );
      },
    );
  }
}
