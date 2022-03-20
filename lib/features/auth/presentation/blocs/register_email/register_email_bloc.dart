import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';

import '../../../../../data/repositories/auth_repository.dart';
import '../../formz/formz.dart';

part 'register_email_event.dart';
part 'register_email_state.dart';

class RegisterEmailBloc extends Bloc<RegisterEmailEvent, RegisterEmailState> {
  RegisterEmailBloc(this.repository) : super(const RegisterEmailState()) {
    on<RegisterEmailNameChanged>(_onNameChanged);
    on<RegisterEmailEmailChanged>(_onEmailChanged);
    on<RegisterEmailPasswordChanged>(_onPasswordChanged);
    on<RegisterEmailSubmitted>(_onSubmitted);
  }

  final AuthRepository repository;

  void _onNameChanged(
    RegisterEmailNameChanged event,
    Emitter<RegisterEmailState> emit,
  ) {
    final name = event.name;
    emit(state.copyWith(
      name: name,
      status: Formz.validate([state.email, state.password]),
    ));
  }

  void _onEmailChanged(
    RegisterEmailEmailChanged event,
    Emitter<RegisterEmailState> emit,
  ) {
    final email = EmailFormz.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void _onPasswordChanged(
    RegisterEmailPasswordChanged event,
    Emitter<RegisterEmailState> emit,
  ) {
    final password = PasswordFormz.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  void _onSubmitted(
    RegisterEmailSubmitted event,
    Emitter<RegisterEmailState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final result = await repository.createNewUser(
          state.name,
          state.email.value,
          state.password.value,
        );

        if (result.runtimeType == User && result != null) {
          repository.addUserData(state.name);
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
