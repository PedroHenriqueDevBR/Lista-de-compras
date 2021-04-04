import 'dart:convert';

import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

class Family {
  dynamic? id;
  late String family_id;
  late String name;
  late String password;
  List<String> administrators = [];
  List<ShoppingList> listToBuy = [];

  Family({
    this.id,
    required this.family_id,
    required this.name,
    required this.password,
  });

  Family.cleanData() {
    this.family_id = '';
    this.name = '';
    this.password = '';
  }

  void setAdministrators(List<String> administratorList) {
    this.administrators = administratorList;
  }

  void setListToBuy(List<ShoppingList> listToBuyList) {
    this.listToBuy = listToBuyList;
  }

  void addAdministrator(String personID) {
    this.administrators.add(personID);
  }

  void addShoppingList(ShoppingList shoppingList) {
    this.listToBuy.add(shoppingList);
  }

  String get administratorsToString {
    StringBuffer out = StringBuffer();
    for (String administratorID in this.administrators) {
      out.writeln(administratorID);
    }
    return out.toString();
  }

  String get listToBuyToString {
    StringBuffer out = StringBuffer();
    for (ShoppingList toBuy in this.listToBuy) {
      out.writeln(toBuy.toString());
    }
    return out.toString();
  }

  @override
  String toString() {
    return '''Family
                id: ${id ?? "Empty"}, 
                family_id: $family_id, 
                name: $name, 
                password: $password, 
                administrators: $administratorsToString, 
                listToBuy: $listToBuyToString
              )''';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'family_id': family_id,
      'name': name,
      'password': password,
      'administrators': administrators,
      'listToBuy': listToBuy,
    };
  }

  factory Family.fromMap(Map<String, dynamic> map) {
    return Family(
      id: map['id'],
      family_id: map['family_id'],
      name: map['name'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Family.fromJson(String source) => Family.fromMap(json.decode(source));
}
