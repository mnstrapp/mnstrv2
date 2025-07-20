// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageResponse _$ManageResponseFromJson(Map<String, dynamic> json) =>
    ManageResponse(
      error: json['error'] as String?,
      monsters: (json['mnstrs'] as List<dynamic>?)
          ?.map((e) => Monster.fromJson(e as Map<String, dynamic>))
          .toList(),
      monster: json['mnstr'] == null
          ? null
          : Monster.fromJson(json['mnstr'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ManageResponseToJson(ManageResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'mnstrs': instance.monsters,
      'mnstr': instance.monster,
    };

ManageEditRequest _$ManageEditRequestFromJson(Map<String, dynamic> json) =>
    ManageEditRequest(
      name: json['name'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ManageEditRequestToJson(ManageEditRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

ManageEditResponse _$ManageEditResponseFromJson(Map<String, dynamic> json) =>
    ManageEditResponse(
      error: json['error'] as String?,
      mnstr: json['mnstr'] == null
          ? null
          : Monster.fromJson(json['mnstr'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ManageEditResponseToJson(ManageEditResponse instance) =>
    <String, dynamic>{'error': instance.error, 'mnstr': instance.mnstr};
