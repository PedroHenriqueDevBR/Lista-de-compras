import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/home/home_page.dart';
import 'package:market_shopping_list/src/shared/exceptions/login_canceled_exception.dart';
import 'package:market_shopping_list/src/shared/interfaces/person_storage_interface.dart';
import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/utils/colors_util.dart';
import 'package:market_shopping_list/src/shared/utils/images_reference_util.dart';
import 'package:asuka/asuka.dart' as asuka;

class LoginController {
  BuildContext context;
  late ColorUtil colorUtil;
  late ImageReference imageReference;
  late IPersonStorage _personStorage;
  final logged = ValueNotifier<bool>(false);
  final loading = ValueNotifier<bool>(false);

  LoginController({
    required IPersonStorage personStorage,
    required this.context,
  }) {
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
    loading.value = true;
    try {
      await _personStorage.loginPerson(person: Person.cleanData());
      loading.value = false;
      isLoggedPerson();
    } on LoginCanceledException catch (error) {
      showMessage('Login cancelado');
    } catch (error) {
      showMessage('Houve um problema, tente novamente');
    }
    loading.value = false;
  }

  void signOut() async {
    try {
      await _personStorage.signOut();
      isLoggedPerson();
    } catch (e) {
      showMessage('Ocorreu um erro, verifique a sua conexão com a internet');
    }
  }

  void showMessage(String message) {
    asuka.AsukaSnackbar.warning(message).show();
  }
}
