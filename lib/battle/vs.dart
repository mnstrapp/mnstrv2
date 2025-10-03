import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../providers/session_users.dart';
import '../shared/mnstr_list.dart';
import '../ui/button.dart';
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

  Future<void> _initUser() async {
    final user = await getSessionUser();
    setState(() {
      _user = user;
    });
  }

  bool _isChallenger() {
    return widget.battleQueue!.data?.userId == _user?.id;
  }

  void _chooseMnstr(Monster mnstr) {
    setState(() {
      if (_isChallenger()) {
        _challengerMnstr = mnstr;
      } else {
        _opponentMnstr = mnstr;
      }
    });
    _buildBattleQueue();
  }

  BattleQueue _buildBattleQueue() {
    final data = BattleQueueData(
      action: BattleQueueDataAction.mnstrChosen,
      userId: _isChallenger()
          ? _user?.id
          : widget.battleQueue!.data?.opponentId,
      userName: _isChallenger()
          ? _user?.displayName
          : widget.battleQueue!.data?.opponentName,
      opponentId: !_isChallenger()
          ? widget.battleQueue!.data?.opponentId
          : _user?.id,
      opponentName: !_isChallenger()
          ? widget.battleQueue!.data?.opponentName
          : _user?.displayName,
      userMnstrId: _isChallenger()
          ? _challengerMnstr?.id
          : widget.battleQueue!.data?.userMnstrId,
      opponentMnstrId: !_isChallenger()
          ? _opponentMnstr?.id
          : widget.battleQueue!.data?.opponentMnstrId,
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initUser();
      final data = jsonDecode(widget.battleQueue!.data!.data!);
      if (_isChallenger()) {
        _challengerId = _user?.id;
        _opponentId = widget.battleQueue!.data?.opponentId;
      } else {
        _challengerId = widget.battleQueue!.data?.userId;
        _opponentId = _user?.id;
      }
      _gameData = GameData.fromJson(data);
      _challengerMnstr = _gameData?.challengerMnstr;
      _opponentMnstr = _gameData?.opponentMnstr;
      _challengerMnstrs = _gameData?.challengerMnstrs;
      _opponentMnstrs = _gameData?.opponentMnstrs;
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
            height: size.height - 96,
            width: size.width - 32,
            child: MnstrList(
              showName: false,
              monsters: mnstrs,
              onTap: _chooseMnstr,
              overlayBuilder: (mnstr) {
                return UIButton(
                  height: 40,
                  onPressed: () {
                    _chooseMnstr(mnstr);
                  },
                  icon: Icons.play_arrow_rounded,
                  backgroundColor: Colors.green,
                );
              },
              overlayPositioning: const EdgeInsets.only(
                bottom: 16,
                left: 16,
                right: 16,
              ),
            ),
          )
        : waiting
        ? const Center(child: Text('Waiting for opponent...'))
        : const Center(child: Text('Game time!'));
  }
}
