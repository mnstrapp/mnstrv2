import 'dart:io' show WebSocket, WebSocketStatus;
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mnstrv2/providers/auth.dart';
import 'package:uuid/uuid.dart' as uuid;

import '../config/endpoints.dart';
import '../providers/session_users.dart';
import '../shared/layout_scaffold.dart';
import '../ui/button.dart';
import '../utils/color.dart';
import 'data.dart';

enum BattleMessageType {
  message,
  error,
}

class BattleMessage {
  BattleMessageType type;
  String message;

  BattleMessage({this.type = BattleMessageType.message, this.message = ''});
}

class BattleView extends ConsumerStatefulWidget {
  const BattleView({super.key});

  @override
  ConsumerState<BattleView> createState() => _BattleViewState();
}

class _BattleViewState extends ConsumerState<BattleView> {
  WebSocket? _socket;
  bool _isJoined = false;
  bool _reconnect = false;
  List<BattleMessage> _messages = [];

  Future<void> _handleMessage(String message) async {
    final battleQueue = BattleQueue.fromJson(jsonDecode(message));
    log('[handleMessage] battleQueue: ${battleQueue.toJson()}');
    final newMessage = BattleMessage();
    if (battleQueue.data?.message != null) {
      newMessage.type = BattleMessageType.message;
      newMessage.message = battleQueue.data?.message as String;
    }
    if (battleQueue.data?.error != null) {
      newMessage.type = BattleMessageType.error;
      newMessage.message = battleQueue.data?.error as String;
    }
    setState(() {
      _messages = [..._messages, newMessage];
    });
    switch (battleQueue.action) {
      case BattleQueueAction.joined:
        setState(() {
          _isJoined = true;
        });
        break;
      case BattleQueueAction.left:
        break;
      case BattleQueueAction.ready:
        break;
      case BattleQueueAction.requested:
        break;
      case BattleQueueAction.accepted:
        break;
      case BattleQueueAction.rejected:
        break;
      case BattleQueueAction.cancelled:
        break;
      case BattleQueueAction.watching:
        break;
      case BattleQueueAction.error:
        break;
      default:
        break;
    }
  }

  Future<void> _connect() async {
    final session = await getAuth();
    if (session == null) {
      log('session is null');
      return;
    }
    final headers = {'Authorization': 'Bearer ${session.token}'};

    try {
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
      setState(() {
        _messages = [
          ..._messages,
          BattleMessage(
            type: BattleMessageType.message,
            message: 'Connected to battle queue',
          ),
        ];
      });
      _socket?.listen(
        (message) {
          _handleMessage(message);
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
          setState(() {
            _messages = [
              ..._messages,
              BattleMessage(
                type: BattleMessageType.error,
                message: 'Socket error: $error',
              ),
            ];
          });
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
      });
    }
  }

  Future<void> _sendTestMessage() async {
    final user = ref.read(sessionUserProvider);
    if (user.value == null) {
      setState(() {
        _messages = [
          ..._messages,
          BattleMessage(type: BattleMessageType.error, message: 'User is null'),
        ];
      });
      return;
    }
    final data = BattleQueueData(
      action: BattleQueueDataAction.ready,
      userId: user.value?.id,
      message: 'test',
    );
    final queue = BattleQueue(
      action: BattleQueueAction.ready,
      channel: BattleQueueChannel.lobby,
      userId: user.value?.id,
      data: data,
    );
    setState(() {
      _messages = [
        ..._messages,
        BattleMessage(
          type: BattleMessageType.message,
          message: 'Sending test message',
        ),
      ];
    });
    _socket?.add(jsonEncode(queue.toJson()));
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
                UIButton(
                  onPressedAsync: _sendTestMessage,
                  text: 'Send Test Message',
                  icon: Icons.send,
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

  const _BattleMessages({super.key, required this.messages});

  @override
  State<_BattleMessages> createState() => _BattleMessagesState();
}

class _BattleMessagesState extends State<_BattleMessages> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.messages.isEmpty) {
      return const SizedBox.shrink();
    }

    final messages = widget.messages.reversed.skip(1).toList();
    final currentMessage = widget.messages.last;
    log('[build] messages: $messages');
    log('[build] currentMessage: $currentMessage');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        Row(
          children: [
            Container(
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: darkenColor(theme.primaryColor, 0.3),
                borderRadius: BorderRadius.circular(20),
              ),
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
                  Text(
                    currentMessage.message,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.surface,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                    child: Container(
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
                  ),
                ],
              ),
            ),
          ],
        ),
        if (_expanded)
          ...messages.map(
            (message) => Container(
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: darkenColor(theme.primaryColor, 0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
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
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
