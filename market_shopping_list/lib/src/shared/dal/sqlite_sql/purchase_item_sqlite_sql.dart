import 'package:market_shopping_list/src/shared/dal/interfaces/purchase_item_sql_interface.dart';
import 'package:market_shopping_list/src/shared/dal/sqlite_sql/database_sql.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';

class PurchaseItemSQLite implements IPurchaseItemSQL {
  @override
  String getAllPurchaseItensFromShoppingList(ShoppingList shoppingList) {
    return '''
      select * from ${DatabaseSQL.PURCHASE_ITEM} where ${DatabaseSQL.SHOPPING_LIST} = ${shoppingList.id};
    ''';
  }

  @override
  String updatePurchaseItem(PurchaseItem purchaseItem) {
    return '''
      update purchase_item
      set product_name = 'Arroz integral',
      quantity = 2,
      price = 22.50
      where id = 1;
    ''';
  }

  @override
  String removePurchaseItem(PurchaseItem purchaseItem) {
    return '''
      delete from ${DatabaseSQL.PURCHASE_ITEM} where id = ${purchaseItem.id};
    ''';
  }
}
