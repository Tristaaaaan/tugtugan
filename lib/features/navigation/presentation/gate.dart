import 'package:flutter/material.dart';
import 'package:tugtugan/features/favorite/presentation/favorite.dart';
import 'package:tugtugan/features/home/presentation/home.dart';
import 'package:tugtugan/features/inbox/presentation/inbox.dart';
import 'package:tugtugan/features/profile/presentation/profile.dart';
import 'package:tugtugan/features/search/presentation/search.dart';

class NavigationGate extends StatefulWidget {
  const NavigationGate({super.key});

  @override
  State<NavigationGate> createState() => _NavigationGateState();
}

class _NavigationGateState extends State<NavigationGate> {
  int _selectedIndex = 0;

  // Define your screens here
  final List<Widget> _screens = const [
    HomePage(),
    FindStudioPage(),
    FavoriteStudioPage(),
    InboxPage(),
    ProfilePage(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}
