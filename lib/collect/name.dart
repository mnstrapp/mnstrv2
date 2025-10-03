import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/monster.dart';
import '../ui/inplace_text.dart';
import '../utils/color.dart';

class NameView extends ConsumerStatefulWidget {
  final Monster monster;
  final Function(String) onSubmitted;

  const NameView({super.key, required this.monster, required this.onSubmitted});

  @override
  ConsumerState<NameView> createState() => _NameViewState();
}

class _NameViewState extends ConsumerState<NameView> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.monster.mnstrName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final monster = widget.monster.toMonsterModel();
    final color = Color.lerp(monster.color, Colors.white, 0.5);
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Set Monster Name',
          style: theme.textTheme.titleMedium?.copyWith(
            color: darkenColor(color!, 0.5),
          ),
        ),
        InplaceText(
          text: _nameController.text,
          backgroundColor: lightenColor(color!, 0.2),
          foregroundColor: darkenColor(color),
          autofocus: true,
          onChanged: (value) {
            setState(() {
              _nameController.text = value;
            });
          },
          onSubmitted: (value) {
            widget.onSubmitted(value);
          },
        ),
      ],
    );
  }
}
