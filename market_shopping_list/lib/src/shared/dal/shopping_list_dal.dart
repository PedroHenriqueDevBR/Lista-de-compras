import 'package:market_shopping_list/src/shared/dal/interfaces/purchase_item_sql_interface.dart';
import 'package:sqflite/sqflite.dart';

import 'package:market_shopping_list/src/shared/dal/interfaces/shopping_list_sql_interface.dart';
import 'package:market_shopping_list/src/shared/interfaces/shopping_list_interface.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:market_shopping_list/src/shared/services/sqflite_connection.dart';

class ShoppingListDAL implements IShoppingListStorage {
  IShoppingListSQL shoppingListSQL;
  IPurchaseItemSQL purchaseItemSQL;
  SQFLiteConnection connection = SQFLiteConnection.instance;
  late Database db;

  ShoppingListDAL({
    required this.shoppingListSQL,
    required this.purchaseItemSQL,
  }) {
    initDatabase();
  }

  void initDatabase() async {
    db = await connection.db;
  }

  @override
  Future<List<ShoppingList>> selectAllShoppingLists() async {
    try {
      List<Map> response = await db.rawQuery(shoppingListSQL.selectAllShoppingLists());
      response.map((item) => ShoppingList.fromSQLite(item));
      return response as List<ShoppingList>;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<List<ShoppingList>> selectAllShoppingListsByFamily(Family family) async {
    try {
      List<Map> response = await db.rawQuery(shoppingListSQL.selectAllShoppingListsByFamily(family));
      response.map((item) => ShoppingList.fromSQLite(item));
      return response as List<ShoppingList>;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<ShoppingList> updateShoppingList(ShoppingList shoppingList) async {
    try {
      int affectedRows = await db.rawUpdate(shoppingListSQL.updateShoppingList(shoppingList));
      if (affectedRows > 0) {
        return shoppingList;
      } else {
        throw Exception('Nenhum dado afetado');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<ShoppingList> completeShoppingList(ShoppingList shoppingList) async {
    try {
      int affectedRows = await db.rawUpdate(shoppingListSQL.completeShoppingList(shoppingList));
      if (affectedRows > 0) {
        return shoppingList;
      } else {
        throw Exception('Nenhum dado afetado');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<ShoppingList> redoCompleteShoppingList(ShoppingList shoppingList) async {
    try {
      int affectedRows = await db.rawUpdate(shoppingListSQL.redoCompleteShoppingList(shoppingList));
      if (affectedRows > 0) {
        return shoppingList;
      } else {
        throw Exception('Nenhum dado afetado');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> removeShoppingList(ShoppingList shoppingList) async {
    try {
      int affectedRows = await db.rawDelete(shoppingListSQL.removeShoppingList(shoppingList));
      if (affectedRows == 0) {
        throw Exception('Nenhum dado afetado');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<double> calculateShoppingListPrice(ShoppingList shoppingList) async {
    try {
      List<Map> response = await db.rawQuery(shoppingListSQL.calculateShoppingListPrice(shoppingList));
      return double.parse(response[0]['sum']);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<List<PurchaseItem>> addItemToShoppingList(ShoppingList shoppingList, PurchaseItem purchaseItem) async {
    try {
      await db.rawInsert(shoppingListSQL.addItemToShoppingList(shoppingList, purchaseItem));
      List<Map> response = await db.rawQuery(purchaseItemSQL.getAllPurchaseItensFromShoppingList(shoppingList));
      response.map((item) => PurchaseItem.fromSQLite(item));
      return response as List<PurchaseItem>;
    } catch (error) {
      throw Exception(error);
    }
  }
}