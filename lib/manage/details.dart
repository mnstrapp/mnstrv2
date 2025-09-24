import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/monster.dart';

class ManageDetailsView extends ConsumerStatefulWidget {
  final Monster monster;

  const ManageDetailsView({super.key, required this.monster});

  @override
  ConsumerState<ManageDetailsView> createState() => _ManageDetailsViewState();
}

class _ManageDetailsViewState extends ConsumerState<ManageDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
