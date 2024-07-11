import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DatabaseKocKatimHelper.dart';

class KocKatimController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  var selectedKoyun = Rxn<String>();
  var selectedKoc = Rxn<String>();
  var koyun = <String>[].obs;
  var koc = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Example data; replace with actual data retrieval
    koyun.assignAll(['Koyun 1', 'Koyun 2', 'Koyun 3']);
    koc.assignAll(['Koç 1', 'Koç 2', 'Koç 3']);
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  void resetForm() {
    selectedKoyun.value = null;
    selectedKoc.value = null;
    dateController.clear();
    timeController.clear();
  }

  Future<void> saveKocKatimData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> kocKatimData = {
        'koyun': selectedKoyun.value,
        'koc': selectedKoc.value,
        'date': dateController.text,
        'time': timeController.text,
      };

      await DatabaseKocKatimHelper.instance.insertKocKatim(kocKatimData);
      Get.snackbar('Başarılı', 'Eşleme başarılı');
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/bottomNavigation');
      });
    }
  }
}
