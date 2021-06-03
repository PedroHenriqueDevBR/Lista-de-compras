import 'package:asuka/asuka.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:asuka/asuka.dart' as asuka;

class CreateFamilyController {
  RxNotifier<bool> editIsActive = RxNotifier<bool>(true);
  RxList<ShoppingList> shoppingList = RxList<ShoppingList>([]);
  RxNotifier<Family> family = RxNotifier<Family>(Family.withNoData());

  toggleEditActive() {
    if (family.value.id == null) {
      asuka.showSnackBar(AsukaSnackbar.info('Editar não pode ser desabilitado sem a categoria está salva.'));
    } else {
      this.editIsActive.value = !this.editIsActive.value;
    }
  }

  void initFamilyData(Family family) {
    editIsActive.value = false;
    this.family.value = family;
    getShoppingListFromFamily();
  }

  void getShoppingListFromFamily() {
    shoppingList.addAll([
      ShoppingList(id: 1, title: 'Teste 01', description: 'Apenas testes'),
      ShoppingList(id: 2, title: 'Teste 02', description: 'Apenas testes'),
      ShoppingList(id: 3, title: 'Teste 03', description: 'Apenas testes'),
      ShoppingList(id: 4, title: 'Teste 04', description: 'Apenas testes'),
      ShoppingList(id: 5, title: 'Teste 05', description: 'Apenas testes'),
      ShoppingList(id: 6, title: 'Teste 06', description: 'Apenas testes'),
    ]);
  }

  void saveFamily() {
    family.value.id = 1;
    editIsActive.value = false;
    asuka.showSnackBar(AsukaSnackbar.success('Dados salvos com sucesso'));
  }

  void deleteFamily(BuildContext pageContext) {
    if (family.value.id == null) {
      asuka.showSnackBar(AsukaSnackbar.info('Não há dados para deletar'));
    } else {
      asuka.showDialog(
        builder: (dialogContext) => AlertDialog(
          title: Text('Deletar Categoria'),
          content: Container(
            child: Text('Atenção, você realmente deseja deletar a categoria ${family.value.name}?'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(pageContext);
              },
              child: Text('Sim'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text('Não'),
            ),
          ],
        ),
      );
    }
  }
}
