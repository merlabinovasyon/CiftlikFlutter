import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/AnimalService/AnimalService.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/KocKatim/DatabaseKocKatimHelper.dart';

class KocKatimController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  var selectedKoyun = Rxn<String>();
  var selectedKoc = Rxn<String>();
  var koyun = <Map<String, dynamic>>[].obs;
  var koc = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchKoyunList();
    fetchKocList();
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  void fetchKoyunList() async {
    koyun.assignAll(await AnimalService.instance.getKoyunList());
  }

  void fetchKocList() async {
    koc.assignAll(await AnimalService.instance.getKocList());
  }

  void resetForm() {
    selectedKoyun.value = null;
    selectedKoc.value = null;
    dateController.clear();
    timeController.clear();
  }

  Future<void> saveKocKatimData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> kocKatimData = {
        'koyun': selectedKoyun.value,
        'koc': selectedKoc.value,
        'date': dateController.text,
        'time': timeController.text,
      };

      await DatabaseKocKatimHelper.instance.insertKocKatim(kocKatimData);
      Get.snackbar('Başarılı', 'Eşleme başarılı');
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/bottomNavigation');
      });
    }
  }
}
