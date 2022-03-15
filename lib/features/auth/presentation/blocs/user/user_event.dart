part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserOnLoading extends UserEvent {}

class UserFetched extends UserEvent {}

class UserUpdated extends UserEvent {
  const UserUpdated({
    required this.uid,
    required this.name,
    required this.gender,
    required this.score,
  });

  final String uid;
  final String name;
  final String gender;
  final int score;

  @override
  List<Object?> get props => [uid, name, gender, score];
}
