import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/monster_container.dart';
import '../shared/monster_model.dart';
import '../providers/manage.dart';

class ManageListView extends ConsumerStatefulWidget {
  const ManageListView({super.key});

  @override
  ConsumerState<ManageListView> createState() => _ManageListViewState();
}

class _ManageListViewState extends ConsumerState<ManageListView> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getMonsters();
  }

  Future<void> _getMonsters() async {
    setState(() {
      _isLoading = true;
    });
    await ref.read(manageProvider.notifier).getMonsters();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final monsters = ref.watch(manageProvider);
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : monsters.when(
              data: (monsters) => ListView.builder(
                itemCount: monsters.length,
                itemBuilder: (context, index) => MonsterContainer(
                  monster: Monster.fromQRCode(monsters[index].qrCode ?? ''),
                ),
              ),
              error: (error, stackTrace) => Text('Error: $error'),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
    );
  }
}
