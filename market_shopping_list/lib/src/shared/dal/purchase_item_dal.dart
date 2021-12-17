import 'dart:io' show Platform;

import 'package:sqflite/sqflite.dart';

import '../interfaces/purchase_item_storage_interface.dart';
import '../models/purchase_item.dart';
import '../models/shopping_list.dart';
import '../services/connection_base.dart';
import '../services/sqflite_connection.dart';
import '../services/sqflite_connection_desktop.dart';
import 'interfaces/purchase_item_sql_interface.dart';

class PurchaseItemDAL implements IPurchaseItemStorage {
  IPurchaseItemSQL purchaseItemSQL;
  late IConnectionBase connection;

  PurchaseItemDAL({
    required this.purchaseItemSQL,
  }){
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
  Future<List<PurchaseItem>> getAllPurchaseItensFromShoppingList(ShoppingList shoppingList) async {
    try {
      final db = await getDatabase();
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
  Future<PurchaseItem> updatePurchaseItem(PurchaseItem purchaseItem) async {
    try {
      final db = await getDatabase();
      final affectedRows = await db.rawUpdate(purchaseItemSQL.updatePurchaseItem(purchaseItem));
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
      final db = await getDatabase();
      final affectedRows = await db.rawDelete(purchaseItemSQL.removePurchaseItem(purchaseItem));
      if (affectedRows == 0) {
        throw Exception('Nenhum dado afetado');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> deletePurchaseItemByShoppingList(ShoppingList shoppingList) async {
    try {
      final db = await getDatabase();
      await db.rawDelete(purchaseItemSQL.deletePurchaseItemByShoppingList(shoppingList));
    } catch (error) {
      throw Exception(error);
    }
  }
}
