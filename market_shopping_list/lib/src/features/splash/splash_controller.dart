import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/home/home_page.dart';
import 'package:market_shopping_list/src/features/login/login_page.dart';
import 'package:market_shopping_list/src/shared/interfaces/person_storage_interface.dart';
import 'package:market_shopping_list/src/shared/utils/colors_util.dart';
import 'package:market_shopping_list/src/shared/utils/images_reference_util.dart';

class SplashController {
  BuildContext context;
  late ImageReference imageReference;
  late ColorUtil colorUtil;
  late IPersonStorage _personStorage;

  SplashController({required this.context, required IPersonStorage personStorage}) {
    imageReference = ImageReference();
    colorUtil = ColorUtil();
    this._personStorage = personStorage;
  }

  void goToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void goToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void isLoggedPerson() async {
    bool isLogged = await _personStorage.isLoggedPerson();
    if (isLogged) {
      goToHomePage();
    } else {
      goToLoginPage();
    }
  }
}
