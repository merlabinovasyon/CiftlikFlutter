import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/Register/RegisterController.dart';
import 'package:merlabciftlikyonetim/services/AuthService.dart';
import 'package:merlabciftlikyonetim/services/DatabaseController.dart';
import 'package:merlabciftlikyonetim/services/DatabaseService.dart';
import 'AnaSayfa/HomeController.dart';
import 'KocKatim/AddKocKatimController.dart';
import 'Login/AuthController.dart';
import 'Login/LoginController.dart';
import 'Calendar/CalendarController.dart';
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
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());

  }
}
class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
class KocKatimBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddKocKatimController>(() => AddKocKatimController());
  }
}

