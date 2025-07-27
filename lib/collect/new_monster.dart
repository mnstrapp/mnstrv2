import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/monster.dart';
import '../providers/collect.dart';
import '../shared/layout_scaffold.dart';
import '../utils/color.dart';
import '../ui/button.dart';
import 'name.dart';
import 'stats.dart';

class NewMonsterView extends ConsumerStatefulWidget {
  final Monster monster;

  const NewMonsterView({super.key, required this.monster});

  @override
  ConsumerState<NewMonsterView> createState() => _NewMonsterViewState();
}

class _NewMonsterViewState extends ConsumerState<NewMonsterView> {
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
      case Stat.intelligence:
        final maxIntelligence = total;
        setState(() {
          _monster = _monster!.copyWith(
            maxIntelligence: maxIntelligence,
            currentIntelligence: maxIntelligence,
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
      case Stat.intelligence:
        final maxIntelligence = total;
        setState(() {
          _monster = _monster!.copyWith(
            maxIntelligence: maxIntelligence,
            currentIntelligence: maxIntelligence,
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
      final error = await ref
          .read(collectProvider.notifier)
          .createMonster(_monster!);
      if (error != null) {
        messenger.showSnackBar(SnackBar(content: Text(error)));
        return;
      }
      navigator.pop(true);
      messenger.showSnackBar(const SnackBar(content: Text('Monster created')));
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
    return LayoutScaffold(
      backgroundColor: Color.lerp(color, Colors.white, 0.5),
      child: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Container(
              margin: const EdgeInsets.only(top: 32),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('New Monster', style: theme.textTheme.titleLarge),
                  Divider(color: darkenColor(color, 0.5)),
                  NameView(monster: _monster!, onSubmitted: _setName),
                  Divider(color: darkenColor(color, 0.5)),
                  StatsView(
                    monster: _monster!,
                    onStatIncreased: _increaseStat,
                    onStatDecreased: _decreaseStat,
                    width: size.width - 128,
                  ),
                  Divider(color: darkenColor(color, 0.5)),
                  UIButton(
                    onPressed: () => _save(context, ref),
                    text: 'Save',
                    backgroundColor: Color.lerp(color, Colors.black, 0.5),
                    // foregroundColor: ,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
