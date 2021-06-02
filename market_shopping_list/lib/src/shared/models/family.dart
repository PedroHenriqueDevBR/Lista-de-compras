import 'dart:convert';

import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

class Family {
  dynamic? id;
  String name;
  List<ShoppingList> listToBuy = [];

  Family({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Family.fromMap(Map<String, dynamic> map) {
    return Family(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Family.fromJson(String source) => Family.fromMap(json.decode(source));
}
