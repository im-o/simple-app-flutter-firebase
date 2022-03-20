import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseManager {
  var userQuery = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<dynamic> addUserData(String name, String gender, int score) async {
    String uid = auth.currentUser?.uid ?? "";
    try {
      var query = userQuery.doc(uid).set({
        'uid': uid,
        'name': name,
        'gender': gender,
        'score': score,
      });
      return query;
    } on FirebaseException catch (e) {
      log("addUserData ERROR : " + e.toString());
      return e.message;
    }
  }

  Future<dynamic> updateUserData(
      String uid, String name, String gender, int score) async {
    try {
      return userQuery.doc(uid).set({
        'name': name,
        'gender': gender,
        'score': score,
      });
    } on FirebaseException catch (e) {
      log("addUserData ERROR : " + e.toString());
      return e.message;
    }
  }

  Future getUserList() async {
    List users = [];
    try {
      await userQuery.get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          users.add(doc.data());
        }
      });
      log("Hello x Result xx : " + users.toString());
      return users;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
