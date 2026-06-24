import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

import '../providers/auth.dart';
import '../models/monster.dart';
import '../config/endpoints.dart' as endpoints;
import 'local_storage.dart';

import '../proto/mnstr.pb.dart' as proto_mnstr;
import '../proto/mnstr.pbgrpc.dart' as proto_mnstr_grpc;

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
      final error = await LocalStorage.addMnstr(monster);
      if (error != null) {
        debugPrint('[createMonster] Error: $error, ${StackTrace.current}');
        return error;
      }

      state = monster;
      return null;
    }

    try {
      final channel = ClientChannel(
        endpoints.apiHost,
        port: endpoints.apiPort,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
      final request = proto_mnstr.CreateMnstrRequest(
        token: auth.token,
        mnstrName: monster.mnstrName,
        mnstrDescription: monster.mnstrDescription,
        mnstrQrCode: monster.mnstrQrCode,
        currentHealth: monster.currentHealth,
        maxHealth: monster.maxHealth,
        currentAttack: monster.currentAttack,
        maxAttack: monster.maxAttack,
        currentDefense: monster.currentDefense,
        maxDefense: monster.maxDefense,
        currentIntelligence: monster.currentIntelligence,
        maxIntelligence: monster.maxIntelligence,
        currentSpeed: monster.currentSpeed,
        maxSpeed: monster.maxSpeed,
        currentMagic: monster.currentMagic,
        maxMagic: monster.maxMagic,
      );
      final response = await proto_mnstr_grpc.MnstrServiceClient(
        channel,
      ).create(request);
      if (response.hasMnstr()) {
        state = Monster.fromProto(response.mnstr);
        return null;
      }
    } catch (e, stackTrace) {
      debugPrint('[createMonster] Error: $e, stackTrace: $stackTrace');
      return "There was an error creating the monster";
    }
    return "There was an error creating the monster";
  }
}
