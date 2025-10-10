import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';

import '../models/monster.dart';

class LocalStorage {
  static late Database database;

  LocalStorage();

  static init() async {
    final directory = await getApplicationSupportDirectory();
    final dbPath = path.join(directory.path, 'mnstr.db');
    if (UniversalPlatform.isWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }
    database = await openDatabase(dbPath);
    // await _dropTables(database);
    await _createTables(database);
  }

  static Future<List<Monster>> getMnstrs() async {
    final result = await database.query('mnstrs', orderBy: 'created_at DESC');

    return result.map((e) => Monster.fromDb(e)).toList();
  }

  static Future<Monster?> getMnstr(String id) async {
    final result = await database.query(
      'mnstrs',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.map((e) => Monster.fromDb(e)).toList().firstOrNull;
  }

  static Future<Monster?> getMnstrByQrCode(String qrCode) async {
    final result = await database.query(
      'mnstrs',
      where: 'mnstr_qr_code = ?',
      whereArgs: [qrCode],
      limit: 1,
    );
    return result.map((e) => Monster.fromDb(e)).toList().firstOrNull;
  }

  static addMnstr(Monster mnstr) async {
    final now = DateTime.now();
    mnstr.id ??= Uuid().v4();
    mnstr.createdAt ??= now;
    mnstr.updatedAt = now;
    final result = await database.insert(
      'mnstrs',
      mnstr.toDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (result == 0) {
      Sentry.captureException(
        Exception('Failed to add monster'),
        stackTrace: StackTrace.current,
      );
      return;
    }
  }
}

Future<void> _createTables(Database database) async {
  await database.execute('''
    CREATE TABLE IF NOT EXISTS mnstrs (
      id VARCHAR(255) PRIMARY KEY,
      user_id VARCHAR(255),
      mnstr_name VARCHAR(255),
      mnstr_description TEXT,
      mnstr_qr_code VARCHAR(255),
      current_level INT DEFAULT 0,
      current_experience INT DEFAULT 0,
      experience_to_next_level INT DEFAULT 0,
      current_health INT DEFAULT 10,
      max_health INT DEFAULT 10,
      current_attack INT DEFAULT 10,
      max_attack INT DEFAULT 10,
      current_defense INT DEFAULT 10,
      max_defense INT DEFAULT 10,
      current_intelligence INT DEFAULT 10,
      max_intelligence INT DEFAULT 10,
      current_speed INT DEFAULT 10,
      max_speed INT DEFAULT 10,
      current_magic INT DEFAULT 10,
      max_magic INT DEFAULT 10,
      created_at VARCHAR(255) DEFAULT CURRENT_TIMESTAMP,
      updated_at VARCHAR(255) DEFAULT CURRENT_TIMESTAMP,
      archived_at VARCHAR(255)
    )
  ''');
}

Future<void> _dropTables(Database database) async {
  await database.execute('DROP TABLE IF EXISTS mnstrs');
}
