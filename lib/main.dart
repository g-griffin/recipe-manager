import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/ui/app.dart';

Future<void> main() async {
  return runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupServiceLocator();
    runApp(MyApp());
  }, (error, stack) {
    print(stack);
    print(error);
  });
}
