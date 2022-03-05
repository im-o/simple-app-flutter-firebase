part of 'login_email_bloc.dart';

class LoginEmailState extends Equatable {
  const LoginEmailState({
    this.email = const EmailFormz.pure(),
    this.password = const PasswordFormz.pure(),
    this.status = FormzStatus.pure,
    this.failure,
  });

  final EmailFormz email;
  final PasswordFormz password;
  final FormzStatus status;
  final String? failure;

  LoginEmailState copyWith({
    EmailFormz? email,
    PasswordFormz? password,
    FormzStatus? status,
    String? failure,
  }) {
    return LoginEmailState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}
