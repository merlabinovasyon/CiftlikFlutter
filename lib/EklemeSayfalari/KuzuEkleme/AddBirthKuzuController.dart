import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DatabaseKuzuHelper.dart';

class AddBirthKuzuController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final dobController = TextEditingController();
  final timeController = TextEditingController();
  final countController = TextEditingController();
  final count1Controller = TextEditingController();
  final count2Controller = TextEditingController();
  final tagNoController = TextEditingController();
  final govTagNoController = TextEditingController();
  final nameController = TextEditingController();

  var selectedAnimal = Rxn<String>();
  var selectedKoc = Rxn<String>();
  var selectedLamb = Rxn<String>();
  var selected1Lamb = Rxn<String>();
  var selected2Lamb = Rxn<String>();
  var selectedGender1 = Rxn<String>();
  var selectedGender2 = Rxn<String>();
  var selectedGender3 = Rxn<String>();
  var isTwin = false.obs;
  var isTriplet = false.obs;

  final List<String> animals = ['Hayvan 1', 'Hayvan 2', 'Hayvan 3'];
  final List<String> koc = ['Koç 1', 'Koç 2', 'Koç 3'];
  final List<String> lamb = ['Merinos', 'Türk Koyunu', 'Çine Çoban Koyunu'];
  final List<String> lamb1 = ['Merinos', 'Türk Koyunu', 'Çine Çoban Koyunu'];
  final List<String> genders = ['Erkek', 'Dişi'];

  @override
  void dispose() {
    dobController.dispose();
    timeController.dispose();
    countController.dispose();
    count1Controller.dispose();
    count2Controller.dispose();
    tagNoController.dispose();
    govTagNoController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void resetTwinValues() {
    selected1Lamb.value = null;
    selectedGender2.value = null;
    count1Controller.clear();
    resetTripletValues();
  }

  void resetTripletValues() {
    selected2Lamb.value = null;
    selectedGender3.value = null;
    count2Controller.clear();
  }

  @override
  void onClose() {
    resetForm();
    super.onClose();
  }

  void resetForm() {
    selectedAnimal.value = null;
    selectedKoc.value = null;
    selectedLamb.value = null;
    selected1Lamb.value = null;
    selected2Lamb.value = null;
    selectedGender1.value = null;
    selectedGender2.value = null;
    selectedGender3.value = null;
    isTwin.value = false;
    isTriplet.value = false;
    dobController.clear();
    timeController.clear();
    countController.clear();
    count1Controller.clear();
    count2Controller.clear();
    tagNoController.clear();
    govTagNoController.clear();
    nameController.clear();
  }

  Future<void> saveLambData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> lambData = {
        'weight': countController.text,
        'mother': selectedAnimal.value,
        'father': selectedKoc.value,
        'dob': dobController.text,
        'time': timeController.text,
        'tagNo': tagNoController.text,
        'govTagNo': govTagNoController.text,
        'species': selectedLamb.value,
        'name': nameController.text,
        'gender': selectedGender1.value,
        'type': countController.text,
      };

      await DatabaseKuzuHelper.instance.insertLamb(lambData);
      Get.snackbar('Başarılı', 'Kayıt başarılı');
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/bottomNavigation');
      });
    }
  }
}
