import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/monster.dart';
import '../providers/manage.dart';
import '../shared/layout_scaffold.dart';
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
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    monster = widget.monster;
    _pages.add(ManageView());
    _pages.add(ManageDetailsView());
    _pages.add(ManageSkillsView());
    _pages.add(ManageShopView());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(manageEditProvider.notifier).set(monster);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mnstr = monster.toMonsterModel();

    return LayoutScaffold(
      backgroundColor: Color.lerp(
        mnstr.color ?? Colors.white,
        Colors.white,
        0.5,
      ),

      child: Stack(
        children: [
          _pages[_currentIndex],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigationBar(
              backgroundColor: Color.lerp(
                mnstr.color ?? Colors.white,
                Colors.white,
                0.5,
              ),
              selectedItemColor: Color.lerp(
                mnstr.color ?? Colors.white,
                Colors.black,
                0.5,
              ),
              unselectedItemColor: Color.lerp(
                mnstr.color ?? Colors.white,
                Colors.white,
                0.10,
              ),
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.view_carousel_rounded),
                  label: 'View',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_box_rounded),
                  label: 'Details',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bolt_rounded),
                  label: 'Skills',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_rounded),
                  label: 'Shop',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
