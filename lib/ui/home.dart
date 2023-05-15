import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recipe_manager/data/sharedpref/shared_preferences_helper.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/stores/recipe_index_store.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _indexStore = serviceLocator<RecipeIndexStore>();

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await _indexStore.loadRecipeIndices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Hello ${serviceLocator<SharedPreferencesHelper>().username}"),
      ),
      body: _buildIndexList(),
    );
  }

  Widget _buildIndexList() {
    if (_indexStore.recipeIndices.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 50.0),
        child: Center(
          child: Text(
            'No recipes were found.\n\nTap \'Scan\' to add some now.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return Observer(
        builder: (_) => ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _indexStore.recipeIndices.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.5),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(_indexStore.recipeIndices[index].recipeIndexText),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
