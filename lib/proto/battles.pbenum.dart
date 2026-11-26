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

class BattleStatusState extends $pb.ProtobufEnum {
  static const BattleStatusState BATTLE_STATUS_STATE_UNSPECIFIED =
      BattleStatusState._(
          0, _omitEnumNames ? '' : 'BATTLE_STATUS_STATE_UNSPECIFIED');
  static const BattleStatusState BATTLE_STATUS_STATE_IN_QUEUE =
      BattleStatusState._(
          1, _omitEnumNames ? '' : 'BATTLE_STATUS_STATE_IN_QUEUE');
  static const BattleStatusState BATTLE_STATUS_STATE_IN_BATTLE =
      BattleStatusState._(
          2, _omitEnumNames ? '' : 'BATTLE_STATUS_STATE_IN_BATTLE');
  static const BattleStatusState BATTLE_STATUS_STATE_WATCHING =
      BattleStatusState._(
          3, _omitEnumNames ? '' : 'BATTLE_STATUS_STATE_WATCHING');

  static const $core.List<BattleStatusState> values = <BattleStatusState>[
    BATTLE_STATUS_STATE_UNSPECIFIED,
    BATTLE_STATUS_STATE_IN_QUEUE,
    BATTLE_STATUS_STATE_IN_BATTLE,
    BATTLE_STATUS_STATE_WATCHING,
  ];

  static final $core.List<BattleStatusState?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static BattleStatusState? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BattleStatusState._(super.value, super.name);
}

class BattlePhase extends $pb.ProtobufEnum {
  static const BattlePhase BATTLE_PHASE_UNSPECIFIED =
      BattlePhase._(0, _omitEnumNames ? '' : 'BATTLE_PHASE_UNSPECIFIED');

  /// Challenge accepted; both players are picking a mnstr.
  static const BattlePhase BATTLE_PHASE_CHOOSING_MNSTRS =
      BattlePhase._(1, _omitEnumNames ? '' : 'BATTLE_PHASE_CHOOSING_MNSTRS');

  /// Both mnstrs chosen; players take turns.
  static const BattlePhase BATTLE_PHASE_IN_PROGRESS =
      BattlePhase._(2, _omitEnumNames ? '' : 'BATTLE_PHASE_IN_PROGRESS');
  static const BattlePhase BATTLE_PHASE_ENDED =
      BattlePhase._(3, _omitEnumNames ? '' : 'BATTLE_PHASE_ENDED');

  static const $core.List<BattlePhase> values = <BattlePhase>[
    BATTLE_PHASE_UNSPECIFIED,
    BATTLE_PHASE_CHOOSING_MNSTRS,
    BATTLE_PHASE_IN_PROGRESS,
    BATTLE_PHASE_ENDED,
  ];

  static final $core.List<BattlePhase?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static BattlePhase? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BattlePhase._(super.value, super.name);
}

class BattleTurnAction extends $pb.ProtobufEnum {
  static const BattleTurnAction BATTLE_TURN_ACTION_UNSPECIFIED =
      BattleTurnAction._(
          0, _omitEnumNames ? '' : 'BATTLE_TURN_ACTION_UNSPECIFIED');
  static const BattleTurnAction BATTLE_TURN_ACTION_ATTACK =
      BattleTurnAction._(1, _omitEnumNames ? '' : 'BATTLE_TURN_ACTION_ATTACK');
  static const BattleTurnAction BATTLE_TURN_ACTION_DEFEND =
      BattleTurnAction._(2, _omitEnumNames ? '' : 'BATTLE_TURN_ACTION_DEFEND');
  static const BattleTurnAction BATTLE_TURN_ACTION_MAGIC =
      BattleTurnAction._(3, _omitEnumNames ? '' : 'BATTLE_TURN_ACTION_MAGIC');

  static const $core.List<BattleTurnAction> values = <BattleTurnAction>[
    BATTLE_TURN_ACTION_UNSPECIFIED,
    BATTLE_TURN_ACTION_ATTACK,
    BATTLE_TURN_ACTION_DEFEND,
    BATTLE_TURN_ACTION_MAGIC,
  ];

  static final $core.List<BattleTurnAction?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static BattleTurnAction? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BattleTurnAction._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
