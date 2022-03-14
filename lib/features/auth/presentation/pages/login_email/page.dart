import 'package:firebase_user/data/repositories/auth_repository.dart';
import 'package:firebase_user/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../core/core.dart';
import '../../../../../data/database_manager/database_manager.dart';
import '../../../../../data/services/auth_service.dart';
import '../../../../../presentation/pages/dashboard/dashboard.dart';
import '../../blocs/blocs.dart';
import 'sections/sections.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({Key? key}) : super(key: key);

  @override
  _LoginEmailPageState createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  final AuthRepository _authRepository =
      AuthRepository(AuthService(), DatabaseManager());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginEmailBloc(_authRepository),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocListener<LoginEmailBloc, LoginEmailState>(
      listener: (context, state) {
        final status = state.status;
        if (status.isSubmissionSuccess) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const DashboardPage(),
          ));
        }
        if (status.isSubmissionFailure) {
          showSnackBar(context, state.failure.toString());
        }
      },
      child: ListView(
        padding: const EdgeInsets.all(Dimens.dp16),
        physics: const BouncingScrollPhysics(),
        children: const [
          HeaderSection(),
          SizedBox(height: Dimens.dp24),
          FormSection(),
          SizedBox(height: Dimens.dp64),
          BottomSection()
        ],
      ),
    );
  }
}
