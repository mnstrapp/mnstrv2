import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../collect/stats.dart';
import '../models/monster.dart';
import '../providers/manage.dart';

class ManageSkillsView extends ConsumerStatefulWidget {
  const ManageSkillsView({super.key});

  @override
  ConsumerState<ManageSkillsView> createState() => _ManageSkillsViewState();
}

class _ManageSkillsViewState extends ConsumerState<ManageSkillsView> {
  int _availablePoints = 0;
  bool _loading = true;
  final duration = const Duration(milliseconds: 500);

  int _health = 0;
  int _attack = 0;
  int _defense = 0;
  int _intelligence = 0;
  int _speed = 0;
  int _magic = 0;

  final Map<Stat, Timer?> _timers = {
    Stat.health: null,
    Stat.attack: null,
    Stat.defense: null,
    Stat.intelligence: null,
    Stat.speed: null,
    Stat.magic: null,
  };

  Future<void> _calculateAvailablePoints() async {
    var monster = ref.watch(manageEditProvider);
    if (monster == null) {
      return;
    }

    setState(() {
      _loading = true;
    });

    bool changed = false;

    final levelPoints = ((monster.currentLevel ?? 0) + 1) * 10;
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

  Future<void> _updateMonster() async {
    var monster = ref.watch(manageEditProvider);
    if (monster == null) {
      return;
    }
    await ref
        .read(manageEditProvider.notifier)
        .editMonster(
          _copyMonster(monster),
        );
  }

  Monster _copyMonster(Monster monster) {
    return monster.copyWith(
      currentHealth: _health,
      currentAttack: _attack,
      currentDefense: _defense,
      currentIntelligence: _intelligence,
      currentSpeed: _speed,
      currentMagic: _magic,
      maxHealth: _health,
      maxAttack: _attack,
      maxDefense: _defense,
      maxIntelligence: _intelligence,
      maxSpeed: _speed,
      maxMagic: _magic,
    );
  }

  Future<void> _increaseStat(Stat stat, int total) async {
    var monster = ref.watch(manageEditProvider);
    if (monster == null) {
      return;
    }

    if (_availablePoints < 1) {
      return;
    }

    setState(() {
      _availablePoints -= 1;
    });

    switch (stat) {
      case Stat.health:
        if (mounted) {
          setState(() {
            _health += 1;
          });
        }

        if (_timers[stat] == null) {
          _timers[stat] = Timer.periodic(duration, (
            timer,
          ) async {
            if (mounted) {
              int maxHealth = (monster!.maxHealth ?? 0);
              if (maxHealth == _health) {
                timer.cancel();
                await _updateMonster();
                _timers[stat] = null;
                return;
              }
              monster = _copyMonster(monster!);
            }
          });
        }
        break;
      case Stat.attack:
        if (mounted) {
          setState(() {
            _attack += 1;
          });
        }

        if (_timers[stat] == null) {
          _timers[stat] = Timer.periodic(duration, (
            timer,
          ) async {
            if (mounted) {
              int maxAttack = (monster!.maxAttack ?? 0);
              if (maxAttack == _attack) {
                timer.cancel();
                await _updateMonster();
                _timers[stat] = null;
                return;
              }
              monster = _copyMonster(monster!);
            }
          });
        }
        break;
      case Stat.defense:
        if (mounted) {
          setState(() {
            _defense += 1;
          });
        }

        if (_timers[stat] == null) {
          _timers[stat] = Timer.periodic(duration, (
            timer,
          ) async {
            if (mounted) {
              int maxDefense = (monster!.maxDefense ?? 0);
              if (maxDefense == _defense) {
                timer.cancel();
                await _updateMonster();
                _timers[stat] = null;
                return;
              }
              monster = _copyMonster(monster!);
            }
          });
        }
        break;
      case Stat.intelligence:
        if (mounted) {
          setState(() {
            _intelligence += 1;
          });
        }

        if (_timers[stat] == null) {
          _timers[stat] = Timer.periodic(duration, (
            timer,
          ) async {
            if (mounted) {
              int maxIntelligence = (monster!.maxIntelligence ?? 0);
              if (maxIntelligence == _intelligence) {
                timer.cancel();
                await _updateMonster();
                _timers[stat] = null;
                return;
              }
              monster = _copyMonster(monster!);
            }
          });
        }
        break;
      case Stat.speed:
        if (mounted) {
          setState(() {
            _speed += 1;
          });
        }

        if (_timers[stat] == null) {
          _timers[stat] = Timer.periodic(duration, (
            timer,
          ) async {
            if (mounted) {
              int maxSpeed = (monster!.maxSpeed ?? 0);
              if (maxSpeed == _speed) {
                timer.cancel();
                await _updateMonster();
                _timers[stat] = null;
                return;
              }
              monster = _copyMonster(monster!);
            }
          });
        }
        break;
      case Stat.magic:
        if (mounted) {
          setState(() {
            _magic += 1;
          });
        }

        if (_timers[stat] == null) {
          _timers[stat] = Timer.periodic(duration, (
            timer,
          ) async {
            if (mounted) {
              int maxMagic = (monster!.maxMagic ?? 0);
              if (maxMagic == _magic) {
                timer.cancel();
                await _updateMonster();
                _timers[stat] = null;
                return;
              }
              monster = _copyMonster(monster!);
            }
          });
        }
        break;
    }
  }

  Future<void> _decreaseStat(Stat stat, int total) async {
    var monster = ref.watch(manageEditProvider);
    if (monster == null) {
      return;
    }
    setState(() => _availablePoints += 1);

    switch (stat) {
      case Stat.health:
        if (mounted) {
          setState(() {
            _health -= 1;
          });
        }

        if (_timers[stat] == null) {
          _timers[stat] = Timer.periodic(duration, (
            timer,
          ) async {
            if (mounted) {
              int maxHealth = (monster!.maxHealth ?? 0);
              if (maxHealth == _health) {
                timer.cancel();
                await _updateMonster();
                _timers[stat] = null;
                return;
              }
              monster = _copyMonster(monster!);
            }
          });
        }
        break;
      case Stat.attack:
        if (mounted) {
          setState(() {
            _attack -= 1;
          });
        }

        if (_timers[stat] == null) {
          _timers[stat] = Timer.periodic(duration, (
            timer,
          ) async {
            if (mounted) {
              int maxAttack = (monster!.maxAttack ?? 0);
              if (maxAttack == _attack) {
                timer.cancel();
                await _updateMonster();
                _timers[stat] = null;
                return;
              }
              monster = _copyMonster(monster!);
            }
          });
        }
        break;
      case Stat.defense:
        if (mounted) {
          setState(() {
            _defense -= 1;
          });
        }

        if (_timers[stat] == null) {
          _timers[stat] = Timer.periodic(duration, (
            timer,
          ) async {
            if (mounted) {
              int maxDefense = (monster!.maxDefense ?? 0);
              if (maxDefense == _defense) {
                timer.cancel();
                await _updateMonster();
                _timers[stat] = null;
                return;
              }
              monster = _copyMonster(monster!);
            }
          });
        }
        break;
      case Stat.intelligence:
        if (mounted) {
          setState(() {
            _intelligence -= 1;
          });
        }

        if (_timers[stat] == null) {
          _timers[stat] = Timer.periodic(duration, (
            timer,
          ) async {
            if (mounted) {
              int maxIntelligence = (monster!.maxIntelligence ?? 0);
              if (maxIntelligence == _intelligence) {
                timer.cancel();
                await _updateMonster();
                _timers[stat] = null;
                return;
              }
              monster = _copyMonster(monster!);
            }
          });
        }
        break;
      case Stat.speed:
        if (mounted) {
          setState(() {
            _speed -= 1;
          });
        }

        if (_timers[stat] == null) {
          _timers[stat] = Timer.periodic(duration, (
            timer,
          ) async {
            if (mounted) {
              int maxSpeed = (monster!.maxSpeed ?? 0);
              if (maxSpeed == _speed) {
                timer.cancel();
                await _updateMonster();
                _timers[stat] = null;
                return;
              }
              monster = _copyMonster(monster!);
            }
          });
        }
        break;
      case Stat.magic:
        if (mounted) {
          setState(() {
            _magic -= 1;
          });
        }

        if (_timers[stat] == null) {
          _timers[stat] = Timer.periodic(duration, (
            timer,
          ) async {
            if (mounted) {
              int maxMagic = (monster!.maxMagic ?? 0);
              if (maxMagic == _magic) {
                timer.cancel();
                await _updateMonster();
                _timers[stat] = null;
                return;
              }
              monster = _copyMonster(monster!);
            }
          });
        }
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _calculateAvailablePoints();
      final monster = ref.watch(manageEditProvider);
      if (monster != null) {
        setState(() {
          _health = (monster.maxHealth ?? 0);
          _attack = (monster.maxAttack ?? 0);
          _defense = (monster.maxDefense ?? 0);
          _intelligence = (monster.maxIntelligence ?? 0);
          _speed = (monster.maxSpeed ?? 0);
          _magic = (monster.maxMagic ?? 0);
        });
        log(
          'initState: $_health, $_attack, $_defense, $_intelligence, $_speed, $_magic',
        );
      }
    });
  }

  @override
  void dispose() {
    for (var timer in _timers.values) {
      timer?.cancel();
    }
    super.dispose();
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
