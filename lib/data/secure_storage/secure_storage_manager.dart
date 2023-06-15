import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  final FlutterSecureStorage _secureStorage;

  SecureStorageManager(this._secureStorage) {
    removeAll();
  }

  Future<void> setString(String key, String? value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getString(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> remove(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> removeAll() async {
    await _secureStorage.deleteAll();
  }
}
