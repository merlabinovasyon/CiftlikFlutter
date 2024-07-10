import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'DatabaseBuzagiHelper.dart';

class AddBirthBuzagiController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final dobController = TextEditingController();
  final timeController = TextEditingController();
  final countController = TextEditingController();
  final count1Controller = TextEditingController();
  final count2Controller = TextEditingController();
  final tagNoController = TextEditingController();
  final govTagNoController = TextEditingController();
  final nameController = TextEditingController();

  var selectedCow = Rxn<String>();
  var selectedBoga = Rxn<String>();
  var selectedBuzagi = Rxn<String>();
  var selected1Buzagi = Rxn<String>();
  var selected2Buzagi = Rxn<String>();
  var selectedGender1 = Rxn<String>();
  var selectedGender2 = Rxn<String>();
  var selectedGender3 = Rxn<String>();
  var isTwin = false.obs;
  var isTriplet = false.obs;

  final List<String> cows = ['Hayvan 1', 'Hayvan 2', 'Hayvan 3'];
  final List<String> boga = ['Boğa 1', 'Boğa 2', 'Boğa 3'];
  final List<String> buzagi = ['Merinos', 'Türk Koyunu', 'Çine Çoban Koyunu'];
  final List<String> buzagi1 = ['Merinos', 'Türk Koyunu', 'Çine Çoban Koyunu'];
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
    selected1Buzagi.value = null;
    selectedGender2.value = null;
    count1Controller.clear();
    resetTripletValues();
  }

  void resetTripletValues() {
    selected2Buzagi.value = null;
    selectedGender3.value = null;
    count2Controller.clear();
  }

  @override
  void onClose() {
    resetForm();
    super.onClose();
  }

  void resetForm() {
    selectedCow.value = null;
    selectedBoga.value = null;
    selectedBuzagi.value = null;
    selected1Buzagi.value = null;
    selected2Buzagi.value = null;
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

  Future<void> saveBuzagiData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> buzagiData = {
        'weight': countController.text,
        'mother': selectedCow.value,
        'father': selectedBoga.value,
        'dob': dobController.text,
        'time': timeController.text,
        'tagNo': tagNoController.text,
        'govTagNo': govTagNoController.text,
        'species': selectedBuzagi.value,
        'name': nameController.text,
        'gender': selectedGender1.value,
        'type': countController.text,
      };

      await DatabaseBuzagiHelper.instance.insertBuzagi(buzagiData);
      Get.snackbar('Başarılı', 'Kayıt başarılı');
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/bottomNavigation');
      });
    }
  }
}
