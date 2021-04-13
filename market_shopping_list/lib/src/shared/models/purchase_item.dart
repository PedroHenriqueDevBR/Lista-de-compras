import 'dart:convert';

class PurchaseItem {
  dynamic? id;
  late int quantity;
  late double purchasePrice;
  late String productName;
  String? purchasedBy;

  PurchaseItem({
    this.id,
    this.purchasedBy,
    required this.quantity,
    required this.purchasePrice,
    required this.productName,
  });

  PurchaseItem.cleanData() {
    this.quantity = 0;
    this.purchasePrice = 0.0;
    this.productName = '';
  }

  void changeProduct(String product) {
    this.productName = product;
  }

  void changePersonPurchased(String person) {
    this.purchasedBy = person;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'purchasePrice': purchasePrice,
      'productName': productName,
      'purchasedBy': purchasedBy,
    };
  }

  factory PurchaseItem.fromMap(Map<String, dynamic> map) {
    return PurchaseItem(
      id: map['id'],
      quantity: map['quantity'],
      purchasePrice: map['purchasePrice'],
      productName: map['productName'],
      purchasedBy: map['purchasedBy'],
    );
  }

  @override
  String toString() {
    return '''PurchaseItem(
                id: ${id ?? "Empty"}, 
                quantity: $quantity, 
                purchasePrice: $purchasePrice, 
                productName: $productName, 
                purchasedBy: ${purchasedBy}
              )''';
  }

  String toJson() => json.encode(toMap());

  factory PurchaseItem.fromJson(String source) => PurchaseItem.fromMap(json.decode(source));
}
