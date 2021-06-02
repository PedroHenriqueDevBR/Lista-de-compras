import 'package:market_shopping_list/src/shared/models/purchase_item.dart';

class ShoppingList {
  dynamic? id;
  String title;
  String? description;
  bool is_done;
  DateTime created_at = DateTime.now();
  List<PurchaseItem> productItens = [];

  ShoppingList({
    this.id,
    required this.title,
    this.description,
    this.is_done = false,
  });
}
