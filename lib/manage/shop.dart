import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/monster.dart';

class ManageShopView extends ConsumerStatefulWidget {
  final Monster monster;

  const ManageShopView({super.key, required this.monster});

  @override
  ConsumerState<ManageShopView> createState() => _ManageShopViewState();
}

class _ManageShopViewState extends ConsumerState<ManageShopView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
