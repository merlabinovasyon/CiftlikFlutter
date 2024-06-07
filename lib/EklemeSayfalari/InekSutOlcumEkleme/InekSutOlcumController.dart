import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InekSutOlcumController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var selectedType = Rxn<String>();
  var types = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Seçenekleri buraya ekliyoruz
    types.assignAll([
      'İnek 1',
      'İnek 2',
      'İnek 3',
    ]);
  }

  void resetForm() {
    selectedType.value = null;
  }
}
