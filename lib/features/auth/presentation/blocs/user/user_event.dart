part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserOnLoading extends UserEvent {}

class UserFetched extends UserEvent {}

class UserUpdated extends UserEvent {}
