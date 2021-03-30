import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        appBarTheme: _appBarTheme(),
        brightness: Brightness.light,
      ),
      home: LoginPage(),
    );
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.white),
      backgroundColor: _colorUtil.primaryColor,
      iconTheme: IconThemeData(color: Colors.white),
    );
  }
}
