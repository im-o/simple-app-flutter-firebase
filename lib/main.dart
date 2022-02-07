import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAvpn2c7FH1bjwJI5I3EV-83oCd4nTB5AQ",
      authDomain: "flutter-user-profile-aaef2.firebaseapp.com",
      projectId: "flutter-user-profile-aaef2",
      storageBucket: "flutter-user-profile-aaef2.appspot.com",
      messagingSenderId: "36293820089",
      appId: "1:36293820089:web:ae71586fcfaba2de1b2568",
      measurementId: "G-7CGVEJ74G1",
    ),
  );

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ),
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurpleAccent,
      ),
    );
  }
}
