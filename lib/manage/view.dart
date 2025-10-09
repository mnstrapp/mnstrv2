import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/manage.dart';
import '../shared/monster_container.dart';

class ManageView extends ConsumerStatefulWidget {
  const ManageView({super.key});

  @override
  ConsumerState<ManageView> createState() => _ManageViewState();
}

class _ManageViewState extends ConsumerState<ManageView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final monster = ref.watch(manageEditProvider);
    if (monster == null) {
      return const SizedBox.shrink();
    }
    return MonsterContainer(
      monster: monster,
      showName: false,
      size: size,
    );
  }
}
