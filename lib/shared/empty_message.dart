import 'package:flutter/material.dart';

import '../collect/collect.dart';
import '../ui/button.dart';
import 'layout_scaffold.dart';

class EmptyMessage extends StatelessWidget {
  const EmptyMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return LayoutScaffold(
      child: SafeArea(
        child: Container(
          width: size.width,
          margin: const EdgeInsets.only(
            top: 46,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                Text(
                  'Alas, your stable is empty!',
                  style: theme.textTheme.displaySmall,
                ),
                Text(
                  'Find a QR or Bar Code and catch one!',
                  style: theme.textTheme.displayMedium,
                ),
                Text(
                  'Quickly now, the world awaits!',
                  style: theme.textTheme.displayLarge,
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: UIButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Collect(),
                        ),
                      );
                    },
                    text: 'Catch',
                    icon: Icons.qr_code_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
