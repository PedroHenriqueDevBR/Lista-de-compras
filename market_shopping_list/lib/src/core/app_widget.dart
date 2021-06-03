import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:market_shopping_list/src/core/colors_util.dart';
import 'package:market_shopping_list/src/features/create_family/create_family_page.dart';
import 'package:market_shopping_list/src/features/list_families/list_families_page.dart';

class AppWidget extends StatelessWidget {
  void changeNavigatorColor() {
    dynamic systemTheme = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: AppColors.primaryColor,
      systemNavigationBarColor: AppColors.primaryColor,
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
        primaryColor: AppColors.primaryColor,
        appBarTheme: _appBarTheme(),
        brightness: Brightness.light,
      ),
      home: ListFamiliesPage(),
    );
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.white),
      backgroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(color: Colors.white),
      brightness: Brightness.dark,
      elevation: 0,
    );
  }
}
