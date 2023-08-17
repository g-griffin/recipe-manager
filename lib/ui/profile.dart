import 'package:flutter/material.dart';
import 'package:recipe_manager/constants/strings.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/stores/session_store.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final SessionStore _sessionStore = serviceLocator<SessionStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(Strings.profile),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight - // AppBar height
              kBottomNavigationBarHeight, // NavBar height
          child: Center(
            child: _buildProfileDetails(),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          child: Image.asset(Strings.defaultAvatarPath),
          // TODO: user avatar
        ),
        const SizedBox(height: 30),
        Text(
            'Name: ${_sessionStore.firstName ?? Strings.defaultFirstName} ${_sessionStore.lastName ?? Strings.defaultLastName}'),
        const SizedBox(height: 30),
        Text('Email: ${_sessionStore.email ?? Strings.defaultEmail}'),
      ],
    );
  }
}
