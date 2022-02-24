import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user/data/repositories/auth_repository.dart';
import 'package:firebase_user/data/services/auth_service.dart';
import 'package:firebase_user/utils/color_util.dart';
import 'package:firebase_user/utils/text_field_util.dart';
import 'package:firebase_user/utils/text_util.dart';
import 'package:firebase_user/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/database_manager/database_manager.dart';

class RegisterEmailPage extends StatefulWidget {
  const RegisterEmailPage({Key? key}) : super(key: key);

  @override
  _RegisterEmailPageState createState() => _RegisterEmailPageState();
}

class _RegisterEmailPageState extends State<RegisterEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthRepository _authRepository =
      AuthRepository(AuthService(), DatabaseManager());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: ColorUtil.colorPrimary),
        title: const Text("Register", style: TextUtil.textStyle18),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _imageLoginHeader(),
                _textTitle(),
                _textFieldName(),
                _textFieldEmail(),
                _textFieldPassword(),
                _buttonSignIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageLoginHeader() {
    return Container(
      alignment: Alignment.topLeft,
      child: SvgPicture.asset("assets/icons/ic_header_login.svg"),
    );
  }

  Widget _textTitle() {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 24.0),
      child: const Text("Hey,\nRegister Now,", style: TextUtil.textStyle18),
    );
  }

  Widget _textFieldName() {
    return SizedBox(
      height: 50.0,
      child: TextFormField(
        controller: _nameController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Name cannot be empty";
          }
          return null;
        },
        style: const TextStyle(fontSize: 14),
        decoration: TextFieldUtil.inputDecorationFormLogin.copyWith(
          hintText: "Full Name",
          prefixIcon: const Icon(
            Icons.account_box,
            color: ColorUtil.colorTextFilled,
          ),
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: SizedBox(
        height: 50.0,
        child: TextFormField(
          controller: _emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Email cannot be empty";
            }
            return null;
          },
          style: const TextStyle(fontSize: 14),
          decoration: TextFieldUtil.inputDecorationFormLogin.copyWith(
            hintText: "Email",
            prefixIcon: const Icon(
              Icons.alternate_email,
              color: ColorUtil.colorTextFilled,
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: SizedBox(
        height: 50.0,
        child: TextFormField(
          controller: _passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Password cannot be empty";
            }
            return null;
          },
          style: const TextStyle(fontSize: 14),
          obscureText: true,
          decoration: TextFieldUtil.inputDecorationFormLogin.copyWith(
            hintText: "Password",
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: ColorUtil.colorTextFilled,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonSignIn() {
    return Container(
      margin: const EdgeInsets.only(top: 64.0),
      child: ElevatedButton(
        child: const Text("Register"),
        style: ElevatedButton.styleFrom(
          textStyle: TextUtil.textStyle18.copyWith(fontSize: 16),
          primary: ColorUtil.colorPrimary,
          fixedSize: Size(MediaQuery.of(context).size.width, 50.0),
          elevation: 0.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        onPressed: () => {
          if (_formKey.currentState!.validate()) _scaffoldMessage(),
        },
      ),
    );
  }

  void _scaffoldMessage() {
    _authRepository
        .createNewUser(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
    )
        .then((userResult) {
      User user = userResult;
      showSnackBar(context, "Register email : ${user.email}");
    });
  }
}
