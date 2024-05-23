import 'package:get/get.dart';
import 'Callendar/CalendarController.dart';
import 'Login/auth_controller.dart';
import 'Login/login_controller.dart';
import 'Profil/profil_controller.dart';
import 'iletisim/iletisim_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
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
