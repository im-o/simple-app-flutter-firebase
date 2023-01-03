import 'package:firebase_user/presentation/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../../../utils/utils.dart';
import '../../../blocs/blocs.dart';

class FormSection extends StatefulWidget {
  const FormSection({Key? key, this.user}) : super(key: key);

  final dynamic user;

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = _userIsNotEmpty() ? widget.user['name'] : "";
    _genderController.text = _userIsNotEmpty() ? widget.user['gender'] : "";
    _scoreController.text =
        _userIsNotEmpty() ? widget.user['score'].toString() : "";
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.status == UserStatus.updated) {
          Route route = MaterialPageRoute(
            builder: (context) => const DashboardPage(),
          );
          Navigator.pushReplacement(context, route);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RegularInput(
            hintText: 'Name',
            controller: _nameController,
            prefixIcon: Icons.account_box,
            inputType: TextInputType.text,
          ),
          const SizedBox(height: Dimens.dp16),
          RegularInput(
            hintText: 'Gender',
            controller: _genderController,
            prefixIcon: Icons.account_box,
            inputType: TextInputType.text,
          ),
          const SizedBox(height: Dimens.dp16),
          RegularInput(
            hintText: 'Score',
            prefixIcon: Icons.account_box,
            inputType: TextInputType.number,
            controller: _scoreController,
          ),
          const SizedBox(height: Dimens.dp64),
          _bottomSection()
        ],
      ),
    );
  }

  Widget _bottomSection() {
    return Column(
      children: [
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return state.status == UserStatus.loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: TextUtil.textStyle18.copyWith(fontSize: 16),
                      backgroundColor: ColorUtil.colorPrimary,
                      fixedSize: Size(MediaQuery.of(context).size.width, 50.0),
                      elevation: 0.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onPressed: () => {
                          context.read<UserBloc>().add(UserUpdated(
                                uid: _userIsNotEmpty()
                                    ? widget.user['uid']
                                    : null,
                                name: _nameController.text,
                                gender: _genderController.text,
                                score: int.parse(_scoreController.text),
                              ))
                        },
                    child: Text(
                      _userIsNotEmpty() ? "Update User" : "Add User",
                    ));
          },
        ),
      ],
    );
  }

  bool _userIsNotEmpty() {
    return widget.user.isNotEmpty;
  }
}
