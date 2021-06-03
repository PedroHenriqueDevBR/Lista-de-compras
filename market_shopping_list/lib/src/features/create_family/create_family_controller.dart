import 'package:asuka/asuka.dart' as asuka;
import 'package:asuka/asuka.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

import 'package:market_shopping_list/src/shared/interfaces/family_storage_interface.dart';
import 'package:market_shopping_list/src/shared/interfaces/shopping_list_interface.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';

class CreateFamilyController {
  RxNotifier<bool> editIsActive = RxNotifier<bool>(true);
  RxList<ShoppingList> shoppingList = RxList<ShoppingList>([]);
  RxNotifier<Family> family = RxNotifier<Family>(Family.withNoData());
  IFamilyStorage familyStorage;
  IShoppingListStorage shoppingStorage;

  CreateFamilyController({
    required this.familyStorage,
    required this.shoppingStorage,
  });

  void toggleEditActive() {
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

  void getShoppingListFromFamily() async {
    try {
      List<ShoppingList> shppingListResponse = await shoppingStorage.selectAllShoppingListsByFamily(family.value);
      this.shoppingList.addAll(shppingListResponse);
    } catch (error) {
      print(error);
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro ao busca lista de compras da categoria ${family.value.name}'));
    }
  }

  void saveFamily() {
    print("family");
    print(family.value.id);
    print(family.value.name);
    if (this.family.value.id == null) {
      createFamily();
    } else {
      updateFamily();
    }
  }

  void createFamily() async {
    try {
      if (familyIsValidToSave()) {
        Family family = await familyStorage.createFamily(this.family.value);
        this.family.value.id = family.id;
        editIsActive.value = false;
        asuka.showSnackBar(asuka.AsukaSnackbar.success('Dados salvos com sucesso'));
      }
    } catch (error) {
      print(error);
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Ocorreu um erro ao criar family'));
    }
  }

  Future<void> deleteFamilyFromDatabase() async {
    try {
      await familyStorage.deleteFamily(family.value);
      asuka.showSnackBar(asuka.AsukaSnackbar.success('Categoria deletada com sucesso'));
      this.family.value.id = null;
      editIsActive.value = true;
    } catch (error) {
      print(error);
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Erro ao deletar a categoria'));
    }
  }

  void updateFamily() async {
    try {
      if (familyIsValidToSave()) {
        await familyStorage.updateFamily(this.family.value);
        editIsActive.value = false;
        asuka.showSnackBar(asuka.AsukaSnackbar.success('Dados atualizados com sucesso'));
      }
    } catch (error) {
      print(error);
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Ocorreu um erro ao criar family'));
    }
  }

  bool familyIsValidToSave() {
    if (this.family.value.name.length == 0) {
      asuka.showSnackBar(
        asuka.AsukaSnackbar.warning('Digite o nome da categoria'),
      );
      return false;
    } else if (this.family.value.name.length > 20) {
      asuka.showSnackBar(
        asuka.AsukaSnackbar.warning('O nome da categoria deve possuir no máximo 20 caracteres'),
      );
      return false;
    }
    return true;
  }

  void onChangeTextInput(value) {
    this.family.value.name = value;
  }
}
