import 'package:dars81_dio/core/network/dio_client.dart';
import 'package:dars81_dio/data/models/user.dart';
import 'package:dio/dio.dart';

class DioUsersService {
  final _dio = DioClient();

  Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get(
        path: "/users",
        queryParams: {"page": 2},
      );

      List<User> users = [];

      for (var userData in response.data['data']) {
        users.add(User.fromMap(userData));
      }
      return users;
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      // Xatolikni keyingi try catch'ga otib yuboradi
      rethrow;
    }
  }

  Future<void> addUser(String name, String job) async {
    try {
      final response = await _dio.post(
        path: "/login",
        data: {
          "email": "peter@klaven",
        },
      );
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
