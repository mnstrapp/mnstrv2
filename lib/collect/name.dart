import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/collect.dart';
import '../models/monster.dart' as m;
import '../shared/monster_model.dart' as mm;
import '../shared/layout_scaffold.dart';
import '../ui/button.dart';
import '../ui/inplace_text.dart';
import '../utils/color.dart';
import '../home/home.dart';

class SetMonsterNameView extends ConsumerStatefulWidget {
  final m.Monster monster;
  const SetMonsterNameView({super.key, required this.monster});

  @override
  ConsumerState<SetMonsterNameView> createState() => _SetMonsterNameViewState();
}

class _SetMonsterNameViewState extends ConsumerState<SetMonsterNameView> {
  final _nameController = TextEditingController();

  Future<void> _setName() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    await ref
        .read(collectProvider.notifier)
        .setName(name: _nameController.text, monsterId: widget.monster.id!);
    final mnstr = ref.read(collectProvider);
    mnstr.when(
      data: (data) {
        if (data != null) {
          navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => HomeView()),
          );
          messenger.showSnackBar(
            SnackBar(content: Text('MNSTR ${data.name} ready to use!')),
          );
        } else {
          messenger.showSnackBar(
            SnackBar(content: Text('Failed to set name: ${mnstr.error}')),
          );
        }
      },
      error: (error, stackTrace) {
        messenger.showSnackBar(
          SnackBar(content: Text('Failed to set name: $error')),
        );
      },
      loading: () {},
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.monster.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final monster = mm.MonsterModel.fromQRCode(widget.monster.qrCode!);
    final color = Color.lerp(monster.color, Colors.white, 0.5);
    final theme = Theme.of(context);

    return LayoutScaffold(
      backgroundColor: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Set Monster Name',
              style: theme.textTheme.titleLarge?.copyWith(
                color: darkenColor(color!, 0.5),
              ),
            ),
            InplaceText(
              text: _nameController.text,
              backgroundColor: lightenColor(color!),
              foregroundColor: darkenColor(color),
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  _nameController.text = value;
                });
              },
              onSubmitted: (value) async {
                await _setName();
              },
            ),
            UIButton(
              onPressedAsync: () async {
                await _setName();
              },
              icon: Icons.check,
              text: 'Set Name',
            ),
          ],
        ),
      ),
    );
  }
}
