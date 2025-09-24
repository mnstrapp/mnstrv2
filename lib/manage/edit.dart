import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/monster.dart';
import '../providers/manage.dart';
import '../shared/layout_scaffold.dart';
import '../shared/monster_container.dart';
import '../ui/inplace_text.dart';
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
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    monster = widget.monster;
    _pages.add(ManageView(monster: monster));
    _pages.add(ManageDetailsView(monster: monster));
    _pages.add(ManageSkillsView(monster: monster));
    _pages.add(ManageShopView(monster: monster));
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
                0.5,
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
                  icon: Icon(Icons.details_rounded),
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
