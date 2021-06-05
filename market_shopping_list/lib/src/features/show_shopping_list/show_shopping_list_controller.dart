import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/create_shopping_list/create_shopping_list_page.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:asuka/asuka.dart' as asuka;

class ShowShoppingListController {
  ShoppingList shoppingList;
  RxList<PurchaseItem> itens = RxList<PurchaseItem>([]);
  PurchaseItem purchaseItem = PurchaseItem.withNoData();

  ShowShoppingListController({
    required this.shoppingList,
  });

  void saveItem({PurchaseItem? purchaseItem}) {
    if (purchaseItem == null) {
      registerItem();
    } else {
      updateItem(purchaseItem);
    }
  }

  void registerItem() async {
    itens.add(purchaseItem);
  }

  void updateItem(PurchaseItem purchaseItem) {
    int index = itens.indexOf(purchaseItem);
    if (index != -1) {
      itens[index] = this.purchaseItem;
    } else {
      asuka.showSnackBar(asuka.AsukaSnackbar.warning('Item não localizado'));
    }
  }

  void removeItem(PurchaseItem purchaseItem) {
    bool isRemoved = itens.remove(purchaseItem);
    if (isRemoved) {
      asuka.showSnackBar(asuka.AsukaSnackbar.info('Item removido com sucesso'));
    }
  }

  void goToEditShoppingListPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateShoppingListPage(
          shoppingList: this.shoppingList,
        ),
      ),
    );
  }

  String creationDate() {
    String day = formatDate(shoppingList.createdAt.day);
    String month = formatDate(shoppingList.createdAt.month);
    String year = formatDate(shoppingList.createdAt.year);
    return '${day}/${month}/${year}';
  }

  String formatDate(int value) {
    if (value < 10) {
      return '0${value}';
    }
    return '${value}';
  }

  double getTotal() {
    double total = 0;
    for (PurchaseItem item in itens) {
      total += (item.price * item.quantity);
    }
    return total;
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
