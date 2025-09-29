// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BattleQueue _$BattleQueueFromJson(Map<String, dynamic> json) => BattleQueue(
  id: json['id'] as String?,
  userId: json['userId'] as String?,
  channel: $enumDecodeNullable(_$BattleQueueChannelEnumMap, json['channel']),
  action: $enumDecodeNullable(_$BattleQueueActionEnumMap, json['action']),
  data: json['data'] == null
      ? null
      : BattleQueueData.fromJson(json['data'] as Map<String, dynamic>),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  archivedAt: json['archivedAt'] == null
      ? null
      : DateTime.parse(json['archivedAt'] as String),
);

Map<String, dynamic> _$BattleQueueToJson(BattleQueue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'channel': _$BattleQueueChannelEnumMap[instance.channel],
      'action': _$BattleQueueActionEnumMap[instance.action],
      'data': instance.data,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'archivedAt': instance.archivedAt?.toIso8601String(),
    };

const _$BattleQueueChannelEnumMap = {
  BattleQueueChannel.lobby: 'lobby',
  BattleQueueChannel.battle: 'battle',
};

const _$BattleQueueActionEnumMap = {
  BattleQueueAction.error: 'error',
  BattleQueueAction.joined: 'joined',
  BattleQueueAction.left: 'left',
  BattleQueueAction.ready: 'ready',
  BattleQueueAction.requested: 'requested',
  BattleQueueAction.accepted: 'accepted',
  BattleQueueAction.rejected: 'rejected',
  BattleQueueAction.cancelled: 'cancelled',
  BattleQueueAction.watching: 'watching',
};

BattleQueueData _$BattleQueueDataFromJson(Map<String, dynamic> json) =>
    BattleQueueData(
      action: $enumDecodeNullable(
        _$BattleQueueDataActionEnumMap,
        json['action'],
      ),
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      opponentId: json['opponentId'] as String?,
      opponentName: json['opponentName'] as String?,
      mnstrId: json['mnstrId'] as String?,
      error: json['error'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BattleQueueDataToJson(BattleQueueData instance) =>
    <String, dynamic>{
      'action': _$BattleQueueDataActionEnumMap[instance.action],
      'userId': instance.userId,
      'userName': instance.userName,
      'opponentId': instance.opponentId,
      'opponentName': instance.opponentName,
      'mnstrId': instance.mnstrId,
      'error': instance.error,
      'message': instance.message,
    };

const _$BattleQueueDataActionEnumMap = {
  BattleQueueDataAction.connect: 'connect',
  BattleQueueDataAction.cancel: 'cancel',
  BattleQueueDataAction.ready: 'ready',
  BattleQueueDataAction.unready: 'unready',
  BattleQueueDataAction.start: 'start',
  BattleQueueDataAction.watch: 'watch',
};
