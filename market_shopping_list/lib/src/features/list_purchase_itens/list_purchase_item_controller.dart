import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:market_shopping_list/src/shared/interfaces/person_storage_interface.dart';
import 'package:market_shopping_list/src/shared/interfaces/shopping_list_interface.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:market_shopping_list/src/shared/repositories/person_repository.dart';
import 'package:market_shopping_list/src/shared/repositories/shopping_list_repository.dart';

class ListPurchaseItemController {
  ValueNotifier<bool> checkboxShoppingListIsDone = ValueNotifier<bool>(false);
  ValueNotifier<bool> checkboxPurchasedProduct = ValueNotifier<bool>(false);
  ValueNotifier<bool> isSavedPurchaseItem = ValueNotifier<bool>(false);
  ValueNotifier<int> purchaseItemAmount = ValueNotifier<int>(0);
  ValueNotifier<double> purchaseTotal = ValueNotifier<double>(0);
  late ValueNotifier<ShoppingList> currentShoppingList;
  late IShoppingListStorage _shoppingListStorage;
  late IPersonStorage _personStorage;
  late Family family;

  ValueNotifier<List<PurchaseItem>> purchaseItens = ValueNotifier<List<PurchaseItem>>([]);

  ListPurchaseItemController({
    ShoppingList? shoppingListArgument,
    required this.family,
  }) {
    this._shoppingListStorage = ShoppingListRepository();
    this._personStorage = PersonRepository();

    if (shoppingListArgument == null) {
      currentShoppingList = ValueNotifier<ShoppingList>(ShoppingList.cleanData());
    } else {
      currentShoppingList = ValueNotifier<ShoppingList>(shoppingListArgument);
      isSavedPurchaseItem.value = true;
      checkboxShoppingListIsDone.value = shoppingListArgument.is_done;
    }
  }

  void saveData() {
    if (isSavedPurchaseItem.value) {
      updateShoppingList();
    } else {
      registerShoppingList();
    }
  }

  void registerShoppingList() async {
    try {
      await formatShoppingListToSave();
      if (shoppingListIsValidToRegister()) {
        ShoppingList response = await _shoppingListStorage.registerShoppingList(currentShoppingList.value);
        currentShoppingList.value = response;
        isSavedPurchaseItem.value = true;
        asuka.showSnackBar(SnackBar(content: Text('Dados salvos')));
      }
    } catch (error) {
      print(error);
      asuka.showSnackBar(SnackBar(content: Text('Ocorreu um erro')));
    }
  }

  void updateShoppingList() async {
    try {
      if (shoppingListIsValidToRegister()) {
        ShoppingList response = await _shoppingListStorage.updateShoppingList(shoppingList: currentShoppingList.value);
        currentShoppingList.value = response;
        asuka.showSnackBar(SnackBar(content: Text('Dados atualizados')));
      }
    } catch (error) {
      print(error);
      asuka.showSnackBar(SnackBar(content: Text('Ocorreu um erro')));
    }
  }

  Future formatShoppingListToSave() async {
    Person person = await _personStorage.getLoggedPerson();
    this.currentShoppingList.value.created_by = person.name;
    this.currentShoppingList.value.created_at = DateTime.now();
    this.currentShoppingList.value.familyID = family.id;
    this.currentShoppingList.value.is_done = checkboxShoppingListIsDone.value;
  }

  bool shoppingListIsValidToRegister() {
    if (currentShoppingList.value.created_by.isEmpty) {
      asuka.showSnackBar(SnackBar(content: Text('Informe o nome do usuário')));
      return false;
    } else if (currentShoppingList.value.title.isEmpty) {
      asuka.showSnackBar(SnackBar(content: Text('Informe o título da lista de compras')));
      return false;
    } else if (currentShoppingList.value.description.isEmpty) {
      asuka.showSnackBar(SnackBar(content: Text('Digite uma descrição para a lista de compras')));
      return false;
    } else if (currentShoppingList.value.familyID.isEmpty) {
      asuka.showSnackBar(SnackBar(content: Text('O código da família é importante.')));
      return false;
    }
    return true;
  }

  String formatDate({DateTime? datetime}) {
    if (datetime == null) {
      datetime = DateTime.now();
    }
    return '${datetime.day}/${datetime.month}/${datetime.year} às ${datetime.hour}:${datetime.minute}';
  }

  void calculatePurchaseTotal() {
    double result = 0.0;
    for (PurchaseItem purchaseItem in purchaseItens.value) {
      result += purchaseItem.purchaseTotal;
    }
    purchaseTotal.value = result;
  }

  void changeAmount(int value) {
    purchaseItemAmount.value += value;
  }

  void setIsDone(bool? value) {
    this.checkboxShoppingListIsDone.value = value!;
  }

}
