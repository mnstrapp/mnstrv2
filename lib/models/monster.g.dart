// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monster.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Monster _$MonsterFromJson(Map<String, dynamic> json) => Monster(
  id: json['id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  qrCode: json['qrCode'] as String?,
  level: (json['level'] as num?)?.toInt(),
  experience: (json['experience'] as num?)?.toInt(),
  currentHealth: (json['currentHealth'] as num?)?.toInt(),
  maxHealth: (json['maxHealth'] as num?)?.toInt(),
  currentAttack: (json['currentAttack'] as num?)?.toInt(),
  maxAttack: (json['maxAttack'] as num?)?.toInt(),
  currentDefense: (json['currentDefense'] as num?)?.toInt(),
  maxDefense: (json['maxDefense'] as num?)?.toInt(),
  currentIntelligence: (json['currentIntelligence'] as num?)?.toInt(),
  maxIntelligence: (json['maxIntelligence'] as num?)?.toInt(),
  currentSpeed: (json['currentSpeed'] as num?)?.toInt(),
  maxSpeed: (json['maxSpeed'] as num?)?.toInt(),
  currentMagic: (json['currentMagic'] as num?)?.toInt(),
  maxMagic: (json['maxMagic'] as num?)?.toInt(),
);

Map<String, dynamic> _$MonsterToJson(Monster instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'qrCode': instance.qrCode,
  'level': instance.level,
  'experience': instance.experience,
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
