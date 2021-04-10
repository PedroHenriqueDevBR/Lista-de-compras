import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_shopping_list/src/shared/exceptions/user_not_logged_in_exception.dart';
import 'package:market_shopping_list/src/shared/interfaces/family_storage_interface.dart';
import 'package:market_shopping_list/src/shared/interfaces/person_storage_interface.dart';
import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/repositories/database_reference_model.dart';
import 'package:market_shopping_list/src/shared/repositories/person_repository.dart';

class FamilyRepository implements IFamilyStorage {
  late FirebaseFirestore _firestore;
  late IPersonStorage _personStorage;
  late DatabaseReference _databaseReference;

  FamilyRepository() {
    _personStorage = PersonRepository();
    _firestore = FirebaseFirestore.instance;
    _databaseReference = DatabaseReference();
  }

  @override
  Future<Family> registerFamily({required Family family}) async {
    try {
      Person loggedPerson = await _personStorage.getLoggedPerson();
      family.addAdministrator(loggedPerson.id);
      CollectionReference familyCollection = await _firestore.collection(_databaseReference.familyCollection);
      DocumentReference familyDocument = await familyCollection.add(family.toMap());
      family.id = familyDocument.id;
      await _personStorage.addFamilyToPerson(personRequest: loggedPerson, family: family);
      return family;
    } on UserNotLoggedInException {
      throw UserNotLoggedInException();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Family>> selectAllFamiliesFromPerson({required Person person}) async {
    try {
      List<Family> families = [];
      for (Family family in person.families) {
        QuerySnapshot snapshot = await _firestore.collection(_databaseReference.familyCollection)
            .where('family_id', isEqualTo: family.family_id)
            .get();
        for (QueryDocumentSnapshot itemData in snapshot.docs) {
          if (itemData.exists) {
            Family family = Family.fromMap(itemData.data()!);
            family.id = itemData.id;
            families.add(family);
          }
        }
      }
      return families;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Family> updateFamilyInformations({required Family family}) {
    // TODO: implement updateFamilyInformations
    throw UnimplementedError();
  }

  @override
  Future<void> addAdministratorToFamily({required Family family, required Person person}) {
    // TODO: implement addAdministratorToFamily
    throw UnimplementedError();
  }

  @override
  Future<Family> setFamilyPassword({required Family family, required String password}) {
    // TODO: implement setFamilyPassword
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFamily({required Family family}) {
    // TODO: implement deleteFamily
    throw UnimplementedError();
  }
}
