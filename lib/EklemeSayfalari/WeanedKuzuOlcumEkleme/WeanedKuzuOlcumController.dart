import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DatabaseWeanedKuzuHelper.dart';

class WeanedKuzuOlcumController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  var selectedType = Rxn<String>();
  var types = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Seçenekleri buraya ekliyoruz
    types.assignAll([
      'Kuzu 1',
      'Kuzu 2',
      'Kuzu 3',
    ]);
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void resetForm() {
    selectedType.value = null;
    dateController.clear();
    timeController.clear();
    weightController.clear();
  }

  Future<void> saveWeanedKuzuData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> weanedKuzuData = {
        'weight': weightController.text,
        'type': selectedType.value,
        'date': dateController.text,
        'time': timeController.text,
      };

      await DatabaseWeanedKuzuHelper.instance.insertWeanedKuzu(weanedKuzuData);
      Get.snackbar('Başarılı', 'Kayıt başarılı');
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/bottomNavigation');
      });
    }
  }
}
