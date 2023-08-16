import 'package:flutter/material.dart';
import 'package:recipe_manager/constants/strings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String dummyName = 'user1';
  final String dummyEmail = 'user1@email.de';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 200, child: Image.asset(Strings.defaultAvatarPath)),
                const SizedBox(height: 30),
                Text('Username: $dummyName'),
                const SizedBox(height: 30),
                Text('Email: $dummyEmail'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
