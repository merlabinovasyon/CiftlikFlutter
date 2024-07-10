import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DatabaseKoyunHelper.dart';

class AddSheepController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final dobController = TextEditingController();
  final timeController = TextEditingController();
  final countController = TextEditingController();
  final tagNoController = TextEditingController();
  final govTagNoController = TextEditingController();
  final nameController = TextEditingController();

  var selectedSheep = Rxn<String>();

  final List<String> sheep = ['Merinos', 'Türk Koyunu', 'Çine Çoban Koyunu'];

  @override
  void dispose() {
    dobController.dispose();
    timeController.dispose();
    countController.dispose();
    tagNoController.dispose();
    govTagNoController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void resetForm() {
    selectedSheep.value = null;
    dobController.clear();
    timeController.clear();
    countController.clear();
    tagNoController.clear();
    govTagNoController.clear();
    nameController.clear();
  }

  Future<void> saveSheepData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> sheepData = {
        'weight': countController.text,
        'tagNo': tagNoController.text,
        'govTagNo': govTagNoController.text,
        'species': selectedSheep.value,
        'name': nameController.text,
        'type': countController.text,
        'dob': dobController.text,
        'time': timeController.text,
      };

      await DatabaseKoyunHelper.instance.insertKoyun(sheepData);
      Get.snackbar('Başarılı', 'Kayıt başarılı');
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/bottomNavigation');
      });
    }
  }
}
