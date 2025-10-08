import 'package:flutter/material.dart';

class ShowCaseProvider extends StatefulWidget {
  final Widget child;

  const ShowCaseProvider({
    super.key,
    required this.child,
  });

  static ShowCaseProviderState of(BuildContext context) {
    ShowCaseProviderState? state = context
        .findAncestorStateOfType<ShowCaseProviderState>();
    assert(() {
      if (state == null) {
        throw FlutterError('ShowCaseProvider not found in context');
      }
      return true;
    }());
    return state!;
  }

  static void enable(BuildContext context) {
    of(context).enable();
  }

  static void disable(BuildContext context) {
    of(context).disable();
  }

  @override
  State<ShowCaseProvider> createState() => ShowCaseProviderState();
}

class ShowCaseProviderState extends State<ShowCaseProvider> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    if (!_enabled) {
      return widget.child;
    }
    return Stack(
      children: [
        widget.child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
            ),
            child: Column(
              children: [],
            ),
          ),
        ),
      ],
    );
  }

  void enable() {
    setState(() {
      _enabled = true;
    });
  }

  void disable() {
    setState(() {
      _enabled = false;
    });
  }

  List<ShowCaseStep> findAllSteps(BuildContext context) {
    final steps = <ShowCaseStep>[];
    context.visitChildElements((element) {
      if (element is ShowCaseStep) {
        steps.add(element as ShowCaseStep);
      }
    });
    return steps;
  }
}

class ShowCaseStep extends StatefulWidget {
  final Widget child;
  final String title;
  final String description;

  const ShowCaseStep({
    required super.key,
    required this.child,
    required this.title,
    required this.description,
  });

  @override
  State<ShowCaseStep> createState() => ShowCaseStepState();
}

class ShowCaseStepState extends State<ShowCaseStep> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
