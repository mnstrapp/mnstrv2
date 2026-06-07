import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../shared/layout_scaffold.dart';
import '../theme.dart';

class ScannerView extends ConsumerWidget {
  const ScannerView({super.key, required this.onScan});
  final Function(Uint8List?) onScan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final layout = LayoutScaffold.of(context);

    return MobileScanner(
      onDetectError: (error, stackTrace) {
        layout.addError(error.toString());
      },
      onDetect: (capture) {
        if (capture.barcodes.isEmpty) {
          return;
        }
        final bytes = capture.barcodes.first.rawValue;
        onScan(bytes != null ? Uint8List.fromList(bytes.codeUnits) : null);
      },
      overlayBuilder: (context, constraints) => Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 60,
              color: primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Automatic scan',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Place a QR code in front of the camera',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
