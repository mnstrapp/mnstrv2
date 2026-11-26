import '../manage/list.dart' show ManageOrderBy, ManageOrderDirection;
import '../models/monster.dart';
import '../proto/battles.pb.dart' as proto;

/// Reads a [proto.BattleState] from one player's point of view.
extension BattleStateView on proto.BattleState {
  bool isChallenger(String userId) => challenger.userId == userId;

  proto.BattlePlayer me(String userId) =>
      isChallenger(userId) ? challenger : opponent;

  proto.BattlePlayer other(String userId) =>
      isChallenger(userId) ? opponent : challenger;

  bool hasChosen(String userId) =>
      isChallenger(userId) ? hasChallengerMnstr() : hasOpponentMnstr();

  Monster? myMnstr(String userId) {
    if (!hasChosen(userId)) {
      return null;
    }
    return Monster.fromProto(
      isChallenger(userId) ? challengerMnstr : opponentMnstr,
    );
  }

  Monster? otherMnstr(String userId) {
    final otherHasChosen = isChallenger(userId)
        ? hasOpponentMnstr()
        : hasChallengerMnstr();
    if (!otherHasChosen) {
      return null;
    }
    return Monster.fromProto(
      isChallenger(userId) ? opponentMnstr : challengerMnstr,
    );
  }

  /// The caller's mnstrs to choose from. Only sent while choosing.
  List<Monster> myChoices(String userId) =>
      (isChallenger(userId) ? challengerMnstrs : opponentMnstrs)
          .map(Monster.fromProto)
          .toList();

  bool isMyTurn(String userId) => turnUserId == userId;

  bool get isChoosing =>
      phase == proto.BattlePhase.BATTLE_PHASE_CHOOSING_MNSTRS;

  bool get isInProgress => phase == proto.BattlePhase.BATTLE_PHASE_IN_PROGRESS;

  bool get isEnded => phase == proto.BattlePhase.BATTLE_PHASE_ENDED;
}

/// The battle a lobby or battle event belongs to, if any.
String? battleIdOf(proto.BattleEvent event) => switch (event.whichPayload()) {
  proto.BattleEvent_Payload.gameStarted => event.gameStarted.state.battleId,
  proto.BattleEvent_Payload.mnstrChosen => event.mnstrChosen.state.battleId,
  proto.BattleEvent_Payload.turnTaken => event.turnTaken.state.battleId,
  proto.BattleEvent_Payload.gameEnded => event.gameEnded.state.battleId,
  proto.BattleEvent_Payload.rejoined => event.rejoined.state.battleId,
  proto.BattleEvent_Payload.challengeAccepted =>
    event.challengeAccepted.battleId,
  proto.BattleEvent_Payload.error when event.error.hasBattleId() =>
    event.error.battleId,
  _ => null,
};

/// The new battle state carried by [event], if it carries one.
proto.BattleState? battleStateOf(proto.BattleEvent event) =>
    switch (event.whichPayload()) {
      proto.BattleEvent_Payload.gameStarted => event.gameStarted.state,
      proto.BattleEvent_Payload.mnstrChosen => event.mnstrChosen.state,
      proto.BattleEvent_Payload.turnTaken => event.turnTaken.state,
      proto.BattleEvent_Payload.gameEnded => event.gameEnded.state,
      proto.BattleEvent_Payload.rejoined => event.rejoined.state,
      _ => null,
    };

/// Applies a lobby presence event to the list of other players.
List<proto.BattleStatus> applyLobbyEvent(
  List<proto.BattleStatus> lobby,
  proto.BattleEvent event,
  String selfId,
) {
  switch (event.whichPayload()) {
    case proto.BattleEvent_Payload.playerJoined:
      return _upsertStatus(lobby, event.playerJoined.status, selfId);
    case proto.BattleEvent_Payload.playerStatusChanged:
      return _upsertStatus(lobby, event.playerStatusChanged.status, selfId);
    case proto.BattleEvent_Payload.playerLeft:
      final userId = event.playerLeft.player.userId;
      return lobby.where((status) => status.userId != userId).toList();
    default:
      return lobby;
  }
}

List<proto.BattleStatus> _upsertStatus(
  List<proto.BattleStatus> lobby,
  proto.BattleStatus status,
  String selfId,
) {
  if (status.userId.isEmpty || status.userId == selfId) {
    return lobby;
  }
  final index = lobby.indexWhere((s) => s.userId == status.userId);
  if (index == -1) {
    return [...lobby, status];
  }
  return [...lobby]..[index] = status;
}

/// Challenges the player has received and sent while in the lobby.
class LobbyChallenges {
  /// Challenges waiting for the player's answer, oldest first.
  final List<proto.ChallengeReceived> received;

  /// Challenges the player sent: opponent id to challenge id.
  final Map<String, String> sent;

  const LobbyChallenges({this.received = const [], this.sent = const {}});

  LobbyChallenges withSent(String opponentId, String challengeId) =>
      LobbyChallenges(
        received: received,
        sent: {...sent, opponentId: challengeId},
      );

  LobbyChallenges withoutSent(String opponentId) => LobbyChallenges(
    received: received,
    sent: {...sent}..remove(opponentId),
  );

  LobbyChallenges withoutReceived(String challengeId) => LobbyChallenges(
    received: received.where((c) => c.challengeId != challengeId).toList(),
    sent: sent,
  );

  LobbyChallenges _withoutSentId(String challengeId) => LobbyChallenges(
    received: received,
    sent: {...sent}..removeWhere((_, id) => id == challengeId),
  );

  LobbyChallenges apply(proto.BattleEvent event) {
    switch (event.whichPayload()) {
      case proto.BattleEvent_Payload.challengeReceived:
        final challenge = event.challengeReceived;
        if (received.any((c) => c.challengeId == challenge.challengeId)) {
          return this;
        }
        return LobbyChallenges(received: [...received, challenge], sent: sent);
      case proto.BattleEvent_Payload.challengeCancelled:
        return withoutReceived(event.challengeCancelled.challengeId);
      case proto.BattleEvent_Payload.challengeRejected:
        return _withoutSentId(event.challengeRejected.challengeId);
      case proto.BattleEvent_Payload.challengeAccepted:
        return _withoutSentId(event.challengeAccepted.challengeId);
      case proto.BattleEvent_Payload.playerLeft:
        final userId = event.playerLeft.player.userId;
        return LobbyChallenges(
          received: received
              .where((c) => c.challenger.userId != userId)
              .toList(),
          sent: {...sent}..remove(userId),
        );
      default:
        return this;
    }
  }
}

/// What a turn looks like to one player.
enum TurnOverlay { none, attacked, magicAttacked, defended }

class TurnOutcome {
  final TurnOverlay overlay;
  final int damage;

  const TurnOutcome(this.overlay, [this.damage = 0]);

  static const none = TurnOutcome(TurnOverlay.none);
}

/// The overlay to show [userId] after [result]. Only the player on the
/// receiving end of a turn sees one, as in the original battle screen.
TurnOutcome outcomeFor(proto.TurnResult result, String userId) {
  if (result.actorUserId == userId) {
    return TurnOutcome.none;
  }
  return switch (result.action) {
    proto.BattleTurnAction.BATTLE_TURN_ACTION_ATTACK =>
      result.hit
          ? TurnOutcome(TurnOverlay.attacked, result.damage)
          : const TurnOutcome(TurnOverlay.defended),
    proto.BattleTurnAction.BATTLE_TURN_ACTION_MAGIC =>
      result.hit
          ? TurnOutcome(TurnOverlay.magicAttacked, result.damage)
          : const TurnOutcome(TurnOverlay.defended),
    proto.BattleTurnAction.BATTLE_TURN_ACTION_DEFEND => const TurnOutcome(
      TurnOverlay.defended,
    ),
    _ => TurnOutcome.none,
  };
}

/// The rewards [userId] got from [ended].
proto.BattleRewards rewardsFor(proto.GameEnded ended, String userId) =>
    ended.winnerId == userId ? ended.winnerRewards : ended.loserRewards;

/// Sorts mnstrs on the client, like the manage screen's order. Mnstrs
/// without a value for the chosen field go last; ties keep their order.
List<Monster> sortMnstrs(
  List<Monster> mnstrs,
  ManageOrderBy orderBy,
  ManageOrderDirection orderDirection,
) {
  Comparable<Object>? valueOf(Monster mnstr) =>
      switch (orderBy) {
            ManageOrderBy.createdAt => mnstr.createdAt,
            ManageOrderBy.updatedAt => mnstr.updatedAt,
            ManageOrderBy.name => mnstr.mnstrName?.toLowerCase(),
            ManageOrderBy.level => mnstr.currentLevel,
            ManageOrderBy.experience => mnstr.currentExperience,
            ManageOrderBy.health => mnstr.currentHealth,
            ManageOrderBy.attack => mnstr.currentAttack,
            ManageOrderBy.defense => mnstr.currentDefense,
            ManageOrderBy.intelligence => mnstr.currentIntelligence,
            ManageOrderBy.speed => mnstr.currentSpeed,
            ManageOrderBy.magic => mnstr.currentMagic,
          }
          as Comparable<Object>?;

  final indexed = mnstrs.indexed.toList();
  indexed.sort((a, b) {
    final left = valueOf(a.$2);
    final right = valueOf(b.$2);
    if (left == null || right == null) {
      if (left == null && right == null) {
        return a.$1.compareTo(b.$1);
      }
      return left == null ? 1 : -1;
    }
    final compared = orderDirection == ManageOrderDirection.asc
        ? left.compareTo(right)
        : right.compareTo(left);
    return compared != 0 ? compared : a.$1.compareTo(b.$1);
  });
  return indexed.map((entry) => entry.$2).toList();
}
