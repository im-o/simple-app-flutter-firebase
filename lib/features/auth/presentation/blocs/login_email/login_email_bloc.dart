import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user/data/repositories/auth_repository.dart';
import 'package:formz/formz.dart';

import '../../formz/formz.dart';

part 'login_email_event.dart';

part 'login_email_state.dart';

class LoginEmailBloc extends Bloc<LoginEmailEvent, LoginEmailState> {
  LoginEmailBloc(this.repository) : super(const LoginEmailState()) {
    on<LoginEmailEmailChanged>(_onEmailChanged);
    on<LoginEmailPasswordChanged>(_onPasswordChanged);
    on<LoginEmailSubmitted>(_onSubmitted);
  }

  final AuthRepository repository;

  void _onEmailChanged(
    LoginEmailEmailChanged event,
    Emitter<LoginEmailState> emit,
  ) {
    final email = EmailFormz.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void _onPasswordChanged(
    LoginEmailPasswordChanged event,
    Emitter<LoginEmailState> emit,
  ) {
    final password = PasswordFormz.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  void _onSubmitted(
    LoginEmailSubmitted event,
    Emitter<LoginEmailState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final result = await repository.loginUser(
          state.email.value,
          state.password.value,
        );

        if (result.runtimeType == User && result != null) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            failure: result,
          ));
        }
      } on Exception catch (e) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            failure: e.toString(),
          ),
        );
      }
    }
  }
}
