import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/AnimalService/AnimalService.dart';
import 'DatabaseWeanedKuzuHelper.dart';

class WeanedKuzuOlcumController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  var selectedTagNo = Rxn<String>();
  var tagno = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchKuzuList();
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void fetchKuzuList() async {
    tagno.assignAll(await AnimalService.instance.getKuzuList());
  }

  void resetForm() {
    selectedTagNo.value = null;
    dateController.clear();
    timeController.clear();
    weightController.clear();
  }

  Future<void> saveWeanedKuzuData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> weanedKuzuData = {
        'weight': weightController.text,
        'tagNo': selectedTagNo.value,
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
