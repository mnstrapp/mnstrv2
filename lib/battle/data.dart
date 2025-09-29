import 'package:change_case/change_case.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart' as uuid;

part 'data.g.dart';

@JsonEnum()
enum BattleQueueChannel {
  lobby,
  battle,
}

@JsonEnum()
enum BattleQueueAction {
  error,
  joined,
  left,
  ready,
  requested,
  accepted,
  rejected,
  cancelled,
  watching,
}

@JsonSerializable()
class BattleQueue {
  String id;
  String? userId;
  BattleQueueChannel? channel;
  BattleQueueAction? action;
  BattleQueueData? data;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? archivedAt;

  BattleQueue({
    String? id,
    this.userId,
    this.channel,
    this.action,
    this.data,
    this.createdAt,
    this.updatedAt,
    this.archivedAt,
  }) : id = id ?? uuid.Uuid().v4();

  factory BattleQueue.fromJson(Map<String, dynamic> json) => BattleQueue(
    id: json['id'] as String,
    userId: json['userId'] as String?,
    channel: $enumDecodeNullable(
      _$BattleQueueChannelEnumMap,
      (json['channel'] as String?)?.toLowerCase(),
    ),
    action: $enumDecodeNullable(
      _$BattleQueueActionEnumMap,
      (json['action'] as String?)?.toLowerCase(),
    ),
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

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'channel': channel?.name.toTitleCase(),
    'action': action?.name.toTitleCase(),
    'data': data?.toJson(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'archivedAt': archivedAt?.toIso8601String(),
  };
}

@JsonEnum()
enum BattleQueueDataAction {
  connect,
  cancel,
  ready,
  unready,
  start,
  watch,
}

@JsonSerializable()
class BattleQueueData {
  BattleQueueDataAction? action;
  String? userId;
  String? userName;
  String? opponentId;
  String? opponentName;
  String? mnstrId;
  String? error;
  String? message;

  BattleQueueData({
    this.action,
    this.userId,
    this.userName,
    this.opponentId,
    this.opponentName,
    this.mnstrId,
    this.error,
    this.message,
  });

  factory BattleQueueData.fromJson(Map<String, dynamic> json) =>
      BattleQueueData(
        action: $enumDecodeNullable(
          _$BattleQueueDataActionEnumMap,
          (json['action'] as String?)?.toLowerCase(),
        ),
        userId: json['userId'] as String?,
        userName: json['userName'] as String?,
        opponentId: json['opponentId'] as String?,
        opponentName: json['opponentName'] as String?,
        mnstrId: json['mnstrId'] as String?,
        error: json['error'] as String?,
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'action': action?.name.toTitleCase(),
    'userId': userId,
    'userName': userName,
    'opponentId': opponentId,
    'opponentName': opponentName,
    'mnstrId': mnstrId,
    'error': error,
    'message': message,
  };
}
