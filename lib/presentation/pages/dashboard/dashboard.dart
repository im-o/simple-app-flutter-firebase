import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database_manager/database_manager.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/services/auth_service.dart';
import '../../../features/auth/presentation/blocs/blocs.dart';
import '../../../utils/utils.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final AuthRepository _authRepository =
      AuthRepository(AuthService(), DatabaseManager());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
  String userUID = "";

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  void fetchUserInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    userUID = auth.currentUser?.uid ?? "";
  }

  void updateUserData(String uid, String name, String gender, int score) async {
    await _authRepository
        .updateUserData(uid, name, gender, score)
        .then((value) {
      if (value.runtimeType == String) {
        showSnackBar(context, value.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(repository: _authRepository),
          ),
          BlocProvider(
            create: (context) =>
                UserBloc(repository: _authRepository)..add(UserFetched()),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.status == AuthenticationStatus.unAuthenticated) {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    SystemNavigator.pop();
                  }
                }
              },
            ),
            BlocListener<UserBloc, UserState>(
              listener: (context, state) {},
            ),
          ],
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: const IconThemeData(color: ColorUtil.colorPrimary),
              title: const Text("Dashboard", style: TextUtil.textStyle18),
              actions: [
                _editOption(),
                _signOutOption(),
              ],
            ),
            body: _dashboardBody(),
          ),
        ));
  }

  Widget _editOption() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const UpdateUserPage(user: []),
            ));
          },
          icon: const Icon(
            Icons.add,
            color: ColorUtil.colorPrimary,
          ),
        );
      },
    );
  }

  Widget _signOutOption() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        log("SignOut User : ${state.status}");
        return IconButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthLogoutRequested());
          },
          icon: const Icon(
            Icons.exit_to_app,
            color: ColorUtil.colorPrimary,
          ),
        );
      },
    );
  }

  Widget _dashboardBody() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state.status == UserStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: state.users.length,
          itemBuilder: (context, index) {
            var users = state.users;
            return Card(
              child: ListTile(
                title: Text(users[index]["name"]),
                subtitle: Text("Gender: ${users[index]["gender"]}"),
                leading: const CircleAvatar(
                  child: Image(
                    image: AssetImage("assets/images/programmer.png"),
                  ),
                ),
                trailing: Text("Score : ${users[index]["score"] ?? 0}"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UpdateUserPage(
                      user: users[index],
                    ),
                  ));
                },
              ),
            );
          },
        );
      },
    );
  }

  void submitAction(BuildContext context) {
    updateUserData(
      userUID,
      _nameController.text,
      _genderController.text,
      int.parse(_scoreController.text),
    );
    _nameController.clear();
    _genderController.clear();
    _scoreController.clear();
  }
}
