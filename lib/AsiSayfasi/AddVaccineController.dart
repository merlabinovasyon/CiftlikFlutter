import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DatabaseVaccineHelper.dart';

class AddVaccineController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var vaccineName = ''.obs;
  var vaccineDescription = ''.obs;

  void resetForm() {
    vaccineName.value = '';
    vaccineDescription.value = '';
  }

  Future<void> saveVaccineData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> vaccineData = {
        'vaccineName': vaccineName.value,
        'vaccineDescription': vaccineDescription.value,
      };

      await DatabaseVaccineHelper.instance.insertVaccine(vaccineData);
      Future.delayed(const Duration(milliseconds: 600), () {
        Get.back(result: true); // Burada Get.offAllNamed yerine Get.back kullanıyoruz
        Get.snackbar('Başarılı', 'Kayıt başarılı');
      });
    }
  }

}
