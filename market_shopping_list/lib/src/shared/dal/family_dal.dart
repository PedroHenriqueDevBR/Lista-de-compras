import 'package:sqflite/sqflite.dart';

import 'package:market_shopping_list/src/shared/dal/interfaces/family_sql_interface.dart';
import 'package:market_shopping_list/src/shared/dal/interfaces/shopping_list_sql_interface.dart';
import 'package:market_shopping_list/src/shared/interfaces/family_storage_interface.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:market_shopping_list/src/shared/services/sqflite_connection.dart';

class FamilyDAL implements IFamilyStorage {
  IFamilySQL familySQL;
  IShoppingListSQL shoppingListSQL;
  SQFLiteConnection connection = SQFLiteConnection.instance;
  late Database db;

  FamilyDAL({
    required this.familySQL,
    required this.shoppingListSQL,
  }) {
    initDatabase();
  }

  void initDatabase() async {
    db = await connection.db;
  }

  @override
  Future<Family> createFamily(Family family) async {
    try {
      int responseId = await db.rawInsert(familySQL.createFamily(family));
      family.id = responseId;
      return family;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<List<Family>> getAllFamilies() async {
    try {
      List<Map> response = await db.rawQuery(familySQL.getAllFamilies());
      response.map((family) => Family.fromSQLite(family));
      return response as List<Family>;
    } catch (error) {
      throw Exception();
    }
  }

  @override
  Future<Family> updateFamily(Family family) async {
    try {
      int affectedRows = await db.rawUpdate(familySQL.updateFamily(family));
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
  Future<List<ShoppingList>> addShoppingList(Family family, ShoppingList shoppingList) async {
    try {
      await db.rawInsert(familySQL.addShoppingList(family, shoppingList));
      List<Map> response = await db.rawQuery(shoppingListSQL.selectAllShoppingListsByFamily(family));
      response.map((shoppingListItem) => ShoppingList.fromSQLite(shoppingListItem));
      return response as List<ShoppingList>;
    } catch (error) {
      throw Exception(error);
    }
  }
}
