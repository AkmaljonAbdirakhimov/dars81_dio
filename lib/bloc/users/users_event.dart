part of 'users_bloc.dart';

sealed class UsersEvent {}

final class GetUsersEvent extends UsersEvent {}

final class AddUserEvent extends UsersEvent {
  final String name;
  final String job;

  AddUserEvent(this.name, this.job);
}
