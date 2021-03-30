import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/login/login_page.dart';
import 'package:market_shopping_list/src/shared/utils/colors_util.dart';

class AppWidget extends StatelessWidget {
  ColorUtil _colorUtil = ColorUtil();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
