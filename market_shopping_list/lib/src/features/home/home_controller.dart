import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_shopping_list/src/features/login/login_page.dart';
import 'package:market_shopping_list/src/shared/interfaces/person_storage_interface.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/utils/colors_util.dart';
import 'package:market_shopping_list/src/shared/utils/images_reference_util.dart';

class HomeController {
  BuildContext context;
  late ColorUtil colorUtil;
  late ImageReference imageReference;
  late IPersonStorage _personStorage;

  List<Family> families = [
    Family(family_id: '01', name: 'Familia Lima', password: '123456'),
    Family(family_id: '02', name: 'Familia Lima 02', password: '123456'),
    Family(family_id: '03', name: 'Familia Lima 03', password: '123456'),
  ];

  HomeController({
    required this.context,
    required IPersonStorage personStorage,
  }) {
    this.colorUtil = ColorUtil();
    this.imageReference = ImageReference();
    this._personStorage = personStorage;
  }

  void endSession() async {
    try {
      await _personStorage.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
        (route) => false,
      );
    } catch (error) {
      print(error);
    }
  }
}
