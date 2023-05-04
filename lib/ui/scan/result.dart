import 'package:flutter/material.dart';
import 'package:recipe_manager/data/network/dio_client.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/models/index.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    serviceLocator<DioClient>().saveIndex(Index(indexText: text));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Text(text),
        ),
      ),
    );
  }
}
