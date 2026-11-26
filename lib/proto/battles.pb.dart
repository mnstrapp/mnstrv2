// This is a generated file - do not edit.
//
// Generated from battles.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'battles.pbenum.dart';
import 'mnstr.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'battles.pbenum.dart';

class BattlePlayer extends $pb.GeneratedMessage {
  factory BattlePlayer({
    $core.String? userId,
    $core.String? displayName,
  }) {
    final result = BattlePlayer._();
    if (userId != null) result.userId = userId;
    if (displayName != null) result.displayName = displayName;
    return result;
  }

  BattlePlayer._();

  factory BattlePlayer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BattlePlayer()..mergeFromBuffer(data, registry);
  factory BattlePlayer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BattlePlayer()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BattlePlayer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: BattlePlayer.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BattlePlayer clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BattlePlayer copyWith(void Function(BattlePlayer) updates) =>
      super.copyWith((message) => updates(message as BattlePlayer))
          as BattlePlayer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BattlePlayer() / BattlePlayer.new instead')
  static BattlePlayer create() => BattlePlayer._();
  static $pb.GeneratedMessage $_createMessage() => BattlePlayer._();
  @$core.override
  BattlePlayer createEmptyInstance() => BattlePlayer._();
  @$core.pragma('dart2js:noInline')
  static BattlePlayer getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BattlePlayer>(
          BattlePlayer.$_createMessage);
  static BattlePlayer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => $_clearField(2);
}

/// A player's presence in the battle lobby.
class BattleStatus extends $pb.GeneratedMessage {
  factory BattleStatus({
    $core.String? id,
    $core.String? userId,
    $core.String? displayName,
    $core.String? opponentId,
    $core.String? opponentName,
    $core.String? battleId,
    BattleStatusState? status,
  }) {
    final result = BattleStatus._();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (displayName != null) result.displayName = displayName;
    if (opponentId != null) result.opponentId = opponentId;
    if (opponentName != null) result.opponentName = opponentName;
    if (battleId != null) result.battleId = battleId;
    if (status != null) result.status = status;
    return result;
  }

  BattleStatus._();

  factory BattleStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BattleStatus()..mergeFromBuffer(data, registry);
  factory BattleStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BattleStatus()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BattleStatus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: BattleStatus.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..aOS(4, _omitFieldNames ? '' : 'opponentId')
    ..aOS(5, _omitFieldNames ? '' : 'opponentName')
    ..aOS(6, _omitFieldNames ? '' : 'battleId')
    ..aE<BattleStatusState>(7, _omitFieldNames ? '' : 'status',
        enumValues: BattleStatusState.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BattleStatus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BattleStatus copyWith(void Function(BattleStatus) updates) =>
      super.copyWith((message) => updates(message as BattleStatus))
          as BattleStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BattleStatus() / BattleStatus.new instead')
  static BattleStatus create() => BattleStatus._();
  static $pb.GeneratedMessage $_createMessage() => BattleStatus._();
  @$core.override
  BattleStatus createEmptyInstance() => BattleStatus._();
  @$core.pragma('dart2js:noInline')
  static BattleStatus getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BattleStatus>(
          BattleStatus.$_createMessage);
  static BattleStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get opponentId => $_getSZ(3);
  @$pb.TagNumber(4)
  set opponentId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOpponentId() => $_has(3);
  @$pb.TagNumber(4)
  void clearOpponentId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get opponentName => $_getSZ(4);
  @$pb.TagNumber(5)
  set opponentName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasOpponentName() => $_has(4);
  @$pb.TagNumber(5)
  void clearOpponentName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get battleId => $_getSZ(5);
  @$pb.TagNumber(6)
  set battleId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBattleId() => $_has(5);
  @$pb.TagNumber(6)
  void clearBattleId() => $_clearField(6);

  @$pb.TagNumber(7)
  BattleStatusState get status => $_getN(6);
  @$pb.TagNumber(7)
  set status(BattleStatusState value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);
}

/// The full, server-authoritative state of one battle.
class BattleState extends $pb.GeneratedMessage {
  factory BattleState({
    $core.String? battleId,
    BattlePhase? phase,
    BattlePlayer? challenger,
    BattlePlayer? opponent,
    $1.Mnstr? challengerMnstr,
    $1.Mnstr? opponentMnstr,
    $core.Iterable<$1.Mnstr>? challengerMnstrs,
    $core.Iterable<$1.Mnstr>? opponentMnstrs,
    $core.String? turnUserId,
  }) {
    final result = BattleState._();
    if (battleId != null) result.battleId = battleId;
    if (phase != null) result.phase = phase;
    if (challenger != null) result.challenger = challenger;
    if (opponent != null) result.opponent = opponent;
    if (challengerMnstr != null) result.challengerMnstr = challengerMnstr;
    if (opponentMnstr != null) result.opponentMnstr = opponentMnstr;
    if (challengerMnstrs != null)
      result.challengerMnstrs.addAll(challengerMnstrs);
    if (opponentMnstrs != null) result.opponentMnstrs.addAll(opponentMnstrs);
    if (turnUserId != null) result.turnUserId = turnUserId;
    return result;
  }

  BattleState._();

  factory BattleState.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BattleState()..mergeFromBuffer(data, registry);
  factory BattleState.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BattleState()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BattleState',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: BattleState.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'battleId')
    ..aE<BattlePhase>(2, _omitFieldNames ? '' : 'phase',
        enumValues: BattlePhase.values)
    ..aOM<BattlePlayer>(3, _omitFieldNames ? '' : 'challenger',
        subBuilder: BattlePlayer.$_createMessage)
    ..aOM<BattlePlayer>(4, _omitFieldNames ? '' : 'opponent',
        subBuilder: BattlePlayer.$_createMessage)
    ..aOM<$1.Mnstr>(5, _omitFieldNames ? '' : 'challengerMnstr',
        subBuilder: $1.Mnstr.$_createMessage)
    ..aOM<$1.Mnstr>(6, _omitFieldNames ? '' : 'opponentMnstr',
        subBuilder: $1.Mnstr.$_createMessage)
    ..pPM<$1.Mnstr>(7, _omitFieldNames ? '' : 'challengerMnstrs',
        subBuilder: $1.Mnstr.$_createMessage)
    ..pPM<$1.Mnstr>(8, _omitFieldNames ? '' : 'opponentMnstrs',
        subBuilder: $1.Mnstr.$_createMessage)
    ..aOS(9, _omitFieldNames ? '' : 'turnUserId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BattleState clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BattleState copyWith(void Function(BattleState) updates) =>
      super.copyWith((message) => updates(message as BattleState))
          as BattleState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BattleState() / BattleState.new instead')
  static BattleState create() => BattleState._();
  static $pb.GeneratedMessage $_createMessage() => BattleState._();
  @$core.override
  BattleState createEmptyInstance() => BattleState._();
  @$core.pragma('dart2js:noInline')
  static BattleState getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BattleState>(
          BattleState.$_createMessage);
  static BattleState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get battleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set battleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBattleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBattleId() => $_clearField(1);

  @$pb.TagNumber(2)
  BattlePhase get phase => $_getN(1);
  @$pb.TagNumber(2)
  set phase(BattlePhase value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPhase() => $_has(1);
  @$pb.TagNumber(2)
  void clearPhase() => $_clearField(2);

  @$pb.TagNumber(3)
  BattlePlayer get challenger => $_getN(2);
  @$pb.TagNumber(3)
  set challenger(BattlePlayer value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasChallenger() => $_has(2);
  @$pb.TagNumber(3)
  void clearChallenger() => $_clearField(3);
  @$pb.TagNumber(3)
  BattlePlayer ensureChallenger() => $_ensure(2);

  @$pb.TagNumber(4)
  BattlePlayer get opponent => $_getN(3);
  @$pb.TagNumber(4)
  set opponent(BattlePlayer value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasOpponent() => $_has(3);
  @$pb.TagNumber(4)
  void clearOpponent() => $_clearField(4);
  @$pb.TagNumber(4)
  BattlePlayer ensureOpponent() => $_ensure(3);

  /// Set once each player has chosen.
  @$pb.TagNumber(5)
  $1.Mnstr get challengerMnstr => $_getN(4);
  @$pb.TagNumber(5)
  set challengerMnstr($1.Mnstr value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasChallengerMnstr() => $_has(4);
  @$pb.TagNumber(5)
  void clearChallengerMnstr() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Mnstr ensureChallengerMnstr() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Mnstr get opponentMnstr => $_getN(5);
  @$pb.TagNumber(6)
  set opponentMnstr($1.Mnstr value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasOpponentMnstr() => $_has(5);
  @$pb.TagNumber(6)
  void clearOpponentMnstr() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Mnstr ensureOpponentMnstr() => $_ensure(5);

  /// Each player's mnstrs to choose from; only sent while choosing.
  @$pb.TagNumber(7)
  $pb.PbList<$1.Mnstr> get challengerMnstrs => $_getList(6);

  @$pb.TagNumber(8)
  $pb.PbList<$1.Mnstr> get opponentMnstrs => $_getList(7);

  /// Whose turn it is to act. Empty until the battle is in progress.
  @$pb.TagNumber(9)
  $core.String get turnUserId => $_getSZ(8);
  @$pb.TagNumber(9)
  set turnUserId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTurnUserId() => $_has(8);
  @$pb.TagNumber(9)
  void clearTurnUserId() => $_clearField(9);
}

/// What happened in one turn.
class TurnResult extends $pb.GeneratedMessage {
  factory TurnResult({
    $core.String? actorUserId,
    $core.String? actorMnstrId,
    BattleTurnAction? action,
    $core.bool? hit,
    $core.bool? missed,
    $core.int? damage,
    $core.int? defense,
  }) {
    final result = TurnResult._();
    if (actorUserId != null) result.actorUserId = actorUserId;
    if (actorMnstrId != null) result.actorMnstrId = actorMnstrId;
    if (action != null) result.action = action;
    if (hit != null) result.hit = hit;
    if (missed != null) result.missed = missed;
    if (damage != null) result.damage = damage;
    if (defense != null) result.defense = defense;
    return result;
  }

  TurnResult._();

  factory TurnResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TurnResult()..mergeFromBuffer(data, registry);
  factory TurnResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TurnResult()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TurnResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: TurnResult.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'actorUserId')
    ..aOS(2, _omitFieldNames ? '' : 'actorMnstrId')
    ..aE<BattleTurnAction>(3, _omitFieldNames ? '' : 'action',
        enumValues: BattleTurnAction.values)
    ..aOB(4, _omitFieldNames ? '' : 'hit')
    ..aOB(5, _omitFieldNames ? '' : 'missed')
    ..aI(6, _omitFieldNames ? '' : 'damage')
    ..aI(7, _omitFieldNames ? '' : 'defense')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TurnResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TurnResult copyWith(void Function(TurnResult) updates) =>
      super.copyWith((message) => updates(message as TurnResult)) as TurnResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TurnResult() / TurnResult.new instead')
  static TurnResult create() => TurnResult._();
  static $pb.GeneratedMessage $_createMessage() => TurnResult._();
  @$core.override
  TurnResult createEmptyInstance() => TurnResult._();
  @$core.pragma('dart2js:noInline')
  static TurnResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TurnResult>(TurnResult.$_createMessage);
  static TurnResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get actorUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set actorUserId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasActorUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearActorUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get actorMnstrId => $_getSZ(1);
  @$pb.TagNumber(2)
  set actorMnstrId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActorMnstrId() => $_has(1);
  @$pb.TagNumber(2)
  void clearActorMnstrId() => $_clearField(2);

  @$pb.TagNumber(3)
  BattleTurnAction get action => $_getN(2);
  @$pb.TagNumber(3)
  set action(BattleTurnAction value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAction() => $_has(2);
  @$pb.TagNumber(3)
  void clearAction() => $_clearField(3);

  /// Attack and magic: whether the move landed and how much health it took.
  @$pb.TagNumber(4)
  $core.bool get hit => $_getBF(3);
  @$pb.TagNumber(4)
  set hit($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHit() => $_has(3);
  @$pb.TagNumber(4)
  void clearHit() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get missed => $_getBF(4);
  @$pb.TagNumber(5)
  set missed($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMissed() => $_has(4);
  @$pb.TagNumber(5)
  void clearMissed() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get damage => $_getIZ(5);
  @$pb.TagNumber(6)
  set damage($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDamage() => $_has(5);
  @$pb.TagNumber(6)
  void clearDamage() => $_clearField(6);

  /// Defend: how much defense was restored.
  @$pb.TagNumber(7)
  $core.int get defense => $_getIZ(6);
  @$pb.TagNumber(7)
  set defense($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDefense() => $_has(6);
  @$pb.TagNumber(7)
  void clearDefense() => $_clearField(7);
}

class BattleRewards extends $pb.GeneratedMessage {
  factory BattleRewards({
    $core.int? xpAwarded,
    $core.int? coinsAwarded,
  }) {
    final result = BattleRewards._();
    if (xpAwarded != null) result.xpAwarded = xpAwarded;
    if (coinsAwarded != null) result.coinsAwarded = coinsAwarded;
    return result;
  }

  BattleRewards._();

  factory BattleRewards.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BattleRewards()..mergeFromBuffer(data, registry);
  factory BattleRewards.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BattleRewards()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BattleRewards',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: BattleRewards.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'xpAwarded')
    ..aI(2, _omitFieldNames ? '' : 'coinsAwarded')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BattleRewards clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BattleRewards copyWith(void Function(BattleRewards) updates) =>
      super.copyWith((message) => updates(message as BattleRewards))
          as BattleRewards;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BattleRewards() / BattleRewards.new instead')
  static BattleRewards create() => BattleRewards._();
  static $pb.GeneratedMessage $_createMessage() => BattleRewards._();
  @$core.override
  BattleRewards createEmptyInstance() => BattleRewards._();
  @$core.pragma('dart2js:noInline')
  static BattleRewards getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BattleRewards>(
          BattleRewards.$_createMessage);
  static BattleRewards? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get xpAwarded => $_getIZ(0);
  @$pb.TagNumber(1)
  set xpAwarded($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasXpAwarded() => $_has(0);
  @$pb.TagNumber(1)
  void clearXpAwarded() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get coinsAwarded => $_getIZ(1);
  @$pb.TagNumber(2)
  set coinsAwarded($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCoinsAwarded() => $_has(1);
  @$pb.TagNumber(2)
  void clearCoinsAwarded() => $_clearField(2);
}

class GameEnded extends $pb.GeneratedMessage {
  factory GameEnded({
    BattleState? state,
    $core.String? winnerId,
    $core.String? loserId,
    BattleRewards? winnerRewards,
    BattleRewards? loserRewards,
    $core.bool? escaped,
  }) {
    final result = GameEnded._();
    if (state != null) result.state = state;
    if (winnerId != null) result.winnerId = winnerId;
    if (loserId != null) result.loserId = loserId;
    if (winnerRewards != null) result.winnerRewards = winnerRewards;
    if (loserRewards != null) result.loserRewards = loserRewards;
    if (escaped != null) result.escaped = escaped;
    return result;
  }

  GameEnded._();

  factory GameEnded.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GameEnded()..mergeFromBuffer(data, registry);
  factory GameEnded.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GameEnded()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GameEnded',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: GameEnded.$_createMessage)
    ..aOM<BattleState>(1, _omitFieldNames ? '' : 'state',
        subBuilder: BattleState.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'winnerId')
    ..aOS(3, _omitFieldNames ? '' : 'loserId')
    ..aOM<BattleRewards>(4, _omitFieldNames ? '' : 'winnerRewards',
        subBuilder: BattleRewards.$_createMessage)
    ..aOM<BattleRewards>(5, _omitFieldNames ? '' : 'loserRewards',
        subBuilder: BattleRewards.$_createMessage)
    ..aOB(6, _omitFieldNames ? '' : 'escaped')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GameEnded clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GameEnded copyWith(void Function(GameEnded) updates) =>
      super.copyWith((message) => updates(message as GameEnded)) as GameEnded;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GameEnded() / GameEnded.new instead')
  static GameEnded create() => GameEnded._();
  static $pb.GeneratedMessage $_createMessage() => GameEnded._();
  @$core.override
  GameEnded createEmptyInstance() => GameEnded._();
  @$core.pragma('dart2js:noInline')
  static GameEnded getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GameEnded>(GameEnded.$_createMessage);
  static GameEnded? _defaultInstance;

  @$pb.TagNumber(1)
  BattleState get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(BattleState value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);
  @$pb.TagNumber(1)
  BattleState ensureState() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get winnerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set winnerId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWinnerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearWinnerId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get loserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set loserId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLoserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearLoserId() => $_clearField(3);

  @$pb.TagNumber(4)
  BattleRewards get winnerRewards => $_getN(3);
  @$pb.TagNumber(4)
  set winnerRewards(BattleRewards value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasWinnerRewards() => $_has(3);
  @$pb.TagNumber(4)
  void clearWinnerRewards() => $_clearField(4);
  @$pb.TagNumber(4)
  BattleRewards ensureWinnerRewards() => $_ensure(3);

  @$pb.TagNumber(5)
  BattleRewards get loserRewards => $_getN(4);
  @$pb.TagNumber(5)
  set loserRewards(BattleRewards value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasLoserRewards() => $_has(4);
  @$pb.TagNumber(5)
  void clearLoserRewards() => $_clearField(5);
  @$pb.TagNumber(5)
  BattleRewards ensureLoserRewards() => $_ensure(4);

  /// True when the loser ran away instead of being knocked out.
  @$pb.TagNumber(6)
  $core.bool get escaped => $_getBF(5);
  @$pb.TagNumber(6)
  set escaped($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasEscaped() => $_has(5);
  @$pb.TagNumber(6)
  void clearEscaped() => $_clearField(6);
}

class PlayerJoined extends $pb.GeneratedMessage {
  factory PlayerJoined({
    BattleStatus? status,
  }) {
    final result = PlayerJoined._();
    if (status != null) result.status = status;
    return result;
  }

  PlayerJoined._();

  factory PlayerJoined.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PlayerJoined()..mergeFromBuffer(data, registry);
  factory PlayerJoined.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PlayerJoined()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlayerJoined',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: PlayerJoined.$_createMessage)
    ..aOM<BattleStatus>(1, _omitFieldNames ? '' : 'status',
        subBuilder: BattleStatus.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayerJoined clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayerJoined copyWith(void Function(PlayerJoined) updates) =>
      super.copyWith((message) => updates(message as PlayerJoined))
          as PlayerJoined;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PlayerJoined() / PlayerJoined.new instead')
  static PlayerJoined create() => PlayerJoined._();
  static $pb.GeneratedMessage $_createMessage() => PlayerJoined._();
  @$core.override
  PlayerJoined createEmptyInstance() => PlayerJoined._();
  @$core.pragma('dart2js:noInline')
  static PlayerJoined getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerJoined>(
          PlayerJoined.$_createMessage);
  static PlayerJoined? _defaultInstance;

  @$pb.TagNumber(1)
  BattleStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(BattleStatus value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
  @$pb.TagNumber(1)
  BattleStatus ensureStatus() => $_ensure(0);
}

class PlayerLeft extends $pb.GeneratedMessage {
  factory PlayerLeft({
    BattlePlayer? player,
  }) {
    final result = PlayerLeft._();
    if (player != null) result.player = player;
    return result;
  }

  PlayerLeft._();

  factory PlayerLeft.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PlayerLeft()..mergeFromBuffer(data, registry);
  factory PlayerLeft.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PlayerLeft()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlayerLeft',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: PlayerLeft.$_createMessage)
    ..aOM<BattlePlayer>(1, _omitFieldNames ? '' : 'player',
        subBuilder: BattlePlayer.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayerLeft clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayerLeft copyWith(void Function(PlayerLeft) updates) =>
      super.copyWith((message) => updates(message as PlayerLeft)) as PlayerLeft;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PlayerLeft() / PlayerLeft.new instead')
  static PlayerLeft create() => PlayerLeft._();
  static $pb.GeneratedMessage $_createMessage() => PlayerLeft._();
  @$core.override
  PlayerLeft createEmptyInstance() => PlayerLeft._();
  @$core.pragma('dart2js:noInline')
  static PlayerLeft getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlayerLeft>(PlayerLeft.$_createMessage);
  static PlayerLeft? _defaultInstance;

  @$pb.TagNumber(1)
  BattlePlayer get player => $_getN(0);
  @$pb.TagNumber(1)
  set player(BattlePlayer value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPlayer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayer() => $_clearField(1);
  @$pb.TagNumber(1)
  BattlePlayer ensurePlayer() => $_ensure(0);
}

class PlayerStatusChanged extends $pb.GeneratedMessage {
  factory PlayerStatusChanged({
    BattleStatus? status,
  }) {
    final result = PlayerStatusChanged._();
    if (status != null) result.status = status;
    return result;
  }

  PlayerStatusChanged._();

  factory PlayerStatusChanged.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PlayerStatusChanged()..mergeFromBuffer(data, registry);
  factory PlayerStatusChanged.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PlayerStatusChanged()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlayerStatusChanged',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: PlayerStatusChanged.$_createMessage)
    ..aOM<BattleStatus>(1, _omitFieldNames ? '' : 'status',
        subBuilder: BattleStatus.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayerStatusChanged clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayerStatusChanged copyWith(void Function(PlayerStatusChanged) updates) =>
      super.copyWith((message) => updates(message as PlayerStatusChanged))
          as PlayerStatusChanged;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use PlayerStatusChanged() / PlayerStatusChanged.new instead')
  static PlayerStatusChanged create() => PlayerStatusChanged._();
  static $pb.GeneratedMessage $_createMessage() => PlayerStatusChanged._();
  @$core.override
  PlayerStatusChanged createEmptyInstance() => PlayerStatusChanged._();
  @$core.pragma('dart2js:noInline')
  static PlayerStatusChanged getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlayerStatusChanged>(
          PlayerStatusChanged.$_createMessage);
  static PlayerStatusChanged? _defaultInstance;

  @$pb.TagNumber(1)
  BattleStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(BattleStatus value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
  @$pb.TagNumber(1)
  BattleStatus ensureStatus() => $_ensure(0);
}

class ChallengeReceived extends $pb.GeneratedMessage {
  factory ChallengeReceived({
    $core.String? challengeId,
    BattlePlayer? challenger,
    BattlePlayer? opponent,
  }) {
    final result = ChallengeReceived._();
    if (challengeId != null) result.challengeId = challengeId;
    if (challenger != null) result.challenger = challenger;
    if (opponent != null) result.opponent = opponent;
    return result;
  }

  ChallengeReceived._();

  factory ChallengeReceived.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChallengeReceived()..mergeFromBuffer(data, registry);
  factory ChallengeReceived.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChallengeReceived()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChallengeReceived',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: ChallengeReceived.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'challengeId')
    ..aOM<BattlePlayer>(2, _omitFieldNames ? '' : 'challenger',
        subBuilder: BattlePlayer.$_createMessage)
    ..aOM<BattlePlayer>(3, _omitFieldNames ? '' : 'opponent',
        subBuilder: BattlePlayer.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChallengeReceived clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChallengeReceived copyWith(void Function(ChallengeReceived) updates) =>
      super.copyWith((message) => updates(message as ChallengeReceived))
          as ChallengeReceived;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChallengeReceived() / ChallengeReceived.new instead')
  static ChallengeReceived create() => ChallengeReceived._();
  static $pb.GeneratedMessage $_createMessage() => ChallengeReceived._();
  @$core.override
  ChallengeReceived createEmptyInstance() => ChallengeReceived._();
  @$core.pragma('dart2js:noInline')
  static ChallengeReceived getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChallengeReceived>(
          ChallengeReceived.$_createMessage);
  static ChallengeReceived? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get challengeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set challengeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChallengeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChallengeId() => $_clearField(1);

  @$pb.TagNumber(2)
  BattlePlayer get challenger => $_getN(1);
  @$pb.TagNumber(2)
  set challenger(BattlePlayer value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasChallenger() => $_has(1);
  @$pb.TagNumber(2)
  void clearChallenger() => $_clearField(2);
  @$pb.TagNumber(2)
  BattlePlayer ensureChallenger() => $_ensure(1);

  @$pb.TagNumber(3)
  BattlePlayer get opponent => $_getN(2);
  @$pb.TagNumber(3)
  set opponent(BattlePlayer value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasOpponent() => $_has(2);
  @$pb.TagNumber(3)
  void clearOpponent() => $_clearField(3);
  @$pb.TagNumber(3)
  BattlePlayer ensureOpponent() => $_ensure(2);
}

class ChallengeCancelled extends $pb.GeneratedMessage {
  factory ChallengeCancelled({
    $core.String? challengeId,
    BattlePlayer? challenger,
  }) {
    final result = ChallengeCancelled._();
    if (challengeId != null) result.challengeId = challengeId;
    if (challenger != null) result.challenger = challenger;
    return result;
  }

  ChallengeCancelled._();

  factory ChallengeCancelled.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChallengeCancelled()..mergeFromBuffer(data, registry);
  factory ChallengeCancelled.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChallengeCancelled()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChallengeCancelled',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: ChallengeCancelled.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'challengeId')
    ..aOM<BattlePlayer>(2, _omitFieldNames ? '' : 'challenger',
        subBuilder: BattlePlayer.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChallengeCancelled clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChallengeCancelled copyWith(void Function(ChallengeCancelled) updates) =>
      super.copyWith((message) => updates(message as ChallengeCancelled))
          as ChallengeCancelled;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChallengeCancelled() / ChallengeCancelled.new instead')
  static ChallengeCancelled create() => ChallengeCancelled._();
  static $pb.GeneratedMessage $_createMessage() => ChallengeCancelled._();
  @$core.override
  ChallengeCancelled createEmptyInstance() => ChallengeCancelled._();
  @$core.pragma('dart2js:noInline')
  static ChallengeCancelled getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChallengeCancelled>(
          ChallengeCancelled.$_createMessage);
  static ChallengeCancelled? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get challengeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set challengeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChallengeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChallengeId() => $_clearField(1);

  @$pb.TagNumber(2)
  BattlePlayer get challenger => $_getN(1);
  @$pb.TagNumber(2)
  set challenger(BattlePlayer value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasChallenger() => $_has(1);
  @$pb.TagNumber(2)
  void clearChallenger() => $_clearField(2);
  @$pb.TagNumber(2)
  BattlePlayer ensureChallenger() => $_ensure(1);
}

class ChallengeRejected extends $pb.GeneratedMessage {
  factory ChallengeRejected({
    $core.String? challengeId,
    BattlePlayer? opponent,
  }) {
    final result = ChallengeRejected._();
    if (challengeId != null) result.challengeId = challengeId;
    if (opponent != null) result.opponent = opponent;
    return result;
  }

  ChallengeRejected._();

  factory ChallengeRejected.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChallengeRejected()..mergeFromBuffer(data, registry);
  factory ChallengeRejected.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChallengeRejected()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChallengeRejected',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: ChallengeRejected.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'challengeId')
    ..aOM<BattlePlayer>(2, _omitFieldNames ? '' : 'opponent',
        subBuilder: BattlePlayer.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChallengeRejected clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChallengeRejected copyWith(void Function(ChallengeRejected) updates) =>
      super.copyWith((message) => updates(message as ChallengeRejected))
          as ChallengeRejected;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChallengeRejected() / ChallengeRejected.new instead')
  static ChallengeRejected create() => ChallengeRejected._();
  static $pb.GeneratedMessage $_createMessage() => ChallengeRejected._();
  @$core.override
  ChallengeRejected createEmptyInstance() => ChallengeRejected._();
  @$core.pragma('dart2js:noInline')
  static ChallengeRejected getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChallengeRejected>(
          ChallengeRejected.$_createMessage);
  static ChallengeRejected? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get challengeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set challengeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChallengeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChallengeId() => $_clearField(1);

  @$pb.TagNumber(2)
  BattlePlayer get opponent => $_getN(1);
  @$pb.TagNumber(2)
  set opponent(BattlePlayer value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasOpponent() => $_has(1);
  @$pb.TagNumber(2)
  void clearOpponent() => $_clearField(2);
  @$pb.TagNumber(2)
  BattlePlayer ensureOpponent() => $_ensure(1);
}

class ChallengeAccepted extends $pb.GeneratedMessage {
  factory ChallengeAccepted({
    $core.String? challengeId,
    BattlePlayer? opponent,
    $core.String? battleId,
  }) {
    final result = ChallengeAccepted._();
    if (challengeId != null) result.challengeId = challengeId;
    if (opponent != null) result.opponent = opponent;
    if (battleId != null) result.battleId = battleId;
    return result;
  }

  ChallengeAccepted._();

  factory ChallengeAccepted.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChallengeAccepted()..mergeFromBuffer(data, registry);
  factory ChallengeAccepted.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChallengeAccepted()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChallengeAccepted',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: ChallengeAccepted.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'challengeId')
    ..aOM<BattlePlayer>(2, _omitFieldNames ? '' : 'opponent',
        subBuilder: BattlePlayer.$_createMessage)
    ..aOS(3, _omitFieldNames ? '' : 'battleId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChallengeAccepted clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChallengeAccepted copyWith(void Function(ChallengeAccepted) updates) =>
      super.copyWith((message) => updates(message as ChallengeAccepted))
          as ChallengeAccepted;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChallengeAccepted() / ChallengeAccepted.new instead')
  static ChallengeAccepted create() => ChallengeAccepted._();
  static $pb.GeneratedMessage $_createMessage() => ChallengeAccepted._();
  @$core.override
  ChallengeAccepted createEmptyInstance() => ChallengeAccepted._();
  @$core.pragma('dart2js:noInline')
  static ChallengeAccepted getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChallengeAccepted>(
          ChallengeAccepted.$_createMessage);
  static ChallengeAccepted? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get challengeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set challengeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChallengeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChallengeId() => $_clearField(1);

  @$pb.TagNumber(2)
  BattlePlayer get opponent => $_getN(1);
  @$pb.TagNumber(2)
  set opponent(BattlePlayer value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasOpponent() => $_has(1);
  @$pb.TagNumber(2)
  void clearOpponent() => $_clearField(2);
  @$pb.TagNumber(2)
  BattlePlayer ensureOpponent() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get battleId => $_getSZ(2);
  @$pb.TagNumber(3)
  set battleId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBattleId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBattleId() => $_clearField(3);
}

class GameStarted extends $pb.GeneratedMessage {
  factory GameStarted({
    BattleState? state,
  }) {
    final result = GameStarted._();
    if (state != null) result.state = state;
    return result;
  }

  GameStarted._();

  factory GameStarted.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GameStarted()..mergeFromBuffer(data, registry);
  factory GameStarted.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GameStarted()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GameStarted',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: GameStarted.$_createMessage)
    ..aOM<BattleState>(1, _omitFieldNames ? '' : 'state',
        subBuilder: BattleState.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GameStarted clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GameStarted copyWith(void Function(GameStarted) updates) =>
      super.copyWith((message) => updates(message as GameStarted))
          as GameStarted;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GameStarted() / GameStarted.new instead')
  static GameStarted create() => GameStarted._();
  static $pb.GeneratedMessage $_createMessage() => GameStarted._();
  @$core.override
  GameStarted createEmptyInstance() => GameStarted._();
  @$core.pragma('dart2js:noInline')
  static GameStarted getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameStarted>(
          GameStarted.$_createMessage);
  static GameStarted? _defaultInstance;

  @$pb.TagNumber(1)
  BattleState get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(BattleState value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);
  @$pb.TagNumber(1)
  BattleState ensureState() => $_ensure(0);
}

class MnstrChosen extends $pb.GeneratedMessage {
  factory MnstrChosen({
    BattleState? state,
    $core.String? userId,
  }) {
    final result = MnstrChosen._();
    if (state != null) result.state = state;
    if (userId != null) result.userId = userId;
    return result;
  }

  MnstrChosen._();

  factory MnstrChosen.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MnstrChosen()..mergeFromBuffer(data, registry);
  factory MnstrChosen.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MnstrChosen()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MnstrChosen',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: MnstrChosen.$_createMessage)
    ..aOM<BattleState>(1, _omitFieldNames ? '' : 'state',
        subBuilder: BattleState.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MnstrChosen clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MnstrChosen copyWith(void Function(MnstrChosen) updates) =>
      super.copyWith((message) => updates(message as MnstrChosen))
          as MnstrChosen;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MnstrChosen() / MnstrChosen.new instead')
  static MnstrChosen create() => MnstrChosen._();
  static $pb.GeneratedMessage $_createMessage() => MnstrChosen._();
  @$core.override
  MnstrChosen createEmptyInstance() => MnstrChosen._();
  @$core.pragma('dart2js:noInline')
  static MnstrChosen getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MnstrChosen>(
          MnstrChosen.$_createMessage);
  static MnstrChosen? _defaultInstance;

  @$pb.TagNumber(1)
  BattleState get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(BattleState value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);
  @$pb.TagNumber(1)
  BattleState ensureState() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class TurnTaken extends $pb.GeneratedMessage {
  factory TurnTaken({
    TurnResult? result,
    BattleState? state,
  }) {
    final result$ = TurnTaken._();
    if (result != null) result$.result = result;
    if (state != null) result$.state = state;
    return result$;
  }

  TurnTaken._();

  factory TurnTaken.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TurnTaken()..mergeFromBuffer(data, registry);
  factory TurnTaken.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TurnTaken()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TurnTaken',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: TurnTaken.$_createMessage)
    ..aOM<TurnResult>(1, _omitFieldNames ? '' : 'result',
        subBuilder: TurnResult.$_createMessage)
    ..aOM<BattleState>(2, _omitFieldNames ? '' : 'state',
        subBuilder: BattleState.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TurnTaken clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TurnTaken copyWith(void Function(TurnTaken) updates) =>
      super.copyWith((message) => updates(message as TurnTaken)) as TurnTaken;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TurnTaken() / TurnTaken.new instead')
  static TurnTaken create() => TurnTaken._();
  static $pb.GeneratedMessage $_createMessage() => TurnTaken._();
  @$core.override
  TurnTaken createEmptyInstance() => TurnTaken._();
  @$core.pragma('dart2js:noInline')
  static TurnTaken getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TurnTaken>(TurnTaken.$_createMessage);
  static TurnTaken? _defaultInstance;

  @$pb.TagNumber(1)
  TurnResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(TurnResult value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => $_clearField(1);
  @$pb.TagNumber(1)
  TurnResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  BattleState get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(BattleState value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => $_clearField(2);
  @$pb.TagNumber(2)
  BattleState ensureState() => $_ensure(1);
}

class Rejoined extends $pb.GeneratedMessage {
  factory Rejoined({
    BattleState? state,
    $core.String? userId,
  }) {
    final result = Rejoined._();
    if (state != null) result.state = state;
    if (userId != null) result.userId = userId;
    return result;
  }

  Rejoined._();

  factory Rejoined.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Rejoined()..mergeFromBuffer(data, registry);
  factory Rejoined.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Rejoined()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Rejoined',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: Rejoined.$_createMessage)
    ..aOM<BattleState>(1, _omitFieldNames ? '' : 'state',
        subBuilder: BattleState.$_createMessage)
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Rejoined clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Rejoined copyWith(void Function(Rejoined) updates) =>
      super.copyWith((message) => updates(message as Rejoined)) as Rejoined;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Rejoined() / Rejoined.new instead')
  static Rejoined create() => Rejoined._();
  static $pb.GeneratedMessage $_createMessage() => Rejoined._();
  @$core.override
  Rejoined createEmptyInstance() => Rejoined._();
  @$core.pragma('dart2js:noInline')
  static Rejoined getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Rejoined>(Rejoined.$_createMessage);
  static Rejoined? _defaultInstance;

  @$pb.TagNumber(1)
  BattleState get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(BattleState value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);
  @$pb.TagNumber(1)
  BattleState ensureState() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class BattleError extends $pb.GeneratedMessage {
  factory BattleError({
    $core.String? message,
    $core.String? battleId,
  }) {
    final result = BattleError._();
    if (message != null) result.message = message;
    if (battleId != null) result.battleId = battleId;
    return result;
  }

  BattleError._();

  factory BattleError.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BattleError()..mergeFromBuffer(data, registry);
  factory BattleError.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BattleError()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BattleError',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: BattleError.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..aOS(2, _omitFieldNames ? '' : 'battleId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BattleError clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BattleError copyWith(void Function(BattleError) updates) =>
      super.copyWith((message) => updates(message as BattleError))
          as BattleError;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BattleError() / BattleError.new instead')
  static BattleError create() => BattleError._();
  static $pb.GeneratedMessage $_createMessage() => BattleError._();
  @$core.override
  BattleError createEmptyInstance() => BattleError._();
  @$core.pragma('dart2js:noInline')
  static BattleError getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BattleError>(
          BattleError.$_createMessage);
  static BattleError? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get battleId => $_getSZ(1);
  @$pb.TagNumber(2)
  set battleId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBattleId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBattleId() => $_clearField(2);
}

enum BattleEvent_Payload {
  playerJoined,
  playerLeft,
  playerStatusChanged,
  challengeReceived,
  challengeCancelled,
  challengeRejected,
  challengeAccepted,
  gameStarted,
  mnstrChosen,
  turnTaken,
  gameEnded,
  rejoined,
  error,
  notSet
}

class BattleEvent extends $pb.GeneratedMessage {
  factory BattleEvent({
    $core.String? id,
    PlayerJoined? playerJoined,
    PlayerLeft? playerLeft,
    PlayerStatusChanged? playerStatusChanged,
    ChallengeReceived? challengeReceived,
    ChallengeCancelled? challengeCancelled,
    ChallengeRejected? challengeRejected,
    ChallengeAccepted? challengeAccepted,
    GameStarted? gameStarted,
    MnstrChosen? mnstrChosen,
    TurnTaken? turnTaken,
    GameEnded? gameEnded,
    Rejoined? rejoined,
    BattleError? error,
  }) {
    final result = BattleEvent._();
    if (id != null) result.id = id;
    if (playerJoined != null) result.playerJoined = playerJoined;
    if (playerLeft != null) result.playerLeft = playerLeft;
    if (playerStatusChanged != null)
      result.playerStatusChanged = playerStatusChanged;
    if (challengeReceived != null) result.challengeReceived = challengeReceived;
    if (challengeCancelled != null)
      result.challengeCancelled = challengeCancelled;
    if (challengeRejected != null) result.challengeRejected = challengeRejected;
    if (challengeAccepted != null) result.challengeAccepted = challengeAccepted;
    if (gameStarted != null) result.gameStarted = gameStarted;
    if (mnstrChosen != null) result.mnstrChosen = mnstrChosen;
    if (turnTaken != null) result.turnTaken = turnTaken;
    if (gameEnded != null) result.gameEnded = gameEnded;
    if (rejoined != null) result.rejoined = rejoined;
    if (error != null) result.error = error;
    return result;
  }

  BattleEvent._();

  factory BattleEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BattleEvent()..mergeFromBuffer(data, registry);
  factory BattleEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BattleEvent()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, BattleEvent_Payload>
      _BattleEvent_PayloadByTag = {
    10: BattleEvent_Payload.playerJoined,
    11: BattleEvent_Payload.playerLeft,
    12: BattleEvent_Payload.playerStatusChanged,
    20: BattleEvent_Payload.challengeReceived,
    21: BattleEvent_Payload.challengeCancelled,
    22: BattleEvent_Payload.challengeRejected,
    23: BattleEvent_Payload.challengeAccepted,
    30: BattleEvent_Payload.gameStarted,
    31: BattleEvent_Payload.mnstrChosen,
    32: BattleEvent_Payload.turnTaken,
    33: BattleEvent_Payload.gameEnded,
    34: BattleEvent_Payload.rejoined,
    90: BattleEvent_Payload.error,
    0: BattleEvent_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BattleEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: BattleEvent.$_createMessage)
    ..oo(0, [10, 11, 12, 20, 21, 22, 23, 30, 31, 32, 33, 34, 90])
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<PlayerJoined>(10, _omitFieldNames ? '' : 'playerJoined',
        subBuilder: PlayerJoined.$_createMessage)
    ..aOM<PlayerLeft>(11, _omitFieldNames ? '' : 'playerLeft',
        subBuilder: PlayerLeft.$_createMessage)
    ..aOM<PlayerStatusChanged>(12, _omitFieldNames ? '' : 'playerStatusChanged',
        subBuilder: PlayerStatusChanged.$_createMessage)
    ..aOM<ChallengeReceived>(20, _omitFieldNames ? '' : 'challengeReceived',
        subBuilder: ChallengeReceived.$_createMessage)
    ..aOM<ChallengeCancelled>(21, _omitFieldNames ? '' : 'challengeCancelled',
        subBuilder: ChallengeCancelled.$_createMessage)
    ..aOM<ChallengeRejected>(22, _omitFieldNames ? '' : 'challengeRejected',
        subBuilder: ChallengeRejected.$_createMessage)
    ..aOM<ChallengeAccepted>(23, _omitFieldNames ? '' : 'challengeAccepted',
        subBuilder: ChallengeAccepted.$_createMessage)
    ..aOM<GameStarted>(30, _omitFieldNames ? '' : 'gameStarted',
        subBuilder: GameStarted.$_createMessage)
    ..aOM<MnstrChosen>(31, _omitFieldNames ? '' : 'mnstrChosen',
        subBuilder: MnstrChosen.$_createMessage)
    ..aOM<TurnTaken>(32, _omitFieldNames ? '' : 'turnTaken',
        subBuilder: TurnTaken.$_createMessage)
    ..aOM<GameEnded>(33, _omitFieldNames ? '' : 'gameEnded',
        subBuilder: GameEnded.$_createMessage)
    ..aOM<Rejoined>(34, _omitFieldNames ? '' : 'rejoined',
        subBuilder: Rejoined.$_createMessage)
    ..aOM<BattleError>(90, _omitFieldNames ? '' : 'error',
        subBuilder: BattleError.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BattleEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BattleEvent copyWith(void Function(BattleEvent) updates) =>
      super.copyWith((message) => updates(message as BattleEvent))
          as BattleEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BattleEvent() / BattleEvent.new instead')
  static BattleEvent create() => BattleEvent._();
  static $pb.GeneratedMessage $_createMessage() => BattleEvent._();
  @$core.override
  BattleEvent createEmptyInstance() => BattleEvent._();
  @$core.pragma('dart2js:noInline')
  static BattleEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BattleEvent>(
          BattleEvent.$_createMessage);
  static BattleEvent? _defaultInstance;

  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(20)
  @$pb.TagNumber(21)
  @$pb.TagNumber(22)
  @$pb.TagNumber(23)
  @$pb.TagNumber(30)
  @$pb.TagNumber(31)
  @$pb.TagNumber(32)
  @$pb.TagNumber(33)
  @$pb.TagNumber(34)
  @$pb.TagNumber(90)
  BattleEvent_Payload whichPayload() =>
      _BattleEvent_PayloadByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(20)
  @$pb.TagNumber(21)
  @$pb.TagNumber(22)
  @$pb.TagNumber(23)
  @$pb.TagNumber(30)
  @$pb.TagNumber(31)
  @$pb.TagNumber(32)
  @$pb.TagNumber(33)
  @$pb.TagNumber(34)
  @$pb.TagNumber(90)
  void clearPayload() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// Lobby presence
  @$pb.TagNumber(10)
  PlayerJoined get playerJoined => $_getN(1);
  @$pb.TagNumber(10)
  set playerJoined(PlayerJoined value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasPlayerJoined() => $_has(1);
  @$pb.TagNumber(10)
  void clearPlayerJoined() => $_clearField(10);
  @$pb.TagNumber(10)
  PlayerJoined ensurePlayerJoined() => $_ensure(1);

  @$pb.TagNumber(11)
  PlayerLeft get playerLeft => $_getN(2);
  @$pb.TagNumber(11)
  set playerLeft(PlayerLeft value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasPlayerLeft() => $_has(2);
  @$pb.TagNumber(11)
  void clearPlayerLeft() => $_clearField(11);
  @$pb.TagNumber(11)
  PlayerLeft ensurePlayerLeft() => $_ensure(2);

  @$pb.TagNumber(12)
  PlayerStatusChanged get playerStatusChanged => $_getN(3);
  @$pb.TagNumber(12)
  set playerStatusChanged(PlayerStatusChanged value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasPlayerStatusChanged() => $_has(3);
  @$pb.TagNumber(12)
  void clearPlayerStatusChanged() => $_clearField(12);
  @$pb.TagNumber(12)
  PlayerStatusChanged ensurePlayerStatusChanged() => $_ensure(3);

  /// Challenges
  @$pb.TagNumber(20)
  ChallengeReceived get challengeReceived => $_getN(4);
  @$pb.TagNumber(20)
  set challengeReceived(ChallengeReceived value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasChallengeReceived() => $_has(4);
  @$pb.TagNumber(20)
  void clearChallengeReceived() => $_clearField(20);
  @$pb.TagNumber(20)
  ChallengeReceived ensureChallengeReceived() => $_ensure(4);

  @$pb.TagNumber(21)
  ChallengeCancelled get challengeCancelled => $_getN(5);
  @$pb.TagNumber(21)
  set challengeCancelled(ChallengeCancelled value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasChallengeCancelled() => $_has(5);
  @$pb.TagNumber(21)
  void clearChallengeCancelled() => $_clearField(21);
  @$pb.TagNumber(21)
  ChallengeCancelled ensureChallengeCancelled() => $_ensure(5);

  @$pb.TagNumber(22)
  ChallengeRejected get challengeRejected => $_getN(6);
  @$pb.TagNumber(22)
  set challengeRejected(ChallengeRejected value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasChallengeRejected() => $_has(6);
  @$pb.TagNumber(22)
  void clearChallengeRejected() => $_clearField(22);
  @$pb.TagNumber(22)
  ChallengeRejected ensureChallengeRejected() => $_ensure(6);

  @$pb.TagNumber(23)
  ChallengeAccepted get challengeAccepted => $_getN(7);
  @$pb.TagNumber(23)
  set challengeAccepted(ChallengeAccepted value) => $_setField(23, value);
  @$pb.TagNumber(23)
  $core.bool hasChallengeAccepted() => $_has(7);
  @$pb.TagNumber(23)
  void clearChallengeAccepted() => $_clearField(23);
  @$pb.TagNumber(23)
  ChallengeAccepted ensureChallengeAccepted() => $_ensure(7);

  /// Battle
  @$pb.TagNumber(30)
  GameStarted get gameStarted => $_getN(8);
  @$pb.TagNumber(30)
  set gameStarted(GameStarted value) => $_setField(30, value);
  @$pb.TagNumber(30)
  $core.bool hasGameStarted() => $_has(8);
  @$pb.TagNumber(30)
  void clearGameStarted() => $_clearField(30);
  @$pb.TagNumber(30)
  GameStarted ensureGameStarted() => $_ensure(8);

  @$pb.TagNumber(31)
  MnstrChosen get mnstrChosen => $_getN(9);
  @$pb.TagNumber(31)
  set mnstrChosen(MnstrChosen value) => $_setField(31, value);
  @$pb.TagNumber(31)
  $core.bool hasMnstrChosen() => $_has(9);
  @$pb.TagNumber(31)
  void clearMnstrChosen() => $_clearField(31);
  @$pb.TagNumber(31)
  MnstrChosen ensureMnstrChosen() => $_ensure(9);

  @$pb.TagNumber(32)
  TurnTaken get turnTaken => $_getN(10);
  @$pb.TagNumber(32)
  set turnTaken(TurnTaken value) => $_setField(32, value);
  @$pb.TagNumber(32)
  $core.bool hasTurnTaken() => $_has(10);
  @$pb.TagNumber(32)
  void clearTurnTaken() => $_clearField(32);
  @$pb.TagNumber(32)
  TurnTaken ensureTurnTaken() => $_ensure(10);

  @$pb.TagNumber(33)
  GameEnded get gameEnded => $_getN(11);
  @$pb.TagNumber(33)
  set gameEnded(GameEnded value) => $_setField(33, value);
  @$pb.TagNumber(33)
  $core.bool hasGameEnded() => $_has(11);
  @$pb.TagNumber(33)
  void clearGameEnded() => $_clearField(33);
  @$pb.TagNumber(33)
  GameEnded ensureGameEnded() => $_ensure(11);

  @$pb.TagNumber(34)
  Rejoined get rejoined => $_getN(12);
  @$pb.TagNumber(34)
  set rejoined(Rejoined value) => $_setField(34, value);
  @$pb.TagNumber(34)
  $core.bool hasRejoined() => $_has(12);
  @$pb.TagNumber(34)
  void clearRejoined() => $_clearField(34);
  @$pb.TagNumber(34)
  Rejoined ensureRejoined() => $_ensure(12);

  /// Errors not tied to a request the client is waiting on
  @$pb.TagNumber(90)
  BattleError get error => $_getN(13);
  @$pb.TagNumber(90)
  set error(BattleError value) => $_setField(90, value);
  @$pb.TagNumber(90)
  $core.bool hasError() => $_has(13);
  @$pb.TagNumber(90)
  void clearError() => $_clearField(90);
  @$pb.TagNumber(90)
  BattleError ensureError() => $_ensure(13);
}

class JoinBattleQueueRequest extends $pb.GeneratedMessage {
  factory JoinBattleQueueRequest({
    $core.String? token,
  }) {
    final result = JoinBattleQueueRequest._();
    if (token != null) result.token = token;
    return result;
  }

  JoinBattleQueueRequest._();

  factory JoinBattleQueueRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      JoinBattleQueueRequest()..mergeFromBuffer(data, registry);
  factory JoinBattleQueueRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      JoinBattleQueueRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JoinBattleQueueRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: JoinBattleQueueRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinBattleQueueRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinBattleQueueRequest copyWith(
          void Function(JoinBattleQueueRequest) updates) =>
      super.copyWith((message) => updates(message as JoinBattleQueueRequest))
          as JoinBattleQueueRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use JoinBattleQueueRequest() / JoinBattleQueueRequest.new instead')
  static JoinBattleQueueRequest create() => JoinBattleQueueRequest._();
  static $pb.GeneratedMessage $_createMessage() => JoinBattleQueueRequest._();
  @$core.override
  JoinBattleQueueRequest createEmptyInstance() => JoinBattleQueueRequest._();
  @$core.pragma('dart2js:noInline')
  static JoinBattleQueueRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JoinBattleQueueRequest>(
          JoinBattleQueueRequest.$_createMessage);
  static JoinBattleQueueRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);
}

class LeaveBattleQueueRequest extends $pb.GeneratedMessage {
  factory LeaveBattleQueueRequest({
    $core.String? token,
  }) {
    final result = LeaveBattleQueueRequest._();
    if (token != null) result.token = token;
    return result;
  }

  LeaveBattleQueueRequest._();

  factory LeaveBattleQueueRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LeaveBattleQueueRequest()..mergeFromBuffer(data, registry);
  factory LeaveBattleQueueRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LeaveBattleQueueRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LeaveBattleQueueRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: LeaveBattleQueueRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveBattleQueueRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveBattleQueueRequest copyWith(
          void Function(LeaveBattleQueueRequest) updates) =>
      super.copyWith((message) => updates(message as LeaveBattleQueueRequest))
          as LeaveBattleQueueRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use LeaveBattleQueueRequest() / LeaveBattleQueueRequest.new instead')
  static LeaveBattleQueueRequest create() => LeaveBattleQueueRequest._();
  static $pb.GeneratedMessage $_createMessage() => LeaveBattleQueueRequest._();
  @$core.override
  LeaveBattleQueueRequest createEmptyInstance() => LeaveBattleQueueRequest._();
  @$core.pragma('dart2js:noInline')
  static LeaveBattleQueueRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LeaveBattleQueueRequest>(
          LeaveBattleQueueRequest.$_createMessage);
  static LeaveBattleQueueRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);
}

class LeaveBattleQueueResponse extends $pb.GeneratedMessage {
  factory LeaveBattleQueueResponse({
    $core.bool? success,
  }) {
    final result = LeaveBattleQueueResponse._();
    if (success != null) result.success = success;
    return result;
  }

  LeaveBattleQueueResponse._();

  factory LeaveBattleQueueResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LeaveBattleQueueResponse()..mergeFromBuffer(data, registry);
  factory LeaveBattleQueueResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LeaveBattleQueueResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LeaveBattleQueueResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: LeaveBattleQueueResponse.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveBattleQueueResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveBattleQueueResponse copyWith(
          void Function(LeaveBattleQueueResponse) updates) =>
      super.copyWith((message) => updates(message as LeaveBattleQueueResponse))
          as LeaveBattleQueueResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use LeaveBattleQueueResponse() / LeaveBattleQueueResponse.new instead')
  static LeaveBattleQueueResponse create() => LeaveBattleQueueResponse._();
  static $pb.GeneratedMessage $_createMessage() => LeaveBattleQueueResponse._();
  @$core.override
  LeaveBattleQueueResponse createEmptyInstance() =>
      LeaveBattleQueueResponse._();
  @$core.pragma('dart2js:noInline')
  static LeaveBattleQueueResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LeaveBattleQueueResponse>(
          LeaveBattleQueueResponse.$_createMessage);
  static LeaveBattleQueueResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class ListBattlePlayersRequest extends $pb.GeneratedMessage {
  factory ListBattlePlayersRequest({
    $core.String? token,
  }) {
    final result = ListBattlePlayersRequest._();
    if (token != null) result.token = token;
    return result;
  }

  ListBattlePlayersRequest._();

  factory ListBattlePlayersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBattlePlayersRequest()..mergeFromBuffer(data, registry);
  factory ListBattlePlayersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBattlePlayersRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListBattlePlayersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: ListBattlePlayersRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBattlePlayersRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBattlePlayersRequest copyWith(
          void Function(ListBattlePlayersRequest) updates) =>
      super.copyWith((message) => updates(message as ListBattlePlayersRequest))
          as ListBattlePlayersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListBattlePlayersRequest() / ListBattlePlayersRequest.new instead')
  static ListBattlePlayersRequest create() => ListBattlePlayersRequest._();
  static $pb.GeneratedMessage $_createMessage() => ListBattlePlayersRequest._();
  @$core.override
  ListBattlePlayersRequest createEmptyInstance() =>
      ListBattlePlayersRequest._();
  @$core.pragma('dart2js:noInline')
  static ListBattlePlayersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListBattlePlayersRequest>(
          ListBattlePlayersRequest.$_createMessage);
  static ListBattlePlayersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);
}

class ListBattlePlayersResponse extends $pb.GeneratedMessage {
  factory ListBattlePlayersResponse({
    $core.Iterable<BattleStatus>? statuses,
  }) {
    final result = ListBattlePlayersResponse._();
    if (statuses != null) result.statuses.addAll(statuses);
    return result;
  }

  ListBattlePlayersResponse._();

  factory ListBattlePlayersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBattlePlayersResponse()..mergeFromBuffer(data, registry);
  factory ListBattlePlayersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBattlePlayersResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListBattlePlayersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: ListBattlePlayersResponse.$_createMessage)
    ..pPM<BattleStatus>(1, _omitFieldNames ? '' : 'statuses',
        subBuilder: BattleStatus.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBattlePlayersResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBattlePlayersResponse copyWith(
          void Function(ListBattlePlayersResponse) updates) =>
      super.copyWith((message) => updates(message as ListBattlePlayersResponse))
          as ListBattlePlayersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListBattlePlayersResponse() / ListBattlePlayersResponse.new instead')
  static ListBattlePlayersResponse create() => ListBattlePlayersResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ListBattlePlayersResponse._();
  @$core.override
  ListBattlePlayersResponse createEmptyInstance() =>
      ListBattlePlayersResponse._();
  @$core.pragma('dart2js:noInline')
  static ListBattlePlayersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListBattlePlayersResponse>(
          ListBattlePlayersResponse.$_createMessage);
  static ListBattlePlayersResponse? _defaultInstance;

  /// Everyone in the lobby except the caller, one entry per player.
  @$pb.TagNumber(1)
  $pb.PbList<BattleStatus> get statuses => $_getList(0);
}

class ChallengeRequest extends $pb.GeneratedMessage {
  factory ChallengeRequest({
    $core.String? token,
    $core.String? opponentId,
  }) {
    final result = ChallengeRequest._();
    if (token != null) result.token = token;
    if (opponentId != null) result.opponentId = opponentId;
    return result;
  }

  ChallengeRequest._();

  factory ChallengeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChallengeRequest()..mergeFromBuffer(data, registry);
  factory ChallengeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChallengeRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChallengeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: ChallengeRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'opponentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChallengeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChallengeRequest copyWith(void Function(ChallengeRequest) updates) =>
      super.copyWith((message) => updates(message as ChallengeRequest))
          as ChallengeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChallengeRequest() / ChallengeRequest.new instead')
  static ChallengeRequest create() => ChallengeRequest._();
  static $pb.GeneratedMessage $_createMessage() => ChallengeRequest._();
  @$core.override
  ChallengeRequest createEmptyInstance() => ChallengeRequest._();
  @$core.pragma('dart2js:noInline')
  static ChallengeRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChallengeRequest>(
          ChallengeRequest.$_createMessage);
  static ChallengeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get opponentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set opponentId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOpponentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOpponentId() => $_clearField(2);
}

class ChallengeResponse extends $pb.GeneratedMessage {
  factory ChallengeResponse({
    $core.String? challengeId,
  }) {
    final result = ChallengeResponse._();
    if (challengeId != null) result.challengeId = challengeId;
    return result;
  }

  ChallengeResponse._();

  factory ChallengeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChallengeResponse()..mergeFromBuffer(data, registry);
  factory ChallengeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChallengeResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChallengeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: ChallengeResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'challengeId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChallengeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChallengeResponse copyWith(void Function(ChallengeResponse) updates) =>
      super.copyWith((message) => updates(message as ChallengeResponse))
          as ChallengeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChallengeResponse() / ChallengeResponse.new instead')
  static ChallengeResponse create() => ChallengeResponse._();
  static $pb.GeneratedMessage $_createMessage() => ChallengeResponse._();
  @$core.override
  ChallengeResponse createEmptyInstance() => ChallengeResponse._();
  @$core.pragma('dart2js:noInline')
  static ChallengeResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChallengeResponse>(
          ChallengeResponse.$_createMessage);
  static ChallengeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get challengeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set challengeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChallengeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChallengeId() => $_clearField(1);
}

class CancelChallengeRequest extends $pb.GeneratedMessage {
  factory CancelChallengeRequest({
    $core.String? token,
    $core.String? challengeId,
    $core.String? opponentId,
  }) {
    final result = CancelChallengeRequest._();
    if (token != null) result.token = token;
    if (challengeId != null) result.challengeId = challengeId;
    if (opponentId != null) result.opponentId = opponentId;
    return result;
  }

  CancelChallengeRequest._();

  factory CancelChallengeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CancelChallengeRequest()..mergeFromBuffer(data, registry);
  factory CancelChallengeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CancelChallengeRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelChallengeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: CancelChallengeRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'challengeId')
    ..aOS(3, _omitFieldNames ? '' : 'opponentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelChallengeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelChallengeRequest copyWith(
          void Function(CancelChallengeRequest) updates) =>
      super.copyWith((message) => updates(message as CancelChallengeRequest))
          as CancelChallengeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CancelChallengeRequest() / CancelChallengeRequest.new instead')
  static CancelChallengeRequest create() => CancelChallengeRequest._();
  static $pb.GeneratedMessage $_createMessage() => CancelChallengeRequest._();
  @$core.override
  CancelChallengeRequest createEmptyInstance() => CancelChallengeRequest._();
  @$core.pragma('dart2js:noInline')
  static CancelChallengeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelChallengeRequest>(
          CancelChallengeRequest.$_createMessage);
  static CancelChallengeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get challengeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set challengeId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChallengeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChallengeId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get opponentId => $_getSZ(2);
  @$pb.TagNumber(3)
  set opponentId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOpponentId() => $_has(2);
  @$pb.TagNumber(3)
  void clearOpponentId() => $_clearField(3);
}

class CancelChallengeResponse extends $pb.GeneratedMessage {
  factory CancelChallengeResponse({
    $core.bool? success,
  }) {
    final result = CancelChallengeResponse._();
    if (success != null) result.success = success;
    return result;
  }

  CancelChallengeResponse._();

  factory CancelChallengeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CancelChallengeResponse()..mergeFromBuffer(data, registry);
  factory CancelChallengeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CancelChallengeResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelChallengeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: CancelChallengeResponse.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelChallengeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelChallengeResponse copyWith(
          void Function(CancelChallengeResponse) updates) =>
      super.copyWith((message) => updates(message as CancelChallengeResponse))
          as CancelChallengeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CancelChallengeResponse() / CancelChallengeResponse.new instead')
  static CancelChallengeResponse create() => CancelChallengeResponse._();
  static $pb.GeneratedMessage $_createMessage() => CancelChallengeResponse._();
  @$core.override
  CancelChallengeResponse createEmptyInstance() => CancelChallengeResponse._();
  @$core.pragma('dart2js:noInline')
  static CancelChallengeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelChallengeResponse>(
          CancelChallengeResponse.$_createMessage);
  static CancelChallengeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class AcceptChallengeRequest extends $pb.GeneratedMessage {
  factory AcceptChallengeRequest({
    $core.String? token,
    $core.String? challengeId,
    $core.String? challengerId,
  }) {
    final result = AcceptChallengeRequest._();
    if (token != null) result.token = token;
    if (challengeId != null) result.challengeId = challengeId;
    if (challengerId != null) result.challengerId = challengerId;
    return result;
  }

  AcceptChallengeRequest._();

  factory AcceptChallengeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AcceptChallengeRequest()..mergeFromBuffer(data, registry);
  factory AcceptChallengeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AcceptChallengeRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AcceptChallengeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: AcceptChallengeRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'challengeId')
    ..aOS(3, _omitFieldNames ? '' : 'challengerId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcceptChallengeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcceptChallengeRequest copyWith(
          void Function(AcceptChallengeRequest) updates) =>
      super.copyWith((message) => updates(message as AcceptChallengeRequest))
          as AcceptChallengeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use AcceptChallengeRequest() / AcceptChallengeRequest.new instead')
  static AcceptChallengeRequest create() => AcceptChallengeRequest._();
  static $pb.GeneratedMessage $_createMessage() => AcceptChallengeRequest._();
  @$core.override
  AcceptChallengeRequest createEmptyInstance() => AcceptChallengeRequest._();
  @$core.pragma('dart2js:noInline')
  static AcceptChallengeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AcceptChallengeRequest>(
          AcceptChallengeRequest.$_createMessage);
  static AcceptChallengeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get challengeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set challengeId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChallengeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChallengeId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get challengerId => $_getSZ(2);
  @$pb.TagNumber(3)
  set challengerId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChallengerId() => $_has(2);
  @$pb.TagNumber(3)
  void clearChallengerId() => $_clearField(3);
}

class AcceptChallengeResponse extends $pb.GeneratedMessage {
  factory AcceptChallengeResponse({
    BattleState? state,
  }) {
    final result = AcceptChallengeResponse._();
    if (state != null) result.state = state;
    return result;
  }

  AcceptChallengeResponse._();

  factory AcceptChallengeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AcceptChallengeResponse()..mergeFromBuffer(data, registry);
  factory AcceptChallengeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AcceptChallengeResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AcceptChallengeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: AcceptChallengeResponse.$_createMessage)
    ..aOM<BattleState>(1, _omitFieldNames ? '' : 'state',
        subBuilder: BattleState.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcceptChallengeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcceptChallengeResponse copyWith(
          void Function(AcceptChallengeResponse) updates) =>
      super.copyWith((message) => updates(message as AcceptChallengeResponse))
          as AcceptChallengeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use AcceptChallengeResponse() / AcceptChallengeResponse.new instead')
  static AcceptChallengeResponse create() => AcceptChallengeResponse._();
  static $pb.GeneratedMessage $_createMessage() => AcceptChallengeResponse._();
  @$core.override
  AcceptChallengeResponse createEmptyInstance() => AcceptChallengeResponse._();
  @$core.pragma('dart2js:noInline')
  static AcceptChallengeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AcceptChallengeResponse>(
          AcceptChallengeResponse.$_createMessage);
  static AcceptChallengeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BattleState get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(BattleState value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);
  @$pb.TagNumber(1)
  BattleState ensureState() => $_ensure(0);
}

class RejectChallengeRequest extends $pb.GeneratedMessage {
  factory RejectChallengeRequest({
    $core.String? token,
    $core.String? challengeId,
    $core.String? challengerId,
  }) {
    final result = RejectChallengeRequest._();
    if (token != null) result.token = token;
    if (challengeId != null) result.challengeId = challengeId;
    if (challengerId != null) result.challengerId = challengerId;
    return result;
  }

  RejectChallengeRequest._();

  factory RejectChallengeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RejectChallengeRequest()..mergeFromBuffer(data, registry);
  factory RejectChallengeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RejectChallengeRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RejectChallengeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: RejectChallengeRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'challengeId')
    ..aOS(3, _omitFieldNames ? '' : 'challengerId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RejectChallengeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RejectChallengeRequest copyWith(
          void Function(RejectChallengeRequest) updates) =>
      super.copyWith((message) => updates(message as RejectChallengeRequest))
          as RejectChallengeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RejectChallengeRequest() / RejectChallengeRequest.new instead')
  static RejectChallengeRequest create() => RejectChallengeRequest._();
  static $pb.GeneratedMessage $_createMessage() => RejectChallengeRequest._();
  @$core.override
  RejectChallengeRequest createEmptyInstance() => RejectChallengeRequest._();
  @$core.pragma('dart2js:noInline')
  static RejectChallengeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RejectChallengeRequest>(
          RejectChallengeRequest.$_createMessage);
  static RejectChallengeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get challengeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set challengeId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChallengeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChallengeId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get challengerId => $_getSZ(2);
  @$pb.TagNumber(3)
  set challengerId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChallengerId() => $_has(2);
  @$pb.TagNumber(3)
  void clearChallengerId() => $_clearField(3);
}

class RejectChallengeResponse extends $pb.GeneratedMessage {
  factory RejectChallengeResponse({
    $core.bool? success,
  }) {
    final result = RejectChallengeResponse._();
    if (success != null) result.success = success;
    return result;
  }

  RejectChallengeResponse._();

  factory RejectChallengeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RejectChallengeResponse()..mergeFromBuffer(data, registry);
  factory RejectChallengeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RejectChallengeResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RejectChallengeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: RejectChallengeResponse.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RejectChallengeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RejectChallengeResponse copyWith(
          void Function(RejectChallengeResponse) updates) =>
      super.copyWith((message) => updates(message as RejectChallengeResponse))
          as RejectChallengeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RejectChallengeResponse() / RejectChallengeResponse.new instead')
  static RejectChallengeResponse create() => RejectChallengeResponse._();
  static $pb.GeneratedMessage $_createMessage() => RejectChallengeResponse._();
  @$core.override
  RejectChallengeResponse createEmptyInstance() => RejectChallengeResponse._();
  @$core.pragma('dart2js:noInline')
  static RejectChallengeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RejectChallengeResponse>(
          RejectChallengeResponse.$_createMessage);
  static RejectChallengeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class ChooseMnstrRequest extends $pb.GeneratedMessage {
  factory ChooseMnstrRequest({
    $core.String? token,
    $core.String? battleId,
    $core.String? mnstrId,
  }) {
    final result = ChooseMnstrRequest._();
    if (token != null) result.token = token;
    if (battleId != null) result.battleId = battleId;
    if (mnstrId != null) result.mnstrId = mnstrId;
    return result;
  }

  ChooseMnstrRequest._();

  factory ChooseMnstrRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChooseMnstrRequest()..mergeFromBuffer(data, registry);
  factory ChooseMnstrRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChooseMnstrRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChooseMnstrRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: ChooseMnstrRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'battleId')
    ..aOS(3, _omitFieldNames ? '' : 'mnstrId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChooseMnstrRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChooseMnstrRequest copyWith(void Function(ChooseMnstrRequest) updates) =>
      super.copyWith((message) => updates(message as ChooseMnstrRequest))
          as ChooseMnstrRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChooseMnstrRequest() / ChooseMnstrRequest.new instead')
  static ChooseMnstrRequest create() => ChooseMnstrRequest._();
  static $pb.GeneratedMessage $_createMessage() => ChooseMnstrRequest._();
  @$core.override
  ChooseMnstrRequest createEmptyInstance() => ChooseMnstrRequest._();
  @$core.pragma('dart2js:noInline')
  static ChooseMnstrRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChooseMnstrRequest>(
          ChooseMnstrRequest.$_createMessage);
  static ChooseMnstrRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get battleId => $_getSZ(1);
  @$pb.TagNumber(2)
  set battleId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBattleId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBattleId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get mnstrId => $_getSZ(2);
  @$pb.TagNumber(3)
  set mnstrId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMnstrId() => $_has(2);
  @$pb.TagNumber(3)
  void clearMnstrId() => $_clearField(3);
}

class ChooseMnstrResponse extends $pb.GeneratedMessage {
  factory ChooseMnstrResponse({
    BattleState? state,
  }) {
    final result = ChooseMnstrResponse._();
    if (state != null) result.state = state;
    return result;
  }

  ChooseMnstrResponse._();

  factory ChooseMnstrResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChooseMnstrResponse()..mergeFromBuffer(data, registry);
  factory ChooseMnstrResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChooseMnstrResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChooseMnstrResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: ChooseMnstrResponse.$_createMessage)
    ..aOM<BattleState>(1, _omitFieldNames ? '' : 'state',
        subBuilder: BattleState.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChooseMnstrResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChooseMnstrResponse copyWith(void Function(ChooseMnstrResponse) updates) =>
      super.copyWith((message) => updates(message as ChooseMnstrResponse))
          as ChooseMnstrResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ChooseMnstrResponse() / ChooseMnstrResponse.new instead')
  static ChooseMnstrResponse create() => ChooseMnstrResponse._();
  static $pb.GeneratedMessage $_createMessage() => ChooseMnstrResponse._();
  @$core.override
  ChooseMnstrResponse createEmptyInstance() => ChooseMnstrResponse._();
  @$core.pragma('dart2js:noInline')
  static ChooseMnstrResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChooseMnstrResponse>(
          ChooseMnstrResponse.$_createMessage);
  static ChooseMnstrResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BattleState get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(BattleState value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);
  @$pb.TagNumber(1)
  BattleState ensureState() => $_ensure(0);
}

class TurnRequest extends $pb.GeneratedMessage {
  factory TurnRequest({
    $core.String? token,
    $core.String? battleId,
  }) {
    final result = TurnRequest._();
    if (token != null) result.token = token;
    if (battleId != null) result.battleId = battleId;
    return result;
  }

  TurnRequest._();

  factory TurnRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TurnRequest()..mergeFromBuffer(data, registry);
  factory TurnRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TurnRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TurnRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: TurnRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'battleId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TurnRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TurnRequest copyWith(void Function(TurnRequest) updates) =>
      super.copyWith((message) => updates(message as TurnRequest))
          as TurnRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TurnRequest() / TurnRequest.new instead')
  static TurnRequest create() => TurnRequest._();
  static $pb.GeneratedMessage $_createMessage() => TurnRequest._();
  @$core.override
  TurnRequest createEmptyInstance() => TurnRequest._();
  @$core.pragma('dart2js:noInline')
  static TurnRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TurnRequest>(
          TurnRequest.$_createMessage);
  static TurnRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get battleId => $_getSZ(1);
  @$pb.TagNumber(2)
  set battleId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBattleId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBattleId() => $_clearField(2);
}

class TurnResponse extends $pb.GeneratedMessage {
  factory TurnResponse({
    TurnResult? result,
    BattleState? state,
    GameEnded? gameEnded,
  }) {
    final result$ = TurnResponse._();
    if (result != null) result$.result = result;
    if (state != null) result$.state = state;
    if (gameEnded != null) result$.gameEnded = gameEnded;
    return result$;
  }

  TurnResponse._();

  factory TurnResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TurnResponse()..mergeFromBuffer(data, registry);
  factory TurnResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TurnResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TurnResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: TurnResponse.$_createMessage)
    ..aOM<TurnResult>(1, _omitFieldNames ? '' : 'result',
        subBuilder: TurnResult.$_createMessage)
    ..aOM<BattleState>(2, _omitFieldNames ? '' : 'state',
        subBuilder: BattleState.$_createMessage)
    ..aOM<GameEnded>(3, _omitFieldNames ? '' : 'gameEnded',
        subBuilder: GameEnded.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TurnResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TurnResponse copyWith(void Function(TurnResponse) updates) =>
      super.copyWith((message) => updates(message as TurnResponse))
          as TurnResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TurnResponse() / TurnResponse.new instead')
  static TurnResponse create() => TurnResponse._();
  static $pb.GeneratedMessage $_createMessage() => TurnResponse._();
  @$core.override
  TurnResponse createEmptyInstance() => TurnResponse._();
  @$core.pragma('dart2js:noInline')
  static TurnResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TurnResponse>(
          TurnResponse.$_createMessage);
  static TurnResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TurnResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(TurnResult value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => $_clearField(1);
  @$pb.TagNumber(1)
  TurnResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  BattleState get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(BattleState value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => $_clearField(2);
  @$pb.TagNumber(2)
  BattleState ensureState() => $_ensure(1);

  /// Set when this turn knocked the other mnstr out.
  @$pb.TagNumber(3)
  GameEnded get gameEnded => $_getN(2);
  @$pb.TagNumber(3)
  set gameEnded(GameEnded value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasGameEnded() => $_has(2);
  @$pb.TagNumber(3)
  void clearGameEnded() => $_clearField(3);
  @$pb.TagNumber(3)
  GameEnded ensureGameEnded() => $_ensure(2);
}

class EscapeRequest extends $pb.GeneratedMessage {
  factory EscapeRequest({
    $core.String? token,
    $core.String? battleId,
  }) {
    final result = EscapeRequest._();
    if (token != null) result.token = token;
    if (battleId != null) result.battleId = battleId;
    return result;
  }

  EscapeRequest._();

  factory EscapeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EscapeRequest()..mergeFromBuffer(data, registry);
  factory EscapeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EscapeRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EscapeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: EscapeRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'battleId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EscapeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EscapeRequest copyWith(void Function(EscapeRequest) updates) =>
      super.copyWith((message) => updates(message as EscapeRequest))
          as EscapeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use EscapeRequest() / EscapeRequest.new instead')
  static EscapeRequest create() => EscapeRequest._();
  static $pb.GeneratedMessage $_createMessage() => EscapeRequest._();
  @$core.override
  EscapeRequest createEmptyInstance() => EscapeRequest._();
  @$core.pragma('dart2js:noInline')
  static EscapeRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EscapeRequest>(
          EscapeRequest.$_createMessage);
  static EscapeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get battleId => $_getSZ(1);
  @$pb.TagNumber(2)
  set battleId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBattleId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBattleId() => $_clearField(2);
}

class EscapeResponse extends $pb.GeneratedMessage {
  factory EscapeResponse({
    GameEnded? gameEnded,
  }) {
    final result = EscapeResponse._();
    if (gameEnded != null) result.gameEnded = gameEnded;
    return result;
  }

  EscapeResponse._();

  factory EscapeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EscapeResponse()..mergeFromBuffer(data, registry);
  factory EscapeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EscapeResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EscapeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: EscapeResponse.$_createMessage)
    ..aOM<GameEnded>(1, _omitFieldNames ? '' : 'gameEnded',
        subBuilder: GameEnded.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EscapeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EscapeResponse copyWith(void Function(EscapeResponse) updates) =>
      super.copyWith((message) => updates(message as EscapeResponse))
          as EscapeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use EscapeResponse() / EscapeResponse.new instead')
  static EscapeResponse create() => EscapeResponse._();
  static $pb.GeneratedMessage $_createMessage() => EscapeResponse._();
  @$core.override
  EscapeResponse createEmptyInstance() => EscapeResponse._();
  @$core.pragma('dart2js:noInline')
  static EscapeResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EscapeResponse>(
          EscapeResponse.$_createMessage);
  static EscapeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GameEnded get gameEnded => $_getN(0);
  @$pb.TagNumber(1)
  set gameEnded(GameEnded value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGameEnded() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameEnded() => $_clearField(1);
  @$pb.TagNumber(1)
  GameEnded ensureGameEnded() => $_ensure(0);
}

class RejoinRequest extends $pb.GeneratedMessage {
  factory RejoinRequest({
    $core.String? token,
    $core.String? battleId,
  }) {
    final result = RejoinRequest._();
    if (token != null) result.token = token;
    if (battleId != null) result.battleId = battleId;
    return result;
  }

  RejoinRequest._();

  factory RejoinRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RejoinRequest()..mergeFromBuffer(data, registry);
  factory RejoinRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RejoinRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RejoinRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: RejoinRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'battleId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RejoinRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RejoinRequest copyWith(void Function(RejoinRequest) updates) =>
      super.copyWith((message) => updates(message as RejoinRequest))
          as RejoinRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RejoinRequest() / RejoinRequest.new instead')
  static RejoinRequest create() => RejoinRequest._();
  static $pb.GeneratedMessage $_createMessage() => RejoinRequest._();
  @$core.override
  RejoinRequest createEmptyInstance() => RejoinRequest._();
  @$core.pragma('dart2js:noInline')
  static RejoinRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RejoinRequest>(
          RejoinRequest.$_createMessage);
  static RejoinRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get battleId => $_getSZ(1);
  @$pb.TagNumber(2)
  set battleId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBattleId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBattleId() => $_clearField(2);
}

class RejoinResponse extends $pb.GeneratedMessage {
  factory RejoinResponse({
    BattleState? state,
  }) {
    final result = RejoinResponse._();
    if (state != null) result.state = state;
    return result;
  }

  RejoinResponse._();

  factory RejoinResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RejoinResponse()..mergeFromBuffer(data, registry);
  factory RejoinResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RejoinResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RejoinResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: RejoinResponse.$_createMessage)
    ..aOM<BattleState>(1, _omitFieldNames ? '' : 'state',
        subBuilder: BattleState.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RejoinResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RejoinResponse copyWith(void Function(RejoinResponse) updates) =>
      super.copyWith((message) => updates(message as RejoinResponse))
          as RejoinResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RejoinResponse() / RejoinResponse.new instead')
  static RejoinResponse create() => RejoinResponse._();
  static $pb.GeneratedMessage $_createMessage() => RejoinResponse._();
  @$core.override
  RejoinResponse createEmptyInstance() => RejoinResponse._();
  @$core.pragma('dart2js:noInline')
  static RejoinResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RejoinResponse>(
          RejoinResponse.$_createMessage);
  static RejoinResponse? _defaultInstance;

  @$pb.TagNumber(1)
  BattleState get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(BattleState value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);
  @$pb.TagNumber(1)
  BattleState ensureState() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
