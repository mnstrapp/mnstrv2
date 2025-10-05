import 'dart:convert';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../providers/session_users.dart';
import '../shared/layout_scaffold.dart';
import '../shared/mnstr_list.dart';
import '../shared/monster_view.dart';
import '../shared/stat_bar_container.dart';
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
      log(
        '\tchallenger: ${battleQueue.data?.userId} != $_userId ->  ${_userId} ${battleQueue.data?.userId != _userId}',
      );
      log(
        '\topponent: ${battleQueue.data?.opponentId} != $_userId ->  ${_userId} ${battleQueue.data?.opponentId != _userId}',
      );
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
        final data = jsonDecode(battleQueue.data!.data!);
        final gameData = GameData.fromJson(data);

        setState(() {
          _gameData = gameData;
          _inBattle = true;
        });
        break;
      // case BattleQueueAction.rejoined:
      //   log('[rejoined] battleQueue: ${battleQueue.toJson()}');
      //   if (battleQueue.data?.userId == _userId ||
      //       battleQueue.data?.opponentId == _userId) {
      //     final data = jsonDecode(battleQueue.data!.data!);
      //     final gameData = GameData.fromJson(data);

      //     setState(() {
      //       _gameData = gameData;
      //       _challengerMnstr = gameData.challengerMnstr;
      //       _opponentMnstr = gameData.opponentMnstr;
      //       _choosingMnstr = false;
      //       _inBattle = true;
      //     });
      //   }
      //   break;
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

    log('[BattleVsView] choosingMnstr: $choosingMnstr');
    log('[BattleVsView] inBattle: $inBattle');

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
            challengerId: _challengerId,
            opponentId: _opponentId,
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
  final String? challengerId;
  final String? opponentId;
  final GameData gameData;
  final Function(Function(String)) onListen;
  final Function(BattleQueue) onSend;
  final Function(BattleQueue) onLog;
  final Function(Function(String)) onDispose;

  const BattleVsInGameView({
    super.key,
    required this.challengerId,
    required this.opponentId,
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

  Future<void> _setBackgroundColor() async {
    final user = ref.watch(sessionUserProvider);
    if (user.value == null) {
      return;
    }

    final isChallenger = widget.challengerId == user.value?.id;
    final theme = Theme.of(context);
    final opponentMnstr = isChallenger
        ? _gameData!.opponentMnstr
        : _gameData!.challengerMnstr;
    final color = opponentMnstr?.toMonsterModel().color ?? theme.primaryColor;
    LayoutScaffold.of(
      context,
    ).setBackgroundColor(
      Color.lerp(color, Colors.white, 0.25) ?? theme.primaryColor,
    );
  }

  void _removeStatBar() {
    LayoutScaffold.of(
      context,
    ).setShowStatBar(false);
  }

  @override
  void initState() {
    super.initState();
    _gameData = widget.gameData;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setBackgroundColor();
      _removeStatBar();
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
    final user = ref.watch(sessionUserProvider);
    if (user.value == null) {
      return const SizedBox.shrink();
    }

    final isChallenger = widget.challengerId == user.value?.id;

    final challengerMnstr = isChallenger
        ? _gameData!.challengerMnstr
        : _gameData!.opponentMnstr;
    final opponentMnstr = isChallenger
        ? _gameData!.opponentMnstr
        : _gameData!.challengerMnstr;
    final size = MediaQuery.sizeOf(context);

    log('[BattleVsInGameView] challengerMnstr: ${challengerMnstr?.toJson()}');
    log('[BattleVsInGameView] opponentMnstr: ${opponentMnstr?.toJson()}');

    final theme = Theme.of(context);
    final buttonColor = darkenColor(
      Color.lerp(
            opponentMnstr?.toMonsterModel().color ?? theme.primaryColor,
            Colors.white,
            0.25,
          ) ??
          theme.primaryColor,
      0.5,
    );

    final statBarMargin = EdgeInsets.all(16);
    final statBarPadding = EdgeInsets.only(
      left: 8,
      right: 8,
      top: 4,
      bottom: 4,
    );
    final statBarWidth =
        size.width - (statBarMargin.left + statBarMargin.right);

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: MonsterView(
            monster: opponentMnstr!.toMonsterModel(),
            monsterScale: 1.25,
            size: Size(size.width, size.height),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: StatBarContainer(
            leading: const Text('Health'),
            trailing: Text(
              '${opponentMnstr.currentHealth}/${opponentMnstr.maxHealth}',
            ),
            width: statBarWidth,
            margin: statBarMargin,
            padding: statBarPadding,
            currentValue: opponentMnstr.currentHealth!,
            totalValue: opponentMnstr.maxHealth!,
            color: opponentMnstr.toMonsterModel().color,
          ),
        ),
        Positioned(
          top: 0,
          left: -size.width * 0.4,
          right: 0,
          bottom: -size.height * 0.68,
          child: MonsterView(
            monster: challengerMnstr!.toMonsterModel(),
            size: Size(size.width, size.height),
            monsterScale: 2,
            backside: true,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: StatBarContainer(
            leading: const Text('Health'),
            trailing: Text(
              '${challengerMnstr.currentHealth}/${challengerMnstr.maxHealth}',
            ),
            width: statBarWidth,
            margin: statBarMargin,
            padding: statBarPadding,
            currentValue: challengerMnstr.currentHealth!,
            totalValue: challengerMnstr.maxHealth!,
            color: challengerMnstr.toMonsterModel().color,
          ),
        ),
        Positioned(
          right: 16,
          bottom: 70,
          child: Column(
            spacing: 24,
            children: [
              Tooltip(
                message: 'Attack',
                child: UIButton(
                  onPressed: () {},
                  icon: Symbols.swords_rounded,
                  height: 40,
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                ),
              ),
              Tooltip(
                message: 'Defend',
                child: UIButton(
                  onPressed: () {},
                  icon: Icons.shield_moon_rounded,
                  height: 40,
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                ),
              ),
              Tooltip(
                message: 'Magic',
                child: UIButton(
                  onPressed: () {},
                  icon: Symbols.magic_button_rounded,
                  height: 40,
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                ),
              ),
              Tooltip(
                message: 'Escape from battle',
                child: UIButton(
                  onPressed: () {},
                  icon: Icons.directions_run_rounded,
                  height: 40,
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                ),
              ),
              Tooltip(
                message: 'View inventory',
                child: UIButton(
                  onPressed: () {},
                  icon: Icons.shelves,
                  height: 40,
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
