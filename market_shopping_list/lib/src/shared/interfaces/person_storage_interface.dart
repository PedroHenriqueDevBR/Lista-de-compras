import 'package:firebase_auth/firebase_auth.dart';
import 'package:market_shopping_list/src/shared/models/person.dart';

abstract class IPersonStorage {
  Future<Person> registerPerson({required Person person});

  Future<Person> loginPerson({required Person person});

  Future<UserCredential> signInWithGoogle();

  Future<void> signOut();

  Future<bool> isLoggedPerson();
}
