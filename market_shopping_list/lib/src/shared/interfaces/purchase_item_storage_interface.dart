import '../models/purchase_item.dart';
import '../models/shopping_list.dart';

abstract class IPurchaseItemStorage {
  Future<List<PurchaseItem>> getAllPurchaseItensFromShoppingList(ShoppingList shoppingList);

  Future<PurchaseItem> updatePurchaseItem(PurchaseItem purchaseItem);

  Future<void> removePurchaseItem(PurchaseItem purchaseItem);

  Future<void> deletePurchaseItemByShoppingList(ShoppingList shoppingList);
}
