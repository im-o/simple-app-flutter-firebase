import 'package:firebase_user/data/repositories/auth_repository.dart';
import 'package:firebase_user/presentation/pages/login/login_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(key: key);

  final AuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: RepositoryProvider(
        create: (context) => _authRepository,
        child: const LoginEmailPage(),
      ),
    );
  }
}
