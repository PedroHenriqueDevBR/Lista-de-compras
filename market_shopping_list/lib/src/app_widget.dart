import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_shopping_list/src/features/login/login_page.dart';
import 'package:market_shopping_list/src/features/splash/splash_page.dart';
import 'package:market_shopping_list/src/shared/utils/colors_util.dart';
import 'package:asuka/asuka.dart' as asuka;

class AppWidget extends StatelessWidget {
  ColorUtil _colorUtil = ColorUtil();

  void changeNavigatorColor() {
    dynamic systemTheme = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: _colorUtil.primaryColor,
      systemNavigationBarColor: _colorUtil.primaryColor,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);
  }

  @override
  Widget build(BuildContext context) {
    changeNavigatorColor();
    return MaterialApp(
      builder: asuka.builder,
      navigatorObservers: [asuka.asukaHeroController],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: _appBarTheme(),
        brightness: Brightness.light,
      ),
      home: SplashPage(),
    );
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.white),
      backgroundColor: _colorUtil.primaryColor,
      iconTheme: IconThemeData(color: Colors.white),
      brightness: Brightness.dark,
    );
  }
}
