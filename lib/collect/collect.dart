import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mnstrv2/shared/monster.dart';
import 'package:mnstrv2/ui/button.dart';

import '../qr/scanner.dart';
import '../shared/monster_model.dart';

class Collect extends ConsumerStatefulWidget {
  const Collect({super.key});

  @override
  ConsumerState<Collect> createState() => _CollectState();
}

class _CollectState extends ConsumerState<Collect> {
  Uint8List? _qrCode;

  @override
  Widget build(BuildContext context) {
    Monster? monster;
    if (_qrCode != null) {
      monster = Monster.fromQRCode(base64Encode(_qrCode!));
    }
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: _qrCode == null
            ? ScannerView(
                onScan: (data) {
                  setState(() {
                    _qrCode = data;
                  });
                },
              )
            : SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                      bottom: size.height * 0.05,
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      child: UIButton(
                        onPressed: () {},
                        text: 'Collect',
                        icon: Icons.add,
                        iconSize: 24,
                        fontSize: 24,
                        padding: 8,
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: Center(child: MonsterView(monster: monster!)),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
