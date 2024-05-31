import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:merlabciftlikyonetim/services/AuthService.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final authService = AuthService();

  var obscureText = true.obs;
  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>(); // formKey tanımı eklendi

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.onClose();
  }

  Future<void> register() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        usernameController.text.isEmpty) {
      Get.snackbar('Hata', 'Tüm Alanları Doldurmanız Gerekir');
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      await authService.registerUser(
        emailController.text,
        passwordController.text,
        usernameController.text,
      );
      Get.snackbar('Başarılı', 'Kayıt başarılı');
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/login'); // Giriş sayfasına yönlendirme
      });
    } catch (e) {
      Get.snackbar('Hata', 'Kayıt başarısız: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }
}
