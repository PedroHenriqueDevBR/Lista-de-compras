import '../../models/purchase_item.dart';
import '../../models/shopping_list.dart';
import '../interfaces/purchase_item_sql_interface.dart';
import 'database_sql.dart';

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
      update ${DatabaseSQL.PURCHASE_ITEM}
      set product_name = '${purchaseItem.productName}',
      quantity = ${purchaseItem.quantity},
      price = ${purchaseItem.price}
      where id = ${purchaseItem.id};
    ''';
  }

  @override
  String removePurchaseItem(PurchaseItem purchaseItem) {
    return '''
      delete from ${DatabaseSQL.PURCHASE_ITEM} where id = ${purchaseItem.id};
    ''';
  }

  @override
  String deletePurchaseItemByShoppingList(ShoppingList shoppingList) {
    return '''
      delete from ${DatabaseSQL.PURCHASE_ITEM} where shopping_list = ${shoppingList.id};
    ''';
  }
}
