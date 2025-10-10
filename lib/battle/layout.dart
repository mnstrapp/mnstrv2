import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mnstrv2/providers/auth.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:wiredash/wiredash.dart';

import '../auth/login.dart';
import '../config/endpoints.dart';
import '../providers/manage.dart';
import '../providers/session_users.dart';
import '../shared/empty_message.dart';
import '../shared/layout_scaffold.dart';
import '../ui/button.dart';
import '../utils/color.dart';
import 'data.dart';
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

class BattleLayoutView extends ConsumerStatefulWidget {
  const BattleLayoutView({super.key});

  @override
  ConsumerState<BattleLayoutView> createState() => _BattleLayoutViewState();
}

class _BattleLayoutViewState extends ConsumerState<BattleLayoutView> {
  WebSocketChannel? _socket;
  bool _isLoading = false;
  bool _isJoined = false;
  bool _reconnect = false;
  bool _isInBattle = false;
  List<BattleMessage> _messages = [];
  final List<Function(String)> _listeners = [];
  BattleQueue? _battleQueue;
  final GlobalKey<LayoutScaffoldState> layoutKey =
      GlobalKey<LayoutScaffoldState>();

  void _keepConnection() {
    if (!mounted) {
      return;
    }
    if (_socket == null) {
      _connect();
      return;
    }

    final user = ref.read(sessionUserProvider);
    if (user == null) {
      return;
    }
    final data = BattleQueueData(
      userId: user.id,
      userName: user.displayName,
      message: 'ping',
      action: BattleQueueDataAction.ping,
    );
    final battleQueue = BattleQueue(
      action: BattleQueueAction.ping,
      userId: user.id,
      data: data,
      channel: BattleQueueChannel.lobby,
    );
    try {
      _socket?.sink.add(jsonEncode(battleQueue.toJson()));
    } catch (e) {
      _connect();
    }
    Future.delayed(const Duration(seconds: 1), () {
      _keepConnection();
    });
  }

  void _log(BattleQueue battleQueue) {
    final user = ref.read(sessionUserProvider);
    if (user == null) {
      return;
    }
    battleQueue.data?.userName ??= user.displayName;
    battleQueue.data?.userId ??= user.id;
    battleQueue.userId ??= user.id;

    final newMessage = BattleMessage();

    if (battleQueue.data?.message != null) {
      newMessage.type = BattleMessageType.message;
      newMessage.message =
          '[${battleQueue.data?.userName}] ${battleQueue.data?.message as String}';
    }
    if (battleQueue.data?.error != null) {
      newMessage.type = BattleMessageType.error;
      newMessage.message =
          '[${battleQueue.data?.userName}] ${battleQueue.data?.error as String}';
    }
    setState(() {
      _messages = [..._messages, newMessage];
    });
  }

  void _broadcast(String message) {
    for (var listener in _listeners) {
      listener(message);
    }
  }

  Future<void> _handleMessage(String message) async {
    final user = ref.read(sessionUserProvider);
    if (user == null) {
      return;
    }

    final battleQueue = BattleQueue.fromJson(jsonDecode(message));
    if (battleQueue.action == BattleQueueAction.ping) {
      return;
    }
    // _log(battleQueue);
    _broadcast(message);

    switch (battleQueue.action) {
      case BattleQueueAction.joined:
        if (battleQueue.data?.userId == user.id) {
          setState(() {
            _isJoined = true;
          });
        }
        break;
      case BattleQueueAction.left:
        if (battleQueue.data?.userId == user.id) {
          setState(() {
            _isJoined = false;
            _reconnect = true;
            _isInBattle = false;
          });
        }
        break;
      case BattleQueueAction.gameStarted:
        setState(() {
          if (battleQueue.data?.userId == user.id ||
              battleQueue.data?.opponentId == user.id) {
            _isInBattle = true;
            _battleQueue = battleQueue;
          }
        });
        break;
      default:
        break;
    }
  }

  void _addListener(Function(String) listener) {
    if (_listeners.contains(listener)) {
      return;
    }
    _listeners.add(listener);
  }

  void _removeListener(Function(String) listener) {
    _listeners.remove(listener);
  }

  void _sendMessage(BattleQueue battleQueue) {
    _socket?.sink.add(jsonEncode(battleQueue.toJson()));
  }

  Future<void> _connect() async {
    final session = await getAuth();
    if (session == null) {
      log('session is null');
      return;
    }

    final user = ref.read(sessionUserProvider);

    try {
      if (mounted) {
        setState(() {
          Wiredash.trackEvent(
            'Battle Layout View Connecting',
            data: {
              'displayName': user?.displayName,
              'id': user?.id,
            },
          );
          _messages = [
            ..._messages,
            BattleMessage(
              type: BattleMessageType.message,
              message: 'Connecting to battle queue',
            ),
          ];
        });
        _socket = WebSocketChannel.connect(
          Uri.parse('$wsUrl/battle_queue/${session.token}'),
        );
      }
      if (mounted) {
        Wiredash.trackEvent(
          'Battle Layout View Connected',
          data: {
            'displayName': user?.displayName,
            'id': user?.id,
          },
        );
        setState(() {
          _messages = [
            ..._messages,
            BattleMessage(
              type: BattleMessageType.message,
              message: 'Connected to battle queue',
            ),
          ];
        });
      }
      _socket?.stream.listen(
        (message) {
          Wiredash.trackEvent(
            'Battle Layout View Message',
            data: {
              'displayName': user?.displayName,
              'id': user?.id,
            },
          );
          if (mounted) {
            _handleMessage(message);
          }
        },
        onDone: () {
          Wiredash.trackEvent(
            'Battle Layout View Done',
            data: {
              'displayName': user?.displayName,
              'id': user?.id,
            },
          );
          layoutKey.currentState?.addError('Socket is disconnected');
          if (_socket?.closeCode == null) {
            return;
          }
          if (mounted) {
            setState(() {
              _messages = [
                ..._messages,
                BattleMessage(
                  type: BattleMessageType.error,
                  message: 'Socket is disconnected',
                ),
              ];
              _isJoined = false;
              _reconnect = true;
              _isInBattle = false;
            });
          }
        },
        onError: (error) {
          Wiredash.trackEvent(
            'Battle Layout View Socket Error',
            data: {
              'error': error,
              'displayName': user?.displayName,
              'id': user?.id,
            },
          );
          layoutKey.currentState?.addError('Socket error: $error');
          if (mounted) {
            setState(() {
              _messages = [
                ..._messages,
                BattleMessage(
                  type: BattleMessageType.error,
                  message: 'Socket error: $error',
                ),
              ];
              _isJoined = false;
              _reconnect = true;
              _isInBattle = false;
            });
          }
        },
      );
    } catch (e, stackTrace) {
      Wiredash.trackEvent(
        'Battle Layout View Socket Error',
        data: {
          'error': e,
          'displayName': user?.displayName,
          'id': user?.id,
        },
      );
      Sentry.captureException(e, stackTrace: stackTrace);
      layoutKey.currentState?.addError('Socket error: $e');
      setState(() {
        _messages = [
          ..._messages,
          BattleMessage(
            type: BattleMessageType.error,
            message: 'Socket error: $e',
          ),
        ];
        _isJoined = false;
        _reconnect = true;
        _isInBattle = false;
      });
    }
    _keepConnection();
  }

  @override
  void dispose() {
    _socket?.sink.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = ref.read(sessionUserProvider);

      Wiredash.trackEvent(
        'Battle Layout View',
        data: {
          'displayName': user?.displayName,
          'id': user?.id,
        },
      );

      setState(() {
        _isLoading = true;
      });
      await ref.read(manageProvider.notifier).getMonsters();

      if (mounted) {
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authProvider);
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
                  'Your challenges goes unheard!',
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

    return LayoutScaffold(
      key: layoutKey,
      child: _isInBattle
          ? BattleVsView(
              onListen: _addListener,
              onSend: _sendMessage,
              onLog: _log,
              onDispose: _removeListener,
              battleQueue: _battleQueue,
              onGameEnded: (_) {
                setState(() {
                  _isInBattle = false;
                  _battleQueue = null;
                });
                final battleQueueData = BattleQueueData(
                  action: BattleQueueDataAction.connect,
                  userId: _battleQueue?.data?.userId,
                  userName: _battleQueue?.data?.userName,
                );
                final battleQueue = BattleQueue(
                  action: BattleQueueAction.joined,
                  userId: _battleQueue?.data?.userId,
                  data: battleQueueData,
                  channel: BattleQueueChannel.lobby,
                );
                _socket?.sink.add(jsonEncode(battleQueue.toJson()));
              },
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
                          if (_reconnect)
                            UIButton(
                              onPressedAsync: () async {
                                setState(() {
                                  _reconnect = false;
                                  _messages = [
                                    ..._messages,
                                    BattleMessage(
                                      type: BattleMessageType.message,
                                      message: 'Reconnecting to battle queue',
                                    ),
                                  ];
                                });
                                await _connect();
                              },
                              text: 'Reconnect',
                              icon: Icons.refresh,
                            ),
                          if (_isJoined && !_isInBattle)
                            BattleQueueView(
                              onListen: _addListener,
                              onSend: _sendMessage,
                              onLog: _log,
                              onDispose: _removeListener,
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
