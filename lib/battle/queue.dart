import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/battle.dart';
import '../providers/session_users.dart';
import '../proto/battles.pb.dart' as proto;
import '../shared/layout_scaffold.dart';
import '../ui/button.dart';
import '../utils/color.dart';
import 'battle_state.dart';

/// The battle lobby: other players, and challenges sent and received.
class BattleQueueView extends ConsumerStatefulWidget {
  final BattleClient client;

  /// Called with the new battle when the player accepts a challenge.
  final void Function(proto.BattleState state) onBattleStarted;

  const BattleQueueView({
    super.key,
    required this.client,
    required this.onBattleStarted,
  });

  @override
  ConsumerState<BattleQueueView> createState() => _BattleQueueViewState();
}

class _BattleQueueViewState extends ConsumerState<BattleQueueView> {
  List<proto.BattleStatus> _lobby = [];
  LobbyChallenges _challenges = const LobbyChallenges();
  StreamSubscription<proto.BattleEvent>? _events;
  StreamSubscription<BattleConnection>? _connection;

  BattleClient get _client => widget.client;

  void _showError(Object error) {
    if (!mounted) {
      return;
    }
    final message = error is BattleException
        ? error.message
        : 'Something went wrong. Please try again.';
    LayoutScaffold.addError(context, message);
  }

  Future<void> _refreshLobby() async {
    try {
      final lobby = await _client.listPlayers();
      if (mounted) {
        setState(() {
          _lobby = lobby;
        });
      }
    } catch (error) {
      _showError(error);
    }
  }

  void _handleEvent(proto.BattleEvent event) {
    final user = ref.read(sessionUserProvider);
    if (!mounted || user?.id == null) {
      return;
    }
    setState(() {
      _lobby = applyLobbyEvent(_lobby, event, user!.id!);
      _challenges = _challenges.apply(event);
    });
  }

  Future<void> _challenge(proto.BattleStatus status) async {
    try {
      final challengeId = await _client.challenge(status.userId);
      if (mounted) {
        setState(() {
          _challenges = _challenges.withSent(status.userId, challengeId);
        });
      }
    } catch (error) {
      _showError(error);
    }
  }

  Future<void> _cancel(proto.BattleStatus status) async {
    final challengeId = _challenges.sent[status.userId];
    setState(() {
      _challenges = _challenges.withoutSent(status.userId);
    });
    if (challengeId == null) {
      return;
    }
    try {
      await _client.cancelChallenge(
        challengeId: challengeId,
        opponentId: status.userId,
      );
    } catch (error) {
      _showError(error);
    }
  }

  Future<void> _accept(proto.ChallengeReceived challenge) async {
    setState(() {
      _challenges = _challenges.withoutReceived(challenge.challengeId);
    });
    try {
      final state = await _client.acceptChallenge(
        challengeId: challenge.challengeId,
        challengerId: challenge.challenger.userId,
      );
      widget.onBattleStarted(state);
    } catch (error) {
      _showError(error);
    }
  }

  Future<void> _reject(proto.ChallengeReceived challenge) async {
    setState(() {
      _challenges = _challenges.withoutReceived(challenge.challengeId);
    });
    try {
      await _client.rejectChallenge(
        challengeId: challenge.challengeId,
        challengerId: challenge.challenger.userId,
      );
    } catch (error) {
      _showError(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _events = _client.events.listen(_handleEvent);
    _connection = _client.connectionChanges.listen((connection) {
      // A new stream is a new lobby entry: reload who is here.
      if (connection == BattleConnection.connected) {
        _refreshLobby();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshLobby();
    });
  }

  @override
  void dispose() {
    _events?.cancel();
    _connection?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        ..._challenges.received.map(
          (challenge) => _ChallengeWidget(
            challenge: challenge,
            onAccept: () => _accept(challenge),
            onReject: () => _reject(challenge),
          ),
        ),
        ..._lobby.map(
          (status) => _BattleStatusWidget(
            battleStatus: status,
            waiting: _challenges.sent.containsKey(status.userId),
            onChallenge: () => _challenge(status),
            onCancel: () => _cancel(status),
          ),
        ),
      ],
    );
  }
}

class _BattleStatusWidget extends StatefulWidget {
  final proto.BattleStatus battleStatus;
  final bool waiting;
  final Future<void> Function() onChallenge;
  final Future<void> Function() onCancel;

  const _BattleStatusWidget({
    required this.battleStatus,
    required this.waiting,
    required this.onChallenge,
    required this.onCancel,
  });

  @override
  State<_BattleStatusWidget> createState() => _BattleStatusWidgetState();
}

class _BattleStatusWidgetState extends State<_BattleStatusWidget> {
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
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final status = widget.battleStatus.status;
    final statusColor = switch (status) {
      proto.BattleStatusState.BATTLE_STATUS_STATE_IN_QUEUE => Colors.green,
      proto.BattleStatusState.BATTLE_STATUS_STATE_IN_BATTLE => Colors.yellow,
      proto.BattleStatusState.BATTLE_STATUS_STATE_WATCHING => Colors.grey,
      _ => Colors.red,
    };
    final canBattle =
        status == proto.BattleStatusState.BATTLE_STATUS_STATE_IN_QUEUE;
    final battling =
        status == proto.BattleStatusState.BATTLE_STATUS_STATE_IN_BATTLE;

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
            widget.battleStatus.displayName.isEmpty
                ? 'unknown'
                : widget.battleStatus.displayName,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.surface,
            ),
          ),
          Spacer(),
          if (canBattle && !widget.waiting)
            UIButton(
              onPressedAsync: widget.onChallenge,
              text: 'Battle',
              icon: Icons.play_arrow_rounded,
              backgroundColor: darkenColor(theme.colorScheme.primary, 0.1),
              foregroundColor: theme.colorScheme.onPrimary,
            ),
          if (canBattle && widget.waiting)
            UIButton(
              onPressedAsync: widget.onCancel,
              text: 'Cancel',
              icon: Icons.hourglass_empty_rounded,
              backgroundColor: darkenColor(theme.colorScheme.primary, 0.1),
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

class _ChallengeWidget extends StatelessWidget {
  final proto.ChallengeReceived challenge;
  final Future<void> Function() onAccept;
  final Future<void> Function() onReject;

  const _ChallengeWidget({
    required this.challenge,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
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
            '${challenge.challenger.displayName} has challenged you to a battle',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UIButton(
                onPressedAsync: onReject,
                text: 'Reject',
                icon: Icons.cancel_rounded,
                backgroundColor: Colors.transparent,
              ),
              UIButton(
                onPressedAsync: onAccept,
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
