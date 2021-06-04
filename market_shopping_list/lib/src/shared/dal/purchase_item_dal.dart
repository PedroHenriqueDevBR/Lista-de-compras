import 'package:sqflite/sqflite.dart';

import 'package:market_shopping_list/src/shared/dal/interfaces/purchase_item_sql_interface.dart';
import 'package:market_shopping_list/src/shared/interfaces/purchase_item_storage_interface.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:market_shopping_list/src/shared/services/sqflite_connection.dart';

class PurchaseItemDAL implements IPurchaseItemStorage {
  IPurchaseItemSQL purchaseItemSQL;
  SQFLiteConnection connection = SQFLiteConnection.instance;

  PurchaseItemDAL({
    required this.purchaseItemSQL,
  });

  Future<Database> getDatabase() async {
    return await connection.db;
  }

  @override
  Future<List<PurchaseItem>> getAllPurchaseItensFromShoppingList(ShoppingList shoppingList) async {
    try {
      Database db = await getDatabase();
      List<Map> response = await db.rawQuery(purchaseItemSQL.getAllPurchaseItensFromShoppingList(shoppingList));
      response.map((item) => PurchaseItem.fromSQLite(item));
      return response as List<PurchaseItem>;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<PurchaseItem> updatePurchaseItem(PurchaseItem purchaseItem) async {
    try {
      Database db = await getDatabase();
      int affectedRows = await db.rawUpdate(purchaseItemSQL.updatePurchaseItem(purchaseItem));
      if (affectedRows > 0) {
        return purchaseItem;
      } else {
        throw Exception('Nenhum dado afetado');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> removePurchaseItem(PurchaseItem purchaseItem) async {
    try {
      Database db = await getDatabase();
      int affectedRows = await db.rawDelete(purchaseItemSQL.removePurchaseItem(purchaseItem));
      if (affectedRows == 0) {
        throw Exception('Nenhum dado afetado');
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
