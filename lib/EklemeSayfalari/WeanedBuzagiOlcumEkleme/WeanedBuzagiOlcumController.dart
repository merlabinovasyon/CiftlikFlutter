import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/AnimalService/AnimalService.dart';
import 'DatabaseWeanedBuzagiHelper.dart';

class WeanedBuzagiOlcumController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  var selectedTagNo = Rxn<String>();
  var tagno = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBuzagiList();
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void fetchBuzagiList() async {
    tagno.assignAll(await AnimalService.instance.getBuzagiList());
  }

  void resetForm() {
    selectedTagNo.value = null;
    dateController.clear();
    timeController.clear();
    weightController.clear();
  }

  Future<void> saveWeanedBuzagiData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> weanedBuzagiData = {
        'weight': weightController.text,
        'tagNo': selectedTagNo.value,
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
