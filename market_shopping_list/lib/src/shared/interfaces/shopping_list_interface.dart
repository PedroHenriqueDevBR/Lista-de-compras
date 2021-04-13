import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

abstract class IShoppingListStorage {
  Future<ShoppingList> registerShoppingList(ShoppingList shoppingList);

  Future<List<ShoppingList>> allShoppingListFromFamily({
    required Family family,
  });

  Future<List<ShoppingList>> allPendingShoppingListFromFamily({
    required Family family,
  });

  Future<List<ShoppingList>> allDoneShoppingListFromFamily({
    required Family family,
  });

  Future<List<ShoppingList>> allShoppingListFromFamilyByData({
    required DateTime date,
  });

  Future<List<ShoppingList>> getAllEmptyShoppingListFromFamily({
    required Family family,
  });

  Future<ShoppingList> addItemToShoppingList({
    required ShoppingList shoppingList,
    required PurchaseItem item,
  });

  Future<ShoppingList> removeItemToShoppingList({
    required ShoppingList shoppingList,
    required PurchaseItem item,
  });

  Future<ShoppingList> updateShoppingList({required ShoppingList shoppingList});

  Future<void> deleteShoppingList({required ShoppingList shoppingList});
}
