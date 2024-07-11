import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/KocKatim/KocKatimPage.dart';
import 'AnaSayfa/HomePage.dart';
import 'Calendar/CalendarPage.dart';
import 'Login/LoginPage.dart';
import 'Profil/ProfilPage.dart';
import 'Register/RegisterPage.dart';
import 'bindings.dart';
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
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black54,
          selectionColor: Colors.cyan.shade700, // Seçim rengi (yarı saydam)
          selectionHandleColor: Colors.cyan.shade800, // Seçim imleci rengi
        ),
      ),
      initialBinding: InitialBinding(), // Tüm bağımlılıkları başlatan binding
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/bottomNavigation', page: () => BottomNavigation()),
        GetPage(name: '/calendar', page: () => const CalendarPage(), binding: CalendarBinding()),
        GetPage(name: '/iletisim', page: () => const IletisimPage(), binding: IletisimBinding()),
        GetPage(name: '/profil', page: () => const ProfilPage(), binding: ProfilBinding()),
        GetPage(name: '/test', page: () => const TestPage()),
        GetPage(name: '/login', page: () => LoginPage(), binding: AuthBinding()),
        GetPage(name: '/Home', page: () => HomePage(),binding: HomeBinding()),
        GetPage(name: '/register', page: () => const RegisterPage(),binding: RegisterBinding()),
        GetPage(name: '/kockatim', page: () =>  KocKatimPage(),binding: KocKatimBinding()),

      ],
      home: LoginPage(),
    );
  }
}
