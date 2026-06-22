// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
  id: json['id'] as String?,
  token: json['sessionToken'] as String?,
  userID: json['userID'] as String?,
);

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
  'id': instance.id,
  'sessionToken': instance.token,
  'userID': instance.userID,
};
