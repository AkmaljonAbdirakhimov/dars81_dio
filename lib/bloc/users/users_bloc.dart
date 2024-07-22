import 'package:bloc/bloc.dart';
import 'package:dars81_dio/data/repositories/users_repository.dart';

import '../../data/models/user.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository _usersRepository;

  UsersBloc({required UsersRepository usersRepository})
      : _usersRepository = usersRepository,
        super(InitialUsersState()) {
    on<GetUsersEvent>(_getUsers);
    on<AddUserEvent>(_addUser);
  }

  void _getUsers(
    GetUsersEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(LoadingUsersState());
    try {
      final users = await _usersRepository.getUsers();
      emit(LoadedUsersState(users));
    } catch (e) {
      emit(ErrorUsersState(e.toString()));
    }
  }

  void _addUser(
    AddUserEvent event,
    Emitter<UsersState> emit,
  ) async {
    final currentState = state;

    emit(LoadingUsersState());

    try {
      await _usersRepository.addUser(event.name, event.job);
      emit(SuccessState());
      if (currentState is LoadedUsersState) {
        emit(LoadedUsersState(currentState.users));
      }
    } catch (e) {
      emit(ErrorUsersState(e.toString()));
    }
  }
}
