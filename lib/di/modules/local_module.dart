import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalModule {
  static const _androidOptions =
      AndroidOptions(encryptedSharedPreferences: true);

  static Future<SharedPreferences> provideSharedPreferences() async {
    final singleton = await SharedPreferences.getInstance();
    singleton.clear();  // TODO: Remove after finishing Authentication
    return singleton;
  }

  static FlutterSecureStorage provideSecureStorage() {
    return const FlutterSecureStorage(aOptions: _androidOptions);
  }
}
