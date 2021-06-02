import 'package:market_shopping_list/src/shared/models/purchase_item.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

abstract class IPurchaseItemSQL {
  String getAllPurchaseItensFromShoppingList(ShoppingList shoppingList);

  String updatePurchaseItem(PurchaseItem purchaseItem);

  String removePurchaseItem(PurchaseItem purchaseItem);
}
