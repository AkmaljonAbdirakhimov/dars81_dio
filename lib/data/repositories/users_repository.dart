import 'package:dars81_dio/data/services/dio_users_service.dart';

import '../models/user.dart';

class UsersRepository {
  final DioUsersService _dioUsersService;

  UsersRepository({required DioUsersService dioUserService})
      : _dioUsersService = dioUserService;

  Future<List<User>> getUsers() async {
    return _dioUsersService.getUsers();
  }

  Future<void> addUser(String name, String job) async {
    return _dioUsersService.addUser(name, job);
  }
}
