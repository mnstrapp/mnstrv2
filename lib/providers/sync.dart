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
  pushing,
  pushed,
  pulling,
  pulled,
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
      await LocalStorage.addMnstr(updatedMnstr);
      state = {...state, updatedMnstr.mnstrQrCode!: SyncState.pushed};
    }

    return null;
  }

  Future<String?> pull() async {
    for (var mnstr in state.keys) {
      state = {...state, mnstr: SyncState.pulling};
    }
    final error = await ref.read(manageProvider.notifier).getMonsters();
    if (error != null) {
      debugPrint('Error pulling: $error, ${StackTrace.current}');
      return error;
    }

    final mnstrs = ref.read(manageProvider);
    for (var mnstr in mnstrs) {
      await LocalStorage.addMnstr(mnstr);
      state = {...state, mnstr.mnstrQrCode!: SyncState.pulled};
    }

    return null;
  }

  Future<String?> sync({bool onlyPush = true}) async {
    state = {};
    ref.read(previouslySyncedProvider.notifier).setPreviouslySynced(false);
    final error = await push();
    if (error != null) {
      debugPrint('[sync] Error: $error, ${StackTrace.current}');
      return error;
    }
    if (!onlyPush) {
      final error = await pull();
      if (error != null) {
        debugPrint('[sync] Error: $error, ${StackTrace.current}');
        return error;
      }
    }
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
