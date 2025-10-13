import 'package:flutter/material.dart';
import 'analytics.dart';

import '../models/monster.dart';
import 'layout_scaffold.dart';
import 'monster_container.dart';
import '../theme.dart';

class MnstrList extends StatefulWidget {
  final List<Monster> monsters;
  final Function(Monster)? onTap;
  final Widget? overlay;
  final EdgeInsets? overlayPositioning;
  final Widget Function(Monster)? overlayBuilder;
  final bool showName;
  final bool Function(Monster)? filter;

  const MnstrList({
    super.key,
    required this.monsters,
    this.onTap,
    this.overlay,
    this.overlayBuilder,
    this.overlayPositioning,
    this.showName = true,
    this.filter,
  });

  @override
  State<MnstrList> createState() => _MnstrListState();
}

class _MnstrListState extends State<MnstrList> {
  final ScrollController _scrollController = ScrollController();
  double _currentPixels = 0;

  void _setBackgroundColor() {
    if (widget.monsters.isEmpty) {
      return;
    }

    int index = 0;
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > mobileBreakpoint;
    double pixels = _currentPixels;
    final calculatedHeight = isTablet ? size.height / 2 : size.height;

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

    if (index >= (widget.monsters.length - 1)) {
      index = widget.monsters.length - 1;
    }

    final monster = widget.monsters[index];
    final m = monster.toMonsterModel();
    final color = Color.lerp(m.color, Colors.white, 0.25);

    setState(() {
      _currentPixels = pixels;
    });

    try {
      final layoutScaffold = LayoutScaffold.of(context);
      layoutScaffold.setBackgroundColor(color!);
    } catch (e) {
      debugPrint('Error setting background color: $e');
    }
  }

  void _scrollPage(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.dy;
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final pixels = _scrollController.position.pixels;
    final maxPixels = _scrollController.position.maxScrollExtent;
    double targetPixels = pixels;
    if (velocity > 0) {
      targetPixels = pixels - height;
    } else {
      targetPixels = pixels + height;
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setBackgroundColor();
      _scrollController.addListener(() {
        _setBackgroundColor();
      });
    });
  }

  void _onTap(Monster monster) {
    Wiredash.trackEvent(
      'MnstrList Tapped',
      data: {
        'monster': monster.id,
      },
    );
    widget.onTap?.call(monster);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > mobileBreakpoint;
    final targetWidth = 500;
    final actualWidth = size.width ~/ targetWidth;

    final mnstrs = <Widget>[];
    final mnstrsTablet = <Widget>[];

    if (widget.monsters.length == 1) {
      mnstrs.add(
        MnstrView(
          monster: widget.monsters.first,
          onTap: _onTap,
          overlay:
              widget.overlayBuilder?.call(widget.monsters.first) ??
              widget.overlay,
          overlayPositioning: widget.overlayPositioning,
          showName: widget.showName,
        ),
      );
    } else if (isTablet) {
      final row = <Monster>[];
      for (var entry
          in widget.monsters
              .where(widget.filter ?? (m) => true)
              .toList()
              .asMap()
              .entries) {
        final index = entry.key;
        final m = entry.value;
        if ((index % actualWidth) == 0) {
          if (row.isNotEmpty) {
            mnstrsTablet.add(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: row
                    .map(
                      (m) => SizedBox(
                        width: size.width / actualWidth,
                        child: MnstrView(
                          monster: m,
                          onTap: _onTap,
                          overlay:
                              widget.overlayBuilder?.call(m) ?? widget.overlay,
                          overlayPositioning: widget.overlayPositioning,
                          showName: widget.showName,
                          size: Size(
                            size.width / actualWidth,
                            size.height,
                          ),
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
      if (row.isNotEmpty) {
        mnstrsTablet.add(
          Row(
            children: row
                .map(
                  (m) => SizedBox(
                    width: size.width / actualWidth,
                    child: MnstrView(
                      monster: m,
                      onTap: _onTap,
                      overlay: widget.overlayBuilder?.call(m) ?? widget.overlay,
                      overlayPositioning: widget.overlayPositioning,
                      showName: widget.showName,
                      size: Size(
                        size.width / actualWidth,
                        size.height,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      }
    } else {
      mnstrs.addAll(
        widget.monsters
            .where(widget.filter ?? (m) => true)
            .map(
              (m) => MnstrView(
                monster: m,
                onTap: _onTap,
                overlay: widget.overlayBuilder?.call(m) ?? widget.overlay,
                overlayPositioning: widget.overlayPositioning,
                showName: widget.showName,
              ),
            ),
      );
    }

    return SingleChildScrollView(
      controller: _scrollController,
      child: GestureDetector(
        onVerticalDragEnd: _scrollPage,
        child: isTablet && widget.monsters.length > 1
            ? Column(children: mnstrsTablet)
            : Column(children: mnstrs),
      ),
    );
  }
}

class MnstrView extends StatelessWidget {
  final Monster monster;
  final Function(Monster)? onTap;
  final Widget? overlay;
  final EdgeInsets? overlayPositioning;
  final bool showName;
  final Size? size;

  const MnstrView({
    super.key,
    required this.monster,
    this.onTap,
    this.overlay,
    this.overlayPositioning,
    this.showName = true,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? MediaQuery.sizeOf(context);

    return InkWell(
      onTap: () => onTap?.call(monster),
      child: Stack(
        children: [
          MonsterContainer(monster: monster, size: size, showName: showName),
          if (overlay != null)
            Positioned(
              top: overlayPositioning?.top ?? 0,
              bottom: overlayPositioning?.bottom ?? 0,
              left: overlayPositioning?.left ?? 0,
              right: overlayPositioning?.right ?? 0,
              child: overlay!,
            ),
        ],
      ),
    );
  }
}
