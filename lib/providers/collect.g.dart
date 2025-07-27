// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageRequest _$ManageRequestFromJson(Map<String, dynamic> json) =>
    ManageRequest(
      qrCode: json['qrCode'] as String,
      name: json['name'] as String,
      currentHealth: (json['currentHealth'] as num).toInt(),
      maxHealth: (json['maxHealth'] as num).toInt(),
      currentAttack: (json['currentAttack'] as num).toInt(),
      maxAttack: (json['maxAttack'] as num).toInt(),
      currentDefense: (json['currentDefense'] as num).toInt(),
      maxDefense: (json['maxDefense'] as num).toInt(),
      currentIntelligence: (json['currentIntelligence'] as num).toInt(),
      maxIntelligence: (json['maxIntelligence'] as num).toInt(),
      currentSpeed: (json['currentSpeed'] as num).toInt(),
      maxSpeed: (json['maxSpeed'] as num).toInt(),
      currentMagic: (json['currentMagic'] as num).toInt(),
      maxMagic: (json['maxMagic'] as num).toInt(),
    );

Map<String, dynamic> _$ManageRequestToJson(ManageRequest instance) =>
    <String, dynamic>{
      'qrCode': instance.qrCode,
      'name': instance.name,
      'currentHealth': instance.currentHealth,
      'maxHealth': instance.maxHealth,
      'currentAttack': instance.currentAttack,
      'maxAttack': instance.maxAttack,
      'currentDefense': instance.currentDefense,
      'maxDefense': instance.maxDefense,
      'currentIntelligence': instance.currentIntelligence,
      'maxIntelligence': instance.maxIntelligence,
      'currentSpeed': instance.currentSpeed,
      'maxSpeed': instance.maxSpeed,
      'currentMagic': instance.currentMagic,
      'maxMagic': instance.maxMagic,
    };

ManageResponse _$ManageResponseFromJson(Map<String, dynamic> json) =>
    ManageResponse(
      error: json['error'] as String?,
      mnstr: json['mnstr'] == null
          ? null
          : Monster.fromJson(json['mnstr'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ManageResponseToJson(ManageResponse instance) =>
    <String, dynamic>{'error': instance.error, 'mnstr': instance.mnstr};
