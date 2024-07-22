part of 'users_bloc.dart';

// sealed - abstract klass va shu faylda ishlaydi
sealed class UsersState {}

final class InitialUsersState extends UsersState {}

final class LoadingUsersState extends UsersState {}

final class SuccessState extends UsersState {}

final class LoadedUsersState extends UsersState {
  List<User> users;

  LoadedUsersState(this.users);
}

final class ErrorUsersState extends UsersState {
  final String message;

  ErrorUsersState(this.message);
}
