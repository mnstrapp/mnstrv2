import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/login.dart';
import '../providers/auth.dart';
import '../providers/battle.dart';
import '../providers/manage.dart';
import '../providers/session_users.dart';
import '../proto/battles.pb.dart' as proto;
import '../shared/empty_message.dart';
import '../shared/layout_scaffold.dart';
import '../ui/button.dart';
import '../utils/color.dart';
import 'queue.dart';
import 'vs.dart';

enum BattleMessageType {
  message,
  error,
}

class BattleMessage {
  BattleMessageType type;
  String message;

  BattleMessage({this.type = BattleMessageType.message, this.message = ''});
}

/// The battle area: holds the `Join` event stream open and shows the lobby
/// or the current battle.
class BattleLayoutView extends ConsumerStatefulWidget {
  const BattleLayoutView({super.key});

  @override
  ConsumerState<BattleLayoutView> createState() => _BattleLayoutViewState();
}

class _BattleLayoutViewState extends ConsumerState<BattleLayoutView> {
  late final BattleClient _client;
  final List<StreamSubscription<Object>> _subscriptions = [];
  bool _isLoading = false;
  BattleConnection _connection = BattleConnection.disconnected;
  bool _canReconnect = false;
  List<BattleMessage> _messages = [];

  /// The battle the player is in, if any.
  proto.BattleState? _battle;
  final GlobalKey<LayoutScaffoldState> layoutKey =
      GlobalKey<LayoutScaffoldState>();

  void _log(String message, {bool error = false}) {
    if (!mounted) {
      return;
    }
    setState(() {
      _messages = [
        ..._messages,
        BattleMessage(
          type: error ? BattleMessageType.error : BattleMessageType.message,
          message: message,
        ),
      ];
    });
  }

  void _startBattle(proto.BattleState state) {
    if (!mounted) {
      return;
    }
    if (_battle != null && _battle!.battleId == state.battleId) {
      return;
    }
    setState(() {
      _battle = state;
    });
  }

  void _handleEvent(proto.BattleEvent event) {
    final userId = ref.read(sessionUserProvider)?.id;
    switch (event.whichPayload()) {
      case proto.BattleEvent_Payload.gameStarted:
        _startBattle(event.gameStarted.state);
        break;
      case proto.BattleEvent_Payload.rejoined:
        if (event.rejoined.userId == userId) {
          _startBattle(event.rejoined.state);
        }
        break;
      case proto.BattleEvent_Payload.error:
        if (!event.error.hasBattleId()) {
          layoutKey.currentState?.addError(event.error.message);
          _log(event.error.message, error: true);
        }
        break;
      default:
        break;
    }
  }

  void _handleConnection(BattleConnection connection) {
    if (!mounted) {
      return;
    }
    setState(() {
      _connection = connection;
      if (connection == BattleConnection.connected) {
        _canReconnect = false;
      }
    });
    switch (connection) {
      case BattleConnection.connecting:
        _log('Connecting to battle queue');
        break;
      case BattleConnection.connected:
        _log('Connected to battle queue');
        // A dropped stream took the player out of the lobby; put them back
        // into the battle they were fighting.
        final battle = _battle;
        if (battle != null) {
          _rejoin(battle.battleId);
        }
        break;
      case BattleConnection.reconnecting:
        _log('Reconnecting to battle queue', error: true);
        break;
      case BattleConnection.disconnected:
        setState(() {
          _canReconnect = true;
        });
        break;
    }
  }

  void _handleStreamError(BattleException error) {
    layoutKey.currentState?.addError(error.message);
    _log(error.message, error: true);
  }

  Future<void> _rejoin(String battleId) async {
    try {
      final state = await _client.rejoin(battleId);
      if (mounted && _battle?.battleId == battleId) {
        setState(() {
          _battle = state;
        });
      }
    } on BattleException catch (error) {
      // The battle ended while the player was away.
      _log(error.message, error: true);
      if (mounted) {
        setState(() {
          _battle = null;
        });
      }
    }
  }

  void _connect() {
    setState(() {
      _canReconnect = false;
    });
    _client.connect();
  }

  Future<void> _onGameEnded() async {
    setState(() {
      _battle = null;
    });
    // Rewards changed the player's mnstrs.
    await ref.read(manageProvider.notifier).getMonsters();
  }

  @override
  void initState() {
    super.initState();
    _client = ref.read(battleClientProvider);
    _connection = _client.connection;
    _subscriptions.addAll([
      _client.events.listen(_handleEvent),
      _client.connectionChanges.listen(_handleConnection),
      _client.streamErrors.listen(_handleStreamError),
    ]);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _isLoading = true;
      });
      await ref.read(manageProvider.notifier).getMonsters();
      await ref.read(authProvider.notifier).ensureAuth();
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
      });
      final mnstrs = ref.read(manageProvider);
      if (mnstrs.isEmpty) {
        return;
      }
      final auth = ref.read(authProvider);
      if (auth == null) {
        return;
      }
      _connect();
    });
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    // Closing the stream takes the player out of the lobby.
    _client.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    if (auth == null) {
      return LayoutScaffold(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                Text(
                  'Your challenges go unheard!',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Perhaps you should go where the other humans are...',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                UIButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ),
                    );
                  },
                  icon: Icons.login,
                  text: 'Login',
                ),
              ],
            ),
          ),
        ),
      );
    }

    final size = MediaQuery.sizeOf(context);
    final mnstrs = ref.watch(manageProvider);

    if (mnstrs.isEmpty && !_isLoading) {
      return const EmptyMessage();
    }

    final battle = _battle;
    final isJoined = _connection == BattleConnection.connected;

    return LayoutScaffold(
      key: layoutKey,
      child: battle != null
          ? BattleVsView(
              key: ValueKey(battle.battleId),
              client: _client,
              initialState: battle,
              onGameEnded: _onGameEnded,
            )
          : SafeArea(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      margin: const EdgeInsets.only(
                        top: 48,
                        left: 16,
                        right: 16,
                        bottom: 0,
                      ),
                      width: size.width,
                      child: Column(
                        spacing: 8,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_messages.isNotEmpty)
                            _BattleMessages(messages: _messages),
                          if (_canReconnect)
                            UIButton(
                              onPressed: _connect,
                              text: 'Reconnect',
                              icon: Icons.refresh,
                            ),
                          if (isJoined)
                            BattleQueueView(
                              client: _client,
                              onBattleStarted: _startBattle,
                            ),
                        ],
                      ),
                    ),
            ),
    );
  }
}

class _BattleMessages extends StatefulWidget {
  final List<BattleMessage> messages;

  const _BattleMessages({
    required this.messages,
  });

  @override
  State<_BattleMessages> createState() => _BattleMessagesState();
}

class _BattleMessagesState extends State<_BattleMessages> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final height = size.height * 0.15;
    final backgroundColor = LayoutScaffold.getBackgroundColor(context);

    if (widget.messages.isEmpty) {
      return const SizedBox.shrink();
    }

    final messages = widget.messages.reversed.skip(1).toList();
    final currentMessage = widget.messages.last;

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: lightenColor(backgroundColor ?? theme.primaryColor, 0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: size.width - 32,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: darkenColor(
                    backgroundColor ?? theme.primaryColor,
                    0.1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      Icon(
                        Icons.circle,
                        color: currentMessage.type == BattleMessageType.error
                            ? theme.colorScheme.error
                            : Colors.green,
                      ),
                      Expanded(
                        child: Text(
                          currentMessage.message,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.surface,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          _expanded
                              ? Icons.expand_less_rounded
                              : Icons.expand_more_rounded,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_expanded)
            Container(
              height: height,
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SingleChildScrollView(
                  child: Column(
                    // spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: messages
                        .map(
                          (message) => Padding(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              spacing: 8,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: message.type == BattleMessageType.error
                                      ? theme.colorScheme.error
                                      : Colors.green,
                                ),
                                Expanded(
                                  child: Text(
                                    message.message,
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
