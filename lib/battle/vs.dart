import 'dart:convert';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../shared/analytics.dart';

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
  final Function(GameData) onGameEnded;
  final BattleQueue? battleQueue;

  const BattleVsView({
    super.key,
    required this.onListen,
    required this.onSend,
    required this.onLog,
    required this.onDispose,
    required this.battleQueue,
    required this.onGameEnded,
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
    if (user == null) {
      return;
    }
    setState(() {
      _userId = user.id;
      _userName = user.displayName;
      _isChallenger = _battleQueue?.data?.userId == user.id;
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
      log('\n\n[handle message] not user or opponent\n\n');
      log('[handle message] userId: ${battleQueue.data?.userId} != $_userId');
      log(
        '[handle message] opponentId: ${battleQueue.data?.opponentId} != $_userId',
      );
      log('[handle message] battleQueue: ${battleQueue.toJson()}');
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
              // showName: false,
              monsters: mnstrs,
              onTap: _chooseMnstr,
              filter: (mnstr) {
                return mnstr.currentHealth != null && mnstr.currentHealth! > 0;
              },
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
            onGameEnded: widget.onGameEnded,
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
  final Function(GameData) onGameEnded;

  const BattleVsInGameView({
    super.key,
    required this.challengerId,
    required this.opponentId,
    required this.gameData,
    required this.onListen,
    required this.onSend,
    required this.onLog,
    required this.onDispose,
    required this.onGameEnded,
  });

  @override
  ConsumerState<BattleVsInGameView> createState() => _BattleVsInGameViewState();
}

class _BattleVsInGameViewState extends ConsumerState<BattleVsInGameView> {
  GameData? _gameData;
  String? _winnerId;
  bool _isLoading = false;
  String? _loadingAction;
  String? _turnUserId;

  void _handleMessage(String message) {
    final user = ref.watch(sessionUserProvider);
    if (user == null) {
      return;
    }

    final battleQueue = BattleQueue.fromJson(jsonDecode(message));
    if (battleQueue.data?.userId != widget.challengerId &&
        battleQueue.data?.userId != widget.opponentId) {
      return;
    }

    switch (battleQueue.action) {
      case BattleQueueAction.gameEnded:
        final data = jsonDecode(battleQueue.data!.data!);
        final gameData = GameData.fromJson(data);
        Wiredash.trackEvent(
          'Battle Vs In Game View Game Ended Received',
          data: {
            'displayName': user.displayName,
            'id': user.id,
            'battleId': widget.gameData.battleId,
            'winnerId': gameData.winnerId,
            'challengerId': widget.gameData.challengerMnstr?.userId,
            'challengerMnstr': widget.gameData.challengerMnstr?.id,
            'opponentId': widget.gameData.opponentMnstr?.userId,
            'opponentMnstr': widget.gameData.opponentMnstr?.id,
          },
        );
        setState(() {
          _gameData = gameData;
          _winnerId = gameData.winnerId;
          _isLoading = false;
        });
        break;
      case BattleQueueAction.attack:
        final data = jsonDecode(battleQueue.data!.data!);
        final gameData = GameData.fromJson(data);
        Wiredash.trackEvent(
          'Battle Vs In Game View Attack Received',
          data: {
            'displayName': user.displayName,
            'id': user.id,
            'battleId': widget.gameData.battleId,
            'turnUserId': gameData.turnUserId,
            'challengerMnstr': widget.gameData.challengerMnstr?.id,
            'opponentMnstr': widget.gameData.opponentMnstr?.id,
          },
        );
        setState(() {
          _gameData = gameData;
          _isLoading = false;
          _turnUserId = gameData.turnUserId;
        });
        break;
      case BattleQueueAction.defend:
        final data = jsonDecode(battleQueue.data!.data!);
        final gameData = GameData.fromJson(data);
        Wiredash.trackEvent(
          'Battle Vs In Game View Defend Received',
          data: {
            'displayName': user.displayName,
            'id': user.id,
            'battleId': widget.gameData.battleId,
            'turnUserId': gameData.turnUserId,
            'challengerMnstr': widget.gameData.challengerMnstr?.id,
            'opponentMnstr': widget.gameData.opponentMnstr?.id,
          },
        );
        setState(() {
          _gameData = gameData;
          _isLoading = false;
          _turnUserId = gameData.turnUserId;
        });
        break;
      case BattleQueueAction.magic:
        final data = jsonDecode(battleQueue.data!.data!);
        final gameData = GameData.fromJson(data);
        Wiredash.trackEvent(
          'Battle Vs In Game View Magic Received',
          data: {
            'displayName': user.displayName,
            'id': user.id,
            'battleId': widget.gameData.battleId,
            'turnUserId': gameData.turnUserId,
            'challengerMnstr': widget.gameData.challengerMnstr?.id,
            'opponentMnstr': widget.gameData.opponentMnstr?.id,
          },
        );
        setState(() {
          _gameData = gameData;
          _isLoading = false;
          _turnUserId = gameData.turnUserId;
        });
        break;
      default:
        break;
    }
  }

  void _escape() {
    final user = ref.watch(sessionUserProvider);
    if (user == null) {
      return;
    }

    Wiredash.trackEvent(
      'Battle Vs In Game View Escape',
      data: {
        'displayName': user.displayName,
        'id': user.id,
        'battleId': widget.gameData.battleId,
        'turnUserId': _turnUserId,
        'challengerId': widget.gameData.challengerMnstr?.userId,
        'challengerMnstr': widget.gameData.challengerMnstr?.id,
        'opponentId': widget.gameData.opponentMnstr?.userId,
        'opponentMnstr': widget.gameData.opponentMnstr?.id,
      },
    );

    setState(() {
      _isLoading = true;
      _loadingAction = 'Escaping from battle...';
    });

    String? winnerId;
    if (widget.gameData.opponentMnstr?.userId == user.id) {
      winnerId = widget.gameData.challengerMnstr?.userId;
    } else {
      winnerId = widget.gameData.opponentMnstr?.userId;
    }

    final gameData = GameData(
      battleId: widget.gameData.battleId,
      challengerMnstr: widget.gameData.challengerMnstr,
      opponentMnstr: widget.gameData.opponentMnstr,
      winnerId: winnerId,
    );
    final data = BattleQueueData(
      userId: user.id,
      userName: user.displayName,
      action: BattleQueueDataAction.escape,
      message: 'Escape from battle',
      data: jsonEncode(gameData.toJson()),
    );
    final battleQueue = BattleQueue(
      action: BattleQueueAction.escape,
      userId: widget.challengerId,
      data: data,
      channel: BattleQueueChannel.battle,
    );
    widget.onSend(battleQueue);
  }

  void _attack() {
    final user = ref.watch(sessionUserProvider);
    if (user == null) {
      return;
    }

    Wiredash.trackEvent(
      'Battle Vs In Game View Attack',
      data: {
        'displayName': user.displayName,
        'id': user.id,
        'battleId': widget.gameData.battleId,
        'turnUserId': _turnUserId,
        'challengerMnstr': widget.gameData.challengerMnstr?.id,
        'opponentMnstr': widget.gameData.opponentMnstr?.id,
      },
    );

    setState(() {
      _isLoading = true;
      _loadingAction = 'Attacking...';
    });

    String? turnUserId;
    if (_turnUserId != user.id) {
      turnUserId = user.id;
    } else {
      if (_turnUserId == widget.opponentId) {
        turnUserId = widget.challengerId;
      } else {
        turnUserId = widget.opponentId;
      }
    }

    final gameData = GameData(
      battleId: widget.gameData.battleId,
      challengerMnstr: _gameData!.challengerMnstr,
      opponentMnstr: _gameData!.opponentMnstr,
      turnUserId: turnUserId,
    );
    final data = BattleQueueData(
      userId: user.id,
      userName: user.displayName,
      action: BattleQueueDataAction.attack,
      message: 'Attack',
      data: jsonEncode(gameData.toJson()),
    );
    final battleQueue = BattleQueue(
      action: BattleQueueAction.attack,
      userId: widget.challengerId,
      data: data,
      channel: BattleQueueChannel.battle,
    );
    widget.onSend(battleQueue);
  }

  void _defend() {
    final user = ref.watch(sessionUserProvider);
    if (user == null) {
      return;
    }

    Wiredash.trackEvent(
      'Battle Vs In Game View Defend',
      data: {
        'displayName': user.displayName,
        'id': user.id,
        'battleId': widget.gameData.battleId,
        'turnUserId': _turnUserId,
        'challengerMnstr': widget.gameData.challengerMnstr?.id,
        'opponentMnstr': widget.gameData.opponentMnstr?.id,
      },
    );

    setState(() {
      _isLoading = true;
      _loadingAction = 'Defending...';
    });

    String? turnUserId;
    if (_turnUserId != user.id) {
      turnUserId = user.id;
    } else {
      if (_turnUserId == widget.opponentId) {
        turnUserId = widget.challengerId;
      } else {
        turnUserId = widget.opponentId;
      }
    }

    final gameData = GameData(
      battleId: widget.gameData.battleId,
      challengerMnstr: _gameData!.challengerMnstr,
      opponentMnstr: _gameData!.opponentMnstr,
      turnUserId: turnUserId,
    );
    final data = BattleQueueData(
      userId: user.id,
      userName: user.displayName,
      action: BattleQueueDataAction.defend,
      message: 'Defend',
      data: jsonEncode(gameData.toJson()),
    );
    final battleQueue = BattleQueue(
      action: BattleQueueAction.defend,
      userId: widget.challengerId,
      data: data,
      channel: BattleQueueChannel.battle,
    );
    widget.onSend(battleQueue);
  }

  void _magic() {
    final user = ref.watch(sessionUserProvider);
    if (user == null) {
      return;
    }

    Wiredash.trackEvent(
      'Battle Vs In Game View Magic',
      data: {
        'displayName': user.displayName,
        'id': user.id,
        'battleId': widget.gameData.battleId,
        'turnUserId': _turnUserId,
        'challengerMnstr': widget.gameData.challengerMnstr?.id,
        'opponentMnstr': widget.gameData.opponentMnstr?.id,
      },
    );

    setState(() {
      _isLoading = true;
      _loadingAction = 'Magic...';
    });

    String? turnUserId;
    if (_turnUserId != user.id) {
      turnUserId = user.id;
    } else {
      if (_turnUserId == widget.opponentId) {
        turnUserId = widget.challengerId;
      } else {
        turnUserId = widget.opponentId;
      }
    }

    final gameData = GameData(
      battleId: widget.gameData.battleId,
      challengerMnstr: _gameData!.challengerMnstr,
      opponentMnstr: _gameData!.opponentMnstr,
      turnUserId: turnUserId,
    );

    final data = BattleQueueData(
      userId: user.id,
      userName: user.displayName,
      action: BattleQueueDataAction.magic,
      message: 'Magic',
      data: jsonEncode(gameData.toJson()),
    );

    final battleQueue = BattleQueue(
      action: BattleQueueAction.magic,
      userId: widget.challengerId,
      data: data,
      channel: BattleQueueChannel.battle,
    );
    widget.onSend(battleQueue);
  }

  Future<void> _setBackgroundColor() async {
    final user = ref.watch(sessionUserProvider);
    if (user == null) {
      return;
    }

    final isChallenger = widget.challengerId == user.id;
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
    _turnUserId = widget.gameData.turnUserId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setBackgroundColor();
      _removeStatBar();
      widget.onListen(_handleMessage);
      final user = ref.watch(sessionUserProvider);
      Wiredash.trackEvent(
        'Battle Vs In Game View',
        data: {
          'displayName': user?.displayName,
          'id': user?.id,
          'battleId': widget.gameData.battleId,
          'turnUserId': _turnUserId,
          'challengerMnstr': widget.gameData.challengerMnstr?.id,
          'opponentMnstr': widget.gameData.opponentMnstr?.id,
        },
      );
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
    if (user == null) {
      return const SizedBox.shrink();
    }

    final isChallenger = widget.challengerId == user.id;

    final challengerMnstr = isChallenger
        ? _gameData!.challengerMnstr
        : _gameData!.opponentMnstr;
    final opponentMnstr = isChallenger
        ? _gameData!.opponentMnstr
        : _gameData!.challengerMnstr;
    final size = MediaQuery.sizeOf(context);

    final theme = Theme.of(context);
    final buttonColor = darkenColor(
      Color.lerp(
            challengerMnstr?.toMonsterModel().color ?? theme.primaryColor,
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

    final winnerMnstr = _winnerId == user.id ? challengerMnstr : opponentMnstr;

    final loserMnstr = _winnerId == user.id ? opponentMnstr : challengerMnstr;

    final xpAwarded = _winnerId == user.id
        ? _gameData!.winnerXpAwarded
        : _gameData!.loserXpAwarded;

    final coinsAwarded = _winnerId == user.id
        ? _gameData!.winnerCoinsAwarded
        : _gameData!.loserCoinsAwarded;

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
          child: SafeArea(
            child: _StatsBar(
              monster: opponentMnstr,
              position: _StatsBarPosition.bottom,
              width: statBarWidth,
              margin: statBarMargin,
              padding: statBarPadding,
            ),
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
            monsterScale: 2.5,
            backside: true,
          ),
        ),

        if (_turnUserId == user.id)
          Positioned(
            right: 16,
            bottom: 70,
            child: Column(
              spacing: 24,
              children: [
                Tooltip(
                  message: 'Attack',
                  child: UIButton(
                    onPressed: _attack,
                    icon: Symbols.swords_rounded,
                    height: 40,
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                  ),
                ),
                Tooltip(
                  message: 'Magic',
                  child: UIButton(
                    onPressed: _magic,
                    icon: Symbols.magic_button_rounded,
                    height: 40,
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                  ),
                ),
                Tooltip(
                  message: 'Defend',
                  child: UIButton(
                    onPressed: _defend,
                    icon: Icons.shield_moon_rounded,
                    height: 40,
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                  ),
                ),
                Tooltip(
                  message: 'Escape from battle',
                  child: UIButton(
                    onPressed: _escape,
                    icon: Icons.directions_run_rounded,
                    height: 40,
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        Positioned(
          bottom: 0,
          left: 0,
          child: _StatsBar(
            monster: challengerMnstr,
            position: _StatsBarPosition.top,
            width: statBarWidth,
            margin: statBarMargin,
            padding: statBarPadding,
          ),
        ),
        if (_winnerId != null)
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 16,
                    children: [
                      if (_winnerId == user.id) ...[
                        Text(
                          'You defeated',
                          style: theme.textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          loserMnstr?.mnstrName ?? 'your opponent',
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                      if (_winnerId != user.id) ...[
                        Text(
                          'You were defeated by',
                          style: theme.textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          winnerMnstr?.mnstrName ?? 'your opponent',
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                      Text(
                        '+ $xpAwarded XP',
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: Colors.yellow,
                        ),
                      ),
                      Row(
                        spacing: 8,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '+ $coinsAwarded',
                            style: theme.textTheme.displayLarge?.copyWith(
                              color: Colors.yellow,
                            ),
                          ),
                          Image.asset(
                            'assets/items/coin.png',
                            width: 60,
                            height: 60,
                          ),
                        ],
                      ),
                      UIButton(
                        onPressed: () {
                          widget.onGameEnded(_gameData!);
                        },
                        icon: Symbols.social_leaderboard_rounded,
                        height: 40,
                        text: 'exit battle',
                        backgroundColor: buttonColor,
                        foregroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        if (_isLoading)
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16,
                  children: [
                    Text(
                      _loadingAction ?? 'Processing...',
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    CircularProgressIndicator(
                      color: buttonColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

enum _StatsBarPosition {
  top,
  bottom,
}

class _StatsBar extends StatefulWidget {
  final Monster monster;
  final _StatsBarPosition position;
  final double width;
  final EdgeInsets margin;
  final EdgeInsets padding;

  const _StatsBar({
    required this.monster,
    required this.position,
    required this.width,
    required this.margin,
    required this.padding,
  });

  @override
  State<_StatsBar> createState() => _StatsBarState();
}

class _StatsBarState extends State<_StatsBar> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
      child: Container(
        margin: widget.margin,
        decoration: BoxDecoration(
          color: darkenColor(
            Color.lerp(
                  widget.monster.toMonsterModel().color ?? theme.primaryColor,
                  Colors.white,
                  0.25,
                ) ??
                theme.primaryColor,
            0.5,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            if (_expanded && widget.position == _StatsBarPosition.top)
              _StatsBarContainer(
                monster: widget.monster,
                width: widget.width,
              ),
            Container(
              width: widget.width,
              decoration: BoxDecoration(
                color: Color.lerp(
                  widget.monster.toMonsterModel().color ?? theme.primaryColor,
                  Colors.white,
                  0.5,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  UIButton(
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                    icon: widget.position == _StatsBarPosition.bottom
                        ? _expanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded
                        : _expanded
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_up_rounded,
                    height: 32,
                    margin: 0,
                    padding: 0,
                    backgroundColor: darkenColor(
                      Color.lerp(
                            widget.monster.toMonsterModel().color ??
                                theme.primaryColor,
                            Colors.white,
                            0.25,
                          ) ??
                          theme.primaryColor,
                      0.5,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  Expanded(
                    child: StatBarContainer(
                      leading: const Icon(Symbols.health_metrics_rounded),
                      trailing: Text(
                        '${widget.monster.currentHealth}/${widget.monster.maxHealth}',
                      ),
                      padding: widget.padding,
                      currentValue: widget.monster.currentHealth!,
                      totalValue: widget.monster.maxHealth!,
                      color: widget.monster.toMonsterModel().color,
                    ),
                  ),
                ],
              ),
            ),
            if (_expanded && widget.position == _StatsBarPosition.bottom)
              _StatsBarContainer(
                monster: widget.monster,
                width: widget.width,
              ),
          ],
        ),
      ),
    );
  }
}

class _StatsBarContainer extends StatelessWidget {
  final Monster monster;
  final double width;

  const _StatsBarContainer({
    required this.monster,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.all(8);
    return Container(
      padding: padding,
      width: width,
      child: Column(
        spacing: 8,
        children: [
          StatBarContainer(
            leading: const Icon(Symbols.swords_rounded),
            trailing: Text(
              '${monster.currentAttack}/${monster.maxAttack}',
            ),
            currentValue: monster.currentAttack!,
            totalValue: monster.maxAttack!,
            color: monster.toMonsterModel().color,
            width: width - padding.horizontal,
          ),
          StatBarContainer(
            leading: const Icon(Symbols.shield_moon_rounded),
            trailing: Text(
              '${monster.currentDefense}/${monster.maxDefense}',
            ),
            currentValue: monster.currentDefense!,
            totalValue: monster.maxDefense!,
            color: monster.toMonsterModel().color,
            width: width - padding.horizontal,
          ),
          StatBarContainer(
            leading: const Icon(Symbols.psychology_rounded),
            trailing: Text(
              '${monster.currentIntelligence}/${monster.maxIntelligence}',
            ),
            currentValue: monster.currentIntelligence!,
            totalValue: monster.maxIntelligence!,
            color: monster.toMonsterModel().color,
            width: width - padding.horizontal,
          ),
          StatBarContainer(
            leading: const Icon(Symbols.speed_rounded),
            trailing: Text(
              '${monster.currentSpeed}/${monster.maxSpeed}',
            ),
            currentValue: monster.currentSpeed!,
            totalValue: monster.maxSpeed!,
            color: monster.toMonsterModel().color,
            width: width - padding.horizontal,
          ),
          StatBarContainer(
            leading: const Icon(Symbols.magic_button_rounded),
            trailing: Text(
              '${monster.currentMagic}/${monster.maxMagic}',
            ),
            currentValue: monster.currentMagic!,
            totalValue: monster.maxMagic!,
            color: monster.toMonsterModel().color,
            width: width - padding.horizontal,
          ),
        ],
      ),
    );
  }
}
