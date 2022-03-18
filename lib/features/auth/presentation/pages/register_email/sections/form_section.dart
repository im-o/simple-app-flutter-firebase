import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../blocs/blocs.dart';

class FormSection extends StatelessWidget {
  const FormSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterEmailBloc, RegisterEmailState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RegularInput(
              hintText: 'Name',
              prefixIcon: Icons.account_box,
              inputType: TextInputType.emailAddress,
              onChange: (v) => context
                  .read<RegisterEmailBloc>()
                  .add(RegisterEmailNameChanged(name: v)),
            ),
            const SizedBox(height: Dimens.dp16),
            RegularInput(
              hintText: 'Email',
              prefixIcon: Icons.alternate_email,
              inputType: TextInputType.emailAddress,
              onChange: (v) => context
                  .read<RegisterEmailBloc>()
                  .add(RegisterEmailEmailChanged(email: v)),
              errorText: state.email.invalid ? 'Email is invalid' : null,
            ),
            const SizedBox(height: Dimens.dp16),
            PasswordInput(
              hintText: 'Password',
              onChange: (v) => context
                  .read<RegisterEmailBloc>()
                  .add(RegisterEmailPasswordChanged(password: v)),
              errorText: state.password.invalid ? 'Password is invalid' : null,
            ),
          ],
        );
      },
    );
  }
}
