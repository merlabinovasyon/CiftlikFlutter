import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';
import 'package:merlabciftlikyonetim/AnaSayfa/HomePage.dart';
import 'package:merlabciftlikyonetim/iletisim/iletisimPage.dart';
import 'package:merlabciftlikyonetim/Profil/ProfilPage.dart';
import '../Calendar/CalendarPage.dart';
import 'BottomNavigationController.dart';

class BottomNavigation extends StatelessWidget {
  final BottomNavigationController bottomNavController = Get.put(BottomNavigationController());

  final List<Widget> _pages = [
    HomePage(),
    const CalendarPage(),
    const IletisimPage(),
    const ProfilPage(),
  ];

  BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageTransitionSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
          child: _pages[bottomNavController.selectedIndex.value],
        );
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'AnaSayfa', backgroundColor: Colors.cyan),
          BottomNavigationBarItem(icon: Icon(Icons.event_note), label: 'Ajanda', backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.contact_support), label: 'Iletişim', backgroundColor: Colors.deepPurpleAccent),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil', backgroundColor: Colors.cyan),
        ],
        currentIndex: bottomNavController.selectedIndex.value,
        onTap: bottomNavController.onItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
      )),
    );
  }
}
