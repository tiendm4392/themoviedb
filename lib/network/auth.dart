import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testapp/components/globla_dialog.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  Future signUp(
      {required String emailAddress,
      required String password,
      required dynamic context}) async {
    try {
      return await _auth
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          )
          .then((value) => true);
    } on FirebaseAuthException catch (e) {
      GlobalDialog()
          .showMyDialog(context: context, message: e.message, title: 'Error');
    }
  }

  Future signIn(
      {required String emailAddress,
      required String password,
      required dynamic context}) async {
    try {
      return await _auth
          .signInWithEmailAndPassword(email: emailAddress, password: password)
          .then((value) => true);
    } on FirebaseAuthException catch (e) {
      GlobalDialog()
          .showMyDialog(context: context, message: e.message, title: 'Error');
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
