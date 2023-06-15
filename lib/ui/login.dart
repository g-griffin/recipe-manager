import 'package:flutter/material.dart';
import 'package:recipe_manager/constants/strings.dart';
import 'package:recipe_manager/data/shared_pref/shared_preferences_helper.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/stores/recipe_index_store.dart';
import 'package:recipe_manager/stores/session_store.dart';
import 'package:recipe_manager/utils/nav_bar_handler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SessionStore _session = serviceLocator<SessionStore>();

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
    await _session.login();
    if (serviceLocator<SharedPreferencesHelper>().isLoggedIn) {
      await serviceLocator<RecipeIndexStore>().loadRecipeIndices();
      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const NavBarHandler()));
      }
    }
  }
}
