import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_user/app.dart';
import 'package:firebase_user/data/database_manager/database_manager.dart';
import 'package:firebase_user/data/repositories/auth_repository.dart';
import 'package:firebase_user/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/simple_bloc_observer.dart';
import 'default_firebase_config.dart';

Future<void> main() {
  return BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseConfig.platformOptions,
    );
    final authRepository = AuthRepository(AuthService(), DatabaseManager());
    runApp(App(authRepository: authRepository));
  }, blocObserver: SimpleBlocObserver());
}
