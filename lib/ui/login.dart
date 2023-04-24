import 'package:flutter/material.dart';
import 'package:recipe_manager/constants/strings.dart';
import 'package:recipe_manager/stores/login_form_store.dart';
import 'package:recipe_manager/utils/nav_bar_handler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _loginFormStore = LoginFormStore();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: Strings.usernameFieldText,
                ),
                onChanged: (value) {
                  _loginFormStore.setUsername(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: Strings.passwordFieldText),
                onChanged: (value) {
                  _loginFormStore.setPassword(value);
                },
              ),
            ),
            TextButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: const Text(
                Strings.forgotPasswordButtonText,
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  if (_loginFormStore.canLogin) {
                    _loginFormStore.login();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const NavBarHandler()));
                    //TODO AUTHENTICATION
                  }
                },
                child: const Text(
                  Strings.loginButtonText,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(height: 130),
            TextButton(
              onPressed: () {
                //TODO CREATE ACCOUNT PAGE
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
}
