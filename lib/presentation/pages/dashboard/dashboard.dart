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
import '../../../utils/utils.dart';

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
  String userUID = "";

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  fetchUserInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    userUID = auth.currentUser?.uid ?? "";
  }

  updateUserData(String uid, String name, String gender, int score) async {
    await _authRepository
        .updateUserData(uid, name, gender, score)
        .then((value) {
      if (value.runtimeType == String) {
        showSnackBar(context, value.toString());
      }
    });
    // context.read<UserBloc>().add(UserUpdated(
    //       uid: uid,
    //       name: name,
    //       gender: gender,
    //       score: score,
    //     ));
    // // BlocBuilder<UserBloc, UserState>(
    // //   builder: (context, state) {
    // // aBlocProvider.of<UserBloc>(context)
    // //     .add(UserUpdated(uid: uid, name: name, gender: gender, score: score));
    // //     return Container();
    // //   },
    // // );
    // // BlocProvider(
    // //   create: (context) => UserBloc(repository: _authRepository)..add(),
    // // );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(repository: _authRepository),
          ),
          BlocProvider(
            create: (context) => UserBloc(repository: _authRepository),
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
            showDialog(
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
                          BlocProvider.of<UserBloc>(context).add(UserUpdated(
                            uid: userUID,
                            name: _nameController.text,
                            gender: _genderController.text,
                            score: int.parse(_scoreController.text),
                          ));
                          // context.read<UserBloc>().add(UserUpdated(
                          //       uid: userUID,
                          //       name: _nameController.text,
                          //       gender: _genderController.text,
                          //       score: int.parse(_scoreController.text),
                          //     ));
                          Navigator.pop(context);
                        },
                        child: const Text("Submit"),
                      )
                      //   },
                      // ),
                    ],
                  );
                });
          },
          icon: const Icon(
            Icons.edit,
            color: ColorUtil.colorPrimary,
          ),
        );
      },
    );
  }

  Widget _signOutOption() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        log("SignOut User : " + state.status.toString());
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
                subtitle: Text("Age: ${users[index]["age"] ?? 0}"),
                leading: const CircleAvatar(
                  child: Image(
                    image: AssetImage("assets/images/programmer.png"),
                  ),
                ),
                trailing: Text("Score : ${users[index]["score"] ?? 0}"),
              ),
            );
          },
        );
      },
    );
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
