part of 'register_email_bloc.dart';

class RegisterEmailState extends Equatable {
  const RegisterEmailState({
    this.name = '',
    this.email = const EmailFormz.pure(),
    this.password = const PasswordFormz.pure(),
    this.status = FormzStatus.pure,
    this.failure = '',
  });

  final String name;
  final EmailFormz email;
  final PasswordFormz password;
  final FormzStatus status;
  final String failure;

  RegisterEmailState copyWith({
    String? name,
    EmailFormz? email,
    PasswordFormz? password,
    FormzStatus? status,
    String? failure,
  }) {
    return RegisterEmailState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object> get props => [name, email, password, status, failure];
}
