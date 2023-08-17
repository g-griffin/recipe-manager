import 'package:recipe_manager/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferencesHelper {


  final SharedPreferences _sharedPreferences;

  SharedPreferencesHelper(this._sharedPreferences);

  String? get firstName {
    return _sharedPreferences.getString(Preferences.firstName);
  }

  String? get lastName {
    return _sharedPreferences.getString(Preferences.lastName);
  }

  String? get email {
    return _sharedPreferences.getString(Preferences.email);
  }

  Future<bool> saveString(String key, String value) async {
    return _sharedPreferences.setString(key, value);
  }

  Future<bool> logout() async {
    return _sharedPreferences.clear();
  }

  Future<bool> setIsLoggedIn(bool value) async {
    return _sharedPreferences.setBool(Preferences.isLoggedIn, value);
  }

  bool get isLoggedIn {
    return _sharedPreferences.getBool(Preferences.isLoggedIn) ?? false;
  }
}
