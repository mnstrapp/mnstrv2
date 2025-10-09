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

class ManageListView extends ConsumerStatefulWidget {
  const ManageListView({super.key});

  @override
  ConsumerState<ManageListView> createState() => _ManageListViewState();
}

class _ManageListViewState extends ConsumerState<ManageListView> {
  bool _isLoading = false;
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getMonsters();
    });
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

  @override
  Widget build(BuildContext context) {
    final monsters = ref.watch(manageProvider);
    final size = MediaQuery.sizeOf(context);

    if (monsters.isEmpty && !_isLoading) {
      return const EmptyMessage();
    }

    return LayoutScaffold(
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : MnstrList(
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
                final container = MonsterContainer(
                  monster: monster,
                  size: size,
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
                                container,
                              );
                          await SharePlus.instance.share(
                            ShareParams(
                              subject: 'Sharing my MNSTR!',
                              text:
                                  '👋 Check out my MNSTR, ${monster.mnstrName}!',
                              downloadFallbackEnabled: true,
                              files: [
                                XFile.fromData(
                                  image,
                                  mimeType: 'image/png',
                                  name: '${monster.mnstrName}.png',
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
    );
  }
}
