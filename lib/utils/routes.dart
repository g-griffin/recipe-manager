import 'package:flutter/cupertino.dart';

import '../ui/home.dart';

class Routes {
  Routes._();

  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomeScreen()
  };
}