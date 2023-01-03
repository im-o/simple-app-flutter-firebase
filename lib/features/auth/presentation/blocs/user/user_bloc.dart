import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../../../data/repositories/auth_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.repository}) : super(const UserState()) {
    on<UserFetched>(_onUserFetched);
    on<UserUpdated>(_onUserUpdated);
  }

  final AuthRepository repository;

  FutureOr<void> _onUserFetched(
    UserFetched event,
    Emitter<UserState> emit,
  ) async {
    try {
      dynamic users = await repository.getUserList();
      if (users != null) {
        return emit(state.copyWith(
          status: UserStatus.success,
          users: users,
          hasReachedMax: false,
        ));
      }
    } catch (e) {
      return emit(state.copyWith(status: UserStatus.failure));
    }
  }

  FutureOr<void> _onUserUpdated(
    UserUpdated event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));
      var uuid = const Uuid();
      await repository
          .updateUserData(
        event.uid ?? uuid.v1(),
        event.name,
        event.gender,
        event.score,
      )
          .then((value) {
        if (value.runtimeType == String) {
          emit(state.copyWith(status: UserStatus.failure));
        } else {
          emit(state.copyWith(status: UserStatus.updated));
        }
      });
    } catch (e) {
      return emit(state.copyWith(status: UserStatus.failure));
    }
  }
}
