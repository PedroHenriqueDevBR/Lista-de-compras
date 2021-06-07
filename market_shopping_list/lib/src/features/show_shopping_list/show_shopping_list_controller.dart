import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

import 'package:market_shopping_list/src/features/create_shopping_list/create_shopping_list_page.dart';
import 'package:market_shopping_list/src/shared/interfaces/purchase_item_storage_interface.dart';
import 'package:market_shopping_list/src/shared/interfaces/shopping_list_interface.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

class ShowShoppingListController {
  RxNotifier<ShoppingList> shoppingList = RxNotifier<ShoppingList>(ShoppingList.withNoData());
  RxList<PurchaseItem> itens = RxList<PurchaseItem>([]);
  RxNotifier<bool> isDone = RxNotifier<bool>(false);
  RxNotifier<double> total = RxNotifier<double>(0.0);
  PurchaseItem purchaseItem = PurchaseItem.withNoData();
  RxNotifier<bool> changeState = RxNotifier<bool>(false);

  IShoppingListStorage shoppingStorage;
  IPurchaseItemStorage itemStorage;

  ShowShoppingListController({
    required ShoppingList shoppingList,
    required this.shoppingStorage,
    required this.itemStorage,
  }) {
    this.shoppingList.value = shoppingList;
    getAllItensFromShoppingList(shoppingList);
  }

  void getAllItensFromShoppingList(ShoppingList shoppingList) async {
    try {
      List<PurchaseItem> itensResponse = await itemStorage.getAllPurchaseItensFromShoppingList(shoppingList);
      this.itens.clear();
      this.itens.addAll(itensResponse);
    } catch (error) {
      print(error);
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro ao carregar lista de itens do carrinho'));
    }
  }

  void saveItem({PurchaseItem? purchaseItem}) {
    if (purchaseItem == null) {
      registerItem();
    } else {
      updateItem(purchaseItem);
    }
  }

  void registerItem() async {
    try {
      await shoppingStorage.addItemToShoppingList(shoppingList.value, purchaseItem);
      this.getAllItensFromShoppingList(shoppingList.value);
    } catch (error) {
      print(error);
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro ao adicionar item no carrinho'));
    }
  }

  void updateItem(PurchaseItem purchaseItem) async {
    try {
      int index = itens.indexOf(purchaseItem);
      if (index != -1) {
        purchaseItem.productName = this.purchaseItem.productName;
        purchaseItem.price = this.purchaseItem.price;
        purchaseItem.quantity = this.purchaseItem.quantity;
        await itemStorage.updatePurchaseItem(purchaseItem);
        this.getAllItensFromShoppingList(shoppingList.value);
        print('=' * 30);
        print('Dados atualizados');
      } else {
        asuka.showSnackBar(asuka.AsukaSnackbar.warning('Item não localizado'));
      }
    } catch (error) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro ao adicionar item no carrinho'));
    }
  }

  void removeItem(PurchaseItem purchaseItem) async {
    try {
      await itemStorage.removePurchaseItem(purchaseItem);
      bool isRemoved = itens.remove(purchaseItem);
      if (isRemoved) {
        asuka.showSnackBar(asuka.AsukaSnackbar.success('Item removido com sucesso'));
      } else {
        asuka.showSnackBar(asuka.AsukaSnackbar.warning('Item não localizado no carrinho'));
      }
    } catch (error) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro ao remover item do carrinho'));
    }
  }

  Future<void> deleteShoppingList() async {
    try {
      await shoppingStorage.removeShoppingList(shoppingList.value);
      await itemStorage.deletePurchaseItemByShoppingList(shoppingList.value);
      asuka.showSnackBar(asuka.AsukaSnackbar.success('Lista de compras deletada'));
    } catch (error) {
      print(error);
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro ao deletar lista de compras'));
    }
  }

  void toggleDoneShoppingList() async {
    try {
      if (this.shoppingList.value.isDone) {
        await shoppingStorage.redoCompleteShoppingList(shoppingList.value);
      } else {
        await shoppingStorage.completeShoppingList(shoppingList.value);
      }
      this.shoppingList.value.isDone = !this.shoppingList.value.isDone;
      isDone.value = !isDone.value;
    } catch (error) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro ao mudar status'));
    }
  }

  void goToEditShoppingListPage(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateShoppingListPage(
          shoppingList: this.shoppingList.value,
        ),
      ),
    ).then((_) {
      changeState.value = !changeState.value;
    });
  }

  String creationDate() {
    String day = formatDate(shoppingList.value.createdAt.day);
    String month = formatDate(shoppingList.value.createdAt.month);
    String year = formatDate(shoppingList.value.createdAt.year);
    return '${day}/${month}/${year}';
  }

  String formatDate(int value) {
    if (value < 10) {
      return '0${value}';
    }
    return '${value}';
  }

  void getTotal() {
    double out = 0;
    for (PurchaseItem item in itens) {
      out += (item.price * item.quantity);
    }
    this.total.value = out;
  }

  bool isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  String formatDoubleValue(double n) {
    return n.toStringAsFixed(2);
  }
}
