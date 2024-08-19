import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DatabaseExaminationHelper.dart';

class AddExaminationController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var examinationName = ''.obs;
  var examinationDescription = ''.obs;

  void resetForm() {
    examinationName.value = '';
    examinationDescription.value = '';
  }

  Future<void> saveExaminationData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> examinationData = {
        'examinationName': examinationName.value,
        'examinationDescription': examinationDescription.value,
      };

      await DatabaseExaminationHelper.instance.insertExamination(examinationData);
      Future.delayed(const Duration(milliseconds: 600), () {
        Get.back(result: true); // Burada Get.offAllNamed yerine Get.back kullanıyoruz
        Get.snackbar('Başarılı', 'Kayıt başarılı');
      });
    }
  }
}
