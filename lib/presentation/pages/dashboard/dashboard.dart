import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../data/database_manager/database_manager.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/services/auth_service.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: ColorUtil.colorPrimary),
        title: const Text("Dashboard", style: TextUtil.textStyle18),
        actions: [
          ElevatedButton(
            onPressed: () {
              openDialogBox();
            },
            child: const Icon(
              Icons.edit,
              color: ColorUtil.colorPrimary,
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _signOutUser();
            },
            child: const Icon(
              Icons.exit_to_app,
              color: ColorUtil.colorPrimary,
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
              ),
            ),
          )
        ],
      ),
      body: _dashboardBody(),
    );
  }

  Widget _dashboardBody() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text("Rival test $index"),
            subtitle: Text("Age: 2$index"),
            leading: const CircleAvatar(
              child: Image(
                image: AssetImage("assets/images/programmer.png"),
              ),
            ),
            trailing: Text("Score : 10$index"),
          ),
        );
      },
    );
  }

  void _signOutUser() {
    _authRepository.signOut().then((result) {
      showSnackBar(context, "SignOut User...");
      log("SignOut User : " + result.toString());
      Navigator.of(context).pop(true);
    });
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
                      hintText: "Name",
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
                  Navigator.pop(context);
                },
                child: const Text("Submit"),
              ),
            ],
          );
        });
  }
}
