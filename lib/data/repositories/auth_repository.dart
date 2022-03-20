import 'dart:developer';

import 'package:firebase_user/data/database_manager/database_manager.dart';
import 'package:firebase_user/data/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;
  final DatabaseManager _databaseManager;

  AuthRepository(this._authService, this._databaseManager);

  Future createNewUser(String name, String email, String password) async {
    try {
      var result = await _authService.createNewUser(name, email, password);
      log("Auth Result : " + result.toString());
      return result;
    } catch (e) {
      log("Auth Error : " + e.toString());
      return e.toString();
    }
  }

  Future loginUser(String email, String password) async {
    try {
      var result = await _authService.loginUser(email, password);
      log("Auth Result : " + result.toString());
      return result;
    } catch (e) {
      log("Auth Error : " + e.toString());
      return e;
    }
  }

  Future signOut() async {
    try {
      var result = await _authService.signOut();
      log("SignOut Result : " + result.toString());
      return result;
    } catch (e) {
      log("SignOut Result : " + e.toString());
      return null;
    }
  }

  Future<dynamic> getUserList() async {
    try {
      var result = await _databaseManager.getUserList();
      log("User Result AuthRepository: $result");
      return result;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future addUserData(String name) async {
    try {
      var result = await _databaseManager.addUserData(name, "", 0);
      log("User Add AuthRepository: $result");
      return result;
    } catch (e) {
      log("Update Error : " + e.toString());
      return e.toString();
    }
  }

  Future updateUserData(
      String uid, String name, String gender, int score) async {
    try {
      var result =
          await _databaseManager.updateUserData(uid, name, gender, score);
      log("User Update AuthRepository: $result");
      return result;
    } catch (e) {
      log("Update Error : " + e.toString());
      return e.toString();
    }
  }
}
