part of 'user_bloc.dart';

enum UserStatus { initial, success, failure, updated }

class UserState extends Equatable {
  const UserState({
    this.status = UserStatus.initial,
    this.users = const <dynamic>[],
    this.hasReachedMax = false,
  });

  final UserStatus status;
  final List<dynamic> users;
  final bool hasReachedMax;

  UserState copyWith({
    UserStatus? status,
    List<dynamic>? users,
    bool? hasReachedMax,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, users, hasReachedMax];
}
