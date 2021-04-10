import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_shopping_list/src/features/login/login_page.dart';
import 'package:market_shopping_list/src/features/splash/splash_page.dart';
import 'package:market_shopping_list/src/shared/interfaces/family_storage_interface.dart';
import 'package:market_shopping_list/src/shared/interfaces/person_storage_interface.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/repositories/family_repository.dart';
import 'package:market_shopping_list/src/shared/repositories/person_repository.dart';
import 'package:market_shopping_list/src/shared/utils/colors_util.dart';
import 'package:market_shopping_list/src/shared/utils/images_reference_util.dart';

class HomeController {
  BuildContext context;
  late ColorUtil colorUtil;
  late ImageReference imageReference;
  late IPersonStorage _personStorage;
  late IFamilyStorage _familyStorage;
  ValueNotifier<List<Family>> families = ValueNotifier<List<Family>>([]);

  HomeController({
    required this.context,
  }) {
    this.colorUtil = ColorUtil();
    this.imageReference = ImageReference();
    this._personStorage = PersonRepository();
    this._familyStorage = FamilyRepository();
    getFamiliesFromDatabase();
  }

  Future<void> getFamiliesFromDatabase() async {
    Person person = await _personStorage.getLoggedPerson();
    List<Family> familiesResponse = await _familyStorage.selectAllFamiliesFromPerson(person: person);
    families.value = familiesResponse;
    families.notifyListeners();
    // TODO: Deve pegar esses dados de um lugar centralizado para evitar problemas
  }

  void endSession() async {
    try {
      await _personStorage.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SplashPage(),
        ),
        (route) => false,
      );
    } catch (error) {
      print(error);
    }
  }
}
