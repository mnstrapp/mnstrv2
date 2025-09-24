import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/monster.dart';
import '../shared/monster_container.dart';

class ManageView extends ConsumerStatefulWidget {
  final Monster monster;

  const ManageView({super.key, required this.monster});

  @override
  ConsumerState<ManageView> createState() => _ManageViewState();
}

class _ManageViewState extends ConsumerState<ManageView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MonsterContainer(
      monster: widget.monster.toMonsterModel(),
      showName: false,
      size: size,
    );
  }
}
