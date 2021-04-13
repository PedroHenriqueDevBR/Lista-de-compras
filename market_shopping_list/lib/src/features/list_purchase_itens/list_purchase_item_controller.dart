import 'package:flutter/cupertino.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:market_shopping_list/src/shared/interfaces/purchase_item_storage_interface.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';
import 'package:market_shopping_list/src/shared/repositories/purchase_item_repository.dart';

class ListPurchaseItemController {
  ValueNotifier<bool> isDone = ValueNotifier<bool>(false);
  ValueNotifier<bool> selectIsActive = ValueNotifier<bool>(false);
  ValueNotifier<bool> purchasedProduct = ValueNotifier<bool>(false);
  ValueNotifier<bool> isSavedPurchaseItem = ValueNotifier<bool>(false);
  ValueNotifier<int> amount = ValueNotifier<int>(0);
  ValueNotifier<double> purchaseTotal = ValueNotifier<double>(0);
  late IPurchaseItemStorage _purchaseItemStorage;

  List<PurchaseItem> purchaseItens = [
    PurchaseItem(quantity: 4, purchasePrice: 0.0, productName: 'Arroz'),
    PurchaseItem(quantity: 12, purchasePrice: 4.0, productName: 'Maça', purchasedBy: 'Pedro Henrique'),
    PurchaseItem(quantity: 2, purchasePrice: 3.35, productName: 'Feijão', purchasedBy: 'Pedro Henrique'),
    PurchaseItem(quantity: 2, purchasePrice: 3.5, productName: 'Macarrão', purchasedBy: 'Pedro Henrique'),
    PurchaseItem(quantity: 8, purchasePrice: 0.0, productName: 'Café'),
    PurchaseItem(quantity: 3, purchasePrice: 3.75, productName: 'Leite', purchasedBy: 'Pedro Henrique'),
  ];

  ListPurchaseItemController() {
    this._purchaseItemStorage = PurchaseItemRepository();
    calculatePurchaseTotal();
  }

  String formatDate({DateTime? datetime}) {
    if (datetime == null) {
      datetime = DateTime.now();
    }
    return '${datetime.day}/${datetime.month}/${datetime.year} às ${datetime.hour}:${datetime.minute}';
  }

  void calculatePurchaseTotal() {
    double result = 0.0;
    for (PurchaseItem purchaseItem in purchaseItens) {
      result += purchaseItem.purchaseTotal;
    }
    purchaseTotal.value = result;
  }

  void changeAmount(int value) {
    amount.value += value;
  }

  void savePurchaseList() {
    isSavedPurchaseItem.value = true;
    asuka.AsukaSnackbar.message('Lista de compras registrada com sucesso!');
  }

  void setIsDone(bool? value) {
    this.isDone.value = value!;
  }

  void setSelectIsActive(bool? value) {
    this.selectIsActive.value = value!;
  }
}
