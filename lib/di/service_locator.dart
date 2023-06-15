import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_manager/data/secure_storage_manager.dart';
import 'package:recipe_manager/data/network/dio_client.dart';
import 'package:recipe_manager/data/sharedpref/shared_preferences_helper.dart';
import 'package:recipe_manager/di/modules/local_module.dart';
import 'package:recipe_manager/di/modules/network_module.dart';
import 'package:recipe_manager/stores/recipe_index_store.dart';
import 'package:recipe_manager/stores/login_form_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Storage
  serviceLocator.registerSingletonAsync<SharedPreferences>(
      () => LocalModule.provideSharedPreferences());
  serviceLocator.registerSingleton<SharedPreferencesHelper>(
      SharedPreferencesHelper(
          await serviceLocator.getAsync<SharedPreferences>()));
  serviceLocator.registerSingleton<FlutterSecureStorage>(
      LocalModule.provideSecureStorage());
  serviceLocator.registerSingleton<SecureStorageManager>(
      SecureStorageManager(serviceLocator<FlutterSecureStorage>()));


  // Network & authentication
  serviceLocator.registerSingleton<Dio>(
      NetworkModule.provideDio(serviceLocator<SecureStorageManager>()));
  serviceLocator.registerSingleton<DioClient>(DioClient(serviceLocator<Dio>()));

  // Models
  serviceLocator.registerSingleton<RecipeIndexStore>(RecipeIndexStore());

  // Stores
  serviceLocator.registerFactory<LoginFormStore>(() => LoginFormStore());
}
