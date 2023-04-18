import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  return runZonedGuarded(() async {
    runApp(MyApp());
  }, (error, stack) {
    print(stack);
    print(error);
  });
}
