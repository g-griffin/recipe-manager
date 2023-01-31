import 'package:mobx/mobx.dart';

part 'login_form_store.g.dart';

class LoginFormStore = _LoginFormStore with _$LoginFormStore;

abstract class _LoginFormStore with Store {

  @observable
  String username = "";

  @observable
  String password = "";

  @action
  void setUsername(String value) {
    username = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @computed
  bool get canLogin => username.isNotEmpty && password.isNotEmpty;
}
