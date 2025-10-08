import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiredash/wiredash.dart';

import '../manage/edit.dart';
import '../home/home.dart';
import '../providers/session_users.dart';
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
  bool _saved = false;
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
    final user = ref.watch(sessionUserProvider);
    final error = await ref.read(manageGetByQRProvider.notifier).get(qrCode);
    if (error != null) {
      Wiredash.trackEvent(
        'Collect Monster Error',
        data: {
          'error': error,
          'monster': _monster?.id,
          'displayName': user.value?.displayName,
          'id': user.value?.id,
        },
      );
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

  Future<void> _collectMonster() async {
    final messenger = ScaffoldMessenger.of(context);
    final user = ref.watch(sessionUserProvider);

    if (_monster?.id != null) {
      Wiredash.trackEvent(
        'Collect Monster Previously Collected',
        data: {
          'error': 'Monster previously collected',
          'monster': _monster?.id,
          'displayName': user.value?.displayName,
          'id': user.value?.id,
        },
      );
      messenger.showSnackBar(
        SnackBar(content: Text('Monster previously collected')),
      );
      setState(() {
        _saved = true;
      });
      return;
    }

    if (_monster?.id == null) {
      if (context.mounted) {
        await _saveMonster();
      }
      return;
    }
  }

  Future<void> _saveMonster() async {
    final user = ref.watch(sessionUserProvider);
    final messenger = ScaffoldMessenger.of(context);
    final error = await ref
        .read(collectProvider.notifier)
        .createMonster(_monster!.toMonster());
    if (error != null) {
      Wiredash.trackEvent(
        'Collect Monster Error',
        data: {
          'error': error,
          'monster': _monster?.id,
          'displayName': user.value?.displayName,
          'id': user.value?.id,
        },
      );
      messenger.showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    final monster = ref.read(collectProvider);
    Wiredash.trackEvent(
      'Collect Monster Success',
      data: {
        'monster': monster?.id,
        'displayName': user.value?.displayName,
        'id': user.value?.id,
      },
    );
    setState(() {
      _monster = monster?.toMonsterModel();
      _saved = true;
    });
    if (context.mounted) {
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
                    await _collectMonster();
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
                        child: _saved
                            ? InkWell(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ManageEditView(
                                      monster: _monster!.toMonster(),
                                    ),
                                  ),
                                ),
                                child: MonsterView(
                                  monster: _monster!,
                                  size: size,
                                ),
                              )
                            : MonsterView(monster: _monster!, size: size),
                      ),
                    ),
                    if (!_saved)
                      Positioned(
                        top: size.height * 0.5,
                        bottom: size.height * 0.5,
                        left: size.width * 0.5,
                        right: size.width * 0.5,
                        child: CircularProgressIndicator(),
                      ),
                    if (_saved)
                      Positioned(
                        bottom: size.height * 0.05,
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                        child: UIButton(
                          onPressedAsync: () =>
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => ManageEditView(
                                    monster: _monster!.toMonster(),
                                  ),
                                ),
                              ),
                          text: 'View MNSTR',
                          icon: Icons.view_carousel_rounded,
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
