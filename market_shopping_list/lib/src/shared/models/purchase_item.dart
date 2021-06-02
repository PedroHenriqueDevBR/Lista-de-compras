import 'dart:convert';

class PurchaseItem {
  dynamic? id;
  int quantity;
  double price;
  String productName;

  PurchaseItem({
    this.id,
    required this.quantity,
    required this.price,
    required this.productName,
  });

  factory PurchaseItem.fromSQLite(Map map) {
    return PurchaseItem(
      id: map['id'],
      quantity: map['quantity'],
      price: map['price'],
      productName: map['product_name'],
    );
  }
}
