import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../models/monster.dart';
import 'collect.dart';
import 'local_storage.dart';
import 'manage.dart';

class SyncNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  Future<String?> push() async {
    final mnstrs = await LocalStorage.getMnstrs();
    for (var mnstr in mnstrs) {
      final error = await ref
          .read(manageGetByQRProvider.notifier)
          .get(mnstr.mnstrQrCode ?? '');
      if (error != null) {
        debugPrint('Error pushing: ${mnstr.mnstrName}');
        debugPrint('Error: $error');
        final createError = await create(mnstr);
        if (createError != null) {
          debugPrint('Error creating mnstr: $createError');
          continue;
        }
        continue;
      }
      final mnstrFound = ref.read(manageGetByQRProvider);
      debugPrint('mnstr found: ${mnstrFound?.mnstrName} ${mnstrFound?.id}');
      if (mnstrFound != null) {
          final error = await update(mnstr);
          if (error != null) {
            debugPrint('Error updating mnstr: $error');
            continue;
          }
      }
    }
    return null;
  }

  Future<String?> create(Monster mnstr) async {
    final error = await ref
        .read(collectProvider.notifier)
        .createMonster(mnstr);
    if (error != null) {
      debugPrint('Error creating: ${mnstr.mnstrName}');
      return error;
    }
    return null;
  }

  Future<String?> update(Monster mnstr) async {
    final error = await ref
        .read(manageEditProvider.notifier)
        .editMonster(mnstr);
    if (error != null) {
      debugPrint('Error updating: ${mnstr.mnstrName}');
      return error;
    }
    return null;
  }

  Future<String?> pull() async {
    await LocalStorage.clearMnstrs();
    final error = await ref.read(manageProvider.notifier).getMonsters();
    if (error != null) {
      return error;
    }
    final mnstrs = ref.read(manageProvider);
    for (var mnstr in mnstrs) {
      LocalStorage.addMnstr(mnstr);
    }
    return null;
  }

  Future<String?> sync() async {
    final error = await push();
    if (error != null) {
      return error;
    }
    final error2 = await pull();
    if (error2 != null) {
      return error2;
    }
    return null;
  }
}

final syncProvider = NotifierProvider<SyncNotifier, bool>(
  () => SyncNotifier(),
);
