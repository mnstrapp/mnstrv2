import 'dart:developer';

import '../models/monster.dart';

class GameData {
  final String? battleId;
  final Monster? challengerMnstr;
  final List<Monster>? challengerMnstrs;
  final Monster? opponentMnstr;
  final List<Monster>? opponentMnstrs;
  final String? winnerId;
  final int? winnerXpAwarded;
  final int? winnerCoinsAwarded;
  final int? loserXpAwarded;
  final int? loserCoinsAwarded;
  final String? turnUserId;
  final BattleLogData? battleLogData;

  GameData({
    this.battleId,
    this.challengerMnstr,
    this.challengerMnstrs,
    this.opponentMnstr,
    this.opponentMnstrs,
    this.winnerId,
    this.winnerXpAwarded,
    this.loserXpAwarded,
    this.winnerCoinsAwarded,
    this.loserCoinsAwarded,
    this.turnUserId,
    this.battleLogData,
  });

  factory GameData.fromJson(Map<String, dynamic> json) {
    final challengerMnstrs = <Monster>[];

    if (json['challengerMnstrs'] != null) {
      for (var e in json['challengerMnstrs']) {
        challengerMnstrs.add(Monster.fromJson(e));
      }
    }

    final opponentMnstrs = <Monster>[];
    if (json['opponentMnstrs'] != null) {
      for (var e in json['opponentMnstrs']) {
        opponentMnstrs.add(Monster.fromJson(e));
      }
    }
    final winnerXpAwarded = json['winnerXpAwarded'] as int?;
    final loserXpAwarded = json['loserXpAwarded'] as int?;
    final winnerCoinsAwarded = json['winnerCoinsAwarded'] as int?;
    final loserCoinsAwarded = json['loserCoinsAwarded'] as int?;

    return GameData(
      battleId: json['battleId'] as String?,
      challengerMnstr: json['challengerMnstr'] != null
          ? Monster.fromJson(json['challengerMnstr'])
          : null,
      challengerMnstrs: challengerMnstrs,
      opponentMnstrs: opponentMnstrs,
      opponentMnstr: json['opponentMnstr'] != null
          ? Monster.fromJson(json['opponentMnstr'])
          : null,
      winnerId: json['winnerId'] as String?,
      winnerXpAwarded: winnerXpAwarded,
      loserXpAwarded: loserXpAwarded,
      winnerCoinsAwarded: winnerCoinsAwarded,
      loserCoinsAwarded: loserCoinsAwarded,
      turnUserId: json['turnUserId'] as String?,
      battleLogData: json['battleLogData'] != null
          ? BattleLogData.fromJson(json['battleLogData'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'battleId': battleId,
    'challengerMnstr': challengerMnstr?.toJson(),
    'challengerMnstrs': challengerMnstrs?.map((e) => e.toJson()).toList(),
    'opponentMnstr': opponentMnstr?.toJson(),
    'opponentMnstrs': opponentMnstrs?.map((e) => e.toJson()).toList(),
    'winnerId': winnerId,
    'winnerXpAwarded': winnerXpAwarded,
    'loserXpAwarded': loserXpAwarded,
    'winnerCoinsAwarded': winnerCoinsAwarded,
    'loserCoinsAwarded': loserCoinsAwarded,
    'turnUserId': turnUserId,
    'battleLogData': battleLogData?.toJson(),
  };
}

class BattleLogData {
  final bool? missed;
  final bool? hit;
  final bool? defense;
  final int? damage;

  BattleLogData({
    this.missed,
    this.hit,
    this.defense,
    this.damage,
  });

  factory BattleLogData.fromJson(Map<String, dynamic> json) {
    return BattleLogData(
      missed: json['missed'] as bool?,
      hit: json['hit'] as bool?,
      defense: json['defense'] as bool?,
      damage: json['damage'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'missed': missed,
    'hit': hit,
    'defense': defense,
    'damage': damage,
  };
}
