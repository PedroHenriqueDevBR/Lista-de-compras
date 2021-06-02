import 'dart:async';

import 'package:market_shopping_list/src/shared/dal/sqlite_sql/database_sql.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQFLiteConnection {
  SQFLiteConnection._();

  static SQFLiteConnection? _sqfliteConnection;

  static SQFLiteConnection get instance {
    _sqfliteConnection ??= SQFLiteConnection._();
    return _sqfliteConnection!;
  }

  static const DATABASE_VERSION = 1;
  static const DATABASE_NAME = 'personal_service_manager';
  Database? _db;

  Future<Database> get db => _openDatabaseConnection();

  Future<Database> _openDatabaseConnection() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, DATABASE_NAME);

    if (_db == null) {
      _db = await openDatabase(
        path,
        version: DATABASE_VERSION,
        onCreate: _onCreate,
      );
    }
    return _db!;
  }

  FutureOr<void> _onCreate(Database db, int version) {
    db.execute(DatabaseSQL.DATABASE_CREATOR_SQL);
  }
}
