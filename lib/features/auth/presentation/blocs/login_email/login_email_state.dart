part of 'login_email_bloc.dart';

class LoginEmailState extends Equatable {
  const LoginEmailState({
    this.email = '',
    this.password = '',
    this.submissionStatus = const InitialFormStatus(),
  });

  final String email;

  bool get isValidEmail => email.length >= 3;
  final String password;

  bool get isValidPassword => password.length >= 6;
  final FormSubmissionStatus submissionStatus;

  LoginEmailState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? submissionStatus,
  }) {
    return LoginEmailState(
      email: email ?? this.email,
      password: password ?? this.password,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [email, password, submissionStatus];
}
