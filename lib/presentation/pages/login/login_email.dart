import 'dart:developer';

import 'package:firebase_user/data/repositories/auth_repository.dart';
import 'package:firebase_user/features/auth/presentation/blocs/login_email/login_email_bloc.dart';
import 'package:firebase_user/features/auth/presentation/forms/submit_status/FormSubmissionStatus.dart';
import 'package:firebase_user/presentation/pages/register/register_email.dart';
import 'package:firebase_user/utils/color_util.dart';
import 'package:firebase_user/utils/text_field_util.dart';
import 'package:firebase_user/utils/text_util.dart';
import 'package:firebase_user/utils/widget_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../dashboard/dashboard.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({Key? key}) : super(key: key);

  @override
  _LoginEmailPageState createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: BlocProvider(
        create: (_) => LoginEmailBloc(context.read<AuthRepository>()),
        child: _loginForm(),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginEmailBloc, LoginEmailState>(
      listener: (context, state) {
        final submissionStatus = state.submissionStatus;
        if (submissionStatus is SubmissionFailed) {
          showSnackBar(context, submissionStatus.exception);
        }
        if (submissionStatus is SubmissionSuccess) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const DashboardPage(),
          ));
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _imageLoginHeader(),
                _textTitle(),
                _textRegister(),
                _textFieldEmail(),
                _textFieldPassword(),
                _buttonSignIn(),
                _textForgotPassword()
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
      child: const Text("Hey,\nLogin Now,", style: TextUtil.textStyle18),
    );
  }

  Widget _textRegister() {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(bottom: 48.0),
      child: RichText(
        text: TextSpan(
          text: "If you are new / ",
          style: TextUtil.textStyle10.copyWith(color: ColorUtil.black300),
          children: [
            TextSpan(
                text: "Register",
                style: TextUtil.textStyle12.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorUtil.colorPrimary,
                  decorationColor: ColorUtil.colorPrimary,
                  decorationThickness: 2,
                  decorationStyle: TextDecorationStyle.solid,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterEmailPage(),
                    ));
                  }),
          ],
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return BlocBuilder<LoginEmailBloc, LoginEmailState>(
        builder: (context, state) {
      return TextFormField(
        controller: _emailController,
        validator: (value) => state.isValidEmail ? null : 'Is valid email',
        onChanged: (value) => context
            .read<LoginEmailBloc>()
            .add(LoginEmailEmailChanged(email: value)),
        style: const TextStyle(fontSize: 14),
        decoration: TextFieldUtil.inputDecorationFormLogin.copyWith(
          hintText: "Email",
          prefixIcon: const Icon(
            Icons.alternate_email,
            color: ColorUtil.colorTextFilled,
          ),
        ),
      );
    });
  }

  Widget _textFieldPassword() {
    return BlocBuilder<LoginEmailBloc, LoginEmailState>(
        builder: (context, state) {
      return Container(
        margin: const EdgeInsets.only(top: 16.0),
        child: TextFormField(
          controller: _passwordController,
          validator: (value) =>
              state.isValidPassword ? null : 'Is valid password',
          onChanged: (value) => context
              .read<LoginEmailBloc>()
              .add(LoginEmailPasswordChanged(password: value)),
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
      );
    });
  }

  Widget _buttonSignIn() {
    return Container(
        margin: const EdgeInsets.only(top: 64.0),
        child: BlocBuilder<LoginEmailBloc, LoginEmailState>(
            builder: (context, state) {
          return state.submissionStatus is FormSubmitting
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  child: const Text("Login"),
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
                    if (_formKey.currentState!.validate())
                      context
                          .read<LoginEmailBloc>()
                          .add(const LoginEmailSubmitted())
                  },
                );
        }));
  }

  Widget _textForgotPassword() {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.symmetric(vertical: 24.0),
      child: RichText(
        text: TextSpan(
          text: "Forgot Password? / ",
          style: TextUtil.textStyle10.copyWith(color: ColorUtil.black300),
          children: [
            TextSpan(
                text: "Reset",
                style: TextUtil.textStyle12.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorUtil.colorPrimary,
                  decorationColor: ColorUtil.colorPrimary,
                  decorationThickness: 2,
                  decorationStyle: TextDecorationStyle.solid,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    log("Testing xxx1");
                    showSnackBar(context, "Reset testing");
                  }),
          ],
        ),
      ),
    );
  }
}
