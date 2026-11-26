import 'package:flutter_test/flutter_test.dart';
import 'package:mnstrv2/battle/battle_state.dart';
import 'package:mnstrv2/manage/list.dart';
import 'package:mnstrv2/models/monster.dart';
import 'package:mnstrv2/proto/battles.pb.dart' as proto;
import 'package:mnstrv2/proto/mnstr.pb.dart' as proto_mnstr;

proto.BattleStatus status(
  String userId, [
  proto.BattleStatusState state =
      proto.BattleStatusState.BATTLE_STATUS_STATE_IN_QUEUE,
]) => proto.BattleStatus(
  id: 'status-$userId',
  userId: userId,
  displayName: 'Name $userId',
  status: state,
);

proto.BattlePlayer player(String userId) =>
    proto.BattlePlayer(userId: userId, displayName: 'Name $userId');

proto_mnstr.Mnstr mnstr(String id, String userId) =>
    proto_mnstr.Mnstr(id: id, userId: userId, mnstrName: 'Mnstr $id');

proto.BattleState battle({
  bool challengerChosen = false,
  bool opponentChosen = false,
  proto.BattlePhase phase = proto.BattlePhase.BATTLE_PHASE_CHOOSING_MNSTRS,
  String turn = '',
}) => proto.BattleState(
  battleId: 'battle',
  phase: phase,
  challenger: player('me'),
  opponent: player('them'),
  challengerMnstr: challengerChosen ? mnstr('m1', 'me') : null,
  opponentMnstr: opponentChosen ? mnstr('t1', 'them') : null,
  challengerMnstrs: [mnstr('m1', 'me'), mnstr('m2', 'me')],
  opponentMnstrs: [mnstr('t1', 'them')],
  turnUserId: turn,
);

void main() {
  group('BattleStateView', () {
    test('reads the battle from each side', () {
      final state = battle(
        challengerChosen: true,
        phase: proto.BattlePhase.BATTLE_PHASE_IN_PROGRESS,
        turn: 'them',
      );
      expect(state.isChallenger('me'), isTrue);
      expect(state.isChallenger('them'), isFalse);
      expect(state.me('them').userId, 'them');
      expect(state.other('me').userId, 'them');
      expect(state.hasChosen('me'), isTrue);
      expect(state.hasChosen('them'), isFalse);
      expect(state.myMnstr('me')?.id, 'm1');
      expect(state.otherMnstr('me'), isNull);
      expect(state.otherMnstr('them')?.id, 'm1');
      expect(state.myChoices('me').map((m) => m.id), ['m1', 'm2']);
      expect(state.myChoices('them').map((m) => m.id), ['t1']);
      expect(state.isMyTurn('them'), isTrue);
      expect(state.isMyTurn('me'), isFalse);
      expect(state.isInProgress, isTrue);
      expect(state.isChoosing, isFalse);
    });
  });

  group('battle events', () {
    test('battleIdOf and battleStateOf follow the payload', () {
      final state = battle();
      final started = proto.BattleEvent(
        gameStarted: proto.GameStarted(state: state),
      );
      expect(battleIdOf(started), 'battle');
      expect(battleStateOf(started), state);

      final turn = proto.BattleEvent(
        turnTaken: proto.TurnTaken(state: state, result: proto.TurnResult()),
      );
      expect(battleIdOf(turn), 'battle');
      expect(battleStateOf(turn), state);

      final accepted = proto.BattleEvent(
        challengeAccepted: proto.ChallengeAccepted(battleId: 'b2'),
      );
      expect(battleIdOf(accepted), 'b2');
      expect(battleStateOf(accepted), isNull);

      final lobbyError = proto.BattleEvent(
        error: proto.BattleError(message: 'boom'),
      );
      expect(battleIdOf(lobbyError), isNull);
      final battleError = proto.BattleEvent(
        error: proto.BattleError(message: 'boom', battleId: 'battle'),
      );
      expect(battleIdOf(battleError), 'battle');

      final joined = proto.BattleEvent(
        playerJoined: proto.PlayerJoined(status: status('a')),
      );
      expect(battleIdOf(joined), isNull);
      expect(battleStateOf(joined), isNull);
    });
  });

  group('applyLobbyEvent', () {
    test('adds, updates and removes other players, never the caller', () {
      var lobby = <proto.BattleStatus>[];
      lobby = applyLobbyEvent(
        lobby,
        proto.BattleEvent(
          playerJoined: proto.PlayerJoined(status: status('a')),
        ),
        'me',
      );
      lobby = applyLobbyEvent(
        lobby,
        proto.BattleEvent(
          playerJoined: proto.PlayerJoined(status: status('me')),
        ),
        'me',
      );
      lobby = applyLobbyEvent(
        lobby,
        proto.BattleEvent(
          playerJoined: proto.PlayerJoined(status: status('b')),
        ),
        'me',
      );
      expect(lobby.map((s) => s.userId), ['a', 'b']);

      lobby = applyLobbyEvent(
        lobby,
        proto.BattleEvent(
          playerStatusChanged: proto.PlayerStatusChanged(
            status: status(
              'a',
              proto.BattleStatusState.BATTLE_STATUS_STATE_IN_BATTLE,
            ),
          ),
        ),
        'me',
      );
      expect(lobby.map((s) => s.userId), ['a', 'b']);
      expect(
        lobby.first.status,
        proto.BattleStatusState.BATTLE_STATUS_STATE_IN_BATTLE,
      );

      lobby = applyLobbyEvent(
        lobby,
        proto.BattleEvent(playerLeft: proto.PlayerLeft(player: player('a'))),
        'me',
      );
      expect(lobby.map((s) => s.userId), ['b']);
    });

    test('a joined player does not appear twice', () {
      final event = proto.BattleEvent(
        playerJoined: proto.PlayerJoined(status: status('a')),
      );
      final lobby = applyLobbyEvent(
        applyLobbyEvent([], event, 'me'),
        event,
        'me',
      );
      expect(lobby, hasLength(1));
    });

    test('other events leave the lobby alone', () {
      final lobby = [status('a')];
      final next = applyLobbyEvent(
        lobby,
        proto.BattleEvent(gameStarted: proto.GameStarted(state: battle())),
        'me',
      );
      expect(identical(next, lobby), isTrue);
    });
  });

  group('LobbyChallenges', () {
    proto.BattleEvent received(String id, String from) => proto.BattleEvent(
      challengeReceived: proto.ChallengeReceived(
        challengeId: id,
        challenger: player(from),
        opponent: player('me'),
      ),
    );

    test('tracks received challenges until cancelled', () {
      var challenges = const LobbyChallenges()
          .apply(received('c1', 'a'))
          .apply(received('c1', 'a'))
          .apply(received('c2', 'b'));
      expect(challenges.received.map((c) => c.challengeId), ['c1', 'c2']);
      challenges = challenges.apply(
        proto.BattleEvent(
          challengeCancelled: proto.ChallengeCancelled(challengeId: 'c1'),
        ),
      );
      expect(challenges.received.map((c) => c.challengeId), ['c2']);
      expect(
        challenges.withoutReceived('c2').received,
        isEmpty,
      );
    });

    test('clears sent challenges when answered', () {
      var challenges = const LobbyChallenges()
          .withSent('a', 's1')
          .withSent('b', 's2');
      challenges = challenges.apply(
        proto.BattleEvent(
          challengeRejected: proto.ChallengeRejected(challengeId: 's1'),
        ),
      );
      expect(challenges.sent, {'b': 's2'});
      challenges = challenges.apply(
        proto.BattleEvent(
          challengeAccepted: proto.ChallengeAccepted(challengeId: 's2'),
        ),
      );
      expect(challenges.sent, isEmpty);
      expect(
        const LobbyChallenges().withSent('a', 's1').withoutSent('a').sent,
        isEmpty,
      );
    });

    test('drops challenges with a player who left', () {
      final challenges = const LobbyChallenges()
          .withSent('a', 's1')
          .apply(received('c1', 'a'))
          .apply(received('c2', 'b'))
          .apply(
            proto.BattleEvent(
              playerLeft: proto.PlayerLeft(player: player('a')),
            ),
          );
      expect(challenges.sent, isEmpty);
      expect(challenges.received.map((c) => c.challengeId), ['c2']);
    });
  });

  group('outcomeFor', () {
    proto.TurnResult result(
      proto.BattleTurnAction action, {
      String actor = 'them',
      bool hit = true,
      int damage = 7,
    }) => proto.TurnResult(
      actorUserId: actor,
      action: action,
      hit: hit,
      missed: !hit,
      damage: hit ? damage : 0,
    );

    test('the target sees hits, misses and defends', () {
      final attack = outcomeFor(
        result(proto.BattleTurnAction.BATTLE_TURN_ACTION_ATTACK),
        'me',
      );
      expect(attack.overlay, TurnOverlay.attacked);
      expect(attack.damage, 7);

      final magic = outcomeFor(
        result(proto.BattleTurnAction.BATTLE_TURN_ACTION_MAGIC, damage: 3),
        'me',
      );
      expect(magic.overlay, TurnOverlay.magicAttacked);
      expect(magic.damage, 3);

      expect(
        outcomeFor(
          result(proto.BattleTurnAction.BATTLE_TURN_ACTION_ATTACK, hit: false),
          'me',
        ).overlay,
        TurnOverlay.defended,
      );
      expect(
        outcomeFor(
          result(proto.BattleTurnAction.BATTLE_TURN_ACTION_DEFEND, hit: false),
          'me',
        ).overlay,
        TurnOverlay.defended,
      );
    });

    test('the actor sees nothing', () {
      expect(
        outcomeFor(
          result(proto.BattleTurnAction.BATTLE_TURN_ACTION_ATTACK, actor: 'me'),
          'me',
        ).overlay,
        TurnOverlay.none,
      );
    });
  });

  test('rewardsFor picks the winner or loser rewards', () {
    final ended = proto.GameEnded(
      winnerId: 'me',
      loserId: 'them',
      winnerRewards: proto.BattleRewards(xpAwarded: 40, coinsAwarded: 10),
      loserRewards: proto.BattleRewards(xpAwarded: 20, coinsAwarded: 5),
    );
    expect(rewardsFor(ended, 'me').xpAwarded, 40);
    expect(rewardsFor(ended, 'them').coinsAwarded, 5);
  });

  group('sortMnstrs', () {
    final mnstrs = [
      Monster(id: 'a', mnstrName: 'Zap', currentLevel: 2, currentHealth: 5),
      Monster(id: 'b', mnstrName: 'alpha', currentLevel: 9),
      Monster(id: 'c', mnstrName: 'Mid', currentLevel: 2, currentHealth: 9),
    ];

    List<String?> ids(List<Monster> sorted) => sorted.map((m) => m.id).toList();

    test('sorts by name ignoring case', () {
      expect(
        ids(sortMnstrs(mnstrs, ManageOrderBy.name, ManageOrderDirection.asc)),
        ['b', 'c', 'a'],
      );
      expect(
        ids(sortMnstrs(mnstrs, ManageOrderBy.name, ManageOrderDirection.desc)),
        ['a', 'c', 'b'],
      );
    });

    test('keeps ties in their original order', () {
      expect(
        ids(sortMnstrs(mnstrs, ManageOrderBy.level, ManageOrderDirection.asc)),
        ['a', 'c', 'b'],
      );
      expect(
        ids(sortMnstrs(mnstrs, ManageOrderBy.level, ManageOrderDirection.desc)),
        ['b', 'a', 'c'],
      );
    });

    test('puts missing values last in either direction', () {
      expect(
        ids(
          sortMnstrs(mnstrs, ManageOrderBy.health, ManageOrderDirection.desc),
        ),
        ['c', 'a', 'b'],
      );
      expect(
        ids(sortMnstrs(mnstrs, ManageOrderBy.health, ManageOrderDirection.asc)),
        ['a', 'c', 'b'],
      );
    });

    test('sorts by date', () {
      final dated = [
        Monster(id: 'old', updatedAt: DateTime(2024)),
        Monster(id: 'new', updatedAt: DateTime(2026)),
      ];
      expect(
        ids(
          sortMnstrs(
            dated,
            ManageOrderBy.updatedAt,
            ManageOrderDirection.desc,
          ),
        ),
        ['new', 'old'],
      );
    });

    test('does not change the input list', () {
      final input = [...mnstrs];
      sortMnstrs(input, ManageOrderBy.name, ManageOrderDirection.asc);
      expect(ids(input), ['a', 'b', 'c']);
    });
  });
}
