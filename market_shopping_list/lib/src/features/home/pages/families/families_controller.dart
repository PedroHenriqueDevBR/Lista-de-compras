import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/show_family/show_family_page.dart';
import 'package:market_shopping_list/src/shared/interfaces/family_storage_interface.dart';
import 'package:market_shopping_list/src/shared/interfaces/person_storage_interface.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/utils/colors_util.dart';
import 'package:market_shopping_list/src/shared/utils/images_reference_util.dart';
import 'package:asuka/asuka.dart' as asuka;

class FamiliesController {
  late ColorUtil colorUtil;
  late ImageReference imageReference;
  late IFamilyStorage _familyStorage;
  late IPersonStorage _personStorage;

  BuildContext context;
  Family familyToSave = Family.cleanData();
  ValueNotifier<List<Family>> families = ValueNotifier<List<Family>>([]);
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  ValueNotifier<bool> loadDataFromDatabaseIsDone = ValueNotifier<bool>(false);

  FamiliesController({
    required this.context,
    required IFamilyStorage familyStorage,
    required IPersonStorage personStorage,
  }) {
    this.colorUtil = ColorUtil();
    this.imageReference = ImageReference();
    this._familyStorage = familyStorage;
    this._personStorage = personStorage;

    this.getFamiliesFromDatabase();
  }

  Future<Person> getLoggedPerson() async {
    late Person person;
    try {
      person = await _personStorage.getLoggedPerson();
    } catch (e) {
      asuka.AsukaSnackbar.message('Ocorreu um erro interno');
    }
    return person;
  }

  void getFamiliesFromDatabase() async {
    try {
      Person person = await _personStorage.getLoggedPerson();
      List<Family> familiesResponse = await _familyStorage.selectAllFamiliesFromPerson(person: person);
      this.families.value = familiesResponse;
    } catch (e) {
      print(e);
      asuka.AsukaSnackbar.message('Ocorreu um erro interno ao buscar as famílias');
    } finally {
      loadDataFromDatabaseIsDone.value = true;
    }
  }

  void createFamily() async {
    try {
      familyToSave.family_id = await generateIDForFamily();
      familyToSave.password = generatePasswordDForFamily();
      Family familyResponse = await _familyStorage.registerFamily(family: familyToSave);

      families.value.add(familyResponse);
      clearFamilyToSave();
      families.notifyListeners();
    } catch (error) {
      print(error);
      asuka.AsukaSnackbar.alert('Erro ao cadastrar família');
    }
  }

  void clearFamilyToSave() {
    familyToSave = Family.cleanData();
  }

  Future<String> generateIDForFamily() async {
    Person person = await getLoggedPerson();
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    StringBuffer out = StringBuffer();
    out.write('${familyToSave.name.replaceAll(' ', '_')}-');
    out.write('${person.name.replaceAll(' ', '_')}-');
    out.write('${time}');
    return out.toString();
  }

  String generatePasswordDForFamily() {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    StringBuffer out = StringBuffer();
    out.write('${familyToSave.name.replaceAll(' ', '_')}-');
    out.write('${time}');
    return out.toString();
  }

  void goToShowFamilyPage(Family family) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowFamilyPage(family: family),
      ),
    );
  }
}
