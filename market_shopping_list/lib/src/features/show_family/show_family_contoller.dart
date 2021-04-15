import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/list_purchase_itens/list_purchase_item_page.dart';
import 'package:market_shopping_list/src/shared/interfaces/shopping_list_interface.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:market_shopping_list/src/shared/repositories/shopping_list_repository.dart';

class ShowFamilyController {
  late IShoppingListStorage _shoppingListStorage;

  ValueNotifier<bool> isLoadingShopingList = ValueNotifier<bool>(false);
  ValueNotifier<Family> family = ValueNotifier<Family>(Family.cleanData());
  ValueNotifier<List<ShoppingList>> shoppingListItens = ValueNotifier<List<ShoppingList>>([]);
  ValueNotifier<List<ShoppingList>> shoppingListItensToShow = ValueNotifier<List<ShoppingList>>([]);
  ValueNotifier<int> currentFilterSelected = ValueNotifier<int>(0);

  ShowFamilyController({
    required Family family,
  }) {
    this.family.value = family;
    this._shoppingListStorage = ShoppingListRepository();
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
      this.shoppingListItensToShow.value = result;
      this.shoppingListItens.notifyListeners();
      this.shoppingListItensToShow.notifyListeners();
    } catch (error) {
      print(error);
      asuka.showSnackBar(SnackBar(content: Text('Ocorreu um erro interno')));
    } finally {
      isLoadingShopingList.value = false;
    }
  }

  void deleteShoppingList(ShoppingList shoppingList) async {
    try {
      await this._shoppingListStorage.deleteShoppingList(shoppingList: shoppingList);
      getAllShoppingListFromDatabase();
      asuka.showSnackBar(SnackBar(content: Text('Lista de compras deletada')));
    } catch(error) {
      print(error);
      asuka.showSnackBar(SnackBar(content: Text('Ocorreu um erro ao deletar lista de compras')));
    }
  }

  void searchShopingList(String search){
    print(search);
    List<ShoppingList> result = [];
    for (ShoppingList shoppingList in shoppingListItens.value) {
      if (shoppingList.title.contains(search)){
        result.add(shoppingList);
      }
    }
    print(result.length);
    shoppingListItensToShow.value = result;
    shoppingListItensToShow.notifyListeners();
  }

  void changeCategoryFilter(int value) {
    if (value < 0 || value > 2) {
      value = 0;
    }
    this.currentFilterSelected.value = value;
  }
}
