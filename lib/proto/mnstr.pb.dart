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

import 'mnstr.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'mnstr.pbenum.dart';

class Mnstr extends $pb.GeneratedMessage {
  factory Mnstr({
    $core.String? id,
    $core.String? userId,
    $core.String? mnstrName,
    $core.String? mnstrDescription,
    $core.String? mnstrQrCode,
    $core.int? currentLevel,
    $core.int? currentExperience,
    $core.int? currentHealth,
    $core.int? maxHealth,
    $core.int? currentAttack,
    $core.int? maxAttack,
    $core.int? currentDefense,
    $core.int? maxDefense,
    $core.int? currentSpeed,
    $core.int? maxSpeed,
    $core.int? currentIntelligence,
    $core.int? maxIntelligence,
    $core.int? currentMagic,
    $core.int? maxMagic,
    $core.int? experienceToNextLevel,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (mnstrName != null) result.mnstrName = mnstrName;
    if (mnstrDescription != null) result.mnstrDescription = mnstrDescription;
    if (mnstrQrCode != null) result.mnstrQrCode = mnstrQrCode;
    if (currentLevel != null) result.currentLevel = currentLevel;
    if (currentExperience != null) result.currentExperience = currentExperience;
    if (currentHealth != null) result.currentHealth = currentHealth;
    if (maxHealth != null) result.maxHealth = maxHealth;
    if (currentAttack != null) result.currentAttack = currentAttack;
    if (maxAttack != null) result.maxAttack = maxAttack;
    if (currentDefense != null) result.currentDefense = currentDefense;
    if (maxDefense != null) result.maxDefense = maxDefense;
    if (currentSpeed != null) result.currentSpeed = currentSpeed;
    if (maxSpeed != null) result.maxSpeed = maxSpeed;
    if (currentIntelligence != null)
      result.currentIntelligence = currentIntelligence;
    if (maxIntelligence != null) result.maxIntelligence = maxIntelligence;
    if (currentMagic != null) result.currentMagic = currentMagic;
    if (maxMagic != null) result.maxMagic = maxMagic;
    if (experienceToNextLevel != null)
      result.experienceToNextLevel = experienceToNextLevel;
    return result;
  }

  Mnstr._();

  factory Mnstr.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Mnstr.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Mnstr',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'mnstrName')
    ..aOS(4, _omitFieldNames ? '' : 'mnstrDescription')
    ..aOS(5, _omitFieldNames ? '' : 'mnstrQrCode')
    ..aI(6, _omitFieldNames ? '' : 'currentLevel')
    ..aI(7, _omitFieldNames ? '' : 'currentExperience')
    ..aI(8, _omitFieldNames ? '' : 'currentHealth')
    ..aI(9, _omitFieldNames ? '' : 'maxHealth')
    ..aI(10, _omitFieldNames ? '' : 'currentAttack')
    ..aI(11, _omitFieldNames ? '' : 'maxAttack')
    ..aI(12, _omitFieldNames ? '' : 'currentDefense')
    ..aI(13, _omitFieldNames ? '' : 'maxDefense')
    ..aI(14, _omitFieldNames ? '' : 'currentSpeed')
    ..aI(15, _omitFieldNames ? '' : 'maxSpeed')
    ..aI(16, _omitFieldNames ? '' : 'currentIntelligence')
    ..aI(17, _omitFieldNames ? '' : 'maxIntelligence')
    ..aI(18, _omitFieldNames ? '' : 'currentMagic')
    ..aI(19, _omitFieldNames ? '' : 'maxMagic')
    ..aI(20, _omitFieldNames ? '' : 'experienceToNextLevel')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Mnstr clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Mnstr copyWith(void Function(Mnstr) updates) =>
      super.copyWith((message) => updates(message as Mnstr)) as Mnstr;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Mnstr create() => Mnstr._();
  @$core.override
  Mnstr createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Mnstr getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Mnstr>(create);
  static Mnstr? _defaultInstance;

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
  $core.String get mnstrName => $_getSZ(2);
  @$pb.TagNumber(3)
  set mnstrName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMnstrName() => $_has(2);
  @$pb.TagNumber(3)
  void clearMnstrName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get mnstrDescription => $_getSZ(3);
  @$pb.TagNumber(4)
  set mnstrDescription($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMnstrDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearMnstrDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get mnstrQrCode => $_getSZ(4);
  @$pb.TagNumber(5)
  set mnstrQrCode($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMnstrQrCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearMnstrQrCode() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get currentLevel => $_getIZ(5);
  @$pb.TagNumber(6)
  set currentLevel($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrentLevel() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrentLevel() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get currentExperience => $_getIZ(6);
  @$pb.TagNumber(7)
  set currentExperience($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrentExperience() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrentExperience() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get currentHealth => $_getIZ(7);
  @$pb.TagNumber(8)
  set currentHealth($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCurrentHealth() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrentHealth() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get maxHealth => $_getIZ(8);
  @$pb.TagNumber(9)
  set maxHealth($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMaxHealth() => $_has(8);
  @$pb.TagNumber(9)
  void clearMaxHealth() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get currentAttack => $_getIZ(9);
  @$pb.TagNumber(10)
  set currentAttack($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCurrentAttack() => $_has(9);
  @$pb.TagNumber(10)
  void clearCurrentAttack() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get maxAttack => $_getIZ(10);
  @$pb.TagNumber(11)
  set maxAttack($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMaxAttack() => $_has(10);
  @$pb.TagNumber(11)
  void clearMaxAttack() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get currentDefense => $_getIZ(11);
  @$pb.TagNumber(12)
  set currentDefense($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCurrentDefense() => $_has(11);
  @$pb.TagNumber(12)
  void clearCurrentDefense() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get maxDefense => $_getIZ(12);
  @$pb.TagNumber(13)
  set maxDefense($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasMaxDefense() => $_has(12);
  @$pb.TagNumber(13)
  void clearMaxDefense() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get currentSpeed => $_getIZ(13);
  @$pb.TagNumber(14)
  set currentSpeed($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCurrentSpeed() => $_has(13);
  @$pb.TagNumber(14)
  void clearCurrentSpeed() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get maxSpeed => $_getIZ(14);
  @$pb.TagNumber(15)
  set maxSpeed($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasMaxSpeed() => $_has(14);
  @$pb.TagNumber(15)
  void clearMaxSpeed() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.int get currentIntelligence => $_getIZ(15);
  @$pb.TagNumber(16)
  set currentIntelligence($core.int value) => $_setSignedInt32(15, value);
  @$pb.TagNumber(16)
  $core.bool hasCurrentIntelligence() => $_has(15);
  @$pb.TagNumber(16)
  void clearCurrentIntelligence() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.int get maxIntelligence => $_getIZ(16);
  @$pb.TagNumber(17)
  set maxIntelligence($core.int value) => $_setSignedInt32(16, value);
  @$pb.TagNumber(17)
  $core.bool hasMaxIntelligence() => $_has(16);
  @$pb.TagNumber(17)
  void clearMaxIntelligence() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.int get currentMagic => $_getIZ(17);
  @$pb.TagNumber(18)
  set currentMagic($core.int value) => $_setSignedInt32(17, value);
  @$pb.TagNumber(18)
  $core.bool hasCurrentMagic() => $_has(17);
  @$pb.TagNumber(18)
  void clearCurrentMagic() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.int get maxMagic => $_getIZ(18);
  @$pb.TagNumber(19)
  set maxMagic($core.int value) => $_setSignedInt32(18, value);
  @$pb.TagNumber(19)
  $core.bool hasMaxMagic() => $_has(18);
  @$pb.TagNumber(19)
  void clearMaxMagic() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.int get experienceToNextLevel => $_getIZ(19);
  @$pb.TagNumber(20)
  set experienceToNextLevel($core.int value) => $_setSignedInt32(19, value);
  @$pb.TagNumber(20)
  $core.bool hasExperienceToNextLevel() => $_has(19);
  @$pb.TagNumber(20)
  void clearExperienceToNextLevel() => $_clearField(20);
}

class MnstrInput extends $pb.GeneratedMessage {
  factory MnstrInput({
    $core.String? id,
    $core.String? mnstrName,
    $core.String? mnstrDescription,
    $core.String? mnstrQrCode,
    $core.int? currentLevel,
    $core.int? currentExperience,
    $core.int? currentHealth,
    $core.int? maxHealth,
    $core.int? currentAttack,
    $core.int? maxAttack,
    $core.int? currentDefense,
    $core.int? maxDefense,
    $core.int? currentSpeed,
    $core.int? maxSpeed,
    $core.int? currentIntelligence,
    $core.int? maxIntelligence,
    $core.int? currentMagic,
    $core.int? maxMagic,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (mnstrName != null) result.mnstrName = mnstrName;
    if (mnstrDescription != null) result.mnstrDescription = mnstrDescription;
    if (mnstrQrCode != null) result.mnstrQrCode = mnstrQrCode;
    if (currentLevel != null) result.currentLevel = currentLevel;
    if (currentExperience != null) result.currentExperience = currentExperience;
    if (currentHealth != null) result.currentHealth = currentHealth;
    if (maxHealth != null) result.maxHealth = maxHealth;
    if (currentAttack != null) result.currentAttack = currentAttack;
    if (maxAttack != null) result.maxAttack = maxAttack;
    if (currentDefense != null) result.currentDefense = currentDefense;
    if (maxDefense != null) result.maxDefense = maxDefense;
    if (currentSpeed != null) result.currentSpeed = currentSpeed;
    if (maxSpeed != null) result.maxSpeed = maxSpeed;
    if (currentIntelligence != null)
      result.currentIntelligence = currentIntelligence;
    if (maxIntelligence != null) result.maxIntelligence = maxIntelligence;
    if (currentMagic != null) result.currentMagic = currentMagic;
    if (maxMagic != null) result.maxMagic = maxMagic;
    return result;
  }

  MnstrInput._();

  factory MnstrInput.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MnstrInput.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MnstrInput',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(3, _omitFieldNames ? '' : 'mnstrName')
    ..aOS(4, _omitFieldNames ? '' : 'mnstrDescription')
    ..aOS(5, _omitFieldNames ? '' : 'mnstrQrCode')
    ..aI(9, _omitFieldNames ? '' : 'currentLevel')
    ..aI(10, _omitFieldNames ? '' : 'currentExperience')
    ..aI(11, _omitFieldNames ? '' : 'currentHealth')
    ..aI(12, _omitFieldNames ? '' : 'maxHealth')
    ..aI(13, _omitFieldNames ? '' : 'currentAttack')
    ..aI(14, _omitFieldNames ? '' : 'maxAttack')
    ..aI(15, _omitFieldNames ? '' : 'currentDefense')
    ..aI(16, _omitFieldNames ? '' : 'maxDefense')
    ..aI(17, _omitFieldNames ? '' : 'currentSpeed')
    ..aI(18, _omitFieldNames ? '' : 'maxSpeed')
    ..aI(19, _omitFieldNames ? '' : 'currentIntelligence')
    ..aI(20, _omitFieldNames ? '' : 'maxIntelligence')
    ..aI(21, _omitFieldNames ? '' : 'currentMagic')
    ..aI(22, _omitFieldNames ? '' : 'maxMagic')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MnstrInput clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MnstrInput copyWith(void Function(MnstrInput) updates) =>
      super.copyWith((message) => updates(message as MnstrInput)) as MnstrInput;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MnstrInput create() => MnstrInput._();
  @$core.override
  MnstrInput createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MnstrInput getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MnstrInput>(create);
  static MnstrInput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(3)
  $core.String get mnstrName => $_getSZ(1);
  @$pb.TagNumber(3)
  set mnstrName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(3)
  $core.bool hasMnstrName() => $_has(1);
  @$pb.TagNumber(3)
  void clearMnstrName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get mnstrDescription => $_getSZ(2);
  @$pb.TagNumber(4)
  set mnstrDescription($core.String value) => $_setString(2, value);
  @$pb.TagNumber(4)
  $core.bool hasMnstrDescription() => $_has(2);
  @$pb.TagNumber(4)
  void clearMnstrDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get mnstrQrCode => $_getSZ(3);
  @$pb.TagNumber(5)
  set mnstrQrCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(5)
  $core.bool hasMnstrQrCode() => $_has(3);
  @$pb.TagNumber(5)
  void clearMnstrQrCode() => $_clearField(5);

  @$pb.TagNumber(9)
  $core.int get currentLevel => $_getIZ(4);
  @$pb.TagNumber(9)
  set currentLevel($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrentLevel() => $_has(4);
  @$pb.TagNumber(9)
  void clearCurrentLevel() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get currentExperience => $_getIZ(5);
  @$pb.TagNumber(10)
  set currentExperience($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(10)
  $core.bool hasCurrentExperience() => $_has(5);
  @$pb.TagNumber(10)
  void clearCurrentExperience() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get currentHealth => $_getIZ(6);
  @$pb.TagNumber(11)
  set currentHealth($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(11)
  $core.bool hasCurrentHealth() => $_has(6);
  @$pb.TagNumber(11)
  void clearCurrentHealth() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get maxHealth => $_getIZ(7);
  @$pb.TagNumber(12)
  set maxHealth($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(12)
  $core.bool hasMaxHealth() => $_has(7);
  @$pb.TagNumber(12)
  void clearMaxHealth() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get currentAttack => $_getIZ(8);
  @$pb.TagNumber(13)
  set currentAttack($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(13)
  $core.bool hasCurrentAttack() => $_has(8);
  @$pb.TagNumber(13)
  void clearCurrentAttack() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get maxAttack => $_getIZ(9);
  @$pb.TagNumber(14)
  set maxAttack($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(14)
  $core.bool hasMaxAttack() => $_has(9);
  @$pb.TagNumber(14)
  void clearMaxAttack() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get currentDefense => $_getIZ(10);
  @$pb.TagNumber(15)
  set currentDefense($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(15)
  $core.bool hasCurrentDefense() => $_has(10);
  @$pb.TagNumber(15)
  void clearCurrentDefense() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.int get maxDefense => $_getIZ(11);
  @$pb.TagNumber(16)
  set maxDefense($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(16)
  $core.bool hasMaxDefense() => $_has(11);
  @$pb.TagNumber(16)
  void clearMaxDefense() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.int get currentSpeed => $_getIZ(12);
  @$pb.TagNumber(17)
  set currentSpeed($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(17)
  $core.bool hasCurrentSpeed() => $_has(12);
  @$pb.TagNumber(17)
  void clearCurrentSpeed() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.int get maxSpeed => $_getIZ(13);
  @$pb.TagNumber(18)
  set maxSpeed($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(18)
  $core.bool hasMaxSpeed() => $_has(13);
  @$pb.TagNumber(18)
  void clearMaxSpeed() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.int get currentIntelligence => $_getIZ(14);
  @$pb.TagNumber(19)
  set currentIntelligence($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(19)
  $core.bool hasCurrentIntelligence() => $_has(14);
  @$pb.TagNumber(19)
  void clearCurrentIntelligence() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.int get maxIntelligence => $_getIZ(15);
  @$pb.TagNumber(20)
  set maxIntelligence($core.int value) => $_setSignedInt32(15, value);
  @$pb.TagNumber(20)
  $core.bool hasMaxIntelligence() => $_has(15);
  @$pb.TagNumber(20)
  void clearMaxIntelligence() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.int get currentMagic => $_getIZ(16);
  @$pb.TagNumber(21)
  set currentMagic($core.int value) => $_setSignedInt32(16, value);
  @$pb.TagNumber(21)
  $core.bool hasCurrentMagic() => $_has(16);
  @$pb.TagNumber(21)
  void clearCurrentMagic() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.int get maxMagic => $_getIZ(17);
  @$pb.TagNumber(22)
  set maxMagic($core.int value) => $_setSignedInt32(17, value);
  @$pb.TagNumber(22)
  $core.bool hasMaxMagic() => $_has(17);
  @$pb.TagNumber(22)
  void clearMaxMagic() => $_clearField(22);
}

class BatchMnstrInput extends $pb.GeneratedMessage {
  factory BatchMnstrInput({
    $core.Iterable<MnstrInput>? mnstrs,
  }) {
    final result = create();
    if (mnstrs != null) result.mnstrs.addAll(mnstrs);
    return result;
  }

  BatchMnstrInput._();

  factory BatchMnstrInput.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchMnstrInput.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchMnstrInput',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..pPM<MnstrInput>(1, _omitFieldNames ? '' : 'mnstrs',
        subBuilder: MnstrInput.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchMnstrInput clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchMnstrInput copyWith(void Function(BatchMnstrInput) updates) =>
      super.copyWith((message) => updates(message as BatchMnstrInput))
          as BatchMnstrInput;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchMnstrInput create() => BatchMnstrInput._();
  @$core.override
  BatchMnstrInput createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchMnstrInput getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchMnstrInput>(create);
  static BatchMnstrInput? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MnstrInput> get mnstrs => $_getList(0);
}

class ListMnstrsRequest extends $pb.GeneratedMessage {
  factory ListMnstrsRequest({
    $core.String? token,
    MnstrOrderBy? orderBy,
    MnstrOrderDirection? orderDirection,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (orderBy != null) result.orderBy = orderBy;
    if (orderDirection != null) result.orderDirection = orderDirection;
    return result;
  }

  ListMnstrsRequest._();

  factory ListMnstrsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListMnstrsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMnstrsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aE<MnstrOrderBy>(2, _omitFieldNames ? '' : 'orderBy',
        enumValues: MnstrOrderBy.values)
    ..aE<MnstrOrderDirection>(3, _omitFieldNames ? '' : 'orderDirection',
        enumValues: MnstrOrderDirection.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMnstrsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMnstrsRequest copyWith(void Function(ListMnstrsRequest) updates) =>
      super.copyWith((message) => updates(message as ListMnstrsRequest))
          as ListMnstrsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMnstrsRequest create() => ListMnstrsRequest._();
  @$core.override
  ListMnstrsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListMnstrsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMnstrsRequest>(create);
  static ListMnstrsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  MnstrOrderBy get orderBy => $_getN(1);
  @$pb.TagNumber(2)
  set orderBy(MnstrOrderBy value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasOrderBy() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrderBy() => $_clearField(2);

  @$pb.TagNumber(3)
  MnstrOrderDirection get orderDirection => $_getN(2);
  @$pb.TagNumber(3)
  set orderDirection(MnstrOrderDirection value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasOrderDirection() => $_has(2);
  @$pb.TagNumber(3)
  void clearOrderDirection() => $_clearField(3);
}

class ListMnstrsResponse extends $pb.GeneratedMessage {
  factory ListMnstrsResponse({
    $core.Iterable<Mnstr>? mnstrs,
  }) {
    final result = create();
    if (mnstrs != null) result.mnstrs.addAll(mnstrs);
    return result;
  }

  ListMnstrsResponse._();

  factory ListMnstrsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListMnstrsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMnstrsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..pPM<Mnstr>(1, _omitFieldNames ? '' : 'mnstrs', subBuilder: Mnstr.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMnstrsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMnstrsResponse copyWith(void Function(ListMnstrsResponse) updates) =>
      super.copyWith((message) => updates(message as ListMnstrsResponse))
          as ListMnstrsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMnstrsResponse create() => ListMnstrsResponse._();
  @$core.override
  ListMnstrsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListMnstrsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMnstrsResponse>(create);
  static ListMnstrsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Mnstr> get mnstrs => $_getList(0);
}

class GetMnstrByQrCodeRequest extends $pb.GeneratedMessage {
  factory GetMnstrByQrCodeRequest({
    $core.String? token,
    $core.String? mnstrQrCode,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (mnstrQrCode != null) result.mnstrQrCode = mnstrQrCode;
    return result;
  }

  GetMnstrByQrCodeRequest._();

  factory GetMnstrByQrCodeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMnstrByQrCodeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMnstrByQrCodeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'mnstrQrCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMnstrByQrCodeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMnstrByQrCodeRequest copyWith(
          void Function(GetMnstrByQrCodeRequest) updates) =>
      super.copyWith((message) => updates(message as GetMnstrByQrCodeRequest))
          as GetMnstrByQrCodeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMnstrByQrCodeRequest create() => GetMnstrByQrCodeRequest._();
  @$core.override
  GetMnstrByQrCodeRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetMnstrByQrCodeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMnstrByQrCodeRequest>(create);
  static GetMnstrByQrCodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get mnstrQrCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set mnstrQrCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMnstrQrCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearMnstrQrCode() => $_clearField(2);
}

class GetMnstrByQrCodeResponse extends $pb.GeneratedMessage {
  factory GetMnstrByQrCodeResponse({
    Mnstr? mnstr,
  }) {
    final result = create();
    if (mnstr != null) result.mnstr = mnstr;
    return result;
  }

  GetMnstrByQrCodeResponse._();

  factory GetMnstrByQrCodeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMnstrByQrCodeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMnstrByQrCodeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOM<Mnstr>(1, _omitFieldNames ? '' : 'mnstr', subBuilder: Mnstr.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMnstrByQrCodeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMnstrByQrCodeResponse copyWith(
          void Function(GetMnstrByQrCodeResponse) updates) =>
      super.copyWith((message) => updates(message as GetMnstrByQrCodeResponse))
          as GetMnstrByQrCodeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMnstrByQrCodeResponse create() => GetMnstrByQrCodeResponse._();
  @$core.override
  GetMnstrByQrCodeResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetMnstrByQrCodeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMnstrByQrCodeResponse>(create);
  static GetMnstrByQrCodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Mnstr get mnstr => $_getN(0);
  @$pb.TagNumber(1)
  set mnstr(Mnstr value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMnstr() => $_has(0);
  @$pb.TagNumber(1)
  void clearMnstr() => $_clearField(1);
  @$pb.TagNumber(1)
  Mnstr ensureMnstr() => $_ensure(0);
}

class CollectMnstrRequest extends $pb.GeneratedMessage {
  factory CollectMnstrRequest({
    $core.String? token,
    $core.String? mnstrQrCode,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (mnstrQrCode != null) result.mnstrQrCode = mnstrQrCode;
    return result;
  }

  CollectMnstrRequest._();

  factory CollectMnstrRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CollectMnstrRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CollectMnstrRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'mnstrQrCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CollectMnstrRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CollectMnstrRequest copyWith(void Function(CollectMnstrRequest) updates) =>
      super.copyWith((message) => updates(message as CollectMnstrRequest))
          as CollectMnstrRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CollectMnstrRequest create() => CollectMnstrRequest._();
  @$core.override
  CollectMnstrRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CollectMnstrRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CollectMnstrRequest>(create);
  static CollectMnstrRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get mnstrQrCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set mnstrQrCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMnstrQrCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearMnstrQrCode() => $_clearField(2);
}

class CollectMnstrResponse extends $pb.GeneratedMessage {
  factory CollectMnstrResponse({
    Mnstr? mnstr,
  }) {
    final result = create();
    if (mnstr != null) result.mnstr = mnstr;
    return result;
  }

  CollectMnstrResponse._();

  factory CollectMnstrResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CollectMnstrResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CollectMnstrResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOM<Mnstr>(1, _omitFieldNames ? '' : 'mnstr', subBuilder: Mnstr.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CollectMnstrResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CollectMnstrResponse copyWith(void Function(CollectMnstrResponse) updates) =>
      super.copyWith((message) => updates(message as CollectMnstrResponse))
          as CollectMnstrResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CollectMnstrResponse create() => CollectMnstrResponse._();
  @$core.override
  CollectMnstrResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CollectMnstrResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CollectMnstrResponse>(create);
  static CollectMnstrResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Mnstr get mnstr => $_getN(0);
  @$pb.TagNumber(1)
  set mnstr(Mnstr value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMnstr() => $_has(0);
  @$pb.TagNumber(1)
  void clearMnstr() => $_clearField(1);
  @$pb.TagNumber(1)
  Mnstr ensureMnstr() => $_ensure(0);
}

class CreateMnstrRequest extends $pb.GeneratedMessage {
  factory CreateMnstrRequest({
    $core.String? token,
    $core.String? mnstrName,
    $core.String? mnstrDescription,
    $core.String? mnstrQrCode,
    $core.int? currentHealth,
    $core.int? maxHealth,
    $core.int? currentAttack,
    $core.int? maxAttack,
    $core.int? currentDefense,
    $core.int? maxDefense,
    $core.int? currentSpeed,
    $core.int? maxSpeed,
    $core.int? currentIntelligence,
    $core.int? maxIntelligence,
    $core.int? currentMagic,
    $core.int? maxMagic,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (mnstrName != null) result.mnstrName = mnstrName;
    if (mnstrDescription != null) result.mnstrDescription = mnstrDescription;
    if (mnstrQrCode != null) result.mnstrQrCode = mnstrQrCode;
    if (currentHealth != null) result.currentHealth = currentHealth;
    if (maxHealth != null) result.maxHealth = maxHealth;
    if (currentAttack != null) result.currentAttack = currentAttack;
    if (maxAttack != null) result.maxAttack = maxAttack;
    if (currentDefense != null) result.currentDefense = currentDefense;
    if (maxDefense != null) result.maxDefense = maxDefense;
    if (currentSpeed != null) result.currentSpeed = currentSpeed;
    if (maxSpeed != null) result.maxSpeed = maxSpeed;
    if (currentIntelligence != null)
      result.currentIntelligence = currentIntelligence;
    if (maxIntelligence != null) result.maxIntelligence = maxIntelligence;
    if (currentMagic != null) result.currentMagic = currentMagic;
    if (maxMagic != null) result.maxMagic = maxMagic;
    return result;
  }

  CreateMnstrRequest._();

  factory CreateMnstrRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateMnstrRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateMnstrRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'mnstrName')
    ..aOS(3, _omitFieldNames ? '' : 'mnstrDescription')
    ..aOS(4, _omitFieldNames ? '' : 'mnstrQrCode')
    ..aI(5, _omitFieldNames ? '' : 'currentHealth')
    ..aI(6, _omitFieldNames ? '' : 'maxHealth')
    ..aI(7, _omitFieldNames ? '' : 'currentAttack')
    ..aI(8, _omitFieldNames ? '' : 'maxAttack')
    ..aI(9, _omitFieldNames ? '' : 'currentDefense')
    ..aI(10, _omitFieldNames ? '' : 'maxDefense')
    ..aI(11, _omitFieldNames ? '' : 'currentSpeed')
    ..aI(12, _omitFieldNames ? '' : 'maxSpeed')
    ..aI(13, _omitFieldNames ? '' : 'currentIntelligence')
    ..aI(14, _omitFieldNames ? '' : 'maxIntelligence')
    ..aI(15, _omitFieldNames ? '' : 'currentMagic')
    ..aI(16, _omitFieldNames ? '' : 'maxMagic')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateMnstrRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateMnstrRequest copyWith(void Function(CreateMnstrRequest) updates) =>
      super.copyWith((message) => updates(message as CreateMnstrRequest))
          as CreateMnstrRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateMnstrRequest create() => CreateMnstrRequest._();
  @$core.override
  CreateMnstrRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateMnstrRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateMnstrRequest>(create);
  static CreateMnstrRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get mnstrName => $_getSZ(1);
  @$pb.TagNumber(2)
  set mnstrName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMnstrName() => $_has(1);
  @$pb.TagNumber(2)
  void clearMnstrName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get mnstrDescription => $_getSZ(2);
  @$pb.TagNumber(3)
  set mnstrDescription($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMnstrDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearMnstrDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get mnstrQrCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set mnstrQrCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMnstrQrCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearMnstrQrCode() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get currentHealth => $_getIZ(4);
  @$pb.TagNumber(5)
  set currentHealth($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrentHealth() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentHealth() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get maxHealth => $_getIZ(5);
  @$pb.TagNumber(6)
  set maxHealth($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMaxHealth() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxHealth() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get currentAttack => $_getIZ(6);
  @$pb.TagNumber(7)
  set currentAttack($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrentAttack() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrentAttack() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get maxAttack => $_getIZ(7);
  @$pb.TagNumber(8)
  set maxAttack($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMaxAttack() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxAttack() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get currentDefense => $_getIZ(8);
  @$pb.TagNumber(9)
  set currentDefense($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrentDefense() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrentDefense() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get maxDefense => $_getIZ(9);
  @$pb.TagNumber(10)
  set maxDefense($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasMaxDefense() => $_has(9);
  @$pb.TagNumber(10)
  void clearMaxDefense() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get currentSpeed => $_getIZ(10);
  @$pb.TagNumber(11)
  set currentSpeed($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCurrentSpeed() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrentSpeed() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get maxSpeed => $_getIZ(11);
  @$pb.TagNumber(12)
  set maxSpeed($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMaxSpeed() => $_has(11);
  @$pb.TagNumber(12)
  void clearMaxSpeed() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get currentIntelligence => $_getIZ(12);
  @$pb.TagNumber(13)
  set currentIntelligence($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCurrentIntelligence() => $_has(12);
  @$pb.TagNumber(13)
  void clearCurrentIntelligence() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get maxIntelligence => $_getIZ(13);
  @$pb.TagNumber(14)
  set maxIntelligence($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasMaxIntelligence() => $_has(13);
  @$pb.TagNumber(14)
  void clearMaxIntelligence() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get currentMagic => $_getIZ(14);
  @$pb.TagNumber(15)
  set currentMagic($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasCurrentMagic() => $_has(14);
  @$pb.TagNumber(15)
  void clearCurrentMagic() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.int get maxMagic => $_getIZ(15);
  @$pb.TagNumber(16)
  set maxMagic($core.int value) => $_setSignedInt32(15, value);
  @$pb.TagNumber(16)
  $core.bool hasMaxMagic() => $_has(15);
  @$pb.TagNumber(16)
  void clearMaxMagic() => $_clearField(16);
}

class CreateMnstrResponse extends $pb.GeneratedMessage {
  factory CreateMnstrResponse({
    Mnstr? mnstr,
  }) {
    final result = create();
    if (mnstr != null) result.mnstr = mnstr;
    return result;
  }

  CreateMnstrResponse._();

  factory CreateMnstrResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateMnstrResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateMnstrResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOM<Mnstr>(1, _omitFieldNames ? '' : 'mnstr', subBuilder: Mnstr.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateMnstrResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateMnstrResponse copyWith(void Function(CreateMnstrResponse) updates) =>
      super.copyWith((message) => updates(message as CreateMnstrResponse))
          as CreateMnstrResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateMnstrResponse create() => CreateMnstrResponse._();
  @$core.override
  CreateMnstrResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateMnstrResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateMnstrResponse>(create);
  static CreateMnstrResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Mnstr get mnstr => $_getN(0);
  @$pb.TagNumber(1)
  set mnstr(Mnstr value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMnstr() => $_has(0);
  @$pb.TagNumber(1)
  void clearMnstr() => $_clearField(1);
  @$pb.TagNumber(1)
  Mnstr ensureMnstr() => $_ensure(0);
}

class CreateMnstrBatchRequest extends $pb.GeneratedMessage {
  factory CreateMnstrBatchRequest({
    $core.String? token,
    BatchMnstrInput? mnstrs,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (mnstrs != null) result.mnstrs = mnstrs;
    return result;
  }

  CreateMnstrBatchRequest._();

  factory CreateMnstrBatchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateMnstrBatchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateMnstrBatchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOM<BatchMnstrInput>(2, _omitFieldNames ? '' : 'mnstrs',
        subBuilder: BatchMnstrInput.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateMnstrBatchRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateMnstrBatchRequest copyWith(
          void Function(CreateMnstrBatchRequest) updates) =>
      super.copyWith((message) => updates(message as CreateMnstrBatchRequest))
          as CreateMnstrBatchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateMnstrBatchRequest create() => CreateMnstrBatchRequest._();
  @$core.override
  CreateMnstrBatchRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateMnstrBatchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateMnstrBatchRequest>(create);
  static CreateMnstrBatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  BatchMnstrInput get mnstrs => $_getN(1);
  @$pb.TagNumber(2)
  set mnstrs(BatchMnstrInput value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMnstrs() => $_has(1);
  @$pb.TagNumber(2)
  void clearMnstrs() => $_clearField(2);
  @$pb.TagNumber(2)
  BatchMnstrInput ensureMnstrs() => $_ensure(1);
}

class CreateMnstrBatchResponse extends $pb.GeneratedMessage {
  factory CreateMnstrBatchResponse({
    $core.Iterable<Mnstr>? mnstrs,
  }) {
    final result = create();
    if (mnstrs != null) result.mnstrs.addAll(mnstrs);
    return result;
  }

  CreateMnstrBatchResponse._();

  factory CreateMnstrBatchResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateMnstrBatchResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateMnstrBatchResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..pPM<Mnstr>(1, _omitFieldNames ? '' : 'mnstrs', subBuilder: Mnstr.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateMnstrBatchResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateMnstrBatchResponse copyWith(
          void Function(CreateMnstrBatchResponse) updates) =>
      super.copyWith((message) => updates(message as CreateMnstrBatchResponse))
          as CreateMnstrBatchResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateMnstrBatchResponse create() => CreateMnstrBatchResponse._();
  @$core.override
  CreateMnstrBatchResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateMnstrBatchResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateMnstrBatchResponse>(create);
  static CreateMnstrBatchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Mnstr> get mnstrs => $_getList(0);
}

class UpdateMnstrRequest extends $pb.GeneratedMessage {
  factory UpdateMnstrRequest({
    $core.String? token,
    $core.String? id,
    $core.String? mnstrName,
    $core.String? mnstrDescription,
    $core.int? currentHealth,
    $core.int? maxHealth,
    $core.int? currentAttack,
    $core.int? maxAttack,
    $core.int? currentDefense,
    $core.int? maxDefense,
    $core.int? currentSpeed,
    $core.int? maxSpeed,
    $core.int? currentIntelligence,
    $core.int? maxIntelligence,
    $core.int? currentMagic,
    $core.int? maxMagic,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (id != null) result.id = id;
    if (mnstrName != null) result.mnstrName = mnstrName;
    if (mnstrDescription != null) result.mnstrDescription = mnstrDescription;
    if (currentHealth != null) result.currentHealth = currentHealth;
    if (maxHealth != null) result.maxHealth = maxHealth;
    if (currentAttack != null) result.currentAttack = currentAttack;
    if (maxAttack != null) result.maxAttack = maxAttack;
    if (currentDefense != null) result.currentDefense = currentDefense;
    if (maxDefense != null) result.maxDefense = maxDefense;
    if (currentSpeed != null) result.currentSpeed = currentSpeed;
    if (maxSpeed != null) result.maxSpeed = maxSpeed;
    if (currentIntelligence != null)
      result.currentIntelligence = currentIntelligence;
    if (maxIntelligence != null) result.maxIntelligence = maxIntelligence;
    if (currentMagic != null) result.currentMagic = currentMagic;
    if (maxMagic != null) result.maxMagic = maxMagic;
    return result;
  }

  UpdateMnstrRequest._();

  factory UpdateMnstrRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateMnstrRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateMnstrRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'id')
    ..aOS(3, _omitFieldNames ? '' : 'mnstrName')
    ..aOS(4, _omitFieldNames ? '' : 'mnstrDescription')
    ..aI(6, _omitFieldNames ? '' : 'currentHealth')
    ..aI(7, _omitFieldNames ? '' : 'maxHealth')
    ..aI(8, _omitFieldNames ? '' : 'currentAttack')
    ..aI(9, _omitFieldNames ? '' : 'maxAttack')
    ..aI(10, _omitFieldNames ? '' : 'currentDefense')
    ..aI(11, _omitFieldNames ? '' : 'maxDefense')
    ..aI(12, _omitFieldNames ? '' : 'currentSpeed')
    ..aI(13, _omitFieldNames ? '' : 'maxSpeed')
    ..aI(14, _omitFieldNames ? '' : 'currentIntelligence')
    ..aI(15, _omitFieldNames ? '' : 'maxIntelligence')
    ..aI(16, _omitFieldNames ? '' : 'currentMagic')
    ..aI(17, _omitFieldNames ? '' : 'maxMagic')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMnstrRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMnstrRequest copyWith(void Function(UpdateMnstrRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateMnstrRequest))
          as UpdateMnstrRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMnstrRequest create() => UpdateMnstrRequest._();
  @$core.override
  UpdateMnstrRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateMnstrRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateMnstrRequest>(create);
  static UpdateMnstrRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get mnstrName => $_getSZ(2);
  @$pb.TagNumber(3)
  set mnstrName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMnstrName() => $_has(2);
  @$pb.TagNumber(3)
  void clearMnstrName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get mnstrDescription => $_getSZ(3);
  @$pb.TagNumber(4)
  set mnstrDescription($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMnstrDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearMnstrDescription() => $_clearField(4);

  @$pb.TagNumber(6)
  $core.int get currentHealth => $_getIZ(4);
  @$pb.TagNumber(6)
  set currentHealth($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrentHealth() => $_has(4);
  @$pb.TagNumber(6)
  void clearCurrentHealth() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get maxHealth => $_getIZ(5);
  @$pb.TagNumber(7)
  set maxHealth($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(7)
  $core.bool hasMaxHealth() => $_has(5);
  @$pb.TagNumber(7)
  void clearMaxHealth() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get currentAttack => $_getIZ(6);
  @$pb.TagNumber(8)
  set currentAttack($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(8)
  $core.bool hasCurrentAttack() => $_has(6);
  @$pb.TagNumber(8)
  void clearCurrentAttack() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get maxAttack => $_getIZ(7);
  @$pb.TagNumber(9)
  set maxAttack($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(9)
  $core.bool hasMaxAttack() => $_has(7);
  @$pb.TagNumber(9)
  void clearMaxAttack() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get currentDefense => $_getIZ(8);
  @$pb.TagNumber(10)
  set currentDefense($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(10)
  $core.bool hasCurrentDefense() => $_has(8);
  @$pb.TagNumber(10)
  void clearCurrentDefense() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get maxDefense => $_getIZ(9);
  @$pb.TagNumber(11)
  set maxDefense($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(11)
  $core.bool hasMaxDefense() => $_has(9);
  @$pb.TagNumber(11)
  void clearMaxDefense() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get currentSpeed => $_getIZ(10);
  @$pb.TagNumber(12)
  set currentSpeed($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(12)
  $core.bool hasCurrentSpeed() => $_has(10);
  @$pb.TagNumber(12)
  void clearCurrentSpeed() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get maxSpeed => $_getIZ(11);
  @$pb.TagNumber(13)
  set maxSpeed($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(13)
  $core.bool hasMaxSpeed() => $_has(11);
  @$pb.TagNumber(13)
  void clearMaxSpeed() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get currentIntelligence => $_getIZ(12);
  @$pb.TagNumber(14)
  set currentIntelligence($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(14)
  $core.bool hasCurrentIntelligence() => $_has(12);
  @$pb.TagNumber(14)
  void clearCurrentIntelligence() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get maxIntelligence => $_getIZ(13);
  @$pb.TagNumber(15)
  set maxIntelligence($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(15)
  $core.bool hasMaxIntelligence() => $_has(13);
  @$pb.TagNumber(15)
  void clearMaxIntelligence() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.int get currentMagic => $_getIZ(14);
  @$pb.TagNumber(16)
  set currentMagic($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(16)
  $core.bool hasCurrentMagic() => $_has(14);
  @$pb.TagNumber(16)
  void clearCurrentMagic() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.int get maxMagic => $_getIZ(15);
  @$pb.TagNumber(17)
  set maxMagic($core.int value) => $_setSignedInt32(15, value);
  @$pb.TagNumber(17)
  $core.bool hasMaxMagic() => $_has(15);
  @$pb.TagNumber(17)
  void clearMaxMagic() => $_clearField(17);
}

class UpdateMnstrResponse extends $pb.GeneratedMessage {
  factory UpdateMnstrResponse({
    Mnstr? mnstr,
  }) {
    final result = create();
    if (mnstr != null) result.mnstr = mnstr;
    return result;
  }

  UpdateMnstrResponse._();

  factory UpdateMnstrResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateMnstrResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateMnstrResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOM<Mnstr>(1, _omitFieldNames ? '' : 'mnstr', subBuilder: Mnstr.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMnstrResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMnstrResponse copyWith(void Function(UpdateMnstrResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateMnstrResponse))
          as UpdateMnstrResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMnstrResponse create() => UpdateMnstrResponse._();
  @$core.override
  UpdateMnstrResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateMnstrResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateMnstrResponse>(create);
  static UpdateMnstrResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Mnstr get mnstr => $_getN(0);
  @$pb.TagNumber(1)
  set mnstr(Mnstr value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMnstr() => $_has(0);
  @$pb.TagNumber(1)
  void clearMnstr() => $_clearField(1);
  @$pb.TagNumber(1)
  Mnstr ensureMnstr() => $_ensure(0);
}

class UpdateMnstrBatchRequest extends $pb.GeneratedMessage {
  factory UpdateMnstrBatchRequest({
    $core.String? token,
    BatchMnstrInput? mnstrs,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (mnstrs != null) result.mnstrs = mnstrs;
    return result;
  }

  UpdateMnstrBatchRequest._();

  factory UpdateMnstrBatchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateMnstrBatchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateMnstrBatchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOM<BatchMnstrInput>(2, _omitFieldNames ? '' : 'mnstrs',
        subBuilder: BatchMnstrInput.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMnstrBatchRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMnstrBatchRequest copyWith(
          void Function(UpdateMnstrBatchRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateMnstrBatchRequest))
          as UpdateMnstrBatchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMnstrBatchRequest create() => UpdateMnstrBatchRequest._();
  @$core.override
  UpdateMnstrBatchRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateMnstrBatchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateMnstrBatchRequest>(create);
  static UpdateMnstrBatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  BatchMnstrInput get mnstrs => $_getN(1);
  @$pb.TagNumber(2)
  set mnstrs(BatchMnstrInput value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMnstrs() => $_has(1);
  @$pb.TagNumber(2)
  void clearMnstrs() => $_clearField(2);
  @$pb.TagNumber(2)
  BatchMnstrInput ensureMnstrs() => $_ensure(1);
}

class UpdateMnstrBatchResponse extends $pb.GeneratedMessage {
  factory UpdateMnstrBatchResponse({
    $core.Iterable<Mnstr>? mnstrs,
  }) {
    final result = create();
    if (mnstrs != null) result.mnstrs.addAll(mnstrs);
    return result;
  }

  UpdateMnstrBatchResponse._();

  factory UpdateMnstrBatchResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateMnstrBatchResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateMnstrBatchResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'mnstrv2'),
      createEmptyInstance: create)
    ..pPM<Mnstr>(1, _omitFieldNames ? '' : 'mnstrs', subBuilder: Mnstr.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMnstrBatchResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMnstrBatchResponse copyWith(
          void Function(UpdateMnstrBatchResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateMnstrBatchResponse))
          as UpdateMnstrBatchResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMnstrBatchResponse create() => UpdateMnstrBatchResponse._();
  @$core.override
  UpdateMnstrBatchResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateMnstrBatchResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateMnstrBatchResponse>(create);
  static UpdateMnstrBatchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Mnstr> get mnstrs => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
