import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth.dart';
import '../models/monster.dart';
import '../config/endpoints.dart' as endpoints;
import '../utils/graphql.dart';
import 'local_storage.dart';

final collectProvider = NotifierProvider<CollectNotifier, Monster?>(
  () => CollectNotifier(),
);

class CollectNotifier extends Notifier<Monster?> {
  @override
  Monster? build() {
    return null;
  }

  Future<String?> createMonster(Monster monster) async {
    final auth = ref.read(authProvider);

    if (auth == null) {
      await LocalStorage.addMnstr(monster);
      state = monster;
      return null;
    }

    final document = r'''
    mutation createMonster(
      $mnstrQrCode: String,
      $mnstrName: String,
      $mnstrDescription: String,
      $currentHealth: Int,
      $maxHealth: Int,
      $currentAttack: Int,
      $maxAttack: Int,
      $currentDefense: Int,
      $maxDefense: Int,
      $currentIntelligence: Int,
      $maxIntelligence: Int,
      $currentSpeed: Int,
      $maxSpeed: Int,
      $currentMagic: Int,
      $maxMagic: Int,
    ) {
      mnstrs {
        create(
          mnstrName: $mnstrName,
          mnstrDescription: $mnstrDescription,
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
          maxMagic: $maxMagic,
          mnstrQrCode: $mnstrQrCode,
        ) {
          id
          mnstrName
          mnstrDescription
          mnstrQrCode
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
      'mnstrQrCode': monster.mnstrQrCode ?? '',
      'mnstrName': monster.mnstrName ?? '',
      'mnstrDescription': monster.mnstrDescription ?? '',
      'currentLevel': monster.currentLevel ?? 0,
      'currentExperience': monster.currentExperience ?? 0,
      'experienceToNextLevel': monster.experienceToNextLevel ?? 0,
      'currentHealth': monster.currentHealth ?? 0,
      'maxHealth': monster.maxHealth ?? 0,
      'currentAttack': monster.currentAttack ?? 0,
      'maxAttack': monster.maxAttack ?? 0,
      'currentDefense': monster.currentDefense ?? 0,
      'maxDefense': monster.maxDefense ?? 0,
      'currentIntelligence': monster.currentIntelligence ?? 0,
      'maxIntelligence': monster.maxIntelligence ?? 0,
      'currentSpeed': monster.currentSpeed ?? 0,
      'maxSpeed': monster.maxSpeed ?? 0,
      'currentMagic': monster.currentMagic ?? 0,
      'maxMagic': monster.maxMagic ?? 0,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${auth.token}',
    };

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        variables: variables,
        headers: headers,
      );

      if (response['errors'] != null) {
        debugPrint('[createMonster] Error: ${response['errors']}');
        return "There was an error creating the monster";
      }

      final monster = Monster.fromJson(response['data']['mnstrs']['create']);
      state = monster;
      LocalStorage.addMnstr(monster);

      return null;
    } catch (e, stackTrace) {
      debugPrint('[createMonster] Error: $e, stackTrace: $stackTrace');
      return "There was an error creating the monster";
    }
  }
}
