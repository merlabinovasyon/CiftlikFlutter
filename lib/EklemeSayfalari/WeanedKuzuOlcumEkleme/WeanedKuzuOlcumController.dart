import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeanedKuzuOlcumController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var selectedType = Rxn<String>();
  var types = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Seçenekleri buraya ekliyoruz
    types.assignAll([
      'Kuzu 1',
      'Kuzu 2',
      'Kuzu 3',
    ]);
  }

  void resetForm() {
    selectedType.value = null;
  }
}
