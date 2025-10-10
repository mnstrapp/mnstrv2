import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:wiredash/wiredash.dart';

import '../providers/session_users.dart';
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
        final user = ref.read(sessionUserProvider);
        Wiredash.trackEvent(
          'Scanner View Error',
          data: {
            'displayName': user?.displayName,
            'id': user?.id,
          },
        );
        layout.addError(error.toString());
        Sentry.captureException(error, stackTrace: stackTrace);
      },
      onDetect: (capture) {
        final user = ref.read(sessionUserProvider);
        Wiredash.trackEvent(
          'Scanner View Detected',
          data: {
            'displayName': user?.displayName,
            'id': user?.id,
          },
        );
        onScan(capture.barcodes.single.rawBytes);
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
