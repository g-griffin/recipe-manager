import 'package:mobx/mobx.dart';
import 'package:recipe_manager/data/sharedpref/shared_preferences_helper.dart';
import 'package:recipe_manager/di/service_locator.dart';

part 'login_form_store.g.dart';

class LoginFormStore = _LoginFormStore with _$LoginFormStore;

abstract class _LoginFormStore with Store {
  @observable
  String username = "";

  @observable
  String password = "";

  @action
  Future<void> setUsername(String value) async {
    username = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @computed
  bool get canLogin => username.isNotEmpty && password.isNotEmpty;

  @action
  Future<void> login() async {
    serviceLocator.get<SharedPreferencesHelper>().saveUsername(username);
    serviceLocator.get<SharedPreferencesHelper>().saveIsLoggedIn(true);
  }
}
