import 'package:flutter/material.dart';
import 'package:recipe_manager/constants/strings.dart';
import 'package:recipe_manager/data/shared_pref/shared_preferences_helper.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/ui/login.dart';
import 'package:recipe_manager/utils/nav_bar_handler.dart';
import 'package:recipe_manager/utils/navigator_key.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(primarySwatch: Colors.blue),
      navigatorKey: navigatorKey,
      home: serviceLocator<SharedPreferencesHelper>().isLoggedIn
          ? const NavBarHandler()
          : const LoginScreen(),
    );
  }
}
