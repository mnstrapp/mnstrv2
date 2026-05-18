import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';
import '../config/endpoints.dart' as endpoints;
import '../models/monster.dart';
import '../utils/graphql.dart';
import 'local_storage.dart';
import 'manage.dart';
import 'session_users.dart';

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

    final user = ref.read(sessionUserProvider);
    if (user == null) {
      return 'User not found';
    }

    final userId = user.id;

    final batchMnstrs = mnstrs
        .map(
          (mnstr) => {
            'id': mnstr.id ?? '',
            'userId': userId,
            'mnstrQrCode': mnstr.mnstrQrCode ?? '',
            'mnstrName': mnstr.mnstrName ?? '',
            'mnstrDescription': mnstr.mnstrDescription ?? '',
            'currentLevel': mnstr.currentLevel ?? 0,
            'currentExperience': mnstr.currentExperience ?? 0,
            'experienceToNextLevel': mnstr.experienceToNextLevel ?? 0,
            'currentHealth': mnstr.currentHealth ?? 0,
            'maxHealth': mnstr.maxHealth ?? 0,
            'currentAttack': mnstr.currentAttack ?? 0,
            'maxAttack': mnstr.maxAttack ?? 0,
            'currentDefense': mnstr.currentDefense ?? 0,
            'maxDefense': mnstr.maxDefense ?? 0,
            'currentIntelligence': mnstr.currentIntelligence ?? 0,
            'maxIntelligence': mnstr.maxIntelligence ?? 0,
            'currentSpeed': mnstr.currentSpeed ?? 0,
            'maxSpeed': mnstr.maxSpeed ?? 0,
            'currentMagic': mnstr.currentMagic ?? 0,
            'maxMagic': mnstr.maxMagic ?? 0,
          },
        )
        .toList();

    final document = r'''
    mutation updateMnstrs($mnstrs: BatchMnstrInput!) {
      mnstrs {
        updateBatch(mnstrs: $mnstrs) {
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
          experienceToNextLevel
        }
      }
    }
    ''';

    final variables = {
      'mnstrs': {
        'mnstrs': batchMnstrs,
      },
    };

    // final jsonVariables = jsonEncode(variables);

    // debugPrint(jsonVariables);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${auth.token}',
    };

    final response = await graphql(
      url: endpoints.baseUrl,
      query: document,
      variables: variables,
      headers: headers,
    );

    if (response['errors'] != null) {
      debugPrint('Error updating mnstrs: ${response['errors']}');
      return "There was an error updating the monsters";
    }

    final updatedMnstrs = response['data']['mnstrs']['updateBatch'];
    for (var mnstr in updatedMnstrs) {
      final updatedMnstr = Monster.fromJson(mnstr);
      state = {...state, updatedMnstr.mnstrQrCode!: SyncState.pushed};
    }

    return null;
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
