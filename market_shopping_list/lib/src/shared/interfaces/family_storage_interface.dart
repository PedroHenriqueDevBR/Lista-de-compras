import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/person.dart';

abstract class IFamilyStorage {
  Future<List<Family>> selectAllFamiliesByPerson({required Person person});

  Future<Family> registerFamily({required Family family});

  Future<Family> updateFamilyInformations({required Family family});

  Future<void> deleteFamily({required Family family});

  Future<void> addAdministratorToFamily({
    required Family family,
    required Person person,
  });

  Future<Family> setFamilyPassword({
    required Family family,
    required String password,
  });
}
