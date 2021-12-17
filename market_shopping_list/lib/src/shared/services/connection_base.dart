import 'package:sqflite/sqflite.dart';

abstract class IConnectionBase {
  Future<Database> get db;
}
