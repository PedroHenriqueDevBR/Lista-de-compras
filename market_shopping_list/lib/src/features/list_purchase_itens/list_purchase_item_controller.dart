import 'package:flutter/cupertino.dart';
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
  ValueNotifier<bool> isDone = ValueNotifier<bool>(false);
  ValueNotifier<bool> selectIsActive = ValueNotifier<bool>(false);
  ValueNotifier<bool> purchasedProduct = ValueNotifier<bool>(false);
  ValueNotifier<bool> isSavedPurchaseItem = ValueNotifier<bool>(false);
  ValueNotifier<int> amount = ValueNotifier<int>(0);
  ValueNotifier<double> purchaseTotal = ValueNotifier<double>(0);
  late ValueNotifier<ShoppingList> shoppingList;
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
      shoppingList = ValueNotifier<ShoppingList>(ShoppingList.cleanData());
    } else {
      shoppingList = ValueNotifier<ShoppingList>(shoppingListArgument);
      isSavedPurchaseItem.value = true;
      isDone.value = shoppingListArgument.is_done;
    }
  }

  void registerShoppingList() async {
    try {
      await formatShoppingListToSave();
      if (shoppingListIsValidToRegister()) {
        ShoppingList response = await _shoppingListStorage.registerShoppingList(shoppingList.value);
        shoppingList.value = response;
        isSavedPurchaseItem.value = true;
        asuka.AsukaSnackbar.message('Lista de compras registrada com sucesso!');
      }
    } catch (error) {
      print(error);
      asuka.AsukaSnackbar.alert('Ocorreu um erro interno');
    }
  }

  Future formatShoppingListToSave() async {
    Person person = await _personStorage.getLoggedPerson();
    this.shoppingList.value.created_by = person.name;
    this.shoppingList.value.created_at = DateTime.now();
    this.shoppingList.value.familyID = family.id;
    this.shoppingList.value.is_done = isDone.value;
  }

  bool shoppingListIsValidToRegister() {
    if (shoppingList.value.created_by.isEmpty) {
      asuka.AsukaSnackbar.info('Informe o nome do usuário');
      return false;
    } else if (shoppingList.value.title.isEmpty) {
      asuka.AsukaSnackbar.info('Informe o título da lista de compras');
      return false;
    } else if (shoppingList.value.description.isEmpty) {
      asuka.AsukaSnackbar.info('Digite uma descrição para a lista de compras');
      return false;
    } else if (shoppingList.value.familyID.isEmpty) {
      asuka.AsukaSnackbar.info('O código da família é importante.');
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
    amount.value += value;
  }

  void setIsDone(bool? value) {
    this.isDone.value = value!;
  }

  void setSelectIsActive(bool? value) {
    this.selectIsActive.value = value!;
  }
}
