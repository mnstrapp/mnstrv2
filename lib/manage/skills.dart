import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../collect/name.dart';
import '../collect/stats.dart';
import '../models/monster.dart';
import '../providers/manage.dart';
import '../ui/button.dart';

class ManageSkillsView extends ConsumerStatefulWidget {
  const ManageSkillsView({super.key});

  @override
  ConsumerState<ManageSkillsView> createState() => _ManageSkillsViewState();
}

class _ManageSkillsViewState extends ConsumerState<ManageSkillsView> {
  int _availablePoints = 0;
  bool _loading = true;

  void _calculateAvailablePoints() async {
    var monster = ref.watch(manageEditProvider);
    if (monster == null) {
      return;
    }

    setState(() {
      _loading = true;
    });

    bool changed = false;

    final levelPoints = ((monster.level ?? 0) + 1) * 10;
    final assumedPoints = levelPoints * 6;

    if ((monster.maxHealth ?? 0) < levelPoints) {
      monster = monster.copyWith(
        maxHealth: levelPoints,
        currentHealth: levelPoints,
      );
      changed = true;
    }
    if ((monster.maxAttack ?? 0) < levelPoints) {
      monster = monster.copyWith(
        maxAttack: levelPoints,
        currentAttack: levelPoints,
      );
      changed = true;
    }
    if ((monster.maxDefense ?? 0) < levelPoints) {
      monster = monster.copyWith(
        maxDefense: levelPoints,
        currentDefense: levelPoints,
      );
      changed = true;
    }
    if ((monster.maxDefense ?? 0) < levelPoints) {
      monster = monster.copyWith(
        maxDefense: levelPoints,
        currentDefense: levelPoints,
      );
      changed = true;
    }
    if ((monster.maxIntelligence ?? 0) < levelPoints) {
      monster = monster.copyWith(
        maxIntelligence: levelPoints,
        currentIntelligence: levelPoints,
      );
      changed = true;
    }
    if ((monster.maxSpeed ?? 0) < levelPoints) {
      monster = monster.copyWith(
        maxSpeed: levelPoints,
        currentSpeed: levelPoints,
      );
      changed = true;
    }
    if ((monster.maxMagic ?? 0) < levelPoints) {
      monster = monster.copyWith(
        maxMagic: levelPoints,
        currentMagic: levelPoints,
      );
      changed = true;
    }
    if (changed) {
      await ref.read(manageEditProvider.notifier).editMonster(monster);
    }

    final usedPoints =
        (monster.maxHealth ?? 0) +
        (monster.maxAttack ?? 0) +
        (monster.maxDefense ?? 0) +
        (monster.maxIntelligence ?? 0) +
        (monster.maxSpeed ?? 0) +
        (monster.maxMagic ?? 0);

    setState(() {
      _availablePoints = (assumedPoints + levelPoints) - usedPoints;
      _loading = false;
    });
  }

  void _increaseStat(Stat stat, int total) {
    final monster = ref.watch(manageEditProvider);
    if (monster == null) {
      return;
    }

    switch (stat) {
      case Stat.health:
        final maxHealth = total;
        ref
            .read(manageEditProvider.notifier)
            .editMonster(
              monster.copyWith(
                maxHealth: maxHealth,
                currentHealth: maxHealth,
              ),
            );
        break;
      case Stat.attack:
        final maxAttack = total;
        ref
            .read(manageEditProvider.notifier)
            .editMonster(
              monster.copyWith(
                maxAttack: maxAttack,
                currentAttack: maxAttack,
              ),
            );
        break;
      case Stat.defense:
        final maxDefense = total;
        ref
            .read(manageEditProvider.notifier)
            .editMonster(
              monster.copyWith(
                maxDefense: maxDefense,
                currentDefense: maxDefense,
              ),
            );
        break;
      case Stat.intelligence:
        final maxIntelligence = total;
        ref
            .read(manageEditProvider.notifier)
            .editMonster(
              monster.copyWith(
                maxIntelligence: maxIntelligence,
                currentIntelligence: maxIntelligence,
              ),
            );
        break;
      case Stat.speed:
        final maxSpeed = total;
        ref
            .read(manageEditProvider.notifier)
            .editMonster(
              monster.copyWith(
                maxSpeed: maxSpeed,
                currentSpeed: maxSpeed,
              ),
            );
        break;
      case Stat.magic:
        final maxMagic = total;
        ref
            .read(manageEditProvider.notifier)
            .editMonster(
              monster.copyWith(
                maxMagic: maxMagic,
                currentMagic: maxMagic,
              ),
            );
        break;
    }
    setState(() {
      _availablePoints -= 1;
    });
  }

  void _decreaseStat(Stat stat, int total) {
    final monster = ref.watch(manageEditProvider);
    if (monster == null) {
      return;
    }

    switch (stat) {
      case Stat.health:
        final maxHealth = total;
        ref
            .read(manageEditProvider.notifier)
            .editMonster(
              monster.copyWith(
                maxHealth: maxHealth,
                currentHealth: maxHealth,
              ),
            );
        break;
      case Stat.attack:
        final maxAttack = total;
        ref
            .read(manageEditProvider.notifier)
            .editMonster(
              monster.copyWith(
                maxAttack: maxAttack,
                currentAttack: maxAttack,
              ),
            );
        break;
      case Stat.defense:
        final maxDefense = total;
        ref
            .read(manageEditProvider.notifier)
            .editMonster(
              monster.copyWith(
                maxDefense: maxDefense,
                currentDefense: maxDefense,
              ),
            );
        break;
      case Stat.intelligence:
        final maxIntelligence = total;
        ref
            .read(manageEditProvider.notifier)
            .editMonster(
              monster.copyWith(
                maxIntelligence: maxIntelligence,
                currentIntelligence: maxIntelligence,
              ),
            );
        break;
      case Stat.speed:
        final maxSpeed = total;
        ref
            .read(manageEditProvider.notifier)
            .editMonster(
              monster.copyWith(
                maxSpeed: maxSpeed,
                currentSpeed: maxSpeed,
              ),
            );
        break;
      case Stat.magic:
        final maxMagic = total;
        ref
            .read(manageEditProvider.notifier)
            .editMonster(
              monster.copyWith(
                maxMagic: maxMagic,
                currentMagic: maxMagic,
              ),
            );
        break;
    }
    setState(() => _availablePoints += 1);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _calculateAvailablePoints();
    });
  }

  @override
  Widget build(BuildContext context) {
    final monster = ref.watch(manageEditProvider);
    if (monster == null) {
      return const SizedBox.shrink();
    }
    final size = MediaQuery.of(context).size;

    log('available points: $_availablePoints');
    return SafeArea(
      child: Container(
        height: size.height - (48 - 32),
        margin: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 76),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: StatsView(
                    availablePoints: _availablePoints,
                    monster: monster,
                    onStatIncreased: _increaseStat,
                    onStatDecreased: _decreaseStat,
                    width: size.width - 170,
                  ),
                ),
              ),
      ),
    );
  }
}
