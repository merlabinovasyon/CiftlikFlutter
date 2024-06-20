import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/BogaEkleme/AddBogaPage.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/BuzagiEkleme/AddBirthBuzagiPage.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/InekEkleme/AddInekPage.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/InekSutOlcumEkleme/InekSutOlcumPage.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/KocEkleme/AddKocPage.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/KocKatim/KocKatimPage.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/KoyunEkleme/AddSheepPage.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/KoyunSutOlcumEkleme/KoyunSutOlcumPage.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/KuzuEkleme/AddBirthKuzuPage.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/WeanedBuzagiOlcumEkleme/WeanedBuzagiOlcumPage.dart';
import 'package:merlabciftlikyonetim/GelirGiderHesaplama/FinancePage.dart';
import 'package:merlabciftlikyonetim/HastalikSayfalari/DiseasePage.dart';
import 'AnaSayfa/HomePage.dart';
import 'Calendar/CalendarPage.dart';
import 'EklemeSayfalari/WeanedKuzuOlcumEkleme/WeanedKuzuOlcumPage.dart';
import 'Login/LoginPage.dart';
import 'Profil/ProfilPage.dart';
import 'Register/RegisterPage.dart';
import 'bindings.dart';
import 'iletisim/iletisimPage.dart';
import 'TestPage.dart';
import 'models/BottomNavigation.dart';
import 'initial_bindings.dart'; // Yeni oluşturduğumuz InitialBinding dosyasını import edin
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Bu satırı ekleyin
import 'package:flutter/services.dart'; // SystemChrome kullanımı için import edin

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr', null);

  // Navigation bar rengini ayarlamak ve dikey moda zorlamak için SystemChrome kullanıyoruz
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // Burada istediğiniz rengi kullanabilirsiniz
    systemNavigationBarIconBrightness: Brightness.light, // Simge rengini belirleyin (light/dark)
  ));

  // Yalnızca dikey modda çalışmasını sağlamak
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // İngilizce
        const Locale('tr', 'TR'), // Türkçe
      ],
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/bottomNavigation', page: () => BottomNavigation()),
        GetPage(name: '/calendar', page: () => const CalendarPage(), binding: CalendarBinding()),
        GetPage(name: '/iletisim', page: () => const IletisimPage(), binding: IletisimBinding()),
        GetPage(name: '/profil', page: () => const ProfilPage(), binding: ProfilBinding()),
        GetPage(name: '/test', page: () => const TestPage()),
        GetPage(name: '/login', page: () => LoginPage(), binding: AuthBinding()),
        GetPage(name: '/Home', page: () => HomePage(), binding: HomeBinding()),
        GetPage(name: '/register', page: () => const RegisterPage(), binding: RegisterBinding()),
        GetPage(name: '/kockatim', page: () => KocKatimPage(), binding: KocKatimBinding()),
        GetPage(name: '/addBirthKuzuPage', page: () => AddBirthKuzuPage()),
        GetPage(name: '/addBirthBuzagiPage', page: () => AddBirthBuzagiPage()),
        GetPage(name: '/addSheepPage', page: () => AddSheepPage()),
        GetPage(name: '/addKocPage', page: () => AddKocPage()),
        GetPage(name: '/addInekPage', page: () => AddInekPage()),
        GetPage(name: '/addBogaPage', page: () => AddBogaPage()),
        GetPage(name: '/koyunSutOlcumPage', page: () => KoyunSutOlcumPage()),
        GetPage(name: '/inekSutOlcumPage', page: () => InekSutOlcumPage()),
        GetPage(name: '/weanedKuzuOlcumPage', page: () => WeanedKuzuOlcumPage()),
        GetPage(name: '/weanedBuzagiOlcumPage', page: () => WeanedBuzagiOlcumPage()),
        GetPage(name: '/diseasePage', page: () => DiseasePage()),
        GetPage(name: '/financePage', page: () => FinancePage()),
      ],
      home: LoginPage(),
    );
  }
}
