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
);

Map<String, dynamic> _$MonsterToJson(Monster instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'qrCode': instance.qrCode,
};
