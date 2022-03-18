part of 'register_email_bloc.dart';

abstract class RegisterEmailEvent extends Equatable {
  const RegisterEmailEvent();

  @override
  List<Object?> get props => [];
}

class RegisterEmailEmailChanged extends RegisterEmailEvent {
  const RegisterEmailEmailChanged({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class RegisterEmailNameChanged extends RegisterEmailEvent {
  const RegisterEmailNameChanged({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

class RegisterEmailPasswordChanged extends RegisterEmailEvent {
  const RegisterEmailPasswordChanged({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];
}

class RegisterEmailSubmitted extends RegisterEmailEvent {
  const RegisterEmailSubmitted();

  @override
  List<Object?> get props => [];
}
