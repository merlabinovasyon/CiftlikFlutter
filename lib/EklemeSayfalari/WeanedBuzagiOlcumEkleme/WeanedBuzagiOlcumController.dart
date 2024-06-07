import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeanedBuzagiOlcumController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var selectedType = Rxn<String>();
  var types = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Seçenekleri buraya ekliyoruz
    types.assignAll([
      'Buzağı 1',
      'Buzağı 2',
      'Buzağı 3',
    ]);
  }

  void resetForm() {
    selectedType.value = null;
  }
}
