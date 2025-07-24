import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/monster.dart';
import '../providers/collect.dart';
import '../ui/button.dart';
import 'name.dart';
import 'stats.dart';

class CollectDialog extends ConsumerStatefulWidget {
  final Monster monster;

  const CollectDialog({super.key, required this.monster});

  @override
  ConsumerState<CollectDialog> createState() => _CollectDialogState();
}

class _CollectDialogState extends ConsumerState<CollectDialog> {
  bool _nameSet = false;
  bool _statsSet = false;
  Monster? _monster;
  int _availablePoints = 10;

  @override
  void initState() {
    super.initState();
    _monster = widget.monster;
  }

  void _setName(String name) {
    setState(() {
      _nameSet = true;
      _monster = _monster!.copyWith(name: name);
    });
  }

  void _increaseStat(Stat stat, int total) {
    switch (stat) {
      case Stat.health:
        final maxHealth = total;
        setState(() {
          _monster = _monster!.copyWith(
            maxHealth: maxHealth,
            currentHealth: maxHealth,
          );
        });
        break;
      case Stat.attack:
        final maxAttack = total;
        setState(() {
          _monster = _monster!.copyWith(
            maxAttack: maxAttack,
            currentAttack: maxAttack,
          );
        });
        break;
      case Stat.defense:
        final maxDefense = total;
        setState(() {
          _monster = _monster!.copyWith(
            maxDefense: maxDefense,
            currentDefense: maxDefense,
          );
        });
        break;
      case Stat.speed:
        final maxSpeed = total;
        setState(() {
          _monster = _monster!.copyWith(
            maxSpeed: maxSpeed,
            currentSpeed: maxSpeed,
          );
        });
        break;
      case Stat.magic:
        final maxMagic = total;
        setState(() {
          _monster = _monster!.copyWith(
            maxMagic: maxMagic,
            currentMagic: maxMagic,
          );
        });
        break;
    }
    setState(() {
      _availablePoints -= 1;
      if (_availablePoints <= 0) {
        _statsSet = true;
      }
    });
  }

  void _decreaseStat(Stat stat, int total) {
    switch (stat) {
      case Stat.health:
        final maxHealth = total;
        setState(() {
          _monster = _monster!.copyWith(
            maxHealth: maxHealth,
            currentHealth: maxHealth,
          );
        });
        break;
      case Stat.attack:
        final maxAttack = total;
        setState(() {
          _monster = _monster!.copyWith(
            maxAttack: maxAttack,
            currentAttack: maxAttack,
          );
        });
        break;
      case Stat.defense:
        final maxDefense = total;
        setState(() {
          _monster = _monster!.copyWith(
            maxDefense: maxDefense,
            currentDefense: maxDefense,
          );
        });
        break;
      case Stat.speed:
        final maxSpeed = total;
        setState(() {
          _monster = _monster!.copyWith(
            maxSpeed: maxSpeed,
            currentSpeed: maxSpeed,
          );
        });
        break;
      case Stat.magic:
        final maxMagic = total;
        setState(() {
          _monster = _monster!.copyWith(
            maxMagic: maxMagic,
            currentMagic: maxMagic,
          );
        });
        break;
    }
    setState(() => _availablePoints += 1);
  }

  Future<void> _save(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    if (_nameSet && _statsSet) {
      await ref.read(collectProvider.notifier).saveMonster(_monster!);
      navigator.pop(true);
    } else if (!_nameSet) {
      messenger.showSnackBar(SnackBar(content: Text('Please set a name')));
    } else if (!_statsSet) {
      messenger.showSnackBar(SnackBar(content: Text('Please set all stats')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color =
        widget.monster.toMonsterModel().color ?? theme.colorScheme.primary;
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: color,
      title: Text('New Monster'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NameView(monster: widget.monster, onSubmitted: _setName),
          StatsView(
            monster: widget.monster,
            onStatIncreased: _increaseStat,
            onStatDecreased: _decreaseStat,
            width: size.width - 224,
          ),
        ],
      ),
      actions: [UIButton(onPressed: () => _save(context, ref), text: 'Save')],
    );
  }
}
