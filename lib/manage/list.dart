import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../providers/manage.dart';
import '../shared/empty_message.dart';
import '../shared/layout_scaffold.dart';
import '../shared/monster_container.dart';
import '../ui/button.dart';
import '../shared/mnstr_list.dart';
import '../utils/color.dart';
import 'edit.dart';

enum ScrollDirection { up, down }

enum ManageOrderBy {
  createdAt,
  updatedAt,
  name,
  level,
  experience,
  health,
  attack,
  defense,
  intelligence,
  speed,
  magic;

  static ManageOrderBy fromName(String value) {
    return ManageOrderBy.values.byName(value);
  }
}

enum ManageOrderDirection {
  asc,
  desc;

  static ManageOrderDirection fromName(String value) {
    return ManageOrderDirection.values.byName(value);
  }
}

class ManageListView extends ConsumerStatefulWidget {
  const ManageListView({super.key});

  @override
  ConsumerState<ManageListView> createState() => _ManageListViewState();
}

class _ManageListViewState extends ConsumerState<ManageListView> {
  bool _isLoading = false;
  ManageOrder? _order;
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadOrder();
      await _getMonsters();
    });
  }

  Future<void> _loadOrder() async {
    if (_order != null) {
      return;
    }
    await ref.read(manageOrderProvider.notifier).init();
    if (mounted) {
      setState(() {
        _order = ref.read(manageOrderProvider);
      });
    }
  }

  Future<void> _getMonsters() async {
    setState(() {
      _isLoading = true;
    });
    await ref.read(manageProvider.notifier).getMonsters();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _setOrder({
    required ManageOrderBy orderBy,
    required ManageOrderDirection orderDirection,
  }) async {
    setState(() {
      _isLoading = true;
    });
    ref
        .read(manageOrderProvider.notifier)
        .set(
          orderBy: orderBy,
          orderDirection: orderDirection,
        );
    setState(() {
      _order = ref.read(manageOrderProvider);
    });
    await ref.read(manageProvider.notifier).getMonsters();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final monsters = ref.watch(manageProvider);
    final size = MediaQuery.sizeOf(context);
    final inputDecorationTheme = InputDecorationTheme(
      fillColor: Colors.white.withValues(alpha: 0.5),
      filled: true,
      contentPadding: const EdgeInsets.only(left: 16, right: 16),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
    );

    if (monsters.isEmpty && !_isLoading) {
      return const EmptyMessage();
    }

    return LayoutScaffold(
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                MnstrList(
                  monsters: monsters,
                  onTap: (monster) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageEditView(monster: monster),
                      ),
                    );
                  },
                  overlayBuilder: (monster) {
                    final m = monster.toMonsterModel();
                    final backgroundColor = lightenColor(
                      Color.lerp(
                            m.color,
                            Colors.black,
                            0.5,
                          ) ??
                          Colors.black,
                      0.1,
                    );

                    return Stack(
                      children: [
                        Positioned(
                          bottom: 16,
                          left: 13,
                          child: UIButton(
                            height: 80,
                            onPressedAsync: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ManageEditView(monster: monster),
                                ),
                              );
                            },
                            icon: Icons.edit,
                            backgroundColor: backgroundColor,
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          right: 13,
                          child: UIButton(
                            height: 80,
                            onPressedAsync: () async {
                              final image = await _screenshotController
                                  .captureFromWidget(
                                    SizedBox(
                                      width: size.width,
                                      height: size.height,
                                      child: MonsterContainer(
                                        monster: monster,
                                        size: size,
                                      ),
                                    ),
                                  );
                              await SharePlus.instance.share(
                                ShareParams(
                                  subject: 'Sharing my MNSTR!',
                                  text:
                                      '👋 Check out my MNSTR, ${monster.mnstrName ?? 'unnamed'}!',
                                  downloadFallbackEnabled: true,
                                  files: [
                                    XFile.fromData(
                                      image,
                                      mimeType: 'image/png',
                                      name:
                                          '${monster.mnstrName ?? 'unnamed'}.png',
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: Icons.share,
                            backgroundColor: backgroundColor,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  bottom: 80,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(left: 32, right: 32),
                        child: Row(
                          spacing: 8,
                          children: [
                            Icon(Icons.sort_rounded),
                            DropdownMenu(
                              inputDecorationTheme: inputDecorationTheme,
                              dropdownMenuEntries: ManageOrderBy.values
                                  .map(
                                    (e) => DropdownMenuEntry(
                                      value: e,
                                      label: e.name,
                                    ),
                                  )
                                  .toList(),
                              enableFilter: true,
                              initialSelection: _order?.orderBy,
                              onSelected: (value) {
                                _setOrder(
                                  orderBy: value ?? ManageOrderBy.updatedAt,
                                  orderDirection:
                                      _order?.orderDirection ??
                                      ManageOrderDirection.desc,
                                );
                              },
                            ),
                            DropdownMenu(
                              inputDecorationTheme: inputDecorationTheme,
                              dropdownMenuEntries: ManageOrderDirection.values
                                  .map(
                                    (e) => DropdownMenuEntry(
                                      value: e,
                                      label: e.name,
                                    ),
                                  )
                                  .toList(),
                              enableFilter: true,
                              initialSelection: _order?.orderDirection,
                              onSelected: (value) {
                                _setOrder(
                                  orderBy:
                                      _order?.orderBy ??
                                      ManageOrderBy.updatedAt,
                                  orderDirection:
                                      value ?? ManageOrderDirection.desc,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
