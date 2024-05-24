import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KocKatimController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var selectedAnimal = Rxn<String>();
  var selectedKoc = Rxn<String>();
  var animals = <String>[].obs;
  var koc = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Example data; replace with actual data retrieval
    animals.assignAll(['Koyun 1', 'Koyun 2', 'Koyun 3']);
    koc.assignAll(['Koç 1', 'Koç 2', 'Koç 3']);
  }

  void resetForm() {
    selectedAnimal.value = null;
    selectedKoc.value = null;
  }
}
