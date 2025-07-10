import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mnstrv2/shared/monster_container.dart';
import '../models/monster.dart' as mc;
import '../shared/monster_model.dart' as mcl;
import '../utils/color.dart';
import '../ui/inplace_text.dart';
import '../shared/layout_scaffold.dart';

class ManageEditView extends ConsumerWidget {
  final mc.Monster monster;

  const ManageEditView({super.key, required this.monster});

  void _onNameChanged(String name) {
    log(name);
  }

  void _onDescriptionChanged(String description) {
    log(description);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mnstr = mcl.Monster.fromQRCode(monster.qrCode ?? '');
    return LayoutScaffold(
      backgroundColor: Color.lerp(
        mnstr.color ?? Colors.white,
        Colors.white,
        0.5,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 46, left: 16, right: 16),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: MonsterContainer(monster: mnstr, showName: false),
            ),
            ListView(
              children: [
                InplaceText(
                  text: monster.name,
                  onChanged: _onNameChanged,
                  label: const Text('Name'),
                  backgroundColor: lightenColor(mnstr.color ?? Colors.white),
                  foregroundColor: darkenColor(mnstr.color ?? Colors.black),
                ),
                InplaceText(
                  text: monster.description,
                  label: const Text('Description'),
                  onChanged: _onDescriptionChanged,
                  minLines: 3,
                  maxLines: 10,
                  backgroundColor: lightenColor(mnstr.color ?? Colors.black12),
                  foregroundColor: darkenColor(mnstr.color ?? Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
