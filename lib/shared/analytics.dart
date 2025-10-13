import 'package:flutter/widgets.dart';

class Wiredash extends StatelessWidget {
  final Widget child;
  const Wiredash({
    super.key,
    required this.child,
    required String projectId,
    required String secret,
  });

  @override
  Widget build(BuildContext context) => child;

  static Future<void> trackEvent(
    String name, {
    Map<String, Object?> data = const {},
  }) async {}
}
