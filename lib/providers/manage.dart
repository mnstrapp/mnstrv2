import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/endpoints.dart' as endpoints;
import '../providers/auth.dart';
import '../models/monster.dart';
import '../utils/graphql.dart';

final manageProvider = NotifierProvider<ManageNotifier, List<Monster>>(
  () => ManageNotifier(),
);

class ManageNotifier extends Notifier<List<Monster>> {
  @override
  List<Monster> build() {
    return [];
  }

  Future<String?> getMonsters() async {
    final auth = ref.read(authProvider);

    if (auth.value == null) {
      return "Invalid login";
    }

    final document = r'''
    query getMonsters {
      mnstrs {
        list {
          id
          name
          description
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

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${auth.value?.token}',
    };

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        headers: headers,
      );

      if (response['errors'] != null) {
        return "There was an error getting the monsters";
      }

      final monsters = <Monster>[];
      for (var e in response['data']['mnstrs']['list']) {
        monsters.add(Monster.fromJson(e as Map<String, dynamic>));
      }
      state = monsters;
      return null;
    } catch (e, stackTrace) {
      log('[getMonsters] catch error: $e');
      log('[getMonsters] catch stackTrace: $stackTrace');
      return "There was an error getting the monsters";
    }
  }
}

final manageGetByQRProvider =
    AsyncNotifierProvider<ManageGetByQRNotifier, Monster?>(
      () => ManageGetByQRNotifier(),
    );

class ManageGetByQRNotifier extends AsyncNotifier<Monster?> {
  @override
  Future<Monster?> build() async {
    return null;
  }

  Future<String?> get(String qrCode) async {
    final auth = ref.read(authProvider);

    if (auth.value == null) {
      return "There was an error getting the monster by QR code";
    }

    final document = r'''
    query getMonsterByQRCode($qrCode: String!) {
      mnstrs {
        qrCode(qrCode: $qrCode) {
          id
          name
          description
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

    final variables = {'qrCode': qrCode};

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
        return "There was an error getting the monster by QR code";
      }

      if (response['data']['mnstrs']['qrCode'] == null) {
        return "Monster not found";
      }

      final monster = Monster.fromJson(response['data']['mnstrs']['qrCode']);

      state = AsyncData(monster);

      return null;
    } catch (e) {
      return "There was an error getting the monster by QR code";
    }
  }
}

final manageEditProvider = NotifierProvider<ManageEditNotifier, Monster?>(
  () => ManageEditNotifier(),
);

class ManageEditNotifier extends Notifier<Monster?> {
  @override
  Monster? build() {
    return null;
  }

  void set(Monster monster) {
    state = monster;
  }

  Future<String?> editMonster(Monster monster) async {
    final auth = ref.read(authProvider);

    if (auth.value == null) {
      return "There was an error editing the monster";
    }

    log('[editMonster] monster: ${monster.toJson()}');

    final document = r'''
    mutation editMonster(
      $id: String!,
      $name: String,
      $description: String,
      $qrCode: String,
      $health: Int,
      $maxHealth: Int,
      $attack: Int,
      $maxAttack: Int,
      $defense: Int,
      $maxDefense: Int,
      $intelligence: Int,
      $maxIntelligence: Int,
      $speed: Int,
      $maxSpeed: Int,
      $magic: Int,
      $maxMagic: Int,
    ) {
      mnstrs {
        update(
          id: $id,
          name: $name,
          description: $description,
          qrCode: $qrCode,
          health: $health,
          maxHealth: $maxHealth,
          attack: $attack,
          maxAttack: $maxAttack,
          defense: $defense,
          maxDefense: $maxDefense,
          intelligence: $intelligence,
          maxIntelligence: $maxIntelligence,
          speed: $speed,
          maxSpeed: $maxSpeed,
          magic: $magic,
          maxMagic: $maxMagic,
        ) {
          id
          name
          description
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
      'id': monster.id,
      'name': monster.name,
      'description': monster.description,
      'qrCode': monster.qrCode,
      'health': monster.currentHealth,
      'maxHealth': monster.maxHealth,
      'attack': monster.currentAttack,
      'maxAttack': monster.maxAttack,
      'defense': monster.currentDefense,
      'maxDefense': monster.maxDefense,
      'intelligence': monster.currentIntelligence,
      'maxIntelligence': monster.maxIntelligence,
      'speed': monster.currentSpeed,
      'maxSpeed': monster.maxSpeed,
      'magic': monster.currentMagic,
      'maxMagic': monster.maxMagic,
    };

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
        return "There was an error editing the monster";
      }

      final monster = Monster.fromJson(response['data']['mnstrs']['update']);
      state = monster;

      log('[editMonster] monster: ${monster.toJson()}');

      ref.read(manageProvider.notifier).getMonsters();

      return null;
    } catch (e, stackTrace) {
      log('[editMonster] catch error: $e');
      log('[editMonster] catch stackTrace: $stackTrace');
      return "There was an error editing the monster";
    }
  }
}
