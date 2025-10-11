import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:wiredash/wiredash.dart';

import '../models/monster.dart';
import 'collect.dart';
import 'local_storage.dart';
import 'manage.dart';
import 'session_users.dart';

enum SyncState {
  syncing,
  pushed,
  pulled,
  done,
}

class SyncNotifier extends Notifier<Map<String, SyncState>> {
  @override
  Map<String, SyncState> build() {
    return <String, SyncState>{};
  }

  Future<String?> push() async {
    final mnstrs = await LocalStorage.getMnstrs();
    final futures = <Future<String?>>[];
    for (var mnstr in mnstrs) {
      state[mnstr.id!] = SyncState.syncing;
      futures.add(_processMnstr(mnstr));
    }
    final errors = await Future.wait(futures);
    return errors.firstOrNull;
  }

  Future<String?> _processMnstr(Monster mnstr) async {
    final error = await ref
        .read(manageGetByQRProvider.notifier)
        .get(mnstr.mnstrQrCode ?? '');
    if (error != null) {
      // expected if the monster is not in the database
      final createError = await create(mnstr);
      state = {...state, mnstr.id!: SyncState.pushed};
      if (createError != null) {
        debugPrint('Error creating mnstr: $createError, ${StackTrace.current}');
        return createError;
      }
      return null;
    }
    final mnstrFound = ref.read(manageGetByQRProvider);
    debugPrint('mnstr found: ${mnstrFound?.mnstrName} ${mnstrFound?.id}');
    if (mnstrFound != null) {
      mnstr = Monster.fromSync(mnstrFound, mnstr);
      final error = await update(mnstr);
      state = {...state, mnstr.id!: SyncState.pushed};
      if (error != null) {
        debugPrint('Error updating mnstr: $error, ${StackTrace.current}');
        return error;
      }
    }
    return null;
  }

  Future<String?> create(Monster mnstr) async {
    debugPrint('Creating mnstr: ${mnstr.mnstrName}');
    String? error = await ref
        .read(collectProvider.notifier)
        .createMonster(mnstr);
    if (error != null) {
      debugPrint('Error creating: ${mnstr.mnstrName}');
      debugPrint('Error: $error, ${StackTrace.current}');
      return error;
    }
    return null;
  }

  Future<String?> update(Monster mnstr) async {
    debugPrint('Updating mnstr: ${mnstr.mnstrName}');
    final error = await ref
        .read(manageEditProvider.notifier)
        .editMonster(mnstr);
    if (error != null) {
      debugPrint('Error updating: ${mnstr.mnstrName}');
      debugPrint('Error: $error, ${StackTrace.current}');
      return error;
    }
    return null;
  }

  Future<String?> pull() async {
    final user = ref.read(sessionUserProvider);
    final error = await ref.read(manageProvider.notifier).getMonsters();
    if (error != null) {
      debugPrint('Error pulling: $error, ${StackTrace.current}');
      Wiredash.trackEvent(
        'Pull Error',
        data: {
          'error': error,
          'displayName': user?.displayName,
          'id': user?.id,
        },
      );
      return error;
    }
    final mnstrs = ref.read(manageProvider);
    final futures = <Future<String?>>[];
    for (var mnstr in mnstrs) {
      // futures.add(compute(pullOne, mnstr));
      futures.add(pullOne(mnstr));
    }
    final errors = await Future.wait(futures);
    return errors.firstOrNull;
  }

  Future<String?> pushOne(Monster mnstr) async {
    String? error = await ref
        .read(manageGetByQRProvider.notifier)
        .get(mnstr.mnstrQrCode!);
    if (error != null) {
      debugPrint('[pushOne] Error: $error, ${StackTrace.current}');
      return error;
    }
    final mnstrFound = ref.read(manageGetByQRProvider);
    if (mnstrFound != null) {
      mnstr = Monster.fromSync(mnstrFound, mnstr);
      error = await ref.read(manageEditProvider.notifier).editMonster(mnstr);
      if (error != null) {
        debugPrint('[pushOne] Error: $error, ${StackTrace.current}');
        return error;
      }
      return null;
    }
    error = await ref.read(collectProvider.notifier).createMonster(mnstr);
    if (error != null) {
      debugPrint('[pushOne] Error: $error, ${StackTrace.current}');
      return error;
    }
    return null;
  }

  Future<String?> pullOne(Monster mnstr) async {
    state = {...state, mnstr.id!: SyncState.syncing};
    String? error = await ref
        .read(manageGetByQRProvider.notifier)
        .get(mnstr.mnstrQrCode!);
    if (error != null) {
      state = {...state, mnstr.id!: SyncState.pulled};
      debugPrint('[pullOne] Error: $error, ${StackTrace.current}');
      return error;
    }
    final mnstrFound = ref.read(manageGetByQRProvider);
    if (mnstrFound != null) {
      mnstr = Monster.fromSync(mnstrFound, mnstr);
      await LocalStorage.addMnstr(mnstr);
      state = {...state, mnstr.id!: SyncState.pulled};
      return null;
    }
    return null;
  }

  Future<String?> sync({bool onlyPush = true}) async {
    state = {};
    final user = ref.read(sessionUserProvider);
    final error = await push();
    if (error != null) {
      debugPrint('[sync] Error: $error, ${StackTrace.current}');
      Wiredash.trackEvent(
        'Sync Error',
        data: {
          'error': error,
          'displayName': user?.displayName,
          'id': user?.id,
        },
      );
      return error;
    }
    if (!onlyPush) {
      final error = await pull();
      if (error != null) {
        debugPrint('[sync] Error: $error, ${StackTrace.current}');
        return error;
      }
    }
    return null;
  }
}

final syncProvider = NotifierProvider<SyncNotifier, Map<String, SyncState>>(
  () => SyncNotifier(),
);
