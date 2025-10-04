import 'dart:convert';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/session_users.dart';
import '../shared/mnstr_list.dart';
import '../ui/button.dart';
import '../utils/color.dart';
import 'data.dart';
import '../models/monster.dart';
import 'game_data.dart';

class BattleVsView extends ConsumerStatefulWidget {
  final Function(Function(String)) onListen;
  final Function(BattleQueue) onSend;
  final Function(BattleQueue) onLog;
  final Function(Function(String)) onDispose;
  final BattleQueue? battleQueue;

  const BattleVsView({
    super.key,
    required this.onListen,
    required this.onSend,
    required this.onLog,
    required this.onDispose,
    required this.battleQueue,
  });

  @override
  ConsumerState<BattleVsView> createState() => _BattleVsViewState();
}

class _BattleVsViewState extends ConsumerState<BattleVsView> {
  Monster? _challengerMnstr;
  Monster? _opponentMnstr;
  List<Monster>? _challengerMnstrs;
  List<Monster>? _opponentMnstrs;
  String? _userId;
  String? _userName;
  String? _battleId;
  String? _challengerId;
  String? _opponentId;
  GameData? _gameData;
  BattleQueue? _battleQueue;
  bool _choosingMnstr = true;
  bool _inBattle = false;
  bool _isChallenger = false;

  Future<void> _initUser() async {
    final user = ref.read(sessionUserProvider);
    if (user.value == null) {
      return;
    }
    setState(() {
      _userId = user.value?.id;
      _userName = user.value?.displayName;
      _isChallenger = _battleQueue?.data?.userId == user.value?.id;
    });
  }

  Future<void> _chooseMnstr(Monster mnstr) async {
    final isChallenger = _isChallenger;

    setState(() {
      if (isChallenger) {
        _challengerMnstr = mnstr;
      } else {
        _opponentMnstr = mnstr;
      }
      _choosingMnstr = false;
    });
    final battleQueue = await _buildBattleQueue();
    widget.onSend(battleQueue);
  }

  Future<BattleQueue> _buildBattleQueue() async {
    final data = BattleQueueData(
      action: BattleQueueDataAction.mnstrChosen,
      userId: _isChallenger ? _userId : _battleQueue!.data!.opponentId,
      userName: _isChallenger ? _userName : _battleQueue!.data!.opponentName,
      opponentId: !_isChallenger ? _userId : _battleQueue!.data?.opponentId,
      opponentName: !_isChallenger
          ? _userName
          : _battleQueue!.data!.opponentName,
      userMnstrId: _isChallenger
          ? _challengerMnstr?.id
          : _battleQueue!.data!.userMnstrId,
      opponentMnstrId: !_isChallenger
          ? _opponentMnstr?.id
          : _battleQueue!.data!.opponentMnstrId,
      message: 'Mnstr chosen',
      data: jsonEncode(
        GameData(
          challengerMnstr: _isChallenger
              ? _challengerMnstr
              : _gameData?.challengerMnstr,
          opponentMnstr: !_isChallenger
              ? _opponentMnstr
              : _gameData?.opponentMnstr,
          battleId: _gameData?.battleId,
        ).toJson(),
      ),
    );
    final battleQueue = BattleQueue(
      action: BattleQueueAction.mnstrChosen,
      userId: _userId,
      data: data,
      channel: BattleQueueChannel.battle,
    );
    log('[build battle queue] _isChallenger: $_isChallenger');
    log('[build battle queue] _userId: $_userId');
    log('[build battle queue] _userName: $_userName');
    log(
      '[build battle queue] battle queue data: ${battleQueue.data?.toJson()}',
    );
    log('[build battle queue] battle queue: ${battleQueue.toJson()}');
    return battleQueue;
  }

  Future<void> _handleMessage(String message) async {
    final battleQueue = BattleQueue.fromJson(jsonDecode(message));
    if (battleQueue.action == BattleQueueAction.ping) {
      return;
    }

    if (battleQueue.data!.userId != _userId &&
        battleQueue.data!.opponentId != _userId) {
      log('[handle message] not user or opponent:');
      log('\tchallenger: ${battleQueue.data?.userId != _userId}');
      log('\topponent: ${battleQueue.data?.opponentId != _userId}');
      return;
    }

    setState(() {
      _battleQueue = battleQueue;
    });

    switch (battleQueue.action) {
      case BattleQueueAction.mnstrChosen:
        if (battleQueue.data!.data == null) {
          log('[mnstr chosen] data is null');
          break;
        }
        final data = jsonDecode(battleQueue.data!.data!);
        final gameData = GameData.fromJson(data);
        setState(() {
          if (gameData.challengerMnstr != null) {
            _challengerMnstr = gameData.challengerMnstr;
          }
          if (gameData.opponentMnstr != null) {
            _opponentMnstr = gameData.opponentMnstr;
          }
        });
        break;
      case BattleQueueAction.gameStarted:
        setState(() {
          _inBattle = true;
        });
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _battleQueue = widget.battleQueue;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initUser();
      if (_isChallenger) {
        _challengerId = _userId;
        _opponentId = _battleQueue!.data!.opponentId;
      } else {
        _challengerId = _battleQueue!.data!.userId;
        _opponentId = _userId;
      }
      final data = jsonDecode(_battleQueue!.data!.data!);
      _gameData = GameData.fromJson(data);
      _challengerMnstr = _gameData?.challengerMnstr;
      _opponentMnstr = _gameData?.opponentMnstr;
      _challengerMnstrs = _gameData?.challengerMnstrs;
      _opponentMnstrs = _gameData?.opponentMnstrs;
      widget.onListen(_handleMessage);
    });
  }

  @override
  void dispose() {
    widget.onDispose(_handleMessage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Monster> mnstrs = [];
    if (_isChallenger) {
      mnstrs = _challengerMnstrs ?? [];
    } else {
      mnstrs = _opponentMnstrs ?? [];
    }

    if (mnstrs.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    bool choosingMnstr = _choosingMnstr;

    final inBattle = _inBattle;

    final size = MediaQuery.sizeOf(context);

    return choosingMnstr && mnstrs.isNotEmpty
        ? SizedBox(
            height: size.height,
            width: size.width,
            child: MnstrList(
              showName: false,
              monsters: mnstrs,
              onTap: _chooseMnstr,
              overlayBuilder: (mnstr) {
                final m = mnstr.toMonsterModel();
                final color = darkenColor(
                  Color.lerp(m.color, Colors.black, 0.1) ?? Colors.black,
                  0.3,
                );
                return Stack(
                  children: [
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: UIButton(
                        height: 48,
                        onPressed: () {
                          _chooseMnstr(mnstr);
                        },
                        icon: Icons.play_arrow_rounded,
                        backgroundColor: color,
                        text: 'Choose',
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        : inBattle
        ? BattleVsInGameView(
            gameData: _gameData!,
            onListen: widget.onListen,
            onSend: widget.onSend,
            onLog: widget.onLog,
            onDispose: widget.onDispose,
          )
        : const Center(child: Text('Waiting for opponent...'));
  }
}

class BattleVsInGameView extends ConsumerStatefulWidget {
  final GameData gameData;
  final Function(Function(String)) onListen;
  final Function(BattleQueue) onSend;
  final Function(BattleQueue) onLog;
  final Function(Function(String)) onDispose;

  const BattleVsInGameView({
    super.key,
    required this.gameData,
    required this.onListen,
    required this.onSend,
    required this.onLog,
    required this.onDispose,
  });

  @override
  ConsumerState<BattleVsInGameView> createState() => _BattleVsInGameViewState();
}

class _BattleVsInGameViewState extends ConsumerState<BattleVsInGameView> {
  GameData? _gameData;

  void _handleMessage(String message) {}

  @override
  void initState() {
    super.initState();
    _gameData = widget.gameData;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onListen(_handleMessage);
    });
  }

  @override
  void dispose() {
    widget.onDispose(_handleMessage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Game time!'));
  }
}
