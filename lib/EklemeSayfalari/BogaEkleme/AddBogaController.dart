import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DatabaseBogaHelper.dart';

class AddBogaController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final dobController = TextEditingController();
  final timeController = TextEditingController();
  final countController = TextEditingController();
  final tagNoController = TextEditingController();
  final govTagNoController = TextEditingController();
  final nameController = TextEditingController();

  var selectedBoga = Rxn<String>();

  final List<String> boga = ['Holstein (Siyah Alaca)', 'Jersey', 'Montofon (Brown Swiss)', 'Simmental', 'Doğu Anadolu Kırmızısı', 'Güney Anadolu Kırmızısı', 'Boz Irk', 'Yerli Kara', 'Angus', 'Hereford'];

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
    selectedBoga.value = null;
    dobController.clear();
    timeController.clear();
    countController.clear();
    tagNoController.clear();
    govTagNoController.clear();
    nameController.clear();
  }

  Future<void> saveBogaData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> bogaData = {
        'weight': countController.text,
        'tagNo': tagNoController.text,
        'govTagNo': govTagNoController.text,
        'species': selectedBoga.value,
        'name': nameController.text,
        'type': countController.text,
        'dob': dobController.text,
        'time': timeController.text,
      };

      await DatabaseBogaHelper.instance.insertBoga(bogaData);
      Get.snackbar('Başarılı', 'Kayıt başarılı');
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/bottomNavigation');
      });
    }
  }
}
