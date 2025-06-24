// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
  id: json['id'] as String?,
  token: json['token'] as String?,
  userID: json['user_id'] as String?,
  expiresAt: json['expires_at'] == null
      ? null
      : DateTime.parse(json['expires_at'] as String),
);

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
  'id': instance.id,
  'token': instance.token,
  'user_id': instance.userID,
  'expires_at': instance.expiresAt?.toIso8601String(),
};
