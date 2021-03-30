import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/home/home_page.dart';

class LoginController {
  void goToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }
}
