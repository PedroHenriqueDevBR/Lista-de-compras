import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/home/home_page.dart';
import 'package:market_shopping_list/src/shared/exceptions/login_canceled_exception.dart';
import 'package:market_shopping_list/src/shared/interfaces/person_storage_interface.dart';
import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/utils/colors_util.dart';
import 'package:market_shopping_list/src/shared/utils/images_reference_util.dart';

class LoginController {
  late ColorUtil colorUtil;
  late ImageReference imageReference;
  late IPersonStorage _personStorage;
  final logged = ValueNotifier<bool>(false);
  final errorMessage = ValueNotifier<String>('');

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
    try {
      Person person = await _personStorage.loginPerson(person: Person.cleanData());
      print('Inspecionando person');
      isLoggedPerson();
      clearErrorMessage();
    } on LoginCanceledException catch (error) {
      errorMessage.value = 'Login cancelado';
    } catch (error) {
      errorMessage.value = 'Houve um problema, tente novamente mais tarde';
    }
  }

  void signOut() async {
    try {
      await _personStorage.signOut();
      isLoggedPerson();
    } catch {
      errorMessage.value = 'Ocorreu um erro, verifique a sua conexão com a internet';
    }
  }

  void clearErrorMessage() {
    errorMessage.value = '';
  }
}
