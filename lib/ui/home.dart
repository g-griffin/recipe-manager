import 'package:flutter/material.dart';
import 'package:recipe_manager/data/network/dio_client.dart';
import 'package:recipe_manager/data/sharedpref/shared_preferences_helper.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/models/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Hello ${serviceLocator<SharedPreferencesHelper>().username}"),
        ),
        body: FutureBuilder<List<Index>>(
          future: serviceLocator<DioClient>().getIndices(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.5),
                    child: Card(
                      elevation: 10,
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(snapshot.data![index].indexText)),
                    ),
                  );
                },
              );
            } else {
              return const LinearProgressIndicator();
            }
          },
        ));
  }
}
