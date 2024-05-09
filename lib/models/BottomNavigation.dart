import 'package:flutter/material.dart';
import 'package:animations/animations.dart'; // Import animations package
import 'package:merlabciftlikyonetim/HomePage.dart';
import 'package:merlabciftlikyonetim/CalendarPage.dart';
import 'package:merlabciftlikyonetim/TestPage.dart';
import 'package:merlabciftlikyonetim/iletisimPage.dart';
import 'package:merlabciftlikyonetim/profilPage.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CalendarPage(),
    iletisimPage(),
    profilPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal, // For train-hopping-like animation
            child: child,
          );
        },
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'AnaSayfa', backgroundColor: Colors.cyan),
          BottomNavigationBarItem(icon: Icon(Icons.event_note), label: 'Ajanda', backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.contact_support), label: 'Iletişim', backgroundColor: Colors.deepPurpleAccent),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil', backgroundColor: Colors.cyan),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
