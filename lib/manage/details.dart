import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/manage.dart';
import '../shared/layout_scaffold.dart';
import '../ui/inplace_text.dart';

class ManageDetailsView extends ConsumerStatefulWidget {
  final GlobalKey<LayoutScaffoldState> layoutKey;

  const ManageDetailsView({super.key, required this.layoutKey});

  @override
  ConsumerState<ManageDetailsView> createState() => _ManageDetailsViewState();
}

class _ManageDetailsViewState extends ConsumerState<ManageDetailsView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final monster = ref.watch(manageEditProvider);
    if (monster == null) {
      return const SizedBox.shrink();
    }
    final mnstr = monster.toMonsterModel();

    final backgroundColor = Color.lerp(mnstr.color, Colors.white, 0.66);
    final labelColor = Color.lerp(mnstr.color, Colors.black, 0.66);

    return SafeArea(
      child: Container(
        height: size.height - (48 - 32),
        margin: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 76),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InplaceText(
                  text: mnstr.name,
                  label: Text(
                    'Name',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: labelColor,
                    ),
                  ),
                  backgroundColor: backgroundColor,
                  foregroundColor: labelColor,
                  onSubmitted: (value) async {
                    final error = await ref
                        .read(manageEditProvider.notifier)
                        .editMonster(monster.copyWith(mnstrName: value));
                    if (error != null) {
                      widget.layoutKey.currentState?.addError(error);
                    }
                  },
                ),
                InplaceText(
                  text: monster.mnstrDescription,
                  label: Text(
                    'Description',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: labelColor,
                    ),
                  ),
                  maxLines: 10,
                  backgroundColor: backgroundColor,
                  foregroundColor: labelColor,
                  onSubmitted: (value) async {
                    final error = await ref
                        .read(manageEditProvider.notifier)
                        .editMonster(
                          monster.copyWith(mnstrDescription: value),
                        );
                    if (error != null) {
                      widget.layoutKey.currentState?.addError(error);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
