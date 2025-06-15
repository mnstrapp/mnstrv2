import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerView extends StatelessWidget {
  const ScannerView({super.key, required this.onScan});
  final Function(Uint8List?) onScan;

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      onDetect: (capture) => onScan(capture.barcodes.single.rawBytes),
    );
  }
}
