import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../dal/sqlite_sql/database_sql.dart';
import 'connection_base.dart';

class SQFLiteConnectionDesktop implements IConnectionBase {
  SQFLiteConnectionDesktop._();

  static SQFLiteConnectionDesktop? _sqfliteConnection;

  static SQFLiteConnectionDesktop get instance {
    _sqfliteConnection ??= SQFLiteConnectionDesktop._();
    return _sqfliteConnection!;
  }

  static final DATABASE_VERSION = 1;
  static final DATABASE_NAME = 'lista_de_compras';
  Database? _db;

  Future<Database> get db => _openDatabaseConnection();

  Future<Database> _openDatabaseConnection() async {
    sqfliteFfiInit();
    final databasePath = await databaseFactoryFfi.getDatabasesPath();
    final path = join(databasePath, DATABASE_NAME);
    final databaseFactory = databaseFactoryFfi;

    if (_db == null) {
      _db = await databaseFactory.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: DATABASE_VERSION,
          onCreate: _onCreate,
        ),
      );
    }
    return _db!;
  }


  FutureOr<void> _onCreate(Database db, int version) {
    db.transaction((reference) async {
      reference.execute(DatabaseSQL.FAMILY_CREATOR_SQL);
      reference.execute(DatabaseSQL.SHOPPING_CREATOR_SQL);
      reference.execute(DatabaseSQL.PURCHASE_CREATOR_SQL);
    });
  }
}
