import 'package:mobx/mobx.dart';
import 'package:recipe_manager/data/shared_pref/shared_preferences_helper.dart';
import 'package:recipe_manager/di/service_locator.dart';

part 'login_form_store.g.dart';

class LoginFormStore = _LoginFormStore with _$LoginFormStore;

abstract class _LoginFormStore with Store {
  @observable
  String _username = "";

  @observable
  String _password = "";

  @action
  void setUsername(String value) {
    _username = value;
  }

  @action
  void setPassword(String value) {
    _password = value;
  }

  @computed
  bool get canLogin => _username.isNotEmpty && _password.isNotEmpty;

  @action
  Future<void> login() async {
    serviceLocator<SharedPreferencesHelper>().saveUsername(_username);
    serviceLocator<SharedPreferencesHelper>().setIsLoggedIn(true);
  }
}
