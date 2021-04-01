import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:market_shopping_list/src/shared/exceptions/base_exception.dart';
import 'package:market_shopping_list/src/shared/exceptions/login_canceled_exception.dart';
import 'package:market_shopping_list/src/shared/exceptions/login_error_exception.dart';
import 'package:market_shopping_list/src/shared/interfaces/person_storage_interface.dart';
import 'package:market_shopping_list/src/shared/models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PersonRepository implements IPersonStorage {
  late FirebaseAuth _auth;

  PersonRepository() {
    this._auth = FirebaseAuth.instance;
  }

  @override
  Future<Person> loginPerson({required Person person}) async {
    try {
      UserCredential credential = await signInWithGoogle();
      Person person = Person(
        id: credential.user?.uid ?? null,
        name: credential.user?.displayName ?? '',
        email: credential.user?.email ?? '',
        password: '',
        photoURL: credential.user?.photoURL ?? '',
      );
      return person;
    } on LoginCanceledException catch (e) {
      return throw BaseException(message: 'Login cancelado');
    } catch (e) {
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
    } catch (e) {
      throw LoginErrorException(message: 'Erro ao realizar o login, tente novamente mais tarde');
    }
  }

  @override
  Future<void> signOut() async {
    if (await isLoggedPerson()) {
      await _auth.signOut();
    } else {
      throw BaseException(message: 'Usuário não logado');
    }
  }

  @override
  Future<bool> isLoggedPerson() async {
    bool out = await _auth.currentUser != null ? true : false;
    return out;
  }

  @override
  Future<Person> registerPerson({required Person person}) {
    // TODO: Ao fazer login na aplicação o usuário deve ser salvo no cloud firestore
    // Deve-se veriicar se o person não está salvo para não ter person repetidos.
    throw UnimplementedError();
  }
}
