import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/session_users.dart';
import 'data.dart';
import 'battle_status.dart';

class BattleQueueView extends ConsumerStatefulWidget {
  final Function(BattleQueue) onLog;
  final Function(Function(String)) onListen;
  final Function(BattleQueue) onSend;
  final Function(Function(String)) onDispose;

  const BattleQueueView({
    super.key,
    required this.onLog,
    required this.onListen,
    required this.onSend,
    required this.onDispose,
  });

  @override
  ConsumerState<BattleQueueView> createState() => _BattleQueueViewState();
}

class _BattleQueueViewState extends ConsumerState<BattleQueueView> {
  List<BattleStatus> _battleStatuses = [];

  void _getBattleStatuses() {
    final user = ref.read(sessionUserProvider);
    if (user.value == null) {
      return;
    }
    final data = BattleQueueData(
      action: BattleQueueDataAction.list,
      userId: user.value?.id,
      userName: user.value?.displayName,
      message: 'list lobby players',
    );
    final battleQueue = BattleQueue(
      action: BattleQueueAction.list,
      userId: user.value?.id,
      data: data,
      channel: BattleQueueChannel.lobby,
    );
    widget.onSend(battleQueue);
  }

  void _handleMessage(String message) {
    if (!mounted) {
      return;
    }

    final user = ref.read(sessionUserProvider);
    if (user.value == null) {
      return;
    }

    log('message: $message');

    final battleQueue = BattleQueue.fromJson(jsonDecode(message));

    switch (battleQueue.action) {
      case BattleQueueAction.joined:
        if (battleQueue.data?.userId != user.value?.id) {
          _getBattleStatuses();
        }
        break;
      case BattleQueueAction.left:
        if (battleQueue.data?.userId != user.value?.id) {
          _getBattleStatuses();
        }
        break;
      case BattleQueueAction.list:
        if (battleQueue.data?.data == null) {
          return;
        }
        final data = jsonDecode(battleQueue.data?.data as String);
        List<BattleStatus> battleStatuses = [];
        for (var e in data) {
          final battleStatus = BattleStatus.fromJson(e);
          if (battleStatus.userId == user.value?.id) {
            continue;
          }
          battleStatuses.add(battleStatus);
        }
        setState(() {
          _battleStatuses = battleStatuses;
        });
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.onListen(_handleMessage);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getBattleStatuses();
    });
  }

  @override
  void dispose() {
    widget.onDispose(_handleMessage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
