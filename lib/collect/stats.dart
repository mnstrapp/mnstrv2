import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/monster.dart';
import '../shared/stat_change_bar.dart';

class StatsView extends ConsumerStatefulWidget {
  final Monster monster;
  final int availablePoints;
  final Function(Stat, int) onStatIncreased;
  final Function(Stat, int) onStatDecreased;
  final double width;

  const StatsView({
    super.key,
    required this.monster,
    this.availablePoints = 0,
    required this.onStatIncreased,
    required this.onStatDecreased,
    required this.width,
  });

  @override
  ConsumerState<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends ConsumerState<StatsView> {
  int _health = 10;
  int _attack = 10;
  int _defense = 10;
  int _intelligence = 10;
  int _speed = 10;
  int _magic = 10;
  int _availablePoints = 10;

  final Map<Stat, int> _baseStats = {
    Stat.health: 0,
    Stat.attack: 0,
    Stat.defense: 0,
    Stat.intelligence: 0,
    Stat.speed: 0,
    Stat.magic: 0,
  };

  final Map<Stat, int> _maxStats = {
    Stat.health: 100,
    Stat.attack: 100,
    Stat.defense: 100,
    Stat.intelligence: 100,
    Stat.speed: 100,
    Stat.magic: 100,
  };

  @override
  void initState() {
    super.initState();
    _availablePoints = widget.availablePoints;

    _health = widget.monster.maxHealth ?? 10;
    _attack = widget.monster.maxAttack ?? 10;
    _defense = widget.monster.maxDefense ?? 10;
    _intelligence = widget.monster.maxIntelligence ?? 10;
    _speed = widget.monster.maxSpeed ?? 10;
    _magic = widget.monster.maxMagic ?? 10;

    _baseStats[Stat.health] = widget.monster.maxHealth ?? _health;
    _baseStats[Stat.attack] = widget.monster.maxAttack ?? _attack;
    _baseStats[Stat.defense] = widget.monster.maxDefense ?? _defense;
    _baseStats[Stat.intelligence] =
        widget.monster.maxIntelligence ?? _intelligence;
    _baseStats[Stat.speed] = widget.monster.maxSpeed ?? _speed;
    _baseStats[Stat.magic] = widget.monster.maxMagic ?? _magic;

    _maxStats[Stat.health] = _health + _availablePoints;
    _maxStats[Stat.attack] = _attack + _availablePoints;
    _maxStats[Stat.defense] = _defense + _availablePoints;
    _maxStats[Stat.intelligence] = _intelligence + _availablePoints;
    _maxStats[Stat.speed] = _speed + _availablePoints;
    _maxStats[Stat.magic] = _magic + _availablePoints;
  }

  void _increaseStat(Stat stat, int value) {
    if (_availablePoints - value < 0) {
      return;
    }

    int total = value;

    switch (stat) {
      case Stat.health:
        total = _health + value;
        setState(() => _health = total);
        break;
      case Stat.attack:
        total = _attack + value;
        setState(() => _attack = total);
        break;
      case Stat.defense:
        total = _defense + value;
        setState(() => _defense = total);
        break;
      case Stat.speed:
        total = _speed + value;
        setState(() => _speed = total);
        break;
      case Stat.magic:
        total = _magic + value;
        setState(() => _magic = total);
        break;
      case Stat.intelligence:
        total = _intelligence + value;
        setState(() => _intelligence = total);
        break;
    }
    setState(() => _availablePoints -= value);
    widget.onStatIncreased(stat, total);
  }

  void _decreaseStat(Stat stat, int value) {
    int total = value;

    switch (stat) {
      case Stat.health:
        total = _health - value;
        if (total >= _baseStats[stat]!) {
          setState(() => _health = total);
          widget.onStatDecreased(stat, total);
        } else {
          return;
        }
        break;
      case Stat.attack:
        total = _attack - value;
        if (total >= _baseStats[stat]!) {
          setState(() => _attack = total);
          widget.onStatDecreased(stat, total);
        } else {
          return;
        }
        break;
      case Stat.defense:
        total = _defense - value;
        if (total >= _baseStats[stat]!) {
          setState(() => _defense = total);
          widget.onStatDecreased(stat, total);
        } else {
          return;
        }
        break;
      case Stat.intelligence:
        total = _intelligence - value;
        if (total >= _baseStats[stat]!) {
          setState(() => _intelligence = total);
          widget.onStatDecreased(stat, total);
        } else {
          return;
        }
        break;
      case Stat.speed:
        total = _speed - value;
        if (total >= _baseStats[stat]!) {
          setState(() => _speed = total);
          widget.onStatDecreased(stat, total);
        } else {
          return;
        }
        break;
      case Stat.magic:
        total = _magic - value;
        if (total >= _baseStats[stat]!) {
          setState(() => _magic = total);
          widget.onStatDecreased(stat, total);
        } else {
          return;
        }
        break;
    }
    setState(() => _availablePoints += value);
  }

  @override
  Widget build(BuildContext context) {
    final level = widget.monster.currentLevel ?? 0;
    final experience = widget.monster.currentExperience ?? 0;
    final experienceToNextLevel = widget.monster.experienceToNextLevel ?? 0;
    final color = widget.monster.toMonsterModel().color;
    final largestStat = _maxStats.values.reduce((a, b) => a > b ? a : b);

    log(
      'mnstr: XP ${widget.monster.currentExperience} / ${widget.monster.experienceToNextLevel}, Level $level',
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Lv: $level'),
            Text('Xp: $experience / $experienceToNextLevel'),
          ],
        ),
        Text('Available Points: $_availablePoints'),
        Text('Health'),
        StatChangeBar(
          currentValue: _health,
          totalValue: _health == _maxStats[Stat.health]!
              ? largestStat
              : _maxStats[Stat.health]!,
          color: color,
          width: widget.width,
          onIncrease: (value) => _increaseStat(Stat.health, value),
          onDecrease: (value) => _decreaseStat(Stat.health, value),
        ),

        Text('Attack'),
        StatChangeBar(
          currentValue: _attack,
          totalValue: _attack == _maxStats[Stat.attack]!
              ? largestStat
              : _maxStats[Stat.attack]!,
          color: color,
          width: widget.width,
          onIncrease: (value) => _increaseStat(Stat.attack, value),
          onDecrease: (value) => _decreaseStat(Stat.attack, value),
        ),

        Text('Defense'),
        StatChangeBar(
          currentValue: _defense,
          totalValue: _defense == _maxStats[Stat.defense]!
              ? largestStat
              : _maxStats[Stat.defense]!,
          color: color,
          width: widget.width,
          onIncrease: (value) => _increaseStat(Stat.defense, value),
          onDecrease: (value) => _decreaseStat(Stat.defense, value),
        ),

        Text('Intelligence'),
        StatChangeBar(
          currentValue: _intelligence,
          totalValue: _intelligence == _maxStats[Stat.intelligence]!
              ? largestStat
              : _maxStats[Stat.intelligence]!,
          color: color,
          width: widget.width,
          onIncrease: (value) => _increaseStat(Stat.intelligence, value),
          onDecrease: (value) => _decreaseStat(Stat.intelligence, value),
        ),

        Text('Speed'),
        StatChangeBar(
          currentValue: _speed,
          totalValue: _speed == _maxStats[Stat.speed]!
              ? largestStat
              : _maxStats[Stat.speed]!,
          color: color,
          width: widget.width,
          onIncrease: (value) => _increaseStat(Stat.speed, value),
          onDecrease: (value) => _decreaseStat(Stat.speed, value),
        ),

        Text('Magic'),
        StatChangeBar(
          currentValue: _magic,
          totalValue: _magic == _maxStats[Stat.magic]!
              ? largestStat
              : _maxStats[Stat.magic]!,
          color: color,
          width: widget.width,
          onIncrease: (value) => _increaseStat(Stat.magic, value),
          onDecrease: (value) => _decreaseStat(Stat.magic, value),
        ),
      ],
    );
  }
}
