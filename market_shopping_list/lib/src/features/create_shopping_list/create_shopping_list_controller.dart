import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/cupertino.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:market_shopping_list/src/shared/interfaces/family_storage_interface.dart';
import 'package:market_shopping_list/src/shared/interfaces/shopping_list_interface.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

class CreateShoppingListController {
  RxNotifier<ShoppingList> shopping = RxNotifier<ShoppingList>(ShoppingList.withNoData());
  RxNotifier<Family> family = RxNotifier<Family>(Family.withNoData());
  RxNotifier<bool> doneOptionIsSelected = RxNotifier<bool>(false);
  List<Family> families = [
    Family(id: 1, name: 'categoria 01'),
    Family(id: 2, name: 'categoria 02'),
    Family(id: 3, name: 'categoria 03'),
    Family(id: 4, name: 'categoria 04'),
    Family(id: 5, name: 'categoria 05'),
  ];
  int selectedFamilyID = 0;

  IShoppingListStorage shoppingStorage;
  IFamilyStorage familyStorage;

  CreateShoppingListController({
    required this.shoppingStorage,
    required this.familyStorage,
  }) {
    if (families.isNotEmpty) {
      selectedFamilyID = families.first.id!;
    }
  }

  void initShoppingData(ShoppingList shopping) async {
    try {
      Family familyResponse = await familyStorage.getFamilyByShopping(shopping);
      this.family.value = familyResponse;
      this.shopping.value = shopping;
      this.doneOptionIsSelected.value = shopping.isDone;
    } catch (error) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro carregar dados da lista de compras'));
    }
  }

  void toggleDoneOption(bool value) {
    doneOptionIsSelected.value = value;
  }

  void getFamilies() {
    families.addAll([Family(id: 1, name: 'ADS')]);
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
        asuka.showSnackBar(asuka.AsukaSnackbar.message('Lista de compras criada'));
        Navigator.pop(context);
      }
    } catch (error) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro ao criar lista de compras'));
    }
  }

  void updateShoppingList() async {
    try {
      shopping.value.isDone = doneOptionIsSelected.value;
      if (familyIsValidToCreateShoppingList()) {
        await shoppingStorage.updateShoppingListWithFamily(shopping.value, family.value);
        asuka.showSnackBar(asuka.AsukaSnackbar.message('Lista de compras atualizada'));
      }
    } catch (error) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro ao criar lista de compras'));
    }
  }

  bool familyIsValidToCreateShoppingList() {
    if (family.value.id == null) {
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
}
