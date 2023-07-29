import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recipe_manager/constants/strings.dart';
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
    await _indexStore.loadRecipeIndices();  // Called after successful login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.appBarTitle(
            serviceLocator<SharedPreferencesHelper>().username)),
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
          await _indexStore.loadRecipeIndices();
        },
        child: _buildIndexList(),
      ),
    );
  }

  Widget _buildIndexList() {
    if (_indexStore.recipeIndices.isEmpty) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight - // AppBar height
              kBottomNavigationBarHeight, // NavBar height
          child: const Center(
            child: Text(Strings.emptyRecipeIndex, textAlign: TextAlign.center),
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
