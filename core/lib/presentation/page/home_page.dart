import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../../style/colors.dart';
import '../screen/history_screen.dart';
import '../screen/home_screen.dart';
import '../screen/settings_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    const HomeScreen(),
    const HistoryScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        onButtonPressed: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        barItems: [
          BarItem(title: 'Home', icon: Icons.home_filled),
          BarItem(title: 'History', icon: Icons.list_alt),
          BarItem(title: 'Settings', icon: Icons.settings),
        ],
        selectedIndex: _currentIndex,
        activeColor: firstBlue,
      ),
    );
  }
}
