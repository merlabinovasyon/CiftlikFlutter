import 'package:get/get.dart';

import '../services/AuthService.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  AuthService authService = AuthService();

  Future<void> signIn(String email, String password) async {
    isLoading(true);
    try {
      await authService.signIn(email, password);
      Get.offAllNamed('/bottomNavigation');  // Giriş başarılıysa BottomNavigation sayfasına yönlendirin
    } catch (e) {
      print('Hata: $e');  // Hataları konsola yazdır
      Get.snackbar('Error', 'Kullanıcı adı veya şifre hatalı');
    } finally {
      isLoading(false);
    }
  }
}
