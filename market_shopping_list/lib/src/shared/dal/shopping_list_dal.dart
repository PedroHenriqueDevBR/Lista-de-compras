import 'dart:io' show Platform;

import 'package:sqflite/sqflite.dart';

import '../interfaces/shopping_list_interface.dart';
import '../models/family.dart';
import '../models/purchase_item.dart';
import '../models/shopping_list.dart';
import '../services/connection_base.dart';
import '../services/sqflite_connection.dart';
import '../services/sqflite_connection_desktop.dart';
import 'interfaces/purchase_item_sql_interface.dart';
import 'interfaces/shopping_list_sql_interface.dart';

class ShoppingListDAL implements IShoppingListStorage {
  IShoppingListSQL shoppingListSQL;
  IPurchaseItemSQL purchaseItemSQL;
  late IConnectionBase connection;

  ShoppingListDAL({
    required this.shoppingListSQL,
    required this.purchaseItemSQL,
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
  Future<List<ShoppingList>> selectAllShoppingLists() async {
    try {
      final db = await getDatabase();
      List<Map> response =
          await db.rawQuery(shoppingListSQL.selectAllShoppingLists());
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
  Future<List<ShoppingList>> selectAllShoppingListsByFamily(
      Family family) async {
    try {
      final db = await getDatabase();
      List<Map> response = await db
          .rawQuery(shoppingListSQL.selectAllShoppingListsByFamily(family));
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
      final db = await getDatabase();
      final affectedRows =
          await db.rawUpdate(shoppingListSQL.updateShoppingList(shoppingList));
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
      final db = await getDatabase();
      final affectedRows = await db
          .rawUpdate(shoppingListSQL.completeShoppingList(shoppingList));
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
  Future<ShoppingList> redoCompleteShoppingList(
      ShoppingList shoppingList) async {
    try {
      final db = await getDatabase();
      final affectedRows = await db
          .rawUpdate(shoppingListSQL.redoCompleteShoppingList(shoppingList));
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
      final db = await getDatabase();
      final affectedRows =
          await db.rawDelete(shoppingListSQL.removeShoppingList(shoppingList));
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
      final db = await getDatabase();
      List<Map> response = await db
          .rawQuery(shoppingListSQL.calculateShoppingListPrice(shoppingList));
      return double.parse(response[0]['sum']);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<List<PurchaseItem>> addItemToShoppingList(
      ShoppingList shoppingList, PurchaseItem purchaseItem) async {
    try {
      final db = await getDatabase();
      await db.rawInsert(
          shoppingListSQL.addItemToShoppingList(shoppingList, purchaseItem));
      List<Map> response = await db.rawQuery(
          purchaseItemSQL.getAllPurchaseItensFromShoppingList(shoppingList));
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
  Future<ShoppingList> updateShoppingListWithFamily(
      ShoppingList shoppingList, Family family) async {
    try {
      final db = await getDatabase();
      final affectedRows = await db.rawUpdate(
          shoppingListSQL.updateShoppingListWithFamily(shoppingList, family));
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
  Future<void> deleteToShoppingListByFamily(Family family) async {
    try {
      final db = await getDatabase();
      await db.rawDelete(shoppingListSQL.deleteShoppingListByFamilyId(family));
    } catch (error) {
      throw Exception(error);
    }
  }
}
