import 'dart:developer';

import 'package:firebase_user/data/services/auth_service.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository(this.authService);

  Future createNewUser(String name, String email, String password) async {
    try {
      var result = await authService.createNewUser(name, email, password);
      log("Auth Result : " + result.toString());
      return result;
    } catch (e) {
      log("Auth Error : " + e.toString());
    }
  }

  Future loginUser(String email, String password) async {
    try {
      var result = await authService.loginUser(email, password);
      log("Auth Result : " + result.toString());
      return result;
    } catch (e) {
      log("Auth Error : " + e.toString());
    }
  }
}
