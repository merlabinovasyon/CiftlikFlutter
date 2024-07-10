import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DatabaseKocHelper.dart';

class AddKocController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final dobController = TextEditingController();
  final timeController = TextEditingController();
  final countController = TextEditingController();
  final tagNoController = TextEditingController();
  final govTagNoController = TextEditingController();
  final nameController = TextEditingController();

  var selectedKoc = Rxn<String>();

  final List<String> koc = ['Merinos', 'Türk Koyunu', 'Çine Çoban Koyunu'];

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
    selectedKoc.value = null;
    dobController.clear();
    timeController.clear();
    countController.clear();
    tagNoController.clear();
    govTagNoController.clear();
    nameController.clear();
  }

  Future<void> saveKocData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> kocData = {
        'weight': countController.text,
        'tagNo': tagNoController.text,
        'govTagNo': govTagNoController.text,
        'species': selectedKoc.value,
        'name': nameController.text,
        'type': countController.text,
        'dob': dobController.text,
        'time': timeController.text,
      };

      await DatabaseKocHelper.instance.insertKoc(kocData);
      Get.snackbar('Başarılı', 'Kayıt başarılı');
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/bottomNavigation');
      });
    }
  }
}
