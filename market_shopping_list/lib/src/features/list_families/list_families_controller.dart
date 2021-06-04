import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/create_family/create_family_page.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:market_shopping_list/src/shared/interfaces/family_storage_interface.dart';
import 'package:market_shopping_list/src/shared/interfaces/shopping_list_interface.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:asuka/asuka.dart' as asuka;

class ListFamiliesController {
  RxNotifier<bool> dialVisible = RxNotifier<bool>(false);
  RxNotifier<int> selectedFamily = RxNotifier<int>(-1);
  RxList<int> pendingShoppingList = RxList<int>();
  RxList<Family> families = RxList<Family>();
  RxList<ShoppingList> shoppingList = RxList<ShoppingList>();
  IFamilyStorage familyStorage;
  IShoppingListStorage shoppingStorage;

  ListFamiliesController({
    required this.familyStorage,
    required this.shoppingStorage,
  }) {
    getAllFamiliesFromDatabase();
  }

  void getAllFamiliesFromDatabase() async {
    try {
      List<Family> familiesResponse = await familyStorage.getAllFamilies();
      this.families.clear();
      this.families.addAll(familiesResponse);
    } catch (error) {
      asuka.showSnackBar(
        asuka.AsukaSnackbar.alert('Erro ao carregar lista de categorias'),
      );
    }
  }

  void setDialVisible(bool value) {
    this.dialVisible.value = value;
  }

  void selectfamily(int value) {
    if (this.selectedFamily.value == value) {
      this.selectedFamily.value = -1;
    } else {
      this.selectedFamily.value = value;
    }
  }

  void goToCreateFamilyPage(BuildContext context, {Family? family}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CreateFamilyPage(
          family: family,
        ),
      ),
    ).then((value) => getAllFamiliesFromDatabase());
  }

  void goToCreateShoppingListPage(BuildContext context) {
    print('Deve ser implementado');
  }
}
