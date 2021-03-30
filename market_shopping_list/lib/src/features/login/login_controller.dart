import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_shopping_list/src/features/home/home_page.dart';
import 'package:market_shopping_list/src/shared/utils/colors_util.dart';
import 'package:market_shopping_list/src/shared/utils/images_reference_util.dart';

class LoginController {
  late ColorUtil colorUtil;
  late ImageReference imageReference;

  LoginController() {
    this.colorUtil = ColorUtil();
    this.imageReference = ImageReference();
  }

  void goToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }
}
