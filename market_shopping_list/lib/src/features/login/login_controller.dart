import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/home/home_page.dart';
import 'package:market_shopping_list/src/shared/exceptions/login_canceled_exception.dart';
import 'package:market_shopping_list/src/shared/interfaces/person_storage_interface.dart';
import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/utils/colors_util.dart';
import 'package:market_shopping_list/src/shared/utils/images_reference_util.dart';

class LoginController {
  BuildContext context;
  late ColorUtil colorUtil;
  late ImageReference imageReference;
  late IPersonStorage _personStorage;
  final logged = ValueNotifier<bool>(false);
  final errorMessage = ValueNotifier<String>('');

  LoginController({required IPersonStorage personStorage, required this.context}) {
    this.colorUtil = ColorUtil();
    this.imageReference = ImageReference();
    this._personStorage = personStorage;
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void isLoggedPerson() async {
    bool isLogged = await _personStorage.isLoggedPerson();
    if (isLogged) {
      goToHomePage(context);
    }
    logged.value = isLogged;
  }

  void loginWithGoogle() async {
    try {
      await _personStorage.loginPerson(person: Person.cleanData());
      isLoggedPerson();
      clearErrorMessage();
    } on LoginCanceledException catch (error) {
      errorMessage.value = 'Login cancelado';
    } catch (error) {
      errorMessage.value = 'Houve um problema, tente novamente';
    }
  }

  void signOut() async {
    try {
      await _personStorage.signOut();
      isLoggedPerson();
    } catch (e) {
      errorMessage.value = 'Ocorreu um erro, verifique a sua conexão com a internet';
    }
  }

  void clearErrorMessage() {
    errorMessage.value = '';
  }
}
