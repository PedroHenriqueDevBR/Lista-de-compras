import '../models/family.dart';
import '../models/shopping_list.dart';

abstract class IFamilyStorage {
  Future<Family> createFamily(Family family);

  Future<List<Family>> getAllFamilies();

  Future<Family> getFamilyByShopping(ShoppingList shoppingList);

  Future<Family> updateFamily(Family family);

  Future<List<ShoppingList>> addShoppingList(Family family, ShoppingList shoppingList);

  Future<void> deleteFamily(Family family);
}
