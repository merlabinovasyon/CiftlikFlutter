import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// Sayfa ve diğer importlar
import 'AnaSayfa/HomePage.dart';
import 'AsiSayfasi/VaccinePage.dart';
import 'BildirimSayfasi/NotificationPage.dart';
import 'Calendar/CalendarPage.dart';
import 'EklemeSayfalari/BogaEkleme/AddBogaPage.dart';
import 'EklemeSayfalari/BuzagiEkleme/AddBirthBuzagiPage.dart';
import 'EklemeSayfalari/InekEkleme/AddInekPage.dart';
import 'EklemeSayfalari/InekSutOlcumEkleme/InekSutOlcumPage.dart';
import 'EklemeSayfalari/KocEkleme/AddKocPage.dart';
import 'EklemeSayfalari/KocKatim/KocKatimPage.dart';
import 'EklemeSayfalari/KoyunEkleme/AddSheepPage.dart';
import 'EklemeSayfalari/KoyunSutOlcumEkleme/KoyunSutOlcumPage.dart';
import 'EklemeSayfalari/KuzuEkleme/AddBirthKuzuPage.dart';
import 'EklemeSayfalari/WeanedBuzagiOlcumEkleme/WeanedBuzagiOlcumPage.dart';
import 'EklemeSayfalari/WeanedKuzuOlcumEkleme/WeanedKuzuOlcumPage.dart';
import 'GelirGiderHesaplama/FinancePage.dart';
import 'HastalikSayfalari/DiseasePage.dart';
import 'Login/LoginPage.dart';
import 'Profil/ProfilPage.dart';
import 'Register/RegisterPage.dart';
import 'bindings.dart';
import 'iletisim/iletisimPage.dart';
import 'TestPage.dart';
import 'models/BottomNavigation.dart';
import 'initial_bindings.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr', null);
  tz.initializeTimeZones();

  // Bildirimler için FlutterLocalNotificationsPlugin başlatılması
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Navigation bar rengini ayarlamak ve dikey moda zorlamak için SystemChrome kullanıyoruz
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
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
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black54,
          selectionColor: Colors.cyan.shade700,
          selectionHandleColor: Colors.cyan.shade800,
        ),
      ),
      initialBinding: InitialBinding(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('tr', 'TR'),
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
        GetPage(name: '/vaccinePage', page: () => VaccinePage()),
        GetPage(name: '/notificationPage', page: () => NotificationPage()),
      ],
      locale: const Locale('tr', 'TR'), // Varsayılan dili ayarlayın
      home: LoginPage(),
    );
  }
}
