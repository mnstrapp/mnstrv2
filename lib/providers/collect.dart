import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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

    if (auth == null) {
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

    final variables = {'mnstrQrCode': monster.mnstrQrCode ?? ''};

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
        return "There was an error creating the monster";
      }

      final monster = Monster.fromJson(response['data']['mnstrs']['collect']);
      state = monster;
      return null;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return "There was an error creating the monster";
    }
  }
}
