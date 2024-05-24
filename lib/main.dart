import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AnaSayfa/HomePage.dart';
import 'Callendar/CalendarPage.dart';
import 'Login/LoginPage.dart';
import 'Profil/ProfilPage.dart';
import 'iletisim/iletisimPage.dart';
import 'TestPage.dart';
import 'models/BottomNavigation.dart';
import 'initial_bindings.dart'; // Yeni oluşturduğumuz InitialBinding dosyasını import edin

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialBinding: InitialBinding(), // Tüm bağımlılıkları başlatan binding
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/bottomNavigation', page: () => BottomNavigation()),
        GetPage(name: '/calendar', page: () => CalendarPage()),
        GetPage(name: '/iletisim', page: () => iletisimPage()),
        GetPage(name: '/profil', page: () => ProfilPage()),
        GetPage(name: '/test', page: () => TestPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/Home', page: () => HomePage()),
      ],
      home: LoginPage(),
    );
  }
}
