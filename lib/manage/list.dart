import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../theme.dart';
import '../models/monster.dart' as mnstr;
import '../providers/manage.dart';
import '../shared/layout_scaffold.dart';
import '../shared/monster_container.dart';
import '../shared/monster_model.dart' as model;
import '../ui/button.dart';
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
  final ScrollController _scrollController = ScrollController();
  final ScreenshotController _screenshotController = ScreenshotController();
  List<mnstr.Monster> _monsters = [];
  Color? _backgroundColor;
  int _currentIndex = 0;
  double _currentPixels = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final size = MediaQuery.of(context).size;
      await _getMonsters();
      _setMonsters();
      _setBackgroundColor(size.height);
      _scrollController.addListener(() {
        _setBackgroundColor(size.height);
      });
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

  void _setMonsters() {
    final monsters = ref.watch(manageProvider);
    monsters.whenData((monsters) {
      setState(() {
        _monsters = monsters;
      });
    });
  }

  void _setBackgroundColor(double height) {
    if (_monsters.isEmpty) {
      return;
    }
    int index = _currentIndex;
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > mobileBreakpoint;
    double pixels = _currentPixels;
    final calculatedHeight = isTablet ? height / 2 : height;

    try {
      pixels = _scrollController.position.pixels;
    } catch (e) {
      debugPrint('Error getting scroll position: $e');
    }

    if (pixels > 0) {
      index = pixels > _currentPixels
          ? (pixels / calculatedHeight).ceil()
          : (pixels / calculatedHeight).round();
    }

    final monster = _monsters[index];
    final m = model.MonsterModel.fromQRCode(monster.qrCode ?? '');
    setState(() {
      _backgroundColor = Color.lerp(m.color, Colors.white, 0.25);
      _currentIndex = index;
      _currentPixels = pixels;
    });
  }

  void _scrollPage(double height, ScrollDirection direction) {
    final pixels = _scrollController.position.pixels;
    final maxPixels = _scrollController.position.maxScrollExtent;
    double targetPixels = pixels;
    if (direction == ScrollDirection.up) {
      targetPixels = pixels + height;
    } else {
      targetPixels = pixels - height;
    }
    if (targetPixels > maxPixels) {
      targetPixels = maxPixels;
    }
    if (targetPixels < 0) {
      targetPixels = 0;
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

    final isTablet = size.width > mobileBreakpoint;

    final mnstrs = <Widget>[];
    final mnstrsTablet = <Widget>[];

    return LayoutScaffold(
      backgroundColor: _backgroundColor,
      child: monsters.when(
        data: (monsters) {
          if (isTablet) {
            final row = <mnstr.Monster>[];
            for (var entry in monsters.asMap().entries) {
              final index = entry.key;
              final m = entry.value;
              if ((index % 2) == 0) {
                if (row.isNotEmpty) {
                  mnstrsTablet.add(
                    Row(
                      children: row
                          .map(
                            (monster) => SizedBox(
                              width: size.width / 2,
                              child: _buildMnstrView(
                                context: context,
                                monster: monster,
                                screenshotController: _screenshotController,
                                onUpdate: _getMonsters,
                                size: size,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                }
                row.clear();
              }
              row.add(m);
            }
          } else {
            mnstrs.addAll(
              monsters.map(
                (monster) => _buildMnstrView(
                  context: context,
                  monster: monster,
                  screenshotController: _screenshotController,
                  onUpdate: _getMonsters,
                  size: size,
                ),
              ),
            );
          }

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
                    child: isTablet
                        ? Column(children: mnstrsTablet)
                        : Column(children: mnstrs),
                  ),
                );
        },
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

Widget _buildMnstrView({
  required BuildContext context,
  required mnstr.Monster monster,
  required ScreenshotController screenshotController,
  required VoidCallback onUpdate,
  required Size size,
}) {
  final m = monster.toMonsterModel();
  final container = MonsterContainer(monster: m, size: size);

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ManageEditView(monster: monster),
        ),
      );
    },
    child: Stack(
      children: [
        container,
        Positioned(
          bottom: 130,
          left: 13,
          child: UIButton(
            onPressedAsync: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageEditView(monster: monster),
                ),
              );
            },
            icon: Icons.edit,
            backgroundColor: lightenColor(
              Color.lerp(m.color, Colors.black, 0.5) ?? Colors.black,
              0.1,
            ),
          ),
        ),
        Positioned(
          bottom: 130,
          right: 13,
          child: UIButton(
            onPressedAsync: () async {
              final image = await screenshotController.captureFromWidget(
                container,
              );
              await SharePlus.instance.share(
                ShareParams(
                  subject: 'Sharing my MNSTR!',
                  text: '👋 Check out my MNSTR, ${monster.name}!',
                  downloadFallbackEnabled: true,
                  files: [
                    XFile.fromData(
                      image,
                      mimeType: 'image/png',
                      name: '${monster.name}.png',
                    ),
                  ],
                ),
              );
            },
            icon: Icons.share,
            backgroundColor: lightenColor(
              Color.lerp(m.color, Colors.black, 0.5) ?? Colors.black,
              0.1,
            ),
          ),
        ),
      ],
    ),
  );
}
