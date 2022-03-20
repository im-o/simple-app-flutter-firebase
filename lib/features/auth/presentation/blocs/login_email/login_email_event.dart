part of 'login_email_bloc.dart';

abstract class LoginEmailEvent extends Equatable {
  const LoginEmailEvent();

  @override
  List<Object?> get props => [];
}

class LoginEmailEmailChanged extends LoginEmailEvent {
  const LoginEmailEmailChanged({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class LoginEmailPasswordChanged extends LoginEmailEvent {
  const LoginEmailPasswordChanged({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];
}

class LoginEmailSubmitted extends LoginEmailEvent {
  const LoginEmailSubmitted();

  @override
  List<Object?> get props => [];
}
