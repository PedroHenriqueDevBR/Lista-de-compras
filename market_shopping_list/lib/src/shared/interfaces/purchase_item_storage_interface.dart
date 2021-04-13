import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/models/product.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

abstract class IPurchaseItemStorage {
  Future<PurchaseItem> registerPurchaseItem({
    required PurchaseItem purchaseItem,
  });

  Future<PurchaseItem> setBuyer({
    required PurchaseItem purchaseItem,
    required Person person,
  });

  Future<List<PurchaseItem>> selectAllPurchaseItensFromShoppingList({
    required ShoppingList shoppingList,
  });

  Future<PurchaseItem> updatePurchaseItem({
    required PurchaseItem purchaseItem,
  });

  Future<void> deletePurchaseItem({required PurchaseItem purchaseItem});
}
