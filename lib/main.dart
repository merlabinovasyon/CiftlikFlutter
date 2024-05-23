import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Callendar/CalendarPage.dart';
import 'Login/LoginPage.dart';
import 'Login/auth_controller.dart';
import 'Login/login_controller.dart';
import 'Profil/ProfilPage.dart';
import 'iletisim/iletisimPage.dart';
import 'TestPage.dart';
import 'bindings.dart'; // Bindings dosyasını import edin
import 'models/BottomNavigation.dart';

void main() {
  // Controller'ları uygulama başlarken başlatın
  Get.put(AuthController());
  Get.put(LoginController());

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
      initialBinding: AuthBinding(),  // Initial binding burada belirtiliyor
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/bottomNavigation', page: () => BottomNavigation()),
        GetPage(name: '/calendar', page: () => CalendarPage(), binding: CalendarBinding()),
        GetPage(name: '/iletisim', page: () => iletisimPage(), binding: IletisimBinding()), // iletisimPage ve binding'i ekleyin
        GetPage(name: '/profil', page: () => ProfilPage(), binding: ProfilBinding()), // ProfilPage ve binding'i ekleyin
        GetPage(name: '/test', page: () => TestPage()),
        GetPage(name: '/login', page: () => LoginPage()),
      ],
      home: LoginPage(),
    );
  }
}
