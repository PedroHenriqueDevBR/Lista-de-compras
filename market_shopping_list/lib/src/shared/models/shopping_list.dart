import 'purchase_item.dart';

class ShoppingList {
  dynamic? id;
  String title;
  String? description;
  bool isDone;
  late DateTime createdAt;
  List<PurchaseItem> productItens = [];

  ShoppingList({
    this.id,
    required this.title,
    this.description,
    this.isDone = false,
    DateTime? createdAt,
  }) {
    if (createdAt == null) {
      this.createdAt = DateTime.now();
    } else {
      this.createdAt = createdAt;
    }
  }

  ShoppingList.withNoData({
    this.title: '',
    this.description = '',
    this.isDone = false,
  }) {
    this.createdAt = DateTime.now();
  }

  void setProductItens(List<PurchaseItem> productItens) => this.productItens = productItens;

  void addProductItem(PurchaseItem purchaseItem) => this.productItens.add(purchaseItem);

  factory ShoppingList.fromSQLite(Map map) {
    return ShoppingList(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isDone: map['is_done'] == 0 ? false : true,
      createdAt: DateTime.fromMillisecondsSinceEpoch(int.parse(map['create_at'])),
    );
  }
}
