import 'package:change_case/change_case.dart';

enum BattleStatusState {
  inQueue,
  inBattle,
  watching,
}

class BattleStatus {
  String? id;
  String? userId;
  String? displayName;
  BattleStatusState? status;
  bool? connected;
  String? createdAt;

  BattleStatus({
    this.userId,
    this.displayName,
    this.status,
    this.connected,
    this.createdAt,
  });

  factory BattleStatus.fromJson(Map<String, dynamic> json) {
    final status = switch (json['status']) {
      'inQueue' => BattleStatusState.inQueue,
      'inBattle' => BattleStatusState.inBattle,
      'watching' => BattleStatusState.watching,
      _ => BattleStatusState.inQueue,
    };
    return BattleStatus(
      userId: json['userId'] as String?,
      displayName: json['displayName'] as String?,
      status: status,
      connected: json['connected'] as bool?,
      createdAt: json['createdAt'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'displayName': displayName,
    'status': status?.name.toTitleCase(),
    'connected': connected,
    'createdAt': createdAt,
  };
}
