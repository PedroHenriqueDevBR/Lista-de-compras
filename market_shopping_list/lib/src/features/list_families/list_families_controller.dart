import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ListFamiliesController {
  RxNotifier<bool> dialVisible = RxNotifier<bool>(false);
  RxNotifier<int> selectedFamily = RxNotifier<int>(-1);
  RxList<int> pendingShoppingList = RxList<int>([1, 3]);

  RxList<Family> families = RxList<Family>([
    Family(id: 1, name: 'Eu Mesmo'),
    Family(id: 2, name: 'Familia Lima'),
  ]);

  RxList<ShoppingList> shoppingList = RxList<ShoppingList>([
    ShoppingList(id: 1, title: 'Teste 01', description: 'Apenas testes'),
    ShoppingList(id: 2, title: 'Teste 02', description: 'Apenas testes'),
  ]);

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
}