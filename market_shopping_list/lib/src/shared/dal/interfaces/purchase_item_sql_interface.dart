import '../../models/purchase_item.dart';
import '../../models/shopping_list.dart';

abstract class IPurchaseItemSQL {
  String getAllPurchaseItensFromShoppingList(ShoppingList shoppingList);

  String updatePurchaseItem(PurchaseItem purchaseItem);

  String removePurchaseItem(PurchaseItem purchaseItem);

  String deletePurchaseItemByShoppingList(ShoppingList shoppingList);
}
