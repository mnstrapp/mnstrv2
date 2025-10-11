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
        mnstr = Monster.fromSync(mnstrFound, mnstr);
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
    debugPrint('Creating mnstr: ${mnstr.mnstrName}');
    String? error = await ref
        .read(collectProvider.notifier)
        .createMonster(mnstr);
    if (error != null) {
      debugPrint('Error creating: ${mnstr.mnstrName}');
      debugPrint('Error: $error');
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

  Future<String?> pushOne(Monster mnstr) async {
    String? error = await ref
        .read(manageGetByQRProvider.notifier)
        .get(mnstr.mnstrQrCode!);
    if (error != null) {
      return error;
    }
    final mnstrFound = ref.read(manageGetByQRProvider);
    if (mnstrFound != null) {
      mnstr = Monster.fromSync(mnstrFound, mnstr);
      error = await ref.read(manageEditProvider.notifier).editMonster(mnstr);
      if (error != null) {
        return error;
      }
      return null;
    }
    error = await ref.read(collectProvider.notifier).createMonster(mnstr);
    if (error != null) {
      return error;
    }
    return null;
  }

  Future<String?> pullOne(Monster mnstr) async {
    String? error = await ref
        .read(manageGetByQRProvider.notifier)
        .get(mnstr.mnstrQrCode!);
    if (error != null) {
      return error;
    }
    final mnstrFound = ref.read(manageGetByQRProvider);
    if (mnstrFound != null) {
      mnstr = Monster.fromSync(mnstrFound, mnstr);
      await LocalStorage.addMnstr(mnstr);
      return null;
    }
    return null;
  }

  Future<String?> sync() async {
    final error = await push();
    if (error != null) {
      return error;
    }
    return null;
  }
}

final syncProvider = NotifierProvider<SyncNotifier, bool>(
  () => SyncNotifier(),
);
