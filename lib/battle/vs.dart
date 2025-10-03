import 'dart:convert';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
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
  String? _battleId;
  String? _challengerId;
  String? _opponentId;
  User? _user;
  GameData? _gameData;
  BattleQueue? _battleQueue;

  Future<void> _initUser() async {
    final user = await getSessionUser();
    setState(() {
      _user = user;
    });
  }

  bool _isChallenger() {
    return _battleQueue?.data?.userId == _user?.id;
  }

  void _chooseMnstr(Monster mnstr) {
    setState(() {
      if (_isChallenger()) {
        _challengerMnstr = mnstr;
      } else {
        _opponentMnstr = mnstr;
      }
    });
    final battleQueue = _buildBattleQueue();
    widget.onSend(battleQueue);
  }

  BattleQueue _buildBattleQueue() {
    log('[build battle queue] _user: ${_user?.toJson()}');
    final data = BattleQueueData(
      action: BattleQueueDataAction.mnstrChosen,
      userId: _isChallenger() ? _user?.id : _battleQueue!.data!.opponentId,
      userName: _isChallenger()
          ? _user?.displayName
          : _battleQueue!.data!.opponentName,
      opponentId: !_isChallenger() ? _battleQueue!.data?.opponentId : _user?.id,
      opponentName: !_isChallenger()
          ? _battleQueue!.data!.opponentName
          : _user?.displayName,
      userMnstrId: _isChallenger()
          ? _challengerMnstr?.id
          : _battleQueue!.data!.userMnstrId,
      opponentMnstrId: !_isChallenger()
          ? _opponentMnstr?.id
          : _battleQueue!.data!.opponentMnstrId,
      message: 'Mnstr chosen',
      data: jsonEncode(
        GameData(
          challengerMnstr: _isChallenger()
              ? _challengerMnstr
              : _gameData?.challengerMnstr,
          opponentMnstr: !_isChallenger()
              ? _opponentMnstr
              : _gameData?.opponentMnstr,
          battleId: _gameData?.battleId,
        ).toJson(),
      ),
    );
    return BattleQueue(
      action: BattleQueueAction.mnstrChosen,
      userId: _user?.id,
      data: data,
      channel: BattleQueueChannel.battle,
    );
  }

  Future<void> _handleMessage(String message) async {
    final user = ref.read(sessionUserProvider);
    if (user.value == null) {
      return;
    }

    final battleQueue = BattleQueue.fromJson(jsonDecode(message));
    if (battleQueue.action == BattleQueueAction.ping) {
      return;
    }
    setState(() {
      _battleQueue = battleQueue;
    });

    log('[mnstr chosen] battle queue: $message');

    if (battleQueue.data!.userId != user.value?.id ||
        battleQueue.data!.opponentId != user.value?.id) {
      log('[mnstr chosen] not user or opponent');
      return;
    }

    switch (battleQueue.action) {
      case BattleQueueAction.mnstrChosen:
        if (battleQueue.data!.data == null) {
          log('[mnstr chosen] data is null');
          break;
        }
        final data = jsonDecode(battleQueue.data!.data!);
        final gameData = GameData.fromJson(data);
        log('[mnstr chosen] game data: ${gameData.toJson()}');
        setState(() {
          if (gameData.challengerMnstr != null) {
            _challengerMnstr = gameData.challengerMnstr;
          }
          if (gameData.opponentMnstr != null) {
            _opponentMnstr = gameData.opponentMnstr;
          }
        });
        log(
          '[mnstr chosen] challenger mnstr set: ${_challengerMnstr?.toJson()}',
        );
        log('[mnstr chosen] opponent mnstr set: ${_opponentMnstr?.toJson()}');
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
      final data = jsonDecode(_battleQueue!.data!.data!);
      if (_isChallenger()) {
        _challengerId = _user?.id;
        _opponentId = _battleQueue!.data!.opponentId;
      } else {
        _challengerId = _battleQueue!.data!.userId;
        _opponentId = _user?.id;
      }
      _gameData = GameData.fromJson(data);
      _challengerMnstr = _gameData?.challengerMnstr;
      _opponentMnstr = _gameData?.opponentMnstr;
      _challengerMnstrs = _gameData?.challengerMnstrs;
      _opponentMnstrs = _gameData?.opponentMnstrs;
      widget.onListen(_handleMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Monster> mnstrs = [];
    if (_isChallenger()) {
      mnstrs = _challengerMnstrs ?? [];
    } else {
      mnstrs = _opponentMnstrs ?? [];
    }

    if (mnstrs.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    bool chooseMnstr = false;
    if (_isChallenger() && _challengerMnstr == null) {
      chooseMnstr = true;
    } else if (!_isChallenger() && _opponentMnstr == null) {
      chooseMnstr = true;
    }

    final waiting = (_challengerMnstr == null || _opponentMnstr == null)
        ? true
        : false;

    final size = MediaQuery.sizeOf(context);

    return chooseMnstr && mnstrs.isNotEmpty
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
                        text: 'Choose ${mnstr.mnstrName}',
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        : waiting
        ? const Center(child: Text('Waiting for opponent...'))
        : const Center(child: Text('Game time!'));
  }
}
