class Product {
  dynamic? id;
  late String name;
  late double minimum_price;
  late double maximum_price;
  late double last_price;

  Product({
    this.id,
    required this.name,
    required this.minimum_price,
    required this.maximum_price,
    required this.last_price,
  });

  Product.cleanData() {
    this.name = '';
    this.minimum_price = 0.0;
    this.maximum_price = 0.0;
    this.last_price = 0.0;
  }

  @override
  String toString() {
    return '''Product(
                id: ${id ?? "Empty"}, 
                name: $name, 
                minimum_price: $minimum_price, 
                maximum_price: $maximum_price, 
                last_price: $last_price
              )''';
  }
}
