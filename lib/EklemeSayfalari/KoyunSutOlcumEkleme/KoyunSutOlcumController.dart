import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KoyunSutOlcumController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var selectedType = Rxn<String>();
  var types = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Seçenekleri buraya ekliyoruz
    types.assignAll([
      'Koyun 1',
      'Koyun 2',
      'Koyun 3',
    ]);
  }

  void resetForm() {
    selectedType.value = null;
  }
}
