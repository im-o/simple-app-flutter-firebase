import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user/data/repositories/auth_repository.dart';
import 'package:firebase_user/features/auth/presentation/forms/submit_status/FormSubmissionStatus.dart';

part 'login_email_event.dart';

part 'login_email_state.dart';

class LoginEmailBloc extends Bloc<LoginEmailEvent, LoginEmailState> {
  final AuthRepository authRepository;

  LoginEmailBloc(this.authRepository) : super(const LoginEmailState()) {
    on<LoginEmailEmailChanged>(_onEmailChanged);
    on<LoginEmailPasswordChanged>(_onPasswordChanged);
    on<LoginEmailSubmitted>(_onSubmitted);
  }

  FutureOr<void> _onEmailChanged(
    LoginEmailEmailChanged event,
    Emitter<LoginEmailState> emit,
  ) {
    log("EM CH : ${event.email}");
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _onPasswordChanged(
    LoginEmailPasswordChanged event,
    Emitter<LoginEmailState> emit,
  ) {
    log("PW CH : ${event.password}");
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _onSubmitted(
    LoginEmailSubmitted event,
    Emitter<LoginEmailState> emit,
  ) async {
    emit(state.copyWith(submissionStatus: FormSubmitting()));
    log('BLOC XX : ${state.email} | ${state.password}');
    try {
      var result = await authRepository.loginUser(state.email, state.password);
      if (result.runtimeType == User && result != null) {
        emit(state.copyWith(submissionStatus: SubmissionSuccess()));
      } else {
        emit(state.copyWith(
            submissionStatus: SubmissionFailed(result.toString())));
      }
      log("BLOC Result : $result");
    } on Exception catch (e) {
      log("BLOC Error : " + e.toString());
      emit(state.copyWith(submissionStatus: SubmissionFailed(e.toString())));
    }
  }
}
