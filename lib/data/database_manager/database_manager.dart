import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseManager {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<dynamic> addUserData(String name, String gender, int score) async {
    String uid = auth.currentUser?.uid ?? "";
    return users.add({
      'uid': uid,
      'name': name,
      'gender': gender,
      'score': score,
    });
  }
}
