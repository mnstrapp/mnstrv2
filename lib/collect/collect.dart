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
import '../providers/manage.dart';
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
  MonsterModel? _monster;

  Future<void> _playCollectSound() async {
    await _collectSound.play();
  }

  Future<MonsterModel?> _getMonster(String qrCode) async {
    await ref.read(manageGetByQRProvider.notifier).get(qrCode);
    final existingMonster = ref.read(manageGetByQRProvider);
    MonsterModel? monster;
    existingMonster.when(
      data: (data) {
        if (data != null) {
          monster = data.toMonsterModel();
          return;
        }
        monster = MonsterModel.fromQRCode(qrCode);
      },
      error: (error, stackTrace) {
        monster = MonsterModel.fromQRCode(qrCode);
      },
      loading: () {},
    );
    return monster;
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
    final size = MediaQuery.of(context).size;
    final color = _monster?.color ?? Theme.of(context).colorScheme.primary;

    if (_monster != null) {
      _playCollectSound();
    }

    return LayoutScaffold(
      useSizedBox: true,
      backgroundColor: Color.lerp(color, Colors.white, 0.5),
      child: Center(
        child: _qrCode == null
            ? ScannerView(
                onScan: (data) async {
                  setState(() {
                    _qrCode = data;
                  });
                  if (data != null) {
                    final monster = await _getMonster(base64Encode(data));
                    setState(() {
                      _monster = monster;
                    });
                  }
                },
              )
            : _monster == null
            ? const Center(child: CircularProgressIndicator())
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
                      child: Center(child: MonsterView(monster: _monster!)),
                    ),
                    Positioned(
                      bottom: size.height * 0.05,
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      child: UIButton(
                        onPressedAsync: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          final navigator = Navigator.of(context);

                          if (_monster?.name != null) {
                            navigator.pop();
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text('Monster already collected'),
                              ),
                            );
                            return;
                          }

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
                        text: _monster?.name != null ? 'Continue' : 'Collect',
                        icon: Icons.add,
                        iconSize: 24,
                        fontSize: 24,
                        padding: 8,
                        backgroundColor: Color.lerp(color, Colors.black, 0.5),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
