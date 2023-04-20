import 'package:flutter/cupertino.dart';
import 'package:recipe_manager/ui/search.dart';
import 'package:recipe_manager/ui/home.dart';
import 'package:recipe_manager/ui/login.dart';
import 'package:recipe_manager/ui/scan.dart';

class Routes {
  Routes._();

  static const String home = '/home';
  static const String login = '/login';
  static const String scan = '/scan';
  static const String search = '/search';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomeScreen(),
    login: (BuildContext context) => LoginScreen(),
    scan: (BuildContext context) => ScanScreen(),
    search: (BuildContext context) => SearchScreen()
  };
}
