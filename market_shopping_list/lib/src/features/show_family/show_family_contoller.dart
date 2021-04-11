import 'package:flutter/cupertino.dart';
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
}
