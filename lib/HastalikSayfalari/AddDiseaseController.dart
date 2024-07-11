import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DatabaseDiseaseHelper.dart';

class AddDiseaseController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final diseaseNameController = TextEditingController();
  final diseaseDescriptionController = TextEditingController();

  @override
  void dispose() {
    diseaseNameController.dispose();
    diseaseDescriptionController.dispose();
    super.dispose();
  }

  void resetForm() {
    diseaseNameController.clear();
    diseaseDescriptionController.clear();
  }

  Future<void> saveDiseaseData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> diseaseData = {
        'diseaseName': diseaseNameController.text,
        'diseaseDescription': diseaseDescriptionController.text,
      };

      await DatabaseDiseaseHelper.instance.insertDisease(diseaseData);
      Future.delayed(const Duration(milliseconds: 600), () {
        Get.back(result: true); // Burada Get.offAllNamed yerine Get.back kullanıyoruz
        Get.snackbar('Başarılı', 'Kayıt başarılı');
      });
    }
  }

}
