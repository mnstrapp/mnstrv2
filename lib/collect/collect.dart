import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../collect/name.dart';
import '../shared/sounds.dart';
import '../shared/stars.dart';
import '../shared/monster_view.dart';
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
  final _collectSound = CollectSound();

  Future<void> _playCollectSound() async {
    await _collectSound.play();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MonsterModel? monster;
    if (_qrCode != null) {
      monster = MonsterModel.fromQRCode(base64Encode(_qrCode!));
      _playCollectSound();
    }
    final size = MediaQuery.of(context).size;

    return LayoutScaffold(
      useSizedBox: true,
      backgroundColor: Color.lerp(monster?.color, Colors.white, 0.5),
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
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: StarsView(),
                    ),
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
                            navigator.push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    SetMonsterNameView(monster: mnstr.value!),
                              ),
                            );
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
                          monster?.color,
                          Colors.black,
                          0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
