import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_user/app.dart';
import 'package:flutter/material.dart';

import 'default_firebase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  runApp(const App());
}
