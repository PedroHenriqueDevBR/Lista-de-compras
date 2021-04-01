import 'package:google_sign_in/google_sign_in.dart';
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
    var response = signInWithGoogle(); // TODO: Avaliar qual é o retorno apresentado nesse response
    return Person(email: '', name: '', password: '');
  }

  @override
  Future<Person> registerPerson({required Person person}) {
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!; // TODO: esse trecho de código pode ser nulo
    final GoogleSignInAuthentication googleAuthentication = await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuthentication.accessToken,
      idToken: googleAuthentication.idToken,
    );
    return await _auth.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<bool> isLoggedPerson() async {
    bool out = await _auth.currentUser != null ? true : false;
    return out;
  }
}
