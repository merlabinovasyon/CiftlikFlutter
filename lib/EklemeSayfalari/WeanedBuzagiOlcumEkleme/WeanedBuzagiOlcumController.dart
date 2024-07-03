import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DatabaseWeanedBuzagiHelper.dart';

class WeanedBuzagiOlcumController extends GetxController {
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
      'Buzağı 1',
      'Buzağı 2',
      'Buzağı 3',
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

  Future<void> saveWeanedBuzagiData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> weanedBuzagiData = {
        'weight': weightController.text,
        'type': selectedType.value,
        'date': dateController.text,
        'time': timeController.text,
      };

      await DatabaseWeanedBuzagiHelper.instance.insertWeanedBuzagi(weanedBuzagiData);
      Get.snackbar('Başarılı', 'Kayıt başarılı');
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/bottomNavigation');
      });
    }
  }
}
