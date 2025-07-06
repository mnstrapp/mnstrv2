// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String?,
  displayName: json['displayName'] as String?,
  qrCode: json['qrCode'] as String?,
  experienceLevel: (json['experienceLevel'] as num?)?.toInt(),
  experiencePoints: (json['experiencePoints'] as num?)?.toInt(),
  experienceToNextLevel: (json['experienceToNextLevel'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'displayName': instance.displayName,
  'qrCode': instance.qrCode,
  'experienceLevel': instance.experienceLevel,
  'experiencePoints': instance.experiencePoints,
  'experienceToNextLevel': instance.experienceToNextLevel,
};
