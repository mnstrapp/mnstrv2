import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Collect extends StatelessWidget {
  const Collect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Collect')),
      body: Center(
        child: FilledButton.icon(
          onPressed: () {},
          icon: Icon(Icons.add),
          label: Text('Collect'),
        ),
      ),
    );
  }
}
