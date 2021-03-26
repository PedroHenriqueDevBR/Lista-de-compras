import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

class Family {
  dynamic? id;
  late String family_id;
  late String name;
  late String password;
  List<Person> administrators = [];
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

  void setAdministrators(List<Person> administratorList) {
    this.administrators = administratorList;
  }

  void setListToBuy(List<ShoppingList> listToBuyList) {
    this.listToBuy = listToBuyList;
  }

  void addAdministrator(Person person) {
    this.administrators.add(person);
  }

  void addShoppingList(ShoppingList shoppingList) {
    this.listToBuy.add(shoppingList);
  }

  String get administratorsToString {
    StringBuffer out = StringBuffer();
    for (Person administrator in this.administrators) {
      out.writeln(administrator.toString());
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
}
