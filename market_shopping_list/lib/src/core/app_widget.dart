import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:market_shopping_list/src/core/colors_util.dart';

class AppWidget extends StatelessWidget {
  AppColors _colorUtil = AppColors();

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
        primarySwatch: Colors.indigo,
        primaryColor: _colorUtil.primaryColor,
        appBarTheme: _appBarTheme(),
        brightness: Brightness.light,
      ),
      home: AppPage(),
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

class AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Apenas um teste'),
      ),
    );
  }
}
