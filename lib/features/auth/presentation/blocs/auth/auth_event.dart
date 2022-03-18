part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthInitialized extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class AuthLogoutRequested extends AuthEvent {}
