import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database_manager/database_manager.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/services/auth_service.dart';
import '../../../features/auth/presentation/blocs/blocs.dart';
import '../../../utils/color_util.dart';
import '../../../utils/text_util.dart';
import '../../../utils/widget_util.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final AuthRepository _authRepository =
      AuthRepository(AuthService(), DatabaseManager());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
  List userList = [];
  String userUID = "";

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    fetchDataUsers();
  }

  fetchUserInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    userUID = auth.currentUser?.uid ?? "";
  }

  fetchDataUsers() async {
    dynamic result = await _authRepository.getUserList();
    if (result == null) {
      log("Null user data: $result");
    } else {
      setState(() {
        userList = result;
      });
    }
  }

  updateUserData(String uid, String name, String gender, int score) async {
    await _authRepository
        .updateUserData(uid, name, gender, score)
        .then((value) {
      if (value.runtimeType == String) {
        showSnackBar(context, value.toString());
      }
    });
    fetchDataUsers();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthBloc(repository: _authRepository),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          log("SignOut User : " + state.status.toString());
          if (state.status == AuthenticationStatus.unAuthenticated) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              SystemNavigator.pop();
            }
          }
          return Scaffold(
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
          );
        },
      ),
    );
  }

  Widget _editOption() {
    return IconButton(
      onPressed: () {
        openDialogBox();
      },
      icon: const Icon(
        Icons.edit,
        color: ColorUtil.colorPrimary,
      ),
    );
  }

  Widget _signOutOption() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        log("SignOut User : " + state.status.toString());
        return IconButton(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(AuthLogoutRequested());
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
    if (userList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(userList[index]["name"]),
              subtitle: Text("Age: ${userList[index]["age"] ?? 0}"),
              leading: const CircleAvatar(
                child: Image(
                  image: AssetImage("assets/images/programmer.png"),
                ),
              ),
              trailing: Text("Score : ${userList[index]["score"] ?? 0}"),
            ),
          );
        },
      );
    }
  }

  void signOutUser() {
    BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        context.read<AuthBloc>().add(AuthLogoutRequested());
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            log("SignOut User : " + state.status.toString());
            if (state.status is AuthState) {
              log("SignOut User : " + state.status.toString());
            }
          },
        );
      },
    );
    //     .then((result) {
    //   showSnackBar(context, "SignOut User...");
    //   log("SignOut User : " + result.toString());
    //   Navigator.of(context).pop(true);
    // });
  }

  Future<dynamic> openDialogBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Edit user details"),
            content: SizedBox(
              height: 150.0,
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "Your Name",
                    ),
                  ),
                  TextField(
                    controller: _genderController,
                    decoration: const InputDecoration(
                      hintText: "Gender",
                    ),
                  ),
                  TextField(
                    controller: _scoreController,
                    decoration: const InputDecoration(
                      hintText: "Score",
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  submitAction(context);
                  Navigator.pop(context);
                },
                child: const Text("Submit"),
              ),
            ],
          );
        });
  }

  submitAction(BuildContext context) {
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
