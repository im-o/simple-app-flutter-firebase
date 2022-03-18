import 'package:firebase_user/features/auth/presentation/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../core/core.dart';
import '../../../../../data/database_manager/database_manager.dart';
import '../../../../../data/repositories/auth_repository.dart';
import '../../../../../data/services/auth_service.dart';
import '../../../../../presentation/pages/dashboard/dashboard.dart';
import '../../../../../utils/utils.dart';
import 'sections/sections.dart';

class RegisterEmailPage extends StatefulWidget {
  const RegisterEmailPage({Key? key}) : super(key: key);

  @override
  _RegisterEmailPageState createState() => _RegisterEmailPageState();
}

class _RegisterEmailPageState extends State<RegisterEmailPage> {
  final AuthRepository _authRepository =
      AuthRepository(AuthService(), DatabaseManager());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterEmailBloc(_authRepository),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: ColorUtil.colorPrimary),
          title: const Text("Register", style: TextUtil.textStyle18),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocListener<RegisterEmailBloc, RegisterEmailState>(
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
