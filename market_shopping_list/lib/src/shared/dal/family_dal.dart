import 'dart:io' show Platform;

import 'package:sqflite/sqflite.dart';

import '../interfaces/family_storage_interface.dart';
import '../models/family.dart';
import '../models/shopping_list.dart';
import '../services/connection_base.dart';
import '../services/sqflite_connection.dart';
import '../services/sqflite_connection_desktop.dart';
import 'interfaces/family_sql_interface.dart';
import 'interfaces/shopping_list_sql_interface.dart';

class FamilyDAL implements IFamilyStorage {
  IFamilySQL familySQL;
  IShoppingListSQL shoppingListSQL;
  late IConnectionBase connection;

  FamilyDAL({
    required this.familySQL,
    required this.shoppingListSQL,
  }) {
    if (Platform.isAndroid) {
      connection = SQFLiteConnection.instance;
    } else {
      connection = SQFLiteConnectionDesktop.instance;
    }
  }

  Future<Database> getDatabase() async {
    return await connection.db;
  }

  @override
  Future<Family> createFamily(Family family) async {
    try {
      final db = await getDatabase();
      final responseId = await db.rawInsert(familySQL.createFamily(family));
      family.id = responseId;
      return family;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<List<Family>> getAllFamilies() async {
    try {
      final db = await getDatabase();
      List<Map> response = await db.rawQuery(familySQL.getAllFamilies());
      List<Family> families = [];
      for (Map item in response) {
        families.add(Family.fromSQLite(item));
      }
      return families;
    } catch (error) {
      throw Exception();
    }
  }

  @override
  Future<Family> updateFamily(Family family) async {
    try {
      final db = await getDatabase();
      final affectedRows = await db.rawUpdate(familySQL.updateFamily(family));
      if (affectedRows > 0) {
        return family;
      } else {
        throw Exception('Nenhum dado afetado');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<List<ShoppingList>> addShoppingList(
      Family family, ShoppingList shoppingList) async {
    try {
      final db = await getDatabase();
      await db.rawInsert(familySQL.addShoppingList(family, shoppingList));
      List<Map> response = await db
          .rawQuery(shoppingListSQL.selectAllShoppingListsByFamily(family));
      List<ShoppingList> shoppingResponse = [];
      for (Map item in response) {
        shoppingResponse.add(ShoppingList.fromSQLite(item));
      }
      return shoppingResponse;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> deleteFamily(Family family) async {
    try {
      final db = await getDatabase();
      final affectedRows = await db.rawDelete(familySQL.deleteFamily(family));
      if (affectedRows == 0) {
        throw Exception('Nenhum dado afetado');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<Family> getFamilyByShopping(ShoppingList shoppingList) async {
    try {
      final db = await getDatabase();
      List<Map> response =
          await db.rawQuery(familySQL.getFamilyByShoppingList(shoppingList));
      return Family.fromSQLite(response.first);
    } catch (error) {
      throw Exception();
    }
  }
}
