import 'package:flutter/material.dart';
import 'package:tugtugan/features/favorite/presentation/favorite.dart';
import 'package:tugtugan/features/home/presentation/home.dart';
import 'package:tugtugan/features/inbox/presentation/inbox.dart';
import 'package:tugtugan/features/profile/presentation/profile.dart';
import 'package:tugtugan/features/search/presentation/search.dart';

import '../../../commons/widgets/navbar/custom_navbar.dart';

class NavigationGate extends StatefulWidget {
  const NavigationGate({super.key});

  @override
  State<NavigationGate> createState() => _NavigationGateState();
}

class _NavigationGateState extends State<NavigationGate> {
  int _selectedIndex = 0;
  bool _isHolding = false;

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

  void _handleTouch(bool isDown) {
    setState(() {
      _isHolding = isDown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTapDown: (_) => _handleTouch(true),
            onTapUp: (_) => _handleTouch(false),
            onTapCancel: () => _handleTouch(false),
            behavior: HitTestBehavior.translucent,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _screens[_selectedIndex],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedOpacity(
              opacity: _isHolding ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: IgnorePointer(
                ignoring: _isHolding,
                child: CustomBottomNavBar(
                  currentIndex: _selectedIndex,
                  onTap: _onTabSelected,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
