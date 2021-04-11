import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:market_shopping_list/src/shared/exceptions/base_exception.dart';
import 'package:market_shopping_list/src/shared/exceptions/data_not_found_exception.dart';
import 'package:market_shopping_list/src/shared/exceptions/login_canceled_exception.dart';
import 'package:market_shopping_list/src/shared/exceptions/login_error_exception.dart';
import 'package:market_shopping_list/src/shared/exceptions/user_not_logged_in_exception.dart';
import 'package:market_shopping_list/src/shared/interfaces/person_storage_interface.dart';
import 'package:market_shopping_list/src/shared/models/family.dart';
import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:market_shopping_list/src/shared/repositories/database_reference_model.dart';

class PersonRepository implements IPersonStorage {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late DatabaseReference _databaseReference;

  PersonRepository() {
    this._auth = FirebaseAuth.instance;
    this._firestore = FirebaseFirestore.instance;
    this._databaseReference = DatabaseReference();
  }

  @override
  Future<Person> loginPerson({required Person person}) async {
    try {
      UserCredential credential = await signInWithGoogle();
      Person person = setPersonFromCredencial(credential);
      try {
        await registerPerson(person: person);
        return person;
      } catch (error) {
        throw Exception();
      }
    } on LoginCanceledException catch (error) {
      return throw BaseException(message: 'Login cancelado');
    } catch (error) {
      return throw Exception();
    }
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;
      final GoogleSignInAuthentication googleAuthentication = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential;
    } on PlatformException {
      throw LoginCanceledException();
    } catch (error) {
      throw LoginErrorException(message: 'Erro ao realizar o login, tente novamente mais tarde');
    }
  }

  Person setPersonFromCredencial(UserCredential credential) {
    return Person(
      id: credential.user?.uid ?? null,
      name: credential.user?.displayName ?? '',
      email: credential.user?.email ?? '',
      password: '',
      photoURL: credential.user?.photoURL ?? '',
    );
  }

  @override
  Future<Person> registerPerson({required Person person}) async {
    try {
      if (await validPersonToRegister(person)) {
        _firestore.collection(_databaseReference.personCollection).doc(person.id).set(person.toMap());
      }
      return person;
    } catch (error) {
      throw Exception();
    }
  }

  Future<bool> validPersonToRegister(Person person) async {
    if (person.id == null) {
      return false;
    }
    QuerySnapshot snapshot = await _firestore.collection(_databaseReference.personCollection).where('id', isEqualTo: person.id).get();
    if (snapshot.docs.length > 0) {
      return false;
    }
    return true;
  }

  @override
  Future<Person> getLoggedPerson() async {
    try {
      User? user = await _auth.currentUser;
      if (user == null) {
        throw UserNotLoggedInException();
      }
      Person person = Person(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        password: '',
        photoURL: user.photoURL ?? '',
      );
      person.families = await formatFamiliesFromPerson(person);
      return person;
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<Family>> formatFamiliesFromPerson(Person person) async {
    List<Family> familiesFromPerson = [];

    try {
      CollectionReference personCollection = await _firestore.collection(_databaseReference.personCollection);
      DocumentSnapshot personDocumentSnapshot = await personCollection.doc(person.id).get();
      if (personDocumentSnapshot.exists) {
        Map<String, dynamic>? personData = personDocumentSnapshot.data();
        for (var familyID in personData!['families']) {
          Family family = Family.cleanData();
          family.id = familyID;
          familiesFromPerson.add(family);
        }
      }
    } catch (error) {
      throw Exception();
    }

    return familiesFromPerson;
  }

  @override
  Future<bool> isLoggedPerson() async {
    return await _auth.currentUser != null ? true : false;
  }

  @override
  Future<Person> addFamilyToPerson({
    required Person personRequest,
    required Family family,
  }) async {
    if (personRequest.id == null) {
      throw DataNotFoundException(dataName: 'Person.id cant be null');
    } else {
      personRequest.addFamily(family);
      try {
        await _firestore.collection(_databaseReference.personCollection).doc(personRequest.id).update(personRequest.toMap());
      } catch (error) {
        Exception();
      }
    }
    return personRequest;
  }

  @override
  Future<void> signOut() async {
    if (await isLoggedPerson()) {
      await _auth.signOut();
    } else {
      throw BaseException(message: 'Not logged person');
    }
  }
}
