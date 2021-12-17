import '../models/family.dart';
import '../models/purchase_item.dart';
import '../models/shopping_list.dart';

abstract class IShoppingListStorage {
  Future<List<ShoppingList>> selectAllShoppingListsByFamily(Family family);

  Future<void> removeShoppingList(ShoppingList shoppingList);

  Future<List<ShoppingList>> selectAllShoppingLists();

  Future<ShoppingList> updateShoppingList(ShoppingList shoppingList);

  Future<ShoppingList> updateShoppingListWithFamily(ShoppingList shoppingList, Family family);

  Future<ShoppingList> completeShoppingList(ShoppingList shoppingList);

  Future<ShoppingList> redoCompleteShoppingList(ShoppingList shoppingList);

  Future<double> calculateShoppingListPrice(ShoppingList shoppingList);

  Future<List<PurchaseItem>> addItemToShoppingList(ShoppingList shoppingList, PurchaseItem purchaseItem);

  Future<void> deleteToShoppingListByFamily(Family family);
}
