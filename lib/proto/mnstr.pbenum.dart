// This is a generated file - do not edit.
//
// Generated from mnstr.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MnstrOrderBy extends $pb.ProtobufEnum {
  static const MnstrOrderBy MNSTR_ORDER_BY_UNSPECIFIED =
      MnstrOrderBy._(0, _omitEnumNames ? '' : 'MNSTR_ORDER_BY_UNSPECIFIED');
  static const MnstrOrderBy MNSTR_ORDER_BY_CREATED_AT =
      MnstrOrderBy._(1, _omitEnumNames ? '' : 'MNSTR_ORDER_BY_CREATED_AT');
  static const MnstrOrderBy MNSTR_ORDER_BY_UPDATED_AT =
      MnstrOrderBy._(2, _omitEnumNames ? '' : 'MNSTR_ORDER_BY_UPDATED_AT');
  static const MnstrOrderBy MNSTR_ORDER_BY_NAME =
      MnstrOrderBy._(3, _omitEnumNames ? '' : 'MNSTR_ORDER_BY_NAME');
  static const MnstrOrderBy MNSTR_ORDER_BY_LEVEL =
      MnstrOrderBy._(4, _omitEnumNames ? '' : 'MNSTR_ORDER_BY_LEVEL');
  static const MnstrOrderBy MNSTR_ORDER_BY_EXPERIENCE =
      MnstrOrderBy._(5, _omitEnumNames ? '' : 'MNSTR_ORDER_BY_EXPERIENCE');
  static const MnstrOrderBy MNSTR_ORDER_BY_HEALTH =
      MnstrOrderBy._(6, _omitEnumNames ? '' : 'MNSTR_ORDER_BY_HEALTH');
  static const MnstrOrderBy MNSTR_ORDER_BY_ATTACK =
      MnstrOrderBy._(7, _omitEnumNames ? '' : 'MNSTR_ORDER_BY_ATTACK');
  static const MnstrOrderBy MNSTR_ORDER_BY_DEFENSE =
      MnstrOrderBy._(8, _omitEnumNames ? '' : 'MNSTR_ORDER_BY_DEFENSE');
  static const MnstrOrderBy MNSTR_ORDER_BY_SPEED =
      MnstrOrderBy._(9, _omitEnumNames ? '' : 'MNSTR_ORDER_BY_SPEED');
  static const MnstrOrderBy MNSTR_ORDER_BY_INTELLIGENCE =
      MnstrOrderBy._(10, _omitEnumNames ? '' : 'MNSTR_ORDER_BY_INTELLIGENCE');
  static const MnstrOrderBy MNSTR_ORDER_BY_MAGIC =
      MnstrOrderBy._(11, _omitEnumNames ? '' : 'MNSTR_ORDER_BY_MAGIC');

  static const $core.List<MnstrOrderBy> values = <MnstrOrderBy>[
    MNSTR_ORDER_BY_UNSPECIFIED,
    MNSTR_ORDER_BY_CREATED_AT,
    MNSTR_ORDER_BY_UPDATED_AT,
    MNSTR_ORDER_BY_NAME,
    MNSTR_ORDER_BY_LEVEL,
    MNSTR_ORDER_BY_EXPERIENCE,
    MNSTR_ORDER_BY_HEALTH,
    MNSTR_ORDER_BY_ATTACK,
    MNSTR_ORDER_BY_DEFENSE,
    MNSTR_ORDER_BY_SPEED,
    MNSTR_ORDER_BY_INTELLIGENCE,
    MNSTR_ORDER_BY_MAGIC,
  ];

  static final $core.List<MnstrOrderBy?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 11);
  static MnstrOrderBy? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MnstrOrderBy._(super.value, super.name);
}

class MnstrOrderDirection extends $pb.ProtobufEnum {
  static const MnstrOrderDirection MNSTR_ORDER_DIRECTION_UNSPECIFIED =
      MnstrOrderDirection._(
          0, _omitEnumNames ? '' : 'MNSTR_ORDER_DIRECTION_UNSPECIFIED');
  static const MnstrOrderDirection MNSTR_ORDER_DIRECTION_ASC =
      MnstrOrderDirection._(
          1, _omitEnumNames ? '' : 'MNSTR_ORDER_DIRECTION_ASC');
  static const MnstrOrderDirection MNSTR_ORDER_DIRECTION_DESC =
      MnstrOrderDirection._(
          2, _omitEnumNames ? '' : 'MNSTR_ORDER_DIRECTION_DESC');

  static const $core.List<MnstrOrderDirection> values = <MnstrOrderDirection>[
    MNSTR_ORDER_DIRECTION_UNSPECIFIED,
    MNSTR_ORDER_DIRECTION_ASC,
    MNSTR_ORDER_DIRECTION_DESC,
  ];

  static final $core.List<MnstrOrderDirection?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static MnstrOrderDirection? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MnstrOrderDirection._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
