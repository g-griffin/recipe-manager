import 'package:flutter/material.dart';
import 'package:recipe_manager/constants/strings.dart';
import 'package:recipe_manager/ui/login.dart';
import 'package:recipe_manager/utils/nav_bar_handler.dart';
import 'package:recipe_manager/utils/routes.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: Routes.routes,
      home: const NavBarHandler(),
    );
  }
}
