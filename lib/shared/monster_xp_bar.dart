import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/session_users.dart';
import '../utils/color.dart';

class MonsterXpBar extends ConsumerStatefulWidget {
  const MonsterXpBar({super.key, this.color, this.disableBackButton = false});
  final Color? color;
  final bool disableBackButton;

  @override
  ConsumerState<MonsterXpBar> createState() => _MonsterXpBarState();
}

class _MonsterXpBarState extends ConsumerState<MonsterXpBar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final messenger = ScaffoldMessenger.of(context);
      final error = await ref.read(sessionUserProvider.notifier).refresh();
      if (error != null) {
        messenger.showSnackBar(SnackBar(content: Text(error)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(sessionUserProvider);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final backgroundColor = lightenColor(widget.color ?? theme.primaryColor);
    final margin = EdgeInsets.only(left: 32, right: 32);
    final height = 40.0;
    final barBackgroundColor = darkenColor(
      widget.color ?? theme.primaryColor,
      0.1,
    );
    final barForegroundColor = darkenColor(
      widget.color ?? theme.primaryColor,
      0.2,
    );
    final barWidth = size.width * 0.33;
    final barHeight = 20.0;
    final barExperience = user.value?.experiencePoints ?? 1;
    final barExperienceToNextLevel = user.value?.experienceToNextLevel ?? 1;
    final barExperiencePercentage = barExperience / barExperienceToNextLevel;
    final barExperienceWidth = barWidth * barExperiencePercentage;
    final borderRadius = BorderRadius.circular(20);

    return SafeArea(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: backgroundColor,
          ),
          height: height,
          margin: margin,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 4,
                      children: [
                        Row(
                          children: [
                            const Text('LV: '),
                            Text(
                              user.value?.experienceLevel.toString() ?? '0',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              width: barWidth,
                              height: barHeight,
                              decoration: BoxDecoration(
                                borderRadius: borderRadius,
                                color: barBackgroundColor,
                              ),
                            ),
                            Container(
                              width: barExperienceWidth,
                              height: barHeight,
                              decoration: BoxDecoration(
                                borderRadius: borderRadius,
                                color: barForegroundColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/items/coin.png',
                              width: 20,
                              height: 20,
                            ),
                            Text(
                              user.value?.coins.toString() ?? '0',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (Navigator.of(context).canPop() && !widget.disableBackButton)
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: barForegroundColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
