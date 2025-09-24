import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/manage.dart';

class ManageShopView extends ConsumerStatefulWidget {
  const ManageShopView({super.key});

  @override
  ConsumerState<ManageShopView> createState() => _ManageShopViewState();
}

class _ManageShopViewState extends ConsumerState<ManageShopView> {
  @override
  Widget build(BuildContext context) {
    final monster = ref.watch(manageEditProvider);
    if (monster == null) {
      return const SizedBox.shrink();
    }
    final mnstr = monster.toMonsterModel();

    return Container();
  }
}
