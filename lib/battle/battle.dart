import 'dart:io' show WebSocket;
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mnstrv2/providers/auth.dart';

import '../config/endpoints.dart';
import '../shared/layout_scaffold.dart';

class BattleView extends ConsumerStatefulWidget {
  const BattleView({super.key});

  @override
  ConsumerState<BattleView> createState() => _BattleViewState();
}

class _BattleViewState extends ConsumerState<BattleView> {
  WebSocket? _socket;

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
      log('message: $message');
    });
    _socket?.add(jsonEncode({'type': 'join_battle_queue'}));
  }

  Future<void> _disconnect() async {
    await _socket?.close();
    _socket = null;
  }

  @override
  void initState() {
    super.initState();
    _connect();
  }

  @override
  void dispose() {
    _disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutScaffold(
      child: SafeArea(child: Center(child: Text('Battle'))),
    );
  }
}
