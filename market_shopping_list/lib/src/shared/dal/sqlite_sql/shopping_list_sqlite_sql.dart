import 'package:market_shopping_list/src/shared/dal/interfaces/shopping_list_sql_interface.dart';
import 'package:market_shopping_list/src/shared/dal/sqlite_sql/database_sql.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';

class ShoppingListSQLite implements IShoppingListSQL {
  @override
  String selectAllShoppingListsByFamily(Family family) {
    return '''
      select * from ${DatabaseSQL.SHOPPING_LIST} where family = 1;
    ''';
  }

  @override
  String selectAllShoppingLists() {
    return '''
      select * from ${DatabaseSQL.SHOPPING_LIST};
    ''';
  }

  @override
  String updateShoppingList(ShoppingList shoppingList) {
    return '''
      update ${DatabaseSQL.SHOPPING_LIST}
      set title = '${shoppingList.title}',
      description = '${shoppingList.description}'
      where id = ${shoppingList.id};
    ''';
  }

  @override
  String completeShoppingList(ShoppingList shoppingList) {
    return '''
      update ${DatabaseSQL.SHOPPING_LIST}
      set is_done = 1
      where id = ${shoppingList.id};
    ''';
  }

  @override
  String redoCompleteShoppingList(ShoppingList shoppingList) {
    return '''
      update ${DatabaseSQL.SHOPPING_LIST}
      set is_done = 0
      where id = ${shoppingList.id};
    ''';
  }

  @override
  String removeShoppingList(ShoppingList shoppingList) {
    return '''
      delete from ${DatabaseSQL.SHOPPING_LIST} where id = ${shoppingList.id};
    ''';
  }

  @override
  String addItemToShoppingList(ShoppingList shoppingList, PurchaseItem purchaseItem) {
    return '''
      insert into ${DatabaseSQL.PURCHASE_ITEM}(product_name, quantity, price, shopping_list)
      values ('${purchaseItem}', ${purchaseItem.quantity}, ${purchaseItem.price}, ${shoppingList.id});
    ''';
  }

  @override
  String calculateShoppingListPrice(ShoppingList shoppingList) {
    return '''
      select sum(pi.quantity * pi.price) from ${DatabaseSQL.SHOPPING_LIST} as sl inner join ${DatabaseSQL.PURCHASE_ITEM} pi
      on sl.id = pi.shopping_list where sl.id = ${shoppingList.id};
    ''';
  }
}
