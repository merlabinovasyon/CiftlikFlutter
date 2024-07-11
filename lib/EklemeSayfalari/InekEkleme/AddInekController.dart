import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DatabaseInekHelper.dart';

class AddInekController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final dobController = TextEditingController();
  final timeController = TextEditingController();
  final countController = TextEditingController();
  final tagNoController = TextEditingController();
  final govTagNoController = TextEditingController();
  final nameController = TextEditingController();

  var selectedInek = Rxn<String>();

  final List<String> inek = ['Holstein (Siyah Alaca)', 'Jersey', 'Montofon (Brown Swiss)', 'Simmental', 'Doğu Anadolu Kırmızısı', 'Güney Anadolu Kırmızısı', 'Boz Irk', 'Yerli Kara', 'Angus', 'Hereford'];

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
    selectedInek.value = null;
    dobController.clear();
    timeController.clear();
    countController.clear();
    tagNoController.clear();
    govTagNoController.clear();
    nameController.clear();
  }

  Future<void> saveInekData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> inekData = {
        'weight': countController.text,
        'tagNo': tagNoController.text,
        'govTagNo': govTagNoController.text,
        'species': selectedInek.value,
        'name': nameController.text,
        'type': countController.text,
        'dob': dobController.text,
        'time': timeController.text,
      };

      await DatabaseInekHelper.instance.insertInek(inekData);
      Get.snackbar('Başarılı', 'Kayıt başarılı');
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/bottomNavigation');
      });
    }
  }
}
