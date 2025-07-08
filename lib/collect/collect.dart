import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/monster.dart';
import '../ui/button.dart';
import '../providers/collect.dart';
import '../qr/scanner.dart';
import '../shared/monster_model.dart';
import '../shared/layout_scaffold.dart';

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

    return LayoutScaffold(
      backgroundColor: Color.lerp(monster?.color, Colors.white, 0.5),
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Center(
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
                        bottom: 40,
                        left: 0,
                        right: 0,
                        child: Center(child: MonsterView(monster: monster!)),
                      ),
                      Positioned(
                        bottom: size.height * 0.05,
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                        child: UIButton(
                          onPressedAsync: () async {
                            final messenger = ScaffoldMessenger.of(context);
                            final navigator = Navigator.of(context);
                            await ref
                                .read(collectProvider.notifier)
                                .collect(base64Encode(_qrCode!));
                            final mnstr = ref.read(collectProvider);
                            if (mnstr.value != null) {
                              navigator.pop();
                              messenger.showSnackBar(
                                SnackBar(content: Text('Monster collected')),
                              );
                              return;
                            }
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text('Failed to collect monster'),
                              ),
                            );
                          },
                          text: 'Collect',
                          icon: Icons.add,
                          iconSize: 24,
                          fontSize: 24,
                          padding: 8,
                          backgroundColor: Color.lerp(
                            monster.color,
                            Colors.black,
                            0.5,
                          ),
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
