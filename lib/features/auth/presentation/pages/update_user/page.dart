import 'package:firebase_user/features/auth/presentation/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../../data/database_manager/database_manager.dart';
import '../../../../../data/repositories/auth_repository.dart';
import '../../../../../data/services/auth_service.dart';
import '../../../../../presentation/pages/dashboard/dashboard.dart';
import '../../../../../utils/utils.dart';
import 'sections/sections.dart';

class UpdateUserPage extends StatefulWidget {
  const UpdateUserPage({Key? key, this.user}) : super(key: key);

  final dynamic user;

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final AuthRepository _authRepository =
      AuthRepository(AuthService(), DatabaseManager());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(repository: _authRepository),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: ColorUtil.colorPrimary),
          title: Text(
            _userIsNotEmpty() ? "Update User" : "Add User",
            style: TextUtil.textStyle18,
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        final status = state.status;
        if (status == UserStatus.updated) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const DashboardPage(),
          ));
        }
        if (status == UserStatus.failure) {
          showSnackBar(context, state.users.toString());
        }
      },
      child: ListView(
        padding: const EdgeInsets.all(Dimens.dp16),
        physics: const BouncingScrollPhysics(),
        children: [
          const HeaderSection(),
          const SizedBox(height: Dimens.dp24),
          FormSection(user: widget.user ?? [])
        ],
      ),
    );
  }

  bool _userIsNotEmpty() {
    return (widget.user.isNotEmpty);
  }
}
