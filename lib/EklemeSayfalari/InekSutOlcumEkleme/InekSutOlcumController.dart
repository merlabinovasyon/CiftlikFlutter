import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/AnimalService/AnimalService.dart';
import 'DatabaseSutOlcumInekHelper.dart';

class InekSutOlcumController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  var selectedType = Rxn<String>();
  var types = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchInekList();
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void fetchInekList() async {
    types.assignAll(await AnimalService.instance.getInekList());
  }

  void resetForm() {
    selectedType.value = null;
    dateController.clear();
    timeController.clear();
    weightController.clear();
  }

  Future<void> saveSutOlcumInekData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> sutOlcumInekData = {
        'weight': weightController.text,
        'type': selectedType.value,
        'date': dateController.text,
        'time': timeController.text,
      };

      await DatabaseSutOlcumInekHelper.instance.insertSutOlcumInek(sutOlcumInekData);
      Get.snackbar('Başarılı', 'Kayıt başarılı');
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/bottomNavigation');
      });
    }
  }
}
