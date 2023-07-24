import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recipe_manager/data/shared_pref/shared_preferences_helper.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/stores/recipe_index_store.dart';
import 'package:recipe_manager/stores/session_store.dart';
import 'package:recipe_manager/ui/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecipeIndexStore _indexStore = serviceLocator<RecipeIndexStore>();
  final SessionStore _session = serviceLocator<SessionStore>();

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
            Text('Hello ${serviceLocator<SharedPreferencesHelper>().username}'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                _logoutAction();
              },
              child: const Icon(Icons.power_settings_new, size: 26.0),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.blue,
        strokeWidth: 4.0,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          await Future<void>.delayed(const Duration(seconds: 1));
          await serviceLocator<RecipeIndexStore>().loadRecipeIndices();
        },
        child: _buildIndexList(),
      ),
    );
  }

  Widget _buildIndexList() {
    if (_indexStore.recipeIndices.isEmpty) {
      return const Center(
        child: SingleChildScrollView(
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
          physics: const AlwaysScrollableScrollPhysics(),
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

  Future<void> _logoutAction() async {
    await _session.logout();
    if (mounted) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }
}
