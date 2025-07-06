// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
  error: json['error'] as String?,
  user: json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{'error': instance.error, 'user': instance.user};
