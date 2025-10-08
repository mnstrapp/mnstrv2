import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth.dart';
import '../models/monster.dart';
import '../config/endpoints.dart' as endpoints;
import '../utils/graphql.dart';

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

    if (auth.value == null) {
      return "There was an error creating the monster";
    }

    final document = r'''
    mutation createMonster(
      $mnstrQrCode: String!,
    ) {
      mnstrs {
        collect(
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

    final variables = {'mnstrQrCode': monster.mnstrQrCode ?? ''};

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
      state = monster;
      return null;
    } catch (e, stackTrace) {
      return "There was an error creating the monster";
    }
  }
}
