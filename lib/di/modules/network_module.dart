import 'package:dio/dio.dart';
import 'package:recipe_manager/data/network/constants/endpoints.dart';

abstract class NetworkModule {
  /// A singleton preference provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Dio provideDio() {
    final dio = Dio();

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout;

    return dio;
  }


}
