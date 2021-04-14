import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_shopping_list/src/shared/exceptions/data_not_found_exception.dart';

import 'package:market_shopping_list/src/shared/interfaces/person_storage_interface.dart';
import 'package:market_shopping_list/src/shared/interfaces/shopping_list_interface.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/purchase_item.dart';
import 'package:market_shopping_list/src/shared/models/shopping_list.dart';
import 'package:market_shopping_list/src/shared/repositories/database_reference_model.dart';
import 'package:market_shopping_list/src/shared/repositories/person_repository.dart';

class ShoppingListRepository implements IShoppingListStorage {
  late IPersonStorage _personStorage;
  late FirebaseFirestore _firestore;
  late DatabaseReference _databaseReference;

  ShoppingListRepository() {
    this._personStorage = PersonRepository();
    this._firestore = FirebaseFirestore.instance;
    this._databaseReference = DatabaseReference();
  }

  @override
  Future<ShoppingList> registerShoppingList(ShoppingList shoppingList) async {
    try {
      CollectionReference shoppingListCollection = await _firestore.collection(_databaseReference.shoppingList);
      DocumentReference shoppingListDocument = await shoppingListCollection.add(shoppingList.toMap());
      shoppingList.id = shoppingListDocument.id;
      return shoppingList;
    } catch (error) {
      print(error);
      throw Exception();
    }
  }

  @override
  Future<List<ShoppingList>> allShoppingListFromFamily({required Family family}) async {
    if (family.id == null) {
      throw DataNotFoundException(dataName: 'Family.id is required');
    } else {
      CollectionReference shoppingListCollection = await _firestore.collection(_databaseReference.shoppingList);
      QuerySnapshot shoppingListQuery = await shoppingListCollection.where('familyID', isEqualTo: family.id).get();

      List<ShoppingList> out = [];
      for (QueryDocumentSnapshot documentSnapshot in shoppingListQuery.docs) {
        if (documentSnapshot.data()!.isNotEmpty) {
          ShoppingList shoppingList = ShoppingList.fromMap(documentSnapshot.data()!);
          shoppingList.id = documentSnapshot.id;
          out.add(shoppingList);
        }
      }
      return out;
    }
  }

  @override
  Future<ShoppingList> updateShoppingList({required ShoppingList shoppingList}) async {
    if (shoppingList.id == null){
      throw DataNotFoundException(dataName: 'shoppingList.id is required');
    } else {
      try {
        CollectionReference shoppingListCollection = await _firestore.collection(_databaseReference.shoppingList);
        DocumentReference shoppingListDocument = await shoppingListCollection.doc(shoppingList.id);
        shoppingListDocument.update(shoppingList.toMap());
        return shoppingList;
      } catch(error) {
        print(error);
        throw Exception();
      }
    }
  }

  @override
  Future<ShoppingList> addItemToShoppingList({required ShoppingList shoppingList, required PurchaseItem item}) {
    // TODO: implement allShoppingListFromFamily
    throw UnimplementedError();
  }

  @override
  Future<List<ShoppingList>> allDoneShoppingListFromFamily({required Family family}) {
    // TODO: implement allDoneShoppingListFromFamily
    throw UnimplementedError();
  }

  @override
  Future<List<ShoppingList>> allPendingShoppingListFromFamily({required Family family}) {
    // TODO: implement allPendingShoppingListFromFamily
    throw UnimplementedError();
  }

  @override
  Future<List<ShoppingList>> allShoppingListFromFamilyByData({required DateTime date}) {
    // TODO: implement allShoppingListFromFamilyByData
    throw UnimplementedError();
  }

  @override
  Future<void> deleteShoppingList({required ShoppingList shoppingList}) {
    // TODO: implement deleteShoppingList
    throw UnimplementedError();
  }

  @override
  Future<List<ShoppingList>> getAllEmptyShoppingListFromFamily({required Family family}) {
    // TODO: implement getAllEmptyShoppingListFromFamily
    throw UnimplementedError();
  }

  @override
  Future<ShoppingList> removeItemToShoppingList({required ShoppingList shoppingList, required PurchaseItem item}) {
    // TODO: implement removeItemToShoppingList
    throw UnimplementedError();
  }
}
