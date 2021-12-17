import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../features/list_families/list_families_page.dart';
import 'colors_util.dart';

class AppWidget extends StatelessWidget {
  void changeNavigatorColor() {
    dynamic systemTheme = SystemUiOverlayStyle.light.copyWith(
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
