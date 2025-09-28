import 'dart:io' show WebSocket, WebSocketStatus;
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mnstrv2/providers/auth.dart';

import '../config/endpoints.dart';
import '../shared/layout_scaffold.dart';
import '../shared/monster_xp_bar.dart';
import '../utils/color.dart';
import 'data.dart';

class BattleView extends ConsumerStatefulWidget {
  const BattleView({super.key});

  @override
  ConsumerState<BattleView> createState() => _BattleViewState();
}

class _BattleViewState extends ConsumerState<BattleView> {
  WebSocket? _socket;
  bool _isJoined = false;
  String? _message;
  String? _error;

  Future<void> _handleMessage(String message) async {
    final battleQueue = BattleQueue.fromJson(jsonDecode(message));
    log('[handleMessage] battleQueue: ${battleQueue.toJson()}');
    setState(() {
      _message = battleQueue.data?.message;
      _error = battleQueue.data?.error;
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

  void _connect() async {
    final session = await getAuth();
    if (session == null) {
      log('session is null');
      return;
    }
    final headers = {'Authorization': 'Bearer ${session.token}'};
    _socket = await WebSocket.connect(
      '$wsUrl/battle_queue',
      headers: headers,
    );
    _socket?.listen((message) {
      _handleMessage(message);
    });
  }

  @override
  void initState() {
    super.initState();
    _connect();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return LayoutScaffold(
      child: !_isJoined
          ? const Center(
              child: Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Joining...'),
                ],
              ),
            )
          : SafeArea(
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
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: 16),
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
                          Icon(Icons.circle, color: Colors.green),
                          if (_message != null)
                            Text(
                              _message!,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.surface,
                              ),
                            ),
                          if (_error != null)
                            Text(
                              _error!,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.error,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
