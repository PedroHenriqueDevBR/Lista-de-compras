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

  Family.withNoData({this.name = ''});

  void setListToBuy(List<ShoppingList> listToBuy) => this.listToBuy = listToBuy;

  void addListToBuy(ShoppingList listToBuy) => this.listToBuy.add(listToBuy);

  factory Family.fromSQLite(Map map) {
    return Family(
      id: map['id'],
      name: map['name'],
    );
  }
}
