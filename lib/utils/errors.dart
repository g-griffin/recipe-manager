import 'package:flutter/material.dart';

void logError(String code, String? message) {
  print('Error: $code${message == null ? '' : '\nError Message: $message'}');
}

void showInSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message, textAlign: TextAlign.center,)));
}