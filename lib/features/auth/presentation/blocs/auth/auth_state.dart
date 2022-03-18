part of 'auth_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unAuthenticated }

class AuthState extends Equatable {
  const AuthState._({
    this.user,
    this.status = AuthenticationStatus.unknown,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated(User user)
      : this._(user: user, status: AuthenticationStatus.authenticated);

  const AuthState.unAuthenticated()
      : this._(
          status: AuthenticationStatus.unAuthenticated,
          user: null,
        );

  final User? user;
  final AuthenticationStatus status;

  @override
  List<Object> get props => [];
}
