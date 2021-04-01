import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_shopping_list/src/features/home/home_page.dart';
import 'package:market_shopping_list/src/shared/interfaces/person_storage_interface.dart';
import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/utils/colors_util.dart';
import 'package:market_shopping_list/src/shared/utils/images_reference_util.dart';

class LoginController {
  late ColorUtil colorUtil;
  late ImageReference imageReference;
  late IPersonStorage _personStorage;
  final logged = ValueNotifier<bool>(false);

  LoginController({required IPersonStorage personStorage}) {
    this.colorUtil = ColorUtil();
    this.imageReference = ImageReference();
    this._personStorage = personStorage;
  }

  void goToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  void isLoggedPerson() async {
    bool response = await _personStorage.isLoggedPerson();
    logged.value = response;
  }

  void loginWithGoogle() async {
    Person person = Person(name: 'name', email: 'email', password: 'password');
    await _personStorage.loginPerson(person: person);
    isLoggedPerson(); // TODO: Não está sendo apresentado se o usuário está ou não logado na tela de login
  }

  void signOut() async {
    await _personStorage.signOut();
    isLoggedPerson();
  }
}
