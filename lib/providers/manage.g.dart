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
    );

Map<String, dynamic> _$ManageResponseToJson(ManageResponse instance) =>
    <String, dynamic>{'error': instance.error, 'mnstrs': instance.monsters};
