import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseManager {
  CollectionReference userQuery =
      FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<dynamic> addUserData(String name, String gender, int score) async {
    String uid = auth.currentUser?.uid ?? "";
    return userQuery.add({
      'uid': uid,
      'name': name,
      'gender': gender,
      'score': score,
    });
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
