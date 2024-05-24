import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/services/AuthService.dart';
import 'package:merlabciftlikyonetim/services/DatabaseController.dart';
import 'package:merlabciftlikyonetim/services/DatabaseService.dart';
import 'Login/auth_controller.dart';
import 'Login/login_controller.dart';
import 'Callendar/CalendarController.dart';
import 'Profil/profil_controller.dart';
import 'iletisim/iletisim_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalendarController>(() => CalendarController());
  }
}

class IletisimBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IletisimController>(() => IletisimController());
  }
}

class ProfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilController>(() => ProfilController());
  }
}

class DatabaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatabaseService>(() => DatabaseService());
    Get.lazyPut<DatabaseController>(() => DatabaseController());
  }
}
