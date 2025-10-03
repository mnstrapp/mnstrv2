import 'dart:developer';

import '../models/monster.dart';

class GameData {
  final String? battleId;
  final Monster? challengerMnstr;
  final List<Monster>? challengerMnstrs;
  final Monster? opponentMnstr;
  final List<Monster>? opponentMnstrs;

  GameData({
    this.battleId,
    this.challengerMnstr,
    this.challengerMnstrs,
    this.opponentMnstr,
    this.opponentMnstrs,
  });

  factory GameData.fromJson(Map<String, dynamic> json) {
    log('[game data from json] $json');
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
    );
  }

  Map<String, dynamic> toJson() => {
    'battleId': battleId,
    'challengerMnstr': challengerMnstr?.toJson(),
    'challengerMnstrs': challengerMnstrs?.map((e) => e.toJson()).toList(),
    'opponentMnstr': opponentMnstr?.toJson(),
    'opponentMnstrs': opponentMnstrs?.map((e) => e.toJson()).toList(),
  };
}
