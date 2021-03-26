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

  Product copyWith({
    dynamic? id,
    String? name,
    double? minimum_price,
    double? maximum_price,
    double? last_price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      minimum_price: minimum_price ?? this.minimum_price,
      maximum_price: maximum_price ?? this.maximum_price,
      last_price: last_price ?? this.last_price,
    );
  }
}
