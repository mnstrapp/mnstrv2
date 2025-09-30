import 'package:json_annotation/json_annotation.dart';

part 'battle_status.g.dart';

@JsonSerializable()
class BattleStatus {
  String? id;
  String? userId;
  String? displayName;
  String? status;
  bool? connected;
  String? createdAt;

  BattleStatus({this.userId, this.displayName});

  factory BattleStatus.fromJson(Map<String, dynamic> json) =>
      _$BattleStatusFromJson(json);
  Map<String, dynamic> toJson() => _$BattleStatusToJson(this);
}
