part of 'login_email_bloc.dart';

abstract class LoginEmailEvent extends Equatable {
  const LoginEmailEvent();
}

class LoginEmailEmailChanged extends LoginEmailEvent {
  final String email;

  const LoginEmailEmailChanged({required this.email});

  @override
  List<Object?> get props => [email];
}

class LoginEmailPasswordChanged extends LoginEmailEvent {
  final String password;

  const LoginEmailPasswordChanged({required this.password});

  @override
  List<Object?> get props => [password];
}

class LoginEmailSubmitted extends LoginEmailEvent {
  const LoginEmailSubmitted();

  @override
  List<Object?> get props => [];
}
