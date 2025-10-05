import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../providers/session_users.dart';
import '../shared/layout_scaffold.dart';
import '../ui/button.dart';
import '../utils/color.dart';
import 'data.dart';
import 'battle_status.dart';
import 'game_data.dart';

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
  List<BattleQueue> _challenges = [];
  final Map<String, (BattleQueue, VoidCallback)> _sentChallenges = {};
  bool _showChallenges = false;
  String? _opponentId;

  void _onChallenge(BattleQueue battleQueue, VoidCallback callback) {
    setState(() {
      _sentChallenges[battleQueue.data!.id!] = (
        battleQueue,
        callback,
      );
    });
    widget.onSend(battleQueue);
  }

  void _acceptChallenge(int index) {
    final user = ref.read(sessionUserProvider);
    if (user.value == null) {
      return;
    }

    final data = BattleQueueData(
      action: BattleQueueDataAction.accept,
      userId: _challenges[index].data?.userId,
      userName: _challenges[index].data?.userName,
      opponentId: user.value?.id,
      opponentName: user.value?.displayName,
      message: 'accept challenge',
    );
    final battleQueue = BattleQueue(
      action: BattleQueueAction.accept,
      userId: user.value?.id,
      data: data,
      channel: BattleQueueChannel.lobby,
    );
    widget.onSend(battleQueue);

    setState(() {
      _challenges.removeAt(index);
      _opponentId = data.userId;
    });
  }

  void _rejectChallenge(int index) {
    final user = ref.read(sessionUserProvider);
    if (user.value == null) {
      return;
    }

    final data = BattleQueueData(
      action: BattleQueueDataAction.reject,
      id: _challenges[index].data?.id,
      userId: _challenges[index].data?.userId,
      userName: _challenges[index].data?.userName,
      opponentId: user.value?.id,
      opponentName: user.value?.displayName,
      message: 'reject challenge',
    );
    final battleQueue = BattleQueue(
      action: BattleQueueAction.reject,
      userId: user.value?.id,
      data: data,
      channel: BattleQueueChannel.lobby,
    );
    widget.onSend(battleQueue);

    setState(() {
      _challenges.removeAt(index);
    });
  }

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
      case BattleQueueAction.challenge:
        if (battleQueue.data?.opponentId == user.value?.id) {
          setState(() {
            _showChallenges = true;
            _challenges = [..._challenges, battleQueue];
          });
        }
        break;
      case BattleQueueAction.cancel:
        if (battleQueue.data?.opponentId == user.value?.id) {
          setState(() {
            _challenges.removeWhere(
              (challenge) => challenge.data?.id == battleQueue.data?.id,
            );
            if (_challenges.isEmpty) {
              _showChallenges = false;
            }
          });
        }
        break;
      case BattleQueueAction.reject:
        if (battleQueue.data?.userId == user.value?.id) {
          final callback = _sentChallenges[battleQueue.data?.id];
          if (callback != null) {
            callback.$2();
          }
          setState(() {
            _sentChallenges.remove(battleQueue.data?.id);
          });
        }
        break;
      case BattleQueueAction.accept:
        if (battleQueue.data?.userId == user.value?.id) {
          final callback = _sentChallenges[battleQueue.data?.id];
          if (callback != null) {
            callback.$2();
          }
          setState(() {
            _sentChallenges.remove(battleQueue.data?.id);
            _opponentId = battleQueue.data?.opponentId;
          });
        }
        _getBattleStatuses();
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
      log('get battle statuses');
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
      spacing: 8,
      children: [
        if (_showChallenges)
          ..._challenges.asMap().entries.map(
            (entry) => _ChallengeWidget(
              challenge: entry.value,
              onAccept: () => _acceptChallenge(entry.key),
              onReject: () => _rejectChallenge(entry.key),
            ),
          ),
        ..._battleStatuses.map(
          (battleStatus) => _BattleStatusWidget(
            battleStatus: battleStatus,
            onSend: widget.onSend,
            onChallenge: _onChallenge,
          ),
        ),
      ],
    );
  }
}

class _BattleStatusWidget extends ConsumerStatefulWidget {
  final BattleStatus battleStatus;
  final Function(BattleQueue) onSend;
  final Function(BattleQueue, VoidCallback) onChallenge;

  const _BattleStatusWidget({
    required this.battleStatus,
    required this.onSend,
    required this.onChallenge,
  });

  @override
  ConsumerState<_BattleStatusWidget> createState() =>
      _BattleStatusWidgetState();
}

class _BattleStatusWidgetState extends ConsumerState<_BattleStatusWidget> {
  bool _waiting = false;
  BattleQueue? _challengeMade;

  void _challenge() {
    final user = ref.read(sessionUserProvider);
    if (user.value == null) {
      return;
    }

    setState(() {
      _waiting = true;
    });

    final data = BattleQueueData(
      action: BattleQueueDataAction.challenge,
      id: Uuid().v4(),
      userId: user.value?.id,
      userName: user.value?.displayName,
      opponentId: widget.battleStatus.userId,
      opponentName: widget.battleStatus.displayName,
      message: 'challenge ${widget.battleStatus.displayName}',
    );
    final battleQueue = BattleQueue(
      action: BattleQueueAction.challenge,
      userId: user.value?.id,
      data: data,
      channel: BattleQueueChannel.lobby,
    );
    _challengeMade = battleQueue;
    widget.onChallenge(battleQueue, () {
      setState(() {
        _waiting = false;
      });
    });
  }

  void _cancel() {
    final user = ref.read(sessionUserProvider);
    if (user.value == null) {
      return;
    }

    log('[battle status cancel handler] id: ${_challengeMade?.data?.id}');

    final data = BattleQueueData(
      action: BattleQueueDataAction.cancel,
      id: _challengeMade?.data?.id,
      userId: user.value?.id,
      userName: user.value?.displayName,
      opponentId: widget.battleStatus.userId,
      opponentName: widget.battleStatus.displayName,
      message: 'cancel challenge ${widget.battleStatus.displayName}',
    );
    final battleQueue = BattleQueue(
      action: BattleQueueAction.cancel,
      userId: user.value?.id,
      data: data,
      channel: BattleQueueChannel.lobby,
    );
    widget.onSend(battleQueue);
    setState(() {
      _waiting = false;
      _challengeMade = null;
    });
  }

  void _rejoin() {
    final user = ref.read(sessionUserProvider);
    if (user.value == null) {
      return;
    }

    final gameData = GameData(
      battleId: widget.battleStatus.battleId,
    );
    final data = BattleQueueData(
      action: BattleQueueDataAction.rejoin,
      userId: user.value?.id,
      userName: user.value?.displayName,
      message: 'rejoin battle',
      data: jsonEncode(gameData.toJson()),
    );
    final battleQueue = BattleQueue(
      action: BattleQueueAction.rejoin,
      userId: user.value?.id,
      data: data,
      channel: BattleQueueChannel.battle,
    );
    widget.onSend(battleQueue);
  }

  void setShowStatBar() {
    LayoutScaffold.of(
      context,
    ).setShowStatBar(true);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setShowStatBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(sessionUserProvider);
    if (user.value == null) {
      return const SizedBox.shrink();
    }

    final canRejoin =
        (widget.battleStatus.userId == user.value?.id ||
        widget.battleStatus.opponentId == user.value?.id);

    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final statusColor = switch (widget.battleStatus.status) {
      BattleStatusState.inQueue => Colors.green,
      BattleStatusState.inBattle => Colors.yellow,
      BattleStatusState.watching => Colors.grey,
      null => Colors.red,
    };
    final canBattle = widget.battleStatus.status == BattleStatusState.inQueue;
    final battling =
        widget.battleStatus.opponentId == widget.battleStatus.userId;
    final inBattle = widget.battleStatus.opponentId != null;

    return Container(
      height: 40,
      width: size.width - 32,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: darkenColor(theme.primaryColor, 0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        spacing: 8,
        children: [
          Icon(
            Icons.circle,
            color: statusColor,
          ),
          Text(
            widget.battleStatus.displayName ?? 'unknown',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.surface,
            ),
          ),
          Spacer(),
          if (canBattle && !_waiting && !battling)
            UIButton(
              onPressed: inBattle ? () {} : _challenge,
              text: 'Battle',
              icon: Icons.play_arrow_rounded,
              backgroundColor: inBattle
                  ? Colors.grey
                  : darkenColor(theme.colorScheme.primary, 0.1),
              foregroundColor: inBattle
                  ? lightenColor(theme.colorScheme.onSurface, 0.3)
                  : theme.colorScheme.onPrimary,
            ),
          if (canBattle && _waiting)
            UIButton(
              onPressed: _cancel,
              text: 'Cancel',
              icon: Icons.hourglass_empty_rounded,
              backgroundColor: darkenColor(theme.colorScheme.primary, 0.1),
            ),
          if (canRejoin)
            UIButton(
              onPressed: _rejoin,
              text: 'Rejoin',
              icon: Icons.refresh_rounded,
              backgroundColor: darkenColor(theme.colorScheme.primary, 0.1),
            ),
          if (!canBattle && !battling && !canRejoin)
            UIButton(
              onPressed: inBattle ? () {} : () {},
              text: 'Watch',
              icon: Icons.remove_red_eye_rounded,
              backgroundColor: inBattle
                  ? Colors.grey
                  : darkenColor(theme.colorScheme.primary, 0.1),
              foregroundColor: inBattle
                  ? lightenColor(theme.colorScheme.onSurface, 0.3)
                  : theme.colorScheme.onPrimary,
            ),
          if (battling)
            Text(
              'Battling...',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.surface,
              ),
            ),
        ],
      ),
    );
  }
}

class _ChallengeWidget extends ConsumerWidget {
  final BattleQueue challenge;
  final Function() onAccept;
  final Function() onReject;

  const _ChallengeWidget({
    required this.challenge,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightenColor(theme.colorScheme.primary, 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 3,
          color: theme.colorScheme.primary,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        spacing: 16,
        children: [
          Text(
            '${challenge.data?.userName} has challenged you to a battle',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UIButton(
                onPressed: onReject,
                text: 'Reject',
                icon: Icons.cancel_rounded,
                backgroundColor: Colors.transparent,
              ),
              UIButton(
                onPressed: onAccept,
                text: 'Accept',
                icon: Icons.play_arrow_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
