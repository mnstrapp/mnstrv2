import 'dart:io' show WebSocket;
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mnstrv2/providers/auth.dart';

import '../config/endpoints.dart';
import '../providers/session_users.dart';
import '../shared/layout_scaffold.dart';
import '../ui/button.dart';
import '../utils/color.dart';
import 'data.dart';
import 'queue.dart';

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
  WebSocket? _socket;
  bool _isJoined = false;
  bool _reconnect = false;
  List<BattleMessage> _messages = [];
  List<Function(String)> _listeners = [];

  void _log(BattleQueue battleQueue) {
    final user = ref.read(sessionUserProvider);
    if (user.value == null) {
      return;
    }
    battleQueue.data?.userName ??= user.value?.displayName;
    battleQueue.data?.userId ??= user.value?.id;
    battleQueue.userId ??= user.value?.id;

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
    _broadcast(message);

    final user = ref.read(sessionUserProvider);
    if (user.value == null) {
      return;
    }

    final battleQueue = BattleQueue.fromJson(jsonDecode(message));
    _log(battleQueue);

    switch (battleQueue.action) {
      case BattleQueueAction.joined:
        if (battleQueue.data?.userId == user.value?.id) {
          setState(() {
            _isJoined = true;
          });
        }
        break;
      case BattleQueueAction.left:
        if (battleQueue.data?.userId == user.value?.id) {
          setState(() {
            _isJoined = false;
            _reconnect = true;
          });
        }
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
    _socket?.add(jsonEncode(battleQueue.toJson()));
  }

  Future<void> _connect() async {
    final session = await getAuth();
    if (session == null) {
      log('session is null');
      return;
    }
    final headers = {'Authorization': 'Bearer ${session.token}'};

    try {
      if (mounted) {
        setState(() {
          _messages = [
            ..._messages,
            BattleMessage(
              type: BattleMessageType.message,
              message: 'Connecting to battle queue',
            ),
          ];
        });
        _socket = await WebSocket.connect(
          '$wsUrl/battle_queue',
          headers: headers,
        );
      }
      if (mounted) {
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
      _socket?.listen(
        (message) {
          if (mounted) {
            _handleMessage(message);
          }
        },
        onDone: () {
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
            });
          }
        },
        onError: (error) {
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
            });
          }
        },
      );
    } catch (e) {
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
      });
    }
  }

  @override
  void dispose() {
    _socket?.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _connect();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return LayoutScaffold(
      child: SafeArea(
        child: Container(
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
              if (_messages.isNotEmpty) _BattleMessages(messages: _messages),
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
              if (_isJoined)
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    if (widget.messages.isEmpty) {
      return const SizedBox.shrink();
    }

    final messages = widget.messages.reversed.skip(1).toList();
    final currentMessage = widget.messages.last;

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: lightenColor(theme.primaryColor, 0.3),
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
                  color: darkenColor(theme.primaryColor, 0.1),
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
              height: size.height * 0.33,
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
                                Text(
                                  message.message,
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
