import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/KocKatim/KocKatimController.dart';
import 'package:merlabciftlikyonetim/HayvanGebelikKontrolSayfasi/PregnancyCheckController.dart';
import 'package:merlabciftlikyonetim/HayvanGrupSayfasi/AnimalGroupController.dart';
import 'package:merlabciftlikyonetim/HayvanKonumSayfasi/AnimalLocationController.dart';
import 'package:merlabciftlikyonetim/HayvanMuayeneSayfasi/AnimalExaminationController.dart';
import 'package:merlabciftlikyonetim/Register/RegisterController.dart';
import 'package:merlabciftlikyonetim/services/AuthService.dart';
import 'package:merlabciftlikyonetim/services/DatabaseController.dart';
import 'package:merlabciftlikyonetim/services/DatabaseService.dart';
import 'AnaSayfa/HomeController.dart';
import 'Drawer/DrawerController.dart';
import 'HayvanAsiSayfasi/AnimalVaccineController.dart';
import 'HayvanNotSayfasi/AnimalNoteController.dart';
import 'Login/AuthController.dart';
import 'Login/LoginController.dart';
import 'Calendar/CalendarController.dart';
import 'Profil/profil_controller.dart';
import 'iletisim/iletisim_controller.dart';


class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<DatabaseService>(() => DatabaseService());
    Get.lazyPut<DatabaseController>(() => DatabaseController());
    Get.lazyPut<CalendarController>(() => CalendarController());
    Get.lazyPut<IletisimController>(() => IletisimController());
    Get.lazyPut<ProfilController>(() => ProfilController());
    Get.lazyPut<DrawerMenuController>(() => DrawerMenuController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<KocKatimController>(() => KocKatimController());
    Get.put(AnimalVaccineController(), permanent: true);
    Get.put(AnimalExaminationController(), permanent: true);
    Get.put(AnimalNoteController(), permanent: true);
    Get.put(AnimalGroupController(), permanent: true);
    Get.put(PregnancyCheckController(), permanent: true);
    Get.put(AnimalLocationController(), permanent: true);



  }
}
