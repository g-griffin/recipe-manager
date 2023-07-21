import 'package:flutter/material.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/stores/session_store.dart';
import 'package:recipe_manager/ui/login.dart';
import 'package:recipe_manager/utils/navigator_key.dart';

Future<void> expiredSessionDialog() async {
  return showDialog<void>(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Session Expired', textAlign: TextAlign.center),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          actionsOverflowButtonSpacing: 20,
          actions: [
            ElevatedButton(
                onPressed: () async {
                  await serviceLocator<SessionStore>().logout();
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  }
                },
                child: const Text('Ok')),
          ],
          content:
              const Text('Please log in again.', textAlign: TextAlign.center),
        );
      });
}
