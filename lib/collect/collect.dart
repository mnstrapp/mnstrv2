import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'new_monster.dart';
import '../home/home.dart';
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
  bool _isCollected = false;
  bool _collectionSoundPlayed = false;

  Future<void> _playCollectSound() async {
    if (!_collectionSoundPlayed) {
      _collectSound.play();
      setState(() {
        _collectionSoundPlayed = true;
      });
    }
  }

  Future<MonsterModel?> _getMonster(String qrCode) async {
    final error = await ref.read(manageGetByQRProvider.notifier).get(qrCode);
    if (error != null) {
      log('[getMonster] error: $error');
      return MonsterModel.fromQRCode(qrCode);
    }
    final mnstr = ref.read(manageGetByQRProvider);
    return mnstr.when(
      data: (data) {
        return data?.toMonsterModel();
      },
      error: (error, stackTrace) {
        return null;
      },
      loading: () {
        return null;
      },
    );
  }

  Future<void> _collectMonster(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    await _collectSound.stop();

    if (_monster?.name != null) {
      navigator.pop();
      messenger.showSnackBar(
        SnackBar(content: Text('Monster already collected')),
      );
      return;
    }

    if (_monster?.name == null) {
      setState(() {
        _isCollected = true;
      });
      if (context.mounted) {
        await _saveMonster(context);
      }
      return;
    }
  }

  Future<void> _saveMonster(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewMonsterView(monster: _monster!.toMonster()),
      ),
    );
    if (result == null) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Monster not saved')),
      );
      return;
    }
    if (context.mounted) {
      navigator.pushReplacement(
        MaterialPageRoute(builder: (context) => HomeView()),
      );
      messenger.showSnackBar(const SnackBar(content: Text('Monster saved')));
    }
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
                      child: Center(
                        child: MonsterView(monster: _monster!, size: size),
                      ),
                    ),
                    Positioned(
                      bottom: size.height * 0.05,
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      child: UIButton(
                        onPressedAsync: () => _collectMonster(context),
                        text: _monster?.name != null ? 'Continue' : 'Catch Me!',
                        // icon: Icons.add,
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
