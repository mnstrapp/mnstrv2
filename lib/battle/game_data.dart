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
  };
}
