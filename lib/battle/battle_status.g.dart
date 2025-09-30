// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BattleStatus _$BattleStatusFromJson(Map<String, dynamic> json) =>
    BattleStatus(
        userId: json['userId'] as String?,
        displayName: json['displayName'] as String?,
      )
      ..id = json['id'] as String?
      ..status = json['status'] as String?
      ..connected = json['connected'] as bool?
      ..createdAt = json['createdAt'] as String?;

Map<String, dynamic> _$BattleStatusToJson(BattleStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'displayName': instance.displayName,
      'status': instance.status,
      'connected': instance.connected,
      'createdAt': instance.createdAt,
    };
