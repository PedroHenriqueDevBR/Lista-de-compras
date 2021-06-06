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

  ShoppingListDAL({
    required this.shoppingListSQL,
    required this.purchaseItemSQL,
  });

  Future<Database> getDatabase() async {
    return await connection.db;
  }

  @override
  Future<List<ShoppingList>> selectAllShoppingLists() async {
    try {
      Database db = await getDatabase();
      List<Map> response = await db.rawQuery(shoppingListSQL.selectAllShoppingLists());
      List<ShoppingList> shoppingList = [];
      for (Map item in response) {
        shoppingList.add(ShoppingList.fromSQLite(item));
      }
      return shoppingList;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<List<ShoppingList>> selectAllShoppingListsByFamily(Family family) async {
    try {
      Database db = await getDatabase();
      List<Map> response = await db.rawQuery(shoppingListSQL.selectAllShoppingListsByFamily(family));
      List<ShoppingList> shoppingList = [];
      for (Map item in response) {
        shoppingList.add(ShoppingList.fromSQLite(item));
      }
      return shoppingList;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<ShoppingList> updateShoppingList(ShoppingList shoppingList) async {
    try {
      Database db = await getDatabase();
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
      Database db = await getDatabase();
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
      Database db = await getDatabase();
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
      Database db = await getDatabase();
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
      Database db = await getDatabase();
      List<Map> response = await db.rawQuery(shoppingListSQL.calculateShoppingListPrice(shoppingList));
      return double.parse(response[0]['sum']);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<List<PurchaseItem>> addItemToShoppingList(ShoppingList shoppingList, PurchaseItem purchaseItem) async {
    try {
      Database db = await getDatabase();
      await db.rawInsert(shoppingListSQL.addItemToShoppingList(shoppingList, purchaseItem));
      List<Map> response = await db.rawQuery(purchaseItemSQL.getAllPurchaseItensFromShoppingList(shoppingList));
      List<PurchaseItem> itens = [];
      for (Map item in response) {
        itens.add(PurchaseItem.fromSQLite(item));
      }
      return itens;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<ShoppingList> updateShoppingListWithFamily(ShoppingList shoppingList, Family family) async {
    try {
      Database db = await getDatabase();
      int affectedRows = await db.rawUpdate(shoppingListSQL.updateShoppingListWithFamily(shoppingList, family));
      if (affectedRows > 0) {
        return shoppingList;
      } else {
        throw Exception('Nenhum dado afetado');
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
