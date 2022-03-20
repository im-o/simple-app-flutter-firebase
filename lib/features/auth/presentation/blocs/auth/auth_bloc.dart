import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../data/repositories/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.repository}) : super(const AuthState.unknown()) {
    on<AuthInitialized>(_onInitialized);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  final AuthRepository repository;

  FutureOr<void> _onInitialized(
      AuthInitialized event, Emitter<AuthState> emit) {}

  FutureOr<void> _onLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) {}

  FutureOr<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    repository.signOut();
    emit(const AuthState.unAuthenticated());
  }
}
