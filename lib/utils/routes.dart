import 'package:flutter/cupertino.dart';
import 'package:recipe_manager/ui/home.dart';
import 'package:recipe_manager/ui/login.dart';



class Routes {
  Routes._();

  static const String home = '/home';
  static const String login = '/login';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomeScreen(),
    login: (BuildContext context) => LoginScreen()
  };
}