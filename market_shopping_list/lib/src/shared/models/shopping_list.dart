import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';

class ShoppingList {
  dynamic? id;
  late Person created_by;
  late String title;
  late String description;
  late bool is_done;
  late DateTime created_at;
  List<PurchaseItem> productItens = [];

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
    this.productItens.add(item);
  }

  String get createdAtFormatedToLocalDate {
    DateTime date = this.created_at;
    return '${date.day}/' + '${date.month}/' + '${date.year}';
  }

  String get productsToString {
    StringBuffer out = StringBuffer();
    for (PurchaseItem product in this.productItens) {
      out.writeln(product.toString());
    }
    return out.toString();
  }

  @override
  String toString() {
    return '''ShoppingList(
                id: ${id ?? "Empty"}, 
                created_by: ${created_by.name}, 
                title: $title, 
                description: $description, 
                is_done: $is_done,
                created_at: $createdAtFormatedToLocalDate, 
                productsItens: $productsToString)
              ${"-" * 30}''';
  }
}
