import '../../models/family.dart';
import '../../models/purchase_item.dart';
import '../../models/shopping_list.dart';
import '../interfaces/shopping_list_sql_interface.dart';
import 'database_sql.dart';

class ShoppingListSQLite implements IShoppingListSQL {
  @override
  String selectAllShoppingListsByFamily(Family family) {
    return '''
      select * from ${DatabaseSQL.SHOPPING_LIST} where family = ${family.id};
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
      is_done = ${shoppingList.isDone ? 1 : 0}
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
      values ('${purchaseItem.productName}', ${purchaseItem.quantity}, ${purchaseItem.price}, ${shoppingList.id});
    ''';
  }

  @override
  String calculateShoppingListPrice(ShoppingList shoppingList) {
    return '''
      select sum(pi.quantity * pi.price) from ${DatabaseSQL.SHOPPING_LIST} as sl inner join ${DatabaseSQL.PURCHASE_ITEM} pi
      on sl.id = pi.shopping_list where sl.id = ${shoppingList.id};
    ''';
  }

  @override
  String updateShoppingListWithFamily(ShoppingList shoppingList, Family family) {
    return '''
      update ${DatabaseSQL.SHOPPING_LIST}
      set title = '${shoppingList.title}',
      description = '${shoppingList.description}',
      is_done = ${shoppingList.isDone ? 1 : 0},
      family = ${family.id}
      where id = ${shoppingList.id};
    ''';
  }

  @override
  String deleteShoppingListByFamilyId(Family family) {
    return '''
    delete from ${DatabaseSQL.SHOPPING_LIST} where family = ${family.id};
    ''';
  }
}
