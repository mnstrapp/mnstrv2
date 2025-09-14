import 'dart:convert';
import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth.dart';
import '../models/monster.dart';
import '../config/endpoints.dart' as endpoints;
import '../utils/graphql.dart';

part 'collect.g.dart';

final collectProvider = AsyncNotifierProvider<CollectNotifier, Monster?>(
  () => CollectNotifier(),
);

@JsonSerializable()
class ManageRequest {
  final String qrCode;
  final String name;
  final int currentHealth;
  final int maxHealth;
  final int currentAttack;
  final int maxAttack;
  final int currentDefense;
  final int maxDefense;
  final int currentIntelligence;
  final int maxIntelligence;
  final int currentSpeed;
  final int maxSpeed;
  final int currentMagic;
  final int maxMagic;

  ManageRequest({
    required this.qrCode,
    required this.name,
    required this.currentHealth,
    required this.maxHealth,
    required this.currentAttack,
    required this.maxAttack,
    required this.currentDefense,
    required this.maxDefense,
    required this.currentIntelligence,
    required this.maxIntelligence,
    required this.currentSpeed,
    required this.maxSpeed,
    required this.currentMagic,
    required this.maxMagic,
  });

  factory ManageRequest.fromJson(Map<String, dynamic> json) =>
      _$ManageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ManageRequestToJson(this);
}

@JsonSerializable()
class ManageResponse {
  final String? error;
  final Monster? mnstr;

  ManageResponse({this.error, this.mnstr});

  factory ManageResponse.fromJson(Map<String, dynamic> json) =>
      _$ManageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ManageResponseToJson(this);
}

class CollectNotifier extends AsyncNotifier<Monster?> {
  @override
  Future<Monster?> build() async {
    return null;
  }

  Future<String?> createMonster(Monster monster) async {
    final auth = ref.read(authProvider);

    if (auth.value == null) {
      return "There was an error creating the monster";
    }

    final document = r'''
    mutation createMonster(
      $qrCode: String!,
      $name: String!,
      $currentHealth: Int!,
      $maxHealth: Int!,
      $currentAttack: Int!,
      $maxAttack: Int!,
      $currentDefense: Int!,
      $maxDefense: Int!,
      $currentIntelligence: Int!,
      $maxIntelligence: Int!,
      $currentSpeed: Int!,
      $maxSpeed: Int!,
      $currentMagic: Int!,
      $maxMagic: Int!
    ) {
      mnstrs {
        collect(
          qrCode: $qrCode,
          name: $name,
          currentHealth: $currentHealth,
          maxHealth: $maxHealth,
          currentAttack: $currentAttack,
          maxAttack: $maxAttack,
          currentDefense: $currentDefense,
          maxDefense: $maxDefense,
          currentIntelligence: $currentIntelligence,
          maxIntelligence: $maxIntelligence,
          currentSpeed: $currentSpeed,
          maxSpeed: $maxSpeed,
          currentMagic: $currentMagic,
          maxMagic: $maxMagic
        ) {
          id
          name
          qrCode
          currentLevel
          currentExperience
          currentHealth
          maxHealth
          currentAttack
          maxAttack
          currentDefense
          maxDefense
          currentIntelligence
          maxIntelligence
          currentSpeed
          maxSpeed
          currentMagic
          maxMagic
        }
      }
    }
    ''';

    final variables = {
      'qrCode': monster.qrCode ?? '',
      'name': monster.name ?? '',
      'currentHealth': monster.currentHealth ?? 10,
      'maxHealth': monster.maxHealth ?? 10,
      'currentAttack': monster.currentAttack ?? 10,
      'maxAttack': monster.maxAttack ?? 10,
      'currentDefense': monster.currentDefense ?? 10,
      'maxDefense': monster.maxDefense ?? 10,
      'currentIntelligence': monster.currentIntelligence ?? 10,
      'maxIntelligence': monster.maxIntelligence ?? 10,
      'currentSpeed': monster.currentSpeed ?? 10,
      'maxSpeed': monster.maxSpeed ?? 10,
      'currentMagic': monster.currentMagic ?? 10,
      'maxMagic': monster.maxMagic ?? 10,
    };
    log('[createMonster] variables: ${jsonEncode(variables)}');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${auth.value?.token}',
    };

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        variables: variables,
        headers: headers,
      );

      if (response['errors'] != null) {
        return "There was an error creating the monster";
      }

      final monster = Monster.fromJson(response['data']['mnstrs']['collect']);
      state = AsyncData(monster);
      return null;
    } catch (e, stackTrace) {
      log('[createMonster] catch error: $e');
      log('[createMonster] catch stackTrace: $stackTrace');
      return "There was an error creating the monster";
    }
  }
}
