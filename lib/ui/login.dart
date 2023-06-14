import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:recipe_manager/constants/strings.dart';
import 'package:recipe_manager/data/network/constants/endpoints.dart';
import 'package:recipe_manager/data/sharedpref/shared_preferences_helper.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/stores/recipe_index_store.dart';
import 'package:recipe_manager/utils/nav_bar_handler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final appAuth = const FlutterAppAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(Strings.login),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: Image.asset(Strings.loginPageLogoPath),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  _loginAction();
                },
                child: const Text(
                  Strings.loginButtonText,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () {
                //TODO user registration
              },
              child: const Text(
                style: TextStyle(color: Colors.grey),
                Strings.createAccountButtonText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loginAction() async {
    try {
      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          Endpoints.keycloakClientId,
          Endpoints.redirectUrl,
          discoveryUrl: Endpoints.discoveryUrl,
          scopes: ['email', 'profile', 'openid'], // Add scope=openid to get idToken from Keycloak
          allowInsecureConnections: true,
        ),
      );
      var authToken = result?.accessToken;
      var idToken = result?.idToken;
      if (result != null) {
        await serviceLocator<SharedPreferencesHelper>()
            .saveAuthToken(authToken!);
        await serviceLocator<SharedPreferencesHelper>().saveIdToken(idToken!);
        await serviceLocator<SharedPreferencesHelper>().saveIsLoggedIn(true);

        if (serviceLocator<SharedPreferencesHelper>().isLoggedIn) {
          await serviceLocator<RecipeIndexStore>().loadRecipeIndices();
          if (mounted) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const NavBarHandler()));
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
