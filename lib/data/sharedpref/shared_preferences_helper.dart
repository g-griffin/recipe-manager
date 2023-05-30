import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferencesHelper {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesHelper(this._sharedPreferences);

  Future<String?> get authToken async {
    return _sharedPreferences.getString(Preferences.authToken);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreferences.setString(Preferences.authToken, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreferences.remove(Preferences.authToken);
  }

  String? get username {
    return _sharedPreferences.getString(Preferences.username);
  }

  Future<bool> saveUsername(String value) async {
    return _sharedPreferences.setString(Preferences.username, value);
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreferences.setBool(Preferences.isLoggedIn, value);
  }

  bool get isLoggedIn {
    return _sharedPreferences.getBool(Preferences.isLoggedIn) ?? false;
  }
}
