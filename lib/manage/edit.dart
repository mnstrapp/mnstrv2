import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/monster.dart';
import '../providers/manage.dart';
import '../shared/layout_scaffold.dart';
import '../ui/navigation_bar.dart';
import '../utils/color.dart';
import 'details.dart';
import 'shop.dart';
import 'skills.dart';
import 'view.dart';

class ManageEditView extends ConsumerStatefulWidget {
  final Monster monster;
  final Function(Monster)? onUpdate;

  const ManageEditView({super.key, required this.monster, this.onUpdate});

  @override
  ConsumerState<ManageEditView> createState() => _ManageEditViewState();
}

class _ManageEditViewState extends ConsumerState<ManageEditView> {
  late Monster monster;
  int _currentIndex = 0;
  final _pages = <_NavigationPage>[
    _NavigationPage(
      label: 'view',
      icon: Icons.view_carousel_rounded,
      page: ManageView(),
    ),
    _NavigationPage(
      label: 'details',
      icon: Icons.abc_rounded,
      page: ManageDetailsView(),
    ),
    _NavigationPage(
      label: 'skills',
      icon: Icons.school,
      page: ManageSkillsView(),
    ),
    _NavigationPage(label: 'shop', icon: Icons.shop, page: ManageShopView()),
  ];

  @override
  void initState() {
    super.initState();
    monster = widget.monster;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(manageEditProvider.notifier).set(monster);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mnstr = monster.toMonsterModel();
    final backgroundColor = Color.lerp(
      mnstr.color ?? Colors.white,
      Colors.white,
      0.5,
    );

    final selectedBackgroundColor = darkenColor(
      backgroundColor ?? Theme.of(context).primaryColor,
      0.2,
    );

    return LayoutScaffold(
      backgroundColor: backgroundColor,

      child: Stack(
        children: [
          _pages[_currentIndex].page,
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: UINavigationBar(
              buttons: _pages
                  .map(
                    (page) => UINavigationBarButton(
                      label: page.label,
                      icon: page.icon,
                    ),
                  )
                  .toList(),
              onSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              margin: 16,
              selectedBackgroundColor: selectedBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationPage {
  final String label;
  final IconData icon;
  final Widget page;

  _NavigationPage({
    required this.label,
    required this.icon,
    required this.page,
  });
}
