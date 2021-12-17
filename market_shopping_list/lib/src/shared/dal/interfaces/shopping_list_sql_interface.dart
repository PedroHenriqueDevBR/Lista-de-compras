import '../../models/family.dart';
import '../../models/purchase_item.dart';
import '../../models/shopping_list.dart';

abstract class IShoppingListSQL {
  String selectAllShoppingListsByFamily(Family family);

  String removeShoppingList(ShoppingList shoppingList);

  String selectAllShoppingLists();

  String updateShoppingList(ShoppingList shoppingList);

  String updateShoppingListWithFamily(ShoppingList shoppingList, Family family);

  String completeShoppingList(ShoppingList shoppingList);

  String redoCompleteShoppingList(ShoppingList shoppingList);

  String calculateShoppingListPrice(ShoppingList shoppingList);

  String addItemToShoppingList(ShoppingList shoppingList, PurchaseItem purchaseItem);

  String deleteShoppingListByFamilyId(Family family);
}
