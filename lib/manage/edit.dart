import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/monster.dart' as mc;
import '../ui/inplace_text.dart';

class ManageEditView extends ConsumerWidget {
  final mc.Monster monster;

  const ManageEditView({super.key, required this.monster});

  void _onNameChanged(String name) {
    log(name);
  }

  void _onDescriptionChanged(String description) {
    log(description);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          InplaceText(
            text: monster.name,
            onChanged: _onNameChanged,
            label: const Text('Name'),
          ),
          InplaceText(
            text: monster.description,
            label: const Text('Description'),
            onChanged: _onDescriptionChanged,
            minLines: 3,
            maxLines: 10,
          ),
        ],
      ),
    );
  }
}
