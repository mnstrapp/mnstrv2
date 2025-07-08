import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mnstrv2/providers/session_users.dart';

import '../shared/layout_scaffold.dart';
import '../shared/monster_container.dart';
import '../shared/monster_model.dart';
import '../providers/manage.dart';
import 'edit.dart';

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
    return LayoutScaffold(
      child: monsters.when(
        data: (monsters) {
          return _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: monsters
                      .map(
                        (monster) => InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ManageEditView(monster: monster),
                              ),
                            );
                          },
                          child: MonsterContainer(
                            monster: Monster.fromQRCode(monster.qrCode ?? ''),
                          ),
                        ),
                      )
                      .toList(),
                );
        },
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
