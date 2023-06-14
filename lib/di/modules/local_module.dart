import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalModule {
  /// A singleton preference provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Future<SharedPreferences> provideSharedPreferences() async {
    final singleton = await SharedPreferences.getInstance();
    singleton.clear();
    return singleton;
  }
}