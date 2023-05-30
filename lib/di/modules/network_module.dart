import 'package:dio/dio.dart';
import 'package:recipe_manager/data/network/constants/endpoints.dart';
import 'package:recipe_manager/data/sharedpref/shared_preferences_helper.dart';

abstract class NetworkModule {
  /// A singleton preference provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Dio provideDio(SharedPreferencesHelper sharedPreferencesHelper) {
    final dio = Dio();

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options,
              RequestInterceptorHandler handler) async {
            var token = await sharedPreferencesHelper.authToken;
            if (token != null) {
              options.headers
                  .putIfAbsent('Authorization', () => 'Bearer $token');
            } else {
              print('Auth token is null');
            }
            return handler.next(options);
          },
        ),
      );
    return dio;
  }
}
