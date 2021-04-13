import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/list_purchase_itens/list_purchase_item_page.dart';
import 'package:market_shopping_list/src/shared/interfaces/family_storage_interface.dart';
import 'package:market_shopping_list/src/shared/interfaces/shopping_list_interface.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:market_shopping_list/src/shared/repositories/family_repository.dart';
import 'package:market_shopping_list/src/shared/repositories/shopping_list_repository.dart';

class ShowFamilyController {
  late IFamilyStorage _familyStorage;
  late IShoppingListStorage _shoppingListStorage;

  ValueNotifier<bool> isLoadingShopingList = ValueNotifier<bool>(false);
  ValueNotifier<Family> family = ValueNotifier<Family>(Family.cleanData());
  ValueNotifier<List<ShoppingList>> shoppingListItens = ValueNotifier<List<ShoppingList>>([]);

  ShowFamilyController({
    required Family family,
  }) {
    this.family.value = family;
    this._shoppingListStorage = ShoppingListRepository();
    this._familyStorage = FamilyRepository();
    getAllShoppingListFromDatabase();
  }

  void goToCreatePurchaseItemPage(BuildContext context, {ShoppingList? shoppingList}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListPurchaseItemPage(
          family: family.value,
          shoppingList: shoppingList,
        ),
      ),
    ).then((updateData) {
      getAllShoppingListFromDatabase();
    });
  }

  void getAllShoppingListFromDatabase() async {
    isLoadingShopingList.value = true;
    try {
      List<ShoppingList> result = await _shoppingListStorage.allShoppingListFromFamily(family: this.family.value);
      this.shoppingListItens.value = result;
      this.shoppingListItens.notifyListeners();
    } catch (error) {
      print(error);
      AsukaSnackbar.alert('Ocorreu um erro interno');
    } finally {
      isLoadingShopingList.value = false;
    }
  }
}
