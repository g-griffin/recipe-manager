import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:recipe_manager/constants/strings.dart';
import 'package:recipe_manager/data/network/constants/endpoints.dart';
import 'package:recipe_manager/data/sharedpref/shared_preferences_helper.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/stores/recipe_index_store.dart';
import 'package:recipe_manager/ui/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _indexStore = serviceLocator<RecipeIndexStore>();

  final appAuth = const FlutterAppAuth();

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
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          _buildLogoutButton(),
          Flexible(fit: FlexFit.loose, child: _buildIndexList()),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      height: 50,
      width: 250,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(20)),
      child: TextButton(
        onPressed: () {
          _logoutAction();
        },
        child: const Text(
          Strings.logoutButtonText,
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
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

  Future<void> _logoutAction() async {
    final idToken = await serviceLocator<SharedPreferencesHelper>().idToken;
    await appAuth.endSession(
      EndSessionRequest(
        idTokenHint: idToken,
        postLogoutRedirectUrl: Endpoints.redirectUrl,
        issuer: Endpoints.issuerUrl,
        discoveryUrl: Endpoints.discoveryUrl,
        allowInsecureConnections: true,
      ),
    );

    await serviceLocator<SharedPreferencesHelper>().saveIsLoggedIn(false);
    await serviceLocator<SharedPreferencesHelper>().removeAuthToken();
    await serviceLocator<SharedPreferencesHelper>().removeIdToken();

    if (mounted) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }
}
