import '../models/monster.dart';

class GameData {
  final String battleId;
  final Monster? challengerMnstr;
  final List<Monster>? challengerMnstrs;
  final Monster? opponentMnstr;
  final List<Monster>? opponentMnstrs;

  GameData({
    required this.battleId,
    required this.challengerMnstr,
    required this.challengerMnstrs,
    required this.opponentMnstr,
    required this.opponentMnstrs,
  });

  factory GameData.fromJson(Map<String, dynamic> json) {
    return GameData(
      battleId: json['battleId'],
      challengerMnstr: json['challengerMnstr'] != null
          ? Monster.fromJson(json['challengerMnstr'])
          : null,
      challengerMnstrs: json['challengerMnstrs'] != null
          ? (json['challengerMnstrs'] as List)
                .map((e) => Monster.fromJson(e))
                .toList()
          : null,
      opponentMnstr: json['opponentMnstr'] != null
          ? Monster.fromJson(json['opponentMnstr'])
          : null,
      opponentMnstrs: json['opponentMnstrs'] != null
          ? (json['opponentMnstrs'] as List)
                .map((e) => Monster.fromJson(e))
                .toList()
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
