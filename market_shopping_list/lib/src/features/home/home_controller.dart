import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/utils/colors_util.dart';
import 'package:market_shopping_list/src/shared/utils/images_reference_util.dart';

class HomeController {
  late ColorUtil colorUtil;
  late ImageReference imageReference;
  List<Family> families = [
    Family(family_id: '01', name: 'Familia Lima', password: '123456'),
    Family(family_id: '02', name: 'Familia Lima 02', password: '123456'),
    Family(family_id: '03', name: 'Familia Lima 03', password: '123456'),
  ];

  HomeController() {
    this.colorUtil = ColorUtil();
    this.imageReference = ImageReference();
  }
}
