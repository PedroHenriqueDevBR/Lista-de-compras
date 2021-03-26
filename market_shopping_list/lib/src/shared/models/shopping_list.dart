import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';

class ShoppingList {
  dynamic? id;
  late Person created_by;
  late String title;
  late String description;
  late bool is_done;
  late DateTime created_at;
  List<PurchaseItem> productsItens = [];

  ShoppingList({
    this.id,
    required this.created_by,
    required this.title,
    required this.description,
    required this.created_at,
    this.is_done = null ?? false,
  });

  ShoppingList.createWithNowDate({
    this.id,
    required this.created_by,
    required this.title,
    required this.description,
    this.is_done = null ?? false,
  }) {
    this.created_at = DateTime.now();
  }

  ShoppingList.cleanData() {
    this.created_by = Person.cleanData();
    this.title = '';
    this.description = '';
    this.is_done = false;
    this.created_at = DateTime.now();
  }

  void addProductItem(PurchaseItem item) {
    this.productsItens.add(item);
  }
}
