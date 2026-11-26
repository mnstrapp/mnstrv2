import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../manage/list.dart';
import '../models/monster.dart';
import '../providers/battle.dart';
import '../providers/manage.dart';
import '../providers/session_users.dart';
import '../proto/battles.pb.dart' as proto;
import '../shared/layout_scaffold.dart';
import '../shared/mnstr_list.dart';
import '../shared/monster_view.dart';
import '../shared/stat_bar_container.dart';
import '../ui/button.dart';
import '../utils/color.dart';
import 'battle_state.dart';

/// One battle, from choosing a mnstr to the result screen.
///
/// All battle state comes from the server: the [initialState] the battle
/// started with, then the state carried by each event and action response.
class BattleVsView extends ConsumerStatefulWidget {
  final BattleClient client;
  final proto.BattleState initialState;
  final VoidCallback onGameEnded;

  const BattleVsView({
    super.key,
    required this.client,
    required this.initialState,
    required this.onGameEnded,
  });

  @override
  ConsumerState<BattleVsView> createState() => _BattleVsViewState();
}

class _BattleVsViewState extends ConsumerState<BattleVsView> {
  late proto.BattleState _state;
  List<Monster> _choices = [];
  bool _choosingMnstr = true;
  ManageOrder? _order;
  TurnOutcome _outcome = TurnOutcome.none;
  proto.GameEnded? _gameEnded;
  String? _busyMessage;
  StreamSubscription<proto.BattleEvent>? _events;

  BattleClient get _client => widget.client;

  String? get _userId => ref.read(sessionUserProvider)?.id;

  String get _battleId => _state.battleId;

  void _showError(Object error) {
    if (!mounted) {
      return;
    }
    final message = error is BattleException
        ? error.message
        : 'Something went wrong. Please try again.';
    LayoutScaffold.addError(context, message);
  }

  void _applyState(proto.BattleState state) {
    final userId = _userId;
    if (userId == null || state.battleId != _battleId) {
      return;
    }
    _state = state;
    final choices = state.myChoices(userId);
    if (choices.isNotEmpty) {
      _choices = _sorted(choices);
    }
    if (state.hasChosen(userId)) {
      _choosingMnstr = false;
    }
  }

  void _applyGameEnded(proto.GameEnded ended) {
    if (ended.state.battleId != _battleId) {
      return;
    }
    _applyState(ended.state);
    _gameEnded = ended;
    _busyMessage = null;
    _outcome = TurnOutcome.none;
  }

  void _handleEvent(proto.BattleEvent event) {
    final userId = _userId;
    if (!mounted || userId == null || battleIdOf(event) != _battleId) {
      return;
    }
    setState(() {
      switch (event.whichPayload()) {
        case proto.BattleEvent_Payload.turnTaken:
          _applyState(event.turnTaken.state);
          _outcome = outcomeFor(event.turnTaken.result, userId);
          if (event.turnTaken.result.actorUserId == userId) {
            _busyMessage = null;
          }
          break;
        case proto.BattleEvent_Payload.gameEnded:
          _applyGameEnded(event.gameEnded);
          break;
        case proto.BattleEvent_Payload.error:
          _busyMessage = null;
          LayoutScaffold.addError(context, event.error.message);
          break;
        default:
          final state = battleStateOf(event);
          if (state != null) {
            _applyState(state);
          }
      }
    });
  }

  List<Monster> _sorted(List<Monster> mnstrs) {
    final ManageOrder order = _order ?? ref.read(manageOrderProvider);
    return sortMnstrs(mnstrs, order.orderBy, order.orderDirection);
  }

  Future<void> _chooseMnstr(Monster mnstr) async {
    final mnstrId = mnstr.id;
    if (mnstrId == null) {
      return;
    }
    setState(() {
      _choosingMnstr = false;
    });
    try {
      final state = await _client.chooseMnstr(
        battleId: _battleId,
        mnstrId: mnstrId,
      );
      if (mounted) {
        setState(() => _applyState(state));
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _choosingMnstr = true;
        });
      }
      _showError(error);
    }
  }

  Future<void> _turn(
    String busyMessage,
    Future<proto.TurnResponse> Function(String battleId) action,
  ) async {
    setState(() {
      _busyMessage = busyMessage;
      _outcome = TurnOutcome.none;
    });
    try {
      final response = await action(_battleId);
      if (!mounted) {
        return;
      }
      setState(() {
        _applyState(response.state);
        if (response.hasGameEnded()) {
          _applyGameEnded(response.gameEnded);
        }
        _busyMessage = null;
      });
    } catch (error) {
      if (mounted) {
        setState(() {
          _busyMessage = null;
        });
      }
      _showError(error);
    }
  }

  Future<void> _attack() => _turn('Attacking...', _client.attack);

  Future<void> _defend() => _turn('Defending...', _client.defend);

  Future<void> _magic() => _turn('Magic...', _client.magic);

  Future<void> _escape() async {
    setState(() {
      _busyMessage = 'Escaping from battle...';
    });
    try {
      final ended = await _client.escape(_battleId);
      if (mounted) {
        setState(() => _applyGameEnded(ended));
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _busyMessage = null;
        });
      }
      _showError(error);
    }
  }

  /// Sorts the mnstrs to choose from on the client, and remembers the order
  /// for the manage screen too.
  void _setOrder({
    required ManageOrderBy orderBy,
    required ManageOrderDirection orderDirection,
  }) {
    ref
        .read(manageOrderProvider.notifier)
        .set(
          orderBy: orderBy,
          orderDirection: orderDirection,
        );
    setState(() {
      _order = ref.read(manageOrderProvider);
      _choices = _sorted(_choices);
    });
  }

  @override
  void initState() {
    super.initState();
    _state = widget.initialState;
    _order = ref.read(manageOrderProvider);
    final userId = _userId;
    if (userId != null) {
      _choices = _sorted(_state.myChoices(userId));
      _choosingMnstr = !_state.hasChosen(userId);
    }
    _events = _client.events.listen(_handleEvent);
  }

  @override
  void dispose() {
    _events?.cancel();
    super.dispose();
  }

  Widget _endedWithoutFight(BuildContext context, proto.GameEnded ended) {
    final theme = Theme.of(context);
    final won = ended.winnerId == _userId;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Text(
            won ? 'Your opponent ran away' : 'You ran away',
            style: theme.textTheme.displaySmall?.copyWith(
              color: Colors.white,
            ),
          ),
          UIButton(
            onPressed: widget.onGameEnded,
            icon: Symbols.social_leaderboard_rounded,
            text: 'exit battle',
          ),
        ],
      ),
    );
  }

  Widget _waiting(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Text(
            'Waiting for opponent...',
            style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
          UIButton(
            onPressedAsync: _escape,
            icon: Icons.directions_run_rounded,
            text: 'Run away',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(sessionUserProvider)?.id;
    if (userId == null) {
      return const SizedBox.shrink();
    }

    final gameEnded = _gameEnded;
    final myMnstr = _state.myMnstr(userId);
    final otherMnstr = _state.otherMnstr(userId);
    final bothChosen = myMnstr != null && otherMnstr != null;

    if (gameEnded != null && !bothChosen) {
      return _endedWithoutFight(context, gameEnded);
    }

    if (bothChosen && (_state.isInProgress || gameEnded != null)) {
      return BattleVsInGameView(
        userId: userId,
        state: _state,
        myMnstr: myMnstr,
        otherMnstr: otherMnstr,
        outcome: _outcome,
        gameEnded: gameEnded,
        busyMessage: _busyMessage,
        onAttack: _attack,
        onMagic: _magic,
        onDefend: _defend,
        onEscape: _escape,
        onExit: widget.onGameEnded,
      );
    }

    final mnstrs = _choices;
    final choosingMnstr = _choosingMnstr;

    if (!choosingMnstr || mnstrs.isEmpty) {
      return _waiting(context);
    }

    final size = MediaQuery.sizeOf(context);

    final inputDecorationTheme = InputDecorationTheme(
      fillColor: Colors.white.withValues(alpha: 0.5),
      filled: true,
      contentPadding: const EdgeInsets.only(left: 16, right: 16),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
    );

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          MnstrList(
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
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                  ),
                  child: Row(
                    spacing: 8,
                    children: [
                      Icon(Icons.sort_rounded),
                      DropdownMenu(
                        inputDecorationTheme: inputDecorationTheme,
                        dropdownMenuEntries: ManageOrderBy.values
                            .map(
                              (e) => DropdownMenuEntry(
                                value: e,
                                label: e.name,
                              ),
                            )
                            .toList(),
                        enableFilter: true,
                        initialSelection:
                            _order?.orderBy ?? ManageOrderBy.updatedAt,
                        onSelected: (value) {
                          _setOrder(
                            orderBy: value ?? ManageOrderBy.updatedAt,
                            orderDirection:
                                _order?.orderDirection ??
                                ManageOrderDirection.desc,
                          );
                        },
                      ),
                      DropdownMenu(
                        inputDecorationTheme: inputDecorationTheme,
                        dropdownMenuEntries: ManageOrderDirection.values
                            .map(
                              (e) => DropdownMenuEntry(
                                value: e,
                                label: e.name,
                              ),
                            )
                            .toList(),
                        enableFilter: true,
                        initialSelection:
                            _order?.orderDirection ?? ManageOrderDirection.desc,
                        onSelected: (value) {
                          _setOrder(
                            orderBy: _order?.orderBy ?? ManageOrderBy.updatedAt,
                            orderDirection: value ?? ManageOrderDirection.desc,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BattleVsInGameView extends StatefulWidget {
  final String userId;
  final proto.BattleState state;
  final Monster myMnstr;
  final Monster otherMnstr;
  final TurnOutcome outcome;
  final proto.GameEnded? gameEnded;
  final String? busyMessage;
  final Future<void> Function() onAttack;
  final Future<void> Function() onMagic;
  final Future<void> Function() onDefend;
  final Future<void> Function() onEscape;
  final VoidCallback onExit;

  const BattleVsInGameView({
    super.key,
    required this.userId,
    required this.state,
    required this.myMnstr,
    required this.otherMnstr,
    required this.outcome,
    required this.gameEnded,
    required this.busyMessage,
    required this.onAttack,
    required this.onMagic,
    required this.onDefend,
    required this.onEscape,
    required this.onExit,
  });

  @override
  State<BattleVsInGameView> createState() => _BattleVsInGameViewState();
}

class _BattleVsInGameViewState extends State<BattleVsInGameView> {
  void _setBackgroundColor() {
    final theme = Theme.of(context);
    final color =
        widget.otherMnstr.toMonsterModel().color ?? theme.primaryColor;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _setBackgroundColor();
      _removeStatBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final challengerMnstr = widget.myMnstr;
    final opponentMnstr = widget.otherMnstr;
    final gameEnded = widget.gameEnded;
    final won = gameEnded?.winnerId == widget.userId;
    final isMyTurn =
        gameEnded == null &&
        widget.busyMessage == null &&
        widget.state.isMyTurn(widget.userId);
    final outcome = widget.outcome;
    final size = MediaQuery.sizeOf(context);

    final theme = Theme.of(context);
    final buttonColor = darkenColor(
      Color.lerp(
            challengerMnstr.toMonsterModel().color ?? theme.primaryColor,
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

    final winnerMnstr = won ? challengerMnstr : opponentMnstr;

    final loserMnstr = won ? opponentMnstr : challengerMnstr;

    final rewards = gameEnded == null
        ? null
        : rewardsFor(gameEnded, widget.userId);
    final xpAwarded = rewards?.xpAwarded ?? 0;
    final coinsAwarded = rewards?.coinsAwarded ?? 0;

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: MonsterView(
            monster: opponentMnstr.toMonsterModel(),
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
            monster: challengerMnstr.toMonsterModel(),
            size: Size(size.width, size.height),
            monsterScale: 2.5,
            backside: true,
          ),
        ),

        if (isMyTurn)
          Positioned(
            right: 16,
            bottom: 70,
            child: Column(
              spacing: 24,
              children: [
                Tooltip(
                  message: 'Attack',
                  child: UIButton(
                    onPressedAsync: widget.onAttack,
                    icon: Symbols.swords_rounded,
                    height: 40,
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                  ),
                ),
                Tooltip(
                  message: 'Magic',
                  child: UIButton(
                    onPressedAsync: widget.onMagic,
                    icon: Symbols.magic_button_rounded,
                    height: 40,
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                  ),
                ),
                Tooltip(
                  message: 'Defend',
                  child: UIButton(
                    onPressedAsync: widget.onDefend,
                    icon: Icons.shield_moon_rounded,
                    height: 40,
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                  ),
                ),
                Tooltip(
                  message: 'Escape from battle',
                  child: UIButton(
                    onPressedAsync: widget.onEscape,
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
        if (gameEnded != null)
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
                      if (won) ...[
                        Text(
                          'You defeated',
                          style: theme.textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          loserMnstr.mnstrName ?? 'your opponent',
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                      if (!won) ...[
                        Text(
                          'You were defeated by',
                          style: theme.textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          winnerMnstr.mnstrName ?? 'your opponent',
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
                          widget.onExit();
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
        if (outcome.overlay == TurnOverlay.attacked)
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16,
                  children: [
                    Image.asset(
                      'assets/environment/slash.png',
                      width: size.width * 0.8,
                      height: size.width * 0.8,
                    ),
                    Text(
                      '-${outcome.damage}',
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (outcome.overlay == TurnOverlay.defended)
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16,
                  children: [
                    Image.asset(
                      'assets/environment/shield.png',
                      width: size.width * 0.8,
                      height: size.width * 0.8,
                    ),
                    Text(
                      'Defended',
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (outcome.overlay == TurnOverlay.magicAttacked)
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
                    Image.asset(
                      'assets/environment/slash.png',
                      width: 60,
                      height: 60,
                    ),
                    Text(
                      '-${outcome.damage}',
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (widget.busyMessage != null)
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
                      widget.busyMessage!,
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
