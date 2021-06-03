import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

abstract class IFamilySQL {
  String createFamily(Family family);

  String getAllFamilies();

  String updateFamily(Family family);

  String addShoppingList(Family family, ShoppingList shoppingList);

  String deleteFamily(Family family);
}
