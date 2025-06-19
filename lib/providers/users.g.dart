// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationRequest _$RegistrationRequestFromJson(Map<String, dynamic> json) =>
    RegistrationRequest(
      qrCode: json['qrCode'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegistrationRequestToJson(
  RegistrationRequest instance,
) => <String, dynamic>{
  'qrCode': instance.qrCode,
  'displayName': instance.displayName,
  'email': instance.email,
  'password': instance.password,
};

RegistrationResponse _$RegistrationResponseFromJson(
  Map<String, dynamic> json,
) => RegistrationResponse(
  error: json['error'] as String?,
  user: json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RegistrationResponseToJson(
  RegistrationResponse instance,
) => <String, dynamic>{'error': instance.error, 'user': instance.user};
