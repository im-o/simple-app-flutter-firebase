import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions? get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
        apiKey: "AIzaSyAvpn2c7FH1bjwJI5I3EV-83oCd4nTB5AQ",
        authDomain: "flutter-user-profile-aaef2.firebaseapp.com",
        projectId: "flutter-user-profile-aaef2",
        storageBucket: "flutter-user-profile-aaef2.appspot.com",
        messagingSenderId: "36293820089",
        appId: "1:36293820089:web:ae71586fcfaba2de1b2568",
        measurementId: "G-7CGVEJ74G1",
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:36293820089:web:ae71586fcfaba2de1b2568',
        apiKey: 'AIzaSyAvpn2c7FH1bjwJI5I3EV-83oCd4nTB5AQ',
        projectId: 'flutter-user-profile-aaef2',
        messagingSenderId: '36293820089',
        iosBundleId: 'com.invertase.testing',
        iosClientId:
            '448618578101-28tsenal97nceuij1msj7iuqinv48t02.apps.googleusercontent.com',
        androidClientId:
            '448618578101-a9p7bj5jlakabp22fo3cbkj7nsmag24e.apps.googleusercontent.com',
        databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
        storageBucket: 'flutter-user-profile-aaef2.appspot.com',
      );
    } else {
      // Android
      log("Analytics Dart-only initializer doesn't work on Android, please make sure to add the config file.");

      return null;
    }
  }
}
