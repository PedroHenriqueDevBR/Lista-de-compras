import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/models/product.dart';

class PurchaseItem {
  dynamic? id;
  late int quantity;
  late double price;
  late double purchasePrice;
  late Product product;
  Person? purchasedBy;

  PurchaseItem({
    this.id,
    this.purchasedBy,
    required this.quantity,
    required this.price,
    required this.purchasePrice,
    required this.product,
  });

  PurchaseItem.cleanData() {
    this.quantity = 0;
    this.price = 0.0;
    this.purchasePrice = 0.0;
    this.product = Product.cleanData();
  }

  void changeProduct(Product product) {
    this.product = product;
  }

  void changePersonPurchased(Person person) {
    this.purchasedBy = person;
  }
}
