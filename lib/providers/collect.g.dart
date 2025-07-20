// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectRequest _$CollectRequestFromJson(Map<String, dynamic> json) =>
    CollectRequest(qrCode: json['qrCode'] as String);

Map<String, dynamic> _$CollectRequestToJson(CollectRequest instance) =>
    <String, dynamic>{'qrCode': instance.qrCode};

CollectResponse _$CollectResponseFromJson(Map<String, dynamic> json) =>
    CollectResponse(
      error: json['error'] as String?,
      mnstr: json['mnstr'] == null
          ? null
          : Monster.fromJson(json['mnstr'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CollectResponseToJson(CollectResponse instance) =>
    <String, dynamic>{'error': instance.error, 'mnstr': instance.mnstr};

ManageRequest _$ManageRequestFromJson(Map<String, dynamic> json) =>
    ManageRequest(name: json['name'] as String);

Map<String, dynamic> _$ManageRequestToJson(ManageRequest instance) =>
    <String, dynamic>{'name': instance.name};

ManageResponse _$ManageResponseFromJson(Map<String, dynamic> json) =>
    ManageResponse(
      error: json['error'] as String?,
      mnstr: json['mnstr'] == null
          ? null
          : Monster.fromJson(json['mnstr'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ManageResponseToJson(ManageResponse instance) =>
    <String, dynamic>{'error': instance.error, 'mnstr': instance.mnstr};
