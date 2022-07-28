import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  Future<void> signUp(
      {required String emailAddress, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn(
      {required String emailAddress, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOutUser() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
