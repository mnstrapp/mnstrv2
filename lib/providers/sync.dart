import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';
import '../config/endpoints.dart' as endpoints;
import '../models/monster.dart';
import 'local_storage.dart';
import 'manage.dart';
import 'session_users.dart';

import '../proto/mnstr.pb.dart' as proto_mnstr;
import '../proto/mnstr.pbgrpc.dart' as proto_mnstr_grpc;

enum SyncState {
  merging,
  merged,
  pushing,
  pushed,
  done,
}

class SyncNotifier extends Notifier<Map<String, SyncState>> {
  @override
  Map<String, SyncState> build() {
    return <String, SyncState>{};
  }

  Future<String?> push() async {
    final user = ref.read(sessionUserProvider);
    if (user == null) {
      return 'User not found';
    }

    final mnstrs = await LocalStorage.getMnstrs();
    for (var mnstr in mnstrs) {
      state = {...state, mnstr.mnstrQrCode!: SyncState.pushing};
    }
    final updateError = await _updateMnstrs(mnstrs);
    if (updateError != null) {
      debugPrint('Error updating mnstrs: $updateError, ${StackTrace.current}');
      return updateError;
    }
    return null;
  }

  Future<String?> _updateMnstrs(List<Monster> mnstrs) async {
    if (mnstrs.isEmpty) {
      return null;
    }

    final auth = ref.read(authProvider);
    if (auth == null) {
      return 'User not logged in';
    }

    final batchMnstrs = mnstrs
        .map(
          (mnstr) => proto_mnstr.MnstrInput(
            id: mnstr.id ?? '',
            mnstrQrCode: mnstr.mnstrQrCode ?? '',
            mnstrName: mnstr.mnstrName ?? '',
            mnstrDescription: mnstr.mnstrDescription ?? '',
            currentLevel: mnstr.currentLevel ?? 0,
            currentExperience: mnstr.currentExperience ?? 0,
            currentHealth: mnstr.currentHealth ?? 0,
            maxHealth: mnstr.maxHealth ?? 0,
            currentAttack: mnstr.currentAttack ?? 0,
            maxAttack: mnstr.maxAttack ?? 0,
            currentDefense: mnstr.currentDefense ?? 0,
            maxDefense: mnstr.maxDefense ?? 0,
            currentIntelligence: mnstr.currentIntelligence ?? 0,
            maxIntelligence: mnstr.maxIntelligence ?? 0,
            currentSpeed: mnstr.currentSpeed ?? 0,
            maxSpeed: mnstr.maxSpeed ?? 0,
            currentMagic: mnstr.currentMagic ?? 0,
            maxMagic: mnstr.maxMagic ?? 0,
          ),
        )
        .toList();

    final request = proto_mnstr.UpdateMnstrBatchRequest(
      mnstrs: proto_mnstr.BatchMnstrInput(
        mnstrs: batchMnstrs,
      ),
    );

    final channel = ClientChannel(
      endpoints.apiHost,
      port: endpoints.apiPort,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );

    try {
      final response = await proto_mnstr_grpc.MnstrServiceClient(
        channel,
      ).updateBatch(request);
      if (response.mnstrs.isNotEmpty) {
        for (var mnstr in response.mnstrs) {
          state = {...state, mnstr.mnstrQrCode: SyncState.pushed};
        }
        return null;
      }
      return "There was an error updating the monsters";
    } catch (e) {
      debugPrint('Error updating mnstrs: $e, ${StackTrace.current}');
      return "There was an error updating the monsters";
    }
  }

  Future<String?> merge() async {
    final localMnstrs = await LocalStorage.getMnstrs();
    if (localMnstrs.isEmpty) {
      return null;
    }

    final error = await ref.read(manageProvider.notifier).getMonsters();
    if (error != null) {
      debugPrint('[merge] Error: $error, ${StackTrace.current}');
      return error;
    }

    final syncMnstrs = ref.read(manageProvider);
    debugPrint(
      '[merge] syncMnstrs: ${syncMnstrs.map((e) => e.mnstrName).join(', ')}',
    );

    if (syncMnstrs.isNotEmpty) {
      for (Monster mnstr in localMnstrs) {
        state = {...state, mnstr.mnstrQrCode!: SyncState.merging};
        for (var syncMnstr in syncMnstrs) {
          if (mnstr.mnstrQrCode == syncMnstr.mnstrQrCode) {
            mnstr.archivedAt = syncMnstr.archivedAt;
            mnstr.createdAt = syncMnstr.createdAt;
            mnstr.updatedAt = syncMnstr.updatedAt;
            mnstr.currentLevel = syncMnstr.currentLevel;
            mnstr.currentExperience = syncMnstr.currentExperience;
            mnstr.currentHealth = syncMnstr.currentHealth;
            mnstr.maxHealth = syncMnstr.maxHealth;
            mnstr.currentAttack = syncMnstr.currentAttack;
            mnstr.maxAttack = syncMnstr.maxAttack;
            mnstr.currentDefense = syncMnstr.currentDefense;
            mnstr.maxDefense = syncMnstr.maxDefense;
            mnstr.currentIntelligence = syncMnstr.currentIntelligence;
            mnstr.maxIntelligence = syncMnstr.maxIntelligence;
            mnstr.currentSpeed = syncMnstr.currentSpeed;
            mnstr.maxSpeed = syncMnstr.maxSpeed;
            mnstr.currentMagic = syncMnstr.currentMagic;
            mnstr.maxMagic = syncMnstr.maxMagic;
            mnstr.experienceToNextLevel = syncMnstr.experienceToNextLevel;
            mnstr.id = syncMnstr.id;
            mnstr.userId = syncMnstr.userId;
            mnstr.mnstrName = syncMnstr.mnstrName;
            mnstr.mnstrDescription = syncMnstr.mnstrDescription;
            mnstr.mnstrQrCode = syncMnstr.mnstrQrCode;
            break;
          }
        }
        final updateError = await LocalStorage.updateMnstr(mnstr);
        if (updateError != null) {
          debugPrint('[merge] Error: $updateError, ${StackTrace.current}');
          return updateError;
        }
        state = {...state, mnstr.mnstrQrCode!: SyncState.merged};
      }
    }
    return null;
  }

  Future<String?> sync() async {
    state = {};
    ref.read(previouslySyncedProvider.notifier).setPreviouslySynced(false);

    List<Monster> localMnstrs = await LocalStorage.getMnstrs();
    debugPrint(
      '[sync] before merge localMnstrs: ${localMnstrs.map((e) => e.mnstrName).join(', ')}',
    );
    final mergeError = await merge();
    if (mergeError != null) {
      debugPrint('[sync] Error: $mergeError, ${StackTrace.current}');
      return mergeError;
    }

    localMnstrs = await LocalStorage.getMnstrs();
    debugPrint(
      '[sync] after merge localMnstrs: ${localMnstrs.map((e) => e.mnstrName).join(', ')}',
    );

    final pushError = await push();
    if (pushError != null) {
      debugPrint('[sync] Error: $pushError, ${StackTrace.current}');
      return pushError;
    }

    localMnstrs = await LocalStorage.getMnstrs();
    debugPrint(
      '[sync] after push localMnstrs: ${localMnstrs.map((e) => e.mnstrName).join(', ')}',
    );

    ref.read(previouslySyncedProvider.notifier).setPreviouslySynced(true);
    return null;
  }
}

final syncProvider = NotifierProvider<SyncNotifier, Map<String, SyncState>>(
  () => SyncNotifier(),
);

class PreviouslySyncedNotifier extends Notifier<bool> {
  bool previouslySynced;

  PreviouslySyncedNotifier({this.previouslySynced = false});

  @override
  bool build() {
    return previouslySynced;
  }

  void setPreviouslySynced(bool value) {
    state = value;
    savePreviouslySynced(value);
  }

  Future<bool> getPreviouslySynced() async {
    return await getPreviouslySynced();
  }
}

final previouslySyncedProvider =
    NotifierProvider<PreviouslySyncedNotifier, bool>(
      () => PreviouslySyncedNotifier(),
    );

Future<bool> getPreviouslySynced() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getBool('previouslySynced') ?? false;
}

Future<void> savePreviouslySynced(bool value) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setBool('previouslySynced', value);
}
