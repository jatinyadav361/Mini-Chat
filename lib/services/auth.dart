import 'package:chat/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //convert fireBase user into user
  User _userFromFireBaseUser(FirebaseUser user) {
    return user!= null ? User(uid: user.uid,email: user.email) : null;
  }


  //user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFireBaseUser(user));
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email , String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    } catch(e) {
      print('error:$e');
      return null;
    }
  }


  //register with email and password
  Future registerWithEmailAndPassword(String email,String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    } catch(e) {
      print('erroe:$e');
      return null;
    }
  }


  //verify email address
  Future resetPasswordWithLink(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('error:$e');
      return null;

    }
  }


  //sign out
  Future signOut(String uid) async {
    try {
      var result = await _auth.signOut();
      return result;
    } catch(e) {
      print('error : $e');
      return null;
    }
  }


}