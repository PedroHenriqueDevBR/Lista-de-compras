import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/create_family/create_family_page.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:market_shopping_list/src/shared/interfaces/family_storage_interface.dart';
import 'package:market_shopping_list/src/shared/interfaces/shopping_list_interface.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

class CreateShoppingListController {
  RxNotifier<ShoppingList> shopping = RxNotifier<ShoppingList>(ShoppingList.withNoData());
  RxNotifier<Family> family = RxNotifier<Family>(Family.withNoData());
  RxNotifier<bool> doneOptionIsSelected = RxNotifier<bool>(false);
  RxList<Family> families = RxList<Family>();
  TextEditingController txtTitle = TextEditingController(text: '');
  TextEditingController txtDescription = TextEditingController(text: '');
  int selectedFamilyID = 0;

  IShoppingListStorage shoppingStorage;
  IFamilyStorage familyStorage;

  CreateShoppingListController({
    required this.shoppingStorage,
    required this.familyStorage,
  }) {
    getFamiliesFromDatabase();
  }

  void getFamiliesFromDatabase() async {
    try {
      List<Family> familiesResponse = await familyStorage.getAllFamilies();
      this.families.clear();
      this.families.addAll(familiesResponse);
      this.initFamilyID();
    } catch (error) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro ao buscar as categorias cadastradas'));
    }
  }

  Future<void> initShoppingData(ShoppingList shopping) async {
    try {
      Family familyResponse = await familyStorage.getFamilyByShopping(shopping);
      this.family.value = familyResponse;
      this.shopping.value = shopping;
      this.doneOptionIsSelected.value = shopping.isDone;
      this.txtTitle.text = shopping.title;
      this.txtDescription.text = shopping.description != null ? shopping.description! : '';
    } catch (error) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro carregar dados da lista de compras'));
    }
  }

  void initFamilyID() {
    if (families.isNotEmpty) {
      selectedFamilyID = families.first.id!;
      family.value = families.first;
    }
  }

  void toggleDoneOption(bool value) {
    doneOptionIsSelected.value = value;
  }

  void saveShopping(BuildContext context) {
    if (this.shopping.value.id == null) {
      this.createShoppingList(context);
    } else {
      this.updateShoppingList();
    }
  }

  void createShoppingList(BuildContext context) async {
    try {
      shopping.value.isDone = doneOptionIsSelected.value;
      if (familyIsValidToCreateShoppingList()) {
        await familyStorage.addShoppingList(family.value, shopping.value);
        asuka.showSnackBar(asuka.AsukaSnackbar.success('Lista de compras criada'));
        Navigator.pop(context);
      }
    } catch (error) {
      print(error);
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro ao criar lista de compras'));
    }
  }

  void updateShoppingList() async {
    try {
      shopping.value.isDone = doneOptionIsSelected.value;
      if (familyIsValidToCreateShoppingList()) {
        await shoppingStorage.updateShoppingListWithFamily(shopping.value, family.value);
        asuka.showSnackBar(asuka.AsukaSnackbar.success('Lista de compras atualizada'));
      }
    } catch (error) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro ao atualizar lista de compras'));
    }
  }

  bool familyIsValidToCreateShoppingList() {
    if (family.value.id == null) {
      asuka.showSnackBar(asuka.AsukaSnackbar.warning('Selecione uma categoria antes de salvar a lista de compras'));
      return false;
    }
    return true;
  }

  void setFamilyByID(int id) {
    for (Family familyItem in this.families) {
      if (familyItem.id == id) {
        this.family.value = familyItem;
        break;
      }
    }
    selectedFamilyID = id;
  }

  void goToCreateFamilyPage(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateFamilyPage(),
      ),
    ).then((_) => this.getFamiliesFromDatabase());
  }
}
