import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'setting_screen.dart';

class TebsScreen extends StatefulWidget {
  const TebsScreen({super.key});

  @override
  State<TebsScreen> createState() => _TebsScreenState();
}

class _TebsScreenState extends State<TebsScreen> {
  List<Map<String, dynamic>> pages = [];

  @override
  void initState() {
    setState(() {
      pages = [
        {'page': const HomeScreen(), 'title': 'Home'},
        {'page': const SettingScreen(), 'title': 'Setting'}
      ];
    });
    super.initState();
  }

  int selectedIndex = 0;

  void selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
