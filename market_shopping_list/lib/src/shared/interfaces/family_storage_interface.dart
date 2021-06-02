import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

abstract class IFamilyStorage {
  Future<Family> createFamily(Family family);

  Future<List<Family>> getAllFamilies();

  Future<Family> updateFamily(Family family);

  Future<List<ShoppingList>> addShoppingList(Family family, ShoppingList shoppingList);
}
