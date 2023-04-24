import 'package:get_it/get_it.dart';
import 'package:recipe_manager/data/sharedpref/shared_preferences_helper.dart';
import 'package:recipe_manager/di/modules/local_module.dart';
import 'package:recipe_manager/stores/login_form_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  // async singletons
  serviceLocator.registerSingletonAsync<SharedPreferences>(
      () => LocalModule.provideSharedPreferences());

  // singletons
  serviceLocator.registerSingleton(SharedPreferencesHelper(
      await serviceLocator.getAsync<SharedPreferences>()));

  // stores
  serviceLocator.registerFactory(() => LoginFormStore());
}
