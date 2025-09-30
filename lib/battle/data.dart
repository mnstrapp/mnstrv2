import 'package:change_case/change_case.dart';
import 'package:uuid/uuid.dart' as uuid;

enum BattleQueueChannel {
  lobby,
  battle,
}

enum BattleQueueAction {
  error,
  joined,
  left,
  ready,
  requested,
  accepted,
  rejected,
  watching,
  list,
  challenge,
  cancel,
  accept,
  reject,
}

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

  factory BattleQueue.fromJson(Map<String, dynamic> json) {
    final channel = switch (json['channel'].toLowerCase()) {
      'lobby' => BattleQueueChannel.lobby,
      'battle' => BattleQueueChannel.battle,
      _ => BattleQueueChannel.lobby,
    };
    final action = switch (json['action'].toLowerCase()) {
      'error' => BattleQueueAction.error,
      'joined' => BattleQueueAction.joined,
      'left' => BattleQueueAction.left,
      'ready' => BattleQueueAction.ready,
      'requested' => BattleQueueAction.requested,
      'accepted' => BattleQueueAction.accepted,
      'rejected' => BattleQueueAction.rejected,
      'watching' => BattleQueueAction.watching,
      'list' => BattleQueueAction.list,
      'challenge' => BattleQueueAction.challenge,
      'cancel' => BattleQueueAction.cancel,
      'accept' => BattleQueueAction.accept,
      'reject' => BattleQueueAction.reject,
      _ => BattleQueueAction.error,
    };
    return BattleQueue(
      id: json['id'] as String,
      userId: json['userId'] as String?,
      channel: channel,
      action: action,
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
  }

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

enum BattleQueueDataAction {
  connect,
  cancel,
  ready,
  unready,
  start,
  watch,
  left,
  list,
  error,
  challenge,
  accept,
  reject,
}

class BattleQueueData {
  BattleQueueDataAction? action;
  String? userId;
  String? userName;
  String? opponentId;
  String? opponentName;
  String? mnstrId;
  String? data;
  String? error;
  String? message;

  BattleQueueData({
    this.action,
    this.userId,
    this.userName,
    this.opponentId,
    this.opponentName,
    this.mnstrId,
    this.data,
    this.error,
    this.message,
  });

  factory BattleQueueData.fromJson(Map<String, dynamic> json) {
    final action = switch (json['action'].toLowerCase()) {
      'connect' => BattleQueueDataAction.connect,
      'cancel' => BattleQueueDataAction.cancel,
      'ready' => BattleQueueDataAction.ready,
      'unready' => BattleQueueDataAction.unready,
      'Start' => BattleQueueDataAction.start,
      'watch' => BattleQueueDataAction.watch,
      'left' => BattleQueueDataAction.left,
      'list' => BattleQueueDataAction.list,
      'error' => BattleQueueDataAction.error,
      'challenge' => BattleQueueDataAction.challenge,
      'accept' => BattleQueueDataAction.accept,
      'reject' => BattleQueueDataAction.reject,
      _ => BattleQueueDataAction.error,
    };
    return BattleQueueData(
      action: action,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      opponentId: json['opponentId'] as String?,
      opponentName: json['opponentName'] as String?,
      mnstrId: json['mnstrId'] as String?,
      data: json['data'] as String?,
      error: json['error'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'action': action?.name.toTitleCase(),
    'userId': userId,
    'userName': userName,
    'opponentId': opponentId,
    'opponentName': opponentName,
    'mnstrId': mnstrId,
    'data': data,
    'error': error,
    'message': message,
  };
}
