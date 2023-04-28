import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:recipe_manager/ui/home.dart';
import 'package:recipe_manager/ui/scan/scan.dart';
import 'package:recipe_manager/ui/search.dart';

class NavBarHandler extends StatefulWidget {
  const NavBarHandler({Key? key}) : super(key: key);

  @override
  State<NavBarHandler> createState() => _NavBarHandlerState();
}

class _NavBarHandlerState extends State<NavBarHandler> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ScanScreen(),
    SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        duration: const Duration(seconds: 1),
        transitionBuilder: (Widget child, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: IndexedStack(
            index: _selectedIndex,
            children: _screens),
      ),
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  BottomNavigationBar _bottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onIconTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: "Scan",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Search",
        ),
      ],
    );
  }

  void _onIconTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
