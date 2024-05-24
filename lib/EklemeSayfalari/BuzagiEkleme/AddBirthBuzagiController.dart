import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBirthBuzagiController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final dobController = TextEditingController();
  final timeController = TextEditingController();
  final countController = TextEditingController();
  final count1Controller = TextEditingController();
  final count2Controller = TextEditingController();

  var selectedAnimal = Rxn<String>();
  var selectedKoc = Rxn<String>();
  var selectedBuzagi = Rxn<String>();
  var selected1Buzagi = Rxn<String>();
  var selected2Buzagi = Rxn<String>();
  var selectedGender1 = Rxn<String>();
  var selectedGender2 = Rxn<String>();
  var selectedGender3 = Rxn<String>();
  var isTwin = false.obs;
  var isTriplet = false.obs;

  final animals = ['Hayvan 1', 'Hayvan 2', 'Hayvan 3'];
  final boga = ['Boğa 1', 'Boğa 2', 'Boğa 3'];
  final buzagi = ['Merinos', 'Türk Koyunu', 'Çine Çoban Koyunu'];
  final buzagi1 = ['Merinos', 'Türk Koyunu', 'Çine Çoban Koyunu'];
  final genders = ['Erkek', 'Dişi'];

  @override
  void onClose() {
    resetForm();
    dobController.dispose();
    timeController.dispose();
    countController.dispose();
    count1Controller.dispose();
    count2Controller.dispose();
    super.onClose();
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

  void resetForm() {
    selectedAnimal.value = null;
    selectedKoc.value = null;
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
  }
}
