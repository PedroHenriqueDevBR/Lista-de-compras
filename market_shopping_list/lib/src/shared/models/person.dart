import 'package:market_shopping_list/src/shared/models/family.dart';

class Person {
  dynamic? id;
  late String name;
  late String email;
  late String password;
  List<Family> families = [];

  Person({
    required this.name,
    required this.email,
    required this.password,
  });

  Person.cleanData() {
    this.name = '';
    this.email = '';
    this.password = '';
  }

  void setFamilies(List<Family> familyList) {
    this.families = familyList;
  }

  void addFamily(Family family) {
    this.families.add(family);
  }
}
