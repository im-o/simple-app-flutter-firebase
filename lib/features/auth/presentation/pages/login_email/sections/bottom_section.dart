import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../../core/core.dart';
import '../../../../../../utils/utils.dart';
import '../../../blocs/login_email/login_email_bloc.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buttonSignIn(context),
        const SizedBox(height: Dimens.dp16),
        _textForgotPassword(context),
      ],
    );
  }

  Widget _buttonSignIn(BuildContext context) {
    return BlocBuilder<LoginEmailBloc, LoginEmailState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                child: const Text("Login"),
                style: ElevatedButton.styleFrom(
                  textStyle: TextUtil.textStyle18.copyWith(fontSize: 16),
                  primary: state.status.isValidated
                      ? ColorUtil.colorPrimary
                      : Theme.of(context).disabledColor,
                  fixedSize: Size(MediaQuery.of(context).size.width, 50.0),
                  elevation: 0.0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                onPressed: state.status.isValidated
                    ? () => {
                          context
                              .read<LoginEmailBloc>()
                              .add(const LoginEmailSubmitted())
                        }
                    : () {},
              );
      },
    );
  }

  Widget _textForgotPassword(BuildContext context) {
    return RichText(
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
    );
  }
}
