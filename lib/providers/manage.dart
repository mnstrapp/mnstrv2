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
          mnstrName
          mnstrDescription
          mnstrQrCode
          currentLevel
          currentExperience
          experienceToNextLevel
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
    query getMonsterByQRCode($mnstrQrCode: String!) {
      mnstrs {
        qrCode(mnstrQrCode: $mnstrQrCode) {
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

    final variables = {'mnstrQrCode': qrCode};

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
    } catch (e, stackTrace) {
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

    final document = r'''
    mutation editMonster(
      $id: String!,
      $mnstrName: String,
      $mnstrDescription: String,
      $mnstrQrCode: String,
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
        update(
          id: $id,
          mnstrName: $mnstrName,
          mnstrDescription: $mnstrDescription,
          mnstrQrCode: $mnstrQrCode,
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
      'id': monster.id,
      'mnstrName': monster.mnstrName,
      'mnstrDescription': monster.mnstrDescription,
      'mnstrQrCode': monster.mnstrQrCode,
      'currentHealth': monster.currentHealth,
      'maxHealth': monster.maxHealth,
      'currentAttack': monster.currentAttack,
      'maxAttack': monster.maxAttack,
      'currentDefense': monster.currentDefense,
      'maxDefense': monster.maxDefense,
      'currentIntelligence': monster.currentIntelligence,
      'maxIntelligence': monster.maxIntelligence,
      'currentSpeed': monster.currentSpeed,
      'maxSpeed': monster.maxSpeed,
      'currentMagic': monster.currentMagic,
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

      ref.read(manageProvider.notifier).getMonsters();

      return null;
    } catch (e, stackTrace) {
      return "There was an error editing the monster";
    }
  }
}
