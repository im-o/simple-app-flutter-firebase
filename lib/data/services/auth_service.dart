import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createNewUser(String name, String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      log("Error : " + e.toString());
    }
  }

  Future loginUser(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      log("Error : " + e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      if (kDebugMode) print(error.toString());
      return null;
    }
  }
}
