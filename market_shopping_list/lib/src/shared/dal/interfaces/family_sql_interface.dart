import '../../models/family.dart';
import '../../models/shopping_list.dart';

abstract class IFamilySQL {
  String createFamily(Family family);

  String getAllFamilies();

  String getFamilyByShoppingList(ShoppingList shoppingList);

  String updateFamily(Family family);

  String addShoppingList(Family family, ShoppingList shoppingList);

  String deleteFamily(Family family);
}
