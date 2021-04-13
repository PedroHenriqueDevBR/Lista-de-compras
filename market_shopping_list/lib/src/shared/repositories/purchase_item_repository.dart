import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_shopping_list/src/shared/interfaces/purchase_item_storage_interface.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';
import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/repositories/database_reference_model.dart';

class PurchaseItemRepository implements IPurchaseItemStorage {
  late FirebaseFirestore _firestore;
  late DatabaseReference _databaseReference;

  PurchaseItemRepository() {
    this._firestore = FirebaseFirestore.instance;
    this._databaseReference = DatabaseReference();
  }

  @override
  Future<PurchaseItem> registerPurchaseItem({required PurchaseItem purchaseItem}) async {
    // TODO: implement selectAllPurchaseItensFromShoppingList
    throw UnimplementedError();
  }

  @override
  Future<List<PurchaseItem>> selectAllPurchaseItensFromShoppingList({required ShoppingList shoppingList}) {
    // TODO: implement selectAllPurchaseItensFromShoppingList
    throw UnimplementedError();
  }

  @override
  Future<PurchaseItem> setBuyer({required PurchaseItem purchaseItem, required Person person}) {
    // TODO: implement setBuyer
    throw UnimplementedError();
  }

  @override
  Future<PurchaseItem> updatePurchaseItem({required PurchaseItem purchaseItem}) {
    // TODO: implement updatePurchaseItem
    throw UnimplementedError();
  }

  @override
  Future<void> deletePurchaseItem({required PurchaseItem purchaseItem}) {
    // TODO: implement deletePurchaseItem
    throw UnimplementedError();
  }
}
