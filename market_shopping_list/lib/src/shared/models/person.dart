import 'package:market_shopping_list/src/shared/models/family.dart';

class Person {
  dynamic? id;
  late String photoURL;
  late String name;
  late String email;
  late String password;
  List<Family> families = [];

  Person({
    this.id,
    this.photoURL = null ?? '',
    required this.name,
    required this.email,
    required this.password,
  });

  Person.cleanData() {
    this.photoURL = '';
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

  String get familiesToString {
    StringBuffer out = StringBuffer();
    for (Family family in this.families) {
      out.writeln(family.toString());
    }
    return out.toString();
  }

  @override
  String toString() {
    return '''Person(
                id: ${id ?? "Empty"},
                name: $name,
                email: $email,
                photoURL: $photoURL,
                password: $password,
                families: $familiesToString
              )''';
  }
}
