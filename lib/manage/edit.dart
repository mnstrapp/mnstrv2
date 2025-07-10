import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mnstrv2/shared/monster_container.dart';
import '../models/monster.dart' as mc;
import '../shared/monster_model.dart' as mcl;
import '../utils/color.dart';
import '../ui/inplace_text.dart';
import '../shared/layout_scaffold.dart';
import '../providers/manage.dart';

class ManageEditView extends ConsumerStatefulWidget {
  final mc.Monster monster;

  const ManageEditView({super.key, required this.monster});

  @override
  ConsumerState<ManageEditView> createState() => _ManageEditViewState();
}

class _ManageEditViewState extends ConsumerState<ManageEditView> {
  late mc.Monster monster;

  @override
  void initState() {
    super.initState();
    monster = widget.monster;
  }

  void _onNameChanged(BuildContext context, String name) async {
    final messenger = ScaffoldMessenger.of(context);
    final newMonster = monster.copyWith(name: name);
    final response = await ref
        .read(manageEditProvider.notifier)
        .editMonster(newMonster);
    if (response.error == null) {
      setState(() {
        monster = newMonster;
      });
    } else {
      messenger.showSnackBar(
        SnackBar(content: Text(response.error ?? 'Failed to edit monster')),
      );
    }
  }

  void _onDescriptionChanged(BuildContext context, String description) async {
    final messenger = ScaffoldMessenger.of(context);
    final newMonster = monster.copyWith(description: description);
    final response = await ref
        .read(manageEditProvider.notifier)
        .editMonster(newMonster);
    if (response.error == null) {
      setState(() {
        monster = newMonster;
      });
    } else {
      messenger.showSnackBar(
        SnackBar(content: Text(response.error ?? 'Failed to edit monster')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  onChanged: (name) => _onNameChanged(context, name),
                  label: const Text('Name'),
                  backgroundColor: lightenColor(mnstr.color ?? Colors.white),
                  foregroundColor: darkenColor(mnstr.color ?? Colors.black),
                ),
                InplaceText(
                  text: monster.description,
                  label: const Text('Description'),
                  onChanged: (description) =>
                      _onDescriptionChanged(context, description),
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
