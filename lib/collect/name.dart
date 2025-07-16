import 'package:flutter/material.dart';
import '../models/monster.dart';
import '../shared/layout_scaffold.dart';

class SetMonsterNameView extends StatelessWidget {
  final Monster monster;
  const SetMonsterNameView({super.key, required this.monster});

  @override
  Widget build(BuildContext context) {
    return LayoutScaffold(child: Center(child: Text('Set Monster Name')));
  }
}
