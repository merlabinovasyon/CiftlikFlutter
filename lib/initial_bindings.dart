import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/services/AuthService.dart';
import 'package:merlabciftlikyonetim/services/DatabaseController.dart';
import 'package:merlabciftlikyonetim/services/DatabaseService.dart';
import 'Drawer/DrawerController.dart';
import 'Login/auth_controller.dart';
import 'Login/login_controller.dart';
import 'Callendar/CalendarController.dart';
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
  }
}
