import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_shopping_list/src/features/list_purchase_itens/list_purchase_item_page.dart';
import 'package:market_shopping_list/src/shared/interfaces/family_storage_interface.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/repositories/family_repository.dart';

class ShowFamilyController {
  late IFamilyStorage _familyStorage;
  ValueNotifier<Family> family = ValueNotifier<Family>(Family.cleanData());

  ShowFamilyController({
    required Family family,
  }) {
    this.family.value = family;
    this._familyStorage = FamilyRepository();
  }

  void goToCreatePurchaseItemPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListPurchaseItemPage(),
      ),
    );
  }
}
