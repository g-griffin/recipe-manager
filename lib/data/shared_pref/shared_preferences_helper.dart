import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferencesHelper {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesHelper(this._sharedPreferences);

  String get username {
    return _sharedPreferences.getString(Preferences.username) ?? 'User';
  }

  Future<bool> saveUsername(String value) async {
    return _sharedPreferences.setString(Preferences.username, value);
  }

  Future<bool> setIsLoggedIn(bool value) async {
    return _sharedPreferences.setBool(Preferences.isLoggedIn, value);
  }

  bool get isLoggedIn {
    return _sharedPreferences.getBool(Preferences.isLoggedIn) ?? false;
  }
}
