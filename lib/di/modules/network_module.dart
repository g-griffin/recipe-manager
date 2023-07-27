import 'package:dio/dio.dart';
import 'package:recipe_manager/data/network/constants/endpoints.dart';
import 'package:recipe_manager/data/secure_storage/secure_storage.dart';
import 'package:recipe_manager/stores/session_store.dart';
import 'package:recipe_manager/utils/dialogs.dart';

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
    var authToken = await _session.secureStorage.getString(SecureStorage.authToken);
    if (!_session.tokenHasExpired(authToken)) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $authToken');
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      var refreshToken =
          await _session.secureStorage.getString(SecureStorage.refreshToken);

      if (!_session.tokenHasExpired(refreshToken)) {
        var authToken = await _session.refresh();
        if (!_session.tokenHasExpired(authToken)) {
          err.requestOptions.headers['Authorization'] = 'Bearer $authToken';
          return handler.resolve(await _dio.fetch(err.requestOptions));
        }
      } else {
        await expiredSessionDialog();
        return handler.reject(err);
      }
    }
    return handler.next(err);
  }
}
