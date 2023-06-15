import 'package:dio/dio.dart';
import 'package:recipe_manager/data/network/constants/endpoints.dart';
import 'package:recipe_manager/data/secure_storage/secure_storage.dart';
import 'package:recipe_manager/data/secure_storage/secure_storage_manager.dart';

abstract class NetworkModule {
  /// A singleton preference provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Dio provideDio(SecureStorageManager secureStorage) {
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
        QueuedInterceptorsWrapper(
          onRequest: (RequestOptions options,
              RequestInterceptorHandler requestHandler) async {
            var token = await secureStorage.getString(SecureStorage.authToken);
            if (token != null) {
              options.headers
                  .putIfAbsent('Authorization', () => 'Bearer $token');
            }
            return requestHandler.next(options);
          },
          onError: (DioError error, ErrorInterceptorHandler errorHandler) async {
            print('--------------ERROR ENCOUNTERED-----------------');
            print(error);
            return errorHandler.next(error);
          }
        ),
      );
    return dio;
  }
}
