import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobx/mobx.dart';
import 'package:recipe_manager/data/network/constants/endpoints.dart';
import 'package:recipe_manager/data/secure_storage/secure_storage.dart';
import 'package:recipe_manager/data/secure_storage/secure_storage_manager.dart';
import 'package:recipe_manager/data/shared_pref/constants/preferences.dart';
import 'package:recipe_manager/data/shared_pref/shared_preferences_helper.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/utils/errors.dart';

part 'session_store.g.dart';

class SessionStore = _SessionStore with _$SessionStore;

abstract class _SessionStore with Store {
  final FlutterAppAuth _appAuth;
  final SecureStorageManager _secureStorage;
  final SharedPreferencesHelper _sharedPrefs;

  _SessionStore(this._appAuth, this._secureStorage, this._sharedPrefs);

  @readonly
  String? firstName;

  @readonly
  String? lastName;

  @readonly
  String? email;

  void initializeSessionObservables() {
    firstName = _sharedPrefs.firstName;
    lastName = _sharedPrefs.lastName;
    email = _sharedPrefs.email;
  }

  SecureStorageManager get secureStorage => _secureStorage;

  Future<void> login() async {
    try {
      final AuthorizationTokenResponse? response =
          await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          Endpoints.keycloakClientId,
          Endpoints.redirectUrl,
          discoveryUrl: Endpoints.discoveryUrl,
          scopes: ['email', 'profile', 'openid'],
          // Use 'openid' to get idToken from Keycloak
          allowInsecureConnections: true,
        ),
      );

      if (response != null) {
        await _saveProfileDetails(response.idToken);
        initializeSessionObservables();
        await _saveTokens(response);
        await serviceLocator<SharedPreferencesHelper>().setIsLoggedIn(true);
      }
    } catch (e) {
      logError(e.toString(), 'Authorization failed');
    }
  }

  Future<void> _saveProfileDetails(String? idToken) async {
    if (idToken != null) {
      await _sharedPrefs.saveString(
          Preferences.firstName, JwtDecoder.decode(idToken)['given_name']);
      await _sharedPrefs.saveString(
          Preferences.lastName, JwtDecoder.decode(idToken)['family_name']);
      await _sharedPrefs.saveString(
          Preferences.email, JwtDecoder.decode(idToken)['email']);
    }
  }

  Future<void> _saveTokens(var response) async {
    await _secureStorage.setString(
        SecureStorage.authToken, response.accessToken);
    await _secureStorage.setString(SecureStorage.idToken, response.idToken);
    await _secureStorage.setString(
        SecureStorage.refreshToken, response.refreshToken);
  }

  Future<void> logout() async {
    final idToken = await _secureStorage.getString(SecureStorage.idToken);
    try {
      await serviceLocator<FlutterAppAuth>().endSession(
        EndSessionRequest(
          idTokenHint: idToken,
          postLogoutRedirectUrl: Endpoints.redirectUrl,
          issuer: Endpoints.issuerUrl,
          discoveryUrl: Endpoints.discoveryUrl,
          allowInsecureConnections: true,
        ),
      );
    } catch (e) {
      logError(e.toString(), 'Failed to end session');
    }
    await _secureStorage.removeAll();
    await _sharedPrefs.logout();
  }

  Future<String?> refresh() async {
    var refreshToken =
        await _secureStorage.getString(SecureStorage.refreshToken);
    try {
      final TokenResponse? response = await _appAuth.token(
        TokenRequest(
          Endpoints.keycloakClientId,
          Endpoints.redirectUrl,
          discoveryUrl: Endpoints.discoveryUrl,
          refreshToken: refreshToken,
          allowInsecureConnections: true,
        ),
      );
      if (response != null) {
        await _saveTokens(response);
        return response.accessToken;
      }
    } catch (e) {
      logError(e.toString(), 'Failed to refresh tokens');
    }
    return null;
  }

  bool tokenHasExpired(String? token) {
    return token != null ? JwtDecoder.isExpired(token) : true;
  }
}
