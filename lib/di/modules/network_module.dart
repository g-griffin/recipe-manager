import 'package:dio/dio.dart';
import 'package:recipe_manager/data/network/constants/endpoints.dart';
import 'package:recipe_manager/data/secure_storage/secure_storage.dart';
import 'package:recipe_manager/stores/session_store.dart';

abstract class NetworkModule {
  static Dio provideDio(SessionStore session) {
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
      ..interceptors.addAll({DioInterceptors(session, dio)});
    return dio;
  }
}

class DioInterceptors extends QueuedInterceptorsWrapper {
  final SessionStore _session;
  final Dio _dio;

  DioInterceptors(this._session, this._dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var token = await _session.secureStorage.getString(SecureStorage.authToken);
    if (!_session.tokenHasExpired(token)) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      var newToken = await _session.refresh();
      if (!_session.tokenHasExpired(newToken)) {
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        return handler.resolve(await _dio.fetch(err.requestOptions));
      }
    }
    return handler.next(err);
  }
}
