import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //utility-function
  User _userFromFirebaseUser(FirebaseUser user) {
    return user == null ? null : User(userId: user.uid);
  }

   //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
      .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult response = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = response.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Dikkatli ol = ' + e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = response.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Dikkatli ol = ' + e.toString());
      return null;
    }
  }

  //sign out
  Future signOut()async{
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
