import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/monster.dart';

class ManageSkillsView extends ConsumerStatefulWidget {
  final Monster monster;

  const ManageSkillsView({super.key, required this.monster});

  @override
  ConsumerState<ManageSkillsView> createState() => _ManageSkillsViewState();
}

class _ManageSkillsViewState extends ConsumerState<ManageSkillsView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
