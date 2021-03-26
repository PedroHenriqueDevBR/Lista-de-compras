import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/models/product.dart';

class PurchaseItem {
  dynamic? id;
  late int quantity;
  late double purchasePrice;
  late Product product;
  Person? purchasedBy;

  PurchaseItem({
    this.id,
    this.purchasedBy,
    required this.quantity,
    required this.purchasePrice,
    required this.product,
  });

  PurchaseItem.cleanData() {
    this.quantity = 0;
    this.purchasePrice = 0.0;
    this.product = Product.cleanData();
  }

  void changeProduct(Product product) {
    this.product = product;
  }

  void changePersonPurchased(Person person) {
    this.purchasedBy = person;
  }

  @override
  String toString() {
    return '''PurchaseItem(
                id: ${id ?? "Empty"}, 
                quantity: $quantity, 
                purchasePrice: $purchasePrice, 
                product: $product, 
                purchasedBy: ${purchasedBy != null ? purchasedBy!.name : "Empty"}
              )''';
  }
}
