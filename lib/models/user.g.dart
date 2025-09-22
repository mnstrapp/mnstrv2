// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String?,
  displayName: json['displayName'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  experienceLevel: (json['experienceLevel'] as num?)?.toInt(),
  experiencePoints: (json['experiencePoints'] as num?)?.toInt(),
  experienceToNextLevel: (json['experienceToNextLevel'] as num?)?.toInt(),
  coins: (json['coins'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'displayName': instance.displayName,
  'email': instance.email,
  'phone': instance.phone,
  'experienceLevel': instance.experienceLevel,
  'experiencePoints': instance.experiencePoints,
  'experienceToNextLevel': instance.experienceToNextLevel,
  'coins': instance.coins,
};
