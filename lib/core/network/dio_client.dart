import 'package:dio/dio.dart';

class DioClient {
  final _dio = Dio();

  DioClient._singleton() {
    _dio
      ..options.connectTimeout = const Duration(milliseconds: 5)
      ..options.receiveTimeout = const Duration(seconds: 1)
      ..options.baseUrl = "https://reqres.in/api"
      ..interceptors.add(TestInterceptor());
  }

  static final _singletonConstructor = DioClient._singleton();

  factory DioClient() {
    return _singletonConstructor;
  }

  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      return _dio.get(
        path,
        queryParameters: queryParams,
        // options: Options(
        //   headers: {
        //     "Authorization": "Bearer token",
        //   },
        // ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      return _dio.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }
}

class TestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(options.method);

    if (options.connectTimeout!.inMilliseconds <
        Duration(seconds: 5).inMilliseconds) {
      options.connectTimeout = const Duration(seconds: 5);
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(response.data);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(err.response?.data);
    super.onError(err, handler);
  }
}
