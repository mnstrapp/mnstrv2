import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/layout_scaffold.dart';
import '../shared/monster_container.dart';
import '../shared/monster_model.dart' as model;
import '../models/monster.dart' as mnstr;
import '../providers/manage.dart';
import 'edit.dart';

enum ScrollDirection { up, down }

class ManageListView extends ConsumerStatefulWidget {
  const ManageListView({super.key});

  @override
  ConsumerState<ManageListView> createState() => _ManageListViewState();
}

class _ManageListViewState extends ConsumerState<ManageListView> {
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  List<mnstr.Monster> _monsters = [];
  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getMonsters();
      _setMonsters();
    });
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

  void _setMonsters() {
    final monsters = ref.watch(manageProvider);
    monsters.whenData((monsters) {
      setState(() {
        _monsters = monsters;
      });
    });
  }

  void _setBackgroundColor(double height) {
    final index = _scrollController.position.pixels ~/ height;
    final monster = _monsters[index];
    final m = model.MonsterModel.fromQRCode(monster.qrCode ?? '');
    setState(() {
      _backgroundColor = Color.lerp(m.color, Colors.white, 0.25);
    });
  }

  void _scrollPage(double height, ScrollDirection direction) {
    final pixels = _scrollController.position.pixels;
    double targetPixels = pixels;
    if (direction == ScrollDirection.up) {
      targetPixels = pixels + height;
    } else {
      targetPixels = pixels - height;
    }
    _scrollController.animateTo(
      targetPixels,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    final monsters = ref.watch(manageProvider);
    final size = MediaQuery.of(context).size;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setBackgroundColor(size.height);
      _scrollController.addListener(() {
        _setBackgroundColor(size.height);
      });
    });
    return LayoutScaffold(
      backgroundColor: _backgroundColor,
      child: monsters.when(
        data: (monsters) {
          return _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  controller: _scrollController,
                  child: GestureDetector(
                    onVerticalDragEnd: (details) {
                      final velocity = details.velocity.pixelsPerSecond.dy;
                      if (velocity > 0) {
                        _scrollPage(size.height, ScrollDirection.down);
                      } else {
                        _scrollPage(size.height, ScrollDirection.up);
                      }
                    },
                    child: Column(
                      children: monsters.map((monster) {
                        return InkWell(
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
                            monster: model.MonsterModel.fromQRCode(
                              monster.qrCode ?? '',
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
        },
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
