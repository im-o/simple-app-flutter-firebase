import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../../utils/utils.dart';
import '../../../blocs/blocs.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<RegisterEmailBloc, RegisterEmailState>(
          builder: (context, state) {
            return state.status.isSubmissionInProgress
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    child: const Text("Register"),
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
                                  .read<RegisterEmailBloc>()
                                  .add(const RegisterEmailSubmitted())
                            }
                        : () {},
                  );
          },
        ),
      ],
    );
  }
}
